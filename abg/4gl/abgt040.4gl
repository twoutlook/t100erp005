#該程式未解開Section, 採用最新樣板產出!
{<section id="abgt040.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0007(2015-08-14 13:42:08), PR版次:0007(2017-01-17 13:48:11)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000043
#+ Filename...: abgt040
#+ Description: 期初開帳資料維護
#+ Creator....: 05016(2015-08-04 09:47:57)
#+ Modifier...: 05016 -SD/PR- 06821
 
{</section>}
 
{<section id="abgt040.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#160321-00016#23  160324 By Jessy      修正azzi920重複定義之錯誤訊息
#160318-00025#49  160426 By 07673      將重複內容的錯誤訊息置換為公用錯誤訊息
#160920-00019#4   160920 By 08732      交易對象開窗調整為q_pmaa001_25
#161006-00005#11  161026 By 08732      組織類型與職能開窗調整
#160822-00012#3   161102 By 08729      新舊值處理
#161104-00024#9   161109 By 08171      程式中DEFINE RECORD LIKE時不可以用*的寫法，要一個一個欄位定義(包含INSERT)
#170110-00007#2   170112 By Hans       核算項未輸入時,存檔放入一個空白值
#161129-00019#4   170117 By 06821      預算組織權限,不卡 azzi800 有權限, 改call 元件s_abg2_get_budget_site(...)
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
PRIVATE type type_g_bgbj_m        RECORD
       bgbj001 LIKE bgbj_t.bgbj001, 
   bgbj001_desc LIKE type_t.chr80, 
   bgbj002 LIKE bgbj_t.bgbj002, 
   bgbj002_desc LIKE type_t.chr80, 
   bgaa003 LIKE type_t.chr10
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_bgbj_d        RECORD
       bgbjseq LIKE bgbj_t.bgbjseq, 
   bgbj003 LIKE bgbj_t.bgbj003, 
   bgbj003_desc LIKE type_t.chr500, 
   bgbj004 LIKE bgbj_t.bgbj004, 
   bgbj005 LIKE bgbj_t.bgbj005, 
   bgbj005_desc LIKE type_t.chr500, 
   bgbj006 LIKE bgbj_t.bgbj006, 
   bgbj006_desc LIKE type_t.chr500, 
   bgbj007 LIKE bgbj_t.bgbj007, 
   bgbj007_desc LIKE type_t.chr500, 
   bgbj008 LIKE bgbj_t.bgbj008, 
   bgbj008_desc LIKE type_t.chr500, 
   bgbj009 LIKE bgbj_t.bgbj009, 
   bgbj009_desc LIKE type_t.chr500, 
   bgbj010 LIKE bgbj_t.bgbj010, 
   bgbj010_desc LIKE type_t.chr500, 
   bgbj011 LIKE bgbj_t.bgbj011, 
   bgbj011_desc LIKE type_t.chr500, 
   bgbj012 LIKE bgbj_t.bgbj012, 
   bgbj012_desc LIKE type_t.chr500, 
   bgbj013 LIKE bgbj_t.bgbj013, 
   bgbj013_desc LIKE type_t.chr500, 
   bgbj014 LIKE bgbj_t.bgbj014, 
   bgbj014_desc LIKE type_t.chr500, 
   bgbj015 LIKE bgbj_t.bgbj015, 
   bgbj015_desc LIKE type_t.chr500, 
   bgbj016 LIKE bgbj_t.bgbj016, 
   bgbj016_desc LIKE type_t.chr500, 
   bgbj017 LIKE bgbj_t.bgbj017, 
   bgbj017_desc LIKE type_t.chr500, 
   bgbj018 LIKE bgbj_t.bgbj018, 
   bgbj018_desc LIKE type_t.chr500, 
   bgbj019 LIKE bgbj_t.bgbj019, 
   bgbj019_desc LIKE type_t.chr500, 
   bgbj020 LIKE bgbj_t.bgbj020, 
   bgbj020_desc LIKE type_t.chr500, 
   bgbj021 LIKE bgbj_t.bgbj021, 
   bgbj021_desc LIKE type_t.chr500, 
   bgbj022 LIKE bgbj_t.bgbj022, 
   bgbj022_desc LIKE type_t.chr500, 
   bgbj023 LIKE bgbj_t.bgbj023, 
   bgbj023_desc LIKE type_t.chr500, 
   bgbj024 LIKE bgbj_t.bgbj024, 
   bgbj024_desc LIKE type_t.chr500, 
   bgbj025 LIKE bgbj_t.bgbj025, 
   bgbj025_desc LIKE type_t.chr500, 
   bgbj026 LIKE bgbj_t.bgbj026, 
   bgbj026_desc LIKE type_t.chr500, 
   bgbj027 LIKE bgbj_t.bgbj027, 
   bgbj027_desc LIKE type_t.chr500, 
   bgbj028 LIKE bgbj_t.bgbj028, 
   bgbj029 LIKE bgbj_t.bgbj029, 
   bgbj030 LIKE bgbj_t.bgbj030, 
   bgbj031 LIKE bgbj_t.bgbj031, 
   bgbj032 LIKE bgbj_t.bgbj032, 
   bgbj033 LIKE bgbj_t.bgbj033, 
   bgbjstus LIKE bgbj_t.bgbjstus
       END RECORD
PRIVATE TYPE type_g_bgbj2_d RECORD
       bgbjseq LIKE bgbj_t.bgbjseq, 
   bgbj003 LIKE bgbj_t.bgbj003, 
   bgbjownid LIKE bgbj_t.bgbjownid, 
   bgbjownid_desc LIKE type_t.chr500, 
   bgbjowndp LIKE bgbj_t.bgbjowndp, 
   bgbjowndp_desc LIKE type_t.chr500, 
   bgbjcrtid LIKE bgbj_t.bgbjcrtid, 
   bgbjcrtid_desc LIKE type_t.chr500, 
   bgbjcrtdp LIKE bgbj_t.bgbjcrtdp, 
   bgbjcrtdp_desc LIKE type_t.chr500, 
   bgbjcrtdt DATETIME YEAR TO SECOND, 
   bgbjmodid LIKE bgbj_t.bgbjmodid, 
   bgbjmodid_desc LIKE type_t.chr500, 
   bgbjmoddt DATETIME YEAR TO SECOND
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_bgaa008             LIKE bgaa_t.bgaa008 #使用預算項目參照表 
DEFINE g_bgaa012             LIKE bgaa_t.bgaa012 #是否使用科目預算 
DEFINE g_glaald              LIKE glaa_t.glaald
DEFINE g_glaa004             LIKE glaa_t.glaa004

DEFINE g_glaa                RECORD
           glaacomp  LIKE glaa_t.glaacomp,
           glaa004   LIKE glaa_t.glaa004,
           glaa015   LIKE glaa_t.glaa015,
           glaa019   LIKE glaa_t.glaa019,
           glaa024   LIKE glaa_t.glaa024,
           glaa102   LIKE glaa_t.glaa102,
           glaa121   LIKE glaa_t.glaa121,
           glaa001   LIKE glaa_t.glaa001,
           glaa016   LIKE glaa_t.glaa016,
           glaa020   LIKE glaa_t.glaa020
                             END RECORD
                             
DEFINE g_glad                RECORD
           glad0171          LIKE  glad_t.glad0171,
           glad0172          LIKE  glad_t.glad0172,
           glad0181          LIKE  glad_t.glad0181,
           glad0182          LIKE  glad_t.glad0182,
           glad0191          LIKE  glad_t.glad0191,
           glad0192          LIKE  glad_t.glad0192,
           glad0201          LIKE  glad_t.glad0201,
           glad0202          LIKE  glad_t.glad0202,
           glad0211          LIKE  glad_t.glad0211,
           glad0212          LIKE  glad_t.glad0212,
           glad0221          LIKE  glad_t.glad0221,
           glad0222          LIKE  glad_t.glad0222,
           glad0231          LIKE  glad_t.glad0231,
           glad0232          LIKE  glad_t.glad0232,
           glad0241          LIKE  glad_t.glad0241,
           glad0242          LIKE  glad_t.glad0242,
           glad0251          LIKE  glad_t.glad0251,
           glad0252          LIKE  glad_t.glad0252,
           glad0261          LIKE  glad_t.glad0261,
           glad0262          LIKE  glad_t.glad0262
                             END RECORD
DEFINE g_glac002             LIKE glac_t.glac002    #項目對應會科       
#DEFINE g_userorga            STRING   #161006-00005#11   add  #161129-00019#4 mark
DEFINE g_ooef001_str         STRING    #161129-00019#4 add
#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_bgbj_m          type_g_bgbj_m
DEFINE g_bgbj_m_t        type_g_bgbj_m
DEFINE g_bgbj_m_o        type_g_bgbj_m
DEFINE g_bgbj_m_mask_o   type_g_bgbj_m #轉換遮罩前資料
DEFINE g_bgbj_m_mask_n   type_g_bgbj_m #轉換遮罩後資料
 
   DEFINE g_bgbj001_t LIKE bgbj_t.bgbj001
DEFINE g_bgbj002_t LIKE bgbj_t.bgbj002
 
 
DEFINE g_bgbj_d          DYNAMIC ARRAY OF type_g_bgbj_d
DEFINE g_bgbj_d_t        type_g_bgbj_d
DEFINE g_bgbj_d_o        type_g_bgbj_d
DEFINE g_bgbj_d_mask_o   DYNAMIC ARRAY OF type_g_bgbj_d #轉換遮罩前資料
DEFINE g_bgbj_d_mask_n   DYNAMIC ARRAY OF type_g_bgbj_d #轉換遮罩後資料
DEFINE g_bgbj2_d   DYNAMIC ARRAY OF type_g_bgbj2_d
DEFINE g_bgbj2_d_t type_g_bgbj2_d
DEFINE g_bgbj2_d_o type_g_bgbj2_d
DEFINE g_bgbj2_d_mask_o   DYNAMIC ARRAY OF type_g_bgbj2_d #轉換遮罩前資料
DEFINE g_bgbj2_d_mask_n   DYNAMIC ARRAY OF type_g_bgbj2_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_bgbj001 LIKE bgbj_t.bgbj001,
      b_bgbj002 LIKE bgbj_t.bgbj002
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
 
{<section id="abgt040.main" >}
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
   CALL cl_ap_init("abg","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT bgbj001,'',bgbj002,'',''", 
                      " FROM bgbj_t",
                      " WHERE bgbjent= ? AND bgbj001=? AND bgbj002=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   #161006-00005#11  add ---s
   CALL s_fin_create_account_center_tmp()
   #161129-00019#4 --s mark
   #CALL s_fin_azzi800_sons_query(g_today)
   #CALL s_fin_account_center_sons_str() RETURNING g_userorga
   #CALL s_fin_get_wc_str(g_userorga) RETURNING g_userorga
   #161129-00019#4 --e mark
   #161006-00005#11  add ---e
   #161129-00019#4 --s add
   #檢查預算組織是否在abgi090中可操作的組織中
   CALL s_abg2_get_budget_site('','',g_user,'07') RETURNING g_ooef001_str
   CALL s_fin_get_wc_str(g_ooef001_str) RETURNING g_ooef001_str
   #161129-00019#4 --e add      
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abgt040_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.bgbj001,t0.bgbj002",
               " FROM bgbj_t t0",
               
               " WHERE t0.bgbjent = " ||g_enterprise|| " AND t0.bgbj001 = ? AND t0.bgbj002 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE abgt040_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_abgt040 WITH FORM cl_ap_formpath("abg",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL abgt040_init()   
 
      #進入選單 Menu (="N")
      CALL abgt040_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_abgt040
      
   END IF 
   
   CLOSE abgt040_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="abgt040.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION abgt040_init()
   #add-point:init段define name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill = "Y"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
      CALL cl_set_combo_scc_part('bgbjstus','13','N,Y,X')
 
   
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('bgbj015','6013') #經營方式
   CALL cl_set_combo_scc('bgbj015_desc','6013') #經營方式
   #CALL s_fin_create_account_center_tmp()   #161006-00005#11   mark
   
   #end add-point
   
   CALL abgt040_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="abgt040.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION abgt040_ui_dialog()
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
         INITIALIZE g_bgbj_m.* TO NULL
         CALL g_bgbj_d.clear()
         CALL g_bgbj2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL abgt040_init()
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
               CALL abgt040_idx_chk()
               CALL abgt040_fetch('') # reload data
               LET g_detail_idx = 1
               CALL abgt040_ui_detailshow() #Setting the current row 
         
            ON ACTION qbefield_user   #欄位隱藏設定 
               LET g_action_choice="qbefield_user"
               CALL cl_ui_qbefield_user()
         
         END DISPLAY
        
         DISPLAY ARRAY g_bgbj_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL abgt040_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL abgt040_ui_detailshow()
               
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
        
         DISPLAY ARRAY g_bgbj2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL abgt040_idx_chk()
               CALL abgt040_ui_detailshow()
               
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
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps 
         
         BEFORE DIALOG
            #先填充browser資料
            CALL abgt040_browser_fill("")
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
               CALL abgt040_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL abgt040_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #應用 a49 樣板自動產生(Version:4)
            #過濾瀏覽頁資料
            ON ACTION filter
               LET g_action_choice = "fetch"
               #add-point:filter action name="ui_dialog.action.filter"
               
               #end add-point
               CALL abgt040_filter()
               EXIT DIALOG
 
 
 
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL abgt040_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abgt040_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL abgt040_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abgt040_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL abgt040_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abgt040_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL abgt040_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abgt040_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL abgt040_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abgt040_idx_chk()
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
                  LET g_export_node[1] = base.typeInfo.create(g_bgbj_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_bgbj2_d)
                  LET g_export_id[2]   = "s_detail2"
 
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
               NEXT FIELD bgbjseq
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
               CALL abgt040_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL abgt040_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL abgt040_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL abgt040_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL abgt040_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL abgt040_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL abgt040_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL abgt040_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL abgt040_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL abgt040_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL abgt040_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL abgt040_set_pk_array()
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
 
{<section id="abgt040.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION abgt040_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="abgt040.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION abgt040_browser_fill(ps_page_action)
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
 
   LET l_searchcol = "bgbj001,bgbj002"
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
      LET l_sub_sql = " SELECT DISTINCT bgbj001 ",
                      ", bgbj002 ",
 
                      " FROM bgbj_t ",
                      " ",
                      " ", 
 
 
 
                      " WHERE bgbjent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("bgbj_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT bgbj001 ",
                      ", bgbj002 ",
 
                      " FROM bgbj_t ",
                      " ",
                      " ", 
 
 
                      " WHERE bgbjent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("bgbj_t")
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
      INITIALIZE g_bgbj_m.* TO NULL
      CALL g_bgbj_d.clear()        
      CALL g_bgbj2_d.clear() 
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.bgbj001,t0.bgbj002 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.bgbj001,t0.bgbj002",
                " FROM bgbj_t t0",
                #" ",
                " ",
 
 
 
                
                " WHERE t0.bgbjent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("bgbj_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
   
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"bgbj_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_bgbj001,g_browser[g_cnt].b_bgbj002 
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
         CALL abgt040_browser_mask()
         
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
   
   IF cl_null(g_browser[g_cnt].b_bgbj001) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_bgbj_m.* TO NULL
      CALL g_bgbj_d.clear()
      CALL g_bgbj2_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL abgt040_fetch('')
   
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
 
{<section id="abgt040.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION abgt040_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_bgbj_m.bgbj001 = g_browser[g_current_idx].b_bgbj001   
   LET g_bgbj_m.bgbj002 = g_browser[g_current_idx].b_bgbj002   
 
   EXECUTE abgt040_master_referesh USING g_bgbj_m.bgbj001,g_bgbj_m.bgbj002 INTO g_bgbj_m.bgbj001,g_bgbj_m.bgbj002 
 
   CALL abgt040_show()
   
END FUNCTION
 
{</section>}
 
{<section id="abgt040.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION abgt040_ui_detailshow()
   #add-point:ui_detailshow段define name="ui_detailshow.define_customerization"
   
   #end add-point
   #add-point:ui_detailshow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="ui_detailshow.before"
   
   #end add-point  
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
 
      #add-point:ui_detailshow段more name="ui_detailshow.more"
      
      #end add-point 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="abgt040.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION abgt040_ui_browser_refresh()
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
      IF g_browser[l_i].b_bgbj001 = g_bgbj_m.bgbj001 
         AND g_browser[l_i].b_bgbj002 = g_bgbj_m.bgbj002 
 
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
 
{<section id="abgt040.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION abgt040_construct()
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
   INITIALIZE g_bgbj_m.* TO NULL
   CALL g_bgbj_d.clear()
   CALL g_bgbj2_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON bgbj001,bgbj002
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
                 #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj001
            #add-point:BEFORE FIELD bgbj001 name="construct.b.bgbj001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj001
            
            #add-point:AFTER FIELD bgbj001 name="construct.a.bgbj001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgbj001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj001
            #add-point:ON ACTION controlp INFIELD bgbj001 name="construct.c.bgbj001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_bgaa001()
            DISPLAY g_qryparam.return1 TO bgbj001
            NEXT FIELD bgbj001
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj002
            #add-point:BEFORE FIELD bgbj002 name="construct.b.bgbj002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj002
            
            #add-point:AFTER FIELD bgbj002 name="construct.a.bgbj002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgbj002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj002
            #add-point:ON ACTION controlp INFIELD bgbj002 name="construct.c.bgbj002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.where = "ooef205 = 'Y'"           #161006-00005#11   mark
            #CALL q_ooef001()                                 #161006-00005#11   mark
            #LET g_qryparam.where = " ooef001 IN ", g_userorga #161006-00005#11   add #161129-00019#4 mark
            LET g_qryparam.where = " ooef001 IN ", g_ooef001_str #161129-00019#4 add
            CALL q_ooef001_77()                               #161006-00005#11   add
            DISPLAY g_qryparam.return1 TO bgbj002
            NEXT FIELD bgbj002
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON bgbjseq,bgbj003,bgbj004,bgbj005_desc,bgbj006_desc,bgbj007,bgbj007_desc, 
          bgbj008_desc,bgbj009_desc,bgbj010_desc,bgbj011_desc,bgbj012_desc,bgbj013_desc,bgbj014_desc, 
          bgbj015_desc,bgbj016_desc,bgbj017_desc,bgbj027_desc,bgbj028,bgbj029,bgbj030,bgbj031,bgbj032, 
          bgbj033,bgbjstus,bgbjownid,bgbjowndp,bgbjcrtid,bgbjcrtdp,bgbjcrtdt,bgbjmodid,bgbjmoddt
           FROM s_detail1[1].bgbjseq,s_detail1[1].bgbj003,s_detail1[1].bgbj004,s_detail1[1].bgbj005_desc, 
               s_detail1[1].bgbj006_desc,s_detail1[1].bgbj007,s_detail1[1].bgbj007_desc,s_detail1[1].bgbj008_desc, 
               s_detail1[1].bgbj009_desc,s_detail1[1].bgbj010_desc,s_detail1[1].bgbj011_desc,s_detail1[1].bgbj012_desc, 
               s_detail1[1].bgbj013_desc,s_detail1[1].bgbj014_desc,s_detail1[1].bgbj015_desc,s_detail1[1].bgbj016_desc, 
               s_detail1[1].bgbj017_desc,s_detail1[1].bgbj027_desc,s_detail1[1].bgbj028,s_detail1[1].bgbj029, 
               s_detail1[1].bgbj030,s_detail1[1].bgbj031,s_detail1[1].bgbj032,s_detail1[1].bgbj033,s_detail1[1].bgbjstus, 
               s_detail2[1].bgbjownid,s_detail2[1].bgbjowndp,s_detail2[1].bgbjcrtid,s_detail2[1].bgbjcrtdp, 
               s_detail2[1].bgbjcrtdt,s_detail2[1].bgbjmodid,s_detail2[1].bgbjmoddt
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<bgbjcrtdt>>----
         AFTER FIELD bgbjcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<bgbjmoddt>>----
         AFTER FIELD bgbjmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<bgbjcnfdt>>----
         
         #----<<bgbjpstdt>>----
 
 
 
           
         #單身一般欄位開窗相關處理
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbjseq
            #add-point:BEFORE FIELD bgbjseq name="construct.b.page1.bgbjseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbjseq
            
            #add-point:AFTER FIELD bgbjseq name="construct.a.page1.bgbjseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbjseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbjseq
            #add-point:ON ACTION controlp INFIELD bgbjseq name="construct.c.page1.bgbjseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj003
            #add-point:BEFORE FIELD bgbj003 name="construct.b.page1.bgbj003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj003
            
            #add-point:AFTER FIELD bgbj003 name="construct.a.page1.bgbj003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbj003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj003
            #add-point:ON ACTION controlp INFIELD bgbj003 name="construct.c.page1.bgbj003"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_bgae001()
            DISPLAY g_qryparam.return1 TO bgbj003
            NEXT FIELD bgbj003
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj004
            #add-point:BEFORE FIELD bgbj004 name="construct.b.page1.bgbj004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj004
            
            #add-point:AFTER FIELD bgbj004 name="construct.a.page1.bgbj004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbj004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj004
            #add-point:ON ACTION controlp INFIELD bgbj004 name="construct.c.page1.bgbj004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj005
            #add-point:BEFORE FIELD bgbj005 name="construct.b.page1.bgbj005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj005
            
            #add-point:AFTER FIELD bgbj005 name="construct.a.page1.bgbj005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbj005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj005
            #add-point:ON ACTION controlp INFIELD bgbj005 name="construct.c.page1.bgbj005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj005_desc
            #add-point:BEFORE FIELD bgbj005_desc name="construct.b.page1.bgbj005_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj005_desc
            
            #add-point:AFTER FIELD bgbj005_desc name="construct.a.page1.bgbj005_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbj005_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj005_desc
            #add-point:ON ACTION controlp INFIELD bgbj005_desc name="construct.c.page1.bgbj005_desc"
            #業務部門
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001_4()
            DISPLAY g_qryparam.return1 TO bgbj005_desc
            NEXT FIELD bgbj005_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj006
            #add-point:BEFORE FIELD bgbj006 name="construct.b.page1.bgbj006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj006
            
            #add-point:AFTER FIELD bgbj006 name="construct.a.page1.bgbj006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbj006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj006
            #add-point:ON ACTION controlp INFIELD bgbj006 name="construct.c.page1.bgbj006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj006_desc
            #add-point:BEFORE FIELD bgbj006_desc name="construct.b.page1.bgbj006_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj006_desc
            
            #add-point:AFTER FIELD bgbj006_desc name="construct.a.page1.bgbj006_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbj006_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj006_desc
            #add-point:ON ACTION controlp INFIELD bgbj006_desc name="construct.c.page1.bgbj006_desc"
　　　　　　 #成本利潤中心
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001_4()
            DISPLAY g_qryparam.return1 TO bgbj006_desc
            NEXT FIELD bgbj006_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj007
            #add-point:BEFORE FIELD bgbj007 name="construct.b.page1.bgbj007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj007
            
            #add-point:AFTER FIELD bgbj007 name="construct.a.page1.bgbj007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbj007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj007
            #add-point:ON ACTION controlp INFIELD bgbj007 name="construct.c.page1.bgbj007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj007_desc
            #add-point:BEFORE FIELD bgbj007_desc name="construct.b.page1.bgbj007_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj007_desc
            
            #add-point:AFTER FIELD bgbj007_desc name="construct.a.page1.bgbj007_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbj007_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj007_desc
            #add-point:ON ACTION controlp INFIELD bgbj007_desc name="construct.c.page1.bgbj007_desc"
            #區域
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_287()
            DISPLAY g_qryparam.return1 TO bgbj007_desc
            NEXT FIELD bgbj007_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj008
            #add-point:BEFORE FIELD bgbj008 name="construct.b.page1.bgbj008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj008
            
            #add-point:AFTER FIELD bgbj008 name="construct.a.page1.bgbj008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbj008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj008
            #add-point:ON ACTION controlp INFIELD bgbj008 name="construct.c.page1.bgbj008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj008_desc
            #add-point:BEFORE FIELD bgbj008_desc name="construct.b.page1.bgbj008_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj008_desc
            
            #add-point:AFTER FIELD bgbj008_desc name="construct.a.page1.bgbj008_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbj008_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj008_desc
            #add-point:ON ACTION controlp INFIELD bgbj008_desc name="construct.c.page1.bgbj008_desc"
            #交易客商
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_pmaa001()    #160920-00019#4--mark
            CALL q_pmaa001_25()  #160920-00019#4--add
            DISPLAY g_qryparam.return1 TO bgbj008_desc
            NEXT FIELD bgbj008_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj009
            #add-point:BEFORE FIELD bgbj009 name="construct.b.page1.bgbj009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj009
            
            #add-point:AFTER FIELD bgbj009 name="construct.a.page1.bgbj009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbj009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj009
            #add-point:ON ACTION controlp INFIELD bgbj009 name="construct.c.page1.bgbj009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj009_desc
            #add-point:BEFORE FIELD bgbj009_desc name="construct.b.page1.bgbj009_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj009_desc
            
            #add-point:AFTER FIELD bgbj009_desc name="construct.a.page1.bgbj009_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbj009_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj009_desc
            #add-point:ON ACTION controlp INFIELD bgbj009_desc name="construct.c.page1.bgbj009_desc"
            #收款客商
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmac002_1()
            DISPLAY g_qryparam.return1 TO bgbj009_desc
            NEXT FIELD bgbj009_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj010
            #add-point:BEFORE FIELD bgbj010 name="construct.b.page1.bgbj010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj010
            
            #add-point:AFTER FIELD bgbj010 name="construct.a.page1.bgbj010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbj010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj010
            #add-point:ON ACTION controlp INFIELD bgbj010 name="construct.c.page1.bgbj010"
            #客群
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_281()
            DISPLAY g_qryparam.return1 TO bgbj009_desc
            NEXT FIELD bgbj009_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj010_desc
            #add-point:BEFORE FIELD bgbj010_desc name="construct.b.page1.bgbj010_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj010_desc
            
            #add-point:AFTER FIELD bgbj010_desc name="construct.a.page1.bgbj010_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbj010_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj010_desc
            #add-point:ON ACTION controlp INFIELD bgbj010_desc name="construct.c.page1.bgbj010_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj011
            #add-point:BEFORE FIELD bgbj011 name="construct.b.page1.bgbj011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj011
            
            #add-point:AFTER FIELD bgbj011 name="construct.a.page1.bgbj011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbj011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj011
            #add-point:ON ACTION controlp INFIELD bgbj011 name="construct.c.page1.bgbj011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj011_desc
            #add-point:BEFORE FIELD bgbj011_desc name="construct.b.page1.bgbj011_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj011_desc
            
            #add-point:AFTER FIELD bgbj011_desc name="construct.a.page1.bgbj011_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbj011_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj011_desc
            #add-point:ON ACTION controlp INFIELD bgbj011_desc name="construct.c.page1.bgbj011_desc"
             #產品類別
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001()
            DISPLAY g_qryparam.return1 TO bgbj011_desc
            NEXT FIELD bgbj011_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj012
            #add-point:BEFORE FIELD bgbj012 name="construct.b.page1.bgbj012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj012
            
            #add-point:AFTER FIELD bgbj012 name="construct.a.page1.bgbj012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbj012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj012
            #add-point:ON ACTION controlp INFIELD bgbj012 name="construct.c.page1.bgbj012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj012_desc
            #add-point:BEFORE FIELD bgbj012_desc name="construct.b.page1.bgbj012_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj012_desc
            
            #add-point:AFTER FIELD bgbj012_desc name="construct.a.page1.bgbj012_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbj012_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj012_desc
            #add-point:ON ACTION controlp INFIELD bgbj012_desc name="construct.c.page1.bgbj012_desc"
             #人員
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_8()
            DISPLAY g_qryparam.return1 TO bgbj012_desc
            NEXT FIELD bgbj012_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj013
            #add-point:BEFORE FIELD bgbj013 name="construct.b.page1.bgbj013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj013
            
            #add-point:AFTER FIELD bgbj013 name="construct.a.page1.bgbj013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbj013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj013
            #add-point:ON ACTION controlp INFIELD bgbj013 name="construct.c.page1.bgbj013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj013_desc
            #add-point:BEFORE FIELD bgbj013_desc name="construct.b.page1.bgbj013_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj013_desc
            
            #add-point:AFTER FIELD bgbj013_desc name="construct.a.page1.bgbj013_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbj013_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj013_desc
            #add-point:ON ACTION controlp INFIELD bgbj013_desc name="construct.c.page1.bgbj013_desc"
            #專案代號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()
            DISPLAY g_qryparam.return1 TO bgbj013_desc
            NEXT FIELD bgbj013_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj014
            #add-point:BEFORE FIELD bgbj014 name="construct.b.page1.bgbj014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj014
            
            #add-point:AFTER FIELD bgbj014 name="construct.a.page1.bgbj014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbj014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj014
            #add-point:ON ACTION controlp INFIELD bgbj014 name="construct.c.page1.bgbj014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj014_desc
            #add-point:BEFORE FIELD bgbj014_desc name="construct.b.page1.bgbj014_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj014_desc
            
            #add-point:AFTER FIELD bgbj014_desc name="construct.a.page1.bgbj014_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbj014_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj014_desc
            #add-point:ON ACTION controlp INFIELD bgbj014_desc name="construct.c.page1.bgbj014_desc"
             #WBS
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "pjbb012='1'"
            CALL q_pjbb002()
            DISPLAY g_qryparam.return1 TO bgbj014_desc
            NEXT FIELD bgbj014_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj015
            #add-point:BEFORE FIELD bgbj015 name="construct.b.page1.bgbj015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj015
            
            #add-point:AFTER FIELD bgbj015 name="construct.a.page1.bgbj015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbj015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj015
            #add-point:ON ACTION controlp INFIELD bgbj015 name="construct.c.page1.bgbj015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj015_desc
            #add-point:BEFORE FIELD bgbj015_desc name="construct.b.page1.bgbj015_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj015_desc
            
            #add-point:AFTER FIELD bgbj015_desc name="construct.a.page1.bgbj015_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbj015_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj015_desc
            #add-point:ON ACTION controlp INFIELD bgbj015_desc name="construct.c.page1.bgbj015_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj016
            #add-point:BEFORE FIELD bgbj016 name="construct.b.page1.bgbj016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj016
            
            #add-point:AFTER FIELD bgbj016 name="construct.a.page1.bgbj016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbj016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj016
            #add-point:ON ACTION controlp INFIELD bgbj016 name="construct.c.page1.bgbj016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj016_desc
            #add-point:BEFORE FIELD bgbj016_desc name="construct.b.page1.bgbj016_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj016_desc
            
            #add-point:AFTER FIELD bgbj016_desc name="construct.a.page1.bgbj016_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbj016_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj016_desc
            #add-point:ON ACTION controlp INFIELD bgbj016_desc name="construct.c.page1.bgbj016_desc"
             #渠道
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oojd001_2()
            DISPLAY g_qryparam.return1 TO bgbj016_desc
            NEXT FIELD bgbj016_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj017
            #add-point:BEFORE FIELD bgbj017 name="construct.b.page1.bgbj017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj017
            
            #add-point:AFTER FIELD bgbj017 name="construct.a.page1.bgbj017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbj017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj017
            #add-point:ON ACTION controlp INFIELD bgbj017 name="construct.c.page1.bgbj017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj017_desc
            #add-point:BEFORE FIELD bgbj017_desc name="construct.b.page1.bgbj017_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj017_desc
            
            #add-point:AFTER FIELD bgbj017_desc name="construct.a.page1.bgbj017_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbj017_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj017_desc
            #add-point:ON ACTION controlp INFIELD bgbj017_desc name="construct.c.page1.bgbj017_desc"
            #品牌
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_2002()
            DISPLAY g_qryparam.return1 TO bgbj017_desc
            NEXT FIELD bgbj017_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj027
            #add-point:BEFORE FIELD bgbj027 name="construct.b.page1.bgbj027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj027
            
            #add-point:AFTER FIELD bgbj027 name="construct.a.page1.bgbj027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbj027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj027
            #add-point:ON ACTION controlp INFIELD bgbj027 name="construct.c.page1.bgbj027"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj027_desc
            #add-point:BEFORE FIELD bgbj027_desc name="construct.b.page1.bgbj027_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj027_desc
            
            #add-point:AFTER FIELD bgbj027_desc name="construct.a.page1.bgbj027_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbj027_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj027_desc
            #add-point:ON ACTION controlp INFIELD bgbj027_desc name="construct.c.page1.bgbj027_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj028
            #add-point:BEFORE FIELD bgbj028 name="construct.b.page1.bgbj028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj028
            
            #add-point:AFTER FIELD bgbj028 name="construct.a.page1.bgbj028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbj028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj028
            #add-point:ON ACTION controlp INFIELD bgbj028 name="construct.c.page1.bgbj028"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj029
            #add-point:BEFORE FIELD bgbj029 name="construct.b.page1.bgbj029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj029
            
            #add-point:AFTER FIELD bgbj029 name="construct.a.page1.bgbj029"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbj029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj029
            #add-point:ON ACTION controlp INFIELD bgbj029 name="construct.c.page1.bgbj029"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj030
            #add-point:BEFORE FIELD bgbj030 name="construct.b.page1.bgbj030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj030
            
            #add-point:AFTER FIELD bgbj030 name="construct.a.page1.bgbj030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbj030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj030
            #add-point:ON ACTION controlp INFIELD bgbj030 name="construct.c.page1.bgbj030"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj031
            #add-point:BEFORE FIELD bgbj031 name="construct.b.page1.bgbj031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj031
            
            #add-point:AFTER FIELD bgbj031 name="construct.a.page1.bgbj031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbj031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj031
            #add-point:ON ACTION controlp INFIELD bgbj031 name="construct.c.page1.bgbj031"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj032
            #add-point:BEFORE FIELD bgbj032 name="construct.b.page1.bgbj032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj032
            
            #add-point:AFTER FIELD bgbj032 name="construct.a.page1.bgbj032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbj032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj032
            #add-point:ON ACTION controlp INFIELD bgbj032 name="construct.c.page1.bgbj032"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj033
            #add-point:BEFORE FIELD bgbj033 name="construct.b.page1.bgbj033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj033
            
            #add-point:AFTER FIELD bgbj033 name="construct.a.page1.bgbj033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbj033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj033
            #add-point:ON ACTION controlp INFIELD bgbj033 name="construct.c.page1.bgbj033"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbjstus
            #add-point:BEFORE FIELD bgbjstus name="construct.b.page1.bgbjstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbjstus
            
            #add-point:AFTER FIELD bgbjstus name="construct.a.page1.bgbjstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbjstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbjstus
            #add-point:ON ACTION controlp INFIELD bgbjstus name="construct.c.page1.bgbjstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.bgbjownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbjownid
            #add-point:ON ACTION controlp INFIELD bgbjownid name="construct.c.page2.bgbjownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgbjownid  #顯示到畫面上
            NEXT FIELD bgbjownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbjownid
            #add-point:BEFORE FIELD bgbjownid name="construct.b.page2.bgbjownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbjownid
            
            #add-point:AFTER FIELD bgbjownid name="construct.a.page2.bgbjownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.bgbjowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbjowndp
            #add-point:ON ACTION controlp INFIELD bgbjowndp name="construct.c.page2.bgbjowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgbjowndp  #顯示到畫面上
            NEXT FIELD bgbjowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbjowndp
            #add-point:BEFORE FIELD bgbjowndp name="construct.b.page2.bgbjowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbjowndp
            
            #add-point:AFTER FIELD bgbjowndp name="construct.a.page2.bgbjowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.bgbjcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbjcrtid
            #add-point:ON ACTION controlp INFIELD bgbjcrtid name="construct.c.page2.bgbjcrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgbjcrtid  #顯示到畫面上
            NEXT FIELD bgbjcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbjcrtid
            #add-point:BEFORE FIELD bgbjcrtid name="construct.b.page2.bgbjcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbjcrtid
            
            #add-point:AFTER FIELD bgbjcrtid name="construct.a.page2.bgbjcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.bgbjcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbjcrtdp
            #add-point:ON ACTION controlp INFIELD bgbjcrtdp name="construct.c.page2.bgbjcrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgbjcrtdp  #顯示到畫面上
            NEXT FIELD bgbjcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbjcrtdp
            #add-point:BEFORE FIELD bgbjcrtdp name="construct.b.page2.bgbjcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbjcrtdp
            
            #add-point:AFTER FIELD bgbjcrtdp name="construct.a.page2.bgbjcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbjcrtdt
            #add-point:BEFORE FIELD bgbjcrtdt name="construct.b.page2.bgbjcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.bgbjmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbjmodid
            #add-point:ON ACTION controlp INFIELD bgbjmodid name="construct.c.page2.bgbjmodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgbjmodid  #顯示到畫面上
            NEXT FIELD bgbjmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbjmodid
            #add-point:BEFORE FIELD bgbjmodid name="construct.b.page2.bgbjmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbjmodid
            
            #add-point:AFTER FIELD bgbjmodid name="construct.a.page2.bgbjmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbjmoddt
            #add-point:BEFORE FIELD bgbjmoddt name="construct.b.page2.bgbjmoddt"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
  
 
  
      #add-point:cs段more_construct name="cs.more_construct"
      
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:ui_dialog段b_dialog name="cs.before_dialog"
         #161129-00019#4 --s add
         #檢查預算組織是否在abgi090中可操作的組織中
         CALL s_abg2_get_budget_site('','',g_user,'07') RETURNING g_ooef001_str
         CALL s_fin_get_wc_str(g_ooef001_str) RETURNING g_ooef001_str
         #161129-00019#4 --e add
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
   LET g_wc2 = cl_replace_str(g_wc2,'_desc',' ')
   LET g_wc2_table1 = cl_replace_str(g_wc2_table1,'_desc',' ')
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
 
{<section id="abgt040.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION abgt040_filter()
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
      CONSTRUCT g_wc_filter ON bgbj001,bgbj002
                          FROM s_browse[1].b_bgbj001,s_browse[1].b_bgbj002
 
         BEFORE CONSTRUCT
               DISPLAY abgt040_filter_parser('bgbj001') TO s_browse[1].b_bgbj001
            DISPLAY abgt040_filter_parser('bgbj002') TO s_browse[1].b_bgbj002
      
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
 
      CALL abgt040_filter_show('bgbj001')
   CALL abgt040_filter_show('bgbj002')
 
END FUNCTION
 
{</section>}
 
{<section id="abgt040.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION abgt040_filter_parser(ps_field)
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
 
{<section id="abgt040.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION abgt040_filter_show(ps_field)
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
   LET ls_condition = abgt040_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="abgt040.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION abgt040_query()
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
   CALL g_bgbj_d.clear()
   CALL g_bgbj2_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL abgt040_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL abgt040_browser_fill(g_wc)
      CALL abgt040_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL abgt040_browser_fill("F")
   
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
      CALL abgt040_fetch("F") 
   END IF
   
   CALL abgt040_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="abgt040.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION abgt040_fetch(p_flag)
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
   
   LET g_bgbj_m.bgbj001 = g_browser[g_current_idx].b_bgbj001
   LET g_bgbj_m.bgbj002 = g_browser[g_current_idx].b_bgbj002
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE abgt040_master_referesh USING g_bgbj_m.bgbj001,g_bgbj_m.bgbj002 INTO g_bgbj_m.bgbj001,g_bgbj_m.bgbj002 
 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "bgbj_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_bgbj_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_bgbj_m_mask_o.* =  g_bgbj_m.*
   CALL abgt040_bgbj_t_mask()
   LET g_bgbj_m_mask_n.* =  g_bgbj_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL abgt040_set_act_visible()
   CALL abgt040_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_bgbj_m_t.* = g_bgbj_m.*
   LET g_bgbj_m_o.* = g_bgbj_m.*
   
   #重新顯示   
   CALL abgt040_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="abgt040.insert" >}
#+ 資料新增
PRIVATE FUNCTION abgt040_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_bgbj_d.clear()
   CALL g_bgbj2_d.clear()
 
 
   INITIALIZE g_bgbj_m.* TO NULL             #DEFAULT 設定
   LET g_bgbj001_t = NULL
   LET g_bgbj002_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
      
     
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point 
 
      CALL abgt040_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_bgbj_m.* TO NULL
         INITIALIZE g_bgbj_d TO NULL
         INITIALIZE g_bgbj2_d TO NULL
 
         CALL abgt040_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_bgbj_m.* = g_bgbj_m_t.*
         CALL abgt040_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_bgbj_d.clear()
      #CALL g_bgbj2_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL abgt040_set_act_visible()
   CALL abgt040_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_bgbj001_t = g_bgbj_m.bgbj001
   LET g_bgbj002_t = g_bgbj_m.bgbj002
 
   
   #組合新增資料的條件
   LET g_add_browse = " bgbjent = " ||g_enterprise|| " AND",
                      " bgbj001 = '", g_bgbj_m.bgbj001, "' "
                      ," AND bgbj002 = '", g_bgbj_m.bgbj002, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL abgt040_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL abgt040_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE abgt040_master_referesh USING g_bgbj_m.bgbj001,g_bgbj_m.bgbj002 INTO g_bgbj_m.bgbj001,g_bgbj_m.bgbj002 
 
   
   #遮罩相關處理
   LET g_bgbj_m_mask_o.* =  g_bgbj_m.*
   CALL abgt040_bgbj_t_mask()
   LET g_bgbj_m_mask_n.* =  g_bgbj_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_bgbj_m.bgbj001,g_bgbj_m.bgbj001_desc,g_bgbj_m.bgbj002,g_bgbj_m.bgbj002_desc,g_bgbj_m.bgaa003 
 
   
   #功能已完成,通報訊息中心
   CALL abgt040_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="abgt040.modify" >}
#+ 資料修改
PRIVATE FUNCTION abgt040_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_bgbj_m.bgbj001 IS NULL
   OR g_bgbj_m.bgbj002 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_bgbj001_t = g_bgbj_m.bgbj001
   LET g_bgbj002_t = g_bgbj_m.bgbj002
 
   CALL s_transaction_begin()
   
   OPEN abgt040_cl USING g_enterprise,g_bgbj_m.bgbj001,g_bgbj_m.bgbj002
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abgt040_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE abgt040_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE abgt040_master_referesh USING g_bgbj_m.bgbj001,g_bgbj_m.bgbj002 INTO g_bgbj_m.bgbj001,g_bgbj_m.bgbj002 
 
   
   #遮罩相關處理
   LET g_bgbj_m_mask_o.* =  g_bgbj_m.*
   CALL abgt040_bgbj_t_mask()
   LET g_bgbj_m_mask_n.* =  g_bgbj_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL abgt040_show()
   WHILE TRUE
      LET g_bgbj001_t = g_bgbj_m.bgbj001
      LET g_bgbj002_t = g_bgbj_m.bgbj002
 
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL abgt040_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_bgbj_m.* = g_bgbj_m_t.*
         CALL abgt040_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_bgbj_m.bgbj001 != g_bgbj001_t 
      OR g_bgbj_m.bgbj002 != g_bgbj002_t 
 
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
   CALL abgt040_set_act_visible()
   CALL abgt040_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " bgbjent = " ||g_enterprise|| " AND",
                      " bgbj001 = '", g_bgbj_m.bgbj001, "' "
                      ," AND bgbj002 = '", g_bgbj_m.bgbj002, "' "
 
   #填到對應位置
   CALL abgt040_browser_fill("")
 
   CALL abgt040_idx_chk()
 
   CLOSE abgt040_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL abgt040_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="abgt040.input" >}
#+ 資料輸入
PRIVATE FUNCTION abgt040_input(p_cmd)
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
   DEFINE l_glae009              LIKE glae_t.glae009 #開窗查詢代號 /核算項  
   DEFINE l_orga                 STRING   #161006-00005#11 add
   DEFINE l_site_str             STRING   #161129-00019#4 add
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
   DISPLAY BY NAME g_bgbj_m.bgbj001,g_bgbj_m.bgbj001_desc,g_bgbj_m.bgbj002,g_bgbj_m.bgbj002_desc,g_bgbj_m.bgaa003 
 
   
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
   LET g_forupd_sql = "SELECT bgbjseq,bgbj003,bgbj004,bgbj005,bgbj006,bgbj007,bgbj008,bgbj009,bgbj010, 
       bgbj011,bgbj012,bgbj013,bgbj014,bgbj015,bgbj016,bgbj017,bgbj018,bgbj019,bgbj020,bgbj021,bgbj022, 
       bgbj023,bgbj024,bgbj025,bgbj026,bgbj027,bgbj028,bgbj029,bgbj030,bgbj031,bgbj032,bgbj033,bgbjstus, 
       bgbjseq,bgbj003,bgbjownid,bgbjowndp,bgbjcrtid,bgbjcrtdp,bgbjcrtdt,bgbjmodid,bgbjmoddt FROM bgbj_t  
       WHERE bgbjent=? AND bgbj001=? AND bgbj002=? AND bgbjseq=? AND bgbj003=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abgt040_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL abgt040_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL abgt040_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_bgbj_m.bgbj001,g_bgbj_m.bgbj002,g_bgbj_m.bgaa003
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="abgt040.input.head" >}
   
      #單頭段
      INPUT BY NAME g_bgbj_m.bgbj001,g_bgbj_m.bgbj002,g_bgbj_m.bgaa003 
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
         AFTER FIELD bgbj001
            
            #add-point:AFTER FIELD bgbj001 name="input.a.bgbj001"

            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_bgbj_m.bgbj001) AND NOT cl_null(g_bgbj_m.bgbj002) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bgbj_m.bgbj001 != g_bgbj001_t  OR g_bgbj_m.bgbj002 != g_bgbj002_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bgbj_t WHERE "||"bgbjent = '" ||g_enterprise|| "' AND "||"bgbj001 = '"||g_bgbj_m.bgbj001 ||"' AND "|| "bgbj002 = '"||g_bgbj_m.bgbj002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            LET g_bgbj_m.bgbj001_desc = ' '
            DISPLAY BY NAME g_bgbj_m.bgbj001_desc
            IF NOT cl_null(g_bgbj_m.bgbj001) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_bgbj_m.bgbj001 != g_bgbj_m_t.bgbj001 OR g_bgbj_m_t.bgbj001 IS NULL )) THEN #160822-00012#3 mark
               IF g_bgbj_m.bgbj001 != g_bgbj_m_o.bgbj001 OR cl_null(g_bgbj_m_o.bgbj001) THEN  #160822-00012#3 add
                  CALL s_fin_budget_chk(g_bgbj_m.bgbj001)RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     #160321-00016#23 --s add
                     LET g_errparam.replace[1] = 'abgi040'
                     LET g_errparam.replace[2] = cl_get_progname('abgi040',g_lang,"2")
                     LET g_errparam.exeprog = 'abgi040'
                     #160321-00016#23 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_bgbj_m.bgbj001 = g_bgbj_m_t.bgbj001   #160822-00012#3 mark
                     LET g_bgbj_m.bgbj001 = g_bgbj_m_o.bgbj001    #160822-00012#3 add
                     LET g_bgbj_m.bgbj001_desc = s_desc_get_budget_desc(g_bgbj_m.bgbj001)
                     DISPLAY BY NAME g_bgbj_m.bgbj001_desc,g_bgbj_m.bgbj001
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_fin_abg_center_sons_query(g_bgbj_m.bgbj001,'','')
                  LET g_bgbj_m.bgbj002 = ''
                  LET g_bgbj_m.bgbj002_desc = ''
                  DISPLAY BY NAME g_bgbj_m.bgbj002,g_bgbj_m.bgbj002_desc
               END IF
            END IF
            LET g_bgbj_m.bgbj001_desc = s_desc_get_budget_desc(g_bgbj_m.bgbj001)
            DISPLAY BY NAME g_bgbj_m.bgbj001_desc,g_bgbj_m.bgbj001
            #預算幣別/使用預算項目參照表/使用科目預算
            SELECT bgaa003,bgaa008,bgaa012
              INTO g_bgbj_m.bgaa003,g_bgaa008,g_bgaa012
              FROM bgaa_t
             WHERE bgaaent = g_enterprise
               AND bgaa001 = g_bgbj_m.bgbj001 
            DISPLAY BY NAME g_bgbj_m.bgaa003
            LET g_bgbj_m_o.* = g_bgbj_m.*  #160822-00012#3 add
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj001
            #add-point:BEFORE FIELD bgbj001 name="input.b.bgbj001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbj001
            #add-point:ON CHANGE bgbj001 name="input.g.bgbj001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj002
            
            #add-point:AFTER FIELD bgbj002 name="input.a.bgbj002"

            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_bgbj_m.bgbj001) AND NOT cl_null(g_bgbj_m.bgbj002) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bgbj_m.bgbj001 != g_bgbj001_t  OR g_bgbj_m.bgbj002 != g_bgbj002_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bgbj_t WHERE "||"bgbjent = '" ||g_enterprise|| "' AND "||"bgbj001 = '"||g_bgbj_m.bgbj001 ||"' AND "|| "bgbj002 = '"||g_bgbj_m.bgbj002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            LET g_bgbj_m.bgbj002_desc = ' '
            DISPLAY BY NAME g_bgbj_m.bgbj002_desc
            IF NOT cl_null(g_bgbj_m.bgbj002) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_bgbj_m.bgbj002 != g_bgbj_m_t.bgbj002 OR g_bgbj_m_t.bgbj002 IS NULL )) THEN  #160822-00012#3 mark
               IF g_bgbj_m.bgbj002 != g_bgbj_m_o.bgbj002 OR cl_null(g_bgbj_m_o.bgbj002) THEN  #160822-00012#3 add              
                  CALL s_abg_site_chk(g_bgbj_m.bgbj002)RETURNING g_sub_success,g_errno   
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_bgbj_m.bgbj002 = g_bgbj_m_t.bgbj002 #160822-00012#3 mark
                     LET g_bgbj_m.bgbj002 = g_bgbj_m_o.bgbj002  #160822-00012#3 add
                     LET g_bgbj_m.bgbj002_desc = s_desc_get_department_desc(g_bgbj_m.bgbj002)
                     DISPLAY BY NAME g_bgbj_m.bgbj002_desc,g_bgbj_m.bgbj002
                     NEXT FIELD CURRENT
                  END IF                               
               END IF
               #161129-00019#4 --s add
               #檢查預算組織是否在abgi090中可操作的組織中
               CALL s_abg2_bgai004_chk(g_bgbj_m.bgbj001,'',g_bgbj_m.bgbj002,'07')
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_bgbj_m.bgbj002 = g_bgbj_m_o.bgbj002  #160822-00012#3 add
                  LET g_bgbj_m.bgbj002_desc = s_desc_get_department_desc(g_bgbj_m.bgbj002)
                  DISPLAY BY NAME g_bgbj_m.bgbj002_desc,g_bgbj_m.bgbj002
                  NEXT FIELD CURRENT
               END IF
               #161129-00019#4 --e add                
            END IF
            LET g_bgbj_m.bgbj002_desc = s_desc_get_department_desc(g_bgbj_m.bgbj002)
            DISPLAY BY NAME g_bgbj_m.bgbj002_desc,g_bgbj_m.bgbj002
            
            LET g_glaald = NULL
            SELECT glaald,glaa004 INTO g_glaald,g_glaa004 FROM glaa_t,ooef_t
             WHERE glaaent = g_enterprise
               AND glaacomp = ooef017
               AND glaaent = ooefent
               AND ooef001 = g_bgbj_m.bgbj002
               AND glaa014 = 'Y'
            CALL abgt040_ld_info(g_glaald)
            LET g_bgbj_m_o.* = g_bgbj_m.*  #160822-00012#3 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj002
            #add-point:BEFORE FIELD bgbj002 name="input.b.bgbj002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbj002
            #add-point:ON CHANGE bgbj002 name="input.g.bgbj002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaa003
            #add-point:BEFORE FIELD bgaa003 name="input.b.bgaa003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaa003
            
            #add-point:AFTER FIELD bgaa003 name="input.a.bgaa003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgaa003
            #add-point:ON CHANGE bgaa003 name="input.g.bgaa003"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.bgbj001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj001
            #add-point:ON ACTION controlp INFIELD bgbj001 name="input.c.bgbj001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgbj_m.bgbj001
            CALL q_bgaa001()
            LET g_bgbj_m.bgbj001 = g_qryparam.return1
            DISPLAY BY NAME g_bgbj_m.bgbj001
            NEXT FIELD bgbj001
            #END add-point
 
 
         #Ctrlp:input.c.bgbj002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj002
            #add-point:ON ACTION controlp INFIELD bgbj002 name="input.c.bgbj002"
            #161129-00019#4 --s mark
            ##161006-00005#11  add----s
            #CALL s_fin_abg_center_sons_query(g_bgbj_m.bgbj001,'','')
            #CALL s_fin_account_center_sons_str() RETURNING l_orga  
            #CALL s_fin_get_wc_str(l_orga) RETURNING l_orga
            ##161006-00005#11  add----e
            #161129-00019#4 --e mark
            #161129-00019#4 --s add
            #檢查預算組織是否在abgi090中可操作的組織中
            CALL s_abg2_get_budget_site(g_bgbj_m.bgbj001,'',g_user,'07') RETURNING l_site_str
            CALL s_fin_get_wc_str(l_site_str) RETURNING l_site_str
            #161129-00019#4 --e add              
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgbj_m.bgbj002  #給予default值
            #161006-00005#11   mark---e
            #LET g_qryparam.where = " ooef001 IN (SELECT ooef001 FROM s_fin_tmp1) "  
            #CALL q_ooef001()
            #161006-00005#11   mark---e
            ##161129-00019#4 --s mark
            ##161006-00005#11   add---s
            #LET g_qryparam.where = " ooef001 IN ", g_userorga
            #IF NOT cl_null(g_bgbj_m.bgbj001) THEN 
            #   LET g_qryparam.where = g_qryparam.where CLIPPED," AND ooef001 IN ", l_orga
            #END IF
            #161129-00019#4 --e mark
            LET g_qryparam.where = " ooef001 IN ", l_site_str  #161129-00019#4 add
            CALL q_ooef001_77()   
            #161006-00005#11   add---e
            LET g_bgbj_m.bgbj002 = g_qryparam.return1
            DISPLAY BY NAME g_bgbj_m.bgbj002
            NEXT FIELD bgbj002
            #END add-point
 
 
         #Ctrlp:input.c.bgaa003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaa003
            #add-point:ON ACTION controlp INFIELD bgaa003 name="input.c.bgaa003"
            
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
            DISPLAY BY NAME g_bgbj_m.bgbj001             
                            ,g_bgbj_m.bgbj002   
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
            
               #將遮罩欄位還原
               CALL abgt040_bgbj_t_mask_restore('restore_mask_o')
            
               UPDATE bgbj_t SET (bgbj001,bgbj002) = (g_bgbj_m.bgbj001,g_bgbj_m.bgbj002)
                WHERE bgbjent = g_enterprise AND bgbj001 = g_bgbj001_t
                  AND bgbj002 = g_bgbj002_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bgbj_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bgbj_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bgbj_m.bgbj001
               LET gs_keys_bak[1] = g_bgbj001_t
               LET gs_keys[2] = g_bgbj_m.bgbj002
               LET gs_keys_bak[2] = g_bgbj002_t
               LET gs_keys[3] = g_bgbj_d[g_detail_idx].bgbjseq
               LET gs_keys_bak[3] = g_bgbj_d_t.bgbjseq
               LET gs_keys[4] = g_bgbj_d[g_detail_idx].bgbj003
               LET gs_keys_bak[4] = g_bgbj_d_t.bgbj003
               CALL abgt040_update_b('bgbj_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_bgbj_m_t)
                     #LET g_log2 = util.JSON.stringify(g_bgbj_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL abgt040_bgbj_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL abgt040_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_bgbj001_t = g_bgbj_m.bgbj001
           LET g_bgbj002_t = g_bgbj_m.bgbj002
 
           
           IF g_bgbj_d.getLength() = 0 THEN
              NEXT FIELD bgbjseq
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="abgt040.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_bgbj_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_bgbj_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL abgt040_b_fill(g_wc2) #test 
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
            CALL abgt040_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN abgt040_cl USING g_enterprise,g_bgbj_m.bgbj001,g_bgbj_m.bgbj002                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE abgt040_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN abgt040_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_bgbj_d[l_ac].bgbjseq IS NOT NULL
               AND g_bgbj_d[l_ac].bgbj003 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_bgbj_d_t.* = g_bgbj_d[l_ac].*  #BACKUP
               LET g_bgbj_d_o.* = g_bgbj_d[l_ac].*  #BACKUP
               CALL abgt040_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL abgt040_set_no_entry_b(l_cmd)
               OPEN abgt040_bcl USING g_enterprise,g_bgbj_m.bgbj001,
                                                g_bgbj_m.bgbj002,
 
                                                g_bgbj_d_t.bgbjseq
                                                ,g_bgbj_d_t.bgbj003
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN abgt040_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH abgt040_bcl INTO g_bgbj_d[l_ac].bgbjseq,g_bgbj_d[l_ac].bgbj003,g_bgbj_d[l_ac].bgbj004, 
                      g_bgbj_d[l_ac].bgbj005,g_bgbj_d[l_ac].bgbj006,g_bgbj_d[l_ac].bgbj007,g_bgbj_d[l_ac].bgbj008, 
                      g_bgbj_d[l_ac].bgbj009,g_bgbj_d[l_ac].bgbj010,g_bgbj_d[l_ac].bgbj011,g_bgbj_d[l_ac].bgbj012, 
                      g_bgbj_d[l_ac].bgbj013,g_bgbj_d[l_ac].bgbj014,g_bgbj_d[l_ac].bgbj015,g_bgbj_d[l_ac].bgbj016, 
                      g_bgbj_d[l_ac].bgbj017,g_bgbj_d[l_ac].bgbj018,g_bgbj_d[l_ac].bgbj019,g_bgbj_d[l_ac].bgbj020, 
                      g_bgbj_d[l_ac].bgbj021,g_bgbj_d[l_ac].bgbj022,g_bgbj_d[l_ac].bgbj023,g_bgbj_d[l_ac].bgbj024, 
                      g_bgbj_d[l_ac].bgbj025,g_bgbj_d[l_ac].bgbj026,g_bgbj_d[l_ac].bgbj027,g_bgbj_d[l_ac].bgbj028, 
                      g_bgbj_d[l_ac].bgbj029,g_bgbj_d[l_ac].bgbj030,g_bgbj_d[l_ac].bgbj031,g_bgbj_d[l_ac].bgbj032, 
                      g_bgbj_d[l_ac].bgbj033,g_bgbj_d[l_ac].bgbjstus,g_bgbj2_d[l_ac].bgbjseq,g_bgbj2_d[l_ac].bgbj003, 
                      g_bgbj2_d[l_ac].bgbjownid,g_bgbj2_d[l_ac].bgbjowndp,g_bgbj2_d[l_ac].bgbjcrtid, 
                      g_bgbj2_d[l_ac].bgbjcrtdp,g_bgbj2_d[l_ac].bgbjcrtdt,g_bgbj2_d[l_ac].bgbjmodid, 
                      g_bgbj2_d[l_ac].bgbjmoddt
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_bgbj_d_t.bgbjseq,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_bgbj_d_mask_o[l_ac].* =  g_bgbj_d[l_ac].*
                  CALL abgt040_bgbj_t_mask()
                  LET g_bgbj_d_mask_n[l_ac].* =  g_bgbj_d[l_ac].*
                  
                  CALL abgt040_ref_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            IF g_bgaa012 = 'Y' THEN
               LET g_glac002 = g_bgbj_d[l_ac].bgbj003
            ELSE
               CALL abgt040_bg_to_acc(g_bgaa008,g_bgbj_d[l_ac].bgbj003)RETURNING g_glac002
            END IF
            CALL s_fin_sel_glad(g_glaald,g_glac002,'glad0171|glad0172|glad0181|glad0182|glad0191|glad0192|glad0201|glad0202|glad0211|glad0212|glad0221|glad0222|glad0231|glad0232|glad0241|glad0242|glad0251|glad0252|glad0261|glad0262') 
              RETURNING g_errno,g_glad.*
            #end add-point  
            
 
 
        
         BEFORE INSERT
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            INITIALIZE g_bgbj_d_t.* TO NULL
            INITIALIZE g_bgbj_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_bgbj_d[l_ac].* TO NULL
            #公用欄位預設值
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_bgbj2_d[l_ac].bgbjownid = g_user
      LET g_bgbj2_d[l_ac].bgbjowndp = g_dept
      LET g_bgbj2_d[l_ac].bgbjcrtid = g_user
      LET g_bgbj2_d[l_ac].bgbjcrtdp = g_dept 
      LET g_bgbj2_d[l_ac].bgbjcrtdt = cl_get_current()
      LET g_bgbj2_d[l_ac].bgbjmodid = g_user
      LET g_bgbj2_d[l_ac].bgbjmoddt = cl_get_current()
      LET g_bgbj_d[l_ac].bgbjstus = ''
 
 
  
            #一般欄位預設值
                  LET g_bgbj_d[l_ac].bgbj029 = "0"
      LET g_bgbj_d[l_ac].bgbj030 = "0"
      LET g_bgbj_d[l_ac].bgbj031 = "0"
      LET g_bgbj_d[l_ac].bgbj032 = "0"
      LET g_bgbj_d[l_ac].bgbj033 = "0"
 
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            SELECT MAX(bgbjseq+1) INTO g_bgbj_d[l_ac].bgbjseq
              FROM bgbj_t
             WHERE bgbjent = g_enterprise
               AND bgbj001 = g_bgbj_m.bgbj001
               AND bgbj002 = g_bgbj_m.bgbj002
            IF cl_null(g_bgbj_d[l_ac].bgbjseq)  THEN LET g_bgbj_d[l_ac].bgbjseq = 1 END IF  
            #end add-point
            LET g_bgbj_d_t.* = g_bgbj_d[l_ac].*     #新輸入資料
            LET g_bgbj_d_o.* = g_bgbj_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL abgt040_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL abgt040_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_bgbj_d[li_reproduce_target].* = g_bgbj_d[li_reproduce].*
               LET g_bgbj2_d[li_reproduce_target].* = g_bgbj2_d[li_reproduce].*
 
               LET g_bgbj_d[g_bgbj_d.getLength()].bgbjseq = NULL
               LET g_bgbj_d[g_bgbj_d.getLength()].bgbj003 = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM bgbj_t 
             WHERE bgbjent = g_enterprise AND bgbj001 = g_bgbj_m.bgbj001
               AND bgbj002 = g_bgbj_m.bgbj002
 
               AND bgbjseq = g_bgbj_d[l_ac].bgbjseq
               AND bgbj003 = g_bgbj_d[l_ac].bgbj003
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               #170110-00007#2---s---
               IF cl_null(g_bgbj_d[l_ac].bgbj005) THEN LET g_bgbj_d[l_ac].bgbj005 = ' ' END IF
               IF cl_null(g_bgbj_d[l_ac].bgbj006) THEN LET g_bgbj_d[l_ac].bgbj006 = ' ' END IF               
               IF cl_null(g_bgbj_d[l_ac].bgbj007) THEN LET g_bgbj_d[l_ac].bgbj007 = ' ' END IF               
               IF cl_null(g_bgbj_d[l_ac].bgbj008) THEN LET g_bgbj_d[l_ac].bgbj008 = ' ' END IF
               IF cl_null(g_bgbj_d[l_ac].bgbj009) THEN LET g_bgbj_d[l_ac].bgbj009 = ' ' END IF               
               IF cl_null(g_bgbj_d[l_ac].bgbj010) THEN LET g_bgbj_d[l_ac].bgbj010 = ' ' END IF               
               IF cl_null(g_bgbj_d[l_ac].bgbj011) THEN LET g_bgbj_d[l_ac].bgbj011 = ' ' END IF               
               IF cl_null(g_bgbj_d[l_ac].bgbj012) THEN LET g_bgbj_d[l_ac].bgbj012 = ' ' END IF
               IF cl_null(g_bgbj_d[l_ac].bgbj013) THEN LET g_bgbj_d[l_ac].bgbj013 = ' ' END IF
               IF cl_null(g_bgbj_d[l_ac].bgbj014) THEN LET g_bgbj_d[l_ac].bgbj014 = ' ' END IF
               IF cl_null(g_bgbj_d[l_ac].bgbj015) THEN LET g_bgbj_d[l_ac].bgbj015 = ' ' END IF
               IF cl_null(g_bgbj_d[l_ac].bgbj016) THEN LET g_bgbj_d[l_ac].bgbj016 = ' ' END IF
               IF cl_null(g_bgbj_d[l_ac].bgbj017) THEN LET g_bgbj_d[l_ac].bgbj017 = ' ' END IF
               IF cl_null(g_bgbj_d[l_ac].bgbj018) THEN LET g_bgbj_d[l_ac].bgbj018 = ' ' END IF
               IF cl_null(g_bgbj_d[l_ac].bgbj019) THEN LET g_bgbj_d[l_ac].bgbj019 = ' ' END IF
               IF cl_null(g_bgbj_d[l_ac].bgbj020) THEN LET g_bgbj_d[l_ac].bgbj020 = ' ' END IF
               IF cl_null(g_bgbj_d[l_ac].bgbj021) THEN LET g_bgbj_d[l_ac].bgbj021 = ' ' END IF
               IF cl_null(g_bgbj_d[l_ac].bgbj022) THEN LET g_bgbj_d[l_ac].bgbj022 = ' ' END IF
               IF cl_null(g_bgbj_d[l_ac].bgbj023) THEN LET g_bgbj_d[l_ac].bgbj023 = ' ' END IF               
               IF cl_null(g_bgbj_d[l_ac].bgbj024) THEN LET g_bgbj_d[l_ac].bgbj024 = ' ' END IF
               IF cl_null(g_bgbj_d[l_ac].bgbj025) THEN LET g_bgbj_d[l_ac].bgbj025 = ' ' END IF               
               IF cl_null(g_bgbj_d[l_ac].bgbj026) THEN LET g_bgbj_d[l_ac].bgbj026 = ' ' END IF               
               IF cl_null(g_bgbj_d[l_ac].bgbj027) THEN LET g_bgbj_d[l_ac].bgbj027 = ' ' END IF
               #170110-00007#2---e---
               
               #end add-point
               INSERT INTO bgbj_t
                           (bgbjent,
                            bgbj001,bgbj002,
                            bgbjseq,bgbj003
                            ,bgbj004,bgbj005,bgbj006,bgbj007,bgbj008,bgbj009,bgbj010,bgbj011,bgbj012,bgbj013,bgbj014,bgbj015,bgbj016,bgbj017,bgbj018,bgbj019,bgbj020,bgbj021,bgbj022,bgbj023,bgbj024,bgbj025,bgbj026,bgbj027,bgbj028,bgbj029,bgbj030,bgbj031,bgbj032,bgbj033,bgbjstus,bgbjownid,bgbjowndp,bgbjcrtid,bgbjcrtdp,bgbjcrtdt,bgbjmodid,bgbjmoddt) 
                     VALUES(g_enterprise,
                            g_bgbj_m.bgbj001,g_bgbj_m.bgbj002,
                            g_bgbj_d[l_ac].bgbjseq,g_bgbj_d[l_ac].bgbj003
                            ,g_bgbj_d[l_ac].bgbj004,g_bgbj_d[l_ac].bgbj005,g_bgbj_d[l_ac].bgbj006,g_bgbj_d[l_ac].bgbj007, 
                                g_bgbj_d[l_ac].bgbj008,g_bgbj_d[l_ac].bgbj009,g_bgbj_d[l_ac].bgbj010, 
                                g_bgbj_d[l_ac].bgbj011,g_bgbj_d[l_ac].bgbj012,g_bgbj_d[l_ac].bgbj013, 
                                g_bgbj_d[l_ac].bgbj014,g_bgbj_d[l_ac].bgbj015,g_bgbj_d[l_ac].bgbj016, 
                                g_bgbj_d[l_ac].bgbj017,g_bgbj_d[l_ac].bgbj018,g_bgbj_d[l_ac].bgbj019, 
                                g_bgbj_d[l_ac].bgbj020,g_bgbj_d[l_ac].bgbj021,g_bgbj_d[l_ac].bgbj022, 
                                g_bgbj_d[l_ac].bgbj023,g_bgbj_d[l_ac].bgbj024,g_bgbj_d[l_ac].bgbj025, 
                                g_bgbj_d[l_ac].bgbj026,g_bgbj_d[l_ac].bgbj027,g_bgbj_d[l_ac].bgbj028, 
                                g_bgbj_d[l_ac].bgbj029,g_bgbj_d[l_ac].bgbj030,g_bgbj_d[l_ac].bgbj031, 
                                g_bgbj_d[l_ac].bgbj032,g_bgbj_d[l_ac].bgbj033,g_bgbj_d[l_ac].bgbjstus, 
                                g_bgbj2_d[l_ac].bgbjownid,g_bgbj2_d[l_ac].bgbjowndp,g_bgbj2_d[l_ac].bgbjcrtid, 
                                g_bgbj2_d[l_ac].bgbjcrtdp,g_bgbj2_d[l_ac].bgbjcrtdt,g_bgbj2_d[l_ac].bgbjmodid, 
                                g_bgbj2_d[l_ac].bgbjmoddt)
               #add-point:單身新增中 name="input.body.m_insert"
               
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_bgbj_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "bgbj_t:",SQLERRMESSAGE 
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
               IF abgt040_before_delete() THEN 
                  
 
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_bgbj_m.bgbj001
                  LET gs_keys[gs_keys.getLength()+1] = g_bgbj_m.bgbj002
 
                  LET gs_keys[gs_keys.getLength()+1] = g_bgbj_d_t.bgbjseq
                  LET gs_keys[gs_keys.getLength()+1] = g_bgbj_d_t.bgbj003
 
 
                  #刪除下層單身
                  IF NOT abgt040_key_delete_b(gs_keys,'bgbj_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE abgt040_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE abgt040_bcl
               LET l_count = g_bgbj_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_bgbj_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbjseq
            #add-point:BEFORE FIELD bgbjseq name="input.b.page1.bgbjseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbjseq
            
            #add-point:AFTER FIELD bgbjseq name="input.a.page1.bgbjseq"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_bgbj_m.bgbj001 IS NOT NULL AND g_bgbj_m.bgbj002 IS NOT NULL AND g_bgbj_d[g_detail_idx].bgbjseq IS NOT NULL AND g_bgbj_d[g_detail_idx].bgbj003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_bgbj_m.bgbj001 != g_bgbj001_t OR g_bgbj_m.bgbj002 != g_bgbj002_t OR g_bgbj_d[g_detail_idx].bgbjseq != g_bgbj_d_t.bgbjseq OR g_bgbj_d[g_detail_idx].bgbj003 != g_bgbj_d_t.bgbj003)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bgbj_t WHERE "||"bgbjent = '" ||g_enterprise|| "' AND "||"bgbj001 = '"||g_bgbj_m.bgbj001 ||"' AND "|| "bgbj002 = '"||g_bgbj_m.bgbj002 ||"' AND "|| "bgbjseq = '"||g_bgbj_d[g_detail_idx].bgbjseq ||"' AND "|| "bgbj003 = '"||g_bgbj_d[g_detail_idx].bgbj003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbjseq
            #add-point:ON CHANGE bgbjseq name="input.g.page1.bgbjseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj003
            
            #add-point:AFTER FIELD bgbj003 name="input.a.page1.bgbj003"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_bgbj_m.bgbj001 IS NOT NULL AND g_bgbj_m.bgbj002 IS NOT NULL AND g_bgbj_d[g_detail_idx].bgbjseq IS NOT NULL AND g_bgbj_d[g_detail_idx].bgbj003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_bgbj_m.bgbj001 != g_bgbj001_t OR g_bgbj_m.bgbj002 != g_bgbj002_t OR g_bgbj_d[g_detail_idx].bgbjseq != g_bgbj_d_t.bgbjseq OR g_bgbj_d[g_detail_idx].bgbj003 != g_bgbj_d_t.bgbj003)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bgbj_t WHERE "||"bgbjent = '" ||g_enterprise|| "' AND "||"bgbj001 = '"||g_bgbj_m.bgbj001 ||"' AND "|| "bgbj002 = '"||g_bgbj_m.bgbj002 ||"' AND "|| "bgbjseq = '"||g_bgbj_d[g_detail_idx].bgbjseq ||"' AND "|| "bgbj003 = '"||g_bgbj_d[g_detail_idx].bgbj003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            LET g_bgbj_d[l_ac].bgbj003_desc = ' '
            DISPLAY BY NAME g_bgbj_d[l_ac].bgbj003_desc
            IF NOT cl_null(g_bgbj_d[l_ac].bgbj003) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_bgbj_d[l_ac].bgbj003 != g_bgbj_d_t.bgbj003 OR g_bgbj_d_t.bgbj003 IS NULL )) THEN
                  CALL abgt040_bgbj003_chk(g_bgbj_m.bgbj001,g_bgbj_d[l_ac].bgbj003) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     #160321-00016#23 --s add
                     IF g_errno = 'sub-01302' THEN
                        LET g_errparam.replace[1] = 'agli020'
                        LET g_errparam.replace[2] = cl_get_progname('agli020',g_lang,"2")
                        LET g_errparam.exeprog = 'agli020'
                     END IF
                     #160321-00016#23 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgbj_d[l_ac].bgbj003 = g_bgbj_d_t.bgbj003
                     LET g_bgbj_d[l_ac].bgbj003_desc = s_abg_bgae001_desc(g_bgaa008,g_bgbj_d[l_ac].bgbj003)
                     DISPLAY BY NAME g_bgbj_d[l_ac].bgbj003,g_bgbj_d[l_ac].bgbj003_desc
                     NEXT FIELD CURRENT
                  END IF         
               END IF
            END IF
            LET g_bgbj_d[l_ac].bgbj003_desc = s_abg_bgae001_desc(g_bgaa008,g_bgbj_d[l_ac].bgbj003)
            DISPLAY BY NAME g_bgbj_d[l_ac].bgbj003,g_bgbj_d[l_ac].bgbj003_desc
            IF g_bgaa012 = 'Y' THEN
               LET g_glac002 = g_bgbj_d[l_ac].bgbj003
               LET g_bgbj_d[l_ac].bgbj003_desc = s_desc_get_account_desc(g_glaald,g_bgbj_d[l_ac].bgbj003)
            ELSE
               CALL abgt040_bg_to_acc(g_bgaa008,g_bgbj_d[l_ac].bgbj003)RETURNING g_glac002
               LET g_bgbj_d[l_ac].bgbj003_desc = s_abg_bgae001_desc(g_bgaa008,g_bgbj_d[l_ac].bgbj003)
               DISPLAY BY NAME g_bgbj_d[l_ac].bgbj003,g_bgbj_d[l_ac].bgbj003_desc
            END IF            
            CALL s_fin_sel_glad(g_glaald,g_glac002,'glad0171|glad0172|glad0181|glad0182|glad0191|glad0192|glad0201|glad0202|glad0211|glad0212|glad0221|glad0222|glad0231|glad0232|glad0241|glad0242|glad0251|glad0252|glad0261|glad0262') 
              RETURNING g_errno,g_glad.*
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj003
            #add-point:BEFORE FIELD bgbj003 name="input.b.page1.bgbj003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbj003
            #add-point:ON CHANGE bgbj003 name="input.g.page1.bgbj003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj004
            #add-point:BEFORE FIELD bgbj004 name="input.b.page1.bgbj004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj004
            
            #add-point:AFTER FIELD bgbj004 name="input.a.page1.bgbj004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbj004
            #add-point:ON CHANGE bgbj004 name="input.g.page1.bgbj004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj005
            #add-point:BEFORE FIELD bgbj005 name="input.b.page1.bgbj005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj005
            
            #add-point:AFTER FIELD bgbj005 name="input.a.page1.bgbj005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbj005
            #add-point:ON CHANGE bgbj005 name="input.g.page1.bgbj005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj005_desc
            #add-point:BEFORE FIELD bgbj005_desc name="input.b.page1.bgbj005_desc"
            LET g_bgbj_d[l_ac].bgbj005_desc = g_bgbj_d[l_ac].bgbj005
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj005_desc
            
            #add-point:AFTER FIELD bgbj005_desc name="input.a.page1.bgbj005_desc"
            #部門
            IF NOT cl_null(g_bgbj_d[l_ac].bgbj005_desc) THEN
               #IF ( g_bgbj_d[l_ac].bgbj005_desc != g_bgbj_d_t.bgbj005_desc OR g_bgbj_d_t.bgbj005_desc IS NULL ) THEN #160822-00012#3 mark
               IF g_bgbj_d[l_ac].bgbj005_desc != g_bgbj_d_o.bgbj005_desc OR cl_null(g_bgbj_d_o.bgbj005_desc) THEN #160822-00012#3 add
                  LET g_bgbj_d[l_ac].bgbj005 = g_bgbj_d[l_ac].bgbj005_desc
                  #IF g_glaa.glaa121 = 'N' THEN
                     IF (g_bgbj_d[l_ac].bgbj005 != g_bgbj_d_t.bgbj005 OR g_bgbj_d_t.bgbj005 IS NULL) THEN
                        CALL s_department_chk(g_bgbj_d[l_ac].bgbj005_desc,g_today) RETURNING g_sub_success
                        IF NOT g_sub_success THEN
                           #LET g_bgbj_d[l_ac].bgbj005 = g_bgbj_d_t.bgbj005            #160822-00012#3 mark
                           #LET g_bgbj_d[l_ac].bgbj005_desc = g_bgbj_d_t.bgbj005_desc  #160822-00012#3 mark
                           LET g_bgbj_d[l_ac].bgbj005 = g_bgbj_d_o.bgbj005             #160822-00012#3 add
                           LET g_bgbj_d[l_ac].bgbj005_desc = g_bgbj_d_o.bgbj005_desc   #160822-00012#3 add
                           DISPLAY BY NAME g_bgbj_d[l_ac].bgbj005 ,g_bgbj_d[l_ac].bgbj005_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  #END IF
                  #取責任中心
                  CALL s_department_get_respon_center(g_bgbj_d[l_ac].bgbj005,g_today)
                       RETURNING g_sub_success,g_errno,g_bgbj_d[l_ac].bgbj006,g_bgbj_d[l_ac].bgbj006_desc
                  LET g_bgbj_d[l_ac].bgbj006_desc = s_desc_show1(g_bgbj_d[l_ac].bgbj006,g_bgbj_d[l_ac].bgbj006_desc)
                  LET g_bgbj_d_t.bgbj006_desc = g_bgbj_d[l_ac].bgbj006_desc
                  DISPLAY BY NAME g_bgbj_d[l_ac].bgbj006,g_bgbj_d[l_ac].bgbj006_desc
               END IF
            ELSE
               LET g_bgbj_d[l_ac].bgbj005 = ''
            END IF
            LET g_bgbj_d[l_ac].bgbj005_desc = s_desc_show1(g_bgbj_d[l_ac].bgbj005,s_desc_get_department_desc(g_bgbj_d[l_ac].bgbj005))
            DISPLAY BY NAME g_bgbj_d[l_ac].bgbj005 ,g_bgbj_d[l_ac].bgbj005_desc
            LET g_bgbj_d_t.bgbj005_desc = g_bgbj_d[l_ac].bgbj005_desc
            LET g_bgbj_d_o.* = g_bgbj_d[l_ac].*   #160822-00012#3 add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbj005_desc
            #add-point:ON CHANGE bgbj005_desc name="input.g.page1.bgbj005_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj006
            #add-point:BEFORE FIELD bgbj006 name="input.b.page1.bgbj006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj006
            
            #add-point:AFTER FIELD bgbj006 name="input.a.page1.bgbj006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbj006
            #add-point:ON CHANGE bgbj006 name="input.g.page1.bgbj006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj006_desc
            #add-point:BEFORE FIELD bgbj006_desc name="input.b.page1.bgbj006_desc"
            LET g_bgbj_d[l_ac].bgbj006_desc = g_bgbj_d[l_ac].bgbj006
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj006_desc
            
            #add-point:AFTER FIELD bgbj006_desc name="input.a.page1.bgbj006_desc"
            #責任中心
            IF NOT cl_null(g_bgbj_d[l_ac].bgbj006_desc) THEN
               #IF ( g_bgbj_d[l_ac].bgbj006_desc != g_bgbj_d_t.bgbj006_desc OR g_bgbj_d_t.bgbj006_desc IS NULL ) THEN #160822-00012#3 mark
               IF g_bgbj_d[l_ac].bgbj006_desc != g_bgbj_d_o.bgbj006_desc OR cl_null(g_bgbj_d_o.bgbj006_desc) THEN #160822-00012#3 add
                  LET g_bgbj_d[l_ac].bgbj006 = g_bgbj_d[l_ac].bgbj006_desc
                  IF g_glaa.glaa121 = 'N' THEN
                     IF (g_bgbj_d[l_ac].bgbj006 != g_bgbj_d_t.bgbj006 OR g_bgbj_d_t.bgbj006 IS NULL) THEN
                        CALL s_voucher_glaq019_chk(g_bgbj_d[l_ac].bgbj006_desc,g_today)
                        IF NOT cl_null(g_errno) THEN
                           #LET g_bgbj_d[l_ac].bgbj006 = g_bgbj_d_t.bgbj006              #160822-00012#3 mark
                           #LET g_bgbj_d[l_ac].bgbj006_desc = g_bgbj_d_t.bgbj006_desc    #160822-00012#3 mark
                           LET g_bgbj_d[l_ac].bgbj006 = g_bgbj_d_o.bgbj006               #160822-00012#3 add
                           LET g_bgbj_d[l_ac].bgbj006_desc = g_bgbj_d_o.bgbj006_desc     #160822-00012#3 add
                           DISPLAY BY NAME g_bgbj_d[l_ac].bgbj006,g_bgbj_d[l_ac].bgbj006_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_bgbj_d[l_ac].bgbj006 = ''
            END IF
            LET g_bgbj_d[l_ac].bgbj006_desc = s_desc_show1(g_bgbj_d[l_ac].bgbj006,s_desc_get_department_desc(g_bgbj_d[l_ac].bgbj006))
            DISPLAY BY NAME g_bgbj_d[l_ac].bgbj006 ,g_bgbj_d[l_ac].bgbj006_desc
            LET g_bgbj_d_t.bgbj006_desc = g_bgbj_d[l_ac].bgbj006_desc      
            LET g_bgbj_d_o.* = g_bgbj_d[l_ac].*   #160822-00012#3 add            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbj006_desc
            #add-point:ON CHANGE bgbj006_desc name="input.g.page1.bgbj006_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj007
            #add-point:BEFORE FIELD bgbj007 name="input.b.page1.bgbj007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj007
            
            #add-point:AFTER FIELD bgbj007 name="input.a.page1.bgbj007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbj007
            #add-point:ON CHANGE bgbj007 name="input.g.page1.bgbj007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj007_desc
            #add-point:BEFORE FIELD bgbj007_desc name="input.b.page1.bgbj007_desc"
            LET g_bgbj_d[l_ac].bgbj007_desc = g_bgbj_d[l_ac].bgbj007
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj007_desc
            
            #add-point:AFTER FIELD bgbj007_desc name="input.a.page1.bgbj007_desc"
            #區域
            IF NOT cl_null(g_bgbj_d[l_ac].bgbj007_desc) THEN
               #IF ( g_bgbj_d[l_ac].bgbj007_desc != g_bgbj_d_t.bgbj007_desc OR g_bgbj_d_t.bgbj007_desc IS NULL ) THEN #160822-00012#3 mark
               IF g_bgbj_d[l_ac].bgbj007_desc != g_bgbj_d_o.bgbj007_desc OR cl_null(g_bgbj_d_o.bgbj007_desc) THEN #160822-00012#3 add
                  LET g_bgbj_d[l_ac].bgbj007 = g_bgbj_d[l_ac].bgbj007_desc
                  #IF g_glaa.glaa121 = 'N' THEN
                     IF (g_bgbj_d[l_ac].bgbj007 != g_bgbj_d_t.bgbj007 OR g_bgbj_d_t.bgbj007 IS NULL) THEN
                        IF NOT s_azzi650_chk_exist('287',g_bgbj_d[l_ac].bgbj007) THEN
                           #LET g_bgbj_d[l_ac].bgbj007 = g_bgbj_d_t.bgbj007             #160822-00012#3 mark
                           #LET g_bgbj_d[l_ac].bgbj007_desc = g_bgbj_d_t.bgbj007_desc   #160822-00012#3 mark
                           LET g_bgbj_d[l_ac].bgbj007 = g_bgbj_d_o.bgbj007              #160822-00012#3 add
                           LET g_bgbj_d[l_ac].bgbj007_desc = g_bgbj_d_o.bgbj007_desc    #160822-00012#3 add
                           DISPLAY BY NAME g_bgbj_d[l_ac].bgbj007 ,g_bgbj_d[l_ac].bgbj007_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  #END IF
               END IF
            END IF
            LET g_bgbj_d[l_ac].bgbj007_desc = s_desc_show1(g_bgbj_d[l_ac].bgbj007,s_desc_get_acc_desc('287',g_bgbj_d[l_ac].bgbj007))
            DISPLAY BY NAME g_bgbj_d[l_ac].bgbj007 ,g_bgbj_d[l_ac].bgbj007_desc
            LET g_bgbj_d_t.bgbj007_desc = g_bgbj_d[l_ac].bgbj007_desc
            LET g_bgbj_d_o.* = g_bgbj_d[l_ac].*   #160822-00012#3 add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbj007_desc
            #add-point:ON CHANGE bgbj007_desc name="input.g.page1.bgbj007_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj008
            #add-point:BEFORE FIELD bgbj008 name="input.b.page1.bgbj008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj008
            
            #add-point:AFTER FIELD bgbj008 name="input.a.page1.bgbj008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbj008
            #add-point:ON CHANGE bgbj008 name="input.g.page1.bgbj008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj008_desc
            #add-point:BEFORE FIELD bgbj008_desc name="input.b.page1.bgbj008_desc"
            LET g_bgbj_d[l_ac].bgbj008_desc = g_bgbj_d[l_ac].bgbj008
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj008_desc
            
            #add-point:AFTER FIELD bgbj008_desc name="input.a.page1.bgbj008_desc"
            #交易客商
            IF NOT cl_null(g_bgbj_d[l_ac].bgbj008_desc) THEN
               #IF ( g_bgbj_d[l_ac].bgbj008_desc != g_bgbj_d_t.bgbj008_desc OR g_bgbj_d_t.bgbj008_desc IS NULL ) THEN #160822-00012#3 mark
               IF g_bgbj_d[l_ac].bgbj008_desc != g_bgbj_d_o.bgbj008_desc OR cl_null(g_bgbj_d_o.bgbj008_desc) THEN     #160822-00012#3 add
                  LET g_bgbj_d[l_ac].bgbj008 = g_bgbj_d[l_ac].bgbj008_desc
                  #IF g_glaa.glaa121 = 'N' THEN
                     IF (g_bgbj_d[l_ac].bgbj008 != g_bgbj_d_t.bgbj008 OR g_bgbj_d_t.bgbj008 IS NULL) THEN
                        INITIALIZE g_chkparam.* TO NULL
                        LET g_chkparam.arg1 = g_bgbj_d[l_ac].bgbj008
                        LET g_chkparam.arg2 = ' '
                        LET g_errshow = TRUE   #160318-00025#49
                        LET g_chkparam.err_str[1] = "apm-00201:sub-01302|axmm200|",cl_get_progname("axmm200",g_lang,"2"),"|:EXEPROGaxmm200"    #160318-00025#49 
                        IF NOT cl_chk_exist("v_pmaa001_7") THEN
                           #LET g_bgbj_d[l_ac].bgbj008 = g_bgbj_d_t.bgbj008            #160822-00012#3 mark
                           #LET g_bgbj_d[l_ac].bgbj008_desc = g_bgbj_d_t.bgbj008_desc  #160822-00012#3 mark
                           LET g_bgbj_d[l_ac].bgbj008 = g_bgbj_d_o.bgbj008             #160822-00012#3 add
                           LET g_bgbj_d[l_ac].bgbj008_desc = g_bgbj_d_o.bgbj008_desc   #160822-00012#3 add
                           DISPLAY BY NAME g_bgbj_d[l_ac].bgbj008 ,g_bgbj_d[l_ac].bgbj008_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  #END IF
               END IF
            ELSE
               LET g_bgbj_d[l_ac].bgbj008 = ''
            END IF
            LET g_bgbj_d[l_ac].bgbj008_desc = s_desc_show1(g_bgbj_d[l_ac].bgbj008,s_desc_get_trading_partner_abbr_desc(g_bgbj_d[l_ac].bgbj008))
            DISPLAY BY NAME g_bgbj_d[l_ac].bgbj008 ,g_bgbj_d[l_ac].bgbj008_desc
            LET g_bgbj_d_t.bgbj008_desc = g_bgbj_d[l_ac].bgbj008_desc
            LET g_bgbj_d_o.* = g_bgbj_d[l_ac].*   #160822-00012#3 add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbj008_desc
            #add-point:ON CHANGE bgbj008_desc name="input.g.page1.bgbj008_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj009
            #add-point:BEFORE FIELD bgbj009 name="input.b.page1.bgbj009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj009
            
            #add-point:AFTER FIELD bgbj009 name="input.a.page1.bgbj009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbj009
            #add-point:ON CHANGE bgbj009 name="input.g.page1.bgbj009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj009_desc
            #add-point:BEFORE FIELD bgbj009_desc name="input.b.page1.bgbj009_desc"
            LET g_bgbj_d[l_ac].bgbj009_desc = g_bgbj_d[l_ac].bgbj009
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj009_desc
            
            #add-point:AFTER FIELD bgbj009_desc name="input.a.page1.bgbj009_desc"
            #收款客商
            IF NOT cl_null(g_bgbj_d[l_ac].bgbj009_desc) THEN
               #IF ( g_bgbj_d[l_ac].bgbj009_desc != g_bgbj_d_t.bgbj009_desc OR g_bgbj_d_t.bgbj009_desc IS NULL ) THEN #160822-00012#3 mark
               IF g_bgbj_d[l_ac].bgbj009_desc != g_bgbj_d_o.bgbj009_desc OR cl_null(g_bgbj_d_o.bgbj009_desc) THEN     #160822-00012#3 add
                  LET g_bgbj_d[l_ac].bgbj009 = g_bgbj_d[l_ac].bgbj009_desc
                  #IF g_glaa.glaa121 = 'N' THEN
                     IF (g_bgbj_d[l_ac].bgbj009 != g_bgbj_d_t.bgbj009 OR g_bgbj_d_t.bgbj009 IS NULL) THEN
                        INITIALIZE g_chkparam.* TO NULL
                        LET g_chkparam.arg1 = g_bgbj_d[l_ac].bgbj009
                        LET g_chkparam.arg2 = ' '
                        LET g_errshow = TRUE   #160318-00025#49
                        LET g_chkparam.err_str[1] = "apm-00201:sub-01302|axmm200|",cl_get_progname("axmm200",g_lang,"2"),"|:EXEPROGaxmm200"    #160318-00025#49 
                        IF NOT cl_chk_exist("v_pmaa001_7") THEN
                           #LET g_bgbj_d[l_ac].bgbj009 = g_bgbj_d_t.bgbj009           #160822-00012#3 mark
                           #LET g_bgbj_d[l_ac].bgbj009_desc = g_bgbj_d_t.bgbj009_desc #160822-00012#3 mark
                           LET g_bgbj_d[l_ac].bgbj009 = g_bgbj_d_o.bgbj009            #160822-00012#3 add
                           LET g_bgbj_d[l_ac].bgbj009_desc = g_bgbj_d_o.bgbj009_desc  #160822-00012#3 add
                           DISPLAY BY NAME g_bgbj_d[l_ac].bgbj009 ,g_bgbj_d[l_ac].bgbj009_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  #END IF
               END IF
            ELSE
               LET g_bgbj_d[l_ac].bgbj009 = ''
            END IF
            LET g_bgbj_d[l_ac].bgbj009_desc = s_desc_show1(g_bgbj_d[l_ac].bgbj009,s_desc_get_trading_partner_abbr_desc(g_bgbj_d[l_ac].bgbj009))
            DISPLAY BY NAME g_bgbj_d[l_ac].bgbj009 ,g_bgbj_d[l_ac].bgbj009_desc
            LET g_bgbj_d_t.bgbj009_desc = g_bgbj_d[l_ac].bgbj009_desc
            LET g_bgbj_d_o.* = g_bgbj_d[l_ac].*   #160822-00012#3 add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbj009_desc
            #add-point:ON CHANGE bgbj009_desc name="input.g.page1.bgbj009_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj010
            #add-point:BEFORE FIELD bgbj010 name="input.b.page1.bgbj010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj010
            
            #add-point:AFTER FIELD bgbj010 name="input.a.page1.bgbj010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbj010
            #add-point:ON CHANGE bgbj010 name="input.g.page1.bgbj010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj010_desc
            #add-point:BEFORE FIELD bgbj010_desc name="input.b.page1.bgbj010_desc"
            LET g_bgbj_d[l_ac].bgbj010_desc = g_bgbj_d[l_ac].bgbj010
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj010_desc
            
            #add-point:AFTER FIELD bgbj010_desc name="input.a.page1.bgbj010_desc"
            #客群
            IF NOT cl_null(g_bgbj_d[l_ac].bgbj010_desc) THEN
               #IF ( g_bgbj_d[l_ac].bgbj010_desc != g_bgbj_d_t.bgbj010_desc OR g_bgbj_d_t.bgbj010_desc IS NULL ) THEN #160822-00012#3 mark
               IF g_bgbj_d[l_ac].bgbj010_desc != g_bgbj_d_o.bgbj010_desc OR cl_null(g_bgbj_d_o.bgbj010_desc) THEN     #160822-00012#3 add
                  LET g_bgbj_d[l_ac].bgbj010 = g_bgbj_d[l_ac].bgbj010_desc
                  #IF g_glaa.glaa121 = 'N' THEN
                     IF (g_bgbj_d[l_ac].bgbj010 != g_bgbj_d_t.bgbj010 OR g_bgbj_d_t.bgbj010 IS NULL) THEN
                        IF NOT s_azzi650_chk_exist('281',g_bgbj_d[l_ac].bgbj010) THEN
                           #LET g_bgbj_d[l_ac].bgbj010 = g_bgbj_d_t.bgbj010            #160822-00012#3 mark
                           #LET g_bgbj_d[l_ac].bgbj010_desc = g_bgbj_d_t.bgbj010_desc  #160822-00012#3 mark
                           LET g_bgbj_d[l_ac].bgbj010 = g_bgbj_d_o.bgbj010             #160822-00012#3 add
                           LET g_bgbj_d[l_ac].bgbj010_desc = g_bgbj_d_o.bgbj010_desc   #160822-00012#3 add
                           DISPLAY BY NAME g_bgbj_d[l_ac].bgbj010 ,g_bgbj_d[l_ac].bgbj010_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  #END IF
               END IF
            ELSE
               LET g_bgbj_d[l_ac].bgbj010 = ''
            END IF
            LET g_bgbj_d[l_ac].bgbj010_desc = s_desc_show1(g_bgbj_d[l_ac].bgbj010,s_desc_get_acc_desc('281',g_bgbj_d[l_ac].bgbj010))
            DISPLAY BY NAME g_bgbj_d[l_ac].bgbj010 ,g_bgbj_d[l_ac].bgbj010_desc
            LET g_bgbj_d_t.bgbj010_desc = g_bgbj_d[l_ac].bgbj010_desc
            LET g_bgbj_d_o.* = g_bgbj_d[l_ac].*   #160822-00012#3 add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbj010_desc
            #add-point:ON CHANGE bgbj010_desc name="input.g.page1.bgbj010_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj011
            #add-point:BEFORE FIELD bgbj011 name="input.b.page1.bgbj011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj011
            
            #add-point:AFTER FIELD bgbj011 name="input.a.page1.bgbj011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbj011
            #add-point:ON CHANGE bgbj011 name="input.g.page1.bgbj011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj011_desc
            #add-point:BEFORE FIELD bgbj011_desc name="input.b.page1.bgbj011_desc"
            LET g_bgbj_d[l_ac].bgbj011_desc = g_bgbj_d[l_ac].bgbj011
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj011_desc
            
            #add-point:AFTER FIELD bgbj011_desc name="input.a.page1.bgbj011_desc"
            #產品類別
            IF NOT cl_null(g_bgbj_d[l_ac].bgbj011_desc) THEN
               #IF ( g_bgbj_d[l_ac].bgbj011_desc != g_bgbj_d_t.bgbj011_desc OR g_bgbj_d_t.bgbj011_desc IS NULL ) THEN #160822-00012#3 mark
               IF g_bgbj_d[l_ac].bgbj011_desc != g_bgbj_d_o.bgbj011_desc OR cl_null(g_bgbj_d_o.bgbj011_desc) THEN     #160822-00012#3 add
                  LET g_bgbj_d[l_ac].bgbj011 = g_bgbj_d[l_ac].bgbj011_desc
                  #IF g_glaa.glaa121 = 'N' THEN
                     #IF (g_bgbj_d[l_ac].bgbj011 != g_bgbj_d_t.bgbj011 OR g_bgbj_d_t.bgbj011 IS NULL) THEN #160822-00012#3 mark
                     IF g_bgbj_d[l_ac].bgbj011 != g_bgbj_d_o.bgbj011 OR cl_null(g_bgbj_d_o.bgbj011) THEN   #160822-00012#3 add
                        CALL s_voucher_glaq024_chk(g_bgbj_d[l_ac].bgbj011)
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.extend = ""
                           LET g_errparam.code   = g_errno
                           #160321-00016#23 --s add
                           LET g_errparam.replace[1] = 'arti202'
                           LET g_errparam.replace[2] = cl_get_progname('arti202',g_lang,"2")
                           LET g_errparam.exeprog = 'arti202'
                           #160321-00016#23 --e add
                           LET g_errparam.popup  = TRUE
                           CALL cl_err()
                           #LET g_bgbj_d[l_ac].bgbj011 = g_bgbj_d_t.bgbj011           #160822-00012#3 mark
                           #LET g_bgbj_d[l_ac].bgbj011_desc = g_bgbj_d_t.bgbj011_desc #160822-00012#3 mark
                           LET g_bgbj_d[l_ac].bgbj011 = g_bgbj_d_o.bgbj011            #160822-00012#3 add
                           LET g_bgbj_d[l_ac].bgbj011_desc = g_bgbj_d_o.bgbj011_desc  #160822-00012#3 add
                           DISPLAY BY NAME g_bgbj_d[l_ac].bgbj011 ,g_bgbj_d[l_ac].bgbj011_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  #END IF
               END IF
            ELSE
               LET g_bgbj_d[l_ac].bgbj011 = ''
            END IF
            LET g_bgbj_d[l_ac].bgbj011_desc = s_desc_show1(g_bgbj_d[l_ac].bgbj011,s_desc_get_rtaxl003_desc(g_bgbj_d[l_ac].bgbj011))
            DISPLAY BY NAME g_bgbj_d[l_ac].bgbj011 ,g_bgbj_d[l_ac].bgbj011_desc
            LET g_bgbj_d_t.bgbj011_desc = g_bgbj_d[l_ac].bgbj011_desc
            LET g_bgbj_d_o.* = g_bgbj_d[l_ac].*   #160822-00012#3 add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbj011_desc
            #add-point:ON CHANGE bgbj011_desc name="input.g.page1.bgbj011_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj012
            #add-point:BEFORE FIELD bgbj012 name="input.b.page1.bgbj012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj012
            
            #add-point:AFTER FIELD bgbj012 name="input.a.page1.bgbj012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbj012
            #add-point:ON CHANGE bgbj012 name="input.g.page1.bgbj012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj012_desc
            #add-point:BEFORE FIELD bgbj012_desc name="input.b.page1.bgbj012_desc"
            LET g_bgbj_d[l_ac].bgbj012_desc = g_bgbj_d[l_ac].bgbj012
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj012_desc
            
            #add-point:AFTER FIELD bgbj012_desc name="input.a.page1.bgbj012_desc"
            #人員
            IF NOT cl_null(g_bgbj_d[l_ac].bgbj012_desc) THEN
               #IF ( g_bgbj_d[l_ac].bgbj012_desc != g_bgbj_d_t.bgbj012_desc OR g_bgbj_d_t.bgbj012_desc IS NULL ) THEN #160822-00012#3 mark
               IF g_bgbj_d[l_ac].bgbj012_desc != g_bgbj_d_o.bgbj012_desc OR cl_null(g_bgbj_d_o.bgbj012_desc) THEN     #160822-00012#3 add
                  LET g_bgbj_d[l_ac].bgbj012 = g_bgbj_d[l_ac].bgbj012_desc
                  #IF g_glaa.glaa121 = 'N' THEN
                     IF (g_bgbj_d[l_ac].bgbj012 != g_bgbj_d_t.bgbj012 OR g_bgbj_d_t.bgbj012 IS NULL) THEN
                        CALL s_employee_chk(g_bgbj_d[l_ac].bgbj012_desc) RETURNING g_sub_success
                        IF NOT g_sub_success THEN
                           #LET g_bgbj_d[l_ac].bgbj012 = g_bgbj_d_t.bgbj012           #160822-00012#3 mark
                           #LET g_bgbj_d[l_ac].bgbj012_desc = g_bgbj_d_t.bgbj012_desc #160822-00012#3 mark
                           LET g_bgbj_d[l_ac].bgbj012 = g_bgbj_d_o.bgbj012            #160822-00012#3 add
                           LET g_bgbj_d[l_ac].bgbj012_desc = g_bgbj_d_o.bgbj012_desc  #160822-00012#3 add  
                           DISPLAY BY NAME g_bgbj_d[l_ac].bgbj012,g_bgbj_d[l_ac].bgbj012_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  #END IF
               END IF
            ELSE
               LET g_bgbj_d[l_ac].bgbj012 = ''
            END IF
            LET g_bgbj_d[l_ac].bgbj012_desc = s_desc_show1(g_bgbj_d[l_ac].bgbj012,s_desc_get_person_desc(g_bgbj_d[l_ac].bgbj012))
            DISPLAY BY NAME g_bgbj_d[l_ac].bgbj012,g_bgbj_d[l_ac].bgbj012_desc
            LET g_bgbj_d_t.bgbj012_desc = g_bgbj_d[l_ac].bgbj012_desc
            LET g_bgbj_d_o.* = g_bgbj_d[l_ac].*   #160822-00012#3 add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbj012_desc
            #add-point:ON CHANGE bgbj012_desc name="input.g.page1.bgbj012_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj013
            #add-point:BEFORE FIELD bgbj013 name="input.b.page1.bgbj013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj013
            
            #add-point:AFTER FIELD bgbj013 name="input.a.page1.bgbj013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbj013
            #add-point:ON CHANGE bgbj013 name="input.g.page1.bgbj013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj013_desc
            #add-point:BEFORE FIELD bgbj013_desc name="input.b.page1.bgbj013_desc"
            LET g_bgbj_d[l_ac].bgbj013_desc = g_bgbj_d[l_ac].bgbj013
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj013_desc
            
            #add-point:AFTER FIELD bgbj013_desc name="input.a.page1.bgbj013_desc"
            #專案代號
            IF NOT cl_null(g_bgbj_d[l_ac].bgbj013_desc) THEN
               IF ( g_bgbj_d[l_ac].bgbj013_desc != g_bgbj_d_t.bgbj013_desc OR g_bgbj_d_t.bgbj013_desc IS NULL ) THEN
                  LET g_bgbj_d[l_ac].bgbj013 = g_bgbj_d[l_ac].bgbj013_desc
                  #IF g_glaa.glaa121 = 'N' THEN
                     IF (g_bgbj_d[l_ac].bgbj013 != g_bgbj_d_t.bgbj013 OR g_bgbj_d_t.bgbj013 IS NULL) THEN
                        CALL s_aap_project_chk( g_bgbj_d[l_ac].bgbj013) RETURNING g_sub_success,g_errno
                        IF NOT g_sub_success THEN
                            INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = ''
                           #160321-00016#23 --s add
                           LET g_errparam.replace[1] = 'apjm200'
                           LET g_errparam.replace[2] = cl_get_progname('apjm200',g_lang,"2")
                           LET g_errparam.exeprog = 'apjm200'
                           #160321-00016#23 --e add
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_bgbj_d[l_ac].bgbj013      = g_bgbj_d_t.bgbj013
                           LET g_bgbj_d[l_ac].bgbj013_desc = g_bgbj_d_t.bgbj013_desc
                           DISPLAY BY NAME g_bgbj_d[l_ac].bgbj013,g_bgbj_d[l_ac].bgbj013_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  #END IF
               END IF
            ELSE
               LET g_bgbj_d[l_ac].bgbj013 = ''
            END IF
            LET g_bgbj_d[l_ac].bgbj013_desc = s_desc_show1(g_bgbj_d[l_ac].bgbj013,s_desc_get_project_desc(g_bgbj_d[l_ac].bgbj013))
            LET g_bgbj_d_t.bgbj013 = g_bgbj_d[l_ac].bgbj013_desc
            DISPLAY BY NAME g_bgbj_d[l_ac].bgbj013,g_bgbj_d[l_ac].bgbj013_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbj013_desc
            #add-point:ON CHANGE bgbj013_desc name="input.g.page1.bgbj013_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj014
            #add-point:BEFORE FIELD bgbj014 name="input.b.page1.bgbj014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj014
            
            #add-point:AFTER FIELD bgbj014 name="input.a.page1.bgbj014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbj014
            #add-point:ON CHANGE bgbj014 name="input.g.page1.bgbj014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj014_desc
            #add-point:BEFORE FIELD bgbj014_desc name="input.b.page1.bgbj014_desc"
            LET g_bgbj_d[l_ac].bgbj014_desc = g_bgbj_d[l_ac].bgbj014
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj014_desc
            
            #add-point:AFTER FIELD bgbj014_desc name="input.a.page1.bgbj014_desc"
            #WBS
            IF NOT cl_null(g_bgbj_d[l_ac].bgbj014_desc) THEN
               #IF ( g_bgbj_d[l_ac].bgbj014_desc != g_bgbj_d_t.bgbj014_desc OR g_bgbj_d_t.bgbj014_desc IS NULL ) THEN #160822-00012#3 mark
               IF g_bgbj_d[l_ac].bgbj014_desc != g_bgbj_d_o.bgbj014_desc OR cl_null(g_bgbj_d_o.bgbj014_desc) THEN #160822-00012#3
                  LET g_bgbj_d[l_ac].bgbj014 = g_bgbj_d[l_ac].bgbj014_desc
                  #IF g_glaa.glaa121 = 'N' THEN
                     IF (g_bgbj_d[l_ac].bgbj014 != g_bgbj_d_t.bgbj014 OR g_bgbj_d_t.bgbj014 IS NULL) THEN
                        CALL s_voucher_glaq028_chk(g_bgbj_d[l_ac].bgbj013,g_bgbj_d[l_ac].bgbj014)
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           #LET g_bgbj_d[l_ac].bgbj014      = g_bgbj_d_t.bgbj014      #160822-00012#3 mark
                           #LET g_bgbj_d[l_ac].bgbj014_desc = g_bgbj_d_t.bgbj014_desc #160822-00012#3 mark
                           LET g_bgbj_d[l_ac].bgbj014      = g_bgbj_d_o.bgbj014       #160822-00012#3 add
                           LET g_bgbj_d[l_ac].bgbj014_desc = g_bgbj_d_o.bgbj014_desc  #160822-00012#3 add
                           DISPLAY BY NAME g_bgbj_d[l_ac].bgbj014,g_bgbj_d[l_ac].bgbj014_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  #END IF
               END IF
            ELSE
               LET g_bgbj_d[l_ac].bgbj014 = ''
            END IF
            LET g_bgbj_d[l_ac].bgbj014_desc = s_desc_show1(g_bgbj_d[l_ac].bgbj014,s_desc_get_pjbbl004_desc(g_bgbj_d[l_ac].bgbj013,g_bgbj_d[l_ac].bgbj014))
            LET g_bgbj_d_t.bgbj014 = g_bgbj_d[l_ac].bgbj014_desc
            DISPLAY BY NAME g_bgbj_d[l_ac].bgbj014,g_bgbj_d[l_ac].bgbj014_desc
            LET g_bgbj_d_o.* = g_bgbj_d[l_ac].*   #160822-00012#3 add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbj014_desc
            #add-point:ON CHANGE bgbj014_desc name="input.g.page1.bgbj014_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj015
            #add-point:BEFORE FIELD bgbj015 name="input.b.page1.bgbj015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj015
            
            #add-point:AFTER FIELD bgbj015 name="input.a.page1.bgbj015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbj015
            #add-point:ON CHANGE bgbj015 name="input.g.page1.bgbj015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj015_desc
            #add-point:BEFORE FIELD bgbj015_desc name="input.b.page1.bgbj015_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj015_desc
            
            #add-point:AFTER FIELD bgbj015_desc name="input.a.page1.bgbj015_desc"
       
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbj015_desc
            #add-point:ON CHANGE bgbj015_desc name="input.g.page1.bgbj015_desc"
            LET g_bgbj_d[l_ac].bgbj015 = g_bgbj_d[l_ac].bgbj015_desc 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj016
            #add-point:BEFORE FIELD bgbj016 name="input.b.page1.bgbj016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj016
            
            #add-point:AFTER FIELD bgbj016 name="input.a.page1.bgbj016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbj016
            #add-point:ON CHANGE bgbj016 name="input.g.page1.bgbj016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj016_desc
            #add-point:BEFORE FIELD bgbj016_desc name="input.b.page1.bgbj016_desc"
            LET g_bgbj_d[l_ac].bgbj016_desc = g_bgbj_d[l_ac].bgbj016
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj016_desc
            
            #add-point:AFTER FIELD bgbj016_desc name="input.a.page1.bgbj016_desc"
            #渠道
            IF NOT cl_null(g_bgbj_d[l_ac].bgbj016_desc) THEN
               #IF ( g_bgbj_d[l_ac].bgbj016_desc != g_bgbj_d_t.bgbj016_desc OR g_bgbj_d_t.bgbj016_desc IS NULL ) THEN #160822-00012#3 mark
               IF g_bgbj_d[l_ac].bgbj016_desc != g_bgbj_d_o.bgbj016_desc OR cl_null(g_bgbj_d_o.bgbj016_desc) THEN     #160822-00012#3 add
                  LET g_bgbj_d[l_ac].bgbj016 = g_bgbj_d[l_ac].bgbj016_desc
                  #IF g_glaa.glaa121 = 'N' THEN
                     CALL s_voucher_glaq052_chk(g_bgbj_d[l_ac].bgbj016) 
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        #LET g_bgbj_d[l_ac].bgbj016 = g_bgbj_d_t.bgbj016           #160822-00012#3 mark
                        #LET g_bgbj_d[l_ac].bgbj016_desc = g_bgbj_d_t.bgbj016_desc #160822-00012#3 mark
                        LET g_bgbj_d[l_ac].bgbj016 = g_bgbj_d_o.bgbj016            #160822-00012#3 add
                        LET g_bgbj_d[l_ac].bgbj016_desc = g_bgbj_d_o.bgbj016_desc  #160822-00012#3 add
                        DISPLAY BY NAME g_bgbj_d[l_ac].bgbj016,g_bgbj_d[l_ac].bgbj016_desc
                        NEXT FIELD CURRENT
                     END IF
                  #END IF
               END IF
            ELSE
               LET g_bgbj_d[l_ac].bgbj016 = ''
            END IF
            LET g_bgbj_d[l_ac].bgbj016_desc = s_desc_show1(g_bgbj_d[l_ac].bgbj016,s_desc_get_oojdl003_desc(g_bgbj_d[l_ac].bgbj016))
            DISPLAY BY NAME g_bgbj_d[l_ac].bgbj016,g_bgbj_d[l_ac].bgbj016_desc
            #LET g_bgbj_d_t.bgbj016_desc = g_bgbj_d[l_ac].bgbj016_desc
            LET g_bgbj_d_o.bgbj016_desc = g_bgbj_d[l_ac].bgbj016_desc
            LET g_bgbj_d_o.* = g_bgbj_d[l_ac].*   #160822-00012#3 add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbj016_desc
            #add-point:ON CHANGE bgbj016_desc name="input.g.page1.bgbj016_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj017
            #add-point:BEFORE FIELD bgbj017 name="input.b.page1.bgbj017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj017
            
            #add-point:AFTER FIELD bgbj017 name="input.a.page1.bgbj017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbj017
            #add-point:ON CHANGE bgbj017 name="input.g.page1.bgbj017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj017_desc
            #add-point:BEFORE FIELD bgbj017_desc name="input.b.page1.bgbj017_desc"
            LET g_bgbj_d[l_ac].bgbj017 = g_bgbj_d[l_ac].bgbj017_desc
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj017_desc
            
            #add-point:AFTER FIELD bgbj017_desc name="input.a.page1.bgbj017_desc"
            #品牌
            IF NOT cl_null(g_bgbj_d[l_ac].bgbj017_desc) THEN
               IF ( g_bgbj_d[l_ac].bgbj017_desc != g_bgbj_d_t.bgbj017_desc OR g_bgbj_d_t.bgbj017_desc IS NULL ) THEN
                  LET g_bgbj_d[l_ac].bgbj017 = g_bgbj_d[l_ac].bgbj017_desc
                  #IF g_glaa.glaa121 = 'N' THEN
                     IF NOT s_azzi650_chk_exist('2002',g_bgbj_d[l_ac].bgbj017) THEN
                        LET g_bgbj_d[l_ac].bgbj017      = g_bgbj_d_t.bgbj017
                        LET g_bgbj_d[l_ac].bgbj017_desc = g_bgbj_d_t.bgbj017_desc
                        DISPLAY BY NAME g_bgbj_d[l_ac].bgbj017 ,g_bgbj_d[l_ac].bgbj017_desc
                        NEXT FIELD CURRENT
                     END IF
                  #END IF
               END IF
            ELSE
               LET g_bgbj_d[l_ac].bgbj017 = ''
            END IF
            LET g_bgbj_d[l_ac].bgbj017_desc = s_desc_show1(g_bgbj_d[l_ac].bgbj017,s_desc_get_acc_desc('2002',g_bgbj_d[l_ac].bgbj017))
            DISPLAY BY NAME g_bgbj_d[l_ac].bgbj017 ,g_bgbj_d[l_ac].bgbj017_desc
            LET g_bgbj_d_t.bgbj017_desc = g_bgbj_d[l_ac].bgbj017_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbj017_desc
            #add-point:ON CHANGE bgbj017_desc name="input.g.page1.bgbj017_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj018
            #add-point:BEFORE FIELD bgbj018 name="input.b.page1.bgbj018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj018
            
            #add-point:AFTER FIELD bgbj018 name="input.a.page1.bgbj018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbj018
            #add-point:ON CHANGE bgbj018 name="input.g.page1.bgbj018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj018_desc
            #add-point:BEFORE FIELD bgbj018_desc name="input.b.page1.bgbj018_desc"
            #自由核算項一
            CALL s_fin_get_glae009(g_glad.glad0171) RETURNING l_glae009
            LET g_bgbj_d[l_ac].bgbj018_desc = g_bgbj_d[l_ac].bgbj018
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj018_desc
            
            #add-point:AFTER FIELD bgbj018_desc name="input.a.page1.bgbj018_desc"
            #自由核算項一
            IF NOT cl_null(g_bgbj_d[l_ac].bgbj018_desc) THEN
               IF (g_bgbj_d[l_ac].bgbj018_desc != g_bgbj_d_t.bgbj018_desc OR g_bgbj_d_t.bgbj018_desc IS NULL) THEN
                  LET g_bgbj_d[l_ac].bgbj018 = g_bgbj_d[l_ac].bgbj018_desc
                  #IF g_glaa.glaa121 = 'N' THEN
                     IF (g_bgbj_d[l_ac].bgbj018 != g_bgbj_d_t.bgbj018 OR g_bgbj_d_t.bgbj018 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0171,g_bgbj_d[l_ac].bgbj018,g_glad.glad0172) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.extend = ""
                           LET g_errparam.code   = g_errno
                           #160321-00016#23 --s add
                           LET g_errparam.replace[1] = 'agli041'
                           LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                           LET g_errparam.exeprog = 'agli041'
                           #160321-00016#23 --e add
                           LET g_errparam.popup  = TRUE
                           CALL cl_err()
                           LET g_bgbj_d[l_ac].bgbj018 = g_bgbj_d_t.bgbj018
                           LET g_bgbj_d[l_ac].bgbj018_desc = s_desc_show1(g_bgbj_d[l_ac].bgbj018,s_fin_get_accting_desc(g_glad.glad0171,g_bgbj_d[l_ac].bgbj018))
                           DISPLAY BY NAME g_bgbj_d[l_ac].bgbj018_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  #END IF
               END IF
            ELSE
               LET g_bgbj_d[l_ac].bgbj018 = ''
            END IF
            LET g_bgbj_d[l_ac].bgbj018_desc = s_desc_show1(g_bgbj_d[l_ac].bgbj018,s_fin_get_accting_desc(g_glad.glad0171,g_bgbj_d[l_ac].bgbj018))
            DISPLAY BY NAME g_bgbj_d[l_ac].bgbj018_desc
            LET g_bgbj_d_t.bgbj018_desc = g_bgbj_d[l_ac].bgbj018_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbj018_desc
            #add-point:ON CHANGE bgbj018_desc name="input.g.page1.bgbj018_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj019
            #add-point:BEFORE FIELD bgbj019 name="input.b.page1.bgbj019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj019
            
            #add-point:AFTER FIELD bgbj019 name="input.a.page1.bgbj019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbj019
            #add-point:ON CHANGE bgbj019 name="input.g.page1.bgbj019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj019_desc
            #add-point:BEFORE FIELD bgbj019_desc name="input.b.page1.bgbj019_desc"
            #自由核算項二
            CALL s_fin_get_glae009(g_glad.glad0181) RETURNING l_glae009
            LET g_bgbj_d[l_ac].bgbj019_desc = g_bgbj_d[l_ac].bgbj019
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj019_desc
            
            #add-point:AFTER FIELD bgbj019_desc name="input.a.page1.bgbj019_desc"
             #自由核算項二
            IF NOT cl_null(g_bgbj_d[l_ac].bgbj019_desc) THEN
               IF (g_bgbj_d[l_ac].bgbj019_desc != g_bgbj_d_t.bgbj019_desc OR g_bgbj_d_t.bgbj019_desc IS NULL) THEN
                  LET g_bgbj_d[l_ac].bgbj019 = g_bgbj_d[l_ac].bgbj019_desc
                  #IF g_glaa.glaa121 = 'N' THEN
                     IF (g_bgbj_d[l_ac].bgbj019 != g_bgbj_d_t.bgbj019 OR g_bgbj_d_t.bgbj019 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0181,g_bgbj_d[l_ac].bgbj019,g_glad.glad0182) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.extend = ""
                           LET g_errparam.code   = g_errno
                           #160321-00016#23 --s add
                           LET g_errparam.replace[1] = 'agli041'
                           LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                           LET g_errparam.exeprog = 'agli041'
                           #160321-00016#23 --e add
                           LET g_errparam.popup  = TRUE
                           CALL cl_err()
                           LET g_bgbj_d[l_ac].bgbj019 = g_bgbj_d_t.bgbj019
                           LET g_bgbj_d[l_ac].bgbj019_desc = s_desc_show1(g_bgbj_d[l_ac].bgbj019,s_fin_get_accting_desc(g_glad.glad0181,g_bgbj_d[l_ac].bgbj019))
                           DISPLAY BY NAME g_bgbj_d[l_ac].bgbj019_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  #END IF
               END IF
            ELSE
               LET g_bgbj_d[l_ac].bgbj019 = ''
            END IF
            LET g_bgbj_d[l_ac].bgbj019_desc = s_desc_show1(g_bgbj_d[l_ac].bgbj019,s_fin_get_accting_desc(g_glad.glad0181,g_bgbj_d[l_ac].bgbj019))
            DISPLAY BY NAME g_bgbj_d[l_ac].bgbj019_desc
            LET g_bgbj_d_t.bgbj019_desc = g_bgbj_d[l_ac].bgbj019_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbj019_desc
            #add-point:ON CHANGE bgbj019_desc name="input.g.page1.bgbj019_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj020
            #add-point:BEFORE FIELD bgbj020 name="input.b.page1.bgbj020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj020
            
            #add-point:AFTER FIELD bgbj020 name="input.a.page1.bgbj020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbj020
            #add-point:ON CHANGE bgbj020 name="input.g.page1.bgbj020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj020_desc
            #add-point:BEFORE FIELD bgbj020_desc name="input.b.page1.bgbj020_desc"
            #自由核算項三
            CALL s_fin_get_glae009(g_glad.glad0191) RETURNING l_glae009
            LET g_bgbj_d[l_ac].bgbj020_desc = g_bgbj_d[l_ac].bgbj020
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj020_desc
            
            #add-point:AFTER FIELD bgbj020_desc name="input.a.page1.bgbj020_desc"
            #自由核算項三
            IF NOT cl_null(g_bgbj_d[l_ac].bgbj020_desc) THEN
               IF (g_bgbj_d[l_ac].bgbj020_desc != g_bgbj_d_t.bgbj020_desc OR g_bgbj_d_t.bgbj020_desc IS NULL) THEN
                  LET g_bgbj_d[l_ac].bgbj020 = g_bgbj_d[l_ac].bgbj020_desc
                  #IF g_glaa.glaa121 = 'N' THEN
                     IF (g_bgbj_d[l_ac].bgbj020 != g_bgbj_d_t.bgbj020 OR g_bgbj_d_t.bgbj020 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0191,g_bgbj_d[l_ac].bgbj020,g_glad.glad0192) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.extend = ""
                           LET g_errparam.code   = g_errno
                           #160321-00016#23 --s add
                           LET g_errparam.replace[1] = 'agli041'
                           LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                           LET g_errparam.exeprog = 'agli041'
                           #160321-00016#23 --e add
                           LET g_errparam.popup  = TRUE
                           CALL cl_err()
                           LET g_bgbj_d[l_ac].bgbj020 = g_bgbj_d_t.bgbj020
                           LET g_bgbj_d[l_ac].bgbj020_desc = s_desc_show1(g_bgbj_d[l_ac].bgbj020,s_fin_get_accting_desc(g_glad.glad0191,g_bgbj_d[l_ac].bgbj020))
                           DISPLAY BY NAME g_bgbj_d[l_ac].bgbj020_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  #END IF
               END IF
            ELSE
               LET g_bgbj_d[l_ac].bgbj020 = ''
            END IF
            LET g_bgbj_d[l_ac].bgbj020_desc = s_desc_show1(g_bgbj_d[l_ac].bgbj020,s_fin_get_accting_desc(g_glad.glad0191,g_bgbj_d[l_ac].bgbj020))
            DISPLAY BY NAME g_bgbj_d[l_ac].bgbj020_desc
            LET g_bgbj_d_t.bgbj020_desc = g_bgbj_d[l_ac].bgbj020_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbj020_desc
            #add-point:ON CHANGE bgbj020_desc name="input.g.page1.bgbj020_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj021
            #add-point:BEFORE FIELD bgbj021 name="input.b.page1.bgbj021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj021
            
            #add-point:AFTER FIELD bgbj021 name="input.a.page1.bgbj021"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbj021
            #add-point:ON CHANGE bgbj021 name="input.g.page1.bgbj021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj021_desc
            #add-point:BEFORE FIELD bgbj021_desc name="input.b.page1.bgbj021_desc"
            #自由核算項四
            CALL s_fin_get_glae009(g_glad.glad0201) RETURNING l_glae009
            LET g_bgbj_d[l_ac].bgbj021_desc = g_bgbj_d[l_ac].bgbj021
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj021_desc
            
            #add-point:AFTER FIELD bgbj021_desc name="input.a.page1.bgbj021_desc"
            #自由核算項四
            IF NOT cl_null(g_bgbj_d[l_ac].bgbj021_desc) THEN
               IF (g_bgbj_d[l_ac].bgbj021_desc != g_bgbj_d_t.bgbj021_desc OR g_bgbj_d_t.bgbj021_desc IS NULL) THEN
                  LET g_bgbj_d[l_ac].bgbj021 = g_bgbj_d[l_ac].bgbj021_desc
                  #IF g_glaa.glaa121 = 'N' THEN
                     IF (g_bgbj_d[l_ac].bgbj021 != g_bgbj_d_t.bgbj021 OR g_bgbj_d_t.bgbj021 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0201,g_bgbj_d[l_ac].bgbj021,g_glad.glad0202) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.extend = ""
                           LET g_errparam.code   = g_errno
                           #160321-00016#23 --s add
                           LET g_errparam.replace[1] = 'agli041'
                           LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                           LET g_errparam.exeprog = 'agli041'
                           #160321-00016#23 --e add
                           LET g_errparam.popup  = TRUE
                           CALL cl_err()
                           LET g_bgbj_d[l_ac].bgbj021 = g_bgbj_d_t.bgbj021
                           LET g_bgbj_d[l_ac].bgbj021_desc = s_desc_show1(g_bgbj_d[l_ac].bgbj021,s_fin_get_accting_desc(g_glad.glad0201,g_bgbj_d[l_ac].bgbj021))
                           DISPLAY BY NAME g_bgbj_d[l_ac].bgbj021_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  #END IF
               END IF
            ELSE
               LET g_bgbj_d[l_ac].bgbj021 = ''
            END IF
            LET g_bgbj_d[l_ac].bgbj021_desc = s_desc_show1(g_bgbj_d[l_ac].bgbj021,s_fin_get_accting_desc(g_glad.glad0201,g_bgbj_d[l_ac].bgbj021))
            DISPLAY BY NAME g_bgbj_d[l_ac].bgbj021_desc
            LET g_bgbj_d_t.bgbj021_desc = g_bgbj_d[l_ac].bgbj021_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbj021_desc
            #add-point:ON CHANGE bgbj021_desc name="input.g.page1.bgbj021_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj022
            #add-point:BEFORE FIELD bgbj022 name="input.b.page1.bgbj022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj022
            
            #add-point:AFTER FIELD bgbj022 name="input.a.page1.bgbj022"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbj022
            #add-point:ON CHANGE bgbj022 name="input.g.page1.bgbj022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj022_desc
            #add-point:BEFORE FIELD bgbj022_desc name="input.b.page1.bgbj022_desc"
            #自由核算項五
            CALL s_fin_get_glae009(g_glad.glad0211) RETURNING l_glae009
            LET g_bgbj_d[l_ac].bgbj022_desc = g_bgbj_d[l_ac].bgbj022
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj022_desc
            
            #add-point:AFTER FIELD bgbj022_desc name="input.a.page1.bgbj022_desc"
            #自由核算項五
            IF NOT cl_null(g_bgbj_d[l_ac].bgbj022_desc) THEN
               IF (g_bgbj_d[l_ac].bgbj022_desc != g_bgbj_d_t.bgbj022_desc OR g_bgbj_d_t.bgbj022_desc IS NULL) THEN
                  LET g_bgbj_d[l_ac].bgbj022 = g_bgbj_d[l_ac].bgbj022_desc
                  #IF g_glaa.glaa121 = 'N' THEN
                     IF (g_bgbj_d[l_ac].bgbj022 != g_bgbj_d_t.bgbj022 OR g_bgbj_d_t.bgbj022 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0211,g_bgbj_d[l_ac].bgbj022,g_glad.glad0212) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.extend = ""
                           LET g_errparam.code   = g_errno
                           #160321-00016#23 --s add
                           LET g_errparam.replace[1] = 'agli041'
                           LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                           LET g_errparam.exeprog = 'agli041'
                           #160321-00016#23 --e add
                           LET g_errparam.popup  = TRUE
                           CALL cl_err()
                           LET g_bgbj_d[l_ac].bgbj022 = g_bgbj_d_t.bgbj022
                           LET g_bgbj_d[l_ac].bgbj022_desc = s_desc_show1(g_bgbj_d[l_ac].bgbj022,s_fin_get_accting_desc(g_glad.glad0211,g_bgbj_d[l_ac].bgbj022))
                           DISPLAY BY NAME g_bgbj_d[l_ac].bgbj022_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  #END IF
               END IF
            ELSE
               LET g_bgbj_d[l_ac].bgbj022 = ''
            END IF
            LET g_bgbj_d[l_ac].bgbj022_desc = s_desc_show1(g_bgbj_d[l_ac].bgbj022,s_fin_get_accting_desc(g_glad.glad0211,g_bgbj_d[l_ac].bgbj022))
            DISPLAY BY NAME g_bgbj_d[l_ac].bgbj022_desc
            LET g_bgbj_d_t.bgbj022_desc = g_bgbj_d[l_ac].bgbj022_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbj022_desc
            #add-point:ON CHANGE bgbj022_desc name="input.g.page1.bgbj022_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj023
            #add-point:BEFORE FIELD bgbj023 name="input.b.page1.bgbj023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj023
            
            #add-point:AFTER FIELD bgbj023 name="input.a.page1.bgbj023"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbj023
            #add-point:ON CHANGE bgbj023 name="input.g.page1.bgbj023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj023_desc
            #add-point:BEFORE FIELD bgbj023_desc name="input.b.page1.bgbj023_desc"
             #自由核算項六
            CALL s_fin_get_glae009(g_glad.glad0221) RETURNING l_glae009
            LET g_bgbj_d[l_ac].bgbj023_desc = g_bgbj_d[l_ac].bgbj023
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj023_desc
            
            #add-point:AFTER FIELD bgbj023_desc name="input.a.page1.bgbj023_desc"
            #自由核算項六
            IF NOT cl_null(g_bgbj_d[l_ac].bgbj023_desc) THEN
               IF (g_bgbj_d[l_ac].bgbj023_desc != g_bgbj_d_t.bgbj023_desc OR g_bgbj_d_t.bgbj023_desc IS NULL) THEN
                  LET g_bgbj_d[l_ac].bgbj023 = g_bgbj_d[l_ac].bgbj023_desc
                  #IF g_glaa.glaa121 = 'N' THEN
                     IF (g_bgbj_d[l_ac].bgbj023 != g_bgbj_d_t.bgbj023 OR g_bgbj_d_t.bgbj023 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0221,g_bgbj_d[l_ac].bgbj023,g_glad.glad0222) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.extend = ""
                           LET g_errparam.code   = g_errno
                           #160321-00016#23 --s add
                           LET g_errparam.replace[1] = 'agli041'
                           LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                           LET g_errparam.exeprog = 'agli041'
                           #160321-00016#23 --e add
                           LET g_errparam.popup  = TRUE
                           CALL cl_err()
                           LET g_bgbj_d[l_ac].bgbj023 = g_bgbj_d_t.bgbj023
                           LET g_bgbj_d[l_ac].bgbj023_desc = s_desc_show1(g_bgbj_d[l_ac].bgbj023,s_fin_get_accting_desc(g_glad.glad0221,g_bgbj_d[l_ac].bgbj023))
                           DISPLAY BY NAME g_bgbj_d[l_ac].bgbj023_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  #END IF
               END IF
            ELSE
               LET g_bgbj_d[l_ac].bgbj023 = ''
            END IF
            LET g_bgbj_d[l_ac].bgbj023_desc = s_desc_show1(g_bgbj_d[l_ac].bgbj023,s_fin_get_accting_desc(g_glad.glad0221,g_bgbj_d[l_ac].bgbj023))
            DISPLAY BY NAME g_bgbj_d[l_ac].bgbj023_desc
            LET g_bgbj_d_t.bgbj023_desc = g_bgbj_d[l_ac].bgbj023_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbj023_desc
            #add-point:ON CHANGE bgbj023_desc name="input.g.page1.bgbj023_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj024
            #add-point:BEFORE FIELD bgbj024 name="input.b.page1.bgbj024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj024
            
            #add-point:AFTER FIELD bgbj024 name="input.a.page1.bgbj024"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbj024
            #add-point:ON CHANGE bgbj024 name="input.g.page1.bgbj024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj024_desc
            #add-point:BEFORE FIELD bgbj024_desc name="input.b.page1.bgbj024_desc"
            #自由核算項七
            CALL s_fin_get_glae009(g_glad.glad0231) RETURNING l_glae009
            LET g_bgbj_d[l_ac].bgbj024_desc = g_bgbj_d[l_ac].bgbj024
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj024_desc
            
            #add-point:AFTER FIELD bgbj024_desc name="input.a.page1.bgbj024_desc"
            #自由核算項七
            IF NOT cl_null(g_bgbj_d[l_ac].bgbj024_desc) THEN
               IF (g_bgbj_d[l_ac].bgbj024_desc != g_bgbj_d_t.bgbj024_desc OR g_bgbj_d_t.bgbj024_desc IS NULL) THEN
                  LET g_bgbj_d[l_ac].bgbj024 = g_bgbj_d[l_ac].bgbj024_desc
                  #IF g_glaa.glaa121 = 'N' THEN
                     IF (g_bgbj_d[l_ac].bgbj024 != g_bgbj_d_t.bgbj024 OR g_bgbj_d_t.bgbj024 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0231,g_bgbj_d[l_ac].bgbj024,g_glad.glad0232) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.extend = ""
                           LET g_errparam.code   = g_errno
                           #160321-00016#23 --s add
                           LET g_errparam.replace[1] = 'agli041'
                           LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                           LET g_errparam.exeprog = 'agli041'
                           #160321-00016#23 --e add
                           LET g_errparam.popup  = TRUE
                           CALL cl_err()
                           LET g_bgbj_d[l_ac].bgbj024 = g_bgbj_d_t.bgbj024
                           LET g_bgbj_d[l_ac].bgbj024_desc = s_desc_show1(g_bgbj_d[l_ac].bgbj024,s_fin_get_accting_desc(g_glad.glad0231,g_bgbj_d[l_ac].bgbj024))
                           DISPLAY BY NAME g_bgbj_d[l_ac].bgbj024_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  #END IF
               END IF
            ELSE
               LET g_bgbj_d[l_ac].bgbj024 = ''
            END IF
            LET g_bgbj_d[l_ac].bgbj024_desc = s_desc_show1(g_bgbj_d[l_ac].bgbj024,s_fin_get_accting_desc(g_glad.glad0231,g_bgbj_d[l_ac].bgbj024))
            DISPLAY BY NAME g_bgbj_d[l_ac].bgbj024_desc
            LET g_bgbj_d_t.bgbj024_desc = g_bgbj_d[l_ac].bgbj024_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbj024_desc
            #add-point:ON CHANGE bgbj024_desc name="input.g.page1.bgbj024_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj025
            #add-point:BEFORE FIELD bgbj025 name="input.b.page1.bgbj025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj025
            
            #add-point:AFTER FIELD bgbj025 name="input.a.page1.bgbj025"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbj025
            #add-point:ON CHANGE bgbj025 name="input.g.page1.bgbj025"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj025_desc
            #add-point:BEFORE FIELD bgbj025_desc name="input.b.page1.bgbj025_desc"
            #自由核算項八
            CALL s_fin_get_glae009(g_glad.glad0241) RETURNING l_glae009
            LET g_bgbj_d[l_ac].bgbj025_desc = g_bgbj_d[l_ac].bgbj025
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj025_desc
            
            #add-point:AFTER FIELD bgbj025_desc name="input.a.page1.bgbj025_desc"
            #自由核算項八
            IF NOT cl_null(g_bgbj_d[l_ac].bgbj025_desc) THEN
               IF (g_bgbj_d[l_ac].bgbj025_desc != g_bgbj_d_t.bgbj025_desc OR g_bgbj_d_t.bgbj025_desc IS NULL) THEN
                  LET g_bgbj_d[l_ac].bgbj025 = g_bgbj_d[l_ac].bgbj025_desc
                  #IF g_glaa.glaa121 = 'N' THEN
                     IF (g_bgbj_d[l_ac].bgbj025 != g_bgbj_d_t.bgbj025 OR g_bgbj_d_t.bgbj025 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0241,g_bgbj_d[l_ac].bgbj025,g_glad.glad0242) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.extend = ""
                           LET g_errparam.code   = g_errno
                           #160321-00016#23 --s add
                           LET g_errparam.replace[1] = 'agli041'
                           LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                           LET g_errparam.exeprog = 'agli041'
                           #160321-00016#23 --e add
                           LET g_errparam.popup  = TRUE
                           CALL cl_err()
                           LET g_bgbj_d[l_ac].bgbj025 = g_bgbj_d_t.bgbj025
                           LET g_bgbj_d[l_ac].bgbj025_desc = s_desc_show1(g_bgbj_d[l_ac].bgbj025,s_fin_get_accting_desc(g_glad.glad0241,g_bgbj_d[l_ac].bgbj025))
                           DISPLAY BY NAME g_bgbj_d[l_ac].bgbj025_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  #END IF
               END IF
            ELSE
               LET g_bgbj_d[l_ac].bgbj025 = ''
            END IF
            LET g_bgbj_d[l_ac].bgbj025_desc = s_desc_show1(g_bgbj_d[l_ac].bgbj025,s_fin_get_accting_desc(g_glad.glad0241,g_bgbj_d[l_ac].bgbj025))
            DISPLAY BY NAME g_bgbj_d[l_ac].bgbj025_desc
            LET g_bgbj_d_t.bgbj025_desc = g_bgbj_d[l_ac].bgbj025_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbj025_desc
            #add-point:ON CHANGE bgbj025_desc name="input.g.page1.bgbj025_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj026
            #add-point:BEFORE FIELD bgbj026 name="input.b.page1.bgbj026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj026
            
            #add-point:AFTER FIELD bgbj026 name="input.a.page1.bgbj026"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbj026
            #add-point:ON CHANGE bgbj026 name="input.g.page1.bgbj026"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj026_desc
            #add-point:BEFORE FIELD bgbj026_desc name="input.b.page1.bgbj026_desc"
            #自由核算項九
            CALL s_fin_get_glae009(g_glad.glad0251) RETURNING l_glae009
            LET g_bgbj_d[l_ac].bgbj026_desc = g_bgbj_d[l_ac].bgbj026
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj026_desc
            
            #add-point:AFTER FIELD bgbj026_desc name="input.a.page1.bgbj026_desc"
            #自由核算項九
            IF NOT cl_null(g_bgbj_d[l_ac].bgbj026_desc) THEN
               IF (g_bgbj_d[l_ac].bgbj026_desc != g_bgbj_d_t.bgbj026_desc OR g_bgbj_d_t.bgbj026_desc IS NULL) THEN
                  LET g_bgbj_d[l_ac].bgbj026 = g_bgbj_d[l_ac].bgbj026_desc
                  #IF g_glaa.glaa121 = 'N' THEN
                     IF (g_bgbj_d[l_ac].bgbj026 != g_bgbj_d_t.bgbj026 OR g_bgbj_d_t.bgbj026 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0251,g_bgbj_d[l_ac].bgbj026,g_glad.glad0252) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.extend = ""
                           LET g_errparam.code   = g_errno
                           #160321-00016#23 --s add
                           LET g_errparam.replace[1] = 'agli041'
                           LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                           LET g_errparam.exeprog = 'agli041'
                           #160321-00016#23 --e add
                           LET g_errparam.popup  = TRUE
                           CALL cl_err()
                           LET g_bgbj_d[l_ac].bgbj026 = g_bgbj_d_t.bgbj026
                           LET g_bgbj_d[l_ac].bgbj026_desc = s_desc_show1(g_bgbj_d[l_ac].bgbj026,s_fin_get_accting_desc(g_glad.glad0251,g_bgbj_d[l_ac].bgbj026))
                           DISPLAY BY NAME g_bgbj_d[l_ac].bgbj026_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  #END IF
               END IF
            ELSE
               LET g_bgbj_d[l_ac].bgbj026 = ''
            END IF
            LET g_bgbj_d[l_ac].bgbj026_desc = s_desc_show1(g_bgbj_d[l_ac].bgbj026,s_fin_get_accting_desc(g_glad.glad0251,g_bgbj_d[l_ac].bgbj026))
            DISPLAY BY NAME g_bgbj_d[l_ac].bgbj026_desc
            LET g_bgbj_d_t.bgbj026_desc = g_bgbj_d[l_ac].bgbj026_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbj026_desc
            #add-point:ON CHANGE bgbj026_desc name="input.g.page1.bgbj026_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj027
            #add-point:BEFORE FIELD bgbj027 name="input.b.page1.bgbj027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj027
            
            #add-point:AFTER FIELD bgbj027 name="input.a.page1.bgbj027"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbj027
            #add-point:ON CHANGE bgbj027 name="input.g.page1.bgbj027"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj027_desc
            #add-point:BEFORE FIELD bgbj027_desc name="input.b.page1.bgbj027_desc"
             #自由核算項十
            CALL s_fin_get_glae009(g_glad.glad0261) RETURNING l_glae009
            LET g_bgbj_d[l_ac].bgbj027_desc = g_bgbj_d[l_ac].bgbj027
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj027_desc
            
            #add-point:AFTER FIELD bgbj027_desc name="input.a.page1.bgbj027_desc"
            #自由核算項十
            IF NOT cl_null(g_bgbj_d[l_ac].bgbj027_desc) THEN
               IF (g_bgbj_d[l_ac].bgbj027_desc != g_bgbj_d_t.bgbj027_desc OR g_bgbj_d_t.bgbj027_desc IS NULL) THEN
                  LET g_bgbj_d[l_ac].bgbj027 = g_bgbj_d[l_ac].bgbj027_desc
                  #IF g_glaa.glaa121 = 'N' THEN
                     IF (g_bgbj_d[l_ac].bgbj027 != g_bgbj_d_t.bgbj027 OR g_bgbj_d_t.bgbj027 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0261,g_bgbj_d[l_ac].bgbj027,g_glad.glad0262) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.extend = ""
                           LET g_errparam.code   = g_errno
                           #160321-00016#23 --s add
                           LET g_errparam.replace[1] = 'agli041'
                           LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                           LET g_errparam.exeprog = 'agli041'
                           #160321-00016#23 --e add
                           LET g_errparam.popup  = TRUE
                           CALL cl_err()
                           LET g_bgbj_d[l_ac].bgbj027 = g_bgbj_d_t.bgbj027
                           LET g_bgbj_d[l_ac].bgbj027_desc = s_desc_show1(g_bgbj_d[l_ac].bgbj027,s_fin_get_accting_desc(g_glad.glad0261,g_bgbj_d[l_ac].bgbj027))
                           DISPLAY BY NAME g_bgbj_d[l_ac].bgbj027_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  #END IF
               END IF
            ELSE
               LET g_bgbj_d[l_ac].bgbj027 = ''
            END IF
            LET g_bgbj_d[l_ac].bgbj027_desc = s_desc_show1(g_bgbj_d[l_ac].bgbj027,s_fin_get_accting_desc(g_glad.glad0261,g_bgbj_d[l_ac].bgbj027))
            DISPLAY BY NAME g_bgbj_d[l_ac].bgbj027_desc
            LET g_bgbj_d_t.bgbj027_desc = g_bgbj_d[l_ac].bgbj027_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbj027_desc
            #add-point:ON CHANGE bgbj027_desc name="input.g.page1.bgbj027_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj028
            #add-point:BEFORE FIELD bgbj028 name="input.b.page1.bgbj028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj028
            
            #add-point:AFTER FIELD bgbj028 name="input.a.page1.bgbj028"
            IF NOT cl_null(g_bgbj_d[l_ac].bgbj028) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_bgbj_d[l_ac].bgbj028 != g_bgbj_d_t.bgbj028  OR g_bgbj_d_t.bgbj028 IS NULL )) THEN #160822-00012#3 mark
               IF g_bgbj_d[l_ac].bgbj028 != g_bgbj_d_o.bgbj028  OR cl_null(g_bgbj_d_o.bgbj028) THEN #160822-00012#3 add
                  CALL s_aap_ooaj001_chk(g_glaald,g_bgbj_d[l_ac].bgbj028) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     #160321-00016#23 --s add
                     LET g_errparam.replace[1] = 'aooi150'
                     LET g_errparam.replace[2] = cl_get_progname('aooi150',g_lang,"2")
                     LET g_errparam.exeprog = 'aooi150'
                     #160321-00016#23 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_bgbj_d[l_ac].bgbj028 = g_bgbj_d_t.bgbj028 #160822-00012#3 mark
                     LET g_bgbj_d[l_ac].bgbj028 = g_bgbj_d_o.bgbj028  #160822-00012#3 add
                     NEXT FIELD CURRENT
                  END IF

                  CALL abgt040_get_rate()RETURNING g_bgbj_d[l_ac].bgbj031
                  DISPLAY BY NAME g_bgbj_d[l_ac].bgbj031
               END IF
            END IF
            LET g_bgbj_d_o.* = g_bgbj_d[l_ac].*  #BACKUP #160822-00012#3 add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbj028
            #add-point:ON CHANGE bgbj028 name="input.g.page1.bgbj028"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj029
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_bgbj_d[l_ac].bgbj029,"0","0","","","azz-00079",1) THEN
               NEXT FIELD bgbj029
            END IF 
 
 
 
            #add-point:AFTER FIELD bgbj029 name="input.a.page1.bgbj029"
            IF NOT cl_null(g_bgbj_d[l_ac].bgbj029)AND NOT cl_null(g_bgbj_d[l_ac].bgbj030) 
               AND NOT cl_null(g_bgbj_d[l_ac].bgbj031) THEN                
               CALL abgt040_amt()
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj029
            #add-point:BEFORE FIELD bgbj029 name="input.b.page1.bgbj029"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbj029
            #add-point:ON CHANGE bgbj029 name="input.g.page1.bgbj029"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj030
            #add-point:BEFORE FIELD bgbj030 name="input.b.page1.bgbj030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj030
            
            #add-point:AFTER FIELD bgbj030 name="input.a.page1.bgbj030"
            IF NOT cl_null(g_bgbj_d[l_ac].bgbj029)AND NOT cl_null(g_bgbj_d[l_ac].bgbj030) 
               AND NOT cl_null(g_bgbj_d[l_ac].bgbj031) THEN                
               CALL abgt040_amt()
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbj030
            #add-point:ON CHANGE bgbj030 name="input.g.page1.bgbj030"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbj031
            #add-point:BEFORE FIELD bgbj031 name="input.b.page1.bgbj031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbj031
            
            #add-point:AFTER FIELD bgbj031 name="input.a.page1.bgbj031"
            IF NOT cl_null(g_bgbj_d[l_ac].bgbj031) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_bgbj_d[l_ac].bgbj031 != g_bgbj_d_t.bgbj031  OR g_bgbj_d_t.bgbj031 IS NULL )) THEN
                  IF g_bgbj_d[l_ac].bgbj028 = g_bgbj_m.bgaa003 AND g_bgbj_d[l_ac].bgbj031 !=1 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'abg-00107'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgbj_d[l_ac].bgbj031 = 1
                     NEXT FIELD CURRENT
                  END IF
                  DISPLAY BY NAME g_bgbj_d[l_ac].bgbj031
               END IF
            END IF                       
            IF NOT cl_null(g_bgbj_d[l_ac].bgbj029)AND NOT cl_null(g_bgbj_d[l_ac].bgbj030) 
               AND NOT cl_null(g_bgbj_d[l_ac].bgbj031) THEN                
               CALL abgt040_amt()
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbj031
            #add-point:ON CHANGE bgbj031 name="input.g.page1.bgbj031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbjstus
            #add-point:BEFORE FIELD bgbjstus name="input.b.page1.bgbjstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbjstus
            
            #add-point:AFTER FIELD bgbjstus name="input.a.page1.bgbjstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbjstus
            #add-point:ON CHANGE bgbjstus name="input.g.page1.bgbjstus"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.bgbjseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbjseq
            #add-point:ON ACTION controlp INFIELD bgbjseq name="input.c.page1.bgbjseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbj003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj003
            #add-point:ON ACTION controlp INFIELD bgbj003 name="input.c.page1.bgbj003"
            IF g_bgaa012 = 'Y' THEN
               #抓取會計科目
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_bgbj_d[l_ac].bgbj003
               LET g_qryparam.where = "glac001 = '",g_glaa004,"' AND  glac003 <>'1' "               #glac001(會計科目參照表)/glac003(科>
               CALL aglt310_04()
               LET g_bgbj_d[l_ac].bgbj003 = g_qryparam.return1
               DISPLAY BY NAME g_bgbj_d[l_ac].bgbj003
               NEXT FIELD bgbj003
            ELSE
               #抓取預算項目
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_bgbj_d[l_ac].bgbj003  #給予default值
               LET g_qryparam.where = " bgae006 IN (SELECT bgaa008 FROM bgaa_t WHERE bgaaent = ",g_enterprise," ",
                                                     " AND bgaa001 = '",g_bgbj_m.bgbj001,"' ) ",  #存在預算編號的預算項目參照表
                                       " AND bgae007 = '1' " 

               CALL q_bgae001()
               LET g_bgbj_d[l_ac].bgbj003 = g_qryparam.return1
               DISPLAY BY NAME g_bgbj_d[l_ac].bgbj003
               NEXT FIELD bgbj003
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbj004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj004
            #add-point:ON ACTION controlp INFIELD bgbj004 name="input.c.page1.bgbj004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbj005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj005
            #add-point:ON ACTION controlp INFIELD bgbj005 name="input.c.page1.bgbj005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbj005_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj005_desc
            #add-point:ON ACTION controlp INFIELD bgbj005_desc name="input.c.page1.bgbj005_desc"
            #部門
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgbj_d[l_ac].bgbj005
            LET g_qryparam.arg1 = g_today    #應以單據日期
            CALL q_ooeg001_4()
            LET g_bgbj_d[l_ac].bgbj005 = g_qryparam.return1
            LET g_bgbj_d[l_ac].bgbj005_desc = g_qryparam.return1
            DISPLAY BY NAME g_bgbj_d[l_ac].bgbj005,g_bgbj_d[l_ac].bgbj005_desc
            NEXT FIELD bgbj005_desc
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbj006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj006
            #add-point:ON ACTION controlp INFIELD bgbj006 name="input.c.page1.bgbj006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbj006_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj006_desc
            #add-point:ON ACTION controlp INFIELD bgbj006_desc name="input.c.page1.bgbj006_desc"
            #責任中心
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 =  g_bgbj_d[l_ac].bgbj006
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001_5()
            LET g_bgbj_d[l_ac].bgbj006 = g_qryparam.return1
            LET g_bgbj_d[l_ac].bgbj006_desc = g_qryparam.return1
            DISPLAY BY NAME g_bgbj_d[l_ac].bgbj006,g_bgbj_d[l_ac].bgbj006_desc
            NEXT FIELD bgbj006_desc
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbj007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj007
            #add-point:ON ACTION controlp INFIELD bgbj007 name="input.c.page1.bgbj007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbj007_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj007_desc
            #add-point:ON ACTION controlp INFIELD bgbj007_desc name="input.c.page1.bgbj007_desc"
            #區域
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgbj_d[l_ac].bgbj007
            CALL q_oocq002_287()
            LET g_bgbj_d[l_ac].bgbj007 = g_qryparam.return1
            LET g_bgbj_d[l_ac].bgbj007_desc = g_qryparam.return1
            DISPLAY BY NAME g_bgbj_d[l_ac].bgbj007,g_bgbj_d[l_ac].bgbj007_desc
            NEXT FIELD bgbj007_desc
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbj008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj008
            #add-point:ON ACTION controlp INFIELD bgbj008 name="input.c.page1.bgbj008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbj008_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj008_desc
            #add-point:ON ACTION controlp INFIELD bgbj008_desc name="input.c.page1.bgbj008_desc"
            #交易客商
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgbj_d[l_ac].bgbj008
            #LET g_qryparam.where = "pmaa002 IN ('2','3')"  #160920-00019#4--mark
            #CALL q_pmaa001()    #160920-00019#4--mark
            CALL q_pmaa001_25()  #160920-00019#4--add
            LET g_bgbj_d[l_ac].bgbj008 = g_qryparam.return1
            LET g_bgbj_d[l_ac].bgbj008_desc = g_qryparam.return1
            DISPLAY BY NAME g_bgbj_d[l_ac].bgbj008 ,g_bgbj_d[l_ac].bgbj008_desc
            NEXT FIELD bgbj008_desc
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbj009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj009
            #add-point:ON ACTION controlp INFIELD bgbj009 name="input.c.page1.bgbj009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbj009_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj009_desc
            #add-point:ON ACTION controlp INFIELD bgbj009_desc name="input.c.page1.bgbj009_desc"
             #收款客商
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgbj_d[l_ac].bgbj009
            #LET g_qryparam.where = "pmaa002 IN ('2','3')"  #160920-00019#4--mark
            #CALL q_pmaa001()    #160920-00019#4--mark
            CALL q_pmaa001_25()  #160920-00019#4--add
            LET g_bgbj_d[l_ac].bgbj009 = g_qryparam.return1
            LET g_bgbj_d[l_ac].bgbj009_desc = g_qryparam.return1
            DISPLAY BY NAME g_bgbj_d[l_ac].bgbj009 ,g_bgbj_d[l_ac].bgbj009_desc
            NEXT FIELD bgbj009_desc
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbj010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj010
            #add-point:ON ACTION controlp INFIELD bgbj010 name="input.c.page1.bgbj010"
   
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbj010_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj010_desc
            #add-point:ON ACTION controlp INFIELD bgbj010_desc name="input.c.page1.bgbj010_desc"
             #客群
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
              LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgbj_d[l_ac].bgbj010
            CALL q_oocq002_281()
            LET g_bgbj_d[l_ac].bgbj010 = g_qryparam.return1
            LET g_bgbj_d[l_ac].bgbj010_desc = g_qryparam.return1
            DISPLAY BY NAME g_bgbj_d[l_ac].bgbj010,g_bgbj_d[l_ac].bgbj010_desc
            NEXT FIELD bgbj010_desc
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbj011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj011
            #add-point:ON ACTION controlp INFIELD bgbj011 name="input.c.page1.bgbj011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbj011_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj011_desc
            #add-point:ON ACTION controlp INFIELD bgbj011_desc name="input.c.page1.bgbj011_desc"
            #產品類別
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgbj_d[l_ac].bgbj011
            CALL q_rtax001()
            LET g_bgbj_d[l_ac].bgbj011 = g_qryparam.return1
            LET g_bgbj_d[l_ac].bgbj011_desc = g_qryparam.return1
            DISPLAY BY NAME  g_bgbj_d[l_ac].bgbj011,g_bgbj_d[l_ac].bgbj011_desc
            NEXT FIELD bgbj011_desc
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbj012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj012
            #add-point:ON ACTION controlp INFIELD bgbj012 name="input.c.page1.bgbj012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbj012_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj012_desc
            #add-point:ON ACTION controlp INFIELD bgbj012_desc name="input.c.page1.bgbj012_desc"
            #人員
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgbj_d[l_ac].bgbj012
            CALL q_ooag001_8()
            LET g_bgbj_d[l_ac].bgbj012 = g_qryparam.return1
            LET g_bgbj_d[l_ac].bgbj012_desc = g_qryparam.return1
            DISPLAY BY NAME g_bgbj_d[l_ac].bgbj012,g_bgbj_d[l_ac].bgbj012_desc
            NEXT FIELD bgbj012_desc
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbj013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj013
            #add-point:ON ACTION controlp INFIELD bgbj013 name="input.c.page1.bgbj013"
           
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbj013_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj013_desc
            #add-point:ON ACTION controlp INFIELD bgbj013_desc name="input.c.page1.bgbj013_desc"
            #專案代號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgbj_d[l_ac].bgbj013
            CALL q_pjba001()
            LET g_bgbj_d[l_ac].bgbj013 = g_qryparam.return1
            LET g_bgbj_d[l_ac].bgbj013_desc = g_qryparam.return1
            DISPLAY BY NAME g_bgbj_d[l_ac].bgbj013,g_bgbj_d[l_ac].bgbj013_desc
            NEXT FIELD bgbj013_desc
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbj014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj014
            #add-point:ON ACTION controlp INFIELD bgbj014 name="input.c.page1.bgbj014"
           
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbj014_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj014_desc
            #add-point:ON ACTION controlp INFIELD bgbj014_desc name="input.c.page1.bgbj014_desc"
            #WBS
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgbj_d[l_ac].bgbj014

            IF NOT cl_null(g_bgbj_d[l_ac].bgbj013) THEN
               LET g_qryparam.where = "pjbb012='1' AND pjbb001='",g_bgbj_d[l_ac].bgbj013,"'"
            ELSE
               LET g_qryparam.where = "pjbb012='1'"
            END IF

            CALL q_pjbb002()
            LET g_bgbj_d[l_ac].bgbj014 = g_qryparam.return1
            LET g_bgbj_d[l_ac].bgbj014_desc = g_qryparam.return1
            DISPLAY BY NAME g_bgbj_d[l_ac].bgbj014,g_bgbj_d[l_ac].bgbj014_desc
            NEXT FIELD bgbj014_desc
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbj015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj015
            #add-point:ON ACTION controlp INFIELD bgbj015 name="input.c.page1.bgbj015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbj015_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj015_desc
            #add-point:ON ACTION controlp INFIELD bgbj015_desc name="input.c.page1.bgbj015_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbj016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj016
            #add-point:ON ACTION controlp INFIELD bgbj016 name="input.c.page1.bgbj016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbj016_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj016_desc
            #add-point:ON ACTION controlp INFIELD bgbj016_desc name="input.c.page1.bgbj016_desc"
            #渠道
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgbj_d[l_ac].bgbj016
            CALL q_oojd001_2()
            LET g_bgbj_d[l_ac].bgbj016 = g_qryparam.return1
            LET g_bgbj_d[l_ac].bgbj016_desc = g_qryparam.return1
            DISPLAY BY NAME g_bgbj_d[l_ac].bgbj016,g_bgbj_d[l_ac].bgbj016_desc
            NEXT FIELD bgbj016_desc
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbj017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj017
            #add-point:ON ACTION controlp INFIELD bgbj017 name="input.c.page1.bgbj017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbj017_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj017_desc
            #add-point:ON ACTION controlp INFIELD bgbj017_desc name="input.c.page1.bgbj017_desc"
             #品牌
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgbj_d[l_ac].bgbj017
            CALL q_oocq002_2002()
            LET g_bgbj_d[l_ac].bgbj017 = g_qryparam.return1
            LET g_bgbj_d[l_ac].bgbj017_desc = g_qryparam.return1
            DISPLAY BY NAME g_bgbj_d[l_ac].bgbj017,g_bgbj_d[l_ac].bgbj017_desc
            NEXT FIELD bgbj017_desc
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbj018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj018
            #add-point:ON ACTION controlp INFIELD bgbj018 name="input.c.page1.bgbj018"
           
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbj018_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj018_desc
            #add-point:ON ACTION controlp INFIELD bgbj018_desc name="input.c.page1.bgbj018_desc"
            #自由核算項一
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_bgbj_d[l_ac].bgbj018
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0171,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_bgbj_d[l_ac].bgbj018 = g_qryparam.return1
               LET g_bgbj_d[l_ac].bgbj018_desc = g_qryparam.return1
               DISPLAY BY NAME g_bgbj_d[l_ac].bgbj018,g_bgbj_d[l_ac].bgbj018_desc
               NEXT FIELD bgbj018_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbj019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj019
            #add-point:ON ACTION controlp INFIELD bgbj019 name="input.c.page1.bgbj019"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbj019_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj019_desc
            #add-point:ON ACTION controlp INFIELD bgbj019_desc name="input.c.page1.bgbj019_desc"
            #自由核算項二
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_bgbj_d[l_ac].bgbj019
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0181,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_bgbj_d[l_ac].bgbj019 = g_qryparam.return1
               LET g_bgbj_d[l_ac].bgbj019_desc = g_qryparam.return1
               DISPLAY BY NAME g_bgbj_d[l_ac].bgbj019,g_bgbj_d[l_ac].bgbj019_desc
               NEXT FIELD bgbj019_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbj020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj020
            #add-point:ON ACTION controlp INFIELD bgbj020 name="input.c.page1.bgbj020"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbj020_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj020_desc
            #add-point:ON ACTION controlp INFIELD bgbj020_desc name="input.c.page1.bgbj020_desc"
            #自由核算項三
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_bgbj_d[l_ac].bgbj020
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0191,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_bgbj_d[l_ac].bgbj020 = g_qryparam.return1
               LET g_bgbj_d[l_ac].bgbj020_desc = g_qryparam.return1
               DISPLAY BY NAME g_bgbj_d[l_ac].bgbj020,g_bgbj_d[l_ac].bgbj020_desc
               NEXT FIELD bgbj020_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbj021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj021
            #add-point:ON ACTION controlp INFIELD bgbj021 name="input.c.page1.bgbj021"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbj021_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj021_desc
            #add-point:ON ACTION controlp INFIELD bgbj021_desc name="input.c.page1.bgbj021_desc"
            #自由核算項四
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_bgbj_d[l_ac].bgbj021
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0201,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_bgbj_d[l_ac].bgbj021 = g_qryparam.return1
               LET g_bgbj_d[l_ac].bgbj021_desc = g_qryparam.return1
               DISPLAY BY NAME g_bgbj_d[l_ac].bgbj021,g_bgbj_d[l_ac].bgbj021_desc
               NEXT FIELD bgbj021_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbj022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj022
            #add-point:ON ACTION controlp INFIELD bgbj022 name="input.c.page1.bgbj022"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbj022_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj022_desc
            #add-point:ON ACTION controlp INFIELD bgbj022_desc name="input.c.page1.bgbj022_desc"
            #自由核算項五
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_bgbj_d[l_ac].bgbj022
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0211,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_bgbj_d[l_ac].bgbj022 = g_qryparam.return1
               LET g_bgbj_d[l_ac].bgbj022_desc = g_qryparam.return1
               DISPLAY BY NAME g_bgbj_d[l_ac].bgbj022,g_bgbj_d[l_ac].bgbj022_desc
               NEXT FIELD bgbj022_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbj023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj023
            #add-point:ON ACTION controlp INFIELD bgbj023 name="input.c.page1.bgbj023"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbj023_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj023_desc
            #add-point:ON ACTION controlp INFIELD bgbj023_desc name="input.c.page1.bgbj023_desc"
            #自由核算項六
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_bgbj_d[l_ac].bgbj023
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0221,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_bgbj_d[l_ac].bgbj023 = g_qryparam.return1
               LET g_bgbj_d[l_ac].bgbj023_desc = g_qryparam.return1
               DISPLAY BY NAME g_bgbj_d[l_ac].bgbj023,g_bgbj_d[l_ac].bgbj023_desc
               NEXT FIELD bgbj023_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbj024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj024
            #add-point:ON ACTION controlp INFIELD bgbj024 name="input.c.page1.bgbj024"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbj024_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj024_desc
            #add-point:ON ACTION controlp INFIELD bgbj024_desc name="input.c.page1.bgbj024_desc"
            #自由核算項七
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_bgbj_d[l_ac].bgbj024
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0231,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_bgbj_d[l_ac].bgbj024 = g_qryparam.return1
               LET g_bgbj_d[l_ac].bgbj024_desc = g_qryparam.return1
               DISPLAY BY NAME g_bgbj_d[l_ac].bgbj024,g_bgbj_d[l_ac].bgbj024_desc
               NEXT FIELD bgbj024_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbj025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj025
            #add-point:ON ACTION controlp INFIELD bgbj025 name="input.c.page1.bgbj025"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbj025_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj025_desc
            #add-point:ON ACTION controlp INFIELD bgbj025_desc name="input.c.page1.bgbj025_desc"
            #自由核算項八
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_bgbj_d[l_ac].bgbj025
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0241,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_bgbj_d[l_ac].bgbj025 = g_qryparam.return1
               LET g_bgbj_d[l_ac].bgbj025_desc = g_qryparam.return1
               DISPLAY BY NAME g_bgbj_d[l_ac].bgbj025,g_bgbj_d[l_ac].bgbj025_desc
               NEXT FIELD bgbj025_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbj026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj026
            #add-point:ON ACTION controlp INFIELD bgbj026 name="input.c.page1.bgbj026"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbj026_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj026_desc
            #add-point:ON ACTION controlp INFIELD bgbj026_desc name="input.c.page1.bgbj026_desc"
            #自由核算項九
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_bgbj_d[l_ac].bgbj026
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0251,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_bgbj_d[l_ac].bgbj026 = g_qryparam.return1
               LET g_bgbj_d[l_ac].bgbj026_desc = g_qryparam.return1
               DISPLAY BY NAME g_bgbj_d[l_ac].bgbj026,g_bgbj_d[l_ac].bgbj026_desc
               NEXT FIELD bgbj026_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbj027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj027
            #add-point:ON ACTION controlp INFIELD bgbj027 name="input.c.page1.bgbj027"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbj027_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj027_desc
            #add-point:ON ACTION controlp INFIELD bgbj027_desc name="input.c.page1.bgbj027_desc"
            #自由核算項十
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_bgbj_d[l_ac].bgbj027
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0261,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_bgbj_d[l_ac].bgbj027 = g_qryparam.return1
               LET g_bgbj_d[l_ac].bgbj027_desc = g_qryparam.return1
               DISPLAY BY NAME g_bgbj_d[l_ac].bgbj027,g_bgbj_d[l_ac].bgbj027_desc
               NEXT FIELD bgbj027_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbj028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj028
            #add-point:ON ACTION controlp INFIELD bgbj028 name="input.c.page1.bgbj028"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgbj_d[l_ac].bgbj028
            LET g_qryparam.arg1 = g_glaa.glaacomp
            CALL q_ooaj002_1()
            LET g_bgbj_d[l_ac].bgbj028 = g_qryparam.return1
            DISPLAY BY NAME g_bgbj_d[l_ac].bgbj028
            NEXT FIELD bgbj028
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbj029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj029
            #add-point:ON ACTION controlp INFIELD bgbj029 name="input.c.page1.bgbj029"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbj030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj030
            #add-point:ON ACTION controlp INFIELD bgbj030 name="input.c.page1.bgbj030"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbj031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbj031
            #add-point:ON ACTION controlp INFIELD bgbj031 name="input.c.page1.bgbj031"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbjstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbjstus
            #add-point:ON ACTION controlp INFIELD bgbjstus name="input.c.page1.bgbjstus"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_bgbj_d[l_ac].* = g_bgbj_d_t.*
               CLOSE abgt040_bcl
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
               LET g_errparam.extend = g_bgbj_d[l_ac].bgbjseq 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_bgbj_d[l_ac].* = g_bgbj_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               LET g_bgbj2_d[l_ac].bgbjmodid = g_user 
