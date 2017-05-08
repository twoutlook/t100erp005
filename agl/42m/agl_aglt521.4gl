#該程式未解開Section, 採用最新樣板產出!
{<section id="aglt521.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2015-12-04 16:30:04), PR版次:0005(2016-12-23 16:12:51)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000039
#+ Filename...: aglt521
#+ Description: 合併報表關係人交易維護作業
#+ Creator....: 04152(2015-11-18 09:45:17)
#+ Modifier...: 04152 -SD/PR- 08171
 
{</section>}
 
{<section id="aglt521.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#151113-00002#8 2015/12/22 By Jessy    傳票編號增加串查功能
#150916-00015#1 2015/12/23 By taozf    当有账套时，科目检查改为检查是否存在于glad_t中，會課的模糊查询
#160321-00016#31 2016/03/25  By Jessy   修正azzi920重複定義之錯誤訊息
#160727-00019#31   16/08/08 By 08734 临时表长度超过15码的减少到15码以下 s_merge_gl_group ——> s_merge_group
#160818-00017#15  2016/08/24 By 07900    删除修改未重新判断状态码
#160824-00007#263 2016/12/23 By 08171   新舊值調整
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
PRIVATE type type_g_gldu_m        RECORD
       glduld LIKE gldu_t.glduld, 
   glduld_desc LIKE type_t.chr80, 
   gldu001 LIKE gldu_t.gldu001, 
   gldu001_desc LIKE type_t.chr80, 
   gldu002 LIKE gldu_t.gldu002, 
   gldu002_desc LIKE type_t.chr80, 
   gldu003 LIKE gldu_t.gldu003, 
   gldu004 LIKE gldu_t.gldu004, 
   gldu008 LIKE gldu_t.gldu008, 
   gldu005 LIKE gldu_t.gldu005, 
   gldu006 LIKE gldu_t.gldu006, 
   gldu007 LIKE gldu_t.gldu007, 
   gldustus LIKE gldu_t.gldustus
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_gldu_d        RECORD
       gldu009 LIKE gldu_t.gldu009, 
   gldu010 LIKE gldu_t.gldu010, 
   gldu011 LIKE gldu_t.gldu011, 
   gldu011_desc LIKE type_t.chr500, 
   gldu012 LIKE gldu_t.gldu012, 
   gldu013 LIKE gldu_t.gldu013, 
   gldu013_desc LIKE type_t.chr500, 
   gldu014 LIKE gldu_t.gldu014, 
   gldu015 LIKE gldu_t.gldu015, 
   gldu015_desc LIKE type_t.chr500, 
   gldu016 LIKE gldu_t.gldu016, 
   gldu016_desc LIKE type_t.chr500, 
   gldu017 LIKE gldu_t.gldu017, 
   gldu017_desc LIKE type_t.chr500, 
   gldu018 LIKE gldu_t.gldu018, 
   gldu021 LIKE gldu_t.gldu021, 
   gldu024 LIKE gldu_t.gldu024, 
   gldu027 LIKE gldu_t.gldu027
       END RECORD
PRIVATE TYPE type_g_gldu2_d RECORD
       gldu009 LIKE gldu_t.gldu009, 
   glduownid LIKE gldu_t.glduownid, 
   glduownid_desc LIKE type_t.chr500, 
   glduowndp LIKE gldu_t.glduowndp, 
   glduowndp_desc LIKE type_t.chr500, 
   glducrtid LIKE gldu_t.glducrtid, 
   glducrtid_desc LIKE type_t.chr500, 
   glducrtdp LIKE gldu_t.glducrtdp, 
   glducrtdp_desc LIKE type_t.chr500, 
   glducrtdt DATETIME YEAR TO SECOND, 
   gldumodid LIKE gldu_t.gldumodid, 
   gldumodid_desc LIKE type_t.chr500, 
   gldumoddt DATETIME YEAR TO SECOND, 
   glducnfid LIKE gldu_t.glducnfid, 
   glducnfid_desc LIKE type_t.chr500, 
   glducnfdt DATETIME YEAR TO SECOND
       END RECORD
PRIVATE TYPE type_g_gldu3_d RECORD
       gldu009 LIKE gldu_t.gldu009, 
   gldu0102 LIKE type_t.chr1, 
   gldu0112 LIKE type_t.chr10, 
   gldu0112_desc LIKE type_t.chr500, 
   gldu0122 LIKE type_t.chr5, 
   gldu0132 LIKE type_t.chr10, 
   gldu0132_desc LIKE type_t.chr500, 
   gldu0142 LIKE type_t.chr5, 
   gldu0152 LIKE type_t.chr500, 
   gldu0152_desc LIKE type_t.chr500, 
   gldu0162 LIKE type_t.chr500, 
   gldu0162_desc LIKE type_t.chr500, 
   gldu0172 LIKE type_t.chr500, 
   gldu0172_desc LIKE type_t.chr500, 
   gldu019 LIKE gldu_t.gldu019, 
   gldu022 LIKE gldu_t.gldu022, 
   gldu025 LIKE gldu_t.gldu025, 
   gldu028 LIKE gldu_t.gldu028
       END RECORD
PRIVATE TYPE type_g_gldu4_d RECORD
       gldu009 LIKE gldu_t.gldu009, 
   gldu0103 LIKE type_t.chr1, 
   gldu0113 LIKE type_t.chr10, 
   gldu0113_desc LIKE type_t.chr500, 
   gldu0123 LIKE type_t.chr5, 
   gldu0133 LIKE type_t.chr10, 
   gldu0133_desc LIKE type_t.chr500, 
   gldu0143 LIKE type_t.chr5, 
   gldu0153 LIKE type_t.chr500, 
   gldu0153_desc LIKE type_t.chr500, 
   gldu0163 LIKE type_t.chr500, 
   gldu0163_desc LIKE type_t.chr500, 
   gldu0173 LIKE type_t.chr500, 
   gldu0173_desc LIKE type_t.chr500, 
   gldu020 LIKE gldu_t.gldu020, 
   gldu023 LIKE gldu_t.gldu023, 
   gldu026 LIKE gldu_t.gldu026, 
   gldu029 LIKE gldu_t.gldu029
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_glaa         RECORD
                         glaa004   LIKE glaa_t.glaa004,
                         glaa131   LIKE glaa_t.glaa131
                      END RECORD
#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_gldu_m          type_g_gldu_m
DEFINE g_gldu_m_t        type_g_gldu_m
DEFINE g_gldu_m_o        type_g_gldu_m
DEFINE g_gldu_m_mask_o   type_g_gldu_m #轉換遮罩前資料
DEFINE g_gldu_m_mask_n   type_g_gldu_m #轉換遮罩後資料
 
   DEFINE g_glduld_t LIKE gldu_t.glduld
DEFINE g_gldu001_t LIKE gldu_t.gldu001
DEFINE g_gldu002_t LIKE gldu_t.gldu002
DEFINE g_gldu003_t LIKE gldu_t.gldu003
DEFINE g_gldu004_t LIKE gldu_t.gldu004
 
 
DEFINE g_gldu_d          DYNAMIC ARRAY OF type_g_gldu_d
DEFINE g_gldu_d_t        type_g_gldu_d
DEFINE g_gldu_d_o        type_g_gldu_d
DEFINE g_gldu_d_mask_o   DYNAMIC ARRAY OF type_g_gldu_d #轉換遮罩前資料
DEFINE g_gldu_d_mask_n   DYNAMIC ARRAY OF type_g_gldu_d #轉換遮罩後資料
DEFINE g_gldu2_d   DYNAMIC ARRAY OF type_g_gldu2_d
DEFINE g_gldu2_d_t type_g_gldu2_d
DEFINE g_gldu2_d_o type_g_gldu2_d
DEFINE g_gldu2_d_mask_o   DYNAMIC ARRAY OF type_g_gldu2_d #轉換遮罩前資料
DEFINE g_gldu2_d_mask_n   DYNAMIC ARRAY OF type_g_gldu2_d #轉換遮罩後資料
DEFINE g_gldu3_d   DYNAMIC ARRAY OF type_g_gldu3_d
DEFINE g_gldu3_d_t type_g_gldu3_d
DEFINE g_gldu3_d_o type_g_gldu3_d
DEFINE g_gldu3_d_mask_o   DYNAMIC ARRAY OF type_g_gldu3_d #轉換遮罩前資料
DEFINE g_gldu3_d_mask_n   DYNAMIC ARRAY OF type_g_gldu3_d #轉換遮罩後資料
DEFINE g_gldu4_d   DYNAMIC ARRAY OF type_g_gldu4_d
DEFINE g_gldu4_d_t type_g_gldu4_d
DEFINE g_gldu4_d_o type_g_gldu4_d
DEFINE g_gldu4_d_mask_o   DYNAMIC ARRAY OF type_g_gldu4_d #轉換遮罩前資料
DEFINE g_gldu4_d_mask_n   DYNAMIC ARRAY OF type_g_gldu4_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_glduld LIKE gldu_t.glduld,
      b_gldu001 LIKE gldu_t.gldu001,
      b_gldu002 LIKE gldu_t.gldu002,
      b_gldu003 LIKE gldu_t.gldu003,
      b_gldu004 LIKE gldu_t.gldu004
       #,rank           LIKE type_t.num10
      END RECORD 
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING 
 
 
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
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog
 
DEFINE g_pagestart           LIKE type_t.num10           
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁
DEFINE g_bfill               LIKE type_t.chr5              #是否刷新單身
 
DEFINE g_detail_cnt          LIKE type_t.num10             #單身總筆數
DEFINE g_detail_idx          LIKE type_t.num10             #單身目前所在筆數
DEFINE g_detail_idx2         LIKE type_t.num10             #單身2目前所在筆數
DEFINE g_browser_cnt         LIKE type_t.num10             #Browser總筆數
DEFINE g_browser_idx         LIKE type_t.num10             #Browser目前所在筆數
DEFINE g_temp_idx            LIKE type_t.num10             #Browser目前所在筆數(暫存用)
DEFINE g_current_page        LIKE type_t.num10             #目前所在頁數
DEFINE g_order               STRING                        #查詢排序欄位
DEFINE g_state               STRING                        
DEFINE g_insert              LIKE type_t.chr5              #是否導到其他page                    
DEFINE g_current_row         LIKE type_t.num10             #Browser所在筆數
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_error_show          LIKE type_t.num5
DEFINE gs_keys               DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak           DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_aw                  STRING                        #確定當下點擊的單身
DEFINE g_default             BOOLEAN                       #是否有外部參數查詢
DEFINE g_log1                STRING                        #log用
DEFINE g_log2                STRING                        #log用
DEFINE g_add_browse          STRING                        #新增填充用WC
DEFINE g_loc                 LIKE type_t.chr5              #判斷游標所在位置
DEFINE g_master_insert       BOOLEAN                       #確認單頭資料是否寫入(僅用於三階)
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aglt521.main" >}
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
   LET g_forupd_sql = " SELECT glduld,'',gldu001,'',gldu002,'',gldu003,gldu004,gldu008,gldu005,gldu006, 
       gldu007,gldustus", 
                      " FROM gldu_t",
                      " WHERE glduent= ? AND glduld=? AND gldu001=? AND gldu002=? AND gldu003=? AND  
                          gldu004=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aglt521_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.glduld,t0.gldu001,t0.gldu002,t0.gldu003,t0.gldu004,t0.gldu008,t0.gldu005, 
       t0.gldu006,t0.gldu007,t0.gldustus",
               " FROM gldu_t t0",
               
               " WHERE t0.glduent = " ||g_enterprise|| " AND t0.glduld = ? AND t0.gldu001 = ? AND t0.gldu002 = ? AND t0.gldu003 = ? AND t0.gldu004 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aglt521_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aglt521 WITH FORM cl_ap_formpath("agl",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aglt521_init()   
 
      #進入選單 Menu (="N")
      CALL aglt521_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aglt521
      
   END IF 
   
   CLOSE aglt521_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aglt521.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aglt521_init()
   #add-point:init段define name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill = "Y"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
      CALL cl_set_combo_scc_part('gldustus','50','N,X,Y')
 
   
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc_part('gldustus','13','N,Y')
   CALL cl_set_combo_scc('gldu010','8200')   #交易類型
   CALL cl_set_combo_scc('gldu0102','8200')  #交易類型
   CALL cl_set_combo_scc('gldu0103','8200')  #交易類型
   
   CALL s_fin_continue_no_tmp()
   CALL s_merge_cre_gl_tmp_table() RETURNING g_sub_success
   #end add-point
   
   CALL aglt521_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aglt521.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION aglt521_ui_dialog()
   #add-point:ui_dialog段define name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE la_param  RECORD
          prog                  STRING,
          actionid              STRING,
          background            LIKE type_t.chr1,
          param                 DYNAMIC ARRAY OF STRING
                                END RECORD
   DEFINE ls_js                 STRING
   DEFINE li_idx                LIKE type_t.num10
   DEFINE ls_wc                 STRING
   DEFINE lb_first              BOOLEAN
   DEFINE l_cmd_token           base.StringTokenizer   #報表作業cmdrun使用 
   DEFINE l_cmd_next            STRING                 #報表作業cmdrun使用
   DEFINE l_cmd_cnt             LIKE type_t.num5       #報表作業cmdrun使用
   DEFINE l_cmd_prog_arg        STRING                 #報表作業cmdrun使用
   DEFINE l_cmd_arg             STRING                 #報表作業cmdrun使用
   #add-point:ui_dialog段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   DEFINE l_slip       LIKE gldp_t.gldpdocno
   DEFINE l_date       LIKE gldp_t.gldpdocdt
   #end add-point  
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   LET lb_first = TRUE
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
   IF g_default THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0 
   ELSE
      CALL gfrm_curr.setElementHidden("mainlayout",1)
      CALL gfrm_curr.setElementHidden("worksheet",0)
      LET g_main_hidden = 1
   END IF
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
   
   WHILE TRUE
      
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_gldu_m.* TO NULL
         CALL g_gldu_d.clear()
         CALL g_gldu2_d.clear()
         CALL g_gldu3_d.clear()
         CALL g_gldu4_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aglt521_init()
      END IF
 
      CALL lib_cl_dlg.cl_dlg_before_display()
      CALL cl_notice()
 
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
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL aglt521_idx_chk()
               CALL aglt521_fetch('') # reload data
               LET g_detail_idx = 1
               CALL aglt521_ui_detailshow() #Setting the current row 
         
            ON ACTION qbefield_user   #欄位隱藏設定 
               LET g_action_choice="qbefield_user"
               CALL cl_ui_qbefield_user()
         
         END DISPLAY
        
         DISPLAY ARRAY g_gldu_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL aglt521_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL aglt521_ui_detailshow()
               
               #add-point:page1自定義行為 name="ui_dialog.body.before_row"
               
               #end add-point
            
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
    
               #控制stus哪個按鈕可以按
                              #此段落i02,i07樣板使用, 但目前不支援批次修改狀態, 先註解
			   ##此段落由子樣板a22產生
               ##目前選取的stus為N
               #IF . = "N" THEN
               #                     CALL cl_set_act_visible('open',FALSE)
                  CALL cl_set_act_visible('void',TRUE)
                  CALL cl_set_act_visible('valid',TRUE)
 
               #END IF
               ##stus - Start - 
               ##目前選取的stus為}
               #IF . = "}" THEN
               #   }
               #END IF        
               ##stus -  End  -               
    
 
 
               
            
 
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         DISPLAY ARRAY g_gldu2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL aglt521_idx_chk()
               CALL aglt521_ui_detailshow()
               
               #add-point:page1自定義行為 name="ui_dialog.body2.before_row"
               
               #end add-point
            
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'     
               LET g_current_page = 2
            
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
         DISPLAY ARRAY g_gldu3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL aglt521_idx_chk()
               CALL aglt521_ui_detailshow()
               
               #add-point:page1自定義行為 name="ui_dialog.body3.before_row"
               
               #end add-point
            
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'     
               LET g_current_page = 3
            
            
         
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
         
         END DISPLAY
         DISPLAY ARRAY g_gldu4_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL aglt521_idx_chk()
               CALL aglt521_ui_detailshow()
               
               #add-point:page1自定義行為 name="ui_dialog.body4.before_row"
               
               #end add-point
            
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'     
               LET g_current_page = 4
            
            
         
            #add-point:page4自定義行為 name="ui_dialog.body4.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps 
         
         BEFORE DIALOG
            #先填充browser資料
            CALL aglt521_browser_fill("")
            CALL cl_notice()
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL g_curr_diag.setSelectionMode("s_detail1",1)         
            LET g_page = "first"
            LET g_current_sw = FALSE
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
            
            IF g_current_idx = 0 AND g_browser.getLength() > 0 THEN
               LET g_current_idx = 1 
            END IF
            
            #有資料才進行fetch
            IF g_current_idx <> 0 THEN
               CALL aglt521_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aglt521_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #應用 a49 樣板自動產生(Version:4)
            #過濾瀏覽頁資料
            ON ACTION filter
               LET g_action_choice = "fetch"
               #add-point:filter action name="ui_dialog.action.filter"
               
               #end add-point
               CALL aglt521_filter()
               EXIT DIALOG
 
 
 
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL aglt521_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aglt521_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL aglt521_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aglt521_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL aglt521_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aglt521_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL aglt521_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aglt521_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL aglt521_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aglt521_idx_chk()
            LET g_action_choice = ""
            
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
                  LET g_export_node[1] = base.typeInfo.create(g_gldu_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_gldu2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_gldu3_d)
                  LET g_export_id[3]   = "s_detail3"
                  LET g_export_node[4] = base.typeInfo.create(g_gldu4_d)
                  LET g_export_id[4]   = "s_detail4"
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  
                  #END add-point
                  CALL cl_export_to_excel_getpage()
                  CALL cl_export_to_excel()
               END IF
            END IF
          
         ON ACTION close
            LET INT_FLAG=FALSE        
            LET g_action_choice = "exit"
            EXIT DIALOG     
          
         ON ACTION exit
            LET g_action_choice = "exit"
            EXIT DIALOG
          
         ON ACTION mainhidden       #主頁摺疊
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
            
         ON ACTION worksheethidden   #瀏覽頁折疊
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
               NEXT FIELD gldu009
            END IF
       
         ON ACTION controls      #單頭摺疊，可利用hot key "Alt-s"開啟/關閉單頭
            IF g_header_hidden THEN
               CALL gfrm_curr.setElementHidden("vb_master",0)
               CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
               LET g_header_hidden = 0     #visible
            ELSE
               CALL gfrm_curr.setElementHidden("vb_master",1)
               CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
               LET g_header_hidden = 1     #hidden     
            END IF
            
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               CALL aglt521_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL aglt521_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL aglt521_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION aglt521_01
            LET g_action_choice="aglt521_01"
            IF cl_auth_chk_act("aglt521_01") THEN
               
               #add-point:ON ACTION aglt521_01 name="menu.aglt521_01"
               #計算未實現損益
               CALL aglt521_01(g_gldu_m.glduld,g_gldu_m.gldu001,g_gldu_m.gldu002,g_gldu_m.gldu003,g_gldu_m.gldu004)
                     RETURNING g_sub_success
               IF g_sub_success THEN
                  #重新顯示新的數據
                  LET g_wc = " glduent = ",g_enterprise," AND glduld = '",g_gldu_m.glduld,"' ",
                             " AND gldu001 = '",g_gldu_m.gldu001,"' AND gldu002 = '",g_gldu_m.gldu002,"'",
                             " AND gldu003 = '",g_gldu_m.gldu003,"' AND gldu004 = '",g_gldu_m.gldu004,"'"
                  CALL aglt521_browser_fill("F")
                  CALL aglt521_fetch("F")
                  CALL aglt521_idx_chk()
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL aglt521_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL aglt521_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aglt521_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aglt521_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aglt521_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
               CALL g_curr_diag.setCurrentRow("s_detail4",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION statechange
            LET g_action_choice="statechange"
            IF cl_auth_chk_act("statechange") THEN
               
               #add-point:ON ACTION statechange name="menu.statechange"
               CALL aglt521_statechange()
               #根據資料狀態切換action狀態
               CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
               CALL aglt521_set_act_visible()   
               CALL aglt521_set_act_no_visible()
               IF NOT ( g_gldu_m.glduld IS NULL
                        OR g_gldu_m.gldu001 IS NULL
                        OR g_gldu_m.gldu002 IS NULL
                        OR g_gldu_m.gldu003 IS NULL
                        OR g_gldu_m.gldu004 IS NULL
                 ) THEN
                  #組合條件
                  LET g_add_browse = " glduent = '" ||g_enterprise|| "' AND",
                                     " glduld = '", g_gldu_m.glduld, "' "
                                     ," AND gldu001 = '", g_gldu_m.gldu001, "' "
                                     ," AND gldu002 = '", g_gldu_m.gldu002, "' "
                                     ," AND gldu003 = '", g_gldu_m.gldu003, "' "
                                     ," AND gldu004 = '", g_gldu_m.gldu004, "' "
    
                  #填到對應位置
                  CALL aglt521_browser_fill("")
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aglt502_01
            LET g_action_choice="open_aglt502_01"
            IF cl_auth_chk_act("open_aglt502_01") THEN
               
               #add-point:ON ACTION open_aglt502_01 name="menu.open_aglt502_01"
               IF g_gldu_m.glduld IS NULL THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = ""
                 LET g_errparam.code   = "std-00003"
                 LET g_errparam.popup  = TRUE
                 CALL cl_err()
                 CONTINUE DIALOG
               END IF
               
               #未確認單據不可拋轉
               IF g_gldu_m.gldustus = 'N' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'anm-00185'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  EXIT DIALOG
               END IF
               
               #無傳票號碼才可拋轉
               IF cl_null(g_gldu_m.gldu008) THEN
                  
                  CALL aglt502_01(g_gldu_m.glduld,"aglt522") RETURNING l_slip,l_date
                  DISPLAY l_slip,"/",l_date
                  
                  #若取消產生時，就不往下走拋轉了
                  IF cl_null(l_slip) THEN
                     CONTINUE DIALOG
                  END IF
                  
                  CALL s_transaction_begin()

                  CALL cl_err_collect_init()
                  CALL s_merge_gen_gl(g_gldu_m.glduld,g_gldu_m.gldu001,g_gldu_m.gldu003,g_gldu_m.gldu004,l_slip,l_date,'1','','aglt521')
                       RETURNING g_sub_success,g_gldu_m.gldu008,g_gldu_m.gldu008
                  CALL cl_err_collect_show()
               
                  IF g_sub_success THEN
                     CALL s_transaction_end('Y','0')
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'adz-00217' #執行成功
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  ELSE
                     IF cl_null(g_gldu_m.gldu008) THEN 
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = ''
                        LET g_errparam.code   = 'axc-00530' #無資料產生
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                     ELSE
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = ''
                        LET g_errparam.code   = 'axr-00120' #傳票拋轉失敗
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                     END IF
                     CALL s_transaction_end('N','0')
                  END IF
                  
                  #清空temptable
                  #CALL s_merge_drop_gl_tmp_table() RETURNING g_sub_success
                  
                  DELETE FROM s_merge_gl_tmp
                  DELETE FROM s_merge_group  #160727-00019#31   16/08/08 By 08734 临时表长度超过15码的减少到15码以下 s_merge_gl_group ——> s_merge_group
                  
                  #重新顯示傳票號碼
                  SELECT gldu008 INTO g_gldu_m.gldu008
                    FROM gldu_t
                   WHERE glduent = g_enterprise
                     AND glduld  = g_gldu_m.glduld
                     AND gldu001 = g_gldu_m.gldu001
                     AND gldu002 = g_gldu_m.gldu002
                     AND gldu003 = g_gldu_m.gldu003
                     AND gldu004 = g_gldu_m.gldu004
                  DISPLAY BY NAME g_gldu_m.gldu008
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_aglt522
            LET g_action_choice="prog_aglt522"
            IF cl_auth_chk_act("prog_aglt522") THEN
               
               #add-point:ON ACTION prog_aglt522 name="menu.prog_aglt522"
               #應用 a41 樣板自動產生(Version:2)
               #151113-00002#8 --s
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'aglt522'
               LET la_param.param[1] = g_gldu_m.gldu008

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
               
               #151113-00002#8 --e
               #END add-point
               
            END IF
 
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aglt521_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aglt521_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aglt521_set_pk_array()
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
      
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF
      
   END WHILE
   
   CALL cl_set_act_visible("accept,cancel", TRUE)
   
END FUNCTION
 
{</section>}
 
{<section id="aglt521.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION aglt521_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aglt521.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION aglt521_browser_fill(ps_page_action)
   #add-point:browser_fill段define name="browser_fill.define_customerization"
   
   #end add-point   
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   DEFINE l_searchcol       STRING
   #add-point:browser_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="browser_fill.before_browser_fill"
   
   #end add-point    
 
   LET l_searchcol = "glduld,gldu001,gldu002,gldu003,gldu004"
   LET l_wc  = g_wc.trim() 
   LET l_wc2 = g_wc2.trim()
   IF cl_null(l_wc) THEN  #p_wc 查詢條件
      LET l_wc = " 1=1"
   END IF
   IF cl_null(l_wc2) THEN  #p_wc 查詢條件
      LET l_wc2 = " 1=1"
   END IF
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT glduld ",
                      ", gldu001 ",
                      ", gldu002 ",
                      ", gldu003 ",
                      ", gldu004 ",
 
                      " FROM gldu_t ",
                      " ",
                      " ", 
 
 
 
                      " WHERE glduent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("gldu_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT glduld ",
                      ", gldu001 ",
                      ", gldu002 ",
                      ", gldu003 ",
                      ", gldu004 ",
 
                      " FROM gldu_t ",
                      " ",
                      " ", 
 
 
                      " WHERE glduent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("gldu_t")
   END IF 
   
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
   
   #若超過最大顯示筆數
   IF g_browser_cnt > g_max_browse THEN
      IF g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_browser_cnt 
         LET g_errparam.code   = 9035
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
      END IF
      LET g_browser_cnt = g_max_browse
   END IF
   LET g_error_show = 0
 
   IF cl_null(g_add_browse) THEN
      #清除畫面
      CLEAR FORM                
      INITIALIZE g_gldu_m.* TO NULL
      CALL g_gldu_d.clear()        
      CALL g_gldu2_d.clear() 
      CALL g_gldu3_d.clear() 
      CALL g_gldu4_d.clear() 
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.glduld,t0.gldu001,t0.gldu002,t0.gldu003,t0.gldu004 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.glduld,t0.gldu001,t0.gldu002,t0.gldu003,t0.gldu004",
                " FROM gldu_t t0",
                #" ",
                " ",
 
 
 
                
                " WHERE t0.glduent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("gldu_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
   
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"gldu_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_glduld,g_browser[g_cnt].b_gldu001,g_browser[g_cnt].b_gldu002, 
          g_browser[g_cnt].b_gldu003,g_browser[g_cnt].b_gldu004 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         
         
         #add-point:browser_fill段reference name="browser_fill.reference"
         
         #end add-point  
      
         #遮罩相關處理
         CALL aglt521_browser_mask()
         
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
   
   IF cl_null(g_browser[g_cnt].b_glduld) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_gldu_m.* TO NULL
      CALL g_gldu_d.clear()
      CALL g_gldu2_d.clear()
      CALL g_gldu3_d.clear()
      CALL g_gldu4_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL aglt521_fetch('')
   
   #筆數顯示
   LET g_browser_idx = g_current_idx 
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
    
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
 
   #add-point:browser_fill段結束前 name="browser_fill.after"
   
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="aglt521.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION aglt521_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_gldu_m.glduld = g_browser[g_current_idx].b_glduld   
   LET g_gldu_m.gldu001 = g_browser[g_current_idx].b_gldu001   
   LET g_gldu_m.gldu002 = g_browser[g_current_idx].b_gldu002   
   LET g_gldu_m.gldu003 = g_browser[g_current_idx].b_gldu003   
   LET g_gldu_m.gldu004 = g_browser[g_current_idx].b_gldu004   
 
   EXECUTE aglt521_master_referesh USING g_gldu_m.glduld,g_gldu_m.gldu001,g_gldu_m.gldu002,g_gldu_m.gldu003, 
       g_gldu_m.gldu004 INTO g_gldu_m.glduld,g_gldu_m.gldu001,g_gldu_m.gldu002,g_gldu_m.gldu003,g_gldu_m.gldu004, 
       g_gldu_m.gldu008,g_gldu_m.gldu005,g_gldu_m.gldu006,g_gldu_m.gldu007,g_gldu_m.gldustus
   CALL aglt521_show()
   
END FUNCTION
 
{</section>}
 
{<section id="aglt521.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION aglt521_ui_detailshow()
   #add-point:ui_detailshow段define name="ui_detailshow.define_customerization"
   
   #end add-point
   #add-point:ui_detailshow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="ui_detailshow.before"
   
   #end add-point  
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail4",g_detail_idx)
 
      #add-point:ui_detailshow段more name="ui_detailshow.more"
      
      #end add-point 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="aglt521.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aglt521_ui_browser_refresh()
   #add-point:ui_browser_refresh段define name="ui_browser_refresh.define_customerization"
   
   #end add-point   
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_browser_refresh.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="ui_browser_refresh.pre_function"
   
   #end add-point
   
   LET g_browser_cnt = g_browser.getLength()
   LET g_header_cnt  = g_browser.getLength()
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_glduld = g_gldu_m.glduld 
         AND g_browser[l_i].b_gldu001 = g_gldu_m.gldu001 
         AND g_browser[l_i].b_gldu002 = g_gldu_m.gldu002 
         AND g_browser[l_i].b_gldu003 = g_gldu_m.gldu003 
         AND g_browser[l_i].b_gldu004 = g_gldu_m.gldu004 
 
         THEN  
         CALL g_browser.deleteElement(l_i)
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
 
   DISPLAY g_browser_cnt TO FORMONLY.b_count    #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數的顯示
   
END FUNCTION
 
{</section>}
 
{<section id="aglt521.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aglt521_construct()
   #add-point:cs段define name="cs.define_customerization"
   
   #end add-point    
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   #add-point:cs段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
   
   #清除畫面上相關資料
   CLEAR FORM                 
   INITIALIZE g_gldu_m.* TO NULL
   CALL g_gldu_d.clear()
   CALL g_gldu2_d.clear()
   CALL g_gldu3_d.clear()
   CALL g_gldu4_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON glduld,gldu001,gldu002,gldu003,gldu004,gldu008,gldu005,gldu006,gldu007, 
          gldustus
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
 
            #end add-point 
            
                 #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glduld
            #add-point:BEFORE FIELD glduld name="construct.b.glduld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glduld
            
            #add-point:AFTER FIELD glduld name="construct.a.glduld"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glduld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glduld
            #add-point:ON ACTION controlp INFIELD glduld name="construct.c.glduld"
            #合併帳別開窗
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            CALL q_authorised_ld()
            DISPLAY g_qryparam.return1 TO glduld
            NEXT FIELD glduld
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldu001
            #add-point:BEFORE FIELD gldu001 name="construct.b.gldu001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldu001
            
            #add-point:AFTER FIELD gldu001 name="construct.a.gldu001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gldu001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldu001
            #add-point:ON ACTION controlp INFIELD gldu001 name="construct.c.gldu001"
            #上層公司開窗
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_gldc001()
            DISPLAY g_qryparam.return1 TO gldu001
            NEXT FIELD gldu001
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldu002
            #add-point:BEFORE FIELD gldu002 name="construct.b.gldu002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldu002
            
            #add-point:AFTER FIELD gldu002 name="construct.a.gldu002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gldu002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldu002
            #add-point:ON ACTION controlp INFIELD gldu002 name="construct.c.gldu002"
            #上層公司帳別
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            CALL q_authorised_ld()
            DISPLAY g_qryparam.return1 TO gldu002
            NEXT FIELD gldu002
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldu003
            #add-point:BEFORE FIELD gldu003 name="construct.b.gldu003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldu003
            
            #add-point:AFTER FIELD gldu003 name="construct.a.gldu003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gldu003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldu003
            #add-point:ON ACTION controlp INFIELD gldu003 name="construct.c.gldu003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldu004
            #add-point:BEFORE FIELD gldu004 name="construct.b.gldu004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldu004
            
            #add-point:AFTER FIELD gldu004 name="construct.a.gldu004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gldu004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldu004
            #add-point:ON ACTION controlp INFIELD gldu004 name="construct.c.gldu004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldu008
            #add-point:BEFORE FIELD gldu008 name="construct.b.gldu008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldu008
            
            #add-point:AFTER FIELD gldu008 name="construct.a.gldu008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gldu008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldu008
            #add-point:ON ACTION controlp INFIELD gldu008 name="construct.c.gldu008"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_gldu008()
            DISPLAY g_qryparam.return1 TO gldu008
            NEXT FIELD gldu008
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldu005
            #add-point:BEFORE FIELD gldu005 name="construct.b.gldu005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldu005
            
            #add-point:AFTER FIELD gldu005 name="construct.a.gldu005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gldu005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldu005
            #add-point:ON ACTION controlp INFIELD gldu005 name="construct.c.gldu005"
            #記帳幣
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()
            DISPLAY g_qryparam.return1 TO gldu005
            NEXT FIELD gldu005
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldu006
            #add-point:BEFORE FIELD gldu006 name="construct.b.gldu006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldu006
            
            #add-point:AFTER FIELD gldu006 name="construct.a.gldu006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gldu006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldu006
            #add-point:ON ACTION controlp INFIELD gldu006 name="construct.c.gldu006"
            #功能幣
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()
            DISPLAY g_qryparam.return1 TO gldu006
            NEXT FIELD gldu006
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldu007
            #add-point:BEFORE FIELD gldu007 name="construct.b.gldu007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldu007
            
            #add-point:AFTER FIELD gldu007 name="construct.a.gldu007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gldu007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldu007
            #add-point:ON ACTION controlp INFIELD gldu007 name="construct.c.gldu007"
            #報告幣
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()
            DISPLAY g_qryparam.return1 TO gldu007
            NEXT FIELD gldu007
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldustus
            #add-point:BEFORE FIELD gldustus name="construct.b.gldustus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldustus
            
            #add-point:AFTER FIELD gldustus name="construct.a.gldustus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gldustus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldustus
            #add-point:ON ACTION controlp INFIELD gldustus name="construct.c.gldustus"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON gldu010,gldu011,gldu012,gldu013,gldu014,gldu015,gldu016,gldu017,gldu018, 
          gldu021,gldu024,gldu027,glduownid,glduowndp,glducrtid,glducrtdp,glducrtdt,gldumodid,gldumoddt, 
          glducnfid,glducnfdt,gldu019,gldu022,gldu025,gldu028,gldu020,gldu023,gldu026,gldu029
           FROM s_detail1[1].gldu010,s_detail1[1].gldu011,s_detail1[1].gldu012,s_detail1[1].gldu013, 
               s_detail1[1].gldu014,s_detail1[1].gldu015,s_detail1[1].gldu016,s_detail1[1].gldu017,s_detail1[1].gldu018, 
               s_detail1[1].gldu021,s_detail1[1].gldu024,s_detail1[1].gldu027,s_detail2[1].glduownid, 
               s_detail2[1].glduowndp,s_detail2[1].glducrtid,s_detail2[1].glducrtdp,s_detail2[1].glducrtdt, 
               s_detail2[1].gldumodid,s_detail2[1].gldumoddt,s_detail2[1].glducnfid,s_detail2[1].glducnfdt, 
               s_detail3[1].gldu019,s_detail3[1].gldu022,s_detail3[1].gldu025,s_detail3[1].gldu028,s_detail4[1].gldu020, 
               s_detail4[1].gldu023,s_detail4[1].gldu026,s_detail4[1].gldu029
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<glducrtdt>>----
         AFTER FIELD glducrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<gldumoddt>>----
         AFTER FIELD gldumoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<glducnfdt>>----
         AFTER FIELD glducnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<gldupstdt>>----
 
 
 
           
         #單身一般欄位開窗相關處理
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldu010
            #add-point:BEFORE FIELD gldu010 name="construct.b.page1.gldu010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldu010
            
            #add-point:AFTER FIELD gldu010 name="construct.a.page1.gldu010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldu010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldu010
            #add-point:ON ACTION controlp INFIELD gldu010 name="construct.c.page1.gldu010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldu011
            #add-point:BEFORE FIELD gldu011 name="construct.b.page1.gldu011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldu011
            
            #add-point:AFTER FIELD gldu011 name="construct.a.page1.gldu011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldu011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldu011
            #add-point:ON ACTION controlp INFIELD gldu011 name="construct.c.page1.gldu011"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_gldc002_1()
            DISPLAY g_qryparam.return1 TO gldu011
            NEXT FIELD gldu011
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldu012
            #add-point:BEFORE FIELD gldu012 name="construct.b.page1.gldu012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldu012
            
            #add-point:AFTER FIELD gldu012 name="construct.a.page1.gldu012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldu012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldu012
            #add-point:ON ACTION controlp INFIELD gldu012 name="construct.c.page1.gldu012"
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_grup
            CALL q_authorised_ld()
            DISPLAY g_qryparam.return1 TO gldu012
            NEXT FIELD gldu012
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldu013
            #add-point:BEFORE FIELD gldu013 name="construct.b.page1.gldu013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldu013
            
            #add-point:AFTER FIELD gldu013 name="construct.a.page1.gldu013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldu013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldu013
            #add-point:ON ACTION controlp INFIELD gldu013 name="construct.c.page1.gldu013"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_gldc002_1()
            DISPLAY g_qryparam.return1 TO gldu013
            NEXT FIELD gldu013
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldu014
            #add-point:BEFORE FIELD gldu014 name="construct.b.page1.gldu014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldu014
            
            #add-point:AFTER FIELD gldu014 name="construct.a.page1.gldu014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldu014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldu014
            #add-point:ON ACTION controlp INFIELD gldu014 name="construct.c.page1.gldu014"
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_grup
            CALL q_authorised_ld()
            DISPLAY g_qryparam.return1 TO gldu014
            NEXT FIELD gldu014
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldu015
            #add-point:BEFORE FIELD gldu015 name="construct.b.page1.gldu015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldu015
            
            #add-point:AFTER FIELD gldu015 name="construct.a.page1.gldu015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldu015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldu015
            #add-point:ON ACTION controlp INFIELD gldu015 name="construct.c.page1.gldu015"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " glac003 <>'1' AND glac006 = '1'"
            CALL aglt310_04()
            DISPLAY g_qryparam.return1 TO gldu015
            NEXT FIELD gldu015
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldu016
            #add-point:BEFORE FIELD gldu016 name="construct.b.page1.gldu016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldu016
            
            #add-point:AFTER FIELD gldu016 name="construct.a.page1.gldu016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldu016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldu016
            #add-point:ON ACTION controlp INFIELD gldu016 name="construct.c.page1.gldu016"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " glac003 <>'1' AND glac006 = '1'"
            CALL aglt310_04()
            DISPLAY g_qryparam.return1 TO gldu016
            NEXT FIELD gldu016
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldu017
            #add-point:BEFORE FIELD gldu017 name="construct.b.page1.gldu017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldu017
            
            #add-point:AFTER FIELD gldu017 name="construct.a.page1.gldu017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldu017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldu017
            #add-point:ON ACTION controlp INFIELD gldu017 name="construct.c.page1.gldu017"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " glac003 <>'1' AND glac006 = '1'"
            CALL aglt310_04()
            DISPLAY g_qryparam.return1 TO gldu017
            NEXT FIELD gldu017
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldu018
            #add-point:BEFORE FIELD gldu018 name="construct.b.page1.gldu018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldu018
            
            #add-point:AFTER FIELD gldu018 name="construct.a.page1.gldu018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldu018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldu018
            #add-point:ON ACTION controlp INFIELD gldu018 name="construct.c.page1.gldu018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldu021
            #add-point:BEFORE FIELD gldu021 name="construct.b.page1.gldu021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldu021
            
            #add-point:AFTER FIELD gldu021 name="construct.a.page1.gldu021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldu021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldu021
            #add-point:ON ACTION controlp INFIELD gldu021 name="construct.c.page1.gldu021"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldu024
            #add-point:BEFORE FIELD gldu024 name="construct.b.page1.gldu024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldu024
            
            #add-point:AFTER FIELD gldu024 name="construct.a.page1.gldu024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldu024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldu024
            #add-point:ON ACTION controlp INFIELD gldu024 name="construct.c.page1.gldu024"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldu027
            #add-point:BEFORE FIELD gldu027 name="construct.b.page1.gldu027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldu027
            
            #add-point:AFTER FIELD gldu027 name="construct.a.page1.gldu027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldu027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldu027
            #add-point:ON ACTION controlp INFIELD gldu027 name="construct.c.page1.gldu027"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.glduownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glduownid
            #add-point:ON ACTION controlp INFIELD glduownid name="construct.c.page2.glduownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glduownid  #顯示到畫面上
            NEXT FIELD glduownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glduownid
            #add-point:BEFORE FIELD glduownid name="construct.b.page2.glduownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glduownid
            
            #add-point:AFTER FIELD glduownid name="construct.a.page2.glduownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.glduowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glduowndp
            #add-point:ON ACTION controlp INFIELD glduowndp name="construct.c.page2.glduowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glduowndp  #顯示到畫面上
            NEXT FIELD glduowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glduowndp
            #add-point:BEFORE FIELD glduowndp name="construct.b.page2.glduowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glduowndp
            
            #add-point:AFTER FIELD glduowndp name="construct.a.page2.glduowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.glducrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glducrtid
            #add-point:ON ACTION controlp INFIELD glducrtid name="construct.c.page2.glducrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glducrtid  #顯示到畫面上
            NEXT FIELD glducrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glducrtid
            #add-point:BEFORE FIELD glducrtid name="construct.b.page2.glducrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glducrtid
            
            #add-point:AFTER FIELD glducrtid name="construct.a.page2.glducrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.glducrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glducrtdp
            #add-point:ON ACTION controlp INFIELD glducrtdp name="construct.c.page2.glducrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glducrtdp  #顯示到畫面上
            NEXT FIELD glducrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glducrtdp
            #add-point:BEFORE FIELD glducrtdp name="construct.b.page2.glducrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glducrtdp
            
            #add-point:AFTER FIELD glducrtdp name="construct.a.page2.glducrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glducrtdt
            #add-point:BEFORE FIELD glducrtdt name="construct.b.page2.glducrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.gldumodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldumodid
            #add-point:ON ACTION controlp INFIELD gldumodid name="construct.c.page2.gldumodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gldumodid  #顯示到畫面上
            NEXT FIELD gldumodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldumodid
            #add-point:BEFORE FIELD gldumodid name="construct.b.page2.gldumodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldumodid
            
            #add-point:AFTER FIELD gldumodid name="construct.a.page2.gldumodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldumoddt
            #add-point:BEFORE FIELD gldumoddt name="construct.b.page2.gldumoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.glducnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glducnfid
            #add-point:ON ACTION controlp INFIELD glducnfid name="construct.c.page2.glducnfid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glducnfid  #顯示到畫面上
            NEXT FIELD glducnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glducnfid
            #add-point:BEFORE FIELD glducnfid name="construct.b.page2.glducnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glducnfid
            
            #add-point:AFTER FIELD glducnfid name="construct.a.page2.glducnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glducnfdt
            #add-point:BEFORE FIELD glducnfdt name="construct.b.page2.glducnfdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldu019
            #add-point:BEFORE FIELD gldu019 name="construct.b.page3.gldu019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldu019
            
            #add-point:AFTER FIELD gldu019 name="construct.a.page3.gldu019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.gldu019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldu019
            #add-point:ON ACTION controlp INFIELD gldu019 name="construct.c.page3.gldu019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldu022
            #add-point:BEFORE FIELD gldu022 name="construct.b.page3.gldu022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldu022
            
            #add-point:AFTER FIELD gldu022 name="construct.a.page3.gldu022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.gldu022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldu022
            #add-point:ON ACTION controlp INFIELD gldu022 name="construct.c.page3.gldu022"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldu025
            #add-point:BEFORE FIELD gldu025 name="construct.b.page3.gldu025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldu025
            
            #add-point:AFTER FIELD gldu025 name="construct.a.page3.gldu025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.gldu025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldu025
            #add-point:ON ACTION controlp INFIELD gldu025 name="construct.c.page3.gldu025"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldu028
            #add-point:BEFORE FIELD gldu028 name="construct.b.page3.gldu028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldu028
            
            #add-point:AFTER FIELD gldu028 name="construct.a.page3.gldu028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.gldu028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldu028
            #add-point:ON ACTION controlp INFIELD gldu028 name="construct.c.page3.gldu028"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldu020
            #add-point:BEFORE FIELD gldu020 name="construct.b.page4.gldu020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldu020
            
            #add-point:AFTER FIELD gldu020 name="construct.a.page4.gldu020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.gldu020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldu020
            #add-point:ON ACTION controlp INFIELD gldu020 name="construct.c.page4.gldu020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldu023
            #add-point:BEFORE FIELD gldu023 name="construct.b.page4.gldu023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldu023
            
            #add-point:AFTER FIELD gldu023 name="construct.a.page4.gldu023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.gldu023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldu023
            #add-point:ON ACTION controlp INFIELD gldu023 name="construct.c.page4.gldu023"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldu026
            #add-point:BEFORE FIELD gldu026 name="construct.b.page4.gldu026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldu026
            
            #add-point:AFTER FIELD gldu026 name="construct.a.page4.gldu026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.gldu026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldu026
            #add-point:ON ACTION controlp INFIELD gldu026 name="construct.c.page4.gldu026"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldu029
            #add-point:BEFORE FIELD gldu029 name="construct.b.page4.gldu029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldu029
            
            #add-point:AFTER FIELD gldu029 name="construct.a.page4.gldu029"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.gldu029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldu029
            #add-point:ON ACTION controlp INFIELD gldu029 name="construct.c.page4.gldu029"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
  
 
  
      #add-point:cs段more_construct name="cs.more_construct"
      
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:ui_dialog段b_dialog name="cs.before_dialog"
         
         #end add-point
      
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
    
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
   
   #add-point:cs段after_construct name="cs.after_construct"
   
   #end add-point
   
   #組合g_wc2
   LET g_wc2 = g_wc2_table1
 
 
 
   
   LET g_current_row = 1
 
   IF INT_FLAG THEN
      RETURN
   END IF
   
   LET g_wc_filter = ""
 
END FUNCTION
 
{</section>}
 
{<section id="aglt521.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION aglt521_filter()
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
      CONSTRUCT g_wc_filter ON glduld,gldu001,gldu002,gldu003,gldu004
                          FROM s_browse[1].b_glduld,s_browse[1].b_gldu001,s_browse[1].b_gldu002,s_browse[1].b_gldu003, 
                              s_browse[1].b_gldu004
 
         BEFORE CONSTRUCT
               DISPLAY aglt521_filter_parser('glduld') TO s_browse[1].b_glduld
            DISPLAY aglt521_filter_parser('gldu001') TO s_browse[1].b_gldu001
            DISPLAY aglt521_filter_parser('gldu002') TO s_browse[1].b_gldu002
            DISPLAY aglt521_filter_parser('gldu003') TO s_browse[1].b_gldu003
            DISPLAY aglt521_filter_parser('gldu004') TO s_browse[1].b_gldu004
      
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
 
      CALL aglt521_filter_show('glduld')
   CALL aglt521_filter_show('gldu001')
   CALL aglt521_filter_show('gldu002')
   CALL aglt521_filter_show('gldu003')
   CALL aglt521_filter_show('gldu004')
 
END FUNCTION
 
{</section>}
 
{<section id="aglt521.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aglt521_filter_parser(ps_field)
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
 
{<section id="aglt521.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aglt521_filter_show(ps_field)
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
   LET ls_condition = aglt521_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aglt521.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aglt521_query()
   #add-point:query段define name="query.define_customerization"
   
   #end add-point   
   DEFINE ls_wc STRING
   #add-point:query段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="query.befroe_query"
   CALL cl_set_comp_visible('gldu006,page_3',TRUE)
   CALL cl_set_comp_visible('gldu007,page_4',TRUE)
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
   CALL g_gldu_d.clear()
   CALL g_gldu2_d.clear()
   CALL g_gldu3_d.clear()
   CALL g_gldu4_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL aglt521_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aglt521_browser_fill(g_wc)
      CALL aglt521_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL aglt521_browser_fill("F")
   
   #儲存WC資訊
   CALL cl_dlg_save_user_latestqry("("||g_wc||")")
   
   #備份搜尋條件
   LET ls_wc = g_wc
   
   IF g_browser.getLength() = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "-100" 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   ELSE
      CALL aglt521_fetch("F") 
   END IF
   
   CALL aglt521_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="aglt521.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aglt521_fetch(p_flag)
   #add-point:fetch段define name="fetch.define_customerization"
   
   #end add-point   
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="fetch.before_fetch"
   
   #end add-point    
 
   CASE p_flag
      WHEN 'F' 
         LET g_current_idx = 1
      WHEN 'L' 
         LET g_current_idx = g_header_cnt
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
 
            PROMPT ls_msg CLIPPED,': ' FOR g_jump
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
   
   #若無資料則離開
   IF g_current_idx = 0 THEN
      RETURN
   END IF
   
   
   CALL g_curr_diag.setCurrentRow("s_browse", g_current_idx) #設定browse 索引
   LET g_detail_cnt = g_header_cnt                  
   
   #單身筆數顯示
   DISPLAY g_detail_cnt TO FORMONLY.cnt                      #設定page 總筆數 
   #LET g_detail_idx = 1
   IF g_detail_cnt > 0 THEN
      #LET g_detail_idx = 1
      DISPLAY g_detail_idx TO FORMONLY.idx  
   ELSE
      LET g_detail_idx = 0
      DISPLAY ' ' TO FORMONLY.idx    
   END IF
   
   #瀏覽頁筆數顯示
   LET g_browser_idx = g_pagestart + g_current_idx-1
   DISPLAY g_browser_idx TO FORMONLY.b_index   #當下筆數
   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數
   DISPLAY g_browser_idx TO FORMONLY.h_index   #當下筆數
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數
   
   CALL cl_navigator_setting(g_current_idx,g_detail_cnt)
   
   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF
   
   #超出範圍
   IF g_current_idx > g_browser.getLength() THEN
      LET g_current_idx = g_browser.getLength()
   END IF
   
   LET g_gldu_m.glduld = g_browser[g_current_idx].b_glduld
   LET g_gldu_m.gldu001 = g_browser[g_current_idx].b_gldu001
   LET g_gldu_m.gldu002 = g_browser[g_current_idx].b_gldu002
   LET g_gldu_m.gldu003 = g_browser[g_current_idx].b_gldu003
   LET g_gldu_m.gldu004 = g_browser[g_current_idx].b_gldu004
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE aglt521_master_referesh USING g_gldu_m.glduld,g_gldu_m.gldu001,g_gldu_m.gldu002,g_gldu_m.gldu003, 
       g_gldu_m.gldu004 INTO g_gldu_m.glduld,g_gldu_m.gldu001,g_gldu_m.gldu002,g_gldu_m.gldu003,g_gldu_m.gldu004, 
       g_gldu_m.gldu008,g_gldu_m.gldu005,g_gldu_m.gldu006,g_gldu_m.gldu007,g_gldu_m.gldustus
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "gldu_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_gldu_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_gldu_m_mask_o.* =  g_gldu_m.*
   CALL aglt521_gldu_t_mask()
   LET g_gldu_m_mask_n.* =  g_gldu_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL aglt521_set_act_visible()
   CALL aglt521_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_gldu_m_t.* = g_gldu_m.*
   LET g_gldu_m_o.* = g_gldu_m.*
   
   #重新顯示   
   CALL aglt521_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="aglt521.insert" >}
#+ 資料新增
PRIVATE FUNCTION aglt521_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_gldu_d.clear()
   CALL g_gldu2_d.clear()
   CALL g_gldu3_d.clear()
   CALL g_gldu4_d.clear()
 
 
   INITIALIZE g_gldu_m.* TO NULL             #DEFAULT 設定
   LET g_glduld_t = NULL
   LET g_gldu001_t = NULL
   LET g_gldu002_t = NULL
   LET g_gldu003_t = NULL
   LET g_gldu004_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
            LET g_gldu_m.gldustus = "N"
 
     
      #add-point:單頭預設值 name="insert.default"
      #根據當下狀態碼顯示圖片
      CASE g_gldu_m.gldustus
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      END CASE
      CALL cl_set_comp_visible('gldu006,page_3',TRUE)
      CALL cl_set_comp_visible('gldu007,page_4',TRUE)
      #end add-point 
 
      CALL aglt521_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_gldu_m.* TO NULL
         INITIALIZE g_gldu_d TO NULL
         INITIALIZE g_gldu2_d TO NULL
         INITIALIZE g_gldu3_d TO NULL
         INITIALIZE g_gldu4_d TO NULL
 
         CALL aglt521_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_gldu_m.* = g_gldu_m_t.*
         CALL aglt521_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_gldu_d.clear()
      #CALL g_gldu2_d.clear()
      #CALL g_gldu3_d.clear()
      #CALL g_gldu4_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL aglt521_set_act_visible()
   CALL aglt521_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_glduld_t = g_gldu_m.glduld
   LET g_gldu001_t = g_gldu_m.gldu001
   LET g_gldu002_t = g_gldu_m.gldu002
   LET g_gldu003_t = g_gldu_m.gldu003
   LET g_gldu004_t = g_gldu_m.gldu004
 
   
   #組合新增資料的條件
   LET g_add_browse = " glduent = " ||g_enterprise|| " AND",
                      " glduld = '", g_gldu_m.glduld, "' "
                      ," AND gldu001 = '", g_gldu_m.gldu001, "' "
                      ," AND gldu002 = '", g_gldu_m.gldu002, "' "
                      ," AND gldu003 = '", g_gldu_m.gldu003, "' "
                      ," AND gldu004 = '", g_gldu_m.gldu004, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aglt521_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL aglt521_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aglt521_master_referesh USING g_gldu_m.glduld,g_gldu_m.gldu001,g_gldu_m.gldu002,g_gldu_m.gldu003, 
       g_gldu_m.gldu004 INTO g_gldu_m.glduld,g_gldu_m.gldu001,g_gldu_m.gldu002,g_gldu_m.gldu003,g_gldu_m.gldu004, 
       g_gldu_m.gldu008,g_gldu_m.gldu005,g_gldu_m.gldu006,g_gldu_m.gldu007,g_gldu_m.gldustus
   
   #遮罩相關處理
   LET g_gldu_m_mask_o.* =  g_gldu_m.*
   CALL aglt521_gldu_t_mask()
   LET g_gldu_m_mask_n.* =  g_gldu_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_gldu_m.glduld,g_gldu_m.glduld_desc,g_gldu_m.gldu001,g_gldu_m.gldu001_desc,g_gldu_m.gldu002, 
       g_gldu_m.gldu002_desc,g_gldu_m.gldu003,g_gldu_m.gldu004,g_gldu_m.gldu008,g_gldu_m.gldu005,g_gldu_m.gldu006, 
       g_gldu_m.gldu007,g_gldu_m.gldustus
   
   #功能已完成,通報訊息中心
   CALL aglt521_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aglt521.modify" >}
#+ 資料修改
PRIVATE FUNCTION aglt521_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_gldu_m.glduld IS NULL
   OR g_gldu_m.gldu001 IS NULL
   OR g_gldu_m.gldu002 IS NULL
   OR g_gldu_m.gldu003 IS NULL
   OR g_gldu_m.gldu004 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_glduld_t = g_gldu_m.glduld
   LET g_gldu001_t = g_gldu_m.gldu001
   LET g_gldu002_t = g_gldu_m.gldu002
   LET g_gldu003_t = g_gldu_m.gldu003
   LET g_gldu004_t = g_gldu_m.gldu004
 
   CALL s_transaction_begin()
   
   OPEN aglt521_cl USING g_enterprise,g_gldu_m.glduld,g_gldu_m.gldu001,g_gldu_m.gldu002,g_gldu_m.gldu003,g_gldu_m.gldu004
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aglt521_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE aglt521_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aglt521_master_referesh USING g_gldu_m.glduld,g_gldu_m.gldu001,g_gldu_m.gldu002,g_gldu_m.gldu003, 
       g_gldu_m.gldu004 INTO g_gldu_m.glduld,g_gldu_m.gldu001,g_gldu_m.gldu002,g_gldu_m.gldu003,g_gldu_m.gldu004, 
       g_gldu_m.gldu008,g_gldu_m.gldu005,g_gldu_m.gldu006,g_gldu_m.gldu007,g_gldu_m.gldustus
   
   #遮罩相關處理
   LET g_gldu_m_mask_o.* =  g_gldu_m.*
   CALL aglt521_gldu_t_mask()
   LET g_gldu_m_mask_n.* =  g_gldu_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL aglt521_show()
   WHILE TRUE
      LET g_glduld_t = g_gldu_m.glduld
      LET g_gldu001_t = g_gldu_m.gldu001
      LET g_gldu002_t = g_gldu_m.gldu002
      LET g_gldu003_t = g_gldu_m.gldu003
      LET g_gldu004_t = g_gldu_m.gldu004
 
 
      #add-point:modify段修改前 name="modify.before_input"
      #160818-00017#15  2016/08/24 By 07900 --add--s--
      #檢查是否允許此動作
      IF NOT aglt521_action_chk() THEN
        # CALL s_transaction_end('N','0')
         RETURN
      END IF
      #160818-00017#15  2016/08/24 By 07900 --add--e--
      
      #「D抽單 / R已拒絕」狀況碼更改資料後，需還原為「N未確認」
      IF g_gldu_m.gldustus MATCHES "[DR]" THEN
         LET g_gldu_m.gldustus = "N"
      END IF
      #end add-point
      
      CALL aglt521_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_gldu_m.* = g_gldu_m_t.*
         CALL aglt521_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_gldu_m.glduld != g_glduld_t 
      OR g_gldu_m.gldu001 != g_gldu001_t 
      OR g_gldu_m.gldu002 != g_gldu002_t 
      OR g_gldu_m.gldu003 != g_gldu003_t 
      OR g_gldu_m.gldu004 != g_gldu004_t 
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單頭(偽)修改前 name="modify.b_key_update"
         
         #end add-point
         
         #add-point:單頭(偽)修改中 name="modify.m_key_update"
         
         #end add-point
         
 
         
         #add-point:單頭(偽)修改後 name="modify.a_key_update"
         
         #end add-point
         
      END IF
      
      EXIT WHILE
      
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL aglt521_set_act_visible()
   CALL aglt521_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " glduent = " ||g_enterprise|| " AND",
                      " glduld = '", g_gldu_m.glduld, "' "
                      ," AND gldu001 = '", g_gldu_m.gldu001, "' "
                      ," AND gldu002 = '", g_gldu_m.gldu002, "' "
                      ," AND gldu003 = '", g_gldu_m.gldu003, "' "
                      ," AND gldu004 = '", g_gldu_m.gldu004, "' "
 
   #填到對應位置
   CALL aglt521_browser_fill("")
 
   CALL aglt521_idx_chk()
 
   CLOSE aglt521_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aglt521_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="aglt521.input" >}
#+ 資料輸入
PRIVATE FUNCTION aglt521_input(p_cmd)
   #add-point:input段define name="input.define_customerization"
   
   #end add-point   
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd_t               LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_ac_t                LIKE type_t.num10               #未取消的ARRAY CNT 
   DEFINE  l_n                   LIKE type_t.num10               #檢查重複用  
   DEFINE  l_cnt                 LIKE type_t.num10               #檢查重複用  
   DEFINE  l_lock_sw             LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert        LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete        LIKE type_t.num5                #可刪除否  
   DEFINE  l_count               LIKE type_t.num10
   DEFINE  l_i                   LIKE type_t.num10
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
   #add-point:input段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   DEFINE  l_glaa004             LIKE glaa_t.glaa004  #150916-00015#1 -add
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
   DISPLAY BY NAME g_gldu_m.glduld,g_gldu_m.glduld_desc,g_gldu_m.gldu001,g_gldu_m.gldu001_desc,g_gldu_m.gldu002, 
       g_gldu_m.gldu002_desc,g_gldu_m.gldu003,g_gldu_m.gldu004,g_gldu_m.gldu008,g_gldu_m.gldu005,g_gldu_m.gldu006, 
       g_gldu_m.gldu007,g_gldu_m.gldustus
   
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
   LET g_forupd_sql = "SELECT gldu009,gldu010,gldu011,gldu012,gldu013,gldu014,gldu015,gldu016,gldu017, 
       gldu018,gldu021,gldu024,gldu027,gldu009,glduownid,glduowndp,glducrtid,glducrtdp,glducrtdt,gldumodid, 
       gldumoddt,glducnfid,glducnfdt,gldu009,gldu019,gldu022,gldu025,gldu028,gldu009,gldu020,gldu023, 
       gldu026,gldu029 FROM gldu_t WHERE glduent=? AND glduld=? AND gldu001=? AND gldu002=? AND gldu003=?  
       AND gldu004=? AND gldu009=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aglt521_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aglt521_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL aglt521_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_gldu_m.glduld,g_gldu_m.gldu001,g_gldu_m.gldu003,g_gldu_m.gldu004,g_gldu_m.gldustus 
 
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="aglt521.input.head" >}
   
      #單頭段
      INPUT BY NAME g_gldu_m.glduld,g_gldu_m.gldu001,g_gldu_m.gldu003,g_gldu_m.gldu004,g_gldu_m.gldustus  
 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂單頭ACTION
         
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #add-point:單頭input前 name="input.head.b_input"
            
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glduld
            
            #add-point:AFTER FIELD glduld name="input.a.glduld"
            #合併帳別
            #確認資料無重複
            IF  NOT cl_null(g_gldu_m.glduld) AND NOT cl_null(g_gldu_m.gldu001) AND NOT cl_null(g_gldu_m.gldu002) AND NOT cl_null(g_gldu_m.gldu003) AND NOT cl_null(g_gldu_m.gldu004) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_gldu_m.glduld != g_glduld_t  OR g_gldu_m.gldu001 != g_gldu001_t  OR g_gldu_m.gldu002 != g_gldu002_t  OR g_gldu_m.gldu003 != g_gldu003_t  OR g_gldu_m.gldu004 != g_gldu004_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gldu_t WHERE "||"glduent = '" ||g_enterprise|| "' AND "||"glduld = '"||g_gldu_m.glduld ||"' AND "|| "gldu001 = '"||g_gldu_m.gldu001 ||"' AND "|| "gldu002 = '"||g_gldu_m.gldu002 ||"' AND "|| "gldu003 = '"||g_gldu_m.gldu003 ||"' AND "|| "gldu004 = '"||g_gldu_m.gldu004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF NOT cl_null(g_gldu_m.glduld) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_gldu_m.glduld != g_glduld_t OR g_glduld_t IS NULL )) THEN #160824-00007#263 161223 By 08171 mark
               IF cl_null(g_gldu_m_o.glduld) OR g_gldu_m.glduld != g_gldu_m_o.glduld THEN #160824-00007#263 161223 By 08171 add
                  CALL s_merge_ld_with_comp_chk(g_gldu_m.glduld,g_gldu_m.gldu001,g_user,1)RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                    #LET g_gldu_m.glduld = g_glduld_t #160824-00007#263 161223 By 08171 mark
                     LET g_gldu_m.glduld = g_gldu_m_o.glduld #160824-00007#263 161223 By 08171 add
                     CALL s_desc_get_ld_desc(g_gldu_m.glduld) RETURNING g_gldu_m.glduld_desc
                     DISPLAY BY NAME g_gldu_m.glduld,g_gldu_m.glduld_desc
                     NEXT FIELD CURRENT
                  END IF
                 #LET g_glduld_t = g_gldu_m.glduld #160824-00007#263 161223 By 08171 mark
                  CALL aglt521_ld_visible()
               END IF
            END IF
            CALL s_desc_get_ld_desc(g_gldu_m.glduld) RETURNING g_gldu_m.glduld_desc
            CALL s_ld_sel_glaa(g_gldu_m.glduld,'glaa004|glaa131') RETURNING g_sub_success,g_glaa.glaa004,g_glaa.glaa131
            DISPLAY BY NAME g_gldu_m.glduld,g_gldu_m.glduld_desc
            LET g_gldu_m_o.* = g_gldu_m.* #160824-00007#263 161223 By 08171 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glduld
            #add-point:BEFORE FIELD glduld name="input.b.glduld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glduld
            #add-point:ON CHANGE glduld name="input.g.glduld"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldu001
            
            #add-point:AFTER FIELD gldu001 name="input.a.gldu001"
            #上層公司
            #確認資料無重複
            IF  NOT cl_null(g_gldu_m.glduld) AND NOT cl_null(g_gldu_m.gldu001) AND NOT cl_null(g_gldu_m.gldu002) AND NOT cl_null(g_gldu_m.gldu003) AND NOT cl_null(g_gldu_m.gldu004) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_gldu_m.glduld != g_glduld_t  OR g_gldu_m.gldu001 != g_gldu001_t  OR g_gldu_m.gldu002 != g_gldu002_t  OR g_gldu_m.gldu003 != g_gldu003_t  OR g_gldu_m.gldu004 != g_gldu004_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gldu_t WHERE "||"glduent = '" ||g_enterprise|| "' AND "||"glduld = '"||g_gldu_m.glduld ||"' AND "|| "gldu001 = '"||g_gldu_m.gldu001 ||"' AND "|| "gldu002 = '"||g_gldu_m.gldu002 ||"' AND "|| "gldu003 = '"||g_gldu_m.gldu003 ||"' AND "|| "gldu004 = '"||g_gldu_m.gldu004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF NOT cl_null(g_gldu_m.gldu001) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_gldu_m.gldu001 != g_gldu001_t OR g_gldu001_t IS NULL )) THEN #160824-00007#263 161223 By 08171 mark
               IF cl_null(g_gldu_m_o.gldu001) OR g_gldu_m.gldu001 != g_gldu_m_o.gldu001 THEN #160824-00007#263 161223 By 08171 add
                  CALL s_merge_ld_with_comp_chk(g_gldu_m.glduld,g_gldu_m.gldu001,g_user,1) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                    #LET g_gldu_m.gldu001 = g_gldu001_t #160824-00007#263 161223 By 08171 mark
                     LET g_gldu_m.gldu001 = g_gldu_m_o.gldu001 #160824-00007#263 161223 By 08171 add
                     LET g_gldu_m.gldu001_desc = s_desc_glda001_desc(g_gldu_m.gldu001)
                     DISPLAY BY NAME g_gldu_m.gldu001,g_gldu_m.gldu001_desc
                     NEXT FIELD CURRENT
                  END IF
                 #LET g_gldu001_t = g_gldu_m.gldu001 #160824-00007#263 161223 By 08171 mark
                  #抓取該上層公司的帳別
                  CALL s_merge_get_gl_ld(g_gldu_m.glduld,g_gldu_m.gldu001) RETURNING g_gldu_m.gldu002
                  CALL s_desc_get_ld_desc(g_gldu_m.gldu002) RETURNING g_gldu_m.gldu002_desc
                  DISPLAY BY NAME g_gldu_m.gldu002,g_gldu_m.gldu002_desc
               END IF
            END IF
            LET g_gldu_m.gldu001_desc = s_desc_glda001_desc(g_gldu_m.gldu001)
            DISPLAY BY NAME g_gldu_m.gldu001,g_gldu_m.gldu001_desc
            LET g_gldu_m_o.* = g_gldu_m.* #160824-00007#263 161223 By 08171 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldu001
            #add-point:BEFORE FIELD gldu001 name="input.b.gldu001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldu001
            #add-point:ON CHANGE gldu001 name="input.g.gldu001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldu003
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_gldu_m.gldu003,"0","0","2099","1","azz-00087",1) THEN
               NEXT FIELD gldu003
            END IF 
 
 
 
            #add-point:AFTER FIELD gldu003 name="input.a.gldu003"
            #年度
            #確認資料無重複
            IF  NOT cl_null(g_gldu_m.glduld) AND NOT cl_null(g_gldu_m.gldu001) AND NOT cl_null(g_gldu_m.gldu002) AND NOT cl_null(g_gldu_m.gldu003) AND NOT cl_null(g_gldu_m.gldu004) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_gldu_m.glduld != g_glduld_t  OR g_gldu_m.gldu001 != g_gldu001_t  OR g_gldu_m.gldu002 != g_gldu002_t  OR g_gldu_m.gldu003 != g_gldu003_t  OR g_gldu_m.gldu004 != g_gldu004_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gldu_t WHERE "||"glduent = '" ||g_enterprise|| "' AND "||"glduld = '"||g_gldu_m.glduld ||"' AND "|| "gldu001 = '"||g_gldu_m.gldu001 ||"' AND "|| "gldu002 = '"||g_gldu_m.gldu002 ||"' AND "|| "gldu003 = '"||g_gldu_m.gldu003 ||"' AND "|| "gldu004 = '"||g_gldu_m.gldu004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldu003
            #add-point:BEFORE FIELD gldu003 name="input.b.gldu003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldu003
            #add-point:ON CHANGE gldu003 name="input.g.gldu003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldu004
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_gldu_m.gldu004,"0","0","13","1","azz-00087",1) THEN
               NEXT FIELD gldu004
            END IF 
 
 
 
            #add-point:AFTER FIELD gldu004 name="input.a.gldu004"
            #期別
            #確認資料無重複
            IF  NOT cl_null(g_gldu_m.glduld) AND NOT cl_null(g_gldu_m.gldu001) AND NOT cl_null(g_gldu_m.gldu002) AND NOT cl_null(g_gldu_m.gldu003) AND NOT cl_null(g_gldu_m.gldu004) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_gldu_m.glduld != g_glduld_t  OR g_gldu_m.gldu001 != g_gldu001_t  OR g_gldu_m.gldu002 != g_gldu002_t  OR g_gldu_m.gldu003 != g_gldu003_t  OR g_gldu_m.gldu004 != g_gldu004_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gldu_t WHERE "||"glduent = '" ||g_enterprise|| "' AND "||"glduld = '"||g_gldu_m.glduld ||"' AND "|| "gldu001 = '"||g_gldu_m.gldu001 ||"' AND "|| "gldu002 = '"||g_gldu_m.gldu002 ||"' AND "|| "gldu003 = '"||g_gldu_m.gldu003 ||"' AND "|| "gldu004 = '"||g_gldu_m.gldu004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldu004
            #add-point:BEFORE FIELD gldu004 name="input.b.gldu004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldu004
            #add-point:ON CHANGE gldu004 name="input.g.gldu004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldustus
            #add-point:BEFORE FIELD gldustus name="input.b.gldustus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldustus
            
            #add-point:AFTER FIELD gldustus name="input.a.gldustus"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldustus
            #add-point:ON CHANGE gldustus name="input.g.gldustus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.glduld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glduld
            #add-point:ON ACTION controlp INFIELD glduld name="input.c.glduld"
            #合併帳別
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_gldu_m.glduld
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            #為上層帳套
            LET g_qryparam.where = " glaald IN (SELECT gldbld FROM gldb_t ",
                                   "  WHERE gldbstus = 'Y' ",  
                                   "    AND gldbent = '",g_enterprise,"') "
            CALL q_authorised_ld()
            LET g_gldu_m.glduld = g_qryparam.return1
            LET g_gldu_m.glduld_desc = s_desc_get_ld_desc(g_gldu_m.glduld)
            DISPLAY BY NAME g_gldu_m.glduld,g_gldu_m.glduld_desc
            NEXT FIELD glduld
            #END add-point
 
 
         #Ctrlp:input.c.gldu001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldu001
            #add-point:ON ACTION controlp INFIELD gldu001 name="input.c.gldu001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_gldu_m.gldu001
            LET g_qryparam.where = "gldc009 = 'Y' AND gldbstus = 'Y' AND gldcld = '",g_gldu_m.glduld,"'"
            CALL q_gldc001()
            LET g_gldu_m.gldu001 = g_qryparam.return1
            LET g_gldu_m.gldu001_desc = s_desc_glda001_desc(g_gldu_m.gldu001)
            DISPLAY BY NAME g_gldu_m.gldu001,g_gldu_m.gldu001_desc
            NEXT FIELD gldu001
            #END add-point
 
 
         #Ctrlp:input.c.gldu003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldu003
            #add-point:ON ACTION controlp INFIELD gldu003 name="input.c.gldu003"
            
            #END add-point
 
 
         #Ctrlp:input.c.gldu004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldu004
            #add-point:ON ACTION controlp INFIELD gldu004 name="input.c.gldu004"
            
            #END add-point
 
 
         #Ctrlp:input.c.gldustus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldustus
            #add-point:ON ACTION controlp INFIELD gldustus name="input.c.gldustus"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
            
            IF s_transaction_chk("N",0) THEN
                CALL s_transaction_begin()
            END IF
            
            #錯誤訊息統整顯示
            #CALL cl_err_collect_show()
            #CALL cl_showmsg()
            DISPLAY BY NAME g_gldu_m.glduld             
                            ,g_gldu_m.gldu001   
                            ,g_gldu_m.gldu002   
                            ,g_gldu_m.gldu003   
                            ,g_gldu_m.gldu004   
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
            
               #將遮罩欄位還原
               CALL aglt521_gldu_t_mask_restore('restore_mask_o')
            
               UPDATE gldu_t SET (glduld,gldu001,gldu002,gldu003,gldu004,gldu008,gldu005,gldu006,gldu007, 
                   gldustus) = (g_gldu_m.glduld,g_gldu_m.gldu001,g_gldu_m.gldu002,g_gldu_m.gldu003,g_gldu_m.gldu004, 
                   g_gldu_m.gldu008,g_gldu_m.gldu005,g_gldu_m.gldu006,g_gldu_m.gldu007,g_gldu_m.gldustus) 
 
                WHERE glduent = g_enterprise AND glduld = g_glduld_t
                  AND gldu001 = g_gldu001_t
                  AND gldu002 = g_gldu002_t
                  AND gldu003 = g_gldu003_t
                  AND gldu004 = g_gldu004_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gldu_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gldu_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gldu_m.glduld
               LET gs_keys_bak[1] = g_glduld_t
               LET gs_keys[2] = g_gldu_m.gldu001
               LET gs_keys_bak[2] = g_gldu001_t
               LET gs_keys[3] = g_gldu_m.gldu002
               LET gs_keys_bak[3] = g_gldu002_t
               LET gs_keys[4] = g_gldu_m.gldu003
               LET gs_keys_bak[4] = g_gldu003_t
               LET gs_keys[5] = g_gldu_m.gldu004
               LET gs_keys_bak[5] = g_gldu004_t
               LET gs_keys[6] = g_gldu_d[g_detail_idx].gldu009
               LET gs_keys_bak[6] = g_gldu_d_t.gldu009
               CALL aglt521_update_b('gldu_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_gldu_m_t)
                     #LET g_log2 = util.JSON.stringify(g_gldu_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL aglt521_gldu_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL aglt521_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_glduld_t = g_gldu_m.glduld
           LET g_gldu001_t = g_gldu_m.gldu001
           LET g_gldu002_t = g_gldu_m.gldu002
           LET g_gldu003_t = g_gldu_m.gldu003
           LET g_gldu004_t = g_gldu_m.gldu004
 
           
           IF g_gldu_d.getLength() = 0 THEN
              NEXT FIELD gldu009
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="aglt521.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_gldu_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_gldu_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aglt521_b_fill(g_wc2) #test 
            #如果一直都在單頭則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_detail_idx)
            END IF
            LET g_loc = 'm' 
            LET g_current_page = 1
            #add-point:資料輸入前 name="input.body.before_input"
            
            #end add-point
         
         BEFORE ROW
            #add-point:modify段before row name="input.body.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aglt521_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN aglt521_cl USING g_enterprise,g_gldu_m.glduld,g_gldu_m.gldu001,g_gldu_m.gldu002,g_gldu_m.gldu003,g_gldu_m.gldu004                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE aglt521_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN aglt521_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_gldu_d[l_ac].gldu009 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_gldu_d_t.* = g_gldu_d[l_ac].*  #BACKUP
               LET g_gldu_d_o.* = g_gldu_d[l_ac].*  #BACKUP
               CALL aglt521_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL aglt521_set_no_entry_b(l_cmd)
               OPEN aglt521_bcl USING g_enterprise,g_gldu_m.glduld,
                                                g_gldu_m.gldu001,
                                                g_gldu_m.gldu002,
                                                g_gldu_m.gldu003,
                                                g_gldu_m.gldu004,
 
                                                g_gldu_d_t.gldu009
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN aglt521_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aglt521_bcl INTO g_gldu_d[l_ac].gldu009,g_gldu_d[l_ac].gldu010,g_gldu_d[l_ac].gldu011, 
                      g_gldu_d[l_ac].gldu012,g_gldu_d[l_ac].gldu013,g_gldu_d[l_ac].gldu014,g_gldu_d[l_ac].gldu015, 
                      g_gldu_d[l_ac].gldu016,g_gldu_d[l_ac].gldu017,g_gldu_d[l_ac].gldu018,g_gldu_d[l_ac].gldu021, 
                      g_gldu_d[l_ac].gldu024,g_gldu_d[l_ac].gldu027,g_gldu2_d[l_ac].gldu009,g_gldu2_d[l_ac].glduownid, 
                      g_gldu2_d[l_ac].glduowndp,g_gldu2_d[l_ac].glducrtid,g_gldu2_d[l_ac].glducrtdp, 
                      g_gldu2_d[l_ac].glducrtdt,g_gldu2_d[l_ac].gldumodid,g_gldu2_d[l_ac].gldumoddt, 
                      g_gldu2_d[l_ac].glducnfid,g_gldu2_d[l_ac].glducnfdt,g_gldu3_d[l_ac].gldu009,g_gldu3_d[l_ac].gldu019, 
                      g_gldu3_d[l_ac].gldu022,g_gldu3_d[l_ac].gldu025,g_gldu3_d[l_ac].gldu028,g_gldu4_d[l_ac].gldu009, 
                      g_gldu4_d[l_ac].gldu020,g_gldu4_d[l_ac].gldu023,g_gldu4_d[l_ac].gldu026,g_gldu4_d[l_ac].gldu029 
 
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_gldu_d_t.gldu009,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_gldu_d_mask_o[l_ac].* =  g_gldu_d[l_ac].*
                  CALL aglt521_gldu_t_mask()
                  LET g_gldu_d_mask_n[l_ac].* =  g_gldu_d[l_ac].*
                  
                  CALL aglt521_ref_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            
            #end add-point  
            
 
 
 
 
        
         BEFORE INSERT
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            INITIALIZE g_gldu_d_t.* TO NULL
            INITIALIZE g_gldu_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_gldu_d[l_ac].* TO NULL
            #公用欄位預設值
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_gldu2_d[l_ac].glduownid = g_user
      LET g_gldu2_d[l_ac].glduowndp = g_dept
      LET g_gldu2_d[l_ac].glducrtid = g_user
      LET g_gldu2_d[l_ac].glducrtdp = g_dept 
      LET g_gldu2_d[l_ac].glducrtdt = cl_get_current()
      LET g_gldu2_d[l_ac].gldumodid = g_user
      LET g_gldu2_d[l_ac].gldumoddt = cl_get_current()
 
 
  
            #一般欄位預設值
                  LET g_gldu_d[l_ac].gldu010 = "1"
      LET g_gldu_d[l_ac].gldu018 = "0"
      LET g_gldu_d[l_ac].gldu021 = "0"
      LET g_gldu_d[l_ac].gldu024 = "0"
      LET g_gldu_d[l_ac].gldu027 = "0"
 
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            
            #end add-point
            LET g_gldu_d_t.* = g_gldu_d[l_ac].*     #新輸入資料
            LET g_gldu_d_o.* = g_gldu_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aglt521_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL aglt521_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_gldu_d[li_reproduce_target].* = g_gldu_d[li_reproduce].*
               LET g_gldu2_d[li_reproduce_target].* = g_gldu2_d[li_reproduce].*
               LET g_gldu3_d[li_reproduce_target].* = g_gldu3_d[li_reproduce].*
               LET g_gldu4_d[li_reproduce_target].* = g_gldu4_d[li_reproduce].*
 
               LET g_gldu_d[g_gldu_d.getLength()].gldu009 = NULL
 
            END IF
            
 
 
 
 
            #add-point:modify段before insert name="input.body.before_insert"
            #項次
            SELECT MAX(gldu009)+1 INTO g_gldu_d[l_ac].gldu009 FROM gldu_t
             WHERE glduent = g_enterprise AND glduld = g_gldu_m.glduld
               AND gldu001 = g_gldu_m.gldu001 AND gldu003 = g_gldu_m.gldu003 AND gldu004 = g_gldu_m.gldu004
            IF cl_null(g_gldu_d[l_ac].gldu009) OR g_gldu_d[l_ac].gldu009=0 THEN
               LET g_gldu_d[l_ac].gldu009 = 1
            END IF
            LET g_gldu3_d[l_ac].gldu019 = "0"
            LET g_gldu3_d[l_ac].gldu022 = "0"
            LET g_gldu3_d[l_ac].gldu025 = "0"
            LET g_gldu3_d[l_ac].gldu028 = "0"
            LET g_gldu4_d[l_ac].gldu020 = "0"
            LET g_gldu4_d[l_ac].gldu023 = "0"
            LET g_gldu4_d[l_ac].gldu026 = "0"
            LET g_gldu4_d[l_ac].gldu029 = "0"
            #end add-point  
 
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身新增 name="input.body.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM gldu_t 
             WHERE glduent = g_enterprise AND glduld = g_gldu_m.glduld
               AND gldu001 = g_gldu_m.gldu001
               AND gldu002 = g_gldu_m.gldu002
               AND gldu003 = g_gldu_m.gldu003
               AND gldu004 = g_gldu_m.gldu004
 
               AND gldu009 = g_gldu_d[l_ac].gldu009
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
               INSERT INTO gldu_t
                           (glduent,
                            glduld,gldu001,gldu002,gldu003,gldu004,gldu008,gldu005,gldu006,gldu007,gldustus,
                            gldu009
                            ,gldu010,gldu011,gldu012,gldu013,gldu014,gldu015,gldu016,gldu017,gldu018,gldu021,gldu024,gldu027,glduownid,glduowndp,glducrtid,glducrtdp,glducrtdt,gldumodid,gldumoddt,glducnfid,glducnfdt,gldu019,gldu022,gldu025,gldu028,gldu020,gldu023,gldu026,gldu029) 
                     VALUES(g_enterprise,
                            g_gldu_m.glduld,g_gldu_m.gldu001,g_gldu_m.gldu002,g_gldu_m.gldu003,g_gldu_m.gldu004,g_gldu_m.gldu008,g_gldu_m.gldu005,g_gldu_m.gldu006,g_gldu_m.gldu007,g_gldu_m.gldustus,
                            g_gldu_d[l_ac].gldu009
                            ,g_gldu_d[l_ac].gldu010,g_gldu_d[l_ac].gldu011,g_gldu_d[l_ac].gldu012,g_gldu_d[l_ac].gldu013, 
                                g_gldu_d[l_ac].gldu014,g_gldu_d[l_ac].gldu015,g_gldu_d[l_ac].gldu016, 
                                g_gldu_d[l_ac].gldu017,g_gldu_d[l_ac].gldu018,g_gldu_d[l_ac].gldu021, 
                                g_gldu_d[l_ac].gldu024,g_gldu_d[l_ac].gldu027,g_gldu2_d[l_ac].glduownid, 
                                g_gldu2_d[l_ac].glduowndp,g_gldu2_d[l_ac].glducrtid,g_gldu2_d[l_ac].glducrtdp, 
                                g_gldu2_d[l_ac].glducrtdt,g_gldu2_d[l_ac].gldumodid,g_gldu2_d[l_ac].gldumoddt, 
                                g_gldu2_d[l_ac].glducnfid,g_gldu2_d[l_ac].glducnfdt,g_gldu3_d[l_ac].gldu019, 
                                g_gldu3_d[l_ac].gldu022,g_gldu3_d[l_ac].gldu025,g_gldu3_d[l_ac].gldu028, 
                                g_gldu4_d[l_ac].gldu020,g_gldu4_d[l_ac].gldu023,g_gldu4_d[l_ac].gldu026, 
                                g_gldu4_d[l_ac].gldu029)
               #add-point:單身新增中 name="input.body.m_insert"
               
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_gldu_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "gldu_t:",SQLERRMESSAGE 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b=g_rec_b+1
               DISPLAY g_rec_b TO FORMONLY.cnt
            END IF
            
            #add-point:單身新增後 name="input.body.after_insert"
            
            #end add-point
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               #add-point:單身刪除前 name="input.body.b_delete"
               
               #end add-point
               
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   =  -263 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               IF aglt521_before_delete() THEN 
                  
 
 
 
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_gldu_m.glduld
                  LET gs_keys[gs_keys.getLength()+1] = g_gldu_m.gldu001
                  LET gs_keys[gs_keys.getLength()+1] = g_gldu_m.gldu002
                  LET gs_keys[gs_keys.getLength()+1] = g_gldu_m.gldu003
                  LET gs_keys[gs_keys.getLength()+1] = g_gldu_m.gldu004
 
                  LET gs_keys[gs_keys.getLength()+1] = g_gldu_d_t.gldu009
 
 
                  #刪除下層單身
                  IF NOT aglt521_key_delete_b(gs_keys,'gldu_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE aglt521_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE aglt521_bcl
               LET l_count = g_gldu_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_gldu_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldu010
            #add-point:BEFORE FIELD gldu010 name="input.b.page1.gldu010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldu010
            
            #add-point:AFTER FIELD gldu010 name="input.a.page1.gldu010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldu010
            #add-point:ON CHANGE gldu010 name="input.g.page1.gldu010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldu011
            
            #add-point:AFTER FIELD gldu011 name="input.a.page1.gldu011"
            IF NOT cl_null(g_gldu_m.glduld) THEN
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gldu_d[l_ac].gldu011 != g_gldu_d_t.gldu011)) THEN #160824-00007#263 161223 By 08171 mark
               IF cl_null(g_gldu_d_o.gldu011) OR g_gldu_d[l_ac].gldu011 != g_gldu_d_o.gldu011 THEN #160824-00007#263 161223 By 08171 add
                  #3>>存在並且是合併帳套/並且為上層公司之帳套
                  CALL s_merge_ld_with_comp_chk(g_gldu_m.glduld,g_gldu_d[l_ac].gldu011,g_user,'3')RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                    #LET g_gldu_d[l_ac].gldu011 = g_gldu_d_t.gldu011 #160824-00007#263 161223 By 08171 mark
                     LET g_gldu_d[l_ac].gldu011 = g_gldu_d_o.gldu011 #160824-00007#263 161223 By 08171 add
                     CALL s_merge_get_gl_ld(g_gldu_m.glduld,g_gldu_d[l_ac].gldu011) RETURNING g_gldu_d[l_ac].gldu012
                     DISPLAY BY NAME g_gldu_d[l_ac].gldu012
                     LET g_gldu_d[l_ac].gldu011_desc = s_desc_glda001_desc(g_gldu_d[l_ac].gldu011)
                     DISPLAY BY NAME g_gldu_d[l_ac].gldu011,g_gldu_d[l_ac].gldu011_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
               CALL s_merge_get_gl_ld(g_gldu_m.glduld,g_gldu_d[l_ac].gldu011) RETURNING g_gldu_d[l_ac].gldu012
               DISPLAY BY NAME g_gldu_d[l_ac].gldu012
               CALL s_desc_glda001_desc(g_gldu_d[l_ac].gldu011) RETURNING g_gldu_d[l_ac].gldu011_desc
               DISPLAY BY NAME g_gldu_d[l_ac].gldu011,g_gldu_d[l_ac].gldu011_desc
            END IF
            LET g_gldu_d_o.* = g_gldu_d[l_ac].*  #160824-00007#263 161223 By 08171 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldu011
            #add-point:BEFORE FIELD gldu011 name="input.b.page1.gldu011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldu011
            #add-point:ON CHANGE gldu011 name="input.g.page1.gldu011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldu012
            #add-point:BEFORE FIELD gldu012 name="input.b.page1.gldu012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldu012
            
            #add-point:AFTER FIELD gldu012 name="input.a.page1.gldu012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldu012
            #add-point:ON CHANGE gldu012 name="input.g.page1.gldu012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldu013
            
            #add-point:AFTER FIELD gldu013 name="input.a.page1.gldu013"
            IF NOT cl_null(g_gldu_m.glduld) THEN
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gldu_d[l_ac].gldu013 != g_gldu_d_t.gldu013)) THEN #160824-00007#263 161223 By 08171 mark
               IF cl_null(g_gldu_d_o.gldu013) OR g_gldu_d[l_ac].gldu013 != g_gldu_d_o.gldu013 THEN #160824-00007#263 161223 By 08171 add
                  #3>>存在並且是合併帳套/並且為上層公司之帳套
                  CALL s_merge_ld_with_comp_chk(g_gldu_m.glduld,g_gldu_d[l_ac].gldu013,g_user,'3')RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                    #LET g_gldu_d[l_ac].gldu013 = g_gldu_d_t.gldu013 #160824-00007#263 161223 By 08171 mark
                     LET g_gldu_d[l_ac].gldu013 = g_gldu_d_o.gldu013 #160824-00007#263 161223 By 08171 add
                     CALL s_merge_get_gl_ld(g_gldu_m.glduld,g_gldu_d[l_ac].gldu013) RETURNING g_gldu_d[l_ac].gldu014
                     DISPLAY BY NAME g_gldu_d[l_ac].gldu014
                     CALL s_desc_glda001_desc(g_gldu_d[l_ac].gldu013) RETURNING g_gldu_d[l_ac].gldu013_desc
                     DISPLAY BY NAME g_gldu_d[l_ac].gldu013,g_gldu_d[l_ac].gldu013_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
               CALL s_merge_get_gl_ld(g_gldu_m.glduld,g_gldu_d[l_ac].gldu013) RETURNING g_gldu_d[l_ac].gldu014
               DISPLAY BY NAME g_gldu_d[l_ac].gldu014
               CALL s_desc_glda001_desc(g_gldu_d[l_ac].gldu013) RETURNING g_gldu_d[l_ac].gldu013_desc
               DISPLAY BY NAME g_gldu_d[l_ac].gldu013,g_gldu_d[l_ac].gldu013_desc
            END IF
            LET g_gldu_d_o.* = g_gldu_d[l_ac].* #160824-00007#263 161223 By 08171 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldu013
            #add-point:BEFORE FIELD gldu013 name="input.b.page1.gldu013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldu013
            #add-point:ON CHANGE gldu013 name="input.g.page1.gldu013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldu014
            #add-point:BEFORE FIELD gldu014 name="input.b.page1.gldu014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldu014
            
            #add-point:AFTER FIELD gldu014 name="input.a.page1.gldu014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldu014
            #add-point:ON CHANGE gldu014 name="input.g.page1.gldu014"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldu015
            
            #add-point:AFTER FIELD gldu015 name="input.a.page1.gldu015"
            IF NOT cl_null(g_gldu_d[l_ac].gldu015) THEN
               # 开窗模糊查询 150916-00015#1 --add                      
               IF s_aglt310_getlike_lc_subject(g_gldu_m.glduld,g_gldu_d[l_ac].gldu015,"")  THEN            
                  
                  SELECT glaa004 INTO l_glaa004
                    FROM glaa_t
                   WHERE glaaent = g_enterprise
                     AND glaald  = g_gldu_m.glduld
                  
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = 'FALSE'
                  LET g_qryparam.default1 = g_gldu_d[l_ac].gldu015
                                
                  LET g_qryparam.arg1 = l_glaa004
                  LET g_qryparam.arg2 = g_gldu_d[l_ac].gldu015
                  LET g_qryparam.arg3 = g_gldu_m.glduld
                  LET g_qryparam.arg4 = " 1"
                  CALL q_glac002_6()
                  LET  g_gldu_d[l_ac].gldu015 = g_qryparam.return1 
                  LET g_gldu_d[l_ac].gldu015_desc =  s_desc_get_account_desc(g_gldu_m.glduld,g_gldu_d[l_ac].gldu015)
                  DISPLAY BY NAME g_gldu_d[l_ac].gldu015,g_gldu_d[l_ac].gldu015_desc                           
               END IF
               #科目存在性，有效性，非统治科目，非子系统科目，账户科目属性检查
               IF NOT  s_aglt310_lc_subject(g_gldu_m.glduld,g_gldu_d[l_ac].gldu015,'N') THEN
                  #LET g_gldu_d[l_ac].gldu015 = g_gldu_d_t.gldu015 #160824-00007#263 161223 By 08171 mark
                   LET g_gldu_d[l_ac].gldu015 = g_gldu_d_o.gldu015 #160824-00007#263 161223 By 08171 add
                   LET g_gldu_d[l_ac].gldu015_desc =  s_desc_get_account_desc(g_gldu_m.glduld,g_gldu_d[l_ac].gldu015)
                   DISPLAY BY NAME g_gldu_d[l_ac].gldu015_desc,g_gldu_d[l_ac].gldu015
                   NEXT FIELD CURRENT
               END IF
               # 150916-00015#1 --end   
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_gldu_d[l_ac].gldu015 != g_gldu_d_t.gldu015 OR g_gldu_d_t.gldu015 IS NULL )) THEN #160824-00007#263 161223 By 08171 mark
               IF cl_null(g_gldu_d_o.gldu015) OR g_gldu_d[l_ac].gldu015 != g_gldu_d_o.gldu015 THEN #160824-00007#263 161223 By 08171 add
                  CALL s_merge_glac002_chk(g_glaa.glaa004,g_gldu_d[l_ac].gldu015)RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam.* TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     #160321-00016#31 --s add
                     IF g_errno = 'sub-01302' THEN
                        LET g_errparam.replace[1] = 'agli020'
                        LET g_errparam.replace[2] = cl_get_progname('agli020',g_lang,"2")
                        LET g_errparam.exeprog = 'agli020'
                     END IF
                     #160321-00016#31 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                    #LET g_gldu_d[l_ac].gldu015 = g_gldu_d_t.gldu015 #160824-00007#263 161223 By 08171 mark
                     LET g_gldu_d[l_ac].gldu015 = g_gldu_d_o.gldu015 #160824-00007#263 161223 By 08171 add
                     LET g_gldu_d[l_ac].gldu015_desc =  s_desc_get_account_desc(g_gldu_m.glduld,g_gldu_d[l_ac].gldu015)
                     DISPLAY BY NAME g_gldu_d[l_ac].gldu015_desc,g_gldu_d[l_ac].gldu015
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_gldu_d[l_ac].gldu015_desc =  s_desc_get_account_desc(g_gldu_m.glduld,g_gldu_d[l_ac].gldu015)
            DISPLAY BY NAME g_gldu_d[l_ac].gldu015,g_gldu_d[l_ac].gldu015_desc
            LET g_gldu_d_o.* = g_gldu_d[l_ac].* #160824-00007#263 161223 By 08171 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldu015
            #add-point:BEFORE FIELD gldu015 name="input.b.page1.gldu015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldu015
            #add-point:ON CHANGE gldu015 name="input.g.page1.gldu015"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldu016
            
            #add-point:AFTER FIELD gldu016 name="input.a.page1.gldu016"
            IF NOT cl_null(g_gldu_d[l_ac].gldu016) THEN
               # 开窗模糊查询 150916-00015#1 --add                      
               IF s_aglt310_getlike_lc_subject(g_gldu_m.glduld,g_gldu_d[l_ac].gldu016,"")  THEN            
                  
                  SELECT glaa004 INTO l_glaa004
                    FROM glaa_t
                   WHERE glaaent = g_enterprise
                     AND glaald  = g_gldu_m.glduld
                  
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = 'FALSE'
                  LET g_qryparam.default1 = g_gldu_d[l_ac].gldu016
                                
                  LET g_qryparam.arg1 = l_glaa004
                  LET g_qryparam.arg2 = g_gldu_d[l_ac].gldu016
                  LET g_qryparam.arg3 = g_gldu_m.glduld
                  LET g_qryparam.arg4 = " 1"
                  CALL q_glac002_6()
                  LET  g_gldu_d[l_ac].gldu016 = g_qryparam.return1 
                  LET g_gldu_d[l_ac].gldu016_desc =  s_desc_get_account_desc(g_gldu_m.glduld,g_gldu_d[l_ac].gldu016)
                  DISPLAY BY NAME g_gldu_d[l_ac].gldu016,g_gldu_d[l_ac].gldu016_desc                           
               END IF
               #科目存在性，有效性，非统治科目，非子系统科目，账户科目属性检查
               IF NOT  s_aglt310_lc_subject(g_gldu_m.glduld,g_gldu_d[l_ac].gldu016,'N') THEN
                   LET g_gldu_d[l_ac].gldu016 = g_gldu_d_t.gldu016
                   LET g_gldu_d[l_ac].gldu016_desc =  s_desc_get_account_desc(g_gldu_m.glduld,g_gldu_d[l_ac].gldu016)
                   DISPLAY BY NAME g_gldu_d[l_ac].gldu016_desc,g_gldu_d[l_ac].gldu016
                   NEXT FIELD CURRENT
               END IF
               # 150916-00015#1 --end   
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_gldu_d[l_ac].gldu016 != g_gldu_d_t.gldu016 OR g_gldu_d_t.gldu016 IS NULL )) THEN #160824-00007#263 161223 By 08171 mark
               IF cl_null(g_gldu_d_o.gldu016) OR g_gldu_d[l_ac].gldu016 != g_gldu_d_o.gldu016 THEN #160824-00007#263 161223 By 08171 add
                  CALL s_merge_glac002_chk(g_glaa.glaa004,g_gldu_d[l_ac].gldu016)RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam.* TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     #160321-00016#31 --s add
                     IF g_errno = 'sub-01302' THEN
                        LET g_errparam.replace[1] = 'agli020'
                        LET g_errparam.replace[2] = cl_get_progname('agli020',g_lang,"2")
                        LET g_errparam.exeprog = 'agli020'
                     END IF
                     #160321-00016#31 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                    #LET g_gldu_d[l_ac].gldu016 = g_gldu_d_t.gldu016 #160824-00007#263 161223 By 08171 mark
                     LET g_gldu_d[l_ac].gldu016 = g_gldu_d_o.gldu016 #160824-00007#263 161223 By 08171 add
                     LET g_gldu_d[l_ac].gldu016_desc =  s_desc_get_account_desc(g_gldu_m.glduld,g_gldu_d[l_ac].gldu016)
                     DISPLAY BY NAME g_gldu_d[l_ac].gldu016_desc,g_gldu_d[l_ac].gldu016
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_gldu_d[l_ac].gldu016_desc =  s_desc_get_account_desc(g_gldu_m.glduld,g_gldu_d[l_ac].gldu016)
            DISPLAY BY NAME g_gldu_d[l_ac].gldu016,g_gldu_d[l_ac].gldu016_desc
            LET g_gldu_d_o.* = g_gldu_d[l_ac].* #160824-00007#263 161223 By 08171 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldu016
            #add-point:BEFORE FIELD gldu016 name="input.b.page1.gldu016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldu016
            #add-point:ON CHANGE gldu016 name="input.g.page1.gldu016"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldu017
            
            #add-point:AFTER FIELD gldu017 name="input.a.page1.gldu017"
            IF NOT cl_null(g_gldu_d[l_ac].gldu017) THEN
               # 开窗模糊查询 150916-00015#1 --add                      
               IF s_aglt310_getlike_lc_subject(g_gldu_m.glduld,g_gldu_d[l_ac].gldu017,"")  THEN            
                  
                  SELECT glaa004 INTO l_glaa004
                    FROM glaa_t
                   WHERE glaaent = g_enterprise
                     AND glaald  = g_gldu_m.glduld
                  
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = 'FALSE'
                  LET g_qryparam.default1 = g_gldu_d[l_ac].gldu017
                                
                  LET g_qryparam.arg1 = l_glaa004
                  LET g_qryparam.arg2 = g_gldu_d[l_ac].gldu017
                  LET g_qryparam.arg3 = g_gldu_m.glduld
                  LET g_qryparam.arg4 = " 1"
                  CALL q_glac002_6()
                  LET  g_gldu_d[l_ac].gldu017 = g_qryparam.return1 
                  LET g_gldu_d[l_ac].gldu017_desc =  s_desc_get_account_desc(g_gldu_m.glduld,g_gldu_d[l_ac].gldu017)
                  DISPLAY BY NAME g_gldu_d[l_ac].gldu017,g_gldu_d[l_ac].gldu017_desc                           
               END IF
               #科目存在性，有效性，非统治科目，非子系统科目，账户科目属性检查
               IF NOT  s_aglt310_lc_subject(g_gldu_m.glduld,g_gldu_d[l_ac].gldu017,'N') THEN
                  #LET g_gldu_d[l_ac].gldu017 = g_gldu_d_t.gldu017 #160824-00007#263 161223 By 08171 mark
                   LET g_gldu_d[l_ac].gldu017 = g_gldu_d_o.gldu017 #160824-00007#263 161223 By 08171 add
                   LET g_gldu_d[l_ac].gldu017_desc =  s_desc_get_account_desc(g_gldu_m.glduld,g_gldu_d[l_ac].gldu017)
                   DISPLAY BY NAME g_gldu_d[l_ac].gldu017_desc,g_gldu_d[l_ac].gldu017
                   NEXT FIELD CURRENT
               END IF
               # 150916-00015#1 --end               
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_gldu_d[l_ac].gldu017 != g_gldu_d_t.gldu017 OR g_gldu_d_t.gldu017 IS NULL )) THEN  #160824-00007#263 161223 By 08171 mark
               IF cl_null(g_gldu_d_o.gldu017) OR g_gldu_d[l_ac].gldu017 != g_gldu_d_o.gldu017 THEN
                  CALL s_merge_glac002_chk(g_glaa.glaa004,g_gldu_d[l_ac].gldu017)RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam.* TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     #160321-00016#31 --s add
                     IF g_errno = 'sub-01302' THEN
                        LET g_errparam.replace[1] = 'agli020'
                        LET g_errparam.replace[2] = cl_get_progname('agli020',g_lang,"2")
                        LET g_errparam.exeprog = 'agli020'
                     END IF
                     #160321-00016#31 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                    #LET g_gldu_d[l_ac].gldu017 = g_gldu_d_t.gldu017 #160824-00007#263 161223 By 08171 mark
                     LET g_gldu_d[l_ac].gldu017 = g_gldu_d_o.gldu017 #160824-00007#263 161223 By 08171 add
                     LET g_gldu_d[l_ac].gldu017_desc =  s_desc_get_account_desc(g_gldu_m.glduld,g_gldu_d[l_ac].gldu017)
                     DISPLAY BY NAME g_gldu_d[l_ac].gldu017_desc,g_gldu_d[l_ac].gldu017
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_gldu_d[l_ac].gldu017_desc =  s_desc_get_account_desc(g_gldu_m.glduld,g_gldu_d[l_ac].gldu017)
            DISPLAY BY NAME g_gldu_d[l_ac].gldu017,g_gldu_d[l_ac].gldu017_desc
            LET g_gldu_d_o.* = g_gldu_d[l_ac].*   #160824-00007#263 161223 By 08171 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldu017
            #add-point:BEFORE FIELD gldu017 name="input.b.page1.gldu017"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldu017
            #add-point:ON CHANGE gldu017 name="input.g.page1.gldu017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldu018
            #add-point:BEFORE FIELD gldu018 name="input.b.page1.gldu018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldu018
            
            #add-point:AFTER FIELD gldu018 name="input.a.page1.gldu018"
            IF NOT cl_null(g_gldu_d[l_ac].gldu018) THEN
               IF cl_null(g_gldu_d[l_ac].gldu021) THEN LET g_gldu_d[l_ac].gldu021 = 0 END IF
               CALL s_curr_round_ld('1',g_gldu_m.glduld,g_gldu_m.gldu005,g_gldu_d[l_ac].gldu018,2) RETURNING g_sub_success,g_errno,g_gldu_d[l_ac].gldu018
               LET g_gldu_d[l_ac].gldu024 = g_gldu_d[l_ac].gldu018 - g_gldu_d[l_ac].gldu021
               DISPLAY BY NAME g_gldu_d[l_ac].gldu024
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldu018
            #add-point:ON CHANGE gldu018 name="input.g.page1.gldu018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldu021
            #add-point:BEFORE FIELD gldu021 name="input.b.page1.gldu021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldu021
            
            #add-point:AFTER FIELD gldu021 name="input.a.page1.gldu021"
            IF NOT cl_null(g_gldu_d[l_ac].gldu021) THEN
               IF cl_null(g_gldu_d[l_ac].gldu018) THEN LET g_gldu_d[l_ac].gldu018 = 0 END IF
               CALL s_curr_round_ld('1',g_gldu_m.glduld,g_gldu_m.gldu005,g_gldu_d[l_ac].gldu021,2) RETURNING g_sub_success,g_errno,g_gldu_d[l_ac].gldu021
               LET g_gldu_d[l_ac].gldu024 = g_gldu_d[l_ac].gldu018 - g_gldu_d[l_ac].gldu021
               DISPLAY BY NAME g_gldu_d[l_ac].gldu024
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldu021
            #add-point:ON CHANGE gldu021 name="input.g.page1.gldu021"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.gldu010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldu010
            #add-point:ON ACTION controlp INFIELD gldu010 name="input.c.page1.gldu010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldu011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldu011
            #add-point:ON ACTION controlp INFIELD gldu011 name="input.c.page1.gldu011"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_gldu_d[l_ac].gldu011
            LET g_qryparam.where = " gldbstus = 'Y'  AND gldcld = '",g_gldu_m.glduld,"'"
            CALL q_gldc002_1()
            LET g_gldu_d[l_ac].gldu011= g_qryparam.return1
            CALL s_desc_glda001_desc(g_gldu_d[l_ac].gldu011) RETURNING g_gldu_d[l_ac].gldu011_desc
            DISPLAY BY NAME g_gldu_d[l_ac].gldu011,g_gldu_d[l_ac].gldu011_desc
            NEXT FIELD gldu011
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldu012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldu012
            #add-point:ON ACTION controlp INFIELD gldu012 name="input.c.page1.gldu012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldu013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldu013
            #add-point:ON ACTION controlp INFIELD gldu013 name="input.c.page1.gldu013"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_gldu_d[l_ac].gldu013
            LET g_qryparam.where = " gldbstus = 'Y'  AND gldcld = '",g_gldu_m.glduld,"'"
            CALL q_gldc002_1()
            LET g_gldu_d[l_ac].gldu013= g_qryparam.return1
            CALL s_desc_glda001_desc(g_gldu_d[l_ac].gldu013) RETURNING g_gldu_d[l_ac].gldu013_desc
            DISPLAY BY NAME g_gldu_d[l_ac].gldu013,g_gldu_d[l_ac].gldu013_desc
            NEXT FIELD gldu013
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldu014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldu014
            #add-point:ON ACTION controlp INFIELD gldu014 name="input.c.page1.gldu014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldu015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldu015
            #add-point:ON ACTION controlp INFIELD gldu015 name="input.c.page1.gldu015"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_gldu_d[l_ac].gldu015
            LET g_qryparam.where = "glac001 = '",g_glaa.glaa004,"' AND  glac003 <> '1' AND glac006 = '1' ",
                                   " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 AND gladld='",g_gldu_m.glduld,"' AND gladent=",g_enterprise,
                                   " AND gladstus = 'Y' )" #150916-00015#1 add
            CALL aglt310_04()
            LET g_gldu_d[l_ac].gldu015 = g_qryparam.return1
            LET g_gldu_d[l_ac].gldu015_desc =  s_desc_get_account_desc(g_gldu_m.glduld,g_gldu_d[l_ac].gldu015)
            DISPLAY BY NAME g_gldu_d[l_ac].gldu015,g_gldu_d[l_ac].gldu015_desc
            NEXT FIELD gldu015
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldu016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldu016
            #add-point:ON ACTION controlp INFIELD gldu016 name="input.c.page1.gldu016"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_gldu_d[l_ac].gldu016
            LET g_qryparam.where = "glac001 = '",g_glaa.glaa004,"' AND  glac003 <> '1' AND glac006 = '1' ",
                                   " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 AND gladld='",g_gldu_m.glduld,"' AND gladent=",g_enterprise,
                                   " AND gladstus = 'Y' )" #150916-00015#1 add
            CALL aglt310_04()
            LET g_gldu_d[l_ac].gldu016 = g_qryparam.return1
            LET g_gldu_d[l_ac].gldu016_desc =  s_desc_get_account_desc(g_gldu_m.glduld,g_gldu_d[l_ac].gldu016)
            DISPLAY BY NAME g_gldu_d[l_ac].gldu016,g_gldu_d[l_ac].gldu016_desc
            NEXT FIELD gldu016
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldu017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldu017
            #add-point:ON ACTION controlp INFIELD gldu017 name="input.c.page1.gldu017"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_gldu_d[l_ac].gldu017
            LET g_qryparam.where = "glac001 = '",g_glaa.glaa004,"' AND  glac003 <> '1' AND glac006 = '1' ",
                                   " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 AND gladld='",g_gldu_m.glduld,"' AND gladent=",g_enterprise,
                                   " AND gladstus = 'Y' )" #150916-00015#1 add
            CALL aglt310_04()
            LET g_gldu_d[l_ac].gldu017 = g_qryparam.return1
            LET g_gldu_d[l_ac].gldu017_desc =  s_desc_get_account_desc(g_gldu_m.glduld,g_gldu_d[l_ac].gldu017)
            DISPLAY BY NAME g_gldu_d[l_ac].gldu017,g_gldu_d[l_ac].gldu017_desc
            NEXT FIELD gldu017
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldu018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldu018
            #add-point:ON ACTION controlp INFIELD gldu018 name="input.c.page1.gldu018"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldu021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldu021
            #add-point:ON ACTION controlp INFIELD gldu021 name="input.c.page1.gldu021"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_gldu_d[l_ac].* = g_gldu_d_t.*
               CLOSE aglt521_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_gldu_d[l_ac].gldu009 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_gldu_d[l_ac].* = g_gldu_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               LET g_gldu2_d[l_ac].gldumodid = g_user 
