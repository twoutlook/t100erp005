#該程式未解開Section, 採用最新樣板產出!
{<section id="aglq936.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2016-06-03 17:41:38), PR版次:0004(2016-10-24 11:52:57)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000029
#+ Filename...: aglq936
#+ Description: 合併報表合併後各期科目核算項餘額查詢作業
#+ Creator....: 06821(2015-12-16 11:42:45)
#+ Modifier...: 06821 -SD/PR- 06821
 
{</section>}
 
{<section id="aglq936.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#160517-00002#10 160604  By 06821  查詢加上轉XG功能
#160913-00017#4  2016/09/21  By 07900   AGL模组调整交易客商开窗
#161021-00037#3  2016/10/24  By 06821   組織類型與職能開窗調整
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
PRIVATE type type_g_glea_m        RECORD
       gleald LIKE glea_t.gleald, 
   gleald_desc LIKE type_t.chr80, 
   glea001 LIKE glea_t.glea001, 
   glea001_desc LIKE type_t.chr80, 
   glea003 LIKE glea_t.glea003, 
   glea004 LIKE glea_t.glea004, 
   l_glea007 LIKE type_t.chr10, 
   l_glea026 LIKE type_t.chr10, 
   l_glea029 LIKE type_t.chr10, 
   l_chk12 LIKE type_t.chr1, 
   l_chk13 LIKE type_t.chr1, 
   l_chk14 LIKE type_t.chr1, 
   l_chk15 LIKE type_t.chr1, 
   l_chk16 LIKE type_t.chr1, 
   l_chk17 LIKE type_t.chr1, 
   l_chk18 LIKE type_t.chr1, 
   l_chk19 LIKE type_t.chr1, 
   l_chk20 LIKE type_t.chr1, 
   l_chk21 LIKE type_t.chr1, 
   l_chk22 LIKE type_t.chr1, 
   l_chk23 LIKE type_t.chr1, 
   l_chk24 LIKE type_t.chr1, 
   l_chk25 LIKE type_t.chr1
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_glea_d        RECORD
       glea005 LIKE glea_t.glea005, 
   glea005_desc LIKE type_t.chr500, 
   glea012 LIKE glea_t.glea012, 
   glea012_desc LIKE type_t.chr500, 
   glea013 LIKE glea_t.glea013, 
   glea013_desc LIKE type_t.chr500, 
   glea014 LIKE glea_t.glea014, 
   glea014_desc LIKE type_t.chr500, 
   glea015 LIKE glea_t.glea015, 
   glea015_desc LIKE type_t.chr500, 
   glea016 LIKE glea_t.glea016, 
   glea016_desc LIKE type_t.chr500, 
   glea017 LIKE glea_t.glea017, 
   glea017_desc LIKE type_t.chr500, 
   glea018 LIKE glea_t.glea018, 
   glea018_desc LIKE type_t.chr500, 
   glea019 LIKE glea_t.glea019, 
   glea019_desc LIKE type_t.chr500, 
   glea020 LIKE glea_t.glea020, 
   glea021 LIKE glea_t.glea021, 
   glea021_desc LIKE type_t.chr500, 
   glea022 LIKE glea_t.glea022, 
   glea022_desc LIKE type_t.chr500, 
   glea023 LIKE glea_t.glea023, 
   glea023_desc LIKE type_t.chr500, 
   glea024 LIKE glea_t.glea024, 
   glea024_desc LIKE type_t.chr500, 
   glea025 LIKE glea_t.glea025, 
   glea025_desc LIKE type_t.chr500, 
   glea034 LIKE glea_t.glea034, 
   glea008 LIKE glea_t.glea008, 
   glea009 LIKE glea_t.glea009, 
   l_amt LIKE type_t.num20_6, 
   glea007 LIKE glea_t.glea007, 
   glea002 LIKE glea_t.glea002, 
   glea006 LIKE glea_t.glea006, 
   glea032 LIKE glea_t.glea032, 
   glea033 LIKE glea_t.glea033
       END RECORD
PRIVATE TYPE type_g_glea2_d RECORD
       glea005 LIKE glea_t.glea005, 
   glea0052_desc LIKE type_t.chr500, 
   l_glea0122 LIKE type_t.chr500, 
   l_glea0132 LIKE type_t.chr500, 
   l_glea0142 LIKE type_t.chr500, 
   l_glea0152 LIKE type_t.chr500, 
   l_glea0162 LIKE type_t.chr500, 
   l_glea0172 LIKE type_t.chr500, 
   l_glea0182 LIKE type_t.chr500, 
   l_glea0192 LIKE type_t.chr500, 
   l_glea0202 LIKE type_t.chr500, 
   l_glea0212 LIKE type_t.chr500, 
   l_glea0222 LIKE type_t.chr500, 
   l_glea0232 LIKE type_t.chr500, 
   l_glea0242 LIKE type_t.chr500, 
   l_glea0252 LIKE type_t.chr500, 
   glea035 LIKE glea_t.glea035, 
   glea027 LIKE glea_t.glea027, 
   glea028 LIKE glea_t.glea028, 
   l_amt2 LIKE type_t.num20_6, 
   glea026 LIKE glea_t.glea026, 
   glea002 LIKE glea_t.glea002, 
   glea006 LIKE glea_t.glea006, 
   glea032 LIKE glea_t.glea032, 
   glea033 LIKE glea_t.glea033
       END RECORD
PRIVATE TYPE type_g_glea3_d RECORD
       glea005 LIKE glea_t.glea005, 
   glea0053_desc LIKE type_t.chr500, 
   l_glea0123 LIKE type_t.chr500, 
   l_glea0133 LIKE type_t.chr500, 
   l_glea0143 LIKE type_t.chr500, 
   l_glea0153 LIKE type_t.chr500, 
   l_glea0163 LIKE type_t.chr500, 
   l_glea0173 LIKE type_t.chr500, 
   l_glea0183 LIKE type_t.chr500, 
   l_glea0193 LIKE type_t.chr500, 
   l_glea0203 LIKE type_t.chr500, 
   l_glea0213 LIKE type_t.chr500, 
   l_glea0223 LIKE type_t.chr500, 
   l_glea0233 LIKE type_t.chr500, 
   l_glea0243 LIKE type_t.chr500, 
   l_glea0253 LIKE type_t.chr500, 
   glea036 LIKE glea_t.glea036, 
   glea030 LIKE glea_t.glea030, 
   glea031 LIKE glea_t.glea031, 
   l_amt3 LIKE type_t.num20_6, 
   glea029 LIKE glea_t.glea029, 
   glea002 LIKE glea_t.glea002, 
   glea006 LIKE glea_t.glea006, 
   glea032 LIKE glea_t.glea032, 
   glea033 LIKE glea_t.glea033
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
#核算項顯示否
DEFINE g_input    RECORD
       l_chk12    LIKE type_t.chr80, 
       l_chk13    LIKE type_t.chr80, 
       l_chk14    LIKE type_t.chr80, 
       l_chk15    LIKE type_t.chr80, 
       l_chk16    LIKE type_t.chr80, 
       l_chk17    LIKE type_t.chr80, 
       l_chk18    LIKE type_t.chr80, 
       l_chk19    LIKE type_t.chr80, 
       l_chk20    LIKE type_t.chr80, 
       l_chk21    LIKE type_t.chr80, 
       l_chk22    LIKE type_t.chr80,
       l_chk23    LIKE type_t.chr80, 
       l_chk24    LIKE type_t.chr80, 
       l_chk25    LIKE type_t.chr80
                  END RECORD
DEFINE g_xg_visible          STRING     #XG欄位隱藏條件      #160517-00002#10                  
#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_glea_m          type_g_glea_m
DEFINE g_glea_m_t        type_g_glea_m
DEFINE g_glea_m_o        type_g_glea_m
DEFINE g_glea_m_mask_o   type_g_glea_m #轉換遮罩前資料
DEFINE g_glea_m_mask_n   type_g_glea_m #轉換遮罩後資料
 
   DEFINE g_gleald_t LIKE glea_t.gleald
DEFINE g_glea001_t LIKE glea_t.glea001
DEFINE g_glea003_t LIKE glea_t.glea003
DEFINE g_glea004_t LIKE glea_t.glea004
 
 
DEFINE g_glea_d          DYNAMIC ARRAY OF type_g_glea_d
DEFINE g_glea_d_t        type_g_glea_d
DEFINE g_glea_d_o        type_g_glea_d
DEFINE g_glea_d_mask_o   DYNAMIC ARRAY OF type_g_glea_d #轉換遮罩前資料
DEFINE g_glea_d_mask_n   DYNAMIC ARRAY OF type_g_glea_d #轉換遮罩後資料
DEFINE g_glea2_d   DYNAMIC ARRAY OF type_g_glea2_d
DEFINE g_glea2_d_t type_g_glea2_d
DEFINE g_glea2_d_o type_g_glea2_d
DEFINE g_glea2_d_mask_o   DYNAMIC ARRAY OF type_g_glea2_d #轉換遮罩前資料
DEFINE g_glea2_d_mask_n   DYNAMIC ARRAY OF type_g_glea2_d #轉換遮罩後資料
DEFINE g_glea3_d   DYNAMIC ARRAY OF type_g_glea3_d
DEFINE g_glea3_d_t type_g_glea3_d
DEFINE g_glea3_d_o type_g_glea3_d
DEFINE g_glea3_d_mask_o   DYNAMIC ARRAY OF type_g_glea3_d #轉換遮罩前資料
DEFINE g_glea3_d_mask_n   DYNAMIC ARRAY OF type_g_glea3_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_gleald LIKE glea_t.gleald,
      b_glea001 LIKE glea_t.glea001,
      b_glea003 LIKE glea_t.glea003,
      b_glea004 LIKE glea_t.glea004
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
 
{<section id="aglq936.main" >}
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
   LET g_forupd_sql = " SELECT gleald,'',glea001,'',glea003,glea004,'','','','','','','','','','','', 
       '','','','','',''", 
                      " FROM glea_t",
                      " WHERE gleaent= ? AND gleald=? AND glea001=? AND glea003=? AND glea004=? FOR  
                          UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aglq936_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.gleald,t0.glea001,t0.glea003,t0.glea004",
               " FROM glea_t t0",
               
               " WHERE t0.gleaent = " ||g_enterprise|| " AND t0.gleald = ? AND t0.glea001 = ? AND t0.glea003 = ? AND t0.glea004 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aglq936_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aglq936 WITH FORM cl_ap_formpath("agl",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aglq936_init()   
 
      #進入選單 Menu (="N")
      CALL aglq936_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aglq936
      
   END IF 
   
   CLOSE aglq936_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aglq936.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aglq936_init()
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
   CALL cl_set_combo_scc('glea020','6013')   #經營方式
   CALL cl_set_combo_scc('l_glea0202','6013') 
   CALL cl_set_combo_scc('l_glea0203','6013')
   CALL aglq936_construct_visible('1')
   #end add-point
   
   CALL aglq936_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aglq936.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION aglq936_ui_dialog()
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
   CALL aglq936_create_tmp() #160517-00002#10
   #end add-point
   
   WHILE TRUE
      
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_glea_m.* TO NULL
         CALL g_glea_d.clear()
         CALL g_glea2_d.clear()
         CALL g_glea3_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aglq936_init()
      END IF
 
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
        
         DISPLAY ARRAY g_glea_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL aglq936_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL aglq936_ui_detailshow()
               
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
        
         DISPLAY ARRAY g_glea2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL aglq936_idx_chk()
               CALL aglq936_ui_detailshow()
               
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
         DISPLAY ARRAY g_glea3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL aglq936_idx_chk()
               CALL aglq936_ui_detailshow()
               
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
            CALL aglq936_filter2()
            EXIT DIALOG
         #end add-point
         
         
         BEFORE DIALOG
            #先填充browser資料
            CALL aglq936_browser_fill("")
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
               CALL aglq936_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aglq936_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
 
            #end add-point
 
         
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL aglq936_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aglq936_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL aglq936_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aglq936_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL aglq936_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aglq936_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL aglq936_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aglq936_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL aglq936_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aglq936_idx_chk()
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
                  LET g_export_node[1] = base.typeInfo.create(g_glea_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_glea2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_glea3_d)
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
               NEXT FIELD glea002
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
               CALL aglq936_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL aglq936_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL aglq936_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               ##160517-00002#10 --s add
               CALL aglq936_ins_x01_tmp()
               CALL aglq936_x01(' 1=1','aglq936_x01_tmp',g_xg_visible)
               ##160517-00002#10 --e add
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               ##160517-00002#10 --s add
               CALL aglq936_ins_x01_tmp()
               CALL aglq936_x01(' 1=1','aglq936_x01_tmp',g_xg_visible)
               ##160517-00002#10 --e add
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aglq936_query()
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
            CALL aglq936_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aglq936_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aglq936_set_pk_array()
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
 
{<section id="aglq936.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION aglq936_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aglq936.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION aglq936_browser_fill(ps_page_action)
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
 
   LET l_searchcol = "gleald,glea001,glea003,glea004"
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
      LET l_sub_sql = " SELECT DISTINCT gleald ",
                      ", glea001 ",
                      ", glea003 ",
                      ", glea004 ",
 
                      " FROM glea_t ",
                      " ",
                      " ", 
 
 
 
                      " WHERE gleaent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("glea_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT gleald ",
                      ", glea001 ",
                      ", glea003 ",
                      ", glea004 ",
 
                      " FROM glea_t ",
                      " ",
                      " ", 
 
 
                      " WHERE gleaent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("glea_t")
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
      INITIALIZE g_glea_m.* TO NULL
      CALL g_glea_d.clear()        
      CALL g_glea2_d.clear() 
      CALL g_glea3_d.clear() 
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.gleald,t0.glea001,t0.glea003,t0.glea004 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.gleald,t0.glea001,t0.glea003,t0.glea004",
                " FROM glea_t t0",
                #" ",
                " ",
 
 
 
                
                " WHERE t0.gleaent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("glea_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
   
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"glea_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_gleald,g_browser[g_cnt].b_glea001,g_browser[g_cnt].b_glea003, 
          g_browser[g_cnt].b_glea004 
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
   
   IF cl_null(g_browser[g_cnt].b_gleald) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_glea_m.* TO NULL
      CALL g_glea_d.clear()
      CALL g_glea2_d.clear()
      CALL g_glea3_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL aglq936_fetch('')
   
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
 
{<section id="aglq936.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION aglq936_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_glea_m.gleald = g_browser[g_current_idx].b_gleald   
   LET g_glea_m.glea001 = g_browser[g_current_idx].b_glea001   
   LET g_glea_m.glea003 = g_browser[g_current_idx].b_glea003   
   LET g_glea_m.glea004 = g_browser[g_current_idx].b_glea004   
 
   EXECUTE aglq936_master_referesh USING g_glea_m.gleald,g_glea_m.glea001,g_glea_m.glea003,g_glea_m.glea004 INTO g_glea_m.gleald, 
       g_glea_m.glea001,g_glea_m.glea003,g_glea_m.glea004
   CALL aglq936_show()
   
END FUNCTION
 
{</section>}
 
{<section id="aglq936.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION aglq936_ui_detailshow()
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
 
{<section id="aglq936.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aglq936_ui_browser_refresh()
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
      IF g_browser[l_i].b_gleald = g_glea_m.gleald 
         AND g_browser[l_i].b_glea001 = g_glea_m.glea001 
         AND g_browser[l_i].b_glea003 = g_glea_m.glea003 
         AND g_browser[l_i].b_glea004 = g_glea_m.glea004 
 
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
 
{<section id="aglq936.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aglq936_construct()
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
   INITIALIZE g_glea_m.* TO NULL
   CALL g_glea_d.clear()
   CALL g_glea2_d.clear()
   CALL g_glea3_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   CALL aglq936_qbe_clear()
   CALL cl_set_comp_visible('l_glea026,page_3',TRUE)
   CALL cl_set_comp_visible('l_glea029,page_4',TRUE)
   CALL aglq936_construct_visible('2')
   CALL aglq936_filter_show2('glea005',FALSE) 
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON gleald,glea001,glea003,glea004
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
                 #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gleald
            #add-point:BEFORE FIELD gleald name="construct.b.gleald"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gleald
            
            #add-point:AFTER FIELD gleald name="construct.a.gleald"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gleald
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gleald
            #add-point:ON ACTION controlp INFIELD gleald name="construct.c.gleald"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_grup
            LET g_qryparam.where = " glaald IN (SELECT gldbld FROM gldb_t WHERE gldbent = '",g_enterprise,"') "
            CALL q_authorised_ld()
            DISPLAY g_qryparam.return1 TO gleald
            NEXT FIELD gleald
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea001
            #add-point:BEFORE FIELD glea001 name="construct.b.glea001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea001
            
            #add-point:AFTER FIELD glea001 name="construct.a.glea001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glea001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea001
            #add-point:ON ACTION controlp INFIELD glea001 name="construct.c.glea001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_glda001()
            DISPLAY g_qryparam.return1 TO glea001
            NEXT FIELD glea001
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea003
            #add-point:BEFORE FIELD glea003 name="construct.b.glea003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea003
            
            #add-point:AFTER FIELD glea003 name="construct.a.glea003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glea003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea003
            #add-point:ON ACTION controlp INFIELD glea003 name="construct.c.glea003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea004
            #add-point:BEFORE FIELD glea004 name="construct.b.glea004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea004
            
            #add-point:AFTER FIELD glea004 name="construct.a.glea004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glea004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea004
            #add-point:ON ACTION controlp INFIELD glea004 name="construct.c.glea004"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON glea005,glea012,glea013,glea014,glea015,glea016,glea017,glea018,glea019, 
          glea021,glea022,glea023,glea024,glea025,glea034,glea008,glea009,glea002,glea006,glea032,glea033, 
          glea035,glea027,glea028,glea036,glea030,glea031
           FROM s_detail1[1].glea005,s_detail1[1].glea012,s_detail1[1].glea013,s_detail1[1].glea014, 
               s_detail1[1].glea015,s_detail1[1].glea016,s_detail1[1].glea017,s_detail1[1].glea018,s_detail1[1].glea019, 
               s_detail1[1].glea021,s_detail1[1].glea022,s_detail1[1].glea023,s_detail1[1].glea024,s_detail1[1].glea025, 
               s_detail1[1].glea034,s_detail1[1].glea008,s_detail1[1].glea009,s_detail1[1].glea002,s_detail1[1].glea006, 
               s_detail1[1].glea032,s_detail1[1].glea033,s_detail2[1].glea035,s_detail2[1].glea027,s_detail2[1].glea028, 
               s_detail3[1].glea036,s_detail3[1].glea030,s_detail3[1].glea031
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea005
            #add-point:BEFORE FIELD glea005 name="construct.b.page1.glea005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea005
            
            #add-point:AFTER FIELD glea005 name="construct.a.page1.glea005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glea005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea005
            #add-point:ON ACTION controlp INFIELD glea005 name="construct.c.page1.glea005"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " glac003 <>'1' AND glac006 = '1'"
            CALL aglt310_04()
            DISPLAY g_qryparam.return1 TO glea005  #顯示到畫面上
            NEXT FIELD glea005
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea012
            #add-point:BEFORE FIELD glea012 name="construct.b.page1.glea012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea012
            
            #add-point:AFTER FIELD glea012 name="construct.a.page1.glea012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glea012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea012
            #add-point:ON ACTION controlp INFIELD glea012 name="construct.c.page1.glea012"
            #營運據點
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()    #161021-00037#3 mark
            CALL q_ooef001_01()  #161021-00037#3 add
            DISPLAY g_qryparam.return1 TO glea012
            NEXT FIELD glea012
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea013
            #add-point:BEFORE FIELD glea013 name="construct.b.page1.glea013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea013
            
            #add-point:AFTER FIELD glea013 name="construct.a.page1.glea013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glea013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea013
            #add-point:ON ACTION controlp INFIELD glea013 name="construct.c.page1.glea013"
            #部門
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "ooegstus='Y'"
            CALL q_ooeg001_4()
            DISPLAY g_qryparam.return1 TO glea013
            NEXT FIELD glea013
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea014
            #add-point:BEFORE FIELD glea014 name="construct.b.page1.glea014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea014
            
            #add-point:AFTER FIELD glea014 name="construct.a.page1.glea014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glea014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea014
            #add-point:ON ACTION controlp INFIELD glea014 name="construct.c.page1.glea014"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "ooegstus='Y' AND ooeg003 IN ('1','2','3')"
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glea014      #顯示到畫面上
            NEXT FIELD glea014
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea015
            #add-point:BEFORE FIELD glea015 name="construct.b.page1.glea015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea015
            
            #add-point:AFTER FIELD glea015 name="construct.a.page1.glea015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glea015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea015
            #add-point:ON ACTION controlp INFIELD glea015 name="construct.c.page1.glea015"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_287()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO glea015      #顯示到畫面上
            NEXT FIELD glea015
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea016
            #add-point:BEFORE FIELD glea016 name="construct.b.page1.glea016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea016
            
            #add-point:AFTER FIELD glea016 name="construct.a.page1.glea016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glea016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea016
            #add-point:ON ACTION controlp INFIELD glea016 name="construct.c.page1.glea016"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_25()      #160913-00017#4  add
            #CALL q_pmaa001()        #160913-00017#4  mark               #呼叫開窗      
            DISPLAY g_qryparam.return1 TO glea016
            NEXT FIELD glea016
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea017
            #add-point:BEFORE FIELD glea017 name="construct.b.page1.glea017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea017
            
            #add-point:AFTER FIELD glea017 name="construct.a.page1.glea017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glea017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea017
            #add-point:ON ACTION controlp INFIELD glea017 name="construct.c.page1.glea017"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_pmaa001_25()      #160913-00017#4  add
            #CALL q_pmaa001()        #160913-00017#4  mark               #呼叫開窗      
            DISPLAY g_qryparam.return1 TO glea017
            NEXT FIELD glea017
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea018
            #add-point:BEFORE FIELD glea018 name="construct.b.page1.glea018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea018
            
            #add-point:AFTER FIELD glea018 name="construct.a.page1.glea018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glea018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea018
            #add-point:ON ACTION controlp INFIELD glea018 name="construct.c.page1.glea018"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_oocq002_281()
            DISPLAY g_qryparam.return1 TO glea018
            NEXT FIELD glea018
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea019
            #add-point:BEFORE FIELD glea019 name="construct.b.page1.glea019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea019
            
            #add-point:AFTER FIELD glea019 name="construct.a.page1.glea019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glea019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea019
            #add-point:ON ACTION controlp INFIELD glea019 name="construct.c.page1.glea019"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glea019      #顯示到畫面上
            NEXT FIELD glea019
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea021
            #add-point:BEFORE FIELD glea021 name="construct.b.page1.glea021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea021
            
            #add-point:AFTER FIELD glea021 name="construct.a.page1.glea021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glea021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea021
            #add-point:ON ACTION controlp INFIELD glea021 name="construct.c.page1.glea021"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            LET g_qryparam.where = " oojdstus='Y' "
            CALL q_oojd001_2()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO glea021    #顯示到畫面上
            NEXT FIELD glea021
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea022
            #add-point:BEFORE FIELD glea022 name="construct.b.page1.glea022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea022
            
            #add-point:AFTER FIELD glea022 name="construct.a.page1.glea022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glea022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea022
            #add-point:ON ACTION controlp INFIELD glea022 name="construct.c.page1.glea022"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_oocq002_2002()                            #呼叫開窗
            DISPLAY g_qryparam.return1 TO glea022      #顯示到畫面上
            NEXT FIELD glea022
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea023
            #add-point:BEFORE FIELD glea023 name="construct.b.page1.glea023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea023
            
            #add-point:AFTER FIELD glea023 name="construct.a.page1.glea023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glea023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea023
            #add-point:ON ACTION controlp INFIELD glea023 name="construct.c.page1.glea023"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_ooag001_8()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glea023     #顯示到畫面上
            NEXT FIELD glea023
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea024
            #add-point:BEFORE FIELD glea024 name="construct.b.page1.glea024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea024
            
            #add-point:AFTER FIELD glea024 name="construct.a.page1.glea024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glea024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea024
            #add-point:ON ACTION controlp INFIELD glea024 name="construct.c.page1.glea024"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_pjba001()                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO glea024     #顯示到畫面上
            NEXT FIELD glea024
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea025
            #add-point:BEFORE FIELD glea025 name="construct.b.page1.glea025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea025
            
            #add-point:AFTER FIELD glea025 name="construct.a.page1.glea025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glea025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea025
            #add-point:ON ACTION controlp INFIELD glea025 name="construct.c.page1.glea025"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            LET g_qryparam.where = "pjbb012='1' "
            CALL q_pjbb002()                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO glea025     #顯示到畫面上
            NEXT FIELD glea025
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea034
            #add-point:BEFORE FIELD glea034 name="construct.b.page1.glea034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea034
            
            #add-point:AFTER FIELD glea034 name="construct.a.page1.glea034"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glea034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea034
            #add-point:ON ACTION controlp INFIELD glea034 name="construct.c.page1.glea034"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea008
            #add-point:BEFORE FIELD glea008 name="construct.b.page1.glea008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea008
            
            #add-point:AFTER FIELD glea008 name="construct.a.page1.glea008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glea008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea008
            #add-point:ON ACTION controlp INFIELD glea008 name="construct.c.page1.glea008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea009
            #add-point:BEFORE FIELD glea009 name="construct.b.page1.glea009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea009
            
            #add-point:AFTER FIELD glea009 name="construct.a.page1.glea009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glea009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea009
            #add-point:ON ACTION controlp INFIELD glea009 name="construct.c.page1.glea009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea002
            #add-point:BEFORE FIELD glea002 name="construct.b.page1.glea002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea002
            
            #add-point:AFTER FIELD glea002 name="construct.a.page1.glea002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glea002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea002
            #add-point:ON ACTION controlp INFIELD glea002 name="construct.c.page1.glea002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea006
            #add-point:BEFORE FIELD glea006 name="construct.b.page1.glea006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea006
            
            #add-point:AFTER FIELD glea006 name="construct.a.page1.glea006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glea006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea006
            #add-point:ON ACTION controlp INFIELD glea006 name="construct.c.page1.glea006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea032
            #add-point:BEFORE FIELD glea032 name="construct.b.page1.glea032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea032
            
            #add-point:AFTER FIELD glea032 name="construct.a.page1.glea032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glea032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea032
            #add-point:ON ACTION controlp INFIELD glea032 name="construct.c.page1.glea032"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea033
            #add-point:BEFORE FIELD glea033 name="construct.b.page1.glea033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea033
            
            #add-point:AFTER FIELD glea033 name="construct.a.page1.glea033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glea033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea033
            #add-point:ON ACTION controlp INFIELD glea033 name="construct.c.page1.glea033"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea035
            #add-point:BEFORE FIELD glea035 name="construct.b.page2.glea035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea035
            
            #add-point:AFTER FIELD glea035 name="construct.a.page2.glea035"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.glea035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea035
            #add-point:ON ACTION controlp INFIELD glea035 name="construct.c.page2.glea035"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea027
            #add-point:BEFORE FIELD glea027 name="construct.b.page2.glea027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea027
            
            #add-point:AFTER FIELD glea027 name="construct.a.page2.glea027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.glea027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea027
            #add-point:ON ACTION controlp INFIELD glea027 name="construct.c.page2.glea027"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea028
            #add-point:BEFORE FIELD glea028 name="construct.b.page2.glea028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea028
            
            #add-point:AFTER FIELD glea028 name="construct.a.page2.glea028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.glea028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea028
            #add-point:ON ACTION controlp INFIELD glea028 name="construct.c.page2.glea028"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea036
            #add-point:BEFORE FIELD glea036 name="construct.b.page3.glea036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea036
            
            #add-point:AFTER FIELD glea036 name="construct.a.page3.glea036"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.glea036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea036
            #add-point:ON ACTION controlp INFIELD glea036 name="construct.c.page3.glea036"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea030
            #add-point:BEFORE FIELD glea030 name="construct.b.page3.glea030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea030
            
            #add-point:AFTER FIELD glea030 name="construct.a.page3.glea030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.glea030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea030
            #add-point:ON ACTION controlp INFIELD glea030 name="construct.c.page3.glea030"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea031
            #add-point:BEFORE FIELD glea031 name="construct.b.page3.glea031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea031
            
            #add-point:AFTER FIELD glea031 name="construct.a.page3.glea031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.glea031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea031
            #add-point:ON ACTION controlp INFIELD glea031 name="construct.c.page3.glea031"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
  
 
  
      #add-point:cs段more_construct name="cs.more_construct"
      INPUT BY NAME g_input.l_chk12,g_input.l_chk13,g_input.l_chk14,g_input.l_chk15,g_input.l_chk16,
                    g_input.l_chk17,g_input.l_chk18,g_input.l_chk19,g_input.l_chk20,g_input.l_chk21,
                    g_input.l_chk22,g_input.l_chk23,g_input.l_chk24,g_input.l_chk25
                    ATTRIBUTE(WITHOUT DEFAULTS)
      END INPUT
      
      ON ACTION qbeclear
         CALL aglq936_qbe_clear()
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:ui_dialog段b_dialog name="cs.before_dialog"
         LET l_ac = 1
         LET g_glea_d[l_ac].glea005 = ''
         DISPLAY ARRAY g_glea_d TO s_detail1.*
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
   CALL aglq936_construct_visible('1')
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
 
{<section id="aglq936.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aglq936_query()
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
   CALL g_glea_d.clear()
   CALL g_glea2_d.clear()
   CALL g_glea3_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL aglq936_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aglq936_browser_fill(g_wc)
      CALL aglq936_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL aglq936_browser_fill("F")
   
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
      CALL aglq936_fetch("F") 
   END IF
   
   CALL aglq936_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="aglq936.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aglq936_fetch(p_flag)
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
   
   #CALL aglq936_browser_fill(p_flag)
   
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
   
   LET g_glea_m.gleald = g_browser[g_current_idx].b_gleald
   LET g_glea_m.glea001 = g_browser[g_current_idx].b_glea001
   LET g_glea_m.glea003 = g_browser[g_current_idx].b_glea003
   LET g_glea_m.glea004 = g_browser[g_current_idx].b_glea004
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE aglq936_master_referesh USING g_glea_m.gleald,g_glea_m.glea001,g_glea_m.glea003,g_glea_m.glea004 INTO g_glea_m.gleald, 
       g_glea_m.glea001,g_glea_m.glea003,g_glea_m.glea004
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "glea_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_glea_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_glea_m_mask_o.* =  g_glea_m.*
   CALL aglq936_glea_t_mask()
   LET g_glea_m_mask_n.* =  g_glea_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL aglq936_set_act_visible()
   CALL aglq936_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_glea_m_t.* = g_glea_m.*
   LET g_glea_m_o.* = g_glea_m.*
   
   #重新顯示   
   CALL aglq936_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="aglq936.insert" >}
#+ 資料新增
PRIVATE FUNCTION aglq936_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
 
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_glea_d.clear()
   CALL g_glea2_d.clear()
   CALL g_glea3_d.clear()
 
 
   INITIALIZE g_glea_m.* TO NULL             #DEFAULT 設定
   LET g_gleald_t = NULL
   LET g_glea001_t = NULL
   LET g_glea003_t = NULL
   LET g_glea004_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
            LET g_glea_m.glea003 = "0"
      LET g_glea_m.glea004 = "0"
 
     
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point 
 
      CALL aglq936_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_glea_m.* TO NULL
         INITIALIZE g_glea_d TO NULL
         INITIALIZE g_glea2_d TO NULL
         INITIALIZE g_glea3_d TO NULL
 
         CALL aglq936_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_glea_m.* = g_glea_m_t.*
         CALL aglq936_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_glea_d.clear()
      #CALL g_glea2_d.clear()
      #CALL g_glea3_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL aglq936_set_act_visible()
   CALL aglq936_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_gleald_t = g_glea_m.gleald
   LET g_glea001_t = g_glea_m.glea001
   LET g_glea003_t = g_glea_m.glea003
   LET g_glea004_t = g_glea_m.glea004
 
   
   #組合新增資料的條件
   LET g_add_browse = " gleaent = " ||g_enterprise|| " AND",
                      " gleald = '", g_glea_m.gleald, "' "
                      ," AND glea001 = '", g_glea_m.glea001, "' "
                      ," AND glea003 = '", g_glea_m.glea003, "' "
                      ," AND glea004 = '", g_glea_m.glea004, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aglq936_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL aglq936_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aglq936_master_referesh USING g_glea_m.gleald,g_glea_m.glea001,g_glea_m.glea003,g_glea_m.glea004 INTO g_glea_m.gleald, 
       g_glea_m.glea001,g_glea_m.glea003,g_glea_m.glea004
   
   #遮罩相關處理
   LET g_glea_m_mask_o.* =  g_glea_m.*
   CALL aglq936_glea_t_mask()
   LET g_glea_m_mask_n.* =  g_glea_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_glea_m.gleald,g_glea_m.gleald_desc,g_glea_m.glea001,g_glea_m.glea001_desc,g_glea_m.glea003, 
       g_glea_m.glea004,g_glea_m.l_glea007,g_glea_m.l_glea026,g_glea_m.l_glea029,g_glea_m.l_chk12,g_glea_m.l_chk13, 
       g_glea_m.l_chk14,g_glea_m.l_chk15,g_glea_m.l_chk16,g_glea_m.l_chk17,g_glea_m.l_chk18,g_glea_m.l_chk19, 
       g_glea_m.l_chk20,g_glea_m.l_chk21,g_glea_m.l_chk22,g_glea_m.l_chk23,g_glea_m.l_chk24,g_glea_m.l_chk25 
 
   
   #功能已完成,通報訊息中心
   CALL aglq936_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aglq936.modify" >}
#+ 資料修改
PRIVATE FUNCTION aglq936_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_glea_m.gleald IS NULL
   OR g_glea_m.glea001 IS NULL
   OR g_glea_m.glea003 IS NULL
   OR g_glea_m.glea004 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_gleald_t = g_glea_m.gleald
   LET g_glea001_t = g_glea_m.glea001
   LET g_glea003_t = g_glea_m.glea003
   LET g_glea004_t = g_glea_m.glea004
 
   CALL s_transaction_begin()
   
   OPEN aglq936_cl USING g_enterprise,g_glea_m.gleald,g_glea_m.glea001,g_glea_m.glea003,g_glea_m.glea004
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aglq936_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE aglq936_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aglq936_master_referesh USING g_glea_m.gleald,g_glea_m.glea001,g_glea_m.glea003,g_glea_m.glea004 INTO g_glea_m.gleald, 
       g_glea_m.glea001,g_glea_m.glea003,g_glea_m.glea004
   
   #遮罩相關處理
   LET g_glea_m_mask_o.* =  g_glea_m.*
   CALL aglq936_glea_t_mask()
   LET g_glea_m_mask_n.* =  g_glea_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL aglq936_show()
   WHILE TRUE
      LET g_gleald_t = g_glea_m.gleald
      LET g_glea001_t = g_glea_m.glea001
      LET g_glea003_t = g_glea_m.glea003
      LET g_glea004_t = g_glea_m.glea004
 
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL aglq936_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_glea_m.* = g_glea_m_t.*
         CALL aglq936_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_glea_m.gleald != g_gleald_t 
      OR g_glea_m.glea001 != g_glea001_t 
      OR g_glea_m.glea003 != g_glea003_t 
      OR g_glea_m.glea004 != g_glea004_t 
 
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
   CALL aglq936_set_act_visible()
   CALL aglq936_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " gleaent = " ||g_enterprise|| " AND",
                      " gleald = '", g_glea_m.gleald, "' "
                      ," AND glea001 = '", g_glea_m.glea001, "' "
                      ," AND glea003 = '", g_glea_m.glea003, "' "
                      ," AND glea004 = '", g_glea_m.glea004, "' "
 
   #填到對應位置
   CALL aglq936_browser_fill("")
 
   CALL aglq936_idx_chk()
 
   CLOSE aglq936_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aglq936_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="aglq936.input" >}
#+ 資料輸入
PRIVATE FUNCTION aglq936_input(p_cmd)
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
   DISPLAY BY NAME g_glea_m.gleald,g_glea_m.gleald_desc,g_glea_m.glea001,g_glea_m.glea001_desc,g_glea_m.glea003, 
       g_glea_m.glea004,g_glea_m.l_glea007,g_glea_m.l_glea026,g_glea_m.l_glea029,g_glea_m.l_chk12,g_glea_m.l_chk13, 
       g_glea_m.l_chk14,g_glea_m.l_chk15,g_glea_m.l_chk16,g_glea_m.l_chk17,g_glea_m.l_chk18,g_glea_m.l_chk19, 
       g_glea_m.l_chk20,g_glea_m.l_chk21,g_glea_m.l_chk22,g_glea_m.l_chk23,g_glea_m.l_chk24,g_glea_m.l_chk25 
 
   
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
   LET g_forupd_sql = "SELECT glea005,glea012,glea013,glea014,glea015,glea016,glea017,glea018,glea019, 
       glea020,glea021,glea022,glea023,glea024,glea025,glea034,glea008,glea009,glea007,glea002,glea006, 
       glea032,glea033,glea005,glea035,glea027,glea028,glea026,glea002,glea006,glea032,glea033,glea005, 
       glea036,glea030,glea031,glea029,glea002,glea006,glea032,glea033 FROM glea_t WHERE gleaent=? AND  
       gleald=? AND glea001=? AND glea003=? AND glea004=? AND glea002=? AND glea005=? AND glea006=?  
       AND glea032=? AND glea033=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aglq936_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aglq936_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL aglq936_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_glea_m.gleald,g_glea_m.glea001,g_glea_m.glea003,g_glea_m.glea004,g_glea_m.l_glea007, 
       g_glea_m.l_glea026,g_glea_m.l_glea029,g_glea_m.l_chk12,g_glea_m.l_chk13,g_glea_m.l_chk14,g_glea_m.l_chk15, 
       g_glea_m.l_chk16,g_glea_m.l_chk17,g_glea_m.l_chk18,g_glea_m.l_chk19,g_glea_m.l_chk20,g_glea_m.l_chk21, 
       g_glea_m.l_chk22,g_glea_m.l_chk23,g_glea_m.l_chk24,g_glea_m.l_chk25
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="aglq936.input.head" >}
   
      #單頭段
      INPUT BY NAME g_glea_m.gleald,g_glea_m.glea001,g_glea_m.glea003,g_glea_m.glea004,g_glea_m.l_glea007, 
          g_glea_m.l_glea026,g_glea_m.l_glea029,g_glea_m.l_chk12,g_glea_m.l_chk13,g_glea_m.l_chk14,g_glea_m.l_chk15, 
          g_glea_m.l_chk16,g_glea_m.l_chk17,g_glea_m.l_chk18,g_glea_m.l_chk19,g_glea_m.l_chk20,g_glea_m.l_chk21, 
          g_glea_m.l_chk22,g_glea_m.l_chk23,g_glea_m.l_chk24,g_glea_m.l_chk25 
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
         AFTER FIELD gleald
            
            #add-point:AFTER FIELD gleald name="input.a.gleald"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gleald
            #add-point:BEFORE FIELD gleald name="input.b.gleald"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gleald
            #add-point:ON CHANGE gleald name="input.g.gleald"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea001
            
            #add-point:AFTER FIELD glea001 name="input.a.glea001"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea001
            #add-point:BEFORE FIELD glea001 name="input.b.glea001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glea001
            #add-point:ON CHANGE glea001 name="input.g.glea001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea003
            #add-point:BEFORE FIELD glea003 name="input.b.glea003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea003
            
            #add-point:AFTER FIELD glea003 name="input.a.glea003"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glea003
            #add-point:ON CHANGE glea003 name="input.g.glea003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea004
            #add-point:BEFORE FIELD glea004 name="input.b.glea004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea004
            
            #add-point:AFTER FIELD glea004 name="input.a.glea004"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glea004
            #add-point:ON CHANGE glea004 name="input.g.glea004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glea007
            #add-point:BEFORE FIELD l_glea007 name="input.b.l_glea007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glea007
            
            #add-point:AFTER FIELD l_glea007 name="input.a.l_glea007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glea007
            #add-point:ON CHANGE l_glea007 name="input.g.l_glea007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glea026
            #add-point:BEFORE FIELD l_glea026 name="input.b.l_glea026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glea026
            
            #add-point:AFTER FIELD l_glea026 name="input.a.l_glea026"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glea026
            #add-point:ON CHANGE l_glea026 name="input.g.l_glea026"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glea029
            #add-point:BEFORE FIELD l_glea029 name="input.b.l_glea029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glea029
            
            #add-point:AFTER FIELD l_glea029 name="input.a.l_glea029"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glea029
            #add-point:ON CHANGE l_glea029 name="input.g.l_glea029"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_chk12
            #add-point:BEFORE FIELD l_chk12 name="input.b.l_chk12"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_chk12
            
            #add-point:AFTER FIELD l_chk12 name="input.a.l_chk12"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_chk12
            #add-point:ON CHANGE l_chk12 name="input.g.l_chk12"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_chk13
            #add-point:BEFORE FIELD l_chk13 name="input.b.l_chk13"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_chk13
            
            #add-point:AFTER FIELD l_chk13 name="input.a.l_chk13"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_chk13
            #add-point:ON CHANGE l_chk13 name="input.g.l_chk13"
            
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
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_chk25
            #add-point:BEFORE FIELD l_chk25 name="input.b.l_chk25"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_chk25
            
            #add-point:AFTER FIELD l_chk25 name="input.a.l_chk25"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_chk25
            #add-point:ON CHANGE l_chk25 name="input.g.l_chk25"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.gleald
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gleald
            #add-point:ON ACTION controlp INFIELD gleald name="input.c.gleald"
            
            #END add-point
 
 
         #Ctrlp:input.c.glea001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea001
            #add-point:ON ACTION controlp INFIELD glea001 name="input.c.glea001"
            
            #END add-point
 
 
         #Ctrlp:input.c.glea003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea003
            #add-point:ON ACTION controlp INFIELD glea003 name="input.c.glea003"
            
            #END add-point
 
 
         #Ctrlp:input.c.glea004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea004
            #add-point:ON ACTION controlp INFIELD glea004 name="input.c.glea004"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_glea007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glea007
            #add-point:ON ACTION controlp INFIELD l_glea007 name="input.c.l_glea007"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_glea026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glea026
            #add-point:ON ACTION controlp INFIELD l_glea026 name="input.c.l_glea026"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_glea029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glea029
            #add-point:ON ACTION controlp INFIELD l_glea029 name="input.c.l_glea029"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_chk12
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_chk12
            #add-point:ON ACTION controlp INFIELD l_chk12 name="input.c.l_chk12"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_chk13
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_chk13
            #add-point:ON ACTION controlp INFIELD l_chk13 name="input.c.l_chk13"
            
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
 
 
         #Ctrlp:input.c.l_chk25
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_chk25
            #add-point:ON ACTION controlp INFIELD l_chk25 name="input.c.l_chk25"
            
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
            DISPLAY BY NAME g_glea_m.gleald             
                            ,g_glea_m.glea001   
                            ,g_glea_m.glea003   
                            ,g_glea_m.glea004   
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
            
               #將遮罩欄位還原
               CALL aglq936_glea_t_mask_restore('restore_mask_o')
            
               UPDATE glea_t SET (gleald,glea001,glea003,glea004) = (g_glea_m.gleald,g_glea_m.glea001, 
                   g_glea_m.glea003,g_glea_m.glea004)
                WHERE gleaent = g_enterprise AND gleald = g_gleald_t
                  AND glea001 = g_glea001_t
                  AND glea003 = g_glea003_t
                  AND glea004 = g_glea004_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "glea_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "glea_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_glea_m.gleald
               LET gs_keys_bak[1] = g_gleald_t
               LET gs_keys[2] = g_glea_m.glea001
               LET gs_keys_bak[2] = g_glea001_t
               LET gs_keys[3] = g_glea_m.glea003
               LET gs_keys_bak[3] = g_glea003_t
               LET gs_keys[4] = g_glea_m.glea004
               LET gs_keys_bak[4] = g_glea004_t
               LET gs_keys[5] = g_glea_d[g_detail_idx].glea002
               LET gs_keys_bak[5] = g_glea_d_t.glea002
               LET gs_keys[6] = g_glea_d[g_detail_idx].glea005
               LET gs_keys_bak[6] = g_glea_d_t.glea005
               LET gs_keys[7] = g_glea_d[g_detail_idx].glea006
               LET gs_keys_bak[7] = g_glea_d_t.glea006
               LET gs_keys[8] = g_glea_d[g_detail_idx].glea032
               LET gs_keys_bak[8] = g_glea_d_t.glea032
               LET gs_keys[9] = g_glea_d[g_detail_idx].glea033
               LET gs_keys_bak[9] = g_glea_d_t.glea033
               CALL aglq936_update_b('glea_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_glea_m_t)
                     #LET g_log2 = util.JSON.stringify(g_glea_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL aglq936_glea_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL aglq936_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_gleald_t = g_glea_m.gleald
           LET g_glea001_t = g_glea_m.glea001
           LET g_glea003_t = g_glea_m.glea003
           LET g_glea004_t = g_glea_m.glea004
 
           
           IF g_glea_d.getLength() = 0 THEN
              NEXT FIELD glea002
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="aglq936.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_glea_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_glea_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aglq936_b_fill(g_wc2) #test 
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
            CALL aglq936_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN aglq936_cl USING g_enterprise,g_glea_m.gleald,g_glea_m.glea001,g_glea_m.glea003,g_glea_m.glea004                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE aglq936_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN aglq936_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_glea_d[l_ac].glea002 IS NOT NULL
               AND g_glea_d[l_ac].glea005 IS NOT NULL
               AND g_glea_d[l_ac].glea006 IS NOT NULL
               AND g_glea_d[l_ac].glea032 IS NOT NULL
               AND g_glea_d[l_ac].glea033 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_glea_d_t.* = g_glea_d[l_ac].*  #BACKUP
               LET g_glea_d_o.* = g_glea_d[l_ac].*  #BACKUP
               CALL aglq936_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL aglq936_set_no_entry_b(l_cmd)
               OPEN aglq936_bcl USING g_enterprise,g_glea_m.gleald,
                                                g_glea_m.glea001,
                                                g_glea_m.glea003,
                                                g_glea_m.glea004,
 
                                                g_glea_d_t.glea002
                                                ,g_glea_d_t.glea005
                                                ,g_glea_d_t.glea006
                                                ,g_glea_d_t.glea032
                                                ,g_glea_d_t.glea033
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN aglq936_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aglq936_bcl INTO g_glea_d[l_ac].glea005,g_glea_d[l_ac].glea012,g_glea_d[l_ac].glea013, 
                      g_glea_d[l_ac].glea014,g_glea_d[l_ac].glea015,g_glea_d[l_ac].glea016,g_glea_d[l_ac].glea017, 
                      g_glea_d[l_ac].glea018,g_glea_d[l_ac].glea019,g_glea_d[l_ac].glea020,g_glea_d[l_ac].glea021, 
                      g_glea_d[l_ac].glea022,g_glea_d[l_ac].glea023,g_glea_d[l_ac].glea024,g_glea_d[l_ac].glea025, 
                      g_glea_d[l_ac].glea034,g_glea_d[l_ac].glea008,g_glea_d[l_ac].glea009,g_glea_d[l_ac].glea007, 
                      g_glea_d[l_ac].glea002,g_glea_d[l_ac].glea006,g_glea_d[l_ac].glea032,g_glea_d[l_ac].glea033, 
                      g_glea2_d[l_ac].glea005,g_glea2_d[l_ac].glea035,g_glea2_d[l_ac].glea027,g_glea2_d[l_ac].glea028, 
                      g_glea2_d[l_ac].glea026,g_glea2_d[l_ac].glea002,g_glea2_d[l_ac].glea006,g_glea2_d[l_ac].glea032, 
                      g_glea2_d[l_ac].glea033,g_glea3_d[l_ac].glea005,g_glea3_d[l_ac].glea036,g_glea3_d[l_ac].glea030, 
                      g_glea3_d[l_ac].glea031,g_glea3_d[l_ac].glea029,g_glea3_d[l_ac].glea002,g_glea3_d[l_ac].glea006, 
                      g_glea3_d[l_ac].glea032,g_glea3_d[l_ac].glea033
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_glea_d_t.glea002,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_glea_d_mask_o[l_ac].* =  g_glea_d[l_ac].*
                  CALL aglq936_glea_t_mask()
                  LET g_glea_d_mask_n[l_ac].* =  g_glea_d[l_ac].*
                  
                  CALL aglq936_ref_show()
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
            INITIALIZE g_glea_d_t.* TO NULL
            INITIALIZE g_glea_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_glea_d[l_ac].* TO NULL
            #公用欄位預設值
              
            #一般欄位預設值
                  LET g_glea_d[l_ac].glea018 = "N"
      LET g_glea_d[l_ac].glea018_desc = "N"
      LET g_glea_d[l_ac].glea019 = "N"
      LET g_glea_d[l_ac].glea019_desc = "N"
      LET g_glea_d[l_ac].glea034 = "0"
      LET g_glea_d[l_ac].glea008 = "0"
      LET g_glea_d[l_ac].glea009 = "0"
      LET g_glea_d[l_ac].l_amt = "0"
 
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            
            #end add-point
            LET g_glea_d_t.* = g_glea_d[l_ac].*     #新輸入資料
            LET g_glea_d_o.* = g_glea_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aglq936_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL aglq936_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_glea_d[li_reproduce_target].* = g_glea_d[li_reproduce].*
               LET g_glea2_d[li_reproduce_target].* = g_glea2_d[li_reproduce].*
               LET g_glea3_d[li_reproduce_target].* = g_glea3_d[li_reproduce].*
 
               LET g_glea_d[g_glea_d.getLength()].glea002 = NULL
               LET g_glea_d[g_glea_d.getLength()].glea005 = NULL
               LET g_glea_d[g_glea_d.getLength()].glea006 = NULL
               LET g_glea_d[g_glea_d.getLength()].glea032 = NULL
               LET g_glea_d[g_glea_d.getLength()].glea033 = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM glea_t 
             WHERE gleaent = g_enterprise AND gleald = g_glea_m.gleald
               AND glea001 = g_glea_m.glea001
               AND glea003 = g_glea_m.glea003
               AND glea004 = g_glea_m.glea004
 
               AND glea002 = g_glea_d[l_ac].glea002
               AND glea005 = g_glea_d[l_ac].glea005
               AND glea006 = g_glea_d[l_ac].glea006
               AND glea032 = g_glea_d[l_ac].glea032
               AND glea033 = g_glea_d[l_ac].glea033
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
               INSERT INTO glea_t
                           (gleaent,
                            gleald,glea001,glea003,glea004,
                            glea002,glea005,glea006,glea032,glea033
                            ,glea012,glea013,glea014,glea015,glea016,glea017,glea018,glea019,glea020,glea021,glea022,glea023,glea024,glea025,glea034,glea008,glea009,glea007,glea035,glea027,glea028,glea026,glea036,glea030,glea031,glea029) 
                     VALUES(g_enterprise,
                            g_glea_m.gleald,g_glea_m.glea001,g_glea_m.glea003,g_glea_m.glea004,
                            g_glea_d[l_ac].glea002,g_glea_d[l_ac].glea005,g_glea_d[l_ac].glea006,g_glea_d[l_ac].glea032, 
                                g_glea_d[l_ac].glea033
                            ,g_glea_d[l_ac].glea012,g_glea_d[l_ac].glea013,g_glea_d[l_ac].glea014,g_glea_d[l_ac].glea015, 
                                g_glea_d[l_ac].glea016,g_glea_d[l_ac].glea017,g_glea_d[l_ac].glea018, 
                                g_glea_d[l_ac].glea019,g_glea_d[l_ac].glea020,g_glea_d[l_ac].glea021, 
                                g_glea_d[l_ac].glea022,g_glea_d[l_ac].glea023,g_glea_d[l_ac].glea024, 
                                g_glea_d[l_ac].glea025,g_glea_d[l_ac].glea034,g_glea_d[l_ac].glea008, 
                                g_glea_d[l_ac].glea009,g_glea_d[l_ac].glea007,g_glea2_d[l_ac].glea035, 
                                g_glea2_d[l_ac].glea027,g_glea2_d[l_ac].glea028,g_glea2_d[l_ac].glea026, 
                                g_glea3_d[l_ac].glea036,g_glea3_d[l_ac].glea030,g_glea3_d[l_ac].glea031, 
                                g_glea3_d[l_ac].glea029)
               #add-point:單身新增中 name="input.body.m_insert"
               
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_glea_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "glea_t:",SQLERRMESSAGE 
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
               IF aglq936_before_delete() THEN 
                  
 
 
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_glea_m.gleald
                  LET gs_keys[gs_keys.getLength()+1] = g_glea_m.glea001
                  LET gs_keys[gs_keys.getLength()+1] = g_glea_m.glea003
                  LET gs_keys[gs_keys.getLength()+1] = g_glea_m.glea004
 
                  LET gs_keys[gs_keys.getLength()+1] = g_glea_d_t.glea002
                  LET gs_keys[gs_keys.getLength()+1] = g_glea_d_t.glea005
                  LET gs_keys[gs_keys.getLength()+1] = g_glea_d_t.glea006
                  LET gs_keys[gs_keys.getLength()+1] = g_glea_d_t.glea032
                  LET gs_keys[gs_keys.getLength()+1] = g_glea_d_t.glea033
 
 
                  #刪除下層單身
                  IF NOT aglq936_key_delete_b(gs_keys,'glea_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE aglq936_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE aglq936_bcl
               LET l_count = g_glea_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_glea_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea005
            
            #add-point:AFTER FIELD glea005 name="input.a.page1.glea005"
            #應用 a05 樣板自動產生(Version:2)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea005
            #add-point:BEFORE FIELD glea005 name="input.b.page1.glea005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glea005
            #add-point:ON CHANGE glea005 name="input.g.page1.glea005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea012
            
            #add-point:AFTER FIELD glea012 name="input.a.page1.glea012"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea012
            #add-point:BEFORE FIELD glea012 name="input.b.page1.glea012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glea012
            #add-point:ON CHANGE glea012 name="input.g.page1.glea012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea012_desc
            #add-point:BEFORE FIELD glea012_desc name="input.b.page1.glea012_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea012_desc
            
            #add-point:AFTER FIELD glea012_desc name="input.a.page1.glea012_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glea012_desc
            #add-point:ON CHANGE glea012_desc name="input.g.page1.glea012_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea013
            
            #add-point:AFTER FIELD glea013 name="input.a.page1.glea013"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea013
            #add-point:BEFORE FIELD glea013 name="input.b.page1.glea013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glea013
            #add-point:ON CHANGE glea013 name="input.g.page1.glea013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea013_desc
            #add-point:BEFORE FIELD glea013_desc name="input.b.page1.glea013_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea013_desc
            
            #add-point:AFTER FIELD glea013_desc name="input.a.page1.glea013_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glea013_desc
            #add-point:ON CHANGE glea013_desc name="input.g.page1.glea013_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea014
            
            #add-point:AFTER FIELD glea014 name="input.a.page1.glea014"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea014
            #add-point:BEFORE FIELD glea014 name="input.b.page1.glea014"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glea014
            #add-point:ON CHANGE glea014 name="input.g.page1.glea014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea014_desc
            #add-point:BEFORE FIELD glea014_desc name="input.b.page1.glea014_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea014_desc
            
            #add-point:AFTER FIELD glea014_desc name="input.a.page1.glea014_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glea014_desc
            #add-point:ON CHANGE glea014_desc name="input.g.page1.glea014_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea015
            
            #add-point:AFTER FIELD glea015 name="input.a.page1.glea015"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea015
            #add-point:BEFORE FIELD glea015 name="input.b.page1.glea015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glea015
            #add-point:ON CHANGE glea015 name="input.g.page1.glea015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea015_desc
            #add-point:BEFORE FIELD glea015_desc name="input.b.page1.glea015_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea015_desc
            
            #add-point:AFTER FIELD glea015_desc name="input.a.page1.glea015_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glea015_desc
            #add-point:ON CHANGE glea015_desc name="input.g.page1.glea015_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea016
            
            #add-point:AFTER FIELD glea016 name="input.a.page1.glea016"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea016
            #add-point:BEFORE FIELD glea016 name="input.b.page1.glea016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glea016
            #add-point:ON CHANGE glea016 name="input.g.page1.glea016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea016_desc
            #add-point:BEFORE FIELD glea016_desc name="input.b.page1.glea016_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea016_desc
            
            #add-point:AFTER FIELD glea016_desc name="input.a.page1.glea016_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glea016_desc
            #add-point:ON CHANGE glea016_desc name="input.g.page1.glea016_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea017
            
            #add-point:AFTER FIELD glea017 name="input.a.page1.glea017"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea017
            #add-point:BEFORE FIELD glea017 name="input.b.page1.glea017"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glea017
            #add-point:ON CHANGE glea017 name="input.g.page1.glea017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea017_desc
            #add-point:BEFORE FIELD glea017_desc name="input.b.page1.glea017_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea017_desc
            
            #add-point:AFTER FIELD glea017_desc name="input.a.page1.glea017_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glea017_desc
            #add-point:ON CHANGE glea017_desc name="input.g.page1.glea017_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea018
            
            #add-point:AFTER FIELD glea018 name="input.a.page1.glea018"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea018
            #add-point:BEFORE FIELD glea018 name="input.b.page1.glea018"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glea018
            #add-point:ON CHANGE glea018 name="input.g.page1.glea018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea018_desc
            #add-point:BEFORE FIELD glea018_desc name="input.b.page1.glea018_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea018_desc
            
            #add-point:AFTER FIELD glea018_desc name="input.a.page1.glea018_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glea018_desc
            #add-point:ON CHANGE glea018_desc name="input.g.page1.glea018_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea019
            
            #add-point:AFTER FIELD glea019 name="input.a.page1.glea019"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea019
            #add-point:BEFORE FIELD glea019 name="input.b.page1.glea019"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glea019
            #add-point:ON CHANGE glea019 name="input.g.page1.glea019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea019_desc
            #add-point:BEFORE FIELD glea019_desc name="input.b.page1.glea019_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea019_desc
            
            #add-point:AFTER FIELD glea019_desc name="input.a.page1.glea019_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glea019_desc
            #add-point:ON CHANGE glea019_desc name="input.g.page1.glea019_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea020
            #add-point:BEFORE FIELD glea020 name="input.b.page1.glea020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea020
            
            #add-point:AFTER FIELD glea020 name="input.a.page1.glea020"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glea020
            #add-point:ON CHANGE glea020 name="input.g.page1.glea020"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea021
            
            #add-point:AFTER FIELD glea021 name="input.a.page1.glea021"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea021
            #add-point:BEFORE FIELD glea021 name="input.b.page1.glea021"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glea021
            #add-point:ON CHANGE glea021 name="input.g.page1.glea021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea021_desc
            #add-point:BEFORE FIELD glea021_desc name="input.b.page1.glea021_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea021_desc
            
            #add-point:AFTER FIELD glea021_desc name="input.a.page1.glea021_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glea021_desc
            #add-point:ON CHANGE glea021_desc name="input.g.page1.glea021_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea022
            
            #add-point:AFTER FIELD glea022 name="input.a.page1.glea022"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea022
            #add-point:BEFORE FIELD glea022 name="input.b.page1.glea022"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glea022
            #add-point:ON CHANGE glea022 name="input.g.page1.glea022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea022_desc
            #add-point:BEFORE FIELD glea022_desc name="input.b.page1.glea022_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea022_desc
            
            #add-point:AFTER FIELD glea022_desc name="input.a.page1.glea022_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glea022_desc
            #add-point:ON CHANGE glea022_desc name="input.g.page1.glea022_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea023
            
            #add-point:AFTER FIELD glea023 name="input.a.page1.glea023"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea023
            #add-point:BEFORE FIELD glea023 name="input.b.page1.glea023"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glea023
            #add-point:ON CHANGE glea023 name="input.g.page1.glea023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea023_desc
            #add-point:BEFORE FIELD glea023_desc name="input.b.page1.glea023_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea023_desc
            
            #add-point:AFTER FIELD glea023_desc name="input.a.page1.glea023_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glea023_desc
            #add-point:ON CHANGE glea023_desc name="input.g.page1.glea023_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea024
            
            #add-point:AFTER FIELD glea024 name="input.a.page1.glea024"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea024
            #add-point:BEFORE FIELD glea024 name="input.b.page1.glea024"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glea024
            #add-point:ON CHANGE glea024 name="input.g.page1.glea024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea024_desc
            #add-point:BEFORE FIELD glea024_desc name="input.b.page1.glea024_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea024_desc
            
            #add-point:AFTER FIELD glea024_desc name="input.a.page1.glea024_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glea024_desc
            #add-point:ON CHANGE glea024_desc name="input.g.page1.glea024_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea025
            
            #add-point:AFTER FIELD glea025 name="input.a.page1.glea025"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea025
            #add-point:BEFORE FIELD glea025 name="input.b.page1.glea025"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glea025
            #add-point:ON CHANGE glea025 name="input.g.page1.glea025"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea025_desc
            #add-point:BEFORE FIELD glea025_desc name="input.b.page1.glea025_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea025_desc
            
            #add-point:AFTER FIELD glea025_desc name="input.a.page1.glea025_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glea025_desc
            #add-point:ON CHANGE glea025_desc name="input.g.page1.glea025_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea034
            #add-point:BEFORE FIELD glea034 name="input.b.page1.glea034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea034
            
            #add-point:AFTER FIELD glea034 name="input.a.page1.glea034"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glea034
            #add-point:ON CHANGE glea034 name="input.g.page1.glea034"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea008
            #add-point:BEFORE FIELD glea008 name="input.b.page1.glea008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea008
            
            #add-point:AFTER FIELD glea008 name="input.a.page1.glea008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glea008
            #add-point:ON CHANGE glea008 name="input.g.page1.glea008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea009
            #add-point:BEFORE FIELD glea009 name="input.b.page1.glea009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea009
            
            #add-point:AFTER FIELD glea009 name="input.a.page1.glea009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glea009
            #add-point:ON CHANGE glea009 name="input.g.page1.glea009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_amt
            #add-point:BEFORE FIELD l_amt name="input.b.page1.l_amt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_amt
            
            #add-point:AFTER FIELD l_amt name="input.a.page1.l_amt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_amt
            #add-point:ON CHANGE l_amt name="input.g.page1.l_amt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea007
            #add-point:BEFORE FIELD glea007 name="input.b.page1.glea007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea007
            
            #add-point:AFTER FIELD glea007 name="input.a.page1.glea007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glea007
            #add-point:ON CHANGE glea007 name="input.g.page1.glea007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea002
            #add-point:BEFORE FIELD glea002 name="input.b.page1.glea002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea002
            
            #add-point:AFTER FIELD glea002 name="input.a.page1.glea002"
            #應用 a05 樣板自動產生(Version:2)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glea002
            #add-point:ON CHANGE glea002 name="input.g.page1.glea002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea006
            #add-point:BEFORE FIELD glea006 name="input.b.page1.glea006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea006
            
            #add-point:AFTER FIELD glea006 name="input.a.page1.glea006"
            #應用 a05 樣板自動產生(Version:2)

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glea006
            #add-point:ON CHANGE glea006 name="input.g.page1.glea006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea032
            #add-point:BEFORE FIELD glea032 name="input.b.page1.glea032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea032
            
            #add-point:AFTER FIELD glea032 name="input.a.page1.glea032"
            #應用 a05 樣板自動產生(Version:2)

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glea032
            #add-point:ON CHANGE glea032 name="input.g.page1.glea032"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea033
            #add-point:BEFORE FIELD glea033 name="input.b.page1.glea033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea033
            
            #add-point:AFTER FIELD glea033 name="input.a.page1.glea033"
            #應用 a05 樣板自動產生(Version:2)

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glea033
            #add-point:ON CHANGE glea033 name="input.g.page1.glea033"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.glea005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea005
            #add-point:ON ACTION controlp INFIELD glea005 name="input.c.page1.glea005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glea012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea012
            #add-point:ON ACTION controlp INFIELD glea012 name="input.c.page1.glea012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glea012_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea012_desc
            #add-point:ON ACTION controlp INFIELD glea012_desc name="input.c.page1.glea012_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glea013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea013
            #add-point:ON ACTION controlp INFIELD glea013 name="input.c.page1.glea013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glea013_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea013_desc
            #add-point:ON ACTION controlp INFIELD glea013_desc name="input.c.page1.glea013_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glea014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea014
            #add-point:ON ACTION controlp INFIELD glea014 name="input.c.page1.glea014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glea014_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea014_desc
            #add-point:ON ACTION controlp INFIELD glea014_desc name="input.c.page1.glea014_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glea015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea015
            #add-point:ON ACTION controlp INFIELD glea015 name="input.c.page1.glea015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glea015_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea015_desc
            #add-point:ON ACTION controlp INFIELD glea015_desc name="input.c.page1.glea015_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glea016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea016
            #add-point:ON ACTION controlp INFIELD glea016 name="input.c.page1.glea016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glea016_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea016_desc
            #add-point:ON ACTION controlp INFIELD glea016_desc name="input.c.page1.glea016_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glea017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea017
            #add-point:ON ACTION controlp INFIELD glea017 name="input.c.page1.glea017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glea017_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea017_desc
            #add-point:ON ACTION controlp INFIELD glea017_desc name="input.c.page1.glea017_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glea018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea018
            #add-point:ON ACTION controlp INFIELD glea018 name="input.c.page1.glea018"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glea018_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea018_desc
            #add-point:ON ACTION controlp INFIELD glea018_desc name="input.c.page1.glea018_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glea019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea019
            #add-point:ON ACTION controlp INFIELD glea019 name="input.c.page1.glea019"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glea019_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea019_desc
            #add-point:ON ACTION controlp INFIELD glea019_desc name="input.c.page1.glea019_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glea020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea020
            #add-point:ON ACTION controlp INFIELD glea020 name="input.c.page1.glea020"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glea021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea021
            #add-point:ON ACTION controlp INFIELD glea021 name="input.c.page1.glea021"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glea021_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea021_desc
            #add-point:ON ACTION controlp INFIELD glea021_desc name="input.c.page1.glea021_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glea022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea022
            #add-point:ON ACTION controlp INFIELD glea022 name="input.c.page1.glea022"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glea022_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea022_desc
            #add-point:ON ACTION controlp INFIELD glea022_desc name="input.c.page1.glea022_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glea023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea023
            #add-point:ON ACTION controlp INFIELD glea023 name="input.c.page1.glea023"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glea023_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea023_desc
            #add-point:ON ACTION controlp INFIELD glea023_desc name="input.c.page1.glea023_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glea024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea024
            #add-point:ON ACTION controlp INFIELD glea024 name="input.c.page1.glea024"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glea024_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea024_desc
            #add-point:ON ACTION controlp INFIELD glea024_desc name="input.c.page1.glea024_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glea025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea025
            #add-point:ON ACTION controlp INFIELD glea025 name="input.c.page1.glea025"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glea025_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea025_desc
            #add-point:ON ACTION controlp INFIELD glea025_desc name="input.c.page1.glea025_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glea034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea034
            #add-point:ON ACTION controlp INFIELD glea034 name="input.c.page1.glea034"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glea008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea008
            #add-point:ON ACTION controlp INFIELD glea008 name="input.c.page1.glea008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glea009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea009
            #add-point:ON ACTION controlp INFIELD glea009 name="input.c.page1.glea009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_amt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_amt
            #add-point:ON ACTION controlp INFIELD l_amt name="input.c.page1.l_amt"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glea007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea007
            #add-point:ON ACTION controlp INFIELD glea007 name="input.c.page1.glea007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glea002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea002
            #add-point:ON ACTION controlp INFIELD glea002 name="input.c.page1.glea002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glea006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea006
            #add-point:ON ACTION controlp INFIELD glea006 name="input.c.page1.glea006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glea032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea032
            #add-point:ON ACTION controlp INFIELD glea032 name="input.c.page1.glea032"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glea033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea033
            #add-point:ON ACTION controlp INFIELD glea033 name="input.c.page1.glea033"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_glea_d[l_ac].* = g_glea_d_t.*
               CLOSE aglq936_bcl
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
               LET g_errparam.extend = g_glea_d[l_ac].glea002 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_glea_d[l_ac].* = g_glea_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
         
               #將遮罩欄位還原
               CALL aglq936_glea_t_mask_restore('restore_mask_o')
         
               UPDATE glea_t SET (gleald,glea001,glea003,glea004,glea005,glea012,glea013,glea014,glea015, 
                   glea016,glea017,glea018,glea019,glea020,glea021,glea022,glea023,glea024,glea025,glea034, 
                   glea008,glea009,glea007,glea002,glea006,glea032,glea033,glea035,glea027,glea028,glea026, 
                   glea036,glea030,glea031,glea029) = (g_glea_m.gleald,g_glea_m.glea001,g_glea_m.glea003, 
                   g_glea_m.glea004,g_glea_d[l_ac].glea005,g_glea_d[l_ac].glea012,g_glea_d[l_ac].glea013, 
                   g_glea_d[l_ac].glea014,g_glea_d[l_ac].glea015,g_glea_d[l_ac].glea016,g_glea_d[l_ac].glea017, 
                   g_glea_d[l_ac].glea018,g_glea_d[l_ac].glea019,g_glea_d[l_ac].glea020,g_glea_d[l_ac].glea021, 
                   g_glea_d[l_ac].glea022,g_glea_d[l_ac].glea023,g_glea_d[l_ac].glea024,g_glea_d[l_ac].glea025, 
                   g_glea_d[l_ac].glea034,g_glea_d[l_ac].glea008,g_glea_d[l_ac].glea009,g_glea_d[l_ac].glea007, 
                   g_glea_d[l_ac].glea002,g_glea_d[l_ac].glea006,g_glea_d[l_ac].glea032,g_glea_d[l_ac].glea033, 
                   g_glea2_d[l_ac].glea035,g_glea2_d[l_ac].glea027,g_glea2_d[l_ac].glea028,g_glea2_d[l_ac].glea026, 
                   g_glea3_d[l_ac].glea036,g_glea3_d[l_ac].glea030,g_glea3_d[l_ac].glea031,g_glea3_d[l_ac].glea029) 
 
                WHERE gleaent = g_enterprise AND gleald = g_glea_m.gleald 
                 AND glea001 = g_glea_m.glea001 
                 AND glea003 = g_glea_m.glea003 
                 AND glea004 = g_glea_m.glea004 
 
                 AND glea002 = g_glea_d_t.glea002 #項次   
                 AND glea005 = g_glea_d_t.glea005  
                 AND glea006 = g_glea_d_t.glea006  
                 AND glea032 = g_glea_d_t.glea032  
                 AND glea033 = g_glea_d_t.glea033  
 
                 
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "glea_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "glea_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_glea_m.gleald
               LET gs_keys_bak[1] = g_gleald_t
               LET gs_keys[2] = g_glea_m.glea001
               LET gs_keys_bak[2] = g_glea001_t
               LET gs_keys[3] = g_glea_m.glea003
               LET gs_keys_bak[3] = g_glea003_t
               LET gs_keys[4] = g_glea_m.glea004
               LET gs_keys_bak[4] = g_glea004_t
               LET gs_keys[5] = g_glea_d[g_detail_idx].glea002
               LET gs_keys_bak[5] = g_glea_d_t.glea002
               LET gs_keys[6] = g_glea_d[g_detail_idx].glea005
               LET gs_keys_bak[6] = g_glea_d_t.glea005
               LET gs_keys[7] = g_glea_d[g_detail_idx].glea006
               LET gs_keys_bak[7] = g_glea_d_t.glea006
               LET gs_keys[8] = g_glea_d[g_detail_idx].glea032
               LET gs_keys_bak[8] = g_glea_d_t.glea032
               LET gs_keys[9] = g_glea_d[g_detail_idx].glea033
               LET gs_keys_bak[9] = g_glea_d_t.glea033
               CALL aglq936_update_b('glea_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_glea_m),util.JSON.stringify(g_glea_d_t)
                     LET g_log2 = util.JSON.stringify(g_glea_m),util.JSON.stringify(g_glea_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aglq936_glea_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_glea_m.gleald
               LET ls_keys[ls_keys.getLength()+1] = g_glea_m.glea001
               LET ls_keys[ls_keys.getLength()+1] = g_glea_m.glea003
               LET ls_keys[ls_keys.getLength()+1] = g_glea_m.glea004
 
               LET ls_keys[ls_keys.getLength()+1] = g_glea_d_t.glea002
               LET ls_keys[ls_keys.getLength()+1] = g_glea_d_t.glea005
               LET ls_keys[ls_keys.getLength()+1] = g_glea_d_t.glea006
               LET ls_keys[ls_keys.getLength()+1] = g_glea_d_t.glea032
               LET ls_keys[ls_keys.getLength()+1] = g_glea_d_t.glea033
 
               CALL aglq936_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE aglq936_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_glea_d[l_ac].* = g_glea_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE aglq936_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_glea_d.getLength() = 0 THEN
               NEXT FIELD glea002
            END IF
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_glea_d[li_reproduce_target].* = g_glea_d[li_reproduce].*
               LET g_glea2_d[li_reproduce_target].* = g_glea2_d[li_reproduce].*
               LET g_glea3_d[li_reproduce_target].* = g_glea3_d[li_reproduce].*
 
               LET g_glea_d[li_reproduce_target].glea002 = NULL
               LET g_glea_d[li_reproduce_target].glea005 = NULL
               LET g_glea_d[li_reproduce_target].glea006 = NULL
               LET g_glea_d[li_reproduce_target].glea032 = NULL
               LET g_glea_d[li_reproduce_target].glea033 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_glea_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_glea_d.getLength()+1
            END IF
            
      END INPUT
 
      INPUT ARRAY g_glea2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b, WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                   INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                   DELETE ROW = l_allow_delete,
                   APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
                 
         BEFORE INPUT
            
            CALL aglq936_b_fill(g_wc2) #test 
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
            CALL aglq936_idx_chk()
            
            CALL s_transaction_begin()
            IF g_rec_b >= l_ac THEN
               LET l_cmd='u'
               CALL aglq936_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body2.before_row.set_entry_b"
               
               #end add-point
               CALL aglq936_set_no_entry_b(l_cmd)
               LET g_glea2_d_t.* = g_glea2_d[l_ac].*   #BACKUP  #page1
               LET g_glea2_d_o.* = g_glea2_d[l_ac].*   #BACKUP  #page1
            END IF 
            
 
 
 
    
         BEFORE INSERT
            LET g_insert = 'Y' 
            NEXT FIELD glea002
 
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            INITIALIZE g_glea2_d_t.* TO NULL
            INITIALIZE g_glea2_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_glea2_d[l_ac].* TO NULL
            #公用欄位預設值
              
            #一般欄位預設值
                  LET g_glea2_d[l_ac].l_glea0182 = "N"
      LET g_glea2_d[l_ac].l_glea0192 = "N"
      LET g_glea2_d[l_ac].glea035 = "0"
      LET g_glea2_d[l_ac].glea027 = "0"
      LET g_glea2_d[l_ac].glea028 = "0"
      LET g_glea2_d[l_ac].l_amt2 = "0"
 
            
            #add-point:modify段before備份 name="input.body2.before_insert.before_bak"
            
            #end add-point
            LET g_glea2_d_t.* = g_glea2_d[l_ac].*     #新輸入資料
            LET g_glea2_d_o.* = g_glea2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aglq936_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body2.before_insert.set_entry_b"
            
            #end add-point
            CALL aglq936_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_glea_d[li_reproduce_target].* = g_glea_d[li_reproduce].*
               LET g_glea2_d[li_reproduce_target].* = g_glea2_d[li_reproduce].*
               LET g_glea3_d[li_reproduce_target].* = g_glea3_d[li_reproduce].*
 
               LET g_glea2_d[li_reproduce_target].glea002 = NULL
               LET g_glea2_d[li_reproduce_target].glea005 = NULL
               LET g_glea2_d[li_reproduce_target].glea006 = NULL
               LET g_glea2_d[li_reproduce_target].glea032 = NULL
               LET g_glea2_d[li_reproduce_target].glea033 = NULL
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
               IF aglq936_before_delete() THEN 
                  
 
 
 
  
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_glea_m.gleald
                  LET gs_keys[gs_keys.getLength()+1] = g_glea_m.glea001
                  LET gs_keys[gs_keys.getLength()+1] = g_glea_m.glea003
                  LET gs_keys[gs_keys.getLength()+1] = g_glea_m.glea004
                  LET gs_keys[gs_keys.getLength()+1] = g_glea_d_t.glea002
                  LET gs_keys[gs_keys.getLength()+1] = g_glea_d_t.glea005
                  LET gs_keys[gs_keys.getLength()+1] = g_glea_d_t.glea006
                  LET gs_keys[gs_keys.getLength()+1] = g_glea_d_t.glea032
                  LET gs_keys[gs_keys.getLength()+1] = g_glea_d_t.glea033
 
                  #刪除下層單身
                  IF NOT aglq936_key_delete_b(gs_keys,'glea_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE aglq936_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE aglq936_bcl
               CALL s_transaction_end('Y','0') 
               LET l_count = g_glea2_d.getLength()
            END IF
            
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body2.after_delete"
               
               #end add-point
                              CALL aglq936_delete_b('glea_t',gs_keys,"'2'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_glea2_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_glea2_d[l_ac].* = g_glea2_d_t.*
               CLOSE aglq936_bcl
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
               LET g_errparam.extend = g_glea_d[l_ac].glea002 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_glea2_d[l_ac].* = g_glea2_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               
                
               #add-point:單身修改前 name="modify.body2.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL aglq936_glea_t_mask_restore('restore_mask_o')
                     
               UPDATE glea_t SET (gleald,glea001,glea003,glea004,glea005,glea012,glea013,glea014,glea015, 
                   glea016,glea017,glea018,glea019,glea020,glea021,glea022,glea023,glea024,glea025,glea034, 
                   glea008,glea009,glea007,glea002,glea006,glea032,glea033,glea035,glea027,glea028,glea026, 
                   glea036,glea030,glea031,glea029) = (g_glea_m.gleald,g_glea_m.glea001,g_glea_m.glea003, 
                   g_glea_m.glea004,g_glea_d[l_ac].glea005,g_glea_d[l_ac].glea012,g_glea_d[l_ac].glea013, 
                   g_glea_d[l_ac].glea014,g_glea_d[l_ac].glea015,g_glea_d[l_ac].glea016,g_glea_d[l_ac].glea017, 
                   g_glea_d[l_ac].glea018,g_glea_d[l_ac].glea019,g_glea_d[l_ac].glea020,g_glea_d[l_ac].glea021, 
                   g_glea_d[l_ac].glea022,g_glea_d[l_ac].glea023,g_glea_d[l_ac].glea024,g_glea_d[l_ac].glea025, 
                   g_glea_d[l_ac].glea034,g_glea_d[l_ac].glea008,g_glea_d[l_ac].glea009,g_glea_d[l_ac].glea007, 
                   g_glea_d[l_ac].glea002,g_glea_d[l_ac].glea006,g_glea_d[l_ac].glea032,g_glea_d[l_ac].glea033, 
                   g_glea2_d[l_ac].glea035,g_glea2_d[l_ac].glea027,g_glea2_d[l_ac].glea028,g_glea2_d[l_ac].glea026, 
                   g_glea3_d[l_ac].glea036,g_glea3_d[l_ac].glea030,g_glea3_d[l_ac].glea031,g_glea3_d[l_ac].glea029)  
                   #自訂欄位頁簽
                WHERE gleaent = g_enterprise AND gleald = g_glea_m.gleald
                 AND glea001 = g_glea_m.glea001
                 AND glea003 = g_glea_m.glea003
                 AND glea004 = g_glea_m.glea004
                 AND glea002 = g_glea2_d_t.glea002 #項次 
                 AND glea005 = g_glea2_d_t.glea005
                 AND glea006 = g_glea2_d_t.glea006
                 AND glea032 = g_glea2_d_t.glea032
                 AND glea033 = g_glea2_d_t.glea033
               #add-point:單身修改中 name="modify.body2.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "glea_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "glea_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_glea_m.gleald
               LET gs_keys_bak[1] = g_gleald_t
               LET gs_keys[2] = g_glea_m.glea001
               LET gs_keys_bak[2] = g_glea001_t
               LET gs_keys[3] = g_glea_m.glea003
               LET gs_keys_bak[3] = g_glea003_t
               LET gs_keys[4] = g_glea_m.glea004
               LET gs_keys_bak[4] = g_glea004_t
               LET gs_keys[5] = g_glea2_d[g_detail_idx].glea002
               LET gs_keys_bak[5] = g_glea2_d_t.glea002
               LET gs_keys[6] = g_glea2_d[g_detail_idx].glea005
               LET gs_keys_bak[6] = g_glea2_d_t.glea005
               LET gs_keys[7] = g_glea2_d[g_detail_idx].glea006
               LET gs_keys_bak[7] = g_glea2_d_t.glea006
               LET gs_keys[8] = g_glea2_d[g_detail_idx].glea032
               LET gs_keys_bak[8] = g_glea2_d_t.glea032
               LET gs_keys[9] = g_glea2_d[g_detail_idx].glea033
               LET gs_keys_bak[9] = g_glea2_d_t.glea033
               CALL aglq936_update_b('glea_t',gs_keys,gs_keys_bak,"'2'")
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_glea_m),util.JSON.stringify(g_glea2_d_t)
                     LET g_log2 = util.JSON.stringify(g_glea_m),util.JSON.stringify(g_glea2_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aglq936_glea_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="modify.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glea0122
            #add-point:BEFORE FIELD l_glea0122 name="input.b.page2.l_glea0122"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glea0122
            
            #add-point:AFTER FIELD l_glea0122 name="input.a.page2.l_glea0122"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glea0122
            #add-point:ON CHANGE l_glea0122 name="input.g.page2.l_glea0122"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glea0132
            #add-point:BEFORE FIELD l_glea0132 name="input.b.page2.l_glea0132"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glea0132
            
            #add-point:AFTER FIELD l_glea0132 name="input.a.page2.l_glea0132"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glea0132
            #add-point:ON CHANGE l_glea0132 name="input.g.page2.l_glea0132"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glea0142
            #add-point:BEFORE FIELD l_glea0142 name="input.b.page2.l_glea0142"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glea0142
            
            #add-point:AFTER FIELD l_glea0142 name="input.a.page2.l_glea0142"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glea0142
            #add-point:ON CHANGE l_glea0142 name="input.g.page2.l_glea0142"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glea0152
            #add-point:BEFORE FIELD l_glea0152 name="input.b.page2.l_glea0152"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glea0152
            
            #add-point:AFTER FIELD l_glea0152 name="input.a.page2.l_glea0152"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glea0152
            #add-point:ON CHANGE l_glea0152 name="input.g.page2.l_glea0152"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glea0162
            #add-point:BEFORE FIELD l_glea0162 name="input.b.page2.l_glea0162"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glea0162
            
            #add-point:AFTER FIELD l_glea0162 name="input.a.page2.l_glea0162"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glea0162
            #add-point:ON CHANGE l_glea0162 name="input.g.page2.l_glea0162"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glea0172
            #add-point:BEFORE FIELD l_glea0172 name="input.b.page2.l_glea0172"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glea0172
            
            #add-point:AFTER FIELD l_glea0172 name="input.a.page2.l_glea0172"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glea0172
            #add-point:ON CHANGE l_glea0172 name="input.g.page2.l_glea0172"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glea0182
            #add-point:BEFORE FIELD l_glea0182 name="input.b.page2.l_glea0182"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glea0182
            
            #add-point:AFTER FIELD l_glea0182 name="input.a.page2.l_glea0182"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glea0182
            #add-point:ON CHANGE l_glea0182 name="input.g.page2.l_glea0182"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glea0192
            #add-point:BEFORE FIELD l_glea0192 name="input.b.page2.l_glea0192"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glea0192
            
            #add-point:AFTER FIELD l_glea0192 name="input.a.page2.l_glea0192"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glea0192
            #add-point:ON CHANGE l_glea0192 name="input.g.page2.l_glea0192"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glea0202
            #add-point:BEFORE FIELD l_glea0202 name="input.b.page2.l_glea0202"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glea0202
            
            #add-point:AFTER FIELD l_glea0202 name="input.a.page2.l_glea0202"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glea0202
            #add-point:ON CHANGE l_glea0202 name="input.g.page2.l_glea0202"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glea0212
            #add-point:BEFORE FIELD l_glea0212 name="input.b.page2.l_glea0212"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glea0212
            
            #add-point:AFTER FIELD l_glea0212 name="input.a.page2.l_glea0212"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glea0212
            #add-point:ON CHANGE l_glea0212 name="input.g.page2.l_glea0212"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glea0222
            #add-point:BEFORE FIELD l_glea0222 name="input.b.page2.l_glea0222"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glea0222
            
            #add-point:AFTER FIELD l_glea0222 name="input.a.page2.l_glea0222"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glea0222
            #add-point:ON CHANGE l_glea0222 name="input.g.page2.l_glea0222"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glea0232
            #add-point:BEFORE FIELD l_glea0232 name="input.b.page2.l_glea0232"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glea0232
            
            #add-point:AFTER FIELD l_glea0232 name="input.a.page2.l_glea0232"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glea0232
            #add-point:ON CHANGE l_glea0232 name="input.g.page2.l_glea0232"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glea0242
            #add-point:BEFORE FIELD l_glea0242 name="input.b.page2.l_glea0242"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glea0242
            
            #add-point:AFTER FIELD l_glea0242 name="input.a.page2.l_glea0242"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glea0242
            #add-point:ON CHANGE l_glea0242 name="input.g.page2.l_glea0242"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glea0252
            #add-point:BEFORE FIELD l_glea0252 name="input.b.page2.l_glea0252"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glea0252
            
            #add-point:AFTER FIELD l_glea0252 name="input.a.page2.l_glea0252"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glea0252
            #add-point:ON CHANGE l_glea0252 name="input.g.page2.l_glea0252"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea035
            #add-point:BEFORE FIELD glea035 name="input.b.page2.glea035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea035
            
            #add-point:AFTER FIELD glea035 name="input.a.page2.glea035"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glea035
            #add-point:ON CHANGE glea035 name="input.g.page2.glea035"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea027
            #add-point:BEFORE FIELD glea027 name="input.b.page2.glea027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea027
            
            #add-point:AFTER FIELD glea027 name="input.a.page2.glea027"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glea027
            #add-point:ON CHANGE glea027 name="input.g.page2.glea027"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea028
            #add-point:BEFORE FIELD glea028 name="input.b.page2.glea028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea028
            
            #add-point:AFTER FIELD glea028 name="input.a.page2.glea028"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glea028
            #add-point:ON CHANGE glea028 name="input.g.page2.glea028"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_amt2
            #add-point:BEFORE FIELD l_amt2 name="input.b.page2.l_amt2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_amt2
            
            #add-point:AFTER FIELD l_amt2 name="input.a.page2.l_amt2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_amt2
            #add-point:ON CHANGE l_amt2 name="input.g.page2.l_amt2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea026
            #add-point:BEFORE FIELD glea026 name="input.b.page2.glea026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea026
            
            #add-point:AFTER FIELD glea026 name="input.a.page2.glea026"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glea026
            #add-point:ON CHANGE glea026 name="input.g.page2.glea026"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.l_glea0122
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glea0122
            #add-point:ON ACTION controlp INFIELD l_glea0122 name="input.c.page2.l_glea0122"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_glea0132
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glea0132
            #add-point:ON ACTION controlp INFIELD l_glea0132 name="input.c.page2.l_glea0132"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_glea0142
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glea0142
            #add-point:ON ACTION controlp INFIELD l_glea0142 name="input.c.page2.l_glea0142"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_glea0152
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glea0152
            #add-point:ON ACTION controlp INFIELD l_glea0152 name="input.c.page2.l_glea0152"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_glea0162
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glea0162
            #add-point:ON ACTION controlp INFIELD l_glea0162 name="input.c.page2.l_glea0162"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_glea0172
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glea0172
            #add-point:ON ACTION controlp INFIELD l_glea0172 name="input.c.page2.l_glea0172"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_glea0182
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glea0182
            #add-point:ON ACTION controlp INFIELD l_glea0182 name="input.c.page2.l_glea0182"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_glea0192
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glea0192
            #add-point:ON ACTION controlp INFIELD l_glea0192 name="input.c.page2.l_glea0192"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_glea0202
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glea0202
            #add-point:ON ACTION controlp INFIELD l_glea0202 name="input.c.page2.l_glea0202"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_glea0212
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glea0212
            #add-point:ON ACTION controlp INFIELD l_glea0212 name="input.c.page2.l_glea0212"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_glea0222
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glea0222
            #add-point:ON ACTION controlp INFIELD l_glea0222 name="input.c.page2.l_glea0222"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_glea0232
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glea0232
            #add-point:ON ACTION controlp INFIELD l_glea0232 name="input.c.page2.l_glea0232"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_glea0242
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glea0242
            #add-point:ON ACTION controlp INFIELD l_glea0242 name="input.c.page2.l_glea0242"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_glea0252
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glea0252
            #add-point:ON ACTION controlp INFIELD l_glea0252 name="input.c.page2.l_glea0252"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.glea035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea035
            #add-point:ON ACTION controlp INFIELD glea035 name="input.c.page2.glea035"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.glea027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea027
            #add-point:ON ACTION controlp INFIELD glea027 name="input.c.page2.glea027"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.glea028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea028
            #add-point:ON ACTION controlp INFIELD glea028 name="input.c.page2.glea028"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_amt2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_amt2
            #add-point:ON ACTION controlp INFIELD l_amt2 name="input.c.page2.l_amt2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.glea026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea026
            #add-point:ON ACTION controlp INFIELD glea026 name="input.c.page2.glea026"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:input段after row name="input.body2.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_glea2_d[l_ac].* = g_glea2_d_t.*
               END IF
               CLOSE aglq936_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               EXIT DIALOG 
            END IF
 
            CLOSE aglq936_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #add-point:input段after input  name="input.body2.after_input"
            
            #end add-point    
 
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_glea_d[li_reproduce_target].* = g_glea_d[li_reproduce].*
               LET g_glea2_d[li_reproduce_target].* = g_glea2_d[li_reproduce].*
               LET g_glea3_d[li_reproduce_target].* = g_glea3_d[li_reproduce].*
 
               LET g_glea2_d[li_reproduce_target].glea002 = NULL
               LET g_glea2_d[li_reproduce_target].glea005 = NULL
               LET g_glea2_d[li_reproduce_target].glea006 = NULL
               LET g_glea2_d[li_reproduce_target].glea032 = NULL
               LET g_glea2_d[li_reproduce_target].glea033 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_glea2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_glea2_d.getLength()+1
            END IF
      END INPUT
      INPUT ARRAY g_glea3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b, WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                   INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                   DELETE ROW = l_allow_delete,
                   APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
                 
         BEFORE INPUT
            
            CALL aglq936_b_fill(g_wc2) #test 
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
            CALL aglq936_idx_chk()
            
            CALL s_transaction_begin()
            IF g_rec_b >= l_ac THEN
               LET l_cmd='u'
               CALL aglq936_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body3.before_row.set_entry_b"
               
               #end add-point
               CALL aglq936_set_no_entry_b(l_cmd)
               LET g_glea3_d_t.* = g_glea3_d[l_ac].*   #BACKUP  #page1
               LET g_glea3_d_o.* = g_glea3_d[l_ac].*   #BACKUP  #page1
            END IF 
            
 
 
 
    
         BEFORE INSERT
            LET g_insert = 'Y' 
            NEXT FIELD glea002
 
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            INITIALIZE g_glea3_d_t.* TO NULL
            INITIALIZE g_glea3_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_glea3_d[l_ac].* TO NULL
            #公用欄位預設值
              
            #一般欄位預設值
                  LET g_glea3_d[l_ac].l_glea0183 = "N"
      LET g_glea3_d[l_ac].l_glea0193 = "N"
      LET g_glea3_d[l_ac].glea036 = "0"
      LET g_glea3_d[l_ac].glea030 = "0"
      LET g_glea3_d[l_ac].glea031 = "0"
      LET g_glea3_d[l_ac].l_amt3 = "0"
 
            
            #add-point:modify段before備份 name="input.body3.before_insert.before_bak"
            
            #end add-point
            LET g_glea3_d_t.* = g_glea3_d[l_ac].*     #新輸入資料
            LET g_glea3_d_o.* = g_glea3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aglq936_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body3.before_insert.set_entry_b"
            
            #end add-point
            CALL aglq936_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_glea_d[li_reproduce_target].* = g_glea_d[li_reproduce].*
               LET g_glea2_d[li_reproduce_target].* = g_glea2_d[li_reproduce].*
               LET g_glea3_d[li_reproduce_target].* = g_glea3_d[li_reproduce].*
 
               LET g_glea3_d[li_reproduce_target].glea002 = NULL
               LET g_glea3_d[li_reproduce_target].glea005 = NULL
               LET g_glea3_d[li_reproduce_target].glea006 = NULL
               LET g_glea3_d[li_reproduce_target].glea032 = NULL
               LET g_glea3_d[li_reproduce_target].glea033 = NULL
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
               IF aglq936_before_delete() THEN 
                  
 
 
 
  
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_glea_m.gleald
                  LET gs_keys[gs_keys.getLength()+1] = g_glea_m.glea001
                  LET gs_keys[gs_keys.getLength()+1] = g_glea_m.glea003
                  LET gs_keys[gs_keys.getLength()+1] = g_glea_m.glea004
                  LET gs_keys[gs_keys.getLength()+1] = g_glea_d_t.glea002
                  LET gs_keys[gs_keys.getLength()+1] = g_glea_d_t.glea005
                  LET gs_keys[gs_keys.getLength()+1] = g_glea_d_t.glea006
                  LET gs_keys[gs_keys.getLength()+1] = g_glea_d_t.glea032
                  LET gs_keys[gs_keys.getLength()+1] = g_glea_d_t.glea033
 
                  #刪除下層單身
                  IF NOT aglq936_key_delete_b(gs_keys,'glea_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE aglq936_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE aglq936_bcl
               CALL s_transaction_end('Y','0') 
               LET l_count = g_glea3_d.getLength()
            END IF
            
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body3.after_delete"
               
               #end add-point
                              CALL aglq936_delete_b('glea_t',gs_keys,"'3'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_glea3_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_glea3_d[l_ac].* = g_glea3_d_t.*
               CLOSE aglq936_bcl
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
               LET g_errparam.extend = g_glea_d[l_ac].glea002 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_glea3_d[l_ac].* = g_glea3_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               
                
               #add-point:單身修改前 name="modify.body3.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL aglq936_glea_t_mask_restore('restore_mask_o')
                     
               UPDATE glea_t SET (gleald,glea001,glea003,glea004,glea005,glea012,glea013,glea014,glea015, 
                   glea016,glea017,glea018,glea019,glea020,glea021,glea022,glea023,glea024,glea025,glea034, 
                   glea008,glea009,glea007,glea002,glea006,glea032,glea033,glea035,glea027,glea028,glea026, 
                   glea036,glea030,glea031,glea029) = (g_glea_m.gleald,g_glea_m.glea001,g_glea_m.glea003, 
                   g_glea_m.glea004,g_glea_d[l_ac].glea005,g_glea_d[l_ac].glea012,g_glea_d[l_ac].glea013, 
                   g_glea_d[l_ac].glea014,g_glea_d[l_ac].glea015,g_glea_d[l_ac].glea016,g_glea_d[l_ac].glea017, 
                   g_glea_d[l_ac].glea018,g_glea_d[l_ac].glea019,g_glea_d[l_ac].glea020,g_glea_d[l_ac].glea021, 
                   g_glea_d[l_ac].glea022,g_glea_d[l_ac].glea023,g_glea_d[l_ac].glea024,g_glea_d[l_ac].glea025, 
                   g_glea_d[l_ac].glea034,g_glea_d[l_ac].glea008,g_glea_d[l_ac].glea009,g_glea_d[l_ac].glea007, 
                   g_glea_d[l_ac].glea002,g_glea_d[l_ac].glea006,g_glea_d[l_ac].glea032,g_glea_d[l_ac].glea033, 
                   g_glea2_d[l_ac].glea035,g_glea2_d[l_ac].glea027,g_glea2_d[l_ac].glea028,g_glea2_d[l_ac].glea026, 
                   g_glea3_d[l_ac].glea036,g_glea3_d[l_ac].glea030,g_glea3_d[l_ac].glea031,g_glea3_d[l_ac].glea029)  
                   #自訂欄位頁簽
                WHERE gleaent = g_enterprise AND gleald = g_glea_m.gleald
                 AND glea001 = g_glea_m.glea001
                 AND glea003 = g_glea_m.glea003
                 AND glea004 = g_glea_m.glea004
                 AND glea002 = g_glea3_d_t.glea002 #項次 
                 AND glea005 = g_glea3_d_t.glea005
                 AND glea006 = g_glea3_d_t.glea006
                 AND glea032 = g_glea3_d_t.glea032
                 AND glea033 = g_glea3_d_t.glea033
               #add-point:單身修改中 name="modify.body3.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "glea_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "glea_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_glea_m.gleald
               LET gs_keys_bak[1] = g_gleald_t
               LET gs_keys[2] = g_glea_m.glea001
               LET gs_keys_bak[2] = g_glea001_t
               LET gs_keys[3] = g_glea_m.glea003
               LET gs_keys_bak[3] = g_glea003_t
               LET gs_keys[4] = g_glea_m.glea004
               LET gs_keys_bak[4] = g_glea004_t
               LET gs_keys[5] = g_glea3_d[g_detail_idx].glea002
               LET gs_keys_bak[5] = g_glea3_d_t.glea002
               LET gs_keys[6] = g_glea3_d[g_detail_idx].glea005
               LET gs_keys_bak[6] = g_glea3_d_t.glea005
               LET gs_keys[7] = g_glea3_d[g_detail_idx].glea006
               LET gs_keys_bak[7] = g_glea3_d_t.glea006
               LET gs_keys[8] = g_glea3_d[g_detail_idx].glea032
               LET gs_keys_bak[8] = g_glea3_d_t.glea032
               LET gs_keys[9] = g_glea3_d[g_detail_idx].glea033
               LET gs_keys_bak[9] = g_glea3_d_t.glea033
               CALL aglq936_update_b('glea_t',gs_keys,gs_keys_bak,"'3'")
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_glea_m),util.JSON.stringify(g_glea3_d_t)
                     LET g_log2 = util.JSON.stringify(g_glea_m),util.JSON.stringify(g_glea3_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aglq936_glea_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="modify.body3.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glea0123
            #add-point:BEFORE FIELD l_glea0123 name="input.b.page3.l_glea0123"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glea0123
            
            #add-point:AFTER FIELD l_glea0123 name="input.a.page3.l_glea0123"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glea0123
            #add-point:ON CHANGE l_glea0123 name="input.g.page3.l_glea0123"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glea0133
            #add-point:BEFORE FIELD l_glea0133 name="input.b.page3.l_glea0133"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glea0133
            
            #add-point:AFTER FIELD l_glea0133 name="input.a.page3.l_glea0133"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glea0133
            #add-point:ON CHANGE l_glea0133 name="input.g.page3.l_glea0133"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glea0143
            #add-point:BEFORE FIELD l_glea0143 name="input.b.page3.l_glea0143"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glea0143
            
            #add-point:AFTER FIELD l_glea0143 name="input.a.page3.l_glea0143"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glea0143
            #add-point:ON CHANGE l_glea0143 name="input.g.page3.l_glea0143"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glea0153
            #add-point:BEFORE FIELD l_glea0153 name="input.b.page3.l_glea0153"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glea0153
            
            #add-point:AFTER FIELD l_glea0153 name="input.a.page3.l_glea0153"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glea0153
            #add-point:ON CHANGE l_glea0153 name="input.g.page3.l_glea0153"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glea0163
            #add-point:BEFORE FIELD l_glea0163 name="input.b.page3.l_glea0163"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glea0163
            
            #add-point:AFTER FIELD l_glea0163 name="input.a.page3.l_glea0163"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glea0163
            #add-point:ON CHANGE l_glea0163 name="input.g.page3.l_glea0163"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glea0173
            #add-point:BEFORE FIELD l_glea0173 name="input.b.page3.l_glea0173"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glea0173
            
            #add-point:AFTER FIELD l_glea0173 name="input.a.page3.l_glea0173"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glea0173
            #add-point:ON CHANGE l_glea0173 name="input.g.page3.l_glea0173"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glea0183
            #add-point:BEFORE FIELD l_glea0183 name="input.b.page3.l_glea0183"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glea0183
            
            #add-point:AFTER FIELD l_glea0183 name="input.a.page3.l_glea0183"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glea0183
            #add-point:ON CHANGE l_glea0183 name="input.g.page3.l_glea0183"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glea0193
            #add-point:BEFORE FIELD l_glea0193 name="input.b.page3.l_glea0193"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glea0193
            
            #add-point:AFTER FIELD l_glea0193 name="input.a.page3.l_glea0193"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glea0193
            #add-point:ON CHANGE l_glea0193 name="input.g.page3.l_glea0193"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glea0203
            #add-point:BEFORE FIELD l_glea0203 name="input.b.page3.l_glea0203"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glea0203
            
            #add-point:AFTER FIELD l_glea0203 name="input.a.page3.l_glea0203"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glea0203
            #add-point:ON CHANGE l_glea0203 name="input.g.page3.l_glea0203"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glea0213
            #add-point:BEFORE FIELD l_glea0213 name="input.b.page3.l_glea0213"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glea0213
            
            #add-point:AFTER FIELD l_glea0213 name="input.a.page3.l_glea0213"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glea0213
            #add-point:ON CHANGE l_glea0213 name="input.g.page3.l_glea0213"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glea0223
            #add-point:BEFORE FIELD l_glea0223 name="input.b.page3.l_glea0223"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glea0223
            
            #add-point:AFTER FIELD l_glea0223 name="input.a.page3.l_glea0223"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glea0223
            #add-point:ON CHANGE l_glea0223 name="input.g.page3.l_glea0223"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glea0233
            #add-point:BEFORE FIELD l_glea0233 name="input.b.page3.l_glea0233"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glea0233
            
            #add-point:AFTER FIELD l_glea0233 name="input.a.page3.l_glea0233"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glea0233
            #add-point:ON CHANGE l_glea0233 name="input.g.page3.l_glea0233"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glea0243
            #add-point:BEFORE FIELD l_glea0243 name="input.b.page3.l_glea0243"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glea0243
            
            #add-point:AFTER FIELD l_glea0243 name="input.a.page3.l_glea0243"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glea0243
            #add-point:ON CHANGE l_glea0243 name="input.g.page3.l_glea0243"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glea0253
            #add-point:BEFORE FIELD l_glea0253 name="input.b.page3.l_glea0253"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glea0253
            
            #add-point:AFTER FIELD l_glea0253 name="input.a.page3.l_glea0253"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glea0253
            #add-point:ON CHANGE l_glea0253 name="input.g.page3.l_glea0253"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea036
            #add-point:BEFORE FIELD glea036 name="input.b.page3.glea036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea036
            
            #add-point:AFTER FIELD glea036 name="input.a.page3.glea036"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glea036
            #add-point:ON CHANGE glea036 name="input.g.page3.glea036"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea030
            #add-point:BEFORE FIELD glea030 name="input.b.page3.glea030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea030
            
            #add-point:AFTER FIELD glea030 name="input.a.page3.glea030"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glea030
            #add-point:ON CHANGE glea030 name="input.g.page3.glea030"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea031
            #add-point:BEFORE FIELD glea031 name="input.b.page3.glea031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea031
            
            #add-point:AFTER FIELD glea031 name="input.a.page3.glea031"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glea031
            #add-point:ON CHANGE glea031 name="input.g.page3.glea031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_amt3
            #add-point:BEFORE FIELD l_amt3 name="input.b.page3.l_amt3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_amt3
            
            #add-point:AFTER FIELD l_amt3 name="input.a.page3.l_amt3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_amt3
            #add-point:ON CHANGE l_amt3 name="input.g.page3.l_amt3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glea029
            #add-point:BEFORE FIELD glea029 name="input.b.page3.glea029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glea029
            
            #add-point:AFTER FIELD glea029 name="input.a.page3.glea029"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glea029
            #add-point:ON CHANGE glea029 name="input.g.page3.glea029"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.l_glea0123
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glea0123
            #add-point:ON ACTION controlp INFIELD l_glea0123 name="input.c.page3.l_glea0123"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_glea0133
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glea0133
            #add-point:ON ACTION controlp INFIELD l_glea0133 name="input.c.page3.l_glea0133"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_glea0143
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glea0143
            #add-point:ON ACTION controlp INFIELD l_glea0143 name="input.c.page3.l_glea0143"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_glea0153
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glea0153
            #add-point:ON ACTION controlp INFIELD l_glea0153 name="input.c.page3.l_glea0153"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_glea0163
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glea0163
            #add-point:ON ACTION controlp INFIELD l_glea0163 name="input.c.page3.l_glea0163"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_glea0173
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glea0173
            #add-point:ON ACTION controlp INFIELD l_glea0173 name="input.c.page3.l_glea0173"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_glea0183
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glea0183
            #add-point:ON ACTION controlp INFIELD l_glea0183 name="input.c.page3.l_glea0183"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_glea0193
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glea0193
            #add-point:ON ACTION controlp INFIELD l_glea0193 name="input.c.page3.l_glea0193"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_glea0203
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glea0203
            #add-point:ON ACTION controlp INFIELD l_glea0203 name="input.c.page3.l_glea0203"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_glea0213
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glea0213
            #add-point:ON ACTION controlp INFIELD l_glea0213 name="input.c.page3.l_glea0213"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_glea0223
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glea0223
            #add-point:ON ACTION controlp INFIELD l_glea0223 name="input.c.page3.l_glea0223"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_glea0233
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glea0233
            #add-point:ON ACTION controlp INFIELD l_glea0233 name="input.c.page3.l_glea0233"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_glea0243
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glea0243
            #add-point:ON ACTION controlp INFIELD l_glea0243 name="input.c.page3.l_glea0243"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_glea0253
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glea0253
            #add-point:ON ACTION controlp INFIELD l_glea0253 name="input.c.page3.l_glea0253"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.glea036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea036
            #add-point:ON ACTION controlp INFIELD glea036 name="input.c.page3.glea036"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.glea030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea030
            #add-point:ON ACTION controlp INFIELD glea030 name="input.c.page3.glea030"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.glea031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea031
            #add-point:ON ACTION controlp INFIELD glea031 name="input.c.page3.glea031"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.l_amt3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_amt3
            #add-point:ON ACTION controlp INFIELD l_amt3 name="input.c.page3.l_amt3"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.glea029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glea029
            #add-point:ON ACTION controlp INFIELD glea029 name="input.c.page3.glea029"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:input段after row name="input.body3.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_glea3_d[l_ac].* = g_glea3_d_t.*
               END IF
               CLOSE aglq936_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               EXIT DIALOG 
            END IF
 
            CLOSE aglq936_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #add-point:input段after input  name="input.body3.after_input"
            
            #end add-point    
 
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_glea_d[li_reproduce_target].* = g_glea_d[li_reproduce].*
               LET g_glea2_d[li_reproduce_target].* = g_glea2_d[li_reproduce].*
               LET g_glea3_d[li_reproduce_target].* = g_glea3_d[li_reproduce].*
 
               LET g_glea3_d[li_reproduce_target].glea002 = NULL
               LET g_glea3_d[li_reproduce_target].glea005 = NULL
               LET g_glea3_d[li_reproduce_target].glea006 = NULL
               LET g_glea3_d[li_reproduce_target].glea032 = NULL
               LET g_glea3_d[li_reproduce_target].glea033 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_glea3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_glea3_d.getLength()+1
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
            NEXT FIELD gleald
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD glea005
               WHEN "s_detail2"
                  NEXT FIELD glea005_2
               WHEN "s_detail3"
                  NEXT FIELD glea005_3
 
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
 
{<section id="aglq936.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aglq936_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL aglq936_b_fill(g_wc2) #第一階單身填充
      CALL aglq936_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aglq936_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_glea_m.gleald,g_glea_m.gleald_desc,g_glea_m.glea001,g_glea_m.glea001_desc,g_glea_m.glea003, 
       g_glea_m.glea004,g_glea_m.l_glea007,g_glea_m.l_glea026,g_glea_m.l_glea029,g_glea_m.l_chk12,g_glea_m.l_chk13, 
       g_glea_m.l_chk14,g_glea_m.l_chk15,g_glea_m.l_chk16,g_glea_m.l_chk17,g_glea_m.l_chk18,g_glea_m.l_chk19, 
       g_glea_m.l_chk20,g_glea_m.l_chk21,g_glea_m.l_chk22,g_glea_m.l_chk23,g_glea_m.l_chk24,g_glea_m.l_chk25 
 
 
   CALL aglq936_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
   DISPLAY BY NAME g_input.l_chk12,g_input.l_chk13,g_input.l_chk14,g_input.l_chk15,g_input.l_chk16,
                   g_input.l_chk17,g_input.l_chk18,g_input.l_chk19,g_input.l_chk20,g_input.l_chk21,
                   g_input.l_chk22,g_input.l_chk23,g_input.l_chk24,g_input.l_chk25
   
   CALL aglq936_show_visible()   #單身欄位關閉    
   CALL aglq936_ld_visible()     #依帳套隱顯多本幣
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="aglq936.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION aglq936_ref_show()
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
   LET g_glea_m.gleald_desc  = s_desc_get_ld_desc(g_glea_m.gleald)
   LET g_glea_m.glea001_desc = s_desc_glda001_desc(g_glea_m.glea001)
   
   DISPLAY BY NAME g_glea_m.gleald_desc,g_glea_m.glea001_desc
   #end add-point
 
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_glea_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_glea2_d.getLength()
      #add-point:ref_show段d2_reference name="ref_show.body2.reference"
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_glea3_d.getLength()
      #add-point:ref_show段d3_reference name="ref_show.body3.reference"
      
      #end add-point
   END FOR
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="aglq936.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aglq936_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE glea_t.gleald 
   DEFINE l_oldno     LIKE glea_t.gleald 
   DEFINE l_newno02     LIKE glea_t.glea001 
   DEFINE l_oldno02     LIKE glea_t.glea001 
   DEFINE l_newno03     LIKE glea_t.glea003 
   DEFINE l_oldno03     LIKE glea_t.glea003 
   DEFINE l_newno04     LIKE glea_t.glea004 
   DEFINE l_oldno04     LIKE glea_t.glea004 
 
   DEFINE l_master    RECORD LIKE glea_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE glea_t.* #此變數樣板目前無使用
 
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
 
   IF g_glea_m.gleald IS NULL
      OR g_glea_m.glea001 IS NULL
      OR g_glea_m.glea003 IS NULL
      OR g_glea_m.glea004 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_gleald_t = g_glea_m.gleald
   LET g_glea001_t = g_glea_m.glea001
   LET g_glea003_t = g_glea_m.glea003
   LET g_glea004_t = g_glea_m.glea004
 
   
   LET g_glea_m.gleald = ""
   LET g_glea_m.glea001 = ""
   LET g_glea_m.glea003 = ""
   LET g_glea_m.glea004 = ""
 
   LET g_master_insert = FALSE
   CALL aglq936_set_entry('a')
   CALL aglq936_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #清空key欄位的desc
      LET g_glea_m.gleald_desc = ''
   DISPLAY BY NAME g_glea_m.gleald_desc
   LET g_glea_m.glea001_desc = ''
   DISPLAY BY NAME g_glea_m.glea001_desc
 
   
   CALL aglq936_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_glea_m.* TO NULL
      INITIALIZE g_glea_d TO NULL
      INITIALIZE g_glea2_d TO NULL
      INITIALIZE g_glea3_d TO NULL
 
      CALL aglq936_show()
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
   CALL aglq936_set_act_visible()
   CALL aglq936_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_gleald_t = g_glea_m.gleald
   LET g_glea001_t = g_glea_m.glea001
   LET g_glea003_t = g_glea_m.glea003
   LET g_glea004_t = g_glea_m.glea004
 
   
   #組合新增資料的條件
   LET g_add_browse = " gleaent = " ||g_enterprise|| " AND",
                      " gleald = '", g_glea_m.gleald, "' "
                      ," AND glea001 = '", g_glea_m.glea001, "' "
                      ," AND glea003 = '", g_glea_m.glea003, "' "
                      ," AND glea004 = '", g_glea_m.glea004, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aglq936_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL aglq936_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL aglq936_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="aglq936.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION aglq936_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE glea_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aglq936_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM glea_t
    WHERE gleaent = g_enterprise AND gleald = g_gleald_t
    AND glea001 = g_glea001_t
    AND glea003 = g_glea003_t
    AND glea004 = g_glea004_t
 
       INTO TEMP aglq936_detail
   
   #將key修正為調整後   
   UPDATE aglq936_detail 
      #更新key欄位
      SET gleald = g_glea_m.gleald
          , glea001 = g_glea_m.glea001
          , glea003 = g_glea_m.glea003
          , glea004 = g_glea_m.glea004
 
      #更新共用欄位
      
                                       
   #將資料塞回原table   
   INSERT INTO glea_t SELECT * FROM aglq936_detail
   
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
   DROP TABLE aglq936_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_gleald_t = g_glea_m.gleald
   LET g_glea001_t = g_glea_m.glea001
   LET g_glea003_t = g_glea_m.glea003
   LET g_glea004_t = g_glea_m.glea004
 
   
   DROP TABLE aglq936_detail
   
END FUNCTION
 
{</section>}
 
{<section id="aglq936.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aglq936_delete()
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
   
   IF g_glea_m.gleald IS NULL
   OR g_glea_m.glea001 IS NULL
   OR g_glea_m.glea003 IS NULL
   OR g_glea_m.glea004 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN aglq936_cl USING g_enterprise,g_glea_m.gleald,g_glea_m.glea001,g_glea_m.glea003,g_glea_m.glea004
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aglq936_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE aglq936_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aglq936_master_referesh USING g_glea_m.gleald,g_glea_m.glea001,g_glea_m.glea003,g_glea_m.glea004 INTO g_glea_m.gleald, 
       g_glea_m.glea001,g_glea_m.glea003,g_glea_m.glea004
   
   #遮罩相關處理
   LET g_glea_m_mask_o.* =  g_glea_m.*
   CALL aglq936_glea_t_mask()
   LET g_glea_m_mask_n.* =  g_glea_m.*
   
   CALL aglq936_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aglq936_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM glea_t WHERE gleaent = g_enterprise AND gleald = g_glea_m.gleald
                                                               AND glea001 = g_glea_m.glea001
                                                               AND glea003 = g_glea_m.glea003
                                                               AND glea004 = g_glea_m.glea004
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "glea_t:",SQLERRMESSAGE 
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
      #   CLOSE aglq936_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_glea_d.clear() 
      CALL g_glea2_d.clear()       
      CALL g_glea3_d.clear()       
 
     
      CALL aglq936_ui_browser_refresh()  
      #CALL aglq936_ui_headershow()  
      #CALL aglq936_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL aglq936_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL aglq936_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE aglq936_cl
 
   #功能已完成,通報訊息中心
   CALL aglq936_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="aglq936.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aglq936_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #先清空單身變數內容
   CALL g_glea_d.clear()
   CALL g_glea2_d.clear()
   CALL g_glea3_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT glea005,glea012,glea013,glea014,glea015,glea016,glea017,glea018,glea019, 
       glea020,glea021,glea022,glea023,glea024,glea025,glea034,glea008,glea009,glea007,glea002,glea006, 
       glea032,glea033,glea005,glea035,glea027,glea028,glea026,glea002,glea006,glea032,glea033,glea005, 
       glea036,glea030,glea031,glea029,glea002,glea006,glea032,glea033 FROM glea_t",   
               "",
               
               
               " WHERE gleaent= ? AND gleald=? AND glea001=? AND glea003=? AND glea004=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("glea_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF aglq936_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY glea_t.glea002,glea_t.glea005,glea_t.glea006,glea_t.glea032,glea_t.glea033"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
         
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aglq936_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR aglq936_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_glea_m.gleald,g_glea_m.glea001,g_glea_m.glea003,g_glea_m.glea004   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_glea_m.gleald,g_glea_m.glea001,g_glea_m.glea003,g_glea_m.glea004 INTO g_glea_d[l_ac].glea005, 
          g_glea_d[l_ac].glea012,g_glea_d[l_ac].glea013,g_glea_d[l_ac].glea014,g_glea_d[l_ac].glea015, 
          g_glea_d[l_ac].glea016,g_glea_d[l_ac].glea017,g_glea_d[l_ac].glea018,g_glea_d[l_ac].glea019, 
          g_glea_d[l_ac].glea020,g_glea_d[l_ac].glea021,g_glea_d[l_ac].glea022,g_glea_d[l_ac].glea023, 
          g_glea_d[l_ac].glea024,g_glea_d[l_ac].glea025,g_glea_d[l_ac].glea034,g_glea_d[l_ac].glea008, 
          g_glea_d[l_ac].glea009,g_glea_d[l_ac].glea007,g_glea_d[l_ac].glea002,g_glea_d[l_ac].glea006, 
          g_glea_d[l_ac].glea032,g_glea_d[l_ac].glea033,g_glea2_d[l_ac].glea005,g_glea2_d[l_ac].glea035, 
          g_glea2_d[l_ac].glea027,g_glea2_d[l_ac].glea028,g_glea2_d[l_ac].glea026,g_glea2_d[l_ac].glea002, 
          g_glea2_d[l_ac].glea006,g_glea2_d[l_ac].glea032,g_glea2_d[l_ac].glea033,g_glea3_d[l_ac].glea005, 
          g_glea3_d[l_ac].glea036,g_glea3_d[l_ac].glea030,g_glea3_d[l_ac].glea031,g_glea3_d[l_ac].glea029, 
          g_glea3_d[l_ac].glea002,g_glea3_d[l_ac].glea006,g_glea3_d[l_ac].glea032,g_glea3_d[l_ac].glea033  
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
         #核算項
         LET g_glea_d[l_ac].glea012_desc =  s_desc_show1(g_glea_d[l_ac].glea012,s_merge_source_desc('1',g_glea_d[l_ac].glea012))
         LET g_glea2_d[l_ac].l_glea0122 = g_glea_d[l_ac].glea012_desc
         LET g_glea3_d[l_ac].l_glea0123 = g_glea_d[l_ac].glea012_desc
         LET g_glea_d[l_ac].glea013_desc =  s_desc_show1(g_glea_d[l_ac].glea013,s_merge_source_desc('2',g_glea_d[l_ac].glea013))
         LET g_glea2_d[l_ac].l_glea0132 = g_glea_d[l_ac].glea013_desc
         LET g_glea3_d[l_ac].l_glea0133 = g_glea_d[l_ac].glea013_desc
         LET g_glea_d[l_ac].glea014_desc =  s_desc_show1(g_glea_d[l_ac].glea014,s_merge_source_desc('3',g_glea_d[l_ac].glea014))
         LET g_glea2_d[l_ac].l_glea0142 = g_glea_d[l_ac].glea014_desc
         LET g_glea3_d[l_ac].l_glea0143 = g_glea_d[l_ac].glea014_desc
         LET g_glea_d[l_ac].glea015_desc =  s_desc_show1(g_glea_d[l_ac].glea015,s_merge_source_desc('4',g_glea_d[l_ac].glea015))
         LET g_glea2_d[l_ac].l_glea0152 = g_glea_d[l_ac].glea015_desc
         LET g_glea3_d[l_ac].l_glea0153 = g_glea_d[l_ac].glea015_desc
         LET g_glea_d[l_ac].glea016_desc =  s_desc_show1(g_glea_d[l_ac].glea016,s_merge_source_desc('5',g_glea_d[l_ac].glea016))
         LET g_glea2_d[l_ac].l_glea0162 = g_glea_d[l_ac].glea016_desc
         LET g_glea3_d[l_ac].l_glea0163 = g_glea_d[l_ac].glea016_desc
         LET g_glea_d[l_ac].glea017_desc =  s_desc_show1(g_glea_d[l_ac].glea017,s_merge_source_desc('6',g_glea_d[l_ac].glea017))
         LET g_glea2_d[l_ac].l_glea0172 = g_glea_d[l_ac].glea017_desc
         LET g_glea3_d[l_ac].l_glea0173 = g_glea_d[l_ac].glea017_desc
         LET g_glea_d[l_ac].glea018_desc =  s_desc_show1(g_glea_d[l_ac].glea018,s_merge_source_desc('7',g_glea_d[l_ac].glea018))
         LET g_glea2_d[l_ac].l_glea0182 = g_glea_d[l_ac].glea018_desc
         LET g_glea3_d[l_ac].l_glea0183 = g_glea_d[l_ac].glea018_desc         
         LET g_glea_d[l_ac].glea019_desc =  s_desc_show1(g_glea_d[l_ac].glea019,s_merge_source_desc('8',g_glea_d[l_ac].glea019))
         LET g_glea2_d[l_ac].l_glea0192 = g_glea_d[l_ac].glea019_desc
         LET g_glea3_d[l_ac].l_glea0193 = g_glea_d[l_ac].glea019_desc         
         LET g_glea_d[l_ac].glea021_desc =  s_desc_show1(g_glea_d[l_ac].glea021,s_merge_source_desc('10',g_glea_d[l_ac].glea021))
         LET g_glea2_d[l_ac].l_glea0212 = g_glea_d[l_ac].glea021_desc
         LET g_glea3_d[l_ac].l_glea0213 = g_glea_d[l_ac].glea021_desc
         LET g_glea_d[l_ac].glea022_desc =  s_desc_show1(g_glea_d[l_ac].glea022,s_merge_source_desc('11',g_glea_d[l_ac].glea022))
         LET g_glea2_d[l_ac].l_glea0222 = g_glea_d[l_ac].glea022_desc
         LET g_glea3_d[l_ac].l_glea0223 = g_glea_d[l_ac].glea022_desc
         LET g_glea_d[l_ac].glea023_desc =  s_desc_show1(g_glea_d[l_ac].glea023,s_merge_source_desc('12',g_glea_d[l_ac].glea023))
         LET g_glea2_d[l_ac].l_glea0232 = g_glea_d[l_ac].glea023_desc
         LET g_glea3_d[l_ac].l_glea0233 = g_glea_d[l_ac].glea023_desc
         LET g_glea_d[l_ac].glea024_desc =  s_desc_show1(g_glea_d[l_ac].glea024,s_merge_source_desc('13',g_glea_d[l_ac].glea024))
         LET g_glea2_d[l_ac].l_glea0242 = g_glea_d[l_ac].glea024_desc
         LET g_glea3_d[l_ac].l_glea0243 = g_glea_d[l_ac].glea024_desc
         LET g_glea_d[l_ac].glea025_desc =  s_desc_show1(g_glea_d[l_ac].glea025,s_desc_get_wbs_desc(g_glea_d[l_ac].glea024,g_glea_d[l_ac].glea025))
         LET g_glea2_d[l_ac].l_glea0252 = g_glea_d[l_ac].glea025_desc
         LET g_glea3_d[l_ac].l_glea0253 = g_glea_d[l_ac].glea025_desc
         
         #餘額
         LET g_glea_d[l_ac].l_amt = g_glea_d[l_ac].glea008 - g_glea_d[l_ac].glea009
         LET g_glea2_d[l_ac].l_amt2 = g_glea2_d[l_ac].glea027 - g_glea2_d[l_ac].glea028
         LET g_glea3_d[l_ac].l_amt3 = g_glea3_d[l_ac].glea030 - g_glea3_d[l_ac].glea031
         
         #科目
         LET g_glea_d[l_ac].glea005_desc = s_desc_get_account_desc(g_glea_m.gleald,g_glea_d[l_ac].glea005)
         LET g_glea2_d[l_ac].glea0052_desc =  g_glea_d[l_ac].glea005_desc
         LET g_glea3_d[l_ac].glea0053_desc =  g_glea_d[l_ac].glea005_desc
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
 
            CALL g_glea_d.deleteElement(g_glea_d.getLength())
      CALL g_glea2_d.deleteElement(g_glea2_d.getLength())
      CALL g_glea3_d.deleteElement(g_glea3_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
   
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_glea_d.getLength()
      LET g_glea_d_mask_o[l_ac].* =  g_glea_d[l_ac].*
      CALL aglq936_glea_t_mask()
      LET g_glea_d_mask_n[l_ac].* =  g_glea_d[l_ac].*
   END FOR
   
   LET g_glea2_d_mask_o.* =  g_glea2_d.*
   FOR l_ac = 1 TO g_glea2_d.getLength()
      LET g_glea2_d_mask_o[l_ac].* =  g_glea2_d[l_ac].*
      CALL aglq936_glea_t_mask()
      LET g_glea2_d_mask_n[l_ac].* =  g_glea2_d[l_ac].*
   END FOR
   LET g_glea3_d_mask_o.* =  g_glea3_d.*
   FOR l_ac = 1 TO g_glea3_d.getLength()
      LET g_glea3_d_mask_o[l_ac].* =  g_glea3_d[l_ac].*
      CALL aglq936_glea_t_mask()
      LET g_glea3_d_mask_n[l_ac].* =  g_glea3_d[l_ac].*
   END FOR
 
 
   FREE aglq936_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="aglq936.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION aglq936_idx_chk()
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
      IF g_detail_idx > g_glea_d.getLength() THEN
         LET g_detail_idx = g_glea_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_glea_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_glea_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_glea2_d.getLength() THEN
         LET g_detail_idx = g_glea2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_glea2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_glea2_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_glea3_d.getLength() THEN
         LET g_detail_idx = g_glea3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_glea3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_glea3_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aglq936.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aglq936_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_glea_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="aglq936.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION aglq936_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   
   #end add-point
   
   DELETE FROM glea_t
    WHERE gleaent = g_enterprise AND gleald = g_glea_m.gleald AND
                              glea001 = g_glea_m.glea001 AND
                              glea003 = g_glea_m.glea003 AND
                              glea004 = g_glea_m.glea004 AND
 
          glea002 = g_glea_d_t.glea002
      AND glea005 = g_glea_d_t.glea005
      AND glea006 = g_glea_d_t.glea006
      AND glea032 = g_glea_d_t.glea032
      AND glea033 = g_glea_d_t.glea033
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "glea_t:",SQLERRMESSAGE 
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
 
{<section id="aglq936.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aglq936_delete_b(ps_table,ps_keys_bak,ps_page)
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
 
{<section id="aglq936.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aglq936_insert_b(ps_table,ps_keys,ps_page)
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
 
{<section id="aglq936.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aglq936_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
 
{<section id="aglq936.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION aglq936_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_glea_d[l_ac].glea002 = g_glea_d_t.glea002 
      AND g_glea_d[l_ac].glea005 = g_glea_d_t.glea005 
      AND g_glea_d[l_ac].glea006 = g_glea_d_t.glea006 
      AND g_glea_d[l_ac].glea032 = g_glea_d_t.glea032 
      AND g_glea_d[l_ac].glea033 = g_glea_d_t.glea033 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="aglq936.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION aglq936_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="aglq936.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aglq936_lock_b(ps_table,ps_page)
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
   #CALL aglq936_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aglq936.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aglq936_unlock_b(ps_table,ps_page)
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
 
{<section id="aglq936.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aglq936_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("gleald,glea001,glea003,glea004",TRUE)
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
 
{<section id="aglq936.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aglq936_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("gleald,glea001,glea003,glea004",FALSE)
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
 
{<section id="aglq936.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aglq936_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aglq936.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aglq936_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="aglq936.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aglq936_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aglq936.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aglq936_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aglq936.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION aglq936_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aglq936.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION aglq936_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aglq936.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aglq936_default_search()
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
      LET ls_wc = ls_wc, " gleald = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " glea001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " glea003 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " glea004 = '", g_argv[04], "' AND "
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
 
{<section id="aglq936.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION aglq936_fill_chk(ps_idx)
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
 
{<section id="aglq936.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION aglq936_modify_detail_chk(ps_record)
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
         LET ls_return = "glea005"
      WHEN "s_detail2"
         LET ls_return = "glea005_2"
      WHEN "s_detail3"
         LET ls_return = "glea005_3"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="aglq936.mask_functions" >}
&include "erp/agl/aglq936_mask.4gl"
 
{</section>}
 
{<section id="aglq936.state_change" >}
    
 
{</section>}
 
{<section id="aglq936.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aglq936_set_pk_array()
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
   LET g_pk_array[1].values = g_glea_m.gleald
   LET g_pk_array[1].column = 'gleald'
   LET g_pk_array[2].values = g_glea_m.glea001
   LET g_pk_array[2].column = 'glea001'
   LET g_pk_array[3].values = g_glea_m.glea003
   LET g_pk_array[3].column = 'glea003'
   LET g_pk_array[4].values = g_glea_m.glea004
   LET g_pk_array[4].column = 'glea004'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aglq936.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aglq936_msgcentre_notify(lc_state)
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
   CALL aglq936_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_glea_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aglq936.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 預設值
# Memo...........:
# Usage..........: CALL aglq936_qbe_clear()
# Date & Author..: 151216 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq936_qbe_clear()
   CLEAR FORM
   LET g_input.l_chk12 = 'Y'
   LET g_input.l_chk13 = 'N'
   LET g_input.l_chk14 = 'N'
   LET g_input.l_chk15 = 'N'
   LET g_input.l_chk16 = 'N'
   LET g_input.l_chk17 = 'N'
   LET g_input.l_chk18 = 'N'
   LET g_input.l_chk19 = 'N'
   LET g_input.l_chk20 = 'N'   
   LET g_input.l_chk21 = 'N'
   LET g_input.l_chk22 = 'N'
   LET g_input.l_chk23 = 'N'
   LET g_input.l_chk24 = 'N'
   LET g_input.l_chk25 = 'N'
   DISPLAY BY NAME g_input.l_chk12,g_input.l_chk13,g_input.l_chk14,g_input.l_chk15,g_input.l_chk16,
                   g_input.l_chk17,g_input.l_chk18,g_input.l_chk19,g_input.l_chk20,g_input.l_chk21,
                   g_input.l_chk22,g_input.l_chk23,g_input.l_chk24,g_input.l_chk25
END FUNCTION

################################################################################
# Descriptions...: 欄位開關控制
# Memo...........:
# Usage..........: CALL aglq936_construct_visible(p_type)
# Date & Author..: 151216 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq936_construct_visible(p_type)
   DEFINE p_type   LIKE type_t.chr10   #1.欄位  / 2.欄位+說明

   #先全開
   CALL cl_set_comp_visible('glea012,glea012_desc,glea013,glea013_desc,glea014,glea014_desc',TRUE)
   CALL cl_set_comp_visible('glea015,glea015_desc,glea016,glea016_desc,glea017,glea017_desc',TRUE)
   CALL cl_set_comp_visible('glea018,glea018_desc,glea019,glea019_desc,glea020',TRUE)
   CALL cl_set_comp_visible('glea021,glea021_desc,glea022,glea022_desc,glea023,glea023_desc',TRUE)   
   CALL cl_set_comp_visible('glea024,glea024_desc,glea025,glea025_desc',TRUE)
   
   CASE
      WHEN p_type = '1'
         CALL cl_set_comp_visible('glea012,glea013,glea014',FALSE)
         CALL cl_set_comp_visible('glea015,glea016,glea017',FALSE)
         CALL cl_set_comp_visible('glea018,glea019',FALSE)
         CALL cl_set_comp_visible('glea021,glea022,glea023',FALSE)   
         CALL cl_set_comp_visible('glea024,glea025',FALSE)
         
      WHEN p_type = '2'
         CALL cl_set_comp_visible('glea012_desc,glea013_desc,glea014_desc',FALSE)
         CALL cl_set_comp_visible('glea015_desc,glea016_desc,glea017_desc',FALSE)
         CALL cl_set_comp_visible('glea018_desc,glea019_desc',FALSE)
         CALL cl_set_comp_visible('glea021_desc,glea022_desc,glea023_desc',FALSE)   
         CALL cl_set_comp_visible('glea024_desc,glea025_desc',FALSE)   
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 依帳套設定隱顯其他本位幣頁籤
# Memo...........:
# Usage..........: CALL aglq936_ld_visible()
# Date & Author..: 151216 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq936_ld_visible()
DEFINE l_glaa   RECORD 
                glaa001 LIKE glaa_t.glaa001,
                glaa015 LIKE glaa_t.glaa015,
                glaa016 LIKE glaa_t.glaa016,
                glaa019 LIKE glaa_t.glaa019,
                glaa020 LIKE glaa_t.glaa020                 
                END RECORD
                 
   IF cl_null(g_glea_m.gleald)THEN RETURN END IF
   INITIALIZE l_glaa.* TO NULL        
   SELECT glaa001,glaa015,glaa016,glaa019,glaa020 INTO l_glaa.*
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_glea_m.gleald
      
   CALL cl_set_comp_visible('lbl_glea026,l_glea026,page_3',TRUE)
   CALL cl_set_comp_visible('lbl_glea029,l_glea029,page_4',TRUE)
   CALL cl_set_comp_visible('glea007,glea026,glea029',FALSE)
   LET g_glea_m.l_glea007 = l_glaa.glaa001
   DISPLAY BY NAME g_glea_m.l_glea007
   IF l_glaa.glaa015 = 'N' THEN
      CALL cl_set_comp_visible('lbl_glea026,l_glea026,page_3',FALSE)
   ELSE
      LET g_glea_m.l_glea026 = l_glaa.glaa016
      DISPLAY BY NAME g_glea_m.l_glea026
   END IF
   
   IF l_glaa.glaa019 = 'N' THEN
      CALL cl_set_comp_visible('lbl_glea029,l_glea029,page_4',FALSE)
   ELSE
      LET g_glea_m.l_glea029 = l_glaa.glaa020
      DISPLAY BY NAME g_glea_m.l_glea029      
   END IF
END FUNCTION

################################################################################
# Descriptions...: 物件顯示控制
# Memo...........:
# Usage..........: CALL aglq936_show_visible()
# Date & Author..: 151216 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq936_show_visible()
   CALL cl_set_comp_visible('glea012_desc,l_glea0122,l_glea0123',TRUE)
   CALL cl_set_comp_visible('glea013_desc,l_glea0132,l_glea0133',TRUE)
   CALL cl_set_comp_visible('glea014_desc,l_glea0142,l_glea0143',TRUE)
   CALL cl_set_comp_visible('glea015_desc,l_glea0152,l_glea0153',TRUE)
   CALL cl_set_comp_visible('glea016_desc,l_glea0162,l_glea0163',TRUE)
   CALL cl_set_comp_visible('glea017_desc,l_glea0172,l_glea0173',TRUE)
   CALL cl_set_comp_visible('glea018_desc,l_glea0182,l_glea0183',TRUE)
   CALL cl_set_comp_visible('glea019_desc,l_glea0192,l_glea0193',TRUE)
   CALL cl_set_comp_visible('glea020,l_glea0202,l_glea0203',TRUE)
   CALL cl_set_comp_visible('glea021_desc,l_glea0212,l_glea0213',TRUE)
   CALL cl_set_comp_visible('glea022_desc,l_glea0222,l_glea0223',TRUE)
   CALL cl_set_comp_visible('glea023_desc,l_glea0232,l_glea0233',TRUE)
   CALL cl_set_comp_visible('glea024_desc,l_glea0242,l_glea0243',TRUE)
   CALL cl_set_comp_visible('glea025_desc,l_glea0252,l_glea0253',TRUE)
   
   IF g_input.l_chk12='N' THEN
      CALL cl_set_comp_visible('glea012_desc,l_glea0122,l_glea0123',FALSE)
   END IF
   IF g_input.l_chk13='N' THEN
      CALL cl_set_comp_visible('glea013_desc,l_glea0132,l_glea0133',FALSE)
   END IF
   IF g_input.l_chk14='N' THEN
      CALL cl_set_comp_visible('glea014_desc,l_glea0142,l_glea0143',FALSE)
   END IF
   IF g_input.l_chk15='N' THEN
      CALL cl_set_comp_visible('glea015_desc,l_glea0152,l_glea0153',FALSE)
   END IF
   IF g_input.l_chk16='N' THEN
      CALL cl_set_comp_visible('glea016_desc,l_glea0162,l_glea0163',FALSE)
   END IF
   IF g_input.l_chk17='N' THEN
      CALL cl_set_comp_visible('glea017_desc,l_glea0172,l_glea0173',FALSE)
   END IF
   IF g_input.l_chk18='N' THEN
      CALL cl_set_comp_visible('glea018_desc,l_glea0182,l_glea0183',FALSE)
   END IF
   IF g_input.l_chk19='N' THEN
      CALL cl_set_comp_visible('glea019_desc,l_glea0192,l_glea0193',FALSE)
   END IF
   IF g_input.l_chk20='N' THEN
      CALL cl_set_comp_visible('glea020,l_glea0202,l_glea0203',FALSE)
   END IF
   IF g_input.l_chk21='N' THEN
      CALL cl_set_comp_visible('glea021_desc,l_glea0212,l_glea0213',FALSE)
   END IF
   IF g_input.l_chk22='N' THEN
      CALL cl_set_comp_visible('glea022_desc,l_glea0222,l_glea0223',FALSE)
   END IF
   IF g_input.l_chk23='N' THEN
      CALL cl_set_comp_visible('glea023_desc,l_glea0232,l_glea0233',FALSE)
   END IF
   IF g_input.l_chk24='N' THEN
      CALL cl_set_comp_visible('glea024_desc,l_glea0242,l_glea0243',FALSE)
   END IF
   IF g_input.l_chk25='N' THEN
      CALL cl_set_comp_visible('glea025_desc,l_glea0252,l_glea0253',FALSE)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 二次查詢
# Memo...........:
# Usage..........: CALL aglq936_filter2()
# Date & Author..: 151216 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq936_filter2()
  
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
   LET g_glea_d[l_ac].glea005 = ''
   DISPLAY ARRAY g_glea_d TO s_detail1.*
      BEFORE DISPLAY
         EXIT DISPLAY
   END DISPLAY
   CALL aglq936_construct_visible('2')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON glea005,glea012,glea013,glea014,glea015,
                               glea016,glea017,glea018,glea019,glea020,
                               glea021,glea022,glea023,glea024,glea025
           FROM s_detail1[1].glea005,s_detail1[1].glea012,s_detail1[1].glea013,s_detail1[1].glea014,s_detail1[1].glea015,
                s_detail1[1].glea016,s_detail1[1].glea017,s_detail1[1].glea018,s_detail1[1].glea019,s_detail1[1].glea020,
                s_detail1[1].glea021,s_detail1[1].glea022,s_detail1[1].glea023,s_detail1[1].glea024,s_detail1[1].glea025
      
         BEFORE CONSTRUCT
            CALL aglq936_get_title('glea005')
         
         ON ACTION controlp INFIELD glea005
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " glac003 <>'1' AND glac006 = '1'"
            CALL aglt310_04()
            DISPLAY g_qryparam.return1 TO glea005  #顯示到畫面上
            NEXT FIELD glea005

         ON ACTION controlp INFIELD glea012
            #營運據點
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()    #161021-00037#3 mark
            CALL q_ooef001_01()  #161021-00037#3 add
            DISPLAY g_qryparam.return1 TO glea012
            NEXT FIELD glea012
         
         ON ACTION controlp INFIELD glea013
            #部門
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "ooegstus='Y'"
            CALL q_ooeg001_4()
            DISPLAY g_qryparam.return1 TO glea013
            NEXT FIELD glea013
			
         ON ACTION controlp INFIELD glea014
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "ooegstus='Y' AND ooeg003 IN ('1','2','3')"
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glea014      #顯示到畫面上
            NEXT FIELD glea014
			
         ON ACTION controlp INFIELD glea015
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_287()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO glea015      #顯示到畫面上
            NEXT FIELD glea015
			
         ON ACTION controlp INFIELD glea016
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_25()      #160913-00017#4  add
            #CALL q_pmaa001()        #160913-00017#4  mark               #呼叫開窗      
            DISPLAY g_qryparam.return1 TO glea016
            NEXT FIELD glea016
			
         ON ACTION controlp INFIELD glea017
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_pmaa001_25()      #160913-00017#4  add
            #CALL q_pmaa001()        #160913-00017#4  mark               #呼叫開窗      
            DISPLAY g_qryparam.return1 TO glea017
            NEXT FIELD glea017
			
         ON ACTION controlp INFIELD glea018
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_oocq002_281()
            DISPLAY g_qryparam.return1 TO glea018
            NEXT FIELD glea018
			
         ON ACTION controlp INFIELD glea019
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glea019      #顯示到畫面上
            NEXT FIELD glea019
			
         ON ACTION controlp INFIELD glea021
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            LET g_qryparam.where = " oojdstus='Y' "
            CALL q_oojd001_2()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO glea021    #顯示到畫面上
            NEXT FIELD glea021
			
         ON ACTION controlp INFIELD glea022
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_oocq002_2002()                            #呼叫開窗
            DISPLAY g_qryparam.return1 TO glea022      #顯示到畫面上
            NEXT FIELD glea022
			
         ON ACTION controlp INFIELD glea023
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_ooag001_8()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glea023     #顯示到畫面上
            NEXT FIELD glea023
			
         ON ACTION controlp INFIELD glea024
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_pjba001()                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO glea024     #顯示到畫面上
            NEXT FIELD glea024
			
         ON ACTION controlp INFIELD glea025  
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            LET g_qryparam.where = "pjbb012='1' "
            CALL q_pjbb002()                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO glea025     #顯示到畫面上
            NEXT FIELD glea025
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

   CALL aglq936_filter_show2('glea005',TRUE)
   CALL aglq936_construct_visible('1') 

END FUNCTION

################################################################################
# Descriptions...: 依條件顯示欄位頭
# Memo...........: p_work=T,查詢條件記載在欄位頭
#                  p_work=F,還原欄位頭名稱 
# Usage..........: aglq936_filter_show2(ps_field,p_work)    
# Date & Author..: 151216 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq936_filter_show2(ps_field,p_work)
DEFINE ps_field         STRING
DEFINE lnode_item       om.DomNode
DEFINE ls_title         STRING
DEFINE ls_name          STRING
DEFINE ls_condition     STRING
DEFINE p_work           BOOLEAN
   
   LET ls_name = 'glea_t.',ps_field
   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF  ls_title.getIndexOf('※',1) > 0 THEN
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
   
   #顯示資料組合
   IF p_work THEN
      LET ls_condition = aglq936_filter_parser(ps_field)
      IF NOT cl_null(ls_condition) THEN
         LET ls_title = ls_title, '※', ls_condition, '※'
      END IF
   END IF
   
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
   
END FUNCTION

################################################################################
# Descriptions...: 取得欄位TITLE的搜尋條件
# Memo...........:
# Usage..........: CALL aglq936_get_title(ps_field)
# Date & Author..: 151216 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq936_get_title(ps_field)
DEFINE ps_field         STRING
DEFINE lnode_item       om.DomNode
DEFINE ls_title         STRING
DEFINE r_search         STRING
DEFINE ls_name          STRING
   
   LET ls_name = 'glea_t.',ps_field
   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   
   IF  ls_title.getIndexOf('※',1) > 0 THEN
      LEt r_search = ls_title.subString(ls_title.getIndexOf('※',1)+1,ls_title.getLength()-1)
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
      CALL lnode_item.setAttribute("text",ls_title)
   ELSE
      LET r_search = ''
   END IF
   LET g_glea_d[1].glea005 = r_search.trim()
   DISPLAY g_glea_d[1].glea005 TO s_detail1[1].glea005   
   
END FUNCTION

################################################################################
# Descriptions...: 二次查詢相關元件
# Memo...........:
# Usage..........: CALL aglq936_filter_parser(ps_field)
# Date & Author..: 151216 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq936_filter_parser(ps_field)
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num10
   DEFINE li_tmp2    LIKE type_t.num10
   DEFINE ls_var     STRING   
   
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

################################################################################
# Descriptions...: 建立臨時表
# Memo...........: #160517-00002#10
# Usage..........: CALL aglq936_create_tmp()
# Date & Author..: 160604 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq936_create_tmp()
   #建立臨時表     
   DROP TABLE aglq936_x01_tmp;
   CREATE TEMP TABLE aglq936_x01_tmp(
      gleaent        LIKE glea_t.gleaent, 
      l_gleald_desc  LIKE type_t.chr80, 
      l_glea001_desc LIKE type_t.chr80, 
      glea003        LIKE glea_t.glea003, 
      glea004        LIKE glea_t.glea004, 
      glea007        LIKE glea_t.glea007, 
      glea026        LIKE glea_t.glea026, 
      glea029        LIKE glea_t.glea029, 
      glea005        LIKE glea_t.glea005, 
      l_glea005_desc LIKE type_t.chr500, 
      l_glea012_desc LIKE type_t.chr500, 
      l_glea013_desc LIKE type_t.chr500, 
      l_glea014_desc LIKE type_t.chr500, 
      l_glea015_desc LIKE type_t.chr500, 
      l_glea016_desc LIKE type_t.chr500, 
      l_glea017_desc LIKE type_t.chr500, 
      l_glea018_desc LIKE type_t.chr500, 
      l_glea019_desc LIKE type_t.chr500, 
      l_glea020_desc LIKE type_t.chr500, 
      l_glea021_desc LIKE type_t.chr500, 
      l_glea022_desc LIKE type_t.chr500, 
      l_glea023_desc LIKE type_t.chr500, 
      l_glea024_desc LIKE type_t.chr500, 
      l_glea025_desc LIKE type_t.chr500, 
      glea034        LIKE glea_t.glea034, 
      glea008        LIKE glea_t.glea008, 
      glea009        LIKE glea_t.glea009, 
      l_amt          LIKE type_t.num20_6, 
      glea035        LIKE glea_t.glea035, 
      glea027        LIKE glea_t.glea027, 
      glea028        LIKE glea_t.glea028, 
      l_amt2         LIKE type_t.num20_6, 
      glea036        LIKE glea_t.glea036, 
      glea030        LIKE glea_t.glea030, 
      glea031        LIKE glea_t.glea031, 
      l_amt3         LIKE type_t.num20_6
      )
END FUNCTION

################################################################################
# Descriptions...: 報表列印
# Memo...........: #160517-00002#10
# Usage..........: CALL aglq936_ins_x01_tmp()
# Date & Author..: 160604 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq936_ins_x01_tmp()
DEFINE l_i            LIKE type_t.num5
DEFINE l_gleald_desc  LIKE type_t.chr80
DEFINE l_glea001_desc LIKE type_t.chr80
DEFINE l_glea020_desc LIKE type_t.chr500
DEFINE l_glea020      LIKE type_t.chr500

   LET l_gleald_desc = g_glea_m.gleald,':',g_glea_m.gleald_desc 
   LET l_glea001_desc = g_glea_m.glea001,':',g_glea_m.glea001_desc

   DELETE FROM aglq936_x01_tmp

   LET l_i = 1
   FOR l_i = 1 TO g_glea_d.getLength()     
      LET l_glea020_desc = g_glea_d[l_i].glea020,":",s_desc_gzcbl004_desc('6013',g_glea_d[l_i].glea020)   
      LET l_glea020 = s_desc_gzcbl004_desc('6013',g_glea_d[l_i].glea020)
      IF cl_null(l_glea020) THEN LET l_glea020_desc = g_glea_d[l_i].glea020 END IF
      INSERT INTO aglq936_x01_tmp
      VALUES(g_enterprise,l_gleald_desc,l_glea001_desc,g_glea_m.glea003,g_glea_m.glea004,
             g_glea_m.l_glea007,g_glea_m.l_glea026,g_glea_m.l_glea029,g_glea_d[l_i].glea005,g_glea_d[l_i].glea005_desc,
             g_glea_d[l_i].glea012_desc,g_glea_d[l_i].glea013_desc,g_glea_d[l_i].glea014_desc,g_glea_d[l_i].glea015_desc,g_glea_d[l_i].glea016_desc,
             g_glea_d[l_i].glea017_desc,g_glea_d[l_i].glea018_desc,g_glea_d[l_i].glea019_desc,l_glea020_desc,g_glea_d[l_i].glea021_desc,
             g_glea_d[l_i].glea022_desc,g_glea_d[l_i].glea023_desc,g_glea_d[l_i].glea024_desc,g_glea_d[l_i].glea025_desc,g_glea_d[l_i].glea034,
             g_glea_d[l_i].glea008,g_glea_d[l_i].glea009,g_glea_d[l_i].l_amt,g_glea2_d[l_i].glea035,g_glea2_d[l_i].glea027,
             g_glea2_d[l_i].glea028,g_glea2_d[l_i].l_amt2,g_glea3_d[l_i].glea036,g_glea3_d[l_i].glea030,g_glea3_d[l_i].glea031,
             g_glea3_d[l_i].l_amt3)
   END FOR
   CALL aglq936_xg_visible()

END FUNCTION

################################################################################
# Descriptions...: 傳進XG報表隱藏欄位設置
# Memo...........: #160517-00002#10
# Usage..........: CALL aglq936_xg_visible()
# Date & Author..: 160604 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq936_xg_visible()
DEFINE l_glaa015  LIKE glaa_t.glaa015
DEFINE l_glaa019  LIKE glaa_t.glaa019

   LET g_xg_visible = NULL
  
   LET l_glaa015 = ''
   LET l_glaa019 = ''
   SELECT glaa015,glaa019 INTO l_glaa015,l_glaa019 
     FROM glaa_t
    WHERE glaaent = g_enterprise AND glaald = g_glea_m.gleald
   
   IF l_glaa015 = 'N' THEN #功能幣啟用否
      LET g_xg_visible = "glea035|glea027|glea028|l_amt2"
   END IF
   
   IF l_glaa019 = 'N' THEN #報告幣啟用否
      IF NOT cl_null(g_xg_visible)THEN       
         LET g_xg_visible = g_xg_visible CLIPPED ,"|glea036|glea030|glea031|l_amt3"
      ELSE
         LET g_xg_visible = "glea036|glea030|glea031|l_amt3"
      END IF
   END IF
   
   #核算項
   IF g_input.l_chk12 ='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"l_glea012_desc"
   END IF
   
   IF g_input.l_chk13 ='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"l_glea013_desc"
   END IF
   
   IF g_input.l_chk14 ='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"l_glea014_desc"
   END IF
   
   IF g_input.l_chk15='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"l_glea015_desc"
   END IF
   
   IF g_input.l_chk16 ='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"l_glea016_desc"
   END IF
   
   IF g_input.l_chk17 ='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"l_glea017_desc"
   END IF
   
   IF g_input.l_chk18 ='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"l_glea018_desc"
   END IF
   
   IF g_input.l_chk19 ='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"l_glea019_desc"
   END IF
   #經營方式
   IF g_input.l_chk20 ='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"l_glea020_desc"
   END IF

   IF g_input.l_chk21 ='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"l_glea021_desc"
   END IF

   IF g_input.l_chk22 ='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"l_glea022_desc"
   END IF
   
   IF g_input.l_chk23 ='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"l_glea023_desc"
   END IF 
    
   IF g_input.l_chk24 ='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"l_glea024_desc"
   END IF
   
   IF g_input.l_chk25 ='N' THEN
      IF NOT cl_null(g_xg_visible) THEN
         LET g_xg_visible = g_xg_visible CLIPPED,"|"
      END IF
      LET g_xg_visible = g_xg_visible CLIPPED,"l_glea025_desc"
   END IF
END FUNCTION

 
{</section>}
 