LET g_bgbj2_d[l_ac].bgbjmoddt = cl_get_current()
LET g_bgbj2_d[l_ac].bgbjmodid_desc = cl_get_username(g_bgbj2_d[l_ac].bgbjmodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               CALL cl_err_collect_init()
               CALL abgt040_onrow_chk()RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  CLOSE abgt040_bcl
                  CALL cl_err_collect_show()
                  CALL s_transaction_end('N','0')
                  NEXT FIELD CURRENT
               END IF
               CALL cl_err_collect_show()
               #end add-point
         
               #將遮罩欄位還原
               CALL abgt040_bgbj_t_mask_restore('restore_mask_o')
         
               UPDATE bgbj_t SET (bgbj001,bgbj002,bgbjseq,bgbj003,bgbj004,bgbj005,bgbj006,bgbj007,bgbj008, 
                   bgbj009,bgbj010,bgbj011,bgbj012,bgbj013,bgbj014,bgbj015,bgbj016,bgbj017,bgbj018,bgbj019, 
                   bgbj020,bgbj021,bgbj022,bgbj023,bgbj024,bgbj025,bgbj026,bgbj027,bgbj028,bgbj029,bgbj030, 
                   bgbj031,bgbj032,bgbj033,bgbjstus,bgbjownid,bgbjowndp,bgbjcrtid,bgbjcrtdp,bgbjcrtdt, 
                   bgbjmodid,bgbjmoddt) = (g_bgbj_m.bgbj001,g_bgbj_m.bgbj002,g_bgbj_d[l_ac].bgbjseq, 
                   g_bgbj_d[l_ac].bgbj003,g_bgbj_d[l_ac].bgbj004,g_bgbj_d[l_ac].bgbj005,g_bgbj_d[l_ac].bgbj006, 
                   g_bgbj_d[l_ac].bgbj007,g_bgbj_d[l_ac].bgbj008,g_bgbj_d[l_ac].bgbj009,g_bgbj_d[l_ac].bgbj010, 
                   g_bgbj_d[l_ac].bgbj011,g_bgbj_d[l_ac].bgbj012,g_bgbj_d[l_ac].bgbj013,g_bgbj_d[l_ac].bgbj014, 
                   g_bgbj_d[l_ac].bgbj015,g_bgbj_d[l_ac].bgbj016,g_bgbj_d[l_ac].bgbj017,g_bgbj_d[l_ac].bgbj018, 
                   g_bgbj_d[l_ac].bgbj019,g_bgbj_d[l_ac].bgbj020,g_bgbj_d[l_ac].bgbj021,g_bgbj_d[l_ac].bgbj022, 
                   g_bgbj_d[l_ac].bgbj023,g_bgbj_d[l_ac].bgbj024,g_bgbj_d[l_ac].bgbj025,g_bgbj_d[l_ac].bgbj026, 
                   g_bgbj_d[l_ac].bgbj027,g_bgbj_d[l_ac].bgbj028,g_bgbj_d[l_ac].bgbj029,g_bgbj_d[l_ac].bgbj030, 
                   g_bgbj_d[l_ac].bgbj031,g_bgbj_d[l_ac].bgbj032,g_bgbj_d[l_ac].bgbj033,g_bgbj_d[l_ac].bgbjstus, 
                   g_bgbj2_d[l_ac].bgbjownid,g_bgbj2_d[l_ac].bgbjowndp,g_bgbj2_d[l_ac].bgbjcrtid,g_bgbj2_d[l_ac].bgbjcrtdp, 
                   g_bgbj2_d[l_ac].bgbjcrtdt,g_bgbj2_d[l_ac].bgbjmodid,g_bgbj2_d[l_ac].bgbjmoddt)
                WHERE bgbjent = g_enterprise AND bgbj001 = g_bgbj_m.bgbj001 
                 AND bgbj002 = g_bgbj_m.bgbj002 
 
                 AND bgbjseq = g_bgbj_d_t.bgbjseq #項次   
                 AND bgbj003 = g_bgbj_d_t.bgbj003  
 
                 
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bgbj_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "bgbj_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bgbj_m.bgbj001
               LET gs_keys_bak[1] = g_bgbj001_t
               LET gs_keys[2] = g_bgbj_m.bgbj002
               LET gs_keys_bak[2] = g_bgbj002_t
               LET gs_keys[3] = g_bgbj_d[g_detail_idx].bgbjseq
               LET gs_keys_bak[3] = g_bgbj_d_t.bgbjseq
               LET gs_keys[4] = g_bgbj_d[g_detail_idx].bgbj003
               LET gs_keys_bak[4] = g_bgbj_d_t.bgbj003
               CALL abgt040_update_b('bgbj_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_bgbj_m),util.JSON.stringify(g_bgbj_d_t)
                     LET g_log2 = util.JSON.stringify(g_bgbj_m),util.JSON.stringify(g_bgbj_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL abgt040_bgbj_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_bgbj_m.bgbj001
               LET ls_keys[ls_keys.getLength()+1] = g_bgbj_m.bgbj002
 
               LET ls_keys[ls_keys.getLength()+1] = g_bgbj_d_t.bgbjseq
               LET ls_keys[ls_keys.getLength()+1] = g_bgbj_d_t.bgbj003
 
               CALL abgt040_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE abgt040_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_bgbj_d[l_ac].* = g_bgbj_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE abgt040_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_bgbj_d.getLength() = 0 THEN
               NEXT FIELD bgbjseq
            END IF
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_bgbj_d[li_reproduce_target].* = g_bgbj_d[li_reproduce].*
               LET g_bgbj2_d[li_reproduce_target].* = g_bgbj2_d[li_reproduce].*
 
               LET g_bgbj_d[li_reproduce_target].bgbjseq = NULL
               LET g_bgbj_d[li_reproduce_target].bgbj003 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_bgbj_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_bgbj_d.getLength()+1
            END IF
            
      END INPUT
 
 
      
      DISPLAY ARRAY g_bgbj2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
      
         BEFORE ROW
            CALL abgt040_b_fill(g_wc2) #test 
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_page = 2
            CALL abgt040_idx_chk()
            CALL abgt040_ui_detailshow()
        
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
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD bgbj001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD bgbjseq
               WHEN "s_detail2"
                  NEXT FIELD bgbjseq_2
 
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
 
 
   
   #add-point:input段after_input name="input.after_input"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="abgt040.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION abgt040_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   LET g_glaald = NULL
   SELECT glaald,glaa004 INTO g_glaald,g_glaa004 FROM glaa_t,ooef_t
    WHERE glaaent = g_enterprise
      AND glaacomp = ooef017
      AND glaaent = ooefent
      AND ooef001 = g_bgbj_m.bgbj002
      AND glaa014 = 'Y'   
   CALL abgt040_ld_info(g_glaald)
   #預算幣別
   SELECT bgaa003,bgaa008,bgaa012 
     INTO g_bgbj_m.bgaa003,g_bgaa008,g_bgaa012
     FROM bgaa_t
    WHERE bgaaent = g_enterprise
      AND bgaa001 = g_bgbj_m.bgbj001
   LET g_bgbj_m.bgbj001_desc = s_desc_get_budget_desc(g_bgbj_m.bgbj001)
   LET g_bgbj_m.bgbj002_desc = s_desc_get_department_desc(g_bgbj_m.bgbj002)
  
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL abgt040_b_fill(g_wc2) #第一階單身填充
      CALL abgt040_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL abgt040_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_bgbj_m.bgbj001,g_bgbj_m.bgbj001_desc,g_bgbj_m.bgbj002,g_bgbj_m.bgbj002_desc,g_bgbj_m.bgaa003 
 
 
   CALL abgt040_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
   
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="abgt040.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION abgt040_ref_show()
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
   FOR l_ac = 1 TO g_bgbj_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_bgbj2_d.getLength()
      #add-point:ref_show段d2_reference name="ref_show.body2.reference"
      
      #end add-point
   END FOR
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="abgt040.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION abgt040_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE bgbj_t.bgbj001 
   DEFINE l_oldno     LIKE bgbj_t.bgbj001 
   DEFINE l_newno02     LIKE bgbj_t.bgbj002 
   DEFINE l_oldno02     LIKE bgbj_t.bgbj002 
 
   DEFINE l_master    RECORD LIKE bgbj_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE bgbj_t.* #此變數樣板目前無使用
 
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
 
   IF g_bgbj_m.bgbj001 IS NULL
      OR g_bgbj_m.bgbj002 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_bgbj001_t = g_bgbj_m.bgbj001
   LET g_bgbj002_t = g_bgbj_m.bgbj002
 
   
   LET g_bgbj_m.bgbj001 = ""
   LET g_bgbj_m.bgbj002 = ""
 
   LET g_master_insert = FALSE
   CALL abgt040_set_entry('a')
   CALL abgt040_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #清空key欄位的desc
      LET g_bgbj_m.bgbj001_desc = ''
   DISPLAY BY NAME g_bgbj_m.bgbj001_desc
   LET g_bgbj_m.bgbj002_desc = ''
   DISPLAY BY NAME g_bgbj_m.bgbj002_desc
 
   
   CALL abgt040_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_bgbj_m.* TO NULL
      INITIALIZE g_bgbj_d TO NULL
      INITIALIZE g_bgbj2_d TO NULL
 
      CALL abgt040_show()
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
   CALL abgt040_set_act_visible()
   CALL abgt040_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_bgbj001_t = g_bgbj_m.bgbj001
   LET g_bgbj002_t = g_bgbj_m.bgbj002
 
   
   #組合新增資料的條件
   LET g_add_browse = " bgbjent = " ||g_enterprise|| " AND",
                      " bgbj001 = '", g_bgbj_m.bgbj001, "' "
                      ," AND bgbj002 = '", g_bgbj_m.bgbj002, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL abgt040_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL abgt040_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL abgt040_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="abgt040.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION abgt040_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE bgbj_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE abgt040_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM bgbj_t
    WHERE bgbjent = g_enterprise AND bgbj001 = g_bgbj001_t
    AND bgbj002 = g_bgbj002_t
 
       INTO TEMP abgt040_detail
   
   #將key修正為調整後   
   UPDATE abgt040_detail 
      #更新key欄位
      SET bgbj001 = g_bgbj_m.bgbj001
          , bgbj002 = g_bgbj_m.bgbj002
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
       , bgbjownid = g_user 
       , bgbjowndp = g_dept
       , bgbjcrtid = g_user
       , bgbjcrtdp = g_dept 
       , bgbjcrtdt = ld_date
       , bgbjmodid = g_user
       , bgbjmoddt = ld_date
      #, bgbjstus = "Y" 
 
 
 
                                       
   #將資料塞回原table   
   INSERT INTO bgbj_t SELECT * FROM abgt040_detail
   
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
   DROP TABLE abgt040_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_bgbj001_t = g_bgbj_m.bgbj001
   LET g_bgbj002_t = g_bgbj_m.bgbj002
 
   
   DROP TABLE abgt040_detail
   
END FUNCTION
 
{</section>}
 
{<section id="abgt040.delete" >}
#+ 資料刪除
PRIVATE FUNCTION abgt040_delete()
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
   
   IF g_bgbj_m.bgbj001 IS NULL
   OR g_bgbj_m.bgbj002 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN abgt040_cl USING g_enterprise,g_bgbj_m.bgbj001,g_bgbj_m.bgbj002
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abgt040_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE abgt040_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE abgt040_master_referesh USING g_bgbj_m.bgbj001,g_bgbj_m.bgbj002 INTO g_bgbj_m.bgbj001,g_bgbj_m.bgbj002 
 
   
   #遮罩相關處理
   LET g_bgbj_m_mask_o.* =  g_bgbj_m.*
   CALL abgt040_bgbj_t_mask()
   LET g_bgbj_m_mask_n.* =  g_bgbj_m.*
   
   CALL abgt040_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL abgt040_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM bgbj_t WHERE bgbjent = g_enterprise AND bgbj001 = g_bgbj_m.bgbj001
                                                               AND bgbj002 = g_bgbj_m.bgbj002
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bgbj_t:",SQLERRMESSAGE 
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
      #   CLOSE abgt040_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_bgbj_d.clear() 
      CALL g_bgbj2_d.clear()       
 
     
      CALL abgt040_ui_browser_refresh()  
      #CALL abgt040_ui_headershow()  
      #CALL abgt040_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL abgt040_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL abgt040_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE abgt040_cl
 
   #功能已完成,通報訊息中心
   CALL abgt040_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="abgt040.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION abgt040_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #先清空單身變數內容
   CALL g_bgbj_d.clear()
   CALL g_bgbj2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
  
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT bgbjseq,bgbj003,bgbj004,bgbj005,bgbj006,bgbj007,bgbj008,bgbj009,bgbj010, 
       bgbj011,bgbj012,bgbj013,bgbj014,bgbj015,bgbj016,bgbj017,bgbj018,bgbj019,bgbj020,bgbj021,bgbj022, 
       bgbj023,bgbj024,bgbj025,bgbj026,bgbj027,bgbj028,bgbj029,bgbj030,bgbj031,bgbj032,bgbj033,bgbjstus, 
       bgbjseq,bgbj003,bgbjownid,bgbjowndp,bgbjcrtid,bgbjcrtdp,bgbjcrtdt,bgbjmodid,bgbjmoddt,t1.ooag011 , 
       t2.ooefl003 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011 FROM bgbj_t",   
               "",
               
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=bgbjownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=bgbjowndp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=bgbjcrtid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=bgbjcrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=bgbjmodid  ",
 
               " WHERE bgbjent= ? AND bgbj001=? AND bgbj002=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("bgbj_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF abgt040_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY bgbj_t.bgbjseq,bgbj_t.bgbj003"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
         
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE abgt040_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR abgt040_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_bgbj_m.bgbj001,g_bgbj_m.bgbj002   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_bgbj_m.bgbj001,g_bgbj_m.bgbj002 INTO g_bgbj_d[l_ac].bgbjseq, 
          g_bgbj_d[l_ac].bgbj003,g_bgbj_d[l_ac].bgbj004,g_bgbj_d[l_ac].bgbj005,g_bgbj_d[l_ac].bgbj006, 
          g_bgbj_d[l_ac].bgbj007,g_bgbj_d[l_ac].bgbj008,g_bgbj_d[l_ac].bgbj009,g_bgbj_d[l_ac].bgbj010, 
          g_bgbj_d[l_ac].bgbj011,g_bgbj_d[l_ac].bgbj012,g_bgbj_d[l_ac].bgbj013,g_bgbj_d[l_ac].bgbj014, 
          g_bgbj_d[l_ac].bgbj015,g_bgbj_d[l_ac].bgbj016,g_bgbj_d[l_ac].bgbj017,g_bgbj_d[l_ac].bgbj018, 
          g_bgbj_d[l_ac].bgbj019,g_bgbj_d[l_ac].bgbj020,g_bgbj_d[l_ac].bgbj021,g_bgbj_d[l_ac].bgbj022, 
          g_bgbj_d[l_ac].bgbj023,g_bgbj_d[l_ac].bgbj024,g_bgbj_d[l_ac].bgbj025,g_bgbj_d[l_ac].bgbj026, 
          g_bgbj_d[l_ac].bgbj027,g_bgbj_d[l_ac].bgbj028,g_bgbj_d[l_ac].bgbj029,g_bgbj_d[l_ac].bgbj030, 
          g_bgbj_d[l_ac].bgbj031,g_bgbj_d[l_ac].bgbj032,g_bgbj_d[l_ac].bgbj033,g_bgbj_d[l_ac].bgbjstus, 
          g_bgbj2_d[l_ac].bgbjseq,g_bgbj2_d[l_ac].bgbj003,g_bgbj2_d[l_ac].bgbjownid,g_bgbj2_d[l_ac].bgbjowndp, 
          g_bgbj2_d[l_ac].bgbjcrtid,g_bgbj2_d[l_ac].bgbjcrtdp,g_bgbj2_d[l_ac].bgbjcrtdt,g_bgbj2_d[l_ac].bgbjmodid, 
          g_bgbj2_d[l_ac].bgbjmoddt,g_bgbj2_d[l_ac].bgbjownid_desc,g_bgbj2_d[l_ac].bgbjowndp_desc,g_bgbj2_d[l_ac].bgbjcrtid_desc, 
          g_bgbj2_d[l_ac].bgbjcrtdp_desc,g_bgbj2_d[l_ac].bgbjmodid_desc   #(ver:49)
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充 name="b_fill.fill"
         LET g_bgbj_d[l_ac].bgbj005_desc = s_desc_show1(g_bgbj_d[l_ac].bgbj005,s_desc_get_department_desc(g_bgbj_d[l_ac].bgbj005))
         LET g_bgbj_d[l_ac].bgbj006_desc = s_desc_show1(g_bgbj_d[l_ac].bgbj006,s_desc_get_department_desc(g_bgbj_d[l_ac].bgbj006))
         LET g_bgbj_d[l_ac].bgbj007_desc = s_desc_show1(g_bgbj_d[l_ac].bgbj007,s_desc_get_acc_desc('287',g_bgbj_d[l_ac].bgbj007))
         LET g_bgbj_d[l_ac].bgbj008_desc = s_desc_show1(g_bgbj_d[l_ac].bgbj008,s_desc_get_trading_partner_abbr_desc(g_bgbj_d[l_ac].bgbj008))
         LET g_bgbj_d[l_ac].bgbj009_desc = s_desc_show1(g_bgbj_d[l_ac].bgbj009,s_desc_get_trading_partner_abbr_desc(g_bgbj_d[l_ac].bgbj009))
         LET g_bgbj_d[l_ac].bgbj010_desc = s_desc_show1(g_bgbj_d[l_ac].bgbj010,s_desc_get_acc_desc('281',g_bgbj_d[l_ac].bgbj010))
         LET g_bgbj_d[l_ac].bgbj011_desc = s_desc_show1(g_bgbj_d[l_ac].bgbj011,s_desc_get_rtaxl003_desc(g_bgbj_d[l_ac].bgbj011))
         LET g_bgbj_d[l_ac].bgbj012_desc = s_desc_show1(g_bgbj_d[l_ac].bgbj012,s_desc_get_person_desc(g_bgbj_d[l_ac].bgbj012))
         LET g_bgbj_d[l_ac].bgbj013_desc = s_desc_show1(g_bgbj_d[l_ac].bgbj013,s_desc_get_project_desc(g_bgbj_d[l_ac].bgbj013))
         LET g_bgbj_d[l_ac].bgbj014_desc = s_desc_show1(g_bgbj_d[l_ac].bgbj014,s_desc_get_pjbbl004_desc(g_bgbj_d[l_ac].bgbj013,g_bgbj_d[l_ac].bgbj014))
         LET g_bgbj_d[l_ac].bgbj015_desc = g_bgbj_d[l_ac].bgbj015
         LET g_bgbj_d[l_ac].bgbj016_desc = s_desc_show1(g_bgbj_d[l_ac].bgbj016,s_desc_get_oojdl003_desc(g_bgbj_d[l_ac].bgbj016))
         LET g_bgbj_d[l_ac].bgbj017_desc = s_desc_show1(g_bgbj_d[l_ac].bgbj017,s_desc_get_acc_desc('2002',g_bgbj_d[l_ac].bgbj017))
      
         IF g_bgaa012 = 'Y' THEN
            LET g_glac002 = g_bgbj_d[l_ac].bgbj003
            LET g_bgbj_d[l_ac].bgbj003_desc = s_desc_get_account_desc(g_glaald,g_bgbj_d[l_ac].bgbj003)
         ELSE
            CALL abgt040_bg_to_acc(g_bgaa008,g_bgbj_d[l_ac].bgbj003)RETURNING g_glac002
            LET g_bgbj_d[l_ac].bgbj003_desc = s_abg_bgae001_desc(g_bgaa008,g_bgbj_d[l_ac].bgbj003)
         END IF
                    
         CALL s_fin_sel_glad(g_glaald,g_glac002,'glad0171|glad0172|glad0181|glad0182|glad0191|glad0192|glad0201|glad0202|glad0211|glad0212|glad0221|glad0222|glad0231|glad0232|glad0241|glad0242|glad0251|glad0252|glad0261|glad0262') 
              RETURNING g_errno,g_glad.*
         LET g_bgbj_d[l_ac].bgbj018_desc = s_desc_show1(g_bgbj_d[l_ac].bgbj018,s_fin_get_accting_desc(g_glad.glad0171,g_bgbj_d[l_ac].bgbj018))
         LET g_bgbj_d[l_ac].bgbj019_desc = s_desc_show1(g_bgbj_d[l_ac].bgbj019,s_fin_get_accting_desc(g_glad.glad0181,g_bgbj_d[l_ac].bgbj019))
         LET g_bgbj_d[l_ac].bgbj020_desc = s_desc_show1(g_bgbj_d[l_ac].bgbj020,s_fin_get_accting_desc(g_glad.glad0191,g_bgbj_d[l_ac].bgbj020))
         LET g_bgbj_d[l_ac].bgbj021_desc = s_desc_show1(g_bgbj_d[l_ac].bgbj021,s_fin_get_accting_desc(g_glad.glad0201,g_bgbj_d[l_ac].bgbj021))
         LET g_bgbj_d[l_ac].bgbj022_desc = s_desc_show1(g_bgbj_d[l_ac].bgbj022,s_fin_get_accting_desc(g_glad.glad0211,g_bgbj_d[l_ac].bgbj022))
         LET g_bgbj_d[l_ac].bgbj023_desc = s_desc_show1(g_bgbj_d[l_ac].bgbj023,s_fin_get_accting_desc(g_glad.glad0221,g_bgbj_d[l_ac].bgbj023))
         LET g_bgbj_d[l_ac].bgbj024_desc = s_desc_show1(g_bgbj_d[l_ac].bgbj024,s_fin_get_accting_desc(g_glad.glad0231,g_bgbj_d[l_ac].bgbj024))
         LET g_bgbj_d[l_ac].bgbj025_desc = s_desc_show1(g_bgbj_d[l_ac].bgbj025,s_fin_get_accting_desc(g_glad.glad0241,g_bgbj_d[l_ac].bgbj025))
         LET g_bgbj_d[l_ac].bgbj026_desc = s_desc_show1(g_bgbj_d[l_ac].bgbj026,s_fin_get_accting_desc(g_glad.glad0251,g_bgbj_d[l_ac].bgbj026))
         LET g_bgbj_d[l_ac].bgbj027_desc = s_desc_show1(g_bgbj_d[l_ac].bgbj027,s_fin_get_accting_desc(g_glad.glad0261,g_bgbj_d[l_ac].bgbj027))
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
 
            CALL g_bgbj_d.deleteElement(g_bgbj_d.getLength())
      CALL g_bgbj2_d.deleteElement(g_bgbj2_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
   
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_bgbj_d.getLength()
      LET g_bgbj_d_mask_o[l_ac].* =  g_bgbj_d[l_ac].*
      CALL abgt040_bgbj_t_mask()
      LET g_bgbj_d_mask_n[l_ac].* =  g_bgbj_d[l_ac].*
   END FOR
   
   LET g_bgbj2_d_mask_o.* =  g_bgbj2_d.*
   FOR l_ac = 1 TO g_bgbj2_d.getLength()
      LET g_bgbj2_d_mask_o[l_ac].* =  g_bgbj2_d[l_ac].*
      CALL abgt040_bgbj_t_mask()
      LET g_bgbj2_d_mask_n[l_ac].* =  g_bgbj2_d[l_ac].*
   END FOR
 
 
   FREE abgt040_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="abgt040.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION abgt040_idx_chk()
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
      IF g_detail_idx > g_bgbj_d.getLength() THEN
         LET g_detail_idx = g_bgbj_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_bgbj_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_bgbj_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_bgbj2_d.getLength() THEN
         LET g_detail_idx = g_bgbj2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_bgbj2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_bgbj2_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="abgt040.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION abgt040_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_bgbj_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="abgt040.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION abgt040_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   
   #end add-point
   
   DELETE FROM bgbj_t
    WHERE bgbjent = g_enterprise AND bgbj001 = g_bgbj_m.bgbj001 AND
                              bgbj002 = g_bgbj_m.bgbj002 AND
 
          bgbjseq = g_bgbj_d_t.bgbjseq
      AND bgbj003 = g_bgbj_d_t.bgbj003
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "bgbj_t:",SQLERRMESSAGE 
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
 
{<section id="abgt040.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION abgt040_delete_b(ps_table,ps_keys_bak,ps_page)
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
 
{<section id="abgt040.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION abgt040_insert_b(ps_table,ps_keys,ps_page)
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
 
{<section id="abgt040.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION abgt040_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
 
{<section id="abgt040.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION abgt040_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_bgbj_d[l_ac].bgbjseq = g_bgbj_d_t.bgbjseq 
      AND g_bgbj_d[l_ac].bgbj003 = g_bgbj_d_t.bgbj003 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="abgt040.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION abgt040_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="abgt040.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION abgt040_lock_b(ps_table,ps_page)
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
   #CALL abgt040_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="abgt040.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION abgt040_unlock_b(ps_table,ps_page)
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
 
{<section id="abgt040.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION abgt040_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("bgbj001,bgbj002",TRUE)
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
 
{<section id="abgt040.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION abgt040_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("bgbj001,bgbj002",FALSE)
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
 
{<section id="abgt040.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION abgt040_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="abgt040.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION abgt040_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="abgt040.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION abgt040_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abgt040.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION abgt040_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abgt040.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION abgt040_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abgt040.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION abgt040_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abgt040.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION abgt040_default_search()
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
      LET ls_wc = ls_wc, " bgbj001 = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " bgbj002 = '", g_argv[02], "' AND "
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
 
{<section id="abgt040.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION abgt040_fill_chk(ps_idx)
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
 
{<section id="abgt040.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION abgt040_modify_detail_chk(ps_record)
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
         LET ls_return = "bgbjseq"
      WHEN "s_detail2"
         LET ls_return = "bgbjseq_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="abgt040.mask_functions" >}
&include "erp/abg/abgt040_mask.4gl"
 
{</section>}
 
{<section id="abgt040.state_change" >}
    
 
{</section>}
 
{<section id="abgt040.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION abgt040_set_pk_array()
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
   LET g_pk_array[1].values = g_bgbj_m.bgbj001
   LET g_pk_array[1].column = 'bgbj001'
   LET g_pk_array[2].values = g_bgbj_m.bgbj002
   LET g_pk_array[2].column = 'bgbj002'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="abgt040.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION abgt040_msgcentre_notify(lc_state)
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
   CALL abgt040_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_bgbj_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="abgt040.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 核算項目檢核
# Memo...........:
# Usage..........: CALL abgt040_bgbj003_chk(p_bgaa001,p_bgae001)
# Date & Author..: 2015/08/04 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt040_bgbj003_chk(p_bgaa001,p_bgae001)
 DEFINE p_bgaa001   LIKE bgaa_t.bgaa001 #預算編號
 DEFINE p_bgae001   LIKE bgae_t.bgae001 #預算項目編碼
 DEFINE r_errno     LIKE gzze_t.gzze001 
 DEFINE r_success   LIKE type_t.num5
 
   LET r_errno = NULL   LET r_success = TRUE
   IF g_bgaa012 = 'Y' THEN
      #科目檢合
      CALL s_aap_glac002_chk(p_bgae001,g_glaald) RETURNING g_sub_success,g_errno
      IF NOT g_sub_success THEN
         LET r_success = FALSE
         LET r_errno  = g_errno
         RETURN r_success,r_errno
      END IF
   ELSE
      #預算項目必須存在預算編號中的預算項目參照表中
      CALL s_abg_bgae001_chk(p_bgaa001,'',p_bgae001,1)
            RETURNING g_sub_success,g_errno
      IF NOT g_sub_success THEN
         LET r_success = FALSE
         LET r_errno  = g_errno
         RETURN r_success,r_errno
      END IF
      #項目是否有對應之科目
      CALL abgt040_bg_to_acc(g_bgaa008,g_bgbj_d[l_ac].bgbj003)RETURNING g_glac002
      IF cl_null(g_glac002) THEN 
         LET r_success = FALSE
         LET r_errno = 'abg-00085'
         RETURN r_success,r_errno
      END IF
#      CALL s_aap_glac002_chk(g_glac002,g_glaald) RETURNING g_sub_success,g_errno
#      IF NOT g_sub_success THEN
#         LET r_success = FALSE
#         LET r_errno  = g_errno
#         RETURN r_success,r_errno
#      END IF
   END IF

   RETURN r_success,r_errno

END FUNCTION

################################################################################
# Descriptions...: #取第一個符合在abgi140中的第一個會計科目
# Memo...........:
# Usage..........: CALL abgt040_bg_to_acc(p_bglist,p_bg)
# Date & Author..: 2015/08/04 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt040_bg_to_acc(p_bglist,p_bg)
   DEFINE p_bglist   LIKE bgaa_t.bgaa008
   DEFINE p_bg       LIKE bgae_t.bgae001
   DEFINE r_acc      LIKE glac_t.glac002
   #取第一個符合在abgi140中的第一個會計科目
   DEFINE l_sql      STRING
   LET r_acc = NULL
   LET l_sql = "SELECT bgao003 FROM bgao_t ",
               " WHERE bgaoent = ",g_enterprise," ",
               "   AND bgao001 = '",p_bglist,"'   ",
               "   AND bgao002 = '",g_glaa004,"'  ", 
               "   AND bgao004 = '",p_bg,"' "
   PREPARE sel_bgaop1 FROM l_sql
   DECLARE sel_bgaoc1 CURSOR FOR sel_bgaop1

   FOREACH sel_bgaoc1 INTO r_acc
      IF SQLCA.SQLCODE THEN EXIT FOREACH END IF
      EXIT FOREACH
   END FOREACH

   RETURN r_acc
END FUNCTION

################################################################################
# Descriptions...: 核算項檢核
# Memo...........:
# Usage..........: CALL abgt040_onrow_chk()
# Date & Author..: 2015/08/15 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt040_onrow_chk()
DEFINE r_success        LIKE type_t.num5
DEFINE l_sql            STRING
DEFINE l_bgbj    RECORD
       bgbjseq            LIKE bgbj_t.bgbjseq,
       bgbj001            LIKE bgbj_t.bgbj001,
       bgbj005            LIKE bgbj_t.bgbj005,
       bgbj006            LIKE bgbj_t.bgbj006,
       bgbj007            LIKE bgbj_t.bgbj007,
       bgbj008            LIKE bgbj_t.bgbj008,
       bgbj009            LIKE bgbj_t.bgbj009,
       bgbj010            LIKE bgbj_t.bgbj010,
       bgbj011            LIKE bgbj_t.bgbj011,
       bgbj012            LIKE bgbj_t.bgbj012,
       bgbj013            LIKE bgbj_t.bgbj013,
       bgbj014            LIKE bgbj_t.bgbj014,
       bgbj015            LIKE bgbj_t.bgbj015,
       bgbj016            LIKE bgbj_t.bgbj016,
       bgbj017            LIKE bgbj_t.bgbj017,
       bgbj018            LIKE bgbj_t.bgbj018,
       bgbj019            LIKE bgbj_t.bgbj019,
       bgbj020            LIKE bgbj_t.bgbj020,      
       bgbj021            LIKE bgbj_t.bgbj020,
       bgbj022            LIKE bgbj_t.bgbj022,
       bgbj023            LIKE bgbj_t.bgbj023,
       bgbj024            LIKE bgbj_t.bgbj024,
       bgbj025            LIKE bgbj_t.bgbj025,
       bgbj026            LIKE bgbj_t.bgbj026,
       bgbj027            LIKE bgbj_t.bgbj027,
       bgbj028            LIKE bgbj_t.bgbj028
           END RECORD
           
DEFINE l_account        DYNAMIC ARRAY OF RECORD
              f1           LIKE type_t.chr100,     #欄位值
              f2           LIKE type_t.chr7,       #欄位說明
              f3           LIKE fmmw_t.fmmwdocdt   #條件
                        END RECORD
DEFINE l_glaa121        LIKE glaa_t.glaa121
#DEFINE l_glad           RECORD LIKE glad_t.* #161104-00024#9 mark
#161104-00024#9 --s add
DEFINE l_glad RECORD  #帳套科目管理設定檔
       gladent LIKE glad_t.gladent, #企業編號
       gladownid LIKE glad_t.gladownid, #資料所有者
       gladowndp LIKE glad_t.gladowndp, #資料所屬部門
       gladcrtid LIKE glad_t.gladcrtid, #資料建立者
       gladcrtdp LIKE glad_t.gladcrtdp, #資料建立部門
       gladcrtdt LIKE glad_t.gladcrtdt, #資料創建日
       gladmodid LIKE glad_t.gladmodid, #資料修改者
       gladmoddt LIKE glad_t.gladmoddt, #最近修改日
       gladstus LIKE glad_t.gladstus, #狀態碼
       gladld LIKE glad_t.gladld, #帳套
       glad001 LIKE glad_t.glad001, #會計科目編號
       glad002 LIKE glad_t.glad002, #是否按餘額類型產生分錄
       glad003 LIKE glad_t.glad003, #啟用傳票項次細項立沖
       glad004 LIKE glad_t.glad004, #傳票項次異動別
       glad005 LIKE glad_t.glad005, #是否啟用數量金額式
       glad006 LIKE glad_t.glad006, #借方現金變動碼
       glad007 LIKE glad_t.glad007, #啟用部門管理
       glad008 LIKE glad_t.glad008, #啟用利潤成本管理
       glad009 LIKE glad_t.glad009, #啟用區域管理
       glad010 LIKE glad_t.glad010, #啟用收付款客商管理
       glad011 LIKE glad_t.glad011, #啟用客群管理
       glad012 LIKE glad_t.glad012, #啟用產品類別管理
       glad013 LIKE glad_t.glad013, #啟用人員管理
       glad014 LIKE glad_t.glad014, #no use
       glad015 LIKE glad_t.glad015, #啟用專案管理
       glad016 LIKE glad_t.glad016, #啟用WBS管理
       glad017 LIKE glad_t.glad017, #啟用自由核算項一
       glad0171 LIKE glad_t.glad0171, #自由核算項一類型編號
       glad0172 LIKE glad_t.glad0172, #自由核算項一控制方式
       glad018 LIKE glad_t.glad018, #啟用自由核算項二
       glad0181 LIKE glad_t.glad0181, #自由核算項二類型編號
       glad0182 LIKE glad_t.glad0182, #自由核算項二控制方式
       glad019 LIKE glad_t.glad019, #啟用自由核算項三
       glad0191 LIKE glad_t.glad0191, #自由核算項三類型編號
       glad0192 LIKE glad_t.glad0192, #自由核算項三控制方式
       glad020 LIKE glad_t.glad020, #啟用自由核算項四
       glad0201 LIKE glad_t.glad0201, #自由核算項四類型編號
       glad0202 LIKE glad_t.glad0202, #自由核算項四控制方式
       glad021 LIKE glad_t.glad021, #啟用自由核算項五
       glad0211 LIKE glad_t.glad0211, #自由核算項五類型編號
       glad0212 LIKE glad_t.glad0212, #自由核算項五控制方式
       glad022 LIKE glad_t.glad022, #啟用自由核算項六
       glad0221 LIKE glad_t.glad0221, #自由核算項六類型編號
       glad0222 LIKE glad_t.glad0222, #自由核算項六控制方式
       glad023 LIKE glad_t.glad023, #啟用自由核算項七
       glad0231 LIKE glad_t.glad0231, #自由核算項七類型編號
       glad0232 LIKE glad_t.glad0232, #自由核算項七控制方式
       glad024 LIKE glad_t.glad024, #啟用自由核算項八
       glad0241 LIKE glad_t.glad0241, #自由核算項八類型編號
       glad0242 LIKE glad_t.glad0242, #自由核算項八控制方式
       glad025 LIKE glad_t.glad025, #啟用自由核算項九
       glad0251 LIKE glad_t.glad0251, #自由核算項九類型編號
       glad0252 LIKE glad_t.glad0252, #自由核算項九控制方式
       glad026 LIKE glad_t.glad026, #啟用自由核算項十
       glad0261 LIKE glad_t.glad0261, #自由核算項十類型編號
       glad0262 LIKE glad_t.glad0262, #自由核算項十控制方式
       glad027 LIKE glad_t.glad027, #啟用帳款客商管理
       glad030 LIKE glad_t.glad030, #是否進行預算管控
       glad031 LIKE glad_t.glad031, #啟用經營方式管理
       glad032 LIKE glad_t.glad032, #啟用渠道管理
       glad033 LIKE glad_t.glad033, #啟用品牌管理
       glad034 LIKE glad_t.glad034, #科目做多幣別管理
       glad035 LIKE glad_t.glad035, #是否是子系統科目
       glad036 LIKE glad_t.glad036  #貸方現金變動碼
END RECORD
#161104-00024#9 --e add
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE


   CALL s_ld_sel_glaa(g_glaald,'glaa121') RETURNING  g_sub_success,l_glaa121
   
  
   CALL l_account.clear()
   LET l_account[7].f1  = g_bgbj_d[l_ac].bgbj005    LET l_account[7].f2 =  "bgbj005"    LET l_account[7].f3 = g_today #部門
   LET l_account[8].f1  = g_bgbj_d[l_ac].bgbj006    LET l_account[8].f2 =  "bgbj006"    #利潤中心
   LET l_account[9].f1  = g_bgbj_d[l_ac].bgbj007    LET l_account[9].f2 =  "bgbj007"    #區域
   LET l_account[10].f1 = g_bgbj_d[l_ac].bgbj008    LET l_account[10].f2 = "bgbj008"    #交易客商
   LET l_account[11].f1 = g_bgbj_d[l_ac].bgbj010    LET l_account[11].f2 = "bgbj010"    #客群      
   LET l_account[12].f1 = g_bgbj_d[l_ac].bgbj011    LET l_account[12].f2 = "bgbj011"    #產品類別
   LET l_account[13].f1 = g_bgbj_d[l_ac].bgbj012    LET l_account[13].f2 = "bgbj012"    #業務人員      
   LET l_account[15].f1 = g_bgbj_d[l_ac].bgbj013    LET l_account[15].f2 = "bgbj013"    #專案代號
   LET l_account[16].f1 = g_bgbj_d[l_ac].bgbj014    LET l_account[16].f2 = "bgbj014"    #WBS
   LET l_account[27].f1 = g_bgbj_d[l_ac].bgbj009    LET l_account[27].f2 = "bgbj009"    #帳款客商      
   LET l_account[31].f1 = g_bgbj_d[l_ac].bgbj015    LET l_account[31].f2 = "bgbj015"    #經營方式
   LET l_account[32].f1 = g_bgbj_d[l_ac].bgbj016    LET l_account[32].f2 = "bgbj016"    #渠道
   LET l_account[33].f1 = g_bgbj_d[l_ac].bgbj017    LET l_account[33].f2 = "bgbj017"    #品牌   
   LET l_account[17].f1 = g_bgbj_d[l_ac].bgbj018    LET l_account[17].f2 = "bgbj018"    #自由核算項一
   LET l_account[18].f1 = g_bgbj_d[l_ac].bgbj019    LET l_account[18].f2 = "bgbj019"    #自由核算項二
   LET l_account[19].f1 = g_bgbj_d[l_ac].bgbj020    LET l_account[19].f2 = "bgbj020"    #自由核算項三
   LET l_account[20].f1 = g_bgbj_d[l_ac].bgbj021    LET l_account[20].f2 = "bgbj021"    #自由核算項四
   LET l_account[21].f1 = g_bgbj_d[l_ac].bgbj022    LET l_account[21].f2 = "bgbj022"    #自由核算項五
   LET l_account[22].f1 = g_bgbj_d[l_ac].bgbj023    LET l_account[22].f2 = "bgbj023"    #自由核算項六
   LET l_account[23].f1 = g_bgbj_d[l_ac].bgbj024    LET l_account[23].f2 = "bgbj024"    #自由核算項七
   LET l_account[24].f1 = g_bgbj_d[l_ac].bgbj025    LET l_account[24].f2 = "bgbj025"    #自由核算項八
   LET l_account[25].f1 = g_bgbj_d[l_ac].bgbj026    LET l_account[25].f2 = "bgbj026"    #自由核算項九
   LET l_account[26].f1 = g_bgbj_d[l_ac].bgbj027    LET l_account[26].f2 = "bgbj027"    #自由核算項十

   LET l_account[1].f2  = "bgbj003"
   CALL s_fin_accting_chk(g_glaald,g_glac002,l_account) RETURNING g_sub_success
   IF NOT g_sub_success THEN
      LET r_success = FALSE
   END IF    
 
   RETURN r_success        
           


END FUNCTION

################################################################################
# Descriptions...: 預算編號幣別轉換匯率
# Memo...........:
# Usage..........: CALL abgt040_get_rate()
# Date & Author..: 2015/08/05 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt040_get_rate()
DEFINE r_rate         LIKE bgav_t.bgav004

   SELECT bgav004 INTO r_rate FROM bgav_t
    WHERE bgavent = g_enterprise
      AND bgav001 = g_bgbj_m.bgbj001
      AND bgav002 = g_bgbj_m.bgaa003 
      AND bgav005 = g_bgbj_d[l_ac].bgbj028
      AND bgav003 = (SELECT max(bgav003) FROM bgav_t WHERE bgavent = g_enterprise
                                                        AND bgav001 = g_bgbj_m.bgbj001
                                                        AND bgav003 <=g_today)
      AND bgavstus = 'Y'

    IF cl_null(r_rate) THEN LET r_rate = 1 END IF
    RETURN r_rate

END FUNCTION

################################################################################
# Descriptions...: 金額計算
# Memo...........:
# Usage..........: CALL abgt040_amt()
# Date & Author..: 2015/08/15 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt040_amt()

   LET g_bgbj_d[l_ac].bgbj032 = g_bgbj_d[l_ac].bgbj029 * g_bgbj_d[l_ac].bgbj030 #原幣金額
   LET g_bgbj_d[l_ac].bgbj033 = g_bgbj_d[l_ac].bgbj029 * g_bgbj_d[l_ac].bgbj030  * g_bgbj_d[l_ac].bgbj031 #本幣金額
   CALL s_curr_round_ld('1',g_glaald,g_bgbj_d[l_ac].bgbj028,g_bgbj_d[l_ac].bgbj032,2) RETURNING g_sub_success,g_errno,g_bgbj_d[l_ac].bgbj032
   CALL s_curr_round_ld('1',g_glaald,g_bgbj_m.bgaa003,g_bgbj_d[l_ac].bgbj033,2) RETURNING g_sub_success,g_errno,g_bgbj_d[l_ac].bgbj033
   
   DISPLAY BY NAME g_bgbj_d[l_ac].bgbj032,g_bgbj_d[l_ac].bgbj033

END FUNCTION

################################################################################
# Descriptions...: 帳套相關資訊
# Memo...........:
# Usage..........: CALL abgt040_ld_info(p_ld)
# Date & Author..: 2015/08/05 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt040_ld_info(p_ld)
DEFINE p_ld   LIKE glaa_t.glaald
   CALL s_ld_sel_glaa(p_ld,'glaacomp|glaa004|glaa015|glaa019|glaa024|glaa102|glaa121|glaa001|glaa016|glaa020')
        RETURNING g_sub_success,g_glaa.*
      
END FUNCTION

 
{</section>}
 
