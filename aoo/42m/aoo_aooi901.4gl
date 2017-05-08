#該程式未解開Section, 採用最新樣板產出!
{<section id="aooi901.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0016(2016-07-02 17:34:55), PR版次:0016(2017-01-20 18:19:34)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000373
#+ Filename...: aooi901
#+ Description: 款別依據點設定作業
#+ Creator....: 02003(2014-09-15 17:27:58)
#+ Modifier...: 07142 -SD/PR- 05423
 
{</section>}
 
{<section id="aooi901.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#140930-00020#17  2015/06/17  By Reanna   新增對應銀行帳戶欄位
#160318-00005#33  2016/03/27  By 07900    重复错误信息修改
#160318-00025#26  2016/04/28  BY 07900    校验代码重复错误讯息的修改
#160509-00004#2   2016/05/09  By 02114    新增ooie034,ooie035,ooie036三个栏位
#160509-00004#42  2016/06/06  By 02114    新增ooie040栏位
#160509-00004#94  2016/06/29  By 02114    手续费部门筛选法人
#160905-00007#9   2016/09/05  By 01531    调整系统中无ENT的SQL条件增加ent
#161019-00017#1   2016/10/20  By lixh     组织类型调整 q_ooef001 => q_ooef001_1
#161019-00017#9   2016/10/19  By zhujing  据点组织开窗资料整批调整 q_ooef001_14-->q_ooef001_1
#161124-00048#13  2016/12/14  By 08734    星号整批调整
#170120-00054#1   2017/01/20  By zhujing  调整系统中无ENT的SQL条件增加ent
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
PRIVATE type type_g_ooie_m        RECORD
       ooiesite LIKE ooie_t.ooiesite, 
   ooiesite_desc LIKE type_t.chr80, 
   rtaa001 LIKE type_t.chr10, 
   rtaa001_desc LIKE type_t.chr80
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_ooie_d        RECORD
       ooiestus LIKE ooie_t.ooiestus, 
   ooie001 LIKE ooie_t.ooie001, 
   ooie001_desc LIKE type_t.chr500, 
   ooia002 LIKE type_t.chr10, 
   ooie002 LIKE ooie_t.ooie002, 
   ooie002_desc LIKE type_t.chr500, 
   ooie031 LIKE ooie_t.ooie031, 
   ooie037 LIKE ooie_t.ooie037, 
   ooie038 LIKE ooie_t.ooie038, 
   ooie003 LIKE ooie_t.ooie003, 
   ooie004 LIKE ooie_t.ooie004, 
   ooie005 LIKE ooie_t.ooie005, 
   ooie006 LIKE ooie_t.ooie006, 
   ooie007 LIKE ooie_t.ooie007, 
   ooie008 LIKE ooie_t.ooie008, 
   ooiestamp DATETIME YEAR TO FRACTION(5), 
   ooie030 LIKE ooie_t.ooie030, 
   ooie030_desc LIKE type_t.chr500, 
   ooie032 LIKE ooie_t.ooie032, 
   ooie033 LIKE ooie_t.ooie033, 
   ooie034 LIKE ooie_t.ooie034, 
   ooie035 LIKE ooie_t.ooie035, 
   ooie036 LIKE ooie_t.ooie036, 
   ooie036_desc LIKE type_t.chr500, 
   ooie040 LIKE ooie_t.ooie040, 
   ooie040_desc LIKE type_t.chr500, 
   ooie039 LIKE ooie_t.ooie039
       END RECORD
PRIVATE TYPE type_g_ooie2_d RECORD
       ooie001 LIKE ooie_t.ooie001, 
   ooieownid LIKE ooie_t.ooieownid, 
   ooieownid_desc LIKE type_t.chr500, 
   ooieowndp LIKE ooie_t.ooieowndp, 
   ooieowndp_desc LIKE type_t.chr500, 
   ooiecrtid LIKE ooie_t.ooiecrtid, 
   ooiecrtid_desc LIKE type_t.chr500, 
   ooiecrtdp LIKE ooie_t.ooiecrtdp, 
   ooiecrtdp_desc LIKE type_t.chr500, 
   ooiecrtdt DATETIME YEAR TO SECOND, 
   ooiemodid LIKE ooie_t.ooiemodid, 
   ooiemodid_desc LIKE type_t.chr500, 
   ooiemoddt DATETIME YEAR TO SECOND
       END RECORD
PRIVATE TYPE type_g_ooie3_d RECORD
       ooie001 LIKE ooie_t.ooie001, 
   ooie001_1_desc LIKE type_t.chr500, 
   ooie009 LIKE ooie_t.ooie009, 
   ooie010 LIKE type_t.chr500, 
   ooie011 LIKE type_t.chr500, 
   ooie012 LIKE ooie_t.ooie012, 
   ooie013 LIKE ooie_t.ooie013, 
   ooie014 LIKE ooie_t.ooie014, 
   ooie015 LIKE ooie_t.ooie015, 
   ooie016 LIKE ooie_t.ooie016, 
   ooie017 LIKE ooie_t.ooie017, 
   ooie018 LIKE ooie_t.ooie018, 
   ooie019 LIKE ooie_t.ooie019, 
   ooie020 LIKE ooie_t.ooie020, 
   ooie021 LIKE ooie_t.ooie021, 
   ooie022 LIKE ooie_t.ooie022, 
   ooie023 LIKE ooie_t.ooie023, 
   ooie024 LIKE ooie_t.ooie024, 
   ooie025 LIKE ooie_t.ooie025, 
   ooie026 LIKE ooie_t.ooie026, 
   ooie027 LIKE ooie_t.ooie027, 
   ooie028 LIKE ooie_t.ooie028, 
   ooie029 LIKE ooie_t.ooie029, 
   ooiepos LIKE ooie_t.ooiepos
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_comp                LIKE ooef_t.ooef017           #140930-00020#17
#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_ooie_m          type_g_ooie_m
DEFINE g_ooie_m_t        type_g_ooie_m
DEFINE g_ooie_m_o        type_g_ooie_m
DEFINE g_ooie_m_mask_o   type_g_ooie_m #轉換遮罩前資料
DEFINE g_ooie_m_mask_n   type_g_ooie_m #轉換遮罩後資料
 
   DEFINE g_ooiesite_t LIKE ooie_t.ooiesite
 
 
DEFINE g_ooie_d          DYNAMIC ARRAY OF type_g_ooie_d
DEFINE g_ooie_d_t        type_g_ooie_d
DEFINE g_ooie_d_o        type_g_ooie_d
DEFINE g_ooie_d_mask_o   DYNAMIC ARRAY OF type_g_ooie_d #轉換遮罩前資料
DEFINE g_ooie_d_mask_n   DYNAMIC ARRAY OF type_g_ooie_d #轉換遮罩後資料
DEFINE g_ooie2_d   DYNAMIC ARRAY OF type_g_ooie2_d
DEFINE g_ooie2_d_t type_g_ooie2_d
DEFINE g_ooie2_d_o type_g_ooie2_d
DEFINE g_ooie2_d_mask_o   DYNAMIC ARRAY OF type_g_ooie2_d #轉換遮罩前資料
DEFINE g_ooie2_d_mask_n   DYNAMIC ARRAY OF type_g_ooie2_d #轉換遮罩後資料
DEFINE g_ooie3_d   DYNAMIC ARRAY OF type_g_ooie3_d
DEFINE g_ooie3_d_t type_g_ooie3_d
DEFINE g_ooie3_d_o type_g_ooie3_d
DEFINE g_ooie3_d_mask_o   DYNAMIC ARRAY OF type_g_ooie3_d #轉換遮罩前資料
DEFINE g_ooie3_d_mask_n   DYNAMIC ARRAY OF type_g_ooie3_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_ooiesite LIKE ooie_t.ooiesite,
   b_ooiesite_desc LIKE type_t.chr80,
   b_rtaa001 LIKE rtaa_t.rtaa001,
   b_rtaa001_desc LIKE type_t.chr80
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
 
{<section id="aooi901.main" >}
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
   CALL cl_ap_init("aoo","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT ooiesite,'','',''", 
                      " FROM ooie_t",
                      " WHERE ooieent= ? AND ooiesite=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aooi901_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.ooiesite,t1.ooefl003",
               " FROM ooie_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.ooiesite AND t1.ooefl002='"||g_dlang||"' ",
 
               " WHERE t0.ooieent = " ||g_enterprise|| " AND t0.ooiesite = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aooi901_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aooi901 WITH FORM cl_ap_formpath("aoo",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aooi901_init()   
 
      #進入選單 Menu (="N")
      CALL aooi901_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aooi901
      
   END IF 
   
   CLOSE aooi901_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aooi901.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aooi901_init()
   #add-point:init段define name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill = "Y"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
      CALL cl_set_combo_scc_part('ooiestus','50','N,Y,X')
 
   
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('ooia002','8310') 
   CALL cl_set_combo_scc('ooie032','6886')  #added BY LANJJ 2015-12-24 
   #end add-point
   
   CALL aooi901_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aooi901.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION aooi901_ui_dialog()
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
   DEFINE l_success   LIKE type_t.num5 #added By lanjj 2015-12-05
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
         INITIALIZE g_ooie_m.* TO NULL
         CALL g_ooie_d.clear()
         CALL g_ooie2_d.clear()
         CALL g_ooie3_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aooi901_init()
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
               CALL aooi901_idx_chk()
               CALL aooi901_fetch('') # reload data
               LET g_detail_idx = 1
               CALL aooi901_ui_detailshow() #Setting the current row 
         
            ON ACTION qbefield_user   #欄位隱藏設定 
               LET g_action_choice="qbefield_user"
               CALL cl_ui_qbefield_user()
         
         END DISPLAY
        
         DISPLAY ARRAY g_ooie_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL aooi901_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL aooi901_ui_detailshow()
               
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
               
               
            
 
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         DISPLAY ARRAY g_ooie2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL aooi901_idx_chk()
               CALL aooi901_ui_detailshow()
               
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
         DISPLAY ARRAY g_ooie3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL aooi901_idx_chk()
               CALL aooi901_ui_detailshow()
               
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
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps 
         
         BEFORE DIALOG
            #先填充browser資料
            CALL aooi901_browser_fill("")
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
               CALL aooi901_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aooi901_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #應用 a49 樣板自動產生(Version:4)
            #過濾瀏覽頁資料
            ON ACTION filter
               LET g_action_choice = "fetch"
               #add-point:filter action name="ui_dialog.action.filter"
               
               #end add-point
               CALL aooi901_filter()
               EXIT DIALOG
 
 
 
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL aooi901_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aooi901_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL aooi901_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aooi901_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL aooi901_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aooi901_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL aooi901_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aooi901_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL aooi901_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aooi901_idx_chk()
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
                  LET g_export_node[1] = base.typeInfo.create(g_ooie_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_ooie2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_ooie3_d)
                  LET g_export_id[3]   = "s_detail3"
 
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
               NEXT FIELD ooie001
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
               CALL aooi901_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL aooi901_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL aooi901_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION handling_fee
            LET g_action_choice="handling_fee"
            IF cl_auth_chk_act("handling_fee") THEN
               
               #add-point:ON ACTION handling_fee name="menu.handling_fee"
               #ADDED BY LANJJ 2015-12-04   整单操作action  ----START----批量产生卡手续费
               IF g_ooie_d[g_detail_idx].ooiestus = 'Y' THEN 
                  CALL s_transaction_begin()
                  CALL s_aooi713_handling_fee(g_ooie_d[g_detail_idx].ooie001,              # 款别编号
                                              g_ooie_d[g_detail_idx].ooia002,              # 款别性质
                                              g_ooie_m.ooiesite,                   # 门店
                                              g_ooie_m.rtaa001,                    # 店群
                                              'aooi901')                           # 本程序名
                     RETURNING l_success
                  IF l_success = TRUE THEN 
                     CALL s_transaction_end('Y',1)
                  ELSE 
                     CALL s_transaction_end('N',1)
                  END IF 
               END IF
               #ADDED BY LANJJ 2015-12-04   整单操作action  ---- END ----批量产生卡手续费
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL aooi901_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL aooi901_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION aooi901_01
            LET g_action_choice="aooi901_01"
            IF cl_auth_chk_act("aooi901_01") THEN
               
               #add-point:ON ACTION aooi901_01 name="menu.aooi901_01"
               IF g_detail_idx > 0 THEN    
                  IF NOT cl_null(g_ooie_m.ooiesite) AND NOT cl_null(g_ooie_d[g_detail_idx].ooie001) AND g_ooie_d[g_detail_idx].ooie003 = 'Y' THEN 
                     CALL aooi901_01(g_ooie_m.ooiesite,g_ooie_d[g_detail_idx].ooie001,g_ooie_d[g_detail_idx].ooie003)
                  END IF
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aooi901_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aooi901_insert()
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
               CALL aooi901_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aooi901_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION aooi901_02
            LET g_action_choice="aooi901_02"
            IF cl_auth_chk_act("aooi901_02") THEN
               
               #add-point:ON ACTION aooi901_02 name="menu.aooi901_02"
               IF g_detail_idx > 0 THEN    
                  IF NOT cl_null(g_ooie_m.ooiesite) AND NOT cl_null(g_ooie_d[g_detail_idx].ooie001) THEN 
                     CALL aooi901_02(g_ooie_m.ooiesite,g_ooie_d[g_detail_idx].ooie001)
                  END IF
               END IF 
               #END add-point
               
            END IF
 
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aooi901_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aooi901_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aooi901_set_pk_array()
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
 
{<section id="aooi901.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION aooi901_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aooi901.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION aooi901_browser_fill(ps_page_action)
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
 
   LET l_searchcol = "ooiesite"
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
      LET l_sub_sql = " SELECT DISTINCT ooiesite ",
 
                      " FROM ooie_t ",
                      " ",
                      " ", 
 
 
 
                      " WHERE ooieent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("ooie_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT ooiesite ",
 
                      " FROM ooie_t ",
                      " ",
                      " ", 
 
 
                      " WHERE ooieent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("ooie_t")
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
      INITIALIZE g_ooie_m.* TO NULL
      CALL g_ooie_d.clear()        
      CALL g_ooie2_d.clear() 
      CALL g_ooie3_d.clear() 
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.ooiesite Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.ooiesite,t1.ooefl003",
                " FROM ooie_t t0",
                #" ",
                " ",
 
 
 
                               " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.ooiesite AND t1.ooefl002='"||g_dlang||"' ",
 
                " WHERE t0.ooieent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("ooie_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
   
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"ooie_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_ooiesite,g_browser[g_cnt].b_ooiesite_desc 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         
         
         #add-point:browser_fill段reference name="browser_fill.reference"
      #huangrh add rtak----20150603
      SELECT DISTINCT rtaa001,rtaal003
        INTO g_browser[g_cnt].b_rtaa001,g_browser[g_cnt].b_rtaa001_desc
        FROM rtak_t,rtab_t,rtaa_t LEFT JOIN rtaal_t ON rtaaent = rtaalent AND rtaa001 = rtaal001 AND rtaal002 = g_lang
       WHERE rtaaent = g_enterprise
         AND rtaa001 = rtab001
         AND rtabent = rtaaent
         AND rtab002 = g_browser[g_cnt].b_ooiesite
         AND rtakent=rtaaent
         AND rtak001=rtaa001
         AND rtak002='5'
         AND rtak003='Y'
         AND rtaastus = 'Y'
         #end add-point  
      
         #遮罩相關處理
         CALL aooi901_browser_mask()
         
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
   
   IF cl_null(g_browser[g_cnt].b_ooiesite) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_ooie_m.* TO NULL
      CALL g_ooie_d.clear()
      CALL g_ooie2_d.clear()
      CALL g_ooie3_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL aooi901_fetch('')
   
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
 
{<section id="aooi901.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION aooi901_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_ooie_m.ooiesite = g_browser[g_current_idx].b_ooiesite   
 
   EXECUTE aooi901_master_referesh USING g_ooie_m.ooiesite INTO g_ooie_m.ooiesite,g_ooie_m.ooiesite_desc 
 
   CALL aooi901_show()
   
END FUNCTION
 
{</section>}
 
{<section id="aooi901.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION aooi901_ui_detailshow()
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
 
      #add-point:ui_detailshow段more name="ui_detailshow.more"
      
      #end add-point 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="aooi901.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aooi901_ui_browser_refresh()
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
      IF g_browser[l_i].b_ooiesite = g_ooie_m.ooiesite 
 
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
 
{<section id="aooi901.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aooi901_construct()
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
   INITIALIZE g_ooie_m.* TO NULL
   CALL g_ooie_d.clear()
   CALL g_ooie2_d.clear()
   CALL g_ooie3_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON ooiesite,rtaa001
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
                 #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooiesite
            #add-point:BEFORE FIELD ooiesite name="construct.b.ooiesite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooiesite
            
            #add-point:AFTER FIELD ooiesite name="construct.a.ooiesite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooiesite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooiesite
            #add-point:ON ACTION controlp INFIELD ooiesite name="construct.c.ooiesite"
            ###  ### start ###
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = ""
            LET g_qryparam.where = "1=1"
#            CALL q_ooef001_14()        #161019-00017#9 marked
            CALL q_ooef001_1()        #161019-00017#9 add
            DISPLAY g_qryparam.return1 TO ooiesite  #顯示到畫面上
            NEXT FIELD ooiesite   
            ###  ### end ###

            #END add-point
 
 
         #Ctrlp:construct.c.rtaa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtaa001
            #add-point:ON ACTION controlp INFIELD rtaa001 name="construct.c.rtaa001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '5'
            CALL q_rtaa001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtaa001  #顯示到畫面上
            NEXT FIELD rtaa001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtaa001
            #add-point:BEFORE FIELD rtaa001 name="construct.b.rtaa001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtaa001
            
            #add-point:AFTER FIELD rtaa001 name="construct.a.rtaa001"
            
            #END add-point
            
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON ooiestus,ooie001,ooie002,ooie031,ooie037,ooie038,ooie003,ooie004,ooie005, 
          ooie006,ooie007,ooie008,ooiestamp,ooie030,ooie032,ooie033,ooie034,ooie035,ooie036,ooie040, 
          ooie039,ooieownid,ooieowndp,ooiecrtid,ooiecrtdp,ooiecrtdt,ooiemodid,ooiemoddt,ooie009,ooie010, 
          ooie011,ooie012,ooie013,ooie014,ooie015,ooie016,ooie017,ooie018,ooie019,ooie020,ooie021,ooie022, 
          ooie023,ooie024,ooie025,ooie026,ooie027,ooie028,ooie029,ooiepos
           FROM s_detail1[1].ooiestus,s_detail1[1].ooie001,s_detail1[1].ooie002,s_detail1[1].ooie031, 
               s_detail1[1].ooie037,s_detail1[1].ooie038,s_detail1[1].ooie003,s_detail1[1].ooie004,s_detail1[1].ooie005, 
               s_detail1[1].ooie006,s_detail1[1].ooie007,s_detail1[1].ooie008,s_detail1[1].ooiestamp, 
               s_detail1[1].ooie030,s_detail1[1].ooie032,s_detail1[1].ooie033,s_detail1[1].ooie034,s_detail1[1].ooie035, 
               s_detail1[1].ooie036,s_detail1[1].ooie040,s_detail1[1].ooie039,s_detail2[1].ooieownid, 
               s_detail2[1].ooieowndp,s_detail2[1].ooiecrtid,s_detail2[1].ooiecrtdp,s_detail2[1].ooiecrtdt, 
               s_detail2[1].ooiemodid,s_detail2[1].ooiemoddt,s_detail3[1].ooie009,s_detail3[1].ooie010, 
               s_detail3[1].ooie011,s_detail3[1].ooie012,s_detail3[1].ooie013,s_detail3[1].ooie014,s_detail3[1].ooie015, 
               s_detail3[1].ooie016,s_detail3[1].ooie017,s_detail3[1].ooie018,s_detail3[1].ooie019,s_detail3[1].ooie020, 
               s_detail3[1].ooie021,s_detail3[1].ooie022,s_detail3[1].ooie023,s_detail3[1].ooie024,s_detail3[1].ooie025, 
               s_detail3[1].ooie026,s_detail3[1].ooie027,s_detail3[1].ooie028,s_detail3[1].ooie029,s_detail3[1].ooiepos 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<ooiecrtdt>>----
         AFTER FIELD ooiecrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<ooiemoddt>>----
         AFTER FIELD ooiemoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<ooiecnfdt>>----
         
         #----<<ooiepstdt>>----
 
 
 
           
         #單身一般欄位開窗相關處理
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooiestus
            #add-point:BEFORE FIELD ooiestus name="construct.b.page1.ooiestus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooiestus
            
            #add-point:AFTER FIELD ooiestus name="construct.a.page1.ooiestus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.ooiestus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooiestus
            #add-point:ON ACTION controlp INFIELD ooiestus name="construct.c.page1.ooiestus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.ooie001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie001
            #add-point:ON ACTION controlp INFIELD ooie001 name="construct.c.page1.ooie001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooia001_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooie001  #顯示到畫面上
            NEXT FIELD ooie001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie001
            #add-point:BEFORE FIELD ooie001 name="construct.b.page1.ooie001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie001
            
            #add-point:AFTER FIELD ooie001 name="construct.a.page1.ooie001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.ooie002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie002
            #add-point:ON ACTION controlp INFIELD ooie002 name="construct.c.page1.ooie002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooaj002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooie002  #顯示到畫面上
            NEXT FIELD ooie002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie002
            #add-point:BEFORE FIELD ooie002 name="construct.b.page1.ooie002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie002
            
            #add-point:AFTER FIELD ooie002 name="construct.a.page1.ooie002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie031
            #add-point:BEFORE FIELD ooie031 name="construct.b.page1.ooie031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie031
            
            #add-point:AFTER FIELD ooie031 name="construct.a.page1.ooie031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.ooie031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie031
            #add-point:ON ACTION controlp INFIELD ooie031 name="construct.c.page1.ooie031"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie037
            #add-point:BEFORE FIELD ooie037 name="construct.b.page1.ooie037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie037
            
            #add-point:AFTER FIELD ooie037 name="construct.a.page1.ooie037"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.ooie037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie037
            #add-point:ON ACTION controlp INFIELD ooie037 name="construct.c.page1.ooie037"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie038
            #add-point:BEFORE FIELD ooie038 name="construct.b.page1.ooie038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie038
            
            #add-point:AFTER FIELD ooie038 name="construct.a.page1.ooie038"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.ooie038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie038
            #add-point:ON ACTION controlp INFIELD ooie038 name="construct.c.page1.ooie038"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie003
            #add-point:BEFORE FIELD ooie003 name="construct.b.page1.ooie003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie003
            
            #add-point:AFTER FIELD ooie003 name="construct.a.page1.ooie003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.ooie003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie003
            #add-point:ON ACTION controlp INFIELD ooie003 name="construct.c.page1.ooie003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie004
            #add-point:BEFORE FIELD ooie004 name="construct.b.page1.ooie004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie004
            
            #add-point:AFTER FIELD ooie004 name="construct.a.page1.ooie004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.ooie004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie004
            #add-point:ON ACTION controlp INFIELD ooie004 name="construct.c.page1.ooie004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie005
            #add-point:BEFORE FIELD ooie005 name="construct.b.page1.ooie005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie005
            
            #add-point:AFTER FIELD ooie005 name="construct.a.page1.ooie005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.ooie005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie005
            #add-point:ON ACTION controlp INFIELD ooie005 name="construct.c.page1.ooie005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie006
            #add-point:BEFORE FIELD ooie006 name="construct.b.page1.ooie006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie006
            
            #add-point:AFTER FIELD ooie006 name="construct.a.page1.ooie006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.ooie006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie006
            #add-point:ON ACTION controlp INFIELD ooie006 name="construct.c.page1.ooie006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie007
            #add-point:BEFORE FIELD ooie007 name="construct.b.page1.ooie007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie007
            
            #add-point:AFTER FIELD ooie007 name="construct.a.page1.ooie007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.ooie007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie007
            #add-point:ON ACTION controlp INFIELD ooie007 name="construct.c.page1.ooie007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie008
            #add-point:BEFORE FIELD ooie008 name="construct.b.page1.ooie008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie008
            
            #add-point:AFTER FIELD ooie008 name="construct.a.page1.ooie008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.ooie008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie008
            #add-point:ON ACTION controlp INFIELD ooie008 name="construct.c.page1.ooie008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooiestamp
            #add-point:BEFORE FIELD ooiestamp name="construct.b.page1.ooiestamp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooiestamp
            
            #add-point:AFTER FIELD ooiestamp name="construct.a.page1.ooiestamp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.ooiestamp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooiestamp
            #add-point:ON ACTION controlp INFIELD ooiestamp name="construct.c.page1.ooiestamp"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie030
            #add-point:BEFORE FIELD ooie030 name="construct.b.page1.ooie030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie030
            
            #add-point:AFTER FIELD ooie030 name="construct.a.page1.ooie030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.ooie030
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie030
            #add-point:ON ACTION controlp INFIELD ooie030 name="construct.c.page1.ooie030"
            #140930-00020#17 add ------
            #開窗c段-對應銀行帳戶
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmas001()
            DISPLAY g_qryparam.return1 TO ooie030
            NEXT FIELD ooie030
            #140930-00020#17 add end---
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie032
            #add-point:BEFORE FIELD ooie032 name="construct.b.page1.ooie032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie032
            
            #add-point:AFTER FIELD ooie032 name="construct.a.page1.ooie032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.ooie032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie032
            #add-point:ON ACTION controlp INFIELD ooie032 name="construct.c.page1.ooie032"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie033
            #add-point:BEFORE FIELD ooie033 name="construct.b.page1.ooie033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie033
            
            #add-point:AFTER FIELD ooie033 name="construct.a.page1.ooie033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.ooie033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie033
            #add-point:ON ACTION controlp INFIELD ooie033 name="construct.c.page1.ooie033"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie034
            #add-point:BEFORE FIELD ooie034 name="construct.b.page1.ooie034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie034
            
            #add-point:AFTER FIELD ooie034 name="construct.a.page1.ooie034"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.ooie034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie034
            #add-point:ON ACTION controlp INFIELD ooie034 name="construct.c.page1.ooie034"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie035
            #add-point:BEFORE FIELD ooie035 name="construct.b.page1.ooie035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie035
            
            #add-point:AFTER FIELD ooie035 name="construct.a.page1.ooie035"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.ooie035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie035
            #add-point:ON ACTION controlp INFIELD ooie035 name="construct.c.page1.ooie035"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.ooie036
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie036
            #add-point:ON ACTION controlp INFIELD ooie036 name="construct.c.page1.ooie036"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            #160509-00004#2--add--str--lujh
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()     #161019-00017#1
            CALL q_ooef001_1()   #161019-00017#1
            DISPLAY g_qryparam.return1 TO ooie036  #顯示到畫面上
            NEXT FIELD ooie036                     #返回原欄位
            #160509-00004#2--add--end--lujh
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie036
            #add-point:BEFORE FIELD ooie036 name="construct.b.page1.ooie036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie036
            
            #add-point:AFTER FIELD ooie036 name="construct.a.page1.ooie036"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.ooie040
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie040
            #add-point:ON ACTION controlp INFIELD ooie040 name="construct.c.page1.ooie040"
            #160509-00004#42--add--str--lujh
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooie040  #顯示到畫面上
            NEXT FIELD ooie040                     #返回原欄位
            #160509-00004#42--add--end--lujh
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie040
            #add-point:BEFORE FIELD ooie040 name="construct.b.page1.ooie040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie040
            
            #add-point:AFTER FIELD ooie040 name="construct.a.page1.ooie040"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie039
            #add-point:BEFORE FIELD ooie039 name="construct.b.page1.ooie039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie039
            
            #add-point:AFTER FIELD ooie039 name="construct.a.page1.ooie039"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.ooie039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie039
            #add-point:ON ACTION controlp INFIELD ooie039 name="construct.c.page1.ooie039"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.ooieownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooieownid
            #add-point:ON ACTION controlp INFIELD ooieownid name="construct.c.page2.ooieownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooieownid  #顯示到畫面上
            NEXT FIELD ooieownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooieownid
            #add-point:BEFORE FIELD ooieownid name="construct.b.page2.ooieownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooieownid
            
            #add-point:AFTER FIELD ooieownid name="construct.a.page2.ooieownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.ooieowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooieowndp
            #add-point:ON ACTION controlp INFIELD ooieowndp name="construct.c.page2.ooieowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooieowndp  #顯示到畫面上
            NEXT FIELD ooieowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooieowndp
            #add-point:BEFORE FIELD ooieowndp name="construct.b.page2.ooieowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooieowndp
            
            #add-point:AFTER FIELD ooieowndp name="construct.a.page2.ooieowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.ooiecrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooiecrtid
            #add-point:ON ACTION controlp INFIELD ooiecrtid name="construct.c.page2.ooiecrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooiecrtid  #顯示到畫面上
            NEXT FIELD ooiecrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooiecrtid
            #add-point:BEFORE FIELD ooiecrtid name="construct.b.page2.ooiecrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooiecrtid
            
            #add-point:AFTER FIELD ooiecrtid name="construct.a.page2.ooiecrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.ooiecrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooiecrtdp
            #add-point:ON ACTION controlp INFIELD ooiecrtdp name="construct.c.page2.ooiecrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooiecrtdp  #顯示到畫面上
            NEXT FIELD ooiecrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooiecrtdp
            #add-point:BEFORE FIELD ooiecrtdp name="construct.b.page2.ooiecrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooiecrtdp
            
            #add-point:AFTER FIELD ooiecrtdp name="construct.a.page2.ooiecrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooiecrtdt
            #add-point:BEFORE FIELD ooiecrtdt name="construct.b.page2.ooiecrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.ooiemodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooiemodid
            #add-point:ON ACTION controlp INFIELD ooiemodid name="construct.c.page2.ooiemodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooiemodid  #顯示到畫面上
            NEXT FIELD ooiemodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooiemodid
            #add-point:BEFORE FIELD ooiemodid name="construct.b.page2.ooiemodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooiemodid
            
            #add-point:AFTER FIELD ooiemodid name="construct.a.page2.ooiemodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooiemoddt
            #add-point:BEFORE FIELD ooiemoddt name="construct.b.page2.ooiemoddt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie009
            #add-point:BEFORE FIELD ooie009 name="construct.b.page3.ooie009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie009
            
            #add-point:AFTER FIELD ooie009 name="construct.a.page3.ooie009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.ooie009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie009
            #add-point:ON ACTION controlp INFIELD ooie009 name="construct.c.page3.ooie009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie010
            #add-point:BEFORE FIELD ooie010 name="construct.b.page3.ooie010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie010
            
            #add-point:AFTER FIELD ooie010 name="construct.a.page3.ooie010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.ooie010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie010
            #add-point:ON ACTION controlp INFIELD ooie010 name="construct.c.page3.ooie010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie011
            #add-point:BEFORE FIELD ooie011 name="construct.b.page3.ooie011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie011
            
            #add-point:AFTER FIELD ooie011 name="construct.a.page3.ooie011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.ooie011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie011
            #add-point:ON ACTION controlp INFIELD ooie011 name="construct.c.page3.ooie011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie012
            #add-point:BEFORE FIELD ooie012 name="construct.b.page3.ooie012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie012
            
            #add-point:AFTER FIELD ooie012 name="construct.a.page3.ooie012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.ooie012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie012
            #add-point:ON ACTION controlp INFIELD ooie012 name="construct.c.page3.ooie012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie013
            #add-point:BEFORE FIELD ooie013 name="construct.b.page3.ooie013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie013
            
            #add-point:AFTER FIELD ooie013 name="construct.a.page3.ooie013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.ooie013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie013
            #add-point:ON ACTION controlp INFIELD ooie013 name="construct.c.page3.ooie013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie014
            #add-point:BEFORE FIELD ooie014 name="construct.b.page3.ooie014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie014
            
            #add-point:AFTER FIELD ooie014 name="construct.a.page3.ooie014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.ooie014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie014
            #add-point:ON ACTION controlp INFIELD ooie014 name="construct.c.page3.ooie014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie015
            #add-point:BEFORE FIELD ooie015 name="construct.b.page3.ooie015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie015
            
            #add-point:AFTER FIELD ooie015 name="construct.a.page3.ooie015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.ooie015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie015
            #add-point:ON ACTION controlp INFIELD ooie015 name="construct.c.page3.ooie015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie016
            #add-point:BEFORE FIELD ooie016 name="construct.b.page3.ooie016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie016
            
            #add-point:AFTER FIELD ooie016 name="construct.a.page3.ooie016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.ooie016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie016
            #add-point:ON ACTION controlp INFIELD ooie016 name="construct.c.page3.ooie016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie017
            #add-point:BEFORE FIELD ooie017 name="construct.b.page3.ooie017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie017
            
            #add-point:AFTER FIELD ooie017 name="construct.a.page3.ooie017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.ooie017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie017
            #add-point:ON ACTION controlp INFIELD ooie017 name="construct.c.page3.ooie017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie018
            #add-point:BEFORE FIELD ooie018 name="construct.b.page3.ooie018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie018
            
            #add-point:AFTER FIELD ooie018 name="construct.a.page3.ooie018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.ooie018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie018
            #add-point:ON ACTION controlp INFIELD ooie018 name="construct.c.page3.ooie018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie019
            #add-point:BEFORE FIELD ooie019 name="construct.b.page3.ooie019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie019
            
            #add-point:AFTER FIELD ooie019 name="construct.a.page3.ooie019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.ooie019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie019
            #add-point:ON ACTION controlp INFIELD ooie019 name="construct.c.page3.ooie019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie020
            #add-point:BEFORE FIELD ooie020 name="construct.b.page3.ooie020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie020
            
            #add-point:AFTER FIELD ooie020 name="construct.a.page3.ooie020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.ooie020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie020
            #add-point:ON ACTION controlp INFIELD ooie020 name="construct.c.page3.ooie020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie021
            #add-point:BEFORE FIELD ooie021 name="construct.b.page3.ooie021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie021
            
            #add-point:AFTER FIELD ooie021 name="construct.a.page3.ooie021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.ooie021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie021
            #add-point:ON ACTION controlp INFIELD ooie021 name="construct.c.page3.ooie021"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie022
            #add-point:BEFORE FIELD ooie022 name="construct.b.page3.ooie022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie022
            
            #add-point:AFTER FIELD ooie022 name="construct.a.page3.ooie022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.ooie022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie022
            #add-point:ON ACTION controlp INFIELD ooie022 name="construct.c.page3.ooie022"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie023
            #add-point:BEFORE FIELD ooie023 name="construct.b.page3.ooie023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie023
            
            #add-point:AFTER FIELD ooie023 name="construct.a.page3.ooie023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.ooie023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie023
            #add-point:ON ACTION controlp INFIELD ooie023 name="construct.c.page3.ooie023"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie024
            #add-point:BEFORE FIELD ooie024 name="construct.b.page3.ooie024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie024
            
            #add-point:AFTER FIELD ooie024 name="construct.a.page3.ooie024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.ooie024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie024
            #add-point:ON ACTION controlp INFIELD ooie024 name="construct.c.page3.ooie024"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie025
            #add-point:BEFORE FIELD ooie025 name="construct.b.page3.ooie025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie025
            
            #add-point:AFTER FIELD ooie025 name="construct.a.page3.ooie025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.ooie025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie025
            #add-point:ON ACTION controlp INFIELD ooie025 name="construct.c.page3.ooie025"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie026
            #add-point:BEFORE FIELD ooie026 name="construct.b.page3.ooie026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie026
            
            #add-point:AFTER FIELD ooie026 name="construct.a.page3.ooie026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.ooie026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie026
            #add-point:ON ACTION controlp INFIELD ooie026 name="construct.c.page3.ooie026"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie027
            #add-point:BEFORE FIELD ooie027 name="construct.b.page3.ooie027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie027
            
            #add-point:AFTER FIELD ooie027 name="construct.a.page3.ooie027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.ooie027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie027
            #add-point:ON ACTION controlp INFIELD ooie027 name="construct.c.page3.ooie027"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie028
            #add-point:BEFORE FIELD ooie028 name="construct.b.page3.ooie028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie028
            
            #add-point:AFTER FIELD ooie028 name="construct.a.page3.ooie028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.ooie028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie028
            #add-point:ON ACTION controlp INFIELD ooie028 name="construct.c.page3.ooie028"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie029
            #add-point:BEFORE FIELD ooie029 name="construct.b.page3.ooie029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie029
            
            #add-point:AFTER FIELD ooie029 name="construct.a.page3.ooie029"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.ooie029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie029
            #add-point:ON ACTION controlp INFIELD ooie029 name="construct.c.page3.ooie029"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooiepos
            #add-point:BEFORE FIELD ooiepos name="construct.b.page3.ooiepos"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooiepos
            
            #add-point:AFTER FIELD ooiepos name="construct.a.page3.ooiepos"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.ooiepos
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooiepos
            #add-point:ON ACTION controlp INFIELD ooiepos name="construct.c.page3.ooiepos"
            
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
 
{<section id="aooi901.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION aooi901_filter()
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
      CONSTRUCT g_wc_filter ON ooiesite
                          FROM s_browse[1].b_ooiesite
 
         BEFORE CONSTRUCT
               DISPLAY aooi901_filter_parser('ooiesite') TO s_browse[1].b_ooiesite
      
         #add-point:filter段cs_ctrl name="filter.cs_ctrl"
         ON ACTION controlp INFIELD b_ooiesite
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = ""
            LET g_qryparam.where = "1=1"
            CALL q_rtab002_01()
            DISPLAY g_qryparam.return1 TO b_ooiesite  #顯示到畫面上
            NEXT FIELD b_ooiesite  
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
 
      CALL aooi901_filter_show('ooiesite')
 
END FUNCTION
 
{</section>}
 
{<section id="aooi901.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aooi901_filter_parser(ps_field)
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
 
{<section id="aooi901.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aooi901_filter_show(ps_field)
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
   LET ls_condition = aooi901_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aooi901.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aooi901_query()
   #add-point:query段define name="query.define_customerization"
   
   #end add-point   
   DEFINE ls_wc STRING
   #add-point:query段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="query.befroe_query"
   
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
   CALL g_ooie_d.clear()
   CALL g_ooie2_d.clear()
   CALL g_ooie3_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL aooi901_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aooi901_browser_fill(g_wc)
      CALL aooi901_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL aooi901_browser_fill("F")
   
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
      CALL aooi901_fetch("F") 
   END IF
   
   CALL aooi901_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="aooi901.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aooi901_fetch(p_flag)
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
   
   LET g_ooie_m.ooiesite = g_browser[g_current_idx].b_ooiesite
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE aooi901_master_referesh USING g_ooie_m.ooiesite INTO g_ooie_m.ooiesite,g_ooie_m.ooiesite_desc 
 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "ooie_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_ooie_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_ooie_m_mask_o.* =  g_ooie_m.*
   CALL aooi901_ooie_t_mask()
   LET g_ooie_m_mask_n.* =  g_ooie_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL aooi901_set_act_visible()
   CALL aooi901_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_ooie_m_t.* = g_ooie_m.*
   LET g_ooie_m_o.* = g_ooie_m.*
   
   #重新顯示   
   CALL aooi901_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="aooi901.insert" >}
#+ 資料新增
PRIVATE FUNCTION aooi901_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_ooie_d.clear()
   CALL g_ooie2_d.clear()
   CALL g_ooie3_d.clear()
 
 
   INITIALIZE g_ooie_m.* TO NULL             #DEFAULT 設定
   LET g_ooiesite_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
      
     
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point 
 
      CALL aooi901_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_ooie_m.* TO NULL
         INITIALIZE g_ooie_d TO NULL
         INITIALIZE g_ooie2_d TO NULL
         INITIALIZE g_ooie3_d TO NULL
 
         CALL aooi901_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_ooie_m.* = g_ooie_m_t.*
         CALL aooi901_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_ooie_d.clear()
      #CALL g_ooie2_d.clear()
      #CALL g_ooie3_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      CALL aooi901_b_fill(" 1=1")
      EXIT WHILE 
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL aooi901_set_act_visible()
   CALL aooi901_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_ooiesite_t = g_ooie_m.ooiesite
 
   
   #組合新增資料的條件
   LET g_add_browse = " ooieent = " ||g_enterprise|| " AND",
                      " ooiesite = '", g_ooie_m.ooiesite, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aooi901_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL aooi901_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aooi901_master_referesh USING g_ooie_m.ooiesite INTO g_ooie_m.ooiesite,g_ooie_m.ooiesite_desc 
 
   
   #遮罩相關處理
   LET g_ooie_m_mask_o.* =  g_ooie_m.*
   CALL aooi901_ooie_t_mask()
   LET g_ooie_m_mask_n.* =  g_ooie_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_ooie_m.ooiesite,g_ooie_m.ooiesite_desc,g_ooie_m.rtaa001,g_ooie_m.rtaa001_desc
   
   #功能已完成,通報訊息中心
   CALL aooi901_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aooi901.modify" >}
#+ 資料修改
PRIVATE FUNCTION aooi901_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_ooie_m.ooiesite IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_ooiesite_t = g_ooie_m.ooiesite
 
   CALL s_transaction_begin()
   
   OPEN aooi901_cl USING g_enterprise,g_ooie_m.ooiesite
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aooi901_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE aooi901_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aooi901_master_referesh USING g_ooie_m.ooiesite INTO g_ooie_m.ooiesite,g_ooie_m.ooiesite_desc 
 
   
   #遮罩相關處理
   LET g_ooie_m_mask_o.* =  g_ooie_m.*
   CALL aooi901_ooie_t_mask()
   LET g_ooie_m_mask_n.* =  g_ooie_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL aooi901_show()
   WHILE TRUE
      LET g_ooiesite_t = g_ooie_m.ooiesite
 
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL aooi901_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_ooie_m.* = g_ooie_m_t.*
         CALL aooi901_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_ooie_m.ooiesite != g_ooiesite_t 
 
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
   CALL aooi901_set_act_visible()
   CALL aooi901_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " ooieent = " ||g_enterprise|| " AND",
                      " ooiesite = '", g_ooie_m.ooiesite, "' "
 
   #填到對應位置
   CALL aooi901_browser_fill("")
 
   CALL aooi901_idx_chk()
 
   CLOSE aooi901_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aooi901_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="aooi901.input" >}
#+ 資料輸入
PRIVATE FUNCTION aooi901_input(p_cmd)
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
   DEFINE  l_nmag002             LIKE nmag_t.nmag002  #140930-00020#17
   DEFINE  l_ooie032             LIKE ooie_t.ooie032  #added by lanjj 2015-12-24
   DEFINE  l_ooeg009             LIKE ooeg_t.ooeg009  #160509-00004#94 add lujh
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
   DISPLAY BY NAME g_ooie_m.ooiesite,g_ooie_m.ooiesite_desc,g_ooie_m.rtaa001,g_ooie_m.rtaa001_desc
   
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
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_ooie_m.ooiesite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_ooie_m.ooiesite_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_ooie_m.ooiesite_desc
   #end add-point 
   LET g_forupd_sql = "SELECT ooiestus,ooie001,ooie002,ooie031,ooie037,ooie038,ooie003,ooie004,ooie005, 
       ooie006,ooie007,ooie008,ooiestamp,ooie030,ooie032,ooie033,ooie034,ooie035,ooie036,ooie040,ooie039, 
       ooie001,ooieownid,ooieowndp,ooiecrtid,ooiecrtdp,ooiecrtdt,ooiemodid,ooiemoddt,ooie001,ooie009, 
       ooie010,ooie011,ooie012,ooie013,ooie014,ooie015,ooie016,ooie017,ooie018,ooie019,ooie020,ooie021, 
       ooie022,ooie023,ooie024,ooie025,ooie026,ooie027,ooie028,ooie029,ooiepos FROM ooie_t WHERE ooieent=?  
       AND ooiesite=? AND ooie001=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aooi901_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aooi901_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL aooi901_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_ooie_m.ooiesite
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   LET g_errshow = 1       #160509-00004#2 add lujh
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="aooi901.input.head" >}
   
      #單頭段
      INPUT BY NAME g_ooie_m.ooiesite 
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
         AFTER FIELD ooiesite
            
            #add-point:AFTER FIELD ooiesite name="input.a.ooiesite"

            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_ooie_m.ooiesite) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_ooie_m.ooiesite != g_ooiesite_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM ooie_t WHERE "||"ooieent = '" ||g_enterprise|| "' AND "||"ooiesite = '"||g_ooie_m.ooiesite ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
               CALL aooi901_ooiesite_chk()
               IF NOT cl_null(g_errno) THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = g_errno
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET g_ooie_m.ooiesite = g_ooie_m_t.ooiesite
                  NEXT FIELD ooiesite
               END IF
               #140930-00020#17 add ------
               #抓取據點所屬法人
               SELECT ooef017 INTO g_comp
                 FROM ooef_t
                WHERE ooefent = g_enterprise
                  AND ooef001 = g_ooie_m.ooiesite
                  AND ooefstus = 'Y'
               #140930-00020#17 add end---
            END IF
            
            CALL aooi901_ooiesite_desc()
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ooie_m.ooiesite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_ooie_m.ooiesite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_ooie_m.ooiesite_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooiesite
            #add-point:BEFORE FIELD ooiesite name="input.b.ooiesite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooiesite
            #add-point:ON CHANGE ooiesite name="input.g.ooiesite"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.ooiesite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooiesite
            #add-point:ON ACTION controlp INFIELD ooiesite name="input.c.ooiesite"
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = ""
            LET g_qryparam.where = "1=1"
#            CALL q_ooef001_14()        #161019-00017#9 marked
            CALL q_ooef001_1()        #161019-00017#9 add
            LET g_ooie_m.ooiesite = g_qryparam.return1
            DISPLAY BY NAME g_ooie_m.ooiesite
            NEXT FIELD ooiesite   
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
            DISPLAY BY NAME g_ooie_m.ooiesite             
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
            
               #將遮罩欄位還原
               CALL aooi901_ooie_t_mask_restore('restore_mask_o')
            
               UPDATE ooie_t SET (ooiesite) = (g_ooie_m.ooiesite)
                WHERE ooieent = g_enterprise AND ooiesite = g_ooiesite_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "ooie_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "ooie_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_ooie_m.ooiesite
               LET gs_keys_bak[1] = g_ooiesite_t
               LET gs_keys[2] = g_ooie_d[g_detail_idx].ooie001
               LET gs_keys_bak[2] = g_ooie_d_t.ooie001
               CALL aooi901_update_b('ooie_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
 
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_ooie_m_t)
                     #LET g_log2 = util.JSON.stringify(g_ooie_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL aooi901_ooie_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               IF l_cmd_t != 'r' THEN
                  CALL aooi901_ooie_ins()
                  CALL aooi901_b_fill(" 1=1")
               END IF 
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL aooi901_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_ooiesite_t = g_ooie_m.ooiesite
 
           
           IF g_ooie_d.getLength() = 0 THEN
              NEXT FIELD ooie001
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="aooi901.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_ooie_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_ooie_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aooi901_b_fill(g_wc2) #test 
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
            CALL aooi901_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN aooi901_cl USING g_enterprise,g_ooie_m.ooiesite                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE aooi901_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN aooi901_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_ooie_d[l_ac].ooie001 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_ooie_d_t.* = g_ooie_d[l_ac].*  #BACKUP
               LET g_ooie_d_o.* = g_ooie_d[l_ac].*  #BACKUP
               CALL aooi901_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL aooi901_set_no_entry_b(l_cmd)
               OPEN aooi901_bcl USING g_enterprise,g_ooie_m.ooiesite,
 
                                                g_ooie_d_t.ooie001
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN aooi901_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aooi901_bcl INTO g_ooie_d[l_ac].ooiestus,g_ooie_d[l_ac].ooie001,g_ooie_d[l_ac].ooie002, 
                      g_ooie_d[l_ac].ooie031,g_ooie_d[l_ac].ooie037,g_ooie_d[l_ac].ooie038,g_ooie_d[l_ac].ooie003, 
                      g_ooie_d[l_ac].ooie004,g_ooie_d[l_ac].ooie005,g_ooie_d[l_ac].ooie006,g_ooie_d[l_ac].ooie007, 
                      g_ooie_d[l_ac].ooie008,g_ooie_d[l_ac].ooiestamp,g_ooie_d[l_ac].ooie030,g_ooie_d[l_ac].ooie032, 
                      g_ooie_d[l_ac].ooie033,g_ooie_d[l_ac].ooie034,g_ooie_d[l_ac].ooie035,g_ooie_d[l_ac].ooie036, 
                      g_ooie_d[l_ac].ooie040,g_ooie_d[l_ac].ooie039,g_ooie2_d[l_ac].ooie001,g_ooie2_d[l_ac].ooieownid, 
                      g_ooie2_d[l_ac].ooieowndp,g_ooie2_d[l_ac].ooiecrtid,g_ooie2_d[l_ac].ooiecrtdp, 
                      g_ooie2_d[l_ac].ooiecrtdt,g_ooie2_d[l_ac].ooiemodid,g_ooie2_d[l_ac].ooiemoddt, 
                      g_ooie3_d[l_ac].ooie001,g_ooie3_d[l_ac].ooie009,g_ooie3_d[l_ac].ooie010,g_ooie3_d[l_ac].ooie011, 
                      g_ooie3_d[l_ac].ooie012,g_ooie3_d[l_ac].ooie013,g_ooie3_d[l_ac].ooie014,g_ooie3_d[l_ac].ooie015, 
                      g_ooie3_d[l_ac].ooie016,g_ooie3_d[l_ac].ooie017,g_ooie3_d[l_ac].ooie018,g_ooie3_d[l_ac].ooie019, 
                      g_ooie3_d[l_ac].ooie020,g_ooie3_d[l_ac].ooie021,g_ooie3_d[l_ac].ooie022,g_ooie3_d[l_ac].ooie023, 
                      g_ooie3_d[l_ac].ooie024,g_ooie3_d[l_ac].ooie025,g_ooie3_d[l_ac].ooie026,g_ooie3_d[l_ac].ooie027, 
                      g_ooie3_d[l_ac].ooie028,g_ooie3_d[l_ac].ooie029,g_ooie3_d[l_ac].ooiepos
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_ooie_d_t.ooie001,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_ooie_d_mask_o[l_ac].* =  g_ooie_d[l_ac].*
                  CALL aooi901_ooie_t_mask()
                  LET g_ooie_d_mask_n[l_ac].* =  g_ooie_d[l_ac].*
                  
                  CALL aooi901_ref_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            #140930-00020#17 add ------
            CASE
               WHEN g_ooie_d[l_ac].ooia002 = '10'  #現金
                  LET l_nmag002 = '5'   #零用金
               WHEN g_ooie_d[l_ac].ooia002 = '20'  #銀行電匯款
                  LET l_nmag002 = '1'   #不限制
               WHEN g_ooie_d[l_ac].ooia002 = '30'  #票據
                  LET l_nmag002 = '4'   #票據往來
               OTHERWISE
                  LET l_nmag002 = '1'
            END CASE
            #140930-00020#17 add end---
            
            #160509-00004#2--add--str--lujh
            IF g_ooie_d[l_ac].ooie034 = 'N' THEN 
               CALL cl_set_comp_entry("ooie035",FALSE)
               CALL cl_set_comp_entry("ooie036",TRUE)
            ELSE             
               CALL cl_set_comp_entry("ooie035",TRUE)
            END IF
            
            IF g_ooie_d[l_ac].ooie035 = 'N' THEN 
               CALL cl_set_comp_entry("ooie036",FALSE)
            ELSE
               CALL cl_set_comp_entry("ooie036",TRUE)
            END IF
            #160509-00004#2--add--end--lujh
            #end add-point  
            
 
 
 
        
         BEFORE INSERT
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            INITIALIZE g_ooie_d_t.* TO NULL
            INITIALIZE g_ooie_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_ooie_d[l_ac].* TO NULL
            #公用欄位預設值
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_ooie2_d[l_ac].ooieownid = g_user
      LET g_ooie2_d[l_ac].ooieowndp = g_dept
      LET g_ooie2_d[l_ac].ooiecrtid = g_user
      LET g_ooie2_d[l_ac].ooiecrtdp = g_dept 
      LET g_ooie2_d[l_ac].ooiecrtdt = cl_get_current()
      LET g_ooie2_d[l_ac].ooiemodid = g_user
      LET g_ooie2_d[l_ac].ooiemoddt = cl_get_current()
      LET g_ooie_d[l_ac].ooiestus = ''
 
 
  
            #一般欄位預設值
                  LET g_ooie_d[l_ac].ooiestus = "Y"
      LET g_ooie_d[l_ac].ooia002 = "10"
      LET g_ooie_d[l_ac].ooie031 = "0"
      LET g_ooie_d[l_ac].ooie037 = "0"
      LET g_ooie_d[l_ac].ooie038 = "0"
      LET g_ooie_d[l_ac].ooie003 = "N"
      LET g_ooie_d[l_ac].ooie006 = "0"
      LET g_ooie_d[l_ac].ooie008 = "N"
      LET g_ooie_d[l_ac].ooie033 = "1"
      LET g_ooie_d[l_ac].ooie034 = "Y"
      LET g_ooie_d[l_ac].ooie035 = "N"
      LET g_ooie_d[l_ac].ooie039 = "N"
 
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            LET g_ooie3_d[l_ac].ooiepos = "N"
            #160215-00002#15 160509 by sakura(S)
            SELECT MAX(ooie033)+1 INTO g_ooie_d[l_ac].ooie033
              FROM ooie_t
             WHERE ooieent = g_enterprise
               AND ooiesite = g_ooie_m.ooiesite
            IF cl_null(g_ooie_d[l_ac].ooie033) OR g_ooie_d[l_ac].ooie033 = 0 THEN
               LET g_ooie_d[l_ac].ooie033 = 1
            END IF        
            CALL cl_set_comp_entry("ooie036",FALSE)        #160509-00004#2 add lujh       
            #160215-00002#15 160509 by sakura(E)
            #end add-point
            LET g_ooie_d_t.* = g_ooie_d[l_ac].*     #新輸入資料
            LET g_ooie_d_o.* = g_ooie_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aooi901_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL aooi901_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_ooie_d[li_reproduce_target].* = g_ooie_d[li_reproduce].*
               LET g_ooie2_d[li_reproduce_target].* = g_ooie2_d[li_reproduce].*
               LET g_ooie3_d[li_reproduce_target].* = g_ooie3_d[li_reproduce].*
 
               LET g_ooie_d[g_ooie_d.getLength()].ooie001 = NULL
 
            END IF
            
 
 
 
            #add-point:modify段before insert name="input.body.before_insert"
            
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
            SELECT COUNT(1) INTO l_count FROM ooie_t 
             WHERE ooieent = g_enterprise AND ooiesite = g_ooie_m.ooiesite
 
               AND ooie001 = g_ooie_d[l_ac].ooie001
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
               INSERT INTO ooie_t
                           (ooieent,
                            ooiesite,
                            ooie001
                            ,ooiestus,ooie002,ooie031,ooie037,ooie038,ooie003,ooie004,ooie005,ooie006,ooie007,ooie008,ooiestamp,ooie030,ooie032,ooie033,ooie034,ooie035,ooie036,ooie040,ooie039,ooieownid,ooieowndp,ooiecrtid,ooiecrtdp,ooiecrtdt,ooiemodid,ooiemoddt,ooie009,ooie010,ooie011,ooie012,ooie013,ooie014,ooie015,ooie016,ooie017,ooie018,ooie019,ooie020,ooie021,ooie022,ooie023,ooie024,ooie025,ooie026,ooie027,ooie028,ooie029,ooiepos) 
                     VALUES(g_enterprise,
                            g_ooie_m.ooiesite,
                            g_ooie_d[l_ac].ooie001
                            ,g_ooie_d[l_ac].ooiestus,g_ooie_d[l_ac].ooie002,g_ooie_d[l_ac].ooie031,g_ooie_d[l_ac].ooie037, 
                                g_ooie_d[l_ac].ooie038,g_ooie_d[l_ac].ooie003,g_ooie_d[l_ac].ooie004, 
                                g_ooie_d[l_ac].ooie005,g_ooie_d[l_ac].ooie006,g_ooie_d[l_ac].ooie007, 
                                g_ooie_d[l_ac].ooie008,g_ooie_d[l_ac].ooiestamp,g_ooie_d[l_ac].ooie030, 
                                g_ooie_d[l_ac].ooie032,g_ooie_d[l_ac].ooie033,g_ooie_d[l_ac].ooie034, 
                                g_ooie_d[l_ac].ooie035,g_ooie_d[l_ac].ooie036,g_ooie_d[l_ac].ooie040, 
                                g_ooie_d[l_ac].ooie039,g_ooie2_d[l_ac].ooieownid,g_ooie2_d[l_ac].ooieowndp, 
                                g_ooie2_d[l_ac].ooiecrtid,g_ooie2_d[l_ac].ooiecrtdp,g_ooie2_d[l_ac].ooiecrtdt, 
                                g_ooie2_d[l_ac].ooiemodid,g_ooie2_d[l_ac].ooiemoddt,g_ooie3_d[l_ac].ooie009, 
                                g_ooie3_d[l_ac].ooie010,g_ooie3_d[l_ac].ooie011,g_ooie3_d[l_ac].ooie012, 
                                g_ooie3_d[l_ac].ooie013,g_ooie3_d[l_ac].ooie014,g_ooie3_d[l_ac].ooie015, 
                                g_ooie3_d[l_ac].ooie016,g_ooie3_d[l_ac].ooie017,g_ooie3_d[l_ac].ooie018, 
                                g_ooie3_d[l_ac].ooie019,g_ooie3_d[l_ac].ooie020,g_ooie3_d[l_ac].ooie021, 
                                g_ooie3_d[l_ac].ooie022,g_ooie3_d[l_ac].ooie023,g_ooie3_d[l_ac].ooie024, 
                                g_ooie3_d[l_ac].ooie025,g_ooie3_d[l_ac].ooie026,g_ooie3_d[l_ac].ooie027, 
                                g_ooie3_d[l_ac].ooie028,g_ooie3_d[l_ac].ooie029,g_ooie3_d[l_ac].ooiepos) 
 
               #add-point:單身新增中 name="input.body.m_insert"
               
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_ooie_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "ooie_t:",SQLERRMESSAGE 
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
               IF aooi901_before_delete() THEN 
                  
 
 
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_ooie_m.ooiesite
 
                  LET gs_keys[gs_keys.getLength()+1] = g_ooie_d_t.ooie001
 
 
                  #刪除下層單身
                  IF NOT aooi901_key_delete_b(gs_keys,'ooie_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE aooi901_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE aooi901_bcl
               LET l_count = g_ooie_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_ooie_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooiestus
            #add-point:BEFORE FIELD ooiestus name="input.b.page1.ooiestus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooiestus
            
            #add-point:AFTER FIELD ooiestus name="input.a.page1.ooiestus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooiestus
            #add-point:ON CHANGE ooiestus name="input.g.page1.ooiestus"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie001
            
            #add-point:AFTER FIELD ooie001 name="input.a.page1.ooie001"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_ooie_m.ooiesite IS NOT NULL AND g_ooie_d[g_detail_idx].ooie001 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_ooie_m.ooiesite != g_ooiesite_t OR g_ooie_d[g_detail_idx].ooie001 != g_ooie_d_t.ooie001)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM ooie_t WHERE "||"ooieent = '" ||g_enterprise|| "' AND "||"ooiesite = '"||g_ooie_m.ooiesite ||"' AND "|| "ooie001 = '"||g_ooie_d[g_detail_idx].ooie001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_ooie_d[l_ac].ooie001) THEN 
               CALL aooi901_ooie001_chk()
               IF NOT cl_null(g_errno) THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = g_errno
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET g_ooie_d[l_ac].ooie001 = g_ooie_d_t.ooie001
                  NEXT FIELD ooie001
               END IF
               IF g_ooie_d[l_ac].ooie008 = 'Y' THEN 
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n
                    FROM ooie_t
                   WHERE ooieent = g_enterprise
                     AND ooiesite = g_ooie_m.ooiesite
                     AND ooie001 IN (SELECT ooia001 FROM ooia_t
                                      WHERE ooia002 = (SELECT b.ooia002 FROM ooia_t b WHERE b.ooia001 = g_ooie_d[l_ac].ooie001 
                                      AND ooiaent = g_enterprise #160905-00007#9  add 
                                     ))
                     AND ooie001 <> g_ooie_d[l_ac].ooie001
                     AND ooie008 ='Y'
                  IF l_n > 0 THEN 
                     LET g_ooie_d[l_ac].ooie001 = g_ooie_d_t.ooie001
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = 'aoo-00385'
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD ooie001
                  END IF 
               END IF 
               IF l_cmd = 'a' THEN 
                  LET g_ooie3_d[l_ac].ooie009 = g_ooie_d[l_ac].ooie001
               END IF 
               IF l_cmd = 'a' OR (l_cmd = 'u' AND g_ooie_d[l_ac].ooie001 != g_ooie_d_t.ooie001) THEN 
                  CALL aooi901_ooie_display()
               END IF
               #140930-00020#17 add ------
               CASE
                  WHEN g_ooie_d[l_ac].ooia002 = '10'  #現金
                     LET l_nmag002 = '5'   #零用金
                  WHEN g_ooie_d[l_ac].ooia002 = '20'  #銀行電匯款
                     LET l_nmag002 = '1'   #不限制
                  WHEN g_ooie_d[l_ac].ooia002 = '30'  #票據
                     LET l_nmag002 = '4'   #票據往來
                  OTHERWISE
                     LET l_nmag002 = '1'
               END CASE
               #140930-00020#17 add end---
            END IF
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ooie_d[l_ac].ooie001
            CALL ap_ref_array2(g_ref_fields,"SELECT ooial003 FROM ooial_t WHERE ooialent='"||g_enterprise||"' AND ooial001=? AND ooial002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_ooie_d[l_ac].ooie001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_ooie_d[l_ac].ooie001_desc

            #ADDED BY LANJJ 2015-12-24 ---s---
            IF l_cmd = 'a' THEN
               SELECT ooif032 INTO l_ooie032
                 FROM ooif_t
                WHERE ooifent = g_enterprise
                  AND ooif000 = g_ooie_m.rtaa001
                  AND ooif001 = g_ooie_d[l_ac].ooie001
               LET g_ooie_d[l_ac].ooie032 = l_ooie032
               DISPLAY BY NAME g_ooie_d[l_ac].ooie032
            END IF 
            #ADDED BY LANJJ 2015-12-24 ---e---
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie001
            #add-point:BEFORE FIELD ooie001 name="input.b.page1.ooie001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooie001
            #add-point:ON CHANGE ooie001 name="input.g.page1.ooie001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie002
            
            #add-point:AFTER FIELD ooie002 name="input.a.page1.ooie002"
            IF NOT cl_null(g_ooie_d[l_ac].ooie002) THEN 
               IF NOT ap_chk_isExist(g_ooie_d[l_ac].ooie002,"SELECT COUNT(*) FROM ooaj_t,ooef_t WHERE ooefent = ooajent AND ooef014 = ooaj001 AND ooef001 = '"||g_ooie_m.ooiesite||"' AND "||"ooajent = '" ||g_enterprise|| "' AND "||"ooaj002 = ? ",'aoo-00175',0) THEN 
                  LET g_ooie_d[l_ac].ooie002 = g_ooie_d_t.ooie002 
                  NEXT FIELD CURRENT
               END IF
               IF NOT ap_chk_isExist(g_ooie_d[l_ac].ooie002,"SELECT COUNT(*) FROM ooaj_t,ooef_t WHERE ooefent = ooajent AND ooef014 = ooaj001 AND ooef001 = '"||g_ooie_m.ooiesite||"' AND "||"ooajent = '" ||g_enterprise|| "' AND "||"ooaj002 = ? AND ooajstus = 'Y' ",'sub-01302',"aooi150") THEN  #aoo-00176 #160318-00005#33 by 07900-mod 
                  LET g_ooie_d[l_ac].ooie002 = g_ooie_d_t.ooie002 
                  NEXT FIELD CURRENT
               END IF                
            END IF
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ooie_d[l_ac].ooie002
            CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_ooie_d[l_ac].ooie002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_ooie_d[l_ac].ooie002_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie002
            #add-point:BEFORE FIELD ooie002 name="input.b.page1.ooie002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooie002
            #add-point:ON CHANGE ooie002 name="input.g.page1.ooie002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie031
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooie_d[l_ac].ooie031,"0","1","100","1","azz-00087",1) THEN
               NEXT FIELD ooie031
            END IF 
 
 
 
            #add-point:AFTER FIELD ooie031 name="input.a.page1.ooie031"
            IF NOT cl_null(g_ooie_d[l_ac].ooie031) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie031
            #add-point:BEFORE FIELD ooie031 name="input.b.page1.ooie031"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooie031
            #add-point:ON CHANGE ooie031 name="input.g.page1.ooie031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie037
            #add-point:BEFORE FIELD ooie037 name="input.b.page1.ooie037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie037
            
            #add-point:AFTER FIELD ooie037 name="input.a.page1.ooie037"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooie037
            #add-point:ON CHANGE ooie037 name="input.g.page1.ooie037"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie038
            #add-point:BEFORE FIELD ooie038 name="input.b.page1.ooie038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie038
            
            #add-point:AFTER FIELD ooie038 name="input.a.page1.ooie038"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooie038
            #add-point:ON CHANGE ooie038 name="input.g.page1.ooie038"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie003
            #add-point:BEFORE FIELD ooie003 name="input.b.page1.ooie003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie003
            
            #add-point:AFTER FIELD ooie003 name="input.a.page1.ooie003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooie003
            #add-point:ON CHANGE ooie003 name="input.g.page1.ooie003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie004
            #add-point:BEFORE FIELD ooie004 name="input.b.page1.ooie004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie004
            
            #add-point:AFTER FIELD ooie004 name="input.a.page1.ooie004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooie004
            #add-point:ON CHANGE ooie004 name="input.g.page1.ooie004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie005
            #add-point:BEFORE FIELD ooie005 name="input.b.page1.ooie005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie005
            
            #add-point:AFTER FIELD ooie005 name="input.a.page1.ooie005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooie005
            #add-point:ON CHANGE ooie005 name="input.g.page1.ooie005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie006
            #add-point:BEFORE FIELD ooie006 name="input.b.page1.ooie006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie006
            
            #add-point:AFTER FIELD ooie006 name="input.a.page1.ooie006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooie006
            #add-point:ON CHANGE ooie006 name="input.g.page1.ooie006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie007
            #add-point:BEFORE FIELD ooie007 name="input.b.page1.ooie007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie007
            
            #add-point:AFTER FIELD ooie007 name="input.a.page1.ooie007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooie007
            #add-point:ON CHANGE ooie007 name="input.g.page1.ooie007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie008
            #add-point:BEFORE FIELD ooie008 name="input.b.page1.ooie008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie008
            
            #add-point:AFTER FIELD ooie008 name="input.a.page1.ooie008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooie008
            #add-point:ON CHANGE ooie008 name="input.g.page1.ooie008"
            IF g_ooie_d[l_ac].ooie008 = 'Y' THEN 
               LET l_n = 0
               SELECT COUNT(*) INTO l_n
                 FROM ooie_t
                WHERE ooieent = g_enterprise
                  AND ooiesite = g_ooie_m.ooiesite
                  AND ooie001 IN (SELECT ooia001 FROM ooia_t
                                   WHERE ooia002 = (SELECT b.ooia002 FROM ooia_t b WHERE b.ooia001 = g_ooie_d[l_ac].ooie001
                                     AND ooiaent = g_enterprise #160905-00007#9  add
                                   ))
                  AND ooie001 <> g_ooie_d[l_ac].ooie001
                  AND ooie008 = 'Y'
               IF l_n > 0 THEN 
                  LET g_ooie_d[l_ac].ooie008 = 'N' 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = 'aoo-00385'
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD ooie008
               END IF 
            END IF 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooiestamp
            #add-point:BEFORE FIELD ooiestamp name="input.b.page1.ooiestamp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooiestamp
            
            #add-point:AFTER FIELD ooiestamp name="input.a.page1.ooiestamp"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooiestamp
            #add-point:ON CHANGE ooiestamp name="input.g.page1.ooiestamp"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie030
            
            #add-point:AFTER FIELD ooie030 name="input.a.page1.ooie030"
            #140930-00020#17 add ------
            IF NOT cl_null(g_ooie_d[l_ac].ooie030) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_ooie_d[l_ac].ooie030 != g_ooie_d_t.ooie030 OR g_ooie_d_t.ooie030 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_ooie_d[l_ac].ooie030
                  LET g_chkparam.arg2 = g_comp
                  LET g_chkparam.arg3 = l_nmag002
                  #160318-00025#26  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="ade-00010:sub-01302|anmi120|",cl_get_progname("anmi120",g_lang,"2"),"|:EXEPROGanmi120"
                  #160318-00025#26  by 07900 --add-end
                  IF NOT cl_chk_exist("v_nmas002_4") THEN
                     LET g_ooie_d[l_ac].ooie030 = g_ooie_d_t.ooie030
                     NEXT FIELD CURRENT 
                  END IF                         
               END IF
            END IF
            #140930-00020#17 add end---
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie030
            #add-point:BEFORE FIELD ooie030 name="input.b.page1.ooie030"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooie030
            #add-point:ON CHANGE ooie030 name="input.g.page1.ooie030"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie032
            #add-point:BEFORE FIELD ooie032 name="input.b.page1.ooie032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie032
            
            #add-point:AFTER FIELD ooie032 name="input.a.page1.ooie032"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooie032
            #add-point:ON CHANGE ooie032 name="input.g.page1.ooie032"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie033
            #add-point:BEFORE FIELD ooie033 name="input.b.page1.ooie033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie033
            
            #add-point:AFTER FIELD ooie033 name="input.a.page1.ooie033"
            #160215-00002#15 160524 by sakura(S)
            IF NOT cl_null(g_ooie_d[l_ac].ooie033) THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_ooie_d[l_ac].ooie033 != g_ooie_d_t.ooie033 OR g_ooie_d_t.ooie033 IS null)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM ooie_t WHERE "||"ooieent = '" ||g_enterprise|| "' AND "||"ooiesite = '"||g_ooie_m.ooiesite ||"' AND "|| "ooie033 = '"||g_ooie_d[g_detail_idx].ooie033 ||"'",'std-00004',0) THEN 
                       LET g_ooie_d[l_ac].ooie033 = g_ooie_d_o.ooie033
                       NEXT FIELD CURRENT
                  END IF
               END IF  
            END IF     
            LET g_ooie_d_o.ooie033 = g_ooie_d[l_ac].ooie033
            #160215-00002#15 160524 by sakura(E)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooie033
            #add-point:ON CHANGE ooie033 name="input.g.page1.ooie033"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie034
            #add-point:BEFORE FIELD ooie034 name="input.b.page1.ooie034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie034
            
            #add-point:AFTER FIELD ooie034 name="input.a.page1.ooie034"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooie034
            #add-point:ON CHANGE ooie034 name="input.g.page1.ooie034"
            #160509-00004#2--add--str--lujh
            IF g_ooie_d[l_ac].ooie034 = 'N' THEN 
               LET g_ooie_d[l_ac].ooie035 = 'Y'
               CALL cl_set_comp_entry("ooie035",FALSE)
               CALL cl_set_comp_entry("ooie036",TRUE)
            ELSE    
               CALL cl_set_comp_entry("ooie035",TRUE)            
            END IF
            #160509-00004#2--add--end--lujh
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie035
            #add-point:BEFORE FIELD ooie035 name="input.b.page1.ooie035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie035
            
            #add-point:AFTER FIELD ooie035 name="input.a.page1.ooie035"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooie035
            #add-point:ON CHANGE ooie035 name="input.g.page1.ooie035"
            #160509-00004#2--add--str--lujh
            IF g_ooie_d[l_ac].ooie035 = 'N' THEN 
               LET g_ooie_d[l_ac].ooie036 = ''
               LET g_ooie_d[l_ac].ooie036_desc = ''  
               CALL cl_set_comp_entry("ooie036",FALSE)
            ELSE
               CALL cl_set_comp_entry("ooie036",TRUE)
            END IF
            #160509-00004#2--add--end--lujh
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie036
            
            #add-point:AFTER FIELD ooie036 name="input.a.page1.ooie036"
            #160509-00004#4--add--str--lujh
            IF NOT cl_null(g_ooie_d[l_ac].ooie036) THEN 
#應用 a17 樣板自動產生(Version:3)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
 
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_ooie_d[l_ac].ooie036

                  
               #呼叫檢查存在並帶值的library
               #IF cl_chk_exist("v_ooef001") THEN     #161019-00017#1
               IF cl_chk_exist("v_ooef001_13") THEN   #161019-00017#1
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  LET g_ooie_d[l_ac].ooie036 = g_ooie_d_t.ooie036
                  CALL s_desc_get_department_desc(g_ooie_d[l_ac].ooie036) RETURNING g_ooie_d[l_ac].ooie036_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 
            CALL s_desc_get_department_desc(g_ooie_d[l_ac].ooie036) RETURNING g_ooie_d[l_ac].ooie036_desc
            #160509-00004#4--add--end--lujh
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie036
            #add-point:BEFORE FIELD ooie036 name="input.b.page1.ooie036"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooie036
            #add-point:ON CHANGE ooie036 name="input.g.page1.ooie036"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie040
            
            #add-point:AFTER FIELD ooie040 name="input.a.page1.ooie040"
            #160509-00004#42--add--str--lujh
            IF NOT cl_null(g_ooie_d[l_ac].ooie040)  THEN
               CALL s_department_chk(g_ooie_d[l_ac].ooie040,g_today) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_ooie_d[l_ac].ooie040 = g_ooie_d_t.ooie040
                  CALL s_desc_get_department_desc(g_ooie_d[l_ac].ooie040) RETURNING g_ooie_d[l_ac].ooie040_desc
                  DISPLAY BY NAME g_ooie_d[l_ac].ooie040_desc
                  NEXT FIELD CURRENT
               END IF
               
               #160509-00004#94--add--str--lujh
               SELECT ooeg009 INTO l_ooeg009
                 FROM ooeg_t
                WHERE ooegent = g_enterprise
                  AND ooeg001 = g_ooie_d[l_ac].ooie040
                  
               IF l_ooeg009 <> g_comp THEN 
                  INITIALIZE g_errparam TO NULL  
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "aoo-00709" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET g_ooie_d[l_ac].ooie040 = g_ooie_d_t.ooie040
                  CALL s_desc_get_department_desc(g_ooie_d[l_ac].ooie040) RETURNING g_ooie_d[l_ac].ooie040_desc
                  DISPLAY BY NAME g_ooie_d[l_ac].ooie040_desc
                  NEXT FIELD CURRENT
               END IF
               #160509-00004#94--add--end--lujh
            END IF        
            CALL s_desc_get_department_desc(g_ooie_d[l_ac].ooie040) RETURNING g_ooie_d[l_ac].ooie040_desc
            DISPLAY BY NAME g_ooie_d[l_ac].ooie040_desc
            #160509-00004#42--add--end--lujh
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie040
            #add-point:BEFORE FIELD ooie040 name="input.b.page1.ooie040"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooie040
            #add-point:ON CHANGE ooie040 name="input.g.page1.ooie040"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie039
            #add-point:BEFORE FIELD ooie039 name="input.b.page1.ooie039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie039
            
            #add-point:AFTER FIELD ooie039 name="input.a.page1.ooie039"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooie039
            #add-point:ON CHANGE ooie039 name="input.g.page1.ooie039"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.ooiestus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooiestus
            #add-point:ON ACTION controlp INFIELD ooiestus name="input.c.page1.ooiestus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.ooie001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie001
            #add-point:ON ACTION controlp INFIELD ooie001 name="input.c.page1.ooie001"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooie_d[l_ac].ooie001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooia001_04()                                #呼叫開窗

            LET g_ooie_d[l_ac].ooie001 = g_qryparam.return1              

            DISPLAY g_ooie_d[l_ac].ooie001 TO ooie001              #
            CALL aooi901_ooie001_desc()
            NEXT FIELD ooie001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.ooie002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie002
            #add-point:ON ACTION controlp INFIELD ooie002 name="input.c.page1.ooie002"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooie_d[l_ac].ooie002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            CALL q_ooaj002()                                #呼叫開窗
            LET g_ooie_d[l_ac].ooie002 = g_qryparam.return1              
            DISPLAY g_ooie_d[l_ac].ooie002 TO ooie002              #
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ooie_d[l_ac].ooie002
            CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_ooie_d[l_ac].ooie002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_ooie_d[l_ac].ooie002_desc
            NEXT FIELD ooie002                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.ooie031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie031
            #add-point:ON ACTION controlp INFIELD ooie031 name="input.c.page1.ooie031"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.ooie037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie037
            #add-point:ON ACTION controlp INFIELD ooie037 name="input.c.page1.ooie037"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.ooie038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie038
            #add-point:ON ACTION controlp INFIELD ooie038 name="input.c.page1.ooie038"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.ooie003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie003
            #add-point:ON ACTION controlp INFIELD ooie003 name="input.c.page1.ooie003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.ooie004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie004
            #add-point:ON ACTION controlp INFIELD ooie004 name="input.c.page1.ooie004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.ooie005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie005
            #add-point:ON ACTION controlp INFIELD ooie005 name="input.c.page1.ooie005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.ooie006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie006
            #add-point:ON ACTION controlp INFIELD ooie006 name="input.c.page1.ooie006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.ooie007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie007
            #add-point:ON ACTION controlp INFIELD ooie007 name="input.c.page1.ooie007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.ooie008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie008
            #add-point:ON ACTION controlp INFIELD ooie008 name="input.c.page1.ooie008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.ooiestamp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooiestamp
            #add-point:ON ACTION controlp INFIELD ooiestamp name="input.c.page1.ooiestamp"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.ooie030
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie030
            #add-point:ON ACTION controlp INFIELD ooie030 name="input.c.page1.ooie030"
            #140930-00020#17 add ------
            #開窗i段-對應銀行帳戶
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_ooie_d[l_ac].ooie030
            LET g_qryparam.where = " nmaa002 IN (SELECT ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"'",
                                   "                AND ooef017 = '",g_comp,"')",
                                   " AND EXISTS(SELECT 1 FROM nmag_t WHERE nmag001 = nmaa003 ",
                                   "               AND nmagent = ",g_enterprise, #160905-00007#9 
                                   "               AND nmag002 IN ('1','",l_nmag002,"'))"
            CALL q_nmas_01()
            LET g_ooie_d[l_ac].ooie030 = g_qryparam.return1
            CALL s_desc_get_nmas002_desc(g_ooie_d[l_ac].ooie030) RETURNING g_ooie_d[l_ac].ooie030_desc
            DISPLAY BY NAME g_ooie_d[l_ac].ooie030,g_ooie_d[l_ac].ooie030_desc
            NEXT FIELD ooie030
            #140930-00020#17 add end---
            #END add-point
 
 
         #Ctrlp:input.c.page1.ooie032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie032
            #add-point:ON ACTION controlp INFIELD ooie032 name="input.c.page1.ooie032"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.ooie033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie033
            #add-point:ON ACTION controlp INFIELD ooie033 name="input.c.page1.ooie033"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.ooie034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie034
            #add-point:ON ACTION controlp INFIELD ooie034 name="input.c.page1.ooie034"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.ooie035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie035
            #add-point:ON ACTION controlp INFIELD ooie035 name="input.c.page1.ooie035"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.ooie036
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie036
            #add-point:ON ACTION controlp INFIELD ooie036 name="input.c.page1.ooie036"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            #160509-00004#2--add--str--lujh
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_ooie_d[l_ac].ooie036             #給予default值
            LET g_qryparam.default2 = "" #g_ooie_d[l_ac].ooef001 #组织编号
            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            #CALL q_ooef001()     #161019-00017#1
            CALL q_ooef001_1()   #161019-00017#1
            LET g_ooie_d[l_ac].ooie036 = g_qryparam.return1              

            DISPLAY g_ooie_d[l_ac].ooie036 TO ooie036              #
            CALL s_desc_get_department_desc(g_ooie_d[l_ac].ooie036) RETURNING g_ooie_d[l_ac].ooie036_desc
            DISPLAY g_ooie_d[l_ac].ooie036_desc TO ooie036_desc
            NEXT FIELD ooie036                          #返回原欄位
            #160509-00004#2--add--end--lujh


            #END add-point
 
 
         #Ctrlp:input.c.page1.ooie040
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie040
            #add-point:ON ACTION controlp INFIELD ooie040 name="input.c.page1.ooie040"
            #160509-00004#42--add--str--lujh
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_ooie_d[l_ac].ooie040             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_today
            LET g_qryparam.arg2 = g_comp
 
            CALL q_ooeg001_3()                                #呼叫開窗   #160509-00004#94 change q_ooeg001_4 to q_ooeg001_3 lujh
 
            LET g_ooie_d[l_ac].ooie040 = g_qryparam.return1              

            DISPLAY g_ooie_d[l_ac].ooie040 TO ooie040              #
            CALL s_desc_get_department_desc(g_ooie_d[l_ac].ooie040) RETURNING g_ooie_d[l_ac].ooie040_desc
            NEXT FIELD ooie040                          #返回原欄位
            #160509-00004#42--add--end--lujh
            #END add-point
 
 
         #Ctrlp:input.c.page1.ooie039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie039
            #add-point:ON ACTION controlp INFIELD ooie039 name="input.c.page1.ooie039"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_ooie_d[l_ac].* = g_ooie_d_t.*
               CLOSE aooi901_bcl
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
               LET g_errparam.extend = g_ooie_d[l_ac].ooie001 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_ooie_d[l_ac].* = g_ooie_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               LET g_ooie2_d[l_ac].ooiemodid = g_user 
LET g_ooie2_d[l_ac].ooiemoddt = cl_get_current()
LET g_ooie2_d[l_ac].ooiemodid_desc = cl_get_username(g_ooie2_d[l_ac].ooiemodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
         
               #將遮罩欄位還原
               CALL aooi901_ooie_t_mask_restore('restore_mask_o')
         
               UPDATE ooie_t SET (ooiesite,ooiestus,ooie001,ooie002,ooie031,ooie037,ooie038,ooie003, 
                   ooie004,ooie005,ooie006,ooie007,ooie008,ooiestamp,ooie030,ooie032,ooie033,ooie034, 
                   ooie035,ooie036,ooie040,ooie039,ooieownid,ooieowndp,ooiecrtid,ooiecrtdp,ooiecrtdt, 
                   ooiemodid,ooiemoddt,ooie009,ooie010,ooie011,ooie012,ooie013,ooie014,ooie015,ooie016, 
                   ooie017,ooie018,ooie019,ooie020,ooie021,ooie022,ooie023,ooie024,ooie025,ooie026,ooie027, 
                   ooie028,ooie029,ooiepos) = (g_ooie_m.ooiesite,g_ooie_d[l_ac].ooiestus,g_ooie_d[l_ac].ooie001, 
                   g_ooie_d[l_ac].ooie002,g_ooie_d[l_ac].ooie031,g_ooie_d[l_ac].ooie037,g_ooie_d[l_ac].ooie038, 
                   g_ooie_d[l_ac].ooie003,g_ooie_d[l_ac].ooie004,g_ooie_d[l_ac].ooie005,g_ooie_d[l_ac].ooie006, 
                   g_ooie_d[l_ac].ooie007,g_ooie_d[l_ac].ooie008,g_ooie_d[l_ac].ooiestamp,g_ooie_d[l_ac].ooie030, 
                   g_ooie_d[l_ac].ooie032,g_ooie_d[l_ac].ooie033,g_ooie_d[l_ac].ooie034,g_ooie_d[l_ac].ooie035, 
                   g_ooie_d[l_ac].ooie036,g_ooie_d[l_ac].ooie040,g_ooie_d[l_ac].ooie039,g_ooie2_d[l_ac].ooieownid, 
                   g_ooie2_d[l_ac].ooieowndp,g_ooie2_d[l_ac].ooiecrtid,g_ooie2_d[l_ac].ooiecrtdp,g_ooie2_d[l_ac].ooiecrtdt, 
                   g_ooie2_d[l_ac].ooiemodid,g_ooie2_d[l_ac].ooiemoddt,g_ooie3_d[l_ac].ooie009,g_ooie3_d[l_ac].ooie010, 
                   g_ooie3_d[l_ac].ooie011,g_ooie3_d[l_ac].ooie012,g_ooie3_d[l_ac].ooie013,g_ooie3_d[l_ac].ooie014, 
                   g_ooie3_d[l_ac].ooie015,g_ooie3_d[l_ac].ooie016,g_ooie3_d[l_ac].ooie017,g_ooie3_d[l_ac].ooie018, 
                   g_ooie3_d[l_ac].ooie019,g_ooie3_d[l_ac].ooie020,g_ooie3_d[l_ac].ooie021,g_ooie3_d[l_ac].ooie022, 
                   g_ooie3_d[l_ac].ooie023,g_ooie3_d[l_ac].ooie024,g_ooie3_d[l_ac].ooie025,g_ooie3_d[l_ac].ooie026, 
                   g_ooie3_d[l_ac].ooie027,g_ooie3_d[l_ac].ooie028,g_ooie3_d[l_ac].ooie029,g_ooie3_d[l_ac].ooiepos) 
 
                WHERE ooieent = g_enterprise AND ooiesite = g_ooie_m.ooiesite 
 
                 AND ooie001 = g_ooie_d_t.ooie001 #項次   
 
                 
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "ooie_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "ooie_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_ooie_m.ooiesite
               LET gs_keys_bak[1] = g_ooiesite_t
               LET gs_keys[2] = g_ooie_d[g_detail_idx].ooie001
               LET gs_keys_bak[2] = g_ooie_d_t.ooie001
               CALL aooi901_update_b('ooie_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_ooie_m),util.JSON.stringify(g_ooie_d_t)
                     LET g_log2 = util.JSON.stringify(g_ooie_m),util.JSON.stringify(g_ooie_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aooi901_ooie_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_ooie_m.ooiesite
 
               LET ls_keys[ls_keys.getLength()+1] = g_ooie_d_t.ooie001
 
               CALL aooi901_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE aooi901_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_ooie_d[l_ac].* = g_ooie_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE aooi901_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_ooie_d.getLength() = 0 THEN
               NEXT FIELD ooie001
            END IF
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_ooie_d[li_reproduce_target].* = g_ooie_d[li_reproduce].*
               LET g_ooie2_d[li_reproduce_target].* = g_ooie2_d[li_reproduce].*
               LET g_ooie3_d[li_reproduce_target].* = g_ooie3_d[li_reproduce].*
 
               LET g_ooie_d[li_reproduce_target].ooie001 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_ooie_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_ooie_d.getLength()+1
            END IF
            
      END INPUT
 
      INPUT ARRAY g_ooie3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b, WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                   INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                   DELETE ROW = FALSE,
                   APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
                 
         BEFORE INPUT
            
            CALL aooi901_b_fill(g_wc2) #test 
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
            CALL aooi901_idx_chk()
            
            CALL s_transaction_begin()
            IF g_rec_b >= l_ac THEN
               LET l_cmd='u'
               CALL aooi901_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body3.before_row.set_entry_b"
               IF g_ooie3_d[l_ac].ooie013 = 'Y' THEN 
                  CALL cl_set_comp_entry("ooie014",TRUE)
               ELSE
                  CALL cl_set_comp_entry("ooie014",FALSE)
               END IF 
               #end add-point
               CALL aooi901_set_no_entry_b(l_cmd)
               LET g_ooie3_d_t.* = g_ooie3_d[l_ac].*   #BACKUP  #page1
               LET g_ooie3_d_o.* = g_ooie3_d[l_ac].*   #BACKUP  #page1
            END IF 
            
 
 
 
    
         BEFORE INSERT
            LET g_insert = 'Y' 
            NEXT FIELD ooie001
 
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            INITIALIZE g_ooie3_d_t.* TO NULL
            INITIALIZE g_ooie3_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_ooie3_d[l_ac].* TO NULL
            #公用欄位預設值
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_ooie2_d[l_ac].ooieownid = g_user
      LET g_ooie2_d[l_ac].ooieowndp = g_dept
      LET g_ooie2_d[l_ac].ooiecrtid = g_user
      LET g_ooie2_d[l_ac].ooiecrtdp = g_dept 
      LET g_ooie2_d[l_ac].ooiecrtdt = cl_get_current()
      LET g_ooie2_d[l_ac].ooiemodid = g_user
      LET g_ooie2_d[l_ac].ooiemoddt = cl_get_current()
      LET g_ooie_d[l_ac].ooiestus = ''
 
 
  
            #一般欄位預設值
                  LET g_ooie3_d[l_ac].ooie012 = "N"
      LET g_ooie3_d[l_ac].ooie013 = "N"
      LET g_ooie3_d[l_ac].ooie015 = "N"
      LET g_ooie3_d[l_ac].ooie016 = "N"
      LET g_ooie3_d[l_ac].ooie017 = "Y"
      LET g_ooie3_d[l_ac].ooie018 = "N"
      LET g_ooie3_d[l_ac].ooie019 = "N"
      LET g_ooie3_d[l_ac].ooie020 = "N"
      LET g_ooie3_d[l_ac].ooie021 = "N"
      LET g_ooie3_d[l_ac].ooie022 = "N"
      LET g_ooie3_d[l_ac].ooie023 = "N"
 
            
            #add-point:modify段before備份 name="input.body3.before_insert.before_bak"
            
            #end add-point
            LET g_ooie3_d_t.* = g_ooie3_d[l_ac].*     #新輸入資料
            LET g_ooie3_d_o.* = g_ooie3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aooi901_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body3.before_insert.set_entry_b"
            
            #end add-point
            CALL aooi901_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_ooie_d[li_reproduce_target].* = g_ooie_d[li_reproduce].*
               LET g_ooie2_d[li_reproduce_target].* = g_ooie2_d[li_reproduce].*
               LET g_ooie3_d[li_reproduce_target].* = g_ooie3_d[li_reproduce].*
 
               LET g_ooie3_d[li_reproduce_target].ooie001 = NULL
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
               IF aooi901_before_delete() THEN 
                  
 
 
 
  
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_ooie_m.ooiesite
                  LET gs_keys[gs_keys.getLength()+1] = g_ooie_d_t.ooie001
 
                  #刪除下層單身
                  IF NOT aooi901_key_delete_b(gs_keys,'ooie_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE aooi901_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE aooi901_bcl
               CALL s_transaction_end('Y','0') 
               LET l_count = g_ooie3_d.getLength()
            END IF
            
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body3.after_delete"
               
               #end add-point
                              CALL aooi901_delete_b('ooie_t',gs_keys,"'3'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_ooie3_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_ooie3_d[l_ac].* = g_ooie3_d_t.*
               CLOSE aooi901_bcl
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
               LET g_errparam.extend = g_ooie_d[l_ac].ooie001 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_ooie3_d[l_ac].* = g_ooie3_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               LET g_ooie2_d[l_ac].ooiemodid = g_user 
LET g_ooie2_d[l_ac].ooiemoddt = cl_get_current()
LET g_ooie2_d[l_ac].ooiemodid_desc = cl_get_username(g_ooie2_d[l_ac].ooiemodid)
                
               #add-point:單身修改前 name="modify.body3.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL aooi901_ooie_t_mask_restore('restore_mask_o')
                     
               UPDATE ooie_t SET (ooiesite,ooiestus,ooie001,ooie002,ooie031,ooie037,ooie038,ooie003, 
                   ooie004,ooie005,ooie006,ooie007,ooie008,ooiestamp,ooie030,ooie032,ooie033,ooie034, 
                   ooie035,ooie036,ooie040,ooie039,ooieownid,ooieowndp,ooiecrtid,ooiecrtdp,ooiecrtdt, 
                   ooiemodid,ooiemoddt,ooie009,ooie010,ooie011,ooie012,ooie013,ooie014,ooie015,ooie016, 
                   ooie017,ooie018,ooie019,ooie020,ooie021,ooie022,ooie023,ooie024,ooie025,ooie026,ooie027, 
                   ooie028,ooie029,ooiepos) = (g_ooie_m.ooiesite,g_ooie_d[l_ac].ooiestus,g_ooie_d[l_ac].ooie001, 
                   g_ooie_d[l_ac].ooie002,g_ooie_d[l_ac].ooie031,g_ooie_d[l_ac].ooie037,g_ooie_d[l_ac].ooie038, 
                   g_ooie_d[l_ac].ooie003,g_ooie_d[l_ac].ooie004,g_ooie_d[l_ac].ooie005,g_ooie_d[l_ac].ooie006, 
                   g_ooie_d[l_ac].ooie007,g_ooie_d[l_ac].ooie008,g_ooie_d[l_ac].ooiestamp,g_ooie_d[l_ac].ooie030, 
                   g_ooie_d[l_ac].ooie032,g_ooie_d[l_ac].ooie033,g_ooie_d[l_ac].ooie034,g_ooie_d[l_ac].ooie035, 
                   g_ooie_d[l_ac].ooie036,g_ooie_d[l_ac].ooie040,g_ooie_d[l_ac].ooie039,g_ooie2_d[l_ac].ooieownid, 
                   g_ooie2_d[l_ac].ooieowndp,g_ooie2_d[l_ac].ooiecrtid,g_ooie2_d[l_ac].ooiecrtdp,g_ooie2_d[l_ac].ooiecrtdt, 
                   g_ooie2_d[l_ac].ooiemodid,g_ooie2_d[l_ac].ooiemoddt,g_ooie3_d[l_ac].ooie009,g_ooie3_d[l_ac].ooie010, 
                   g_ooie3_d[l_ac].ooie011,g_ooie3_d[l_ac].ooie012,g_ooie3_d[l_ac].ooie013,g_ooie3_d[l_ac].ooie014, 
                   g_ooie3_d[l_ac].ooie015,g_ooie3_d[l_ac].ooie016,g_ooie3_d[l_ac].ooie017,g_ooie3_d[l_ac].ooie018, 
                   g_ooie3_d[l_ac].ooie019,g_ooie3_d[l_ac].ooie020,g_ooie3_d[l_ac].ooie021,g_ooie3_d[l_ac].ooie022, 
                   g_ooie3_d[l_ac].ooie023,g_ooie3_d[l_ac].ooie024,g_ooie3_d[l_ac].ooie025,g_ooie3_d[l_ac].ooie026, 
                   g_ooie3_d[l_ac].ooie027,g_ooie3_d[l_ac].ooie028,g_ooie3_d[l_ac].ooie029,g_ooie3_d[l_ac].ooiepos)  
                   #自訂欄位頁簽
                WHERE ooieent = g_enterprise AND ooiesite = g_ooie_m.ooiesite
                 AND ooie001 = g_ooie3_d_t.ooie001 #項次 
               #add-point:單身修改中 name="modify.body3.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "ooie_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "ooie_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_ooie_m.ooiesite
               LET gs_keys_bak[1] = g_ooiesite_t
               LET gs_keys[2] = g_ooie3_d[g_detail_idx].ooie001
               LET gs_keys_bak[2] = g_ooie3_d_t.ooie001
               CALL aooi901_update_b('ooie_t',gs_keys,gs_keys_bak,"'3'")
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_ooie_m),util.JSON.stringify(g_ooie3_d_t)
                     LET g_log2 = util.JSON.stringify(g_ooie_m),util.JSON.stringify(g_ooie3_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aooi901_ooie_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="modify.body3.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie009
            #add-point:BEFORE FIELD ooie009 name="input.b.page3.ooie009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie009
            
            #add-point:AFTER FIELD ooie009 name="input.a.page3.ooie009"
            IF NOT cl_null(g_ooie3_d[l_ac].ooie009) THEN
               #150505-00002#1--mark by dongsz--str---            
#               CALL aooi901_ooie009_chk(l_cmd)
#               IF NOT cl_null(g_errno) THEN 
#                  INITIALIZE g_errparam TO NULL 
#                  LET g_errparam.extend = "" 
#                  LET g_errparam.code   = g_errno
#                  LET g_errparam.popup  = TRUE 
#                  CALL cl_err()
#                  LET g_ooie3_d[l_ac].ooie009 = g_ooie3_d_t.ooie009
#                  NEXT FIELD ooie009
#               END IF
               #150505-00002#1--mark by dongsz--end--- 
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooie009
            #add-point:ON CHANGE ooie009 name="input.g.page3.ooie009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie010
            #add-point:BEFORE FIELD ooie010 name="input.b.page3.ooie010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie010
            
            #add-point:AFTER FIELD ooie010 name="input.a.page3.ooie010"
            IF NOT cl_null(g_ooie3_d[l_ac].ooie010) THEN 
               IF l_cmd = 'a' OR (l_cmd = 'u' AND g_ooie3_d[l_ac].ooie010 != g_ooie3_d_t.ooie010) THEN 
                  LET g_ooie3_d[l_ac].ooie011 = g_ooie3_d[l_ac].ooie010
               END IF 
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooie010
            #add-point:ON CHANGE ooie010 name="input.g.page3.ooie010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie011
            #add-point:BEFORE FIELD ooie011 name="input.b.page3.ooie011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie011
            
            #add-point:AFTER FIELD ooie011 name="input.a.page3.ooie011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooie011
            #add-point:ON CHANGE ooie011 name="input.g.page3.ooie011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie012
            #add-point:BEFORE FIELD ooie012 name="input.b.page3.ooie012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie012
            
            #add-point:AFTER FIELD ooie012 name="input.a.page3.ooie012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooie012
            #add-point:ON CHANGE ooie012 name="input.g.page3.ooie012"
            #IF g_ooie3_d[l_ac].ooie012 = 'Y' THEN
            #   LET l_n = 0
            #   SELECT COUNT(*) INTO l_n
            #     FROM ooie_t
            #    WHERE ooieent = g_enterprise
            #      AND ooiesite = g_ooie_m.ooiesite
            #      AND ooie001 <> g_ooie3_d[l_ac].ooie001
            #      AND ooie012 = 'Y'
            #   IF l_n > 0 THEN
            #      LET g_ooie3_d[l_ac].ooie012 = 'N'
            #      INITIALIZE g_errparam TO NULL
            #      LET g_errparam.extend = ""
            #      LET g_errparam.code   = 'aoo-00385'
            #      LET g_errparam.popup  = TRUE
            #      CALL cl_err()
            #      NEXT FIELD ooie008
            #   END IF
            #END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie013
            #add-point:BEFORE FIELD ooie013 name="input.b.page3.ooie013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie013
            
            #add-point:AFTER FIELD ooie013 name="input.a.page3.ooie013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooie013
            #add-point:ON CHANGE ooie013 name="input.g.page3.ooie013"
            IF g_ooie3_d[l_ac].ooie013 = 'Y' THEN 
               CALL cl_set_comp_entry("ooie014",TRUE)
            ELSE
               LET g_ooie3_d[l_ac].ooie014 = ''
               CALL cl_set_comp_entry("ooie014",FALSE)
            END IF 
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie014
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ooie3_d[l_ac].ooie014,"0","1","","","azz-00079",1) THEN
               NEXT FIELD ooie014
            END IF 
 
 
 
            #add-point:AFTER FIELD ooie014 name="input.a.page3.ooie014"
            IF NOT cl_null(g_ooie3_d[l_ac].ooie014) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie014
            #add-point:BEFORE FIELD ooie014 name="input.b.page3.ooie014"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooie014
            #add-point:ON CHANGE ooie014 name="input.g.page3.ooie014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie015
            #add-point:BEFORE FIELD ooie015 name="input.b.page3.ooie015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie015
            
            #add-point:AFTER FIELD ooie015 name="input.a.page3.ooie015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooie015
            #add-point:ON CHANGE ooie015 name="input.g.page3.ooie015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie016
            #add-point:BEFORE FIELD ooie016 name="input.b.page3.ooie016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie016
            
            #add-point:AFTER FIELD ooie016 name="input.a.page3.ooie016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooie016
            #add-point:ON CHANGE ooie016 name="input.g.page3.ooie016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie017
            #add-point:BEFORE FIELD ooie017 name="input.b.page3.ooie017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie017
            
            #add-point:AFTER FIELD ooie017 name="input.a.page3.ooie017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooie017
            #add-point:ON CHANGE ooie017 name="input.g.page3.ooie017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie018
            #add-point:BEFORE FIELD ooie018 name="input.b.page3.ooie018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie018
            
            #add-point:AFTER FIELD ooie018 name="input.a.page3.ooie018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooie018
            #add-point:ON CHANGE ooie018 name="input.g.page3.ooie018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie019
            #add-point:BEFORE FIELD ooie019 name="input.b.page3.ooie019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie019
            
            #add-point:AFTER FIELD ooie019 name="input.a.page3.ooie019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooie019
            #add-point:ON CHANGE ooie019 name="input.g.page3.ooie019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie020
            #add-point:BEFORE FIELD ooie020 name="input.b.page3.ooie020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie020
            
            #add-point:AFTER FIELD ooie020 name="input.a.page3.ooie020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooie020
            #add-point:ON CHANGE ooie020 name="input.g.page3.ooie020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie021
            #add-point:BEFORE FIELD ooie021 name="input.b.page3.ooie021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie021
            
            #add-point:AFTER FIELD ooie021 name="input.a.page3.ooie021"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooie021
            #add-point:ON CHANGE ooie021 name="input.g.page3.ooie021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie022
            #add-point:BEFORE FIELD ooie022 name="input.b.page3.ooie022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie022
            
            #add-point:AFTER FIELD ooie022 name="input.a.page3.ooie022"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooie022
            #add-point:ON CHANGE ooie022 name="input.g.page3.ooie022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie023
            #add-point:BEFORE FIELD ooie023 name="input.b.page3.ooie023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie023
            
            #add-point:AFTER FIELD ooie023 name="input.a.page3.ooie023"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooie023
            #add-point:ON CHANGE ooie023 name="input.g.page3.ooie023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie024
            #add-point:BEFORE FIELD ooie024 name="input.b.page3.ooie024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie024
            
            #add-point:AFTER FIELD ooie024 name="input.a.page3.ooie024"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooie024
            #add-point:ON CHANGE ooie024 name="input.g.page3.ooie024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie025
            #add-point:BEFORE FIELD ooie025 name="input.b.page3.ooie025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie025
            
            #add-point:AFTER FIELD ooie025 name="input.a.page3.ooie025"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooie025
            #add-point:ON CHANGE ooie025 name="input.g.page3.ooie025"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie026
            #add-point:BEFORE FIELD ooie026 name="input.b.page3.ooie026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie026
            
            #add-point:AFTER FIELD ooie026 name="input.a.page3.ooie026"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooie026
            #add-point:ON CHANGE ooie026 name="input.g.page3.ooie026"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie027
            #add-point:BEFORE FIELD ooie027 name="input.b.page3.ooie027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie027
            
            #add-point:AFTER FIELD ooie027 name="input.a.page3.ooie027"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooie027
            #add-point:ON CHANGE ooie027 name="input.g.page3.ooie027"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie028
            #add-point:BEFORE FIELD ooie028 name="input.b.page3.ooie028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie028
            
            #add-point:AFTER FIELD ooie028 name="input.a.page3.ooie028"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooie028
            #add-point:ON CHANGE ooie028 name="input.g.page3.ooie028"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooie029
            #add-point:BEFORE FIELD ooie029 name="input.b.page3.ooie029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooie029
            
            #add-point:AFTER FIELD ooie029 name="input.a.page3.ooie029"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooie029
            #add-point:ON CHANGE ooie029 name="input.g.page3.ooie029"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooiepos
            #add-point:BEFORE FIELD ooiepos name="input.b.page3.ooiepos"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooiepos
            
            #add-point:AFTER FIELD ooiepos name="input.a.page3.ooiepos"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooiepos
            #add-point:ON CHANGE ooiepos name="input.g.page3.ooiepos"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.ooie009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie009
            #add-point:ON ACTION controlp INFIELD ooie009 name="input.c.page3.ooie009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.ooie010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie010
            #add-point:ON ACTION controlp INFIELD ooie010 name="input.c.page3.ooie010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.ooie011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie011
            #add-point:ON ACTION controlp INFIELD ooie011 name="input.c.page3.ooie011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.ooie012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie012
            #add-point:ON ACTION controlp INFIELD ooie012 name="input.c.page3.ooie012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.ooie013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie013
            #add-point:ON ACTION controlp INFIELD ooie013 name="input.c.page3.ooie013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.ooie014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie014
            #add-point:ON ACTION controlp INFIELD ooie014 name="input.c.page3.ooie014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.ooie015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie015
            #add-point:ON ACTION controlp INFIELD ooie015 name="input.c.page3.ooie015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.ooie016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie016
            #add-point:ON ACTION controlp INFIELD ooie016 name="input.c.page3.ooie016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.ooie017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie017
            #add-point:ON ACTION controlp INFIELD ooie017 name="input.c.page3.ooie017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.ooie018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie018
            #add-point:ON ACTION controlp INFIELD ooie018 name="input.c.page3.ooie018"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.ooie019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie019
            #add-point:ON ACTION controlp INFIELD ooie019 name="input.c.page3.ooie019"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.ooie020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie020
            #add-point:ON ACTION controlp INFIELD ooie020 name="input.c.page3.ooie020"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.ooie021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie021
            #add-point:ON ACTION controlp INFIELD ooie021 name="input.c.page3.ooie021"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.ooie022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie022
            #add-point:ON ACTION controlp INFIELD ooie022 name="input.c.page3.ooie022"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.ooie023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie023
            #add-point:ON ACTION controlp INFIELD ooie023 name="input.c.page3.ooie023"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.ooie024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie024
            #add-point:ON ACTION controlp INFIELD ooie024 name="input.c.page3.ooie024"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.ooie025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie025
            #add-point:ON ACTION controlp INFIELD ooie025 name="input.c.page3.ooie025"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.ooie026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie026
            #add-point:ON ACTION controlp INFIELD ooie026 name="input.c.page3.ooie026"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.ooie027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie027
            #add-point:ON ACTION controlp INFIELD ooie027 name="input.c.page3.ooie027"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.ooie028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie028
            #add-point:ON ACTION controlp INFIELD ooie028 name="input.c.page3.ooie028"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.ooie029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooie029
            #add-point:ON ACTION controlp INFIELD ooie029 name="input.c.page3.ooie029"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.ooiepos
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooiepos
            #add-point:ON ACTION controlp INFIELD ooiepos name="input.c.page3.ooiepos"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:input段after row name="input.body3.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_ooie3_d[l_ac].* = g_ooie3_d_t.*
               END IF
               CLOSE aooi901_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               EXIT DIALOG 
            END IF
 
            CLOSE aooi901_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #add-point:input段after input  name="input.body3.after_input"
            
            #end add-point    
 
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_ooie_d[li_reproduce_target].* = g_ooie_d[li_reproduce].*
               LET g_ooie2_d[li_reproduce_target].* = g_ooie2_d[li_reproduce].*
               LET g_ooie3_d[li_reproduce_target].* = g_ooie3_d[li_reproduce].*
 
               LET g_ooie3_d[li_reproduce_target].ooie001 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_ooie3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_ooie3_d.getLength()+1
            END IF
      END INPUT
 
      
      DISPLAY ARRAY g_ooie2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
      
         BEFORE ROW
            CALL aooi901_b_fill(g_wc2) #test 
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_page = 2
            CALL aooi901_idx_chk()
            CALL aooi901_ui_detailshow()
        
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
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD ooiesite
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD ooiestus
               WHEN "s_detail2"
                  NEXT FIELD ooie001_2
               WHEN "s_detail3"
                  NEXT FIELD ooie001_3
 
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
 
 
   
   #add-point:input段after_input name="input.after_input"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aooi901.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aooi901_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   CALL aooi901_ooiesite_desc()
   #140930-00020#17 add ------
   #抓取據點所屬法人
   SELECT ooef017 INTO g_comp
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_ooie_m.ooiesite
      AND ooefstus = 'Y'
   #140930-00020#17 add end---
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL aooi901_b_fill(g_wc2) #第一階單身填充
      CALL aooi901_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aooi901_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_ooie_m.ooiesite,g_ooie_m.ooiesite_desc,g_ooie_m.rtaa001,g_ooie_m.rtaa001_desc
 
   CALL aooi901_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
   
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="aooi901.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION aooi901_ref_show()
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
   FOR l_ac = 1 TO g_ooie_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"
 
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_ooie2_d.getLength()
      #add-point:ref_show段d2_reference name="ref_show.body2.reference"
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_ooie3_d.getLength()
      #add-point:ref_show段d3_reference name="ref_show.body3.reference"
      
      #end add-point
   END FOR
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="aooi901.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aooi901_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE ooie_t.ooiesite 
   DEFINE l_oldno     LIKE ooie_t.ooiesite 
 
   DEFINE l_master    RECORD LIKE ooie_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE ooie_t.* #此變數樣板目前無使用
 
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
 
   IF g_ooie_m.ooiesite IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_ooiesite_t = g_ooie_m.ooiesite
 
   
   LET g_ooie_m.ooiesite = ""
 
   LET g_master_insert = FALSE
   CALL aooi901_set_entry('a')
   CALL aooi901_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #清空key欄位的desc
      LET g_ooie_m.ooiesite_desc = ''
   DISPLAY BY NAME g_ooie_m.ooiesite_desc
 
   
   CALL aooi901_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_ooie_m.* TO NULL
      INITIALIZE g_ooie_d TO NULL
      INITIALIZE g_ooie2_d TO NULL
      INITIALIZE g_ooie3_d TO NULL
 
      CALL aooi901_show()
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
   CALL aooi901_set_act_visible()
   CALL aooi901_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_ooiesite_t = g_ooie_m.ooiesite
 
   
   #組合新增資料的條件
   LET g_add_browse = " ooieent = " ||g_enterprise|| " AND",
                      " ooiesite = '", g_ooie_m.ooiesite, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aooi901_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL aooi901_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL aooi901_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="aooi901.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION aooi901_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE ooie_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aooi901_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM ooie_t
    WHERE ooieent = g_enterprise AND ooiesite = g_ooiesite_t
 
       INTO TEMP aooi901_detail
   
   #將key修正為調整後   
   UPDATE aooi901_detail 
      #更新key欄位
      SET ooiesite = g_ooie_m.ooiesite
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
       , ooieownid = g_user 
       , ooieowndp = g_dept
       , ooiecrtid = g_user
       , ooiecrtdp = g_dept 
       , ooiecrtdt = ld_date
       , ooiemodid = g_user
       , ooiemoddt = ld_date
      #, ooiestus = "Y" 
 
 
 
                                       
   #將資料塞回原table   
   INSERT INTO ooie_t SELECT * FROM aooi901_detail
   
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
   DROP TABLE aooi901_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_ooiesite_t = g_ooie_m.ooiesite
 
   
   DROP TABLE aooi901_detail
   
END FUNCTION
 
{</section>}
 
{<section id="aooi901.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aooi901_delete()
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
   
   #end add-point
   
   IF g_ooie_m.ooiesite IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN aooi901_cl USING g_enterprise,g_ooie_m.ooiesite
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aooi901_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE aooi901_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aooi901_master_referesh USING g_ooie_m.ooiesite INTO g_ooie_m.ooiesite,g_ooie_m.ooiesite_desc 
 
   
   #遮罩相關處理
   LET g_ooie_m_mask_o.* =  g_ooie_m.*
   CALL aooi901_ooie_t_mask()
   LET g_ooie_m_mask_n.* =  g_ooie_m.*
   
   CALL aooi901_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aooi901_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM ooie_t WHERE ooieent = g_enterprise AND ooiesite = g_ooie_m.ooiesite
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ooie_t:",SQLERRMESSAGE 
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
      #   CLOSE aooi901_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_ooie_d.clear() 
      CALL g_ooie2_d.clear()       
      CALL g_ooie3_d.clear()       
 
     
      CALL aooi901_ui_browser_refresh()  
      #CALL aooi901_ui_headershow()  
      #CALL aooi901_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL aooi901_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL aooi901_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE aooi901_cl
 
   #功能已完成,通報訊息中心
   CALL aooi901_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="aooi901.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aooi901_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #先清空單身變數內容
   CALL g_ooie_d.clear()
   CALL g_ooie2_d.clear()
   CALL g_ooie3_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT ooiestus,ooie001,ooie002,ooie031,ooie037,ooie038,ooie003,ooie004,ooie005, 
       ooie006,ooie007,ooie008,ooiestamp,ooie030,ooie032,ooie033,ooie034,ooie035,ooie036,ooie040,ooie039, 
       ooie001,ooieownid,ooieowndp,ooiecrtid,ooiecrtdp,ooiecrtdt,ooiemodid,ooiemoddt,ooie001,ooie009, 
       ooie010,ooie011,ooie012,ooie013,ooie014,ooie015,ooie016,ooie017,ooie018,ooie019,ooie020,ooie021, 
       ooie022,ooie023,ooie024,ooie025,ooie026,ooie027,ooie028,ooie029,ooiepos,t1.ooial003 ,t2.ooail003 , 
       t3.ooefl003 ,t4.ooefl003 ,t5.ooag011 ,t6.ooefl003 ,t7.ooag011 ,t8.ooefl003 ,t9.ooag011 FROM ooie_t", 
          
               "",
               
                              " LEFT JOIN ooial_t t1 ON t1.ooialent="||g_enterprise||" AND t1.ooial001=ooie001 AND t1.ooial002='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t2 ON t2.ooailent="||g_enterprise||" AND t2.ooail001=ooie002 AND t2.ooail002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=ooie036 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=ooie040 AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=ooieownid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=ooieowndp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=ooiecrtid  ",
               " LEFT JOIN ooefl_t t8 ON t8.ooeflent="||g_enterprise||" AND t8.ooefl001=ooiecrtdp AND t8.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=ooiemodid  ",
 
               " WHERE ooieent= ? AND ooiesite=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("ooie_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF aooi901_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY ooie_t.ooie001"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
         
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aooi901_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR aooi901_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_ooie_m.ooiesite   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_ooie_m.ooiesite INTO g_ooie_d[l_ac].ooiestus,g_ooie_d[l_ac].ooie001, 
          g_ooie_d[l_ac].ooie002,g_ooie_d[l_ac].ooie031,g_ooie_d[l_ac].ooie037,g_ooie_d[l_ac].ooie038, 
          g_ooie_d[l_ac].ooie003,g_ooie_d[l_ac].ooie004,g_ooie_d[l_ac].ooie005,g_ooie_d[l_ac].ooie006, 
          g_ooie_d[l_ac].ooie007,g_ooie_d[l_ac].ooie008,g_ooie_d[l_ac].ooiestamp,g_ooie_d[l_ac].ooie030, 
          g_ooie_d[l_ac].ooie032,g_ooie_d[l_ac].ooie033,g_ooie_d[l_ac].ooie034,g_ooie_d[l_ac].ooie035, 
          g_ooie_d[l_ac].ooie036,g_ooie_d[l_ac].ooie040,g_ooie_d[l_ac].ooie039,g_ooie2_d[l_ac].ooie001, 
          g_ooie2_d[l_ac].ooieownid,g_ooie2_d[l_ac].ooieowndp,g_ooie2_d[l_ac].ooiecrtid,g_ooie2_d[l_ac].ooiecrtdp, 
          g_ooie2_d[l_ac].ooiecrtdt,g_ooie2_d[l_ac].ooiemodid,g_ooie2_d[l_ac].ooiemoddt,g_ooie3_d[l_ac].ooie001, 
          g_ooie3_d[l_ac].ooie009,g_ooie3_d[l_ac].ooie010,g_ooie3_d[l_ac].ooie011,g_ooie3_d[l_ac].ooie012, 
          g_ooie3_d[l_ac].ooie013,g_ooie3_d[l_ac].ooie014,g_ooie3_d[l_ac].ooie015,g_ooie3_d[l_ac].ooie016, 
          g_ooie3_d[l_ac].ooie017,g_ooie3_d[l_ac].ooie018,g_ooie3_d[l_ac].ooie019,g_ooie3_d[l_ac].ooie020, 
          g_ooie3_d[l_ac].ooie021,g_ooie3_d[l_ac].ooie022,g_ooie3_d[l_ac].ooie023,g_ooie3_d[l_ac].ooie024, 
          g_ooie3_d[l_ac].ooie025,g_ooie3_d[l_ac].ooie026,g_ooie3_d[l_ac].ooie027,g_ooie3_d[l_ac].ooie028, 
          g_ooie3_d[l_ac].ooie029,g_ooie3_d[l_ac].ooiepos,g_ooie_d[l_ac].ooie001_desc,g_ooie_d[l_ac].ooie002_desc, 
          g_ooie_d[l_ac].ooie036_desc,g_ooie_d[l_ac].ooie040_desc,g_ooie2_d[l_ac].ooieownid_desc,g_ooie2_d[l_ac].ooieowndp_desc, 
          g_ooie2_d[l_ac].ooiecrtid_desc,g_ooie2_d[l_ac].ooiecrtdp_desc,g_ooie2_d[l_ac].ooiemodid_desc  
            #(ver:49)
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充 name="b_fill.fill"
         SELECT ooia002 INTO g_ooie_d[l_ac].ooia002
           FROM ooia_t
          WHERE ooiaent = g_enterprise
            AND ooia001 = g_ooie_d[l_ac].ooie001
         #add by yangxf ---start---
         LET g_ooie3_d[l_ac].ooie001_1_desc = g_ooie_d[l_ac].ooie001_desc
         #add by yangxf ----end----
         
         #對應的銀行帳戶名稱
         CALL s_desc_get_nmas002_desc(g_ooie_d[l_ac].ooie030) RETURNING g_ooie_d[l_ac].ooie030_desc #140930-00020#17
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
 
            CALL g_ooie_d.deleteElement(g_ooie_d.getLength())
      CALL g_ooie2_d.deleteElement(g_ooie2_d.getLength())
      CALL g_ooie3_d.deleteElement(g_ooie3_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
   
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_ooie_d.getLength()
      LET g_ooie_d_mask_o[l_ac].* =  g_ooie_d[l_ac].*
      CALL aooi901_ooie_t_mask()
      LET g_ooie_d_mask_n[l_ac].* =  g_ooie_d[l_ac].*
   END FOR
   
   LET g_ooie2_d_mask_o.* =  g_ooie2_d.*
   FOR l_ac = 1 TO g_ooie2_d.getLength()
      LET g_ooie2_d_mask_o[l_ac].* =  g_ooie2_d[l_ac].*
      CALL aooi901_ooie_t_mask()
      LET g_ooie2_d_mask_n[l_ac].* =  g_ooie2_d[l_ac].*
   END FOR
   LET g_ooie3_d_mask_o.* =  g_ooie3_d.*
   FOR l_ac = 1 TO g_ooie3_d.getLength()
      LET g_ooie3_d_mask_o[l_ac].* =  g_ooie3_d[l_ac].*
      CALL aooi901_ooie_t_mask()
      LET g_ooie3_d_mask_n[l_ac].* =  g_ooie3_d[l_ac].*
   END FOR
 
 
   FREE aooi901_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="aooi901.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION aooi901_idx_chk()
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
      IF g_detail_idx > g_ooie_d.getLength() THEN
         LET g_detail_idx = g_ooie_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_ooie_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_ooie_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_ooie2_d.getLength() THEN
         LET g_detail_idx = g_ooie2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_ooie2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_ooie2_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_ooie3_d.getLength() THEN
         LET g_detail_idx = g_ooie3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_ooie3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_ooie3_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aooi901.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aooi901_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_ooie_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="aooi901.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION aooi901_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   
   #end add-point
   
   DELETE FROM ooie_t
    WHERE ooieent = g_enterprise AND ooiesite = g_ooie_m.ooiesite AND
 
          ooie001 = g_ooie_d_t.ooie001
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "ooie_t:",SQLERRMESSAGE 
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
 
{<section id="aooi901.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aooi901_delete_b(ps_table,ps_keys_bak,ps_page)
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
 
{<section id="aooi901.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aooi901_insert_b(ps_table,ps_keys,ps_page)
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
 
{<section id="aooi901.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aooi901_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
 
{<section id="aooi901.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION aooi901_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_ooie_d[l_ac].ooie001 = g_ooie_d_t.ooie001 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="aooi901.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION aooi901_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="aooi901.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aooi901_lock_b(ps_table,ps_page)
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
   #CALL aooi901_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aooi901.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aooi901_unlock_b(ps_table,ps_page)
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
 
{<section id="aooi901.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aooi901_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("ooiesite",TRUE)
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
 
{<section id="aooi901.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aooi901_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("ooiesite",FALSE)
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
 
{<section id="aooi901.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aooi901_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aooi901.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aooi901_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="aooi901.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aooi901_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aooi901.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aooi901_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aooi901.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION aooi901_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aooi901.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION aooi901_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aooi901.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aooi901_default_search()
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
      LET ls_wc = ls_wc, " ooiesite = '", g_argv[01], "' AND "
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
   LET g_wc = " 1=1"
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aooi901.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION aooi901_fill_chk(ps_idx)
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
 
{<section id="aooi901.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION aooi901_modify_detail_chk(ps_record)
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
         LET ls_return = "ooiestus"
      WHEN "s_detail2"
         LET ls_return = "ooie001_2"
      WHEN "s_detail3"
         LET ls_return = "ooie001_3"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="aooi901.mask_functions" >}
&include "erp/aoo/aooi901_mask.4gl"
 
{</section>}
 
{<section id="aooi901.state_change" >}
    
 
{</section>}
 
{<section id="aooi901.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aooi901_set_pk_array()
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
   LET g_pk_array[1].values = g_ooie_m.ooiesite
   LET g_pk_array[1].column = 'ooiesite'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aooi901.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aooi901_msgcentre_notify(lc_state)
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
   CALL aooi901_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_ooie_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aooi901.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aooi901_ooie001_desc()
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2014/09/16 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi901_ooie001_desc()

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_ooie_d[l_ac].ooie001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooial003 FROM ooial_t WHERE ooialent='"||g_enterprise||"' AND ooial001=? AND ooial002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_ooie_d[l_ac].ooie001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_ooie_d[l_ac].ooie001_desc
   
END FUNCTION

################################################################################
# Descriptions...: 款别检查
# Memo...........:
# Usage..........: CALL aooi901_ooie001_chk()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/09/01 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi901_ooie001_chk()
   DEFINE l_ooiastus   LIKE ooia_t.ooiastus
   DEFINE l_ooia002    LIKE ooia_t.ooia002
   DEFINE l_ooia012    LIKE ooia_t.ooia012
   
   LET g_errno = ''
   SELECT ooiastus,ooia002,ooia012 INTO l_ooiastus,l_ooia002,l_ooia012
     FROM ooia_t
    WHERE ooiaent = g_enterprise 
      AND ooia001 = g_ooie_d[l_ac].ooie001
   CASE WHEN SQLCA.SQLCODE = 100    LET g_errno = 'aoo-00364'
        WHEN l_ooiastus <> 'Y'      LET g_errno = 'aoo-00363'
        OTHERWISE                   LET g_errno = SQLCA.SQLCODE USING '-------'
   END CASE
   IF cl_null(g_errno) THEN 
      LET g_ooie_d[l_ac].ooia002 = l_ooia002
      LET g_ooie_d[l_ac].ooie003 = l_ooia012
   END IF 
END FUNCTION

################################################################################
# Descriptions...: POS款别检查
# Memo...........:
# Usage..........: CALL aooi901_ooie009_chk(p_cmd)
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/08/31 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi901_ooie009_chk(p_cmd)
   DEFINE l_ooiastus   LIKE ooia_t.ooiastus
   DEFINE l_ooia018    LIKE ooia_t.ooia018
   DEFINE l_ooia019    LIKE ooia_t.ooia019
   DEFINE p_cmd        LIKE type_t.chr1
   DEFINE l_n          LIKE type_t.num5
   
   LET g_errno = ''
   IF p_cmd = 'a' THEN 
      SELECT COUNT(*) INTO l_n
        FROM ooie_t
       WHERE ooiesite = g_ooie_m.ooiesite
         AND ooie009 = g_ooie3_d[l_ac].ooie009
         AND ooieent = g_enterprise    #170120-00054#1 add
   ELSE
      SELECT COUNT(*) INTO l_n
        FROM ooie_t
       WHERE ooiesite =  g_ooie_m.ooiesite
         AND ooie009 = g_ooie3_d[l_ac].ooie009
         AND ooie001 <> g_ooie_d[l_ac].ooie001
         AND ooieent = g_enterprise    #170120-00054#1 add
   END IF 
   IF l_n > 0 THEN 
      LET g_errno = 'aoo-00375'
   END IF 

END FUNCTION

################################################################################
# Descriptions...: 新增单身资料
# Memo...........:
# Usage..........: CALL aooi901_ooie_ins()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/09/03 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi901_ooie_ins()
   #DEFINE l_ooif    RECORD LIKE ooif_t.*  #161124-00048#13  2016/12/14 By 08734 mark
   #161124-00048#13  2016/12/14 By 08734 add(S)
   DEFINE l_ooif RECORD  #店群款別主檔
       ooifent LIKE ooif_t.ooifent, #企业编号
       ooifstus LIKE ooif_t.ooifstus, #状态及异动
       ooif000 LIKE ooif_t.ooif000, #店群编号
       ooif001 LIKE ooif_t.ooif001, #款别编号
       ooif002 LIKE ooif_t.ooif002, #款别指定币种
       ooif003 LIKE ooif_t.ooif003, #第三方代收缴款否
       ooif004 LIKE ooif_t.ooif004, #代收机构
       ooif005 LIKE ooif_t.ooif005, #代收手续费费率
       ooif006 LIKE ooif_t.ooif006, #代收手续费金额
       ooif007 LIKE ooif_t.ooif007, #生成代收账款单否
       ooif008 LIKE ooif_t.ooif008, #默认款别否
       ooif009 LIKE ooif_t.ooif009, #对应款别编号
       ooif010 LIKE ooif_t.ooif010, #显示名称
       ooif011 LIKE ooif_t.ooif011, #打印名称
       ooif012 LIKE ooif_t.ooif012, #是否实收折让
       ooif013 LIKE ooif_t.ooif013, #储值付款单次使用否
       ooif014 LIKE ooif_t.ooif014, #录入号码最小长度
       ooif015 LIKE ooif_t.ooif015, #可退款
       ooif016 LIKE ooif_t.ooif016, #可找零
       ooif017 LIKE ooif_t.ooif017, #下传款别
       ooif018 LIKE ooif_t.ooif018, #可溢收
       ooif019 LIKE ooif_t.ooif019, #是否运行接口程序
       ooif020 LIKE ooif_t.ooif020, #扣款金额自动取值
       ooif021 LIKE ooif_t.ooif021, #接口小数倍数
       ooif022 LIKE ooif_t.ooif022, #允许空单交易
       ooif023 LIKE ooif_t.ooif023, #transflag标记
       ooif024 LIKE ooif_t.ooif024, #接口程序返回的打印文件
       ooif025 LIKE ooif_t.ooif025, #运行的接口程序
       ooif026 LIKE ooif_t.ooif026, #运行接口传入的文件名
       ooif027 LIKE ooif_t.ooif027, #运行接口传入档数据类型ID
       ooif028 LIKE ooif_t.ooif028, #运行接口后返回接口档
       ooif029 LIKE ooif_t.ooif029, #运行接口返回档数据类型
       ooifstamp LIKE ooif_t.ooifstamp, #时间戳记
       ooifownid LIKE ooif_t.ooifownid, #资料所有者
       ooifowndp LIKE ooif_t.ooifowndp, #资料所有部门
       ooifcrtid LIKE ooif_t.ooifcrtid, #资料录入者
       ooifcrtdp LIKE ooif_t.ooifcrtdp, #资料录入部门
       ooifcrtdt LIKE ooif_t.ooifcrtdt, #资料创建日
       ooifmodid LIKE ooif_t.ooifmodid, #资料更改者
       ooifmoddt LIKE ooif_t.ooifmoddt, #最近更改日
       ooif031 LIKE ooif_t.ooif031, #标准手续费费率
       ooif032 LIKE ooif_t.ooif032, #券消费认列方式
       ooif033 LIKE ooif_t.ooif033, #资金入账是否当前据点
       ooif034 LIKE ooif_t.ooif034, #代收银否
       ooif035 LIKE ooif_t.ooif035, #代收银据点
       ooif036 LIKE ooif_t.ooif036, #刷卡上限金额
       ooif037 LIKE ooif_t.ooif037, #上限手续费率
       ooif038 LIKE ooif_t.ooif038, #税额扣抵顺序
       ooif039 LIKE ooif_t.ooif039 #收银缴款是否核对明细
END RECORD
#161124-00048#13  2016/12/14 By 08734 add(E)
   #DEFINE l_ooie    RECORD LIKE ooie_t.*  #161124-00048#13  2016/12/14 By 08734 mark
   #161124-00048#13  2016/12/14 By 08734 add(S)
   DEFINE l_ooie RECORD  #款別主檔
       ooieent LIKE ooie_t.ooieent, #企业编号
       ooiestus LIKE ooie_t.ooiestus, #状态码
       ooiesite LIKE ooie_t.ooiesite, #营运据点
       ooie001 LIKE ooie_t.ooie001, #款别编号
       ooie002 LIKE ooie_t.ooie002, #款别指定币种
       ooie003 LIKE ooie_t.ooie003, #第三方代收缴款否
       ooie004 LIKE ooie_t.ooie004, #代收机构
       ooie005 LIKE ooie_t.ooie005, #代收手续费费率
       ooie006 LIKE ooie_t.ooie006, #代收手续费金额
       ooie007 LIKE ooie_t.ooie007, #生成代收账款单否
       ooie008 LIKE ooie_t.ooie008, #默认款别否
       ooie009 LIKE ooie_t.ooie009, #对应款别编号
       ooie010 LIKE ooie_t.ooie010, #显示名称
       ooie011 LIKE ooie_t.ooie011, #打印名称
       ooie012 LIKE ooie_t.ooie012, #是否实收折让
       ooie013 LIKE ooie_t.ooie013, #储值付款单次使用否
       ooie014 LIKE ooie_t.ooie014, #录入号码最小长度
       ooie015 LIKE ooie_t.ooie015, #可退款
       ooie016 LIKE ooie_t.ooie016, #可找零
       ooie017 LIKE ooie_t.ooie017, #下传款别
       ooie018 LIKE ooie_t.ooie018, #可溢收
       ooie019 LIKE ooie_t.ooie019, #是否运行接口进程
       ooie020 LIKE ooie_t.ooie020, #扣款金额自动取值
       ooie021 LIKE ooie_t.ooie021, #接口小数倍数
       ooie022 LIKE ooie_t.ooie022, #允许空单交易
       ooie023 LIKE ooie_t.ooie023, #transflag标记
       ooie024 LIKE ooie_t.ooie024, #接口进程返回的打印文档
       ooie025 LIKE ooie_t.ooie025, #运行的接口进程
       ooie026 LIKE ooie_t.ooie026, #运行接口传入的文件名
       ooie027 LIKE ooie_t.ooie027, #运行接口传入档数据类型ID
       ooie028 LIKE ooie_t.ooie028, #运行接口后返回接口档
       ooie029 LIKE ooie_t.ooie029, #运行接口返回档数据类型
       ooiepos LIKE ooie_t.ooiepos, #下传否
       ooiestamp LIKE ooie_t.ooiestamp, #时间戳记
       ooieownid LIKE ooie_t.ooieownid, #资料所有者
       ooieowndp LIKE ooie_t.ooieowndp, #资料所有部门
       ooiecrtid LIKE ooie_t.ooiecrtid, #资料录入者
       ooiecrtdp LIKE ooie_t.ooiecrtdp, #资料录入部门
       ooiecrtdt LIKE ooie_t.ooiecrtdt, #资料创建日
       ooiemodid LIKE ooie_t.ooiemodid, #资料更改者
       ooiemoddt LIKE ooie_t.ooiemoddt, #最近更改日
       ooie030 LIKE ooie_t.ooie030, #对应的银存账户
       ooie031 LIKE ooie_t.ooie031, #标准卡手续费费率
       ooie032 LIKE ooie_t.ooie032, #券消费认列方式
       ooie033 LIKE ooie_t.ooie033, #税额扣抵顺序
       ooie034 LIKE ooie_t.ooie034, #资金入账是否当前据点
       ooie035 LIKE ooie_t.ooie035, #代收银否
       ooie036 LIKE ooie_t.ooie036, #代收银据点
       ooie037 LIKE ooie_t.ooie037, #刷卡上限金额
       ooie038 LIKE ooie_t.ooie038, #上限手续费率
       ooie039 LIKE ooie_t.ooie039, #收银缴款是否核对明细
       ooie040 LIKE ooie_t.ooie040 #手续费归属部门
END RECORD
#161124-00048#13  2016/12/14 By 08734 add(E)
   DEFINE l_n       LIKE type_t.num5
   
   LET l_n = 0
   IF cl_null(g_ooie_m.rtaa001) THEN 
      RETURN 
   END IF 
   #抓取店群设置款别资料
   SELECT COUNT(*) INTO l_n
     FROM ooif_t
    WHERE ooifent = g_enterprise
      AND ooif000 = g_ooie_m.rtaa001
   IF l_n = 0 THEN   
      RETURN 
   END IF 
   IF NOT cl_ask_confirm('aoo-00391') THEN
      RETURN
   END IF 
   #DECLARE ooif_curs CURSOR FOR SELECT * FROM ooif_t WHERE ooifent = g_enterprise AND ooif000 = g_ooie_m.rtaa001  #161124-00048#13  2016/12/14 By 08734 mark
   DECLARE ooif_curs CURSOR FOR SELECT ooifent,ooifstus,ooif000,ooif001,ooif002,ooif003,ooif004,ooif005,ooif006,ooif007,ooif008,ooif009,ooif010,ooif011,ooif012,ooif013,ooif014,ooif015,
       ooif016,ooif017,ooif018,ooif019,ooif020,ooif021,ooif022,ooif023,ooif024,ooif025,ooif026,ooif027,ooif028,ooif029,ooifstamp,ooifownid,ooifowndp,ooifcrtid,ooifcrtdp,
       ooifcrtdt,ooifmodid,ooifmoddt,ooif031,ooif032,ooif033,ooif034,ooif035,ooif036,ooif037,ooif038,ooif039 FROM ooif_t WHERE ooifent = g_enterprise AND ooif000 = g_ooie_m.rtaa001  #161124-00048#13  2016/12/14 By 08734 add
   FOREACH ooif_curs INTO l_ooif.*
      LET l_ooie.ooieent = g_enterprise
      LET l_ooie.ooiesite = g_ooie_m.ooiesite
      LET l_ooie.ooie001 = l_ooif.ooif001
      LET l_ooie.ooie002 = l_ooif.ooif002
      LET l_ooie.ooie003 = l_ooif.ooif003 
      LET l_ooie.ooie004 = l_ooif.ooif004 
      LET l_ooie.ooie005 = l_ooif.ooif005 
      LET l_ooie.ooie006 = l_ooif.ooif006 
      LET l_ooie.ooie007 = l_ooif.ooif007
      LET l_ooie.ooie008 = l_ooif.ooif008
      LET l_ooie.ooie009 = l_ooif.ooif009
      LET l_ooie.ooie010 = l_ooif.ooif010 
      LET l_ooie.ooie011 = l_ooif.ooif011 
      LET l_ooie.ooie012 = l_ooif.ooif012 
      LET l_ooie.ooie013 = l_ooif.ooif013 
      LET l_ooie.ooie014 = l_ooif.ooif014 
      LET l_ooie.ooie015 = l_ooif.ooif015 
      LET l_ooie.ooie016 = l_ooif.ooif016 
      LET l_ooie.ooie017 = l_ooif.ooif017 
      LET l_ooie.ooie018 = l_ooif.ooif018 
      LET l_ooie.ooie019 = l_ooif.ooif019 
      LET l_ooie.ooie020 = l_ooif.ooif020 
      LET l_ooie.ooie021 = l_ooif.ooif021 
      LET l_ooie.ooie022 = l_ooif.ooif022 
      LET l_ooie.ooie023 = l_ooif.ooif023 
      LET l_ooie.ooie024 = l_ooif.ooif024 
      LET l_ooie.ooie025 = l_ooif.ooif025 
      LET l_ooie.ooie026 = l_ooif.ooif026 
      LET l_ooie.ooie027 = l_ooif.ooif027 
      LET l_ooie.ooie028 = l_ooif.ooif028 
      LET l_ooie.ooie029 = l_ooif.ooif029
      LET l_ooie.ooie031 = l_ooif.ooif031
      LET l_ooie.ooiepos = 'N'
      LET l_ooie.ooieownid = g_user
      LET l_ooie.ooieowndp = g_dept
      LET l_ooie.ooiecrtid = g_user
      LET l_ooie.ooiecrtdp = g_dept 
      LET l_ooie.ooiecrtdt = cl_get_current()
      LET l_ooie.ooiemodid = ""
      LET l_ooie.ooiemoddt = ""
      LET l_ooie.ooiestus = 'Y'
      #INSERT INTO ooie_t VALUES(l_ooie.*)  #161124-00048#13  2016/12/14 By 08734 mark
      INSERT INTO ooie_t(ooieent,ooiestus,ooiesite,ooie001,ooie002,ooie003,ooie004,ooie005,ooie006,ooie007,ooie008,
       ooie009,ooie010,ooie011,ooie012,ooie013,ooie014,ooie015,ooie016,ooie017,ooie018,ooie019,ooie020,
       ooie021,ooie022,ooie023,ooie024,ooie025,ooie026,ooie027,ooie028,ooie029,ooiepos,ooiestamp,ooieownid,ooieowndp,ooiecrtid,ooiecrtdp,
       ooiecrtdt,ooiemodid,ooiemoddt,ooie030,ooie031,ooie032,ooie033,ooie034,ooie035,ooie036,ooie037,ooie038,ooie039,ooie040)  #161124-00048#13  2016/12/14 By 08734 add
         VALUES(l_ooie.ooieent,l_ooie.ooiestus,l_ooie.ooiesite,l_ooie.ooie001,l_ooie.ooie002,l_ooie.ooie003,l_ooie.ooie004,l_ooie.ooie005,l_ooie.ooie006,l_ooie.ooie007,l_ooie.ooie008,
       l_ooie.ooie009,l_ooie.ooie010,l_ooie.ooie011,l_ooie.ooie012,l_ooie.ooie013,l_ooie.ooie014,l_ooie.ooie015,l_ooie.ooie016,l_ooie.ooie017,l_ooie.ooie018,l_ooie.ooie019,l_ooie.ooie020,
       l_ooie.ooie021,l_ooie.ooie022,l_ooie.ooie023,l_ooie.ooie024,l_ooie.ooie025,l_ooie.ooie026,l_ooie.ooie027,l_ooie.ooie028,l_ooie.ooie029,l_ooie.ooiepos,l_ooie.ooiestamp,l_ooie.ooieownid,l_ooie.ooieowndp,l_ooie.ooiecrtid,l_ooie.ooiecrtdp,
       l_ooie.ooiecrtdt,l_ooie.ooiemodid,l_ooie.ooiemoddt,l_ooie.ooie030,l_ooie.ooie031,l_ooie.ooie032,l_ooie.ooie033,l_ooie.ooie034,l_ooie.ooie035,l_ooie.ooie036,l_ooie.ooie037,l_ooie.ooie038,l_ooie.ooie039,l_ooie.ooie040)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN
      END IF
   END FOREACH 
END FUNCTION

################################################################################
# Descriptions...: 带值
# Memo...........:
# Usage..........: CALL aooi901_ooie_display()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/09/03 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi901_ooie_display()
   #DEFINE l_ooia    RECORD LIKE ooia_t.*  #161124-00048#13  2016/12/14 By 08734 mark
   #161124-00048#13  2016/12/14 By 08734 add(S)
   DEFINE l_ooia RECORD  #款別主檔
       ooiaent LIKE ooia_t.ooiaent, #企业编号
       ooia001 LIKE ooia_t.ooia001, #款别编号
       ooia002 LIKE ooia_t.ooia002, #款别性质
       ooia003 LIKE ooia_t.ooia003, #本币否
       ooia004 LIKE ooia_t.ooia004, #交易凭证类型
       ooia005 LIKE ooia_t.ooia005, #POS集成否
       ooiastus LIKE ooia_t.ooiastus, #状态码
       ooia006 LIKE ooia_t.ooia006, #默认币种
       ooia007 LIKE ooia_t.ooia007, #上级款别
       ooia008 LIKE ooia_t.ooia008, #层级
       ooia009 LIKE ooia_t.ooia009, #下级款别数
       ooia010 LIKE ooia_t.ooia010, #所属一级款别
       ooia011 LIKE ooia_t.ooia011, #即期票据否
       ooia012 LIKE ooia_t.ooia012, #第三方代收缴款否
       ooia013 LIKE ooia_t.ooia013, #代收机构
       ooia014 LIKE ooia_t.ooia014, #代收手续费费率
       ooia015 LIKE ooia_t.ooia015, #代收手续费金额
       ooia016 LIKE ooia_t.ooia016, #生成代收账款单否
       ooia017 LIKE ooia_t.ooia017, #对应款别编号
       ooia018 LIKE ooia_t.ooia018, #显示名称
       ooia019 LIKE ooia_t.ooia019, #打印名称
       ooia020 LIKE ooia_t.ooia020, #是否实收折让
       ooia021 LIKE ooia_t.ooia021, #储值付款单次使用否
       ooia022 LIKE ooia_t.ooia022, #录入号码最小长度
       ooia023 LIKE ooia_t.ooia023, #可退款
       ooia024 LIKE ooia_t.ooia024, #可找零
       ooia025 LIKE ooia_t.ooia025, #下传款别
       ooia026 LIKE ooia_t.ooia026, #可溢收
       ooia027 LIKE ooia_t.ooia027, #是否运行接口程序
       ooia028 LIKE ooia_t.ooia028, #扣款金额自动取值
       ooia029 LIKE ooia_t.ooia029, #接口小数倍数
       ooia030 LIKE ooia_t.ooia030, #允许空单交易
       ooia031 LIKE ooia_t.ooia031, #transflag标记
       ooia032 LIKE ooia_t.ooia032, #接口程序返回的打印文件
       ooia033 LIKE ooia_t.ooia033, #运行的接口程序
       ooia034 LIKE ooia_t.ooia034, #运行接口传入的文件名
       ooia035 LIKE ooia_t.ooia035, #运行接口传入档数据类型ID
       ooia036 LIKE ooia_t.ooia036, #运行接口后返回接口档
       ooia037 LIKE ooia_t.ooia037, #运行接口返回档数据类型
       ooiaownid LIKE ooia_t.ooiaownid, #资料所有者
       ooiaowndp LIKE ooia_t.ooiaowndp, #资料所有部门
       ooiacrtid LIKE ooia_t.ooiacrtid, #资料录入者
       ooiacrtdp LIKE ooia_t.ooiacrtdp, #资料录入部门
       ooiacrtdt LIKE ooia_t.ooiacrtdt, #资料创建日
       ooiamodid LIKE ooia_t.ooiamodid, #资料更改者
       ooiamoddt LIKE ooia_t.ooiamoddt, #最近更改日
       ooia038 LIKE ooia_t.ooia038, #标准手续费费率
       ooia039 LIKE ooia_t.ooia039, #券消费认列方式
       ooia040 LIKE ooia_t.ooia040, #资金入账是否当前据点
       ooia041 LIKE ooia_t.ooia041, #代收银否
       ooia042 LIKE ooia_t.ooia042, #代收银据点
       ooia043 LIKE ooia_t.ooia043, #刷卡上限金额
       ooia044 LIKE ooia_t.ooia044, #上限手续费率
       ooia045 LIKE ooia_t.ooia045 #收银缴款是否核对明细
END RECORD
#161124-00048#13  2016/12/14 By 08734 add(E)
   #DEFINE l_ooif    RECORD LIKE ooif_t.*  #161124-00048#13  2016/12/14 By 08734 mark
   #161124-00048#13  2016/12/14 By 08734 add(S)
   DEFINE l_ooif RECORD  #店群款別主檔
       ooifent LIKE ooif_t.ooifent, #企业编号
       ooifstus LIKE ooif_t.ooifstus, #状态及异动
       ooif000 LIKE ooif_t.ooif000, #店群编号
       ooif001 LIKE ooif_t.ooif001, #款别编号
       ooif002 LIKE ooif_t.ooif002, #款别指定币种
       ooif003 LIKE ooif_t.ooif003, #第三方代收缴款否
       ooif004 LIKE ooif_t.ooif004, #代收机构
       ooif005 LIKE ooif_t.ooif005, #代收手续费费率
       ooif006 LIKE ooif_t.ooif006, #代收手续费金额
       ooif007 LIKE ooif_t.ooif007, #生成代收账款单否
       ooif008 LIKE ooif_t.ooif008, #默认款别否
       ooif009 LIKE ooif_t.ooif009, #对应款别编号
       ooif010 LIKE ooif_t.ooif010, #显示名称
       ooif011 LIKE ooif_t.ooif011, #打印名称
       ooif012 LIKE ooif_t.ooif012, #是否实收折让
       ooif013 LIKE ooif_t.ooif013, #储值付款单次使用否
       ooif014 LIKE ooif_t.ooif014, #录入号码最小长度
       ooif015 LIKE ooif_t.ooif015, #可退款
       ooif016 LIKE ooif_t.ooif016, #可找零
       ooif017 LIKE ooif_t.ooif017, #下传款别
       ooif018 LIKE ooif_t.ooif018, #可溢收
       ooif019 LIKE ooif_t.ooif019, #是否运行接口程序
       ooif020 LIKE ooif_t.ooif020, #扣款金额自动取值
       ooif021 LIKE ooif_t.ooif021, #接口小数倍数
       ooif022 LIKE ooif_t.ooif022, #允许空单交易
       ooif023 LIKE ooif_t.ooif023, #transflag标记
       ooif024 LIKE ooif_t.ooif024, #接口程序返回的打印文件
       ooif025 LIKE ooif_t.ooif025, #运行的接口程序
       ooif026 LIKE ooif_t.ooif026, #运行接口传入的文件名
       ooif027 LIKE ooif_t.ooif027, #运行接口传入档数据类型ID
       ooif028 LIKE ooif_t.ooif028, #运行接口后返回接口档
       ooif029 LIKE ooif_t.ooif029, #运行接口返回档数据类型
       ooifstamp LIKE ooif_t.ooifstamp, #时间戳记
       ooifownid LIKE ooif_t.ooifownid, #资料所有者
       ooifowndp LIKE ooif_t.ooifowndp, #资料所有部门
       ooifcrtid LIKE ooif_t.ooifcrtid, #资料录入者
       ooifcrtdp LIKE ooif_t.ooifcrtdp, #资料录入部门
       ooifcrtdt LIKE ooif_t.ooifcrtdt, #资料创建日
       ooifmodid LIKE ooif_t.ooifmodid, #资料更改者
       ooifmoddt LIKE ooif_t.ooifmoddt, #最近更改日
       ooif031 LIKE ooif_t.ooif031, #标准手续费费率
       ooif032 LIKE ooif_t.ooif032, #券消费认列方式
       ooif033 LIKE ooif_t.ooif033, #资金入账是否当前据点
       ooif034 LIKE ooif_t.ooif034, #代收银否
       ooif035 LIKE ooif_t.ooif035, #代收银据点
       ooif036 LIKE ooif_t.ooif036, #刷卡上限金额
       ooif037 LIKE ooif_t.ooif037, #上限手续费率
       ooif038 LIKE ooif_t.ooif038, #税额扣抵顺序
       ooif039 LIKE ooif_t.ooif039 #收银缴款是否核对明细
END RECORD
#161124-00048#13  2016/12/14 By 08734 add(E)
   DEFINE l_ooia002 LIKE ooia_t.ooia002
   DEFINE l_ooef016 LIKE ooef_t.ooef016
   
   #优先抓取店群设置款别资料
   #SELECT * INTO l_ooif.*  #161124-00048#13  2016/12/14 By 08734 mark
   SELECT ooifent,ooifstus,ooif000,ooif001,ooif002,ooif003,ooif004,ooif005,ooif006,ooif007,ooif008,ooif009,ooif010,ooif011,ooif012,ooif013,ooif014,ooif015,
          ooif016,ooif017,ooif018,ooif019,ooif020,ooif021,ooif022,ooif023,ooif024,ooif025,ooif026,ooif027,ooif028,ooif029,ooifstamp,ooifownid,ooifowndp,
          ooifcrtid,ooifcrtdp,ooifcrtdt,ooifmodid,ooifmoddt,ooif031,ooif032,ooif033,ooif034,ooif035,ooif036,ooif037,ooif038,ooif039 
     INTO l_ooif.*  #161124-00048#13  2016/12/14 By 08734 add
     FROM ooif_t
    WHERE ooifent = g_enterprise
      AND ooif000 = g_ooie_m.rtaa001
      AND ooif001 = g_ooie_d[l_ac].ooie001
   IF SQLCA.SQLCODE = 100 OR cl_null(g_ooie_m.rtaa001) THEN 
      #抓取款别资料
      #SELECT * INTO l_ooia.*  #161124-00048#13  2016/12/14 By 08734 mark
      SELECT ooiaent,ooia001,ooia002,ooia003,ooia004,ooia005,ooiastus,ooia006,ooia007,ooia008,ooia009,ooia010,ooia011,ooia012,ooia013,ooia014,ooia015,ooia016,
      ooia017,ooia018,ooia019,ooia020,ooia021,ooia022,ooia023,ooia024,ooia025,ooia026,ooia027,ooia028,ooia029,ooia030,ooia031,ooia032,ooia033,ooia034,ooia035,
      ooia036,ooia037,ooiaownid,ooiaowndp,ooiacrtid,ooiacrtdp,ooiacrtdt,ooiamodid,ooiamoddt,ooia038,ooia039,ooia040,ooia041,ooia042,ooia043,ooia044,ooia045 
        INTO l_ooia.*  #161124-00048#13  2016/12/14 By 08734 add
        FROM ooia_t
       WHERE ooiaent = g_enterprise 
         AND ooia001 = g_ooie_d[l_ac].ooie001
      LET g_ooie_d[l_ac].ooia002 = l_ooia.ooia002
      
      IF l_ooia.ooia003 = 'Y' THEN 
         SELECT ooef016 INTO l_ooef016
           FROM ooef_t
          WHERE ooef001 = g_ooie_m.ooiesite
            AND ooefent = g_enterprise
         LET g_ooie_d[l_ac].ooie002 = l_ooef016
      ELSE
         LET g_ooie_d[l_ac].ooie002 = l_ooia.ooia006
      END IF 
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_ooie_d[l_ac].ooie002
      CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_ooie_d[l_ac].ooie002_desc = '', g_rtn_fields[1] , ''
      
      LET g_ooie_d[l_ac].ooie003 = l_ooia.ooia012
      LET g_ooie_d[l_ac].ooie004 = l_ooia.ooia013
      LET g_ooie_d[l_ac].ooie005 = l_ooia.ooia014
      LET g_ooie_d[l_ac].ooie006 = l_ooia.ooia015
      LET g_ooie_d[l_ac].ooie007 = l_ooia.ooia016
      LET g_ooie_d[l_ac].ooie031 = l_ooia.ooia038
      #160509-00004#2--add--str--lujh
      LET g_ooie_d[l_ac].ooie034 = l_ooia.ooia040
      LET g_ooie_d[l_ac].ooie035 = l_ooia.ooia041
      LET g_ooie_d[l_ac].ooie036 = l_ooia.ooia042
      CALL s_desc_get_department_desc(g_ooie_d[l_ac].ooie036) RETURNING g_ooie_d[l_ac].ooie036_desc
      #160509-00004#2--add--end--lujh
      LET g_ooie3_d[l_ac].ooie010 = l_ooia.ooia018
      LET g_ooie3_d[l_ac].ooie011 = l_ooia.ooia019
      LET g_ooie3_d[l_ac].ooie012 = l_ooia.ooia020
      LET g_ooie3_d[l_ac].ooie013 = l_ooia.ooia021
      LET g_ooie3_d[l_ac].ooie014 = l_ooia.ooia022
      LET g_ooie3_d[l_ac].ooie015 = l_ooia.ooia023
      LET g_ooie3_d[l_ac].ooie016 = l_ooia.ooia024
      LET g_ooie3_d[l_ac].ooie017 = l_ooia.ooia025
      LET g_ooie3_d[l_ac].ooie018 = l_ooia.ooia026
      LET g_ooie3_d[l_ac].ooie019 = l_ooia.ooia027
      LET g_ooie3_d[l_ac].ooie020 = l_ooia.ooia028
      LET g_ooie3_d[l_ac].ooie021 = l_ooia.ooia029
      LET g_ooie3_d[l_ac].ooie022 = l_ooia.ooia030
      LET g_ooie3_d[l_ac].ooie023 = l_ooia.ooia031
      LET g_ooie3_d[l_ac].ooie024 = l_ooia.ooia032
      LET g_ooie3_d[l_ac].ooie025 = l_ooia.ooia033
      LET g_ooie3_d[l_ac].ooie026 = l_ooia.ooia034
      LET g_ooie3_d[l_ac].ooie027 = l_ooia.ooia035
      LET g_ooie3_d[l_ac].ooie028 = l_ooia.ooia036
      LET g_ooie3_d[l_ac].ooie029 = l_ooia.ooia037

   ELSE
      SELECT ooia002 INTO l_ooia002
        FROM ooia_t
       WHERE ooiaent = g_enterprise
         AND ooia001 = g_ooie_d[l_ac].ooie001
      LET g_ooie_d[l_ac].ooia002 = l_ooia002
      LET g_ooie_d[l_ac].ooie002 = l_ooif.ooif002
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_ooie_d[l_ac].ooie002
      CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_ooie_d[l_ac].ooie002_desc = '', g_rtn_fields[1] , ''
      LET g_ooie_d[l_ac].ooie003 = l_ooif.ooif003 
      LET g_ooie_d[l_ac].ooie004 = l_ooif.ooif004 
      LET g_ooie_d[l_ac].ooie005 = l_ooif.ooif005 
      LET g_ooie_d[l_ac].ooie006 = l_ooif.ooif006 
      LET g_ooie_d[l_ac].ooie007 = l_ooif.ooif007 
      LET g_ooie_d[l_ac].ooie031 = l_ooif.ooif031
      LET g_ooie_d[l_ac].ooie033 = l_ooif.ooif038   #160215-00002#15 160524 by sakura
      #160509-00004#2--add--str--lujh
      LET g_ooie_d[l_ac].ooie034 = l_ooif.ooif033
      LET g_ooie_d[l_ac].ooie035 = l_ooif.ooif034
      LET g_ooie_d[l_ac].ooie036 = l_ooif.ooif035
      CALL s_desc_get_department_desc(g_ooie_d[l_ac].ooie036) RETURNING g_ooie_d[l_ac].ooie036_desc
      #160509-00004#2--add--end--lujh
      LET g_ooie3_d[l_ac].ooie010 = l_ooif.ooif010 
      LET g_ooie3_d[l_ac].ooie011 = l_ooif.ooif011 
      LET g_ooie3_d[l_ac].ooie012 = l_ooif.ooif012 
      LET g_ooie3_d[l_ac].ooie013 = l_ooif.ooif013 
      LET g_ooie3_d[l_ac].ooie014 = l_ooif.ooif014 
      LET g_ooie3_d[l_ac].ooie015 = l_ooif.ooif015 
      LET g_ooie3_d[l_ac].ooie016 = l_ooif.ooif016 
      LET g_ooie3_d[l_ac].ooie017 = l_ooif.ooif017 
      LET g_ooie3_d[l_ac].ooie018 = l_ooif.ooif018 
      LET g_ooie3_d[l_ac].ooie019 = l_ooif.ooif019 
      LET g_ooie3_d[l_ac].ooie020 = l_ooif.ooif020 
      LET g_ooie3_d[l_ac].ooie021 = l_ooif.ooif021 
      LET g_ooie3_d[l_ac].ooie022 = l_ooif.ooif022 
      LET g_ooie3_d[l_ac].ooie023 = l_ooif.ooif023 
      LET g_ooie3_d[l_ac].ooie024 = l_ooif.ooif024 
      LET g_ooie3_d[l_ac].ooie025 = l_ooif.ooif025 
      LET g_ooie3_d[l_ac].ooie026 = l_ooif.ooif026 
      LET g_ooie3_d[l_ac].ooie027 = l_ooif.ooif027 
      LET g_ooie3_d[l_ac].ooie028 = l_ooif.ooif028 
      LET g_ooie3_d[l_ac].ooie029 = l_ooif.ooif029
      
   END IF 
   #add by yangxf ---start----
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_ooie3_d[l_ac].ooie009
   CALL ap_ref_array2(g_ref_fields,"SELECT ooial003 FROM ooial_t WHERE ooialent='"||g_enterprise||"' AND ooial001=? AND ooial002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_ooie3_d[l_ac].ooie001_1_desc = '', g_rtn_fields[1] , ''
   LET g_ooie3_d[l_ac].ooie010 = g_ooie3_d[l_ac].ooie001_1_desc
   LET g_ooie3_d[l_ac].ooie011 = g_ooie3_d[l_ac].ooie001_1_desc
   #add by yangxf ---end----
   #151008-00002 by whitney add start
   IF cl_null(g_ooie_d[l_ac].ooie031) THEN
      LET g_ooie_d[l_ac].ooie031 = 0
   END IF
   #151008-00002 by whitney add end
END FUNCTION

################################################################################
# Descriptions...: 营运据点带值
# Memo...........:
# Usage..........: CALL aooi901_ooiesite_desc()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/09/12 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi901_ooiesite_desc()
   LET g_ooie_m.rtaa001 = ''
   LET g_ooie_m.rtaa001_desc = ''
   #huangrh add rtak----20150603
   SELECT DISTINCT rtaa001,rtaal003 INTO g_ooie_m.rtaa001,g_ooie_m.rtaa001_desc
     FROM rtak_t,rtab_t,rtaa_t LEFT JOIN rtaal_t ON rtaaent = rtaalent AND rtaa001 = rtaal001 AND rtaal002 = g_dlang
    WHERE rtaa001 = rtab001 
      AND rtaaent = g_enterprise 
      AND rtab002 = g_ooie_m.ooiesite
      AND rtakent=rtaaent
      AND rtak001=rtaa001
      AND rtak002='5'
      AND rtak003='Y'
   DISPLAY BY NAME g_ooie_m.rtaa001,g_ooie_m.rtaa001_desc
END FUNCTION

################################################################################
# Descriptions...: 门店检查
# Memo...........:
# Usage..........: CALL aooi901_ooiesite_chk()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/09/17 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi901_ooiesite_chk()
   DEFINE l_ooefstus   LIKE ooef_t.ooefstus
   DEFINE l_ooef201    LIKE ooef_t.ooef201
   LET g_errno = ''
   #检查门店是否存在
   SELECT ooefstus INTO l_ooefstus
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_ooie_m.ooiesite
   CASE WHEN SQLCA.SQLCODE = 100    LET g_errno = 'aoo-00016'
        WHEN l_ooefstus <> 'Y'      LET g_errno = 'aoo-00012'
        OTHERWISE                   LET g_errno = SQLCA.SQLCODE USING '-------'
   END CASE
   IF NOT cl_null(g_errno) THEN 
      RETURN 
   END IF 
   #检查门店是否为营运据点
   SELECT ooef201 INTO l_ooef201
     FROM ooef_t
    WHERE ooefent = g_enterprise 
      AND ooef001 = g_ooie_m.ooiesite
   CASE WHEN SQLCA.SQLCODE = 100    LET g_errno = 'aoo-00016'
        WHEN l_ooef201 <> 'Y'       LET g_errno = 'aoo-00163'
        OTHERWISE                   LET g_errno = SQLCA.SQLCODE USING '-------'
   END CASE
END FUNCTION

 
{</section>}
 
