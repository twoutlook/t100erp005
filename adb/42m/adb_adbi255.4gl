#該程式未解開Section, 採用最新樣板產出!
{<section id="adbi255.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0007(2015-03-02 09:41:45), PR版次:0007(2016-08-30 16:50:13)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000352
#+ Filename...: adbi255
#+ Description: 路線順序規劃維護作業
#+ Creator....: 02749(2014-04-30 16:36:12)
#+ Modifier...: 02749 -SD/PR- 06137
 
{</section>}
 
{<section id="adbi255.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#3   2016/04/12  By 07675       將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
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
PRIVATE type type_g_dbaf_m        RECORD
       dbaf001 LIKE dbaf_t.dbaf001, 
   dbaf001_desc LIKE type_t.chr80, 
   f_dbaf011 LIKE type_t.chr500, 
   f_dbaf012 LIKE type_t.chr500, 
   f_dbaf013 LIKE type_t.chr500, 
   f_dbaf014 LIKE type_t.chr500, 
   f_dbaf015 LIKE type_t.chr500, 
   f_dbaf0111 LIKE type_t.chr500, 
   f_dbaf0121 LIKE type_t.chr500, 
   f_dbaf0131 LIKE type_t.chr500, 
   f_dbaf0141 LIKE type_t.chr500, 
   f_dbaf0151 LIKE type_t.chr500
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_dbaf_d        RECORD
       dbafstus LIKE dbaf_t.dbafstus, 
   dbaf004 LIKE dbaf_t.dbaf004, 
   dbaf003 LIKE dbaf_t.dbaf003, 
   dbaf003_desc LIKE type_t.chr500, 
   l_dbad002 LIKE type_t.chr500, 
   l_dbad002_desc LIKE type_t.chr500, 
   dbaf011 LIKE dbaf_t.dbaf011, 
   dbaf012 LIKE dbaf_t.dbaf012, 
   dbaf013 LIKE dbaf_t.dbaf013, 
   dbaf014 LIKE dbaf_t.dbaf014, 
   dbaf015 LIKE dbaf_t.dbaf015, 
   dbaf002 LIKE dbaf_t.dbaf002
       END RECORD
PRIVATE TYPE type_g_dbaf2_d RECORD
       dbaf003 LIKE dbaf_t.dbaf003, 
   dbaf002 LIKE dbaf_t.dbaf002, 
   dbafownid LIKE dbaf_t.dbafownid, 
   dbafownid_desc LIKE type_t.chr500, 
   dbafowndp LIKE dbaf_t.dbafowndp, 
   dbafowndp_desc LIKE type_t.chr500, 
   dbafcrtid LIKE dbaf_t.dbafcrtid, 
   dbafcrtid_desc LIKE type_t.chr500, 
   dbafcrtdp LIKE dbaf_t.dbafcrtdp, 
   dbafcrtdp_desc LIKE type_t.chr500, 
   dbafcrtdt DATETIME YEAR TO SECOND, 
   dbafmodid LIKE dbaf_t.dbafmodid, 
   dbafmodid_desc LIKE type_t.chr500, 
   dbafmoddt DATETIME YEAR TO SECOND
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 TYPE type_g_dbaf3_d RECORD
   dbafstus1       LIKE type_t.chr80, 
   dbaf0041        LIKE type_t.num5, 
   dbaf0031        LIKE dbaf_t.dbaf003, 
   dbaf0031_desc   LIKE type_t.chr500, 
   l_dbad0021      LIKE type_t.chr80, 
   l_dbad0021_desc LIKE type_t.chr500, 
   dbaf0111        LIKE type_t.num15_3, 
   dbaf0121        LIKE type_t.num15_3, 
   dbaf0131        LIKE type_t.num20_6, 
   dbaf0141        LIKE type_t.num20_6, 
   dbaf0151        LIKE type_t.num20_6, 
   dbaf0021        LIKE dbaf_t.dbaf002
       END RECORD

 TYPE type_g_dbaf4_d RECORD
   dbaf003_4         LIKE dbaf_t.dbaf003, 
   dbaf002_4         LIKE dbaf_t.dbaf002, 
   dbafownid1        LIKE dbaf_t.dbafownid, 
   dbafownid1_desc   LIKE type_t.chr500, 
   dbafowndp1        LIKE dbaf_t.dbafowndp, 
   dbafowndp1_desc_1 LIKE type_t.chr500, 
   dbafcrtid1        LIKE dbaf_t.dbafcrtid, 
   dbafcrtid1_desc   LIKE type_t.chr500, 
   dbafcrtdp1        LIKE dbaf_t.dbafcrtdp, 
   dbafcrtdp1_desc   LIKE type_t.chr500, 
   dbafcrtdt1        DATETIME YEAR TO SECOND, 
   dbafmodid1        LIKE dbaf_t.dbafmodid, 
   dbafmodid1_desc   LIKE type_t.chr500, 
   dbafmoddt1        DATETIME YEAR TO SECOND
       END RECORD
       

DEFINE g_dbaf3_d      DYNAMIC ARRAY OF type_g_dbaf3_d
DEFINE g_dbaf3_d_t    type_g_dbaf3_d   
DEFINE g_dbaf4_d      DYNAMIC ARRAY OF type_g_dbaf4_d
DEFINE g_dbaf4_d_t    type_g_dbaf4_d
DEFINE g_wc3          STRING                        #回程CONSTRUCT結果
DEFINE g_wc3_table1   STRING
DEFINE g_wc4          STRING                        #回程CONSTRUCT結果
DEFINE g_wc4_table1   STRING
DEFINE g_detail_idx3  LIKE type_t.num5              #回程-基本資料目前所在筆數
DEFINE g_detail_idx4  LIKE type_t.num5              #回程-異動資訊目前所在筆數
DEFINE g_set_page     LIKE type_t.chr10             #設定導向哪個頁籤
#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_dbaf_m          type_g_dbaf_m
DEFINE g_dbaf_m_t        type_g_dbaf_m
DEFINE g_dbaf_m_o        type_g_dbaf_m
DEFINE g_dbaf_m_mask_o   type_g_dbaf_m #轉換遮罩前資料
DEFINE g_dbaf_m_mask_n   type_g_dbaf_m #轉換遮罩後資料
 
   DEFINE g_dbaf001_t LIKE dbaf_t.dbaf001
 
 
DEFINE g_dbaf_d          DYNAMIC ARRAY OF type_g_dbaf_d
DEFINE g_dbaf_d_t        type_g_dbaf_d
DEFINE g_dbaf_d_o        type_g_dbaf_d
DEFINE g_dbaf_d_mask_o   DYNAMIC ARRAY OF type_g_dbaf_d #轉換遮罩前資料
DEFINE g_dbaf_d_mask_n   DYNAMIC ARRAY OF type_g_dbaf_d #轉換遮罩後資料
DEFINE g_dbaf2_d   DYNAMIC ARRAY OF type_g_dbaf2_d
DEFINE g_dbaf2_d_t type_g_dbaf2_d
DEFINE g_dbaf2_d_o type_g_dbaf2_d
DEFINE g_dbaf2_d_mask_o   DYNAMIC ARRAY OF type_g_dbaf2_d #轉換遮罩前資料
DEFINE g_dbaf2_d_mask_n   DYNAMIC ARRAY OF type_g_dbaf2_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_dbaf001 LIKE dbaf_t.dbaf001
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
 
{<section id="adbi255.main" >}
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
   CALL cl_ap_init("adb","")
 
   #add-point:作業初始化 name="main.init"
   LET g_set_page = NULL
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT dbaf001,'','','','','','','','','','',''", 
                      " FROM dbaf_t",
                      " WHERE dbafent= ? AND dbaf001=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE adbi255_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.dbaf001,t1.dbabl003",
               " FROM dbaf_t t0",
                              " LEFT JOIN dbabl_t t1 ON t1.dbablent="||g_enterprise||" AND t1.dbabl001=t0.dbaf001 AND t1.dbabl002='"||g_dlang||"' ",
 
               " WHERE t0.dbafent = " ||g_enterprise|| " AND t0.dbaf001 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE adbi255_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_adbi255 WITH FORM cl_ap_formpath("adb",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL adbi255_init()   
 
      #進入選單 Menu (="N")
      CALL adbi255_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_adbi255
      
   END IF 
   
   CLOSE adbi255_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="adbi255.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION adbi255_init()
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
   LET g_errshow = '1'
   #end add-point
   
   CALL adbi255_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="adbi255.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION adbi255_ui_dialog()
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
   DEFINE l_sel_flag       LIKE type_t.chr1   
   DEFINE l_sel_st         LIKE type_t.num5   
   DEFINE l_sel_end        LIKE type_t.num5   
   DEFINE l_sel_cnt        LIKE type_t.num5   
   DEFINE l_set_rec        LIKE type_t.num5   
   DEFINE l_dbaf003_st     LIKE dbaf_t.dbaf003 
   DEFINE l_dbaf003_end    LIKE dbaf_t.dbaf003 
   #end add-point  
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   LET lb_first = TRUE
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
   
   WHILE TRUE
      
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_dbaf_m.* TO NULL
         CALL g_dbaf_d.clear()
         CALL g_dbaf2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL adbi255_init()
      END IF
 
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
        
         DISPLAY ARRAY g_dbaf_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL adbi255_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL adbi255_ui_detailshow()
               
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
               LET g_curr_diag = ui.DIALOG.getCurrent()  #151224-00006#1 Add By Ken 160304
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL adbi255_chk_idx()
            #end add-point
               
         END DISPLAY
        
         DISPLAY ARRAY g_dbaf2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL adbi255_idx_chk()
               CALL adbi255_ui_detailshow()
               
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
               LET g_curr_diag = ui.DIALOG.getCurrent()  #151224-00006#1 Add By Ken 160304
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL adbi255_chk_idx()
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_dbaf3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)           
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx3 = l_ac
               DISPLAY g_detail_idx3 TO FORMONLY.idx
               CALL adbi255_ui_detailshow()

            BEFORE DISPLAY 
               CALL FGL_SET_ARR_CURR(g_detail_idx3)  
               LET g_curr_diag = ui.DIALOG.getCurrent()  #151224-00006#1 Add By Ken 160304
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL adbi255_chk_idx()               
         END DISPLAY
        
         DISPLAY ARRAY g_dbaf4_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_detail_idx4 = l_ac
               DISPLAY g_detail_idx4 TO FORMONLY.idx
               CALL adbi255_ui_detailshow()
            BEFORE DISPLAY 
               CALL FGL_SET_ARR_CURR(g_detail_idx4)  
               LET g_curr_diag = ui.DIALOG.getCurrent()  #151224-00006#1 Add By Ken 160304
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL adbi255_chk_idx()               
         END DISPLAY        
         #end add-point
         
         
         BEFORE DIALOG
            #先填充browser資料
            CALL adbi255_browser_fill("")
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
               CALL adbi255_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL adbi255_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
            IF NOT cl_null(g_set_page) THEN
               CASE g_set_page
                  WHEN "s_detail1"
                     NEXT FIELD dbafstus 
                     CALL FGL_SET_ARR_CURR(g_detail_idx)      
                  #WHEN "s_detail2"
                  #   NEXT FIELD dbaf003_2   
                  #   CALL FGL_SET_ARR_CURR(g_detail_idx2)       
                  WHEN "s_detail3"
                     NEXT FIELD dbafstus1 
                     CALL FGL_SET_ARR_CURR(g_detail_idx3)      
                  #WHEN "s_detail4"
                  #   NEXT FIELD dbaf003_3  
                  #   CALL FGL_SET_ARR_CURR(g_detail_idx4)                     
               END CASE             
               
            END IF
            #end add-point
 
         
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL adbi255_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adbi255_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL adbi255_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adbi255_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL adbi255_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adbi255_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL adbi255_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adbi255_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL adbi255_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adbi255_idx_chk()
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
                  LET g_export_node[1] = base.typeInfo.create(g_dbaf_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_dbaf2_d)
                  LET g_export_id[2]   = "s_detail2"
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  LET g_export_node[3] = base.typeInfo.create(g_dbaf3_d)
                  LET g_export_id[3]   = "s_detail3"
                  LET g_export_node[4] = base.typeInfo.create(g_dbaf4_d)
                  LET g_export_id[4]   = "s_detail4"
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
               NEXT FIELD dbaf002
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
               CALL adbi255_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL adbi255_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL adbi255_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL adbi255_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL adbi255_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL adbi255_query()
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
         ON ACTION open_adbi255_01_1
            LET g_action_choice="open_adbi255_01_1"
            IF cl_auth_chk_act("open_adbi255_01_1") THEN
               
               #add-point:ON ACTION open_adbi255_01_1 name="menu.open_adbi255_01_1"
               CALL adbi255_01(g_dbaf_m.dbaf001,'1')   #給空值,確保主程式不會因為子程式時g_action_choice=exit而關閉
               CALL adbi255_b_fill(g_wc2)
               LET g_action_choice=''
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL adbi255_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL adbi255_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_adbi255_01_2
            LET g_action_choice="open_adbi255_01_2"
            IF cl_auth_chk_act("open_adbi255_01_2") THEN
               
               #add-point:ON ACTION open_adbi255_01_2 name="menu.open_adbi255_01_2"
               CALL adbi255_01(g_dbaf_m.dbaf001,'2')
               CALL adbi255_b_fill(g_wc3)
               LET g_action_choice=''   #給空值,確保主程式不會因為子程式時g_action_choice=exit而關閉
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION return_trip
            LET g_action_choice="return_trip"
            IF cl_auth_chk_act("return_trip") THEN
               
               #add-point:ON ACTION return_trip name="menu.return_trip"
               CALL adbi255_return_trip(2)
               CALL adbi255_b_fill(g_wc3)
               #END add-point
               
            END IF
 
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL adbi255_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL adbi255_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL adbi255_set_pk_array()
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
 
{<section id="adbi255.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION adbi255_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="adbi255.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION adbi255_browser_fill(ps_page_action)
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
 
   LET l_searchcol = "dbaf001"
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
      LET l_sub_sql = " SELECT DISTINCT dbaf001 ",
 
                      " FROM dbaf_t ",
                      " ",
                      " ", 
 
 
 
                      " WHERE dbafent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("dbaf_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT dbaf001 ",
 
                      " FROM dbaf_t ",
                      " ",
                      " ", 
 
 
                      " WHERE dbafent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("dbaf_t")
   END IF 
   
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
 
   #add-point:browser_fill,count前 name="browser_fill.before_count"
   IF g_wc2 <> " 1=1" OR NOT cl_null(g_wc2) THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT UNIQUE dbaf001 ", 
                      " FROM dbaf_t,dbad_t ",
                      " WHERE dbafent = dbadent AND dbaf003 = dbad001 ",
                      "   AND dbafent = '" ||g_enterprise|| "' AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("dbaf_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE dbaf001 ", 
                      " FROM dbaf_t ",
                      " WHERE dbafent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED, cl_sql_add_filter("dbaf_t")
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
      INITIALIZE g_dbaf_m.* TO NULL
      CALL g_dbaf_d.clear()        
      CALL g_dbaf2_d.clear() 
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.dbaf001 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.dbaf001",
                " FROM dbaf_t t0",
                #" ",
                " ",
 
 
 
                
                " WHERE t0.dbafent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("dbaf_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
   IF g_wc2 <> " 1=1" AND NOT cl_null(g_wc2) THEN 
      LET l_sub_sql  = "SELECT DISTINCT dbaf001 ",
                       " FROM dbaf_t,dbad_t ",
                       " WHERE dbafent = dbadent AND dbaf003 = dbad001 ",
                       "   AND dbafent = '" ||g_enterprise|| "' AND ", g_wc," AND ",g_wc2, cl_sql_add_filter("dbaf_t") 
   ELSE
      LET l_sub_sql  = "SELECT DISTINCT dbaf001 ",
                       " FROM dbaf_t ",
                       " WHERE dbafent = '" ||g_enterprise|| "' AND ", g_wc, cl_sql_add_filter("dbaf_t")
                 
   END IF
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"dbaf_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_dbaf001 
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
   
   IF cl_null(g_browser[g_cnt].b_dbaf001) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_dbaf_m.* TO NULL
      CALL g_dbaf_d.clear()
      CALL g_dbaf2_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
 
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL adbi255_fetch('')
   
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
 
{<section id="adbi255.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION adbi255_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_dbaf_m.dbaf001 = g_browser[g_current_idx].b_dbaf001   
 
   EXECUTE adbi255_master_referesh USING g_dbaf_m.dbaf001 INTO g_dbaf_m.dbaf001,g_dbaf_m.dbaf001_desc 
 
   CALL adbi255_show()
   
END FUNCTION
 
{</section>}
 
{<section id="adbi255.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION adbi255_ui_detailshow()
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
 
{<section id="adbi255.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION adbi255_ui_browser_refresh()
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
      IF g_browser[l_i].b_dbaf001 = g_dbaf_m.dbaf001 
 
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
 
{<section id="adbi255.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION adbi255_construct()
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
   INITIALIZE g_dbaf_m.* TO NULL
   CALL g_dbaf_d.clear()
   CALL g_dbaf2_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   CALL g_dbaf3_d.clear()
   CALL g_dbaf4_d.clear()
   INITIALIZE g_wc3 TO NULL
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON dbaf001
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
                 #Ctrlp:construct.c.dbaf001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbaf001
            #add-point:ON ACTION controlp INFIELD dbaf001 name="construct.c.dbaf001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_dbab001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbaf001  #顯示到畫面上
            NEXT FIELD dbaf001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbaf001
            #add-point:BEFORE FIELD dbaf001 name="construct.b.dbaf001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbaf001
            
            #add-point:AFTER FIELD dbaf001 name="construct.a.dbaf001"
            
            #END add-point
            
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON dbafstus,dbaf003,l_dbad002,l_dbad002_desc,dbaf011,dbaf012,dbaf013,dbaf014, 
          dbaf015,dbaf002,dbafownid,dbafowndp,dbafcrtid,dbafcrtdp,dbafcrtdt,dbafmodid,dbafmoddt
           FROM s_detail1[1].dbafstus,s_detail1[1].dbaf003,s_detail1[1].l_dbad002,s_detail1[1].l_dbad002_desc, 
               s_detail1[1].dbaf011,s_detail1[1].dbaf012,s_detail1[1].dbaf013,s_detail1[1].dbaf014,s_detail1[1].dbaf015, 
               s_detail1[1].dbaf002,s_detail2[1].dbafownid,s_detail2[1].dbafowndp,s_detail2[1].dbafcrtid, 
               s_detail2[1].dbafcrtdp,s_detail2[1].dbafcrtdt,s_detail2[1].dbafmodid,s_detail2[1].dbafmoddt 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<dbafcrtdt>>----
         AFTER FIELD dbafcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<dbafmoddt>>----
         AFTER FIELD dbafmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<dbafcnfdt>>----
         
         #----<<dbafpstdt>>----
 
 
 
           
         #單身一般欄位開窗相關處理
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbafstus
            #add-point:BEFORE FIELD dbafstus name="construct.b.page1.dbafstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbafstus
            
            #add-point:AFTER FIELD dbafstus name="construct.a.page1.dbafstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.dbafstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbafstus
            #add-point:ON ACTION controlp INFIELD dbafstus name="construct.c.page1.dbafstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.dbaf003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbaf003
            #add-point:ON ACTION controlp INFIELD dbaf003 name="construct.c.page1.dbaf003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_dbad001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbaf003  #顯示到畫面上
            NEXT FIELD dbaf003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbaf003
            #add-point:BEFORE FIELD dbaf003 name="construct.b.page1.dbaf003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbaf003
            
            #add-point:AFTER FIELD dbaf003 name="construct.a.page1.dbaf003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_dbad002
            #add-point:BEFORE FIELD l_dbad002 name="construct.b.page1.l_dbad002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_dbad002
            
            #add-point:AFTER FIELD l_dbad002 name="construct.a.page1.l_dbad002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_dbad002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_dbad002
            #add-point:ON ACTION controlp INFIELD l_dbad002 name="construct.c.page1.l_dbad002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_dbad002_desc
            #add-point:BEFORE FIELD l_dbad002_desc name="construct.b.page1.l_dbad002_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_dbad002_desc
            
            #add-point:AFTER FIELD l_dbad002_desc name="construct.a.page1.l_dbad002_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_dbad002_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_dbad002_desc
            #add-point:ON ACTION controlp INFIELD l_dbad002_desc name="construct.c.page1.l_dbad002_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbaf011
            #add-point:BEFORE FIELD dbaf011 name="construct.b.page1.dbaf011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbaf011
            
            #add-point:AFTER FIELD dbaf011 name="construct.a.page1.dbaf011"
   
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.dbaf011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbaf011
            #add-point:ON ACTION controlp INFIELD dbaf011 name="construct.c.page1.dbaf011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbaf012
            #add-point:BEFORE FIELD dbaf012 name="construct.b.page1.dbaf012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbaf012
            
            #add-point:AFTER FIELD dbaf012 name="construct.a.page1.dbaf012"
 
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.dbaf012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbaf012
            #add-point:ON ACTION controlp INFIELD dbaf012 name="construct.c.page1.dbaf012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbaf013
            #add-point:BEFORE FIELD dbaf013 name="construct.b.page1.dbaf013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbaf013
            
            #add-point:AFTER FIELD dbaf013 name="construct.a.page1.dbaf013"
 
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.dbaf013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbaf013
            #add-point:ON ACTION controlp INFIELD dbaf013 name="construct.c.page1.dbaf013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbaf014
            #add-point:BEFORE FIELD dbaf014 name="construct.b.page1.dbaf014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbaf014
            
            #add-point:AFTER FIELD dbaf014 name="construct.a.page1.dbaf014"
 
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.dbaf014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbaf014
            #add-point:ON ACTION controlp INFIELD dbaf014 name="construct.c.page1.dbaf014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbaf015
            #add-point:BEFORE FIELD dbaf015 name="construct.b.page1.dbaf015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbaf015
            
            #add-point:AFTER FIELD dbaf015 name="construct.a.page1.dbaf015"
 
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.dbaf015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbaf015
            #add-point:ON ACTION controlp INFIELD dbaf015 name="construct.c.page1.dbaf015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbaf002
            #add-point:BEFORE FIELD dbaf002 name="construct.b.page1.dbaf002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbaf002
            
            #add-point:AFTER FIELD dbaf002 name="construct.a.page1.dbaf002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.dbaf002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbaf002
            #add-point:ON ACTION controlp INFIELD dbaf002 name="construct.c.page1.dbaf002"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.dbafownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbafownid
            #add-point:ON ACTION controlp INFIELD dbafownid name="construct.c.page2.dbafownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbafownid  #顯示到畫面上
            NEXT FIELD dbafownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbafownid
            #add-point:BEFORE FIELD dbafownid name="construct.b.page2.dbafownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbafownid
            
            #add-point:AFTER FIELD dbafownid name="construct.a.page2.dbafownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.dbafowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbafowndp
            #add-point:ON ACTION controlp INFIELD dbafowndp name="construct.c.page2.dbafowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbafowndp  #顯示到畫面上
            NEXT FIELD dbafowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbafowndp
            #add-point:BEFORE FIELD dbafowndp name="construct.b.page2.dbafowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbafowndp
            
            #add-point:AFTER FIELD dbafowndp name="construct.a.page2.dbafowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.dbafcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbafcrtid
            #add-point:ON ACTION controlp INFIELD dbafcrtid name="construct.c.page2.dbafcrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbafcrtid  #顯示到畫面上
            NEXT FIELD dbafcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbafcrtid
            #add-point:BEFORE FIELD dbafcrtid name="construct.b.page2.dbafcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbafcrtid
            
            #add-point:AFTER FIELD dbafcrtid name="construct.a.page2.dbafcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.dbafcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbafcrtdp
            #add-point:ON ACTION controlp INFIELD dbafcrtdp name="construct.c.page2.dbafcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbafcrtdp  #顯示到畫面上
            NEXT FIELD dbafcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbafcrtdp
            #add-point:BEFORE FIELD dbafcrtdp name="construct.b.page2.dbafcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbafcrtdp
            
            #add-point:AFTER FIELD dbafcrtdp name="construct.a.page2.dbafcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbafcrtdt
            #add-point:BEFORE FIELD dbafcrtdt name="construct.b.page2.dbafcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.dbafmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbafmodid
            #add-point:ON ACTION controlp INFIELD dbafmodid name="construct.c.page2.dbafmodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbafmodid  #顯示到畫面上
            NEXT FIELD dbafmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbafmodid
            #add-point:BEFORE FIELD dbafmodid name="construct.b.page2.dbafmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbafmodid
            
            #add-point:AFTER FIELD dbafmodid name="construct.a.page2.dbafmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbafmoddt
            #add-point:BEFORE FIELD dbafmoddt name="construct.b.page2.dbafmoddt"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
  
 
  
      #add-point:cs段more_construct name="cs.more_construct"
      CONSTRUCT g_wc3_table1 ON dbafstus,dbaf003,dbad002,dbaf011,dbaf012,dbaf013,dbaf014,dbaf015,dbaf002, 
                                dbafownid,dbafowndp,dbafcrtid,dbafcrtdp,dbafcrtdt,dbafmodid,dbafmoddt
           FROM s_detail3[1].dbafstus1, s_detail3[1].dbaf0031,  s_detail3[1].dbad0021,  s_detail3[1].dbaf0111, 
                s_detail3[1].dbaf0121,  s_detail3[1].dbaf0131,  s_detail3[1].dbaf0141,  s_detail3[1].dbaf0151,  s_detail3[1].dbaf0021,
                s_detail4[1].dbafownid1,s_detail4[1].dbafowndp1,s_detail4[1].dbafcrtid1,s_detail4[1].dbafcrtdp1, 
                s_detail4[1].dbafcrtdt1,s_detail4[1].dbafmodid1,s_detail4[1].dbafmoddt1
         
         AFTER FIELD dbafcrtdt1
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
            
         AFTER FIELD dbafmoddt1
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         ON ACTION controlp INFIELD dbaf0031
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_dbad001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbaf0031 #顯示到畫面上
            NEXT FIELD dbaf0031                    #返回原欄位  
            
         ON ACTION controlp INFIELD dbad0021
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_dbac001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbad0021     #顯示到畫面上
            NEXT FIELD dbad0021    

         ON ACTION controlp INFIELD dbafownid1
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbafownid1   #顯示到畫面上
            NEXT FIELD dbafownid1                      #返回原欄位
            
         ON ACTION controlp INFIELD dbafowndp1
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooea001_1()                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbafowndp1    #顯示到畫面上
            NEXT FIELD dbafowndp1 
        
         ON ACTION controlp INFIELD dbafcrtid1
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbafcrtid1   #顯示到畫面上
            NEXT FIELD dbafcrtid1
            
         ON ACTION controlp INFIELD dbafcrtdp1
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooea001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbafcrtdp1     #顯示到畫面上
            NEXT FIELD dbafcrtdp1   
        
         ON ACTION controlp INFIELD dbafmodid1
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbafmodid1   #顯示到畫面上
            NEXT FIELD dbafmodid1
      END CONSTRUCT  
       
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
   LET g_wc3 = g_wc3_table1
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
 
{<section id="adbi255.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION adbi255_query()
   #add-point:query段define name="query.define_customerization"
   
   #end add-point   
   DEFINE ls_wc STRING
   #add-point:query段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="query.befroe_query"
   CALL g_dbaf3_d.clear()
   CALL g_dbaf4_d.clear()
   LET g_detail_idx3 = 1
   LET g_detail_idx4 = 1  
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
   CALL g_dbaf_d.clear()
   CALL g_dbaf2_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL adbi255_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL adbi255_browser_fill(g_wc)
      CALL adbi255_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL adbi255_browser_fill("F")
   
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
      CALL adbi255_fetch("F") 
   END IF
   
   CALL adbi255_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="adbi255.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION adbi255_fetch(p_flag)
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
   
   #CALL adbi255_browser_fill(p_flag)
   
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
   
   LET g_dbaf_m.dbaf001 = g_browser[g_current_idx].b_dbaf001
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE adbi255_master_referesh USING g_dbaf_m.dbaf001 INTO g_dbaf_m.dbaf001,g_dbaf_m.dbaf001_desc 
 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "dbaf_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_dbaf_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_dbaf_m_mask_o.* =  g_dbaf_m.*
   CALL adbi255_dbaf_t_mask()
   LET g_dbaf_m_mask_n.* =  g_dbaf_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL adbi255_set_act_visible()
   CALL adbi255_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_dbaf_m_t.* = g_dbaf_m.*
   LET g_dbaf_m_o.* = g_dbaf_m.*
   
   #重新顯示   
   CALL adbi255_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="adbi255.insert" >}
#+ 資料新增
PRIVATE FUNCTION adbi255_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   CALL g_dbaf3_d.clear()
   CALL g_dbaf4_d.clear()
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_dbaf_d.clear()
   CALL g_dbaf2_d.clear()
 
 
   INITIALIZE g_dbaf_m.* TO NULL             #DEFAULT 設定
   LET g_dbaf001_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
      
     
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point 
 
      CALL adbi255_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_dbaf_m.* TO NULL
         INITIALIZE g_dbaf_d TO NULL
         INITIALIZE g_dbaf2_d TO NULL
 
         CALL adbi255_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_dbaf_m.* = g_dbaf_m_t.*
         CALL adbi255_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_dbaf_d.clear()
      #CALL g_dbaf2_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      CALL g_dbaf3_d.clear()
      CALL g_dbaf4_d.clear()
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL adbi255_set_act_visible()
   CALL adbi255_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_dbaf001_t = g_dbaf_m.dbaf001
 
   
   #組合新增資料的條件
   LET g_add_browse = " dbafent = " ||g_enterprise|| " AND",
                      " dbaf001 = '", g_dbaf_m.dbaf001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL adbi255_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL adbi255_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE adbi255_master_referesh USING g_dbaf_m.dbaf001 INTO g_dbaf_m.dbaf001,g_dbaf_m.dbaf001_desc 
 
   
   #遮罩相關處理
   LET g_dbaf_m_mask_o.* =  g_dbaf_m.*
   CALL adbi255_dbaf_t_mask()
   LET g_dbaf_m_mask_n.* =  g_dbaf_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_dbaf_m.dbaf001,g_dbaf_m.dbaf001_desc,g_dbaf_m.f_dbaf011,g_dbaf_m.f_dbaf012,g_dbaf_m.f_dbaf013, 
       g_dbaf_m.f_dbaf014,g_dbaf_m.f_dbaf015,g_dbaf_m.f_dbaf0111,g_dbaf_m.f_dbaf0121,g_dbaf_m.f_dbaf0131, 
       g_dbaf_m.f_dbaf0141,g_dbaf_m.f_dbaf0151
   
   #功能已完成,通報訊息中心
   CALL adbi255_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="adbi255.modify" >}
#+ 資料修改
PRIVATE FUNCTION adbi255_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_dbaf_m.dbaf001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_dbaf001_t = g_dbaf_m.dbaf001
 
   CALL s_transaction_begin()
   
   OPEN adbi255_cl USING g_enterprise,g_dbaf_m.dbaf001
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN adbi255_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE adbi255_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE adbi255_master_referesh USING g_dbaf_m.dbaf001 INTO g_dbaf_m.dbaf001,g_dbaf_m.dbaf001_desc 
 
   
   #遮罩相關處理
   LET g_dbaf_m_mask_o.* =  g_dbaf_m.*
   CALL adbi255_dbaf_t_mask()
   LET g_dbaf_m_mask_n.* =  g_dbaf_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL adbi255_show()
   WHILE TRUE
      LET g_dbaf001_t = g_dbaf_m.dbaf001
 
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL adbi255_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_dbaf_m.* = g_dbaf_m_t.*
         CALL adbi255_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_dbaf_m.dbaf001 != g_dbaf001_t 
 
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
   CALL adbi255_set_act_visible()
   CALL adbi255_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " dbafent = " ||g_enterprise|| " AND",
                      " dbaf001 = '", g_dbaf_m.dbaf001, "' "
 
   #填到對應位置
   CALL adbi255_browser_fill("")
 
   CALL adbi255_idx_chk()
 
   CLOSE adbi255_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL adbi255_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="adbi255.input" >}
#+ 資料輸入
PRIVATE FUNCTION adbi255_input(p_cmd)
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
   DEFINE  l_dbaf004             LIKE dbaf_t.dbaf004 
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
   DISPLAY BY NAME g_dbaf_m.dbaf001,g_dbaf_m.dbaf001_desc,g_dbaf_m.f_dbaf011,g_dbaf_m.f_dbaf012,g_dbaf_m.f_dbaf013, 
       g_dbaf_m.f_dbaf014,g_dbaf_m.f_dbaf015,g_dbaf_m.f_dbaf0111,g_dbaf_m.f_dbaf0121,g_dbaf_m.f_dbaf0131, 
       g_dbaf_m.f_dbaf0141,g_dbaf_m.f_dbaf0151
   
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
   LET g_forupd_sql = "SELECT dbafstus,dbaf004,dbaf003,dbaf011,dbaf012,dbaf013,dbaf014,dbaf015,dbaf002, 
       dbaf003,dbaf002,dbafownid,dbafowndp,dbafcrtid,dbafcrtdp,dbafcrtdt,dbafmodid,dbafmoddt FROM dbaf_t  
       WHERE dbafent=? AND dbaf001=? AND dbaf002=? AND dbaf003=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE adbi255_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL adbi255_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL adbi255_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_dbaf_m.dbaf001
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="adbi255.input.head" >}
   
      #單頭段
      INPUT BY NAME g_dbaf_m.dbaf001 
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
         AFTER FIELD dbaf001
            
            #add-point:AFTER FIELD dbaf001 name="input.a.dbaf001"
            
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_dbaf_m.dbaf001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_dbaf_m.dbaf001 != g_dbaf001_t )) THEN 
                  #IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM dbaf_t WHERE "||"dbafent = '" ||g_enterprise|| "' AND "||"dbaf001 = '"||g_dbaf_m.dbaf001 ||"'",'std-00004',0) THEN 
                  #   NEXT FIELD CURRENT
                  #END IF
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_dbaf_m.dbaf001
                  #160318-00025#3--add--str
                  LET g_errshow = TRUE 
                  LET g_chkparam.err_str[1] = "adb-00027:sub-01302|adbi251|",cl_get_progname("adbi251",g_lang,"2"),"|:EXEPROGadbi251"
                  #160318-00025#3--add--end
                  IF cl_chk_exist("v_dbab001") THEN
                  ELSE
                     LET g_dbaf_m.dbaf001 = g_dbaf001_t
                     LET g_dbaf_m.dbaf001_desc = adbi255_dbaf001_ref(g_dbaf_m.dbaf001)
                     NEXT FIELD CURRENT
                  END IF   
               END IF
            END IF
            LET g_dbaf_m.dbaf001_desc = adbi255_dbaf001_ref(g_dbaf_m.dbaf001)
            DISPLAY BY NAME g_dbaf_m.dbaf001_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbaf001
            #add-point:BEFORE FIELD dbaf001 name="input.b.dbaf001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbaf001
            #add-point:ON CHANGE dbaf001 name="input.g.dbaf001"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.dbaf001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbaf001
            #add-point:ON ACTION controlp INFIELD dbaf001 name="input.c.dbaf001"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_dbaf_m.dbaf001             #給予default值
            LET g_qryparam.default2 = "" #g_dbaf_m.dbabl003 #說明(簡稱)
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_dbab001()                                #呼叫開窗

            LET g_dbaf_m.dbaf001 = g_qryparam.return1              
            #LET g_dbaf_m.dbabl003 = g_qryparam.return2 
            DISPLAY g_dbaf_m.dbaf001 TO dbaf001              #
            LET g_dbaf_m.dbaf001_desc = adbi255_dbaf001_ref(g_dbaf_m.dbaf001)
            DISPLAY BY NAME g_dbaf_m.dbaf001_desc 
            NEXT FIELD dbaf001                          #返回原欄位


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
            DISPLAY BY NAME g_dbaf_m.dbaf001             
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
            
               #將遮罩欄位還原
               CALL adbi255_dbaf_t_mask_restore('restore_mask_o')
            
               UPDATE dbaf_t SET (dbaf001) = (g_dbaf_m.dbaf001)
                WHERE dbafent = g_enterprise AND dbaf001 = g_dbaf001_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "dbaf_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "dbaf_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_dbaf_m.dbaf001
               LET gs_keys_bak[1] = g_dbaf001_t
               LET gs_keys[2] = g_dbaf_d[g_detail_idx].dbaf002
               LET gs_keys_bak[2] = g_dbaf_d_t.dbaf002
               LET gs_keys[3] = g_dbaf_d[g_detail_idx].dbaf003
               LET gs_keys_bak[3] = g_dbaf_d_t.dbaf003
               CALL adbi255_update_b('dbaf_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_dbaf_m_t)
                     #LET g_log2 = util.JSON.stringify(g_dbaf_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL adbi255_dbaf_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL adbi255_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_dbaf001_t = g_dbaf_m.dbaf001
 
           
           IF g_dbaf_d.getLength() = 0 THEN
              NEXT FIELD dbaf002
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="adbi255.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_dbaf_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_dbaf_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL adbi255_b_fill(g_wc2) #test 
            #如果一直都在單頭則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_detail_idx)
            END IF
            LET g_loc = 'm' 
            LET g_current_page = 1
            #add-point:資料輸入前 name="input.body.before_input"
            LET g_rec_b = g_dbaf_d.getLength()
            LET g_curr_diag = ui.DIALOG.getCurrent()  #151224-00006#1 Add By Ken 160304
            LET g_aw = g_curr_diag.getCurrentItem()
            #151224-00006#1 Add By Ken 151229(S)
            SELECT COUNT(*) INTO l_cnt         
              FROM dbaf_t
             WHERE dbafent = g_enterprise
               AND dbaf001 = g_dbaf_m.dbaf001
            IF l_cnt = 0 THEN                 #不存在adbi255中
               SELECT COUNT(*) INTO l_cnt 
                 FROM dbac_t,dbad_t 
                WHERE dbacent = dbadent 
                  AND dbac001 = dbad002 
                  AND dbacstus = 'Y' 
                  AND dbadstus = 'Y' 
                  AND dbac002 = g_dbaf_m.dbaf001
               IF l_cnt > 0 THEN             #需存在adbi252,adbi253中 
                  IF cl_ask_confirm('adb-00430') THEN
                     CALL adbi255_default_dbad001(g_dbaf_m.dbaf001)
                     CALL adbi255_b_fill(g_wc2)
                     CALL adbi255_b_fill2('0')
                     LET INT_FLAG = 0                     
                  END IF
               END IF
            END IF
            #151224-00006#1 Add By Ken 151229(E)
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
            CALL adbi255_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN adbi255_cl USING g_enterprise,g_dbaf_m.dbaf001                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE adbi255_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN adbi255_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_dbaf_d[l_ac].dbaf002 IS NOT NULL
               AND g_dbaf_d[l_ac].dbaf003 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_dbaf_d_t.* = g_dbaf_d[l_ac].*  #BACKUP
               LET g_dbaf_d_o.* = g_dbaf_d[l_ac].*  #BACKUP
               CALL adbi255_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL adbi255_set_no_entry_b(l_cmd)
               OPEN adbi255_bcl USING g_enterprise,g_dbaf_m.dbaf001,
 
                                                g_dbaf_d_t.dbaf002
                                                ,g_dbaf_d_t.dbaf003
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN adbi255_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH adbi255_bcl INTO g_dbaf_d[l_ac].dbafstus,g_dbaf_d[l_ac].dbaf004,g_dbaf_d[l_ac].dbaf003, 
                      g_dbaf_d[l_ac].dbaf011,g_dbaf_d[l_ac].dbaf012,g_dbaf_d[l_ac].dbaf013,g_dbaf_d[l_ac].dbaf014, 
                      g_dbaf_d[l_ac].dbaf015,g_dbaf_d[l_ac].dbaf002,g_dbaf2_d[l_ac].dbaf003,g_dbaf2_d[l_ac].dbaf002, 
                      g_dbaf2_d[l_ac].dbafownid,g_dbaf2_d[l_ac].dbafowndp,g_dbaf2_d[l_ac].dbafcrtid, 
                      g_dbaf2_d[l_ac].dbafcrtdp,g_dbaf2_d[l_ac].dbafcrtdt,g_dbaf2_d[l_ac].dbafmodid, 
                      g_dbaf2_d[l_ac].dbafmoddt
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_dbaf_d_t.dbaf002,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_dbaf_d_mask_o[l_ac].* =  g_dbaf_d[l_ac].*
                  CALL adbi255_dbaf_t_mask()
                  LET g_dbaf_d_mask_n[l_ac].* =  g_dbaf_d[l_ac].*
                  
                  CALL adbi255_ref_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            LET g_rec_b = g_dbaf_d.getLength()
            #end add-point  
            
 
 
        
         BEFORE INSERT
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            INITIALIZE g_dbaf_d_t.* TO NULL
            INITIALIZE g_dbaf_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_dbaf_d[l_ac].* TO NULL
            #公用欄位預設值
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_dbaf2_d[l_ac].dbafownid = g_user
      LET g_dbaf2_d[l_ac].dbafowndp = g_dept
      LET g_dbaf2_d[l_ac].dbafcrtid = g_user
      LET g_dbaf2_d[l_ac].dbafcrtdp = g_dept 
      LET g_dbaf2_d[l_ac].dbafcrtdt = cl_get_current()
      LET g_dbaf2_d[l_ac].dbafmodid = g_user
      LET g_dbaf2_d[l_ac].dbafmoddt = cl_get_current()
      LET g_dbaf_d[l_ac].dbafstus = ''
 
 
  
            #一般欄位預設值
                  LET g_dbaf_d[l_ac].dbafstus = "Y"
      LET g_dbaf_d[l_ac].dbaf002 = "1"
 
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            
            #end add-point
            LET g_dbaf_d_t.* = g_dbaf_d[l_ac].*     #新輸入資料
            LET g_dbaf_d_o.* = g_dbaf_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL adbi255_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            #IF l_ac <= g_rec_b THEN
            #   FOR l_i = l_ac + 1 TO g_dbaf_d.getLength()      #從插入列的下一列更新路線順序
            #      LET l_dbaf004 = g_dbaf_d[l_i].dbaf004    
            #      LET g_dbaf_d[l_i].dbaf004 = l_dbaf004 + 1
            #      IF l_i > g_dbaf_d.getLength() THEN
            #         EXIT FOR
            #      END IF
            #   END FOR          
            #END IF
            CALL adbi255_redisplay_dbaf004('u',l_ac)
            LET g_dbaf_d[l_ac].dbaf004 = l_ac - 1
            IF g_dbaf_d[l_ac].dbaf004 = 0 THEN
               LET g_dbaf_d[l_ac].dbaf011 = 0 
               LET g_dbaf_d[l_ac].dbaf012 = 0
               LET g_dbaf_d[l_ac].dbaf013 = 0
               LET g_dbaf_d[l_ac].dbaf014 = 0
               LET g_dbaf_d[l_ac].dbaf015 = 0
            END IF
            #end add-point
            CALL adbi255_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_dbaf_d[li_reproduce_target].* = g_dbaf_d[li_reproduce].*
               LET g_dbaf2_d[li_reproduce_target].* = g_dbaf2_d[li_reproduce].*
 
               LET g_dbaf_d[g_dbaf_d.getLength()].dbaf002 = NULL
               LET g_dbaf_d[g_dbaf_d.getLength()].dbaf003 = NULL
 
            END IF
            
 
 
            #add-point:modify段before insert name="input.body.before_insert"
            LET g_dbaf_d_t.* = g_dbaf_d[l_ac].*
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
            SELECT COUNT(1) INTO l_count FROM dbaf_t 
             WHERE dbafent = g_enterprise AND dbaf001 = g_dbaf_m.dbaf001
 
               AND dbaf002 = g_dbaf_d[l_ac].dbaf002
               AND dbaf003 = g_dbaf_d[l_ac].dbaf003
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               IF l_ac <= g_rec_b THEN
                  UPDATE dbaf_t
                     SET dbaf004 = dbaf004 + 1 
                   WHERE dbafent = g_enterprise
                     AND dbaf001 = g_dbaf_m.dbaf001
                     AND dbaf002 = g_dbaf_d[l_ac].dbaf002
                     AND dbaf004 >= l_ac - 1
               END IF 
               #end add-point
               INSERT INTO dbaf_t
                           (dbafent,
                            dbaf001,
                            dbaf002,dbaf003
                            ,dbafstus,dbaf004,dbaf011,dbaf012,dbaf013,dbaf014,dbaf015,dbafownid,dbafowndp,dbafcrtid,dbafcrtdp,dbafcrtdt,dbafmodid,dbafmoddt) 
                     VALUES(g_enterprise,
                            g_dbaf_m.dbaf001,
                            g_dbaf_d[l_ac].dbaf002,g_dbaf_d[l_ac].dbaf003
                            ,g_dbaf_d[l_ac].dbafstus,g_dbaf_d[l_ac].dbaf004,g_dbaf_d[l_ac].dbaf011,g_dbaf_d[l_ac].dbaf012, 
                                g_dbaf_d[l_ac].dbaf013,g_dbaf_d[l_ac].dbaf014,g_dbaf_d[l_ac].dbaf015, 
                                g_dbaf2_d[l_ac].dbafownid,g_dbaf2_d[l_ac].dbafowndp,g_dbaf2_d[l_ac].dbafcrtid, 
                                g_dbaf2_d[l_ac].dbafcrtdp,g_dbaf2_d[l_ac].dbafcrtdt,g_dbaf2_d[l_ac].dbafmodid, 
                                g_dbaf2_d[l_ac].dbafmoddt)
               #add-point:單身新增中 name="input.body.m_insert"
               
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_dbaf_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "dbaf_t:",SQLERRMESSAGE 
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
            CALL adbi255_get_amount(g_dbaf_m.dbaf001)
            #end add-point
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               #add-point:單身刪除前 name="input.body.b_delete"
               #IF l_ac <= g_rec_b THEN
               #   FOR l_i = l_ac TO g_dbaf_d.getLength()      #從刪除列更新路線順序
               #      LET l_dbaf004 = g_dbaf_d[l_i].dbaf004    
               #      LET g_dbaf_d[l_i].dbaf004 = l_dbaf004 - 1
               #      IF l_i > g_dbaf_d.getLength() THEN
               #         EXIT FOR
               #      END IF
               #   END FOR          
               #END IF
               CALL adbi255_redisplay_dbaf004('d',l_ac)
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
               IF adbi255_before_delete() THEN 
                  
 
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_dbaf_m.dbaf001
 
                  LET gs_keys[gs_keys.getLength()+1] = g_dbaf_d_t.dbaf002
                  LET gs_keys[gs_keys.getLength()+1] = g_dbaf_d_t.dbaf003
 
 
                  #刪除下層單身
                  IF NOT adbi255_key_delete_b(gs_keys,'dbaf_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE adbi255_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE adbi255_bcl
               LET l_count = g_dbaf_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
            CALL adbi255_get_amount(g_dbaf_m.dbaf001)
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_dbaf_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbafstus
            #add-point:BEFORE FIELD dbafstus name="input.b.page1.dbafstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbafstus
            
            #add-point:AFTER FIELD dbafstus name="input.a.page1.dbafstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbafstus
            #add-point:ON CHANGE dbafstus name="input.g.page1.dbafstus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbaf004
            #add-point:BEFORE FIELD dbaf004 name="input.b.page1.dbaf004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbaf004
            
            #add-point:AFTER FIELD dbaf004 name="input.a.page1.dbaf004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbaf004
            #add-point:ON CHANGE dbaf004 name="input.g.page1.dbaf004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbaf003
            
            #add-point:AFTER FIELD dbaf003 name="input.a.page1.dbaf003"
            #此段落由子樣板a05產生
            IF  g_dbaf_m.dbaf001 IS NOT NULL AND g_dbaf_d[g_detail_idx].dbaf002 IS NOT NULL AND g_dbaf_d[g_detail_idx].dbaf003 IS NOT NULL THEN 
                #IF l_cmd = 'a' OR ( l_cmd = 'u' AND g_dbaf_d[g_detail_idx].dbaf003 != g_dbaf_d_t.dbaf003) THEN   #160824-00007#9 Mark By Ken 160830
                IF (g_dbaf_d[g_detail_idx].dbaf003 != g_dbaf_d_o.dbaf003 OR g_dbaf_d_o.dbaf003 IS NULL)  THEN    #160824-00007#9 Add By Ken 160830
                   IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM dbaf_t WHERE "||"dbafent = '" ||g_enterprise|| "' AND "||"dbaf001 = '"||g_dbaf_m.dbaf001 ||"' AND "|| "dbaf002 = '"||g_dbaf_d[g_detail_idx].dbaf002 ||"' AND "|| "dbaf003 = '"||g_dbaf_d[g_detail_idx].dbaf003 ||"'",'std-00004',0) THEN
                      NEXT FIELD CURRENT                       
                   END IF
                   
                   IF adbi255_chk_dbaf003(g_dbaf_m.dbaf001,g_dbaf_d[g_detail_idx].dbaf002,g_dbaf_d[g_detail_idx].dbaf003) THEN                  
                      LET g_dbaf_d[g_detail_idx].l_dbad002 = adbi255_get_dbad002(g_dbaf_d[g_detail_idx].dbaf003)   
                      LET g_dbaf_d[g_detail_idx].l_dbad002_desc = adbi255_dbad002_ref( g_dbaf_d[g_detail_idx].l_dbad002) 
                   ELSE
                      #LET g_dbaf_d[g_detail_idx].dbaf003 = g_dbaf_d_t.dbaf003  #160824-00007#9 Mark By Ken 160830
                      LET g_dbaf_d[g_detail_idx].dbaf003 = g_dbaf_d_o.dbaf003   #160824-00007#9 Add By Ken 160830               
                      LET g_dbaf_d[g_detail_idx].dbaf003_desc = adbi255_dbaf003_ref(g_dbaf_d[g_detail_idx].dbaf003)
                      LET g_dbaf_d[g_detail_idx].l_dbad002 = adbi255_get_dbad002(g_dbaf_d[g_detail_idx].dbaf003)   
                      LET g_dbaf_d[g_detail_idx].l_dbad002_desc = adbi255_dbad002_ref( g_dbaf_d[g_detail_idx].l_dbad002_desc) 
                      DISPLAY BY NAME g_dbaf_d[g_detail_idx].dbaf003,g_dbaf_d[g_detail_idx].dbaf003_desc,
                                      g_dbaf_d[g_detail_idx].l_dbad002,g_dbaf_d[g_detail_idx].l_dbad002_desc                  
                      NEXT FIELD CURRENT    
                   END IF 
                END IF   
            END IF
            LET g_dbaf_d[g_detail_idx].dbaf003_desc = adbi255_dbaf003_ref(g_dbaf_d[g_detail_idx].dbaf003)
            LET g_dbaf_d[g_detail_idx].l_dbad002= adbi255_get_dbad002(g_dbaf_d[g_detail_idx].dbaf003)   
            LET g_dbaf_d[g_detail_idx].l_dbad002_desc = adbi255_dbad002_ref( g_dbaf_d[g_detail_idx].l_dbad002 ) 
            DISPLAY BY NAME g_dbaf_d[g_detail_idx].dbaf003,g_dbaf_d[g_detail_idx].dbaf003_desc,
                  g_dbaf_d[g_detail_idx].l_dbad002,g_dbaf_d[g_detail_idx].l_dbad002_desc 
            LET g_dbaf_d_o.* = g_dbaf_d[g_detail_idx].*  #160824-00007#9 Add By Ken 160830                  
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbaf003
            #add-point:BEFORE FIELD dbaf003 name="input.b.page1.dbaf003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbaf003
            #add-point:ON CHANGE dbaf003 name="input.g.page1.dbaf003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbaf011
            #add-point:BEFORE FIELD dbaf011 name="input.b.page1.dbaf011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbaf011
            
            #add-point:AFTER FIELD dbaf011 name="input.a.page1.dbaf011"
            IF NOT cl_null(g_dbaf_d[l_ac].dbaf011) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND g_dbaf_d[l_ac].dbaf011 != g_dbaf_d_t.dbaf011) THEN
                  IF g_dbaf_d[l_ac].dbaf011 < 0 THEN
                     LET g_dbaf_d[l_ac].dbaf011 = g_dbaf_d_t.dbaf011
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aim-00003'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD dbaf011
                  END IF   
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbaf011
            #add-point:ON CHANGE dbaf011 name="input.g.page1.dbaf011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbaf012
            #add-point:BEFORE FIELD dbaf012 name="input.b.page1.dbaf012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbaf012
            
            #add-point:AFTER FIELD dbaf012 name="input.a.page1.dbaf012"
            IF NOT cl_null(g_dbaf_d[l_ac].dbaf012) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND g_dbaf_d[l_ac].dbaf012 != g_dbaf_d_t.dbaf012) THEN
                  IF g_dbaf_d[l_ac].dbaf012 < 0 THEN
                     LET g_dbaf_d[l_ac].dbaf012 = g_dbaf_d_t.dbaf012
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aim-00003'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD dbaf012
                  END IF   
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbaf012
            #add-point:ON CHANGE dbaf012 name="input.g.page1.dbaf012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbaf013
            #add-point:BEFORE FIELD dbaf013 name="input.b.page1.dbaf013"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbaf013
            
            #add-point:AFTER FIELD dbaf013 name="input.a.page1.dbaf013"
            IF NOT cl_null(g_dbaf_d[l_ac].dbaf013) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND g_dbaf_d[l_ac].dbaf013 != g_dbaf_d_t.dbaf013) THEN
                  IF g_dbaf_d[l_ac].dbaf013 < 0 THEN
                     LET g_dbaf_d[l_ac].dbaf013 = g_dbaf_d_t.dbaf013
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aim-00003'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD dbaf013
                  END IF   
               END IF
               CALL adbi255_default_dbaf015()
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbaf013
            #add-point:ON CHANGE dbaf013 name="input.g.page1.dbaf013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbaf014
            #add-point:BEFORE FIELD dbaf014 name="input.b.page1.dbaf014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbaf014
            
            #add-point:AFTER FIELD dbaf014 name="input.a.page1.dbaf014"
            IF NOT cl_null(g_dbaf_d[l_ac].dbaf014) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND g_dbaf_d[l_ac].dbaf014 != g_dbaf_d_t.dbaf014) THEN
                  IF g_dbaf_d[l_ac].dbaf014 < 0 THEN
                     LET g_dbaf_d[l_ac].dbaf014 = g_dbaf_d_t.dbaf014
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aim-00003'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD dbaf014
                  END IF   
               END IF
               CALL adbi255_default_dbaf015()
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbaf014
            #add-point:ON CHANGE dbaf014 name="input.g.page1.dbaf014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbaf015
            #add-point:BEFORE FIELD dbaf015 name="input.b.page1.dbaf015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbaf015
            
            #add-point:AFTER FIELD dbaf015 name="input.a.page1.dbaf015"
            IF NOT cl_null(g_dbaf_d[l_ac].dbaf015) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND g_dbaf_d[l_ac].dbaf015 != g_dbaf_d_t.dbaf015) THEN
                  IF g_dbaf_d[l_ac].dbaf015 < 0 THEN
                     LET g_dbaf_d[l_ac].dbaf015 = g_dbaf_d_t.dbaf015
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aim-00003'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD dbaf015
                  END IF   
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbaf015
            #add-point:ON CHANGE dbaf015 name="input.g.page1.dbaf015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbaf002
            #add-point:BEFORE FIELD dbaf002 name="input.b.page1.dbaf002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbaf002
            
            #add-point:AFTER FIELD dbaf002 name="input.a.page1.dbaf002"
            #此段落由子樣板a05產生
            IF  g_dbaf_m.dbaf001 IS NOT NULL AND g_dbaf_d[g_detail_idx].dbaf002 IS NOT NULL AND g_dbaf_d[g_detail_idx].dbaf003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_dbaf_m.dbaf001 != g_dbaf001_t OR g_dbaf_d[g_detail_idx].dbaf002 != g_dbaf_d_t.dbaf002 OR g_dbaf_d[g_detail_idx].dbaf003 != g_dbaf_d_t.dbaf003)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM dbaf_t WHERE "||"dbafent = '" ||g_enterprise|| "' AND "||"dbaf001 = '"||g_dbaf_m.dbaf001 ||"' AND "|| "dbaf002 = '"||g_dbaf_d[g_detail_idx].dbaf002 ||"' AND "|| "dbaf003 = '"||g_dbaf_d[g_detail_idx].dbaf003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbaf002
            #add-point:ON CHANGE dbaf002 name="input.g.page1.dbaf002"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.dbafstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbafstus
            #add-point:ON ACTION controlp INFIELD dbafstus name="input.c.page1.dbafstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.dbaf004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbaf004
            #add-point:ON ACTION controlp INFIELD dbaf004 name="input.c.page1.dbaf004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.dbaf003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbaf003
            #add-point:ON ACTION controlp INFIELD dbaf003 name="input.c.page1.dbaf003"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_dbaf_d[l_ac].dbaf003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_dbad001()                                #呼叫開窗

            LET g_dbaf_d[l_ac].dbaf003 = g_qryparam.return1              

            DISPLAY g_dbaf_d[l_ac].dbaf003 TO dbaf003              #
            LET g_dbaf_d[g_detail_idx].dbaf003_desc = adbi255_dbaf003_ref(g_dbaf_d[g_detail_idx].dbaf003)
            LET g_dbaf_d[g_detail_idx].l_dbad002 = adbi255_get_dbad002(g_dbaf_d[g_detail_idx].dbaf003)   
            LET g_dbaf_d[g_detail_idx].l_dbad002_desc = adbi255_dbad002_ref( g_dbaf_d[g_detail_idx].l_dbad002) 
            NEXT FIELD dbaf003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.dbaf011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbaf011
            #add-point:ON ACTION controlp INFIELD dbaf011 name="input.c.page1.dbaf011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.dbaf012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbaf012
            #add-point:ON ACTION controlp INFIELD dbaf012 name="input.c.page1.dbaf012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.dbaf013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbaf013
            #add-point:ON ACTION controlp INFIELD dbaf013 name="input.c.page1.dbaf013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.dbaf014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbaf014
            #add-point:ON ACTION controlp INFIELD dbaf014 name="input.c.page1.dbaf014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.dbaf015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbaf015
            #add-point:ON ACTION controlp INFIELD dbaf015 name="input.c.page1.dbaf015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.dbaf002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbaf002
            #add-point:ON ACTION controlp INFIELD dbaf002 name="input.c.page1.dbaf002"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_dbaf_d[l_ac].* = g_dbaf_d_t.*
               CLOSE adbi255_bcl
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
               LET g_errparam.extend = g_dbaf_d[l_ac].dbaf002 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_dbaf_d[l_ac].* = g_dbaf_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               LET g_dbaf2_d[l_ac].dbafmodid = g_user 
