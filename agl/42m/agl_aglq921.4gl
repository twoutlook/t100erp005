#該程式未解開Section, 採用最新樣板產出!
{<section id="aglq921.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2016-06-02 17:33:19), PR版次:0004(2016-10-24 11:51:14)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000029
#+ Filename...: aglq921
#+ Description: 合併報表沖銷前各期科目核算項餘額查詢
#+ Creator....: 02159(2015-11-18 09:46:14)
#+ Modifier...: 06821 -SD/PR- 06821
 
{</section>}
 
{<section id="aglq921.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#160517-00002#5 160603  By 06821  查詢加上轉XG功能
#160913-00017#3 160921  By 07900  AGL模组调整交易客商开窗
#161021-00037#3 161024  By 06821  組織類型與職能開窗調整
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
PRIVATE type type_g_gldt_m        RECORD
       gldtld LIKE gldt_t.gldtld, 
   gldtld_desc LIKE type_t.chr80, 
   gldt001 LIKE gldt_t.gldt001, 
   gldt001_desc LIKE type_t.chr80, 
   gldt003 LIKE gldt_t.gldt003, 
   gldt003_desc LIKE type_t.chr80, 
   gldt005 LIKE gldt_t.gldt005, 
   gldt006 LIKE gldt_t.gldt006, 
   gldt009 LIKE gldt_t.gldt009, 
   gldt025 LIKE gldt_t.gldt025, 
   gldt028 LIKE gldt_t.gldt028, 
   l_chk14 LIKE type_t.chr1, 
   l_chk15 LIKE type_t.chr1, 
   l_chk16 LIKE type_t.chr1, 
   l_chk17 LIKE type_t.chr1, 
   l_chk18 LIKE type_t.chr1, 
   l_chk19 LIKE type_t.chr1, 
   l_chk20 LIKE type_t.chr1, 
   l_chk21 LIKE type_t.chr1, 
   l_chk36 LIKE type_t.chr1, 
   l_chk37 LIKE type_t.chr1, 
   l_chk38 LIKE type_t.chr1, 
   l_chk22 LIKE type_t.chr1, 
   l_chk23 LIKE type_t.chr1, 
   l_chk24 LIKE type_t.chr1
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_gldt_d        RECORD
       gldt002 LIKE gldt_t.gldt002, 
   gldt004 LIKE gldt_t.gldt004, 
   gldt008 LIKE gldt_t.gldt008, 
   gldt031 LIKE gldt_t.gldt031, 
   gldt032 LIKE gldt_t.gldt032, 
   gldt007 LIKE gldt_t.gldt007, 
   gldt007_desc LIKE type_t.chr100, 
   gldt014 LIKE gldt_t.gldt014, 
   gldt014_desc LIKE type_t.chr100, 
   gldt015 LIKE gldt_t.gldt015, 
   gldt015_desc LIKE type_t.chr100, 
   gldt016 LIKE gldt_t.gldt016, 
   gldt016_desc LIKE type_t.chr100, 
   gldt017 LIKE gldt_t.gldt017, 
   gldt017_desc LIKE type_t.chr100, 
   gldt018 LIKE gldt_t.gldt018, 
   gldt018_desc LIKE type_t.chr100, 
   gldt019 LIKE gldt_t.gldt019, 
   gldt019_desc LIKE type_t.chr100, 
   gldt020 LIKE gldt_t.gldt020, 
   gldt020_desc LIKE type_t.chr100, 
   gldt021 LIKE gldt_t.gldt021, 
   gldt021_desc LIKE type_t.chr100, 
   gldt036 LIKE gldt_t.gldt036, 
   gldt037 LIKE gldt_t.gldt037, 
   gldt037_desc LIKE type_t.chr100, 
   gldt038 LIKE gldt_t.gldt038, 
   gldt038_desc LIKE type_t.chr100, 
   gldt022 LIKE gldt_t.gldt022, 
   gldt022_desc LIKE type_t.chr100, 
   gldt023 LIKE gldt_t.gldt023, 
   gldt023_desc LIKE type_t.chr100, 
   gldt024 LIKE gldt_t.gldt024, 
   gldt024_desc LIKE type_t.chr100, 
   gldt033 LIKE gldt_t.gldt033, 
   gldt010 LIKE gldt_t.gldt010, 
   gldt011 LIKE gldt_t.gldt011, 
   l_gldt011 LIKE type_t.num20_6
       END RECORD
PRIVATE TYPE type_g_gldt2_d RECORD
       gldt002 LIKE gldt_t.gldt002, 
   gldt004 LIKE gldt_t.gldt004, 
   gldt008 LIKE gldt_t.gldt008, 
   gldt031 LIKE gldt_t.gldt031, 
   gldt032 LIKE gldt_t.gldt032, 
   gldt007 LIKE gldt_t.gldt007, 
   gldt0072_desc LIKE type_t.chr100, 
   l_gldt0142 LIKE type_t.chr100, 
   l_gldt0152 LIKE type_t.chr100, 
   l_gldt0162 LIKE type_t.chr100, 
   l_gldt0172 LIKE type_t.chr100, 
   l_gldt0182 LIKE type_t.chr100, 
   l_gldt0192 LIKE type_t.chr100, 
   l_gldt0202 LIKE type_t.chr100, 
   l_gldt0212 LIKE type_t.chr100, 
   l_gldt0362 LIKE type_t.chr100, 
   l_gldt0372 LIKE type_t.chr100, 
   l_gldt0382 LIKE type_t.chr100, 
   l_gldt0222 LIKE type_t.chr100, 
   l_gldt0232 LIKE type_t.chr100, 
   l_gldt0242 LIKE type_t.chr100, 
   gldt034 LIKE gldt_t.gldt034, 
   gldt026 LIKE gldt_t.gldt026, 
   gldt027 LIKE gldt_t.gldt027, 
   l_gldt027 LIKE type_t.num20_6
       END RECORD
PRIVATE TYPE type_g_gldt3_d RECORD
       gldt002 LIKE gldt_t.gldt002, 
   gldt004 LIKE gldt_t.gldt004, 
   gldt008 LIKE gldt_t.gldt008, 
   gldt031 LIKE gldt_t.gldt031, 
   gldt032 LIKE gldt_t.gldt032, 
   gldt007 LIKE gldt_t.gldt007, 
   gldt0073_desc LIKE type_t.chr100, 
   l_gldt0143 LIKE type_t.chr100, 
   l_gldt0153 LIKE type_t.chr100, 
   l_gldt0163 LIKE type_t.chr100, 
   l_gldt0173 LIKE type_t.chr100, 
   l_gldt0183 LIKE type_t.chr100, 
   l_gldt0193 LIKE type_t.chr100, 
   l_gldt0203 LIKE type_t.chr100, 
   l_gldt0213 LIKE type_t.chr100, 
   l_gldt0363 LIKE type_t.chr100, 
   l_gldt0373 LIKE type_t.chr100, 
   l_gldt0383 LIKE type_t.chr100, 
   l_gldt0223 LIKE type_t.chr100, 
   l_gldt0233 LIKE type_t.chr100, 
   l_gldt0243 LIKE type_t.chr100, 
   gldt035 LIKE gldt_t.gldt035, 
   gldt029 LIKE gldt_t.gldt029, 
   gldt030 LIKE gldt_t.gldt030, 
   l_gldt030 LIKE type_t.num20_6
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_input               RECORD
             l_chk14 LIKE type_t.chr80, 
             l_chk15 LIKE type_t.chr80, 
             l_chk16 LIKE type_t.chr80, 
             l_chk17 LIKE type_t.chr80, 
             l_chk18 LIKE type_t.chr80, 
             l_chk19 LIKE type_t.chr80, 
             l_chk20 LIKE type_t.chr80, 
             l_chk21 LIKE type_t.chr80, 
			 l_chk36 LIKE type_t.chr80, 
             l_chk37 LIKE type_t.chr80, 
             l_chk38 LIKE type_t.chr80,
             l_chk22 LIKE type_t.chr80, 
             l_chk23 LIKE type_t.chr80, 
             l_chk24 LIKE type_t.chr80
                             END RECORD
DEFINE g_xg_visible          STRING     #XG欄位隱藏條件      #160517-00002#5
#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_gldt_m          type_g_gldt_m
DEFINE g_gldt_m_t        type_g_gldt_m
DEFINE g_gldt_m_o        type_g_gldt_m
DEFINE g_gldt_m_mask_o   type_g_gldt_m #轉換遮罩前資料
DEFINE g_gldt_m_mask_n   type_g_gldt_m #轉換遮罩後資料
 
   DEFINE g_gldtld_t LIKE gldt_t.gldtld
DEFINE g_gldt001_t LIKE gldt_t.gldt001
DEFINE g_gldt003_t LIKE gldt_t.gldt003
DEFINE g_gldt005_t LIKE gldt_t.gldt005
DEFINE g_gldt006_t LIKE gldt_t.gldt006
 
 
DEFINE g_gldt_d          DYNAMIC ARRAY OF type_g_gldt_d
DEFINE g_gldt_d_t        type_g_gldt_d
DEFINE g_gldt_d_o        type_g_gldt_d
DEFINE g_gldt_d_mask_o   DYNAMIC ARRAY OF type_g_gldt_d #轉換遮罩前資料
DEFINE g_gldt_d_mask_n   DYNAMIC ARRAY OF type_g_gldt_d #轉換遮罩後資料
DEFINE g_gldt2_d   DYNAMIC ARRAY OF type_g_gldt2_d
DEFINE g_gldt2_d_t type_g_gldt2_d
DEFINE g_gldt2_d_o type_g_gldt2_d
DEFINE g_gldt2_d_mask_o   DYNAMIC ARRAY OF type_g_gldt2_d #轉換遮罩前資料
DEFINE g_gldt2_d_mask_n   DYNAMIC ARRAY OF type_g_gldt2_d #轉換遮罩後資料
DEFINE g_gldt3_d   DYNAMIC ARRAY OF type_g_gldt3_d
DEFINE g_gldt3_d_t type_g_gldt3_d
DEFINE g_gldt3_d_o type_g_gldt3_d
DEFINE g_gldt3_d_mask_o   DYNAMIC ARRAY OF type_g_gldt3_d #轉換遮罩前資料
DEFINE g_gldt3_d_mask_n   DYNAMIC ARRAY OF type_g_gldt3_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_gldtld LIKE gldt_t.gldtld,
      b_gldt001 LIKE gldt_t.gldt001,
      b_gldt003 LIKE gldt_t.gldt003,
      b_gldt005 LIKE gldt_t.gldt005,
      b_gldt006 LIKE gldt_t.gldt006
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
 
{<section id="aglq921.main" >}
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
   LET g_forupd_sql = " SELECT gldtld,'',gldt001,'',gldt003,'',gldt005,gldt006,gldt009,gldt025,gldt028, 
       '','','','','','','','','','','','','',''", 
                      " FROM gldt_t",
                      " WHERE gldtent= ? AND gldtld=? AND gldt001=? AND gldt003=? AND gldt005=? AND  
                          gldt006=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aglq921_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.gldtld,t0.gldt001,t0.gldt003,t0.gldt005,t0.gldt006,t0.gldt009,t0.gldt025, 
       t0.gldt028",
               " FROM gldt_t t0",
               
               " WHERE t0.gldtent = " ||g_enterprise|| " AND t0.gldtld = ? AND t0.gldt001 = ? AND t0.gldt003 = ? AND t0.gldt005 = ? AND t0.gldt006 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aglq921_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aglq921 WITH FORM cl_ap_formpath("agl",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aglq921_init()   
 
      #進入選單 Menu (="N")
      CALL aglq921_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aglq921
      
   END IF 
   
   CLOSE aglq921_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aglq921.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aglq921_init()
   #add-point:init段define name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill = "Y"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('gldt036','6013')   #經營方式
   CALL cl_set_combo_scc('l_gldt0362','6013') 
   CALL cl_set_combo_scc('l_gldt0363','6013')
   CALL aglq921_construct_visible('OUT')
   #end add-point
   
   CALL aglq921_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aglq921.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION aglq921_ui_dialog()
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
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   LET lb_first = TRUE
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   CALL aglq921_create_tmp() #160517-00002#5
   #end add-point
   
   WHILE TRUE
      
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_gldt_m.* TO NULL
         CALL g_gldt_d.clear()
         CALL g_gldt2_d.clear()
         CALL g_gldt3_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aglq921_init()
      END IF
 
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
        
         DISPLAY ARRAY g_gldt_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL aglq921_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL aglq921_ui_detailshow()
               
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
        
         DISPLAY ARRAY g_gldt2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL aglq921_idx_chk()
               CALL aglq921_ui_detailshow()
               
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
         DISPLAY ARRAY g_gldt3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL aglq921_idx_chk()
               CALL aglq921_ui_detailshow()
               
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
         ON ACTION filter
            CALL aglq921_filter2()
            EXIT DIALOG
         #end add-point
         
         
         BEFORE DIALOG
            #先填充browser資料
            CALL aglq921_browser_fill("")
            CALL cl_notice()
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL g_curr_diag.setSelectionMode("s_detail1",1)         
            LET g_page = "first"
            LET g_current_sw = FALSE
            #回歸舊筆數位置 (回到當時異動的筆數)
            IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
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
               CALL aglq921_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aglq921_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL aglq921_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aglq921_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL aglq921_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aglq921_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL aglq921_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aglq921_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL aglq921_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aglq921_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL aglq921_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aglq921_idx_chk()
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
                  LET g_export_node[1] = base.typeInfo.create(g_gldt_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_gldt2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_gldt3_d)
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
               NEXT FIELD gldt002
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
               CALL aglq921_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL aglq921_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL aglq921_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               #160517-00002#5 --s add
               CALL aglq921_ins_x01_tmp()
               CALL aglq921_x01(' 1=1','aglq921_x01_tmp',g_xg_visible)
               #160517-00002#5 --e add
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               #160517-00002#5 --s add
               CALL aglq921_ins_x01_tmp()
               CALL aglq921_x01(' 1=1','aglq921_x01_tmp',g_xg_visible)
               #160517-00002#5 --e add
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aglq921_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN
               
               #add-point:ON ACTION datainfo name="menu.datainfo"
               
               #END add-point
               
            END IF
 
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aglq921_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aglq921_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aglq921_set_pk_array()
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
 
{<section id="aglq921.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION aglq921_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aglq921.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION aglq921_browser_fill(ps_page_action)
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
 
   LET l_searchcol = "gldtld,gldt001,gldt003,gldt005,gldt006"
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
      LET l_sub_sql = " SELECT DISTINCT gldtld ",
                      ", gldt001 ",
                      ", gldt003 ",
                      ", gldt005 ",
                      ", gldt006 ",
 
                      " FROM gldt_t ",
                      " ",
                      " ", 
 
 
 
                      " WHERE gldtent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("gldt_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT gldtld ",
                      ", gldt001 ",
                      ", gldt003 ",
                      ", gldt005 ",
                      ", gldt006 ",
 
                      " FROM gldt_t ",
                      " ",
                      " ", 
 
 
                      " WHERE gldtent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("gldt_t")
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
      INITIALIZE g_gldt_m.* TO NULL
      CALL g_gldt_d.clear()        
      CALL g_gldt2_d.clear() 
      CALL g_gldt3_d.clear() 
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.gldtld,t0.gldt001,t0.gldt003,t0.gldt005,t0.gldt006 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.gldtld,t0.gldt001,t0.gldt003,t0.gldt005,t0.gldt006",
                " FROM gldt_t t0",
                #" ",
                " ",
 
 
 
                
                " WHERE t0.gldtent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("gldt_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
   
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"gldt_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_gldtld,g_browser[g_cnt].b_gldt001,g_browser[g_cnt].b_gldt003, 
          g_browser[g_cnt].b_gldt005,g_browser[g_cnt].b_gldt006 
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
   
   IF cl_null(g_browser[g_cnt].b_gldtld) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_gldt_m.* TO NULL
      CALL g_gldt_d.clear()
      CALL g_gldt2_d.clear()
      CALL g_gldt3_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL aglq921_fetch('')
   
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
 
{<section id="aglq921.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION aglq921_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_gldt_m.gldtld = g_browser[g_current_idx].b_gldtld   
   LET g_gldt_m.gldt001 = g_browser[g_current_idx].b_gldt001   
   LET g_gldt_m.gldt003 = g_browser[g_current_idx].b_gldt003   
   LET g_gldt_m.gldt005 = g_browser[g_current_idx].b_gldt005   
   LET g_gldt_m.gldt006 = g_browser[g_current_idx].b_gldt006   
 
   EXECUTE aglq921_master_referesh USING g_gldt_m.gldtld,g_gldt_m.gldt001,g_gldt_m.gldt003,g_gldt_m.gldt005, 
       g_gldt_m.gldt006 INTO g_gldt_m.gldtld,g_gldt_m.gldt001,g_gldt_m.gldt003,g_gldt_m.gldt005,g_gldt_m.gldt006, 
       g_gldt_m.gldt009,g_gldt_m.gldt025,g_gldt_m.gldt028
   CALL aglq921_show()
   
END FUNCTION
 
{</section>}
 
{<section id="aglq921.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION aglq921_ui_detailshow()
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
 
{<section id="aglq921.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aglq921_ui_browser_refresh()
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
      IF g_browser[l_i].b_gldtld = g_gldt_m.gldtld 
         AND g_browser[l_i].b_gldt001 = g_gldt_m.gldt001 
         AND g_browser[l_i].b_gldt003 = g_gldt_m.gldt003 
         AND g_browser[l_i].b_gldt005 = g_gldt_m.gldt005 
         AND g_browser[l_i].b_gldt006 = g_gldt_m.gldt006 
 
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
 
{<section id="aglq921.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aglq921_construct()
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
   INITIALIZE g_gldt_m.* TO NULL
   CALL g_gldt_d.clear()
   CALL g_gldt2_d.clear()
   CALL g_gldt3_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   CALL aglq921_qbe_clear()
   CALL cl_set_comp_visible('gldt025,page_3',TRUE)
   CALL cl_set_comp_visible('gldt028,page_4',TRUE)
   CALL aglq921_construct_visible('IN')
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON gldtld,gldt001,gldt003,gldt005,gldt006
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
                 #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldtld
            #add-point:BEFORE FIELD gldtld name="construct.b.gldtld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldtld
            
            #add-point:AFTER FIELD gldtld name="construct.a.gldtld"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gldtld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldtld
            #add-point:ON ACTION controlp INFIELD gldtld name="construct.c.gldtld"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_grup
            LET g_qryparam.where = " glaald IN (SELECT glaald FROM glaa_t WHERE glaa130 = 'Y') "
            CALL q_authorised_ld()
            DISPLAY g_qryparam.return1 TO gldtld
            NEXT FIELD gldtld
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt001
            #add-point:BEFORE FIELD gldt001 name="construct.b.gldt001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt001
            
            #add-point:AFTER FIELD gldt001 name="construct.a.gldt001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gldt001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt001
            #add-point:ON ACTION controlp INFIELD gldt001 name="construct.c.gldt001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_glda001()
            DISPLAY g_qryparam.return1 TO gldt001
            NEXT FIELD gldt001
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt003
            #add-point:BEFORE FIELD gldt003 name="construct.b.gldt003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt003
            
            #add-point:AFTER FIELD gldt003 name="construct.a.gldt003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gldt003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt003
            #add-point:ON ACTION controlp INFIELD gldt003 name="construct.c.gldt003"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_glda001()
            DISPLAY g_qryparam.return1 TO gldt003
            NEXT FIELD gldt003
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt005
            #add-point:BEFORE FIELD gldt005 name="construct.b.gldt005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt005
            
            #add-point:AFTER FIELD gldt005 name="construct.a.gldt005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gldt005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt005
            #add-point:ON ACTION controlp INFIELD gldt005 name="construct.c.gldt005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt006
            #add-point:BEFORE FIELD gldt006 name="construct.b.gldt006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt006
            
            #add-point:AFTER FIELD gldt006 name="construct.a.gldt006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gldt006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt006
            #add-point:ON ACTION controlp INFIELD gldt006 name="construct.c.gldt006"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON gldt002,gldt004,gldt008,gldt031,gldt032,gldt007,gldt014,gldt015,gldt016, 
          gldt017,gldt018,gldt019,gldt020,gldt021,gldt036,gldt037,gldt038,gldt022,gldt023,gldt024,gldt033, 
          gldt010,gldt011,gldt034,gldt026,gldt027,gldt035,gldt029,gldt030
           FROM s_detail1[1].gldt002,s_detail1[1].gldt004,s_detail1[1].gldt008,s_detail1[1].gldt031, 
               s_detail1[1].gldt032,s_detail1[1].gldt007,s_detail1[1].gldt014,s_detail1[1].gldt015,s_detail1[1].gldt016, 
               s_detail1[1].gldt017,s_detail1[1].gldt018,s_detail1[1].gldt019,s_detail1[1].gldt020,s_detail1[1].gldt021, 
               s_detail1[1].gldt036,s_detail1[1].gldt037,s_detail1[1].gldt038,s_detail1[1].gldt022,s_detail1[1].gldt023, 
               s_detail1[1].gldt024,s_detail1[1].gldt033,s_detail1[1].gldt010,s_detail1[1].gldt011,s_detail2[1].gldt034, 
               s_detail2[1].gldt026,s_detail2[1].gldt027,s_detail3[1].gldt035,s_detail3[1].gldt029,s_detail3[1].gldt030 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt002
            #add-point:BEFORE FIELD gldt002 name="construct.b.page1.gldt002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt002
            
            #add-point:AFTER FIELD gldt002 name="construct.a.page1.gldt002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldt002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt002
            #add-point:ON ACTION controlp INFIELD gldt002 name="construct.c.page1.gldt002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt004
            #add-point:BEFORE FIELD gldt004 name="construct.b.page1.gldt004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt004
            
            #add-point:AFTER FIELD gldt004 name="construct.a.page1.gldt004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldt004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt004
            #add-point:ON ACTION controlp INFIELD gldt004 name="construct.c.page1.gldt004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt008
            #add-point:BEFORE FIELD gldt008 name="construct.b.page1.gldt008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt008
            
            #add-point:AFTER FIELD gldt008 name="construct.a.page1.gldt008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldt008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt008
            #add-point:ON ACTION controlp INFIELD gldt008 name="construct.c.page1.gldt008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt031
            #add-point:BEFORE FIELD gldt031 name="construct.b.page1.gldt031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt031
            
            #add-point:AFTER FIELD gldt031 name="construct.a.page1.gldt031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldt031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt031
            #add-point:ON ACTION controlp INFIELD gldt031 name="construct.c.page1.gldt031"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt032
            #add-point:BEFORE FIELD gldt032 name="construct.b.page1.gldt032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt032
            
            #add-point:AFTER FIELD gldt032 name="construct.a.page1.gldt032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldt032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt032
            #add-point:ON ACTION controlp INFIELD gldt032 name="construct.c.page1.gldt032"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt007
            #add-point:BEFORE FIELD gldt007 name="construct.b.page1.gldt007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt007
            
            #add-point:AFTER FIELD gldt007 name="construct.a.page1.gldt007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldt007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt007
            #add-point:ON ACTION controlp INFIELD gldt007 name="construct.c.page1.gldt007"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " glac003 <>'1' AND glac006 = '1'"
            CALL aglt310_04()
            DISPLAY g_qryparam.return1 TO gldt007  #顯示到畫面上
            NEXT FIELD gldt007
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt014
            #add-point:BEFORE FIELD gldt014 name="construct.b.page1.gldt014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt014
            
            #add-point:AFTER FIELD gldt014 name="construct.a.page1.gldt014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldt014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt014
            #add-point:ON ACTION controlp INFIELD gldt014 name="construct.c.page1.gldt014"
            #營運據點
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()    #161021-00037#3 mark
            CALL q_ooef001_01()  #161021-00037#3 add
            DISPLAY g_qryparam.return1 TO gldt014
            NEXT FIELD gldt014
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt015
            #add-point:BEFORE FIELD gldt015 name="construct.b.page1.gldt015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt015
            
            #add-point:AFTER FIELD gldt015 name="construct.a.page1.gldt015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldt015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt015
            #add-point:ON ACTION controlp INFIELD gldt015 name="construct.c.page1.gldt015"
            #部門
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "ooegstus='Y'"
            CALL q_ooeg001_4()
            DISPLAY g_qryparam.return1 TO gldt015
            NEXT FIELD gldt015
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt016
            #add-point:BEFORE FIELD gldt016 name="construct.b.page1.gldt016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt016
            
            #add-point:AFTER FIELD gldt016 name="construct.a.page1.gldt016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldt016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt016
            #add-point:ON ACTION controlp INFIELD gldt016 name="construct.c.page1.gldt016"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "ooegstus='Y' AND ooeg003 IN ('1','2','3')"
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gldt016      #顯示到畫面上
            NEXT FIELD gldt016
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt017
            #add-point:BEFORE FIELD gldt017 name="construct.b.page1.gldt017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt017
            
            #add-point:AFTER FIELD gldt017 name="construct.a.page1.gldt017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldt017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt017
            #add-point:ON ACTION controlp INFIELD gldt017 name="construct.c.page1.gldt017"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_287()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO gldt017      #顯示到畫面上
            NEXT FIELD gldt017
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt018
            #add-point:BEFORE FIELD gldt018 name="construct.b.page1.gldt018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt018
            
            #add-point:AFTER FIELD gldt018 name="construct.a.page1.gldt018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldt018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt018
            #add-point:ON ACTION controlp INFIELD gldt018 name="construct.c.page1.gldt018"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_25()      #160913-00017#3  add
            #CALL q_pmaa001()        #160913-00017#3  mark               #呼叫開窗
            DISPLAY g_qryparam.return1 TO gldt018
            NEXT FIELD gldt018
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt019
            #add-point:BEFORE FIELD gldt019 name="construct.b.page1.gldt019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt019
            
            #add-point:AFTER FIELD gldt019 name="construct.a.page1.gldt019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldt019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt019
            #add-point:ON ACTION controlp INFIELD gldt019 name="construct.c.page1.gldt019"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_pmaa001_25()      #160913-00017#3  add
            #CALL q_pmaa001()        #160913-00017#3  mark               #呼叫開窗
            DISPLAY g_qryparam.return1 TO gldt019
            NEXT FIELD gldt019
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt020
            #add-point:BEFORE FIELD gldt020 name="construct.b.page1.gldt020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt020
            
            #add-point:AFTER FIELD gldt020 name="construct.a.page1.gldt020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldt020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt020
            #add-point:ON ACTION controlp INFIELD gldt020 name="construct.c.page1.gldt020"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_oocq002_281()
            DISPLAY g_qryparam.return1 TO gldt020
            NEXT FIELD gldt020
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt021
            #add-point:BEFORE FIELD gldt021 name="construct.b.page1.gldt021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt021
            
            #add-point:AFTER FIELD gldt021 name="construct.a.page1.gldt021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldt021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt021
            #add-point:ON ACTION controlp INFIELD gldt021 name="construct.c.page1.gldt021"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gldt021      #顯示到畫面上
            NEXT FIELD gldt021
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt036
            #add-point:BEFORE FIELD gldt036 name="construct.b.page1.gldt036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt036
            
            #add-point:AFTER FIELD gldt036 name="construct.a.page1.gldt036"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldt036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt036
            #add-point:ON ACTION controlp INFIELD gldt036 name="construct.c.page1.gldt036"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt037
            #add-point:BEFORE FIELD gldt037 name="construct.b.page1.gldt037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt037
            
            #add-point:AFTER FIELD gldt037 name="construct.a.page1.gldt037"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldt037
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt037
            #add-point:ON ACTION controlp INFIELD gldt037 name="construct.c.page1.gldt037"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            LET g_qryparam.where = " oojdstus='Y' "
            CALL q_oojd001_2()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO gldt037    #顯示到畫面上
            NEXT FIELD gldt037
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt038
            #add-point:BEFORE FIELD gldt038 name="construct.b.page1.gldt038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt038
            
            #add-point:AFTER FIELD gldt038 name="construct.a.page1.gldt038"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldt038
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt038
            #add-point:ON ACTION controlp INFIELD gldt038 name="construct.c.page1.gldt038"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_oocq002_2002()                            #呼叫開窗
            DISPLAY g_qryparam.return1 TO gldt038      #顯示到畫面上
            NEXT FIELD gldt038
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt022
            #add-point:BEFORE FIELD gldt022 name="construct.b.page1.gldt022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt022
            
            #add-point:AFTER FIELD gldt022 name="construct.a.page1.gldt022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldt022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt022
            #add-point:ON ACTION controlp INFIELD gldt022 name="construct.c.page1.gldt022"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_ooag001_8()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gldt022     #顯示到畫面上
            NEXT FIELD gldt022
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt023
            #add-point:BEFORE FIELD gldt023 name="construct.b.page1.gldt023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt023
            
            #add-point:AFTER FIELD gldt023 name="construct.a.page1.gldt023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldt023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt023
            #add-point:ON ACTION controlp INFIELD gldt023 name="construct.c.page1.gldt023"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_pjba001()                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO gldt023     #顯示到畫面上
            NEXT FIELD gldt023
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt024
            #add-point:BEFORE FIELD gldt024 name="construct.b.page1.gldt024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt024
            
            #add-point:AFTER FIELD gldt024 name="construct.a.page1.gldt024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldt024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt024
            #add-point:ON ACTION controlp INFIELD gldt024 name="construct.c.page1.gldt024"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            LET g_qryparam.where = "pjbb012='1' "
            CALL q_pjbb002()                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO gldt024     #顯示到畫面上
            NEXT FIELD gldt024
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt033
            #add-point:BEFORE FIELD gldt033 name="construct.b.page1.gldt033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt033
            
            #add-point:AFTER FIELD gldt033 name="construct.a.page1.gldt033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldt033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt033
            #add-point:ON ACTION controlp INFIELD gldt033 name="construct.c.page1.gldt033"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt010
            #add-point:BEFORE FIELD gldt010 name="construct.b.page1.gldt010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt010
            
            #add-point:AFTER FIELD gldt010 name="construct.a.page1.gldt010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldt010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt010
            #add-point:ON ACTION controlp INFIELD gldt010 name="construct.c.page1.gldt010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt011
            #add-point:BEFORE FIELD gldt011 name="construct.b.page1.gldt011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt011
            
            #add-point:AFTER FIELD gldt011 name="construct.a.page1.gldt011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldt011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt011
            #add-point:ON ACTION controlp INFIELD gldt011 name="construct.c.page1.gldt011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt034
            #add-point:BEFORE FIELD gldt034 name="construct.b.page2.gldt034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt034
            
            #add-point:AFTER FIELD gldt034 name="construct.a.page2.gldt034"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.gldt034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt034
            #add-point:ON ACTION controlp INFIELD gldt034 name="construct.c.page2.gldt034"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt026
            #add-point:BEFORE FIELD gldt026 name="construct.b.page2.gldt026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt026
            
            #add-point:AFTER FIELD gldt026 name="construct.a.page2.gldt026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.gldt026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt026
            #add-point:ON ACTION controlp INFIELD gldt026 name="construct.c.page2.gldt026"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt027
            #add-point:BEFORE FIELD gldt027 name="construct.b.page2.gldt027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt027
            
            #add-point:AFTER FIELD gldt027 name="construct.a.page2.gldt027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.gldt027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt027
            #add-point:ON ACTION controlp INFIELD gldt027 name="construct.c.page2.gldt027"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt035
            #add-point:BEFORE FIELD gldt035 name="construct.b.page3.gldt035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt035
            
            #add-point:AFTER FIELD gldt035 name="construct.a.page3.gldt035"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.gldt035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt035
            #add-point:ON ACTION controlp INFIELD gldt035 name="construct.c.page3.gldt035"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt029
            #add-point:BEFORE FIELD gldt029 name="construct.b.page3.gldt029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt029
            
            #add-point:AFTER FIELD gldt029 name="construct.a.page3.gldt029"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.gldt029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt029
            #add-point:ON ACTION controlp INFIELD gldt029 name="construct.c.page3.gldt029"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt030
            #add-point:BEFORE FIELD gldt030 name="construct.b.page3.gldt030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt030
            
            #add-point:AFTER FIELD gldt030 name="construct.a.page3.gldt030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.gldt030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt030
            #add-point:ON ACTION controlp INFIELD gldt030 name="construct.c.page3.gldt030"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
  
 
  
      #add-point:cs段more_construct name="cs.more_construct"
      INPUT BY NAME g_input.l_chk14,g_input.l_chk15,g_input.l_chk16,g_input.l_chk17,
                    g_input.l_chk18,g_input.l_chk19,g_input.l_chk20,g_input.l_chk21,
                    g_input.l_chk36,g_input.l_chk37,g_input.l_chk38,
                    g_input.l_chk22,g_input.l_chk23,g_input.l_chk24
                    ATTRIBUTE(WITHOUT DEFAULTS)
      END INPUT
      ON ACTION qbeclear
         CALL aglq921_qbe_clear()
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:ui_dialog段b_dialog name="cs.before_dialog"
         LET l_ac = 1
         LET g_gldt_d[l_ac].gldt007 = ''
         DISPLAY ARRAY g_gldt_d TO s_detail1.*
            BEFORE DISPLAY
               EXIT DISPLAY
         END DISPLAY
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
   CALL aglq921_construct_visible('OUT')
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
 
{<section id="aglq921.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aglq921_query()
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
   CALL g_gldt_d.clear()
   CALL g_gldt2_d.clear()
   CALL g_gldt3_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL aglq921_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aglq921_browser_fill(g_wc)
      CALL aglq921_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL aglq921_browser_fill("F")
   
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
      CALL aglq921_fetch("F") 
   END IF
   
   CALL aglq921_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="aglq921.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aglq921_fetch(p_flag)
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
   
   #CALL aglq921_browser_fill(p_flag)
   
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
   
   LET g_gldt_m.gldtld = g_browser[g_current_idx].b_gldtld
   LET g_gldt_m.gldt001 = g_browser[g_current_idx].b_gldt001
   LET g_gldt_m.gldt003 = g_browser[g_current_idx].b_gldt003
   LET g_gldt_m.gldt005 = g_browser[g_current_idx].b_gldt005
   LET g_gldt_m.gldt006 = g_browser[g_current_idx].b_gldt006
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE aglq921_master_referesh USING g_gldt_m.gldtld,g_gldt_m.gldt001,g_gldt_m.gldt003,g_gldt_m.gldt005, 
       g_gldt_m.gldt006 INTO g_gldt_m.gldtld,g_gldt_m.gldt001,g_gldt_m.gldt003,g_gldt_m.gldt005,g_gldt_m.gldt006, 
       g_gldt_m.gldt009,g_gldt_m.gldt025,g_gldt_m.gldt028
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "gldt_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_gldt_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_gldt_m_mask_o.* =  g_gldt_m.*
   CALL aglq921_gldt_t_mask()
   LET g_gldt_m_mask_n.* =  g_gldt_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL aglq921_set_act_visible()
   CALL aglq921_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_gldt_m_t.* = g_gldt_m.*
   LET g_gldt_m_o.* = g_gldt_m.*
   
   #重新顯示   
   CALL aglq921_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="aglq921.insert" >}
#+ 資料新增
PRIVATE FUNCTION aglq921_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_gldt_d.clear()
   CALL g_gldt2_d.clear()
   CALL g_gldt3_d.clear()
 
 
   INITIALIZE g_gldt_m.* TO NULL             #DEFAULT 設定
   LET g_gldtld_t = NULL
   LET g_gldt001_t = NULL
   LET g_gldt003_t = NULL
   LET g_gldt005_t = NULL
   LET g_gldt006_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
            LET g_gldt_m.gldt005 = "0"
      LET g_gldt_m.gldt006 = "0"
 
     
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point 
 
      CALL aglq921_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_gldt_m.* TO NULL
         INITIALIZE g_gldt_d TO NULL
         INITIALIZE g_gldt2_d TO NULL
         INITIALIZE g_gldt3_d TO NULL
 
         CALL aglq921_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_gldt_m.* = g_gldt_m_t.*
         CALL aglq921_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_gldt_d.clear()
      #CALL g_gldt2_d.clear()
      #CALL g_gldt3_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL aglq921_set_act_visible()
   CALL aglq921_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_gldtld_t = g_gldt_m.gldtld
   LET g_gldt001_t = g_gldt_m.gldt001
   LET g_gldt003_t = g_gldt_m.gldt003
   LET g_gldt005_t = g_gldt_m.gldt005
   LET g_gldt006_t = g_gldt_m.gldt006
 
   
   #組合新增資料的條件
   LET g_add_browse = " gldtent = " ||g_enterprise|| " AND",
                      " gldtld = '", g_gldt_m.gldtld, "' "
                      ," AND gldt001 = '", g_gldt_m.gldt001, "' "
                      ," AND gldt003 = '", g_gldt_m.gldt003, "' "
                      ," AND gldt005 = '", g_gldt_m.gldt005, "' "
                      ," AND gldt006 = '", g_gldt_m.gldt006, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aglq921_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL aglq921_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aglq921_master_referesh USING g_gldt_m.gldtld,g_gldt_m.gldt001,g_gldt_m.gldt003,g_gldt_m.gldt005, 
       g_gldt_m.gldt006 INTO g_gldt_m.gldtld,g_gldt_m.gldt001,g_gldt_m.gldt003,g_gldt_m.gldt005,g_gldt_m.gldt006, 
       g_gldt_m.gldt009,g_gldt_m.gldt025,g_gldt_m.gldt028
   
   #遮罩相關處理
   LET g_gldt_m_mask_o.* =  g_gldt_m.*
   CALL aglq921_gldt_t_mask()
   LET g_gldt_m_mask_n.* =  g_gldt_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_gldt_m.gldtld,g_gldt_m.gldtld_desc,g_gldt_m.gldt001,g_gldt_m.gldt001_desc,g_gldt_m.gldt003, 
       g_gldt_m.gldt003_desc,g_gldt_m.gldt005,g_gldt_m.gldt006,g_gldt_m.gldt009,g_gldt_m.gldt025,g_gldt_m.gldt028, 
       g_gldt_m.l_chk14,g_gldt_m.l_chk15,g_gldt_m.l_chk16,g_gldt_m.l_chk17,g_gldt_m.l_chk18,g_gldt_m.l_chk19, 
       g_gldt_m.l_chk20,g_gldt_m.l_chk21,g_gldt_m.l_chk36,g_gldt_m.l_chk37,g_gldt_m.l_chk38,g_gldt_m.l_chk22, 
       g_gldt_m.l_chk23,g_gldt_m.l_chk24
   
   #功能已完成,通報訊息中心
   CALL aglq921_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aglq921.modify" >}
#+ 資料修改
PRIVATE FUNCTION aglq921_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_gldt_m.gldtld IS NULL
   OR g_gldt_m.gldt001 IS NULL
   OR g_gldt_m.gldt003 IS NULL
   OR g_gldt_m.gldt005 IS NULL
   OR g_gldt_m.gldt006 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_gldtld_t = g_gldt_m.gldtld
   LET g_gldt001_t = g_gldt_m.gldt001
   LET g_gldt003_t = g_gldt_m.gldt003
   LET g_gldt005_t = g_gldt_m.gldt005
   LET g_gldt006_t = g_gldt_m.gldt006
 
   CALL s_transaction_begin()
   
   OPEN aglq921_cl USING g_enterprise,g_gldt_m.gldtld,g_gldt_m.gldt001,g_gldt_m.gldt003,g_gldt_m.gldt005,g_gldt_m.gldt006
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aglq921_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE aglq921_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aglq921_master_referesh USING g_gldt_m.gldtld,g_gldt_m.gldt001,g_gldt_m.gldt003,g_gldt_m.gldt005, 
       g_gldt_m.gldt006 INTO g_gldt_m.gldtld,g_gldt_m.gldt001,g_gldt_m.gldt003,g_gldt_m.gldt005,g_gldt_m.gldt006, 
       g_gldt_m.gldt009,g_gldt_m.gldt025,g_gldt_m.gldt028
   
   #遮罩相關處理
   LET g_gldt_m_mask_o.* =  g_gldt_m.*
   CALL aglq921_gldt_t_mask()
   LET g_gldt_m_mask_n.* =  g_gldt_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL aglq921_show()
   WHILE TRUE
      LET g_gldtld_t = g_gldt_m.gldtld
      LET g_gldt001_t = g_gldt_m.gldt001
      LET g_gldt003_t = g_gldt_m.gldt003
      LET g_gldt005_t = g_gldt_m.gldt005
      LET g_gldt006_t = g_gldt_m.gldt006
 
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL aglq921_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_gldt_m.* = g_gldt_m_t.*
         CALL aglq921_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_gldt_m.gldtld != g_gldtld_t 
      OR g_gldt_m.gldt001 != g_gldt001_t 
      OR g_gldt_m.gldt003 != g_gldt003_t 
      OR g_gldt_m.gldt005 != g_gldt005_t 
      OR g_gldt_m.gldt006 != g_gldt006_t 
 
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
   CALL aglq921_set_act_visible()
   CALL aglq921_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " gldtent = " ||g_enterprise|| " AND",
                      " gldtld = '", g_gldt_m.gldtld, "' "
                      ," AND gldt001 = '", g_gldt_m.gldt001, "' "
                      ," AND gldt003 = '", g_gldt_m.gldt003, "' "
                      ," AND gldt005 = '", g_gldt_m.gldt005, "' "
                      ," AND gldt006 = '", g_gldt_m.gldt006, "' "
 
   #填到對應位置
   CALL aglq921_browser_fill("")
 
   CALL aglq921_idx_chk()
 
   CLOSE aglq921_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aglq921_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="aglq921.input" >}
#+ 資料輸入
PRIVATE FUNCTION aglq921_input(p_cmd)
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
   DISPLAY BY NAME g_gldt_m.gldtld,g_gldt_m.gldtld_desc,g_gldt_m.gldt001,g_gldt_m.gldt001_desc,g_gldt_m.gldt003, 
       g_gldt_m.gldt003_desc,g_gldt_m.gldt005,g_gldt_m.gldt006,g_gldt_m.gldt009,g_gldt_m.gldt025,g_gldt_m.gldt028, 
       g_gldt_m.l_chk14,g_gldt_m.l_chk15,g_gldt_m.l_chk16,g_gldt_m.l_chk17,g_gldt_m.l_chk18,g_gldt_m.l_chk19, 
       g_gldt_m.l_chk20,g_gldt_m.l_chk21,g_gldt_m.l_chk36,g_gldt_m.l_chk37,g_gldt_m.l_chk38,g_gldt_m.l_chk22, 
       g_gldt_m.l_chk23,g_gldt_m.l_chk24
   
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
   LET g_forupd_sql = "SELECT gldt002,gldt004,gldt008,gldt031,gldt032,gldt007,gldt014,gldt015,gldt016, 
       gldt017,gldt018,gldt019,gldt020,gldt021,gldt036,gldt037,gldt038,gldt022,gldt023,gldt024,gldt033, 
       gldt010,gldt011,gldt002,gldt004,gldt008,gldt031,gldt032,gldt007,gldt034,gldt026,gldt027,gldt002, 
       gldt004,gldt008,gldt031,gldt032,gldt007,gldt035,gldt029,gldt030 FROM gldt_t WHERE gldtent=? AND  
       gldtld=? AND gldt001=? AND gldt003=? AND gldt005=? AND gldt006=? AND gldt002=? AND gldt004=?  
       AND gldt007=? AND gldt008=? AND gldt031=? AND gldt032=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aglq921_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aglq921_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL aglq921_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_gldt_m.gldtld,g_gldt_m.gldt001,g_gldt_m.gldt003,g_gldt_m.gldt005,g_gldt_m.gldt006, 
       g_gldt_m.gldt009,g_gldt_m.gldt025,g_gldt_m.gldt028,g_gldt_m.l_chk14,g_gldt_m.l_chk15,g_gldt_m.l_chk16, 
       g_gldt_m.l_chk17,g_gldt_m.l_chk18,g_gldt_m.l_chk19,g_gldt_m.l_chk20,g_gldt_m.l_chk21,g_gldt_m.l_chk36, 
       g_gldt_m.l_chk37,g_gldt_m.l_chk38,g_gldt_m.l_chk22,g_gldt_m.l_chk23,g_gldt_m.l_chk24
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="aglq921.input.head" >}
   
      #單頭段
      INPUT BY NAME g_gldt_m.gldtld,g_gldt_m.gldt001,g_gldt_m.gldt003,g_gldt_m.gldt005,g_gldt_m.gldt006, 
          g_gldt_m.gldt009,g_gldt_m.gldt025,g_gldt_m.gldt028,g_gldt_m.l_chk14,g_gldt_m.l_chk15,g_gldt_m.l_chk16, 
          g_gldt_m.l_chk17,g_gldt_m.l_chk18,g_gldt_m.l_chk19,g_gldt_m.l_chk20,g_gldt_m.l_chk21,g_gldt_m.l_chk36, 
          g_gldt_m.l_chk37,g_gldt_m.l_chk38,g_gldt_m.l_chk22,g_gldt_m.l_chk23,g_gldt_m.l_chk24 
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
         AFTER FIELD gldtld
            
            #add-point:AFTER FIELD gldtld name="input.a.gldtld"

            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_gldt_m.gldtld) AND NOT cl_null(g_gldt_m.gldt001) AND NOT cl_null(g_gldt_m.gldt003) AND NOT cl_null(g_gldt_m.gldt005) AND NOT cl_null(g_gldt_m.gldt006) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_gldt_m.gldtld != g_gldtld_t  OR g_gldt_m.gldt001 != g_gldt001_t  OR g_gldt_m.gldt003 != g_gldt003_t  OR g_gldt_m.gldt005 != g_gldt005_t  OR g_gldt_m.gldt006 != g_gldt006_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gldt_t WHERE "||"gldtent = '" ||g_enterprise|| "' AND "||"gldtld = '"||g_gldt_m.gldtld ||"' AND "|| "gldt001 = '"||g_gldt_m.gldt001 ||"' AND "|| "gldt003 = '"||g_gldt_m.gldt003 ||"' AND "|| "gldt005 = '"||g_gldt_m.gldt005 ||"' AND "|| "gldt006 = '"||g_gldt_m.gldt006 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldtld
            #add-point:BEFORE FIELD gldtld name="input.b.gldtld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldtld
            #add-point:ON CHANGE gldtld name="input.g.gldtld"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt001
            
            #add-point:AFTER FIELD gldt001 name="input.a.gldt001"

            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_gldt_m.gldtld) AND NOT cl_null(g_gldt_m.gldt001) AND NOT cl_null(g_gldt_m.gldt003) AND NOT cl_null(g_gldt_m.gldt005) AND NOT cl_null(g_gldt_m.gldt006) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_gldt_m.gldtld != g_gldtld_t  OR g_gldt_m.gldt001 != g_gldt001_t  OR g_gldt_m.gldt003 != g_gldt003_t  OR g_gldt_m.gldt005 != g_gldt005_t  OR g_gldt_m.gldt006 != g_gldt006_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gldt_t WHERE "||"gldtent = '" ||g_enterprise|| "' AND "||"gldtld = '"||g_gldt_m.gldtld ||"' AND "|| "gldt001 = '"||g_gldt_m.gldt001 ||"' AND "|| "gldt003 = '"||g_gldt_m.gldt003 ||"' AND "|| "gldt005 = '"||g_gldt_m.gldt005 ||"' AND "|| "gldt006 = '"||g_gldt_m.gldt006 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt001
            #add-point:BEFORE FIELD gldt001 name="input.b.gldt001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldt001
            #add-point:ON CHANGE gldt001 name="input.g.gldt001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt003
            
            #add-point:AFTER FIELD gldt003 name="input.a.gldt003"

            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_gldt_m.gldtld) AND NOT cl_null(g_gldt_m.gldt001) AND NOT cl_null(g_gldt_m.gldt003) AND NOT cl_null(g_gldt_m.gldt005) AND NOT cl_null(g_gldt_m.gldt006) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_gldt_m.gldtld != g_gldtld_t  OR g_gldt_m.gldt001 != g_gldt001_t  OR g_gldt_m.gldt003 != g_gldt003_t  OR g_gldt_m.gldt005 != g_gldt005_t  OR g_gldt_m.gldt006 != g_gldt006_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gldt_t WHERE "||"gldtent = '" ||g_enterprise|| "' AND "||"gldtld = '"||g_gldt_m.gldtld ||"' AND "|| "gldt001 = '"||g_gldt_m.gldt001 ||"' AND "|| "gldt003 = '"||g_gldt_m.gldt003 ||"' AND "|| "gldt005 = '"||g_gldt_m.gldt005 ||"' AND "|| "gldt006 = '"||g_gldt_m.gldt006 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt003
            #add-point:BEFORE FIELD gldt003 name="input.b.gldt003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldt003
            #add-point:ON CHANGE gldt003 name="input.g.gldt003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt005
            #add-point:BEFORE FIELD gldt005 name="input.b.gldt005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt005
            
            #add-point:AFTER FIELD gldt005 name="input.a.gldt005"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_gldt_m.gldtld) AND NOT cl_null(g_gldt_m.gldt001) AND NOT cl_null(g_gldt_m.gldt003) AND NOT cl_null(g_gldt_m.gldt005) AND NOT cl_null(g_gldt_m.gldt006) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_gldt_m.gldtld != g_gldtld_t  OR g_gldt_m.gldt001 != g_gldt001_t  OR g_gldt_m.gldt003 != g_gldt003_t  OR g_gldt_m.gldt005 != g_gldt005_t  OR g_gldt_m.gldt006 != g_gldt006_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gldt_t WHERE "||"gldtent = '" ||g_enterprise|| "' AND "||"gldtld = '"||g_gldt_m.gldtld ||"' AND "|| "gldt001 = '"||g_gldt_m.gldt001 ||"' AND "|| "gldt003 = '"||g_gldt_m.gldt003 ||"' AND "|| "gldt005 = '"||g_gldt_m.gldt005 ||"' AND "|| "gldt006 = '"||g_gldt_m.gldt006 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldt005
            #add-point:ON CHANGE gldt005 name="input.g.gldt005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt006
            #add-point:BEFORE FIELD gldt006 name="input.b.gldt006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt006
            
            #add-point:AFTER FIELD gldt006 name="input.a.gldt006"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_gldt_m.gldtld) AND NOT cl_null(g_gldt_m.gldt001) AND NOT cl_null(g_gldt_m.gldt003) AND NOT cl_null(g_gldt_m.gldt005) AND NOT cl_null(g_gldt_m.gldt006) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_gldt_m.gldtld != g_gldtld_t  OR g_gldt_m.gldt001 != g_gldt001_t  OR g_gldt_m.gldt003 != g_gldt003_t  OR g_gldt_m.gldt005 != g_gldt005_t  OR g_gldt_m.gldt006 != g_gldt006_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gldt_t WHERE "||"gldtent = '" ||g_enterprise|| "' AND "||"gldtld = '"||g_gldt_m.gldtld ||"' AND "|| "gldt001 = '"||g_gldt_m.gldt001 ||"' AND "|| "gldt003 = '"||g_gldt_m.gldt003 ||"' AND "|| "gldt005 = '"||g_gldt_m.gldt005 ||"' AND "|| "gldt006 = '"||g_gldt_m.gldt006 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldt006
            #add-point:ON CHANGE gldt006 name="input.g.gldt006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt009
            #add-point:BEFORE FIELD gldt009 name="input.b.gldt009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt009
            
            #add-point:AFTER FIELD gldt009 name="input.a.gldt009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldt009
            #add-point:ON CHANGE gldt009 name="input.g.gldt009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt025
            #add-point:BEFORE FIELD gldt025 name="input.b.gldt025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt025
            
            #add-point:AFTER FIELD gldt025 name="input.a.gldt025"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldt025
            #add-point:ON CHANGE gldt025 name="input.g.gldt025"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt028
            #add-point:BEFORE FIELD gldt028 name="input.b.gldt028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt028
            
            #add-point:AFTER FIELD gldt028 name="input.a.gldt028"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldt028
            #add-point:ON CHANGE gldt028 name="input.g.gldt028"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_chk14
            #add-point:BEFORE FIELD l_chk14 name="input.b.l_chk14"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_chk14
            
            #add-point:AFTER FIELD l_chk14 name="input.a.l_chk14"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_chk14
            #add-point:ON CHANGE l_chk14 name="input.g.l_chk14"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_chk15
            #add-point:BEFORE FIELD l_chk15 name="input.b.l_chk15"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_chk15
            
            #add-point:AFTER FIELD l_chk15 name="input.a.l_chk15"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_chk15
            #add-point:ON CHANGE l_chk15 name="input.g.l_chk15"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_chk16
            #add-point:BEFORE FIELD l_chk16 name="input.b.l_chk16"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_chk16
            
            #add-point:AFTER FIELD l_chk16 name="input.a.l_chk16"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_chk16
            #add-point:ON CHANGE l_chk16 name="input.g.l_chk16"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_chk17
            #add-point:BEFORE FIELD l_chk17 name="input.b.l_chk17"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_chk17
            
            #add-point:AFTER FIELD l_chk17 name="input.a.l_chk17"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_chk17
            #add-point:ON CHANGE l_chk17 name="input.g.l_chk17"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_chk18
            #add-point:BEFORE FIELD l_chk18 name="input.b.l_chk18"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_chk18
            
            #add-point:AFTER FIELD l_chk18 name="input.a.l_chk18"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_chk18
            #add-point:ON CHANGE l_chk18 name="input.g.l_chk18"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_chk19
            #add-point:BEFORE FIELD l_chk19 name="input.b.l_chk19"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_chk19
            
            #add-point:AFTER FIELD l_chk19 name="input.a.l_chk19"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_chk19
            #add-point:ON CHANGE l_chk19 name="input.g.l_chk19"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_chk20
            #add-point:BEFORE FIELD l_chk20 name="input.b.l_chk20"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_chk20
            
            #add-point:AFTER FIELD l_chk20 name="input.a.l_chk20"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_chk20
            #add-point:ON CHANGE l_chk20 name="input.g.l_chk20"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_chk21
            #add-point:BEFORE FIELD l_chk21 name="input.b.l_chk21"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_chk21
            
            #add-point:AFTER FIELD l_chk21 name="input.a.l_chk21"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_chk21
            #add-point:ON CHANGE l_chk21 name="input.g.l_chk21"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_chk36
            #add-point:BEFORE FIELD l_chk36 name="input.b.l_chk36"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_chk36
            
            #add-point:AFTER FIELD l_chk36 name="input.a.l_chk36"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_chk36
            #add-point:ON CHANGE l_chk36 name="input.g.l_chk36"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_chk37
            #add-point:BEFORE FIELD l_chk37 name="input.b.l_chk37"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_chk37
            
            #add-point:AFTER FIELD l_chk37 name="input.a.l_chk37"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_chk37
            #add-point:ON CHANGE l_chk37 name="input.g.l_chk37"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_chk38
            #add-point:BEFORE FIELD l_chk38 name="input.b.l_chk38"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_chk38
            
            #add-point:AFTER FIELD l_chk38 name="input.a.l_chk38"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_chk38
            #add-point:ON CHANGE l_chk38 name="input.g.l_chk38"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_chk22
            #add-point:BEFORE FIELD l_chk22 name="input.b.l_chk22"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_chk22
            
            #add-point:AFTER FIELD l_chk22 name="input.a.l_chk22"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_chk22
            #add-point:ON CHANGE l_chk22 name="input.g.l_chk22"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_chk23
            #add-point:BEFORE FIELD l_chk23 name="input.b.l_chk23"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_chk23
            
            #add-point:AFTER FIELD l_chk23 name="input.a.l_chk23"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_chk23
            #add-point:ON CHANGE l_chk23 name="input.g.l_chk23"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_chk24
            #add-point:BEFORE FIELD l_chk24 name="input.b.l_chk24"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_chk24
            
            #add-point:AFTER FIELD l_chk24 name="input.a.l_chk24"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_chk24
            #add-point:ON CHANGE l_chk24 name="input.g.l_chk24"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.gldtld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldtld
            #add-point:ON ACTION controlp INFIELD gldtld name="input.c.gldtld"
            
            #END add-point
 
 
         #Ctrlp:input.c.gldt001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt001
            #add-point:ON ACTION controlp INFIELD gldt001 name="input.c.gldt001"
            
            #END add-point
 
 
         #Ctrlp:input.c.gldt003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt003
            #add-point:ON ACTION controlp INFIELD gldt003 name="input.c.gldt003"
            
            #END add-point
 
 
         #Ctrlp:input.c.gldt005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt005
            #add-point:ON ACTION controlp INFIELD gldt005 name="input.c.gldt005"
            
            #END add-point
 
 
         #Ctrlp:input.c.gldt006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt006
            #add-point:ON ACTION controlp INFIELD gldt006 name="input.c.gldt006"
            
            #END add-point
 
 
         #Ctrlp:input.c.gldt009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt009
            #add-point:ON ACTION controlp INFIELD gldt009 name="input.c.gldt009"
            
            #END add-point
 
 
         #Ctrlp:input.c.gldt025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt025
            #add-point:ON ACTION controlp INFIELD gldt025 name="input.c.gldt025"
            
            #END add-point
 
 
         #Ctrlp:input.c.gldt028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt028
            #add-point:ON ACTION controlp INFIELD gldt028 name="input.c.gldt028"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_chk14
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_chk14
            #add-point:ON ACTION controlp INFIELD l_chk14 name="input.c.l_chk14"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_chk15
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_chk15
            #add-point:ON ACTION controlp INFIELD l_chk15 name="input.c.l_chk15"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_chk16
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_chk16
            #add-point:ON ACTION controlp INFIELD l_chk16 name="input.c.l_chk16"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_chk17
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_chk17
            #add-point:ON ACTION controlp INFIELD l_chk17 name="input.c.l_chk17"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_chk18
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_chk18
            #add-point:ON ACTION controlp INFIELD l_chk18 name="input.c.l_chk18"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_chk19
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_chk19
            #add-point:ON ACTION controlp INFIELD l_chk19 name="input.c.l_chk19"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_chk20
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_chk20
            #add-point:ON ACTION controlp INFIELD l_chk20 name="input.c.l_chk20"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_chk21
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_chk21
            #add-point:ON ACTION controlp INFIELD l_chk21 name="input.c.l_chk21"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_chk36
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_chk36
            #add-point:ON ACTION controlp INFIELD l_chk36 name="input.c.l_chk36"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_chk37
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_chk37
            #add-point:ON ACTION controlp INFIELD l_chk37 name="input.c.l_chk37"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_chk38
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_chk38
            #add-point:ON ACTION controlp INFIELD l_chk38 name="input.c.l_chk38"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_chk22
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_chk22
            #add-point:ON ACTION controlp INFIELD l_chk22 name="input.c.l_chk22"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_chk23
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_chk23
            #add-point:ON ACTION controlp INFIELD l_chk23 name="input.c.l_chk23"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_chk24
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_chk24
            #add-point:ON ACTION controlp INFIELD l_chk24 name="input.c.l_chk24"
            
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
            DISPLAY BY NAME g_gldt_m.gldtld             
                            ,g_gldt_m.gldt001   
                            ,g_gldt_m.gldt003   
                            ,g_gldt_m.gldt005   
                            ,g_gldt_m.gldt006   
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
            
               #將遮罩欄位還原
               CALL aglq921_gldt_t_mask_restore('restore_mask_o')
            
               UPDATE gldt_t SET (gldtld,gldt001,gldt003,gldt005,gldt006,gldt009,gldt025,gldt028) = (g_gldt_m.gldtld, 
                   g_gldt_m.gldt001,g_gldt_m.gldt003,g_gldt_m.gldt005,g_gldt_m.gldt006,g_gldt_m.gldt009, 
                   g_gldt_m.gldt025,g_gldt_m.gldt028)
                WHERE gldtent = g_enterprise AND gldtld = g_gldtld_t
                  AND gldt001 = g_gldt001_t
                  AND gldt003 = g_gldt003_t
                  AND gldt005 = g_gldt005_t
                  AND gldt006 = g_gldt006_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gldt_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gldt_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gldt_m.gldtld
               LET gs_keys_bak[1] = g_gldtld_t
               LET gs_keys[2] = g_gldt_m.gldt001
               LET gs_keys_bak[2] = g_gldt001_t
               LET gs_keys[3] = g_gldt_m.gldt003
               LET gs_keys_bak[3] = g_gldt003_t
               LET gs_keys[4] = g_gldt_m.gldt005
               LET gs_keys_bak[4] = g_gldt005_t
               LET gs_keys[5] = g_gldt_m.gldt006
               LET gs_keys_bak[5] = g_gldt006_t
               LET gs_keys[6] = g_gldt_d[g_detail_idx].gldt002
               LET gs_keys_bak[6] = g_gldt_d_t.gldt002
               LET gs_keys[7] = g_gldt_d[g_detail_idx].gldt004
               LET gs_keys_bak[7] = g_gldt_d_t.gldt004
               LET gs_keys[8] = g_gldt_d[g_detail_idx].gldt007
               LET gs_keys_bak[8] = g_gldt_d_t.gldt007
               LET gs_keys[9] = g_gldt_d[g_detail_idx].gldt008
               LET gs_keys_bak[9] = g_gldt_d_t.gldt008
               LET gs_keys[10] = g_gldt_d[g_detail_idx].gldt031
               LET gs_keys_bak[10] = g_gldt_d_t.gldt031
               LET gs_keys[11] = g_gldt_d[g_detail_idx].gldt032
               LET gs_keys_bak[11] = g_gldt_d_t.gldt032
               CALL aglq921_update_b('gldt_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_gldt_m_t)
                     #LET g_log2 = util.JSON.stringify(g_gldt_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL aglq921_gldt_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL aglq921_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_gldtld_t = g_gldt_m.gldtld
           LET g_gldt001_t = g_gldt_m.gldt001
           LET g_gldt003_t = g_gldt_m.gldt003
           LET g_gldt005_t = g_gldt_m.gldt005
           LET g_gldt006_t = g_gldt_m.gldt006
 
           
           IF g_gldt_d.getLength() = 0 THEN
              NEXT FIELD gldt002
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="aglq921.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_gldt_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_gldt_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aglq921_b_fill(g_wc2) #test 
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
            CALL aglq921_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN aglq921_cl USING g_enterprise,g_gldt_m.gldtld,g_gldt_m.gldt001,g_gldt_m.gldt003,g_gldt_m.gldt005,g_gldt_m.gldt006                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE aglq921_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN aglq921_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_gldt_d[l_ac].gldt002 IS NOT NULL
               AND g_gldt_d[l_ac].gldt004 IS NOT NULL
               AND g_gldt_d[l_ac].gldt007 IS NOT NULL
               AND g_gldt_d[l_ac].gldt008 IS NOT NULL
               AND g_gldt_d[l_ac].gldt031 IS NOT NULL
               AND g_gldt_d[l_ac].gldt032 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_gldt_d_t.* = g_gldt_d[l_ac].*  #BACKUP
               LET g_gldt_d_o.* = g_gldt_d[l_ac].*  #BACKUP
               CALL aglq921_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL aglq921_set_no_entry_b(l_cmd)
               OPEN aglq921_bcl USING g_enterprise,g_gldt_m.gldtld,
                                                g_gldt_m.gldt001,
                                                g_gldt_m.gldt003,
                                                g_gldt_m.gldt005,
                                                g_gldt_m.gldt006,
 
                                                g_gldt_d_t.gldt002
                                                ,g_gldt_d_t.gldt004
                                                ,g_gldt_d_t.gldt007
                                                ,g_gldt_d_t.gldt008
                                                ,g_gldt_d_t.gldt031
                                                ,g_gldt_d_t.gldt032
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN aglq921_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aglq921_bcl INTO g_gldt_d[l_ac].gldt002,g_gldt_d[l_ac].gldt004,g_gldt_d[l_ac].gldt008, 
                      g_gldt_d[l_ac].gldt031,g_gldt_d[l_ac].gldt032,g_gldt_d[l_ac].gldt007,g_gldt_d[l_ac].gldt014, 
                      g_gldt_d[l_ac].gldt015,g_gldt_d[l_ac].gldt016,g_gldt_d[l_ac].gldt017,g_gldt_d[l_ac].gldt018, 
                      g_gldt_d[l_ac].gldt019,g_gldt_d[l_ac].gldt020,g_gldt_d[l_ac].gldt021,g_gldt_d[l_ac].gldt036, 
                      g_gldt_d[l_ac].gldt037,g_gldt_d[l_ac].gldt038,g_gldt_d[l_ac].gldt022,g_gldt_d[l_ac].gldt023, 
                      g_gldt_d[l_ac].gldt024,g_gldt_d[l_ac].gldt033,g_gldt_d[l_ac].gldt010,g_gldt_d[l_ac].gldt011, 
                      g_gldt2_d[l_ac].gldt002,g_gldt2_d[l_ac].gldt004,g_gldt2_d[l_ac].gldt008,g_gldt2_d[l_ac].gldt031, 
                      g_gldt2_d[l_ac].gldt032,g_gldt2_d[l_ac].gldt007,g_gldt2_d[l_ac].gldt034,g_gldt2_d[l_ac].gldt026, 
                      g_gldt2_d[l_ac].gldt027,g_gldt3_d[l_ac].gldt002,g_gldt3_d[l_ac].gldt004,g_gldt3_d[l_ac].gldt008, 
                      g_gldt3_d[l_ac].gldt031,g_gldt3_d[l_ac].gldt032,g_gldt3_d[l_ac].gldt007,g_gldt3_d[l_ac].gldt035, 
                      g_gldt3_d[l_ac].gldt029,g_gldt3_d[l_ac].gldt030
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_gldt_d_t.gldt002,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_gldt_d_mask_o[l_ac].* =  g_gldt_d[l_ac].*
                  CALL aglq921_gldt_t_mask()
                  LET g_gldt_d_mask_n[l_ac].* =  g_gldt_d[l_ac].*
                  
                  CALL aglq921_ref_show()
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
            INITIALIZE g_gldt_d_t.* TO NULL
            INITIALIZE g_gldt_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_gldt_d[l_ac].* TO NULL
            #公用欄位預設值
              
            #一般欄位預設值
                  LET g_gldt_d[l_ac].gldt033 = "0"
      LET g_gldt_d[l_ac].gldt010 = "0"
      LET g_gldt_d[l_ac].gldt011 = "0"
      LET g_gldt_d[l_ac].l_gldt011 = "0"
 
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            
            #end add-point
            LET g_gldt_d_t.* = g_gldt_d[l_ac].*     #新輸入資料
            LET g_gldt_d_o.* = g_gldt_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aglq921_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL aglq921_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_gldt_d[li_reproduce_target].* = g_gldt_d[li_reproduce].*
               LET g_gldt2_d[li_reproduce_target].* = g_gldt2_d[li_reproduce].*
               LET g_gldt3_d[li_reproduce_target].* = g_gldt3_d[li_reproduce].*
 
               LET g_gldt_d[g_gldt_d.getLength()].gldt002 = NULL
               LET g_gldt_d[g_gldt_d.getLength()].gldt004 = NULL
               LET g_gldt_d[g_gldt_d.getLength()].gldt007 = NULL
               LET g_gldt_d[g_gldt_d.getLength()].gldt008 = NULL
               LET g_gldt_d[g_gldt_d.getLength()].gldt031 = NULL
               LET g_gldt_d[g_gldt_d.getLength()].gldt032 = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM gldt_t 
             WHERE gldtent = g_enterprise AND gldtld = g_gldt_m.gldtld
               AND gldt001 = g_gldt_m.gldt001
               AND gldt003 = g_gldt_m.gldt003
               AND gldt005 = g_gldt_m.gldt005
               AND gldt006 = g_gldt_m.gldt006
 
               AND gldt002 = g_gldt_d[l_ac].gldt002
               AND gldt004 = g_gldt_d[l_ac].gldt004
               AND gldt007 = g_gldt_d[l_ac].gldt007
               AND gldt008 = g_gldt_d[l_ac].gldt008
               AND gldt031 = g_gldt_d[l_ac].gldt031
               AND gldt032 = g_gldt_d[l_ac].gldt032
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
               INSERT INTO gldt_t
                           (gldtent,
                            gldtld,gldt001,gldt003,gldt005,gldt006,gldt009,gldt025,gldt028,
                            gldt002,gldt004,gldt007,gldt008,gldt031,gldt032
                            ,gldt014,gldt015,gldt016,gldt017,gldt018,gldt019,gldt020,gldt021,gldt036,gldt037,gldt038,gldt022,gldt023,gldt024,gldt033,gldt010,gldt011,gldt034,gldt026,gldt027,gldt035,gldt029,gldt030) 
                     VALUES(g_enterprise,
                            g_gldt_m.gldtld,g_gldt_m.gldt001,g_gldt_m.gldt003,g_gldt_m.gldt005,g_gldt_m.gldt006,g_gldt_m.gldt009,g_gldt_m.gldt025,g_gldt_m.gldt028,
                            g_gldt_d[l_ac].gldt002,g_gldt_d[l_ac].gldt004,g_gldt_d[l_ac].gldt007,g_gldt_d[l_ac].gldt008, 
                                g_gldt_d[l_ac].gldt031,g_gldt_d[l_ac].gldt032
                            ,g_gldt_d[l_ac].gldt014,g_gldt_d[l_ac].gldt015,g_gldt_d[l_ac].gldt016,g_gldt_d[l_ac].gldt017, 
                                g_gldt_d[l_ac].gldt018,g_gldt_d[l_ac].gldt019,g_gldt_d[l_ac].gldt020, 
                                g_gldt_d[l_ac].gldt021,g_gldt_d[l_ac].gldt036,g_gldt_d[l_ac].gldt037, 
                                g_gldt_d[l_ac].gldt038,g_gldt_d[l_ac].gldt022,g_gldt_d[l_ac].gldt023, 
                                g_gldt_d[l_ac].gldt024,g_gldt_d[l_ac].gldt033,g_gldt_d[l_ac].gldt010, 
                                g_gldt_d[l_ac].gldt011,g_gldt2_d[l_ac].gldt034,g_gldt2_d[l_ac].gldt026, 
                                g_gldt2_d[l_ac].gldt027,g_gldt3_d[l_ac].gldt035,g_gldt3_d[l_ac].gldt029, 
                                g_gldt3_d[l_ac].gldt030)
               #add-point:單身新增中 name="input.body.m_insert"
               
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_gldt_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "gldt_t:",SQLERRMESSAGE 
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
               IF aglq921_before_delete() THEN 
                  
 
 
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_gldt_m.gldtld
                  LET gs_keys[gs_keys.getLength()+1] = g_gldt_m.gldt001
                  LET gs_keys[gs_keys.getLength()+1] = g_gldt_m.gldt003
                  LET gs_keys[gs_keys.getLength()+1] = g_gldt_m.gldt005
                  LET gs_keys[gs_keys.getLength()+1] = g_gldt_m.gldt006
 
                  LET gs_keys[gs_keys.getLength()+1] = g_gldt_d_t.gldt002
                  LET gs_keys[gs_keys.getLength()+1] = g_gldt_d_t.gldt004
                  LET gs_keys[gs_keys.getLength()+1] = g_gldt_d_t.gldt007
                  LET gs_keys[gs_keys.getLength()+1] = g_gldt_d_t.gldt008
                  LET gs_keys[gs_keys.getLength()+1] = g_gldt_d_t.gldt031
                  LET gs_keys[gs_keys.getLength()+1] = g_gldt_d_t.gldt032
 
 
                  #刪除下層單身
                  IF NOT aglq921_key_delete_b(gs_keys,'gldt_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE aglq921_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE aglq921_bcl
               LET l_count = g_gldt_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_gldt_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt002
            #add-point:BEFORE FIELD gldt002 name="input.b.page1.gldt002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt002
            
            #add-point:AFTER FIELD gldt002 name="input.a.page1.gldt002"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_gldt_m.gldtld IS NOT NULL AND g_gldt_m.gldt001 IS NOT NULL AND g_gldt_m.gldt003 IS NOT NULL AND g_gldt_m.gldt005 IS NOT NULL AND g_gldt_m.gldt006 IS NOT NULL AND g_gldt_d[g_detail_idx].gldt002 IS NOT NULL AND g_gldt_d[g_detail_idx].gldt004 IS NOT NULL AND g_gldt_d[g_detail_idx].gldt007 IS NOT NULL AND g_gldt_d[g_detail_idx].gldt008 IS NOT NULL AND g_gldt_d[g_detail_idx].gldt031 IS NOT NULL AND g_gldt_d[g_detail_idx].gldt032 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gldt_m.gldtld != g_gldtld_t OR g_gldt_m.gldt001 != g_gldt001_t OR g_gldt_m.gldt003 != g_gldt003_t OR g_gldt_m.gldt005 != g_gldt005_t OR g_gldt_m.gldt006 != g_gldt006_t OR g_gldt_d[g_detail_idx].gldt002 != g_gldt_d_t.gldt002 OR g_gldt_d[g_detail_idx].gldt004 != g_gldt_d_t.gldt004 OR g_gldt_d[g_detail_idx].gldt007 != g_gldt_d_t.gldt007 OR g_gldt_d[g_detail_idx].gldt008 != g_gldt_d_t.gldt008 OR g_gldt_d[g_detail_idx].gldt031 != g_gldt_d_t.gldt031 OR g_gldt_d[g_detail_idx].gldt032 != g_gldt_d_t.gldt032)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gldt_t WHERE "||"gldtent = '" ||g_enterprise|| "' AND "||"gldtld = '"||g_gldt_m.gldtld ||"' AND "|| "gldt001 = '"||g_gldt_m.gldt001 ||"' AND "|| "gldt003 = '"||g_gldt_m.gldt003 ||"' AND "|| "gldt005 = '"||g_gldt_m.gldt005 ||"' AND "|| "gldt006 = '"||g_gldt_m.gldt006 ||"' AND "|| "gldt002 = '"||g_gldt_d[g_detail_idx].gldt002 ||"' AND "|| "gldt004 = '"||g_gldt_d[g_detail_idx].gldt004 ||"' AND "|| "gldt007 = '"||g_gldt_d[g_detail_idx].gldt007 ||"' AND "|| "gldt008 = '"||g_gldt_d[g_detail_idx].gldt008 ||"' AND "|| "gldt031 = '"||g_gldt_d[g_detail_idx].gldt031 ||"' AND "|| "gldt032 = '"||g_gldt_d[g_detail_idx].gldt032 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldt002
            #add-point:ON CHANGE gldt002 name="input.g.page1.gldt002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt004
            #add-point:BEFORE FIELD gldt004 name="input.b.page1.gldt004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt004
            
            #add-point:AFTER FIELD gldt004 name="input.a.page1.gldt004"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_gldt_m.gldtld IS NOT NULL AND g_gldt_m.gldt001 IS NOT NULL AND g_gldt_m.gldt003 IS NOT NULL AND g_gldt_m.gldt005 IS NOT NULL AND g_gldt_m.gldt006 IS NOT NULL AND g_gldt_d[g_detail_idx].gldt002 IS NOT NULL AND g_gldt_d[g_detail_idx].gldt004 IS NOT NULL AND g_gldt_d[g_detail_idx].gldt007 IS NOT NULL AND g_gldt_d[g_detail_idx].gldt008 IS NOT NULL AND g_gldt_d[g_detail_idx].gldt031 IS NOT NULL AND g_gldt_d[g_detail_idx].gldt032 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gldt_m.gldtld != g_gldtld_t OR g_gldt_m.gldt001 != g_gldt001_t OR g_gldt_m.gldt003 != g_gldt003_t OR g_gldt_m.gldt005 != g_gldt005_t OR g_gldt_m.gldt006 != g_gldt006_t OR g_gldt_d[g_detail_idx].gldt002 != g_gldt_d_t.gldt002 OR g_gldt_d[g_detail_idx].gldt004 != g_gldt_d_t.gldt004 OR g_gldt_d[g_detail_idx].gldt007 != g_gldt_d_t.gldt007 OR g_gldt_d[g_detail_idx].gldt008 != g_gldt_d_t.gldt008 OR g_gldt_d[g_detail_idx].gldt031 != g_gldt_d_t.gldt031 OR g_gldt_d[g_detail_idx].gldt032 != g_gldt_d_t.gldt032)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gldt_t WHERE "||"gldtent = '" ||g_enterprise|| "' AND "||"gldtld = '"||g_gldt_m.gldtld ||"' AND "|| "gldt001 = '"||g_gldt_m.gldt001 ||"' AND "|| "gldt003 = '"||g_gldt_m.gldt003 ||"' AND "|| "gldt005 = '"||g_gldt_m.gldt005 ||"' AND "|| "gldt006 = '"||g_gldt_m.gldt006 ||"' AND "|| "gldt002 = '"||g_gldt_d[g_detail_idx].gldt002 ||"' AND "|| "gldt004 = '"||g_gldt_d[g_detail_idx].gldt004 ||"' AND "|| "gldt007 = '"||g_gldt_d[g_detail_idx].gldt007 ||"' AND "|| "gldt008 = '"||g_gldt_d[g_detail_idx].gldt008 ||"' AND "|| "gldt031 = '"||g_gldt_d[g_detail_idx].gldt031 ||"' AND "|| "gldt032 = '"||g_gldt_d[g_detail_idx].gldt032 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldt004
            #add-point:ON CHANGE gldt004 name="input.g.page1.gldt004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt008
            #add-point:BEFORE FIELD gldt008 name="input.b.page1.gldt008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt008
            
            #add-point:AFTER FIELD gldt008 name="input.a.page1.gldt008"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_gldt_m.gldtld IS NOT NULL AND g_gldt_m.gldt001 IS NOT NULL AND g_gldt_m.gldt003 IS NOT NULL AND g_gldt_m.gldt005 IS NOT NULL AND g_gldt_m.gldt006 IS NOT NULL AND g_gldt_d[g_detail_idx].gldt002 IS NOT NULL AND g_gldt_d[g_detail_idx].gldt004 IS NOT NULL AND g_gldt_d[g_detail_idx].gldt007 IS NOT NULL AND g_gldt_d[g_detail_idx].gldt008 IS NOT NULL AND g_gldt_d[g_detail_idx].gldt031 IS NOT NULL AND g_gldt_d[g_detail_idx].gldt032 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gldt_m.gldtld != g_gldtld_t OR g_gldt_m.gldt001 != g_gldt001_t OR g_gldt_m.gldt003 != g_gldt003_t OR g_gldt_m.gldt005 != g_gldt005_t OR g_gldt_m.gldt006 != g_gldt006_t OR g_gldt_d[g_detail_idx].gldt002 != g_gldt_d_t.gldt002 OR g_gldt_d[g_detail_idx].gldt004 != g_gldt_d_t.gldt004 OR g_gldt_d[g_detail_idx].gldt007 != g_gldt_d_t.gldt007 OR g_gldt_d[g_detail_idx].gldt008 != g_gldt_d_t.gldt008 OR g_gldt_d[g_detail_idx].gldt031 != g_gldt_d_t.gldt031 OR g_gldt_d[g_detail_idx].gldt032 != g_gldt_d_t.gldt032)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gldt_t WHERE "||"gldtent = '" ||g_enterprise|| "' AND "||"gldtld = '"||g_gldt_m.gldtld ||"' AND "|| "gldt001 = '"||g_gldt_m.gldt001 ||"' AND "|| "gldt003 = '"||g_gldt_m.gldt003 ||"' AND "|| "gldt005 = '"||g_gldt_m.gldt005 ||"' AND "|| "gldt006 = '"||g_gldt_m.gldt006 ||"' AND "|| "gldt002 = '"||g_gldt_d[g_detail_idx].gldt002 ||"' AND "|| "gldt004 = '"||g_gldt_d[g_detail_idx].gldt004 ||"' AND "|| "gldt007 = '"||g_gldt_d[g_detail_idx].gldt007 ||"' AND "|| "gldt008 = '"||g_gldt_d[g_detail_idx].gldt008 ||"' AND "|| "gldt031 = '"||g_gldt_d[g_detail_idx].gldt031 ||"' AND "|| "gldt032 = '"||g_gldt_d[g_detail_idx].gldt032 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldt008
            #add-point:ON CHANGE gldt008 name="input.g.page1.gldt008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt031
            #add-point:BEFORE FIELD gldt031 name="input.b.page1.gldt031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt031
            
            #add-point:AFTER FIELD gldt031 name="input.a.page1.gldt031"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_gldt_m.gldtld IS NOT NULL AND g_gldt_m.gldt001 IS NOT NULL AND g_gldt_m.gldt003 IS NOT NULL AND g_gldt_m.gldt005 IS NOT NULL AND g_gldt_m.gldt006 IS NOT NULL AND g_gldt_d[g_detail_idx].gldt002 IS NOT NULL AND g_gldt_d[g_detail_idx].gldt004 IS NOT NULL AND g_gldt_d[g_detail_idx].gldt007 IS NOT NULL AND g_gldt_d[g_detail_idx].gldt008 IS NOT NULL AND g_gldt_d[g_detail_idx].gldt031 IS NOT NULL AND g_gldt_d[g_detail_idx].gldt032 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gldt_m.gldtld != g_gldtld_t OR g_gldt_m.gldt001 != g_gldt001_t OR g_gldt_m.gldt003 != g_gldt003_t OR g_gldt_m.gldt005 != g_gldt005_t OR g_gldt_m.gldt006 != g_gldt006_t OR g_gldt_d[g_detail_idx].gldt002 != g_gldt_d_t.gldt002 OR g_gldt_d[g_detail_idx].gldt004 != g_gldt_d_t.gldt004 OR g_gldt_d[g_detail_idx].gldt007 != g_gldt_d_t.gldt007 OR g_gldt_d[g_detail_idx].gldt008 != g_gldt_d_t.gldt008 OR g_gldt_d[g_detail_idx].gldt031 != g_gldt_d_t.gldt031 OR g_gldt_d[g_detail_idx].gldt032 != g_gldt_d_t.gldt032)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gldt_t WHERE "||"gldtent = '" ||g_enterprise|| "' AND "||"gldtld = '"||g_gldt_m.gldtld ||"' AND "|| "gldt001 = '"||g_gldt_m.gldt001 ||"' AND "|| "gldt003 = '"||g_gldt_m.gldt003 ||"' AND "|| "gldt005 = '"||g_gldt_m.gldt005 ||"' AND "|| "gldt006 = '"||g_gldt_m.gldt006 ||"' AND "|| "gldt002 = '"||g_gldt_d[g_detail_idx].gldt002 ||"' AND "|| "gldt004 = '"||g_gldt_d[g_detail_idx].gldt004 ||"' AND "|| "gldt007 = '"||g_gldt_d[g_detail_idx].gldt007 ||"' AND "|| "gldt008 = '"||g_gldt_d[g_detail_idx].gldt008 ||"' AND "|| "gldt031 = '"||g_gldt_d[g_detail_idx].gldt031 ||"' AND "|| "gldt032 = '"||g_gldt_d[g_detail_idx].gldt032 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldt031
            #add-point:ON CHANGE gldt031 name="input.g.page1.gldt031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt032
            #add-point:BEFORE FIELD gldt032 name="input.b.page1.gldt032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt032
            
            #add-point:AFTER FIELD gldt032 name="input.a.page1.gldt032"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_gldt_m.gldtld IS NOT NULL AND g_gldt_m.gldt001 IS NOT NULL AND g_gldt_m.gldt003 IS NOT NULL AND g_gldt_m.gldt005 IS NOT NULL AND g_gldt_m.gldt006 IS NOT NULL AND g_gldt_d[g_detail_idx].gldt002 IS NOT NULL AND g_gldt_d[g_detail_idx].gldt004 IS NOT NULL AND g_gldt_d[g_detail_idx].gldt007 IS NOT NULL AND g_gldt_d[g_detail_idx].gldt008 IS NOT NULL AND g_gldt_d[g_detail_idx].gldt031 IS NOT NULL AND g_gldt_d[g_detail_idx].gldt032 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gldt_m.gldtld != g_gldtld_t OR g_gldt_m.gldt001 != g_gldt001_t OR g_gldt_m.gldt003 != g_gldt003_t OR g_gldt_m.gldt005 != g_gldt005_t OR g_gldt_m.gldt006 != g_gldt006_t OR g_gldt_d[g_detail_idx].gldt002 != g_gldt_d_t.gldt002 OR g_gldt_d[g_detail_idx].gldt004 != g_gldt_d_t.gldt004 OR g_gldt_d[g_detail_idx].gldt007 != g_gldt_d_t.gldt007 OR g_gldt_d[g_detail_idx].gldt008 != g_gldt_d_t.gldt008 OR g_gldt_d[g_detail_idx].gldt031 != g_gldt_d_t.gldt031 OR g_gldt_d[g_detail_idx].gldt032 != g_gldt_d_t.gldt032)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gldt_t WHERE "||"gldtent = '" ||g_enterprise|| "' AND "||"gldtld = '"||g_gldt_m.gldtld ||"' AND "|| "gldt001 = '"||g_gldt_m.gldt001 ||"' AND "|| "gldt003 = '"||g_gldt_m.gldt003 ||"' AND "|| "gldt005 = '"||g_gldt_m.gldt005 ||"' AND "|| "gldt006 = '"||g_gldt_m.gldt006 ||"' AND "|| "gldt002 = '"||g_gldt_d[g_detail_idx].gldt002 ||"' AND "|| "gldt004 = '"||g_gldt_d[g_detail_idx].gldt004 ||"' AND "|| "gldt007 = '"||g_gldt_d[g_detail_idx].gldt007 ||"' AND "|| "gldt008 = '"||g_gldt_d[g_detail_idx].gldt008 ||"' AND "|| "gldt031 = '"||g_gldt_d[g_detail_idx].gldt031 ||"' AND "|| "gldt032 = '"||g_gldt_d[g_detail_idx].gldt032 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldt032
            #add-point:ON CHANGE gldt032 name="input.g.page1.gldt032"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt007
            
            #add-point:AFTER FIELD gldt007 name="input.a.page1.gldt007"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_gldt_m.gldtld IS NOT NULL AND g_gldt_m.gldt001 IS NOT NULL AND g_gldt_m.gldt003 IS NOT NULL AND g_gldt_m.gldt005 IS NOT NULL AND g_gldt_m.gldt006 IS NOT NULL AND g_gldt_d[g_detail_idx].gldt002 IS NOT NULL AND g_gldt_d[g_detail_idx].gldt004 IS NOT NULL AND g_gldt_d[g_detail_idx].gldt007 IS NOT NULL AND g_gldt_d[g_detail_idx].gldt008 IS NOT NULL AND g_gldt_d[g_detail_idx].gldt031 IS NOT NULL AND g_gldt_d[g_detail_idx].gldt032 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gldt_m.gldtld != g_gldtld_t OR g_gldt_m.gldt001 != g_gldt001_t OR g_gldt_m.gldt003 != g_gldt003_t OR g_gldt_m.gldt005 != g_gldt005_t OR g_gldt_m.gldt006 != g_gldt006_t OR g_gldt_d[g_detail_idx].gldt002 != g_gldt_d_t.gldt002 OR g_gldt_d[g_detail_idx].gldt004 != g_gldt_d_t.gldt004 OR g_gldt_d[g_detail_idx].gldt007 != g_gldt_d_t.gldt007 OR g_gldt_d[g_detail_idx].gldt008 != g_gldt_d_t.gldt008 OR g_gldt_d[g_detail_idx].gldt031 != g_gldt_d_t.gldt031 OR g_gldt_d[g_detail_idx].gldt032 != g_gldt_d_t.gldt032)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gldt_t WHERE "||"gldtent = '" ||g_enterprise|| "' AND "||"gldtld = '"||g_gldt_m.gldtld ||"' AND "|| "gldt001 = '"||g_gldt_m.gldt001 ||"' AND "|| "gldt003 = '"||g_gldt_m.gldt003 ||"' AND "|| "gldt005 = '"||g_gldt_m.gldt005 ||"' AND "|| "gldt006 = '"||g_gldt_m.gldt006 ||"' AND "|| "gldt002 = '"||g_gldt_d[g_detail_idx].gldt002 ||"' AND "|| "gldt004 = '"||g_gldt_d[g_detail_idx].gldt004 ||"' AND "|| "gldt007 = '"||g_gldt_d[g_detail_idx].gldt007 ||"' AND "|| "gldt008 = '"||g_gldt_d[g_detail_idx].gldt008 ||"' AND "|| "gldt031 = '"||g_gldt_d[g_detail_idx].gldt031 ||"' AND "|| "gldt032 = '"||g_gldt_d[g_detail_idx].gldt032 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt007
            #add-point:BEFORE FIELD gldt007 name="input.b.page1.gldt007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldt007
            #add-point:ON CHANGE gldt007 name="input.g.page1.gldt007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt014
            
            #add-point:AFTER FIELD gldt014 name="input.a.page1.gldt014"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt014
            #add-point:BEFORE FIELD gldt014 name="input.b.page1.gldt014"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldt014
            #add-point:ON CHANGE gldt014 name="input.g.page1.gldt014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt014_desc
            #add-point:BEFORE FIELD gldt014_desc name="input.b.page1.gldt014_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt014_desc
            
            #add-point:AFTER FIELD gldt014_desc name="input.a.page1.gldt014_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldt014_desc
            #add-point:ON CHANGE gldt014_desc name="input.g.page1.gldt014_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt015
            
            #add-point:AFTER FIELD gldt015 name="input.a.page1.gldt015"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt015
            #add-point:BEFORE FIELD gldt015 name="input.b.page1.gldt015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldt015
            #add-point:ON CHANGE gldt015 name="input.g.page1.gldt015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt015_desc
            #add-point:BEFORE FIELD gldt015_desc name="input.b.page1.gldt015_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt015_desc
            
            #add-point:AFTER FIELD gldt015_desc name="input.a.page1.gldt015_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldt015_desc
            #add-point:ON CHANGE gldt015_desc name="input.g.page1.gldt015_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt016
            
            #add-point:AFTER FIELD gldt016 name="input.a.page1.gldt016"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt016
            #add-point:BEFORE FIELD gldt016 name="input.b.page1.gldt016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldt016
            #add-point:ON CHANGE gldt016 name="input.g.page1.gldt016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt016_desc
            #add-point:BEFORE FIELD gldt016_desc name="input.b.page1.gldt016_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt016_desc
            
            #add-point:AFTER FIELD gldt016_desc name="input.a.page1.gldt016_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldt016_desc
            #add-point:ON CHANGE gldt016_desc name="input.g.page1.gldt016_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt017
            
            #add-point:AFTER FIELD gldt017 name="input.a.page1.gldt017"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt017
            #add-point:BEFORE FIELD gldt017 name="input.b.page1.gldt017"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldt017
            #add-point:ON CHANGE gldt017 name="input.g.page1.gldt017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt017_desc
            #add-point:BEFORE FIELD gldt017_desc name="input.b.page1.gldt017_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt017_desc
            
            #add-point:AFTER FIELD gldt017_desc name="input.a.page1.gldt017_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldt017_desc
            #add-point:ON CHANGE gldt017_desc name="input.g.page1.gldt017_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt018
            
            #add-point:AFTER FIELD gldt018 name="input.a.page1.gldt018"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt018
            #add-point:BEFORE FIELD gldt018 name="input.b.page1.gldt018"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldt018
            #add-point:ON CHANGE gldt018 name="input.g.page1.gldt018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt018_desc
            #add-point:BEFORE FIELD gldt018_desc name="input.b.page1.gldt018_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt018_desc
            
            #add-point:AFTER FIELD gldt018_desc name="input.a.page1.gldt018_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldt018_desc
            #add-point:ON CHANGE gldt018_desc name="input.g.page1.gldt018_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt019
            
            #add-point:AFTER FIELD gldt019 name="input.a.page1.gldt019"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt019
            #add-point:BEFORE FIELD gldt019 name="input.b.page1.gldt019"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldt019
            #add-point:ON CHANGE gldt019 name="input.g.page1.gldt019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt019_desc
            #add-point:BEFORE FIELD gldt019_desc name="input.b.page1.gldt019_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt019_desc
            
            #add-point:AFTER FIELD gldt019_desc name="input.a.page1.gldt019_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldt019_desc
            #add-point:ON CHANGE gldt019_desc name="input.g.page1.gldt019_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt020
            
            #add-point:AFTER FIELD gldt020 name="input.a.page1.gldt020"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt020
            #add-point:BEFORE FIELD gldt020 name="input.b.page1.gldt020"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldt020
            #add-point:ON CHANGE gldt020 name="input.g.page1.gldt020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt020_desc
            #add-point:BEFORE FIELD gldt020_desc name="input.b.page1.gldt020_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt020_desc
            
            #add-point:AFTER FIELD gldt020_desc name="input.a.page1.gldt020_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldt020_desc
            #add-point:ON CHANGE gldt020_desc name="input.g.page1.gldt020_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt021
            
            #add-point:AFTER FIELD gldt021 name="input.a.page1.gldt021"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt021
            #add-point:BEFORE FIELD gldt021 name="input.b.page1.gldt021"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldt021
            #add-point:ON CHANGE gldt021 name="input.g.page1.gldt021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt021_desc
            #add-point:BEFORE FIELD gldt021_desc name="input.b.page1.gldt021_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt021_desc
            
            #add-point:AFTER FIELD gldt021_desc name="input.a.page1.gldt021_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldt021_desc
            #add-point:ON CHANGE gldt021_desc name="input.g.page1.gldt021_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt036
            #add-point:BEFORE FIELD gldt036 name="input.b.page1.gldt036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt036
            
            #add-point:AFTER FIELD gldt036 name="input.a.page1.gldt036"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldt036
            #add-point:ON CHANGE gldt036 name="input.g.page1.gldt036"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt037
            
            #add-point:AFTER FIELD gldt037 name="input.a.page1.gldt037"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt037
            #add-point:BEFORE FIELD gldt037 name="input.b.page1.gldt037"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldt037
            #add-point:ON CHANGE gldt037 name="input.g.page1.gldt037"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt037_desc
            #add-point:BEFORE FIELD gldt037_desc name="input.b.page1.gldt037_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt037_desc
            
            #add-point:AFTER FIELD gldt037_desc name="input.a.page1.gldt037_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldt037_desc
            #add-point:ON CHANGE gldt037_desc name="input.g.page1.gldt037_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt038
            
            #add-point:AFTER FIELD gldt038 name="input.a.page1.gldt038"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt038
            #add-point:BEFORE FIELD gldt038 name="input.b.page1.gldt038"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldt038
            #add-point:ON CHANGE gldt038 name="input.g.page1.gldt038"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt038_desc
            #add-point:BEFORE FIELD gldt038_desc name="input.b.page1.gldt038_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt038_desc
            
            #add-point:AFTER FIELD gldt038_desc name="input.a.page1.gldt038_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldt038_desc
            #add-point:ON CHANGE gldt038_desc name="input.g.page1.gldt038_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt022
            
            #add-point:AFTER FIELD gldt022 name="input.a.page1.gldt022"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt022
            #add-point:BEFORE FIELD gldt022 name="input.b.page1.gldt022"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldt022
            #add-point:ON CHANGE gldt022 name="input.g.page1.gldt022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt022_desc
            #add-point:BEFORE FIELD gldt022_desc name="input.b.page1.gldt022_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt022_desc
            
            #add-point:AFTER FIELD gldt022_desc name="input.a.page1.gldt022_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldt022_desc
            #add-point:ON CHANGE gldt022_desc name="input.g.page1.gldt022_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt023
            
            #add-point:AFTER FIELD gldt023 name="input.a.page1.gldt023"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt023
            #add-point:BEFORE FIELD gldt023 name="input.b.page1.gldt023"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldt023
            #add-point:ON CHANGE gldt023 name="input.g.page1.gldt023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt023_desc
            #add-point:BEFORE FIELD gldt023_desc name="input.b.page1.gldt023_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt023_desc
            
            #add-point:AFTER FIELD gldt023_desc name="input.a.page1.gldt023_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldt023_desc
            #add-point:ON CHANGE gldt023_desc name="input.g.page1.gldt023_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt024
            
            #add-point:AFTER FIELD gldt024 name="input.a.page1.gldt024"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt024
            #add-point:BEFORE FIELD gldt024 name="input.b.page1.gldt024"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldt024
            #add-point:ON CHANGE gldt024 name="input.g.page1.gldt024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt024_desc
            #add-point:BEFORE FIELD gldt024_desc name="input.b.page1.gldt024_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt024_desc
            
            #add-point:AFTER FIELD gldt024_desc name="input.a.page1.gldt024_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldt024_desc
            #add-point:ON CHANGE gldt024_desc name="input.g.page1.gldt024_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt033
            #add-point:BEFORE FIELD gldt033 name="input.b.page1.gldt033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt033
            
            #add-point:AFTER FIELD gldt033 name="input.a.page1.gldt033"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldt033
            #add-point:ON CHANGE gldt033 name="input.g.page1.gldt033"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt010
            #add-point:BEFORE FIELD gldt010 name="input.b.page1.gldt010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt010
            
            #add-point:AFTER FIELD gldt010 name="input.a.page1.gldt010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldt010
            #add-point:ON CHANGE gldt010 name="input.g.page1.gldt010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt011
            #add-point:BEFORE FIELD gldt011 name="input.b.page1.gldt011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt011
            
            #add-point:AFTER FIELD gldt011 name="input.a.page1.gldt011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldt011
            #add-point:ON CHANGE gldt011 name="input.g.page1.gldt011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldt011
            #add-point:BEFORE FIELD l_gldt011 name="input.b.page1.l_gldt011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldt011
            
            #add-point:AFTER FIELD l_gldt011 name="input.a.page1.l_gldt011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldt011
            #add-point:ON CHANGE l_gldt011 name="input.g.page1.l_gldt011"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.gldt002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt002
            #add-point:ON ACTION controlp INFIELD gldt002 name="input.c.page1.gldt002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldt004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt004
            #add-point:ON ACTION controlp INFIELD gldt004 name="input.c.page1.gldt004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldt008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt008
            #add-point:ON ACTION controlp INFIELD gldt008 name="input.c.page1.gldt008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldt031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt031
            #add-point:ON ACTION controlp INFIELD gldt031 name="input.c.page1.gldt031"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldt032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt032
            #add-point:ON ACTION controlp INFIELD gldt032 name="input.c.page1.gldt032"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldt007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt007
            #add-point:ON ACTION controlp INFIELD gldt007 name="input.c.page1.gldt007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldt014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt014
            #add-point:ON ACTION controlp INFIELD gldt014 name="input.c.page1.gldt014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldt014_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt014_desc
            #add-point:ON ACTION controlp INFIELD gldt014_desc name="input.c.page1.gldt014_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldt015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt015
            #add-point:ON ACTION controlp INFIELD gldt015 name="input.c.page1.gldt015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldt015_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt015_desc
            #add-point:ON ACTION controlp INFIELD gldt015_desc name="input.c.page1.gldt015_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldt016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt016
            #add-point:ON ACTION controlp INFIELD gldt016 name="input.c.page1.gldt016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldt016_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt016_desc
            #add-point:ON ACTION controlp INFIELD gldt016_desc name="input.c.page1.gldt016_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldt017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt017
            #add-point:ON ACTION controlp INFIELD gldt017 name="input.c.page1.gldt017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldt017_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt017_desc
            #add-point:ON ACTION controlp INFIELD gldt017_desc name="input.c.page1.gldt017_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldt018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt018
            #add-point:ON ACTION controlp INFIELD gldt018 name="input.c.page1.gldt018"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldt018_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt018_desc
            #add-point:ON ACTION controlp INFIELD gldt018_desc name="input.c.page1.gldt018_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldt019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt019
            #add-point:ON ACTION controlp INFIELD gldt019 name="input.c.page1.gldt019"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldt019_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt019_desc
            #add-point:ON ACTION controlp INFIELD gldt019_desc name="input.c.page1.gldt019_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldt020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt020
            #add-point:ON ACTION controlp INFIELD gldt020 name="input.c.page1.gldt020"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldt020_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt020_desc
            #add-point:ON ACTION controlp INFIELD gldt020_desc name="input.c.page1.gldt020_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldt021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt021
            #add-point:ON ACTION controlp INFIELD gldt021 name="input.c.page1.gldt021"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldt021_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt021_desc
            #add-point:ON ACTION controlp INFIELD gldt021_desc name="input.c.page1.gldt021_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldt036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt036
            #add-point:ON ACTION controlp INFIELD gldt036 name="input.c.page1.gldt036"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldt037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt037
            #add-point:ON ACTION controlp INFIELD gldt037 name="input.c.page1.gldt037"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldt037_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt037_desc
            #add-point:ON ACTION controlp INFIELD gldt037_desc name="input.c.page1.gldt037_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldt038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt038
            #add-point:ON ACTION controlp INFIELD gldt038 name="input.c.page1.gldt038"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldt038_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt038_desc
            #add-point:ON ACTION controlp INFIELD gldt038_desc name="input.c.page1.gldt038_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldt022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt022
            #add-point:ON ACTION controlp INFIELD gldt022 name="input.c.page1.gldt022"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldt022_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt022_desc
            #add-point:ON ACTION controlp INFIELD gldt022_desc name="input.c.page1.gldt022_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldt023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt023
            #add-point:ON ACTION controlp INFIELD gldt023 name="input.c.page1.gldt023"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldt023_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt023_desc
            #add-point:ON ACTION controlp INFIELD gldt023_desc name="input.c.page1.gldt023_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldt024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt024
            #add-point:ON ACTION controlp INFIELD gldt024 name="input.c.page1.gldt024"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldt024_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt024_desc
            #add-point:ON ACTION controlp INFIELD gldt024_desc name="input.c.page1.gldt024_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldt033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt033
            #add-point:ON ACTION controlp INFIELD gldt033 name="input.c.page1.gldt033"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldt010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt010
            #add-point:ON ACTION controlp INFIELD gldt010 name="input.c.page1.gldt010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldt011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt011
            #add-point:ON ACTION controlp INFIELD gldt011 name="input.c.page1.gldt011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_gldt011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldt011
            #add-point:ON ACTION controlp INFIELD l_gldt011 name="input.c.page1.l_gldt011"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_gldt_d[l_ac].* = g_gldt_d_t.*
               CLOSE aglq921_bcl
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
               LET g_errparam.extend = g_gldt_d[l_ac].gldt002 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_gldt_d[l_ac].* = g_gldt_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
         
               #將遮罩欄位還原
               CALL aglq921_gldt_t_mask_restore('restore_mask_o')
         
               UPDATE gldt_t SET (gldtld,gldt001,gldt003,gldt005,gldt006,gldt002,gldt004,gldt008,gldt031, 
                   gldt032,gldt007,gldt014,gldt015,gldt016,gldt017,gldt018,gldt019,gldt020,gldt021,gldt036, 
                   gldt037,gldt038,gldt022,gldt023,gldt024,gldt033,gldt010,gldt011,gldt034,gldt026,gldt027, 
                   gldt035,gldt029,gldt030) = (g_gldt_m.gldtld,g_gldt_m.gldt001,g_gldt_m.gldt003,g_gldt_m.gldt005, 
                   g_gldt_m.gldt006,g_gldt_d[l_ac].gldt002,g_gldt_d[l_ac].gldt004,g_gldt_d[l_ac].gldt008, 
                   g_gldt_d[l_ac].gldt031,g_gldt_d[l_ac].gldt032,g_gldt_d[l_ac].gldt007,g_gldt_d[l_ac].gldt014, 
                   g_gldt_d[l_ac].gldt015,g_gldt_d[l_ac].gldt016,g_gldt_d[l_ac].gldt017,g_gldt_d[l_ac].gldt018, 
                   g_gldt_d[l_ac].gldt019,g_gldt_d[l_ac].gldt020,g_gldt_d[l_ac].gldt021,g_gldt_d[l_ac].gldt036, 
                   g_gldt_d[l_ac].gldt037,g_gldt_d[l_ac].gldt038,g_gldt_d[l_ac].gldt022,g_gldt_d[l_ac].gldt023, 
                   g_gldt_d[l_ac].gldt024,g_gldt_d[l_ac].gldt033,g_gldt_d[l_ac].gldt010,g_gldt_d[l_ac].gldt011, 
                   g_gldt2_d[l_ac].gldt034,g_gldt2_d[l_ac].gldt026,g_gldt2_d[l_ac].gldt027,g_gldt3_d[l_ac].gldt035, 
                   g_gldt3_d[l_ac].gldt029,g_gldt3_d[l_ac].gldt030)
                WHERE gldtent = g_enterprise AND gldtld = g_gldt_m.gldtld 
                 AND gldt001 = g_gldt_m.gldt001 
                 AND gldt003 = g_gldt_m.gldt003 
                 AND gldt005 = g_gldt_m.gldt005 
                 AND gldt006 = g_gldt_m.gldt006 
 
                 AND gldt002 = g_gldt_d_t.gldt002 #項次   
                 AND gldt004 = g_gldt_d_t.gldt004  
                 AND gldt007 = g_gldt_d_t.gldt007  
                 AND gldt008 = g_gldt_d_t.gldt008  
                 AND gldt031 = g_gldt_d_t.gldt031  
                 AND gldt032 = g_gldt_d_t.gldt032  
 
                 
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gldt_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "gldt_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gldt_m.gldtld
               LET gs_keys_bak[1] = g_gldtld_t
               LET gs_keys[2] = g_gldt_m.gldt001
               LET gs_keys_bak[2] = g_gldt001_t
               LET gs_keys[3] = g_gldt_m.gldt003
               LET gs_keys_bak[3] = g_gldt003_t
               LET gs_keys[4] = g_gldt_m.gldt005
               LET gs_keys_bak[4] = g_gldt005_t
               LET gs_keys[5] = g_gldt_m.gldt006
               LET gs_keys_bak[5] = g_gldt006_t
               LET gs_keys[6] = g_gldt_d[g_detail_idx].gldt002
               LET gs_keys_bak[6] = g_gldt_d_t.gldt002
               LET gs_keys[7] = g_gldt_d[g_detail_idx].gldt004
               LET gs_keys_bak[7] = g_gldt_d_t.gldt004
               LET gs_keys[8] = g_gldt_d[g_detail_idx].gldt007
               LET gs_keys_bak[8] = g_gldt_d_t.gldt007
               LET gs_keys[9] = g_gldt_d[g_detail_idx].gldt008
               LET gs_keys_bak[9] = g_gldt_d_t.gldt008
               LET gs_keys[10] = g_gldt_d[g_detail_idx].gldt031
               LET gs_keys_bak[10] = g_gldt_d_t.gldt031
               LET gs_keys[11] = g_gldt_d[g_detail_idx].gldt032
               LET gs_keys_bak[11] = g_gldt_d_t.gldt032
               CALL aglq921_update_b('gldt_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_gldt_m),util.JSON.stringify(g_gldt_d_t)
                     LET g_log2 = util.JSON.stringify(g_gldt_m),util.JSON.stringify(g_gldt_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aglq921_gldt_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_gldt_m.gldtld
               LET ls_keys[ls_keys.getLength()+1] = g_gldt_m.gldt001
               LET ls_keys[ls_keys.getLength()+1] = g_gldt_m.gldt003
               LET ls_keys[ls_keys.getLength()+1] = g_gldt_m.gldt005
               LET ls_keys[ls_keys.getLength()+1] = g_gldt_m.gldt006
 
               LET ls_keys[ls_keys.getLength()+1] = g_gldt_d_t.gldt002
               LET ls_keys[ls_keys.getLength()+1] = g_gldt_d_t.gldt004
               LET ls_keys[ls_keys.getLength()+1] = g_gldt_d_t.gldt007
               LET ls_keys[ls_keys.getLength()+1] = g_gldt_d_t.gldt008
               LET ls_keys[ls_keys.getLength()+1] = g_gldt_d_t.gldt031
               LET ls_keys[ls_keys.getLength()+1] = g_gldt_d_t.gldt032
 
               CALL aglq921_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE aglq921_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_gldt_d[l_ac].* = g_gldt_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE aglq921_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_gldt_d.getLength() = 0 THEN
               NEXT FIELD gldt002
            END IF
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_gldt_d[li_reproduce_target].* = g_gldt_d[li_reproduce].*
               LET g_gldt2_d[li_reproduce_target].* = g_gldt2_d[li_reproduce].*
               LET g_gldt3_d[li_reproduce_target].* = g_gldt3_d[li_reproduce].*
 
               LET g_gldt_d[li_reproduce_target].gldt002 = NULL
               LET g_gldt_d[li_reproduce_target].gldt004 = NULL
               LET g_gldt_d[li_reproduce_target].gldt007 = NULL
               LET g_gldt_d[li_reproduce_target].gldt008 = NULL
               LET g_gldt_d[li_reproduce_target].gldt031 = NULL
               LET g_gldt_d[li_reproduce_target].gldt032 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_gldt_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_gldt_d.getLength()+1
            END IF
            
      END INPUT
 
      INPUT ARRAY g_gldt2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b, WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                   INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                   DELETE ROW = l_allow_delete,
                   APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
                 
         BEFORE INPUT
            
            CALL aglq921_b_fill(g_wc2) #test 
            #如果一直都在單頭則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_detail_idx)
            END IF
            LET g_loc = 'm' 
            LET g_current_page = 2
            #add-point:資料輸入前 name="input.body2.before_input"
            
            #end add-point
 
         BEFORE ROW 
            #add-point:before row name="input.body2.before_row2"
            
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
            CALL aglq921_idx_chk()
            
            CALL s_transaction_begin()
            IF g_rec_b >= l_ac THEN
               LET l_cmd='u'
               CALL aglq921_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body2.before_row.set_entry_b"
               
               #end add-point
               CALL aglq921_set_no_entry_b(l_cmd)
               LET g_gldt2_d_t.* = g_gldt2_d[l_ac].*   #BACKUP  #page1
               LET g_gldt2_d_o.* = g_gldt2_d[l_ac].*   #BACKUP  #page1
            END IF 
            
 
 
 
    
         BEFORE INSERT
            LET g_insert = 'Y' 
            NEXT FIELD gldt002
 
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            INITIALIZE g_gldt2_d_t.* TO NULL
            INITIALIZE g_gldt2_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_gldt2_d[l_ac].* TO NULL
            #公用欄位預設值
              
            #一般欄位預設值
                  LET g_gldt2_d[l_ac].gldt034 = "0"
      LET g_gldt2_d[l_ac].gldt026 = "0"
      LET g_gldt2_d[l_ac].gldt027 = "0"
      LET g_gldt2_d[l_ac].l_gldt027 = "0"
 
            
            #add-point:modify段before備份 name="input.body2.before_insert.before_bak"
            
            #end add-point
            LET g_gldt2_d_t.* = g_gldt2_d[l_ac].*     #新輸入資料
            LET g_gldt2_d_o.* = g_gldt2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aglq921_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body2.before_insert.set_entry_b"
            
            #end add-point
            CALL aglq921_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_gldt_d[li_reproduce_target].* = g_gldt_d[li_reproduce].*
               LET g_gldt2_d[li_reproduce_target].* = g_gldt2_d[li_reproduce].*
               LET g_gldt3_d[li_reproduce_target].* = g_gldt3_d[li_reproduce].*
 
               LET g_gldt2_d[li_reproduce_target].gldt002 = NULL
               LET g_gldt2_d[li_reproduce_target].gldt004 = NULL
               LET g_gldt2_d[li_reproduce_target].gldt007 = NULL
               LET g_gldt2_d[li_reproduce_target].gldt008 = NULL
               LET g_gldt2_d[li_reproduce_target].gldt031 = NULL
               LET g_gldt2_d[li_reproduce_target].gldt032 = NULL
            END IF
            
 
 
 
            #add-point:modify段before insert name="input.body2.before_insert"
            
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
               IF aglq921_before_delete() THEN 
                  
 
 
 
  
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_gldt_m.gldtld
                  LET gs_keys[gs_keys.getLength()+1] = g_gldt_m.gldt001
                  LET gs_keys[gs_keys.getLength()+1] = g_gldt_m.gldt003
                  LET gs_keys[gs_keys.getLength()+1] = g_gldt_m.gldt005
                  LET gs_keys[gs_keys.getLength()+1] = g_gldt_m.gldt006
                  LET gs_keys[gs_keys.getLength()+1] = g_gldt_d_t.gldt002
                  LET gs_keys[gs_keys.getLength()+1] = g_gldt_d_t.gldt004
                  LET gs_keys[gs_keys.getLength()+1] = g_gldt_d_t.gldt007
                  LET gs_keys[gs_keys.getLength()+1] = g_gldt_d_t.gldt008
                  LET gs_keys[gs_keys.getLength()+1] = g_gldt_d_t.gldt031
                  LET gs_keys[gs_keys.getLength()+1] = g_gldt_d_t.gldt032
 
                  #刪除下層單身
                  IF NOT aglq921_key_delete_b(gs_keys,'gldt_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE aglq921_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE aglq921_bcl
               CALL s_transaction_end('Y','0') 
               LET l_count = g_gldt2_d.getLength()
            END IF
            
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body2.after_delete"
               
               #end add-point
                              CALL aglq921_delete_b('gldt_t',gs_keys,"'2'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_gldt2_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_gldt2_d[l_ac].* = g_gldt2_d_t.*
               CLOSE aglq921_bcl
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
               LET g_errparam.extend = g_gldt_d[l_ac].gldt002 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_gldt2_d[l_ac].* = g_gldt2_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               
                
               #add-point:單身修改前 name="modify.body2.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL aglq921_gldt_t_mask_restore('restore_mask_o')
                     
               UPDATE gldt_t SET (gldtld,gldt001,gldt003,gldt005,gldt006,gldt002,gldt004,gldt008,gldt031, 
                   gldt032,gldt007,gldt014,gldt015,gldt016,gldt017,gldt018,gldt019,gldt020,gldt021,gldt036, 
                   gldt037,gldt038,gldt022,gldt023,gldt024,gldt033,gldt010,gldt011,gldt034,gldt026,gldt027, 
                   gldt035,gldt029,gldt030) = (g_gldt_m.gldtld,g_gldt_m.gldt001,g_gldt_m.gldt003,g_gldt_m.gldt005, 
                   g_gldt_m.gldt006,g_gldt_d[l_ac].gldt002,g_gldt_d[l_ac].gldt004,g_gldt_d[l_ac].gldt008, 
                   g_gldt_d[l_ac].gldt031,g_gldt_d[l_ac].gldt032,g_gldt_d[l_ac].gldt007,g_gldt_d[l_ac].gldt014, 
                   g_gldt_d[l_ac].gldt015,g_gldt_d[l_ac].gldt016,g_gldt_d[l_ac].gldt017,g_gldt_d[l_ac].gldt018, 
                   g_gldt_d[l_ac].gldt019,g_gldt_d[l_ac].gldt020,g_gldt_d[l_ac].gldt021,g_gldt_d[l_ac].gldt036, 
                   g_gldt_d[l_ac].gldt037,g_gldt_d[l_ac].gldt038,g_gldt_d[l_ac].gldt022,g_gldt_d[l_ac].gldt023, 
                   g_gldt_d[l_ac].gldt024,g_gldt_d[l_ac].gldt033,g_gldt_d[l_ac].gldt010,g_gldt_d[l_ac].gldt011, 
                   g_gldt2_d[l_ac].gldt034,g_gldt2_d[l_ac].gldt026,g_gldt2_d[l_ac].gldt027,g_gldt3_d[l_ac].gldt035, 
                   g_gldt3_d[l_ac].gldt029,g_gldt3_d[l_ac].gldt030) #自訂欄位頁簽
                WHERE gldtent = g_enterprise AND gldtld = g_gldt_m.gldtld
                 AND gldt001 = g_gldt_m.gldt001
                 AND gldt003 = g_gldt_m.gldt003
                 AND gldt005 = g_gldt_m.gldt005
                 AND gldt006 = g_gldt_m.gldt006
                 AND gldt002 = g_gldt2_d_t.gldt002 #項次 
                 AND gldt004 = g_gldt2_d_t.gldt004
                 AND gldt007 = g_gldt2_d_t.gldt007
                 AND gldt008 = g_gldt2_d_t.gldt008
                 AND gldt031 = g_gldt2_d_t.gldt031
                 AND gldt032 = g_gldt2_d_t.gldt032
               #add-point:單身修改中 name="modify.body2.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gldt_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gldt_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gldt_m.gldtld
               LET gs_keys_bak[1] = g_gldtld_t
               LET gs_keys[2] = g_gldt_m.gldt001
               LET gs_keys_bak[2] = g_gldt001_t
               LET gs_keys[3] = g_gldt_m.gldt003
               LET gs_keys_bak[3] = g_gldt003_t
               LET gs_keys[4] = g_gldt_m.gldt005
               LET gs_keys_bak[4] = g_gldt005_t
               LET gs_keys[5] = g_gldt_m.gldt006
               LET gs_keys_bak[5] = g_gldt006_t
               LET gs_keys[6] = g_gldt2_d[g_detail_idx].gldt002
               LET gs_keys_bak[6] = g_gldt2_d_t.gldt002
               LET gs_keys[7] = g_gldt2_d[g_detail_idx].gldt004
               LET gs_keys_bak[7] = g_gldt2_d_t.gldt004
               LET gs_keys[8] = g_gldt2_d[g_detail_idx].gldt007
               LET gs_keys_bak[8] = g_gldt2_d_t.gldt007
               LET gs_keys[9] = g_gldt2_d[g_detail_idx].gldt008
               LET gs_keys_bak[9] = g_gldt2_d_t.gldt008
               LET gs_keys[10] = g_gldt2_d[g_detail_idx].gldt031
               LET gs_keys_bak[10] = g_gldt2_d_t.gldt031
               LET gs_keys[11] = g_gldt2_d[g_detail_idx].gldt032
               LET gs_keys_bak[11] = g_gldt2_d_t.gldt032
               CALL aglq921_update_b('gldt_t',gs_keys,gs_keys_bak,"'2'")
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_gldt_m),util.JSON.stringify(g_gldt2_d_t)
                     LET g_log2 = util.JSON.stringify(g_gldt_m),util.JSON.stringify(g_gldt2_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aglq921_gldt_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="modify.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt0072_desc
            #add-point:BEFORE FIELD gldt0072_desc name="input.b.page2.gldt0072_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt0072_desc
            
            #add-point:AFTER FIELD gldt0072_desc name="input.a.page2.gldt0072_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldt0072_desc
            #add-point:ON CHANGE gldt0072_desc name="input.g.page2.gldt0072_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldt0142
            #add-point:BEFORE FIELD l_gldt0142 name="input.b.page2.l_gldt0142"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldt0142
            
            #add-point:AFTER FIELD l_gldt0142 name="input.a.page2.l_gldt0142"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldt0142
            #add-point:ON CHANGE l_gldt0142 name="input.g.page2.l_gldt0142"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldt0152
            #add-point:BEFORE FIELD l_gldt0152 name="input.b.page2.l_gldt0152"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldt0152
            
            #add-point:AFTER FIELD l_gldt0152 name="input.a.page2.l_gldt0152"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldt0152
            #add-point:ON CHANGE l_gldt0152 name="input.g.page2.l_gldt0152"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldt0162
            #add-point:BEFORE FIELD l_gldt0162 name="input.b.page2.l_gldt0162"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldt0162
            
            #add-point:AFTER FIELD l_gldt0162 name="input.a.page2.l_gldt0162"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldt0162
            #add-point:ON CHANGE l_gldt0162 name="input.g.page2.l_gldt0162"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldt0172
            #add-point:BEFORE FIELD l_gldt0172 name="input.b.page2.l_gldt0172"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldt0172
            
            #add-point:AFTER FIELD l_gldt0172 name="input.a.page2.l_gldt0172"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldt0172
            #add-point:ON CHANGE l_gldt0172 name="input.g.page2.l_gldt0172"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldt0182
            #add-point:BEFORE FIELD l_gldt0182 name="input.b.page2.l_gldt0182"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldt0182
            
            #add-point:AFTER FIELD l_gldt0182 name="input.a.page2.l_gldt0182"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldt0182
            #add-point:ON CHANGE l_gldt0182 name="input.g.page2.l_gldt0182"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldt0192
            #add-point:BEFORE FIELD l_gldt0192 name="input.b.page2.l_gldt0192"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldt0192
            
            #add-point:AFTER FIELD l_gldt0192 name="input.a.page2.l_gldt0192"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldt0192
            #add-point:ON CHANGE l_gldt0192 name="input.g.page2.l_gldt0192"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldt0202
            #add-point:BEFORE FIELD l_gldt0202 name="input.b.page2.l_gldt0202"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldt0202
            
            #add-point:AFTER FIELD l_gldt0202 name="input.a.page2.l_gldt0202"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldt0202
            #add-point:ON CHANGE l_gldt0202 name="input.g.page2.l_gldt0202"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldt0212
            #add-point:BEFORE FIELD l_gldt0212 name="input.b.page2.l_gldt0212"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldt0212
            
            #add-point:AFTER FIELD l_gldt0212 name="input.a.page2.l_gldt0212"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldt0212
            #add-point:ON CHANGE l_gldt0212 name="input.g.page2.l_gldt0212"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldt0362
            #add-point:BEFORE FIELD l_gldt0362 name="input.b.page2.l_gldt0362"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldt0362
            
            #add-point:AFTER FIELD l_gldt0362 name="input.a.page2.l_gldt0362"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldt0362
            #add-point:ON CHANGE l_gldt0362 name="input.g.page2.l_gldt0362"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldt0372
            #add-point:BEFORE FIELD l_gldt0372 name="input.b.page2.l_gldt0372"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldt0372
            
            #add-point:AFTER FIELD l_gldt0372 name="input.a.page2.l_gldt0372"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldt0372
            #add-point:ON CHANGE l_gldt0372 name="input.g.page2.l_gldt0372"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldt0382
            #add-point:BEFORE FIELD l_gldt0382 name="input.b.page2.l_gldt0382"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldt0382
            
            #add-point:AFTER FIELD l_gldt0382 name="input.a.page2.l_gldt0382"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldt0382
            #add-point:ON CHANGE l_gldt0382 name="input.g.page2.l_gldt0382"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldt0222
            #add-point:BEFORE FIELD l_gldt0222 name="input.b.page2.l_gldt0222"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldt0222
            
            #add-point:AFTER FIELD l_gldt0222 name="input.a.page2.l_gldt0222"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldt0222
            #add-point:ON CHANGE l_gldt0222 name="input.g.page2.l_gldt0222"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldt0232
            #add-point:BEFORE FIELD l_gldt0232 name="input.b.page2.l_gldt0232"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldt0232
            
            #add-point:AFTER FIELD l_gldt0232 name="input.a.page2.l_gldt0232"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldt0232
            #add-point:ON CHANGE l_gldt0232 name="input.g.page2.l_gldt0232"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldt0242
            #add-point:BEFORE FIELD l_gldt0242 name="input.b.page2.l_gldt0242"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldt0242
            
            #add-point:AFTER FIELD l_gldt0242 name="input.a.page2.l_gldt0242"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldt0242
            #add-point:ON CHANGE l_gldt0242 name="input.g.page2.l_gldt0242"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt034
            #add-point:BEFORE FIELD gldt034 name="input.b.page2.gldt034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt034
            
            #add-point:AFTER FIELD gldt034 name="input.a.page2.gldt034"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldt034
            #add-point:ON CHANGE gldt034 name="input.g.page2.gldt034"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt026
            #add-point:BEFORE FIELD gldt026 name="input.b.page2.gldt026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt026
            
            #add-point:AFTER FIELD gldt026 name="input.a.page2.gldt026"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldt026
            #add-point:ON CHANGE gldt026 name="input.g.page2.gldt026"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt027
            #add-point:BEFORE FIELD gldt027 name="input.b.page2.gldt027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt027
            
            #add-point:AFTER FIELD gldt027 name="input.a.page2.gldt027"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldt027
            #add-point:ON CHANGE gldt027 name="input.g.page2.gldt027"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldt027
            #add-point:BEFORE FIELD l_gldt027 name="input.b.page2.l_gldt027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldt027
            
            #add-point:AFTER FIELD l_gldt027 name="input.a.page2.l_gldt027"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldt027
            #add-point:ON CHANGE l_gldt027 name="input.g.page2.l_gldt027"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.gldt0072_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt0072_desc
            #add-point:ON ACTION controlp INFIELD gldt0072_desc name="input.c.page2.gldt0072_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_gldt0142
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldt0142
            #add-point:ON ACTION controlp INFIELD l_gldt0142 name="input.c.page2.l_gldt0142"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_gldt0152
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldt0152
            #add-point:ON ACTION controlp INFIELD l_gldt0152 name="input.c.page2.l_gldt0152"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_gldt0162
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldt0162
            #add-point:ON ACTION controlp INFIELD l_gldt0162 name="input.c.page2.l_gldt0162"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_gldt0172
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldt0172
            #add-point:ON ACTION controlp INFIELD l_gldt0172 name="input.c.page2.l_gldt0172"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_gldt0182
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldt0182
            #add-point:ON ACTION controlp INFIELD l_gldt0182 name="input.c.page2.l_gldt0182"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_gldt0192
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldt0192
            #add-point:ON ACTION controlp INFIELD l_gldt0192 name="input.c.page2.l_gldt0192"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_gldt0202
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldt0202
            #add-point:ON ACTION controlp INFIELD l_gldt0202 name="input.c.page2.l_gldt0202"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_gldt0212
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldt0212
            #add-point:ON ACTION controlp INFIELD l_gldt0212 name="input.c.page2.l_gldt0212"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_gldt0362
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldt0362
            #add-point:ON ACTION controlp INFIELD l_gldt0362 name="input.c.page2.l_gldt0362"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_gldt0372
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldt0372
            #add-point:ON ACTION controlp INFIELD l_gldt0372 name="input.c.page2.l_gldt0372"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_gldt0382
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldt0382
            #add-point:ON ACTION controlp INFIELD l_gldt0382 name="input.c.page2.l_gldt0382"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_gldt0222
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldt0222
            #add-point:ON ACTION controlp INFIELD l_gldt0222 name="input.c.page2.l_gldt0222"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_gldt0232
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldt0232
            #add-point:ON ACTION controlp INFIELD l_gldt0232 name="input.c.page2.l_gldt0232"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_gldt0242
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldt0242
            #add-point:ON ACTION controlp INFIELD l_gldt0242 name="input.c.page2.l_gldt0242"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.gldt034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt034
            #add-point:ON ACTION controlp INFIELD gldt034 name="input.c.page2.gldt034"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.gldt026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt026
            #add-point:ON ACTION controlp INFIELD gldt026 name="input.c.page2.gldt026"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.gldt027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt027
            #add-point:ON ACTION controlp INFIELD gldt027 name="input.c.page2.gldt027"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_gldt027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldt027
            #add-point:ON ACTION controlp INFIELD l_gldt027 name="input.c.page2.l_gldt027"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:input段after row name="input.body2.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_gldt2_d[l_ac].* = g_gldt2_d_t.*
               END IF
               CLOSE aglq921_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               EXIT DIALOG 
            END IF
 
            CLOSE aglq921_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #add-point:input段after input  name="input.body2.after_input"
            
            #end add-point    
 
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_gldt_d[li_reproduce_target].* = g_gldt_d[li_reproduce].*
               LET g_gldt2_d[li_reproduce_target].* = g_gldt2_d[li_reproduce].*
               LET g_gldt3_d[li_reproduce_target].* = g_gldt3_d[li_reproduce].*
 
               LET g_gldt2_d[li_reproduce_target].gldt002 = NULL
               LET g_gldt2_d[li_reproduce_target].gldt004 = NULL
               LET g_gldt2_d[li_reproduce_target].gldt007 = NULL
               LET g_gldt2_d[li_reproduce_target].gldt008 = NULL
               LET g_gldt2_d[li_reproduce_target].gldt031 = NULL
               LET g_gldt2_d[li_reproduce_target].gldt032 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_gldt2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_gldt2_d.getLength()+1
            END IF
      END INPUT
      INPUT ARRAY g_gldt3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b, WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                   INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                   DELETE ROW = l_allow_delete,
                   APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
                 
         BEFORE INPUT
            
            CALL aglq921_b_fill(g_wc2) #test 
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
            CALL aglq921_idx_chk()
            
            CALL s_transaction_begin()
            IF g_rec_b >= l_ac THEN
               LET l_cmd='u'
               CALL aglq921_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body3.before_row.set_entry_b"
               
               #end add-point
               CALL aglq921_set_no_entry_b(l_cmd)
               LET g_gldt3_d_t.* = g_gldt3_d[l_ac].*   #BACKUP  #page1
               LET g_gldt3_d_o.* = g_gldt3_d[l_ac].*   #BACKUP  #page1
            END IF 
            
 
 
 
    
         BEFORE INSERT
            LET g_insert = 'Y' 
            NEXT FIELD gldt002
 
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            INITIALIZE g_gldt3_d_t.* TO NULL
            INITIALIZE g_gldt3_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_gldt3_d[l_ac].* TO NULL
            #公用欄位預設值
              
            #一般欄位預設值
                  LET g_gldt3_d[l_ac].gldt035 = "0"
      LET g_gldt3_d[l_ac].gldt029 = "0"
      LET g_gldt3_d[l_ac].gldt030 = "0"
      LET g_gldt3_d[l_ac].l_gldt030 = "0"
 
            
            #add-point:modify段before備份 name="input.body3.before_insert.before_bak"
            
            #end add-point
            LET g_gldt3_d_t.* = g_gldt3_d[l_ac].*     #新輸入資料
            LET g_gldt3_d_o.* = g_gldt3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aglq921_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body3.before_insert.set_entry_b"
            
            #end add-point
            CALL aglq921_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_gldt_d[li_reproduce_target].* = g_gldt_d[li_reproduce].*
               LET g_gldt2_d[li_reproduce_target].* = g_gldt2_d[li_reproduce].*
               LET g_gldt3_d[li_reproduce_target].* = g_gldt3_d[li_reproduce].*
 
               LET g_gldt3_d[li_reproduce_target].gldt002 = NULL
               LET g_gldt3_d[li_reproduce_target].gldt004 = NULL
               LET g_gldt3_d[li_reproduce_target].gldt007 = NULL
               LET g_gldt3_d[li_reproduce_target].gldt008 = NULL
               LET g_gldt3_d[li_reproduce_target].gldt031 = NULL
               LET g_gldt3_d[li_reproduce_target].gldt032 = NULL
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
               IF aglq921_before_delete() THEN 
                  
 
 
 
  
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_gldt_m.gldtld
                  LET gs_keys[gs_keys.getLength()+1] = g_gldt_m.gldt001
                  LET gs_keys[gs_keys.getLength()+1] = g_gldt_m.gldt003
                  LET gs_keys[gs_keys.getLength()+1] = g_gldt_m.gldt005
                  LET gs_keys[gs_keys.getLength()+1] = g_gldt_m.gldt006
                  LET gs_keys[gs_keys.getLength()+1] = g_gldt_d_t.gldt002
                  LET gs_keys[gs_keys.getLength()+1] = g_gldt_d_t.gldt004
                  LET gs_keys[gs_keys.getLength()+1] = g_gldt_d_t.gldt007
                  LET gs_keys[gs_keys.getLength()+1] = g_gldt_d_t.gldt008
                  LET gs_keys[gs_keys.getLength()+1] = g_gldt_d_t.gldt031
                  LET gs_keys[gs_keys.getLength()+1] = g_gldt_d_t.gldt032
 
                  #刪除下層單身
                  IF NOT aglq921_key_delete_b(gs_keys,'gldt_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE aglq921_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE aglq921_bcl
               CALL s_transaction_end('Y','0') 
               LET l_count = g_gldt3_d.getLength()
            END IF
            
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body3.after_delete"
               
               #end add-point
                              CALL aglq921_delete_b('gldt_t',gs_keys,"'3'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_gldt3_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_gldt3_d[l_ac].* = g_gldt3_d_t.*
               CLOSE aglq921_bcl
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
               LET g_errparam.extend = g_gldt_d[l_ac].gldt002 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_gldt3_d[l_ac].* = g_gldt3_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               
                
               #add-point:單身修改前 name="modify.body3.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL aglq921_gldt_t_mask_restore('restore_mask_o')
                     
               UPDATE gldt_t SET (gldtld,gldt001,gldt003,gldt005,gldt006,gldt002,gldt004,gldt008,gldt031, 
                   gldt032,gldt007,gldt014,gldt015,gldt016,gldt017,gldt018,gldt019,gldt020,gldt021,gldt036, 
                   gldt037,gldt038,gldt022,gldt023,gldt024,gldt033,gldt010,gldt011,gldt034,gldt026,gldt027, 
                   gldt035,gldt029,gldt030) = (g_gldt_m.gldtld,g_gldt_m.gldt001,g_gldt_m.gldt003,g_gldt_m.gldt005, 
                   g_gldt_m.gldt006,g_gldt_d[l_ac].gldt002,g_gldt_d[l_ac].gldt004,g_gldt_d[l_ac].gldt008, 
                   g_gldt_d[l_ac].gldt031,g_gldt_d[l_ac].gldt032,g_gldt_d[l_ac].gldt007,g_gldt_d[l_ac].gldt014, 
                   g_gldt_d[l_ac].gldt015,g_gldt_d[l_ac].gldt016,g_gldt_d[l_ac].gldt017,g_gldt_d[l_ac].gldt018, 
                   g_gldt_d[l_ac].gldt019,g_gldt_d[l_ac].gldt020,g_gldt_d[l_ac].gldt021,g_gldt_d[l_ac].gldt036, 
                   g_gldt_d[l_ac].gldt037,g_gldt_d[l_ac].gldt038,g_gldt_d[l_ac].gldt022,g_gldt_d[l_ac].gldt023, 
                   g_gldt_d[l_ac].gldt024,g_gldt_d[l_ac].gldt033,g_gldt_d[l_ac].gldt010,g_gldt_d[l_ac].gldt011, 
                   g_gldt2_d[l_ac].gldt034,g_gldt2_d[l_ac].gldt026,g_gldt2_d[l_ac].gldt027,g_gldt3_d[l_ac].gldt035, 
                   g_gldt3_d[l_ac].gldt029,g_gldt3_d[l_ac].gldt030) #自訂欄位頁簽
                WHERE gldtent = g_enterprise AND gldtld = g_gldt_m.gldtld
                 AND gldt001 = g_gldt_m.gldt001
                 AND gldt003 = g_gldt_m.gldt003
                 AND gldt005 = g_gldt_m.gldt005
                 AND gldt006 = g_gldt_m.gldt006
                 AND gldt002 = g_gldt3_d_t.gldt002 #項次 
                 AND gldt004 = g_gldt3_d_t.gldt004
                 AND gldt007 = g_gldt3_d_t.gldt007
                 AND gldt008 = g_gldt3_d_t.gldt008
                 AND gldt031 = g_gldt3_d_t.gldt031
                 AND gldt032 = g_gldt3_d_t.gldt032
               #add-point:單身修改中 name="modify.body3.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gldt_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gldt_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gldt_m.gldtld
               LET gs_keys_bak[1] = g_gldtld_t
               LET gs_keys[2] = g_gldt_m.gldt001
               LET gs_keys_bak[2] = g_gldt001_t
               LET gs_keys[3] = g_gldt_m.gldt003
               LET gs_keys_bak[3] = g_gldt003_t
               LET gs_keys[4] = g_gldt_m.gldt005
               LET gs_keys_bak[4] = g_gldt005_t
               LET gs_keys[5] = g_gldt_m.gldt006
               LET gs_keys_bak[5] = g_gldt006_t
               LET gs_keys[6] = g_gldt3_d[g_detail_idx].gldt002
               LET gs_keys_bak[6] = g_gldt3_d_t.gldt002
               LET gs_keys[7] = g_gldt3_d[g_detail_idx].gldt004
               LET gs_keys_bak[7] = g_gldt3_d_t.gldt004
               LET gs_keys[8] = g_gldt3_d[g_detail_idx].gldt007
               LET gs_keys_bak[8] = g_gldt3_d_t.gldt007
               LET gs_keys[9] = g_gldt3_d[g_detail_idx].gldt008
               LET gs_keys_bak[9] = g_gldt3_d_t.gldt008
               LET gs_keys[10] = g_gldt3_d[g_detail_idx].gldt031
               LET gs_keys_bak[10] = g_gldt3_d_t.gldt031
               LET gs_keys[11] = g_gldt3_d[g_detail_idx].gldt032
               LET gs_keys_bak[11] = g_gldt3_d_t.gldt032
               CALL aglq921_update_b('gldt_t',gs_keys,gs_keys_bak,"'3'")
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_gldt_m),util.JSON.stringify(g_gldt3_d_t)
                     LET g_log2 = util.JSON.stringify(g_gldt_m),util.JSON.stringify(g_gldt3_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aglq921_gldt_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="modify.body3.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt0073_desc
            #add-point:BEFORE FIELD gldt0073_desc name="input.b.page3.gldt0073_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt0073_desc
            
            #add-point:AFTER FIELD gldt0073_desc name="input.a.page3.gldt0073_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldt0073_desc
            #add-point:ON CHANGE gldt0073_desc name="input.g.page3.gldt0073_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldt0143
            #add-point:BEFORE FIELD l_gldt0143 name="input.b.page3.l_gldt0143"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldt0143
            
            #add-point:AFTER FIELD l_gldt0143 name="input.a.page3.l_gldt0143"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldt0143
            #add-point:ON CHANGE l_gldt0143 name="input.g.page3.l_gldt0143"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldt0153
            #add-point:BEFORE FIELD l_gldt0153 name="input.b.page3.l_gldt0153"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldt0153
            
            #add-point:AFTER FIELD l_gldt0153 name="input.a.page3.l_gldt0153"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldt0153
            #add-point:ON CHANGE l_gldt0153 name="input.g.page3.l_gldt0153"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldt0163
            #add-point:BEFORE FIELD l_gldt0163 name="input.b.page3.l_gldt0163"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldt0163
            
            #add-point:AFTER FIELD l_gldt0163 name="input.a.page3.l_gldt0163"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldt0163
            #add-point:ON CHANGE l_gldt0163 name="input.g.page3.l_gldt0163"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldt0173
            #add-point:BEFORE FIELD l_gldt0173 name="input.b.page3.l_gldt0173"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldt0173
            
            #add-point:AFTER FIELD l_gldt0173 name="input.a.page3.l_gldt0173"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldt0173
            #add-point:ON CHANGE l_gldt0173 name="input.g.page3.l_gldt0173"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldt0183
            #add-point:BEFORE FIELD l_gldt0183 name="input.b.page3.l_gldt0183"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldt0183
            
            #add-point:AFTER FIELD l_gldt0183 name="input.a.page3.l_gldt0183"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldt0183
            #add-point:ON CHANGE l_gldt0183 name="input.g.page3.l_gldt0183"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldt0193
            #add-point:BEFORE FIELD l_gldt0193 name="input.b.page3.l_gldt0193"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldt0193
            
            #add-point:AFTER FIELD l_gldt0193 name="input.a.page3.l_gldt0193"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldt0193
            #add-point:ON CHANGE l_gldt0193 name="input.g.page3.l_gldt0193"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldt0203
            #add-point:BEFORE FIELD l_gldt0203 name="input.b.page3.l_gldt0203"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldt0203
            
            #add-point:AFTER FIELD l_gldt0203 name="input.a.page3.l_gldt0203"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldt0203
            #add-point:ON CHANGE l_gldt0203 name="input.g.page3.l_gldt0203"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldt0213
            #add-point:BEFORE FIELD l_gldt0213 name="input.b.page3.l_gldt0213"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldt0213
            
            #add-point:AFTER FIELD l_gldt0213 name="input.a.page3.l_gldt0213"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldt0213
            #add-point:ON CHANGE l_gldt0213 name="input.g.page3.l_gldt0213"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldt0363
            #add-point:BEFORE FIELD l_gldt0363 name="input.b.page3.l_gldt0363"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldt0363
            
            #add-point:AFTER FIELD l_gldt0363 name="input.a.page3.l_gldt0363"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldt0363
            #add-point:ON CHANGE l_gldt0363 name="input.g.page3.l_gldt0363"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldt0373
            #add-point:BEFORE FIELD l_gldt0373 name="input.b.page3.l_gldt0373"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldt0373
            
            #add-point:AFTER FIELD l_gldt0373 name="input.a.page3.l_gldt0373"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldt0373
            #add-point:ON CHANGE l_gldt0373 name="input.g.page3.l_gldt0373"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldt0383
            #add-point:BEFORE FIELD l_gldt0383 name="input.b.page3.l_gldt0383"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldt0383
            
            #add-point:AFTER FIELD l_gldt0383 name="input.a.page3.l_gldt0383"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldt0383
            #add-point:ON CHANGE l_gldt0383 name="input.g.page3.l_gldt0383"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldt0223
            #add-point:BEFORE FIELD l_gldt0223 name="input.b.page3.l_gldt0223"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldt0223
            
            #add-point:AFTER FIELD l_gldt0223 name="input.a.page3.l_gldt0223"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldt0223
            #add-point:ON CHANGE l_gldt0223 name="input.g.page3.l_gldt0223"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldt0233
            #add-point:BEFORE FIELD l_gldt0233 name="input.b.page3.l_gldt0233"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldt0233
            
            #add-point:AFTER FIELD l_gldt0233 name="input.a.page3.l_gldt0233"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldt0233
            #add-point:ON CHANGE l_gldt0233 name="input.g.page3.l_gldt0233"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldt0243
            #add-point:BEFORE FIELD l_gldt0243 name="input.b.page3.l_gldt0243"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldt0243
            
            #add-point:AFTER FIELD l_gldt0243 name="input.a.page3.l_gldt0243"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldt0243
            #add-point:ON CHANGE l_gldt0243 name="input.g.page3.l_gldt0243"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt035
            #add-point:BEFORE FIELD gldt035 name="input.b.page3.gldt035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt035
            
            #add-point:AFTER FIELD gldt035 name="input.a.page3.gldt035"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldt035
            #add-point:ON CHANGE gldt035 name="input.g.page3.gldt035"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt029
            #add-point:BEFORE FIELD gldt029 name="input.b.page3.gldt029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt029
            
            #add-point:AFTER FIELD gldt029 name="input.a.page3.gldt029"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldt029
            #add-point:ON CHANGE gldt029 name="input.g.page3.gldt029"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldt030
            #add-point:BEFORE FIELD gldt030 name="input.b.page3.gldt030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldt030
            
            #add-point:AFTER FIELD gldt030 name="input.a.page3.gldt030"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldt030
            #add-point:ON CHANGE gldt030 name="input.g.page3.gldt030"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldt030
            #add-point:BEFORE FIELD l_gldt030 name="input.b.page3.l_gldt030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldt030
            
            #add-point:AFTER FIELD l_gldt030 name="input.a.page3.l_gldt030"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldt030
            #add-point:ON CHANGE l_gldt030 name="input.g.page3.l_gldt030"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.gldt0073_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt0073_desc
            #add-point:ON ACTION controlp INFIELD gldt0073_desc name="input.c.page3.gldt0073_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_gldt0143
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldt0143
            #add-point:ON ACTION controlp INFIELD l_gldt0143 name="input.c.page3.l_gldt0143"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_gldt0153
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldt0153
            #add-point:ON ACTION controlp INFIELD l_gldt0153 name="input.c.page3.l_gldt0153"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_gldt0163
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldt0163
            #add-point:ON ACTION controlp INFIELD l_gldt0163 name="input.c.page3.l_gldt0163"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_gldt0173
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldt0173
            #add-point:ON ACTION controlp INFIELD l_gldt0173 name="input.c.page3.l_gldt0173"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_gldt0183
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldt0183
            #add-point:ON ACTION controlp INFIELD l_gldt0183 name="input.c.page3.l_gldt0183"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_gldt0193
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldt0193
            #add-point:ON ACTION controlp INFIELD l_gldt0193 name="input.c.page3.l_gldt0193"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_gldt0203
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldt0203
            #add-point:ON ACTION controlp INFIELD l_gldt0203 name="input.c.page3.l_gldt0203"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_gldt0213
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldt0213
            #add-point:ON ACTION controlp INFIELD l_gldt0213 name="input.c.page3.l_gldt0213"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_gldt0363
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldt0363
            #add-point:ON ACTION controlp INFIELD l_gldt0363 name="input.c.page3.l_gldt0363"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_gldt0373
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldt0373
            #add-point:ON ACTION controlp INFIELD l_gldt0373 name="input.c.page3.l_gldt0373"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_gldt0383
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldt0383
            #add-point:ON ACTION controlp INFIELD l_gldt0383 name="input.c.page3.l_gldt0383"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_gldt0223
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldt0223
            #add-point:ON ACTION controlp INFIELD l_gldt0223 name="input.c.page3.l_gldt0223"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_gldt0233
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldt0233
            #add-point:ON ACTION controlp INFIELD l_gldt0233 name="input.c.page3.l_gldt0233"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_gldt0243
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldt0243
            #add-point:ON ACTION controlp INFIELD l_gldt0243 name="input.c.page3.l_gldt0243"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.gldt035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt035
            #add-point:ON ACTION controlp INFIELD gldt035 name="input.c.page3.gldt035"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.gldt029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt029
            #add-point:ON ACTION controlp INFIELD gldt029 name="input.c.page3.gldt029"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.gldt030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldt030
            #add-point:ON ACTION controlp INFIELD gldt030 name="input.c.page3.gldt030"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_gldt030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldt030
            #add-point:ON ACTION controlp INFIELD l_gldt030 name="input.c.page3.l_gldt030"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:input段after row name="input.body3.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_gldt3_d[l_ac].* = g_gldt3_d_t.*
               END IF
               CLOSE aglq921_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               EXIT DIALOG 
            END IF
 
            CLOSE aglq921_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #add-point:input段after input  name="input.body3.after_input"
            
            #end add-point    
 
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_gldt_d[li_reproduce_target].* = g_gldt_d[li_reproduce].*
               LET g_gldt2_d[li_reproduce_target].* = g_gldt2_d[li_reproduce].*
               LET g_gldt3_d[li_reproduce_target].* = g_gldt3_d[li_reproduce].*
 
               LET g_gldt3_d[li_reproduce_target].gldt002 = NULL
               LET g_gldt3_d[li_reproduce_target].gldt004 = NULL
               LET g_gldt3_d[li_reproduce_target].gldt007 = NULL
               LET g_gldt3_d[li_reproduce_target].gldt008 = NULL
               LET g_gldt3_d[li_reproduce_target].gldt031 = NULL
               LET g_gldt3_d[li_reproduce_target].gldt032 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_gldt3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_gldt3_d.getLength()+1
            END IF
      END INPUT
 
      
 
      
 
      
 
    
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
            NEXT FIELD gldtld
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD gldt002
               WHEN "s_detail2"
                  NEXT FIELD gldt002_2
               WHEN "s_detail3"
                  NEXT FIELD gldt002_3
 
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
 
{<section id="aglq921.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aglq921_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL aglq921_b_fill(g_wc2) #第一階單身填充
      CALL aglq921_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aglq921_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_gldt_m.gldtld,g_gldt_m.gldtld_desc,g_gldt_m.gldt001,g_gldt_m.gldt001_desc,g_gldt_m.gldt003, 
       g_gldt_m.gldt003_desc,g_gldt_m.gldt005,g_gldt_m.gldt006,g_gldt_m.gldt009,g_gldt_m.gldt025,g_gldt_m.gldt028, 
       g_gldt_m.l_chk14,g_gldt_m.l_chk15,g_gldt_m.l_chk16,g_gldt_m.l_chk17,g_gldt_m.l_chk18,g_gldt_m.l_chk19, 
       g_gldt_m.l_chk20,g_gldt_m.l_chk21,g_gldt_m.l_chk36,g_gldt_m.l_chk37,g_gldt_m.l_chk38,g_gldt_m.l_chk22, 
       g_gldt_m.l_chk23,g_gldt_m.l_chk24
 
   CALL aglq921_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
   DISPLAY BY NAME g_input.l_chk14,g_input.l_chk15,g_input.l_chk16,
                   g_input.l_chk17,g_input.l_chk18,g_input.l_chk19,
                   g_input.l_chk20,g_input.l_chk21,g_input.l_chk36,
                   g_input.l_chk37,g_input.l_chk38,g_input.l_chk22,
                   g_input.l_chk23,g_input.l_chk24
   CALL aglq921_show_visible()   #單身欄位關閉
   CALL aglq921_ld_visible()     #依帳別開關
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="aglq921.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION aglq921_ref_show()
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
   LET g_gldt_m.gldtld_desc  = s_desc_get_ld_desc(g_gldt_m.gldtld)
   LET g_gldt_m.gldt001_desc = s_desc_glda001_desc(g_gldt_m.gldt001)
   LET g_gldt_m.gldt003_desc  = s_desc_glda001_desc(g_gldt_m.gldt003)
   DISPLAY BY NAME g_gldt_m.gldtld_desc,g_gldt_m.gldt001_desc,g_gldt_m.gldt003_desc
   #end add-point
 
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_gldt_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_gldt2_d.getLength()
      #add-point:ref_show段d2_reference name="ref_show.body2.reference"
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_gldt3_d.getLength()
      #add-point:ref_show段d3_reference name="ref_show.body3.reference"
      
      #end add-point
   END FOR
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="aglq921.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aglq921_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE gldt_t.gldtld 
   DEFINE l_oldno     LIKE gldt_t.gldtld 
   DEFINE l_newno02     LIKE gldt_t.gldt001 
   DEFINE l_oldno02     LIKE gldt_t.gldt001 
   DEFINE l_newno03     LIKE gldt_t.gldt003 
   DEFINE l_oldno03     LIKE gldt_t.gldt003 
   DEFINE l_newno04     LIKE gldt_t.gldt005 
   DEFINE l_oldno04     LIKE gldt_t.gldt005 
   DEFINE l_newno05     LIKE gldt_t.gldt006 
   DEFINE l_oldno05     LIKE gldt_t.gldt006 
 
   DEFINE l_master    RECORD LIKE gldt_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE gldt_t.* #此變數樣板目前無使用
 
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
 
   IF g_gldt_m.gldtld IS NULL
      OR g_gldt_m.gldt001 IS NULL
      OR g_gldt_m.gldt003 IS NULL
      OR g_gldt_m.gldt005 IS NULL
      OR g_gldt_m.gldt006 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_gldtld_t = g_gldt_m.gldtld
   LET g_gldt001_t = g_gldt_m.gldt001
   LET g_gldt003_t = g_gldt_m.gldt003
   LET g_gldt005_t = g_gldt_m.gldt005
   LET g_gldt006_t = g_gldt_m.gldt006
 
   
   LET g_gldt_m.gldtld = ""
   LET g_gldt_m.gldt001 = ""
   LET g_gldt_m.gldt003 = ""
   LET g_gldt_m.gldt005 = ""
   LET g_gldt_m.gldt006 = ""
 
   LET g_master_insert = FALSE
   CALL aglq921_set_entry('a')
   CALL aglq921_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #清空key欄位的desc
      LET g_gldt_m.gldtld_desc = ''
   DISPLAY BY NAME g_gldt_m.gldtld_desc
   LET g_gldt_m.gldt001_desc = ''
   DISPLAY BY NAME g_gldt_m.gldt001_desc
   LET g_gldt_m.gldt003_desc = ''
   DISPLAY BY NAME g_gldt_m.gldt003_desc
 
   
   CALL aglq921_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_gldt_m.* TO NULL
      INITIALIZE g_gldt_d TO NULL
      INITIALIZE g_gldt2_d TO NULL
      INITIALIZE g_gldt3_d TO NULL
 
      CALL aglq921_show()
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
   CALL aglq921_set_act_visible()
   CALL aglq921_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_gldtld_t = g_gldt_m.gldtld
   LET g_gldt001_t = g_gldt_m.gldt001
   LET g_gldt003_t = g_gldt_m.gldt003
   LET g_gldt005_t = g_gldt_m.gldt005
   LET g_gldt006_t = g_gldt_m.gldt006
 
   
   #組合新增資料的條件
   LET g_add_browse = " gldtent = " ||g_enterprise|| " AND",
                      " gldtld = '", g_gldt_m.gldtld, "' "
                      ," AND gldt001 = '", g_gldt_m.gldt001, "' "
                      ," AND gldt003 = '", g_gldt_m.gldt003, "' "
                      ," AND gldt005 = '", g_gldt_m.gldt005, "' "
                      ," AND gldt006 = '", g_gldt_m.gldt006, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aglq921_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL aglq921_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL aglq921_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="aglq921.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION aglq921_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE gldt_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aglq921_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM gldt_t
    WHERE gldtent = g_enterprise AND gldtld = g_gldtld_t
    AND gldt001 = g_gldt001_t
    AND gldt003 = g_gldt003_t
    AND gldt005 = g_gldt005_t
    AND gldt006 = g_gldt006_t
 
       INTO TEMP aglq921_detail
   
   #將key修正為調整後   
   UPDATE aglq921_detail 
      #更新key欄位
      SET gldtld = g_gldt_m.gldtld
          , gldt001 = g_gldt_m.gldt001
          , gldt003 = g_gldt_m.gldt003
          , gldt005 = g_gldt_m.gldt005
          , gldt006 = g_gldt_m.gldt006
 
      #更新共用欄位
      
                                       
   #將資料塞回原table   
   INSERT INTO gldt_t SELECT * FROM aglq921_detail
   
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
   DROP TABLE aglq921_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_gldtld_t = g_gldt_m.gldtld
   LET g_gldt001_t = g_gldt_m.gldt001
   LET g_gldt003_t = g_gldt_m.gldt003
   LET g_gldt005_t = g_gldt_m.gldt005
   LET g_gldt006_t = g_gldt_m.gldt006
 
   
   DROP TABLE aglq921_detail
   
END FUNCTION
 
{</section>}
 
{<section id="aglq921.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aglq921_delete()
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
   
   IF g_gldt_m.gldtld IS NULL
   OR g_gldt_m.gldt001 IS NULL
   OR g_gldt_m.gldt003 IS NULL
   OR g_gldt_m.gldt005 IS NULL
   OR g_gldt_m.gldt006 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN aglq921_cl USING g_enterprise,g_gldt_m.gldtld,g_gldt_m.gldt001,g_gldt_m.gldt003,g_gldt_m.gldt005,g_gldt_m.gldt006
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aglq921_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE aglq921_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aglq921_master_referesh USING g_gldt_m.gldtld,g_gldt_m.gldt001,g_gldt_m.gldt003,g_gldt_m.gldt005, 
       g_gldt_m.gldt006 INTO g_gldt_m.gldtld,g_gldt_m.gldt001,g_gldt_m.gldt003,g_gldt_m.gldt005,g_gldt_m.gldt006, 
       g_gldt_m.gldt009,g_gldt_m.gldt025,g_gldt_m.gldt028
   
   #遮罩相關處理
   LET g_gldt_m_mask_o.* =  g_gldt_m.*
   CALL aglq921_gldt_t_mask()
   LET g_gldt_m_mask_n.* =  g_gldt_m.*
   
   CALL aglq921_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aglq921_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM gldt_t WHERE gldtent = g_enterprise AND gldtld = g_gldt_m.gldtld
                                                               AND gldt001 = g_gldt_m.gldt001
                                                               AND gldt003 = g_gldt_m.gldt003
                                                               AND gldt005 = g_gldt_m.gldt005
                                                               AND gldt006 = g_gldt_m.gldt006
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gldt_t:",SQLERRMESSAGE 
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
      #   CLOSE aglq921_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_gldt_d.clear() 
      CALL g_gldt2_d.clear()       
      CALL g_gldt3_d.clear()       
 
     
      CALL aglq921_ui_browser_refresh()  
      #CALL aglq921_ui_headershow()  
      #CALL aglq921_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL aglq921_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL aglq921_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE aglq921_cl
 
   #功能已完成,通報訊息中心
   CALL aglq921_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="aglq921.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aglq921_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #先清空單身變數內容
   CALL g_gldt_d.clear()
   CALL g_gldt2_d.clear()
   CALL g_gldt3_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT gldt002,gldt004,gldt008,gldt031,gldt032,gldt007,gldt014,gldt015,gldt016, 
       gldt017,gldt018,gldt019,gldt020,gldt021,gldt036,gldt037,gldt038,gldt022,gldt023,gldt024,gldt033, 
       gldt010,gldt011,gldt002,gldt004,gldt008,gldt031,gldt032,gldt007,gldt034,gldt026,gldt027,gldt002, 
       gldt004,gldt008,gldt031,gldt032,gldt007,gldt035,gldt029,gldt030 FROM gldt_t",   
               "",
               
               
               " WHERE gldtent= ? AND gldtld=? AND gldt001=? AND gldt003=? AND gldt005=? AND gldt006=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("gldt_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF aglq921_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY gldt_t.gldt002,gldt_t.gldt004,gldt_t.gldt007,gldt_t.gldt008,gldt_t.gldt031,gldt_t.gldt032"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
         
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aglq921_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR aglq921_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_gldt_m.gldtld,g_gldt_m.gldt001,g_gldt_m.gldt003,g_gldt_m.gldt005,g_gldt_m.gldt006   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_gldt_m.gldtld,g_gldt_m.gldt001,g_gldt_m.gldt003,g_gldt_m.gldt005, 
          g_gldt_m.gldt006 INTO g_gldt_d[l_ac].gldt002,g_gldt_d[l_ac].gldt004,g_gldt_d[l_ac].gldt008, 
          g_gldt_d[l_ac].gldt031,g_gldt_d[l_ac].gldt032,g_gldt_d[l_ac].gldt007,g_gldt_d[l_ac].gldt014, 
          g_gldt_d[l_ac].gldt015,g_gldt_d[l_ac].gldt016,g_gldt_d[l_ac].gldt017,g_gldt_d[l_ac].gldt018, 
          g_gldt_d[l_ac].gldt019,g_gldt_d[l_ac].gldt020,g_gldt_d[l_ac].gldt021,g_gldt_d[l_ac].gldt036, 
          g_gldt_d[l_ac].gldt037,g_gldt_d[l_ac].gldt038,g_gldt_d[l_ac].gldt022,g_gldt_d[l_ac].gldt023, 
          g_gldt_d[l_ac].gldt024,g_gldt_d[l_ac].gldt033,g_gldt_d[l_ac].gldt010,g_gldt_d[l_ac].gldt011, 
          g_gldt2_d[l_ac].gldt002,g_gldt2_d[l_ac].gldt004,g_gldt2_d[l_ac].gldt008,g_gldt2_d[l_ac].gldt031, 
          g_gldt2_d[l_ac].gldt032,g_gldt2_d[l_ac].gldt007,g_gldt2_d[l_ac].gldt034,g_gldt2_d[l_ac].gldt026, 
          g_gldt2_d[l_ac].gldt027,g_gldt3_d[l_ac].gldt002,g_gldt3_d[l_ac].gldt004,g_gldt3_d[l_ac].gldt008, 
          g_gldt3_d[l_ac].gldt031,g_gldt3_d[l_ac].gldt032,g_gldt3_d[l_ac].gldt007,g_gldt3_d[l_ac].gldt035, 
          g_gldt3_d[l_ac].gldt029,g_gldt3_d[l_ac].gldt030   #(ver:49)
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充 name="b_fill.fill"
         LET g_gldt_d[l_ac].gldt014_desc =  s_desc_show1(g_gldt_d[l_ac].gldt014,s_merge_source_desc('1',g_gldt_d[l_ac].gldt014))
         LET g_gldt2_d[l_ac].l_gldt0142 = g_gldt_d[l_ac].gldt014_desc
         LET g_gldt3_d[l_ac].l_gldt0143 = g_gldt_d[l_ac].gldt014_desc
         LET g_gldt_d[l_ac].gldt015_desc =  s_desc_show1(g_gldt_d[l_ac].gldt015,s_merge_source_desc('2',g_gldt_d[l_ac].gldt015))
         LET g_gldt2_d[l_ac].l_gldt0152 = g_gldt_d[l_ac].gldt015_desc
         LET g_gldt3_d[l_ac].l_gldt0153 = g_gldt_d[l_ac].gldt015_desc
         LET g_gldt_d[l_ac].gldt016_desc =  s_desc_show1(g_gldt_d[l_ac].gldt016,s_merge_source_desc('3',g_gldt_d[l_ac].gldt016))
         LET g_gldt2_d[l_ac].l_gldt0162 = g_gldt_d[l_ac].gldt016_desc
         LET g_gldt3_d[l_ac].l_gldt0163 = g_gldt_d[l_ac].gldt016_desc
         LET g_gldt_d[l_ac].gldt017_desc =  s_desc_show1(g_gldt_d[l_ac].gldt017,s_merge_source_desc('4',g_gldt_d[l_ac].gldt017))
         LET g_gldt2_d[l_ac].l_gldt0172 = g_gldt_d[l_ac].gldt017_desc
         LET g_gldt3_d[l_ac].l_gldt0173 = g_gldt_d[l_ac].gldt017_desc
         LET g_gldt_d[l_ac].gldt018_desc =  s_desc_show1(g_gldt_d[l_ac].gldt018,s_merge_source_desc('5',g_gldt_d[l_ac].gldt018))
         LET g_gldt2_d[l_ac].l_gldt0182 = g_gldt_d[l_ac].gldt018_desc
         LET g_gldt3_d[l_ac].l_gldt0183 = g_gldt_d[l_ac].gldt018_desc
         LET g_gldt_d[l_ac].gldt019_desc =  s_desc_show1(g_gldt_d[l_ac].gldt019,s_merge_source_desc('6',g_gldt_d[l_ac].gldt019))
         LET g_gldt2_d[l_ac].l_gldt0192 = g_gldt_d[l_ac].gldt019_desc
         LET g_gldt3_d[l_ac].l_gldt0193 = g_gldt_d[l_ac].gldt019_desc
         LET g_gldt_d[l_ac].gldt020_desc =  s_desc_show1(g_gldt_d[l_ac].gldt020,s_merge_source_desc('7',g_gldt_d[l_ac].gldt020))
         LET g_gldt2_d[l_ac].l_gldt0202 = g_gldt_d[l_ac].gldt020_desc
         LET g_gldt3_d[l_ac].l_gldt0203 = g_gldt_d[l_ac].gldt020_desc         
         LET g_gldt_d[l_ac].gldt021_desc =  s_desc_show1(g_gldt_d[l_ac].gldt021,s_merge_source_desc('8',g_gldt_d[l_ac].gldt021))
         LET g_gldt2_d[l_ac].l_gldt0212 = g_gldt_d[l_ac].gldt021_desc
         LET g_gldt3_d[l_ac].l_gldt0213 = g_gldt_d[l_ac].gldt021_desc         
         LET g_gldt_d[l_ac].gldt037_desc =  s_desc_show1(g_gldt_d[l_ac].gldt037,s_merge_source_desc('10',g_gldt_d[l_ac].gldt037))
         LET g_gldt2_d[l_ac].l_gldt0372 = g_gldt_d[l_ac].gldt037_desc
         LET g_gldt3_d[l_ac].l_gldt0373 = g_gldt_d[l_ac].gldt037_desc
         LET g_gldt_d[l_ac].gldt038_desc =  s_desc_show1(g_gldt_d[l_ac].gldt038,s_merge_source_desc('11',g_gldt_d[l_ac].gldt038))
         LET g_gldt2_d[l_ac].l_gldt0382 = g_gldt_d[l_ac].gldt038_desc
         LET g_gldt3_d[l_ac].l_gldt0383 = g_gldt_d[l_ac].gldt038_desc
         LET g_gldt_d[l_ac].gldt022_desc =  s_desc_show1(g_gldt_d[l_ac].gldt022,s_merge_source_desc('12',g_gldt_d[l_ac].gldt022))
         LET g_gldt2_d[l_ac].l_gldt0222 = g_gldt_d[l_ac].gldt022_desc
         LET g_gldt3_d[l_ac].l_gldt0223 = g_gldt_d[l_ac].gldt022_desc
         LET g_gldt_d[l_ac].gldt023_desc =  s_desc_show1(g_gldt_d[l_ac].gldt023,s_merge_source_desc('13',g_gldt_d[l_ac].gldt023))
         LET g_gldt2_d[l_ac].l_gldt0232 = g_gldt_d[l_ac].gldt023_desc
         LET g_gldt3_d[l_ac].l_gldt0233 = g_gldt_d[l_ac].gldt023_desc
         LET g_gldt_d[l_ac].gldt024_desc =  s_desc_show1(g_gldt_d[l_ac].gldt024,s_desc_get_wbs_desc(g_gldt_d[l_ac].gldt023,g_gldt_d[l_ac].gldt024))
         LET g_gldt2_d[l_ac].l_gldt0242 = g_gldt_d[l_ac].gldt024_desc
         LET g_gldt3_d[l_ac].l_gldt0243 = g_gldt_d[l_ac].gldt024_desc
         
         LET g_gldt_d[l_ac].l_gldt011 = g_gldt_d[l_ac].gldt010 - g_gldt_d[l_ac].gldt011
         LET g_gldt2_d[l_ac].l_gldt027 = g_gldt2_d[l_ac].gldt026 - g_gldt2_d[l_ac].gldt027
         LET g_gldt3_d[l_ac].l_gldt030 = g_gldt3_d[l_ac].gldt029 - g_gldt3_d[l_ac].gldt030
         LET g_gldt_d[l_ac].gldt007_desc = s_desc_get_account_desc(g_gldt_m.gldtld,g_gldt_d[l_ac].gldt007)
         LET g_gldt2_d[l_ac].gldt0072_desc =  g_gldt_d[l_ac].gldt007_desc
         LET g_gldt3_d[l_ac].gldt0073_desc =  g_gldt_d[l_ac].gldt007_desc
         #end add-point
      
         #帶出公用欄位reference值
         
         
         
         
 
        
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
 
            CALL g_gldt_d.deleteElement(g_gldt_d.getLength())
      CALL g_gldt2_d.deleteElement(g_gldt2_d.getLength())
      CALL g_gldt3_d.deleteElement(g_gldt3_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
   
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_gldt_d.getLength()
      LET g_gldt_d_mask_o[l_ac].* =  g_gldt_d[l_ac].*
      CALL aglq921_gldt_t_mask()
      LET g_gldt_d_mask_n[l_ac].* =  g_gldt_d[l_ac].*
   END FOR
   
   LET g_gldt2_d_mask_o.* =  g_gldt2_d.*
   FOR l_ac = 1 TO g_gldt2_d.getLength()
      LET g_gldt2_d_mask_o[l_ac].* =  g_gldt2_d[l_ac].*
      CALL aglq921_gldt_t_mask()
      LET g_gldt2_d_mask_n[l_ac].* =  g_gldt2_d[l_ac].*
   END FOR
   LET g_gldt3_d_mask_o.* =  g_gldt3_d.*
   FOR l_ac = 1 TO g_gldt3_d.getLength()
      LET g_gldt3_d_mask_o[l_ac].* =  g_gldt3_d[l_ac].*
      CALL aglq921_gldt_t_mask()
      LET g_gldt3_d_mask_n[l_ac].* =  g_gldt3_d[l_ac].*
   END FOR
 
 
   FREE aglq921_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="aglq921.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION aglq921_idx_chk()
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
      IF g_detail_idx > g_gldt_d.getLength() THEN
         LET g_detail_idx = g_gldt_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_gldt_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_gldt_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_gldt2_d.getLength() THEN
         LET g_detail_idx = g_gldt2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_gldt2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_gldt2_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_gldt3_d.getLength() THEN
         LET g_detail_idx = g_gldt3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_gldt3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_gldt3_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aglq921.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aglq921_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_gldt_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="aglq921.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION aglq921_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   
   #end add-point
   
   DELETE FROM gldt_t
    WHERE gldtent = g_enterprise AND gldtld = g_gldt_m.gldtld AND
                              gldt001 = g_gldt_m.gldt001 AND
                              gldt003 = g_gldt_m.gldt003 AND
                              gldt005 = g_gldt_m.gldt005 AND
                              gldt006 = g_gldt_m.gldt006 AND
 
          gldt002 = g_gldt_d_t.gldt002
      AND gldt004 = g_gldt_d_t.gldt004
      AND gldt007 = g_gldt_d_t.gldt007
      AND gldt008 = g_gldt_d_t.gldt008
      AND gldt031 = g_gldt_d_t.gldt031
      AND gldt032 = g_gldt_d_t.gldt032
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "gldt_t:",SQLERRMESSAGE 
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
 
{<section id="aglq921.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aglq921_delete_b(ps_table,ps_keys_bak,ps_page)
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
 
{<section id="aglq921.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aglq921_insert_b(ps_table,ps_keys,ps_page)
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
 
{<section id="aglq921.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aglq921_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
 
{<section id="aglq921.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION aglq921_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_gldt_d[l_ac].gldt002 = g_gldt_d_t.gldt002 
      AND g_gldt_d[l_ac].gldt004 = g_gldt_d_t.gldt004 
      AND g_gldt_d[l_ac].gldt007 = g_gldt_d_t.gldt007 
      AND g_gldt_d[l_ac].gldt008 = g_gldt_d_t.gldt008 
      AND g_gldt_d[l_ac].gldt031 = g_gldt_d_t.gldt031 
      AND g_gldt_d[l_ac].gldt032 = g_gldt_d_t.gldt032 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="aglq921.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION aglq921_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="aglq921.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aglq921_lock_b(ps_table,ps_page)
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
   #CALL aglq921_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aglq921.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aglq921_unlock_b(ps_table,ps_page)
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
 
{<section id="aglq921.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aglq921_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("gldtld,gldt001,gldt003,gldt005,gldt006",TRUE)
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
 
{<section id="aglq921.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aglq921_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("gldtld,gldt001,gldt003,gldt005,gldt006",FALSE)
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
 
{<section id="aglq921.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aglq921_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aglq921.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aglq921_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="aglq921.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aglq921_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aglq921.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aglq921_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aglq921.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION aglq921_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aglq921.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION aglq921_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aglq921.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aglq921_default_search()
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
      LET ls_wc = ls_wc, " gldtld = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " gldt001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " gldt003 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " gldt005 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET ls_wc = ls_wc, " gldt006 = '", g_argv[05], "' AND "
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
 
{<section id="aglq921.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION aglq921_fill_chk(ps_idx)
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
 
{<section id="aglq921.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION aglq921_modify_detail_chk(ps_record)
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
         LET ls_return = "gldt002"
      WHEN "s_detail2"
         LET ls_return = "gldt002_2"
      WHEN "s_detail3"
         LET ls_return = "gldt002_3"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="aglq921.mask_functions" >}
&include "erp/agl/aglq921_mask.4gl"
 
{</section>}
 
{<section id="aglq921.state_change" >}
    
 
{</section>}
 
{<section id="aglq921.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aglq921_set_pk_array()
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
   LET g_pk_array[1].values = g_gldt_m.gldtld
   LET g_pk_array[1].column = 'gldtld'
   LET g_pk_array[2].values = g_gldt_m.gldt001
   LET g_pk_array[2].column = 'gldt001'
   LET g_pk_array[3].values = g_gldt_m.gldt003
   LET g_pk_array[3].column = 'gldt003'
   LET g_pk_array[4].values = g_gldt_m.gldt005
   LET g_pk_array[4].column = 'gldt005'
   LET g_pk_array[5].values = g_gldt_m.gldt006
   LET g_pk_array[5].column = 'gldt006'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aglq921.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aglq921_msgcentre_notify(lc_state)
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
   CALL aglq921_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_gldt_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aglq921.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 給預設值
# Memo...........:
# Usage..........: CALL aglq921_qbe_clear()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/11/18 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq921_qbe_clear()
   CLEAR FORM
   LET g_input.l_chk14 = 'Y'
   LET g_input.l_chk15 = 'N'
   LET g_input.l_chk16 = 'N'
   LET g_input.l_chk17 = 'N'
   LET g_input.l_chk18 = 'N'
   LET g_input.l_chk19 = 'N'
   LET g_input.l_chk20 = 'N'
   LET g_input.l_chk21 = 'N'
   LET g_input.l_chk36 = 'N'   
   LET g_input.l_chk37 = 'N'
   LET g_input.l_chk38 = 'N'
   LET g_input.l_chk22 = 'N'
   LET g_input.l_chk23 = 'N'
   LET g_input.l_chk24 = 'N'
   DISPLAY BY NAME g_input.l_chk14,g_input.l_chk15,g_input.l_chk16,
                   g_input.l_chk17,g_input.l_chk18,g_input.l_chk19,
                   g_input.l_chk20,g_input.l_chk21,g_input.l_chk36,
                   g_input.l_chk37,g_input.l_chk38,g_input.l_chk22,
                   g_input.l_chk23,g_input.l_chk24
END FUNCTION

################################################################################
# Descriptions...: 欄位開關控制
# Memo...........:
# Usage..........: CALL aglq921_construct_visible(p_type)
# Input parameter: p_type   IN/OUT
# Return code....: 無
# Date & Author..: 2015/11/18 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq921_construct_visible(p_type)
   DEFINE p_type   LIKE type_t.chr10      # IN/OUT

   #先全開
   CALL cl_set_comp_visible('gldt014,gldt014_desc,gldt015,gldt015_desc,gldt016,gldt016_desc',TRUE)
   CALL cl_set_comp_visible('gldt017,gldt017_desc,gldt018,gldt018_desc,gldt019,gldt019_desc',TRUE)
   CALL cl_set_comp_visible('gldt020,gldt020_desc,gldt021,gldt021_desc,gldt036',TRUE)
   CALL cl_set_comp_visible('gldt037,gldt037_desc,gldt038,gldt038_desc,gldt022,gldt022_desc',TRUE)   
   CALL cl_set_comp_visible('gldt023,gldt023_desc,gldt024,gldt024_desc',TRUE)
   CASE
      WHEN p_type = 'IN'
         CALL cl_set_comp_visible('gldt014_desc,gldt015_desc,gldt016_desc',FALSE)
         CALL cl_set_comp_visible('gldt017_desc,gldt018_desc,gldt019_desc',FALSE)
         CALL cl_set_comp_visible('gldt020_desc,gldt021_desc',FALSE)
         CALL cl_set_comp_visible('gldt037_desc,gldt038_desc,gldt022_desc',FALSE)   
         CALL cl_set_comp_visible('gldt023_desc,gldt024_desc',FALSE)   
      WHEN p_type = 'OUT'
         CALL cl_set_comp_visible('gldt014,gldt015,gldt016',FALSE)
         CALL cl_set_comp_visible('gldt017,gldt018,gldt019',FALSE)
         CALL cl_set_comp_visible('gldt020,gldt021',FALSE)
         CALL cl_set_comp_visible('gldt037,gldt038,gldt022',FALSE)   
         CALL cl_set_comp_visible('gldt023,gldt024',FALSE)      
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 控制功能/報告幣欄位,頁簽顯示
# Memo...........:
# Usage..........: CALL aglq921_ld_visible()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/11/18 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq921_ld_visible()
   DEFINE l_glaa RECORD 
                 glaa015 LIKE glaa_t.glaa015,
                 glaa019 LIKE glaa_t.glaa019                 
                 END RECORD
                 
   IF cl_null(g_gldt_m.gldtld)THEN RETURN END IF
   INITIALIZE l_glaa.* TO NULL        
   SELECT glaa015,glaa019 INTO l_glaa.*
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_gldt_m.gldtld
      
   CALL cl_set_comp_visible('gldt025,page_3',TRUE)
   CALL cl_set_comp_visible('gldt028,page_4',TRUE)
   IF l_glaa.glaa015 = 'N' THEN
      CALL cl_set_comp_visible('gldt025,page_3',FALSE)
   END IF
   
   IF l_glaa.glaa019 = 'N' THEN
      CALL cl_set_comp_visible('gldt028,page_4',FALSE)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 物件顯示控制
# Memo...........:
# Usage..........: CALL aglq921_show_visible()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/11/18 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq921_show_visible()
   CALL cl_set_comp_visible('gldt014_desc,l_gldt0142,l_gldt0143',TRUE)
   CALL cl_set_comp_visible('gldt015_desc,l_gldt0152,l_gldt0153',TRUE)
   CALL cl_set_comp_visible('gldt016_desc,l_gldt0162,l_gldt0163',TRUE)
   CALL cl_set_comp_visible('gldt017_desc,l_gldt0172,l_gldt0173',TRUE)
   CALL cl_set_comp_visible('gldt018_desc,l_gldt0182,l_gldt0183',TRUE)
   CALL cl_set_comp_visible('gldt019_desc,l_gldt0192,l_gldt0193',TRUE)
   CALL cl_set_comp_visible('gldt020_desc,l_gldt0202,l_gldt0203',TRUE)
   CALL cl_set_comp_visible('gldt021_desc,l_gldt0212,l_gldt0213',TRUE)
   CALL cl_set_comp_visible('gldt036,l_gldt0362,l_gldt0363',TRUE)
   CALL cl_set_comp_visible('gldt037_desc,l_gldt0372,l_gldt0373',TRUE)
   CALL cl_set_comp_visible('gldt038_desc,l_gldt0382,l_gldt0383',TRUE)
   CALL cl_set_comp_visible('gldt022_desc,l_gldt0222,l_gldt0223',TRUE)
   CALL cl_set_comp_visible('gldt023_desc,l_gldt0232,l_gldt0233',TRUE)
   CALL cl_set_comp_visible('gldt024_desc,l_gldt0242,l_gldt0243',TRUE)
   
   IF g_input.l_chk14='N' THEN
      CALL cl_set_comp_visible('gldt014_desc,l_gldt0142,l_gldt0143',FALSE)
   END IF
   IF g_input.l_chk15='N' THEN
      CALL cl_set_comp_visible('gldt015_desc,l_gldt0152,l_gldt0153',FALSE)
   END IF
   IF g_input.l_chk16='N' THEN
      CALL cl_set_comp_visible('gldt016_desc,l_gldt0162,l_gldt0163',FALSE)
   END IF
   IF g_input.l_chk17='N' THEN
      CALL cl_set_comp_visible('gldt017_desc,l_gldt0172,l_gldt0173',FALSE)
   END IF
   IF g_input.l_chk18='N' THEN
      CALL cl_set_comp_visible('gldt018_desc,l_gldt0182,l_gldt0183',FALSE)
   END IF
   IF g_input.l_chk19='N' THEN
      CALL cl_set_comp_visible('gldt019_desc,l_gldt0192,l_gldt0193',FALSE)
   END IF
   IF g_input.l_chk20='N' THEN
      CALL cl_set_comp_visible('gldt020_desc,l_gldt0202,l_gldt0203',FALSE)
   END IF
   IF g_input.l_chk21='N' THEN
      CALL cl_set_comp_visible('gldt021_desc,l_gldt0212,l_gldt0213',FALSE)
   END IF
   IF g_input.l_chk36='N' THEN
      CALL cl_set_comp_visible('gldt036,l_gldt0362,l_gldt0363',FALSE)
   END IF
   IF g_input.l_chk37='N' THEN
      CALL cl_set_comp_visible('gldt037_desc,l_gldt0372,l_gldt0373',FALSE)
   END IF
   IF g_input.l_chk38='N' THEN
      CALL cl_set_comp_visible('gldt038_desc,l_gldt0382,l_gldt0383',FALSE)
   END IF
   IF g_input.l_chk22='N' THEN
      CALL cl_set_comp_visible('gldt022_desc,l_gldt0222,l_gldt0223',FALSE)
   END IF
   IF g_input.l_chk23='N' THEN
      CALL cl_set_comp_visible('gldt023_desc,l_gldt0232,l_gldt0233',FALSE)
   END IF
   IF g_input.l_chk24='N' THEN
      CALL cl_set_comp_visible('gldt024_desc,l_gldt0242,l_gldt0243',FALSE)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aglq921_filter2()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/11/18 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq921_filter2()
  
  IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF 
   LET INT_FLAG = 0
 
   LET g_wc_filter_t = g_wc_filter.trim()
   LET g_wc_t = g_wc
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter_t, '')
   LET l_ac = 1
   LET g_gldt_d[l_ac].gldt007 = ''
   DISPLAY ARRAY g_gldt_d TO s_detail1.*
      BEFORE DISPLAY
         EXIT DISPLAY
   END DISPLAY
   CALL aglq921_construct_visible('IN')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON gldt002,gldt004,gldt008,gldt031,gldt032,gldt007,gldt014,gldt015,gldt016, 
          gldt017,gldt018,gldt019,gldt020,gldt021,gldt036,gldt037,gldt038,gldt022,gldt023,gldt024,gldt033, 
          gldt010,gldt011,gldt034,gldt026,gldt027,gldt035,gldt029,gldt030
           FROM s_detail1[1].gldt002,s_detail1[1].gldt004,s_detail1[1].gldt008,s_detail1[1].gldt031, 
               s_detail1[1].gldt032,s_detail1[1].gldt007,s_detail1[1].gldt014,s_detail1[1].gldt015,s_detail1[1].gldt016, 
               s_detail1[1].gldt017,s_detail1[1].gldt018,s_detail1[1].gldt019,s_detail1[1].gldt020,s_detail1[1].gldt021, 
               s_detail1[1].gldt036,s_detail1[1].gldt037,s_detail1[1].gldt038,s_detail1[1].gldt022,s_detail1[1].gldt023, 
               s_detail1[1].gldt024,s_detail1[1].gldt033,s_detail1[1].gldt010,s_detail1[1].gldt011,s_detail2[1].gldt034, 
               s_detail2[1].gldt026,s_detail2[1].gldt027,s_detail3[1].gldt035,s_detail3[1].gldt029,s_detail3[1].gldt030
         BEFORE CONSTRUCT

         ON ACTION controlp INFIELD gldt007
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " glac003 <>'1' AND glac006 = '1'"
            CALL aglt310_04()
            DISPLAY g_qryparam.return1 TO gldt007  #顯示到畫面上
            NEXT FIELD gldt007

         ON ACTION controlp INFIELD gldt014
            #營運據點
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()    #161021-00037#3 mark
            CALL q_ooef001_01()  #161021-00037#3 add
            DISPLAY g_qryparam.return1 TO gldt014
            NEXT FIELD gldt014

         ON ACTION controlp INFIELD gldt015
            #部門
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "ooegstus='Y'"
            CALL q_ooeg001_4()
            DISPLAY g_qryparam.return1 TO gldt015
            NEXT FIELD gldt015
			
         ON ACTION controlp INFIELD gldt016
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "ooegstus='Y' AND ooeg003 IN ('1','2','3')"
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gldt016      #顯示到畫面上
            NEXT FIELD gldt016
			
         ON ACTION controlp INFIELD gldt017
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_287()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO gldt017      #顯示到畫面上
            NEXT FIELD gldt017
			
         ON ACTION controlp INFIELD gldt018
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_25()      #160913-00017#3  add
            #CALL q_pmaa001()        #160913-00017#3  mark               #呼叫開窗
            DISPLAY g_qryparam.return1 TO gldt018
            NEXT FIELD gldt018
			
         ON ACTION controlp INFIELD gldt019
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_pmaa001_25()      #160913-00017#3  add
            #CALL q_pmaa001()        #160913-00017#3  mark               #呼叫開窗
            DISPLAY g_qryparam.return1 TO gldt019
            NEXT FIELD gldt019
			
         ON ACTION controlp INFIELD gldt020
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_oocq002_281()
            DISPLAY g_qryparam.return1 TO gldt020
            NEXT FIELD gldt020
			
         ON ACTION controlp INFIELD gldt021
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gldt021      #顯示到畫面上
            NEXT FIELD gldt021
			
         ON ACTION controlp INFIELD gldt037
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            LET g_qryparam.where = " oojdstus='Y' "
            CALL q_oojd001_2()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO gldt037    #顯示到畫面上
            NEXT FIELD gldt037
			
         ON ACTION controlp INFIELD gldt038
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_oocq002_2002()                            #呼叫開窗
            DISPLAY g_qryparam.return1 TO gldt038      #顯示到畫面上
            NEXT FIELD gldt038
			
         ON ACTION controlp INFIELD gldt022
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_ooag001_8()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gldt022     #顯示到畫面上
            NEXT FIELD gldt022
			
         ON ACTION controlp INFIELD gldt023
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_pjba001()                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO gldt023     #顯示到畫面上
            NEXT FIELD gldt023
			
         ON ACTION controlp INFIELD gldt024  
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            LET g_qryparam.where = "pjbb012='1' "
            CALL q_pjbb002()                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO gldt024     #顯示到畫面上
            NEXT FIELD gldt024
      END CONSTRUCT
 
      BEFORE DIALOG
      
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
   CALL aglq921_construct_visible('OUT')
END FUNCTION

################################################################################
# Descriptions...: 建立臨時表
# Memo...........: #160517-00002#5
# Usage..........: CALL aglq921_create_tmp()
# Date & Author..: 160603 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq921_create_tmp()
   #建立臨時表     
   DROP TABLE aglq921_x01_tmp;
   CREATE TEMP TABLE aglq921_x01_tmp(
      gldtent         SMALLINT, 
      l_gldtld_desc   VARCHAR(80), 
      l_gldt001_desc  VARCHAR(80), 
      l_gldt003_desc  VARCHAR(80), 
      gldt005         SMALLINT, 
      gldt006         SMALLINT, 
      gldt009         VARCHAR(10), 
      gldt025         VARCHAR(10), 
      gldt028         VARCHAR(10), 
      gldt007         VARCHAR(24), 
      l_gldt007_desc  VARCHAR(100), 
      l_gldt014_desc  VARCHAR(100), 
      l_gldt015_desc  VARCHAR(100), 
      l_gldt016_desc  VARCHAR(100), 
      l_gldt017_desc  VARCHAR(100), 
      l_gldt018_desc  VARCHAR(100), 
      l_gldt019_desc  VARCHAR(100), 
      l_gldt020_desc  VARCHAR(100), 
      l_gldt021_desc  VARCHAR(100), 
      l_gldt036_desc  VARCHAR(100),  
      l_gldt037_desc  VARCHAR(100), 
      l_gldt038_desc  VARCHAR(100), 
      l_gldt022_desc  VARCHAR(100), 
      l_gldt023_desc  VARCHAR(100), 
      l_gldt024_desc  VARCHAR(100), 
      gldt033         DECIMAL(20,10), 
      gldt010         DECIMAL(20,6), 
      gldt011         DECIMAL(20,6), 
      l_gldt011       DECIMAL(20,6),
      gldt034         DECIMAL(20,10), 
      gldt026         DECIMAL(20,6), 
      gldt027         DECIMAL(20,6), 
      l_gldt027       DECIMAL(20,6),
      gldt035         DECIMAL(20,10), 
      gldt029         DECIMAL(20,6), 
      gldt030         DECIMAL(20,6), 
      l_gldt030       DECIMAL(20,6)
      )
END FUNCTION

################################################################################
# Descriptions...: 報表列印
# Memo...........: #160517-00002#5
# Usage..........: CALL aglq921_ins_x01_tmp()
# Date & Author..: 160603 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq921_ins_x01_tmp()
DEFINE l_i            LIKE type_t.num5
DEFINE l_gldtld_desc  LIKE type_t.chr80
DEFINE l_gldt001_desc LIKE type_t.chr80
DEFINE l_gldt003_desc LIKE type_t.chr80
DEFINE l_gldt036_desc LIKE type_t.chr80
DEFINE l_gldt036      LIKE type_t.chr80

   LET l_gldtld_desc = g_gldt_m.gldtld,':',g_gldt_m.gldtld_desc
   LET l_gldt001_desc = g_gldt_m.gldt001,':',g_gldt_m.gldt001_desc
   LET l_gldt003_desc = g_gldt_m.gldt003,':',g_gldt_m.gldt003_desc

   DELETE FROM aglq921_x01_tmp

   LET l_i = 1
   FOR l_i = 1 TO g_gldt_d.getLength()
      LET l_gldt036_desc = ''
      LET l_gldt036 = ''      
      LET l_gldt036_desc = g_gldt_d[l_i].gldt036,":",s_desc_gzcbl004_desc('6013',g_gldt_d[l_i].gldt036)   
      LET l_gldt036 = s_desc_gzcbl004_desc('6013',g_gldt_d[l_i].gldt036)
      IF cl_null(l_gldt036) THEN LET l_gldt036_desc = g_gldt_d[l_i].gldt036 END IF
      INSERT INTO aglq921_x01_tmp
      VALUES(g_enterprise,l_gldtld_desc,l_gldt001_desc,l_gldt003_desc,
             g_gldt_m.gldt005,g_gldt_m.gldt006,g_gldt_m.gldt009,g_gldt_m.gldt025,
             g_gldt_m.gldt028,g_gldt_d[l_i].gldt007,g_gldt_d[l_i].gldt007_desc,
             g_gldt_d[l_i].gldt014_desc,g_gldt_d[l_i].gldt015_desc,g_gldt_d[l_i].gldt016_desc,
             g_gldt_d[l_i].gldt017_desc,g_gldt_d[l_i].gldt018_desc,g_gldt_d[l_i].gldt019_desc,
             g_gldt_d[l_i].gldt020_desc,g_gldt_d[l_i].gldt021_desc,l_gldt036_desc,
             g_gldt_d[l_i].gldt037_desc,g_gldt_d[l_i].gldt038_desc,g_gldt_d[l_i].gldt022_desc,
             g_gldt_d[l_i].gldt023_desc,g_gldt_d[l_i].gldt024_desc,g_gldt_d[l_i].gldt033,
             g_gldt_d[l_i].gldt010,g_gldt_d[l_i].gldt011,g_gldt_d[l_i].l_gldt011,
             g_gldt2_d[l_i].gldt034,g_gldt2_d[l_i].gldt026,g_gldt2_d[l_i].gldt027,
             g_gldt2_d[l_i].l_gldt027,g_gldt3_d[l_i].gldt035,g_gldt3_d[l_i].gldt029,
             g_gldt3_d[l_i].gldt030,g_gldt3_d[l_i].l_gldt030
             )
   END FOR
   CALL aglq921_xg_visible()
      
END FUNCTION

################################################################################
# Descriptions...: 傳進XG報表隱藏欄位設置
# Memo...........: #160517-00002#5
# Usage..........: CALL aglq921_xg_visible()
# Date & Author..: 160603 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq921_xg_visible()
DEFINE l_glaa015  LIKE glaa_t.glaa015
DEFINE l_glaa019  LIKE glaa_t.glaa019

   LET g_xg_visible = NULL
  
   LET l_glaa015 = ''
   LET l_glaa019 = ''
   SELECT glaa015,glaa019 INTO l_glaa015,l_glaa019 
     FROM glaa_t
    WHERE glaaent = g_enterprise AND glaald = g_gldt_m.gldtld
   
   IF l_glaa015 = 'N' THEN #功能幣啟用否
      LET g_xg_visible = "gldt034|gldt026|gldt027|l_gldt027"
   END IF
   
   IF l_glaa019 = 'N' THEN #報告幣啟用否
      IF NOT cl_null(g_xg_visible)THEN       
         LET g_xg_visible = g_xg_visible CLIPPED ,"|gldt035|gldt029|gldt030|l_gldt030"
      ELSE
         LET g_xg_visible = "gldt035|gldt029|gldt030|l_gldt030"
      END IF
   END IF
   
   #核算項
   IF g_input.l_chk14 ='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"l_gldt014_desc"
   END IF
   
   IF g_input.l_chk15 ='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"l_gldt015_desc"
   END IF
   
   IF g_input.l_chk16 ='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"l_gldt016_desc"
   END IF
   
   IF g_input.l_chk17='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"l_gldt017_desc"
   END IF
   
   IF g_input.l_chk18 ='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"l_gldt018_desc"
   END IF
   
   IF g_input.l_chk19 ='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"l_gldt019_desc"
   END IF
   
   IF g_input.l_chk20 ='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"l_gldt020_desc"
   END IF
   
   IF g_input.l_chk21 ='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"l_gldt021_desc"
   END IF
   #經營方式
   IF g_input.l_chk36 ='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"l_gldt036_desc"
   END IF

   IF g_input.l_chk37 ='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"l_gldt037_desc"
   END IF

   IF g_input.l_chk38 ='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"l_gldt038_desc"
   END IF
   
   IF g_input.l_chk22 ='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"l_gldt022_desc"
   END IF 
    
   IF g_input.l_chk23 ='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"l_gldt023_desc"
   END IF
   
   IF g_input.l_chk24 ='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"l_gldt024_desc"
   END IF
END FUNCTION

 
{</section>}
 
