#該程式未解開Section, 採用最新樣板產出!
{<section id="aglq901.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2016-06-01 14:45:35), PR版次:0004(2016-10-24 11:18:30)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000029
#+ Filename...: aglq901
#+ Description: 合併報表個體公司合併前各期科目核算項餘額查詢作業
#+ Creator....: 03080(2015-03-17 10:00:56)
#+ Modifier...: 06821 -SD/PR- 06821
 
{</section>}
 
{<section id="aglq901.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#160517-00002#2 160602  By 06821  查詢加上轉XG功能
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
PRIVATE type type_g_gldn_m        RECORD
       gldnld LIKE gldn_t.gldnld, 
   gldnld_desc LIKE type_t.chr80, 
   gldn001 LIKE gldn_t.gldn001, 
   gldn001_desc LIKE type_t.chr80, 
   gldn002 LIKE gldn_t.gldn002, 
   gldn002_desc LIKE type_t.chr80, 
   gldn005 LIKE gldn_t.gldn005, 
   gldn006 LIKE gldn_t.gldn006, 
   gldn009 LIKE gldn_t.gldn009, 
   gldn026 LIKE gldn_t.gldn026, 
   gldn029 LIKE gldn_t.gldn029, 
   gldn032 LIKE gldn_t.gldn032, 
   gldn003 LIKE gldn_t.gldn003, 
   gldn033 LIKE gldn_t.gldn033, 
   gldn004 LIKE gldn_t.gldn004
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_gldn_d        RECORD
       gldn007 LIKE gldn_t.gldn007, 
   gldn007_desc LIKE type_t.chr100, 
   gldn008 LIKE gldn_t.gldn008, 
   gldn014 LIKE gldn_t.gldn014, 
   gldn014_desc LIKE type_t.chr100, 
   gldn015 LIKE gldn_t.gldn015, 
   gldn015_desc LIKE type_t.chr100, 
   gldn016 LIKE gldn_t.gldn016, 
   gldn016_desc LIKE type_t.chr100, 
   gldn017 LIKE gldn_t.gldn017, 
   gldn017_desc LIKE type_t.chr100, 
   gldn018 LIKE gldn_t.gldn018, 
   gldn018_desc LIKE type_t.chr100, 
   gldn019 LIKE gldn_t.gldn019, 
   gldn019_desc LIKE type_t.chr100, 
   gldn020 LIKE gldn_t.gldn020, 
   gldn020_desc LIKE type_t.chr100, 
   gldn021 LIKE gldn_t.gldn021, 
   gldn021_desc LIKE type_t.chr100, 
   gldn037 LIKE gldn_t.gldn037, 
   gldn038 LIKE gldn_t.gldn038, 
   gldn038_desc LIKE type_t.chr100, 
   gldn039 LIKE gldn_t.gldn039, 
   gldn039_desc LIKE type_t.chr100, 
   gldn022 LIKE gldn_t.gldn022, 
   gldn022_desc LIKE type_t.chr100, 
   gldn024 LIKE gldn_t.gldn024, 
   gldn024_desc LIKE type_t.chr100, 
   gldn025 LIKE gldn_t.gldn025, 
   gldn025_desc LIKE type_t.chr100, 
   gldn034 LIKE gldn_t.gldn034, 
   gldn010 LIKE gldn_t.gldn010, 
   gldn011 LIKE gldn_t.gldn011, 
   l_gldn011 LIKE type_t.num20_6, 
   gldn040 LIKE gldn_t.gldn040, 
   gldn041 LIKE gldn_t.gldn041
       END RECORD
PRIVATE TYPE type_g_gldn2_d RECORD
       gldn007 LIKE gldn_t.gldn007, 
   gldn0072_desc LIKE type_t.chr100, 
   gldn008 LIKE gldn_t.gldn008, 
   l_gldn0142 LIKE type_t.chr100, 
   l_gldn0152 LIKE type_t.chr100, 
   l_gldn0162 LIKE type_t.chr100, 
   l_gldn0172 LIKE type_t.chr100, 
   l_gldn0182 LIKE type_t.chr100, 
   l_gldn0192 LIKE type_t.chr100, 
   l_gldn0202 LIKE type_t.chr100, 
   l_gldn0212 LIKE type_t.chr100, 
   l_gldn0372 LIKE type_t.chr10, 
   l_gldn0382 LIKE type_t.chr100, 
   l_gldn0392 LIKE type_t.chr100, 
   l_gldn0222 LIKE type_t.chr100, 
   l_gldn0242 LIKE type_t.chr100, 
   l_gldn0252 LIKE type_t.chr100, 
   gldn035 LIKE gldn_t.gldn035, 
   gldn027 LIKE gldn_t.gldn027, 
   gldn028 LIKE gldn_t.gldn028, 
   l_gldn028 LIKE type_t.num20_6, 
   gldn040 LIKE gldn_t.gldn040, 
   gldn041 LIKE gldn_t.gldn041
       END RECORD
PRIVATE TYPE type_g_gldn3_d RECORD
       gldn007 LIKE gldn_t.gldn007, 
   gldn0073_desc LIKE type_t.chr100, 
   gldn008 LIKE gldn_t.gldn008, 
   l_gldn0143 LIKE type_t.chr100, 
   l_gldn0153 LIKE type_t.chr100, 
   l_gldn0163 LIKE type_t.chr100, 
   l_gldn0173 LIKE type_t.chr100, 
   l_gldn0183 LIKE type_t.chr100, 
   l_gldn0193 LIKE type_t.chr100, 
   l_gldn0203 LIKE type_t.chr100, 
   l_gldn0213 LIKE type_t.chr100, 
   l_gldn0373 LIKE type_t.chr10, 
   l_gldn0383 LIKE type_t.chr100, 
   l_gldn0393 LIKE type_t.chr100, 
   l_gldn0223 LIKE type_t.chr100, 
   l_gldn0243 LIKE type_t.chr100, 
   l_gldn0253 LIKE type_t.chr100, 
   gldn036 LIKE gldn_t.gldn036, 
   gldn030 LIKE gldn_t.gldn030, 
   gldn031 LIKE gldn_t.gldn031, 
   l_gldn031 LIKE type_t.num20_6, 
   gldn040 LIKE gldn_t.gldn040, 
   gldn041 LIKE gldn_t.gldn041
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
             l_chk37 LIKE type_t.chr80, 
             l_chk38 LIKE type_t.chr80, 
             l_chk39 LIKE type_t.chr80, 
             l_chk22 LIKE type_t.chr80, 
             l_chk24 LIKE type_t.chr80, 
             l_chk25 LIKE type_t.chr80
                             END RECORD
DEFINE g_xg_visible          STRING     #XG欄位隱藏條件      #160517-00002#2
#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_gldn_m          type_g_gldn_m
DEFINE g_gldn_m_t        type_g_gldn_m
DEFINE g_gldn_m_o        type_g_gldn_m
DEFINE g_gldn_m_mask_o   type_g_gldn_m #轉換遮罩前資料
DEFINE g_gldn_m_mask_n   type_g_gldn_m #轉換遮罩後資料
 
   DEFINE g_gldnld_t LIKE gldn_t.gldnld
DEFINE g_gldn001_t LIKE gldn_t.gldn001
DEFINE g_gldn002_t LIKE gldn_t.gldn002
DEFINE g_gldn005_t LIKE gldn_t.gldn005
DEFINE g_gldn006_t LIKE gldn_t.gldn006
DEFINE g_gldn032_t LIKE gldn_t.gldn032
DEFINE g_gldn003_t LIKE gldn_t.gldn003
DEFINE g_gldn033_t LIKE gldn_t.gldn033
DEFINE g_gldn004_t LIKE gldn_t.gldn004
 
 
DEFINE g_gldn_d          DYNAMIC ARRAY OF type_g_gldn_d
DEFINE g_gldn_d_t        type_g_gldn_d
DEFINE g_gldn_d_o        type_g_gldn_d
DEFINE g_gldn_d_mask_o   DYNAMIC ARRAY OF type_g_gldn_d #轉換遮罩前資料
DEFINE g_gldn_d_mask_n   DYNAMIC ARRAY OF type_g_gldn_d #轉換遮罩後資料
DEFINE g_gldn2_d   DYNAMIC ARRAY OF type_g_gldn2_d
DEFINE g_gldn2_d_t type_g_gldn2_d
DEFINE g_gldn2_d_o type_g_gldn2_d
DEFINE g_gldn2_d_mask_o   DYNAMIC ARRAY OF type_g_gldn2_d #轉換遮罩前資料
DEFINE g_gldn2_d_mask_n   DYNAMIC ARRAY OF type_g_gldn2_d #轉換遮罩後資料
DEFINE g_gldn3_d   DYNAMIC ARRAY OF type_g_gldn3_d
DEFINE g_gldn3_d_t type_g_gldn3_d
DEFINE g_gldn3_d_o type_g_gldn3_d
DEFINE g_gldn3_d_mask_o   DYNAMIC ARRAY OF type_g_gldn3_d #轉換遮罩前資料
DEFINE g_gldn3_d_mask_n   DYNAMIC ARRAY OF type_g_gldn3_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_gldnld LIKE gldn_t.gldnld,
      b_gldn001 LIKE gldn_t.gldn001,
      b_gldn002 LIKE gldn_t.gldn002,
      b_gldn003 LIKE gldn_t.gldn003,
      b_gldn004 LIKE gldn_t.gldn004,
      b_gldn005 LIKE gldn_t.gldn005,
      b_gldn006 LIKE gldn_t.gldn006,
      b_gldn032 LIKE gldn_t.gldn032,
      b_gldn033 LIKE gldn_t.gldn033
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
 
{<section id="aglq901.main" >}
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
   LET g_forupd_sql = " SELECT gldnld,'',gldn001,'',gldn002,'',gldn005,gldn006,gldn009,gldn026,gldn029, 
       gldn032,gldn003,gldn033,gldn004", 
                      " FROM gldn_t",
                      " WHERE gldnent= ? AND gldnld=? AND gldn001=? AND gldn002=? AND gldn003=? AND  
                          gldn004=? AND gldn005=? AND gldn006=? AND gldn032=? AND gldn033=? FOR UPDATE" 
 
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aglq901_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.gldnld,t0.gldn001,t0.gldn002,t0.gldn005,t0.gldn006,t0.gldn009,t0.gldn026, 
       t0.gldn029,t0.gldn032,t0.gldn003,t0.gldn033,t0.gldn004",
               " FROM gldn_t t0",
               
               " WHERE t0.gldnent = " ||g_enterprise|| " AND t0.gldnld = ? AND t0.gldn001 = ? AND t0.gldn002 = ? AND t0.gldn003 = ? AND t0.gldn004 = ? AND t0.gldn005 = ? AND t0.gldn006 = ? AND t0.gldn032 = ? AND t0.gldn033 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aglq901_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aglq901 WITH FORM cl_ap_formpath("agl",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aglq901_init()   
 
      #進入選單 Menu (="N")
      CALL aglq901_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aglq901
      
   END IF 
   
   CLOSE aglq901_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aglq901.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aglq901_init()
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
   CALL cl_set_combo_scc('gldn037','6013')   #經營方式
   CALL cl_set_combo_scc('l_gldn0372','6013') 
   CALL cl_set_combo_scc('l_gldn0373','6013') 
   #CALL s_fin_set_comp_scc('gldn005','43')   #年度   #151113-00002#4 151113 by sakura mark
   #CALL s_fin_set_comp_scc('gldn006','111')  #期別   #151113-00002#4 151113 by sakura mark
   CALL aglq901_construct_visible('OUT')

   #end add-point
   
   CALL aglq901_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aglq901.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION aglq901_ui_dialog()
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
   CALL aglq901_create_tmp() #160517-00002#2
   #end add-point
   
   WHILE TRUE
      
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_gldn_m.* TO NULL
         CALL g_gldn_d.clear()
         CALL g_gldn2_d.clear()
         CALL g_gldn3_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aglq901_init()
      END IF
 
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
        
         DISPLAY ARRAY g_gldn_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL aglq901_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL aglq901_ui_detailshow()
               
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
        
         DISPLAY ARRAY g_gldn2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL aglq901_idx_chk()
               CALL aglq901_ui_detailshow()
               
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
         DISPLAY ARRAY g_gldn3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL aglq901_idx_chk()
               CALL aglq901_ui_detailshow()
               
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
            CALL aglq901_filter2()
            EXIT DIALOG
         #end add-point
         
         
         BEFORE DIALOG
            #先填充browser資料
            CALL aglq901_browser_fill("")
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
               CALL aglq901_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aglq901_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL aglq901_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aglq901_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL aglq901_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aglq901_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL aglq901_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aglq901_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL aglq901_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aglq901_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL aglq901_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aglq901_idx_chk()
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
                  LET g_export_node[1] = base.typeInfo.create(g_gldn_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_gldn2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_gldn3_d)
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
               NEXT FIELD gldn007
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
               CALL aglq901_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL aglq901_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL aglq901_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               #160517-00002#2 --s add
               CALL aglq901_ins_x01_tmp()
               CALL aglq901_x01(' 1=1','aglq901_x01_tmp',g_xg_visible)
               #160517-00002#2 --e add
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               #160517-00002#2 --s add
               CALL aglq901_ins_x01_tmp()
               CALL aglq901_x01(' 1=1','aglq901_x01_tmp',g_xg_visible)
               #160517-00002#2 --e add
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aglq901_query()
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
            CALL aglq901_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aglq901_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aglq901_set_pk_array()
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
 
{<section id="aglq901.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION aglq901_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aglq901.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION aglq901_browser_fill(ps_page_action)
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
 
   LET l_searchcol = "gldnld,gldn001,gldn002,gldn003,gldn004,gldn005,gldn006,gldn032,gldn033"
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
      LET l_sub_sql = " SELECT DISTINCT gldnld ",
                      ", gldn001 ",
                      ", gldn002 ",
                      ", gldn003 ",
                      ", gldn004 ",
                      ", gldn005 ",
                      ", gldn006 ",
                      ", gldn032 ",
                      ", gldn033 ",
 
                      " FROM gldn_t ",
                      " ",
                      " ", 
 
 
 
                      " WHERE gldnent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("gldn_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT gldnld ",
                      ", gldn001 ",
                      ", gldn002 ",
                      ", gldn003 ",
                      ", gldn004 ",
                      ", gldn005 ",
                      ", gldn006 ",
                      ", gldn032 ",
                      ", gldn033 ",
 
                      " FROM gldn_t ",
                      " ",
                      " ", 
 
 
                      " WHERE gldnent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("gldn_t")
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
      INITIALIZE g_gldn_m.* TO NULL
      CALL g_gldn_d.clear()        
      CALL g_gldn2_d.clear() 
      CALL g_gldn3_d.clear() 
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.gldnld,t0.gldn001,t0.gldn002,t0.gldn003,t0.gldn004,t0.gldn005,t0.gldn006,t0.gldn032,t0.gldn033 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.gldnld,t0.gldn001,t0.gldn002,t0.gldn003,t0.gldn004,t0.gldn005,t0.gldn006, 
       t0.gldn032,t0.gldn033",
                " FROM gldn_t t0",
                #" ",
                " ",
 
 
 
                
                " WHERE t0.gldnent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("gldn_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
   
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"gldn_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_gldnld,g_browser[g_cnt].b_gldn001,g_browser[g_cnt].b_gldn002, 
          g_browser[g_cnt].b_gldn003,g_browser[g_cnt].b_gldn004,g_browser[g_cnt].b_gldn005,g_browser[g_cnt].b_gldn006, 
          g_browser[g_cnt].b_gldn032,g_browser[g_cnt].b_gldn033 
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
   
   IF cl_null(g_browser[g_cnt].b_gldnld) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_gldn_m.* TO NULL
      CALL g_gldn_d.clear()
      CALL g_gldn2_d.clear()
      CALL g_gldn3_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL aglq901_fetch('')
   
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
 
{<section id="aglq901.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION aglq901_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_gldn_m.gldnld = g_browser[g_current_idx].b_gldnld   
   LET g_gldn_m.gldn001 = g_browser[g_current_idx].b_gldn001   
   LET g_gldn_m.gldn002 = g_browser[g_current_idx].b_gldn002   
   LET g_gldn_m.gldn003 = g_browser[g_current_idx].b_gldn003   
   LET g_gldn_m.gldn004 = g_browser[g_current_idx].b_gldn004   
   LET g_gldn_m.gldn005 = g_browser[g_current_idx].b_gldn005   
   LET g_gldn_m.gldn006 = g_browser[g_current_idx].b_gldn006   
   LET g_gldn_m.gldn032 = g_browser[g_current_idx].b_gldn032   
   LET g_gldn_m.gldn033 = g_browser[g_current_idx].b_gldn033   
 
   EXECUTE aglq901_master_referesh USING g_gldn_m.gldnld,g_gldn_m.gldn001,g_gldn_m.gldn002,g_gldn_m.gldn003, 
       g_gldn_m.gldn004,g_gldn_m.gldn005,g_gldn_m.gldn006,g_gldn_m.gldn032,g_gldn_m.gldn033 INTO g_gldn_m.gldnld, 
       g_gldn_m.gldn001,g_gldn_m.gldn002,g_gldn_m.gldn005,g_gldn_m.gldn006,g_gldn_m.gldn009,g_gldn_m.gldn026, 
       g_gldn_m.gldn029,g_gldn_m.gldn032,g_gldn_m.gldn003,g_gldn_m.gldn033,g_gldn_m.gldn004
   CALL aglq901_show()
   
END FUNCTION
 
{</section>}
 
{<section id="aglq901.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION aglq901_ui_detailshow()
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
 
{<section id="aglq901.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aglq901_ui_browser_refresh()
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
      IF g_browser[l_i].b_gldnld = g_gldn_m.gldnld 
         AND g_browser[l_i].b_gldn001 = g_gldn_m.gldn001 
         AND g_browser[l_i].b_gldn002 = g_gldn_m.gldn002 
         AND g_browser[l_i].b_gldn003 = g_gldn_m.gldn003 
         AND g_browser[l_i].b_gldn004 = g_gldn_m.gldn004 
         AND g_browser[l_i].b_gldn005 = g_gldn_m.gldn005 
         AND g_browser[l_i].b_gldn006 = g_gldn_m.gldn006 
         AND g_browser[l_i].b_gldn032 = g_gldn_m.gldn032 
         AND g_browser[l_i].b_gldn033 = g_gldn_m.gldn033 
 
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
 
{<section id="aglq901.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aglq901_construct()
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
   INITIALIZE g_gldn_m.* TO NULL
   CALL g_gldn_d.clear()
   CALL g_gldn2_d.clear()
   CALL g_gldn3_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   CALL aglq901_qbe_clear()
   CALL cl_set_comp_visible('gldn026,bpage_3',TRUE)
   CALL cl_set_comp_visible('gldn029,bpage_4',TRUE)
   CALL aglq901_construct_visible('IN')
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON gldnld,gldn001,gldn002,gldn002_desc,gldn005,gldn006,gldn032,gldn003, 
          gldn033,gldn004
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
                 #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldnld
            #add-point:BEFORE FIELD gldnld name="construct.b.gldnld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldnld
            
            #add-point:AFTER FIELD gldnld name="construct.a.gldnld"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gldnld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldnld
            #add-point:ON ACTION controlp INFIELD gldnld name="construct.c.gldnld"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_grup
            #LET g_qryparam.where = " glaald IN (SELECT glaald FROM glaa_t WHERE glaa130 = 'Y') "              #為合併帳別
            LET g_qryparam.where =  " glaald IN (SELECT gldbld FROM gldb_t WHERE gldbent = '",g_enterprise,"') "
            CALL q_authorised_ld()
            DISPLAY g_qryparam.return1 TO gldnld
            NEXT FIELD gldnld
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn001
            #add-point:BEFORE FIELD gldn001 name="construct.b.gldn001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn001
            
            #add-point:AFTER FIELD gldn001 name="construct.a.gldn001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gldn001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn001
            #add-point:ON ACTION controlp INFIELD gldn001 name="construct.c.gldn001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_glda001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gldn001  #顯示到畫面上
            NEXT FIELD gldn001
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn002
            #add-point:BEFORE FIELD gldn002 name="construct.b.gldn002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn002
            
            #add-point:AFTER FIELD gldn002 name="construct.a.gldn002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gldn002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn002
            #add-point:ON ACTION controlp INFIELD gldn002 name="construct.c.gldn002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_grup
            CALL q_authorised_ld()
            DISPLAY g_qryparam.return1 TO gldn002
            NEXT FIELD gldn002
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn002_desc
            #add-point:BEFORE FIELD gldn002_desc name="construct.b.gldn002_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn002_desc
            
            #add-point:AFTER FIELD gldn002_desc name="construct.a.gldn002_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gldn002_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn002_desc
            #add-point:ON ACTION controlp INFIELD gldn002_desc name="construct.c.gldn002_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn005
            #add-point:BEFORE FIELD gldn005 name="construct.b.gldn005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn005
            
            #add-point:AFTER FIELD gldn005 name="construct.a.gldn005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gldn005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn005
            #add-point:ON ACTION controlp INFIELD gldn005 name="construct.c.gldn005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn006
            #add-point:BEFORE FIELD gldn006 name="construct.b.gldn006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn006
            
            #add-point:AFTER FIELD gldn006 name="construct.a.gldn006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gldn006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn006
            #add-point:ON ACTION controlp INFIELD gldn006 name="construct.c.gldn006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn032
            #add-point:BEFORE FIELD gldn032 name="construct.b.gldn032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn032
            
            #add-point:AFTER FIELD gldn032 name="construct.a.gldn032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gldn032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn032
            #add-point:ON ACTION controlp INFIELD gldn032 name="construct.c.gldn032"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn003
            #add-point:BEFORE FIELD gldn003 name="construct.b.gldn003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn003
            
            #add-point:AFTER FIELD gldn003 name="construct.a.gldn003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gldn003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn003
            #add-point:ON ACTION controlp INFIELD gldn003 name="construct.c.gldn003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn033
            #add-point:BEFORE FIELD gldn033 name="construct.b.gldn033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn033
            
            #add-point:AFTER FIELD gldn033 name="construct.a.gldn033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gldn033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn033
            #add-point:ON ACTION controlp INFIELD gldn033 name="construct.c.gldn033"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn004
            #add-point:BEFORE FIELD gldn004 name="construct.b.gldn004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn004
            
            #add-point:AFTER FIELD gldn004 name="construct.a.gldn004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gldn004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn004
            #add-point:ON ACTION controlp INFIELD gldn004 name="construct.c.gldn004"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON gldn007,gldn008,gldn014,gldn015,gldn016,gldn017,gldn018,gldn019,gldn020, 
          gldn021,gldn037,gldn038,gldn039,gldn022,gldn024,gldn025,gldn034,gldn010,gldn011,gldn035,gldn027, 
          gldn028,gldn036,gldn030,gldn031
           FROM s_detail1[1].gldn007,s_detail1[1].gldn008,s_detail1[1].gldn014,s_detail1[1].gldn015, 
               s_detail1[1].gldn016,s_detail1[1].gldn017,s_detail1[1].gldn018,s_detail1[1].gldn019,s_detail1[1].gldn020, 
               s_detail1[1].gldn021,s_detail1[1].gldn037,s_detail1[1].gldn038,s_detail1[1].gldn039,s_detail1[1].gldn022, 
               s_detail1[1].gldn024,s_detail1[1].gldn025,s_detail1[1].gldn034,s_detail1[1].gldn010,s_detail1[1].gldn011, 
               s_detail2[1].gldn035,s_detail2[1].gldn027,s_detail2[1].gldn028,s_detail3[1].gldn036,s_detail3[1].gldn030, 
               s_detail3[1].gldn031
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn007
            #add-point:BEFORE FIELD gldn007 name="construct.b.page1.gldn007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn007
            
            #add-point:AFTER FIELD gldn007 name="construct.a.page1.gldn007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldn007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn007
            #add-point:ON ACTION controlp INFIELD gldn007 name="construct.c.page1.gldn007"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " glac003 <>'1' AND glac006 = '1'"
            CALL aglt310_04()
            DISPLAY g_qryparam.return1 TO gldn007 #顯示到畫面上
            NEXT FIELD gldn007
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn008
            #add-point:BEFORE FIELD gldn008 name="construct.b.page1.gldn008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn008
            
            #add-point:AFTER FIELD gldn008 name="construct.a.page1.gldn008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldn008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn008
            #add-point:ON ACTION controlp INFIELD gldn008 name="construct.c.page1.gldn008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn014
            #add-point:BEFORE FIELD gldn014 name="construct.b.page1.gldn014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn014
            
            #add-point:AFTER FIELD gldn014 name="construct.a.page1.gldn014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldn014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn014
            #add-point:ON ACTION controlp INFIELD gldn014 name="construct.c.page1.gldn014"
            #營運據點
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()    #161021-00037#3 mark
            CALL q_ooef001_01()  #161021-00037#3 add
            DISPLAY g_qryparam.return1 TO gldn014
            NEXT FIELD gldn014
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn015
            #add-point:BEFORE FIELD gldn015 name="construct.b.page1.gldn015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn015
            
            #add-point:AFTER FIELD gldn015 name="construct.a.page1.gldn015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldn015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn015
            #add-point:ON ACTION controlp INFIELD gldn015 name="construct.c.page1.gldn015"
            #部門
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "ooegstus='Y'"
            CALL q_ooeg001_4()
            DISPLAY g_qryparam.return1 TO gldn015
            NEXT FIELD gldn015
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn016
            #add-point:BEFORE FIELD gldn016 name="construct.b.page1.gldn016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn016
            
            #add-point:AFTER FIELD gldn016 name="construct.a.page1.gldn016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldn016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn016
            #add-point:ON ACTION controlp INFIELD gldn016 name="construct.c.page1.gldn016"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "ooegstus='Y' AND ooeg003 IN ('1','2','3')"
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gldn016      #顯示到畫面上
            NEXT FIELD gldn016
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn017
            #add-point:BEFORE FIELD gldn017 name="construct.b.page1.gldn017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn017
            
            #add-point:AFTER FIELD gldn017 name="construct.a.page1.gldn017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldn017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn017
            #add-point:ON ACTION controlp INFIELD gldn017 name="construct.c.page1.gldn017"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_287()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO gldn017      #顯示到畫面上
            NEXT FIELD gldn017
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn018
            #add-point:BEFORE FIELD gldn018 name="construct.b.page1.gldn018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn018
            
            #add-point:AFTER FIELD gldn018 name="construct.a.page1.gldn018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldn018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn018
            #add-point:ON ACTION controlp INFIELD gldn018 name="construct.c.page1.gldn018"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_25()      #160913-00017#3  add
            #CALL q_pmaa001()        #160913-00017#3  mark               #呼叫開窗
            DISPLAY g_qryparam.return1 TO gldn018
            NEXT FIELD gldn018
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn019
            #add-point:BEFORE FIELD gldn019 name="construct.b.page1.gldn019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn019
            
            #add-point:AFTER FIELD gldn019 name="construct.a.page1.gldn019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldn019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn019
            #add-point:ON ACTION controlp INFIELD gldn019 name="construct.c.page1.gldn019"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_pmaa001_25()      #160913-00017#3  add
            #CALL q_pmaa001()        #160913-00017#3  mark               #呼叫開窗
            DISPLAY g_qryparam.return1 TO gldn019
            NEXT FIELD gldn019
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn020
            #add-point:BEFORE FIELD gldn020 name="construct.b.page1.gldn020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn020
            
            #add-point:AFTER FIELD gldn020 name="construct.a.page1.gldn020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldn020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn020
            #add-point:ON ACTION controlp INFIELD gldn020 name="construct.c.page1.gldn020"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_oocq002_281()
            DISPLAY g_qryparam.return1 TO gldn020
            NEXT FIELD gldn020
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn021
            #add-point:BEFORE FIELD gldn021 name="construct.b.page1.gldn021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn021
            
            #add-point:AFTER FIELD gldn021 name="construct.a.page1.gldn021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldn021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn021
            #add-point:ON ACTION controlp INFIELD gldn021 name="construct.c.page1.gldn021"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gldn021      #顯示到畫面上
            NEXT FIELD gldn021
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn037
            #add-point:BEFORE FIELD gldn037 name="construct.b.page1.gldn037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn037
            
            #add-point:AFTER FIELD gldn037 name="construct.a.page1.gldn037"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldn037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn037
            #add-point:ON ACTION controlp INFIELD gldn037 name="construct.c.page1.gldn037"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn038
            #add-point:BEFORE FIELD gldn038 name="construct.b.page1.gldn038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn038
            
            #add-point:AFTER FIELD gldn038 name="construct.a.page1.gldn038"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldn038
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn038
            #add-point:ON ACTION controlp INFIELD gldn038 name="construct.c.page1.gldn038"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            LET g_qryparam.where = " oojdstus='Y' "
            CALL q_oojd001_2()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO gldn038    #顯示到畫面上
            NEXT FIELD gldn038
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn039
            #add-point:BEFORE FIELD gldn039 name="construct.b.page1.gldn039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn039
            
            #add-point:AFTER FIELD gldn039 name="construct.a.page1.gldn039"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldn039
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn039
            #add-point:ON ACTION controlp INFIELD gldn039 name="construct.c.page1.gldn039"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_oocq002_2002()                            #呼叫開窗
            DISPLAY g_qryparam.return1 TO gldn039      #顯示到畫面上
            NEXT FIELD gldn039
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn022
            #add-point:BEFORE FIELD gldn022 name="construct.b.page1.gldn022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn022
            
            #add-point:AFTER FIELD gldn022 name="construct.a.page1.gldn022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldn022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn022
            #add-point:ON ACTION controlp INFIELD gldn022 name="construct.c.page1.gldn022"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_ooag001_8()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gldn022     #顯示到畫面上
            NEXT FIELD gldn022
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn024
            #add-point:BEFORE FIELD gldn024 name="construct.b.page1.gldn024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn024
            
            #add-point:AFTER FIELD gldn024 name="construct.a.page1.gldn024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldn024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn024
            #add-point:ON ACTION controlp INFIELD gldn024 name="construct.c.page1.gldn024"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_pjba001()                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO gldn024     #顯示到畫面上
            NEXT FIELD gldn024
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn025
            #add-point:BEFORE FIELD gldn025 name="construct.b.page1.gldn025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn025
            
            #add-point:AFTER FIELD gldn025 name="construct.a.page1.gldn025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldn025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn025
            #add-point:ON ACTION controlp INFIELD gldn025 name="construct.c.page1.gldn025"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            LET g_qryparam.where = "pjbb012='1' "
            CALL q_pjbb002()                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO gldn025     #顯示到畫面上
            NEXT FIELD gldn025
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn034
            #add-point:BEFORE FIELD gldn034 name="construct.b.page1.gldn034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn034
            
            #add-point:AFTER FIELD gldn034 name="construct.a.page1.gldn034"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldn034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn034
            #add-point:ON ACTION controlp INFIELD gldn034 name="construct.c.page1.gldn034"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn010
            #add-point:BEFORE FIELD gldn010 name="construct.b.page1.gldn010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn010
            
            #add-point:AFTER FIELD gldn010 name="construct.a.page1.gldn010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldn010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn010
            #add-point:ON ACTION controlp INFIELD gldn010 name="construct.c.page1.gldn010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn011
            #add-point:BEFORE FIELD gldn011 name="construct.b.page1.gldn011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn011
            
            #add-point:AFTER FIELD gldn011 name="construct.a.page1.gldn011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldn011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn011
            #add-point:ON ACTION controlp INFIELD gldn011 name="construct.c.page1.gldn011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn035
            #add-point:BEFORE FIELD gldn035 name="construct.b.page2.gldn035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn035
            
            #add-point:AFTER FIELD gldn035 name="construct.a.page2.gldn035"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.gldn035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn035
            #add-point:ON ACTION controlp INFIELD gldn035 name="construct.c.page2.gldn035"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn027
            #add-point:BEFORE FIELD gldn027 name="construct.b.page2.gldn027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn027
            
            #add-point:AFTER FIELD gldn027 name="construct.a.page2.gldn027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.gldn027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn027
            #add-point:ON ACTION controlp INFIELD gldn027 name="construct.c.page2.gldn027"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn028
            #add-point:BEFORE FIELD gldn028 name="construct.b.page2.gldn028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn028
            
            #add-point:AFTER FIELD gldn028 name="construct.a.page2.gldn028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.gldn028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn028
            #add-point:ON ACTION controlp INFIELD gldn028 name="construct.c.page2.gldn028"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn036
            #add-point:BEFORE FIELD gldn036 name="construct.b.page3.gldn036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn036
            
            #add-point:AFTER FIELD gldn036 name="construct.a.page3.gldn036"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.gldn036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn036
            #add-point:ON ACTION controlp INFIELD gldn036 name="construct.c.page3.gldn036"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn030
            #add-point:BEFORE FIELD gldn030 name="construct.b.page3.gldn030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn030
            
            #add-point:AFTER FIELD gldn030 name="construct.a.page3.gldn030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.gldn030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn030
            #add-point:ON ACTION controlp INFIELD gldn030 name="construct.c.page3.gldn030"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn031
            #add-point:BEFORE FIELD gldn031 name="construct.b.page3.gldn031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn031
            
            #add-point:AFTER FIELD gldn031 name="construct.a.page3.gldn031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.gldn031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn031
            #add-point:ON ACTION controlp INFIELD gldn031 name="construct.c.page3.gldn031"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
  
 
  
      #add-point:cs段more_construct name="cs.more_construct"
      INPUT BY NAME g_input.l_chk14,g_input.l_chk15,g_input.l_chk16,g_input.l_chk17,
                    g_input.l_chk18,g_input.l_chk19,g_input.l_chk20,g_input.l_chk21,
                    g_input.l_chk37,g_input.l_chk38,g_input.l_chk39,
                    g_input.l_chk22,g_input.l_chk24,g_input.l_chk25
                    ATTRIBUTE(WITHOUT DEFAULTS)
      END INPUT
      ON ACTION qbeclear
         CALL aglq901_qbe_clear()
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:ui_dialog段b_dialog name="cs.before_dialog"
         LET l_ac = 1
         LET g_gldn_d[l_ac].gldn007 = ''
         DISPLAY ARRAY g_gldn_d TO s_detail1.*
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
   CALL aglq901_construct_visible('OUT')
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
 
{<section id="aglq901.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aglq901_query()
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
   CALL g_gldn_d.clear()
   CALL g_gldn2_d.clear()
   CALL g_gldn3_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL aglq901_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aglq901_browser_fill(g_wc)
      CALL aglq901_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL aglq901_browser_fill("F")
   
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
      CALL aglq901_fetch("F") 
   END IF
   
   CALL aglq901_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="aglq901.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aglq901_fetch(p_flag)
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
   
   #CALL aglq901_browser_fill(p_flag)
   
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
   
   LET g_gldn_m.gldnld = g_browser[g_current_idx].b_gldnld
   LET g_gldn_m.gldn001 = g_browser[g_current_idx].b_gldn001
   LET g_gldn_m.gldn002 = g_browser[g_current_idx].b_gldn002
   LET g_gldn_m.gldn003 = g_browser[g_current_idx].b_gldn003
   LET g_gldn_m.gldn004 = g_browser[g_current_idx].b_gldn004
   LET g_gldn_m.gldn005 = g_browser[g_current_idx].b_gldn005
   LET g_gldn_m.gldn006 = g_browser[g_current_idx].b_gldn006
   LET g_gldn_m.gldn032 = g_browser[g_current_idx].b_gldn032
   LET g_gldn_m.gldn033 = g_browser[g_current_idx].b_gldn033
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE aglq901_master_referesh USING g_gldn_m.gldnld,g_gldn_m.gldn001,g_gldn_m.gldn002,g_gldn_m.gldn003, 
       g_gldn_m.gldn004,g_gldn_m.gldn005,g_gldn_m.gldn006,g_gldn_m.gldn032,g_gldn_m.gldn033 INTO g_gldn_m.gldnld, 
       g_gldn_m.gldn001,g_gldn_m.gldn002,g_gldn_m.gldn005,g_gldn_m.gldn006,g_gldn_m.gldn009,g_gldn_m.gldn026, 
       g_gldn_m.gldn029,g_gldn_m.gldn032,g_gldn_m.gldn003,g_gldn_m.gldn033,g_gldn_m.gldn004
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "gldn_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_gldn_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_gldn_m_mask_o.* =  g_gldn_m.*
   CALL aglq901_gldn_t_mask()
   LET g_gldn_m_mask_n.* =  g_gldn_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL aglq901_set_act_visible()
   CALL aglq901_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_gldn_m_t.* = g_gldn_m.*
   LET g_gldn_m_o.* = g_gldn_m.*
   
   #重新顯示   
   CALL aglq901_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="aglq901.insert" >}
#+ 資料新增
PRIVATE FUNCTION aglq901_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_gldn_d.clear()
   CALL g_gldn2_d.clear()
   CALL g_gldn3_d.clear()
 
 
   INITIALIZE g_gldn_m.* TO NULL             #DEFAULT 設定
   LET g_gldnld_t = NULL
   LET g_gldn001_t = NULL
   LET g_gldn002_t = NULL
   LET g_gldn003_t = NULL
   LET g_gldn004_t = NULL
   LET g_gldn005_t = NULL
   LET g_gldn006_t = NULL
   LET g_gldn032_t = NULL
   LET g_gldn033_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
            LET g_gldn_m.gldn005 = "0"
      LET g_gldn_m.gldn006 = "0"
      LET g_gldn_m.gldn003 = "0"
      LET g_gldn_m.gldn004 = "0"
 
     
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point 
 
      CALL aglq901_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_gldn_m.* TO NULL
         INITIALIZE g_gldn_d TO NULL
         INITIALIZE g_gldn2_d TO NULL
         INITIALIZE g_gldn3_d TO NULL
 
         CALL aglq901_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_gldn_m.* = g_gldn_m_t.*
         CALL aglq901_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_gldn_d.clear()
      #CALL g_gldn2_d.clear()
      #CALL g_gldn3_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL aglq901_set_act_visible()
   CALL aglq901_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_gldnld_t = g_gldn_m.gldnld
   LET g_gldn001_t = g_gldn_m.gldn001
   LET g_gldn002_t = g_gldn_m.gldn002
   LET g_gldn003_t = g_gldn_m.gldn003
   LET g_gldn004_t = g_gldn_m.gldn004
   LET g_gldn005_t = g_gldn_m.gldn005
   LET g_gldn006_t = g_gldn_m.gldn006
   LET g_gldn032_t = g_gldn_m.gldn032
   LET g_gldn033_t = g_gldn_m.gldn033
 
   
   #組合新增資料的條件
   LET g_add_browse = " gldnent = " ||g_enterprise|| " AND",
                      " gldnld = '", g_gldn_m.gldnld, "' "
                      ," AND gldn001 = '", g_gldn_m.gldn001, "' "
                      ," AND gldn002 = '", g_gldn_m.gldn002, "' "
                      ," AND gldn003 = '", g_gldn_m.gldn003, "' "
                      ," AND gldn004 = '", g_gldn_m.gldn004, "' "
                      ," AND gldn005 = '", g_gldn_m.gldn005, "' "
                      ," AND gldn006 = '", g_gldn_m.gldn006, "' "
                      ," AND gldn032 = '", g_gldn_m.gldn032, "' "
                      ," AND gldn033 = '", g_gldn_m.gldn033, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aglq901_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL aglq901_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aglq901_master_referesh USING g_gldn_m.gldnld,g_gldn_m.gldn001,g_gldn_m.gldn002,g_gldn_m.gldn003, 
       g_gldn_m.gldn004,g_gldn_m.gldn005,g_gldn_m.gldn006,g_gldn_m.gldn032,g_gldn_m.gldn033 INTO g_gldn_m.gldnld, 
       g_gldn_m.gldn001,g_gldn_m.gldn002,g_gldn_m.gldn005,g_gldn_m.gldn006,g_gldn_m.gldn009,g_gldn_m.gldn026, 
       g_gldn_m.gldn029,g_gldn_m.gldn032,g_gldn_m.gldn003,g_gldn_m.gldn033,g_gldn_m.gldn004
   
   #遮罩相關處理
   LET g_gldn_m_mask_o.* =  g_gldn_m.*
   CALL aglq901_gldn_t_mask()
   LET g_gldn_m_mask_n.* =  g_gldn_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_gldn_m.gldnld,g_gldn_m.gldnld_desc,g_gldn_m.gldn001,g_gldn_m.gldn001_desc,g_gldn_m.gldn002, 
       g_gldn_m.gldn002_desc,g_gldn_m.gldn005,g_gldn_m.gldn006,g_gldn_m.gldn009,g_gldn_m.gldn026,g_gldn_m.gldn029, 
       g_gldn_m.gldn032,g_gldn_m.gldn003,g_gldn_m.gldn033,g_gldn_m.gldn004
   
   #功能已完成,通報訊息中心
   CALL aglq901_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aglq901.modify" >}
#+ 資料修改
PRIVATE FUNCTION aglq901_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_gldn_m.gldnld IS NULL
   OR g_gldn_m.gldn001 IS NULL
   OR g_gldn_m.gldn002 IS NULL
   OR g_gldn_m.gldn003 IS NULL
   OR g_gldn_m.gldn004 IS NULL
   OR g_gldn_m.gldn005 IS NULL
   OR g_gldn_m.gldn006 IS NULL
   OR g_gldn_m.gldn032 IS NULL
   OR g_gldn_m.gldn033 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_gldnld_t = g_gldn_m.gldnld
   LET g_gldn001_t = g_gldn_m.gldn001
   LET g_gldn002_t = g_gldn_m.gldn002
   LET g_gldn003_t = g_gldn_m.gldn003
   LET g_gldn004_t = g_gldn_m.gldn004
   LET g_gldn005_t = g_gldn_m.gldn005
   LET g_gldn006_t = g_gldn_m.gldn006
   LET g_gldn032_t = g_gldn_m.gldn032
   LET g_gldn033_t = g_gldn_m.gldn033
 
   CALL s_transaction_begin()
   
   OPEN aglq901_cl USING g_enterprise,g_gldn_m.gldnld,g_gldn_m.gldn001,g_gldn_m.gldn002,g_gldn_m.gldn003,g_gldn_m.gldn004,g_gldn_m.gldn005,g_gldn_m.gldn006,g_gldn_m.gldn032,g_gldn_m.gldn033
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aglq901_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE aglq901_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aglq901_master_referesh USING g_gldn_m.gldnld,g_gldn_m.gldn001,g_gldn_m.gldn002,g_gldn_m.gldn003, 
       g_gldn_m.gldn004,g_gldn_m.gldn005,g_gldn_m.gldn006,g_gldn_m.gldn032,g_gldn_m.gldn033 INTO g_gldn_m.gldnld, 
       g_gldn_m.gldn001,g_gldn_m.gldn002,g_gldn_m.gldn005,g_gldn_m.gldn006,g_gldn_m.gldn009,g_gldn_m.gldn026, 
       g_gldn_m.gldn029,g_gldn_m.gldn032,g_gldn_m.gldn003,g_gldn_m.gldn033,g_gldn_m.gldn004
   
   #遮罩相關處理
   LET g_gldn_m_mask_o.* =  g_gldn_m.*
   CALL aglq901_gldn_t_mask()
   LET g_gldn_m_mask_n.* =  g_gldn_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL aglq901_show()
   WHILE TRUE
      LET g_gldnld_t = g_gldn_m.gldnld
      LET g_gldn001_t = g_gldn_m.gldn001
      LET g_gldn002_t = g_gldn_m.gldn002
      LET g_gldn003_t = g_gldn_m.gldn003
      LET g_gldn004_t = g_gldn_m.gldn004
      LET g_gldn005_t = g_gldn_m.gldn005
      LET g_gldn006_t = g_gldn_m.gldn006
      LET g_gldn032_t = g_gldn_m.gldn032
      LET g_gldn033_t = g_gldn_m.gldn033
 
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL aglq901_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_gldn_m.* = g_gldn_m_t.*
         CALL aglq901_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_gldn_m.gldnld != g_gldnld_t 
      OR g_gldn_m.gldn001 != g_gldn001_t 
      OR g_gldn_m.gldn002 != g_gldn002_t 
      OR g_gldn_m.gldn003 != g_gldn003_t 
      OR g_gldn_m.gldn004 != g_gldn004_t 
      OR g_gldn_m.gldn005 != g_gldn005_t 
      OR g_gldn_m.gldn006 != g_gldn006_t 
      OR g_gldn_m.gldn032 != g_gldn032_t 
      OR g_gldn_m.gldn033 != g_gldn033_t 
 
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
   CALL aglq901_set_act_visible()
   CALL aglq901_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " gldnent = " ||g_enterprise|| " AND",
                      " gldnld = '", g_gldn_m.gldnld, "' "
                      ," AND gldn001 = '", g_gldn_m.gldn001, "' "
                      ," AND gldn002 = '", g_gldn_m.gldn002, "' "
                      ," AND gldn003 = '", g_gldn_m.gldn003, "' "
                      ," AND gldn004 = '", g_gldn_m.gldn004, "' "
                      ," AND gldn005 = '", g_gldn_m.gldn005, "' "
                      ," AND gldn006 = '", g_gldn_m.gldn006, "' "
                      ," AND gldn032 = '", g_gldn_m.gldn032, "' "
                      ," AND gldn033 = '", g_gldn_m.gldn033, "' "
 
   #填到對應位置
   CALL aglq901_browser_fill("")
 
   CALL aglq901_idx_chk()
 
   CLOSE aglq901_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aglq901_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="aglq901.input" >}
#+ 資料輸入
PRIVATE FUNCTION aglq901_input(p_cmd)
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
   DISPLAY BY NAME g_gldn_m.gldnld,g_gldn_m.gldnld_desc,g_gldn_m.gldn001,g_gldn_m.gldn001_desc,g_gldn_m.gldn002, 
       g_gldn_m.gldn002_desc,g_gldn_m.gldn005,g_gldn_m.gldn006,g_gldn_m.gldn009,g_gldn_m.gldn026,g_gldn_m.gldn029, 
       g_gldn_m.gldn032,g_gldn_m.gldn003,g_gldn_m.gldn033,g_gldn_m.gldn004
   
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
   LET g_forupd_sql = "SELECT gldn007,gldn008,gldn014,gldn015,gldn016,gldn017,gldn018,gldn019,gldn020, 
       gldn021,gldn037,gldn038,gldn039,gldn022,gldn024,gldn025,gldn034,gldn010,gldn011,gldn040,gldn041, 
       gldn007,gldn008,gldn035,gldn027,gldn028,gldn040,gldn041,gldn007,gldn008,gldn036,gldn030,gldn031, 
       gldn040,gldn041 FROM gldn_t WHERE gldnent=? AND gldnld=? AND gldn001=? AND gldn002=? AND gldn003=?  
       AND gldn004=? AND gldn005=? AND gldn006=? AND gldn032=? AND gldn033=? AND gldn007=? AND gldn008=?  
       AND gldn040=? AND gldn041=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aglq901_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aglq901_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL aglq901_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_gldn_m.gldnld,g_gldn_m.gldn001,g_gldn_m.gldn002,g_gldn_m.gldn005,g_gldn_m.gldn006, 
       g_gldn_m.gldn009,g_gldn_m.gldn026,g_gldn_m.gldn029,g_gldn_m.gldn032,g_gldn_m.gldn003,g_gldn_m.gldn033, 
       g_gldn_m.gldn004
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="aglq901.input.head" >}
   
      #單頭段
      INPUT BY NAME g_gldn_m.gldnld,g_gldn_m.gldn001,g_gldn_m.gldn002,g_gldn_m.gldn005,g_gldn_m.gldn006, 
          g_gldn_m.gldn009,g_gldn_m.gldn026,g_gldn_m.gldn029,g_gldn_m.gldn032,g_gldn_m.gldn003,g_gldn_m.gldn033, 
          g_gldn_m.gldn004 
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
         AFTER FIELD gldnld
            
            #add-point:AFTER FIELD gldnld name="input.a.gldnld"

            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_gldn_m.gldnld) AND NOT cl_null(g_gldn_m.gldn001) AND NOT cl_null(g_gldn_m.gldn002) AND NOT cl_null(g_gldn_m.gldn003) AND NOT cl_null(g_gldn_m.gldn004) AND NOT cl_null(g_gldn_m.gldn005) AND NOT cl_null(g_gldn_m.gldn006) AND NOT cl_null(g_gldn_m.gldn032) AND NOT cl_null(g_gldn_m.gldn033) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_gldn_m.gldnld != g_gldnld_t  OR g_gldn_m.gldn001 != g_gldn001_t  OR g_gldn_m.gldn002 != g_gldn002_t  OR g_gldn_m.gldn003 != g_gldn003_t  OR g_gldn_m.gldn004 != g_gldn004_t  OR g_gldn_m.gldn005 != g_gldn005_t  OR g_gldn_m.gldn006 != g_gldn006_t  OR g_gldn_m.gldn032 != g_gldn032_t  OR g_gldn_m.gldn033 != g_gldn033_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gldn_t WHERE "||"gldnent = '" ||g_enterprise|| "' AND "||"gldnld = '"||g_gldn_m.gldnld ||"' AND "|| "gldn001 = '"||g_gldn_m.gldn001 ||"' AND "|| "gldn002 = '"||g_gldn_m.gldn002 ||"' AND "|| "gldn003 = '"||g_gldn_m.gldn003 ||"' AND "|| "gldn004 = '"||g_gldn_m.gldn004 ||"' AND "|| "gldn005 = '"||g_gldn_m.gldn005 ||"' AND "|| "gldn006 = '"||g_gldn_m.gldn006 ||"' AND "|| "gldn032 = '"||g_gldn_m.gldn032 ||"' AND "|| "gldn033 = '"||g_gldn_m.gldn033 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldnld
            #add-point:BEFORE FIELD gldnld name="input.b.gldnld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldnld
            #add-point:ON CHANGE gldnld name="input.g.gldnld"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn001
            
            #add-point:AFTER FIELD gldn001 name="input.a.gldn001"

            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_gldn_m.gldnld) AND NOT cl_null(g_gldn_m.gldn001) AND NOT cl_null(g_gldn_m.gldn002) AND NOT cl_null(g_gldn_m.gldn003) AND NOT cl_null(g_gldn_m.gldn004) AND NOT cl_null(g_gldn_m.gldn005) AND NOT cl_null(g_gldn_m.gldn006) AND NOT cl_null(g_gldn_m.gldn032) AND NOT cl_null(g_gldn_m.gldn033) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_gldn_m.gldnld != g_gldnld_t  OR g_gldn_m.gldn001 != g_gldn001_t  OR g_gldn_m.gldn002 != g_gldn002_t  OR g_gldn_m.gldn003 != g_gldn003_t  OR g_gldn_m.gldn004 != g_gldn004_t  OR g_gldn_m.gldn005 != g_gldn005_t  OR g_gldn_m.gldn006 != g_gldn006_t  OR g_gldn_m.gldn032 != g_gldn032_t  OR g_gldn_m.gldn033 != g_gldn033_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gldn_t WHERE "||"gldnent = '" ||g_enterprise|| "' AND "||"gldnld = '"||g_gldn_m.gldnld ||"' AND "|| "gldn001 = '"||g_gldn_m.gldn001 ||"' AND "|| "gldn002 = '"||g_gldn_m.gldn002 ||"' AND "|| "gldn003 = '"||g_gldn_m.gldn003 ||"' AND "|| "gldn004 = '"||g_gldn_m.gldn004 ||"' AND "|| "gldn005 = '"||g_gldn_m.gldn005 ||"' AND "|| "gldn006 = '"||g_gldn_m.gldn006 ||"' AND "|| "gldn032 = '"||g_gldn_m.gldn032 ||"' AND "|| "gldn033 = '"||g_gldn_m.gldn033 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn001
            #add-point:BEFORE FIELD gldn001 name="input.b.gldn001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldn001
            #add-point:ON CHANGE gldn001 name="input.g.gldn001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn002
            
            #add-point:AFTER FIELD gldn002 name="input.a.gldn002"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_gldn_m.gldnld) AND NOT cl_null(g_gldn_m.gldn001) AND NOT cl_null(g_gldn_m.gldn002) AND NOT cl_null(g_gldn_m.gldn003) AND NOT cl_null(g_gldn_m.gldn004) AND NOT cl_null(g_gldn_m.gldn005) AND NOT cl_null(g_gldn_m.gldn006) AND NOT cl_null(g_gldn_m.gldn032) AND NOT cl_null(g_gldn_m.gldn033) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_gldn_m.gldnld != g_gldnld_t  OR g_gldn_m.gldn001 != g_gldn001_t  OR g_gldn_m.gldn002 != g_gldn002_t  OR g_gldn_m.gldn003 != g_gldn003_t  OR g_gldn_m.gldn004 != g_gldn004_t  OR g_gldn_m.gldn005 != g_gldn005_t  OR g_gldn_m.gldn006 != g_gldn006_t  OR g_gldn_m.gldn032 != g_gldn032_t  OR g_gldn_m.gldn033 != g_gldn033_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gldn_t WHERE "||"gldnent = '" ||g_enterprise|| "' AND "||"gldnld = '"||g_gldn_m.gldnld ||"' AND "|| "gldn001 = '"||g_gldn_m.gldn001 ||"' AND "|| "gldn002 = '"||g_gldn_m.gldn002 ||"' AND "|| "gldn003 = '"||g_gldn_m.gldn003 ||"' AND "|| "gldn004 = '"||g_gldn_m.gldn004 ||"' AND "|| "gldn005 = '"||g_gldn_m.gldn005 ||"' AND "|| "gldn006 = '"||g_gldn_m.gldn006 ||"' AND "|| "gldn032 = '"||g_gldn_m.gldn032 ||"' AND "|| "gldn033 = '"||g_gldn_m.gldn033 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn002
            #add-point:BEFORE FIELD gldn002 name="input.b.gldn002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldn002
            #add-point:ON CHANGE gldn002 name="input.g.gldn002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn005
            #add-point:BEFORE FIELD gldn005 name="input.b.gldn005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn005
            
            #add-point:AFTER FIELD gldn005 name="input.a.gldn005"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_gldn_m.gldnld) AND NOT cl_null(g_gldn_m.gldn001) AND NOT cl_null(g_gldn_m.gldn002) AND NOT cl_null(g_gldn_m.gldn003) AND NOT cl_null(g_gldn_m.gldn004) AND NOT cl_null(g_gldn_m.gldn005) AND NOT cl_null(g_gldn_m.gldn006) AND NOT cl_null(g_gldn_m.gldn032) AND NOT cl_null(g_gldn_m.gldn033) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_gldn_m.gldnld != g_gldnld_t  OR g_gldn_m.gldn001 != g_gldn001_t  OR g_gldn_m.gldn002 != g_gldn002_t  OR g_gldn_m.gldn003 != g_gldn003_t  OR g_gldn_m.gldn004 != g_gldn004_t  OR g_gldn_m.gldn005 != g_gldn005_t  OR g_gldn_m.gldn006 != g_gldn006_t  OR g_gldn_m.gldn032 != g_gldn032_t  OR g_gldn_m.gldn033 != g_gldn033_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gldn_t WHERE "||"gldnent = '" ||g_enterprise|| "' AND "||"gldnld = '"||g_gldn_m.gldnld ||"' AND "|| "gldn001 = '"||g_gldn_m.gldn001 ||"' AND "|| "gldn002 = '"||g_gldn_m.gldn002 ||"' AND "|| "gldn003 = '"||g_gldn_m.gldn003 ||"' AND "|| "gldn004 = '"||g_gldn_m.gldn004 ||"' AND "|| "gldn005 = '"||g_gldn_m.gldn005 ||"' AND "|| "gldn006 = '"||g_gldn_m.gldn006 ||"' AND "|| "gldn032 = '"||g_gldn_m.gldn032 ||"' AND "|| "gldn033 = '"||g_gldn_m.gldn033 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldn005
            #add-point:ON CHANGE gldn005 name="input.g.gldn005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn006
            #add-point:BEFORE FIELD gldn006 name="input.b.gldn006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn006
            
            #add-point:AFTER FIELD gldn006 name="input.a.gldn006"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_gldn_m.gldnld) AND NOT cl_null(g_gldn_m.gldn001) AND NOT cl_null(g_gldn_m.gldn002) AND NOT cl_null(g_gldn_m.gldn003) AND NOT cl_null(g_gldn_m.gldn004) AND NOT cl_null(g_gldn_m.gldn005) AND NOT cl_null(g_gldn_m.gldn006) AND NOT cl_null(g_gldn_m.gldn032) AND NOT cl_null(g_gldn_m.gldn033) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_gldn_m.gldnld != g_gldnld_t  OR g_gldn_m.gldn001 != g_gldn001_t  OR g_gldn_m.gldn002 != g_gldn002_t  OR g_gldn_m.gldn003 != g_gldn003_t  OR g_gldn_m.gldn004 != g_gldn004_t  OR g_gldn_m.gldn005 != g_gldn005_t  OR g_gldn_m.gldn006 != g_gldn006_t  OR g_gldn_m.gldn032 != g_gldn032_t  OR g_gldn_m.gldn033 != g_gldn033_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gldn_t WHERE "||"gldnent = '" ||g_enterprise|| "' AND "||"gldnld = '"||g_gldn_m.gldnld ||"' AND "|| "gldn001 = '"||g_gldn_m.gldn001 ||"' AND "|| "gldn002 = '"||g_gldn_m.gldn002 ||"' AND "|| "gldn003 = '"||g_gldn_m.gldn003 ||"' AND "|| "gldn004 = '"||g_gldn_m.gldn004 ||"' AND "|| "gldn005 = '"||g_gldn_m.gldn005 ||"' AND "|| "gldn006 = '"||g_gldn_m.gldn006 ||"' AND "|| "gldn032 = '"||g_gldn_m.gldn032 ||"' AND "|| "gldn033 = '"||g_gldn_m.gldn033 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldn006
            #add-point:ON CHANGE gldn006 name="input.g.gldn006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn009
            #add-point:BEFORE FIELD gldn009 name="input.b.gldn009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn009
            
            #add-point:AFTER FIELD gldn009 name="input.a.gldn009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldn009
            #add-point:ON CHANGE gldn009 name="input.g.gldn009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn026
            #add-point:BEFORE FIELD gldn026 name="input.b.gldn026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn026
            
            #add-point:AFTER FIELD gldn026 name="input.a.gldn026"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldn026
            #add-point:ON CHANGE gldn026 name="input.g.gldn026"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn029
            #add-point:BEFORE FIELD gldn029 name="input.b.gldn029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn029
            
            #add-point:AFTER FIELD gldn029 name="input.a.gldn029"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldn029
            #add-point:ON CHANGE gldn029 name="input.g.gldn029"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn032
            #add-point:BEFORE FIELD gldn032 name="input.b.gldn032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn032
            
            #add-point:AFTER FIELD gldn032 name="input.a.gldn032"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_gldn_m.gldnld) AND NOT cl_null(g_gldn_m.gldn001) AND NOT cl_null(g_gldn_m.gldn002) AND NOT cl_null(g_gldn_m.gldn003) AND NOT cl_null(g_gldn_m.gldn004) AND NOT cl_null(g_gldn_m.gldn005) AND NOT cl_null(g_gldn_m.gldn006) AND NOT cl_null(g_gldn_m.gldn032) AND NOT cl_null(g_gldn_m.gldn033) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_gldn_m.gldnld != g_gldnld_t  OR g_gldn_m.gldn001 != g_gldn001_t  OR g_gldn_m.gldn002 != g_gldn002_t  OR g_gldn_m.gldn003 != g_gldn003_t  OR g_gldn_m.gldn004 != g_gldn004_t  OR g_gldn_m.gldn005 != g_gldn005_t  OR g_gldn_m.gldn006 != g_gldn006_t  OR g_gldn_m.gldn032 != g_gldn032_t  OR g_gldn_m.gldn033 != g_gldn033_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gldn_t WHERE "||"gldnent = '" ||g_enterprise|| "' AND "||"gldnld = '"||g_gldn_m.gldnld ||"' AND "|| "gldn001 = '"||g_gldn_m.gldn001 ||"' AND "|| "gldn002 = '"||g_gldn_m.gldn002 ||"' AND "|| "gldn003 = '"||g_gldn_m.gldn003 ||"' AND "|| "gldn004 = '"||g_gldn_m.gldn004 ||"' AND "|| "gldn005 = '"||g_gldn_m.gldn005 ||"' AND "|| "gldn006 = '"||g_gldn_m.gldn006 ||"' AND "|| "gldn032 = '"||g_gldn_m.gldn032 ||"' AND "|| "gldn033 = '"||g_gldn_m.gldn033 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldn032
            #add-point:ON CHANGE gldn032 name="input.g.gldn032"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn003
            #add-point:BEFORE FIELD gldn003 name="input.b.gldn003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn003
            
            #add-point:AFTER FIELD gldn003 name="input.a.gldn003"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_gldn_m.gldnld) AND NOT cl_null(g_gldn_m.gldn001) AND NOT cl_null(g_gldn_m.gldn002) AND NOT cl_null(g_gldn_m.gldn003) AND NOT cl_null(g_gldn_m.gldn004) AND NOT cl_null(g_gldn_m.gldn005) AND NOT cl_null(g_gldn_m.gldn006) AND NOT cl_null(g_gldn_m.gldn032) AND NOT cl_null(g_gldn_m.gldn033) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_gldn_m.gldnld != g_gldnld_t  OR g_gldn_m.gldn001 != g_gldn001_t  OR g_gldn_m.gldn002 != g_gldn002_t  OR g_gldn_m.gldn003 != g_gldn003_t  OR g_gldn_m.gldn004 != g_gldn004_t  OR g_gldn_m.gldn005 != g_gldn005_t  OR g_gldn_m.gldn006 != g_gldn006_t  OR g_gldn_m.gldn032 != g_gldn032_t  OR g_gldn_m.gldn033 != g_gldn033_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gldn_t WHERE "||"gldnent = '" ||g_enterprise|| "' AND "||"gldnld = '"||g_gldn_m.gldnld ||"' AND "|| "gldn001 = '"||g_gldn_m.gldn001 ||"' AND "|| "gldn002 = '"||g_gldn_m.gldn002 ||"' AND "|| "gldn003 = '"||g_gldn_m.gldn003 ||"' AND "|| "gldn004 = '"||g_gldn_m.gldn004 ||"' AND "|| "gldn005 = '"||g_gldn_m.gldn005 ||"' AND "|| "gldn006 = '"||g_gldn_m.gldn006 ||"' AND "|| "gldn032 = '"||g_gldn_m.gldn032 ||"' AND "|| "gldn033 = '"||g_gldn_m.gldn033 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldn003
            #add-point:ON CHANGE gldn003 name="input.g.gldn003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn033
            #add-point:BEFORE FIELD gldn033 name="input.b.gldn033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn033
            
            #add-point:AFTER FIELD gldn033 name="input.a.gldn033"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_gldn_m.gldnld) AND NOT cl_null(g_gldn_m.gldn001) AND NOT cl_null(g_gldn_m.gldn002) AND NOT cl_null(g_gldn_m.gldn003) AND NOT cl_null(g_gldn_m.gldn004) AND NOT cl_null(g_gldn_m.gldn005) AND NOT cl_null(g_gldn_m.gldn006) AND NOT cl_null(g_gldn_m.gldn032) AND NOT cl_null(g_gldn_m.gldn033) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_gldn_m.gldnld != g_gldnld_t  OR g_gldn_m.gldn001 != g_gldn001_t  OR g_gldn_m.gldn002 != g_gldn002_t  OR g_gldn_m.gldn003 != g_gldn003_t  OR g_gldn_m.gldn004 != g_gldn004_t  OR g_gldn_m.gldn005 != g_gldn005_t  OR g_gldn_m.gldn006 != g_gldn006_t  OR g_gldn_m.gldn032 != g_gldn032_t  OR g_gldn_m.gldn033 != g_gldn033_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gldn_t WHERE "||"gldnent = '" ||g_enterprise|| "' AND "||"gldnld = '"||g_gldn_m.gldnld ||"' AND "|| "gldn001 = '"||g_gldn_m.gldn001 ||"' AND "|| "gldn002 = '"||g_gldn_m.gldn002 ||"' AND "|| "gldn003 = '"||g_gldn_m.gldn003 ||"' AND "|| "gldn004 = '"||g_gldn_m.gldn004 ||"' AND "|| "gldn005 = '"||g_gldn_m.gldn005 ||"' AND "|| "gldn006 = '"||g_gldn_m.gldn006 ||"' AND "|| "gldn032 = '"||g_gldn_m.gldn032 ||"' AND "|| "gldn033 = '"||g_gldn_m.gldn033 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldn033
            #add-point:ON CHANGE gldn033 name="input.g.gldn033"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn004
            #add-point:BEFORE FIELD gldn004 name="input.b.gldn004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn004
            
            #add-point:AFTER FIELD gldn004 name="input.a.gldn004"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_gldn_m.gldnld) AND NOT cl_null(g_gldn_m.gldn001) AND NOT cl_null(g_gldn_m.gldn002) AND NOT cl_null(g_gldn_m.gldn003) AND NOT cl_null(g_gldn_m.gldn004) AND NOT cl_null(g_gldn_m.gldn005) AND NOT cl_null(g_gldn_m.gldn006) AND NOT cl_null(g_gldn_m.gldn032) AND NOT cl_null(g_gldn_m.gldn033) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_gldn_m.gldnld != g_gldnld_t  OR g_gldn_m.gldn001 != g_gldn001_t  OR g_gldn_m.gldn002 != g_gldn002_t  OR g_gldn_m.gldn003 != g_gldn003_t  OR g_gldn_m.gldn004 != g_gldn004_t  OR g_gldn_m.gldn005 != g_gldn005_t  OR g_gldn_m.gldn006 != g_gldn006_t  OR g_gldn_m.gldn032 != g_gldn032_t  OR g_gldn_m.gldn033 != g_gldn033_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gldn_t WHERE "||"gldnent = '" ||g_enterprise|| "' AND "||"gldnld = '"||g_gldn_m.gldnld ||"' AND "|| "gldn001 = '"||g_gldn_m.gldn001 ||"' AND "|| "gldn002 = '"||g_gldn_m.gldn002 ||"' AND "|| "gldn003 = '"||g_gldn_m.gldn003 ||"' AND "|| "gldn004 = '"||g_gldn_m.gldn004 ||"' AND "|| "gldn005 = '"||g_gldn_m.gldn005 ||"' AND "|| "gldn006 = '"||g_gldn_m.gldn006 ||"' AND "|| "gldn032 = '"||g_gldn_m.gldn032 ||"' AND "|| "gldn033 = '"||g_gldn_m.gldn033 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldn004
            #add-point:ON CHANGE gldn004 name="input.g.gldn004"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.gldnld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldnld
            #add-point:ON ACTION controlp INFIELD gldnld name="input.c.gldnld"
            
            #END add-point
 
 
         #Ctrlp:input.c.gldn001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn001
            #add-point:ON ACTION controlp INFIELD gldn001 name="input.c.gldn001"
            
            #END add-point
 
 
         #Ctrlp:input.c.gldn002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn002
            #add-point:ON ACTION controlp INFIELD gldn002 name="input.c.gldn002"
            
            #END add-point
 
 
         #Ctrlp:input.c.gldn005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn005
            #add-point:ON ACTION controlp INFIELD gldn005 name="input.c.gldn005"
            
            #END add-point
 
 
         #Ctrlp:input.c.gldn006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn006
            #add-point:ON ACTION controlp INFIELD gldn006 name="input.c.gldn006"
            
            #END add-point
 
 
         #Ctrlp:input.c.gldn009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn009
            #add-point:ON ACTION controlp INFIELD gldn009 name="input.c.gldn009"
            
            #END add-point
 
 
         #Ctrlp:input.c.gldn026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn026
            #add-point:ON ACTION controlp INFIELD gldn026 name="input.c.gldn026"
            
            #END add-point
 
 
         #Ctrlp:input.c.gldn029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn029
            #add-point:ON ACTION controlp INFIELD gldn029 name="input.c.gldn029"
            
            #END add-point
 
 
         #Ctrlp:input.c.gldn032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn032
            #add-point:ON ACTION controlp INFIELD gldn032 name="input.c.gldn032"
            
            #END add-point
 
 
         #Ctrlp:input.c.gldn003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn003
            #add-point:ON ACTION controlp INFIELD gldn003 name="input.c.gldn003"
            
            #END add-point
 
 
         #Ctrlp:input.c.gldn033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn033
            #add-point:ON ACTION controlp INFIELD gldn033 name="input.c.gldn033"
            
            #END add-point
 
 
         #Ctrlp:input.c.gldn004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn004
            #add-point:ON ACTION controlp INFIELD gldn004 name="input.c.gldn004"
            
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
            DISPLAY BY NAME g_gldn_m.gldnld             
                            ,g_gldn_m.gldn001   
                            ,g_gldn_m.gldn002   
                            ,g_gldn_m.gldn003   
                            ,g_gldn_m.gldn004   
                            ,g_gldn_m.gldn005   
                            ,g_gldn_m.gldn006   
                            ,g_gldn_m.gldn032   
                            ,g_gldn_m.gldn033   
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
            
               #將遮罩欄位還原
               CALL aglq901_gldn_t_mask_restore('restore_mask_o')
            
               UPDATE gldn_t SET (gldnld,gldn001,gldn002,gldn005,gldn006,gldn009,gldn026,gldn029,gldn032, 
                   gldn003,gldn033,gldn004) = (g_gldn_m.gldnld,g_gldn_m.gldn001,g_gldn_m.gldn002,g_gldn_m.gldn005, 
                   g_gldn_m.gldn006,g_gldn_m.gldn009,g_gldn_m.gldn026,g_gldn_m.gldn029,g_gldn_m.gldn032, 
                   g_gldn_m.gldn003,g_gldn_m.gldn033,g_gldn_m.gldn004)
                WHERE gldnent = g_enterprise AND gldnld = g_gldnld_t
                  AND gldn001 = g_gldn001_t
                  AND gldn002 = g_gldn002_t
                  AND gldn003 = g_gldn003_t
                  AND gldn004 = g_gldn004_t
                  AND gldn005 = g_gldn005_t
                  AND gldn006 = g_gldn006_t
                  AND gldn032 = g_gldn032_t
                  AND gldn033 = g_gldn033_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gldn_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gldn_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gldn_m.gldnld
               LET gs_keys_bak[1] = g_gldnld_t
               LET gs_keys[2] = g_gldn_m.gldn001
               LET gs_keys_bak[2] = g_gldn001_t
               LET gs_keys[3] = g_gldn_m.gldn002
               LET gs_keys_bak[3] = g_gldn002_t
               LET gs_keys[4] = g_gldn_m.gldn003
               LET gs_keys_bak[4] = g_gldn003_t
               LET gs_keys[5] = g_gldn_m.gldn004
               LET gs_keys_bak[5] = g_gldn004_t
               LET gs_keys[6] = g_gldn_m.gldn005
               LET gs_keys_bak[6] = g_gldn005_t
               LET gs_keys[7] = g_gldn_m.gldn006
               LET gs_keys_bak[7] = g_gldn006_t
               LET gs_keys[8] = g_gldn_m.gldn032
               LET gs_keys_bak[8] = g_gldn032_t
               LET gs_keys[9] = g_gldn_m.gldn033
               LET gs_keys_bak[9] = g_gldn033_t
               LET gs_keys[10] = g_gldn_d[g_detail_idx].gldn007
               LET gs_keys_bak[10] = g_gldn_d_t.gldn007
               LET gs_keys[11] = g_gldn_d[g_detail_idx].gldn008
               LET gs_keys_bak[11] = g_gldn_d_t.gldn008
               LET gs_keys[12] = g_gldn_d[g_detail_idx].gldn040
               LET gs_keys_bak[12] = g_gldn_d_t.gldn040
               LET gs_keys[13] = g_gldn_d[g_detail_idx].gldn041
               LET gs_keys_bak[13] = g_gldn_d_t.gldn041
               CALL aglq901_update_b('gldn_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_gldn_m_t)
                     #LET g_log2 = util.JSON.stringify(g_gldn_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL aglq901_gldn_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL aglq901_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_gldnld_t = g_gldn_m.gldnld
           LET g_gldn001_t = g_gldn_m.gldn001
           LET g_gldn002_t = g_gldn_m.gldn002
           LET g_gldn003_t = g_gldn_m.gldn003
           LET g_gldn004_t = g_gldn_m.gldn004
           LET g_gldn005_t = g_gldn_m.gldn005
           LET g_gldn006_t = g_gldn_m.gldn006
           LET g_gldn032_t = g_gldn_m.gldn032
           LET g_gldn033_t = g_gldn_m.gldn033
 
           
           IF g_gldn_d.getLength() = 0 THEN
              NEXT FIELD gldn007
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="aglq901.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_gldn_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_gldn_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aglq901_b_fill(g_wc2) #test 
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
            CALL aglq901_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN aglq901_cl USING g_enterprise,g_gldn_m.gldnld,g_gldn_m.gldn001,g_gldn_m.gldn002,g_gldn_m.gldn003,g_gldn_m.gldn004,g_gldn_m.gldn005,g_gldn_m.gldn006,g_gldn_m.gldn032,g_gldn_m.gldn033                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE aglq901_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN aglq901_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_gldn_d[l_ac].gldn007 IS NOT NULL
               AND g_gldn_d[l_ac].gldn008 IS NOT NULL
               AND g_gldn_d[l_ac].gldn040 IS NOT NULL
               AND g_gldn_d[l_ac].gldn041 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_gldn_d_t.* = g_gldn_d[l_ac].*  #BACKUP
               LET g_gldn_d_o.* = g_gldn_d[l_ac].*  #BACKUP
               CALL aglq901_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL aglq901_set_no_entry_b(l_cmd)
               OPEN aglq901_bcl USING g_enterprise,g_gldn_m.gldnld,
                                                g_gldn_m.gldn001,
                                                g_gldn_m.gldn002,
                                                g_gldn_m.gldn003,
                                                g_gldn_m.gldn004,
                                                g_gldn_m.gldn005,
                                                g_gldn_m.gldn006,
                                                g_gldn_m.gldn032,
                                                g_gldn_m.gldn033,
 
                                                g_gldn_d_t.gldn007
                                                ,g_gldn_d_t.gldn008
                                                ,g_gldn_d_t.gldn040
                                                ,g_gldn_d_t.gldn041
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN aglq901_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aglq901_bcl INTO g_gldn_d[l_ac].gldn007,g_gldn_d[l_ac].gldn008,g_gldn_d[l_ac].gldn014, 
                      g_gldn_d[l_ac].gldn015,g_gldn_d[l_ac].gldn016,g_gldn_d[l_ac].gldn017,g_gldn_d[l_ac].gldn018, 
                      g_gldn_d[l_ac].gldn019,g_gldn_d[l_ac].gldn020,g_gldn_d[l_ac].gldn021,g_gldn_d[l_ac].gldn037, 
                      g_gldn_d[l_ac].gldn038,g_gldn_d[l_ac].gldn039,g_gldn_d[l_ac].gldn022,g_gldn_d[l_ac].gldn024, 
                      g_gldn_d[l_ac].gldn025,g_gldn_d[l_ac].gldn034,g_gldn_d[l_ac].gldn010,g_gldn_d[l_ac].gldn011, 
                      g_gldn_d[l_ac].gldn040,g_gldn_d[l_ac].gldn041,g_gldn2_d[l_ac].gldn007,g_gldn2_d[l_ac].gldn008, 
                      g_gldn2_d[l_ac].gldn035,g_gldn2_d[l_ac].gldn027,g_gldn2_d[l_ac].gldn028,g_gldn2_d[l_ac].gldn040, 
                      g_gldn2_d[l_ac].gldn041,g_gldn3_d[l_ac].gldn007,g_gldn3_d[l_ac].gldn008,g_gldn3_d[l_ac].gldn036, 
                      g_gldn3_d[l_ac].gldn030,g_gldn3_d[l_ac].gldn031,g_gldn3_d[l_ac].gldn040,g_gldn3_d[l_ac].gldn041 
 
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_gldn_d_t.gldn007,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_gldn_d_mask_o[l_ac].* =  g_gldn_d[l_ac].*
                  CALL aglq901_gldn_t_mask()
                  LET g_gldn_d_mask_n[l_ac].* =  g_gldn_d[l_ac].*
                  
                  CALL aglq901_ref_show()
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
            INITIALIZE g_gldn_d_t.* TO NULL
            INITIALIZE g_gldn_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_gldn_d[l_ac].* TO NULL
            #公用欄位預設值
              
            #一般欄位預設值
                  LET g_gldn_d[l_ac].gldn034 = "0"
      LET g_gldn_d[l_ac].gldn010 = "0"
      LET g_gldn_d[l_ac].gldn011 = "0"
      LET g_gldn_d[l_ac].l_gldn011 = "0"
 
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            
            #end add-point
            LET g_gldn_d_t.* = g_gldn_d[l_ac].*     #新輸入資料
            LET g_gldn_d_o.* = g_gldn_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aglq901_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL aglq901_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_gldn_d[li_reproduce_target].* = g_gldn_d[li_reproduce].*
               LET g_gldn2_d[li_reproduce_target].* = g_gldn2_d[li_reproduce].*
               LET g_gldn3_d[li_reproduce_target].* = g_gldn3_d[li_reproduce].*
 
               LET g_gldn_d[g_gldn_d.getLength()].gldn007 = NULL
               LET g_gldn_d[g_gldn_d.getLength()].gldn008 = NULL
               LET g_gldn_d[g_gldn_d.getLength()].gldn040 = NULL
               LET g_gldn_d[g_gldn_d.getLength()].gldn041 = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM gldn_t 
             WHERE gldnent = g_enterprise AND gldnld = g_gldn_m.gldnld
               AND gldn001 = g_gldn_m.gldn001
               AND gldn002 = g_gldn_m.gldn002
               AND gldn003 = g_gldn_m.gldn003
               AND gldn004 = g_gldn_m.gldn004
               AND gldn005 = g_gldn_m.gldn005
               AND gldn006 = g_gldn_m.gldn006
               AND gldn032 = g_gldn_m.gldn032
               AND gldn033 = g_gldn_m.gldn033
 
               AND gldn007 = g_gldn_d[l_ac].gldn007
               AND gldn008 = g_gldn_d[l_ac].gldn008
               AND gldn040 = g_gldn_d[l_ac].gldn040
               AND gldn041 = g_gldn_d[l_ac].gldn041
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
               INSERT INTO gldn_t
                           (gldnent,
                            gldnld,gldn001,gldn002,gldn005,gldn006,gldn009,gldn026,gldn029,gldn032,gldn003,gldn033,gldn004,
                            gldn007,gldn008,gldn040,gldn041
                            ,gldn014,gldn015,gldn016,gldn017,gldn018,gldn019,gldn020,gldn021,gldn037,gldn038,gldn039,gldn022,gldn024,gldn025,gldn034,gldn010,gldn011,gldn035,gldn027,gldn028,gldn036,gldn030,gldn031) 
                     VALUES(g_enterprise,
                            g_gldn_m.gldnld,g_gldn_m.gldn001,g_gldn_m.gldn002,g_gldn_m.gldn005,g_gldn_m.gldn006,g_gldn_m.gldn009,g_gldn_m.gldn026,g_gldn_m.gldn029,g_gldn_m.gldn032,g_gldn_m.gldn003,g_gldn_m.gldn033,g_gldn_m.gldn004,
                            g_gldn_d[l_ac].gldn007,g_gldn_d[l_ac].gldn008,g_gldn_d[l_ac].gldn040,g_gldn_d[l_ac].gldn041 
 
                            ,g_gldn_d[l_ac].gldn014,g_gldn_d[l_ac].gldn015,g_gldn_d[l_ac].gldn016,g_gldn_d[l_ac].gldn017, 
                                g_gldn_d[l_ac].gldn018,g_gldn_d[l_ac].gldn019,g_gldn_d[l_ac].gldn020, 
                                g_gldn_d[l_ac].gldn021,g_gldn_d[l_ac].gldn037,g_gldn_d[l_ac].gldn038, 
                                g_gldn_d[l_ac].gldn039,g_gldn_d[l_ac].gldn022,g_gldn_d[l_ac].gldn024, 
                                g_gldn_d[l_ac].gldn025,g_gldn_d[l_ac].gldn034,g_gldn_d[l_ac].gldn010, 
                                g_gldn_d[l_ac].gldn011,g_gldn2_d[l_ac].gldn035,g_gldn2_d[l_ac].gldn027, 
                                g_gldn2_d[l_ac].gldn028,g_gldn3_d[l_ac].gldn036,g_gldn3_d[l_ac].gldn030, 
                                g_gldn3_d[l_ac].gldn031)
               #add-point:單身新增中 name="input.body.m_insert"
               
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_gldn_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "gldn_t:",SQLERRMESSAGE 
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
               IF aglq901_before_delete() THEN 
                  
 
 
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_gldn_m.gldnld
                  LET gs_keys[gs_keys.getLength()+1] = g_gldn_m.gldn001
                  LET gs_keys[gs_keys.getLength()+1] = g_gldn_m.gldn002
                  LET gs_keys[gs_keys.getLength()+1] = g_gldn_m.gldn003
                  LET gs_keys[gs_keys.getLength()+1] = g_gldn_m.gldn004
                  LET gs_keys[gs_keys.getLength()+1] = g_gldn_m.gldn005
                  LET gs_keys[gs_keys.getLength()+1] = g_gldn_m.gldn006
                  LET gs_keys[gs_keys.getLength()+1] = g_gldn_m.gldn032
                  LET gs_keys[gs_keys.getLength()+1] = g_gldn_m.gldn033
 
                  LET gs_keys[gs_keys.getLength()+1] = g_gldn_d_t.gldn007
                  LET gs_keys[gs_keys.getLength()+1] = g_gldn_d_t.gldn008
                  LET gs_keys[gs_keys.getLength()+1] = g_gldn_d_t.gldn040
                  LET gs_keys[gs_keys.getLength()+1] = g_gldn_d_t.gldn041
 
 
                  #刪除下層單身
                  IF NOT aglq901_key_delete_b(gs_keys,'gldn_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE aglq901_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE aglq901_bcl
               LET l_count = g_gldn_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_gldn_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn007
            
            #add-point:AFTER FIELD gldn007 name="input.a.page1.gldn007"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_gldn_m.gldnld IS NOT NULL AND g_gldn_m.gldn001 IS NOT NULL AND g_gldn_m.gldn002 IS NOT NULL AND g_gldn_m.gldn003 IS NOT NULL AND g_gldn_m.gldn004 IS NOT NULL AND g_gldn_m.gldn005 IS NOT NULL AND g_gldn_m.gldn006 IS NOT NULL AND g_gldn_m.gldn032 IS NOT NULL AND g_gldn_m.gldn033 IS NOT NULL AND g_gldn_d[g_detail_idx].gldn007 IS NOT NULL AND g_gldn_d[g_detail_idx].gldn008 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gldn_m.gldnld != g_gldnld_t OR g_gldn_m.gldn001 != g_gldn001_t OR g_gldn_m.gldn002 != g_gldn002_t OR g_gldn_m.gldn003 != g_gldn003_t OR g_gldn_m.gldn004 != g_gldn004_t OR g_gldn_m.gldn005 != g_gldn005_t OR g_gldn_m.gldn006 != g_gldn006_t OR g_gldn_m.gldn032 != g_gldn032_t OR g_gldn_m.gldn033 != g_gldn033_t OR g_gldn_d[g_detail_idx].gldn007 != g_gldn_d_t.gldn007 OR g_gldn_d[g_detail_idx].gldn008 != g_gldn_d_t.gldn008)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gldn_t WHERE "||"gldnent = '" ||g_enterprise|| "' AND "||"gldnld = '"||g_gldn_m.gldnld ||"' AND "|| "gldn001 = '"||g_gldn_m.gldn001 ||"' AND "|| "gldn002 = '"||g_gldn_m.gldn002 ||"' AND "|| "gldn003 = '"||g_gldn_m.gldn003 ||"' AND "|| "gldn004 = '"||g_gldn_m.gldn004 ||"' AND "|| "gldn005 = '"||g_gldn_m.gldn005 ||"' AND "|| "gldn006 = '"||g_gldn_m.gldn006 ||"' AND "|| "gldn032 = '"||g_gldn_m.gldn032 ||"' AND "|| "gldn033 = '"||g_gldn_m.gldn033 ||"' AND "|| "gldn007 = '"||g_gldn_d[g_detail_idx].gldn007 ||"' AND "|| "gldn008 = '"||g_gldn_d[g_detail_idx].gldn008 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn007
            #add-point:BEFORE FIELD gldn007 name="input.b.page1.gldn007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldn007
            #add-point:ON CHANGE gldn007 name="input.g.page1.gldn007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn007_desc
            #add-point:BEFORE FIELD gldn007_desc name="input.b.page1.gldn007_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn007_desc
            
            #add-point:AFTER FIELD gldn007_desc name="input.a.page1.gldn007_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldn007_desc
            #add-point:ON CHANGE gldn007_desc name="input.g.page1.gldn007_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn008
            #add-point:BEFORE FIELD gldn008 name="input.b.page1.gldn008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn008
            
            #add-point:AFTER FIELD gldn008 name="input.a.page1.gldn008"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_gldn_m.gldnld IS NOT NULL AND g_gldn_m.gldn001 IS NOT NULL AND g_gldn_m.gldn002 IS NOT NULL AND g_gldn_m.gldn003 IS NOT NULL AND g_gldn_m.gldn004 IS NOT NULL AND g_gldn_m.gldn005 IS NOT NULL AND g_gldn_m.gldn006 IS NOT NULL AND g_gldn_m.gldn032 IS NOT NULL AND g_gldn_m.gldn033 IS NOT NULL AND g_gldn_d[g_detail_idx].gldn007 IS NOT NULL AND g_gldn_d[g_detail_idx].gldn008 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gldn_m.gldnld != g_gldnld_t OR g_gldn_m.gldn001 != g_gldn001_t OR g_gldn_m.gldn002 != g_gldn002_t OR g_gldn_m.gldn003 != g_gldn003_t OR g_gldn_m.gldn004 != g_gldn004_t OR g_gldn_m.gldn005 != g_gldn005_t OR g_gldn_m.gldn006 != g_gldn006_t OR g_gldn_m.gldn032 != g_gldn032_t OR g_gldn_m.gldn033 != g_gldn033_t OR g_gldn_d[g_detail_idx].gldn007 != g_gldn_d_t.gldn007 OR g_gldn_d[g_detail_idx].gldn008 != g_gldn_d_t.gldn008)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gldn_t WHERE "||"gldnent = '" ||g_enterprise|| "' AND "||"gldnld = '"||g_gldn_m.gldnld ||"' AND "|| "gldn001 = '"||g_gldn_m.gldn001 ||"' AND "|| "gldn002 = '"||g_gldn_m.gldn002 ||"' AND "|| "gldn003 = '"||g_gldn_m.gldn003 ||"' AND "|| "gldn004 = '"||g_gldn_m.gldn004 ||"' AND "|| "gldn005 = '"||g_gldn_m.gldn005 ||"' AND "|| "gldn006 = '"||g_gldn_m.gldn006 ||"' AND "|| "gldn032 = '"||g_gldn_m.gldn032 ||"' AND "|| "gldn033 = '"||g_gldn_m.gldn033 ||"' AND "|| "gldn007 = '"||g_gldn_d[g_detail_idx].gldn007 ||"' AND "|| "gldn008 = '"||g_gldn_d[g_detail_idx].gldn008 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldn008
            #add-point:ON CHANGE gldn008 name="input.g.page1.gldn008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn014
            
            #add-point:AFTER FIELD gldn014 name="input.a.page1.gldn014"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn014
            #add-point:BEFORE FIELD gldn014 name="input.b.page1.gldn014"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldn014
            #add-point:ON CHANGE gldn014 name="input.g.page1.gldn014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn014_desc
            #add-point:BEFORE FIELD gldn014_desc name="input.b.page1.gldn014_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn014_desc
            
            #add-point:AFTER FIELD gldn014_desc name="input.a.page1.gldn014_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldn014_desc
            #add-point:ON CHANGE gldn014_desc name="input.g.page1.gldn014_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn015
            
            #add-point:AFTER FIELD gldn015 name="input.a.page1.gldn015"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn015
            #add-point:BEFORE FIELD gldn015 name="input.b.page1.gldn015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldn015
            #add-point:ON CHANGE gldn015 name="input.g.page1.gldn015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn015_desc
            #add-point:BEFORE FIELD gldn015_desc name="input.b.page1.gldn015_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn015_desc
            
            #add-point:AFTER FIELD gldn015_desc name="input.a.page1.gldn015_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldn015_desc
            #add-point:ON CHANGE gldn015_desc name="input.g.page1.gldn015_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn016
            
            #add-point:AFTER FIELD gldn016 name="input.a.page1.gldn016"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn016
            #add-point:BEFORE FIELD gldn016 name="input.b.page1.gldn016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldn016
            #add-point:ON CHANGE gldn016 name="input.g.page1.gldn016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn016_desc
            #add-point:BEFORE FIELD gldn016_desc name="input.b.page1.gldn016_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn016_desc
            
            #add-point:AFTER FIELD gldn016_desc name="input.a.page1.gldn016_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldn016_desc
            #add-point:ON CHANGE gldn016_desc name="input.g.page1.gldn016_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn017
            
            #add-point:AFTER FIELD gldn017 name="input.a.page1.gldn017"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn017
            #add-point:BEFORE FIELD gldn017 name="input.b.page1.gldn017"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldn017
            #add-point:ON CHANGE gldn017 name="input.g.page1.gldn017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn017_desc
            #add-point:BEFORE FIELD gldn017_desc name="input.b.page1.gldn017_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn017_desc
            
            #add-point:AFTER FIELD gldn017_desc name="input.a.page1.gldn017_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldn017_desc
            #add-point:ON CHANGE gldn017_desc name="input.g.page1.gldn017_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn018
            
            #add-point:AFTER FIELD gldn018 name="input.a.page1.gldn018"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn018
            #add-point:BEFORE FIELD gldn018 name="input.b.page1.gldn018"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldn018
            #add-point:ON CHANGE gldn018 name="input.g.page1.gldn018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn018_desc
            #add-point:BEFORE FIELD gldn018_desc name="input.b.page1.gldn018_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn018_desc
            
            #add-point:AFTER FIELD gldn018_desc name="input.a.page1.gldn018_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldn018_desc
            #add-point:ON CHANGE gldn018_desc name="input.g.page1.gldn018_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn019
            
            #add-point:AFTER FIELD gldn019 name="input.a.page1.gldn019"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn019
            #add-point:BEFORE FIELD gldn019 name="input.b.page1.gldn019"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldn019
            #add-point:ON CHANGE gldn019 name="input.g.page1.gldn019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn019_desc
            #add-point:BEFORE FIELD gldn019_desc name="input.b.page1.gldn019_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn019_desc
            
            #add-point:AFTER FIELD gldn019_desc name="input.a.page1.gldn019_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldn019_desc
            #add-point:ON CHANGE gldn019_desc name="input.g.page1.gldn019_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn020
            
            #add-point:AFTER FIELD gldn020 name="input.a.page1.gldn020"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn020
            #add-point:BEFORE FIELD gldn020 name="input.b.page1.gldn020"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldn020
            #add-point:ON CHANGE gldn020 name="input.g.page1.gldn020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn020_desc
            #add-point:BEFORE FIELD gldn020_desc name="input.b.page1.gldn020_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn020_desc
            
            #add-point:AFTER FIELD gldn020_desc name="input.a.page1.gldn020_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldn020_desc
            #add-point:ON CHANGE gldn020_desc name="input.g.page1.gldn020_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn021
            
            #add-point:AFTER FIELD gldn021 name="input.a.page1.gldn021"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn021
            #add-point:BEFORE FIELD gldn021 name="input.b.page1.gldn021"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldn021
            #add-point:ON CHANGE gldn021 name="input.g.page1.gldn021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn021_desc
            #add-point:BEFORE FIELD gldn021_desc name="input.b.page1.gldn021_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn021_desc
            
            #add-point:AFTER FIELD gldn021_desc name="input.a.page1.gldn021_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldn021_desc
            #add-point:ON CHANGE gldn021_desc name="input.g.page1.gldn021_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn037
            #add-point:BEFORE FIELD gldn037 name="input.b.page1.gldn037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn037
            
            #add-point:AFTER FIELD gldn037 name="input.a.page1.gldn037"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldn037
            #add-point:ON CHANGE gldn037 name="input.g.page1.gldn037"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn038
            
            #add-point:AFTER FIELD gldn038 name="input.a.page1.gldn038"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn038
            #add-point:BEFORE FIELD gldn038 name="input.b.page1.gldn038"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldn038
            #add-point:ON CHANGE gldn038 name="input.g.page1.gldn038"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn038_desc
            #add-point:BEFORE FIELD gldn038_desc name="input.b.page1.gldn038_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn038_desc
            
            #add-point:AFTER FIELD gldn038_desc name="input.a.page1.gldn038_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldn038_desc
            #add-point:ON CHANGE gldn038_desc name="input.g.page1.gldn038_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn039
            
            #add-point:AFTER FIELD gldn039 name="input.a.page1.gldn039"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn039
            #add-point:BEFORE FIELD gldn039 name="input.b.page1.gldn039"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldn039
            #add-point:ON CHANGE gldn039 name="input.g.page1.gldn039"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn039_desc
            #add-point:BEFORE FIELD gldn039_desc name="input.b.page1.gldn039_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn039_desc
            
            #add-point:AFTER FIELD gldn039_desc name="input.a.page1.gldn039_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldn039_desc
            #add-point:ON CHANGE gldn039_desc name="input.g.page1.gldn039_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn022
            
            #add-point:AFTER FIELD gldn022 name="input.a.page1.gldn022"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn022
            #add-point:BEFORE FIELD gldn022 name="input.b.page1.gldn022"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldn022
            #add-point:ON CHANGE gldn022 name="input.g.page1.gldn022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn022_desc
            #add-point:BEFORE FIELD gldn022_desc name="input.b.page1.gldn022_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn022_desc
            
            #add-point:AFTER FIELD gldn022_desc name="input.a.page1.gldn022_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldn022_desc
            #add-point:ON CHANGE gldn022_desc name="input.g.page1.gldn022_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn024
            
            #add-point:AFTER FIELD gldn024 name="input.a.page1.gldn024"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn024
            #add-point:BEFORE FIELD gldn024 name="input.b.page1.gldn024"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldn024
            #add-point:ON CHANGE gldn024 name="input.g.page1.gldn024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn024_desc
            #add-point:BEFORE FIELD gldn024_desc name="input.b.page1.gldn024_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn024_desc
            
            #add-point:AFTER FIELD gldn024_desc name="input.a.page1.gldn024_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldn024_desc
            #add-point:ON CHANGE gldn024_desc name="input.g.page1.gldn024_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn025
            
            #add-point:AFTER FIELD gldn025 name="input.a.page1.gldn025"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn025
            #add-point:BEFORE FIELD gldn025 name="input.b.page1.gldn025"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldn025
            #add-point:ON CHANGE gldn025 name="input.g.page1.gldn025"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn025_desc
            #add-point:BEFORE FIELD gldn025_desc name="input.b.page1.gldn025_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn025_desc
            
            #add-point:AFTER FIELD gldn025_desc name="input.a.page1.gldn025_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldn025_desc
            #add-point:ON CHANGE gldn025_desc name="input.g.page1.gldn025_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn034
            #add-point:BEFORE FIELD gldn034 name="input.b.page1.gldn034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn034
            
            #add-point:AFTER FIELD gldn034 name="input.a.page1.gldn034"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldn034
            #add-point:ON CHANGE gldn034 name="input.g.page1.gldn034"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn010
            #add-point:BEFORE FIELD gldn010 name="input.b.page1.gldn010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn010
            
            #add-point:AFTER FIELD gldn010 name="input.a.page1.gldn010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldn010
            #add-point:ON CHANGE gldn010 name="input.g.page1.gldn010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn011
            #add-point:BEFORE FIELD gldn011 name="input.b.page1.gldn011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn011
            
            #add-point:AFTER FIELD gldn011 name="input.a.page1.gldn011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldn011
            #add-point:ON CHANGE gldn011 name="input.g.page1.gldn011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldn011
            #add-point:BEFORE FIELD l_gldn011 name="input.b.page1.l_gldn011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldn011
            
            #add-point:AFTER FIELD l_gldn011 name="input.a.page1.l_gldn011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldn011
            #add-point:ON CHANGE l_gldn011 name="input.g.page1.l_gldn011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn040
            #add-point:BEFORE FIELD gldn040 name="input.b.page1.gldn040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn040
            
            #add-point:AFTER FIELD gldn040 name="input.a.page1.gldn040"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_gldn_m.gldnld IS NOT NULL AND g_gldn_m.gldn001 IS NOT NULL AND g_gldn_m.gldn002 IS NOT NULL AND g_gldn_m.gldn003 IS NOT NULL AND g_gldn_m.gldn004 IS NOT NULL AND g_gldn_m.gldn005 IS NOT NULL AND g_gldn_m.gldn006 IS NOT NULL AND g_gldn_m.gldn032 IS NOT NULL AND g_gldn_m.gldn033 IS NOT NULL AND g_gldn_d[g_detail_idx].gldn007 IS NOT NULL AND g_gldn_d[g_detail_idx].gldn008 IS NOT NULL AND g_gldn_d[g_detail_idx].gldn040 IS NOT NULL AND g_gldn_d[g_detail_idx].gldn041 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gldn_m.gldnld != g_gldnld_t OR g_gldn_m.gldn001 != g_gldn001_t OR g_gldn_m.gldn002 != g_gldn002_t OR g_gldn_m.gldn003 != g_gldn003_t OR g_gldn_m.gldn004 != g_gldn004_t OR g_gldn_m.gldn005 != g_gldn005_t OR g_gldn_m.gldn006 != g_gldn006_t OR g_gldn_m.gldn032 != g_gldn032_t OR g_gldn_m.gldn033 != g_gldn033_t OR g_gldn_d[g_detail_idx].gldn007 != g_gldn_d_t.gldn007 OR g_gldn_d[g_detail_idx].gldn008 != g_gldn_d_t.gldn008 OR g_gldn_d[g_detail_idx].gldn040 != g_gldn_d_t.gldn040 OR g_gldn_d[g_detail_idx].gldn041 != g_gldn_d_t.gldn041)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gldn_t WHERE "||"gldnent = '" ||g_enterprise|| "' AND "||"gldnld = '"||g_gldn_m.gldnld ||"' AND "|| "gldn001 = '"||g_gldn_m.gldn001 ||"' AND "|| "gldn002 = '"||g_gldn_m.gldn002 ||"' AND "|| "gldn003 = '"||g_gldn_m.gldn003 ||"' AND "|| "gldn004 = '"||g_gldn_m.gldn004 ||"' AND "|| "gldn005 = '"||g_gldn_m.gldn005 ||"' AND "|| "gldn006 = '"||g_gldn_m.gldn006 ||"' AND "|| "gldn032 = '"||g_gldn_m.gldn032 ||"' AND "|| "gldn033 = '"||g_gldn_m.gldn033 ||"' AND "|| "gldn007 = '"||g_gldn_d[g_detail_idx].gldn007 ||"' AND "|| "gldn008 = '"||g_gldn_d[g_detail_idx].gldn008 ||"' AND "|| "gldn040 = '"||g_gldn_d[g_detail_idx].gldn040 ||"' AND "|| "gldn041 = '"||g_gldn_d[g_detail_idx].gldn041 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldn040
            #add-point:ON CHANGE gldn040 name="input.g.page1.gldn040"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn041
            #add-point:BEFORE FIELD gldn041 name="input.b.page1.gldn041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn041
            
            #add-point:AFTER FIELD gldn041 name="input.a.page1.gldn041"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_gldn_m.gldnld IS NOT NULL AND g_gldn_m.gldn001 IS NOT NULL AND g_gldn_m.gldn002 IS NOT NULL AND g_gldn_m.gldn003 IS NOT NULL AND g_gldn_m.gldn004 IS NOT NULL AND g_gldn_m.gldn005 IS NOT NULL AND g_gldn_m.gldn006 IS NOT NULL AND g_gldn_m.gldn032 IS NOT NULL AND g_gldn_m.gldn033 IS NOT NULL AND g_gldn_d[g_detail_idx].gldn007 IS NOT NULL AND g_gldn_d[g_detail_idx].gldn008 IS NOT NULL AND g_gldn_d[g_detail_idx].gldn040 IS NOT NULL AND g_gldn_d[g_detail_idx].gldn041 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gldn_m.gldnld != g_gldnld_t OR g_gldn_m.gldn001 != g_gldn001_t OR g_gldn_m.gldn002 != g_gldn002_t OR g_gldn_m.gldn003 != g_gldn003_t OR g_gldn_m.gldn004 != g_gldn004_t OR g_gldn_m.gldn005 != g_gldn005_t OR g_gldn_m.gldn006 != g_gldn006_t OR g_gldn_m.gldn032 != g_gldn032_t OR g_gldn_m.gldn033 != g_gldn033_t OR g_gldn_d[g_detail_idx].gldn007 != g_gldn_d_t.gldn007 OR g_gldn_d[g_detail_idx].gldn008 != g_gldn_d_t.gldn008 OR g_gldn_d[g_detail_idx].gldn040 != g_gldn_d_t.gldn040 OR g_gldn_d[g_detail_idx].gldn041 != g_gldn_d_t.gldn041)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gldn_t WHERE "||"gldnent = '" ||g_enterprise|| "' AND "||"gldnld = '"||g_gldn_m.gldnld ||"' AND "|| "gldn001 = '"||g_gldn_m.gldn001 ||"' AND "|| "gldn002 = '"||g_gldn_m.gldn002 ||"' AND "|| "gldn003 = '"||g_gldn_m.gldn003 ||"' AND "|| "gldn004 = '"||g_gldn_m.gldn004 ||"' AND "|| "gldn005 = '"||g_gldn_m.gldn005 ||"' AND "|| "gldn006 = '"||g_gldn_m.gldn006 ||"' AND "|| "gldn032 = '"||g_gldn_m.gldn032 ||"' AND "|| "gldn033 = '"||g_gldn_m.gldn033 ||"' AND "|| "gldn007 = '"||g_gldn_d[g_detail_idx].gldn007 ||"' AND "|| "gldn008 = '"||g_gldn_d[g_detail_idx].gldn008 ||"' AND "|| "gldn040 = '"||g_gldn_d[g_detail_idx].gldn040 ||"' AND "|| "gldn041 = '"||g_gldn_d[g_detail_idx].gldn041 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldn041
            #add-point:ON CHANGE gldn041 name="input.g.page1.gldn041"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.gldn007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn007
            #add-point:ON ACTION controlp INFIELD gldn007 name="input.c.page1.gldn007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldn007_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn007_desc
            #add-point:ON ACTION controlp INFIELD gldn007_desc name="input.c.page1.gldn007_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldn008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn008
            #add-point:ON ACTION controlp INFIELD gldn008 name="input.c.page1.gldn008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldn014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn014
            #add-point:ON ACTION controlp INFIELD gldn014 name="input.c.page1.gldn014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldn014_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn014_desc
            #add-point:ON ACTION controlp INFIELD gldn014_desc name="input.c.page1.gldn014_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldn015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn015
            #add-point:ON ACTION controlp INFIELD gldn015 name="input.c.page1.gldn015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldn015_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn015_desc
            #add-point:ON ACTION controlp INFIELD gldn015_desc name="input.c.page1.gldn015_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldn016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn016
            #add-point:ON ACTION controlp INFIELD gldn016 name="input.c.page1.gldn016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldn016_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn016_desc
            #add-point:ON ACTION controlp INFIELD gldn016_desc name="input.c.page1.gldn016_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldn017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn017
            #add-point:ON ACTION controlp INFIELD gldn017 name="input.c.page1.gldn017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldn017_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn017_desc
            #add-point:ON ACTION controlp INFIELD gldn017_desc name="input.c.page1.gldn017_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldn018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn018
            #add-point:ON ACTION controlp INFIELD gldn018 name="input.c.page1.gldn018"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldn018_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn018_desc
            #add-point:ON ACTION controlp INFIELD gldn018_desc name="input.c.page1.gldn018_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldn019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn019
            #add-point:ON ACTION controlp INFIELD gldn019 name="input.c.page1.gldn019"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldn019_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn019_desc
            #add-point:ON ACTION controlp INFIELD gldn019_desc name="input.c.page1.gldn019_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldn020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn020
            #add-point:ON ACTION controlp INFIELD gldn020 name="input.c.page1.gldn020"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldn020_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn020_desc
            #add-point:ON ACTION controlp INFIELD gldn020_desc name="input.c.page1.gldn020_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldn021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn021
            #add-point:ON ACTION controlp INFIELD gldn021 name="input.c.page1.gldn021"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldn021_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn021_desc
            #add-point:ON ACTION controlp INFIELD gldn021_desc name="input.c.page1.gldn021_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldn037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn037
            #add-point:ON ACTION controlp INFIELD gldn037 name="input.c.page1.gldn037"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldn038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn038
            #add-point:ON ACTION controlp INFIELD gldn038 name="input.c.page1.gldn038"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldn038_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn038_desc
            #add-point:ON ACTION controlp INFIELD gldn038_desc name="input.c.page1.gldn038_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldn039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn039
            #add-point:ON ACTION controlp INFIELD gldn039 name="input.c.page1.gldn039"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldn039_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn039_desc
            #add-point:ON ACTION controlp INFIELD gldn039_desc name="input.c.page1.gldn039_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldn022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn022
            #add-point:ON ACTION controlp INFIELD gldn022 name="input.c.page1.gldn022"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldn022_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn022_desc
            #add-point:ON ACTION controlp INFIELD gldn022_desc name="input.c.page1.gldn022_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldn024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn024
            #add-point:ON ACTION controlp INFIELD gldn024 name="input.c.page1.gldn024"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldn024_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn024_desc
            #add-point:ON ACTION controlp INFIELD gldn024_desc name="input.c.page1.gldn024_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldn025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn025
            #add-point:ON ACTION controlp INFIELD gldn025 name="input.c.page1.gldn025"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldn025_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn025_desc
            #add-point:ON ACTION controlp INFIELD gldn025_desc name="input.c.page1.gldn025_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldn034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn034
            #add-point:ON ACTION controlp INFIELD gldn034 name="input.c.page1.gldn034"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldn010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn010
            #add-point:ON ACTION controlp INFIELD gldn010 name="input.c.page1.gldn010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldn011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn011
            #add-point:ON ACTION controlp INFIELD gldn011 name="input.c.page1.gldn011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_gldn011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldn011
            #add-point:ON ACTION controlp INFIELD l_gldn011 name="input.c.page1.l_gldn011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldn040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn040
            #add-point:ON ACTION controlp INFIELD gldn040 name="input.c.page1.gldn040"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldn041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn041
            #add-point:ON ACTION controlp INFIELD gldn041 name="input.c.page1.gldn041"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_gldn_d[l_ac].* = g_gldn_d_t.*
               CLOSE aglq901_bcl
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
               LET g_errparam.extend = g_gldn_d[l_ac].gldn007 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_gldn_d[l_ac].* = g_gldn_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
         
               #將遮罩欄位還原
               CALL aglq901_gldn_t_mask_restore('restore_mask_o')
         
               UPDATE gldn_t SET (gldnld,gldn001,gldn002,gldn003,gldn004,gldn005,gldn006,gldn032,gldn033, 
                   gldn007,gldn008,gldn014,gldn015,gldn016,gldn017,gldn018,gldn019,gldn020,gldn021,gldn037, 
                   gldn038,gldn039,gldn022,gldn024,gldn025,gldn034,gldn010,gldn011,gldn040,gldn041,gldn035, 
                   gldn027,gldn028,gldn036,gldn030,gldn031) = (g_gldn_m.gldnld,g_gldn_m.gldn001,g_gldn_m.gldn002, 
                   g_gldn_m.gldn003,g_gldn_m.gldn004,g_gldn_m.gldn005,g_gldn_m.gldn006,g_gldn_m.gldn032, 
                   g_gldn_m.gldn033,g_gldn_d[l_ac].gldn007,g_gldn_d[l_ac].gldn008,g_gldn_d[l_ac].gldn014, 
                   g_gldn_d[l_ac].gldn015,g_gldn_d[l_ac].gldn016,g_gldn_d[l_ac].gldn017,g_gldn_d[l_ac].gldn018, 
                   g_gldn_d[l_ac].gldn019,g_gldn_d[l_ac].gldn020,g_gldn_d[l_ac].gldn021,g_gldn_d[l_ac].gldn037, 
                   g_gldn_d[l_ac].gldn038,g_gldn_d[l_ac].gldn039,g_gldn_d[l_ac].gldn022,g_gldn_d[l_ac].gldn024, 
                   g_gldn_d[l_ac].gldn025,g_gldn_d[l_ac].gldn034,g_gldn_d[l_ac].gldn010,g_gldn_d[l_ac].gldn011, 
                   g_gldn_d[l_ac].gldn040,g_gldn_d[l_ac].gldn041,g_gldn2_d[l_ac].gldn035,g_gldn2_d[l_ac].gldn027, 
                   g_gldn2_d[l_ac].gldn028,g_gldn3_d[l_ac].gldn036,g_gldn3_d[l_ac].gldn030,g_gldn3_d[l_ac].gldn031) 
 
                WHERE gldnent = g_enterprise AND gldnld = g_gldn_m.gldnld 
                 AND gldn001 = g_gldn_m.gldn001 
                 AND gldn002 = g_gldn_m.gldn002 
                 AND gldn003 = g_gldn_m.gldn003 
                 AND gldn004 = g_gldn_m.gldn004 
                 AND gldn005 = g_gldn_m.gldn005 
                 AND gldn006 = g_gldn_m.gldn006 
                 AND gldn032 = g_gldn_m.gldn032 
                 AND gldn033 = g_gldn_m.gldn033 
 
                 AND gldn007 = g_gldn_d_t.gldn007 #項次   
                 AND gldn008 = g_gldn_d_t.gldn008  
                 AND gldn040 = g_gldn_d_t.gldn040  
                 AND gldn041 = g_gldn_d_t.gldn041  
 
                 
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gldn_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "gldn_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gldn_m.gldnld
               LET gs_keys_bak[1] = g_gldnld_t
               LET gs_keys[2] = g_gldn_m.gldn001
               LET gs_keys_bak[2] = g_gldn001_t
               LET gs_keys[3] = g_gldn_m.gldn002
               LET gs_keys_bak[3] = g_gldn002_t
               LET gs_keys[4] = g_gldn_m.gldn003
               LET gs_keys_bak[4] = g_gldn003_t
               LET gs_keys[5] = g_gldn_m.gldn004
               LET gs_keys_bak[5] = g_gldn004_t
               LET gs_keys[6] = g_gldn_m.gldn005
               LET gs_keys_bak[6] = g_gldn005_t
               LET gs_keys[7] = g_gldn_m.gldn006
               LET gs_keys_bak[7] = g_gldn006_t
               LET gs_keys[8] = g_gldn_m.gldn032
               LET gs_keys_bak[8] = g_gldn032_t
               LET gs_keys[9] = g_gldn_m.gldn033
               LET gs_keys_bak[9] = g_gldn033_t
               LET gs_keys[10] = g_gldn_d[g_detail_idx].gldn007
               LET gs_keys_bak[10] = g_gldn_d_t.gldn007
               LET gs_keys[11] = g_gldn_d[g_detail_idx].gldn008
               LET gs_keys_bak[11] = g_gldn_d_t.gldn008
               LET gs_keys[12] = g_gldn_d[g_detail_idx].gldn040
               LET gs_keys_bak[12] = g_gldn_d_t.gldn040
               LET gs_keys[13] = g_gldn_d[g_detail_idx].gldn041
               LET gs_keys_bak[13] = g_gldn_d_t.gldn041
               CALL aglq901_update_b('gldn_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_gldn_m),util.JSON.stringify(g_gldn_d_t)
                     LET g_log2 = util.JSON.stringify(g_gldn_m),util.JSON.stringify(g_gldn_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aglq901_gldn_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_gldn_m.gldnld
               LET ls_keys[ls_keys.getLength()+1] = g_gldn_m.gldn001
               LET ls_keys[ls_keys.getLength()+1] = g_gldn_m.gldn002
               LET ls_keys[ls_keys.getLength()+1] = g_gldn_m.gldn003
               LET ls_keys[ls_keys.getLength()+1] = g_gldn_m.gldn004
               LET ls_keys[ls_keys.getLength()+1] = g_gldn_m.gldn005
               LET ls_keys[ls_keys.getLength()+1] = g_gldn_m.gldn006
               LET ls_keys[ls_keys.getLength()+1] = g_gldn_m.gldn032
               LET ls_keys[ls_keys.getLength()+1] = g_gldn_m.gldn033
 
               LET ls_keys[ls_keys.getLength()+1] = g_gldn_d_t.gldn007
               LET ls_keys[ls_keys.getLength()+1] = g_gldn_d_t.gldn008
               LET ls_keys[ls_keys.getLength()+1] = g_gldn_d_t.gldn040
               LET ls_keys[ls_keys.getLength()+1] = g_gldn_d_t.gldn041
 
               CALL aglq901_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE aglq901_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_gldn_d[l_ac].* = g_gldn_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE aglq901_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_gldn_d.getLength() = 0 THEN
               NEXT FIELD gldn007
            END IF
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_gldn_d[li_reproduce_target].* = g_gldn_d[li_reproduce].*
               LET g_gldn2_d[li_reproduce_target].* = g_gldn2_d[li_reproduce].*
               LET g_gldn3_d[li_reproduce_target].* = g_gldn3_d[li_reproduce].*
 
               LET g_gldn_d[li_reproduce_target].gldn007 = NULL
               LET g_gldn_d[li_reproduce_target].gldn008 = NULL
               LET g_gldn_d[li_reproduce_target].gldn040 = NULL
               LET g_gldn_d[li_reproduce_target].gldn041 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_gldn_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_gldn_d.getLength()+1
            END IF
            
      END INPUT
 
      INPUT ARRAY g_gldn2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b, WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                   INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                   DELETE ROW = l_allow_delete,
                   APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
                 
         BEFORE INPUT
            
            CALL aglq901_b_fill(g_wc2) #test 
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
            CALL aglq901_idx_chk()
            
            CALL s_transaction_begin()
            IF g_rec_b >= l_ac THEN
               LET l_cmd='u'
               CALL aglq901_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body2.before_row.set_entry_b"
               
               #end add-point
               CALL aglq901_set_no_entry_b(l_cmd)
               LET g_gldn2_d_t.* = g_gldn2_d[l_ac].*   #BACKUP  #page1
               LET g_gldn2_d_o.* = g_gldn2_d[l_ac].*   #BACKUP  #page1
            END IF 
            
 
 
 
    
         BEFORE INSERT
            LET g_insert = 'Y' 
            NEXT FIELD gldn007
 
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            INITIALIZE g_gldn2_d_t.* TO NULL
            INITIALIZE g_gldn2_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_gldn2_d[l_ac].* TO NULL
            #公用欄位預設值
              
            #一般欄位預設值
                  LET g_gldn2_d[l_ac].gldn035 = "0"
      LET g_gldn2_d[l_ac].gldn027 = "0"
      LET g_gldn2_d[l_ac].gldn028 = "0"
      LET g_gldn2_d[l_ac].l_gldn028 = "0"
 
            
            #add-point:modify段before備份 name="input.body2.before_insert.before_bak"
            
            #end add-point
            LET g_gldn2_d_t.* = g_gldn2_d[l_ac].*     #新輸入資料
            LET g_gldn2_d_o.* = g_gldn2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aglq901_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body2.before_insert.set_entry_b"
            
            #end add-point
            CALL aglq901_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_gldn_d[li_reproduce_target].* = g_gldn_d[li_reproduce].*
               LET g_gldn2_d[li_reproduce_target].* = g_gldn2_d[li_reproduce].*
               LET g_gldn3_d[li_reproduce_target].* = g_gldn3_d[li_reproduce].*
 
               LET g_gldn2_d[li_reproduce_target].gldn007 = NULL
               LET g_gldn2_d[li_reproduce_target].gldn008 = NULL
               LET g_gldn2_d[li_reproduce_target].gldn040 = NULL
               LET g_gldn2_d[li_reproduce_target].gldn041 = NULL
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
               IF aglq901_before_delete() THEN 
                  
 
 
 
  
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_gldn_m.gldnld
                  LET gs_keys[gs_keys.getLength()+1] = g_gldn_m.gldn001
                  LET gs_keys[gs_keys.getLength()+1] = g_gldn_m.gldn002
                  LET gs_keys[gs_keys.getLength()+1] = g_gldn_m.gldn003
                  LET gs_keys[gs_keys.getLength()+1] = g_gldn_m.gldn004
                  LET gs_keys[gs_keys.getLength()+1] = g_gldn_m.gldn005
                  LET gs_keys[gs_keys.getLength()+1] = g_gldn_m.gldn006
                  LET gs_keys[gs_keys.getLength()+1] = g_gldn_m.gldn032
                  LET gs_keys[gs_keys.getLength()+1] = g_gldn_m.gldn033
                  LET gs_keys[gs_keys.getLength()+1] = g_gldn_d_t.gldn007
                  LET gs_keys[gs_keys.getLength()+1] = g_gldn_d_t.gldn008
                  LET gs_keys[gs_keys.getLength()+1] = g_gldn_d_t.gldn040
                  LET gs_keys[gs_keys.getLength()+1] = g_gldn_d_t.gldn041
 
                  #刪除下層單身
                  IF NOT aglq901_key_delete_b(gs_keys,'gldn_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE aglq901_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE aglq901_bcl
               CALL s_transaction_end('Y','0') 
               LET l_count = g_gldn2_d.getLength()
            END IF
            
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body2.after_delete"
               
               #end add-point
                              CALL aglq901_delete_b('gldn_t',gs_keys,"'2'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_gldn2_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_gldn2_d[l_ac].* = g_gldn2_d_t.*
               CLOSE aglq901_bcl
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
               LET g_errparam.extend = g_gldn_d[l_ac].gldn007 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_gldn2_d[l_ac].* = g_gldn2_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               
                
               #add-point:單身修改前 name="modify.body2.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL aglq901_gldn_t_mask_restore('restore_mask_o')
                     
               UPDATE gldn_t SET (gldnld,gldn001,gldn002,gldn003,gldn004,gldn005,gldn006,gldn032,gldn033, 
                   gldn007,gldn008,gldn014,gldn015,gldn016,gldn017,gldn018,gldn019,gldn020,gldn021,gldn037, 
                   gldn038,gldn039,gldn022,gldn024,gldn025,gldn034,gldn010,gldn011,gldn040,gldn041,gldn035, 
                   gldn027,gldn028,gldn036,gldn030,gldn031) = (g_gldn_m.gldnld,g_gldn_m.gldn001,g_gldn_m.gldn002, 
                   g_gldn_m.gldn003,g_gldn_m.gldn004,g_gldn_m.gldn005,g_gldn_m.gldn006,g_gldn_m.gldn032, 
                   g_gldn_m.gldn033,g_gldn_d[l_ac].gldn007,g_gldn_d[l_ac].gldn008,g_gldn_d[l_ac].gldn014, 
                   g_gldn_d[l_ac].gldn015,g_gldn_d[l_ac].gldn016,g_gldn_d[l_ac].gldn017,g_gldn_d[l_ac].gldn018, 
                   g_gldn_d[l_ac].gldn019,g_gldn_d[l_ac].gldn020,g_gldn_d[l_ac].gldn021,g_gldn_d[l_ac].gldn037, 
                   g_gldn_d[l_ac].gldn038,g_gldn_d[l_ac].gldn039,g_gldn_d[l_ac].gldn022,g_gldn_d[l_ac].gldn024, 
                   g_gldn_d[l_ac].gldn025,g_gldn_d[l_ac].gldn034,g_gldn_d[l_ac].gldn010,g_gldn_d[l_ac].gldn011, 
                   g_gldn_d[l_ac].gldn040,g_gldn_d[l_ac].gldn041,g_gldn2_d[l_ac].gldn035,g_gldn2_d[l_ac].gldn027, 
                   g_gldn2_d[l_ac].gldn028,g_gldn3_d[l_ac].gldn036,g_gldn3_d[l_ac].gldn030,g_gldn3_d[l_ac].gldn031)  
                   #自訂欄位頁簽
                WHERE gldnent = g_enterprise AND gldnld = g_gldn_m.gldnld
                 AND gldn001 = g_gldn_m.gldn001
                 AND gldn002 = g_gldn_m.gldn002
                 AND gldn003 = g_gldn_m.gldn003
                 AND gldn004 = g_gldn_m.gldn004
                 AND gldn005 = g_gldn_m.gldn005
                 AND gldn006 = g_gldn_m.gldn006
                 AND gldn032 = g_gldn_m.gldn032
                 AND gldn033 = g_gldn_m.gldn033
                 AND gldn007 = g_gldn2_d_t.gldn007 #項次 
                 AND gldn008 = g_gldn2_d_t.gldn008
                 AND gldn040 = g_gldn2_d_t.gldn040
                 AND gldn041 = g_gldn2_d_t.gldn041
               #add-point:單身修改中 name="modify.body2.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gldn_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gldn_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gldn_m.gldnld
               LET gs_keys_bak[1] = g_gldnld_t
               LET gs_keys[2] = g_gldn_m.gldn001
               LET gs_keys_bak[2] = g_gldn001_t
               LET gs_keys[3] = g_gldn_m.gldn002
               LET gs_keys_bak[3] = g_gldn002_t
               LET gs_keys[4] = g_gldn_m.gldn003
               LET gs_keys_bak[4] = g_gldn003_t
               LET gs_keys[5] = g_gldn_m.gldn004
               LET gs_keys_bak[5] = g_gldn004_t
               LET gs_keys[6] = g_gldn_m.gldn005
               LET gs_keys_bak[6] = g_gldn005_t
               LET gs_keys[7] = g_gldn_m.gldn006
               LET gs_keys_bak[7] = g_gldn006_t
               LET gs_keys[8] = g_gldn_m.gldn032
               LET gs_keys_bak[8] = g_gldn032_t
               LET gs_keys[9] = g_gldn_m.gldn033
               LET gs_keys_bak[9] = g_gldn033_t
               LET gs_keys[10] = g_gldn2_d[g_detail_idx].gldn007
               LET gs_keys_bak[10] = g_gldn2_d_t.gldn007
               LET gs_keys[11] = g_gldn2_d[g_detail_idx].gldn008
               LET gs_keys_bak[11] = g_gldn2_d_t.gldn008
               LET gs_keys[12] = g_gldn2_d[g_detail_idx].gldn040
               LET gs_keys_bak[12] = g_gldn2_d_t.gldn040
               LET gs_keys[13] = g_gldn2_d[g_detail_idx].gldn041
               LET gs_keys_bak[13] = g_gldn2_d_t.gldn041
               CALL aglq901_update_b('gldn_t',gs_keys,gs_keys_bak,"'2'")
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_gldn_m),util.JSON.stringify(g_gldn2_d_t)
                     LET g_log2 = util.JSON.stringify(g_gldn_m),util.JSON.stringify(g_gldn2_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aglq901_gldn_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="modify.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn0072_desc
            #add-point:BEFORE FIELD gldn0072_desc name="input.b.page2.gldn0072_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn0072_desc
            
            #add-point:AFTER FIELD gldn0072_desc name="input.a.page2.gldn0072_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldn0072_desc
            #add-point:ON CHANGE gldn0072_desc name="input.g.page2.gldn0072_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldn0142
            #add-point:BEFORE FIELD l_gldn0142 name="input.b.page2.l_gldn0142"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldn0142
            
            #add-point:AFTER FIELD l_gldn0142 name="input.a.page2.l_gldn0142"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldn0142
            #add-point:ON CHANGE l_gldn0142 name="input.g.page2.l_gldn0142"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldn0152
            #add-point:BEFORE FIELD l_gldn0152 name="input.b.page2.l_gldn0152"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldn0152
            
            #add-point:AFTER FIELD l_gldn0152 name="input.a.page2.l_gldn0152"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldn0152
            #add-point:ON CHANGE l_gldn0152 name="input.g.page2.l_gldn0152"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldn0162
            #add-point:BEFORE FIELD l_gldn0162 name="input.b.page2.l_gldn0162"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldn0162
            
            #add-point:AFTER FIELD l_gldn0162 name="input.a.page2.l_gldn0162"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldn0162
            #add-point:ON CHANGE l_gldn0162 name="input.g.page2.l_gldn0162"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldn0172
            #add-point:BEFORE FIELD l_gldn0172 name="input.b.page2.l_gldn0172"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldn0172
            
            #add-point:AFTER FIELD l_gldn0172 name="input.a.page2.l_gldn0172"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldn0172
            #add-point:ON CHANGE l_gldn0172 name="input.g.page2.l_gldn0172"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldn0182
            #add-point:BEFORE FIELD l_gldn0182 name="input.b.page2.l_gldn0182"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldn0182
            
            #add-point:AFTER FIELD l_gldn0182 name="input.a.page2.l_gldn0182"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldn0182
            #add-point:ON CHANGE l_gldn0182 name="input.g.page2.l_gldn0182"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldn0192
            #add-point:BEFORE FIELD l_gldn0192 name="input.b.page2.l_gldn0192"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldn0192
            
            #add-point:AFTER FIELD l_gldn0192 name="input.a.page2.l_gldn0192"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldn0192
            #add-point:ON CHANGE l_gldn0192 name="input.g.page2.l_gldn0192"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldn0202
            #add-point:BEFORE FIELD l_gldn0202 name="input.b.page2.l_gldn0202"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldn0202
            
            #add-point:AFTER FIELD l_gldn0202 name="input.a.page2.l_gldn0202"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldn0202
            #add-point:ON CHANGE l_gldn0202 name="input.g.page2.l_gldn0202"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldn0212
            #add-point:BEFORE FIELD l_gldn0212 name="input.b.page2.l_gldn0212"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldn0212
            
            #add-point:AFTER FIELD l_gldn0212 name="input.a.page2.l_gldn0212"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldn0212
            #add-point:ON CHANGE l_gldn0212 name="input.g.page2.l_gldn0212"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldn0372
            #add-point:BEFORE FIELD l_gldn0372 name="input.b.page2.l_gldn0372"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldn0372
            
            #add-point:AFTER FIELD l_gldn0372 name="input.a.page2.l_gldn0372"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldn0372
            #add-point:ON CHANGE l_gldn0372 name="input.g.page2.l_gldn0372"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldn0382
            #add-point:BEFORE FIELD l_gldn0382 name="input.b.page2.l_gldn0382"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldn0382
            
            #add-point:AFTER FIELD l_gldn0382 name="input.a.page2.l_gldn0382"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldn0382
            #add-point:ON CHANGE l_gldn0382 name="input.g.page2.l_gldn0382"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldn0392
            #add-point:BEFORE FIELD l_gldn0392 name="input.b.page2.l_gldn0392"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldn0392
            
            #add-point:AFTER FIELD l_gldn0392 name="input.a.page2.l_gldn0392"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldn0392
            #add-point:ON CHANGE l_gldn0392 name="input.g.page2.l_gldn0392"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldn0222
            #add-point:BEFORE FIELD l_gldn0222 name="input.b.page2.l_gldn0222"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldn0222
            
            #add-point:AFTER FIELD l_gldn0222 name="input.a.page2.l_gldn0222"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldn0222
            #add-point:ON CHANGE l_gldn0222 name="input.g.page2.l_gldn0222"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldn0242
            #add-point:BEFORE FIELD l_gldn0242 name="input.b.page2.l_gldn0242"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldn0242
            
            #add-point:AFTER FIELD l_gldn0242 name="input.a.page2.l_gldn0242"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldn0242
            #add-point:ON CHANGE l_gldn0242 name="input.g.page2.l_gldn0242"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldn0252
            #add-point:BEFORE FIELD l_gldn0252 name="input.b.page2.l_gldn0252"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldn0252
            
            #add-point:AFTER FIELD l_gldn0252 name="input.a.page2.l_gldn0252"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldn0252
            #add-point:ON CHANGE l_gldn0252 name="input.g.page2.l_gldn0252"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn035
            #add-point:BEFORE FIELD gldn035 name="input.b.page2.gldn035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn035
            
            #add-point:AFTER FIELD gldn035 name="input.a.page2.gldn035"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldn035
            #add-point:ON CHANGE gldn035 name="input.g.page2.gldn035"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn027
            #add-point:BEFORE FIELD gldn027 name="input.b.page2.gldn027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn027
            
            #add-point:AFTER FIELD gldn027 name="input.a.page2.gldn027"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldn027
            #add-point:ON CHANGE gldn027 name="input.g.page2.gldn027"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn028
            #add-point:BEFORE FIELD gldn028 name="input.b.page2.gldn028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn028
            
            #add-point:AFTER FIELD gldn028 name="input.a.page2.gldn028"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldn028
            #add-point:ON CHANGE gldn028 name="input.g.page2.gldn028"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldn028
            #add-point:BEFORE FIELD l_gldn028 name="input.b.page2.l_gldn028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldn028
            
            #add-point:AFTER FIELD l_gldn028 name="input.a.page2.l_gldn028"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldn028
            #add-point:ON CHANGE l_gldn028 name="input.g.page2.l_gldn028"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.gldn0072_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn0072_desc
            #add-point:ON ACTION controlp INFIELD gldn0072_desc name="input.c.page2.gldn0072_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_gldn0142
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldn0142
            #add-point:ON ACTION controlp INFIELD l_gldn0142 name="input.c.page2.l_gldn0142"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_gldn0152
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldn0152
            #add-point:ON ACTION controlp INFIELD l_gldn0152 name="input.c.page2.l_gldn0152"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_gldn0162
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldn0162
            #add-point:ON ACTION controlp INFIELD l_gldn0162 name="input.c.page2.l_gldn0162"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_gldn0172
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldn0172
            #add-point:ON ACTION controlp INFIELD l_gldn0172 name="input.c.page2.l_gldn0172"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_gldn0182
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldn0182
            #add-point:ON ACTION controlp INFIELD l_gldn0182 name="input.c.page2.l_gldn0182"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_gldn0192
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldn0192
            #add-point:ON ACTION controlp INFIELD l_gldn0192 name="input.c.page2.l_gldn0192"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_gldn0202
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldn0202
            #add-point:ON ACTION controlp INFIELD l_gldn0202 name="input.c.page2.l_gldn0202"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_gldn0212
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldn0212
            #add-point:ON ACTION controlp INFIELD l_gldn0212 name="input.c.page2.l_gldn0212"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_gldn0372
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldn0372
            #add-point:ON ACTION controlp INFIELD l_gldn0372 name="input.c.page2.l_gldn0372"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_gldn0382
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldn0382
            #add-point:ON ACTION controlp INFIELD l_gldn0382 name="input.c.page2.l_gldn0382"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_gldn0392
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldn0392
            #add-point:ON ACTION controlp INFIELD l_gldn0392 name="input.c.page2.l_gldn0392"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_gldn0222
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldn0222
            #add-point:ON ACTION controlp INFIELD l_gldn0222 name="input.c.page2.l_gldn0222"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_gldn0242
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldn0242
            #add-point:ON ACTION controlp INFIELD l_gldn0242 name="input.c.page2.l_gldn0242"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_gldn0252
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldn0252
            #add-point:ON ACTION controlp INFIELD l_gldn0252 name="input.c.page2.l_gldn0252"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.gldn035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn035
            #add-point:ON ACTION controlp INFIELD gldn035 name="input.c.page2.gldn035"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.gldn027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn027
            #add-point:ON ACTION controlp INFIELD gldn027 name="input.c.page2.gldn027"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.gldn028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn028
            #add-point:ON ACTION controlp INFIELD gldn028 name="input.c.page2.gldn028"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_gldn028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldn028
            #add-point:ON ACTION controlp INFIELD l_gldn028 name="input.c.page2.l_gldn028"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:input段after row name="input.body2.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_gldn2_d[l_ac].* = g_gldn2_d_t.*
               END IF
               CLOSE aglq901_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               EXIT DIALOG 
            END IF
 
            CLOSE aglq901_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #add-point:input段after input  name="input.body2.after_input"
            
            #end add-point    
 
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_gldn_d[li_reproduce_target].* = g_gldn_d[li_reproduce].*
               LET g_gldn2_d[li_reproduce_target].* = g_gldn2_d[li_reproduce].*
               LET g_gldn3_d[li_reproduce_target].* = g_gldn3_d[li_reproduce].*
 
               LET g_gldn2_d[li_reproduce_target].gldn007 = NULL
               LET g_gldn2_d[li_reproduce_target].gldn008 = NULL
               LET g_gldn2_d[li_reproduce_target].gldn040 = NULL
               LET g_gldn2_d[li_reproduce_target].gldn041 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_gldn2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_gldn2_d.getLength()+1
            END IF
      END INPUT
      INPUT ARRAY g_gldn3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b, WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                   INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                   DELETE ROW = l_allow_delete,
                   APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
                 
         BEFORE INPUT
            
            CALL aglq901_b_fill(g_wc2) #test 
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
            CALL aglq901_idx_chk()
            
            CALL s_transaction_begin()
            IF g_rec_b >= l_ac THEN
               LET l_cmd='u'
               CALL aglq901_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body3.before_row.set_entry_b"
               
               #end add-point
               CALL aglq901_set_no_entry_b(l_cmd)
               LET g_gldn3_d_t.* = g_gldn3_d[l_ac].*   #BACKUP  #page1
               LET g_gldn3_d_o.* = g_gldn3_d[l_ac].*   #BACKUP  #page1
            END IF 
            
 
 
 
    
         BEFORE INSERT
            LET g_insert = 'Y' 
            NEXT FIELD gldn007
 
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            INITIALIZE g_gldn3_d_t.* TO NULL
            INITIALIZE g_gldn3_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_gldn3_d[l_ac].* TO NULL
            #公用欄位預設值
              
            #一般欄位預設值
                  LET g_gldn3_d[l_ac].gldn036 = "0"
      LET g_gldn3_d[l_ac].gldn030 = "0"
      LET g_gldn3_d[l_ac].gldn031 = "0"
      LET g_gldn3_d[l_ac].l_gldn031 = "0"
 
            
            #add-point:modify段before備份 name="input.body3.before_insert.before_bak"
            
            #end add-point
            LET g_gldn3_d_t.* = g_gldn3_d[l_ac].*     #新輸入資料
            LET g_gldn3_d_o.* = g_gldn3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aglq901_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body3.before_insert.set_entry_b"
            
            #end add-point
            CALL aglq901_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_gldn_d[li_reproduce_target].* = g_gldn_d[li_reproduce].*
               LET g_gldn2_d[li_reproduce_target].* = g_gldn2_d[li_reproduce].*
               LET g_gldn3_d[li_reproduce_target].* = g_gldn3_d[li_reproduce].*
 
               LET g_gldn3_d[li_reproduce_target].gldn007 = NULL
               LET g_gldn3_d[li_reproduce_target].gldn008 = NULL
               LET g_gldn3_d[li_reproduce_target].gldn040 = NULL
               LET g_gldn3_d[li_reproduce_target].gldn041 = NULL
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
               IF aglq901_before_delete() THEN 
                  
 
 
 
  
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_gldn_m.gldnld
                  LET gs_keys[gs_keys.getLength()+1] = g_gldn_m.gldn001
                  LET gs_keys[gs_keys.getLength()+1] = g_gldn_m.gldn002
                  LET gs_keys[gs_keys.getLength()+1] = g_gldn_m.gldn003
                  LET gs_keys[gs_keys.getLength()+1] = g_gldn_m.gldn004
                  LET gs_keys[gs_keys.getLength()+1] = g_gldn_m.gldn005
                  LET gs_keys[gs_keys.getLength()+1] = g_gldn_m.gldn006
                  LET gs_keys[gs_keys.getLength()+1] = g_gldn_m.gldn032
                  LET gs_keys[gs_keys.getLength()+1] = g_gldn_m.gldn033
                  LET gs_keys[gs_keys.getLength()+1] = g_gldn_d_t.gldn007
                  LET gs_keys[gs_keys.getLength()+1] = g_gldn_d_t.gldn008
                  LET gs_keys[gs_keys.getLength()+1] = g_gldn_d_t.gldn040
                  LET gs_keys[gs_keys.getLength()+1] = g_gldn_d_t.gldn041
 
                  #刪除下層單身
                  IF NOT aglq901_key_delete_b(gs_keys,'gldn_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE aglq901_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE aglq901_bcl
               CALL s_transaction_end('Y','0') 
               LET l_count = g_gldn3_d.getLength()
            END IF
            
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body3.after_delete"
               
               #end add-point
                              CALL aglq901_delete_b('gldn_t',gs_keys,"'3'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_gldn3_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_gldn3_d[l_ac].* = g_gldn3_d_t.*
               CLOSE aglq901_bcl
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
               LET g_errparam.extend = g_gldn_d[l_ac].gldn007 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_gldn3_d[l_ac].* = g_gldn3_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               
                
               #add-point:單身修改前 name="modify.body3.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL aglq901_gldn_t_mask_restore('restore_mask_o')
                     
               UPDATE gldn_t SET (gldnld,gldn001,gldn002,gldn003,gldn004,gldn005,gldn006,gldn032,gldn033, 
                   gldn007,gldn008,gldn014,gldn015,gldn016,gldn017,gldn018,gldn019,gldn020,gldn021,gldn037, 
                   gldn038,gldn039,gldn022,gldn024,gldn025,gldn034,gldn010,gldn011,gldn040,gldn041,gldn035, 
                   gldn027,gldn028,gldn036,gldn030,gldn031) = (g_gldn_m.gldnld,g_gldn_m.gldn001,g_gldn_m.gldn002, 
                   g_gldn_m.gldn003,g_gldn_m.gldn004,g_gldn_m.gldn005,g_gldn_m.gldn006,g_gldn_m.gldn032, 
                   g_gldn_m.gldn033,g_gldn_d[l_ac].gldn007,g_gldn_d[l_ac].gldn008,g_gldn_d[l_ac].gldn014, 
                   g_gldn_d[l_ac].gldn015,g_gldn_d[l_ac].gldn016,g_gldn_d[l_ac].gldn017,g_gldn_d[l_ac].gldn018, 
                   g_gldn_d[l_ac].gldn019,g_gldn_d[l_ac].gldn020,g_gldn_d[l_ac].gldn021,g_gldn_d[l_ac].gldn037, 
                   g_gldn_d[l_ac].gldn038,g_gldn_d[l_ac].gldn039,g_gldn_d[l_ac].gldn022,g_gldn_d[l_ac].gldn024, 
                   g_gldn_d[l_ac].gldn025,g_gldn_d[l_ac].gldn034,g_gldn_d[l_ac].gldn010,g_gldn_d[l_ac].gldn011, 
                   g_gldn_d[l_ac].gldn040,g_gldn_d[l_ac].gldn041,g_gldn2_d[l_ac].gldn035,g_gldn2_d[l_ac].gldn027, 
                   g_gldn2_d[l_ac].gldn028,g_gldn3_d[l_ac].gldn036,g_gldn3_d[l_ac].gldn030,g_gldn3_d[l_ac].gldn031)  
                   #自訂欄位頁簽
                WHERE gldnent = g_enterprise AND gldnld = g_gldn_m.gldnld
                 AND gldn001 = g_gldn_m.gldn001
                 AND gldn002 = g_gldn_m.gldn002
                 AND gldn003 = g_gldn_m.gldn003
                 AND gldn004 = g_gldn_m.gldn004
                 AND gldn005 = g_gldn_m.gldn005
                 AND gldn006 = g_gldn_m.gldn006
                 AND gldn032 = g_gldn_m.gldn032
                 AND gldn033 = g_gldn_m.gldn033
                 AND gldn007 = g_gldn3_d_t.gldn007 #項次 
                 AND gldn008 = g_gldn3_d_t.gldn008
                 AND gldn040 = g_gldn3_d_t.gldn040
                 AND gldn041 = g_gldn3_d_t.gldn041
               #add-point:單身修改中 name="modify.body3.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gldn_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gldn_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gldn_m.gldnld
               LET gs_keys_bak[1] = g_gldnld_t
               LET gs_keys[2] = g_gldn_m.gldn001
               LET gs_keys_bak[2] = g_gldn001_t
               LET gs_keys[3] = g_gldn_m.gldn002
               LET gs_keys_bak[3] = g_gldn002_t
               LET gs_keys[4] = g_gldn_m.gldn003
               LET gs_keys_bak[4] = g_gldn003_t
               LET gs_keys[5] = g_gldn_m.gldn004
               LET gs_keys_bak[5] = g_gldn004_t
               LET gs_keys[6] = g_gldn_m.gldn005
               LET gs_keys_bak[6] = g_gldn005_t
               LET gs_keys[7] = g_gldn_m.gldn006
               LET gs_keys_bak[7] = g_gldn006_t
               LET gs_keys[8] = g_gldn_m.gldn032
               LET gs_keys_bak[8] = g_gldn032_t
               LET gs_keys[9] = g_gldn_m.gldn033
               LET gs_keys_bak[9] = g_gldn033_t
               LET gs_keys[10] = g_gldn3_d[g_detail_idx].gldn007
               LET gs_keys_bak[10] = g_gldn3_d_t.gldn007
               LET gs_keys[11] = g_gldn3_d[g_detail_idx].gldn008
               LET gs_keys_bak[11] = g_gldn3_d_t.gldn008
               LET gs_keys[12] = g_gldn3_d[g_detail_idx].gldn040
               LET gs_keys_bak[12] = g_gldn3_d_t.gldn040
               LET gs_keys[13] = g_gldn3_d[g_detail_idx].gldn041
               LET gs_keys_bak[13] = g_gldn3_d_t.gldn041
               CALL aglq901_update_b('gldn_t',gs_keys,gs_keys_bak,"'3'")
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_gldn_m),util.JSON.stringify(g_gldn3_d_t)
                     LET g_log2 = util.JSON.stringify(g_gldn_m),util.JSON.stringify(g_gldn3_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aglq901_gldn_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="modify.body3.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn0073_desc
            #add-point:BEFORE FIELD gldn0073_desc name="input.b.page3.gldn0073_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn0073_desc
            
            #add-point:AFTER FIELD gldn0073_desc name="input.a.page3.gldn0073_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldn0073_desc
            #add-point:ON CHANGE gldn0073_desc name="input.g.page3.gldn0073_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldn0143
            #add-point:BEFORE FIELD l_gldn0143 name="input.b.page3.l_gldn0143"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldn0143
            
            #add-point:AFTER FIELD l_gldn0143 name="input.a.page3.l_gldn0143"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldn0143
            #add-point:ON CHANGE l_gldn0143 name="input.g.page3.l_gldn0143"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldn0153
            #add-point:BEFORE FIELD l_gldn0153 name="input.b.page3.l_gldn0153"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldn0153
            
            #add-point:AFTER FIELD l_gldn0153 name="input.a.page3.l_gldn0153"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldn0153
            #add-point:ON CHANGE l_gldn0153 name="input.g.page3.l_gldn0153"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldn0163
            #add-point:BEFORE FIELD l_gldn0163 name="input.b.page3.l_gldn0163"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldn0163
            
            #add-point:AFTER FIELD l_gldn0163 name="input.a.page3.l_gldn0163"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldn0163
            #add-point:ON CHANGE l_gldn0163 name="input.g.page3.l_gldn0163"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldn0173
            #add-point:BEFORE FIELD l_gldn0173 name="input.b.page3.l_gldn0173"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldn0173
            
            #add-point:AFTER FIELD l_gldn0173 name="input.a.page3.l_gldn0173"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldn0173
            #add-point:ON CHANGE l_gldn0173 name="input.g.page3.l_gldn0173"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldn0183
            #add-point:BEFORE FIELD l_gldn0183 name="input.b.page3.l_gldn0183"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldn0183
            
            #add-point:AFTER FIELD l_gldn0183 name="input.a.page3.l_gldn0183"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldn0183
            #add-point:ON CHANGE l_gldn0183 name="input.g.page3.l_gldn0183"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldn0193
            #add-point:BEFORE FIELD l_gldn0193 name="input.b.page3.l_gldn0193"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldn0193
            
            #add-point:AFTER FIELD l_gldn0193 name="input.a.page3.l_gldn0193"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldn0193
            #add-point:ON CHANGE l_gldn0193 name="input.g.page3.l_gldn0193"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldn0203
            #add-point:BEFORE FIELD l_gldn0203 name="input.b.page3.l_gldn0203"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldn0203
            
            #add-point:AFTER FIELD l_gldn0203 name="input.a.page3.l_gldn0203"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldn0203
            #add-point:ON CHANGE l_gldn0203 name="input.g.page3.l_gldn0203"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldn0213
            #add-point:BEFORE FIELD l_gldn0213 name="input.b.page3.l_gldn0213"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldn0213
            
            #add-point:AFTER FIELD l_gldn0213 name="input.a.page3.l_gldn0213"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldn0213
            #add-point:ON CHANGE l_gldn0213 name="input.g.page3.l_gldn0213"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldn0373
            #add-point:BEFORE FIELD l_gldn0373 name="input.b.page3.l_gldn0373"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldn0373
            
            #add-point:AFTER FIELD l_gldn0373 name="input.a.page3.l_gldn0373"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldn0373
            #add-point:ON CHANGE l_gldn0373 name="input.g.page3.l_gldn0373"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldn0383
            #add-point:BEFORE FIELD l_gldn0383 name="input.b.page3.l_gldn0383"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldn0383
            
            #add-point:AFTER FIELD l_gldn0383 name="input.a.page3.l_gldn0383"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldn0383
            #add-point:ON CHANGE l_gldn0383 name="input.g.page3.l_gldn0383"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldn0393
            #add-point:BEFORE FIELD l_gldn0393 name="input.b.page3.l_gldn0393"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldn0393
            
            #add-point:AFTER FIELD l_gldn0393 name="input.a.page3.l_gldn0393"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldn0393
            #add-point:ON CHANGE l_gldn0393 name="input.g.page3.l_gldn0393"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldn0223
            #add-point:BEFORE FIELD l_gldn0223 name="input.b.page3.l_gldn0223"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldn0223
            
            #add-point:AFTER FIELD l_gldn0223 name="input.a.page3.l_gldn0223"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldn0223
            #add-point:ON CHANGE l_gldn0223 name="input.g.page3.l_gldn0223"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldn0243
            #add-point:BEFORE FIELD l_gldn0243 name="input.b.page3.l_gldn0243"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldn0243
            
            #add-point:AFTER FIELD l_gldn0243 name="input.a.page3.l_gldn0243"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldn0243
            #add-point:ON CHANGE l_gldn0243 name="input.g.page3.l_gldn0243"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldn0253
            #add-point:BEFORE FIELD l_gldn0253 name="input.b.page3.l_gldn0253"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldn0253
            
            #add-point:AFTER FIELD l_gldn0253 name="input.a.page3.l_gldn0253"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldn0253
            #add-point:ON CHANGE l_gldn0253 name="input.g.page3.l_gldn0253"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn036
            #add-point:BEFORE FIELD gldn036 name="input.b.page3.gldn036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn036
            
            #add-point:AFTER FIELD gldn036 name="input.a.page3.gldn036"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldn036
            #add-point:ON CHANGE gldn036 name="input.g.page3.gldn036"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn030
            #add-point:BEFORE FIELD gldn030 name="input.b.page3.gldn030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn030
            
            #add-point:AFTER FIELD gldn030 name="input.a.page3.gldn030"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldn030
            #add-point:ON CHANGE gldn030 name="input.g.page3.gldn030"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldn031
            #add-point:BEFORE FIELD gldn031 name="input.b.page3.gldn031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldn031
            
            #add-point:AFTER FIELD gldn031 name="input.a.page3.gldn031"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldn031
            #add-point:ON CHANGE gldn031 name="input.g.page3.gldn031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldn031
            #add-point:BEFORE FIELD l_gldn031 name="input.b.page3.l_gldn031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldn031
            
            #add-point:AFTER FIELD l_gldn031 name="input.a.page3.l_gldn031"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldn031
            #add-point:ON CHANGE l_gldn031 name="input.g.page3.l_gldn031"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.gldn0073_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn0073_desc
            #add-point:ON ACTION controlp INFIELD gldn0073_desc name="input.c.page3.gldn0073_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_gldn0143
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldn0143
            #add-point:ON ACTION controlp INFIELD l_gldn0143 name="input.c.page3.l_gldn0143"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_gldn0153
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldn0153
            #add-point:ON ACTION controlp INFIELD l_gldn0153 name="input.c.page3.l_gldn0153"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_gldn0163
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldn0163
            #add-point:ON ACTION controlp INFIELD l_gldn0163 name="input.c.page3.l_gldn0163"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_gldn0173
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldn0173
            #add-point:ON ACTION controlp INFIELD l_gldn0173 name="input.c.page3.l_gldn0173"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_gldn0183
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldn0183
            #add-point:ON ACTION controlp INFIELD l_gldn0183 name="input.c.page3.l_gldn0183"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_gldn0193
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldn0193
            #add-point:ON ACTION controlp INFIELD l_gldn0193 name="input.c.page3.l_gldn0193"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_gldn0203
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldn0203
            #add-point:ON ACTION controlp INFIELD l_gldn0203 name="input.c.page3.l_gldn0203"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_gldn0213
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldn0213
            #add-point:ON ACTION controlp INFIELD l_gldn0213 name="input.c.page3.l_gldn0213"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_gldn0373
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldn0373
            #add-point:ON ACTION controlp INFIELD l_gldn0373 name="input.c.page3.l_gldn0373"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_gldn0383
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldn0383
            #add-point:ON ACTION controlp INFIELD l_gldn0383 name="input.c.page3.l_gldn0383"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_gldn0393
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldn0393
            #add-point:ON ACTION controlp INFIELD l_gldn0393 name="input.c.page3.l_gldn0393"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_gldn0223
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldn0223
            #add-point:ON ACTION controlp INFIELD l_gldn0223 name="input.c.page3.l_gldn0223"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_gldn0243
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldn0243
            #add-point:ON ACTION controlp INFIELD l_gldn0243 name="input.c.page3.l_gldn0243"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_gldn0253
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldn0253
            #add-point:ON ACTION controlp INFIELD l_gldn0253 name="input.c.page3.l_gldn0253"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.gldn036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn036
            #add-point:ON ACTION controlp INFIELD gldn036 name="input.c.page3.gldn036"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.gldn030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn030
            #add-point:ON ACTION controlp INFIELD gldn030 name="input.c.page3.gldn030"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.gldn031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldn031
            #add-point:ON ACTION controlp INFIELD gldn031 name="input.c.page3.gldn031"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_gldn031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldn031
            #add-point:ON ACTION controlp INFIELD l_gldn031 name="input.c.page3.l_gldn031"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:input段after row name="input.body3.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_gldn3_d[l_ac].* = g_gldn3_d_t.*
               END IF
               CLOSE aglq901_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               EXIT DIALOG 
            END IF
 
            CLOSE aglq901_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #add-point:input段after input  name="input.body3.after_input"
            
            #end add-point    
 
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_gldn_d[li_reproduce_target].* = g_gldn_d[li_reproduce].*
               LET g_gldn2_d[li_reproduce_target].* = g_gldn2_d[li_reproduce].*
               LET g_gldn3_d[li_reproduce_target].* = g_gldn3_d[li_reproduce].*
 
               LET g_gldn3_d[li_reproduce_target].gldn007 = NULL
               LET g_gldn3_d[li_reproduce_target].gldn008 = NULL
               LET g_gldn3_d[li_reproduce_target].gldn040 = NULL
               LET g_gldn3_d[li_reproduce_target].gldn041 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_gldn3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_gldn3_d.getLength()+1
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
            NEXT FIELD gldnld
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD gldn007
               WHEN "s_detail2"
                  NEXT FIELD gldn007_2
               WHEN "s_detail3"
                  NEXT FIELD gldn007_3
 
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
 
{<section id="aglq901.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aglq901_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL aglq901_b_fill(g_wc2) #第一階單身填充
      CALL aglq901_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aglq901_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_gldn_m.gldnld,g_gldn_m.gldnld_desc,g_gldn_m.gldn001,g_gldn_m.gldn001_desc,g_gldn_m.gldn002, 
       g_gldn_m.gldn002_desc,g_gldn_m.gldn005,g_gldn_m.gldn006,g_gldn_m.gldn009,g_gldn_m.gldn026,g_gldn_m.gldn029, 
       g_gldn_m.gldn032,g_gldn_m.gldn003,g_gldn_m.gldn033,g_gldn_m.gldn004
 
   CALL aglq901_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
   DISPLAY BY NAME g_input.l_chk14,g_input.l_chk15,g_input.l_chk16,
                   g_input.l_chk17,g_input.l_chk18,g_input.l_chk19,
                   g_input.l_chk20,g_input.l_chk21,g_input.l_chk37,
                   g_input.l_chk38,g_input.l_chk39,g_input.l_chk22,
                   g_input.l_chk24,g_input.l_chk25
   CALL aglq901_show_visible()   #單身欄位關閉
   CALL aglq901_ld_visible()     #依帳別開關
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="aglq901.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION aglq901_ref_show()
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
   LET g_gldn_m.gldn001_desc = s_desc_glda001_desc(g_gldn_m.gldn001)
   LET g_gldn_m.gldnld_desc  = s_desc_get_ld_desc(g_gldn_m.gldnld)
   LET g_gldn_m.gldn002_desc  = s_desc_get_ld_desc(g_gldn_m.gldn002)
   DISPLAY BY NAME g_gldn_m.gldn001_desc,g_gldn_m.gldnld_desc,g_gldn_m.gldn002_desc
   #end add-point
 
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_gldn_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_gldn2_d.getLength()
      #add-point:ref_show段d2_reference name="ref_show.body2.reference"
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_gldn3_d.getLength()
      #add-point:ref_show段d3_reference name="ref_show.body3.reference"
      
      #end add-point
   END FOR
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="aglq901.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aglq901_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE gldn_t.gldnld 
   DEFINE l_oldno     LIKE gldn_t.gldnld 
   DEFINE l_newno02     LIKE gldn_t.gldn001 
   DEFINE l_oldno02     LIKE gldn_t.gldn001 
   DEFINE l_newno03     LIKE gldn_t.gldn002 
   DEFINE l_oldno03     LIKE gldn_t.gldn002 
   DEFINE l_newno04     LIKE gldn_t.gldn003 
   DEFINE l_oldno04     LIKE gldn_t.gldn003 
   DEFINE l_newno05     LIKE gldn_t.gldn004 
   DEFINE l_oldno05     LIKE gldn_t.gldn004 
   DEFINE l_newno06     LIKE gldn_t.gldn005 
   DEFINE l_oldno06     LIKE gldn_t.gldn005 
   DEFINE l_newno07     LIKE gldn_t.gldn006 
   DEFINE l_oldno07     LIKE gldn_t.gldn006 
   DEFINE l_newno08     LIKE gldn_t.gldn032 
   DEFINE l_oldno08     LIKE gldn_t.gldn032 
   DEFINE l_newno09     LIKE gldn_t.gldn033 
   DEFINE l_oldno09     LIKE gldn_t.gldn033 
 
   DEFINE l_master    RECORD LIKE gldn_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE gldn_t.* #此變數樣板目前無使用
 
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
 
   IF g_gldn_m.gldnld IS NULL
      OR g_gldn_m.gldn001 IS NULL
      OR g_gldn_m.gldn002 IS NULL
      OR g_gldn_m.gldn003 IS NULL
      OR g_gldn_m.gldn004 IS NULL
      OR g_gldn_m.gldn005 IS NULL
      OR g_gldn_m.gldn006 IS NULL
      OR g_gldn_m.gldn032 IS NULL
      OR g_gldn_m.gldn033 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_gldnld_t = g_gldn_m.gldnld
   LET g_gldn001_t = g_gldn_m.gldn001
   LET g_gldn002_t = g_gldn_m.gldn002
   LET g_gldn003_t = g_gldn_m.gldn003
   LET g_gldn004_t = g_gldn_m.gldn004
   LET g_gldn005_t = g_gldn_m.gldn005
   LET g_gldn006_t = g_gldn_m.gldn006
   LET g_gldn032_t = g_gldn_m.gldn032
   LET g_gldn033_t = g_gldn_m.gldn033
 
   
   LET g_gldn_m.gldnld = ""
   LET g_gldn_m.gldn001 = ""
   LET g_gldn_m.gldn002 = ""
   LET g_gldn_m.gldn003 = ""
   LET g_gldn_m.gldn004 = ""
   LET g_gldn_m.gldn005 = ""
   LET g_gldn_m.gldn006 = ""
   LET g_gldn_m.gldn032 = ""
   LET g_gldn_m.gldn033 = ""
 
   LET g_master_insert = FALSE
   CALL aglq901_set_entry('a')
   CALL aglq901_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #清空key欄位的desc
      LET g_gldn_m.gldnld_desc = ''
   DISPLAY BY NAME g_gldn_m.gldnld_desc
   LET g_gldn_m.gldn001_desc = ''
   DISPLAY BY NAME g_gldn_m.gldn001_desc
   LET g_gldn_m.gldn002_desc = ''
   DISPLAY BY NAME g_gldn_m.gldn002_desc
 
   
   CALL aglq901_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_gldn_m.* TO NULL
      INITIALIZE g_gldn_d TO NULL
      INITIALIZE g_gldn2_d TO NULL
      INITIALIZE g_gldn3_d TO NULL
 
      CALL aglq901_show()
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
   CALL aglq901_set_act_visible()
   CALL aglq901_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_gldnld_t = g_gldn_m.gldnld
   LET g_gldn001_t = g_gldn_m.gldn001
   LET g_gldn002_t = g_gldn_m.gldn002
   LET g_gldn003_t = g_gldn_m.gldn003
   LET g_gldn004_t = g_gldn_m.gldn004
   LET g_gldn005_t = g_gldn_m.gldn005
   LET g_gldn006_t = g_gldn_m.gldn006
   LET g_gldn032_t = g_gldn_m.gldn032
   LET g_gldn033_t = g_gldn_m.gldn033
 
   
   #組合新增資料的條件
   LET g_add_browse = " gldnent = " ||g_enterprise|| " AND",
                      " gldnld = '", g_gldn_m.gldnld, "' "
                      ," AND gldn001 = '", g_gldn_m.gldn001, "' "
                      ," AND gldn002 = '", g_gldn_m.gldn002, "' "
                      ," AND gldn003 = '", g_gldn_m.gldn003, "' "
                      ," AND gldn004 = '", g_gldn_m.gldn004, "' "
                      ," AND gldn005 = '", g_gldn_m.gldn005, "' "
                      ," AND gldn006 = '", g_gldn_m.gldn006, "' "
                      ," AND gldn032 = '", g_gldn_m.gldn032, "' "
                      ," AND gldn033 = '", g_gldn_m.gldn033, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aglq901_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL aglq901_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL aglq901_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="aglq901.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION aglq901_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE gldn_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aglq901_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM gldn_t
    WHERE gldnent = g_enterprise AND gldnld = g_gldnld_t
    AND gldn001 = g_gldn001_t
    AND gldn002 = g_gldn002_t
    AND gldn003 = g_gldn003_t
    AND gldn004 = g_gldn004_t
    AND gldn005 = g_gldn005_t
    AND gldn006 = g_gldn006_t
    AND gldn032 = g_gldn032_t
    AND gldn033 = g_gldn033_t
 
       INTO TEMP aglq901_detail
   
   #將key修正為調整後   
   UPDATE aglq901_detail 
      #更新key欄位
      SET gldnld = g_gldn_m.gldnld
          , gldn001 = g_gldn_m.gldn001
          , gldn002 = g_gldn_m.gldn002
          , gldn003 = g_gldn_m.gldn003
          , gldn004 = g_gldn_m.gldn004
          , gldn005 = g_gldn_m.gldn005
          , gldn006 = g_gldn_m.gldn006
          , gldn032 = g_gldn_m.gldn032
          , gldn033 = g_gldn_m.gldn033
 
      #更新共用欄位
      
                                       
   #將資料塞回原table   
   INSERT INTO gldn_t SELECT * FROM aglq901_detail
   
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
   DROP TABLE aglq901_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_gldnld_t = g_gldn_m.gldnld
   LET g_gldn001_t = g_gldn_m.gldn001
   LET g_gldn002_t = g_gldn_m.gldn002
   LET g_gldn003_t = g_gldn_m.gldn003
   LET g_gldn004_t = g_gldn_m.gldn004
   LET g_gldn005_t = g_gldn_m.gldn005
   LET g_gldn006_t = g_gldn_m.gldn006
   LET g_gldn032_t = g_gldn_m.gldn032
   LET g_gldn033_t = g_gldn_m.gldn033
 
   
   DROP TABLE aglq901_detail
   
END FUNCTION
 
{</section>}
 
{<section id="aglq901.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aglq901_delete()
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
   
   IF g_gldn_m.gldnld IS NULL
   OR g_gldn_m.gldn001 IS NULL
   OR g_gldn_m.gldn002 IS NULL
   OR g_gldn_m.gldn003 IS NULL
   OR g_gldn_m.gldn004 IS NULL
   OR g_gldn_m.gldn005 IS NULL
   OR g_gldn_m.gldn006 IS NULL
   OR g_gldn_m.gldn032 IS NULL
   OR g_gldn_m.gldn033 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN aglq901_cl USING g_enterprise,g_gldn_m.gldnld,g_gldn_m.gldn001,g_gldn_m.gldn002,g_gldn_m.gldn003,g_gldn_m.gldn004,g_gldn_m.gldn005,g_gldn_m.gldn006,g_gldn_m.gldn032,g_gldn_m.gldn033
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aglq901_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE aglq901_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aglq901_master_referesh USING g_gldn_m.gldnld,g_gldn_m.gldn001,g_gldn_m.gldn002,g_gldn_m.gldn003, 
       g_gldn_m.gldn004,g_gldn_m.gldn005,g_gldn_m.gldn006,g_gldn_m.gldn032,g_gldn_m.gldn033 INTO g_gldn_m.gldnld, 
       g_gldn_m.gldn001,g_gldn_m.gldn002,g_gldn_m.gldn005,g_gldn_m.gldn006,g_gldn_m.gldn009,g_gldn_m.gldn026, 
       g_gldn_m.gldn029,g_gldn_m.gldn032,g_gldn_m.gldn003,g_gldn_m.gldn033,g_gldn_m.gldn004
   
   #遮罩相關處理
   LET g_gldn_m_mask_o.* =  g_gldn_m.*
   CALL aglq901_gldn_t_mask()
   LET g_gldn_m_mask_n.* =  g_gldn_m.*
   
   CALL aglq901_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aglq901_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM gldn_t WHERE gldnent = g_enterprise AND gldnld = g_gldn_m.gldnld
                                                               AND gldn001 = g_gldn_m.gldn001
                                                               AND gldn002 = g_gldn_m.gldn002
                                                               AND gldn003 = g_gldn_m.gldn003
                                                               AND gldn004 = g_gldn_m.gldn004
                                                               AND gldn005 = g_gldn_m.gldn005
                                                               AND gldn006 = g_gldn_m.gldn006
                                                               AND gldn032 = g_gldn_m.gldn032
                                                               AND gldn033 = g_gldn_m.gldn033
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gldn_t:",SQLERRMESSAGE 
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
      #   CLOSE aglq901_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_gldn_d.clear() 
      CALL g_gldn2_d.clear()       
      CALL g_gldn3_d.clear()       
 
     
      CALL aglq901_ui_browser_refresh()  
      #CALL aglq901_ui_headershow()  
      #CALL aglq901_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL aglq901_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL aglq901_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE aglq901_cl
 
   #功能已完成,通報訊息中心
   CALL aglq901_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="aglq901.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aglq901_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #先清空單身變數內容
   CALL g_gldn_d.clear()
   CALL g_gldn2_d.clear()
   CALL g_gldn3_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT gldn007,gldn008,gldn014,gldn015,gldn016,gldn017,gldn018,gldn019,gldn020, 
       gldn021,gldn037,gldn038,gldn039,gldn022,gldn024,gldn025,gldn034,gldn010,gldn011,gldn040,gldn041, 
       gldn007,gldn008,gldn035,gldn027,gldn028,gldn040,gldn041,gldn007,gldn008,gldn036,gldn030,gldn031, 
       gldn040,gldn041 FROM gldn_t",   
               "",
               
               
               " WHERE gldnent= ? AND gldnld=? AND gldn001=? AND gldn002=? AND gldn003=? AND gldn004=? AND gldn005=? AND gldn006=? AND gldn032=? AND gldn033=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("gldn_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = g_sql CLIPPED," AND ",g_wc CLIPPED
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF aglq901_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY gldn_t.gldn007,gldn_t.gldn008,gldn_t.gldn040,gldn_t.gldn041"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
         
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aglq901_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR aglq901_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_gldn_m.gldnld,g_gldn_m.gldn001,g_gldn_m.gldn002,g_gldn_m.gldn003,g_gldn_m.gldn004,g_gldn_m.gldn005,g_gldn_m.gldn006,g_gldn_m.gldn032,g_gldn_m.gldn033   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_gldn_m.gldnld,g_gldn_m.gldn001,g_gldn_m.gldn002,g_gldn_m.gldn003, 
          g_gldn_m.gldn004,g_gldn_m.gldn005,g_gldn_m.gldn006,g_gldn_m.gldn032,g_gldn_m.gldn033 INTO g_gldn_d[l_ac].gldn007, 
          g_gldn_d[l_ac].gldn008,g_gldn_d[l_ac].gldn014,g_gldn_d[l_ac].gldn015,g_gldn_d[l_ac].gldn016, 
          g_gldn_d[l_ac].gldn017,g_gldn_d[l_ac].gldn018,g_gldn_d[l_ac].gldn019,g_gldn_d[l_ac].gldn020, 
          g_gldn_d[l_ac].gldn021,g_gldn_d[l_ac].gldn037,g_gldn_d[l_ac].gldn038,g_gldn_d[l_ac].gldn039, 
          g_gldn_d[l_ac].gldn022,g_gldn_d[l_ac].gldn024,g_gldn_d[l_ac].gldn025,g_gldn_d[l_ac].gldn034, 
          g_gldn_d[l_ac].gldn010,g_gldn_d[l_ac].gldn011,g_gldn_d[l_ac].gldn040,g_gldn_d[l_ac].gldn041, 
          g_gldn2_d[l_ac].gldn007,g_gldn2_d[l_ac].gldn008,g_gldn2_d[l_ac].gldn035,g_gldn2_d[l_ac].gldn027, 
          g_gldn2_d[l_ac].gldn028,g_gldn2_d[l_ac].gldn040,g_gldn2_d[l_ac].gldn041,g_gldn3_d[l_ac].gldn007, 
          g_gldn3_d[l_ac].gldn008,g_gldn3_d[l_ac].gldn036,g_gldn3_d[l_ac].gldn030,g_gldn3_d[l_ac].gldn031, 
          g_gldn3_d[l_ac].gldn040,g_gldn3_d[l_ac].gldn041   #(ver:49)
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充 name="b_fill.fill"
         LET g_gldn_d[l_ac].gldn014_desc =  s_desc_show1(g_gldn_d[l_ac].gldn014,s_merge_source_desc('1',g_gldn_d[l_ac].gldn014))
         LET g_gldn2_d[l_ac].l_gldn0142 = g_gldn_d[l_ac].gldn014_desc
         LET g_gldn3_d[l_ac].l_gldn0143 = g_gldn_d[l_ac].gldn014_desc
         LET g_gldn_d[l_ac].gldn015_desc =  s_desc_show1(g_gldn_d[l_ac].gldn015,s_merge_source_desc('2',g_gldn_d[l_ac].gldn015))
         LET g_gldn2_d[l_ac].l_gldn0152 = g_gldn_d[l_ac].gldn015_desc
         LET g_gldn3_d[l_ac].l_gldn0153 = g_gldn_d[l_ac].gldn015_desc
         LET g_gldn_d[l_ac].gldn016_desc =  s_desc_show1(g_gldn_d[l_ac].gldn016,s_merge_source_desc('3',g_gldn_d[l_ac].gldn016))
         LET g_gldn2_d[l_ac].l_gldn0162 = g_gldn_d[l_ac].gldn016_desc
         LET g_gldn3_d[l_ac].l_gldn0163 = g_gldn_d[l_ac].gldn016_desc
         LET g_gldn_d[l_ac].gldn017_desc =  s_desc_show1(g_gldn_d[l_ac].gldn017,s_merge_source_desc('4',g_gldn_d[l_ac].gldn017))
         LET g_gldn2_d[l_ac].l_gldn0172 = g_gldn_d[l_ac].gldn017_desc
         LET g_gldn3_d[l_ac].l_gldn0173 = g_gldn_d[l_ac].gldn017_desc
         LET g_gldn_d[l_ac].gldn018_desc =  s_desc_show1(g_gldn_d[l_ac].gldn018,s_merge_source_desc('5',g_gldn_d[l_ac].gldn018))
         LET g_gldn2_d[l_ac].l_gldn0182 = g_gldn_d[l_ac].gldn018_desc
         LET g_gldn3_d[l_ac].l_gldn0183 = g_gldn_d[l_ac].gldn018_desc
         LET g_gldn_d[l_ac].gldn019_desc =  s_desc_show1(g_gldn_d[l_ac].gldn019,s_merge_source_desc('6',g_gldn_d[l_ac].gldn019))
         LET g_gldn2_d[l_ac].l_gldn0192 = g_gldn_d[l_ac].gldn019_desc
         LET g_gldn3_d[l_ac].l_gldn0193 = g_gldn_d[l_ac].gldn019_desc
         LET g_gldn_d[l_ac].gldn020_desc =  s_desc_show1(g_gldn_d[l_ac].gldn020,s_merge_source_desc('7',g_gldn_d[l_ac].gldn020))
         LET g_gldn2_d[l_ac].l_gldn0202 = g_gldn_d[l_ac].gldn020_desc
         LET g_gldn3_d[l_ac].l_gldn0203 = g_gldn_d[l_ac].gldn020_desc         
         LET g_gldn_d[l_ac].gldn021_desc =  s_desc_show1(g_gldn_d[l_ac].gldn021,s_merge_source_desc('8',g_gldn_d[l_ac].gldn021))
         LET g_gldn2_d[l_ac].l_gldn0212 = g_gldn_d[l_ac].gldn021_desc
         LET g_gldn3_d[l_ac].l_gldn0213 = g_gldn_d[l_ac].gldn021_desc         
         LET g_gldn_d[l_ac].gldn038_desc =  s_desc_show1(g_gldn_d[l_ac].gldn038,s_merge_source_desc('10',g_gldn_d[l_ac].gldn038))
         LET g_gldn2_d[l_ac].l_gldn0382 = g_gldn_d[l_ac].gldn038_desc
         LET g_gldn3_d[l_ac].l_gldn0383 = g_gldn_d[l_ac].gldn038_desc
         LET g_gldn_d[l_ac].gldn039_desc =  s_desc_show1(g_gldn_d[l_ac].gldn039,s_merge_source_desc('11',g_gldn_d[l_ac].gldn039))
         LET g_gldn2_d[l_ac].l_gldn0392 = g_gldn_d[l_ac].gldn039_desc
         LET g_gldn3_d[l_ac].l_gldn0393 = g_gldn_d[l_ac].gldn039_desc
         LET g_gldn_d[l_ac].gldn022_desc =  s_desc_show1(g_gldn_d[l_ac].gldn022,s_merge_source_desc('12',g_gldn_d[l_ac].gldn022))
         LET g_gldn2_d[l_ac].l_gldn0222 = g_gldn_d[l_ac].gldn022_desc
         LET g_gldn3_d[l_ac].l_gldn0223 = g_gldn_d[l_ac].gldn022_desc
         LET g_gldn_d[l_ac].gldn024_desc =  s_desc_show1(g_gldn_d[l_ac].gldn024,s_merge_source_desc('13',g_gldn_d[l_ac].gldn024))
         LET g_gldn2_d[l_ac].l_gldn0242 = g_gldn_d[l_ac].gldn024_desc
         LET g_gldn3_d[l_ac].l_gldn0243 = g_gldn_d[l_ac].gldn024_desc
         LET g_gldn_d[l_ac].gldn025_desc =  s_desc_show1(g_gldn_d[l_ac].gldn025,s_desc_get_wbs_desc(g_gldn_d[l_ac].gldn024,g_gldn_d[l_ac].gldn025))
         LET g_gldn2_d[l_ac].l_gldn0252 = g_gldn_d[l_ac].gldn025_desc
         LET g_gldn3_d[l_ac].l_gldn0253 = g_gldn_d[l_ac].gldn025_desc
         
         LET g_gldn_d[l_ac].l_gldn011 = g_gldn_d[l_ac].gldn010 - g_gldn_d[l_ac].gldn011
         LET g_gldn2_d[l_ac].l_gldn028 = g_gldn2_d[l_ac].gldn027 - g_gldn2_d[l_ac].gldn028
         LET g_gldn3_d[l_ac].l_gldn031 = g_gldn3_d[l_ac].gldn030 - g_gldn3_d[l_ac].gldn031
         LET g_gldn_d[l_ac].gldn007_desc = s_desc_get_account_desc(g_gldn_m.gldnld,g_gldn_d[l_ac].gldn007)
         LET g_gldn2_d[l_ac].gldn0072_desc =  g_gldn_d[l_ac].gldn007_desc
         LET g_gldn3_d[l_ac].gldn0073_desc =  g_gldn_d[l_ac].gldn007_desc
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
 
            CALL g_gldn_d.deleteElement(g_gldn_d.getLength())
      CALL g_gldn2_d.deleteElement(g_gldn2_d.getLength())
      CALL g_gldn3_d.deleteElement(g_gldn3_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
   
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_gldn_d.getLength()
      LET g_gldn_d_mask_o[l_ac].* =  g_gldn_d[l_ac].*
      CALL aglq901_gldn_t_mask()
      LET g_gldn_d_mask_n[l_ac].* =  g_gldn_d[l_ac].*
   END FOR
   
   LET g_gldn2_d_mask_o.* =  g_gldn2_d.*
   FOR l_ac = 1 TO g_gldn2_d.getLength()
      LET g_gldn2_d_mask_o[l_ac].* =  g_gldn2_d[l_ac].*
      CALL aglq901_gldn_t_mask()
      LET g_gldn2_d_mask_n[l_ac].* =  g_gldn2_d[l_ac].*
   END FOR
   LET g_gldn3_d_mask_o.* =  g_gldn3_d.*
   FOR l_ac = 1 TO g_gldn3_d.getLength()
      LET g_gldn3_d_mask_o[l_ac].* =  g_gldn3_d[l_ac].*
      CALL aglq901_gldn_t_mask()
      LET g_gldn3_d_mask_n[l_ac].* =  g_gldn3_d[l_ac].*
   END FOR
 
 
   FREE aglq901_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="aglq901.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION aglq901_idx_chk()
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
      IF g_detail_idx > g_gldn_d.getLength() THEN
         LET g_detail_idx = g_gldn_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_gldn_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_gldn_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_gldn2_d.getLength() THEN
         LET g_detail_idx = g_gldn2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_gldn2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_gldn2_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_gldn3_d.getLength() THEN
         LET g_detail_idx = g_gldn3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_gldn3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_gldn3_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aglq901.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aglq901_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_gldn_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="aglq901.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION aglq901_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   
   #end add-point
   
   DELETE FROM gldn_t
    WHERE gldnent = g_enterprise AND gldnld = g_gldn_m.gldnld AND
                              gldn001 = g_gldn_m.gldn001 AND
                              gldn002 = g_gldn_m.gldn002 AND
                              gldn003 = g_gldn_m.gldn003 AND
                              gldn004 = g_gldn_m.gldn004 AND
                              gldn005 = g_gldn_m.gldn005 AND
                              gldn006 = g_gldn_m.gldn006 AND
                              gldn032 = g_gldn_m.gldn032 AND
                              gldn033 = g_gldn_m.gldn033 AND
 
          gldn007 = g_gldn_d_t.gldn007
      AND gldn008 = g_gldn_d_t.gldn008
      AND gldn040 = g_gldn_d_t.gldn040
      AND gldn041 = g_gldn_d_t.gldn041
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "gldn_t:",SQLERRMESSAGE 
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
 
{<section id="aglq901.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aglq901_delete_b(ps_table,ps_keys_bak,ps_page)
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
 
{<section id="aglq901.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aglq901_insert_b(ps_table,ps_keys,ps_page)
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
 
{<section id="aglq901.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aglq901_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
 
{<section id="aglq901.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION aglq901_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_gldn_d[l_ac].gldn007 = g_gldn_d_t.gldn007 
      AND g_gldn_d[l_ac].gldn008 = g_gldn_d_t.gldn008 
      AND g_gldn_d[l_ac].gldn040 = g_gldn_d_t.gldn040 
      AND g_gldn_d[l_ac].gldn041 = g_gldn_d_t.gldn041 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="aglq901.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION aglq901_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="aglq901.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aglq901_lock_b(ps_table,ps_page)
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
   #CALL aglq901_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aglq901.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aglq901_unlock_b(ps_table,ps_page)
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
 
{<section id="aglq901.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aglq901_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("gldnld,gldn001,gldn002,gldn003,gldn004,gldn005,gldn006,gldn032,gldn033",TRUE)
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
 
{<section id="aglq901.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aglq901_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("gldnld,gldn001,gldn002,gldn003,gldn004,gldn005,gldn006,gldn032,gldn033",FALSE)
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
 
{<section id="aglq901.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aglq901_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aglq901.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aglq901_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="aglq901.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aglq901_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aglq901.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aglq901_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aglq901.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION aglq901_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aglq901.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION aglq901_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aglq901.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aglq901_default_search()
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
      LET ls_wc = ls_wc, " gldnld = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " gldn001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " gldn002 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " gldn003 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET ls_wc = ls_wc, " gldn004 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET ls_wc = ls_wc, " gldn005 = '", g_argv[06], "' AND "
   END IF
   IF NOT cl_null(g_argv[07]) THEN
      LET ls_wc = ls_wc, " gldn006 = '", g_argv[07], "' AND "
   END IF
   IF NOT cl_null(g_argv[08]) THEN
      LET ls_wc = ls_wc, " gldn032 = '", g_argv[08], "' AND "
   END IF
   IF NOT cl_null(g_argv[09]) THEN
      LET ls_wc = ls_wc, " gldn033 = '", g_argv[09], "' AND "
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
 
{<section id="aglq901.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION aglq901_fill_chk(ps_idx)
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
 
{<section id="aglq901.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION aglq901_modify_detail_chk(ps_record)
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
         LET ls_return = "gldn007"
      WHEN "s_detail2"
         LET ls_return = "gldn007_2"
      WHEN "s_detail3"
         LET ls_return = "gldn007_3"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="aglq901.mask_functions" >}
&include "erp/agl/aglq901_mask.4gl"
 
{</section>}
 
{<section id="aglq901.state_change" >}
    
 
{</section>}
 
{<section id="aglq901.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aglq901_set_pk_array()
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
   LET g_pk_array[1].values = g_gldn_m.gldnld
   LET g_pk_array[1].column = 'gldnld'
   LET g_pk_array[2].values = g_gldn_m.gldn001
   LET g_pk_array[2].column = 'gldn001'
   LET g_pk_array[3].values = g_gldn_m.gldn002
   LET g_pk_array[3].column = 'gldn002'
   LET g_pk_array[4].values = g_gldn_m.gldn003
   LET g_pk_array[4].column = 'gldn003'
   LET g_pk_array[5].values = g_gldn_m.gldn004
   LET g_pk_array[5].column = 'gldn004'
   LET g_pk_array[6].values = g_gldn_m.gldn005
   LET g_pk_array[6].column = 'gldn005'
   LET g_pk_array[7].values = g_gldn_m.gldn006
   LET g_pk_array[7].column = 'gldn006'
   LET g_pk_array[8].values = g_gldn_m.gldn032
   LET g_pk_array[8].column = 'gldn032'
   LET g_pk_array[9].values = g_gldn_m.gldn033
   LET g_pk_array[9].column = 'gldn033'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aglq901.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aglq901_msgcentre_notify(lc_state)
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
   CALL aglq901_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_gldn_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aglq901.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 給預設值
# Memo...........:
# Date & Author..: 150318 By albireo
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq901_qbe_clear()
   CLEAR FORM
   LET g_input.l_chk14 = 'Y'
   LET g_input.l_chk15 = 'N'
   LET g_input.l_chk16 = 'N'
   LET g_input.l_chk17 = 'N'
   LET g_input.l_chk18 = 'N'
   LET g_input.l_chk19 = 'N'
   LET g_input.l_chk20 = 'N'
   LET g_input.l_chk21 = 'N'
   LET g_input.l_chk37 = 'N'
   LET g_input.l_chk38 = 'N'
   LET g_input.l_chk39 = 'N'
   LET g_input.l_chk22 = 'N'
   LET g_input.l_chk24 = 'N'
   LET g_input.l_chk25 = 'N'
   DISPLAY BY NAME g_input.l_chk14,g_input.l_chk15,g_input.l_chk16,
                   g_input.l_chk17,g_input.l_chk18,g_input.l_chk19,
                   g_input.l_chk20,g_input.l_chk21,g_input.l_chk37,
                   g_input.l_chk38,g_input.l_chk39,g_input.l_chk22,
                   g_input.l_chk24,g_input.l_chk25
END FUNCTION

PRIVATE FUNCTION aglq901_construct_visible(p_type)
   DEFINE p_type   LIKE type_t.chr10      # IN/OUT

   #先全開
   CALL cl_set_comp_visible('gldn014,gldn014_desc,gldn015,gldn015_desc,gldn016,gldn016_desc',TRUE)
   CALL cl_set_comp_visible('gldn017,gldn017_desc,gldn018,gldn018_desc,gldn019,gldn019_desc',TRUE)
   CALL cl_set_comp_visible('gldn020,gldn020_desc,gldn021,gldn021_desc,gldn037',TRUE)
   CALL cl_set_comp_visible('gldn038,gldn038_desc,gldn039,gldn039_desc,gldn022,gldn022_desc',TRUE)   
   CALL cl_set_comp_visible('gldn024,gldn024_desc,gldn025,gldn025_desc',TRUE)
   CASE
      WHEN p_type = 'IN'
         CALL cl_set_comp_visible('gldn014_desc,gldn015_desc,gldn016_desc',FALSE)
         CALL cl_set_comp_visible('gldn017_desc,gldn018_desc,gldn019_desc',FALSE)
         CALL cl_set_comp_visible('gldn020_desc,gldn021_desc',FALSE)
         CALL cl_set_comp_visible('gldn038_desc,gldn039_desc,gldn022_desc',FALSE)   
         CALL cl_set_comp_visible('gldn024_desc,gldn025_desc',FALSE)   
      WHEN p_type = 'OUT'
         CALL cl_set_comp_visible('gldn014,gldn015,gldn016',FALSE)
         CALL cl_set_comp_visible('gldn017,gldn018,gldn019',FALSE)
         CALL cl_set_comp_visible('gldn020,gldn021',FALSE)
         CALL cl_set_comp_visible('gldn038,gldn039,gldn022',FALSE)   
         CALL cl_set_comp_visible('gldn024,gldn025',FALSE)      
   END CASE
END FUNCTION

PRIVATE FUNCTION aglq901_show_visible()
   CALL cl_set_comp_visible('gldn014_desc,l_gldn0142,l_gldn0143',TRUE)
   CALL cl_set_comp_visible('gldn015_desc,l_gldn0152,l_gldn0153',TRUE)
   CALL cl_set_comp_visible('gldn016_desc,l_gldn0162,l_gldn0163',TRUE)
   CALL cl_set_comp_visible('gldn017_desc,l_gldn0172,l_gldn0173',TRUE)
   CALL cl_set_comp_visible('gldn018_desc,l_gldn0182,l_gldn0183',TRUE)
   CALL cl_set_comp_visible('gldn019_desc,l_gldn0192,l_gldn0193',TRUE)
   CALL cl_set_comp_visible('gldn020_desc,l_gldn0202,l_gldn0203',TRUE)
   CALL cl_set_comp_visible('gldn021_desc,l_gldn0212,l_gldn0213',TRUE)
   CALL cl_set_comp_visible('gldn037,l_gldn0372,l_gldn0373',TRUE)
   CALL cl_set_comp_visible('gldn038_desc,l_gldn0382,l_gldn0383',TRUE)
   CALL cl_set_comp_visible('gldn039_desc,l_gldn0392,l_gldn0393',TRUE)
   CALL cl_set_comp_visible('gldn022_desc,l_gldn0222,l_gldn0223',TRUE)
   CALL cl_set_comp_visible('gldn024_desc,l_gldn0242,l_gldn0243',TRUE)
   CALL cl_set_comp_visible('gldn025_desc,l_gldn0252,l_gldn0253',TRUE)
   
   IF g_input.l_chk14='N' THEN
      CALL cl_set_comp_visible('gldn014_desc,l_gldn0142,l_gldn0143',FALSE)
   END IF
   IF g_input.l_chk15='N' THEN
      CALL cl_set_comp_visible('gldn015_desc,l_gldn0152,l_gldn0153',FALSE)
   END IF
   IF g_input.l_chk16='N' THEN
      CALL cl_set_comp_visible('gldn016_desc,l_gldn0162,l_gldn0163',FALSE)
   END IF
   IF g_input.l_chk17='N' THEN
      CALL cl_set_comp_visible('gldn017_desc,l_gldn0172,l_gldn0173',FALSE)
   END IF
   IF g_input.l_chk18='N' THEN
      CALL cl_set_comp_visible('gldn018_desc,l_gldn0182,l_gldn0183',FALSE)
   END IF
   IF g_input.l_chk19='N' THEN
      CALL cl_set_comp_visible('gldn019_desc,l_gldn0192,l_gldn0193',FALSE)
   END IF
   IF g_input.l_chk20='N' THEN
      CALL cl_set_comp_visible('gldn020_desc,l_gldn0202,l_gldn0203',FALSE)
   END IF
   IF g_input.l_chk21='N' THEN
      CALL cl_set_comp_visible('gldn021_desc,l_gldn0212,l_gldn0213',FALSE)
   END IF
   IF g_input.l_chk37='N' THEN
      CALL cl_set_comp_visible('gldn037,l_gldn0372,l_gldn0373',FALSE)
   END IF
   IF g_input.l_chk38='N' THEN
      CALL cl_set_comp_visible('gldn038_desc,l_gldn0382,l_gldn0383',FALSE)
   END IF
   IF g_input.l_chk39='N' THEN
      CALL cl_set_comp_visible('gldn039_desc,l_gldn0392,l_gldn0393',FALSE)
   END IF
   IF g_input.l_chk22='N' THEN
      CALL cl_set_comp_visible('gldn022_desc,l_gldn0222,l_gldn0223',FALSE)
   END IF
   IF g_input.l_chk24='N' THEN
      CALL cl_set_comp_visible('gldn024_desc,l_gldn0242,l_gldn0243',FALSE)
   END IF
   IF g_input.l_chk25='N' THEN
      CALL cl_set_comp_visible('gldn025_desc,l_gldn0252,l_gldn0253',FALSE)
   END IF

END FUNCTION

PRIVATE FUNCTION aglq901_ld_visible()
   DEFINE l_glaa RECORD 
                 glaa015 LIKE glaa_t.glaa015,
                 glaa019 LIKE glaa_t.glaa019                 
                 END RECORD
                 
   IF cl_null(g_gldn_m.gldnld)THEN RETURN END IF
   INITIALIZE l_glaa.* TO NULL        
   SELECT glaa015,glaa019 INTO l_glaa.*
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_gldn_m.gldnld
      
   CALL cl_set_comp_visible('gldn026,bpage_3',TRUE)
   CALL cl_set_comp_visible('gldn029,bpage_4',TRUE)
   IF l_glaa.glaa015 = 'N' THEN
      CALL cl_set_comp_visible('gldn026,bpage_3',FALSE)
   END IF
   
   IF l_glaa.glaa019 = 'N' THEN
      CALL cl_set_comp_visible('gldn029,bpage_4',FALSE)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 2次查詢
# Date & Author..: 150318 By albireo
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq901_filter2()
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
   LET g_gldn_d[l_ac].gldn007 = ''
   DISPLAY ARRAY g_gldn_d TO s_detail1.*
      BEFORE DISPLAY
         EXIT DISPLAY
   END DISPLAY
   CALL aglq901_construct_visible('IN')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON gldn007,gldn008,gldn014,gldn015,gldn016,gldn017,gldn018,gldn019,gldn020, 
          gldn021,gldn037,gldn038,gldn039,gldn022,gldn024,gldn025,gldn034,gldn010,gldn011,gldn035,gldn027, 
          gldn028,gldn036,gldn030,gldn031 
           FROM s_detail1[1].gldn007,s_detail1[1].gldn008,s_detail1[1].gldn014,s_detail1[1].gldn015, 
                s_detail1[1].gldn016,s_detail1[1].gldn017,s_detail1[1].gldn018,s_detail1[1].gldn019,s_detail1[1].gldn020, 
                s_detail1[1].gldn021,s_detail1[1].gldn037,s_detail1[1].gldn038,s_detail1[1].gldn039,s_detail1[1].gldn022, 
                s_detail1[1].gldn024,s_detail1[1].gldn025,s_detail1[1].gldn034,s_detail1[1].gldn010,s_detail1[1].gldn011, 
                s_detail2[1].gldn035,s_detail2[1].gldn027,s_detail2[1].gldn028,s_detail3[1].gldn036,s_detail3[1].gldn030, 
                s_detail3[1].gldn031
         BEFORE CONSTRUCT
           # DISPLAY aglq900_filter_parser('gldn001') TO s_detial1[1].gldn007
         ON ACTION controlp INFIELD gldn007
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " glac003 <>'1' AND glac006 = '1'"
            CALL aglt310_04()
            DISPLAY g_qryparam.return1 TO gldn007  #顯示到畫面上
            NEXT FIELD gldn007

         ON ACTION controlp INFIELD gldn014
            #營運據點
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()    #161021-00037#3 mark
            CALL q_ooef001_01()  #161021-00037#3 add
            DISPLAY g_qryparam.return1 TO gldn014
            NEXT FIELD gldn014
            #END add-point
         ON ACTION controlp INFIELD gldn015
            #部門
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "ooegstus='Y'"
            CALL q_ooeg001_4()
            DISPLAY g_qryparam.return1 TO gldn015
            NEXT FIELD gldn015
         ON ACTION controlp INFIELD gldn016
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "ooegstus='Y' AND ooeg003 IN ('1','2','3')"
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gldn016      #顯示到畫面上
            NEXT FIELD gldn016
         ON ACTION controlp INFIELD gldn017
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_287()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO gldn017      #顯示到畫面上
            NEXT FIELD gldn017
         ON ACTION controlp INFIELD gldn018
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_25()      #160913-00017#3  add
            #CALL q_pmaa001()        #160913-00017#3  mark               #呼叫開窗
            DISPLAY g_qryparam.return1 TO gldn018
            NEXT FIELD gldn018
         ON ACTION controlp INFIELD gldn019
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_pmaa001_25()      #160913-00017#3  add
            #CALL q_pmaa001()        #160913-00017#3  mark               #呼叫開窗
            DISPLAY g_qryparam.return1 TO gldn019
            NEXT FIELD gldn019
         ON ACTION controlp INFIELD gldn020
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_oocq002_281()
            DISPLAY g_qryparam.return1 TO gldn020
            NEXT FIELD gldn020
         ON ACTION controlp INFIELD gldn021
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gldn021      #顯示到畫面上
            NEXT FIELD gldn021
         ON ACTION controlp INFIELD gldn038
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            LET g_qryparam.where = " oojdstus='Y' "
            CALL q_oojd001_2()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO gldn038    #顯示到畫面上
            NEXT FIELD gldn038
         ON ACTION controlp INFIELD gldn039
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_oocq002_2002()                            #呼叫開窗
            DISPLAY g_qryparam.return1 TO gldn039      #顯示到畫面上
            NEXT FIELD gldn039
         ON ACTION controlp INFIELD gldn022
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_ooag001_8()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gldn022     #顯示到畫面上
            NEXT FIELD gldn022
         ON ACTION controlp INFIELD gldn024
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_pjba001()                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO gldn024     #顯示到畫面上
            NEXT FIELD gldn024
         ON ACTION controlp INFIELD gldn025  
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            LET g_qryparam.where = "pjbb012='1' "
            CALL q_pjbb002()                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO gldn025     #顯示到畫面上
            NEXT FIELD gldn025
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
   CALL aglq901_construct_visible('OUT')
END FUNCTION

################################################################################
# Descriptions...: 建立臨時表
# Memo...........: #160517-00002#2
# Usage..........: CALL aglq901_create_tmp()
# Date & Author..: 160602 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq901_create_tmp()
   #建立臨時表     
   DROP TABLE aglq901_x01_tmp;
   CREATE TEMP TABLE aglq901_x01_tmp(
      gldnent        LIKE gldn_t.gldnent, 
      l_gldnld_desc  LIKE type_t.chr80, 
      l_gldn001_desc LIKE type_t.chr80, 
      l_gldn002_desc LIKE type_t.chr80, 
      gldn005        LIKE gldn_t.gldn005, 
      gldn006        LIKE gldn_t.gldn006, 
      gldn009        LIKE gldn_t.gldn009, 
      gldn026        LIKE gldn_t.gldn026, 
      gldn029        LIKE gldn_t.gldn029, 
      gldn007        LIKE gldn_t.gldn007, 
      l_gldn007_desc LIKE type_t.chr100, 
      l_gldn014_desc LIKE type_t.chr100, 
      l_gldn015_desc LIKE type_t.chr100, 
      l_gldn016_desc LIKE type_t.chr100, 
      l_gldn017_desc LIKE type_t.chr100, 
      l_gldn018_desc LIKE type_t.chr100, 
      l_gldn019_desc LIKE type_t.chr100, 
      l_gldn020_desc LIKE type_t.chr100, 
      l_gldn021_desc LIKE type_t.chr100, 
      l_gldn037_desc LIKE type_t.chr80,
      l_gldn038_desc LIKE type_t.chr100, 
      l_gldn039_desc LIKE type_t.chr100, 
      l_gldn022_desc LIKE type_t.chr100, 
      l_gldn024_desc LIKE type_t.chr100, 
      l_gldn025_desc LIKE type_t.chr100, 
      gldn034        LIKE gldn_t.gldn034, 
      gldn010        LIKE gldn_t.gldn010, 
      gldn011        LIKE gldn_t.gldn011, 
      l_gldn011      LIKE type_t.num20_6,
      gldn035        LIKE gldn_t.gldn035, 
      gldn027        LIKE gldn_t.gldn027, 
      gldn028        LIKE gldn_t.gldn028, 
      l_gldn028      LIKE type_t.num20_6,
      gldn036        LIKE gldn_t.gldn036, 
      gldn030        LIKE gldn_t.gldn030, 
      gldn031        LIKE gldn_t.gldn031, 
      l_gldn031      LIKE type_t.num20_6
      )
      
END FUNCTION

################################################################################
# Descriptions...: 報表列印
# Memo...........: #160517-00002#2
# Usage..........: CALL aglq901_ins_x01_tmp()
# Date & Author..: 160602 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq901_ins_x01_tmp()
DEFINE l_i            LIKE type_t.num5
DEFINE l_gldnld_desc  LIKE type_t.chr80
DEFINE l_gldn001_desc LIKE type_t.chr80
DEFINE l_gldn002_desc LIKE type_t.chr80
DEFINE l_gldn037_desc LIKE type_t.chr80
DEFINE l_gldn037      LIKE type_t.chr80

   LET l_gldnld_desc = g_gldn_m.gldnld,':',g_gldn_m.gldnld_desc 
   LET l_gldn001_desc = g_gldn_m.gldn001,':',g_gldn_m.gldn001_desc
   LET l_gldn002_desc = g_gldn_m.gldn002,':',g_gldn_m.gldn002_desc   

   DELETE FROM aglq901_x01_tmp

   LET l_i = 1
   FOR l_i = 1 TO g_gldn_d.getLength()     
      LET l_gldn037_desc = g_gldn_d[l_i].gldn037,":",s_desc_gzcbl004_desc('6013',g_gldn_d[l_i].gldn037)   
      LET l_gldn037 = s_desc_gzcbl004_desc('6013',g_gldn_d[l_i].gldn037)
      IF cl_null(l_gldn037) THEN LET l_gldn037_desc = g_gldn_d[l_i].gldn037 END IF
      INSERT INTO aglq901_x01_tmp
      VALUES(g_enterprise,l_gldnld_desc,l_gldn001_desc,l_gldn002_desc,
             g_gldn_m.gldn005,g_gldn_m.gldn006,g_gldn_m.gldn009,g_gldn_m.gldn026,
             g_gldn_m.gldn029,g_gldn_d[l_i].gldn007,g_gldn_d[l_i].gldn007_desc,
             g_gldn_d[l_i].gldn014_desc,g_gldn_d[l_i].gldn015_desc,g_gldn_d[l_i].gldn016_desc,
             g_gldn_d[l_i].gldn017_desc,g_gldn_d[l_i].gldn018_desc,g_gldn_d[l_i].gldn019_desc,
             g_gldn_d[l_i].gldn020_desc,g_gldn_d[l_i].gldn021_desc,l_gldn037_desc,
             g_gldn_d[l_i].gldn038_desc,g_gldn_d[l_i].gldn039_desc,g_gldn_d[l_i].gldn022_desc,
             g_gldn_d[l_i].gldn024_desc,g_gldn_d[l_i].gldn025_desc,g_gldn_d[l_i].gldn034,
             g_gldn_d[l_i].gldn010,g_gldn_d[l_i].gldn011,g_gldn_d[l_i].l_gldn011,
             g_gldn2_d[l_i].gldn035,g_gldn2_d[l_i].gldn027,g_gldn2_d[l_i].gldn028,
             g_gldn2_d[l_i].l_gldn028,g_gldn3_d[l_i].gldn036,g_gldn3_d[l_i].gldn030,
             g_gldn3_d[l_i].gldn031,g_gldn3_d[l_i].l_gldn031             
             )
   END FOR
   CALL aglq901_xg_visible()
   
END FUNCTION

################################################################################
# Descriptions...: 傳進XG報表隱藏欄位設置
# Memo...........: #160517-00002#2
# Usage..........: CALL aglq901_xg_visible()
# Date & Author..: 160602 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq901_xg_visible()
DEFINE l_glaa015  LIKE glaa_t.glaa015
DEFINE l_glaa019  LIKE glaa_t.glaa019

   LET g_xg_visible = NULL
  
   LET l_glaa015 = ''
   LET l_glaa019 = ''
   SELECT glaa015,glaa019 INTO l_glaa015,l_glaa019 
     FROM glaa_t
    WHERE glaaent = g_enterprise AND glaald = g_gldn_m.gldnld
   
   IF l_glaa015 = 'N' THEN #功能幣啟用否
      LET g_xg_visible = "gldn035|gldn027|gldn028|l_gldn028"
   END IF
   
   IF l_glaa019 = 'N' THEN #報告幣啟用否
      IF NOT cl_null(g_xg_visible)THEN       
         LET g_xg_visible = g_xg_visible CLIPPED ,"|gldn036|gldn030|gldn031|l_gldn031"
      ELSE
         LET g_xg_visible = "gldn036|gldn030|gldn031|l_gldn031"
      END IF
   END IF
   
   #核算項
   IF g_input.l_chk14 ='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"l_gldn014_desc"
   END IF
   
   IF g_input.l_chk15 ='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"l_gldn015_desc"
   END IF
   
   IF g_input.l_chk16 ='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"l_gldn016_desc"
   END IF
   
   IF g_input.l_chk17='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"l_gldn017_desc"
   END IF
   
   IF g_input.l_chk18 ='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"l_gldn018_desc"
   END IF
   
   IF g_input.l_chk19 ='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"l_gldn019_desc"
   END IF
   
   IF g_input.l_chk20 ='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"l_gldn020_desc"
   END IF
   
   IF g_input.l_chk21 ='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"l_gldn021_desc"
   END IF
   #經營方式
   IF g_input.l_chk37 ='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"l_gldn037_desc"
   END IF

   IF g_input.l_chk38 ='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"l_gldn038_desc"
   END IF

   IF g_input.l_chk39 ='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"l_gldn039_desc"
   END IF
   
   IF g_input.l_chk22 ='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"l_gldn022_desc"
   END IF 
    
   IF g_input.l_chk24 ='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"l_gldn024_desc"
   END IF
   
   IF g_input.l_chk25 ='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"l_gldn025_desc"
   END IF
END FUNCTION

 
{</section>}
 