LET g_gldu2_d[l_ac].gldumoddt = cl_get_current()
LET g_gldu2_d[l_ac].gldumodid_desc = cl_get_username(g_gldu2_d[l_ac].gldumodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
         
               #將遮罩欄位還原
               CALL aglt521_gldu_t_mask_restore('restore_mask_o')
         
               UPDATE gldu_t SET (glduld,gldu001,gldu002,gldu003,gldu004,gldu009,gldu010,gldu011,gldu012, 
                   gldu013,gldu014,gldu015,gldu016,gldu017,gldu018,gldu021,gldu024,gldu027,glduownid, 
                   glduowndp,glducrtid,glducrtdp,glducrtdt,gldumodid,gldumoddt,glducnfid,glducnfdt,gldu019, 
                   gldu022,gldu025,gldu028,gldu020,gldu023,gldu026,gldu029) = (g_gldu_m.glduld,g_gldu_m.gldu001, 
                   g_gldu_m.gldu002,g_gldu_m.gldu003,g_gldu_m.gldu004,g_gldu_d[l_ac].gldu009,g_gldu_d[l_ac].gldu010, 
                   g_gldu_d[l_ac].gldu011,g_gldu_d[l_ac].gldu012,g_gldu_d[l_ac].gldu013,g_gldu_d[l_ac].gldu014, 
                   g_gldu_d[l_ac].gldu015,g_gldu_d[l_ac].gldu016,g_gldu_d[l_ac].gldu017,g_gldu_d[l_ac].gldu018, 
                   g_gldu_d[l_ac].gldu021,g_gldu_d[l_ac].gldu024,g_gldu_d[l_ac].gldu027,g_gldu2_d[l_ac].glduownid, 
                   g_gldu2_d[l_ac].glduowndp,g_gldu2_d[l_ac].glducrtid,g_gldu2_d[l_ac].glducrtdp,g_gldu2_d[l_ac].glducrtdt, 
                   g_gldu2_d[l_ac].gldumodid,g_gldu2_d[l_ac].gldumoddt,g_gldu2_d[l_ac].glducnfid,g_gldu2_d[l_ac].glducnfdt, 
                   g_gldu3_d[l_ac].gldu019,g_gldu3_d[l_ac].gldu022,g_gldu3_d[l_ac].gldu025,g_gldu3_d[l_ac].gldu028, 
                   g_gldu4_d[l_ac].gldu020,g_gldu4_d[l_ac].gldu023,g_gldu4_d[l_ac].gldu026,g_gldu4_d[l_ac].gldu029) 
 
                WHERE glduent = g_enterprise AND glduld = g_gldu_m.glduld 
                 AND gldu001 = g_gldu_m.gldu001 
                 AND gldu002 = g_gldu_m.gldu002 
                 AND gldu003 = g_gldu_m.gldu003 
                 AND gldu004 = g_gldu_m.gldu004 
 
                 AND gldu009 = g_gldu_d_t.gldu009 #項次   
 
                 
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gldu_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "gldu_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gldu_m.glduld
               LET gs_keys_bak[1] = g_glduld_t
               LET gs_keys[2] = g_gldu_m.gldu001
               LET gs_keys_bak[2] = g_gldu001_t
               LET gs_keys[3] = g_gldu_m.gldu002
               LET gs_keys_bak[3] = g_gldu002_t
               LET gs_keys[4] = g_gldu_m.gldu003
               LET gs_keys_bak[4] = g_gldu003_t
               LET gs_keys[5] = g_gldu_m.gldu004
               LET gs_keys_bak[5] = g_gldu004_t
               LET gs_keys[6] = g_gldu_d[g_detail_idx].gldu009
               LET gs_keys_bak[6] = g_gldu_d_t.gldu009
               CALL aglt521_update_b('gldu_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_gldu_m),util.JSON.stringify(g_gldu_d_t)
                     LET g_log2 = util.JSON.stringify(g_gldu_m),util.JSON.stringify(g_gldu_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aglt521_gldu_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_gldu_m.glduld
               LET ls_keys[ls_keys.getLength()+1] = g_gldu_m.gldu001
               LET ls_keys[ls_keys.getLength()+1] = g_gldu_m.gldu002
               LET ls_keys[ls_keys.getLength()+1] = g_gldu_m.gldu003
               LET ls_keys[ls_keys.getLength()+1] = g_gldu_m.gldu004
 
               LET ls_keys[ls_keys.getLength()+1] = g_gldu_d_t.gldu009
 
               CALL aglt521_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE aglt521_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_gldu_d[l_ac].* = g_gldu_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE aglt521_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_gldu_d.getLength() = 0 THEN
               NEXT FIELD gldu009
            END IF
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_gldu_d[li_reproduce_target].* = g_gldu_d[li_reproduce].*
               LET g_gldu2_d[li_reproduce_target].* = g_gldu2_d[li_reproduce].*
               LET g_gldu3_d[li_reproduce_target].* = g_gldu3_d[li_reproduce].*
               LET g_gldu4_d[li_reproduce_target].* = g_gldu4_d[li_reproduce].*
 
               LET g_gldu_d[li_reproduce_target].gldu009 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_gldu_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_gldu_d.getLength()+1
            END IF
            
      END INPUT
 
      INPUT ARRAY g_gldu3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b, WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                   INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                   DELETE ROW = l_allow_delete,
                   APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
                 
         BEFORE INPUT
            
            CALL aglt521_b_fill(g_wc2) #test 
            #如果一直都在單頭則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_detail_idx)
            END IF
            LET g_loc = 'm' 
            LET g_current_page = 3
            #add-point:資料輸入前 name="input.body3.before_input"
            
            #end add-point
 
         BEFORE ROW 
            #add-point:before row name="input.body3.before_row2"
            
            #end add-point
            LET l_cmd = ''
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_ac = ARR_CURR()               #returns the current row
            IF l_ac > g_rec_b THEN              #不可超過最後一筆
               CALL fgl_set_arr_curr(g_rec_b)   #moves to a specific row         
            END IF
           
            LET l_lock_sw = 'N'                  #DEFAULT
            LET l_n = ARR_COUNT()                #the number of rows containing  
            
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aglt521_idx_chk()
            
            CALL s_transaction_begin()
            IF g_rec_b >= l_ac THEN
               LET l_cmd='u'
               CALL aglt521_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body3.before_row.set_entry_b"
               
               #end add-point
               CALL aglt521_set_no_entry_b(l_cmd)
               LET g_gldu3_d_t.* = g_gldu3_d[l_ac].*   #BACKUP  #page1
               LET g_gldu3_d_o.* = g_gldu3_d[l_ac].*   #BACKUP  #page1
            END IF 
            
 
 
 
 
    
         BEFORE INSERT
            LET g_insert = 'Y' 
            NEXT FIELD gldu009
 
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            INITIALIZE g_gldu3_d_t.* TO NULL
            INITIALIZE g_gldu3_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_gldu3_d[l_ac].* TO NULL
            #公用欄位預設值
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_gldu2_d[l_ac].glduownid = g_user
      LET g_gldu2_d[l_ac].glduowndp = g_dept
      LET g_gldu2_d[l_ac].glducrtid = g_user
      LET g_gldu2_d[l_ac].glducrtdp = g_dept 
      LET g_gldu2_d[l_ac].glducrtdt = cl_get_current()
      LET g_gldu2_d[l_ac].gldumodid = g_user
      LET g_gldu2_d[l_ac].gldumoddt = cl_get_current()
 
 
  
            #一般欄位預設值
                  LET g_gldu3_d[l_ac].gldu019 = "0"
      LET g_gldu3_d[l_ac].gldu022 = "0"
      LET g_gldu3_d[l_ac].gldu025 = "0"
      LET g_gldu3_d[l_ac].gldu028 = "0"
 
            
            #add-point:modify段before備份 name="input.body3.before_insert.before_bak"
            
            #end add-point
            LET g_gldu3_d_t.* = g_gldu3_d[l_ac].*     #新輸入資料
            LET g_gldu3_d_o.* = g_gldu3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aglt521_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body3.before_insert.set_entry_b"
            
            #end add-point
            CALL aglt521_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_gldu_d[li_reproduce_target].* = g_gldu_d[li_reproduce].*
               LET g_gldu2_d[li_reproduce_target].* = g_gldu2_d[li_reproduce].*
               LET g_gldu3_d[li_reproduce_target].* = g_gldu3_d[li_reproduce].*
               LET g_gldu4_d[li_reproduce_target].* = g_gldu4_d[li_reproduce].*
 
               LET g_gldu3_d[li_reproduce_target].gldu009 = NULL
            END IF
            
 
 
 
 
            #add-point:modify段before insert name="input.body3.before_insert"
            
            #end add-point
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   =  -263 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               IF aglt521_before_delete() THEN 
                  
 
 
 
 
  
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_gldu_m.glduld
                  LET gs_keys[gs_keys.getLength()+1] = g_gldu_m.gldu001
                  LET gs_keys[gs_keys.getLength()+1] = g_gldu_m.gldu002
                  LET gs_keys[gs_keys.getLength()+1] = g_gldu_m.gldu003
                  LET gs_keys[gs_keys.getLength()+1] = g_gldu_m.gldu004
                  LET gs_keys[gs_keys.getLength()+1] = g_gldu_d_t.gldu009
 
                  #刪除下層單身
                  IF NOT aglt521_key_delete_b(gs_keys,'gldu_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE aglt521_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE aglt521_bcl
               CALL s_transaction_end('Y','0') 
               LET l_count = g_gldu3_d.getLength()
            END IF
            
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body3.after_delete"
               
               #end add-point
                              CALL aglt521_delete_b('gldu_t',gs_keys,"'3'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_gldu3_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_gldu3_d[l_ac].* = g_gldu3_d_t.*
               CLOSE aglt521_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_gldu_d[l_ac].gldu009 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_gldu3_d[l_ac].* = g_gldu3_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               LET g_gldu2_d[l_ac].gldumodid = g_user 
LET g_gldu2_d[l_ac].gldumoddt = cl_get_current()
LET g_gldu2_d[l_ac].gldumodid_desc = cl_get_username(g_gldu2_d[l_ac].gldumodid)
                
               #add-point:單身修改前 name="modify.body3.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL aglt521_gldu_t_mask_restore('restore_mask_o')
                     
               UPDATE gldu_t SET (glduld,gldu001,gldu002,gldu003,gldu004,gldu009,gldu010,gldu011,gldu012, 
                   gldu013,gldu014,gldu015,gldu016,gldu017,gldu018,gldu021,gldu024,gldu027,glduownid, 
                   glduowndp,glducrtid,glducrtdp,glducrtdt,gldumodid,gldumoddt,glducnfid,glducnfdt,gldu019, 
                   gldu022,gldu025,gldu028,gldu020,gldu023,gldu026,gldu029) = (g_gldu_m.glduld,g_gldu_m.gldu001, 
                   g_gldu_m.gldu002,g_gldu_m.gldu003,g_gldu_m.gldu004,g_gldu_d[l_ac].gldu009,g_gldu_d[l_ac].gldu010, 
                   g_gldu_d[l_ac].gldu011,g_gldu_d[l_ac].gldu012,g_gldu_d[l_ac].gldu013,g_gldu_d[l_ac].gldu014, 
                   g_gldu_d[l_ac].gldu015,g_gldu_d[l_ac].gldu016,g_gldu_d[l_ac].gldu017,g_gldu_d[l_ac].gldu018, 
                   g_gldu_d[l_ac].gldu021,g_gldu_d[l_ac].gldu024,g_gldu_d[l_ac].gldu027,g_gldu2_d[l_ac].glduownid, 
                   g_gldu2_d[l_ac].glduowndp,g_gldu2_d[l_ac].glducrtid,g_gldu2_d[l_ac].glducrtdp,g_gldu2_d[l_ac].glducrtdt, 
                   g_gldu2_d[l_ac].gldumodid,g_gldu2_d[l_ac].gldumoddt,g_gldu2_d[l_ac].glducnfid,g_gldu2_d[l_ac].glducnfdt, 
                   g_gldu3_d[l_ac].gldu019,g_gldu3_d[l_ac].gldu022,g_gldu3_d[l_ac].gldu025,g_gldu3_d[l_ac].gldu028, 
                   g_gldu4_d[l_ac].gldu020,g_gldu4_d[l_ac].gldu023,g_gldu4_d[l_ac].gldu026,g_gldu4_d[l_ac].gldu029)  
                   #自訂欄位頁簽
                WHERE glduent = g_enterprise AND glduld = g_gldu_m.glduld
                 AND gldu001 = g_gldu_m.gldu001
                 AND gldu002 = g_gldu_m.gldu002
                 AND gldu003 = g_gldu_m.gldu003
                 AND gldu004 = g_gldu_m.gldu004
                 AND gldu009 = g_gldu3_d_t.gldu009 #項次 
               #add-point:單身修改中 name="modify.body3.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gldu_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gldu_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gldu_m.glduld
               LET gs_keys_bak[1] = g_glduld_t
               LET gs_keys[2] = g_gldu_m.gldu001
               LET gs_keys_bak[2] = g_gldu001_t
               LET gs_keys[3] = g_gldu_m.gldu002
               LET gs_keys_bak[3] = g_gldu002_t
               LET gs_keys[4] = g_gldu_m.gldu003
               LET gs_keys_bak[4] = g_gldu003_t
               LET gs_keys[5] = g_gldu_m.gldu004
               LET gs_keys_bak[5] = g_gldu004_t
               LET gs_keys[6] = g_gldu3_d[g_detail_idx].gldu009
               LET gs_keys_bak[6] = g_gldu3_d_t.gldu009
               CALL aglt521_update_b('gldu_t',gs_keys,gs_keys_bak,"'3'")
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_gldu_m),util.JSON.stringify(g_gldu3_d_t)
                     LET g_log2 = util.JSON.stringify(g_gldu_m),util.JSON.stringify(g_gldu3_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aglt521_gldu_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="modify.body3.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldu019
            #add-point:BEFORE FIELD gldu019 name="input.b.page3.gldu019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldu019
            
            #add-point:AFTER FIELD gldu019 name="input.a.page3.gldu019"
            IF NOT cl_null(g_gldu3_d[l_ac].gldu019) THEN
               IF cl_null(g_gldu3_d[l_ac].gldu022) THEN LET g_gldu3_d[l_ac].gldu022 = 0 END IF
               CALL s_curr_round_ld('1',g_gldu_m.glduld,g_gldu_m.gldu006,g_gldu3_d[l_ac].gldu019,2) RETURNING g_sub_success,g_errno,g_gldu3_d[l_ac].gldu019
               LET g_gldu3_d[l_ac].gldu025 = g_gldu3_d[l_ac].gldu019 - g_gldu3_d[l_ac].gldu022
               DISPLAY BY NAME g_gldu3_d[l_ac].gldu025
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldu019
            #add-point:ON CHANGE gldu019 name="input.g.page3.gldu019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldu022
            #add-point:BEFORE FIELD gldu022 name="input.b.page3.gldu022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldu022
            
            #add-point:AFTER FIELD gldu022 name="input.a.page3.gldu022"
            IF NOT cl_null(g_gldu3_d[l_ac].gldu022) THEN
               IF cl_null(g_gldu3_d[l_ac].gldu019) THEN LET g_gldu3_d[l_ac].gldu019 = 0 END IF
               CALL s_curr_round_ld('1',g_gldu_m.glduld,g_gldu_m.gldu006,g_gldu3_d[l_ac].gldu022,2) RETURNING g_sub_success,g_errno,g_gldu3_d[l_ac].gldu022
               LET g_gldu3_d[l_ac].gldu025 = g_gldu3_d[l_ac].gldu019 - g_gldu3_d[l_ac].gldu022
               DISPLAY BY NAME g_gldu3_d[l_ac].gldu025
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldu022
            #add-point:ON CHANGE gldu022 name="input.g.page3.gldu022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldu025
            #add-point:BEFORE FIELD gldu025 name="input.b.page3.gldu025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldu025
            
            #add-point:AFTER FIELD gldu025 name="input.a.page3.gldu025"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldu025
            #add-point:ON CHANGE gldu025 name="input.g.page3.gldu025"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldu028
            #add-point:BEFORE FIELD gldu028 name="input.b.page3.gldu028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldu028
            
            #add-point:AFTER FIELD gldu028 name="input.a.page3.gldu028"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldu028
            #add-point:ON CHANGE gldu028 name="input.g.page3.gldu028"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.gldu019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldu019
            #add-point:ON ACTION controlp INFIELD gldu019 name="input.c.page3.gldu019"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.gldu022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldu022
            #add-point:ON ACTION controlp INFIELD gldu022 name="input.c.page3.gldu022"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.gldu025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldu025
            #add-point:ON ACTION controlp INFIELD gldu025 name="input.c.page3.gldu025"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.gldu028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldu028
            #add-point:ON ACTION controlp INFIELD gldu028 name="input.c.page3.gldu028"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:input段after row name="input.body3.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_gldu3_d[l_ac].* = g_gldu3_d_t.*
               END IF
               CLOSE aglt521_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               EXIT DIALOG 
            END IF
 
            CLOSE aglt521_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #add-point:input段after input  name="input.body3.after_input"
            
            #end add-point    
 
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_gldu_d[li_reproduce_target].* = g_gldu_d[li_reproduce].*
               LET g_gldu2_d[li_reproduce_target].* = g_gldu2_d[li_reproduce].*
               LET g_gldu3_d[li_reproduce_target].* = g_gldu3_d[li_reproduce].*
               LET g_gldu4_d[li_reproduce_target].* = g_gldu4_d[li_reproduce].*
 
               LET g_gldu3_d[li_reproduce_target].gldu009 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_gldu3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_gldu3_d.getLength()+1
            END IF
      END INPUT
      INPUT ARRAY g_gldu4_d FROM s_detail4.*
         ATTRIBUTE(COUNT = g_rec_b, WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                   INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                   DELETE ROW = l_allow_delete,
                   APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
                 
         BEFORE INPUT
            
            CALL aglt521_b_fill(g_wc2) #test 
            #如果一直都在單頭則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_detail_idx)
            END IF
            LET g_loc = 'm' 
            LET g_current_page = 4
            #add-point:資料輸入前 name="input.body4.before_input"
            
            #end add-point
 
         BEFORE ROW 
            #add-point:before row name="input.body4.before_row2"
            
            #end add-point
            LET l_cmd = ''
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_ac = ARR_CURR()               #returns the current row
            IF l_ac > g_rec_b THEN              #不可超過最後一筆
               CALL fgl_set_arr_curr(g_rec_b)   #moves to a specific row         
            END IF
           
            LET l_lock_sw = 'N'                  #DEFAULT
            LET l_n = ARR_COUNT()                #the number of rows containing  
            
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aglt521_idx_chk()
            
            CALL s_transaction_begin()
            IF g_rec_b >= l_ac THEN
               LET l_cmd='u'
               CALL aglt521_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body4.before_row.set_entry_b"
               
               #end add-point
               CALL aglt521_set_no_entry_b(l_cmd)
               LET g_gldu4_d_t.* = g_gldu4_d[l_ac].*   #BACKUP  #page1
               LET g_gldu4_d_o.* = g_gldu4_d[l_ac].*   #BACKUP  #page1
            END IF 
            
 
 
 
 
    
         BEFORE INSERT
            LET g_insert = 'Y' 
            NEXT FIELD gldu009
 
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            INITIALIZE g_gldu4_d_t.* TO NULL
            INITIALIZE g_gldu4_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_gldu4_d[l_ac].* TO NULL
            #公用欄位預設值
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_gldu2_d[l_ac].glduownid = g_user
      LET g_gldu2_d[l_ac].glduowndp = g_dept
      LET g_gldu2_d[l_ac].glducrtid = g_user
      LET g_gldu2_d[l_ac].glducrtdp = g_dept 
      LET g_gldu2_d[l_ac].glducrtdt = cl_get_current()
      LET g_gldu2_d[l_ac].gldumodid = g_user
      LET g_gldu2_d[l_ac].gldumoddt = cl_get_current()
 
 
  
            #一般欄位預設值
                  LET g_gldu4_d[l_ac].gldu020 = "0"
      LET g_gldu4_d[l_ac].gldu023 = "0"
      LET g_gldu4_d[l_ac].gldu026 = "0"
      LET g_gldu4_d[l_ac].gldu029 = "0"
 
            
            #add-point:modify段before備份 name="input.body4.before_insert.before_bak"
            
            #end add-point
            LET g_gldu4_d_t.* = g_gldu4_d[l_ac].*     #新輸入資料
            LET g_gldu4_d_o.* = g_gldu4_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aglt521_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body4.before_insert.set_entry_b"
            
            #end add-point
            CALL aglt521_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_gldu_d[li_reproduce_target].* = g_gldu_d[li_reproduce].*
               LET g_gldu2_d[li_reproduce_target].* = g_gldu2_d[li_reproduce].*
               LET g_gldu3_d[li_reproduce_target].* = g_gldu3_d[li_reproduce].*
               LET g_gldu4_d[li_reproduce_target].* = g_gldu4_d[li_reproduce].*
 
               LET g_gldu4_d[li_reproduce_target].gldu009 = NULL
            END IF
            
 
 
 
 
            #add-point:modify段before insert name="input.body4.before_insert"
            
            #end add-point
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   =  -263 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               IF aglt521_before_delete() THEN 
                  
 
 
 
 
  
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_gldu_m.glduld
                  LET gs_keys[gs_keys.getLength()+1] = g_gldu_m.gldu001
                  LET gs_keys[gs_keys.getLength()+1] = g_gldu_m.gldu002
                  LET gs_keys[gs_keys.getLength()+1] = g_gldu_m.gldu003
                  LET gs_keys[gs_keys.getLength()+1] = g_gldu_m.gldu004
                  LET gs_keys[gs_keys.getLength()+1] = g_gldu_d_t.gldu009
 
                  #刪除下層單身
                  IF NOT aglt521_key_delete_b(gs_keys,'gldu_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE aglt521_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE aglt521_bcl
               CALL s_transaction_end('Y','0') 
               LET l_count = g_gldu4_d.getLength()
            END IF
            
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body4.after_delete"
               
               #end add-point
                              CALL aglt521_delete_b('gldu_t',gs_keys,"'4'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_gldu4_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_gldu4_d[l_ac].* = g_gldu4_d_t.*
               CLOSE aglt521_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_gldu_d[l_ac].gldu009 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_gldu4_d[l_ac].* = g_gldu4_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               LET g_gldu2_d[l_ac].gldumodid = g_user 
LET g_gldu2_d[l_ac].gldumoddt = cl_get_current()
LET g_gldu2_d[l_ac].gldumodid_desc = cl_get_username(g_gldu2_d[l_ac].gldumodid)
                
               #add-point:單身修改前 name="modify.body4.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL aglt521_gldu_t_mask_restore('restore_mask_o')
                     
               UPDATE gldu_t SET (glduld,gldu001,gldu002,gldu003,gldu004,gldu009,gldu010,gldu011,gldu012, 
                   gldu013,gldu014,gldu015,gldu016,gldu017,gldu018,gldu021,gldu024,gldu027,glduownid, 
                   glduowndp,glducrtid,glducrtdp,glducrtdt,gldumodid,gldumoddt,glducnfid,glducnfdt,gldu019, 
                   gldu022,gldu025,gldu028,gldu020,gldu023,gldu026,gldu029) = (g_gldu_m.glduld,g_gldu_m.gldu001, 
                   g_gldu_m.gldu002,g_gldu_m.gldu003,g_gldu_m.gldu004,g_gldu_d[l_ac].gldu009,g_gldu_d[l_ac].gldu010, 
                   g_gldu_d[l_ac].gldu011,g_gldu_d[l_ac].gldu012,g_gldu_d[l_ac].gldu013,g_gldu_d[l_ac].gldu014, 
                   g_gldu_d[l_ac].gldu015,g_gldu_d[l_ac].gldu016,g_gldu_d[l_ac].gldu017,g_gldu_d[l_ac].gldu018, 
                   g_gldu_d[l_ac].gldu021,g_gldu_d[l_ac].gldu024,g_gldu_d[l_ac].gldu027,g_gldu2_d[l_ac].glduownid, 
                   g_gldu2_d[l_ac].glduowndp,g_gldu2_d[l_ac].glducrtid,g_gldu2_d[l_ac].glducrtdp,g_gldu2_d[l_ac].glducrtdt, 
                   g_gldu2_d[l_ac].gldumodid,g_gldu2_d[l_ac].gldumoddt,g_gldu2_d[l_ac].glducnfid,g_gldu2_d[l_ac].glducnfdt, 
                   g_gldu3_d[l_ac].gldu019,g_gldu3_d[l_ac].gldu022,g_gldu3_d[l_ac].gldu025,g_gldu3_d[l_ac].gldu028, 
                   g_gldu4_d[l_ac].gldu020,g_gldu4_d[l_ac].gldu023,g_gldu4_d[l_ac].gldu026,g_gldu4_d[l_ac].gldu029)  
                   #自訂欄位頁簽
                WHERE glduent = g_enterprise AND glduld = g_gldu_m.glduld
                 AND gldu001 = g_gldu_m.gldu001
                 AND gldu002 = g_gldu_m.gldu002
                 AND gldu003 = g_gldu_m.gldu003
                 AND gldu004 = g_gldu_m.gldu004
                 AND gldu009 = g_gldu4_d_t.gldu009 #項次 
               #add-point:單身修改中 name="modify.body4.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gldu_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gldu_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gldu_m.glduld
               LET gs_keys_bak[1] = g_glduld_t
               LET gs_keys[2] = g_gldu_m.gldu001
               LET gs_keys_bak[2] = g_gldu001_t
               LET gs_keys[3] = g_gldu_m.gldu002
               LET gs_keys_bak[3] = g_gldu002_t
               LET gs_keys[4] = g_gldu_m.gldu003
               LET gs_keys_bak[4] = g_gldu003_t
               LET gs_keys[5] = g_gldu_m.gldu004
               LET gs_keys_bak[5] = g_gldu004_t
               LET gs_keys[6] = g_gldu4_d[g_detail_idx].gldu009
               LET gs_keys_bak[6] = g_gldu4_d_t.gldu009
               CALL aglt521_update_b('gldu_t',gs_keys,gs_keys_bak,"'4'")
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_gldu_m),util.JSON.stringify(g_gldu4_d_t)
                     LET g_log2 = util.JSON.stringify(g_gldu_m),util.JSON.stringify(g_gldu4_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aglt521_gldu_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="modify.body4.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldu020
            #add-point:BEFORE FIELD gldu020 name="input.b.page4.gldu020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldu020
            
            #add-point:AFTER FIELD gldu020 name="input.a.page4.gldu020"
            IF NOT cl_null(g_gldu4_d[l_ac].gldu020) THEN
               IF cl_null(g_gldu4_d[l_ac].gldu023) THEN LET g_gldu4_d[l_ac].gldu023 = 0 END IF
               CALL s_curr_round_ld('1',g_gldu_m.glduld,g_gldu_m.gldu007,g_gldu4_d[l_ac].gldu020,2) RETURNING g_sub_success,g_errno,g_gldu4_d[l_ac].gldu020
               LET g_gldu4_d[l_ac].gldu026 = g_gldu4_d[l_ac].gldu020 - g_gldu4_d[l_ac].gldu023
               DISPLAY BY NAME g_gldu4_d[l_ac].gldu026
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldu020
            #add-point:ON CHANGE gldu020 name="input.g.page4.gldu020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldu023
            #add-point:BEFORE FIELD gldu023 name="input.b.page4.gldu023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldu023
            
            #add-point:AFTER FIELD gldu023 name="input.a.page4.gldu023"
            IF NOT cl_null(g_gldu4_d[l_ac].gldu023) THEN
               IF cl_null(g_gldu4_d[l_ac].gldu020) THEN LET g_gldu4_d[l_ac].gldu020 = 0 END IF
               CALL s_curr_round_ld('1',g_gldu_m.glduld,g_gldu_m.gldu007,g_gldu4_d[l_ac].gldu023,2) RETURNING g_sub_success,g_errno,g_gldu4_d[l_ac].gldu023
               LET g_gldu4_d[l_ac].gldu026 = g_gldu4_d[l_ac].gldu020 - g_gldu4_d[l_ac].gldu023
               DISPLAY BY NAME g_gldu4_d[l_ac].gldu026
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldu023
            #add-point:ON CHANGE gldu023 name="input.g.page4.gldu023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldu026
            #add-point:BEFORE FIELD gldu026 name="input.b.page4.gldu026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldu026
            
            #add-point:AFTER FIELD gldu026 name="input.a.page4.gldu026"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldu026
            #add-point:ON CHANGE gldu026 name="input.g.page4.gldu026"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldu029
            #add-point:BEFORE FIELD gldu029 name="input.b.page4.gldu029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldu029
            
            #add-point:AFTER FIELD gldu029 name="input.a.page4.gldu029"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldu029
            #add-point:ON CHANGE gldu029 name="input.g.page4.gldu029"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page4.gldu020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldu020
            #add-point:ON ACTION controlp INFIELD gldu020 name="input.c.page4.gldu020"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.gldu023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldu023
            #add-point:ON ACTION controlp INFIELD gldu023 name="input.c.page4.gldu023"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.gldu026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldu026
            #add-point:ON ACTION controlp INFIELD gldu026 name="input.c.page4.gldu026"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.gldu029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldu029
            #add-point:ON ACTION controlp INFIELD gldu029 name="input.c.page4.gldu029"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:input段after row name="input.body4.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_gldu4_d[l_ac].* = g_gldu4_d_t.*
               END IF
               CLOSE aglt521_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               EXIT DIALOG 
            END IF
 
            CLOSE aglt521_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #add-point:input段after input  name="input.body4.after_input"
            
            #end add-point    
 
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_gldu_d[li_reproduce_target].* = g_gldu_d[li_reproduce].*
               LET g_gldu2_d[li_reproduce_target].* = g_gldu2_d[li_reproduce].*
               LET g_gldu3_d[li_reproduce_target].* = g_gldu3_d[li_reproduce].*
               LET g_gldu4_d[li_reproduce_target].* = g_gldu4_d[li_reproduce].*
 
               LET g_gldu4_d[li_reproduce_target].gldu009 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_gldu4_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_gldu4_d.getLength()+1
            END IF
      END INPUT
 
      
      DISPLAY ARRAY g_gldu2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
      
         BEFORE ROW
            CALL aglt521_b_fill(g_wc2) #test 
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_page = 2
            CALL aglt521_idx_chk()
            CALL aglt521_ui_detailshow()
        
         BEFORE DISPLAY 
            CALL FGL_SET_ARR_CURR(g_detail_idx)      
         
         #add-point:page2自定義行為 name="input.body2.action"
         
         #end add-point
         
      END DISPLAY
 
      
 
      
 
    
      #add-point:input段more_input name="input.more_inputarray"
      
      #end add-point    
      
      BEFORE DIALOG
         #CALL cl_err_collect_init()    
         #add-point:input段before_dialog name="input.before_dialog"
         
         #end add-point 
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)      
         CALL DIALOG.setCurrentRow("s_detail2",g_detail_idx)
         CALL DIALOG.setCurrentRow("s_detail3",g_detail_idx)
         CALL DIALOG.setCurrentRow("s_detail4",g_detail_idx)
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD glduld
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD gldu009
               WHEN "s_detail2"
                  NEXT FIELD gldu009_2
               WHEN "s_detail3"
                  NEXT FIELD gldu009_3
               WHEN "s_detail4"
                  NEXT FIELD gldu009_4
 
            END CASE
         END IF
   
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
         ACCEPT DIALOG
        
      ON ACTION cancel      #在dialog button (放棄)
         LET g_action_choice=""
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION close       #在dialog 右上角 (X)
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
   
   #將畫面指標同步到當下指定的位置上
   CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
   CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
   CALL g_curr_diag.setCurrentRow("s_detail4",g_detail_idx)
 
 
   
   #add-point:input段after_input name="input.after_input"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aglt521.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aglt521_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   CALL s_ld_sel_glaa(g_gldu_m.glduld,'glaa004|glaa131') RETURNING g_sub_success,g_glaa.glaa004,g_glaa.glaa131
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL aglt521_b_fill(g_wc2) #第一階單身填充
      CALL aglt521_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aglt521_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   CALL s_desc_get_ld_desc(g_gldu_m.glduld) RETURNING g_gldu_m.glduld_desc
   CALL s_desc_glda001_desc(g_gldu_m.gldu001) RETURNING g_gldu_m.gldu001_desc
   CALL s_desc_get_ld_desc(g_gldu_m.gldu002) RETURNING g_gldu_m.gldu002_desc
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_gldu_m.glduld,g_gldu_m.glduld_desc,g_gldu_m.gldu001,g_gldu_m.gldu001_desc,g_gldu_m.gldu002, 
       g_gldu_m.gldu002_desc,g_gldu_m.gldu003,g_gldu_m.gldu004,g_gldu_m.gldu008,g_gldu_m.gldu005,g_gldu_m.gldu006, 
       g_gldu_m.gldu007,g_gldu_m.gldustus
 
   CALL aglt521_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
   #根據當下狀態碼顯示圖片
   CASE g_gldu_m.gldustus
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
      WHEN "A"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
      WHEN "D"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
      WHEN "R"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
      WHEN "W"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
   END CASE
   CALL aglt521_ld_visible()
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="aglt521.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION aglt521_ref_show()
   #add-point:ref_show段define name="ref_show.define_customerization"
   
   #end add-point 
   DEFINE l_ac_t LIKE type_t.num10 #l_ac暫存用
   #add-point:ref_show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ref_show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="ref_show.pre_function"
   
   #end add-point
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:ref_show段m_reference name="ref_show.head.reference"
   
   #end add-point
 
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_gldu_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_gldu2_d.getLength()
      #add-point:ref_show段d2_reference name="ref_show.body2.reference"
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_gldu3_d.getLength()
      #add-point:ref_show段d3_reference name="ref_show.body3.reference"
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_gldu4_d.getLength()
      #add-point:ref_show段d4_reference name="ref_show.body4.reference"
      
      #end add-point
   END FOR
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="aglt521.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aglt521_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE gldu_t.glduld 
   DEFINE l_oldno     LIKE gldu_t.glduld 
   DEFINE l_newno02     LIKE gldu_t.gldu001 
   DEFINE l_oldno02     LIKE gldu_t.gldu001 
   DEFINE l_newno03     LIKE gldu_t.gldu002 
   DEFINE l_oldno03     LIKE gldu_t.gldu002 
   DEFINE l_newno04     LIKE gldu_t.gldu003 
   DEFINE l_oldno04     LIKE gldu_t.gldu003 
   DEFINE l_newno05     LIKE gldu_t.gldu004 
   DEFINE l_oldno05     LIKE gldu_t.gldu004 
 
   DEFINE l_master    RECORD LIKE gldu_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE gldu_t.* #此變數樣板目前無使用
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF     
 
   IF g_gldu_m.glduld IS NULL
      OR g_gldu_m.gldu001 IS NULL
      OR g_gldu_m.gldu002 IS NULL
      OR g_gldu_m.gldu003 IS NULL
      OR g_gldu_m.gldu004 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_glduld_t = g_gldu_m.glduld
   LET g_gldu001_t = g_gldu_m.gldu001
   LET g_gldu002_t = g_gldu_m.gldu002
   LET g_gldu003_t = g_gldu_m.gldu003
   LET g_gldu004_t = g_gldu_m.gldu004
 
   
   LET g_gldu_m.glduld = ""
   LET g_gldu_m.gldu001 = ""
   LET g_gldu_m.gldu002 = ""
   LET g_gldu_m.gldu003 = ""
   LET g_gldu_m.gldu004 = ""
 
   LET g_master_insert = FALSE
   CALL aglt521_set_entry('a')
   CALL aglt521_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_gldu_m.gldustus = 'N'
   #根據當下狀態碼顯示圖片
   CASE g_gldu_m.gldustus
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
      WHEN "A"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
      WHEN "D"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
      WHEN "R"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
      WHEN "W"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
   END CASE
   #end add-point
   
   #清空key欄位的desc
      LET g_gldu_m.glduld_desc = ''
   DISPLAY BY NAME g_gldu_m.glduld_desc
   LET g_gldu_m.gldu001_desc = ''
   DISPLAY BY NAME g_gldu_m.gldu001_desc
   LET g_gldu_m.gldu002_desc = ''
   DISPLAY BY NAME g_gldu_m.gldu002_desc
 
   
   CALL aglt521_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_gldu_m.* TO NULL
      INITIALIZE g_gldu_d TO NULL
      INITIALIZE g_gldu2_d TO NULL
      INITIALIZE g_gldu3_d TO NULL
      INITIALIZE g_gldu4_d TO NULL
 
      CALL aglt521_show()
      LET INT_FLAG = 0
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = 9001 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN 
   END IF
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL aglt521_set_act_visible()
   CALL aglt521_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_glduld_t = g_gldu_m.glduld
   LET g_gldu001_t = g_gldu_m.gldu001
   LET g_gldu002_t = g_gldu_m.gldu002
   LET g_gldu003_t = g_gldu_m.gldu003
   LET g_gldu004_t = g_gldu_m.gldu004
 
   
   #組合新增資料的條件
   LET g_add_browse = " glduent = " ||g_enterprise|| " AND",
                      " glduld = '", g_gldu_m.glduld, "' "
                      ," AND gldu001 = '", g_gldu_m.gldu001, "' "
                      ," AND gldu002 = '", g_gldu_m.gldu002, "' "
                      ," AND gldu003 = '", g_gldu_m.gldu003, "' "
                      ," AND gldu004 = '", g_gldu_m.gldu004, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aglt521_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL aglt521_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL aglt521_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="aglt521.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION aglt521_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE gldu_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aglt521_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM gldu_t
    WHERE glduent = g_enterprise AND glduld = g_glduld_t
    AND gldu001 = g_gldu001_t
    AND gldu002 = g_gldu002_t
    AND gldu003 = g_gldu003_t
    AND gldu004 = g_gldu004_t
 
       INTO TEMP aglt521_detail
   
   #將key修正為調整後   
   UPDATE aglt521_detail 
      #更新key欄位
      SET glduld = g_gldu_m.glduld
          , gldu001 = g_gldu_m.gldu001
          , gldu002 = g_gldu_m.gldu002
          , gldu003 = g_gldu_m.gldu003
          , gldu004 = g_gldu_m.gldu004
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
       , glduownid = g_user 
       , glduowndp = g_dept
       , glducrtid = g_user
       , glducrtdp = g_dept 
       , glducrtdt = ld_date
       , gldumodid = g_user
       , gldumoddt = ld_date
 
 
 
                                       
   #將資料塞回原table   
   INSERT INTO gldu_t SELECT * FROM aglt521_detail
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單身複製中1 name="detail_reproduce.body.table1.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aglt521_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_glduld_t = g_gldu_m.glduld
   LET g_gldu001_t = g_gldu_m.gldu001
   LET g_gldu002_t = g_gldu_m.gldu002
   LET g_gldu003_t = g_gldu_m.gldu003
   LET g_gldu004_t = g_gldu_m.gldu004
 
   
   DROP TABLE aglt521_detail
   
END FUNCTION
 
{</section>}
 
{<section id="aglt521.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aglt521_delete()
   #add-point:delete段define name="delete.define_customerization"
   
   #end add-point
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   #160818-00017#15  2016/08/24 By 07900 --add--s--
      #檢查是否允許此動作
      IF NOT aglt521_action_chk() THEN
        # CALL s_transaction_end('N','0')
         RETURN
      END IF
      #160818-00017#15  2016/08/24 By 07900 --add--e--
   #end add-point
   
   IF g_gldu_m.glduld IS NULL
   OR g_gldu_m.gldu001 IS NULL
   OR g_gldu_m.gldu002 IS NULL
   OR g_gldu_m.gldu003 IS NULL
   OR g_gldu_m.gldu004 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN aglt521_cl USING g_enterprise,g_gldu_m.glduld,g_gldu_m.gldu001,g_gldu_m.gldu002,g_gldu_m.gldu003,g_gldu_m.gldu004
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aglt521_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE aglt521_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aglt521_master_referesh USING g_gldu_m.glduld,g_gldu_m.gldu001,g_gldu_m.gldu002,g_gldu_m.gldu003, 
       g_gldu_m.gldu004 INTO g_gldu_m.glduld,g_gldu_m.gldu001,g_gldu_m.gldu002,g_gldu_m.gldu003,g_gldu_m.gldu004, 
       g_gldu_m.gldu008,g_gldu_m.gldu005,g_gldu_m.gldu006,g_gldu_m.gldu007,g_gldu_m.gldustus
   
   #遮罩相關處理
   LET g_gldu_m_mask_o.* =  g_gldu_m.*
   CALL aglt521_gldu_t_mask()
   LET g_gldu_m_mask_n.* =  g_gldu_m.*
   
   CALL aglt521_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aglt521_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM gldu_t WHERE glduent = g_enterprise AND glduld = g_gldu_m.glduld
                                                               AND gldu001 = g_gldu_m.gldu001
                                                               AND gldu002 = g_gldu_m.gldu002
                                                               AND gldu003 = g_gldu_m.gldu003
                                                               AND gldu004 = g_gldu_m.gldu004
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gldu_t:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
 
      
  
      #add-point:單身刪除後  name="delete.body.a_delete"
      
      #end add-point
      
 
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      #頭先不紀錄
      #IF NOT cl_log_modified_record('','') THEN 
      #   CLOSE aglt521_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_gldu_d.clear() 
      CALL g_gldu2_d.clear()       
      CALL g_gldu3_d.clear()       
      CALL g_gldu4_d.clear()       
 
     
      CALL aglt521_ui_browser_refresh()  
      #CALL aglt521_ui_headershow()  
      #CALL aglt521_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL aglt521_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL aglt521_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE aglt521_cl
 
   #功能已完成,通報訊息中心
   CALL aglt521_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="aglt521.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aglt521_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #先清空單身變數內容
   CALL g_gldu_d.clear()
   CALL g_gldu2_d.clear()
   CALL g_gldu3_d.clear()
   CALL g_gldu4_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT gldu009,gldu010,gldu011,gldu012,gldu013,gldu014,gldu015,gldu016,gldu017, 
       gldu018,gldu021,gldu024,gldu027,gldu009,glduownid,glduowndp,glducrtid,glducrtdp,glducrtdt,gldumodid, 
       gldumoddt,glducnfid,glducnfdt,gldu009,gldu019,gldu022,gldu025,gldu028,gldu009,gldu020,gldu023, 
       gldu026,gldu029,t1.ooag011 ,t2.ooefl003 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011 ,t6.ooag011 FROM gldu_t", 
          
               "",
               
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=glduownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=glduowndp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=glducrtid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=glducrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=gldumodid  ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=glducnfid  ",
 
               " WHERE glduent= ? AND glduld=? AND gldu001=? AND gldu002=? AND gldu003=? AND gldu004=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("gldu_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF aglt521_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY gldu_t.gldu009"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
         
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aglt521_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR aglt521_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_gldu_m.glduld,g_gldu_m.gldu001,g_gldu_m.gldu002,g_gldu_m.gldu003,g_gldu_m.gldu004   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_gldu_m.glduld,g_gldu_m.gldu001,g_gldu_m.gldu002,g_gldu_m.gldu003, 
          g_gldu_m.gldu004 INTO g_gldu_d[l_ac].gldu009,g_gldu_d[l_ac].gldu010,g_gldu_d[l_ac].gldu011, 
          g_gldu_d[l_ac].gldu012,g_gldu_d[l_ac].gldu013,g_gldu_d[l_ac].gldu014,g_gldu_d[l_ac].gldu015, 
          g_gldu_d[l_ac].gldu016,g_gldu_d[l_ac].gldu017,g_gldu_d[l_ac].gldu018,g_gldu_d[l_ac].gldu021, 
          g_gldu_d[l_ac].gldu024,g_gldu_d[l_ac].gldu027,g_gldu2_d[l_ac].gldu009,g_gldu2_d[l_ac].glduownid, 
          g_gldu2_d[l_ac].glduowndp,g_gldu2_d[l_ac].glducrtid,g_gldu2_d[l_ac].glducrtdp,g_gldu2_d[l_ac].glducrtdt, 
          g_gldu2_d[l_ac].gldumodid,g_gldu2_d[l_ac].gldumoddt,g_gldu2_d[l_ac].glducnfid,g_gldu2_d[l_ac].glducnfdt, 
          g_gldu3_d[l_ac].gldu009,g_gldu3_d[l_ac].gldu019,g_gldu3_d[l_ac].gldu022,g_gldu3_d[l_ac].gldu025, 
          g_gldu3_d[l_ac].gldu028,g_gldu4_d[l_ac].gldu009,g_gldu4_d[l_ac].gldu020,g_gldu4_d[l_ac].gldu023, 
          g_gldu4_d[l_ac].gldu026,g_gldu4_d[l_ac].gldu029,g_gldu2_d[l_ac].glduownid_desc,g_gldu2_d[l_ac].glduowndp_desc, 
          g_gldu2_d[l_ac].glducrtid_desc,g_gldu2_d[l_ac].glducrtdp_desc,g_gldu2_d[l_ac].gldumodid_desc, 
          g_gldu2_d[l_ac].glducnfid_desc   #(ver:49)
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充 name="b_fill.fill"
         LET g_gldu_d[l_ac].gldu011_desc = s_desc_glda001_desc(g_gldu_d[l_ac].gldu011)
         LET g_gldu_d[l_ac].gldu013_desc = s_desc_glda001_desc(g_gldu_d[l_ac].gldu013)
         LET g_gldu_d[l_ac].gldu015_desc = s_desc_get_account_desc(g_gldu_m.glduld,g_gldu_d[l_ac].gldu015)
         LET g_gldu_d[l_ac].gldu016_desc = s_desc_get_account_desc(g_gldu_m.glduld,g_gldu_d[l_ac].gldu016)
         LET g_gldu_d[l_ac].gldu017_desc = s_desc_get_account_desc(g_gldu_m.glduld,g_gldu_d[l_ac].gldu017)
         
         #頁籤二-功能幣
         LET g_gldu3_d[l_ac].gldu0102 = g_gldu_d[l_ac].gldu010
         LET g_gldu3_d[l_ac].gldu0112 = g_gldu_d[l_ac].gldu011
         LET g_gldu3_d[l_ac].gldu0112_desc = g_gldu_d[l_ac].gldu011_desc
         LET g_gldu3_d[l_ac].gldu0122 = g_gldu_d[l_ac].gldu012
         LET g_gldu3_d[l_ac].gldu0132 = g_gldu_d[l_ac].gldu013
         LET g_gldu3_d[l_ac].gldu0132_desc = g_gldu_d[l_ac].gldu013_desc
         LET g_gldu3_d[l_ac].gldu0142 = g_gldu_d[l_ac].gldu014
         LET g_gldu3_d[l_ac].gldu0152 = g_gldu_d[l_ac].gldu015
         LET g_gldu3_d[l_ac].gldu0162 = g_gldu_d[l_ac].gldu016
         LET g_gldu3_d[l_ac].gldu0172 = g_gldu_d[l_ac].gldu017
         LET g_gldu3_d[l_ac].gldu0152_desc = g_gldu_d[l_ac].gldu015_desc
         LET g_gldu3_d[l_ac].gldu0162_desc = g_gldu_d[l_ac].gldu016_desc
         LET g_gldu3_d[l_ac].gldu0172_desc = g_gldu_d[l_ac].gldu017_desc
         #頁籤三-報告幣
         LET g_gldu4_d[l_ac].gldu0103 = g_gldu_d[l_ac].gldu010
         LET g_gldu4_d[l_ac].gldu0113 = g_gldu_d[l_ac].gldu011
         LET g_gldu4_d[l_ac].gldu0113_desc = g_gldu_d[l_ac].gldu011_desc
         LET g_gldu4_d[l_ac].gldu0123 = g_gldu_d[l_ac].gldu012
         LET g_gldu4_d[l_ac].gldu0133 = g_gldu_d[l_ac].gldu013
         LET g_gldu4_d[l_ac].gldu0133_desc = g_gldu_d[l_ac].gldu013_desc
         LET g_gldu4_d[l_ac].gldu0143 = g_gldu_d[l_ac].gldu014
         LET g_gldu4_d[l_ac].gldu0153 = g_gldu_d[l_ac].gldu015
         LET g_gldu4_d[l_ac].gldu0163 = g_gldu_d[l_ac].gldu016
         LET g_gldu4_d[l_ac].gldu0173 = g_gldu_d[l_ac].gldu017
         LET g_gldu4_d[l_ac].gldu0153_desc = g_gldu_d[l_ac].gldu015_desc
         LET g_gldu4_d[l_ac].gldu0163_desc = g_gldu_d[l_ac].gldu016_desc
         LET g_gldu4_d[l_ac].gldu0173_desc = g_gldu_d[l_ac].gldu017_desc
         #end add-point
      
         #帶出公用欄位reference值
         
         
         #應用 a12 樣板自動產生(Version:4)
 
 
 
         
         
 
        
         #add-point:單身資料抓取 name="bfill.foreach"
         
         #end add-point
      
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
      
         LET l_ac = l_ac + 1
         
      END FOREACH
 
            CALL g_gldu_d.deleteElement(g_gldu_d.getLength())
      CALL g_gldu2_d.deleteElement(g_gldu2_d.getLength())
      CALL g_gldu3_d.deleteElement(g_gldu3_d.getLength())
      CALL g_gldu4_d.deleteElement(g_gldu4_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
   
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_gldu_d.getLength()
      LET g_gldu_d_mask_o[l_ac].* =  g_gldu_d[l_ac].*
      CALL aglt521_gldu_t_mask()
      LET g_gldu_d_mask_n[l_ac].* =  g_gldu_d[l_ac].*
   END FOR
   
   LET g_gldu2_d_mask_o.* =  g_gldu2_d.*
   FOR l_ac = 1 TO g_gldu2_d.getLength()
      LET g_gldu2_d_mask_o[l_ac].* =  g_gldu2_d[l_ac].*
      CALL aglt521_gldu_t_mask()
      LET g_gldu2_d_mask_n[l_ac].* =  g_gldu2_d[l_ac].*
   END FOR
   LET g_gldu3_d_mask_o.* =  g_gldu3_d.*
   FOR l_ac = 1 TO g_gldu3_d.getLength()
      LET g_gldu3_d_mask_o[l_ac].* =  g_gldu3_d[l_ac].*
      CALL aglt521_gldu_t_mask()
      LET g_gldu3_d_mask_n[l_ac].* =  g_gldu3_d[l_ac].*
   END FOR
   LET g_gldu4_d_mask_o.* =  g_gldu4_d.*
   FOR l_ac = 1 TO g_gldu4_d.getLength()
      LET g_gldu4_d_mask_o[l_ac].* =  g_gldu4_d[l_ac].*
      CALL aglt521_gldu_t_mask()
      LET g_gldu4_d_mask_n[l_ac].* =  g_gldu4_d[l_ac].*
   END FOR
 
 
   FREE aglt521_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="aglt521.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION aglt521_idx_chk()
   #add-point:idx_chk段define name="idx_chk.define_customerization"
   
   #end add-point
   #add-point:idx_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   #判定目前選擇的頁面
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      #確保當下指標的位置未超過上限
      IF g_detail_idx > g_gldu_d.getLength() THEN
         LET g_detail_idx = g_gldu_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_gldu_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_gldu_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_gldu2_d.getLength() THEN
         LET g_detail_idx = g_gldu2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_gldu2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_gldu2_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_gldu3_d.getLength() THEN
         LET g_detail_idx = g_gldu3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_gldu3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_gldu3_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
   END IF
   IF g_current_page = 4 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail4")
      IF g_detail_idx > g_gldu4_d.getLength() THEN
         LET g_detail_idx = g_gldu4_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_gldu4_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_gldu4_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail4",g_detail_idx)
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aglt521.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aglt521_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_gldu_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="aglt521.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION aglt521_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   
   #end add-point
   
   DELETE FROM gldu_t
    WHERE glduent = g_enterprise AND glduld = g_gldu_m.glduld AND
                              gldu001 = g_gldu_m.gldu001 AND
                              gldu002 = g_gldu_m.gldu002 AND
                              gldu003 = g_gldu_m.gldu003 AND
                              gldu004 = g_gldu_m.gldu004 AND
 
          gldu009 = g_gldu_d_t.gldu009
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "gldu_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN FALSE 
   END IF
   
   #add-point:單筆刪除後 name="delete.body.a_single_delete"
   
   #end add-point
 
   LET g_rec_b = g_rec_b-1
   DISPLAY g_rec_b TO FORMONLY.cnt
 
   RETURN TRUE
    
END FUNCTION
 
{</section>}
 
{<section id="aglt521.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aglt521_delete_b(ps_table,ps_keys_bak,ps_page)
   #add-point:delete_b段define name="delete_b.define_customerization"
   
   #end add-point
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:delete_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="delete_b.pre_function"
   
   #end add-point
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="aglt521.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aglt521_insert_b(ps_table,ps_keys,ps_page)
   #add-point:insert_b段define name="insert_b.define_customerization"
   
   #end add-point
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   #add-point:insert_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="insert_b.pre_function"
   
   #end add-point
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="aglt521.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aglt521_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   #add-point:update_b段define name="update_b.define_customerization"
   
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
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="update_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="update_b.pre_function"
   
   #end add-point
   
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
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="aglt521.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION aglt521_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_gldu_d[l_ac].gldu009 = g_gldu_d_t.gldu009 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="aglt521.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION aglt521_key_delete_b(ps_keys_bak,ps_table)
   #add-point:delete_b段define(客製用) name="key_delete_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_table    STRING
   #add-point:delete_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_delete_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_delete_b.pre_function"
   
   #end add-point
   
 
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aglt521.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aglt521_lock_b(ps_table,ps_page)
   #add-point:lock_b段define name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL aglt521_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aglt521.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aglt521_unlock_b(ps_table,ps_page)
   #add-point:unlock_b段define name="unlock_b.define_customerization"
   
   #end add-point
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
   
 
 
END FUNCTION
 
{</section>}
 
{<section id="aglt521.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aglt521_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("glduld,gldu001,gldu002,gldu003,gldu004",TRUE)
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
 
{<section id="aglt521.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aglt521_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("glduld,gldu001,gldu002,gldu003,gldu004",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aglt521.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aglt521_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aglt521.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aglt521_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="aglt521.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aglt521_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   CALL cl_set_act_visible("modify,delete,modify_detail", TRUE)
   CALL cl_set_act_visible("aglt521_01,open_aglt502_01", TRUE)
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aglt521.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aglt521_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   IF cl_null(g_gldu_m.glduld) OR g_gldu_m.gldustus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   IF cl_null(g_gldu_m.glduld) THEN
      CALL cl_set_act_visible("aglt521_01,open_aglt502_01", FALSE)
   END IF
   IF g_gldu_m.gldustus <> 'N' THEN
      CALL cl_set_act_visible("aglt521_01", FALSE)
   END IF
   IF g_gldu_m.gldu008 IS NOT NULL OR g_gldu_m.gldustus = 'N' THEN
      CALL cl_set_act_visible("open_aglt502_01", FALSE)
   END IF
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aglt521.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION aglt521_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aglt521.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION aglt521_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aglt521.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aglt521_default_search()
   #add-point:default_search段define name="default_search.define_customerization"
   
   #end add-point    
   DEFINE li_idx  LIKE type_t.num10
   DEFINE li_cnt  LIKE type_t.num10
   DEFINE ls_wc   STRING
   #add-point:default_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="default_search.pre_function"
   
   #end add-point
   
   LET g_pagestart = 1
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point  
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " glduld = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " gldu001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " gldu002 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " gldu003 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET ls_wc = ls_wc, " gldu004 = '", g_argv[05], "' AND "
   END IF
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   
   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_default = TRUE
   ELSE
      LET g_default = FALSE
      #預設查詢條件
      LET g_wc = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc) THEN
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
 
{<section id="aglt521.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION aglt521_fill_chk(ps_idx)
   #add-point:fill_chk段define name="fill_chk.define_customerization"
   
   #end add-point
   DEFINE ps_idx        LIKE type_t.chr10
   DEFINE lst_token     base.StringTokenizer
   DEFINE ls_token      STRING
   #add-point:fill_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fill_chk.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="fill_chk.pre_function"
   
   #end add-point
   
   #此funtion功能暫時停用(2015/1/12)
   #無論傳入值為何皆回傳true(代表要填充該單身)
   
   #add-point:fill_chk段other name="fill_chk.other"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aglt521.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION aglt521_modify_detail_chk(ps_record)
   #add-point:modify_detail_chk段define name="modify_detail_chk.define_customerization"
   
   #end add-point
   DEFINE ps_record STRING
   DEFINE ls_return STRING
   #add-point:modify_detail_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify_detail_chk.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="modify_detail_chk.before"
   
   #end add-point
   
   CASE ps_record
      WHEN "s_detail1" 
         LET ls_return = "gldu009"
      WHEN "s_detail2"
         LET ls_return = "gldu009_2"
      WHEN "s_detail3"
         LET ls_return = "gldu009_3"
      WHEN "s_detail4"
         LET ls_return = "gldu009_4"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="aglt521.mask_functions" >}
&include "erp/agl/aglt521_mask.4gl"
 
{</section>}
 
{<section id="aglt521.state_change" >}
    
 
{</section>}
 
{<section id="aglt521.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aglt521_set_pk_array()
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
   LET g_pk_array[1].values = g_gldu_m.glduld
   LET g_pk_array[1].column = 'glduld'
   LET g_pk_array[2].values = g_gldu_m.gldu001
   LET g_pk_array[2].column = 'gldu001'
   LET g_pk_array[3].values = g_gldu_m.gldu002
   LET g_pk_array[3].column = 'gldu002'
   LET g_pk_array[4].values = g_gldu_m.gldu003
   LET g_pk_array[4].column = 'gldu003'
   LET g_pk_array[5].values = g_gldu_m.gldu004
   LET g_pk_array[5].column = 'gldu004'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aglt521.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aglt521_msgcentre_notify(lc_state)
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
   CALL aglt521_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_gldu_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aglt521.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 依帳套設定隱顯其他本位幣頁籤
# Memo...........:
# Usage..........: CALL aglt521_ld_visible()
# Date & Author..: 2015/11/19 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aglt521_ld_visible()
DEFINE l_glaa RECORD
                 glaa001 LIKE glaa_t.glaa001,
                 glaa015 LIKE glaa_t.glaa015,
                 glaa016 LIKE glaa_t.glaa016,
                 glaa019 LIKE glaa_t.glaa019,
                 glaa020 LIKE glaa_t.glaa020
              END RECORD
   
   IF cl_null(g_gldu_m.glduld)THEN RETURN END IF
   
   INITIALIZE l_glaa.* TO NULL
   SELECT glaa001,glaa015,glaa016,glaa019,glaa020 INTO l_glaa.*
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_gldu_m.glduld
   
   CALL cl_set_comp_visible('gldu006,page_3',TRUE)
   CALL cl_set_comp_visible('gldu007,page_4',TRUE)
   LET g_gldu_m.gldu005 = l_glaa.glaa001
   DISPLAY BY NAME g_gldu_m.gldu005
   #功能幣
   IF l_glaa.glaa015 = 'N' THEN
      CALL cl_set_comp_visible('gldu006,page_3',FALSE)
   ELSE
      LET g_gldu_m.gldu006 = l_glaa.glaa016
      DISPLAY BY NAME g_gldu_m.gldu006
   END IF
   #記帳幣
   IF l_glaa.glaa019 = 'N' THEN
      CALL cl_set_comp_visible('gldu007,page_4',FALSE)
   ELSE
      LET g_gldu_m.gldu007 = l_glaa.glaa020
      DISPLAY BY NAME g_gldu_m.gldu007
   END IF
END FUNCTION

################################################################################
# Descriptions...: 狀態變更
# Memo...........:
# Usage..........: CALL aglt521_statechange()
# Date & Author..: 2015/11/25 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aglt521_statechange()
   #add-point:statechange段define(客製用)

   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)

   #end add-point  
   
   #add-point:Function前置處理

   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_gldu_m.glduld IS NULL
   OR g_gldu_m.gldu001 IS NULL
   OR g_gldu_m.gldu002 IS NULL
   OR g_gldu_m.gldu003 IS NULL
   OR g_gldu_m.gldu004 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN aglt521_cl USING g_enterprise,g_gldu_m.glduld,g_gldu_m.gldu001,g_gldu_m.gldu002,g_gldu_m.gldu003,g_gldu_m.gldu004
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aglt521_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CLOSE aglt521_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE aglt521_master_referesh USING g_gldu_m.glduld,g_gldu_m.gldu001,g_gldu_m.gldu002,g_gldu_m.gldu003, 
       g_gldu_m.gldu004 INTO g_gldu_m.glduld,g_gldu_m.gldu001,g_gldu_m.gldu002,g_gldu_m.gldu003,g_gldu_m.gldu004, 
       g_gldu_m.gldu008,g_gldu_m.gldu005,g_gldu_m.gldu006,g_gldu_m.gldu007,g_gldu_m.gldustus
 
   #檢查是否允許此動作
   IF NOT aglt521_action_chk() THEN
      CLOSE aglt521_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_gldu_m.glduld,g_gldu_m.glduld_desc,g_gldu_m.gldu001,g_gldu_m.gldu001_desc,g_gldu_m.gldu002, 
       g_gldu_m.gldu002_desc,g_gldu_m.gldu003,g_gldu_m.gldu004,g_gldu_m.gldu008,g_gldu_m.gldu005,g_gldu_m.gldu006, 
       g_gldu_m.gldu007,g_gldu_m.gldustus
 
   CASE g_gldu_m.gldustus
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
      WHEN "A"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
      WHEN "D"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
      WHEN "R"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
      WHEN "W"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
   END CASE
   
   #add-point:資料刷新後

   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_gldu_m.gldustus
            
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "X"
               HIDE OPTION "invalid"
            WHEN "A"
               HIDE OPTION "approved"
            WHEN "D"
               HIDE OPTION "withdraw"
            WHEN "R"
               HIDE OPTION "rejection"
            WHEN "W"
               HIDE OPTION "signing"
            WHEN "N"
               HIDE OPTION "unconfirmed"
         END CASE
     
      #add-point:menu前
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
      CALL cl_set_act_visible("closed",FALSE)
     
      CASE g_gldu_m.gldustus
         WHEN "N"
            CALL cl_set_act_visible("unconfirmed,invalid,hold",FALSE)
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
      
      #應用 a36 樣板自動產生(Version:4)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT aglt521_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aglt521_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT aglt521_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aglt521_cl
            RETURN
         END IF
 
 
	  
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制

            #end add-point
         END IF
         EXIT MENU
      ON ACTION invalid
         IF cl_auth_chk_act("invalid") THEN
            LET lc_state = "X"
            #add-point:action控制

            #end add-point
         END IF
         EXIT MENU
      ON ACTION approved
         IF cl_auth_chk_act("approved") THEN
            LET lc_state = "A"
            #add-point:action控制

            #end add-point
         END IF
         EXIT MENU
      #ON ACTION withdraw
      #   IF cl_auth_chk_act("withdraw") THEN
      #      LET lc_state = "D"
      #      #add-point:action控制

      #      #end add-point
      #   END IF
      #   EXIT MENU
      ON ACTION rejection
         IF cl_auth_chk_act("rejection") THEN
            LET lc_state = "R"
            #add-point:action控制

            #end add-point
         END IF
         EXIT MENU
      #ON ACTION signing
      #   IF cl_auth_chk_act("signing") THEN
      #      LET lc_state = "W"
      #      #add-point:action控制

      #      #end add-point
      #   END IF
      #   EXIT MENU
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制

            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制

      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "Y" 
      AND lc_state <> "X"
      AND lc_state <> "A"
      AND lc_state <> "D"
      AND lc_state <> "R"
      AND lc_state <> "W"
      AND lc_state <> "N"
      ) OR 
      g_gldu_m.gldustus = lc_state OR cl_null(lc_state) THEN
      CLOSE aglt521_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前
   #確認
   IF lc_state = 'Y' THEN
      IF g_gldu_m.gldustus = 'N' THEN
         CALL cl_err_collect_init()
         CALL s_aglt521_conf_chk(g_gldu_m.glduld,g_gldu_m.gldu001,g_gldu_m.gldu002,g_gldu_m.gldu003,g_gldu_m.gldu004) RETURNING g_sub_success
         IF NOT g_sub_success THEN
            CALL s_transaction_end('N','0')
            CALL cl_err_collect_show()
            RETURN
         ELSE
            IF NOT cl_ask_confirm('aim-00108') THEN   #是否執行確認？
               CALL s_transaction_end('N','0')        #150401-00001#13
               CALL cl_err_collect_show()
               RETURN
            ELSE
               CALL s_transaction_begin()
               CALL s_aglt521_conf_upd(g_gldu_m.glduld,g_gldu_m.gldu001,g_gldu_m.gldu002,g_gldu_m.gldu003,g_gldu_m.gldu004) RETURNING g_sub_success
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
      CALL s_aglt521_unconf_chk(g_gldu_m.glduld,g_gldu_m.gldu001,g_gldu_m.gldu002,g_gldu_m.gldu003,g_gldu_m.gldu004) RETURNING g_sub_success
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
            CALL s_aglt521_unconf_upd(g_gldu_m.glduld,g_gldu_m.gldu001,g_gldu_m.gldu002,g_gldu_m.gldu003,g_gldu_m.gldu004) RETURNING g_sub_success
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
   
   LET g_gldu2_d[l_ac].gldumodid = g_user
   LET g_gldu2_d[l_ac].gldumoddt = cl_get_current()
   LET g_gldu_m.gldustus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE gldu_t 
      SET (gldustus,gldumodid,gldumoddt) 
        = (g_gldu_m.gldustus,g_gldu2_d[l_ac].gldumodid,g_gldu2_d[l_ac].gldumoddt)     
    WHERE glduent = g_enterprise AND glduld = g_gldu_m.glduld
      AND gldu001 = g_gldu_m.gldu001 AND gldu002 = g_gldu_m.gldu002
      AND gldu003 = g_gldu_m.gldu003 AND gldu004 = g_gldu_m.gldu004
 
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE aglt521_master_referesh USING g_gldu_m.glduld,g_gldu_m.gldu001,g_gldu_m.gldu002,g_gldu_m.gldu003, 
          g_gldu_m.gldu004 INTO g_gldu_m.glduld,g_gldu_m.gldu001,g_gldu_m.gldu002,g_gldu_m.gldu003,g_gldu_m.gldu004, 
          g_gldu_m.gldu008,g_gldu_m.gldu005,g_gldu_m.gldu006,g_gldu_m.gldu007,g_gldu_m.gldustus

      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_gldu_m.glduld,g_gldu_m.glduld_desc,g_gldu_m.gldu001,g_gldu_m.gldu001_desc,g_gldu_m.gldu002, 
          g_gldu_m.gldu002_desc,g_gldu_m.gldu003,g_gldu_m.gldu004,g_gldu_m.gldu008,g_gldu_m.gldu005,g_gldu_m.gldu006, 
          g_gldu_m.gldu007,g_gldu_m.gldustus
   END IF
 
   #add-point:stus修改後

   #end add-point
 
   #add-point:statechange段結束前

   #end add-point  
 
   CLOSE aglt521_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aglt521_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION

#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aglt521_action_chk()
   #add-point:action_chk段define(客製用)

   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)

   #end add-point
   
   #add-point:action_chk段action_chk
   #160818-00017#15  2016/08/24 By 07900 --add--s--
   SELECT gldustus INTO g_gldu_m.gldustus
     FROM gldu_t
    WHERE glduent = g_enterprise
      AND gldu001 = g_gldu_m.gldu001
      AND gldu002 = g_gldu_m.gldu002
      AND gldu003 = g_gldu_m.gldu003
      AND gldu004 = g_gldu_m.gldu004
      AND glduld = g_gldu_m.glduld

   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_gldu_m.gldustus
       
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
        LET g_errparam.extend = g_gldu_m.gldu001
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL aglt521_set_act_visible()
        CALL aglt521_set_act_no_visible()
        CALL aglt521_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#15  2016/08/24 By 07900 --add--e--
   #end add-point
      
   RETURN TRUE
   
END FUNCTION

#+ BPM提交
PRIVATE FUNCTION aglt521_send()
   #add-point:send段define(客製用)

   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)

   #end add-point 
   
   #add-point:Function前置處理 

   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL aglt521_show()
   CALL aglt521_set_pk_array()
   
   #add-point: 初始化的ADP
   #IF NOT s_aglt521_unconf_chk(g_fmmu_m.fmmudocno) THEN
   #   CLOSE aglt521_cl
   #   CALL s_transaction_end('N','0')
   #   RETURN FALSE
   #END IF
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_gldu_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_gldu_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_gldu2_d))
   CALL cl_bpm_set_detail_data("s_detail3", util.JSONArray.fromFGL(g_gldu3_d))
   CALL cl_bpm_set_detail_data("s_detail4", util.JSONArray.fromFGL(g_gldu4_d))
 
 
   # cl_bpm_cli() 裡有包含以前的aws_condition()=>送簽資料檢核和更新單據狀況碼為'W'
   # cl_bpm_cli() 傳入參數:無  ;  回傳值: 0 開單失敗; 1 開單成功
 
   #add-point: 提交前的ADP

   #end add-point
 
   #開單失敗
   IF NOT cl_bpm_cli() THEN 
      RETURN FALSE
   END IF
 
   #add-point: 提交後的ADP

   #end add-point
 
   #此段落不需要刪除資料,但是否需要refresh圖片樣式???
   #CALL afmt565_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL aglt521_ui_headershow()
   CALL aglt521_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION

#+ BPM抽單
PRIVATE FUNCTION aglt521_draw_out()
   #add-point:draw段define

   #end add-point
   #add-point:draw段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)

   #end add-point
   
   #add-point:Function前置處理 

   #end add-point
   
   #抽單失敗
   IF NOT cl_bpm_draw_out() THEN 
      RETURN FALSE
   END IF    
          
   #重新指定此筆單據資料狀態圖片=>抽單
   LET g_browser[g_current_row].b_statepic = "stus/16/draw_out.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL aglt521_ui_headershow()  
   CALL aglt521_ui_detailshow()
 
   #add-point:Function後置處理 

   #end add-point
 
   RETURN TRUE
   
END FUNCTION

 
{</section>}
 
