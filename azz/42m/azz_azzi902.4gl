#該程式未解開Section, 採用最新樣板產出!
{<section id="azzi902.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0019(2015-06-16 15:43:30), PR版次:0019(2016-11-07 09:22:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000433
#+ Filename...: azzi902
#+ Description: 程式畫面多語言維護作業
#+ Creator....: 01856(2013-08-08 14:49:55)
#+ Modifier...: 01856 -SD/PR- 01856
 
{</section>}
 
{<section id="azzi902.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#+ Modifier...: No.161019-00022 #1  2016/10/19  jrg542  修正當有繁體中文轉換標籤文字， 輸入簡體中文轉換標籤文字 ，可以insert 到字典檔
#+ Modifier...: No.161105-00002 #1  2016/11/05  jrg542  畫面檔內標籤清單" 拖拉畫面內標籤到左邊可以幫忙自動轉換繁簡 語系
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
PRIVATE type type_g_gzzd_m        RECORD
       gzzd001 LIKE gzzd_t.gzzd001, 
   gzzd001_desc LIKE type_t.chr80
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_gzzd_d        RECORD
       gzzdstus LIKE gzzd_t.gzzdstus, 
   gzzd002 LIKE gzzd_t.gzzd002, 
   gzzd003 LIKE gzzd_t.gzzd003, 
   gzzd004 LIKE gzzd_t.gzzd004, 
   gzzd005 LIKE gzzd_t.gzzd005, 
   gzzd006 LIKE gzzd_t.gzzd006
       END RECORD
PRIVATE TYPE type_g_gzzd2_d RECORD
       gzzd002 LIKE gzzd_t.gzzd002, 
   gzzd003 LIKE gzzd_t.gzzd003, 
   gzzd004 LIKE gzzd_t.gzzd004, 
   gzzdmodid LIKE gzzd_t.gzzdmodid, 
   gzzdmodid_desc LIKE type_t.chr500, 
   gzzdmoddt DATETIME YEAR TO SECOND, 
   gzzdownid LIKE gzzd_t.gzzdownid, 
   gzzdownid_desc LIKE type_t.chr500, 
   gzzdowndp LIKE gzzd_t.gzzdowndp, 
   gzzdowndp_desc LIKE type_t.chr500, 
   gzzdcrtid LIKE gzzd_t.gzzdcrtid, 
   gzzdcrtid_desc LIKE type_t.chr500, 
   gzzdcrtdp LIKE gzzd_t.gzzdcrtdp, 
   gzzdcrtdp_desc LIKE type_t.chr500, 
   gzzdcrtdt DATETIME YEAR TO SECOND
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
TYPE type_g_gzzd3_d        RECORD
          gzzd003 LIKE gzzd_t.gzzd003,
          gzzd005 LIKE gzzd_t.gzzd005 
              END RECORD
DEFINE g_gzzd3_d   DYNAMIC ARRAY OF type_g_gzzd3_d
DEFINE g_detail_idx3      LIKE type_t.num5              #單身3目前所在筆數 (畫面檔內標籤清單)
DEFINE g_default_lang     LIKE type_t.chr6
DEFINE g_rec_b3           LIKE type_t.num5
DEFINE ma_gzzy DYNAMIC ARRAY OF RECORD
          gzzy001 LIKE gzzy_t.gzzy001,
          gzozcol LIKE type_t.chr10
               END RECORD
DEFINE g_std_cust LIKE type_t.chr1       
DEFINE ms_progs DYNAMIC ARRAY OF STRING
#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_gzzd_m          type_g_gzzd_m
DEFINE g_gzzd_m_t        type_g_gzzd_m
DEFINE g_gzzd_m_o        type_g_gzzd_m
DEFINE g_gzzd_m_mask_o   type_g_gzzd_m #轉換遮罩前資料
DEFINE g_gzzd_m_mask_n   type_g_gzzd_m #轉換遮罩後資料
 
   DEFINE g_gzzd001_t LIKE gzzd_t.gzzd001
 
 
DEFINE g_gzzd_d          DYNAMIC ARRAY OF type_g_gzzd_d
DEFINE g_gzzd_d_t        type_g_gzzd_d
DEFINE g_gzzd_d_o        type_g_gzzd_d
DEFINE g_gzzd_d_mask_o   DYNAMIC ARRAY OF type_g_gzzd_d #轉換遮罩前資料
DEFINE g_gzzd_d_mask_n   DYNAMIC ARRAY OF type_g_gzzd_d #轉換遮罩後資料
DEFINE g_gzzd2_d   DYNAMIC ARRAY OF type_g_gzzd2_d
DEFINE g_gzzd2_d_t type_g_gzzd2_d
DEFINE g_gzzd2_d_o type_g_gzzd2_d
DEFINE g_gzzd2_d_mask_o   DYNAMIC ARRAY OF type_g_gzzd2_d #轉換遮罩前資料
DEFINE g_gzzd2_d_mask_n   DYNAMIC ARRAY OF type_g_gzzd2_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_gzzd001 LIKE gzzd_t.gzzd001,
   b_gzzd001_desc LIKE type_t.chr80
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
 
{<section id="azzi902.main" >}
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
   CALL cl_ap_init("azz","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT gzzd001,''", 
                      " FROM gzzd_t",
                      " WHERE gzzd001=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE azzi902_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.gzzd001,t1.gzzal003",
               " FROM gzzd_t t0",
                              " LEFT JOIN gzzal_t t1 ON t1.gzzal001=t0.gzzd001 AND t1.gzzal002='"||g_lang||"' ",
 
               " WHERE  t0.gzzd001 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE azzi902_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_azzi902 WITH FORM cl_ap_formpath("azz",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL azzi902_init()   
 
      #進入選單 Menu (="N")
      CALL azzi902_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_azzi902
      
   END IF 
   
   CLOSE azzi902_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="azzi902.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION azzi902_init()
   #add-point:init段define name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill = "Y"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
      CALL cl_set_combo_scc('gzzd004','98') 
 
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('gzzd004_2','98')
   CALL cl_set_combo_lang("gzzd002")
   CALL cl_set_combo_lang("gzzd002_2")
   CALL cl_set_combo_lang("def_lang")
   LET g_default_lang = g_lang
   #end add-point
   
   CALL azzi902_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="azzi902.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION azzi902_ui_dialog()
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
   DEFINE l_dnd     ui.DragDrop 
   DEFINE l_source  STRING
   DEFINE li_cnt    LIKE type_t.num5
   DEFINE li_chk    LIKE type_t.num5
   DEFINE ls_str    STRING
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
         INITIALIZE g_gzzd_m.* TO NULL
         CALL g_gzzd_d.clear()
         CALL g_gzzd2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL azzi902_init()
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
               CALL azzi902_idx_chk()
               CALL azzi902_fetch('') # reload data
               LET g_detail_idx = 1
               CALL azzi902_ui_detailshow() #Setting the current row 
         
            ON ACTION qbefield_user   #欄位隱藏設定 
               LET g_action_choice="qbefield_user"
               CALL cl_ui_qbefield_user()
         
         END DISPLAY
        
         DISPLAY ARRAY g_gzzd_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL azzi902_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL azzi902_ui_detailshow()
               
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
               #任意點選筆數 可以直接顯示該筆數 
             ON DRAG_START(l_dnd)                       #啟動拖拉 (source區)
               LET l_source="LEFT"                     #標示來源為 LEFT  從左至右 的拖拉

            ON DRAG_OVER(l_dnd)                        #拖入本區每一行(target) 都會觸發的action
               IF l_source == "LEFT" THEN
                 CALL l_dnd.setOperation(NULL)
               ELSE
                  CALL l_dnd.setOperation("move")      #標註拖拉功能的處理方法
                                                       #NULL(不做),move(搬移),copy(複製)
                  CALL l_dnd.setFeedback("insert")     #標註拖過來時,本區畫面對應方法 
                                                       #insert(兩行之間),select(選定行反藍),all(兩者都要)
               END IF 

            ON DROP(l_dnd)                             #拖動完成target區的處理 (拖入本區的處理) 也就是 右 -> 左 的處理
               LET li_chk =  FALSE
               IF l_source == "RIGHT" THEN
                  FOR li_cnt = 1 TO g_gzzd3_d.getLength()
                      IF DIALOG.isRowSelected("s_detail3",li_cnt) THEN
                        #比對是否有選進來 
                        #(右邊的標籤跟左邊的標籤是否重複，重複的話，比對其他語言別，補欠缺語言別
                        #沒有重複 insert  )
                         IF NOT azzi902_chk_arr_setect(li_cnt) THEN  #比對是否有一樣 同一個語系在待轉標籤，不存在才insert
                            CALL azzi902_fill_arr_select(li_cnt,l_ac)
                            #單身重新刷新
                            LET g_wc2_table1 = " 1=1"
                            CALL azzi902_b_fill(g_wc2) #單身填充
                         END IF
                         
                      END IF 
                  END FOR 
               ELSE
                 CALL l_dnd.dropInternal()
               END IF

            ON DRAG_FINISHED(l_dnd)
               CALL DIALOG.setCurrentRow("g_disable",0)
               INITIALIZE l_source TO NULL
            #end add-point
               
         END DISPLAY
        
         DISPLAY ARRAY g_gzzd2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL azzi902_idx_chk()
               CALL azzi902_ui_detailshow()
               
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
               #任意點選筆數 可以直接顯示該筆數

            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
          DISPLAY ARRAY g_gzzd3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET g_detail_idx3 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL azzi902_ui_detailshow()
            
            BEFORE DISPLAY 
               #重新定義
               #任意點選筆數 可以直接顯示該筆數
               LET l_ac = ARR_CURR()
               LET g_detail_idx3 = l_ac
               CALL azzi902_ui_detailshow()
               CALL FGL_SET_ARR_CURR(g_detail_idx3) 
           
            ON DRAG_START(l_dnd)                        #啟動拖拉 (source區)            
               LET l_source="RIGHT"                     #標示來源為 LEFT  從左至右 () 的拖拉
               #LET l_ac_d = ARR_CURR()

            ON DRAG_FINISHED(l_dnd)
               INITIALIZE l_source TO NULL           
            
         END DISPLAY
         
         INPUT g_default_lang FROM def_lang  ATTRIBUTE(WITHOUT DEFAULTS)

            BEFORE INPUT 

            ON CHANGE def_lang 
               CALL azzi902_b2_fill() 
         END INPUT 
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps 
         
         BEFORE DIALOG
            #先填充browser資料
            CALL azzi902_browser_fill("")
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
               CALL azzi902_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL azzi902_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
            CALL DIALOG.setSelectionMode("s_detail3",1)
            #end add-point
 
         #應用 a49 樣板自動產生(Version:4)
            #過濾瀏覽頁資料
            ON ACTION filter
               LET g_action_choice = "fetch"
               #add-point:filter action name="ui_dialog.action.filter"
               
               #end add-point
               CALL azzi902_filter()
               EXIT DIALOG
 
 
 
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL azzi902_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL azzi902_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL azzi902_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL azzi902_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL azzi902_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL azzi902_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL azzi902_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL azzi902_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL azzi902_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL azzi902_idx_chk()
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
                  LET g_export_node[1] = base.typeInfo.create(g_gzzd_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_gzzd2_d)
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
               NEXT FIELD gzzd002
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
               CALL azzi902_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL azzi902_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL azzi902_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION gen_one_str
            LET g_action_choice="gen_one_str"
            IF cl_auth_chk_act("gen_one_str") THEN
               
               #add-point:ON ACTION gen_one_str name="menu.gen_one_str"
               IF g_gzzd_m.gzzd001 IS NULL THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = "std-00003"
                  LET g_errparam.popup  = FALSE
                  CALL cl_err()
                  CONTINUE DIALOG
               END IF
               CALL azzi902_gen_42s()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL azzi902_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL azzi902_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL azzi902_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL azzi902_insert()
               #add-point:ON ACTION insert name="menu.insert"
               LET ls_str = g_gzzd_m.gzzd001
               #主程式到gzzal_t 子程式到gzdel_t
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_gzzd_m.gzzd001            
               IF NOT ls_str.getIndexOf("_",1) THEN 
                  CALL ap_ref_array2(g_ref_fields,"SELECT gzzal003 FROM gzzal_t WHERE gzzal001=? AND gzzal002='"||g_lang||"'","") RETURNING g_rtn_fields
               ELSE
                  IF ls_str.subString(1,2) = "q_" OR ls_str.subString(1,2) = "cq" THEN 
                     CALL ap_ref_array2(g_ref_fields,"SELECT dzcal003 FROM dzcal_t WHERE dzcal001=? AND dzcal002='"||g_dlang||"'","") RETURNING g_rtn_fields
               ELSE
                  CALL ap_ref_array2(g_ref_fields,"SELECT gzdel003 FROM gzdel_t WHERE gzdel001=? AND gzdel002='"||g_lang||"'","") RETURNING g_rtn_fields
                  #子畫面 
                  IF cl_null(g_rtn_fields[1]) THEN
                     CALL ap_ref_array2(g_ref_fields,"SELECT gzdfl003 FROM gzdfl_t WHERE gzdfl001=? AND gzdfl002='"||g_lang||"'","") RETURNING g_rtn_fields
                  END IF
               END IF                           
            END IF
            LET g_gzzd_m.gzzd001_desc = '', g_rtn_fields[1] , ''   
            DISPLAY BY NAME g_gzzd_m.gzzd001_desc
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
               CALL azzi902_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL azzi902_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL azzi902_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL azzi902_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL azzi902_set_pk_array()
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
 
{<section id="azzi902.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION azzi902_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="azzi902.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION azzi902_browser_fill(ps_page_action)
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
   DEFINE ls_str            STRING 
   #end add-point
   
   #add-point:Function前置處理  name="browser_fill.before_browser_fill"
   
   #end add-point    
 
   LET l_searchcol = "gzzd001"
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
      LET l_sub_sql = " SELECT DISTINCT gzzd001 ",
 
                      " FROM gzzd_t ",
                      " ",
                      " ", 
 
 
 
                      " WHERE  ",l_wc, " AND ", l_wc2, cl_sql_add_filter("gzzd_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT gzzd001 ",
 
                      " FROM gzzd_t ",
                      " ",
                      " ", 
 
 
                      " WHERE  ",l_wc CLIPPED, cl_sql_add_filter("gzzd_t")
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
      INITIALIZE g_gzzd_m.* TO NULL
      CALL g_gzzd_d.clear()        
      CALL g_gzzd2_d.clear() 
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.gzzd001 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.gzzd001,t1.gzzal003",
                " FROM gzzd_t t0",
                #" ",
                " ",
 
 
 
                               " LEFT JOIN gzzal_t t1 ON t1.gzzal001=t0.gzzd001 AND t1.gzzal002='"||g_lang||"' ",
 
                " WHERE  ", l_wc," AND ",l_wc2, cl_sql_add_filter("gzzd_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
   
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"gzzd_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_gzzd001,g_browser[g_cnt].b_gzzd001_desc 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         
         
         #add-point:browser_fill段reference name="browser_fill.reference"
      LET ls_str = g_browser[g_cnt].b_gzzd001 
      #主程式到gzzal_t 子程式到gzdel_t
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_browser[g_cnt].b_gzzd001            
      IF NOT ls_str.getIndexOf("_",1) THEN 
         CALL ap_ref_array2(g_ref_fields,"SELECT gzzal003 FROM gzzal_t WHERE gzzal001=? AND gzzal002='"||g_lang||"'","") RETURNING g_rtn_fields
      ELSE
         IF ls_str.subString(1,2) = "q_" OR ls_str.subString(1,2) = "cq" THEN 
            CALL ap_ref_array2(g_ref_fields,"SELECT dzcal003 FROM dzcal_t WHERE dzcal001=? AND dzcal002='"||g_dlang||"'","") RETURNING g_rtn_fields
         ELSE          
            CALL ap_ref_array2(g_ref_fields,"SELECT gzdel003 FROM gzdel_t WHERE gzdel001=? AND gzdel002='"||g_lang||"'","") RETURNING g_rtn_fields
            #子畫面 
            IF cl_null(g_rtn_fields[1]) THEN
               CALL ap_ref_array2(g_ref_fields,"SELECT gzdfl003 FROM gzdfl_t WHERE gzdfl001=? AND gzdfl002='"||g_lang||"'","") RETURNING g_rtn_fields
            END IF
        END IF     
      END IF
      LET g_browser[g_cnt].b_gzzd001_desc = '', g_rtn_fields[1] , '' 
      DISPLAY BY NAME g_browser[g_cnt].b_gzzd001_desc      
         #end add-point  
      
         #遮罩相關處理
         CALL azzi902_browser_mask()
         
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
   
   IF cl_null(g_browser[g_cnt].b_gzzd001) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_gzzd_m.* TO NULL
      CALL g_gzzd_d.clear()
      CALL g_gzzd2_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL azzi902_fetch('')
   
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
 
{<section id="azzi902.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION azzi902_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_gzzd_m.gzzd001 = g_browser[g_current_idx].b_gzzd001   
 
   EXECUTE azzi902_master_referesh USING g_gzzd_m.gzzd001 INTO g_gzzd_m.gzzd001,g_gzzd_m.gzzd001_desc 
 
   CALL azzi902_show()
   
END FUNCTION
 
{</section>}
 
{<section id="azzi902.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION azzi902_ui_detailshow()
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
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx3) 
      #end add-point 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="azzi902.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION azzi902_ui_browser_refresh()
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
      IF g_browser[l_i].b_gzzd001 = g_gzzd_m.gzzd001 
 
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
 
{<section id="azzi902.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION azzi902_construct()
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
   INITIALIZE g_gzzd_m.* TO NULL
   CALL g_gzzd_d.clear()
   CALL g_gzzd2_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   CALL g_gzzd3_d.clear()
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON gzzd001
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
                 #Ctrlp:construct.c.gzzd001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzzd001
            #add-point:ON ACTION controlp INFIELD gzzd001 name="construct.c.gzzd001"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_gzzd001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzzd001  #顯示到畫面上

            NEXT FIELD gzzd001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzzd001
            #add-point:BEFORE FIELD gzzd001 name="construct.b.gzzd001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzzd001
            
            #add-point:AFTER FIELD gzzd001 name="construct.a.gzzd001"
            
            #END add-point
            
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON gzzdstus,gzzd002,gzzd003,gzzd004,gzzd005,gzzd006,gzzdmodid,gzzdmoddt, 
          gzzdownid,gzzdowndp,gzzdcrtid,gzzdcrtdp,gzzdcrtdt
           FROM s_detail1[1].gzzdstus,s_detail1[1].gzzd002,s_detail1[1].gzzd003,s_detail1[1].gzzd004, 
               s_detail1[1].gzzd005,s_detail1[1].gzzd006,s_detail2[1].gzzdmodid,s_detail2[1].gzzdmoddt, 
               s_detail2[1].gzzdownid,s_detail2[1].gzzdowndp,s_detail2[1].gzzdcrtid,s_detail2[1].gzzdcrtdp, 
               s_detail2[1].gzzdcrtdt
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<gzzdcrtdt>>----
         AFTER FIELD gzzdcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<gzzdmoddt>>----
         AFTER FIELD gzzdmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<gzzdcnfdt>>----
         
         #----<<gzzdpstdt>>----
 
 
 
           
         #單身一般欄位開窗相關處理
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzzdstus
            #add-point:BEFORE FIELD gzzdstus name="construct.b.page1.gzzdstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzzdstus
            
            #add-point:AFTER FIELD gzzdstus name="construct.a.page1.gzzdstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzzdstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzzdstus
            #add-point:ON ACTION controlp INFIELD gzzdstus name="construct.c.page1.gzzdstus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzzd002
            #add-point:BEFORE FIELD gzzd002 name="construct.b.page1.gzzd002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzzd002
            
            #add-point:AFTER FIELD gzzd002 name="construct.a.page1.gzzd002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzzd002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzzd002
            #add-point:ON ACTION controlp INFIELD gzzd002 name="construct.c.page1.gzzd002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzzd003
            #add-point:BEFORE FIELD gzzd003 name="construct.b.page1.gzzd003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzzd003
            
            #add-point:AFTER FIELD gzzd003 name="construct.a.page1.gzzd003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzzd003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzzd003
            #add-point:ON ACTION controlp INFIELD gzzd003 name="construct.c.page1.gzzd003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzzd004
            #add-point:BEFORE FIELD gzzd004 name="construct.b.page1.gzzd004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzzd004
            
            #add-point:AFTER FIELD gzzd004 name="construct.a.page1.gzzd004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzzd004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzzd004
            #add-point:ON ACTION controlp INFIELD gzzd004 name="construct.c.page1.gzzd004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzzd005
            #add-point:BEFORE FIELD gzzd005 name="construct.b.page1.gzzd005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzzd005
            
            #add-point:AFTER FIELD gzzd005 name="construct.a.page1.gzzd005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzzd005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzzd005
            #add-point:ON ACTION controlp INFIELD gzzd005 name="construct.c.page1.gzzd005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzzd006
            #add-point:BEFORE FIELD gzzd006 name="construct.b.page1.gzzd006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzzd006
            
            #add-point:AFTER FIELD gzzd006 name="construct.a.page1.gzzd006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzzd006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzzd006
            #add-point:ON ACTION controlp INFIELD gzzd006 name="construct.c.page1.gzzd006"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.gzzdmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzzdmodid
            #add-point:ON ACTION controlp INFIELD gzzdmodid name="construct.c.page2.gzzdmodid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzzdmodid  #顯示到畫面上

            NEXT FIELD gzzdmodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzzdmodid
            #add-point:BEFORE FIELD gzzdmodid name="construct.b.page2.gzzdmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzzdmodid
            
            #add-point:AFTER FIELD gzzdmodid name="construct.a.page2.gzzdmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzzdmoddt
            #add-point:BEFORE FIELD gzzdmoddt name="construct.b.page2.gzzdmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.gzzdownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzzdownid
            #add-point:ON ACTION controlp INFIELD gzzdownid name="construct.c.page2.gzzdownid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzzdownid  #顯示到畫面上

            NEXT FIELD gzzdownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzzdownid
            #add-point:BEFORE FIELD gzzdownid name="construct.b.page2.gzzdownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzzdownid
            
            #add-point:AFTER FIELD gzzdownid name="construct.a.page2.gzzdownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.gzzdowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzzdowndp
            #add-point:ON ACTION controlp INFIELD gzzdowndp name="construct.c.page2.gzzdowndp"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzzdowndp  #顯示到畫面上

            NEXT FIELD gzzdowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzzdowndp
            #add-point:BEFORE FIELD gzzdowndp name="construct.b.page2.gzzdowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzzdowndp
            
            #add-point:AFTER FIELD gzzdowndp name="construct.a.page2.gzzdowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.gzzdcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzzdcrtid
            #add-point:ON ACTION controlp INFIELD gzzdcrtid name="construct.c.page2.gzzdcrtid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzzdcrtid  #顯示到畫面上

            NEXT FIELD gzzdcrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzzdcrtid
            #add-point:BEFORE FIELD gzzdcrtid name="construct.b.page2.gzzdcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzzdcrtid
            
            #add-point:AFTER FIELD gzzdcrtid name="construct.a.page2.gzzdcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.gzzdcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzzdcrtdp
            #add-point:ON ACTION controlp INFIELD gzzdcrtdp name="construct.c.page2.gzzdcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzzdcrtdp  #顯示到畫面上

            NEXT FIELD gzzdcrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzzdcrtdp
            #add-point:BEFORE FIELD gzzdcrtdp name="construct.b.page2.gzzdcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzzdcrtdp
            
            #add-point:AFTER FIELD gzzdcrtdp name="construct.a.page2.gzzdcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzzdcrtdt
            #add-point:BEFORE FIELD gzzdcrtdt name="construct.b.page2.gzzdcrtdt"
            
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
 
{<section id="azzi902.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION azzi902_filter()
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
      CONSTRUCT g_wc_filter ON gzzd001
                          FROM s_browse[1].b_gzzd001
 
         BEFORE CONSTRUCT
               DISPLAY azzi902_filter_parser('gzzd001') TO s_browse[1].b_gzzd001
      
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
 
      CALL azzi902_filter_show('gzzd001')
 
END FUNCTION
 
{</section>}
 
{<section id="azzi902.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION azzi902_filter_parser(ps_field)
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
 
{<section id="azzi902.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION azzi902_filter_show(ps_field)
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
   LET ls_condition = azzi902_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="azzi902.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION azzi902_query()
   #add-point:query段define name="query.define_customerization"
   
   #end add-point   
   DEFINE ls_wc STRING
   #add-point:query段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
 
   #end add-point
   
   #add-point:Function前置處理  name="query.befroe_query"
   CALL g_gzzd3_d.clear()
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
   CALL g_gzzd_d.clear()
   CALL g_gzzd2_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL azzi902_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL azzi902_browser_fill(g_wc)
      CALL azzi902_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL azzi902_browser_fill("F")
   
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
      CALL azzi902_fetch("F") 
   END IF
   
   CALL azzi902_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="azzi902.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION azzi902_fetch(p_flag)
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
   
   LET g_gzzd_m.gzzd001 = g_browser[g_current_idx].b_gzzd001
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE azzi902_master_referesh USING g_gzzd_m.gzzd001 INTO g_gzzd_m.gzzd001,g_gzzd_m.gzzd001_desc 
 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "gzzd_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_gzzd_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_gzzd_m_mask_o.* =  g_gzzd_m.*
   CALL azzi902_gzzd_t_mask()
   LET g_gzzd_m_mask_n.* =  g_gzzd_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL azzi902_set_act_visible()
   CALL azzi902_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_gzzd_m_t.* = g_gzzd_m.*
   LET g_gzzd_m_o.* = g_gzzd_m.*
   
   #重新顯示   
   CALL azzi902_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="azzi902.insert" >}
#+ 資料新增
PRIVATE FUNCTION azzi902_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_gzzd_d.clear()
   CALL g_gzzd2_d.clear()
 
 
   INITIALIZE g_gzzd_m.* TO NULL             #DEFAULT 設定
   LET g_gzzd001_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
      
     
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point 
 
      CALL azzi902_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_gzzd_m.* TO NULL
         INITIALIZE g_gzzd_d TO NULL
         INITIALIZE g_gzzd2_d TO NULL
 
         CALL azzi902_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_gzzd_m.* = g_gzzd_m_t.*
         CALL azzi902_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_gzzd_d.clear()
      #CALL g_gzzd2_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL azzi902_set_act_visible()
   CALL azzi902_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_gzzd001_t = g_gzzd_m.gzzd001
 
   
   #組合新增資料的條件
   LET g_add_browse = " ",
                      " gzzd001 = '", g_gzzd_m.gzzd001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL azzi902_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL azzi902_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE azzi902_master_referesh USING g_gzzd_m.gzzd001 INTO g_gzzd_m.gzzd001,g_gzzd_m.gzzd001_desc 
 
   
   #遮罩相關處理
   LET g_gzzd_m_mask_o.* =  g_gzzd_m.*
   CALL azzi902_gzzd_t_mask()
   LET g_gzzd_m_mask_n.* =  g_gzzd_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_gzzd_m.gzzd001,g_gzzd_m.gzzd001_desc
   
   #功能已完成,通報訊息中心
   CALL azzi902_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="azzi902.modify" >}
#+ 資料修改
PRIVATE FUNCTION azzi902_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_gzzd_m.gzzd001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_gzzd001_t = g_gzzd_m.gzzd001
 
   CALL s_transaction_begin()
   
   OPEN azzi902_cl USING g_gzzd_m.gzzd001
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN azzi902_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE azzi902_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE azzi902_master_referesh USING g_gzzd_m.gzzd001 INTO g_gzzd_m.gzzd001,g_gzzd_m.gzzd001_desc 
 
   
   #遮罩相關處理
   LET g_gzzd_m_mask_o.* =  g_gzzd_m.*
   CALL azzi902_gzzd_t_mask()
   LET g_gzzd_m_mask_n.* =  g_gzzd_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL azzi902_show()
   WHILE TRUE
      LET g_gzzd001_t = g_gzzd_m.gzzd001
 
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL azzi902_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_gzzd_m.* = g_gzzd_m_t.*
         CALL azzi902_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_gzzd_m.gzzd001 != g_gzzd001_t 
 
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
   CALL azzi902_set_act_visible()
   CALL azzi902_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " ",
                      " gzzd001 = '", g_gzzd_m.gzzd001, "' "
 
   #填到對應位置
   CALL azzi902_browser_fill("")
 
   CALL azzi902_idx_chk()
 
   CLOSE azzi902_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL azzi902_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="azzi902.input" >}
#+ 資料輸入
PRIVATE FUNCTION azzi902_input(p_cmd)
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
   DEFINE l_success              LIKE type_t.num5
   DEFINE ld_lng_type            DYNAMIC ARRAY OF RECORD
          gzzy001                LIKE gzzy_t.gzzy001
          END RECORD
   DEFINE ls_cmd                 STRING
   DEFINE li                     LIKE type_t.num5
   DEFINE li_cnt                 LIKE type_t.num5
   DEFINE lc_spec_type           LIKE type_t.chr1
   DEFINE li_new_lineno          LIKE type_t.num10  #寫入的新行位置
   DEFINE li_new_gzzd            LIKE type_t.num10  #寫入的陣列
   DEFINE li_new_add             LIKE type_t.num10  #寫入的陣列
   DEFINE li_trans               LIKE type_t.num5
   DEFINE lc_gzzd_add            DYNAMIC ARRAY OF type_g_gzzd_d
   DEFINE lc_lang                LIKE type_t.chr6
   DEFINE la_gzzl002             DYNAMIC ARRAY OF LIKE gzzl_t.gzzl002
   DEFINE ls_sql                 STRING 
   DEFINE lc_gzzl001             LIKE gzzl_t.gzzl001
   DEFINE lc_gzzz001             LIKE gzzz_t.gzzz001
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
   DISPLAY BY NAME g_gzzd_m.gzzd001,g_gzzd_m.gzzd001_desc
   
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
   LET g_forupd_sql = "SELECT gzzdstus,gzzd002,gzzd003,gzzd004,gzzd005,gzzd006,gzzd002,gzzd003,gzzd004, 
       gzzdmodid,gzzdmoddt,gzzdownid,gzzdowndp,gzzdcrtid,gzzdcrtdp,gzzdcrtdt FROM gzzd_t WHERE gzzd001=?  
       AND gzzd002=? AND gzzd003=? AND gzzd004=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE azzi902_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL azzi902_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL azzi902_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_gzzd_m.gzzd001
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="azzi902.input.head" >}
   
      #單頭段
      INPUT BY NAME g_gzzd_m.gzzd001 
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
         AFTER FIELD gzzd001
            
            #add-point:AFTER FIELD gzzd001 name="input.a.gzzd001"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_gzzd_m.gzzd001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_gzzd_m.gzzd001 != g_gzzd001_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gzzd_t WHERE "||"gzzd001 = '"||g_gzzd_m.gzzd001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT azzi902_chk_gzzd001() THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_gzzd_m.gzzd001
            
            IF g_gzzd_m.gzzd001[1,2] = "q_" OR g_gzzd_m.gzzd001[1,2] = "cq" THEN 
                CALL ap_ref_array2(g_ref_fields,"SELECT dzcal003 FROM dzcal_t WHERE dzcal001=? AND dzcal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            ELSE 
                CALL ap_ref_array2(g_ref_fields,"SELECT gzzal003 FROM gzzal_t WHERE gzzal001=? AND gzzal002='"||g_dlang||"'","") RETURNING g_rtn_fields
                IF cl_null(g_rtn_fields[1]) THEN 
                   CALL ap_ref_array2(g_ref_fields,"SELECT gzdel003 FROM gzdel_t WHERE gzdel001=? AND gzdel002='"||g_dlang||"'","") RETURNING g_rtn_fields 
                END IF 
            END IF  
            
            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_gzzd_m.gzzd001
            #CALL ap_ref_array2(g_ref_fields,"SELECT gzzal003 FROM gzzal_t WHERE gzzal001=? AND gzzal002='"||g_lang||"'","") RETURNING g_rtn_fields
            LET g_gzzd_m.gzzd001_desc = '(', g_rtn_fields[1] , ')'
            DISPLAY BY NAME g_gzzd_m.gzzd001_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzzd001
            #add-point:BEFORE FIELD gzzd001 name="input.b.gzzd001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzzd001
            #add-point:ON CHANGE gzzd001 name="input.g.gzzd001"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.gzzd001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzzd001
            #add-point:ON ACTION controlp INFIELD gzzd001 name="input.c.gzzd001"
            
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
            DISPLAY BY NAME g_gzzd_m.gzzd001             
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
            
               #將遮罩欄位還原
               CALL azzi902_gzzd_t_mask_restore('restore_mask_o')
            
               UPDATE gzzd_t SET (gzzd001) = (g_gzzd_m.gzzd001)
                WHERE  gzzd001 = g_gzzd001_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzzd_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzzd_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gzzd_m.gzzd001
               LET gs_keys_bak[1] = g_gzzd001_t
               LET gs_keys[2] = g_gzzd_d[g_detail_idx].gzzd002
               LET gs_keys_bak[2] = g_gzzd_d_t.gzzd002
               LET gs_keys[3] = g_gzzd_d[g_detail_idx].gzzd003
               LET gs_keys_bak[3] = g_gzzd_d_t.gzzd003
               LET gs_keys[4] = g_gzzd_d[g_detail_idx].gzzd004
               LET gs_keys_bak[4] = g_gzzd_d_t.gzzd004
               CALL azzi902_update_b('gzzd_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_gzzd_m_t)
                     #LET g_log2 = util.JSON.stringify(g_gzzd_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL azzi902_gzzd_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL azzi902_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_gzzd001_t = g_gzzd_m.gzzd001
 
           
           IF g_gzzd_d.getLength() = 0 THEN
              NEXT FIELD gzzd002
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="azzi902.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_gzzd_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION get_other_rel_lang
            LET g_action_choice="get_other_rel_lang"
            IF cl_auth_chk_act("get_other_rel_lang") THEN
               
               #add-point:ON ACTION get_other_rel_lang name="input.detail_input.page1.get_other_rel_lang"
               #由字典檔匯入其他語言
               CALL s_transaction_begin()
               CALL azzi902_get_other_lang() RETURNING l_success
               IF l_success THEN
                  CALL s_transaction_end('Y','1')
                ELSE
                  CALL s_transaction_end('N','1')
               END IF
               CALL azzi902_b_fill(g_wc2) 
               EXIT DIALOG
               #END add-point
            END IF
 
 
 
 
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_gzzd_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL azzi902_b_fill(g_wc2) #test 
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
            CALL azzi902_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN azzi902_cl USING g_gzzd_m.gzzd001                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE azzi902_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN azzi902_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_gzzd_d[l_ac].gzzd002 IS NOT NULL
               AND g_gzzd_d[l_ac].gzzd003 IS NOT NULL
               AND g_gzzd_d[l_ac].gzzd004 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_gzzd_d_t.* = g_gzzd_d[l_ac].*  #BACKUP
               LET g_gzzd_d_o.* = g_gzzd_d[l_ac].*  #BACKUP
               CALL azzi902_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL azzi902_set_no_entry_b(l_cmd)
               OPEN azzi902_bcl USING g_gzzd_m.gzzd001,
 
                                                g_gzzd_d_t.gzzd002
                                                ,g_gzzd_d_t.gzzd003
                                                ,g_gzzd_d_t.gzzd004
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN azzi902_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH azzi902_bcl INTO g_gzzd_d[l_ac].gzzdstus,g_gzzd_d[l_ac].gzzd002,g_gzzd_d[l_ac].gzzd003, 
                      g_gzzd_d[l_ac].gzzd004,g_gzzd_d[l_ac].gzzd005,g_gzzd_d[l_ac].gzzd006,g_gzzd2_d[l_ac].gzzd002, 
                      g_gzzd2_d[l_ac].gzzd003,g_gzzd2_d[l_ac].gzzd004,g_gzzd2_d[l_ac].gzzdmodid,g_gzzd2_d[l_ac].gzzdmoddt, 
                      g_gzzd2_d[l_ac].gzzdownid,g_gzzd2_d[l_ac].gzzdowndp,g_gzzd2_d[l_ac].gzzdcrtid, 
                      g_gzzd2_d[l_ac].gzzdcrtdp,g_gzzd2_d[l_ac].gzzdcrtdt
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_gzzd_d_t.gzzd002,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_gzzd_d_mask_o[l_ac].* =  g_gzzd_d[l_ac].*
                  CALL azzi902_gzzd_t_mask()
                  LET g_gzzd_d_mask_n[l_ac].* =  g_gzzd_d[l_ac].*
                  
                  CALL azzi902_ref_show()
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
            INITIALIZE g_gzzd_d_t.* TO NULL
            INITIALIZE g_gzzd_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_gzzd_d[l_ac].* TO NULL
            #公用欄位預設值
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_gzzd2_d[l_ac].gzzdownid = g_user
      LET g_gzzd2_d[l_ac].gzzdowndp = g_dept
      LET g_gzzd2_d[l_ac].gzzdcrtid = g_user
      LET g_gzzd2_d[l_ac].gzzdcrtdp = g_dept 
      LET g_gzzd2_d[l_ac].gzzdcrtdt = cl_get_current()
      LET g_gzzd2_d[l_ac].gzzdmodid = g_user
      LET g_gzzd2_d[l_ac].gzzdmoddt = cl_get_current()
      LET g_gzzd_d[l_ac].gzzdstus = ''
 
 
  
            #一般欄位預設值
                  LET g_gzzd_d[l_ac].gzzdstus = "Y"
 
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            LET g_gzzd_d[l_ac].gzzd004 = FGL_GETENV("DGENV") 
            #end add-point
            LET g_gzzd_d_t.* = g_gzzd_d[l_ac].*     #新輸入資料
            LET g_gzzd_d_o.* = g_gzzd_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL azzi902_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL azzi902_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_gzzd_d[li_reproduce_target].* = g_gzzd_d[li_reproduce].*
               LET g_gzzd2_d[li_reproduce_target].* = g_gzzd2_d[li_reproduce].*
 
               LET g_gzzd_d[g_gzzd_d.getLength()].gzzd002 = NULL
               LET g_gzzd_d[g_gzzd_d.getLength()].gzzd003 = NULL
               LET g_gzzd_d[g_gzzd_d.getLength()].gzzd004 = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM gzzd_t 
             WHERE  gzzd001 = g_gzzd_m.gzzd001
 
               AND gzzd002 = g_gzzd_d[l_ac].gzzd002
               AND gzzd003 = g_gzzd_d[l_ac].gzzd003
               AND gzzd004 = g_gzzd_d[l_ac].gzzd004
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
               INSERT INTO gzzd_t
                           (
                            gzzd001,
                            gzzd002,gzzd003,gzzd004
                            ,gzzdstus,gzzd005,gzzd006,gzzdmodid,gzzdmoddt,gzzdownid,gzzdowndp,gzzdcrtid,gzzdcrtdp,gzzdcrtdt) 
                     VALUES(
                            g_gzzd_m.gzzd001,
                            g_gzzd_d[l_ac].gzzd002,g_gzzd_d[l_ac].gzzd003,g_gzzd_d[l_ac].gzzd004
                            ,g_gzzd_d[l_ac].gzzdstus,g_gzzd_d[l_ac].gzzd005,g_gzzd_d[l_ac].gzzd006,g_gzzd2_d[l_ac].gzzdmodid, 
                                g_gzzd2_d[l_ac].gzzdmoddt,g_gzzd2_d[l_ac].gzzdownid,g_gzzd2_d[l_ac].gzzdowndp, 
                                g_gzzd2_d[l_ac].gzzdcrtid,g_gzzd2_d[l_ac].gzzdcrtdp,g_gzzd2_d[l_ac].gzzdcrtdt) 
 
               #add-point:單身新增中 name="input.body.m_insert"
               
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_gzzd_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "gzzd_t:",SQLERRMESSAGE 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert"
               #若是中文，需做自動翻譯
               IF g_gzzd_d[l_ac].gzzd002 = "zh_TW" OR g_gzzd_d[l_ac].gzzd002 = "zh_CN" THEN
                  #取出自動翻譯出來的資料
                  CALL azzi902_zh_data_trans(g_gzzd_d[l_ac].*,l_cmd) RETURNING li_trans,lc_gzzd_add
                  DISPLAY "li_trans:",li_trans,"   lc_gzzd_add.getLength():",lc_gzzd_add.getLength()
                  #回傳是有資料的,則進行新增
                  IF li_trans THEN
                     LET li_new_add = 0
                     FOR li_new_gzzd = 1 TO lc_gzzd_add.getLength()
                        #新增在陣列下一筆
                        LET li_new_lineno = l_ac + li_new_gzzd                       
                        CALL g_gzzd_d.insertElement(li_new_lineno)
                        CALL g_gzzd2_d.insertElement(li_new_lineno)
                        LET g_gzzd_d[li_new_lineno].* = lc_gzzd_add[li_new_gzzd].*
                        LET g_gzzd2_d[li_new_lineno].* = g_gzzd2_d[l_ac].*
                        INSERT INTO gzzd_t
                              (gzzd001,gzzd002,gzzd003,gzzd004,
                               gzzdstus,gzzd005,gzzd006,gzzdmodid,gzzdmoddt,gzzdownid,gzzdowndp,gzzdcrtid,gzzdcrtdp,gzzdcrtdt) 
                        VALUES(g_gzzd_m.gzzd001,
                               g_gzzd_d[li_new_lineno].gzzd002,g_gzzd_d[li_new_lineno].gzzd003,g_gzzd_d[li_new_lineno].gzzd004,
                               g_gzzd_d[li_new_lineno].gzzdstus,g_gzzd_d[li_new_lineno].gzzd005,g_gzzd_d[li_new_lineno].gzzd006,g_gzzd2_d[li_new_lineno].gzzdmodid, 
                               g_gzzd2_d[li_new_lineno].gzzdmoddt,g_gzzd2_d[li_new_lineno].gzzdownid,g_gzzd2_d[li_new_lineno].gzzdowndp, 
                               g_gzzd2_d[li_new_lineno].gzzdcrtid,g_gzzd2_d[li_new_lineno].gzzdcrtdp,g_gzzd2_d[li_new_lineno].gzzdcrtdt)
                        IF NOT SQLCA.SQLCODE THEN
                           LET li_new_add = li_new_add + 1
                        END IF
                     END FOR
                     IF li_new_add THEN
                     # 160510 hiko覺得訊息太過擾民，且此訊息只是提示並非錯誤，因此mark掉訊息顯示的部分
                     #   INITIALIZE g_errparam TO NULL 
                     #   LET g_errparam.extend = g_gzzd_d[l_ac].gzzd003
                     #   LET g_errparam.replace[1] = li_new_add
                     #   LET g_errparam.code   = "lib-00402" 
                     #   LET g_errparam.popup  = TRUE 
                     #   CALL cl_err()
                     END IF
                  END IF
               END IF
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b=g_rec_b+1
               DISPLAY g_rec_b TO FORMONLY.cnt
            END IF
            
            #add-point:單身新增後 name="input.body.after_insert"
            LET g_rec_b = g_gzzd_d.getLength()
            DISPLAY g_rec_b TO FORMONLY.cnt
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
               IF azzi902_before_delete() THEN 
                  
 
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_gzzd_m.gzzd001
 
                  LET gs_keys[gs_keys.getLength()+1] = g_gzzd_d_t.gzzd002
                  LET gs_keys[gs_keys.getLength()+1] = g_gzzd_d_t.gzzd003
                  LET gs_keys[gs_keys.getLength()+1] = g_gzzd_d_t.gzzd004
 
 
                  #刪除下層單身
                  IF NOT azzi902_key_delete_b(gs_keys,'gzzd_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE azzi902_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE azzi902_bcl
               LET l_count = g_gzzd_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_gzzd_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzzdstus
            #add-point:BEFORE FIELD gzzdstus name="input.b.page1.gzzdstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzzdstus
            
            #add-point:AFTER FIELD gzzdstus name="input.a.page1.gzzdstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzzdstus
            #add-point:ON CHANGE gzzdstus name="input.g.page1.gzzdstus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzzd002
            #add-point:BEFORE FIELD gzzd002 name="input.b.page1.gzzd002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzzd002
            
            #add-point:AFTER FIELD gzzd002 name="input.a.page1.gzzd002"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_gzzd_m.gzzd001) AND NOT cl_null(g_gzzd_d[l_ac].gzzd002) AND NOT cl_null(g_gzzd_d[l_ac].gzzd003) AND NOT cl_null(g_gzzd_d[l_ac].gzzd004) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_gzzd_m.gzzd001 != g_gzzd001_t OR g_gzzd_d[l_ac].gzzd002 != g_gzzd_d_t.gzzd002 OR g_gzzd_d[l_ac].gzzd003 != g_gzzd_d_t.gzzd003 OR g_gzzd_d[l_ac].gzzd004 != g_gzzd_d_t.gzzd004 ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gzzd_t WHERE "||"gzzd001 = '"||g_gzzd_m.gzzd001 ||"' AND "|| "gzzd002 = '"||g_gzzd_d[l_ac].gzzd002 ||"' AND "|| "gzzd003 = '"||g_gzzd_d[l_ac].gzzd003 ||"' AND "|| "gzzd004 = '"||g_gzzd_d[l_ac].gzzd004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzzd002
            #add-point:ON CHANGE gzzd002 name="input.g.page1.gzzd002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzzd003
            #add-point:BEFORE FIELD gzzd003 name="input.b.page1.gzzd003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzzd003
            
            #add-point:AFTER FIELD gzzd003 name="input.a.page1.gzzd003"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_gzzd_m.gzzd001) AND NOT cl_null(g_gzzd_d[l_ac].gzzd002) AND NOT cl_null(g_gzzd_d[l_ac].gzzd003) AND NOT cl_null(g_gzzd_d[l_ac].gzzd004)  THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_gzzd_m.gzzd001 != g_gzzd001_t OR g_gzzd_d[l_ac].gzzd002 != g_gzzd_d_t.gzzd002 OR g_gzzd_d[l_ac].gzzd003 != g_gzzd_d_t.gzzd003 OR g_gzzd_d[l_ac].gzzd004 != g_gzzd_d_t.gzzd004 ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gzzd_t WHERE "||"gzzd001 = '"||g_gzzd_m.gzzd001 ||"' AND "|| "gzzd002 = '"||g_gzzd_d[l_ac].gzzd002 ||"' AND "|| "gzzd003 = '"||g_gzzd_d[l_ac].gzzd003 ||"' AND "|| "gzzd004 = '"||g_gzzd_d[l_ac].gzzd004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               CALL azzi902_convert_gzzd003() 
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzzd003
            #add-point:ON CHANGE gzzd003 name="input.g.page1.gzzd003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzzd004
            #add-point:BEFORE FIELD gzzd004 name="input.b.page1.gzzd004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzzd004
            
            #add-point:AFTER FIELD gzzd004 name="input.a.page1.gzzd004"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_gzzd_m.gzzd001) AND NOT cl_null(g_gzzd_d[l_ac].gzzd002) AND NOT cl_null(g_gzzd_d[l_ac].gzzd003) AND NOT cl_null(g_gzzd_d[l_ac].gzzd004) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_gzzd_m.gzzd001 != g_gzzd001_t OR g_gzzd_d[l_ac].gzzd002 != g_gzzd_d_t.gzzd002 OR g_gzzd_d[l_ac].gzzd003 != g_gzzd_d_t.gzzd003 OR g_gzzd_d[l_ac].gzzd004 != g_gzzd_d_t.gzzd004))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gzzd_t WHERE "||"gzzd001 = '"||g_gzzd_m.gzzd001 ||"' AND "|| "gzzd002 = '"||g_gzzd_d[l_ac].gzzd002 ||"' AND "|| "gzzd003 = '"||g_gzzd_d[l_ac].gzzd003 ||"' AND "|| "gzzd004 = '"||g_gzzd_d[l_ac].gzzd004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzzd004
            #add-point:ON CHANGE gzzd004 name="input.g.page1.gzzd004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzzd005
            #add-point:BEFORE FIELD gzzd005 name="input.b.page1.gzzd005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzzd005
            
            #add-point:AFTER FIELD gzzd005 name="input.a.page1.gzzd005"
            IF NOT cl_null(g_gzzd_d[l_ac].gzzd005) THEN
               IF NOT cl_chk_tworcn(g_gzzd_d[l_ac].gzzd002,g_gzzd_d[l_ac].gzzd005,20) THEN
                  NEXT FIELD gzzd005
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzzd005
            #add-point:ON CHANGE gzzd005 name="input.g.page1.gzzd005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzzd006
            #add-point:BEFORE FIELD gzzd006 name="input.b.page1.gzzd006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzzd006
            
            #add-point:AFTER FIELD gzzd006 name="input.a.page1.gzzd006"
            IF NOT cl_null(g_gzzd_d[l_ac].gzzd006) THEN
               IF NOT cl_chk_tworcn(g_gzzd_d[l_ac].gzzd002,g_gzzd_d[l_ac].gzzd006,20) THEN
                  NEXT FIELD gzzd006
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzzd006
            #add-point:ON CHANGE gzzd006 name="input.g.page1.gzzd006"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.gzzdstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzzdstus
            #add-point:ON ACTION controlp INFIELD gzzdstus name="input.c.page1.gzzdstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzzd002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzzd002
            #add-point:ON ACTION controlp INFIELD gzzd002 name="input.c.page1.gzzd002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzzd003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzzd003
            #add-point:ON ACTION controlp INFIELD gzzd003 name="input.c.page1.gzzd003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzzd004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzzd004
            #add-point:ON ACTION controlp INFIELD gzzd004 name="input.c.page1.gzzd004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzzd005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzzd005
            #add-point:ON ACTION controlp INFIELD gzzd005 name="input.c.page1.gzzd005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzzd006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzzd006
            #add-point:ON ACTION controlp INFIELD gzzd006 name="input.c.page1.gzzd006"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_gzzd_d[l_ac].* = g_gzzd_d_t.*
               CLOSE azzi902_bcl
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
               LET g_errparam.extend = g_gzzd_d[l_ac].gzzd002 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_gzzd_d[l_ac].* = g_gzzd_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               LET g_gzzd2_d[l_ac].gzzdmodid = g_user 
LET g_gzzd2_d[l_ac].gzzdmoddt = cl_get_current()
LET g_gzzd2_d[l_ac].gzzdmodid_desc = cl_get_username(g_gzzd2_d[l_ac].gzzdmodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
         
               #將遮罩欄位還原
               CALL azzi902_gzzd_t_mask_restore('restore_mask_o')
         
               UPDATE gzzd_t SET (gzzd001,gzzdstus,gzzd002,gzzd003,gzzd004,gzzd005,gzzd006,gzzdmodid, 
                   gzzdmoddt,gzzdownid,gzzdowndp,gzzdcrtid,gzzdcrtdp,gzzdcrtdt) = (g_gzzd_m.gzzd001, 
                   g_gzzd_d[l_ac].gzzdstus,g_gzzd_d[l_ac].gzzd002,g_gzzd_d[l_ac].gzzd003,g_gzzd_d[l_ac].gzzd004, 
                   g_gzzd_d[l_ac].gzzd005,g_gzzd_d[l_ac].gzzd006,g_gzzd2_d[l_ac].gzzdmodid,g_gzzd2_d[l_ac].gzzdmoddt, 
                   g_gzzd2_d[l_ac].gzzdownid,g_gzzd2_d[l_ac].gzzdowndp,g_gzzd2_d[l_ac].gzzdcrtid,g_gzzd2_d[l_ac].gzzdcrtdp, 
                   g_gzzd2_d[l_ac].gzzdcrtdt)
                WHERE  gzzd001 = g_gzzd_m.gzzd001 
 
                 AND gzzd002 = g_gzzd_d_t.gzzd002 #項次   
                 AND gzzd003 = g_gzzd_d_t.gzzd003  
                 AND gzzd004 = g_gzzd_d_t.gzzd004  
 
                 
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzzd_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "gzzd_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gzzd_m.gzzd001
               LET gs_keys_bak[1] = g_gzzd001_t
               LET gs_keys[2] = g_gzzd_d[g_detail_idx].gzzd002
               LET gs_keys_bak[2] = g_gzzd_d_t.gzzd002
               LET gs_keys[3] = g_gzzd_d[g_detail_idx].gzzd003
               LET gs_keys_bak[3] = g_gzzd_d_t.gzzd003
               LET gs_keys[4] = g_gzzd_d[g_detail_idx].gzzd004
               LET gs_keys_bak[4] = g_gzzd_d_t.gzzd004
               CALL azzi902_update_b('gzzd_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_gzzd_m),util.JSON.stringify(g_gzzd_d_t)
                     LET g_log2 = util.JSON.stringify(g_gzzd_m),util.JSON.stringify(g_gzzd_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL azzi902_gzzd_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_gzzd_m.gzzd001
 
               LET ls_keys[ls_keys.getLength()+1] = g_gzzd_d_t.gzzd002
               LET ls_keys[ls_keys.getLength()+1] = g_gzzd_d_t.gzzd003
               LET ls_keys[ls_keys.getLength()+1] = g_gzzd_d_t.gzzd004
 
               CALL azzi902_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
             
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE azzi902_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_gzzd_d[l_ac].* = g_gzzd_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE azzi902_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_gzzd_d.getLength() = 0 THEN
               NEXT FIELD gzzd002
            END IF
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_gzzd_d[li_reproduce_target].* = g_gzzd_d[li_reproduce].*
               LET g_gzzd2_d[li_reproduce_target].* = g_gzzd2_d[li_reproduce].*
 
               LET g_gzzd_d[li_reproduce_target].gzzd002 = NULL
               LET g_gzzd_d[li_reproduce_target].gzzd003 = NULL
               LET g_gzzd_d[li_reproduce_target].gzzd004 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_gzzd_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_gzzd_d.getLength()+1
            END IF
            
      END INPUT
 
 
      
      DISPLAY ARRAY g_gzzd2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
      
         BEFORE ROW
            CALL azzi902_b_fill(g_wc2) #test 
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_page = 2
            CALL azzi902_idx_chk()
            CALL azzi902_ui_detailshow()
        
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
            NEXT FIELD gzzd001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD gzzdstus
               WHEN "s_detail2"
                  NEXT FIELD gzzd002_2
 
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
   IF NOT INT_FLAG THEN
      CALL azzi902_gen_42s()
#15/04/15 先註解
     #lib/qry 的4fd全部不做
#      IF g_gzzd_m.gzzd001[1,2] = "q_" OR g_gzzd_m.gzzd001[1,3] = "cq_" OR
#          g_gzzd_m.gzzd001[1,3] = "cl_" OR g_gzzd_m.gzzd001[1,4] = "ccl_" THEN
#          INITIALIZE g_errparam TO NULL 
#          LET g_errparam.extend = "" 
#          LET g_errparam.code   = "azz-00316" 
#          LET g_errparam.popup  = TRUE 
#          CALL cl_err()
#          RETURN 
#      END IF
#      
#      CALL la_gzzl002.clear()
#      CALL ms_progs.clear()
#      CALL ld_lng_type.clear()
#      LET ls_sql = "SELECT gzdf001 FROM gzdf_t WHERE gzdf002 = ? ORDER BY gzdf001 "
#      DECLARE azzi902_gen_42s_gzdf CURSOR FROM ls_sql
#
#      LET li_cnt = 1
#      FOREACH azzi902_gen_42s_gzdf USING g_gzzd_m.gzzd001 INTO la_gzzl002[li_cnt]
#        LET li_cnt = li_cnt + 1
#      END FOREACH
#      CALL la_gzzl002.deleteElement(li_cnt)
#      IF la_gzzl002.getLength() = 0 THEN
#         LET la_gzzl002[1] = g_gzzd_m.gzzd001
#      END IF
#      
#      LET ls_sql = "SELECT gzzl001 FROM gzzl_t WHERE gzzl002 = ? ORDER BY gzzl001 "
#      DECLARE azzi902_gen_42s_gzzl CURSOR FROM ls_sql
#
#      LET ls_sql = "SELECT gzzz001 FROM gzzz_t WHERE gzzz002 = ? ORDER BY gzzz001 "
#      DECLARE azzi902_gen_42s_gzzz CURSOR FROM ls_sql
#
#      FOR li = 1 TO la_gzzl002.getLength()
#        FOREACH azzi902_gen_42s_gzzl USING la_gzzl002[li] INTO lc_gzzl001
#           FOREACH azzi902_gen_42s_gzzz USING lc_gzzl001 INTO lc_gzzz001
#              LET li_cnt = ms_progs.getLength()+1
#              LET ms_progs[li_cnt] = lc_gzzz001
#           END FOREACH
#        END FOREACH
#      END FOR

      
     # LET lc_spec_type = cl_chk_spec_type(g_gzzd_m.gzzd001)
     # IF lc_spec_type <> "M" THEN 
     #    RETURN
     # END IF 

#      IF cl_ask_confirm("azz-00099") THEN
#         LET ld_lng_type = s_azzi070_get_gzzy()
#         FOR li = 1 TO ld_lng_type.getLength()
#             FOR li_cnt =  1 TO ms_progs.getLength()
#
#                 LET ls_cmd = " r.r azzp191 ",ms_progs[li_cnt]," ", ld_lng_type[li].gzzy001
#                 RUN ls_cmd WITHOUT WAITING
#             END FOR 
#             # r.r azzp191 azzi900 zh_TW
#             #LET ls_cmd = " r.r azzp191 ",g_gzzd_m.gzzd001," ", ld_lng_type[li].gzzy001
#             #CALL cl_cmdrun(ls_cmd)
#             #RUN ls_cmd WITHOUT WAITING
#         END FOR
#
#      END IF
#15/04/15 先註解
   END IF
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="azzi902.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION azzi902_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL azzi902_b_fill(g_wc2) #第一階單身填充
      CALL azzi902_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL azzi902_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_gzzd_m.gzzd001,g_gzzd_m.gzzd001_desc
 
   CALL azzi902_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
    CALL azzi902_b2_fill() 
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="azzi902.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION azzi902_ref_show()
   #add-point:ref_show段define name="ref_show.define_customerization"
   
   #end add-point 
   DEFINE l_ac_t LIKE type_t.num10 #l_ac暫存用
   #add-point:ref_show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ref_show.define"
   DEFINE ls_str STRING 
   #end add-point
   
   #add-point:Function前置處理  name="ref_show.pre_function"
   
   #end add-point
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:ref_show段m_reference name="ref_show.head.reference"
   LET ls_str = g_gzzd_m.gzzd001
   #主程式到gzzal_t 子程式到gzdel_t
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_gzzd_m.gzzd001            
   IF NOT ls_str.getIndexOf("_",1) THEN 
      CALL ap_ref_array2(g_ref_fields,"SELECT gzzal003 FROM gzzal_t WHERE gzzal001=? AND gzzal002='"||g_lang||"'","") RETURNING g_rtn_fields
   ELSE
      IF ls_str.subString(1,2) = "q_" OR ls_str.subString(1,2) = "cq" THEN 
         CALL ap_ref_array2(g_ref_fields,"SELECT dzcal003 FROM dzcal_t WHERE dzcal001=? AND dzcal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      ELSE
         CALL ap_ref_array2(g_ref_fields,"SELECT gzdel003 FROM gzdel_t WHERE gzdel001=? AND gzdel002='"||g_lang||"'","") RETURNING g_rtn_fields
         #子畫面 
         IF cl_null(g_rtn_fields[1]) THEN
            CALL ap_ref_array2(g_ref_fields,"SELECT gzdfl003 FROM gzdfl_t WHERE gzdfl001=? AND gzdfl002='"||g_lang||"'","") RETURNING g_rtn_fields
         END IF
      END IF                           
    END IF
    LET g_gzzd_m.gzzd001_desc = '', g_rtn_fields[1] , ''   
    DISPLAY BY NAME g_gzzd_m.gzzd001_desc

   #end add-point
 
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_gzzd_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_gzzd2_d.getLength()
      #add-point:ref_show段d2_reference name="ref_show.body2.reference"
 
      #end add-point
   END FOR
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="azzi902.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION azzi902_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE gzzd_t.gzzd001 
   DEFINE l_oldno     LIKE gzzd_t.gzzd001 
 
   DEFINE l_master    RECORD LIKE gzzd_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE gzzd_t.* #此變數樣板目前無使用
 
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
 
   IF g_gzzd_m.gzzd001 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_gzzd001_t = g_gzzd_m.gzzd001
 
   
   LET g_gzzd_m.gzzd001 = ""
 
   LET g_master_insert = FALSE
   CALL azzi902_set_entry('a')
   CALL azzi902_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #清空key欄位的desc
      LET g_gzzd_m.gzzd001_desc = ''
   DISPLAY BY NAME g_gzzd_m.gzzd001_desc
 
   
   CALL azzi902_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_gzzd_m.* TO NULL
      INITIALIZE g_gzzd_d TO NULL
      INITIALIZE g_gzzd2_d TO NULL
 
      CALL azzi902_show()
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
   CALL azzi902_set_act_visible()
   CALL azzi902_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_gzzd001_t = g_gzzd_m.gzzd001
 
   
   #組合新增資料的條件
   LET g_add_browse = " ",
                      " gzzd001 = '", g_gzzd_m.gzzd001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL azzi902_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL azzi902_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL azzi902_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="azzi902.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION azzi902_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE gzzd_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE azzi902_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM gzzd_t
    WHERE  gzzd001 = g_gzzd001_t
 
       INTO TEMP azzi902_detail
   
   #將key修正為調整後   
   UPDATE azzi902_detail 
      #更新key欄位
      SET gzzd001 = g_gzzd_m.gzzd001
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
       , gzzdownid = g_user 
       , gzzdowndp = g_dept
       , gzzdcrtid = g_user
       , gzzdcrtdp = g_dept 
       , gzzdcrtdt = ld_date
       , gzzdmodid = g_user
       , gzzdmoddt = ld_date
      #, gzzdstus = "Y" 
 
 
 
                                       
   #將資料塞回原table   
   INSERT INTO gzzd_t SELECT * FROM azzi902_detail
   
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
   DROP TABLE azzi902_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_gzzd001_t = g_gzzd_m.gzzd001
 
   
   DROP TABLE azzi902_detail
   
END FUNCTION
 
{</section>}
 
{<section id="azzi902.delete" >}
#+ 資料刪除
PRIVATE FUNCTION azzi902_delete()
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
   
   IF g_gzzd_m.gzzd001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN azzi902_cl USING g_gzzd_m.gzzd001
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN azzi902_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE azzi902_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE azzi902_master_referesh USING g_gzzd_m.gzzd001 INTO g_gzzd_m.gzzd001,g_gzzd_m.gzzd001_desc 
 
   
   #遮罩相關處理
   LET g_gzzd_m_mask_o.* =  g_gzzd_m.*
   CALL azzi902_gzzd_t_mask()
   LET g_gzzd_m_mask_n.* =  g_gzzd_m.*
   
   CALL azzi902_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL azzi902_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM gzzd_t WHERE  gzzd001 = g_gzzd_m.gzzd001
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gzzd_t:",SQLERRMESSAGE 
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
      #   CLOSE azzi902_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_gzzd_d.clear() 
      CALL g_gzzd2_d.clear()       
 
     
      CALL azzi902_ui_browser_refresh()  
      #CALL azzi902_ui_headershow()  
      #CALL azzi902_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL azzi902_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL azzi902_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE azzi902_cl
 
   #功能已完成,通報訊息中心
   CALL azzi902_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="azzi902.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION azzi902_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #先清空單身變數內容
   CALL g_gzzd_d.clear()
   CALL g_gzzd2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT gzzdstus,gzzd002,gzzd003,gzzd004,gzzd005,gzzd006,gzzd002,gzzd003,gzzd004, 
       gzzdmodid,gzzdmoddt,gzzdownid,gzzdowndp,gzzdcrtid,gzzdcrtdp,gzzdcrtdt,t1.ooag011 ,t2.ooag011 , 
       t3.ooefl003 ,t4.ooag011 ,t5.ooefl003 FROM gzzd_t",   
               "",
               
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=gzzdmodid  ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=gzzdownid  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=gzzdowndp AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=gzzdcrtid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=gzzdcrtdp AND t5.ooefl002='"||g_dlang||"' ",
 
               " WHERE gzzd001=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("gzzd_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF azzi902_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY gzzd_t.gzzd002,gzzd_t.gzzd003,gzzd_t.gzzd004"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
         
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE azzi902_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR azzi902_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_gzzd_m.gzzd001   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_gzzd_m.gzzd001 INTO g_gzzd_d[l_ac].gzzdstus,g_gzzd_d[l_ac].gzzd002,g_gzzd_d[l_ac].gzzd003, 
          g_gzzd_d[l_ac].gzzd004,g_gzzd_d[l_ac].gzzd005,g_gzzd_d[l_ac].gzzd006,g_gzzd2_d[l_ac].gzzd002, 
          g_gzzd2_d[l_ac].gzzd003,g_gzzd2_d[l_ac].gzzd004,g_gzzd2_d[l_ac].gzzdmodid,g_gzzd2_d[l_ac].gzzdmoddt, 
          g_gzzd2_d[l_ac].gzzdownid,g_gzzd2_d[l_ac].gzzdowndp,g_gzzd2_d[l_ac].gzzdcrtid,g_gzzd2_d[l_ac].gzzdcrtdp, 
          g_gzzd2_d[l_ac].gzzdcrtdt,g_gzzd2_d[l_ac].gzzdmodid_desc,g_gzzd2_d[l_ac].gzzdownid_desc,g_gzzd2_d[l_ac].gzzdowndp_desc, 
          g_gzzd2_d[l_ac].gzzdcrtid_desc,g_gzzd2_d[l_ac].gzzdcrtdp_desc   #(ver:49)
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充 name="b_fill.fill"
         
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
 
            CALL g_gzzd_d.deleteElement(g_gzzd_d.getLength())
      CALL g_gzzd2_d.deleteElement(g_gzzd2_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
   
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_gzzd_d.getLength()
      LET g_gzzd_d_mask_o[l_ac].* =  g_gzzd_d[l_ac].*
      CALL azzi902_gzzd_t_mask()
      LET g_gzzd_d_mask_n[l_ac].* =  g_gzzd_d[l_ac].*
   END FOR
   
   LET g_gzzd2_d_mask_o.* =  g_gzzd2_d.*
   FOR l_ac = 1 TO g_gzzd2_d.getLength()
      LET g_gzzd2_d_mask_o[l_ac].* =  g_gzzd2_d[l_ac].*
      CALL azzi902_gzzd_t_mask()
      LET g_gzzd2_d_mask_n[l_ac].* =  g_gzzd2_d[l_ac].*
   END FOR
 
 
   FREE azzi902_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="azzi902.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION azzi902_idx_chk()
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
      IF g_detail_idx > g_gzzd_d.getLength() THEN
         LET g_detail_idx = g_gzzd_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_gzzd_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_gzzd_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_gzzd2_d.getLength() THEN
         LET g_detail_idx = g_gzzd2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_gzzd2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_gzzd2_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="azzi902.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION azzi902_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_gzzd_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="azzi902.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION azzi902_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   
   #end add-point
   
   DELETE FROM gzzd_t
    WHERE  gzzd001 = g_gzzd_m.gzzd001 AND
 
          gzzd002 = g_gzzd_d_t.gzzd002
      AND gzzd003 = g_gzzd_d_t.gzzd003
      AND gzzd004 = g_gzzd_d_t.gzzd004
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "gzzd_t:",SQLERRMESSAGE 
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
 
{<section id="azzi902.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION azzi902_delete_b(ps_table,ps_keys_bak,ps_page)
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
 
{<section id="azzi902.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION azzi902_insert_b(ps_table,ps_keys,ps_page)
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
 
{<section id="azzi902.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION azzi902_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
 
{<section id="azzi902.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION azzi902_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_gzzd_d[l_ac].gzzd002 = g_gzzd_d_t.gzzd002 
      AND g_gzzd_d[l_ac].gzzd003 = g_gzzd_d_t.gzzd003 
      AND g_gzzd_d[l_ac].gzzd004 = g_gzzd_d_t.gzzd004 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="azzi902.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION azzi902_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="azzi902.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION azzi902_lock_b(ps_table,ps_page)
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
   #CALL azzi902_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="azzi902.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION azzi902_unlock_b(ps_table,ps_page)
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
 
{<section id="azzi902.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION azzi902_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("gzzd001",TRUE)
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
 
{<section id="azzi902.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION azzi902_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("gzzd001",FALSE)
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
 
{<section id="azzi902.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION azzi902_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="azzi902.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION azzi902_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="azzi902.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION azzi902_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="azzi902.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION azzi902_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="azzi902.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION azzi902_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="azzi902.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION azzi902_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="azzi902.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION azzi902_default_search()
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
      LET ls_wc = ls_wc, " gzzd001 = '", g_argv[01], "' AND "
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
 
{<section id="azzi902.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION azzi902_fill_chk(ps_idx)
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
 
{<section id="azzi902.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION azzi902_modify_detail_chk(ps_record)
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
         LET ls_return = "gzzdstus"
      WHEN "s_detail2"
         LET ls_return = "gzzd002_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="azzi902.mask_functions" >}
&include "erp/azz/azzi902_mask.4gl"
 
{</section>}
 
{<section id="azzi902.state_change" >}
    
 
{</section>}
 
{<section id="azzi902.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION azzi902_set_pk_array()
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
   LET g_pk_array[1].values = g_gzzd_m.gzzd001
   LET g_pk_array[1].column = 'gzzd001'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="azzi902.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION azzi902_msgcentre_notify(lc_state)
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
   CALL azzi902_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_gzzd_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="azzi902.other_function" readonly="Y" >}
#+ 函式目的 分析add_item
PRIVATE FUNCTION azzi902_add_item(ls_tag,ls_tmp)
   DEFINE ls_tag   STRING
   DEFINE ls_tmp   STRING
   DEFINE li_pos   LIKE type_t.num5

   #濾除無值的內容
   IF ls_tmp.getLength() < 1 THEN
      RETURN
   END IF
   #DISPLAY "ls_tmp:",ls_tmp
   #濾除不在規則內的內容
   CASE
      #lbl_  or _desc
      WHEN ls_tmp.subString(1,4) = "lbl_" OR ls_tmp.subString(1,3) = "cl_" OR 
           ls_tmp.subString(ls_tmp.getLength()-4 ,ls_tmp.getLength()) = "_desc"
         #DISPLAY "ls_tmp:",ls_tmp
         IF NOT azzi902_get_gzzd(ls_tmp) THEN
            IF ls_tmp.subString(1,4) = "lbl_" THEN
               IF NOT azzi902_get_dzebl(ls_tmp.subString(5,ls_tmp.getLength())) THEN
                  CALL azzi902_set_default(ls_tmp) 
               END IF
            ELSE
               IF NOT azzi902_get_dzebl(ls_tmp.subString(ls_tmp.getLength()-4,ls_tmp.getLength())) THEN
                  CALL azzi902_set_default(ls_tmp) 
               END IF
            END IF
         END IF

     WHEN ls_tag = "Item" # ls_tmp.subString(1,4) = "cbo_" OR ls_tmp.subString(1,4) = "rdo_" 
         IF NOT azzi902_get_gzzd(ls_tmp) THEN
             CALL azzi902_set_default(ls_tmp)
         END IF

     WHEN ls_tag = "Button" OR ls_tag = "Group" OR ls_tag = "Page"

         #一般處理
         IF NOT azzi902_get_gzzd(ls_tmp) THEN
            CALL azzi902_set_default(ls_tmp)
         END IF
 
      OTHERWISE RETURN
   END CASE

END FUNCTION
#+ 畫面右邊的解析 畫面檔內標籤清單
PRIVATE FUNCTION azzi902_b2_fill()
    DEFINE ls_target  STRING
   DEFINE ls_module  STRING
   DEFINE lc_type    LIKE type_t.chr1
   DEFINE ls_sql     STRING 
   DEFINE lc_module  LIKE type_t.chr4
   DEFINE lc_cust    LIKE type_t.chr1
   DEFINE lc_gzzz001  LIKE gzzz_t.gzzz001
   DEFINE lc_gzza001  LIKE gzza_t.gzza001
   DEFINE lc_gzdf001  LIKE gzdf_t.gzdf001
   DEFINE ls_path STRING
   DEFINE lnode_temp  om.DomNode

   CALL g_gzzd3_d.clear()

   LET ls_path = azzi902_get_4fd_file()
   
   #om.DomNode
   LET lnode_temp = s_azzp191_load_xml(ls_path)
   #開始解析
   CALL azzi902_analyze(lnode_temp)
   LET g_rec_b3 = g_gzzd3_d.getLength()
END FUNCTION
#+ 分析lnode_tmp
PRIVATE FUNCTION azzi902_analyze(lnode_tmp)
   DEFINE lnode_tmp     om.DomNode
   DEFINE li_cnt        LIKE type_t.num10
   DEFINE ls_attribute  STRING
   DEFINE ls_tagname    STRING

   LET ls_tagname = lnode_tmp.getTagName()
   CASE ls_tagname
      #一般Label
      WHEN "Button"      LET ls_attribute = lnode_tmp.getAttribute("text")
      WHEN "Group"       LET ls_attribute = lnode_tmp.getAttribute("text")
      WHEN "Page"        LET ls_attribute = lnode_tmp.getAttribute("text")
      WHEN "Label"       LET ls_attribute = lnode_tmp.getAttribute("text")
      #以下是在TABLE內才成立
      WHEN "ButtonEdit"  LET ls_attribute = lnode_tmp.getAttribute("title")
      WHEN "CheckBox"    #先檢查text (一般狀況),在驗 title
         LET ls_attribute = lnode_tmp.getAttribute("text")
         CALL azzi902_add_item(ls_tagname,ls_attribute.trim())
         LET ls_attribute = lnode_tmp.getAttribute("title")
      WHEN "ComboBox"    LET ls_attribute = lnode_tmp.getAttribute("title")
      WHEN "RadioGroup"  LET ls_attribute = lnode_tmp.getAttribute("title")
      WHEN "DateEdit"    LET ls_attribute = lnode_tmp.getAttribute("title")
      WHEN "Edit"        LET ls_attribute = lnode_tmp.getAttribute("title")
      WHEN "TextEdit"    LET ls_attribute = lnode_tmp.getAttribute("title")
      WHEN "SpinEdit"    LET ls_attribute = lnode_tmp.getAttribute("title")
      WHEN "TimeEdit"    LET ls_attribute = lnode_tmp.getAttribute("title")
      WHEN "Slider"      LET ls_attribute = lnode_tmp.getAttribute("title")
      WHEN "FFLabel"     LET ls_attribute = lnode_tmp.getAttribute("title")
      WHEN "FFImage"     LET ls_attribute = lnode_tmp.getAttribute("title")
      #以下是ComboBox/RadioGroup使用
      WHEN "Item"        LET ls_attribute = lnode_tmp.getAttribute("text")
   END CASE
   CALL azzi902_add_item(ls_tagname,ls_attribute.trim())
   
   LET lnode_tmp = lnode_tmp.getFirstChild()

   WHILE lnode_tmp IS NOT NULL
      CALL azzi902_analyze(lnode_tmp)
      LET lnode_tmp = lnode_tmp.getNext()
   END WHILE

END FUNCTION
#+ 輸入中文 按下取得其他語言別 把其他相關語言別 insert DB
PRIVATE FUNCTION azzi902_get_other_lang()
   DEFINE ls_sql STRING 
   DEFINE pc_gzzd005 LIKE gzoz_t.gzoz000
   DEFINE li_cnt     LIKE type_t.num5
   DEFINE li         LIKE type_t.num5
   DEFINE lj         LIKE type_t.num5
   DEFINE r_success  LIKE type_t.num5
   DEFINE li_cnt2    LIKE type_t.num5
   DEFINE lc_gzzd002 LIKE gzzd_t.gzzd002
   DEFINE lc_gzzdmodid LIKE gzzd_t.gzzdmodid
   DEFINE lc_gzzdmoddt DATETIME YEAR TO SECOND
   DEFINE ld_lng_type   DYNAMIC ARRAY OF RECORD 
       gzzy001 LIKE gzzy_t.gzzy001
   END RECORD 
   DEFINE la_gzzy DYNAMIC ARRAY OF RECORD
             gzzy001 LIKE gzzy_t.gzzy001, #語言別
             gzozcol LIKE type_t.chr10    #語言別欄位
                  END RECORD
   DEFINE ls_sql_gzoz STRING
   DEFINE lc_gzzd001     LIKE gzzd_t.gzzd001
   DEFINE lc_gzzd003     LIKE gzzd_t.gzzd003  
   DEFINE lc_gzzd005_tw  LIKE gzzd_t.gzzd005  #轉換標籤
   DEFINE lc_gzzd005_old LIKE gzzd_t.gzzd005
   DEFINE lc_gzzd005_new LIKE gzzd_t.gzzd005
   DEFINE lc_gzzd006_tw  LIKE gzzd_t.gzzd006  #轉換註解
   DEFINE lc_gzzd006_old LIKE gzzd_t.gzzd006
   DEFINE lc_gzzd006_new LIKE gzzd_t.gzzd006
   DEFINE li_result      LIKE type_t.num5
   DEFINE li_result2     LIKE type_t.num5
   DEFINE li_count       LIKE type_t.num5
   DEFINE lr_gzzd_2        type_g_gzzd2_d
   
   LET r_success = TRUE
   LET g_action_choice=''
   IF NOT s_transaction_chk('Y','1') THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   IF g_gzzd_d.getLength() = 0 THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   LET lr_gzzd_2.gzzdownid = g_user
   LET lr_gzzd_2.gzzdowndp = g_dept
   LET lr_gzzd_2.gzzdcrtid = g_user
   LET lr_gzzd_2.gzzdcrtdp = g_dept
   LET lr_gzzd_2.gzzdcrtdt = cl_get_current()
   LET lr_gzzd_2.gzzdmodid = g_user
   LET lr_gzzd_2.gzzdmoddt = cl_get_current()


   #取標準或客製
   LET g_std_cust = FGL_GETENV("DGENV")    
   #gzzd 有標準及客製
   LET ls_sql = "SELECT gzzd003,gzzd005,gzzd006 FROM gzzd_t WHERE gzzd001 = '",g_gzzd_m.gzzd001,"' AND gzzd002 = 'zh_TW' AND gzzd004 ='",g_std_cust CLIPPED ,"' ORDER BY gzzd001"

   #取出語言種類與項目
   LET la_gzzy = azzi902_get_gzzy()
   
   DECLARE azzi902_gzzd_zhtw_cs CURSOR FROM ls_sql

   FOREACH azzi902_gzzd_zhtw_cs INTO lc_gzzd003,lc_gzzd005_tw,lc_gzzd006_tw
      #跑單身陣列
      FOR li_cnt = 1 TO la_gzzy.getLength()
         #以繁體中文為主
         LET ls_sql_gzoz = "SELECT ",la_gzzy[li_cnt].gzozcol CLIPPED,
                           "  FROM gzoz_t WHERE gzoz000= '",lc_gzzd005_tw CLIPPED,"' "                           #151008-00003#1 151008 by sakura add
                            #" FROM gzoz_t WHERE gzoz501='standard' AND gzoz000= '",lc_gzzd005_tw CLIPPED,"' "   #151008-00003#1 151008 by sakura mark
         PREPARE s4 FROM ls_sql_gzoz
         EXECUTE s4 INTO lc_gzzd005_new
         LET li_result = SQLCA.SQLCODE

         #以繁體中文為主
         LET ls_sql_gzoz = "SELECT ",la_gzzy[li_cnt].gzozcol CLIPPED,
                            " FROM gzoz_t WHERE gzoz000= '",lc_gzzd006_tw CLIPPED,"' "
         PREPARE s5 FROM ls_sql_gzoz
         EXECUTE s5 INTO lc_gzzd006_new

         IF (NOT li_result AND NOT cl_null(lc_gzzd005_new) ) OR (NOT li_result2 AND NOT cl_null(lc_gzzd006_new) ) THEN 

            SELECT COUNT(*)  INTO li_count FROM gzzd_t
             WHERE gzzd001 = g_gzzd_m.gzzd001
               AND gzzd002 = la_gzzy[li_cnt].gzzy001
               AND gzzd003 = lc_gzzd003
               AND gzzd004 = g_std_cust
           
            IF li_count = 0 THEN 
               INSERT INTO gzzd_t(gzzdstus,gzzd001,gzzd002,gzzd003,gzzd004,gzzd005,gzzd006,
                                  gzzdcrtid,gzzdcrtdp,gzzdcrtdt,gzzdownid,gzzdowndp)
                  VALUES('Y',g_gzzd_m.gzzd001,la_gzzy[li_cnt].gzzy001,lc_gzzd003,g_std_cust,lc_gzzd005_new,lc_gzzd006_new,
                         lr_gzzd_2.gzzdcrtid,lr_gzzd_2.gzzdcrtdp,lr_gzzd_2.gzzdcrtdt,lr_gzzd_2.gzzdownid,lr_gzzd_2.gzzdowndp)
            ELSE 
              SELECT gzzd006 INTO lc_gzzd005_old,lc_gzzd006_old FROM gzzd_t
               WHERE gzzd001 = g_gzzd_m.gzzd001
                 AND gzzd002 = la_gzzy[li_cnt].gzzy001
                 AND gzzd003 = lc_gzzd003
                 AND gzzd004 = g_std_cust

               IF NOT SQLCA.SQLCODE THEN
                  IF NOT cl_null(lc_gzzd005_old) THEN
                     LET lc_gzzd005_new = lc_gzzd005_old
                  END IF
                  IF NOT cl_null(lc_gzzd006_old) THEN
                     LET lc_gzzd006_new = lc_gzzd006_old  
                  END IF  
                  UPDATE gzzd_t SET gzzd005 = lc_gzzd005_new,gzzd006 = lc_gzzd006_new,
                                    gzzdmodid = lr_gzzd_2.gzzdmodid,gzzdmoddt = lr_gzzd_2.gzzdmoddt
                      WHERE gzzd001 = g_gzzd_m.gzzd001 
                        AND gzzd002 = la_gzzy[li_cnt].gzzy001
                        AND gzzd003 = lc_gzzd003
                        AND gzzd004 = g_std_cust   
               END IF 
            END IF 

         END IF 
         FREE s4
         FREE s5
      END FOR
   END FOREACH 
    CALL azzi902_b_fill(g_wc2)
    RETURN r_success
END FUNCTION
#+ 取得 dzebl欄位說明
PRIVATE FUNCTION azzi902_get_dzebl(ls_temp)
   DEFINE ls_temp   STRING
   DEFINE li_pos  LIKE type_t.num5
   DEFINE l_dzebl   RECORD 
            dzebl001  LIKE dzebl_t.dzebl001,
            dzebl003  LIKE dzebl_t.dzebl003
                 END RECORD
   #DISPLAY "ls_temp:",ls_temp
   LET l_dzebl.dzebl001 = ls_temp.trim()

   SELECT dzebl003 INTO l_dzebl.dzebl003 FROM dzebl_t
    WHERE dzebl001 = l_dzebl.dzebl001 AND dzebl002 = g_default_lang

   IF cl_null(l_dzebl.dzebl003) THEN
       
       RETURN FALSE
   ELSE
      LET li_pos = g_gzzd3_d.getLength() + 1
      LET g_gzzd3_d[li_pos].gzzd003 = "lbl_",l_dzebl.dzebl001
      LET g_gzzd3_d[li_pos].gzzd005 = l_dzebl.dzebl003
      
      RETURN TRUE
   END IF   
END FUNCTION
#+convert gzzd003 to lowercase
PRIVATE FUNCTION azzi902_convert_gzzd003()
   DEFINE ls_str STRING 
   DEFINE li  LIKE type_t.num5
   DEFINE ls_tmp  STRING   
   LET ls_str = g_gzzd_d[l_ac].gzzd003
   
   IF ls_str.getIndexOf("_",1) THEN 
      LET li = ls_str.getIndexOf("_",1)
      LET ls_tmp = DOWNSHIFT((ls_str.subString(1,li-1))) ,ls_str.subString(li,ls_str.getLength())
      LET g_gzzd_d[l_ac].gzzd003 = ls_tmp
   END IF
END FUNCTION
#+取得語言別種類
PRIVATE FUNCTION azzi902_get_gzzy()
   DEFINE ls_sql  STRING
   DEFINE la_gzzy DYNAMIC ARRAY OF RECORD
             gzzy001 LIKE gzzy_t.gzzy001,
             gzozcol LIKE type_t.chr10
                  END RECORD
   DEFINE li_cnt  LIKE type_t.num5

   IF ma_gzzy.getLength() = 0 THEN
      LET ls_sql = "SELECT gzzy001 FROM gzzy_t WHERE gzzystus = 'Y' "
      DECLARE get_gzzy_cs CURSOR FROM ls_sql
      LET li_cnt = 1
      FOREACH get_gzzy_cs INTO la_gzzy[li_cnt].gzzy001
         IF SQLCA.SQLCODE THEN
            EXIT FOREACH
         END IF
         #除了繁體中文取其他語言別
         CASE la_gzzy[li_cnt].gzzy001
            WHEN "en_US" LET la_gzzy[li_cnt].gzozcol = "gzoz001"
            WHEN "zh_CN" LET la_gzzy[li_cnt].gzozcol = "gzoz002"
            WHEN "ja_JP" LET la_gzzy[li_cnt].gzozcol = "gzoz003"
            WHEN "vi_VN" LET la_gzzy[li_cnt].gzozcol = "gzoz004"
            WHEN "th_TH" LET la_gzzy[li_cnt].gzozcol = "gzoz005"
            OTHERWISE
               CONTINUE FOREACH
         END CASE
         LET li_cnt = li_cnt + 1
      END FOREACH
      CALL la_gzzy.deleteElement(li_cnt)
      LET ma_gzzy = la_gzzy
   END IF
   RETURN ma_gzzy
END FUNCTION
#+ 取得 gzzd 標準轉換標籤
PRIVATE FUNCTION azzi902_get_gzzd(ls_temp)
   DEFINE ls_temp STRING
   DEFINE li_pos  LIKE type_t.num5
   DEFINE l_gzzd  RECORD 
            gzzd001  LIKE gzzd_t.gzzd001,
            gzzd002  LIKE gzzd_t.gzzd002,
            gzzd003  LIKE gzzd_t.gzzd003,
            gzzd005  LIKE gzzd_t.gzzd005 
                 END RECORD
   DEFINE l_gzzf005  LIKE gzzf_t.gzzf005  

   LET l_gzzd.gzzd001 = g_gzzd_m.gzzd001
   LET l_gzzd.gzzd003 = ls_temp.trim()
   
   #取預設標準 轉換標籤
      SELECT gzzd005 INTO l_gzzd.gzzd005 FROM gzzd_t
       WHERE gzzd001 = "standard" 
         AND gzzd002 = g_default_lang
         AND gzzd003 = l_gzzd.gzzd003

   IF STATUS THEN
      RETURN FALSE
   ELSE
      LET li_pos = g_gzzd3_d.getLength() + 1
      LET g_gzzd3_d[li_pos].gzzd003 = l_gzzd.gzzd003
      LET g_gzzd3_d[li_pos].gzzd005 = l_gzzd.gzzd005
      RETURN TRUE

   END IF 
END FUNCTION
################################################################################
# Descriptions...: 設預設值當gzzd 及 dzebl 沒有對應就已預設 
# Memo...........:
# Usage..........: CALL azzi902_set_default(ls_temp)
#                  RETURNING 回传参数
# Input parameter: ls_temp
#                : 
# Return code....: 
#                : 
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi902_set_default(ls_temp)
   DEFINE ls_temp STRING
   DEFINE li_pos  LIKE type_t.num5

   FOR li_pos = 1 TO g_gzzd3_d.getLength()
       #如果有重複就不加進去
       IF ls_temp = g_gzzd3_d[li_pos].gzzd003 THEN 
          RETURN  
       END IF 
   END FOR 
   
   LET li_pos = g_gzzd3_d.getLength() + 1
   LET g_gzzd3_d[li_pos].gzzd003 = ls_temp
   LET g_gzzd3_d[li_pos].gzzd005 = "" 
END FUNCTION

################################################################################
# Descriptions...: 把選取的筆數放入陣列
# Memo...........:
# Usage..........: azzi902_fill_arr_select(pi_cnt,pi_ac)
#                  
# Input parameter: pi_cnt 選取的那一筆 NUMBER(5)
#                : pi_ac  要insert的那一筆 NUMBER(5)
# Return code....: 
# Date & Author..: 2014/12/24 By jrg542
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi902_fill_arr_select(pi_cnt,pi_ac)
   DEFINE pi_cnt   LIKE type_t.num5
   DEFINE pi_ac    LIKE type_t.num5
   DEFINE ld_lng_type   DYNAMIC ARRAY OF RECORD
       gzzy001     LIKE gzzy_t.gzzy001
   END RECORD
   DEFINE li_cnt   LIKE type_t.num5

   #LET ld_lng_type = s_azzi070_get_gzzy() 161105-00002 #1 mark
   LET g_std_cust = FGL_GETENV("DGENV")

   #FOR li_cnt = 1 TO ld_lng_type.getLength() 161105-00002 #1 mark
       #CALL azzi902_ins_gzzd(ld_lng_type[li_cnt].gzzy001,g_gzzd3_d[pi_cnt].gzzd003) 161105-00002 #1 mark
       #161105-00002 start
       IF (g_default_lang = "zh_TW" OR g_default_lang = "zh_CN" )THEN  
          CALL azzi902_ins_gzzd(g_default_lang,g_gzzd3_d[pi_cnt].gzzd003,g_gzzd3_d[pi_cnt].gzzd005)
       END IF 
       #161105-00002 end
   #END FOR 161105-00002 #1 mark

END FUNCTION

################################################################################
# Descriptions...: 比對是否有重複
# Memo...........:
# Usage..........: CALL azzi902_chk_arr_setect(pi_index)
#                  
# Input parameter: pi_index 比對那一筆 NUMBER(5)
# Return code....: 
# Date & Author..: 2014/12/24 By jrg542
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi902_chk_arr_setect(pi_index)
   DEFINE pi_type   LIKE type_t.num5
   DEFINE li_cnt    LIKE type_t.num5
   DEFINE li_chk    LIKE type_t.num5
   DEFINE pi_index  LIKE type_t.num5 #右邊的那一筆

   LET li_chk =  FALSE 

   FOR li_cnt =  1 TO g_gzzd_d.getLength()
       #比對是否有一樣，有一樣把其他語系補滿
       #IF g_gzzd_d[li_cnt].gzzd003 = g_gzzd3_d[pi_index].gzzd003 THEN 161105-00002 #1 mark
       IF g_gzzd_d[li_cnt].gzzd003 = g_gzzd3_d[pi_index].gzzd003 AND g_gzzd_d[li_cnt].gzzd002 = g_default_lang THEN        
          #CALL azzi902_chk2_arr_setect(g_gzzd_d[li_cnt].gzzd003) 161105-00002 #1 mark
          LET li_chk =  TRUE  
          EXIT FOR 
       END IF 
   END FOR 

   RETURN li_chk 
END FUNCTION

################################################################################
# Descriptions...: 補滿其他語系
# Memo...........:
# Usage..........: CALL azzi902_chk2_arr_setect(pc_gzzd003)
#                  RETURNING 回传参数
# Input parameter: pc_gzzd003 代轉標籤 CHAR(80)
# Return code....: 
# Date & Author..: 2014/12/24 By jrg542
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi902_chk2_arr_setect(pc_gzzd003)
   DEFINE pi_cnt        LIKE type_t.num5
   DEFINE pi_ac         LIKE type_t.num5
   DEFINE pc_gzzd003    LIKE gzzd_t.gzzd003
   DEFINE ld_lng_type   DYNAMIC ARRAY OF RECORD
       gzzy001          LIKE gzzy_t.gzzy001
   END RECORD
   DEFINE li_cnt        LIKE type_t.num5
   DEFINE li_cnt2       LIKE type_t.num5
   DEFINE ls_sql        STRING 

   LET g_std_cust = FGL_GETENV("DGENV")
   LET ld_lng_type = s_azzi070_get_gzzy()
   
   FOR li_cnt = 1 TO ld_lng_type.getLength()

       LET ls_sql = "SELECT COUNT(*) FROM gzzd_t ",
                    " WHERE gzzd001 ='",g_gzzd_m.gzzd001,"'",
                    "   AND gzzd002 ='",ld_lng_type[li_cnt].gzzy001,"'",
                    "   AND gzzd003 ='",pc_gzzd003,"'",
                    "   AND gzzd004 ='",g_std_cust,"'"

      PREPARE azzi902_chk2_pre FROM ls_sql 
      EXECUTE azzi902_chk2_pre INTO li_cnt2      
      #沒有一樣要insert該筆語系
      IF li_cnt2 = 0 THEN    
         #CALL azzi902_ins_gzzd(ld_lng_type[li_cnt].gzzy001,pc_gzzd003)
      END IF 
   FREE azzi902_chk2_pre    
   END FOR  
END FUNCTION

################################################################################
# Descriptions...: 補該筆語系
# Memo...........:
# Usage..........: CALL azzi902_ins_gzzd(pc_gzzd002,pc_gzzd003,pc_gzzd005)
#                  RETURNING 
# Input parameter: pc_gzzd002 語系 CHAR(6)
#                : pc_gzzd003 代轉標籤 CHAR(80)
#                : pc_gzzd005 說明 
# Return code....: 
# Date & Author..: 2014/12/24 By jrg542
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi902_ins_gzzd(pc_gzzd002,pc_gzzd003,pc_gzzd005)
   DEFINE pc_gzzd002     LIKE gzzd_t.gzzd002
   DEFINE pc_gzzd003     LIKE gzzd_t.gzzd003
   DEFINE lc_gzzd002_new LIKE gzzd_t.gzzd002
   DEFINE pc_gzzd005     LIKE gzzd_t.gzzd005
   DEFINE li_cnt         LIKE type_t.num5
   DEFINE lc_gzzd005_new LIKE gzzd_t.gzzd005

#161105-00002 start
   IF pc_gzzd002 = "zh_TW" THEN 
      LET lc_gzzd002_new = "zh_CN"
   ELSE 
     LET lc_gzzd002_new = "zh_TW"
   END IF 

   IF l_ac = 0 OR g_gzzd_d.getLength() = 0 THEN 
      LET l_ac = 1
   END IF

   LET g_gzzd2_d[l_ac].gzzdownid = g_user
   LET g_gzzd2_d[l_ac].gzzdowndp = g_dept
   LET g_gzzd2_d[l_ac].gzzdcrtid = g_user
   LET g_gzzd2_d[l_ac].gzzdcrtdp = g_dept 
   LET g_gzzd2_d[l_ac].gzzdcrtdt = cl_get_current()
   
   IF cl_null(pc_gzzd005) THEN 
      #空值 不必換 直接insert 當下語系
       INSERT INTO gzzd_t(gzzd001,gzzd002,gzzd003,gzzd004,gzzdstus,
                      gzzd005,gzzd006,gzzdownid,gzzdowndp,gzzdcrtid,
                      gzzdcrtdp,gzzdcrtdt) 
          VALUES(g_gzzd_m.gzzd001,pc_gzzd002,pc_gzzd003,g_std_cust,'Y',
                 pc_gzzd005,'',g_gzzd2_d[l_ac].gzzdownid,g_gzzd2_d[l_ac].gzzdowndp,g_gzzd2_d[l_ac].gzzdcrtid,
                 g_gzzd2_d[l_ac].gzzdcrtdp,g_gzzd2_d[l_ac].gzzdcrtdt)  
   ELSE 
     CALL cl_trans_code_tw_cn(lc_gzzd002_new,pc_gzzd005) RETURNING lc_gzzd005_new
        FOR li_cnt = 1 TO 2
            #先 insert 新語系 ，在 insert 當下語系
            INSERT INTO gzzd_t(gzzd001,gzzd002,gzzd003,gzzd004,gzzdstus,
                      gzzd005,gzzd006,gzzdownid,gzzdowndp,gzzdcrtid,
                      gzzdcrtdp,gzzdcrtdt) 
             VALUES(g_gzzd_m.gzzd001,lc_gzzd002_new,pc_gzzd003,g_std_cust,'Y',
                      lc_gzzd005_new,'',g_gzzd2_d[l_ac].gzzdownid,g_gzzd2_d[l_ac].gzzdowndp,g_gzzd2_d[l_ac].gzzdcrtid,
                       g_gzzd2_d[l_ac].gzzdcrtdp,g_gzzd2_d[l_ac].gzzdcrtdt)  

             LET lc_gzzd002_new = pc_gzzd002 
             LET lc_gzzd005_new = pc_gzzd005
        END FOR 
   END IF 


#   LET g_gzzd2_d[l_ac].gzzdownid = g_user
#   LET g_gzzd2_d[l_ac].gzzdowndp = g_dept
#   LET g_gzzd2_d[l_ac].gzzdcrtid = g_user
#   LET g_gzzd2_d[l_ac].gzzdcrtdp = g_dept 
#   LET g_gzzd2_d[l_ac].gzzdcrtdt = cl_get_current()
#   
#   INSERT INTO gzzd_t(gzzd001,gzzd002,gzzd003,gzzd004,gzzdstus,
#                      gzzd005,gzzd006,gzzdownid,gzzdowndp,gzzdcrtid,
#                      gzzdcrtdp,gzzdcrtdt) 
#          VALUES(g_gzzd_m.gzzd001,pc_gzzd002,pc_gzzd003,g_std_cust,'Y',
#                 '','',g_gzzd2_d[l_ac].gzzdownid,g_gzzd2_d[l_ac].gzzdowndp,g_gzzd2_d[l_ac].gzzdcrtid,
#                 g_gzzd2_d[l_ac].gzzdcrtdp,g_gzzd2_d[l_ac].gzzdcrtdt)  
#161105-00002 end
END FUNCTION

################################################################################
# Descriptions...: 中文資料自動轉換繁簡體
# Memo...........:
# Usage..........: CALL azzi902_zh_data_trans(g_gzzd_org,p_cmd)
#                  RETURNING ls_trans_insert, g_gzzd_new
# Input parameter: g_gzzd_org        陣列資料
# Return code....: ls_trans_insert   是否需自動翻譯
#                : g_gzzd_new        自動翻譯後的陣列資料
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi902_zh_data_trans(g_gzzd_org,p_cmd)
   DEFINE g_gzzd_org       type_g_gzzd_d
   DEFINE g_gzzd_src       type_g_gzzd_d
   DEFINE g_gzzd_new       DYNAMIC ARRAY OF type_g_gzzd_d
   DEFINE ls_count         LIKE type_t.num5
   DEFINE ls_cnt           LIKE type_t.num5
   DEFINE ls_lang_new      LIKE type_t.chr10
   DEFINE ls_data_new      LIKE type_t.chr500
   DEFINE li_trans_insert  LIKE type_t.num5
   DEFINE p_cmd            LIKE type_t.chr1
   DEFINE la_gzoz          DYNAMIC ARRAY OF RECORD
             gzzy001 LIKE gzzy_t.gzzy001,
             gzoz000 LIKE gzoz_t.gzoz000
                           END RECORD
   DEFINE li_gzoz_cnt      LIKE type_t.num10
   DEFINE li_gzzd_new_cnt  LIKE type_t.num10
   DEFINE ls_sql           STRING 

   CALL g_gzzd_new.clear()
   LET li_trans_insert = TRUE

   IF g_gzzd_org.gzzd002 = "zh_TW" OR g_gzzd_org.gzzd002 = "zh_CN" THEN
      LET g_gzzd_new[1].* = g_gzzd_org.*

      #要轉換的另一中文語系
      IF g_gzzd_org.gzzd002 = "zh_TW" THEN
         LET g_gzzd_new[1].gzzd002 = "zh_CN"
         LET ls_sql = "002"
      ELSE
         LET g_gzzd_new[1].gzzd002 = "zh_TW"
         LET ls_sql = "000"
      END IF

      LET ls_count = 0
      SELECT COUNT(1) INTO ls_count FROM gzzd_t
       WHERE gzzd001 = g_gzzd_m.gzzd001
         AND gzzd002 = g_gzzd_new[1].gzzd002 #新的語系內必須為空
         AND gzzd003 = g_gzzd_org.gzzd003
         AND gzzd004 = g_gzzd_org.gzzd004

      IF ls_count = 0 THEN
         LET ls_lang_new = g_gzzd_new[1].gzzd002
         #若有用到禁用字，則不往下進行
         CALL cl_trans_code_tw_cn(ls_lang_new,g_gzzd_org.gzzd005) RETURNING g_gzzd_new[1].gzzd005
         IF NOT cl_null(g_gzzd_org.gzzd005) AND cl_null(g_gzzd_new[1].gzzd005) THEN
            LET li_trans_insert = FALSE
            RETURN li_trans_insert,g_gzzd_new
         END IF
         CALL cl_trans_code_tw_cn(ls_lang_new,g_gzzd_org.gzzd006) RETURNING g_gzzd_new[1].gzzd006
         IF NOT cl_null(g_gzzd_org.gzzd006) AND cl_null(g_gzzd_new[1].gzzd006) THEN
            LET li_trans_insert = FALSE
            RETURN li_trans_insert,g_gzzd_new
         END IF
         
         CALL cl_trans_code_all(g_gzzd_org.gzzd002,g_gzzd_org.gzzd005) RETURNING la_gzoz
         IF la_gzoz.getLength() > 0 THEN

            #刪除回傳資料內的簡繁中文部分
            LET li_gzoz_cnt = 1
            WHILE TRUE
               IF li_gzoz_cnt > la_gzoz.getLength() THEN
                  EXIT WHILE
               END IF
               IF la_gzoz[li_gzoz_cnt].gzzy001 = "zh_TW" OR la_gzoz[li_gzoz_cnt].gzzy001 = "zh_CN" THEN
                  CALL la_gzoz.deleteElement(li_gzoz_cnt)
               ELSE
                  LET li_gzoz_cnt = li_gzoz_cnt + 1
               END IF
            END WHILE

            IF la_gzoz.getLength() > 0 THEN
               #比對加入
               FOR li_gzoz_cnt = 1 TO la_gzoz.getLength()
                  LET g_gzzd_new[g_gzzd_new.getLength()+1].* = g_gzzd_new[1].*
                  LET g_gzzd_new[g_gzzd_new.getLength()].gzzd002 = la_gzoz[li_gzoz_cnt].gzzy001
                  LET g_gzzd_new[g_gzzd_new.getLength()].gzzd005 = la_gzoz[li_gzoz_cnt].gzoz000
                  LET g_gzzd_new[g_gzzd_new.getLength()].gzzd006 = ""
               END FOR
            END IF
         END IF

         #處理gzzd006
         IF g_gzzd_new.getLength() > 1 THEN
            CALL cl_trans_code_all(g_gzzd_org.gzzd002,g_gzzd_org.gzzd006) RETURNING la_gzoz
            IF la_gzoz.getLength() > 0 THEN
               FOR li_gzzd_new_cnt = 1 TO g_gzzd_new.getLength()
                  FOR li_gzoz_cnt = 1 TO la_gzoz.getLength()
                     IF la_gzoz[li_gzoz_cnt].gzzy001 = g_gzzd_new[li_gzzd_new_cnt].gzzd002 THEN
                        LET g_gzzd_new[li_gzzd_new_cnt].gzzd006 = la_gzoz[li_gzoz_cnt].gzoz000
                     END IF
                  END FOR
               END FOR
            END IF
         END IF

      ELSE

         LET ls_count = 0
         #當新增輸入zh_CN 對應新語系 zh_TW ，zh_TW 有這筆資料 要insert 到字典檔
         IF g_gzzd_org.gzzd002 = "zh_CN" OR g_gzzd_org.gzzd002 = "zh_TW" THEN 
            SELECT gzzd002,gzzd003,gzzd004,gzzd005,gzzd006 INTO g_gzzd_src.gzzd002,g_gzzd_src.gzzd003,g_gzzd_src.gzzd004,g_gzzd_src.gzzd005,g_gzzd_src.gzzd006 FROM gzzd_t
             WHERE gzzd001 = g_gzzd_m.gzzd001
              AND gzzd002 = g_gzzd_new[1].gzzd002 #新的語系內必須為空
              AND gzzd003 = g_gzzd_org.gzzd003
              AND gzzd004 = g_gzzd_org.gzzd004
   
            LET ls_sql = "SELECT COUNT(1) FROM gzoz_t ",
                         " WHERE gzoz",ls_sql ,"='",g_gzzd_src.gzzd005,"'" 
            PREPARE azzi902_zh_data_pre FROM ls_sql
            EXECUTE azzi902_zh_data_pre INTO ls_count 
            FREE azzi902_zh_data_pre  
              
            IF ls_count = 0 THEN 
               CALL cl_trans_code_tw_cn(g_gzzd_org.gzzd002,g_gzzd_src.gzzd005) RETURNING g_gzzd_new[1].gzzd005
            END IF 
            
            LET ls_sql = "SELECT COUNT(1) FROM gzoz_t ",
                         " WHERE gzoz",ls_sql ,"='",g_gzzd_src.gzzd006,"'" 
            PREPARE azzi902_zh_data_pre2 FROM ls_sql
            EXECUTE azzi902_zh_data_pre2 INTO ls_count 
            FREE azzi902_zh_data_pre2  

            IF ls_count = 0 THEN   
               CALL cl_trans_code_tw_cn(g_gzzd_org.gzzd002,g_gzzd_org.gzzd006) RETURNING g_gzzd_new[1].gzzd006
            END IF 
         END IF 

         
         LET li_trans_insert = FALSE
      END IF
   ELSE
      LET li_trans_insert = FALSE
   END IF

   RETURN li_trans_insert,g_gzzd_new
END FUNCTION

################################################################################
# Descriptions...: 確認4fd 是否存在
# Memo...........:
# Usage..........: CALL azzi902_chk_gzzd001()
#                  RETURNING TRUE/FALSE
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/01/27 By jrg542
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi902_chk_gzzd001()
   DEFINE lc_type    LIKE type_t.chr1
   DEFINE ls_file    STRING 
 
   LET ls_file = azzi902_get_4fd_file()

   IF NOT os.Path.exists(ls_file) THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code   = "azz-00306"
         LET g_errparam.popup  = TRUE
         LET g_errparam.replace[1] = g_gzzd_m.gzzd001
         CALL cl_err()
         RETURN FALSE 
   END IF
   RETURN TRUE  
END FUNCTION

################################################################################
# Descriptions...: 取4fd檔案路徑
# Memo...........:
# Usage..........: CALL azzi902_get_4fd_file()
#                  RETURNING 回传参数
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/01/27 By jrg542
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi902_get_4fd_file()
   DEFINE ls_target   STRING
   DEFINE ls_module   STRING
   DEFINE lc_type     LIKE type_t.chr1
   DEFINE ls_sql      STRING 
   DEFINE lc_module   LIKE type_t.chr4
   DEFINE lc_cust     LIKE type_t.chr1
   DEFINE lc_gzzz001  LIKE gzzz_t.gzzz001
   DEFINE lc_gzza001  LIKE gzza_t.gzza001
   DEFINE lc_gzdf001  LIKE gzdf_t.gzdf001
   DEFINE ls_path     STRING
   DEFINE ls_count    LIKE type_t.num5    #No:150715-00011
   
   LET ls_target = g_gzzd_m.gzzd001
   LET lc_type = cl_chk_spec_type(g_gzzd_m.gzzd001) 

   IF lc_type = "M" OR lc_type = "N" THEN 

      #qry 開窗id 要另外處理
      IF ls_target.subString(1,2) = "q_" OR ls_target.subString(1,3) = "cq_" THEN 
         LET ls_sql = "SELECT dzca002 FROM dzca_t WHERE dzca001 = '",ls_target,"'"
         PREPARE azzi902_check_module_pre FROM ls_sql
         EXECUTE azzi902_check_module_pre INTO lc_cust
         FREE azzi902_check_module_pre
         LET lc_module = "QRY"
      ELSE 
         #M 主程式 及 N <-表象是NULL,實際上應該是作業ID 
         CASE 
            #作業轉成程式
            WHEN lc_type = "N"
               LET lc_gzzz001 = g_gzzd_m.gzzd001
               SELECT gzzz002 INTO lc_gzza001
                FROM gzzz_t
                 WHERE gzzz001 = lc_gzzz001

              LET ls_target = lc_gzza001
         END CASE 
         LET ls_sql = "SELECT gzza003,gzza011 FROM gzza_t WHERE gzza001 = '",ls_target,"'"
         PREPARE azzi902_check_module_pre4 FROM ls_sql
         EXECUTE azzi902_check_module_pre4 INTO lc_module,lc_cust
         FREE azzi902_check_module_pre4
      END IF 
#15/06/16 sart--
      #M 主程式 及 N <-表象是NULL,實際上應該是作業ID 
      --CASE 
         #作業轉成程式
         --WHEN lc_type = "N"
            --LET lc_gzzz001 = g_gzzd_m.gzzd001
            --SELECT gzzz002 INTO lc_gzza001
             --FROM gzzz_t
              --WHERE gzzz001 = lc_gzzz001
--
            --LET ls_target = lc_gzza001
      --END CASE 
      --LET ls_sql = "SELECT gzza003,gzza011 FROM gzza_t WHERE gzza001 = '",ls_target,"'"
      --PREPARE azzi902_check_module_pre FROM ls_sql
      --EXECUTE azzi902_check_module_pre INTO lc_module,lc_cust
      --FREE azzi902_check_module_pre
#15/06/16 end       
   ELSE
     
      CASE
         WHEN lc_type = "F"
            LET ls_sql = "SELECT gzdf001,gzdf003 FROM gzdf_t WHERE gzdf002 = '",ls_target,"'"
            PREPARE azzi902_check_module_pre2 FROM ls_sql
            EXECUTE azzi902_check_module_pre2 INTO lc_gzdf001,lc_cust
            FREE azzi902_check_module_pre2
            #取得所屬哪一隻程式的子作業
            #先到主程式 
            SELECT gzza003 INTO lc_module FROM gzza_t WHERE gzza001 = lc_gzdf001 
            IF SQLCA.sqlcode THEN 
               #在到子程式
               SELECT gzde002 INTO lc_module FROM gzde_t WHERE gzde001 = lc_gzdf001   
            END IF

         #No:150715-00011 ---start---
         #新增判斷Q類開窗多語言的判斷，
         #若屬於Q類者，則先檢查r.q中(dzca_t)是否有該筆客製資料
         WHEN lc_type = "Q"
            LET ls_count = 0

            #若有客製資料則先取客製資料，若無客製則視為標準資料 (q類開窗預設在r.q中一定會有資料)
            LET ls_sql = "SELECT count(*) FROM dzca_t WHERE dzca001 = '",ls_target,"' AND dzca002 = 'c'"
            PREPARE azzi902_check_module_pre5 FROM ls_sql
            EXECUTE azzi902_check_module_pre5 INTO ls_count
            FREE azzi902_check_module_pre5

            IF ls_count > 0 THEN   #客製
               LET lc_cust = "c"
               LET lc_module = "CQRY"
            ELSE
               #150908-00016 ---modify start---
            #   LET lc_cust = "s"
               LET ls_sql = "SELECT dzca002 FROM dzca_t WHERE dzca001 = '",ls_target,"'"
               PREPARE azzi902_check_module_pre6 FROM ls_sql
               EXECUTE azzi902_check_module_pre6 INTO lc_cust
               FREE azzi902_check_module_pre6
               #150908-00016 --- modify end ---

               LET lc_module = "QRY"
            END IF
         #No:150715-00011 --- end ---

         OTHERWISE 
             LET ls_sql = "SELECT gzde002,gzde008 FROM gzde_t WHERE gzde001 = '",ls_target,"'"
             PREPARE azzi902_check_module_pre3 FROM ls_sql
             EXECUTE azzi902_check_module_pre3 INTO lc_module,lc_cust
             FREE azzi902_check_module_pre3
      END CASE 
   END IF 
    #標準
      IF lc_cust = 's' THEN 
         LET ls_module = lc_module 
      ELSE 
      #客製
         #dxx or exx or cxx 應該不用判別
         LET ls_module = lc_module 
         CASE 
            WHEN ls_module.subString(1,1) = 'A' 
               LET ls_module = 'C',ls_module.subString(2,3)
            WHEN ls_module = 'LIB' OR ls_module = 'SUB' OR ls_module = 'QRY'
               LET ls_module = 'C',ls_module.subString(1,3)            
            WHEN ls_module.subString(1,1) = 'B'
               #ex 假如 bxmt800_ph bxmt800_ph_01 判斷bxm 是否是行業模組 是:表示行業模組 否:表示在標準模組下的行業程式 
               IF s_azzi900_chk_industry(ls_module.subString(2,3)) THEN 
                 LET ls_module = 'D',ls_module.subString(2,3)
               ELSE 
                 LET ls_module = 'C',ls_module.subString(2,3)
               END IF 
            WHEN ls_module.subString(1,1) = 'M' #light平台
              LET ls_module = 'N',ls_module.subString(2,3)    
   
         END CASE  
      END IF 

   #4fd 檔案路徑      
   LET ls_path = os.Path.join(os.Path.join(FGL_GETENV(ls_module),"4fd"),ls_target),".4fd"  
   RETURN ls_path
END FUNCTION

################################################################################
# Descriptions...: 搜尋同一標籤的另一個語言別
# Memo...........:
# Usage..........: CALL azzi902_search_other_tag(pc_lang,pc_gzzd003,pc_gzzd004)
#                  RETURNING TRUE/FLASE,li_cnt
# Input parameter: pc_lang    語言別
#                : pc_gzzd003 標籤
#                : pc_gzzd004 使用標示
# Return code....: TRUE/FLASE,li_cnt
# Date & Author..: 2015/03/19 By jrg542
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi902_search_other_tag(pc_lang,pc_gzzd003,pc_gzzd004)
   DEFINE li_cnt      LIKE type_t.num5
   DEFINE pc_gzzd001  LIKE gzzd_t.gzzd001
   DEFINE pc_lang     LIKE type_t.chr6
   DEFINE pc_gzzd003  LIKE gzzd_t.gzzd003
   DEFINE pc_gzzd004  LIKE gzzd_t.gzzd004 

   FOR li_cnt =  1 TO g_gzzd_d.getLength()
       IF g_gzzd_d[li_cnt].gzzd002 = pc_lang AND g_gzzd_d[li_cnt].gzzd003 = pc_gzzd003 AND g_gzzd_d[li_cnt].gzzd004 = pc_gzzd004 THEN 

          IF cl_null(g_gzzd_d[li_cnt].gzzd005) OR cl_null(g_gzzd_d[li_cnt].gzzd006) THEN 
             RETURN TRUE,li_cnt 
          END IF 
       END IF 
   END FOR 
   RETURN FALSE,li_cnt 
END FUNCTION

################################################################################
# Descriptions...: 產生str/42s
# Memo...........:
# Usage..........: CALL azzi902_gen_42s()
#                  RETURNING 
# Input parameter: 传入参数变量1   传入参数变量说明1
# Return code....: 回传参数变量1   回传参数变量说明1
# Date & Author..: 2015/04/15 By jrg542
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi902_gen_42s()
      DEFINE ld_lng_type  DYNAMIC ARRAY OF RECORD
          gzzy001       LIKE gzzy_t.gzzy001
          END RECORD
   DEFINE li_cnt        LIKE type_t.num5   
   DEFINE lc_spec_type  LIKE type_t.chr1
   DEFINE ls_cmd        STRING 
   
   IF g_gzzd_m.gzzd001[1,2] = "q_" OR g_gzzd_m.gzzd001[1,3] = "cq_" OR
     g_gzzd_m.gzzd001[1,3] = "cl_" OR g_gzzd_m.gzzd001[1,4] = "ccl_" THEN
     INITIALIZE g_errparam TO NULL 
     LET g_errparam.extend = "" 
     LET g_errparam.code   = "azz-00316" 
     LET g_errparam.popup  = TRUE 
     CALL cl_err()
     RETURN 
   END IF
   
  CALL ld_lng_type.clear()
  LET li_cnt = 1
  LET lc_spec_type = cl_chk_spec_type(g_gzzd_m.gzzd001)
  LET ld_lng_type = s_azzi070_get_gzzy()
  IF lc_spec_type = "M" THEN 
     IF cl_ask_confirm("azz-00099") THEN
         
         FOR li_cnt = 1 TO ld_lng_type.getLength()
             LET ls_cmd = " r.r azzp191 ",g_gzzd_m.gzzd001," ", ld_lng_type[li_cnt].gzzy001
             RUN ls_cmd WITHOUT WAITING
         END FOR
      END IF
  ELSE 
     #不是主程式只產生該隻str檔，避免效能被拖慢
     #r.r azzp191 azzi900 zh_TW '' '' Y

     INITIALIZE g_errparam TO NULL 
     LET g_errparam.extend = "" 
     LET g_errparam.code   = "azz-00323" #不是主程式，只產生str
     LET g_errparam.popup  = TRUE 
     CALL cl_err()
     FOR li_cnt = 1 TO ld_lng_type.getLength()
         LET ls_cmd = " r.r azzp191 ",g_gzzd_m.gzzd001," ", ld_lng_type[li_cnt].gzzy001 ," '' " ," '' ", "Y"
         RUN ls_cmd WITHOUT WAITING
     END FOR
  END IF 
END FUNCTION

 
{</section>}
 