LET g_dbaf2_d[l_ac].dbafmoddt = cl_get_current()
LET g_dbaf2_d[l_ac].dbafmodid_desc = cl_get_username(g_dbaf2_d[l_ac].dbafmodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
         
               #將遮罩欄位還原
               CALL adbi255_dbaf_t_mask_restore('restore_mask_o')
         
               UPDATE dbaf_t SET (dbaf001,dbafstus,dbaf004,dbaf003,dbaf011,dbaf012,dbaf013,dbaf014,dbaf015, 
                   dbaf002,dbafownid,dbafowndp,dbafcrtid,dbafcrtdp,dbafcrtdt,dbafmodid,dbafmoddt) = (g_dbaf_m.dbaf001, 
                   g_dbaf_d[l_ac].dbafstus,g_dbaf_d[l_ac].dbaf004,g_dbaf_d[l_ac].dbaf003,g_dbaf_d[l_ac].dbaf011, 
                   g_dbaf_d[l_ac].dbaf012,g_dbaf_d[l_ac].dbaf013,g_dbaf_d[l_ac].dbaf014,g_dbaf_d[l_ac].dbaf015, 
                   g_dbaf_d[l_ac].dbaf002,g_dbaf2_d[l_ac].dbafownid,g_dbaf2_d[l_ac].dbafowndp,g_dbaf2_d[l_ac].dbafcrtid, 
                   g_dbaf2_d[l_ac].dbafcrtdp,g_dbaf2_d[l_ac].dbafcrtdt,g_dbaf2_d[l_ac].dbafmodid,g_dbaf2_d[l_ac].dbafmoddt) 
 
                WHERE dbafent = g_enterprise AND dbaf001 = g_dbaf_m.dbaf001 
 
                 AND dbaf002 = g_dbaf_d_t.dbaf002 #項次   
                 AND dbaf003 = g_dbaf_d_t.dbaf003  
 
                 
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "dbaf_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "dbaf_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_dbaf_m.dbaf001
               LET gs_keys_bak[1] = g_dbaf001_t
               LET gs_keys[2] = g_dbaf_d[g_detail_idx].dbaf002
               LET gs_keys_bak[2] = g_dbaf_d_t.dbaf002
               LET gs_keys[3] = g_dbaf_d[g_detail_idx].dbaf003
               LET gs_keys_bak[3] = g_dbaf_d_t.dbaf003
               CALL adbi255_update_b('dbaf_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_dbaf_m),util.JSON.stringify(g_dbaf_d_t)
                     LET g_log2 = util.JSON.stringify(g_dbaf_m),util.JSON.stringify(g_dbaf_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL adbi255_dbaf_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_dbaf_m.dbaf001
 
               LET ls_keys[ls_keys.getLength()+1] = g_dbaf_d_t.dbaf002
               LET ls_keys[ls_keys.getLength()+1] = g_dbaf_d_t.dbaf003
 
               CALL adbi255_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               CALL adbi255_get_amount(g_dbaf_m.dbaf001)
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE adbi255_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_dbaf_d[l_ac].* = g_dbaf_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE adbi255_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_dbaf_d.getLength() = 0 THEN
               NEXT FIELD dbaf002
            END IF
            #add-point:input段after input  name="input.body.after_input"
            CALL adbi255_return_trip(1)
            LET g_set_page = g_aw
            LET g_detail_idx = l_ac
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_dbaf_d[li_reproduce_target].* = g_dbaf_d[li_reproduce].*
               LET g_dbaf2_d[li_reproduce_target].* = g_dbaf2_d[li_reproduce].*
 
               LET g_dbaf_d[li_reproduce_target].dbaf002 = NULL
               LET g_dbaf_d[li_reproduce_target].dbaf003 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_dbaf_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_dbaf_d.getLength()+1
            END IF
            
      END INPUT
 
 
      
      DISPLAY ARRAY g_dbaf2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
      
         BEFORE ROW
            CALL adbi255_b_fill(g_wc2) #test 
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_page = 2
            CALL adbi255_idx_chk()
            CALL adbi255_ui_detailshow()
        
         BEFORE DISPLAY 
            CALL FGL_SET_ARR_CURR(g_detail_idx)      
         
         #add-point:page2自定義行為 name="input.body2.action"
         
         #end add-point
         
      END DISPLAY
 
      
 
      
 
    
      #add-point:input段more_input name="input.more_inputarray"
      #回程資料維護
      INPUT ARRAY g_dbaf3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b, MAXCOUNT = g_max_rec, WITHOUT DEFAULTS, 
                   INSERT ROW = l_allow_insert, 
                   DELETE ROW = l_allow_delete,
                   APPEND ROW = l_allow_insert)                 
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_dbaf3_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
           CALL adbi255_b_fill(g_wc3) 
           IF g_rec_b != 0 THEN             
              CALL fgl_set_arr_curr(l_ac)
           END IF
           
           LET g_rec_b = g_dbaf3_d.getLength()
           LET g_curr_diag = ui.DIALOG.getCurrent()  #151224-00006#1 Add By Ken 160304
           LET g_aw = g_curr_diag.getCurrentItem()
           CALL adbi255_chk_idx()
 
         BEFORE ROW 
            LET l_insert = FALSE
            LET g_detail_idx3 = DIALOG.getCurrentRow("s_detail3")
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()            
            DISPLAY l_ac TO FORMONLY.idx
            CALL adbi255_set_entry_b(l_cmd)
            CALL adbi255_set_no_entry_b(l_cmd)
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN adbi255_cl USING g_enterprise,g_dbaf_m.dbaf001                                               
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  STATUS
                  LET g_errparam.extend = "OPEN adbi255_cl:"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CLOSE adbi255_cl
                  CALL s_transaction_end('N','0')
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            
            IF g_rec_b >= l_ac AND g_dbaf3_d[l_ac].dbaf0031 IS NOT NULL THEN 
               LET l_cmd='u'
               LET g_dbaf3_d_t.* = g_dbaf3_d[l_ac].*   #BACKUP
               #CALL adbi255_set_entry_b(l_cmd)
               #CALL adbi255_set_no_entry_b(l_cmd)
               CALL adbi255_set_no_entry_b(l_cmd)
               OPEN adbi255_bcl USING g_enterprise,g_dbaf_m.dbaf001, 
                                      g_dbaf3_d_t.dbaf0021,g_dbaf3_d_t.dbaf0031               
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  STATUS
                  LET g_errparam.extend = "OPEN adbi255_bcl:"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET l_lock_sw='Y'
               ELSE
                  FETCH adbi255_bcl INTO g_dbaf_d[l_ac].dbafstus,g_dbaf_d[l_ac].dbaf004,g_dbaf_d[l_ac].dbaf003, 
                      g_dbaf_d[l_ac].dbaf011,g_dbaf_d[l_ac].dbaf012,g_dbaf_d[l_ac].dbaf013,g_dbaf_d[l_ac].dbaf014, 
                      g_dbaf_d[l_ac].dbaf015,g_dbaf_d[l_ac].dbaf002,g_dbaf2_d[l_ac].dbaf003,g_dbaf2_d[l_ac].dbaf002, 
                      g_dbaf2_d[l_ac].dbafownid,g_dbaf2_d[l_ac].dbafowndp,g_dbaf2_d[l_ac].dbafcrtid, 
                      g_dbaf2_d[l_ac].dbafcrtdp,g_dbaf2_d[l_ac].dbafcrtdt,g_dbaf2_d[l_ac].dbafmodid, 
                      g_dbaf2_d[l_ac].dbafmoddt
                      
                   IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = SQLCA.sqlcode
                      LET g_errparam.extend = g_dbaf_d_t.dbaf002
                      LET g_errparam.popup = TRUE
                      CALL cl_err()

                      LET l_lock_sw = "Y"
                  END IF
                  
                  CALL adbi255_ref_show()
                  CALL cl_show_fld_cont()
               END IF            
            ELSE
               LET l_cmd='a'               
            END IF 
            
            LET g_rec_b = g_dbaf3_d.getLength()   
            CALL adbi255_chk_idx()            
             
         BEFORE INSERT            
            INITIALIZE g_dbaf3_d_t.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_dbaf3_d[l_ac].* TO NULL  
            
            CALL adbi255_redisplay_dbaf004('u',l_ac)
            
            LET g_dbaf4_d[l_ac].dbafownid1 = g_user
            LET g_dbaf4_d[l_ac].dbafowndp1 = g_dept
            LET g_dbaf4_d[l_ac].dbafcrtid1 = g_user
            LET g_dbaf4_d[l_ac].dbafcrtdp1 = g_dept 
            LET g_dbaf4_d[l_ac].dbafcrtdt1 = cl_get_current()
            LET g_dbaf4_d[l_ac].dbafmodid1 = ""
            LET g_dbaf4_d[l_ac].dbafmoddt1 = ""
            
            #一般欄位預設值
            LET g_dbaf3_d[l_ac].dbafstus1 = "Y"
            LET g_dbaf3_d[l_ac].dbaf0021 = "2"   
            LET g_dbaf3_d[l_ac].dbaf0041 = l_ac -1            
            IF g_dbaf3_d[l_ac].dbaf0041 = 0 THEN
               LET g_dbaf3_d[l_ac].dbaf0111 = 0 
               LET g_dbaf3_d[l_ac].dbaf0121 = 0
               LET g_dbaf3_d[l_ac].dbaf0131 = 0
               LET g_dbaf3_d[l_ac].dbaf0141 = 0
               LET g_dbaf3_d[l_ac].dbaf0151 = 0
            END IF             
            
            LET g_dbaf3_d_t.* = g_dbaf3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            #CALL adbi255_set_entry_b(l_cmd)
            #CALL adbi255_set_no_entry_b(l_cmd)
            
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_dbaf3_d[li_reproduce_target].* = g_dbaf3_d[li_reproduce].* 
               LET g_dbaf3_d[li_reproduce_target].dbaf0021 = NULL
               LET g_dbaf3_d[li_reproduce_target].dbaf0031 = NULL
            END IF

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
            SELECT COUNT(*) INTO l_count  
              FROM dbaf_t 
             WHERE dbafent = g_enterprise AND dbaf001 = g_dbaf_m.dbaf001 
               AND dbaf002 = g_dbaf3_d[l_ac].dbaf0021
               AND dbaf003 = g_dbaf3_d[l_ac].dbaf0031
               
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               
               INSERT INTO dbaf_t
                           (dbafent,dbaf001,dbaf002,dbaf003,dbaf004,
                            dbaf011,dbaf012,dbaf013,dbaf014,dbaf015,
                            dbafstus,dbafownid,dbafowndp,dbafcrtid,dbafcrtdp,
                            dbafcrtdt,dbafmodid,dbafmoddt) 
                     VALUES(g_enterprise,g_dbaf_m.dbaf001,g_dbaf3_d[l_ac].dbaf0021,g_dbaf3_d[l_ac].dbaf0031,g_dbaf3_d[l_ac].dbaf0041,
                            g_dbaf3_d[l_ac].dbaf0111,g_dbaf3_d[l_ac].dbaf0121,g_dbaf3_d[l_ac].dbaf0131,g_dbaf3_d[l_ac].dbaf0141,g_dbaf3_d[l_ac].dbaf0151, 
                            g_dbaf3_d[l_ac].dbafstus1,g_dbaf4_d[l_ac].dbafownid1,g_dbaf4_d[l_ac].dbafowndp1,g_dbaf4_d[l_ac].dbafcrtid1,g_dbaf4_d[l_ac].dbafcrtdp1,
                            g_dbaf4_d[l_ac].dbafcrtdt1,g_dbaf4_d[l_ac].dbafmodid1,g_dbaf4_d[l_ac].dbafmoddt1)
               LET p_cmd = 'u'
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_dbaf3_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "dbaf_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               CALL s_transaction_end('Y','0')
               ERROR "INSERT O.K"
               LET g_rec_b=g_rec_b+1
               DISPLAY g_rec_b TO FORMONLY.cnt
            END IF
            
            CALL adbi255_get_amount(g_dbaf_m.dbaf001)

         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' AND g_dbaf3_d.getLength() < l_ac THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_dbaf3_d.deleteElement(l_ac)
               NEXT FIELD dbaf0021
            END IF           
            
            IF g_dbaf3_d_t.dbaf0021 IS NOT NULL
               AND g_dbaf3_d_t.dbaf0031 IS NOT NULL
            THEN
            
               CALL adbi255_redisplay_dbaf004('d',l_ac)
               
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
               IF adbi255_before_delete() THEN
                  CALL s_transaction_end('Y','0')
               ELSE
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE
               END IF
               CLOSE adbi255_bcl
               LET l_count = g_dbaf_d.getLength()
            END IF

            CALL adbi255_get_amount(g_dbaf_m.dbaf001)
            
         AFTER DELETE 
 
         ON ROW CHANGE 
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_dbaf3_d[l_ac].* = g_dbaf3_d_t.*
               CLOSE adbi255_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_dbaf3_d[l_ac].dbaf0021
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_dbaf3_d[l_ac].* = g_dbaf3_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               LET g_dbaf4_d[l_ac].dbafmodid1 = g_user 
               LET g_dbaf4_d[l_ac].dbafmoddt1 = cl_get_current()
                        
               UPDATE dbaf_t 
                  SET dbafstus  = g_dbaf3_d[l_ac].dbafstus1,
                      dbaf003   = g_dbaf3_d[l_ac].dbaf0031,
                      dbaf004   = g_dbaf3_d[l_ac].dbaf0041,
                      dbaf011   = g_dbaf3_d[l_ac].dbaf0111,
                      dbaf012   = g_dbaf3_d[l_ac].dbaf0121,
                      dbaf013   = g_dbaf3_d[l_ac].dbaf0131,
                      dbaf014   = g_dbaf3_d[l_ac].dbaf0141,
                      dbaf015   = g_dbaf3_d[l_ac].dbaf0151, 
                      dbafmodid = g_dbaf4_d[l_ac].dbafmodid1,
                      dbafmoddt = g_dbaf4_d[l_ac].dbafmoddt1
                WHERE dbafent   = g_enterprise 
                  AND dbaf001   = g_dbaf_m.dbaf001  
                  AND dbaf002   = g_dbaf3_d_t.dbaf0021  
                  AND dbaf003   = g_dbaf3_d_t.dbaf0031  
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "dbaf_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                  OTHERWISE
                     INITIALIZE gs_keys TO NULL 
                     LET gs_keys[1] = g_dbaf_m.dbaf001
                     LET gs_keys_bak[1] = g_dbaf001_t
                     LET gs_keys[2] = g_dbaf_d[g_detail_idx].dbaf002
                     LET gs_keys_bak[2] = g_dbaf_d_t.dbaf002
                     LET gs_keys[3] = g_dbaf_d[g_detail_idx].dbaf003
                     LET gs_keys_bak[3] = g_dbaf_d_t.dbaf003
                     CALL adbi255_update_b('dbaf_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改                     
               END CASE
               
               CALL adbi255_get_amount(g_dbaf_m.dbaf001)
            END IF        
         
         AFTER FIELD dbaf0031
            IF  g_dbaf_m.dbaf001 IS NOT NULL AND g_dbaf3_d[l_ac].dbaf0021 IS NOT NULL AND g_dbaf3_d[l_ac].dbaf0031 IS NOT NULL THEN 
                IF l_cmd = 'a' OR ( l_cmd = 'u' AND g_dbaf3_d[l_ac].dbaf0031 != g_dbaf3_d_t.dbaf0031) THEN   
                   IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM dbaf_t WHERE "||"dbafent = '" ||g_enterprise|| "' AND "||"dbaf001 = '"||g_dbaf_m.dbaf001 ||"' AND "|| "dbaf002 = '"||g_dbaf3_d[l_ac].dbaf0021 ||"' AND "|| "dbaf003 = '"||g_dbaf3_d[l_ac].dbaf0031 ||"'",'std-00004',0) THEN
                      NEXT FIELD CURRENT                       
                   END IF
                   
                   IF adbi255_chk_dbaf003(g_dbaf_m.dbaf001,g_dbaf3_d[l_ac].dbaf0021,g_dbaf3_d[l_ac].dbaf0031) THEN                  
                      LET g_dbaf3_d[l_ac].l_dbad0021      = adbi255_get_dbad002(g_dbaf3_d[l_ac].dbaf0031)   
                      LET g_dbaf3_d[l_ac].l_dbad0021_desc = adbi255_dbad002_ref(g_dbaf3_d[l_ac].l_dbad0021) 
                   ELSE
                      LET g_dbaf3_d[l_ac].dbaf0031      = g_dbaf3_d_t.dbaf0031  
                      LET g_dbaf3_d[l_ac].dbaf0031_desc = adbi255_dbaf003_ref(g_dbaf3_d[l_ac].dbaf0031)
                      LET g_dbaf3_d[l_ac].l_dbad0021      = adbi255_get_dbad002(g_dbaf3_d[l_ac].dbaf0031)   
                      LET g_dbaf3_d[l_ac].l_dbad0021_desc = adbi255_dbad002_ref(g_dbaf3_d[l_ac].l_dbad0021)                      
                      DISPLAY BY NAME g_dbaf3_d[l_ac].dbaf0031,g_dbaf3_d[l_ac].dbaf0031_desc,
                                      g_dbaf3_d[l_ac].l_dbad0021,g_dbaf3_d[l_ac].l_dbad0021_desc 
                      NEXT FIELD CURRENT   
                   END IF 
                END IF   
            END IF
            LET g_dbaf3_d[g_detail_idx3].dbaf0031_desc = adbi255_dbaf003_ref(g_dbaf3_d[l_ac].dbaf0031)
            LET g_dbaf3_d[l_ac].l_dbad0021      = adbi255_get_dbad002(g_dbaf3_d[l_ac].dbaf0031)   
            LET g_dbaf3_d[l_ac].l_dbad0021_desc = adbi255_dbad002_ref(g_dbaf3_d[l_ac].l_dbad0021)                      
            DISPLAY BY NAME g_dbaf3_d[l_ac].dbaf0031,g_dbaf3_d[l_ac].dbaf0031_desc,
                  g_dbaf3_d[l_ac].l_dbad0021,g_dbaf3_d[l_ac].l_dbad0021_desc             

         AFTER FIELD dbaf0111
            IF NOT cl_null(g_dbaf3_d[l_ac].dbaf0111) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND g_dbaf3_d[l_ac].dbaf0111 != g_dbaf3_d_t.dbaf0111) THEN
                  IF g_dbaf3_d[l_ac].dbaf0111 <= 0 THEN
                     LET g_dbaf3_d[l_ac].dbaf0111 = g_dbaf3_d_t.dbaf0111
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aim-00003'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD dbaf0111
                  END IF   
               END IF
            END IF

         AFTER FIELD dbaf0121
            IF NOT cl_null(g_dbaf3_d[l_ac].dbaf0121) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND g_dbaf3_d[l_ac].dbaf0121 != g_dbaf3_d_t.dbaf0121) THEN
                  IF g_dbaf3_d[l_ac].dbaf0121 <= 0 THEN
                     LET g_dbaf3_d[l_ac].dbaf0121 = g_dbaf3_d_t.dbaf0121
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aim-00003'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD dbaf0121
                  END IF   
               END IF
            END IF

         AFTER FIELD dbaf0131
            IF NOT cl_null(g_dbaf3_d[l_ac].dbaf0131) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND g_dbaf3_d[l_ac].dbaf0131 != g_dbaf3_d_t.dbaf0131) THEN
                  IF g_dbaf3_d[l_ac].dbaf0131 <= 0 THEN
                     LET g_dbaf3_d[l_ac].dbaf0131 = g_dbaf3_d_t.dbaf0131
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aim-00003'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD dbaf0131
                  END IF   
               END IF
               CALL adbi255_default_dbaf015()
            END IF

         AFTER FIELD dbaf0141
            IF NOT cl_null(g_dbaf3_d[l_ac].dbaf0141) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND g_dbaf3_d[l_ac].dbaf0141 != g_dbaf3_d_t.dbaf0141) THEN
                  IF g_dbaf3_d[l_ac].dbaf0141 <= 0 THEN
                     LET g_dbaf3_d[l_ac].dbaf0141 = g_dbaf3_d_t.dbaf0141
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aim-00003'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD dbaf0141
                  END IF   
               END IF
               CALL adbi255_default_dbaf015()
            END IF

         AFTER FIELD dbaf0151
            IF NOT cl_null(g_dbaf3_d[l_ac].dbaf0151) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND g_dbaf3_d[l_ac].dbaf0151 != g_dbaf3_d_t.dbaf0151) THEN
                  IF g_dbaf3_d[l_ac].dbaf0151 <= 0 THEN
                     LET g_dbaf3_d[l_ac].dbaf0151 = g_dbaf3_d_t.dbaf0151
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aim-00003'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD dbaf0151
                  END IF   
               END IF
            END IF

         ON ACTION controlp INFIELD dbaf0031
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_dbaf3_d[l_ac].dbaf0031             #給予default值
            CALL q_dbad001()                                #呼叫開窗
            LET g_dbaf3_d[l_ac].dbaf0031 = g_qryparam.return1 
            DISPLAY g_dbaf3_d[l_ac].dbaf0031 TO dbaf0031
            LET g_dbaf3_d[l_ac].dbaf0031_desc = adbi255_dbaf003_ref(g_dbaf3_d[l_ac].dbaf0031)
            LET g_dbaf3_d[l_ac].l_dbad0021      = adbi255_get_dbad002(g_dbaf3_d[l_ac].dbaf0031) 
            LET g_dbaf3_d[l_ac].l_dbad0021_desc = adbi255_dbad002_ref(g_dbaf3_d[l_ac].l_dbad0021) 
            NEXT FIELD dbaf0031                          #返回原欄位

         AFTER ROW
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_dbaf3_d[l_ac].* = g_dbaf3_d_t.*
               END IF
               CLOSE adbi255_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
 
            CLOSE adbi255_bcl
            CALL s_transaction_end('Y','0')
           
         ON ACTION controlo
            CALL FGL_SET_ARR_CURR(g_dbaf3_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_dbaf3_d.getLength()+1 

         AFTER INPUT
            LET g_set_page = g_aw
            LET g_detail_idx3 = l_ac

      END INPUT
 
      DISPLAY ARRAY g_dbaf4_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b) 
         BEFORE ROW
            CALL adbi255_b_fill(g_wc3) 
            LET g_detail_idx4 = DIALOG.getCurrentRow("s_detail4")
            LET l_ac = g_detail_idx4
            DISPLAY g_detail_idx4 TO FORMONLY.idx
            CALL adbi255_ui_detailshow()        
         BEFORE DISPLAY 
            CALL FGL_SET_ARR_CURR(g_detail_idx4)     
      END DISPLAY
      #end add-point    
      
      BEFORE DIALOG
         #CALL cl_err_collect_init()    
         #add-point:input段before_dialog name="input.before_dialog"
        
         IF p_cmd = 'a' THEN
            NEXT FIELD dbaf001
         ELSE
            CASE g_aw
               WHEN "s_detail3"
                  NEXT FIELD dbafstus1
               WHEN "s_detail4"
                  NEXT FIELD dbaf003_4            
            END CASE
         END IF   
         #end add-point 
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)      
         CALL DIALOG.setCurrentRow("s_detail2",g_detail_idx)
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD dbaf001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD dbafstus
               WHEN "s_detail2"
                  NEXT FIELD dbaf003_2
 
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
 
{<section id="adbi255.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION adbi255_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   IF g_bfill = "Y" THEN
      CALL adbi255_b_fill(g_wc3) #單身填充
      CALL adbi255_b_fill2('0') #單身填充
   END IF
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL adbi255_b_fill(g_wc2) #第一階單身填充
      CALL adbi255_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL adbi255_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_dbaf_m.dbaf001,g_dbaf_m.dbaf001_desc,g_dbaf_m.f_dbaf011,g_dbaf_m.f_dbaf012,g_dbaf_m.f_dbaf013, 
       g_dbaf_m.f_dbaf014,g_dbaf_m.f_dbaf015,g_dbaf_m.f_dbaf0111,g_dbaf_m.f_dbaf0121,g_dbaf_m.f_dbaf0131, 
       g_dbaf_m.f_dbaf0141,g_dbaf_m.f_dbaf0151
 
   CALL adbi255_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
   CALL adbi255_b_fill(g_wc3_table1) 
   CALL adbi255_ref_show()
   CALL adbi255_get_amount(g_dbaf_m.dbaf001)
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="adbi255.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION adbi255_ref_show()
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

   LET g_dbaf_m.dbaf001_desc = adbi255_dbaf001_ref(g_dbaf_m.dbaf001)
   DISPLAY BY NAME g_dbaf_m.dbaf001_desc

   #end add-point
 
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_dbaf_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"
      LET g_dbaf_d[l_ac].dbaf003_desc = adbi255_dbaf003_ref(g_dbaf_d[l_ac].dbaf003)
      LET g_dbaf_d[l_ac].l_dbad002 = adbi255_get_dbad002(g_dbaf_d[l_ac].dbaf003)   
      LET g_dbaf_d[l_ac].l_dbad002_desc = adbi255_dbad002_ref(g_dbaf_d[l_ac].l_dbad002)
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_dbaf2_d.getLength()
      #add-point:ref_show段d2_reference name="ref_show.body2.reference"
      LET g_dbaf2_d[l_ac].dbafownid_desc = adbi255_user_ref(g_dbaf2_d[l_ac].dbafownid)
      LET g_dbaf2_d[l_ac].dbafowndp_desc = adbi255_org_ref(g_dbaf2_d[l_ac].dbafowndp)
      LET g_dbaf2_d[l_ac].dbafcrtid_desc = adbi255_user_ref(g_dbaf2_d[l_ac].dbafcrtid)
      LET g_dbaf2_d[l_ac].dbafcrtdp_desc = adbi255_org_ref(g_dbaf2_d[l_ac].dbafcrtdp)
      LET g_dbaf2_d[l_ac].dbafmodid_desc = adbi255_org_ref(g_dbaf2_d[l_ac].dbafmodid)
      #end add-point
   END FOR
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   FOR l_ac = 1 TO g_dbaf3_d.getLength()
      LET g_dbaf3_d[l_ac].dbaf0031_desc = adbi255_dbaf003_ref(g_dbaf3_d[l_ac].dbaf0031)
      LET g_dbaf3_d[l_ac].l_dbad0021 = adbi255_get_dbad002(g_dbaf3_d[l_ac].dbaf0031)
      LET g_dbaf3_d[l_ac].l_dbad0021_desc = adbi255_dbad002_ref(g_dbaf3_d[l_ac].l_dbad0021)
   END FOR
   
   FOR l_ac = 1 TO g_dbaf4_d.getLength()
      LET g_dbaf4_d[l_ac].dbafownid1_desc = adbi255_user_ref(g_dbaf4_d[l_ac].dbafownid1)
      LET g_dbaf4_d[l_ac].dbafowndp1_desc_1 = adbi255_org_ref(g_dbaf4_d[l_ac].dbafowndp1)
      LET g_dbaf4_d[l_ac].dbafcrtid1_desc = adbi255_user_ref(g_dbaf4_d[l_ac].dbafcrtid1)
      LET g_dbaf4_d[l_ac].dbafcrtdp1_desc = adbi255_org_ref(g_dbaf4_d[l_ac].dbafcrtdp1)
      LET g_dbaf4_d[l_ac].dbafmodid1_desc = adbi255_org_ref(g_dbaf4_d[l_ac].dbafmodid1)
   END FOR
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="adbi255.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION adbi255_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE dbaf_t.dbaf001 
   DEFINE l_oldno     LIKE dbaf_t.dbaf001 
 
   DEFINE l_master    RECORD LIKE dbaf_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE dbaf_t.* #此變數樣板目前無使用
 
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
 
   IF g_dbaf_m.dbaf001 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_dbaf001_t = g_dbaf_m.dbaf001
 
   
   LET g_dbaf_m.dbaf001 = ""
 
   LET g_master_insert = FALSE
   CALL adbi255_set_entry('a')
   CALL adbi255_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #清空key欄位的desc
      LET g_dbaf_m.dbaf001_desc = ''
   DISPLAY BY NAME g_dbaf_m.dbaf001_desc
 
   
   CALL adbi255_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_dbaf_m.* TO NULL
      INITIALIZE g_dbaf_d TO NULL
      INITIALIZE g_dbaf2_d TO NULL
 
      CALL adbi255_show()
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
   CALL adbi255_set_act_visible()
   CALL adbi255_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_dbaf001_t = g_dbaf_m.dbaf001
 
   
   #組合新增資料的條件
   LET g_add_browse = " dbafent = " ||g_enterprise|| " AND",
                      " dbaf001 = '", g_dbaf_m.dbaf001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL adbi255_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL adbi255_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL adbi255_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="adbi255.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION adbi255_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE dbaf_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE adbi255_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM dbaf_t
    WHERE dbafent = g_enterprise AND dbaf001 = g_dbaf001_t
 
       INTO TEMP adbi255_detail
   
   #將key修正為調整後   
   UPDATE adbi255_detail 
      #更新key欄位
      SET dbaf001 = g_dbaf_m.dbaf001
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
       , dbafownid = g_user 
       , dbafowndp = g_dept
       , dbafcrtid = g_user
       , dbafcrtdp = g_dept 
       , dbafcrtdt = ld_date
       , dbafmodid = g_user
       , dbafmoddt = ld_date
      #, dbafstus = "Y" 
 
 
 
                                       
   #將資料塞回原table   
   INSERT INTO dbaf_t SELECT * FROM adbi255_detail
   
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
   DROP TABLE adbi255_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_dbaf001_t = g_dbaf_m.dbaf001
 
   
   DROP TABLE adbi255_detail
   
END FUNCTION
 
{</section>}
 
{<section id="adbi255.delete" >}
#+ 資料刪除
PRIVATE FUNCTION adbi255_delete()
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
   
   IF g_dbaf_m.dbaf001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN adbi255_cl USING g_enterprise,g_dbaf_m.dbaf001
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN adbi255_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE adbi255_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE adbi255_master_referesh USING g_dbaf_m.dbaf001 INTO g_dbaf_m.dbaf001,g_dbaf_m.dbaf001_desc 
 
   
   #遮罩相關處理
   LET g_dbaf_m_mask_o.* =  g_dbaf_m.*
   CALL adbi255_dbaf_t_mask()
   LET g_dbaf_m_mask_n.* =  g_dbaf_m.*
   
   CALL adbi255_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL adbi255_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM dbaf_t WHERE dbafent = g_enterprise AND dbaf001 = g_dbaf_m.dbaf001
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "dbaf_t:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
 
      
  
      #add-point:單身刪除後  name="delete.body.a_delete"
      #151224-00006#1 Add By Ken 160304(S)
      CALL g_dbaf3_d.clear()
      CALL g_dbaf4_d.clear()
      #151224-00006#1 Add By Ken 160304(E)
      #end add-point
      
 
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      #頭先不紀錄
      #IF NOT cl_log_modified_record('','') THEN 
      #   CLOSE adbi255_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_dbaf_d.clear() 
      CALL g_dbaf2_d.clear()       
 
     
      CALL adbi255_ui_browser_refresh()  
      #CALL adbi255_ui_headershow()  
      #CALL adbi255_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL adbi255_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL adbi255_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE adbi255_cl
 
   #功能已完成,通報訊息中心
   CALL adbi255_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="adbi255.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION adbi255_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_order_sql  STRING
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #先清空單身變數內容
   CALL g_dbaf_d.clear()
   CALL g_dbaf2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL g_dbaf3_d.clear()
   CALL g_dbaf4_d.clear()
   
   LET l_order_sql = " ORDER BY dbaf004 "
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT dbafstus,dbaf004,dbaf003,dbaf011,dbaf012,dbaf013,dbaf014,dbaf015,dbaf002, 
       dbaf003,dbaf002,dbafownid,dbafowndp,dbafcrtid,dbafcrtdp,dbafcrtdt,dbafmodid,dbafmoddt,t1.dbadl003 , 
       t2.ooag011 ,t3.ooefl003 ,t4.ooag011 ,t5.ooefl003 ,t6.ooag011 FROM dbaf_t",   
               "",
               
                              " LEFT JOIN dbadl_t t1 ON t1.dbadlent="||g_enterprise||" AND t1.dbadl001=dbaf003 AND t1.dbadl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=dbafownid  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=dbafowndp AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=dbafcrtid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=dbafcrtdp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=dbafmodid  ",
 
               " WHERE dbafent= ? AND dbaf001=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("dbaf_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = g_sql CLIPPED," AND dbaf002 = '1' "
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF adbi255_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY dbaf_t.dbaf002,dbaf_t.dbaf003"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
      #因樣板產生的ORDER BY SQL無法調整,用Replace     
      LET g_sql = cl_replace_str(g_sql, " ORDER BY dbaf_t.dbaf002,dbaf_t.dbaf003", l_order_sql)
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE adbi255_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR adbi255_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_dbaf_m.dbaf001   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_dbaf_m.dbaf001 INTO g_dbaf_d[l_ac].dbafstus,g_dbaf_d[l_ac].dbaf004, 
          g_dbaf_d[l_ac].dbaf003,g_dbaf_d[l_ac].dbaf011,g_dbaf_d[l_ac].dbaf012,g_dbaf_d[l_ac].dbaf013, 
          g_dbaf_d[l_ac].dbaf014,g_dbaf_d[l_ac].dbaf015,g_dbaf_d[l_ac].dbaf002,g_dbaf2_d[l_ac].dbaf003, 
          g_dbaf2_d[l_ac].dbaf002,g_dbaf2_d[l_ac].dbafownid,g_dbaf2_d[l_ac].dbafowndp,g_dbaf2_d[l_ac].dbafcrtid, 
          g_dbaf2_d[l_ac].dbafcrtdp,g_dbaf2_d[l_ac].dbafcrtdt,g_dbaf2_d[l_ac].dbafmodid,g_dbaf2_d[l_ac].dbafmoddt, 
          g_dbaf_d[l_ac].dbaf003_desc,g_dbaf2_d[l_ac].dbafownid_desc,g_dbaf2_d[l_ac].dbafowndp_desc, 
          g_dbaf2_d[l_ac].dbafcrtid_desc,g_dbaf2_d[l_ac].dbafcrtdp_desc,g_dbaf2_d[l_ac].dbafmodid_desc  
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
         #LET g_dbaf_d[l_ac].dbad002 = adbi255_get_dbad002(g_dbaf_d[l_ac].dbaf003)   
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
 
            CALL g_dbaf_d.deleteElement(g_dbaf_d.getLength())
      CALL g_dbaf2_d.deleteElement(g_dbaf2_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"

   LET g_sql = "SELECT  UNIQUE dbafstus,dbaf004,dbaf003,dbaf011,dbaf012,dbaf013,dbaf014,dbaf015,dbaf002, ",
               "               dbaf003,dbaf002,dbafownid,dbafowndp,dbafcrtid,dbafcrtdp,dbafcrtdt,dbafmodid,dbafmoddt,t1.dbadl003 , ", 
               "               t2.ooag011 ,t3.ooefl003 ,t4.ooag011 ,t5.ooefl003 ,t6.ooag011 ",
               "  FROM dbaf_t ",                  
               "       LEFT JOIN dbadl_t t1 ON t1.dbadlent='"||g_enterprise||"' AND t1.dbadl001=dbaf003 AND t1.dbadl002='"||g_dlang||"' ",
               "       LEFT JOIN ooag_t t2 ON t2.ooagent='"||g_enterprise||"' AND t2.ooag001=dbafownid  ",
               "       LEFT JOIN ooefl_t t3 ON t3.ooeflent='"||g_enterprise||"' AND t3.ooefl001=dbafowndp AND t3.ooefl002='"||g_dlang||"' ",
               "       LEFT JOIN ooag_t t4 ON t4.ooagent='"||g_enterprise||"' AND t4.ooag001=dbafcrtid  ",
               "       LEFT JOIN ooefl_t t5 ON t5.ooeflent='"||g_enterprise||"' AND t5.ooefl001=dbafcrtdp AND t5.ooefl002='"||g_dlang||"' ",
               "       LEFT JOIN ooag_t t6 ON t6.ooagent='"||g_enterprise||"' AND t6.ooag001=dbafmodid  ",
               " WHERE dbafent= ? AND dbaf001=?",
               "   AND dbaf002 ='2' "    

   IF NOT cl_null(g_wc3_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc3_table1 CLIPPED, cl_sql_add_filter("dbaf_t")
   END IF

   #判斷是否填充
   IF adbi255_fill_chk(3) THEN
      LET g_sql = g_sql, l_order_sql
      
      PREPARE adbi255_pb1 FROM g_sql
      DECLARE b_fill_cs1 CURSOR FOR adbi255_pb1
            
      LET l_ac = 1
      LET g_cnt = l_ac
      
      OPEN b_fill_cs1 USING g_enterprise,g_dbaf_m.dbaf001
      FOREACH b_fill_cs1 INTO #g_dbaf3_d[l_ac].dbafstus1,      g_dbaf3_d[l_ac].dbaf0041,         g_dbaf3_d[l_ac].dbaf0031,  g_dbaf3_d[l_ac].dbaf0031_desc, 
                              #g_dbaf3_d[l_ac].l_dbad0021,     g_dbaf3_d[l_ac].l_dbad0021_desc,  g_dbaf3_d[l_ac].dbaf0111,  g_dbaf3_d[l_ac].dbaf0121, 
                              #g_dbaf3_d[l_ac].dbaf0131,       g_dbaf3_d[l_ac].dbaf0141,         g_dbaf3_d[l_ac].dbaf0151,  g_dbaf3_d[l_ac].dbaf0021,                              
                              #g_dbaf4_d[l_ac].dbaf003_4,      g_dbaf4_d[l_ac].dbaf002_4,        g_dbaf4_d[l_ac].dbafownid1,g_dbaf4_d[l_ac].dbafownid1_desc, 
                              #g_dbaf4_d[l_ac].dbafowndp1,     g_dbaf4_d[l_ac].dbafowndp1_desc_1,g_dbaf4_d[l_ac].dbafcrtid1,g_dbaf4_d[l_ac].dbafcrtid1_desc, 
                              #g_dbaf4_d[l_ac].dbafcrtdp1,     g_dbaf4_d[l_ac].dbafcrtdp1_desc,  g_dbaf4_d[l_ac].dbafcrtdt1,g_dbaf4_d[l_ac].dbafmodid1, 
                              #g_dbaf4_d[l_ac].dbafmodid1_desc,g_dbaf4_d[l_ac].dbafmoddt1
                              
                              g_dbaf3_d[l_ac].dbafstus1,        g_dbaf3_d[l_ac].dbaf0041,       g_dbaf3_d[l_ac].dbaf0031,       g_dbaf3_d[l_ac].dbaf0111, 
                              g_dbaf3_d[l_ac].dbaf0121,         g_dbaf3_d[l_ac].dbaf0131,       g_dbaf3_d[l_ac].dbaf0141,       g_dbaf3_d[l_ac].dbaf0151, 
                              g_dbaf3_d[l_ac].dbaf0021,         g_dbaf4_d[l_ac].dbaf003_4,      g_dbaf4_d[l_ac].dbaf002_4,      g_dbaf4_d[l_ac].dbafownid1, 
                              g_dbaf4_d[l_ac].dbafowndp1,       g_dbaf4_d[l_ac].dbafcrtid1,     g_dbaf4_d[l_ac].dbafcrtdp1,     g_dbaf4_d[l_ac].dbafcrtdt1, 
                              g_dbaf4_d[l_ac].dbafmodid1,       g_dbaf4_d[l_ac].dbafmoddt1,     g_dbaf3_d[l_ac].dbaf0031_desc,  g_dbaf4_d[l_ac].dbafownid1_desc, 
                              g_dbaf4_d[l_ac].dbafowndp1_desc_1,g_dbaf4_d[l_ac].dbafcrtid1_desc,g_dbaf4_d[l_ac].dbafcrtdp1_desc,g_dbaf4_d[l_ac].dbafmodid1_desc 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF
         
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
      
      CALL g_dbaf3_d.deleteElement(g_dbaf3_d.getLength())
      CALL g_dbaf4_d.deleteElement(g_dbaf4_d.getLength())
 
   END IF
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_dbaf_d.getLength()
      LET g_dbaf_d_mask_o[l_ac].* =  g_dbaf_d[l_ac].*
      CALL adbi255_dbaf_t_mask()
      LET g_dbaf_d_mask_n[l_ac].* =  g_dbaf_d[l_ac].*
   END FOR
   
   LET g_dbaf2_d_mask_o.* =  g_dbaf2_d.*
   FOR l_ac = 1 TO g_dbaf2_d.getLength()
      LET g_dbaf2_d_mask_o[l_ac].* =  g_dbaf2_d[l_ac].*
      CALL adbi255_dbaf_t_mask()
      LET g_dbaf2_d_mask_n[l_ac].* =  g_dbaf2_d[l_ac].*
   END FOR
 
 
   FREE adbi255_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="adbi255.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION adbi255_idx_chk()
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
      IF g_detail_idx > g_dbaf_d.getLength() THEN
         LET g_detail_idx = g_dbaf_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_dbaf_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_dbaf_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_dbaf2_d.getLength() THEN
         LET g_detail_idx = g_dbaf2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_dbaf2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_dbaf2_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="adbi255.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION adbi255_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_dbaf_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="adbi255.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION adbi255_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   DEFINE l_sql          STRING
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
 
#   #end add-point
#   
#   DELETE FROM dbaf_t
#    WHERE dbafent = g_enterprise AND dbaf001 = g_dbaf_m.dbaf001 AND
# 
#          dbaf002 = g_dbaf_d_t.dbaf002
#      AND dbaf003 = g_dbaf_d_t.dbaf003
# 
#      
#   #add-point:單筆刪除中 name="delete.body.m_single_delete"
   #需判斷是刪除去程或是回程的資料,KEY對應的變數不同
   LET l_sql = " DELETE FROM dbaf_t ",
               "  WHERE dbafent = ",g_enterprise,
               "    AND dbaf001 = '",g_dbaf_m.dbaf001,"' ",
               "    AND dbaf002 = ? AND dbaf003 = ? "
   PREPARE adbi255_del_pre FROM l_sql   
   
   CASE g_aw                             
      WHEN  's_detail1' 
         EXECUTE adbi255_del_pre USING g_dbaf_d_t.dbaf002,g_dbaf_d_t.dbaf003
      WHEN 's_detail3' 
          EXECUTE adbi255_del_pre USING g_dbaf3_d_t.dbaf0021,g_dbaf3_d_t.dbaf0031 
   END CASE             
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "dbaf_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN FALSE 
   END IF
   
   #add-point:單筆刪除後 name="delete.body.a_single_delete"
   IF l_ac <= g_rec_b THEN
      LET l_sql = "UPDATE dbaf_t SET dbaf004 = dbaf004 - 1 ",
                  " WHERE dbafent = ",g_enterprise,
                  "   AND dbaf001 = '",g_dbaf_m.dbaf001,"' ",
                  "   AND dbaf002 = ? ",
                  "    AND dbaf004 >= ", l_ac
      PREPARE adbi255_upd_pre FROM l_sql
            
      CASE                              
         WHEN g_aw = 's_detail1' 
            EXECUTE adbi255_upd_pre USING g_dbaf_d_t.dbaf002
         WHEN g_aw = 's_detail3' 
            EXECUTE adbi255_upd_pre USING g_dbaf3_d_t.dbaf0021
      END CASE 
   END IF   
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "dbaf_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE 
   END IF
   #end add-point
 
   LET g_rec_b = g_rec_b-1
   DISPLAY g_rec_b TO FORMONLY.cnt
 
   RETURN TRUE
    
END FUNCTION
 
{</section>}
 
{<section id="adbi255.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION adbi255_delete_b(ps_table,ps_keys_bak,ps_page)
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
 
{<section id="adbi255.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION adbi255_insert_b(ps_table,ps_keys,ps_page)
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
 
{<section id="adbi255.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION adbi255_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
 
{<section id="adbi255.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION adbi255_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_dbaf_d[l_ac].dbaf002 = g_dbaf_d_t.dbaf002 
      AND g_dbaf_d[l_ac].dbaf003 = g_dbaf_d_t.dbaf003 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="adbi255.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION adbi255_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="adbi255.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION adbi255_lock_b(ps_table,ps_page)
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
   #CALL adbi255_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="adbi255.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION adbi255_unlock_b(ps_table,ps_page)
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
 
{<section id="adbi255.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION adbi255_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("dbaf001",TRUE)
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
 
{<section id="adbi255.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION adbi255_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("dbaf001",FALSE)
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
 
{<section id="adbi255.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION adbi255_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   CASE g_aw 
      WHEN "s_detail1"
         CALL cl_set_comp_entry('dbaf011,dbaf012,dbaf013,dbaf014,dbaf015',TRUE)
      WHEN "s_detail3"
         CALL cl_set_comp_entry('dbaf0111,dbaf0121,dbaf0131,dbaf0141,dbaf0151',TRUE) 
   END CASE      
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="adbi255.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION adbi255_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   IF l_ac > 0 THEN
      CASE g_aw 
         WHEN "s_detail1"   
            IF g_dbaf_d[l_ac].dbaf004 = 0 THEN
               CALL cl_set_comp_entry('dbaf011,dbaf012,dbaf013,dbaf014,dbaf015',FALSE)
            END IF
         WHEN "s_detail3"   
            IF g_dbaf3_d[l_ac].dbaf0041 = 0 THEN
               CALL cl_set_comp_entry('dbaf0111,dbaf0121,dbaf0131,dbaf0141,dbaf0151',FALSE)
            END IF
      END CASE   
   END IF   
   DISPLAY "g_aw",g_aw
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="adbi255.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION adbi255_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="adbi255.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION adbi255_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="adbi255.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION adbi255_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="adbi255.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION adbi255_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="adbi255.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION adbi255_default_search()
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
      LET ls_wc = ls_wc, " dbaf001 = '", g_argv[01], "' AND "
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
 
{<section id="adbi255.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION adbi255_fill_chk(ps_idx)
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
   IF (cl_null(g_wc3_table1) OR g_wc3_table1.trim() = '1=1') THEN
      RETURN TRUE
   END IF
   
   IF ps_idx = 3 AND
      ((NOT cl_null(g_wc3_table1) AND g_wc3_table1.trim() <> '1=1')) THEN
      RETURN TRUE
   END IF
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="adbi255.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION adbi255_modify_detail_chk(ps_record)
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
         LET ls_return = "dbafstus"
      WHEN "s_detail2"
         LET ls_return = "dbaf003_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="adbi255.mask_functions" >}
&include "erp/adb/adbi255_mask.4gl"
 
{</section>}
 
{<section id="adbi255.state_change" >}
    
 
{</section>}
 
{<section id="adbi255.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION adbi255_set_pk_array()
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
   LET g_pk_array[1].values = g_dbaf_m.dbaf001
   LET g_pk_array[1].column = 'dbaf001'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="adbi255.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION adbi255_msgcentre_notify(lc_state)
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
   CALL adbi255_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_dbaf_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="adbi255.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 人員名稱
# Memo...........:
# Usage..........: CALL adbi255_user_ref(p_user_id)
#                  RETURNING r_user_desc
# Input parameter: p_user_id      人員編號
# Return code....: r_user_desc    人員名稱
# Date & Author..: 2014/05/05 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbi255_user_ref(p_user_id)
   DEFINE p_user_id   LIKE dbac_t.dbacownid
   DEFINE r_user_desc LIKE oofa_t.oofa011 
   
   LET r_user_desc = NULL
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_user_id
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET r_user_desc = '', g_rtn_fields[1] , ''
   
   RETURN r_user_desc
END FUNCTION

################################################################################
# Descriptions...: 組織说明
# Memo...........:
# Usage..........: CALL adbi255_org_ref(p_org_id)
#                  RETURNING r_org_desc
# Input parameter: p_org_id       組織編號
# Return code....: r_org_desc     組織說明
# Date & Author..: 2014/05/05 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbi255_org_ref(p_org_id)
   DEFINE p_org_id   LIKE dbac_t.dbacowndp
   DEFINE r_org_desc LIKE ooefl_t.ooefl003
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_org_id
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_org_desc = '', g_rtn_fields[1] , ''
   
   RETURN r_org_desc
END FUNCTION

################################################################################
# Descriptions...: 路線說明
# Memo...........:
# Usage..........: CALL adbi255_dbaf001_ref(p_dbaf001)
#                  RETURNING r_dbaf001_desc
# Input parameter: p_dbaf001      路線編號
# Return code....: r_dbaf001_desc 路線說明
# Date & Author..: 2014/05/05 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbi255_dbaf001_ref(p_dbaf001)
   DEFINE p_dbaf001      LIKE dbaf_t.dbaf001
   DEFINE r_dbaf001_desc LIKE dbabl_t.dbabl003
   
   LET r_dbaf001_desc = NULL
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_dbaf001
   CALL ap_ref_array2(g_ref_fields,"SELECT dbabl003 FROM dbabl_t WHERE dbablent='"||g_enterprise||"' AND dbabl001=? AND dbabl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_dbaf001_desc = '', g_rtn_fields[1] , ''
   
   RETURN r_dbaf001_desc
END FUNCTION

################################################################################
# Descriptions...: 站點说明
# Memo...........:
# Usage..........: CALL adbi255_dbaf003_ref(p_dbaf003)
#                  RETURNING r_dbaf003_desc
# Input parameter: p_dbaf003      站點編號
# Return code....: r_dbaf003_desc 站點說明
# Date & Author..: 2014/05/05 By Lori
# Modify.........:
################################################################################
PUBLIC FUNCTION adbi255_dbaf003_ref(p_dbaf003)
   DEFINE p_dbaf003      LIKE dbaf_t.dbaf003
   DEFINE r_dbaf003_desc LIKE dbadl_t.dbadl003
   
   LET r_dbaf003_desc = NULL
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_dbaf003
   CALL ap_ref_array2(g_ref_fields,"SELECT dbadl003 FROM dbadl_t WHERE dbadlent='"||g_enterprise||"' AND dbadl001=? AND dbadl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_dbaf003_desc = '', g_rtn_fields[1] , ''
   
   RETURN r_dbaf003_desc
END FUNCTION

################################################################################
# Descriptions...: 片區说明
# Memo...........:
# Usage..........: CALL adbi255_dbad002_ref(p_dbad002)
#                  RETURNING r_dbad002_desc
# Input parameter: p_dbad002       片區編號
# Return code....: r_dbad002_desc  片區說明
# Date & Author..: 2014/05/05 By Lori
# Modify.........:
################################################################################
PUBLIC FUNCTION adbi255_dbad002_ref(p_dbad002)
   DEFINE p_dbad002      LIKE dbad_t.dbad002
   DEFINE r_dbad002_desc LIKE dbacl_t.dbacl003
   
   LET r_dbad002_desc = NULL
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_dbad002
   CALL ap_ref_array2(g_ref_fields,"SELECT dbacl003 FROM dbacl_t WHERE dbaclent='"||g_enterprise||"' AND dbacl001=? AND dbacl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_dbad002_desc = '', g_rtn_fields[1] , ''
   
   RETURN r_dbad002_desc
END FUNCTION

################################################################################
# Descriptions...: 取片區編號
# Memo...........:
# Usage..........: CALL adbi255_get_dbad002(p_dbaf003) RETURN r_dbad002
# Input parameter: p_dbaf003   站點編號
# Return code....: r_dbad002   片區編號
# Date & Author..: 2014/05/05 By Lori
# Modify.........:
################################################################################
PUBLIC FUNCTION adbi255_get_dbad002(p_dbaf003)
   DEFINE p_dbaf003   LIKE dbaf_t.dbaf003
   DEFINE r_dbad002   LIKE dbad_t.dbad002
   
   LET r_dbad002 = NULL
   
   SELECT dbad002 INTO r_dbad002
     FROM dbad_t
    WHERE dbadent = g_enterprise AND dbad001 = p_dbaf003
    
   RETURN r_dbad002
END FUNCTION

################################################################################
# Descriptions...: 去程/回程總計
# Memo...........:
# Usage..........: CALL adbi255_get_amount(p_dbaf001)
# Input parameter: p_dbaf001   路線編號
# Return code....: 
# Date & Author..: 2014/05/05 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbi255_get_amount(p_dbaf001)
   DEFINE p_dbaf001   LIKE dbaf_t.dbaf001   
   DEFINE l_dbaf011   LIKE dbaf_t.dbaf011
   DEFINE l_dbaf0111  LIKE dbaf_t.dbaf011
   DEFINE l_dbaf012   LIKE dbaf_t.dbaf012
   DEFINE l_dbaf0121  LIKE dbaf_t.dbaf012
   DEFINE l_dbaf013   LIKE dbaf_t.dbaf013
   DEFINE l_dbaf0131  LIKE dbaf_t.dbaf013
   DEFINE l_dbaf014   LIKE dbaf_t.dbaf014
   DEFINE l_dbaf0141  LIKE dbaf_t.dbaf014
   DEFINE l_dbaf015   LIKE dbaf_t.dbaf015
   DEFINE l_dbaf0151  LIKE dbaf_t.dbaf015 

   LET l_dbaf011  = NULL
   LET l_dbaf0111 = NULL
   LET l_dbaf012  = NULL
   LET l_dbaf0121 = NULL
   LET l_dbaf013  = NULL
   LET l_dbaf0131 = NULL
   LET l_dbaf014  = NULL
   LET l_dbaf0141 = NULL
   LET l_dbaf015  = NULL
   LET l_dbaf0151 = NULL
   
   SELECT SUM(CASE dbaf002 WHEN '1' THEN dbaf011 END),
          SUM(CASE dbaf002 WHEN '1' THEN dbaf012 END),
          SUM(CASE dbaf002 WHEN '1' THEN dbaf013 END),
          SUM(CASE dbaf002 WHEN '1' THEN dbaf014 END),
          SUM(CASE dbaf002 WHEN '1' THEN dbaf015 END),
          SUM(CASE dbaf002 WHEN '2' THEN dbaf011 END),
          SUM(CASE dbaf002 WHEN '2' THEN dbaf012 END),
          SUM(CASE dbaf002 WHEN '2' THEN dbaf013 END),
          SUM(CASE dbaf002 WHEN '2' THEN dbaf014 END),
          SUM(CASE dbaf002 WHEN '2' THEN dbaf015 END)
     INTO l_dbaf011,l_dbaf012,l_dbaf013,l_dbaf014,l_dbaf015,
          l_dbaf0111,l_dbaf0121,l_dbaf0131,l_dbaf0141,l_dbaf0151
     FROM dbaf_t
    WHERE dbafent = g_enterprise AND dbaf001 = g_dbaf_m.dbaf001 
  
   IF cl_null(l_dbaf011  ) THEN      LET l_dbaf011  = 0       END IF     
   IF cl_null(l_dbaf0111 ) THEN      LET l_dbaf0111 = 0       END IF
   IF cl_null(l_dbaf012  ) THEN      LET l_dbaf012  = 0       END IF
   IF cl_null(l_dbaf0121 ) THEN      LET l_dbaf0121 = 0       END IF
   IF cl_null(l_dbaf013  ) THEN      LET l_dbaf013  = 0       END IF
   IF cl_null(l_dbaf0131 ) THEN      LET l_dbaf0131 = 0       END IF
   IF cl_null(l_dbaf014  ) THEN      LET l_dbaf014  = 0       END IF
   IF cl_null(l_dbaf0141 ) THEN      LET l_dbaf0141 = 0       END IF
   IF cl_null(l_dbaf015  ) THEN      LET l_dbaf015  = 0       END IF     
   IF cl_null(l_dbaf0151 ) THEN      LET l_dbaf0151 = 0       END IF
   
   LET g_dbaf_m.f_dbaf011  = l_dbaf011
   LET g_dbaf_m.f_dbaf0111 = l_dbaf0111
   LET g_dbaf_m.f_dbaf012  = l_dbaf012
   LET g_dbaf_m.f_dbaf0121 = l_dbaf0121
   LET g_dbaf_m.f_dbaf013  = l_dbaf013
   LET g_dbaf_m.f_dbaf0131 = l_dbaf0131
   LET g_dbaf_m.f_dbaf014  = l_dbaf014 
   LET g_dbaf_m.f_dbaf0141 = l_dbaf0141
   LET g_dbaf_m.f_dbaf015  = l_dbaf015
   LET g_dbaf_m.f_dbaf0151 = l_dbaf0151 
                             
   DISPLAY BY NAME g_dbaf_m.f_dbaf011,g_dbaf_m.f_dbaf0111,                         
                   g_dbaf_m.f_dbaf012,g_dbaf_m.f_dbaf0121,              
                   g_dbaf_m.f_dbaf013,g_dbaf_m.f_dbaf0131,               
                   g_dbaf_m.f_dbaf014,g_dbaf_m.f_dbaf0141,              
                   g_dbaf_m.f_dbaf015,g_dbaf_m.f_dbaf0151   
  
   IF s_transaction_chk("N",0) THEN
      CALL s_transaction_begin()
   END IF

   UPDATE dbab_t
      SET dbab011 = g_dbaf_m.f_dbaf011,
          dbab012 = g_dbaf_m.f_dbaf012,
          dbab013 = g_dbaf_m.f_dbaf013,
          dbab014 = g_dbaf_m.f_dbaf014,
          dbab015 = g_dbaf_m.f_dbaf015,
          dbab021 = g_dbaf_m.f_dbaf0111,
          dbab022 = g_dbaf_m.f_dbaf0121,
          dbab023 = g_dbaf_m.f_dbaf0131,
          dbab024 = g_dbaf_m.f_dbaf0141,
          dbab025 = g_dbaf_m.f_dbaf0151
    WHERE dbabent = g_enterprise
      AND dbab001 = g_dbaf_m.dbaf001  
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "dbaf_t"
      LET g_errparam.popup = FALSE
      CALL cl_err()

      CALL s_transaction_end('N','0')
   ELSE
      CALL s_transaction_end('Y','0')   
   END IF      
END FUNCTION

################################################################################
# Descriptions...: 預設回程路線
# Memo...........: 去程路線編輯完畢後自動產生
# Usage..........: CALL adbi255_default_back(p_dbaf001,p_dbaf002)
#                  RETURNING r_success
# Input parameter: p_dbaf001   路線編號
#                  p_dbaf002   類型
# Return code....: r_success   處理狀態
# Date & Author..: 2014/05/05 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbi255_default_back(p_dbaf001,p_dbaf002)
   DEFINE p_dbaf001   LIKE dbaf_t.dbaf001
   DEFINE p_dbaf002   LIKE dbaf_t.dbaf002
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_sql       STRING
   DEFINE l_dbaf      RECORD 
              dbaf001     LIKE dbaf_t.dbaf001  ,
              dbaf002     LIKE dbaf_t.dbaf002  ,
              dbaf003     LIKE dbaf_t.dbaf003  ,
              dbaf004     LIKE dbaf_t.dbaf004  ,
              dbaf011     LIKE dbaf_t.dbaf011  ,
              dbaf012     LIKE dbaf_t.dbaf012  ,
              dbaf013     LIKE dbaf_t.dbaf013  ,
              dbaf014     LIKE dbaf_t.dbaf014  ,
              dbaf015     LIKE dbaf_t.dbaf015  ,
              dbafownid   LIKE dbaf_t.dbafownid,
              dbafowndp   LIKE dbaf_t.dbafowndp,
              dbafcrtid   LIKE dbaf_t.dbafcrtid,
              dbafcrtdp   LIKE dbaf_t.dbafcrtdp,
              dbafcrtdt   LIKE dbaf_t.dbafcrtdt,
              dbafstus    LIKe dbaf_t.dbafstus
                      END RECORD
   DEFINE l_dbaf004   LIKE dbaf_t.dbaf004
   
   LET r_success = TRUE
   
   LET l_sql = "SELECT dbaf011,dbaf012,dbaf013,dbaf014,dbaf015 ",
               "  FROM dbaf_t ",
               "  WHERE dbafent = ",g_enterprise," AND dbaf001 = '",p_dbaf001,"' ",
               "    AND dbaf002 = '",p_dbaf002,"'  AND dbaf004 = ? AND dbafstus ='Y' "
   PREPARE adbi255_dbaf_info FROM l_sql
   
   LET l_sql = " SELECT dbaf001,dbaf003,dbaf004 ",
               "   FROM dbaf_t t1",
               "  WHERE dbafent = ",g_enterprise," AND dbaf001 = '",p_dbaf001,"' ",
               "    AND dbaf002 = '",p_dbaf002,"'  AND dbafstus ='Y' ",
               "  ORDER BY t1.dbaf004 DESC "
   PREPARE adbi255_dbaf_sel_pre FROM l_sql
   DECLARE adbi255_dbaf_sel_cur CURSOR FOR adbi255_dbaf_sel_pre   
   
   LET l_dbaf004 = 0 
   FOREACH adbi255_dbaf_sel_cur INTO l_dbaf.dbaf001,l_dbaf.dbaf003,l_dbaf.dbaf004 
   
      LET l_dbaf.dbaf002 = '2'      
      IF l_dbaf004 = 0 THEN
         LET l_dbaf.dbaf011 = 0 
         LET l_dbaf.dbaf012 = 0
         LET l_dbaf.dbaf013 = 0
         LET l_dbaf.dbaf014 = 0
         LET l_dbaf.dbaf015 = 0
      ELSE
         LET l_dbaf.dbaf004 = l_dbaf.dbaf004 + 1 
         EXECUTE adbi255_dbaf_info USING l_dbaf.dbaf004 
                                    INTO l_dbaf.dbaf011,l_dbaf.dbaf012,  
                                         l_dbaf.dbaf013,l_dbaf.dbaf014,l_dbaf.dbaf015
      END IF
      
      LET l_dbaf.dbafownid = g_user
      LET l_dbaf.dbafowndp = g_dept
      LET l_dbaf.dbafcrtid = g_user
      LET l_dbaf.dbafcrtdp = g_dept 
      LET l_dbaf.dbafcrtdt = cl_get_current()
      LET l_dbaf.dbafstus  = 'Y'
      
      INSERT INTO dbaf_t
                  (dbafent,dbaf001,dbaf002,dbaf003,dbaf004,
                   dbaf011,dbaf012,dbaf013,dbaf014,dbaf015,
                   dbafownid,dbafowndp,dbafcrtid,dbafcrtdp,
                   dbafcrtdt,dbafstus) 
            VALUES(g_enterprise,    l_dbaf.dbaf001,  l_dbaf.dbaf002,  l_dbaf.dbaf003,  l_dbaf004,
                   l_dbaf.dbaf011,  l_dbaf.dbaf012,  l_dbaf.dbaf013,  l_dbaf.dbaf014,  l_dbaf.dbaf015, 
                   l_dbaf.dbafownid,l_dbaf.dbafowndp,l_dbaf.dbafcrtid,l_dbaf.dbafcrtdp,l_dbaf.dbafcrtdt,
                   l_dbaf.dbafstus)
      IF SQLCA.SQLcode THEN
         LET r_success = FALSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "dbaf_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
         EXIT FOREACH         
      END IF
 
      LET l_dbaf004 = l_dbaf004 + 1 
   END FOREACH
   
   RETURN r_success   
END FUNCTION

################################################################################
# Descriptions...: 產生回程資料
# Memo...........: 已存在回程資料時,先詢問是否依去程資料重新產生
# Usage..........: CALL adbi255_return_trip(p_type)
# Input parameter: p_type  處理時機點,1.修改資料確認後,2.ACTION
# Return code....: 
# Date & Author..: 2014/05/05 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbi255_return_trip(p_type)
   DEFINE p_type       LIKE type_t.num5
   DEFINE l_cnt        LIKE type_t.num5
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_ins_flag   LIKE type_t.chr1
   DEFINE l_del_flag   LIKE type_t.chr1
   
   LET l_cnt = 0
   LET l_ins_flag = NULL
   LET l_del_flag = NULL
   
   IF cl_null(g_dbaf_m.dbaf001) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'adb-00043'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
   
   SELECT COUNT(*) INTO l_cnt FROM dbaf_t
    WHERE dbafent = g_enterprise AND dbaf001 = g_dbaf_m.dbaf001
      AND dbaf002 = '2'
   
   IF p_type = 1 AND l_cnt = 0 THEN   #首次輸入去程資料才自動產生回程資料
      LET l_ins_flag = 'Y'
      LET l_del_flag = 'N'
   END IF
   
   IF p_type = 2 AND l_cnt > 0 THEN
      IF cl_ask_promp('adb-00044') THEN
         LET l_ins_flag = 'Y'
         LET l_del_flag = 'Y'
      ELSE
         RETURN
      END IF 
   END IF 
   
   IF s_transaction_chk("N",0) THEN
       CALL s_transaction_begin()
   END IF  
      
   IF l_del_flag = 'Y' THEN  
      DELETE FROM dbaf_t
       WHERE dbafent = g_enterprise 
         AND dbaf001 = g_dbaf_m.dbaf001
         AND dbaf002 = '2'
      IF SQLCA.sqlcode THEN
         CALL s_transaction_end('N','0')
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "dbaf_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN
      ELSE
         CALL s_transaction_end('Y','0')
      END IF       
   END IF   
   
   IF l_ins_flag = 'Y' THEN  
      CALL adbi255_default_back(g_dbaf_m.dbaf001,'1') RETURNING l_success 
      IF l_success THEN
         CALL s_transaction_end('Y','0')
      ELSE   
         CALL s_transaction_end('N','0')
      END IF        
   END IF   
END FUNCTION

################################################################################
# Descriptions...: 檢查站點是否在不同的路線中重複
# Memo...........: 站點編號+類型，只能存在一個路線編號中，不可重複
# Usage..........: CALL adbi255_chk_dbaf003(p_dbaf001,p_dbaf002,p_dbaf003)
#                  RETURNING r_success
# Input parameter: p_dbaf001   路線編號
#                : p_dbaf002   類型
#                : p_dbaf003   站點編號
# Return code....: r_success   檢查結果
# Date & Author..: 2014/05/05 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbi255_chk_dbaf003(p_dbaf001,p_dbaf002,p_dbaf003)
   DEFINE p_dbaf001   LIKE dbaf_t.dbaf001
   DEFINE p_dbaf002   LIKE dbaf_t.dbaf002
   DEFINE p_dbaf003   LIKE dbaf_t.dbaf003
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_cnt       LIKE type_t.num5
   DEFINE l_msg       STRING
   
   LET r_success = TRUE
   LET l_cnt = 0 
   LET l_msg = NULL
   
   INITIALIZE g_chkparam.* TO NULL
   LET g_chkparam.arg1 = g_dbaf_d[g_detail_idx].dbaf003
   IF NOT cl_chk_exist("v_dbad001") THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   SELECT COUNT(*) INTO l_cnt
     FROM dbaf_t
    WHERE dbafent = g_enterprise AND dbaf001 <> p_dbaf001
      AND dbaf002 = p_dbaf002    AND dbaf003 = p_dbaf003

   IF l_cnt > 0 THEN
      LET r_success = FALSE
      CASE p_dbaf002 
          WHEN '1' 
            LET l_msg = 'adb-00045'
          WHEN '2'
            LET l_msg = 'adb-00046'
      END CASE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = l_msg
      LET g_errparam.extend = p_dbaf003
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 計算總花費費用的預設值
# Memo...........:
# Usage..........: CALL adbi255_default_dbaf015()
# Input parameter: 
# Return code....: 
# Date & Author..: 2014/05/06 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbi255_default_dbaf015()
   DEFINE l_dbaf013   LIKE dbaf_t.dbaf013
   DEFINE l_dbaf014   LIKE dbaf_t.dbaf014
   
   CASE g_aw
      WHEN "s_detail1"
         IF cl_null(g_dbaf_d[l_ac].dbaf013) AND cl_null(g_dbaf_d[l_ac].dbaf014) THEN
            RETURN
         END IF
         
         IF cl_null(g_dbaf_d[l_ac].dbaf013) THEN
            LET l_dbaf013 = 0
         ELSE
            LET l_dbaf013 = g_dbaf_d[l_ac].dbaf013
         END IF  

         IF cl_null(g_dbaf_d[l_ac].dbaf014) THEN
            LET l_dbaf014 = 0
         ELSE
            LET l_dbaf014 = g_dbaf_d[l_ac].dbaf014
         END IF 
         
         LET g_dbaf_d[l_ac].dbaf015 = l_dbaf013 + l_dbaf014
         
      WHEN "s_detail3"
         IF cl_null(g_dbaf3_d[l_ac].dbaf0131) AND cl_null(g_dbaf3_d[l_ac].dbaf0141) THEN
            RETURN
         END IF
         
         IF cl_null(g_dbaf3_d[l_ac].dbaf0131) THEN
            LET l_dbaf013 = 0
         ELSE
            LET l_dbaf013 = g_dbaf3_d[l_ac].dbaf0131
         END IF  

         IF cl_null(g_dbaf3_d[l_ac].dbaf0141) THEN
            LET l_dbaf014 = 0
         ELSE
            LET l_dbaf014 = g_dbaf3_d[l_ac].dbaf0141
         END IF 
         
         LET g_dbaf3_d[l_ac].dbaf0151 = l_dbaf013 + l_dbaf014      
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 取當下頁籤的筆數
# Memo...........:
# Usage..........: CALL adbi255_chk_idx()
# Input parameter:
# Return code....: 
# Date & Author..: 2014/05/08 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbi255_chk_idx()
   CASE g_aw
      WHEN "s_detail1"
         LET g_detail_idx = g_curr_diag.getCurrentRow(g_aw)
         IF g_detail_idx <= g_dbaf_d.getLength() THEN
            LET g_detail_idx = g_dbaf_d.getLength()
         END IF
         DISPLAY g_detail_idx TO FORMONLY.idx
         DISPLAY g_dbaf_d.getLength() TO FORMONLY.cnt
      #WHEN "s_detail2"
      WHEN "s_detail3"
         LET g_detail_idx3 = g_curr_diag.getCurrentRow(g_aw)
         IF g_detail_idx3 <= g_dbaf3_d.getLength() THEN
            LET g_detail_idx3 = g_dbaf3_d.getLength()
         DISPLAY g_detail_idx3 TO FORMONLY.idx
         DISPLAY g_dbaf3_d.getLength() TO FORMONLY.cnt
         END IF      
      WHEN "s_datail4"
         LET g_detail_idx4 = g_curr_diag.getCurrentRow(g_aw)
         IF g_detail_idx4 <= g_dbaf4_d.getLength() THEN
            LET g_detail_idx4 = g_dbaf4_d.getLength()
         END IF 
         DISPLAY g_detail_idx4 TO FORMONLY.idx
         DISPLAY g_dbaf4_d.getLength() TO FORMONLY.cnt     
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 重新顯示畫面上的路線順序
# Memo...........: 插入站點或刪除站點時都需要重新顯示
# Usage..........: CALL adbi255_redisplay_dbaf004(p_type,p_ac)
# Input parameter: p_type    異動類型:i.插入站點 d.刪除站點
#                : p_ac      畫面指標
# Return code....: 
# Date & Author..: 2014/05/09 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbi255_redisplay_dbaf004(p_type,p_ac)
   DEFINE p_type     LIKE type_t.chr1
   DEFINE p_ac       LIKE type_t.num5
   DEFINE i          LIKE type_t.num5
   DEFINE l_dbaf004  LIKE dbaf_t.dbaf004
   
   IF p_ac <= g_rec_b THEN
      CASE p_type
         WHEN 'u'   #從插入列的下一列更新路線順序
            CASE g_aw
               WHEN "s_detail1"
                  FOR i = p_ac + 1 TO g_dbaf_d.getLength()      
                     LET l_dbaf004 = g_dbaf_d[i].dbaf004    
                     LET g_dbaf_d[i].dbaf004 = l_dbaf004 + 1
                     IF i > g_dbaf_d.getLength() THEN
                        EXIT FOR
                     END IF
                  END FOR
               WHEN "s_detail3"
                  FOR i = p_ac + 1 TO g_dbaf3_d.getLength()      
                     LET l_dbaf004 = g_dbaf3_d[i].dbaf0041    
                     LET g_dbaf3_d[i].dbaf0041 = l_dbaf004 + 1
                     IF i > g_dbaf3_d.getLength() THEN
                        EXIT FOR
                     END IF
                  END FOR                  
            END CASE               
         WHEN 'd'   #從刪除列更新路線順序      
            CASE g_aw
               WHEN "s_detail1"
                  FOR i = p_ac TO g_dbaf_d.getLength()               
                     LET l_dbaf004 = g_dbaf_d[i].dbaf004                   
                     LET g_dbaf_d[i].dbaf004 = l_dbaf004 - 1               
                     IF i > g_dbaf_d.getLength() THEN               
                        EXIT FOR               
                     END IF               
                  END FOR      
               WHEN "s_detail3"
                  DISPLAY "g_dbaf3_d.getLength(): ",g_dbaf3_d.getLength()
                  FOR i = p_ac TO g_dbaf3_d.getLength()               
                     LET l_dbaf004 = g_dbaf3_d[i].dbaf0041                   
                     LET g_dbaf3_d[i].dbaf0041 = l_dbaf004 - 1               
                     IF i > g_dbaf3_d.getLength() THEN               
                        EXIT FOR               
                     END IF               
                  END FOR                 
            END CASE
      END CASE
   END IF
END FUNCTION

################################################################################
# Descriptions...: 由路線編號帶出adbi252,adbi253設定好的片區、站點資料
# Memo...........:
# Usage..........: CALL adbi255_default_dbad001(p_dbaf001)
# Input parameter: dbaf001        路線編號
# Date & Author..: 2015/12/29 By Ken  #151224-00006#1
# Modify.........:
################################################################################
PRIVATE FUNCTION adbi255_default_dbad001(p_dbaf001)
DEFINE p_dbaf001        LIKE dbaf_t.dbaf001
DEFINE l_sql            STRING
DEFINE l_cnt       LIKE type_t.num5
DEFINE l_dbaf      RECORD 
           dbaf001     LIKE dbaf_t.dbaf001  ,
           dbaf002     LIKE dbaf_t.dbaf002  ,
           dbaf003     LIKE dbaf_t.dbaf003  ,
           dbaf004     LIKE dbaf_t.dbaf004  ,
           dbaf011     LIKE dbaf_t.dbaf011  ,
           dbaf012     LIKE dbaf_t.dbaf012  ,
           dbaf013     LIKE dbaf_t.dbaf013  ,
           dbaf014     LIKE dbaf_t.dbaf014  ,
           dbaf015     LIKE dbaf_t.dbaf015  ,
           dbafownid   LIKE dbaf_t.dbafownid,
           dbafowndp   LIKE dbaf_t.dbafowndp,
           dbafcrtid   LIKE dbaf_t.dbafcrtid,
           dbafcrtdp   LIKE dbaf_t.dbafcrtdp,
           dbafcrtdt   LIKE dbaf_t.dbafcrtdt,
           dbafstus    LIKE dbaf_t.dbafstus
                   END RECORD
DEFINE l_dbaf004       LIKE dbaf_t.dbaf004                   

   #先預設路線順序為0
   LET l_dbaf004 = 0   
   LET l_ac = 1
   #去程
   LET l_sql = " SELECT UNIQUE dbac002,dbad001 ",
               "   FROM dbac_t,dbad_t ",
               "  WHERE dbacent = dbadent ",
               "    AND dbac001 = dbad002 ",
               "    AND dbacstus = 'Y' ",
               "    AND dbadstus = 'Y' ",
               "    AND dbac002 = '",p_dbaf001,"' ", 
               "  ORDER BY dbad001 "
   PREPARE adbi255_dbad001_pre FROM l_sql
   DECLARE adbi255_dbad001_cur CURSOR FOR adbi255_dbad001_pre 
   FOREACH adbi255_dbad001_cur INTO l_dbaf.dbaf001,l_dbaf.dbaf003
   #FOREACH adbi255_dbad001_cur INTO l_dbaf.dbaf001,g_dbaf_d[l_ac].dbaf003
   
      LET l_dbaf.dbaf002 = '1'     #去程 
      LET l_dbaf.dbaf011 = 0 
      LET l_dbaf.dbaf012 = 0
      LET l_dbaf.dbaf013 = 0
      LET l_dbaf.dbaf014 = 0
      LET l_dbaf.dbaf015 = 0    
      LET l_dbaf.dbafownid = g_user
      LET l_dbaf.dbafowndp = g_dept
      LET l_dbaf.dbafcrtid = g_user
      LET l_dbaf.dbafcrtdp = g_dept 
      LET l_dbaf.dbafcrtdt = cl_get_current()
      LET l_dbaf.dbafstus  = 'Y'
      
      SELECT COUNT(*) INTO l_cnt
        FROM dbaf_t
       WHERE dbafent = g_enterprise 
         AND dbaf001 <> p_dbaf001
         AND dbaf002 = '1'    
         AND dbaf003 = g_dbaf_d[l_ac].dbaf003 
      IF l_cnt > 0 THEN         
         CONTINUE FOREACH
      END IF
      
      #LET g_dbaf_d[l_ac].dbaf002 = '1'     #去程 
      #LET g_dbaf_d[l_ac].dbaf011 = 0 
      #LET g_dbaf_d[l_ac].dbaf012 = 0
      #LET g_dbaf_d[l_ac].dbaf013 = 0
      #LET g_dbaf_d[l_ac].dbaf014 = 0
      #LET g_dbaf_d[l_ac].dbaf015 = 0 
      #LET g_dbaf_d[l_ac].dbafstus  = 'Y'    
      #LET g_dbaf_d[l_ac].dbaf004 = l_dbaf004 
      #LET g_dbaf2_d[l_ac].dbafownid = g_user
      #LET g_dbaf2_d[l_ac].dbafowndp = g_dept
      #LET g_dbaf2_d[l_ac].dbafcrtid = g_user
      #LET g_dbaf2_d[l_ac].dbafcrtdp = g_dept 
      #LET g_dbaf2_d[l_ac].dbafcrtdt = cl_get_current()      
            
      INSERT INTO dbaf_t
                  (dbafent,dbaf001,dbaf002,dbaf003,dbaf004,
                   dbaf011,dbaf012,dbaf013,dbaf014,dbaf015,
                   dbafownid,dbafowndp,dbafcrtid,dbafcrtdp,
                   dbafcrtdt,dbafstus) 
            VALUES(g_enterprise,    l_dbaf.dbaf001,  l_dbaf.dbaf002,  l_dbaf.dbaf003,  l_dbaf004,
                   l_dbaf.dbaf011,  l_dbaf.dbaf012,  l_dbaf.dbaf013,  l_dbaf.dbaf014,  l_dbaf.dbaf015, 
                   l_dbaf.dbafownid,l_dbaf.dbafowndp,l_dbaf.dbafcrtid,l_dbaf.dbafcrtdp,l_dbaf.dbafcrtdt,
                   l_dbaf.dbafstus)
      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "dbaf_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
         EXIT FOREACH         
      END IF
      
      LET l_ac = l_ac + 1
      LET l_dbaf004 = l_dbaf004 + 1       
   END FOREACH
   CALL g_dbaf_d.deleteElement(g_dbaf_d.getLength())
      
   #先預設路線順序為0
   LET l_dbaf004 = 0   
   LET l_ac = 1
   #返程
   LET l_sql = " SELECT UNIQUE dbac002,dbad001 ",
               "   FROM dbac_t,dbad_t ",
               "  WHERE dbacent = dbadent ",
               "    AND dbac001 = dbad002 ",
               "    AND dbacstus = 'Y' ",
               "    AND dbadstus = 'Y' ",
               "    AND dbac002 = '",p_dbaf001,"' ", 
               "  ORDER BY dbad001 DESC "
   PREPARE adbi255_dbad001_pre1 FROM l_sql
   DECLARE adbi255_dbad001_cur1 CURSOR FOR adbi255_dbad001_pre1 
   FOREACH adbi255_dbad001_cur1 INTO l_dbaf.dbaf001,l_dbaf.dbaf003 
   #FOREACH adbi255_dbad001_cur1 INTO l_dbaf.dbaf001,g_dbaf3_d[l_ac].dbaf0031   
   
      LET l_dbaf.dbaf002 = '2'     #返程 
      LET l_dbaf.dbaf011 = 0 
      LET l_dbaf.dbaf012 = 0
      LET l_dbaf.dbaf013 = 0
      LET l_dbaf.dbaf014 = 0
      LET l_dbaf.dbaf015 = 0    
      LET l_dbaf.dbafownid = g_user
      LET l_dbaf.dbafowndp = g_dept
      LET l_dbaf.dbafcrtid = g_user
      LET l_dbaf.dbafcrtdp = g_dept 
      LET l_dbaf.dbafcrtdt = cl_get_current()
      LET l_dbaf.dbafstus  = 'Y'
      
      SELECT COUNT(*) INTO l_cnt
        FROM dbaf_t
       WHERE dbafent = g_enterprise 
         AND dbaf001 <> p_dbaf001
         AND dbaf002 = '2'    
         AND dbaf003 = g_dbaf_d[l_ac].dbaf003 
      IF l_cnt > 0 THEN         
         CONTINUE FOREACH
      END IF      
      
      #LET g_dbaf3_d[l_ac].dbaf0021 = '2'     #去程 
      #LET g_dbaf3_d[l_ac].dbaf0111 = 0 
      #LET g_dbaf3_d[l_ac].dbaf0121 = 0
      #LET g_dbaf3_d[l_ac].dbaf0131 = 0
      #LET g_dbaf3_d[l_ac].dbaf0141 = 0
      #LET g_dbaf3_d[l_ac].dbaf0151 = 0 
      #LET g_dbaf3_d[l_ac].dbafstus1  = 'Y'    
      #LET g_dbaf3_d[l_ac].dbaf0041 = l_dbaf004  
      #LET g_dbaf4_d[l_ac].dbafownid1 = g_user
      #LET g_dbaf4_d[l_ac].dbafowndp1 = g_dept
      #LET g_dbaf4_d[l_ac].dbafcrtid1 = g_user
      #LET g_dbaf4_d[l_ac].dbafcrtdp1 = g_dept 
      #LET g_dbaf4_d[l_ac].dbafcrtdt1 = cl_get_current()  
      
      INSERT INTO dbaf_t
                  (dbafent,dbaf001,dbaf002,dbaf003,dbaf004,
                   dbaf011,dbaf012,dbaf013,dbaf014,dbaf015,
                   dbafownid,dbafowndp,dbafcrtid,dbafcrtdp,
                   dbafcrtdt,dbafstus) 
            VALUES(g_enterprise,    l_dbaf.dbaf001,  l_dbaf.dbaf002,  l_dbaf.dbaf003,  l_dbaf004,
                   l_dbaf.dbaf011,  l_dbaf.dbaf012,  l_dbaf.dbaf013,  l_dbaf.dbaf014,  l_dbaf.dbaf015, 
                   l_dbaf.dbafownid,l_dbaf.dbafowndp,l_dbaf.dbafcrtid,l_dbaf.dbafcrtdp,l_dbaf.dbafcrtdt,
                   l_dbaf.dbafstus)
      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "dbaf_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
         EXIT FOREACH         
      END IF
 
      LET l_ac = l_ac + 1
      LET l_dbaf004 = l_dbaf004 + 1       
   END FOREACH   
   CALL g_dbaf3_d.deleteElement(g_dbaf3_d.getLength())
END FUNCTION

 
{</section>}
 
