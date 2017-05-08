#該程式未解開Section, 採用最新樣板產出!
{<section id="afmt080.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2014-10-30 10:14:23), PR版次:0002(2016-04-26 15:44:37)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000049
#+ Filename...: afmt080
#+ Description: (取消)計提利息維護
#+ Creator....: 00810(2014-10-20 16:37:06)
#+ Modifier...: 00810 -SD/PR- 07959
 
{</section>}
 
{<section id="afmt080.global" >}
#應用 i07 樣板自動產生(Version:43)
#add-point:填寫註解說明 name="global.memo"
#Modify.........: No.151125-00001#2    2015/11/27 By catmoon  作廢前詢問「是否執行作廢？」
#Modify.........: No.160318-00025#37   2016/04/19 BY pengxin  將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
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
PRIVATE type type_g_fmaz_m        RECORD
       fmaz002 LIKE fmaz_t.fmaz002, 
   fmaz003 LIKE fmaz_t.fmaz003, 
   fmaz012 LIKE fmaz_t.fmaz012, 
   fmaz013 LIKE fmaz_t.fmaz013, 
   b_stus LIKE type_t.chr500
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_fmaz_d        RECORD
       fmaz014 LIKE fmaz_t.fmaz014, 
   fmaz001 LIKE fmaz_t.fmaz001, 
   fmaz001_desc LIKE type_t.chr500, 
   fmaz001_desc_1 LIKE type_t.chr500, 
   fmaz004 LIKE fmaz_t.fmaz004, 
   fmaz011 LIKE fmaz_t.fmaz011, 
   fmaz006 LIKE fmaz_t.fmaz006, 
   fmaz006_desc LIKE type_t.chr500, 
   sumday LIKE type_t.chr500, 
   fmaz011_desc LIKE type_t.num20_6, 
   fmaz008 LIKE fmaz_t.fmaz008, 
   fmaz001_desc_2 LIKE type_t.chr500, 
   fmaz010 LIKE fmaz_t.fmaz010
       END RECORD
PRIVATE TYPE type_g_fmaz3_d RECORD
       fmaz014 LIKE fmaz_t.fmaz014, 
   fmazownid LIKE fmaz_t.fmazownid, 
   fmazownid_desc LIKE type_t.chr500, 
   fmazowndp LIKE fmaz_t.fmazowndp, 
   fmazowndp_desc LIKE type_t.chr500, 
   fmazcrtid LIKE fmaz_t.fmazcrtid, 
   fmazcrtid_desc LIKE type_t.chr500, 
   fmazcrtdp LIKE fmaz_t.fmazcrtdp, 
   fmazcrtdp_desc LIKE type_t.chr500, 
   fmazcrtdt DATETIME YEAR TO SECOND, 
   fmazmodid LIKE fmaz_t.fmazmodid, 
   fmazmodid_desc LIKE type_t.chr500, 
   fmazmoddt DATETIME YEAR TO SECOND, 
   fmazcnfid LIKE fmaz_t.fmazcnfid, 
   fmazcnfid_desc LIKE type_t.chr500, 
   fmazcnfdt DATETIME YEAR TO SECOND, 
   fmazpstid LIKE fmaz_t.fmazpstid, 
   fmazpstid_desc LIKE type_t.chr500, 
   fmazpstdt LIKE fmaz_t.fmazpstdt
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_sumfmam005          LIKE type_t.num20_6 #貸款的和
DEFINE g_sumfmaw008          LIKE type_t.num20_6 #還款的和

DEFINE g_fmaz_s01 DYNAMIC ARRAY OF RECORD
         fmaz014        like fmaz_t.fmaz014,
         fmaz001        like fmaz_t.fmaz001,
         fmaz004        like fmaz_t.fmaz004,
         fmaz011        like fmaz_t.fmaz011,
         fmaz005        like fmaz_t.fmaz005,
         fmaz006        like fmaz_t.fmaz006,
         fmao003        like fmao_t.fmao003,
         fmaz011_desc_1 like fmao_t.fmao006,
         thisdatem      like type_t.num20_6
                  END RECORD
                  
DEFINE g_fmaz_s02 DYNAMIC ARRAY OF RECORD
         fmaz014        like fmaz_t.fmaz014,
         fmaz001        like fmaz_t.fmaz001,
         fmaz004        like fmaz_t.fmaz004,
         fmaz011        like fmaz_t.fmaz011,
         fmaz005        like fmaz_t.fmaz005,
         fmam003        like fmam_t.fmam003,
         fmaw002        like fmaw_t.fmaw003,
         daynum         like type_t.num5,
         fmaz006        like fmaz_t.fmaz006,
         fmam005        like fmam_t.fmam005,
         fmaz008        like fmaz_t.fmaz008,
         fman008        like fman_t.fman008,
         fmaz010        like fmaz_t.fmaz010
                  END RECORD
#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_fmaz_m          type_g_fmaz_m
DEFINE g_fmaz_m_t        type_g_fmaz_m
DEFINE g_fmaz_m_o        type_g_fmaz_m
DEFINE g_fmaz_m_mask_o   type_g_fmaz_m #轉換遮罩前資料
DEFINE g_fmaz_m_mask_n   type_g_fmaz_m #轉換遮罩後資料
 
   DEFINE g_fmaz002_t LIKE fmaz_t.fmaz002
DEFINE g_fmaz003_t LIKE fmaz_t.fmaz003
 
 
DEFINE g_fmaz_d          DYNAMIC ARRAY OF type_g_fmaz_d
DEFINE g_fmaz_d_t        type_g_fmaz_d
DEFINE g_fmaz_d_o        type_g_fmaz_d
DEFINE g_fmaz_d_mask_o   DYNAMIC ARRAY OF type_g_fmaz_d #轉換遮罩前資料
DEFINE g_fmaz_d_mask_n   DYNAMIC ARRAY OF type_g_fmaz_d #轉換遮罩後資料
DEFINE g_fmaz3_d   DYNAMIC ARRAY OF type_g_fmaz3_d
DEFINE g_fmaz3_d_t type_g_fmaz3_d
DEFINE g_fmaz3_d_o type_g_fmaz3_d
DEFINE g_fmaz3_d_mask_o   DYNAMIC ARRAY OF type_g_fmaz3_d #轉換遮罩前資料
DEFINE g_fmaz3_d_mask_n   DYNAMIC ARRAY OF type_g_fmaz3_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_fmaz002 LIKE fmaz_t.fmaz002,
      b_fmaz003 LIKE fmaz_t.fmaz003
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
 
{<section id="afmt080.main" >}
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
   CALL cl_ap_init("afm","")
 
   #add-point:作業初始化 name="main.init"
   INITIALIZE g_errparam TO NULL
   LET g_errparam.extend = ""
   LET g_errparam.code   = "afm-00218"
   LET g_errparam.popup  = TRUE
   CALL cl_err()
   #離開作業
   CALL cl_ap_exitprogram("0")
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT fmaz002,fmaz003,fmaz012,fmaz013,''", 
                      " FROM fmaz_t",
                      " WHERE fmazent= ? AND fmaz002=? AND fmaz003=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afmt080_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.fmaz002,t0.fmaz003,t0.fmaz012,t0.fmaz013",
               " FROM fmaz_t t0",
               
               " WHERE t0.fmazent = " ||g_enterprise|| " AND t0.fmaz002 = ? AND t0.fmaz003 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE afmt080_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_afmt080 WITH FORM cl_ap_formpath("afm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL afmt080_init()   
 
      #進入選單 Menu (="N")
      CALL afmt080_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_afmt080
      
   END IF 
   
   CLOSE afmt080_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="afmt080.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION afmt080_init()
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
   
   CALL cl_set_combo_scc_part('b_stus','50','N,Y,X')
   #end add-point
   
   CALL afmt080_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="afmt080.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION afmt080_ui_dialog()
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
   
   #end add-point
   
   WHILE TRUE
      
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_fmaz_m.* TO NULL
         CALL g_fmaz_d.clear()
         CALL g_fmaz3_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL afmt080_init()
      END IF
 
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
        
         DISPLAY ARRAY g_fmaz_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL afmt080_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL afmt080_ui_detailshow()
               
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
        
         DISPLAY ARRAY g_fmaz3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL afmt080_idx_chk()
               CALL afmt080_ui_detailshow()
               
               #add-point:page1自定義行為 name="ui_dialog.body3.before_row"
               
               #end add-point
            
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'     
               LET g_current_page = 2
            
            
         
            #add-point:page2自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         
         BEFORE DIALOG
            #先填充browser資料
            CALL afmt080_browser_fill("")
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
               CALL afmt080_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL afmt080_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL afmt080_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afmt080_idx_chk()
			LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL afmt080_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afmt080_idx_chk()
			LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL afmt080_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afmt080_idx_chk()
			LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL afmt080_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afmt080_idx_chk()
			LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL afmt080_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afmt080_idx_chk()
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
                  LET g_export_node[1] = base.typeInfo.create(g_fmaz_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_fmaz3_d)
                  LET g_export_id[2]   = "s_detail3"
 
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
               NEXT FIELD fmaz014
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
               CALL afmt080_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL afmt080_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL afmt080_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL afmt080_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL afmt080_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_afmt080_1
            LET g_action_choice="open_afmt080_1"
            IF cl_auth_chk_act("open_afmt080_1") THEN
               
               #add-point:ON ACTION open_afmt080_1 name="menu.open_afmt080_1"
               CALL afmt080_s01()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL afmt080_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL afmt080_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_afmp010
            LET g_action_choice="open_afmp010"
            IF cl_auth_chk_act("open_afmp010") THEN
               
               #add-point:ON ACTION open_afmp010 name="menu.open_afmp010"

               LET la_param.prog = "afmp010"
               LET la_param.param[1] = ' '
               LET la_param.param[2] = ' '
               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun(ls_js)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/afm/afmt080_rep.4gl"
               #add-point:ON ACTION output.after
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL afmt080_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL afmt080_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_afmt080_2
            LET g_action_choice="open_afmt080_2"
            IF cl_auth_chk_act("open_afmt080_2") THEN
               
               #add-point:ON ACTION open_afmt080_2 name="menu.open_afmt080_2"
               CALL afmt080_s02()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION statechange
            LET g_action_choice="statechange"
            IF cl_auth_chk_act("statechange") THEN
               
               #add-point:ON ACTION statechange name="menu.statechange"
               CALL afmt080_confirm()
               #END add-point
               
            END IF
 
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL afmt080_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL afmt080_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL afmt080_set_pk_array()
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
 
{<section id="afmt080.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION afmt080_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="afmt080.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION afmt080_browser_fill(ps_page_action)
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
 
   LET l_searchcol = "fmaz002,fmaz003"
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
      LET l_sub_sql = " SELECT DISTINCT fmaz002 ",
                      ", fmaz003 ",
 
                      " FROM fmaz_t ",
                      " ",
                      " ", 
 
 
 
                      " WHERE fmazent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("fmaz_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT fmaz002 ",
                      ", fmaz003 ",
 
                      " FROM fmaz_t ",
                      " ",
                      " ", 
 
 
                      " WHERE fmazent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("fmaz_t")
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
      INITIALIZE g_fmaz_m.* TO NULL
      CALL g_fmaz_d.clear()        
      CALL g_fmaz3_d.clear() 
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.fmaz002,t0.fmaz003 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.fmaz002,t0.fmaz003",
                " FROM fmaz_t t0",
                #" ",
                " ",
 
 
 
                
                " WHERE t0.fmazent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("fmaz_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
   
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"fmaz_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_fmaz002,g_browser[g_cnt].b_fmaz003 
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
   
   IF cl_null(g_browser[g_cnt].b_fmaz002) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_fmaz_m.* TO NULL
      CALL g_fmaz_d.clear()
      CALL g_fmaz3_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL afmt080_fetch('')
   
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
 
{<section id="afmt080.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION afmt080_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_fmaz_m.fmaz002 = g_browser[g_current_idx].b_fmaz002   
   LET g_fmaz_m.fmaz003 = g_browser[g_current_idx].b_fmaz003   
 
   EXECUTE afmt080_master_referesh USING g_fmaz_m.fmaz002,g_fmaz_m.fmaz003 INTO g_fmaz_m.fmaz002,g_fmaz_m.fmaz003, 
       g_fmaz_m.fmaz012,g_fmaz_m.fmaz013
   CALL afmt080_show()
   
END FUNCTION
 
{</section>}
 
{<section id="afmt080.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION afmt080_ui_detailshow()
   #add-point:ui_detailshow段define name="ui_detailshow.define_customerization"
   
   #end add-point
   #add-point:ui_detailshow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="ui_detailshow.before"
   
   #end add-point  
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
 
      #add-point:ui_detailshow段more name="ui_detailshow.more"
      
      #end add-point 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="afmt080.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION afmt080_ui_browser_refresh()
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
      IF g_browser[l_i].b_fmaz002 = g_fmaz_m.fmaz002 
         AND g_browser[l_i].b_fmaz003 = g_fmaz_m.fmaz003 
 
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
 
{<section id="afmt080.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION afmt080_construct()
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
   INITIALIZE g_fmaz_m.* TO NULL
   CALL g_fmaz_d.clear()
   CALL g_fmaz3_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON fmaz002,fmaz003,fmaz012
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
                 #Ctrlp:construct.c.fmaz002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaz002
            #add-point:ON ACTION controlp INFIELD fmaz002 name="construct.c.fmaz002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_glav001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmaz002  #顯示到畫面上
            NEXT FIELD fmaz002                     #返回原欄位
    


#            #此段落由子樣板a08產生
#            #開窗c段
#            INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'c'
#            LET g_qryparam.reqry = FALSE
#            CALL q_glav001_1()                           #呼叫開窗
#            DISPLAY g_qryparam.return1 TO fmaz002  #顯示到畫面上
#            NEXT FIELD fmaz002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaz002
            #add-point:BEFORE FIELD fmaz002 name="construct.b.fmaz002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaz002
            
            #add-point:AFTER FIELD fmaz002 name="construct.a.fmaz002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmaz003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaz003
            #add-point:ON ACTION controlp INFIELD fmaz003 name="construct.c.fmaz003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_glav001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmaz003  #顯示到畫面上
            NEXT FIELD fmaz003                     #返回原欄位
    


            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_glav001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmaz003  #顯示到畫面上
            NEXT FIELD fmaz003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaz003
            #add-point:BEFORE FIELD fmaz003 name="construct.b.fmaz003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaz003
            
            #add-point:AFTER FIELD fmaz003 name="construct.a.fmaz003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmaz012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaz012
            #add-point:ON ACTION controlp INFIELD fmaz012 name="construct.c.fmaz012"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooed005()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmaz012  #顯示到畫面上
            NEXT FIELD fmaz012                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaz012
            #add-point:BEFORE FIELD fmaz012 name="construct.b.fmaz012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaz012
            
            #add-point:AFTER FIELD fmaz012 name="construct.a.fmaz012"
            
            #END add-point
            
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON fmaz001,fmaz004,fmaz006,sumday,fmaz008,fmaz010,fmaz014_1,fmazownid,fmazowndp, 
          fmazcrtid,fmazcrtdp,fmazcrtdt,fmazmodid,fmazmoddt,fmazcnfid,fmazcnfdt,fmazpstid,fmazpstdt
           FROM s_detail1[1].fmaz001,s_detail1[1].fmaz004,s_detail1[1].fmaz006,s_detail1[1].sumday,s_detail1[1].fmaz008, 
               s_detail1[1].fmaz010,s_detail3[1].fmaz014_1,s_detail3[1].fmazownid,s_detail3[1].fmazowndp, 
               s_detail3[1].fmazcrtid,s_detail3[1].fmazcrtdp,s_detail3[1].fmazcrtdt,s_detail3[1].fmazmodid, 
               s_detail3[1].fmazmoddt,s_detail3[1].fmazcnfid,s_detail3[1].fmazcnfdt,s_detail3[1].fmazpstid, 
               s_detail3[1].fmazpstdt
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<fmazcrtdt>>----
         AFTER FIELD fmazcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<fmazmoddt>>----
         AFTER FIELD fmazmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<fmazcnfdt>>----
         AFTER FIELD fmazcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<fmazpstdt>>----
         AFTER FIELD fmazpstdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
           
         #單身一般欄位開窗相關處理
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaz014
            #add-point:BEFORE FIELD fmaz014 name="construct.b.page1.fmaz014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaz014
            
            #add-point:AFTER FIELD fmaz014 name="construct.a.page1.fmaz014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmaz014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaz014
            #add-point:ON ACTION controlp INFIELD fmaz014 name="construct.c.page1.fmaz014"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.fmaz001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaz001
            #add-point:ON ACTION controlp INFIELD fmaz001 name="construct.c.page1.fmaz001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_fmaw004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmaz001  #顯示到畫面上
            NEXT FIELD fmaz001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaz001
            #add-point:BEFORE FIELD fmaz001 name="construct.b.page1.fmaz001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaz001
            
            #add-point:AFTER FIELD fmaz001 name="construct.a.page1.fmaz001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmaz004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaz004
            #add-point:ON ACTION controlp INFIELD fmaz004 name="construct.c.page1.fmaz004"
#            #此段落由子樣板a08產生
#            #開窗c段
#            INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'c'
#            LET g_qryparam.reqry = FALSE
#            CALL q_fmaj001_1()                           #呼叫開窗
#            DISPLAY g_qryparam.return1 TO fmaz004  #顯示到畫面上
#            NEXT FIELD fmaz004                     #返回原欄位
#    


            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_fmaw003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmaz004  #顯示到畫面上
            NEXT FIELD fmaz004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaz004
            #add-point:BEFORE FIELD fmaz004 name="construct.b.page1.fmaz004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaz004
            
            #add-point:AFTER FIELD fmaz004 name="construct.a.page1.fmaz004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmaz006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaz006
            #add-point:ON ACTION controlp INFIELD fmaz006 name="construct.c.page1.fmaz006"
#            #此段落由子樣板a08產生
#            #開窗c段
#            INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'c'
#            LET g_qryparam.reqry = FALSE
#            CALL q_itys001_1()                           #呼叫開窗
#            DISPLAY g_qryparam.return1 TO fmaz006  #顯示到畫面上
#            NEXT FIELD fmaz006                     #返回原欄位
#    


            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooaj002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmaz006  #顯示到畫面上
            NEXT FIELD fmaz006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaz006
            #add-point:BEFORE FIELD fmaz006 name="construct.b.page1.fmaz006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaz006
            
            #add-point:AFTER FIELD fmaz006 name="construct.a.page1.fmaz006"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sumday
            #add-point:BEFORE FIELD sumday name="construct.b.page1.sumday"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sumday
            
            #add-point:AFTER FIELD sumday name="construct.a.page1.sumday"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.sumday
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sumday
            #add-point:ON ACTION controlp INFIELD sumday name="construct.c.page1.sumday"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaz008
            #add-point:BEFORE FIELD fmaz008 name="construct.b.page1.fmaz008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaz008
            
            #add-point:AFTER FIELD fmaz008 name="construct.a.page1.fmaz008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmaz008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaz008
            #add-point:ON ACTION controlp INFIELD fmaz008 name="construct.c.page1.fmaz008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaz010
            #add-point:BEFORE FIELD fmaz010 name="construct.b.page1.fmaz010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaz010
            
            #add-point:AFTER FIELD fmaz010 name="construct.a.page1.fmaz010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmaz010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaz010
            #add-point:ON ACTION controlp INFIELD fmaz010 name="construct.c.page1.fmaz010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaz014_1
            #add-point:BEFORE FIELD fmaz014_1 name="construct.b.page3.fmaz014_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaz014_1
            
            #add-point:AFTER FIELD fmaz014_1 name="construct.a.page3.fmaz014_1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.fmaz014_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaz014_1
            #add-point:ON ACTION controlp INFIELD fmaz014_1 name="construct.c.page3.fmaz014_1"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.fmazownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmazownid
            #add-point:ON ACTION controlp INFIELD fmazownid name="construct.c.page3.fmazownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmazownid  #顯示到畫面上
            NEXT FIELD fmazownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmazownid
            #add-point:BEFORE FIELD fmazownid name="construct.b.page3.fmazownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmazownid
            
            #add-point:AFTER FIELD fmazownid name="construct.a.page3.fmazownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.fmazowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmazowndp
            #add-point:ON ACTION controlp INFIELD fmazowndp name="construct.c.page3.fmazowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmazowndp  #顯示到畫面上
            NEXT FIELD fmazowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmazowndp
            #add-point:BEFORE FIELD fmazowndp name="construct.b.page3.fmazowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmazowndp
            
            #add-point:AFTER FIELD fmazowndp name="construct.a.page3.fmazowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.fmazcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmazcrtid
            #add-point:ON ACTION controlp INFIELD fmazcrtid name="construct.c.page3.fmazcrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmazcrtid  #顯示到畫面上
            NEXT FIELD fmazcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmazcrtid
            #add-point:BEFORE FIELD fmazcrtid name="construct.b.page3.fmazcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmazcrtid
            
            #add-point:AFTER FIELD fmazcrtid name="construct.a.page3.fmazcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.fmazcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmazcrtdp
            #add-point:ON ACTION controlp INFIELD fmazcrtdp name="construct.c.page3.fmazcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmazcrtdp  #顯示到畫面上
            NEXT FIELD fmazcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmazcrtdp
            #add-point:BEFORE FIELD fmazcrtdp name="construct.b.page3.fmazcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmazcrtdp
            
            #add-point:AFTER FIELD fmazcrtdp name="construct.a.page3.fmazcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmazcrtdt
            #add-point:BEFORE FIELD fmazcrtdt name="construct.b.page3.fmazcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.fmazmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmazmodid
            #add-point:ON ACTION controlp INFIELD fmazmodid name="construct.c.page3.fmazmodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmazmodid  #顯示到畫面上
            NEXT FIELD fmazmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmazmodid
            #add-point:BEFORE FIELD fmazmodid name="construct.b.page3.fmazmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmazmodid
            
            #add-point:AFTER FIELD fmazmodid name="construct.a.page3.fmazmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmazmoddt
            #add-point:BEFORE FIELD fmazmoddt name="construct.b.page3.fmazmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.fmazcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmazcnfid
            #add-point:ON ACTION controlp INFIELD fmazcnfid name="construct.c.page3.fmazcnfid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmazcnfid  #顯示到畫面上
            NEXT FIELD fmazcnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmazcnfid
            #add-point:BEFORE FIELD fmazcnfid name="construct.b.page3.fmazcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmazcnfid
            
            #add-point:AFTER FIELD fmazcnfid name="construct.a.page3.fmazcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmazcnfdt
            #add-point:BEFORE FIELD fmazcnfdt name="construct.b.page3.fmazcnfdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.fmazpstid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmazpstid
            #add-point:ON ACTION controlp INFIELD fmazpstid name="construct.c.page3.fmazpstid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmazpstid  #顯示到畫面上
            NEXT FIELD fmazpstid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmazpstid
            #add-point:BEFORE FIELD fmazpstid name="construct.b.page3.fmazpstid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmazpstid
            
            #add-point:AFTER FIELD fmazpstid name="construct.a.page3.fmazpstid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmazpstdt
            #add-point:BEFORE FIELD fmazpstdt name="construct.b.page3.fmazpstdt"
            
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
 
{<section id="afmt080.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION afmt080_query()
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
   CALL g_fmaz_d.clear()
   CALL g_fmaz3_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL afmt080_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL afmt080_browser_fill(g_wc)
      CALL afmt080_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL afmt080_browser_fill("F")
   
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
      CALL afmt080_fetch("F") 
   END IF
   
   CALL afmt080_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="afmt080.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION afmt080_fetch(p_flag)
   #add-point:fetch段define name="fetch.define_customerization"
   
   #end add-point   
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="fetch.before_fetch"
   CALL cl_set_act_visible("statechange,modify,delete,reproduce,modify_detail", TRUE)
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
   
   #CALL afmt080_browser_fill(p_flag)
   
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
   
   LET g_fmaz_m.fmaz002 = g_browser[g_current_idx].b_fmaz002
   LET g_fmaz_m.fmaz003 = g_browser[g_current_idx].b_fmaz003
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE afmt080_master_referesh USING g_fmaz_m.fmaz002,g_fmaz_m.fmaz003 INTO g_fmaz_m.fmaz002,g_fmaz_m.fmaz003, 
       g_fmaz_m.fmaz012,g_fmaz_m.fmaz013
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "fmaz_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_fmaz_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_fmaz_m_mask_o.* =  g_fmaz_m.*
   CALL afmt080_fmaz_t_mask()
   LET g_fmaz_m_mask_n.* =  g_fmaz_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL afmt080_set_act_visible()
   CALL afmt080_set_act_no_visible()
 
   #保存單頭舊值
   LET g_fmaz_m_t.* = g_fmaz_m.*
   LET g_fmaz_m_o.* = g_fmaz_m.*
   
   #重新顯示   
   CALL afmt080_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="afmt080.insert" >}
#+ 資料新增
PRIVATE FUNCTION afmt080_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_fmaz_d.clear()
   CALL g_fmaz3_d.clear()
 
 
   INITIALIZE g_fmaz_m.* LIKE fmaz_t.*             #DEFAULT 設定
   LET g_fmaz002_t = NULL
   LET g_fmaz003_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
            LET g_fmaz_m.fmaz013 = "1"
      LET g_fmaz_m.b_stus = "N"
 
     
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point 
 
      CALL afmt080_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_fmaz_m.* TO NULL
         INITIALIZE g_fmaz_d TO NULL
         INITIALIZE g_fmaz3_d TO NULL
 
         CALL afmt080_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_fmaz_m.* = g_fmaz_m_t.*
         CALL afmt080_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_fmaz_d.clear()
      #CALL g_fmaz3_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL afmt080_set_act_visible()
   CALL afmt080_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_fmaz002_t = g_fmaz_m.fmaz002
   LET g_fmaz003_t = g_fmaz_m.fmaz003
 
   
   #組合新增資料的條件
   LET g_add_browse = " fmazent = " ||g_enterprise|| " AND",
                      " fmaz002 = '", g_fmaz_m.fmaz002, "' "
                      ," AND fmaz003 = '", g_fmaz_m.fmaz003, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL afmt080_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL afmt080_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE afmt080_master_referesh USING g_fmaz_m.fmaz002,g_fmaz_m.fmaz003 INTO g_fmaz_m.fmaz002,g_fmaz_m.fmaz003, 
       g_fmaz_m.fmaz012,g_fmaz_m.fmaz013
   
   #遮罩相關處理
   LET g_fmaz_m_mask_o.* =  g_fmaz_m.*
   CALL afmt080_fmaz_t_mask()
   LET g_fmaz_m_mask_n.* =  g_fmaz_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_fmaz_m.fmaz002,g_fmaz_m.fmaz003,g_fmaz_m.fmaz012,g_fmaz_m.fmaz013,g_fmaz_m.b_stus 
 
   
   #功能已完成,通報訊息中心
   CALL afmt080_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="afmt080.modify" >}
#+ 資料修改
PRIVATE FUNCTION afmt080_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_fmaz_m.fmaz002 IS NULL
   OR g_fmaz_m.fmaz003 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_fmaz002_t = g_fmaz_m.fmaz002
   LET g_fmaz003_t = g_fmaz_m.fmaz003
 
   CALL s_transaction_begin()
   
   OPEN afmt080_cl USING g_enterprise,g_fmaz_m.fmaz002,g_fmaz_m.fmaz003
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afmt080_cl:" 
      LET g_errparam.code   =  STATUS 
      LET g_errparam.popup  = TRUE 
      CLOSE afmt080_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE afmt080_master_referesh USING g_fmaz_m.fmaz002,g_fmaz_m.fmaz003 INTO g_fmaz_m.fmaz002,g_fmaz_m.fmaz003, 
       g_fmaz_m.fmaz012,g_fmaz_m.fmaz013
   
   #遮罩相關處理
   LET g_fmaz_m_mask_o.* =  g_fmaz_m.*
   CALL afmt080_fmaz_t_mask()
   LET g_fmaz_m_mask_n.* =  g_fmaz_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL afmt080_show()
   WHILE TRUE
      LET g_fmaz002_t = g_fmaz_m.fmaz002
      LET g_fmaz003_t = g_fmaz_m.fmaz003
 
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL afmt080_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_fmaz_m.* = g_fmaz_m_t.*
         CALL afmt080_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_fmaz_m.fmaz002 != g_fmaz002_t 
      OR g_fmaz_m.fmaz003 != g_fmaz003_t 
 
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
   CALL afmt080_set_act_visible()
   CALL afmt080_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " fmazent = " ||g_enterprise|| " AND",
                      " fmaz002 = '", g_fmaz_m.fmaz002, "' "
                      ," AND fmaz003 = '", g_fmaz_m.fmaz003, "' "
 
   #填到對應位置
   CALL afmt080_browser_fill("")
 
   CALL afmt080_idx_chk()
 
   CLOSE afmt080_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL afmt080_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="afmt080.input" >}
#+ 資料輸入
PRIVATE FUNCTION afmt080_input(p_cmd)
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
   DEFINE l_ooef017   LIKE ooef_t.ooef017
   DEFINE l_glaa003   LIKE glaa_t.glaa003
   DEFINE l_mindate   LIKE type_t.dat
   DEFINE l_maxdate   LIKE type_t.dat
   DEFINE l_smalldate LIKE type_t.dat
   DEFINE l_largedate LIKE type_t.dat
   DEFINE l_fmaj010   LIKE fmaj_t.fmaj010
   DEFINE l_fmam003   LIKE fmam_t.fmam003
   DEFINE l_fmal007   LIKE fmal_t.fmal007
   DEFINE l_fmak010   LIKE fmak_t.fmak010
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
   DISPLAY BY NAME g_fmaz_m.fmaz002,g_fmaz_m.fmaz003,g_fmaz_m.fmaz012,g_fmaz_m.fmaz013,g_fmaz_m.b_stus 
 
   
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
   LET g_forupd_sql = "SELECT fmaz014,fmaz001,fmaz004,fmaz011,fmaz006,fmaz008,fmaz010,fmaz014,fmazownid, 
       fmazowndp,fmazcrtid,fmazcrtdp,fmazcrtdt,fmazmodid,fmazmoddt,fmazcnfid,fmazcnfdt,fmazpstid,fmazpstdt  
       FROM fmaz_t WHERE fmazent=? AND fmaz002=? AND fmaz003=? AND fmaz014=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afmt080_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL afmt080_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL afmt080_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_fmaz_m.fmaz002,g_fmaz_m.fmaz003,g_fmaz_m.fmaz012
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="afmt080.input.head" >}
   
      #單頭段
      INPUT BY NAME g_fmaz_m.fmaz002,g_fmaz_m.fmaz003,g_fmaz_m.fmaz012 
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
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaz002
            #add-point:BEFORE FIELD fmaz002 name="input.b.fmaz002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaz002
            
            #add-point:AFTER FIELD fmaz002 name="input.a.fmaz002"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_fmaz_m.fmaz002) AND NOT cl_null(g_fmaz_m.fmaz003) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_fmaz_m.fmaz002 != g_fmaz002_t  OR g_fmaz_m.fmaz003 != g_fmaz003_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fmaz_t WHERE "||"fmazent = '" ||g_enterprise|| "' AND "||"fmaz002 = '"||g_fmaz_m.fmaz002 ||"' AND "|| "fmaz003 = '"||g_fmaz_m.fmaz003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmaz002
            #add-point:ON CHANGE fmaz002 name="input.g.fmaz002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaz003
            #add-point:BEFORE FIELD fmaz003 name="input.b.fmaz003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaz003
            
            #add-point:AFTER FIELD fmaz003 name="input.a.fmaz003"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_fmaz_m.fmaz002) AND NOT cl_null(g_fmaz_m.fmaz003) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_fmaz_m.fmaz002 != g_fmaz002_t  OR g_fmaz_m.fmaz003 != g_fmaz003_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fmaz_t WHERE "||"fmazent = '" ||g_enterprise|| "' AND "||"fmaz002 = '"||g_fmaz_m.fmaz002 ||"' AND "|| "fmaz003 = '"||g_fmaz_m.fmaz003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmaz003
            #add-point:ON CHANGE fmaz003 name="input.g.fmaz003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaz012
            
            #add-point:AFTER FIELD fmaz012 name="input.a.fmaz012"
            IF NOT cl_null(g_fmaz_m.fmaz012) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fmaz_m.fmaz012

                  
               #呼叫檢查存在並帶值的library
              
               IF NOT cl_chk_exist("v_fmar009") THEN
                  
                  #檢查失敗時後續處理
                  #LET  = g_chkparam.return1
                  LET g_fmaz_m.fmaz012 = g_fmaz_m_t.fmaz012
                  NEXT FIELD CURRENT
                  #DISPLAY BY NAME 
               ELSE
                  #檢查成功時後續處理
                  
               END IF
            

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaz012
            #add-point:BEFORE FIELD fmaz012 name="input.b.fmaz012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmaz012
            #add-point:ON CHANGE fmaz012 name="input.g.fmaz012"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.fmaz002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaz002
            #add-point:ON ACTION controlp INFIELD fmaz002 name="input.c.fmaz002"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmaz_m.fmaz002             #給予default值

            #給予arg
#            LET g_qryparam.arg1 = "" #

            
            CALL q_glav001_1()                                #呼叫開窗

            LET g_fmaz_m.fmaz002 = g_qryparam.return1              

            DISPLAY g_fmaz_m.fmaz002 TO fmaz002              #

            NEXT FIELD fmaz002                          #返回原欄位


           
            #END add-point
 
 
         #Ctrlp:input.c.fmaz003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaz003
            #add-point:ON ACTION controlp INFIELD fmaz003 name="input.c.fmaz003"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmaz_m.fmaz003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.arg2 = "" #
            
            CALL q_glav001_2()                                #呼叫開窗

            LET g_fmaz_m.fmaz003 = g_qryparam.return1              

            DISPLAY g_fmaz_m.fmaz003 TO fmaz003              #

            NEXT FIELD fmaz003                          #返回原欄位


       

            #END add-point
 
 
         #Ctrlp:input.c.fmaz012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaz012
            #add-point:ON ACTION controlp INFIELD fmaz012 name="input.c.fmaz012"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmaz_m.fmaz012             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooed005()                                #呼叫開窗

            LET g_fmaz_m.fmaz012 = g_qryparam.return1              

            DISPLAY g_fmaz_m.fmaz012 TO fmaz012              #

            NEXT FIELD fmaz012                          #返回原欄位


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
            DISPLAY BY NAME g_fmaz_m.fmaz002             
                            ,g_fmaz_m.fmaz003   
 
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
            
               #將遮罩欄位還原
               CALL afmt080_fmaz_t_mask_restore('restore_mask_o')
            
               UPDATE fmaz_t SET (fmaz002,fmaz003,fmaz012,fmaz013) = (g_fmaz_m.fmaz002,g_fmaz_m.fmaz003, 
                   g_fmaz_m.fmaz012,g_fmaz_m.fmaz013)
                WHERE fmazent = g_enterprise AND fmaz002 = g_fmaz002_t
                  AND fmaz003 = g_fmaz003_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmaz_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmaz_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fmaz_m.fmaz002
               LET gs_keys_bak[1] = g_fmaz002_t
               LET gs_keys[2] = g_fmaz_m.fmaz003
               LET gs_keys_bak[2] = g_fmaz003_t
               LET gs_keys[3] = g_fmaz_d[g_detail_idx].fmaz014
               LET gs_keys_bak[3] = g_fmaz_d_t.fmaz014
               CALL afmt080_update_b('fmaz_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_fmaz_m_t)
                     #LET g_log2 = util.JSON.stringify(g_fmaz_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL afmt080_fmaz_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL afmt080_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_fmaz002_t = g_fmaz_m.fmaz002
           LET g_fmaz003_t = g_fmaz_m.fmaz003
 
           
           IF g_fmaz_d.getLength() = 0 THEN
              NEXT FIELD fmaz014
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="afmt080.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_fmaz_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_fmaz_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL afmt080_b_fill(g_wc2) #test 
            #如果一直都在單頭則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_detail_idx)
            END IF
            LET g_loc = 'm' 
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
            CALL afmt080_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN afmt080_cl USING g_enterprise,g_fmaz_m.fmaz002,g_fmaz_m.fmaz003                          
               IF STATUS THEN
                  CLOSE afmt080_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN afmt080_cl:" 
                  LET g_errparam.code   = STATUS 
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_fmaz_d[l_ac].fmaz014 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_fmaz_d_t.* = g_fmaz_d[l_ac].*  #BACKUP
               LET g_fmaz_d_o.* = g_fmaz_d[l_ac].*  #BACKUP
               CALL afmt080_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL afmt080_set_no_entry_b(l_cmd)
               OPEN afmt080_bcl USING g_enterprise,g_fmaz_m.fmaz002,
                                                g_fmaz_m.fmaz003,
 
                                                g_fmaz_d_t.fmaz014
 
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN afmt080_bcl:" 
                  LET g_errparam.code   =  STATUS 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH afmt080_bcl INTO g_fmaz_d[l_ac].fmaz014,g_fmaz_d[l_ac].fmaz001,g_fmaz_d[l_ac].fmaz004, 
                      g_fmaz_d[l_ac].fmaz011,g_fmaz_d[l_ac].fmaz006,g_fmaz_d[l_ac].fmaz008,g_fmaz_d[l_ac].fmaz010, 
                      g_fmaz3_d[l_ac].fmaz014,g_fmaz3_d[l_ac].fmazownid,g_fmaz3_d[l_ac].fmazowndp,g_fmaz3_d[l_ac].fmazcrtid, 
                      g_fmaz3_d[l_ac].fmazcrtdp,g_fmaz3_d[l_ac].fmazcrtdt,g_fmaz3_d[l_ac].fmazmodid, 
                      g_fmaz3_d[l_ac].fmazmoddt,g_fmaz3_d[l_ac].fmazcnfid,g_fmaz3_d[l_ac].fmazcnfdt, 
                      g_fmaz3_d[l_ac].fmazpstid,g_fmaz3_d[l_ac].fmazpstdt
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_fmaz_d_t.fmaz014,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_fmaz_d_mask_o[l_ac].* =  g_fmaz_d[l_ac].*
                  CALL afmt080_fmaz_t_mask()
                  LET g_fmaz_d_mask_n[l_ac].* =  g_fmaz_d[l_ac].*
                  
                  CALL afmt080_ref_show()
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
            INITIALIZE g_fmaz_d_t.* TO NULL
            INITIALIZE g_fmaz_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_fmaz_d[l_ac].* TO NULL
            #公用欄位預設值
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_fmaz3_d[l_ac].fmazownid = g_user
      LET g_fmaz3_d[l_ac].fmazowndp = g_dept
      LET g_fmaz3_d[l_ac].fmazcrtid = g_user
      LET g_fmaz3_d[l_ac].fmazcrtdp = g_dept 
      LET g_fmaz3_d[l_ac].fmazcrtdt = cl_get_current()
      LET g_fmaz3_d[l_ac].fmazmodid = g_user
      LET g_fmaz3_d[l_ac].fmazmoddt = cl_get_current()
 
 
  
            #一般欄位預設值
            
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            
            #end add-point
            LET g_fmaz_d_t.* = g_fmaz_d[l_ac].*     #新輸入資料
            LET g_fmaz_d_o.* = g_fmaz_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL afmt080_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL afmt080_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_fmaz_d[li_reproduce_target].* = g_fmaz_d[li_reproduce].*
               LET g_fmaz3_d[li_reproduce_target].* = g_fmaz3_d[li_reproduce].*
 
               LET g_fmaz_d[g_fmaz_d.getLength()].fmaz014 = NULL
 
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
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM fmaz_t 
             WHERE fmazent = g_enterprise AND fmaz002 = g_fmaz_m.fmaz002
               AND fmaz003 = g_fmaz_m.fmaz003
 
               AND fmaz014 = g_fmaz_d[l_ac].fmaz014
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
               INSERT INTO fmaz_t
                           (fmazent,
                            fmaz002,fmaz003,fmaz012,fmaz013,
                            fmaz014
                            ,fmaz001,fmaz004,fmaz011,fmaz006,fmaz008,fmaz010,fmazownid,fmazowndp,fmazcrtid,fmazcrtdp,fmazcrtdt,fmazmodid,fmazmoddt,fmazcnfid,fmazcnfdt,fmazpstid,fmazpstdt) 
                     VALUES(g_enterprise,
                            g_fmaz_m.fmaz002,g_fmaz_m.fmaz003,g_fmaz_m.fmaz012,g_fmaz_m.fmaz013,
                            g_fmaz_d[l_ac].fmaz014
                            ,g_fmaz_d[l_ac].fmaz001,g_fmaz_d[l_ac].fmaz004,g_fmaz_d[l_ac].fmaz011,g_fmaz_d[l_ac].fmaz006, 
                                g_fmaz_d[l_ac].fmaz008,g_fmaz_d[l_ac].fmaz010,g_fmaz3_d[l_ac].fmazownid, 
                                g_fmaz3_d[l_ac].fmazowndp,g_fmaz3_d[l_ac].fmazcrtid,g_fmaz3_d[l_ac].fmazcrtdp, 
                                g_fmaz3_d[l_ac].fmazcrtdt,g_fmaz3_d[l_ac].fmazmodid,g_fmaz3_d[l_ac].fmazmoddt, 
                                g_fmaz3_d[l_ac].fmazcnfid,g_fmaz3_d[l_ac].fmazcnfdt,g_fmaz3_d[l_ac].fmazpstid, 
                                g_fmaz3_d[l_ac].fmazpstdt)
               #add-point:單身新增中 name="input.body.m_insert"
               
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_fmaz_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "fmaz_t:",SQLERRMESSAGE 
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
               IF afmt080_before_delete() THEN 
                  
 
 
				  
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_fmaz_m.fmaz002
                  LET gs_keys[gs_keys.getLength()+1] = g_fmaz_m.fmaz003
 
                  LET gs_keys[gs_keys.getLength()+1] = g_fmaz_d_t.fmaz014
 
			   
                  #刪除下層單身
                  IF NOT afmt080_key_delete_b(gs_keys,'fmaz_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE afmt080_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE afmt080_bcl
               LET l_count = g_fmaz_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_fmaz_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaz014
            #add-point:BEFORE FIELD fmaz014 name="input.b.page1.fmaz014"
#            IF cl_null(g_fmaz_d[g_detail_idx].fmaz014) OR g_fmaz_d[g_detail_idx].fmaz014="0" THEN
#               SELECT MAX(fmaz014)+1 INTO g_fmaz_d[g_detail_idx].fmaz014
#                 FROM fmaz_t
#                WHERE fmazent=g_enterprise
#                  AND fmaz002=g_fmaz_m.fmaz002
#                  AND fmaz003=g_fmaz_m.fmaz003
#               IF g_fmaz_d[g_detail_idx].fmaz014 IS NULL THEN
#                  LET g_fmaz_d[g_detail_idx].fmaz014 = 1
#               END IF 
#            END IF 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaz014
            
            #add-point:AFTER FIELD fmaz014 name="input.a.page1.fmaz014"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_fmaz_m.fmaz002 IS NOT NULL AND g_fmaz_m.fmaz003 IS NOT NULL AND g_fmaz_d[g_detail_idx].fmaz014 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_fmaz_m.fmaz002 != g_fmaz002_t OR g_fmaz_m.fmaz003 != g_fmaz003_t OR g_fmaz_d[g_detail_idx].fmaz014 != g_fmaz_d_t.fmaz014)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fmaz_t WHERE "||"fmazent = '" ||g_enterprise|| "' AND "||"fmaz002 = '"||g_fmaz_m.fmaz002 ||"' AND "|| "fmaz003 = '"||g_fmaz_m.fmaz003 ||"' AND "|| "fmaz014 = '"||g_fmaz_d[g_detail_idx].fmaz014 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmaz014
            #add-point:ON CHANGE fmaz014 name="input.g.page1.fmaz014"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaz001
            
            #add-point:AFTER FIELD fmaz001 name="input.a.page1.fmaz001"
            IF NOT cl_null(g_fmaz_d[l_ac].fmaz001) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fmaz_m.fmaz012
               LET g_chkparam.arg2 = g_fmaz_d[l_ac].fmaz001
                  
               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist_and_ref_val("v_fmar003") THEN
#                  #檢查成功時後續處理
#                  #LET  = g_chkparam.return1
#                  #DISPLAY BY NAME 
#               ELSE
#                  #檢查失敗時後續處理
#                  NEXT FIELD CURRENT
#               END IF
               IF NOT cl_chk_exist("v_fmar003") THEN
                     LET g_fmaz_d[l_ac].fmaz001 = g_fmaz_d_t.fmaz001
                     CALL afmt080_fmaz001_desc()
                     NEXT FIELD CURRENT
               ELSE
                     CALL afmt080_fmaz001_desc()              
               END IF        

            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaz001
            #add-point:BEFORE FIELD fmaz001 name="input.b.page1.fmaz001"
            IF cl_null(g_fmaz_d[g_detail_idx].fmaz014) OR g_fmaz_d[g_detail_idx].fmaz014="0" THEN
               SELECT MAX(fmaz014)+1 INTO g_fmaz_d[g_detail_idx].fmaz014
                 FROM fmaz_t
                WHERE fmazent=g_enterprise
                  AND fmaz002=g_fmaz_m.fmaz002
                  AND fmaz003=g_fmaz_m.fmaz003
               IF g_fmaz_d[g_detail_idx].fmaz014 IS NULL THEN
                  LET g_fmaz_d[g_detail_idx].fmaz014 = 1
               END IF 
            END IF 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmaz001
            #add-point:ON CHANGE fmaz001 name="input.g.page1.fmaz001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaz004
            
            #add-point:AFTER FIELD fmaz004 name="input.a.page1.fmaz004"
            IF NOT cl_null(g_fmaz_d[l_ac].fmaz004) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
                LET g_chkparam.arg1 =  g_fmaz_d[l_ac].fmaz001  #融资组织
                LET g_chkparam.arg2 = g_fmaz_d[l_ac].fmaz004 #融资合同号
                  
               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist_and_ref_val("v_fmar002") THEN
#                  #檢查成功時後續處理
#                  #LET  = g_chkparam.return1
#                  #DISPLAY BY NAME 
#               ELSE
#                  #檢查失敗時後續處理
#                  NEXT FIELD CURRENT
#               END IF
               IF NOT cl_chk_exist("v_fmar002") THEN
                     LET g_fmaz_d[l_ac].fmaz004 = g_fmaz_d_t.fmaz004  #融资合同号
                     NEXT FIELD CURRENT
                ELSE
                              
                END IF            

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaz004
            #add-point:BEFORE FIELD fmaz004 name="input.b.page1.fmaz004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmaz004
            #add-point:ON CHANGE fmaz004 name="input.g.page1.fmaz004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaz011
            
            #add-point:AFTER FIELD fmaz011 name="input.a.page1.fmaz011"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_fmaz_m.fmaz002 IS NOT NULL AND g_fmaz_m.fmaz003 IS NOT NULL AND g_fmaz_d[g_detail_idx].fmaz011 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_fmaz_m.fmaz002 != g_fmaz002_t OR g_fmaz_m.fmaz003 != g_fmaz003_t OR g_fmaz_d[g_detail_idx].fmaz011 != g_fmaz_d_t.fmaz011)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fmaz_t WHERE "||"fmazent = '" ||g_enterprise|| "' AND "||"fmaz002 = '"||g_fmaz_m.fmaz002 ||"' AND "|| "fmaz003 = '"||g_fmaz_m.fmaz003 ||"' AND "|| "fmaz011 = '"||g_fmaz_d[g_detail_idx].fmaz011 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            IF NOT cl_null(g_fmaz_d[l_ac].fmaz011) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fmaz_d[l_ac].fmaz004  #融资合同號
               LET g_chkparam.arg2 = g_fmaz_d[l_ac].fmaz001  #融资組織
               LET g_chkparam.arg3 = g_fmaz_d[l_ac].fmaz011  #合同項次
                  
               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist_and_ref_val("v_fmaw010") THEN
#                  #檢查成功時後續處理
#                  #LET  = g_chkparam.return1
#                  #DISPLAY BY NAME 
#               ELSE
#                  #檢查失敗時後續處理
#                  NEXT FIELD CURRENT
#               END IF
               IF NOT cl_chk_exist("v_fmaw010") THEN
                     LET g_fmaz_d[l_ac].fmaz011 = g_fmaz_d_t.fmaz011  #融资合同号
                    
                     NEXT FIELD CURRENT
                        
               END IF               

            END IF
            
            #幣別
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmaz_d[l_ac].fmaz004 #合同編號
            LET g_ref_fields[2] = g_fmaz_d[l_ac].fmaz011 #合同項次
            CALL ap_ref_array2(g_ref_fields,"SELECT fmam002 FROM fmam_t WHERE fmament='"||g_enterprise||"' AND fmam001=? AND fmam006=? ","") RETURNING g_rtn_fields
            LET g_fmaz_d[l_ac].fmaz006 = g_rtn_fields[1]
            DISPLAY BY NAME g_fmaz_d[l_ac].fmaz006
            
#            #到賬金額
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_fmaz_d[l_ac].fmaz004 #合同編號
#            LET g_ref_fields[2] = g_fmaz_d[l_ac].fmaz011 #合同項次
#            CALL ap_ref_array2(g_ref_fields,"SELECT sum(fmam005) FROM fmam_t WHERE fmament='"||g_enterprise||"' AND fmam001=? AND fmam006=? ","") RETURNING g_rtn_fields
#            LET g_sumfmam005 = g_rtn_fields[1]
#            
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_fmaz_d[l_ac].fmaz004 #合同編號
#            LET g_ref_fields[2] = g_fmaz_d[l_ac].fmaz011 #合同項次
#            CALL ap_ref_array2(g_ref_fields,"SELECT sum(fmaw008) FROM fmaw_t WHERE fmawent='"||g_enterprise||"' AND fmaw003=? AND fmaw010=? ","") RETURNING g_rtn_fields
#            LET g_sumfmaw008 = g_rtn_fields[1]
#            
#            LET g_fmaz_d[l_ac].fmaz011_desc = g_sumfmam005 - g_sumfmaw008
#            DISPLAY BY NAME g_fmaz_d[l_ac].fmaz011_desc
            
            
            #執行利率
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmaz_d[l_ac].fmaz004 #合同編號
            LET g_ref_fields[2] = g_fmaz_d[l_ac].fmaz011 #合同項次
            CALL ap_ref_array2(g_ref_fields,"SELECT fman008 FROM fman_t WHERE fmanent='"||g_enterprise||"' AND fman001=? AND fman010=? ORDER BY fman003 DESC ","") RETURNING g_rtn_fields
            LET g_fmaz_d[l_ac].fmaz001_desc_2 = g_rtn_fields[1]
            DISPLAY BY NAME g_fmaz_d[l_ac].fmaz001_desc_2
#            SELECT fman008 INTO g_fmaz_d[l_ac].fmaz001_desc_2  FROM fman_t
#            WHERE fmanent = g_enterprise AND fman001 = g_fmaz_d[l_ac].fmaz004 AND fman010 = g_fmaz_d[l_ac].fmaz011
#            ORDER BY fman003 DESC
#            DISPLAY BY NAME g_fmaz_d[l_ac].fmaz001_desc_2
            
            #幣別說明
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmaz_d[l_ac].fmaz006
            CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fmaz_d[l_ac].fmaz006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmaz_d[l_ac].fmaz006_desc
            
            ##--start--本期計息天數
            #本期別最大和最小
         SELECT ooef017 INTO l_ooef017
          FROM ooef_t 
          WHERE ooefent = g_enterprise AND ooef001 = g_fmaz_d[l_ac].fmaz001
         
         SELECT glaa003 INTO l_glaa003 FROM glaa_t
          WHERE glaaent = g_enterprise
            AND glaa014 = 'Y'
            AND glaacomp = l_ooef017
         
         SELECT min(glav004),max(glav004) into l_mindate,l_maxdate
           FROM glav_t 
          WHERE glavent = g_enterprise
            AND glav001 = l_glaa003
            AND glav002 = g_fmaz_m.fmaz002 #年度
            AND glav006 = g_fmaz_m.fmaz003  #期別
            
            #融資到期日fmaj010
            SELECT fmaj010 INTO l_fmaj010
            FROM fmaj_t
            WHERE fmaj001 = g_fmaz_d[l_ac].fmaz004 #合同編號
            AND fmaj002 = g_fmaz_d[l_ac].fmaz001 #合同組織
            AND fmajent = g_enterprise
            #融資到賬日fmam003
            SELECT max(fmam003) INTO l_fmam003
            FROM fmam_t
            WHERE fmam001 = g_fmaz_d[l_ac].fmaz004 #合同編號
            AND fmam006 = g_fmaz_d[l_ac].fmaz011 #合同項次
            AND fmament = g_enterprise
            
            IF l_fmaj010 < l_maxdate THEN
               LET l_smalldate = l_fmaj010
            ELSE
               LET l_smalldate = l_maxdate
            END IF
            
            IF l_mindate < l_fmam003 AND l_fmam003 < l_maxdate THEN
               LET l_largedate = l_fmam003
            ELSE
               LET l_largedate = l_mindate
            END IF
            
            LET g_fmaz_d[l_ac].sumday = l_smalldate - l_largedate +1
            DISPLAY BY NAME g_fmaz_d[l_ac].sumday
         ##--end

         #到賬金額
            LET g_sumfmam005 = 0
            SELECT sum(fmam005) into g_sumfmam005 FROM fmam_t 
            WHERE fmament = g_enterprise
            AND fmam001 = g_fmaz_d[l_ac].fmaz004 
            AND fmam006 = g_fmaz_d[l_ac].fmaz011
            AND fmam003 <= l_maxdate

            IF cl_null(g_sumfmam005) THEN
               LET g_sumfmam005 = 0
            END IF
            
#            LET g_sumfmaw008 = 0
#            SELECT sum(fmaw008) into g_sumfmaw008 FROM fmaw_t
#            WHERE fmawent = g_enterprise
#            AND fmaw003 = g_fmaz_d[l_ac].fmaz004 
#            AND fmaw010 = g_fmaz_d[l_ac].fmaz011
            
            SELECT sum(fmal007) into l_fmal007 FROM fmal_t
            WHERE fmalent = g_enterprise
            AND fmal001 = g_fmaz_d[l_ac].fmaz004 
            AND fmal008 = g_fmaz_d[l_ac].fmaz011
            AND fmal006 <= l_maxdate
            
            IF cl_null(l_fmal007) THEN
               LET l_fmal007 = 0
            END IF

            LET g_fmaz_d[l_ac].fmaz011_desc = g_sumfmam005 - l_fmal007
            DISPLAY BY NAME g_fmaz_d[l_ac].fmaz011_desc
            
            #利息金额
            LET g_fmaz_d[l_ac].fmaz010 = g_fmaz_d[l_ac].fmaz011_desc * (g_fmaz_d[l_ac].fmaz001_desc_2/100)
            DISPLAY BY NAME g_fmaz_d[l_ac].fmaz010
            
            #未还利息
               SELECT fmak010 INTO l_fmak010
               FROM fmak_t
               WHERE fmak001 = g_fmaz_d[l_ac].fmaz004 
               AND fmak011 = g_fmaz_d[l_ac].fmaz011
               AND fmakent = g_enterprise
               
               IF l_fmak010 = 'N' OR cl_null(l_fmak010) THEN
                  LET g_fmaz_d[l_ac].fmaz008 = 0
               ELSE
                  #已经还款的
                  SELECT sum(fmaw008) INTO g_sumfmaw008
                  FROM fmaw_t
                  WHERE fmawent = g_enterprise AND fmaw006 = 2
                  AND fmaw003 = g_fmaz_d[l_ac].fmaz004 AND fmaw010 = g_fmaz_d[l_ac].fmaz011
                  AND fmaw004 = g_fmaz_d[l_ac].fmaz001 AND fmaw002 < l_mindate
                  
                  LET g_fmaz_d[l_ac].fmaz008 = g_fmaz_d[l_ac].fmaz010 - g_sumfmaw008
               END IF
               DISPLAY BY NAME g_fmaz_d[l_ac].fmaz008
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaz011
            #add-point:BEFORE FIELD fmaz011 name="input.b.page1.fmaz011"
           
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmaz011
            #add-point:ON CHANGE fmaz011 name="input.g.page1.fmaz011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaz006
            
            #add-point:AFTER FIELD fmaz006 name="input.a.page1.fmaz006"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmaz_d[l_ac].fmaz006
            CALL ap_ref_array2(g_ref_fields,"SELECT itysl003 FROM itysl_t WHERE ityslent='"||g_enterprise||"' AND itysl001=? AND itysl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fmaz_d[l_ac].fmaz006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmaz_d[l_ac].fmaz006_desc


            IF NOT cl_null(g_fmaz_d[l_ac].fmaz006) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fmaz_d[l_ac].fmaz001
               LET g_chkparam.arg2 = g_fmaz_d[l_ac].fmaz006
              
               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist_and_ref_val("v_ooaj002") THEN
#                  #檢查成功時後續處理
#                  #LET  = g_chkparam.return1
#                  #DISPLAY BY NAME 
#               ELSE
#                  #檢查失敗時後續處理
#                  NEXT FIELD CURRENT
#               END IF
               #160318-00025#37  2016/04/19  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "aoo-00176:sub-01302|aooi150|",cl_get_progname("aooi150",g_lang,"2"),"|:EXEPROGaooi150"
               #160318-00025#37  2016/04/19  by pengxin  add(E)
               IF NOT cl_chk_exist("v_ooaj002") THEN
                     LET g_fmaz_d[l_ac].fmaz006 = g_fmaz_d_t.fmaz006  #幣別 
                     NEXT FIELD CURRENT       
                END IF               
            END IF 
           
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmaz_d[l_ac].fmaz006
            CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fmaz_d[l_ac].fmaz006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmaz_d[l_ac].fmaz006_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaz006
            #add-point:BEFORE FIELD fmaz006 name="input.b.page1.fmaz006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmaz006
            #add-point:ON CHANGE fmaz006 name="input.g.page1.fmaz006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sumday
            #add-point:BEFORE FIELD sumday name="input.b.page1.sumday"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sumday
            
            #add-point:AFTER FIELD sumday name="input.a.page1.sumday"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sumday
            #add-point:ON CHANGE sumday name="input.g.page1.sumday"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaz008
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_fmaz_d[l_ac].fmaz008,"0","0","","","azz-00079",1) THEN
               NEXT FIELD fmaz008
            END IF 
 
 
 
            #add-point:AFTER FIELD fmaz008 name="input.a.page1.fmaz008"
            IF NOT cl_null(g_fmaz_d[l_ac].fmaz008) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaz008
            #add-point:BEFORE FIELD fmaz008 name="input.b.page1.fmaz008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmaz008
            #add-point:ON CHANGE fmaz008 name="input.g.page1.fmaz008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaz010
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_fmaz_d[l_ac].fmaz010,"0","0","","","azz-00079",1) THEN
               NEXT FIELD fmaz010
            END IF 
 
 
 
            #add-point:AFTER FIELD fmaz010 name="input.a.page1.fmaz010"
            IF NOT cl_null(g_fmaz_d[l_ac].fmaz010) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaz010
            #add-point:BEFORE FIELD fmaz010 name="input.b.page1.fmaz010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmaz010
            #add-point:ON CHANGE fmaz010 name="input.g.page1.fmaz010"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.fmaz014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaz014
            #add-point:ON ACTION controlp INFIELD fmaz014 name="input.c.page1.fmaz014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmaz001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaz001
            #add-point:ON ACTION controlp INFIELD fmaz001 name="input.c.page1.fmaz001"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmaz_d[l_ac].fmaz001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_fmaz_m.fmaz012  #资金中心
            LET g_qryparam.arg2 = "6"                #组织类型
            
            CALL q_ooed004_7()                                #呼叫開窗

            LET g_fmaz_d[l_ac].fmaz001 = g_qryparam.return1              

            DISPLAY g_fmaz_d[l_ac].fmaz001 TO fmaz001              #

            NEXT FIELD fmaz001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.fmaz004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaz004
            #add-point:ON ACTION controlp INFIELD fmaz004 name="input.c.page1.fmaz004"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmaz_d[l_ac].fmaz004             #給予default值
            #LET g_qryparam.default2 = "" #g_fmaz_d[l_ac].fmaj001 #融资合同编号
            #給予arg
            LET g_qryparam.arg1 = g_fmaz_d[l_ac].fmaz001      #融資組織

            
            CALL q_fmaj001_1()                                #呼叫開窗

            LET g_fmaz_d[l_ac].fmaz004 = g_qryparam.return1              
            #LET g_fmaz_d[l_ac].fmaj001 = g_qryparam.return2 
            DISPLAY g_fmaz_d[l_ac].fmaz004 TO fmaz004              #
            #DISPLAY g_fmaz_d[l_ac].fmaj001 TO fmaj001 #融资合同编号
            NEXT FIELD fmaz004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.fmaz011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaz011
            #add-point:ON ACTION controlp INFIELD fmaz011 name="input.c.page1.fmaz011"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmaz_d[l_ac].fmaz011             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_fmaz_d[l_ac].fmaz004 #融資合同號
            LET g_qryparam.arg2 = g_fmaz_d[l_ac].fmaz001 #融資組織
            
            CALL q_fmak011()                                #呼叫開窗

            LET g_fmaz_d[l_ac].fmaz011 = g_qryparam.return1              

            DISPLAY g_fmaz_d[l_ac].fmaz011 TO fmaz011              #

            NEXT FIELD fmaz011                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.fmaz006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaz006
            #add-point:ON ACTION controlp INFIELD fmaz006 name="input.c.page1.fmaz006"
            #此段落由子樣板a07產生            
#            #開窗i段
#            INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'i'
#            LET g_qryparam.reqry = FALSE
#
#            LET g_qryparam.default1 = g_fmaz_d[l_ac].fmaz006             #給予default值
#            LET g_qryparam.default2 = "" #g_fmaz_d[l_ac].itys001 #l_cmd
#            #給予arg
#            LET g_qryparam.arg1 = "" #
#
#            
#            CALL q_itys001_1()                                #呼叫開窗
#
#            LET g_fmaz_d[l_ac].fmaz006 = g_qryparam.return1              
#            #LET g_fmaz_d[l_ac].itys001 = g_qryparam.return2 
#            DISPLAY g_fmaz_d[l_ac].fmaz006 TO fmaz006              #
#            #DISPLAY g_fmaz_d[l_ac].itys001 TO itys001 #l_cmd
#            NEXT FIELD fmaz006                          #返回原欄位


            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmaz_d[l_ac].fmaz006             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooaj002()                                #呼叫開窗

            LET g_fmaz_d[l_ac].fmaz006 = g_qryparam.return1              

            DISPLAY g_fmaz_d[l_ac].fmaz006 TO fmaz006              #

            NEXT FIELD fmaz006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.sumday
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sumday
            #add-point:ON ACTION controlp INFIELD sumday name="input.c.page1.sumday"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmaz008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaz008
            #add-point:ON ACTION controlp INFIELD fmaz008 name="input.c.page1.fmaz008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmaz010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaz010
            #add-point:ON ACTION controlp INFIELD fmaz010 name="input.c.page1.fmaz010"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_fmaz_d[l_ac].* = g_fmaz_d_t.*
               CLOSE afmt080_bcl
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
               LET g_errparam.extend = g_fmaz_d[l_ac].fmaz014 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_fmaz_d[l_ac].* = g_fmaz_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               LET g_fmaz3_d[l_ac].fmazmodid = g_user 
LET g_fmaz3_d[l_ac].fmazmoddt = cl_get_current()
LET g_fmaz3_d[l_ac].fmazmodid_desc = cl_get_username(g_fmaz3_d[l_ac].fmazmodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
         
               #將遮罩欄位還原
               CALL afmt080_fmaz_t_mask_restore('restore_mask_o')
         
               UPDATE fmaz_t SET (fmaz002,fmaz003,fmaz014,fmaz001,fmaz004,fmaz011,fmaz006,fmaz008,fmaz010, 
                   fmazownid,fmazowndp,fmazcrtid,fmazcrtdp,fmazcrtdt,fmazmodid,fmazmoddt,fmazcnfid,fmazcnfdt, 
                   fmazpstid,fmazpstdt) = (g_fmaz_m.fmaz002,g_fmaz_m.fmaz003,g_fmaz_d[l_ac].fmaz014, 
                   g_fmaz_d[l_ac].fmaz001,g_fmaz_d[l_ac].fmaz004,g_fmaz_d[l_ac].fmaz011,g_fmaz_d[l_ac].fmaz006, 
                   g_fmaz_d[l_ac].fmaz008,g_fmaz_d[l_ac].fmaz010,g_fmaz3_d[l_ac].fmazownid,g_fmaz3_d[l_ac].fmazowndp, 
                   g_fmaz3_d[l_ac].fmazcrtid,g_fmaz3_d[l_ac].fmazcrtdp,g_fmaz3_d[l_ac].fmazcrtdt,g_fmaz3_d[l_ac].fmazmodid, 
                   g_fmaz3_d[l_ac].fmazmoddt,g_fmaz3_d[l_ac].fmazcnfid,g_fmaz3_d[l_ac].fmazcnfdt,g_fmaz3_d[l_ac].fmazpstid, 
                   g_fmaz3_d[l_ac].fmazpstdt)
                WHERE fmazent = g_enterprise AND fmaz002 = g_fmaz_m.fmaz002 
                 AND fmaz003 = g_fmaz_m.fmaz003 
 
                 AND fmaz014 = g_fmaz_d_t.fmaz014 #項次   
 
                 
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmaz_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "fmaz_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fmaz_m.fmaz002
               LET gs_keys_bak[1] = g_fmaz002_t
               LET gs_keys[2] = g_fmaz_m.fmaz003
               LET gs_keys_bak[2] = g_fmaz003_t
               LET gs_keys[3] = g_fmaz_d[g_detail_idx].fmaz014
               LET gs_keys_bak[3] = g_fmaz_d_t.fmaz014
               CALL afmt080_update_b('fmaz_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_fmaz_m),util.JSON.stringify(g_fmaz_d_t)
                     LET g_log2 = util.JSON.stringify(g_fmaz_m),util.JSON.stringify(g_fmaz_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL afmt080_fmaz_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_fmaz_m.fmaz002
               LET ls_keys[ls_keys.getLength()+1] = g_fmaz_m.fmaz003
 
               LET ls_keys[ls_keys.getLength()+1] = g_fmaz_d_t.fmaz014
 
               CALL afmt080_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE afmt080_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_fmaz_d[l_ac].* = g_fmaz_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE afmt080_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_fmaz_d.getLength() = 0 THEN
               NEXT FIELD fmaz014
            END IF
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_fmaz_d[li_reproduce_target].* = g_fmaz_d[li_reproduce].*
               LET g_fmaz3_d[li_reproduce_target].* = g_fmaz3_d[li_reproduce].*
 
               LET g_fmaz_d[li_reproduce_target].fmaz014 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_fmaz_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_fmaz_d.getLength()+1
            END IF
            
      END INPUT
 
      INPUT ARRAY g_fmaz3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b, WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                   INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                   DELETE ROW = l_allow_delete,
                   APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
                 
         BEFORE INPUT
            
            CALL afmt080_b_fill(g_wc2) #test 
            #如果一直都在單頭則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_detail_idx)
            END IF
            LET g_loc = 'm' 
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
            CALL afmt080_idx_chk()
            
            CALL s_transaction_begin()
            IF g_rec_b >= l_ac THEN
               LET l_cmd='u'
               CALL afmt080_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body3.before_row.set_entry_b"
               
               #end add-point
               CALL afmt080_set_no_entry_b(l_cmd)
               LET g_fmaz3_d_t.* = g_fmaz3_d[l_ac].*   #BACKUP  #page1
               LET g_fmaz3_d_o.* = g_fmaz3_d[l_ac].*   #BACKUP  #page1
            END IF 
            
 
 
    
         BEFORE INSERT
            LET g_insert = 'Y' 
            NEXT FIELD fmaz014
 
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            INITIALIZE g_fmaz3_d_t.* TO NULL
            INITIALIZE g_fmaz3_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_fmaz3_d[l_ac].* TO NULL
            #公用欄位預設值
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_fmaz3_d[l_ac].fmazownid = g_user
      LET g_fmaz3_d[l_ac].fmazowndp = g_dept
      LET g_fmaz3_d[l_ac].fmazcrtid = g_user
      LET g_fmaz3_d[l_ac].fmazcrtdp = g_dept 
      LET g_fmaz3_d[l_ac].fmazcrtdt = cl_get_current()
      LET g_fmaz3_d[l_ac].fmazmodid = g_user
      LET g_fmaz3_d[l_ac].fmazmoddt = cl_get_current()
 
 
  
            #一般欄位預設值
            
            
            #add-point:modify段before備份 name="input.body3.before_insert.before_bak"
            
            #end add-point
            LET g_fmaz3_d_t.* = g_fmaz3_d[l_ac].*     #新輸入資料
            LET g_fmaz3_d_o.* = g_fmaz3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL afmt080_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body3.before_insert.set_entry_b"
            
            #end add-point
            CALL afmt080_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_fmaz_d[li_reproduce_target].* = g_fmaz_d[li_reproduce].*
               LET g_fmaz3_d[li_reproduce_target].* = g_fmaz3_d[li_reproduce].*
 
               LET g_fmaz3_d[li_reproduce_target].fmaz014 = NULL
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
               IF afmt080_before_delete() THEN 
                  
 
 
				  
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_fmaz_m.fmaz002
                  LET gs_keys[gs_keys.getLength()+1] = g_fmaz_m.fmaz003
                  LET gs_keys[gs_keys.getLength()+1] = g_fmaz_d_t.fmaz014
				  
                  #刪除下層單身
                  IF NOT afmt080_key_delete_b(gs_keys,'fmaz_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE afmt080_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE afmt080_bcl
               CALL s_transaction_end('Y','0') 
               LET l_count = g_fmaz3_d.getLength()
            END IF
            
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body3.after_delete"
               
               #end add-point
                              CALL afmt080_delete_b('fmaz_t',gs_keys,"'2'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_fmaz3_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_fmaz3_d[l_ac].* = g_fmaz3_d_t.*
               CLOSE afmt080_bcl
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
               LET g_errparam.extend = g_fmaz_d[l_ac].fmaz014 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_fmaz3_d[l_ac].* = g_fmaz3_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               LET g_fmaz3_d[l_ac].fmazmodid = g_user 
LET g_fmaz3_d[l_ac].fmazmoddt = cl_get_current()
LET g_fmaz3_d[l_ac].fmazmodid_desc = cl_get_username(g_fmaz3_d[l_ac].fmazmodid)
                
               #add-point:單身修改前 name="modify.body3.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL afmt080_fmaz_t_mask_restore('restore_mask_o')
                     
               UPDATE fmaz_t SET (fmaz002,fmaz003,fmaz014,fmaz001,fmaz004,fmaz011,fmaz006,fmaz008,fmaz010, 
                   fmazownid,fmazowndp,fmazcrtid,fmazcrtdp,fmazcrtdt,fmazmodid,fmazmoddt,fmazcnfid,fmazcnfdt, 
                   fmazpstid,fmazpstdt) = (g_fmaz_m.fmaz002,g_fmaz_m.fmaz003,g_fmaz_d[l_ac].fmaz014, 
                   g_fmaz_d[l_ac].fmaz001,g_fmaz_d[l_ac].fmaz004,g_fmaz_d[l_ac].fmaz011,g_fmaz_d[l_ac].fmaz006, 
                   g_fmaz_d[l_ac].fmaz008,g_fmaz_d[l_ac].fmaz010,g_fmaz3_d[l_ac].fmazownid,g_fmaz3_d[l_ac].fmazowndp, 
                   g_fmaz3_d[l_ac].fmazcrtid,g_fmaz3_d[l_ac].fmazcrtdp,g_fmaz3_d[l_ac].fmazcrtdt,g_fmaz3_d[l_ac].fmazmodid, 
                   g_fmaz3_d[l_ac].fmazmoddt,g_fmaz3_d[l_ac].fmazcnfid,g_fmaz3_d[l_ac].fmazcnfdt,g_fmaz3_d[l_ac].fmazpstid, 
                   g_fmaz3_d[l_ac].fmazpstdt) #自訂欄位頁簽
                WHERE fmazent = g_enterprise AND fmaz002 = g_fmaz_m.fmaz002
                 AND fmaz003 = g_fmaz_m.fmaz003
                 AND fmaz014 = g_fmaz3_d_t.fmaz014 #項次 
               #add-point:單身修改中 name="modify.body3.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmaz_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmaz_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fmaz_m.fmaz002
               LET gs_keys_bak[1] = g_fmaz002_t
               LET gs_keys[2] = g_fmaz_m.fmaz003
               LET gs_keys_bak[2] = g_fmaz003_t
               LET gs_keys[3] = g_fmaz3_d[g_detail_idx].fmaz014
               LET gs_keys_bak[3] = g_fmaz3_d_t.fmaz014
               CALL afmt080_update_b('fmaz_t',gs_keys,gs_keys_bak,"'2'")
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_fmaz_m),util.JSON.stringify(g_fmaz3_d_t)
                     LET g_log2 = util.JSON.stringify(g_fmaz_m),util.JSON.stringify(g_fmaz3_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL afmt080_fmaz_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="modify.body3.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaz014_1
            #add-point:BEFORE FIELD fmaz014_1 name="input.b.page3.fmaz014_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaz014_1
            
            #add-point:AFTER FIELD fmaz014_1 name="input.a.page3.fmaz014_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmaz014_1
            #add-point:ON CHANGE fmaz014_1 name="input.g.page3.fmaz014_1"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.fmaz014_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaz014_1
            #add-point:ON ACTION controlp INFIELD fmaz014_1 name="input.c.page3.fmaz014_1"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:input段after row name="input.body3.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_fmaz3_d[l_ac].* = g_fmaz3_d_t.*
               END IF
               CLOSE afmt080_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               EXIT DIALOG 
            END IF
 
            CLOSE afmt080_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #add-point:input段after input  name="input.body3.after_input"
            
            #end add-point    
 
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_fmaz_d[li_reproduce_target].* = g_fmaz_d[li_reproduce].*
               LET g_fmaz3_d[li_reproduce_target].* = g_fmaz3_d[li_reproduce].*
 
               LET g_fmaz3_d[li_reproduce_target].fmaz014 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_fmaz3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_fmaz3_d.getLength()+1
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
         CALL DIALOG.setCurrentRow("s_detail3",g_detail_idx)
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD fmaz002
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD fmaz014
               WHEN "s_detail3"
                  NEXT FIELD fmaz014_2
 
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
   CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
 
 
   
   #add-point:input段after_input name="input.after_input"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="afmt080.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION afmt080_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
    CALL cl_set_act_visible("delete,modify,modify_detail", TRUE)  
   SELECT DISTINCT fmazstus INTO g_fmaz_m.b_stus FROM fmaz_t 
   WHERE  fmazent = g_enterprise 
   AND fmaz002 = g_fmaz_m.fmaz002 AND fmaz003 = g_fmaz_m.fmaz003
    IF cl_null(g_fmaz_m.b_stus) THEN
       LET g_fmaz_m.b_stus = 'N'
    END IF  
    DISPLAY g_fmaz_m.b_stus TO b_stus  
    CASE g_fmaz_m.b_stus
       WHEN "N"
        CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
        CALL cl_set_act_visible("delete,modify,modify_detail",TRUE)
     WHEN "Y"
        CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
        CALL cl_set_act_visible("delete,modify,modify_detail",FALSE)
     WHEN "X"
        CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
        CALL cl_set_act_visible("delete,modify,modify_detail",FALSE)
   END CASE
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL afmt080_b_fill(g_wc2) #第一階單身填充
      CALL afmt080_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL afmt080_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_fmaz_m.fmaz002,g_fmaz_m.fmaz003,g_fmaz_m.fmaz012,g_fmaz_m.fmaz013,g_fmaz_m.b_stus 
 
 
   CALL afmt080_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
   
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="afmt080.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION afmt080_ref_show()
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
   FOR l_ac = 1 TO g_fmaz_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_fmaz3_d.getLength()
      #add-point:ref_show段d2_reference name="ref_show.body3.reference"
      
      #end add-point
   END FOR
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="afmt080.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION afmt080_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE fmaz_t.fmaz002 
   DEFINE l_oldno     LIKE fmaz_t.fmaz002 
   DEFINE l_newno02     LIKE fmaz_t.fmaz003 
   DEFINE l_oldno02     LIKE fmaz_t.fmaz003 
 
   DEFINE l_master    RECORD LIKE fmaz_t.*
   DEFINE l_detail    RECORD LIKE fmaz_t.*
 
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
 
   IF g_fmaz_m.fmaz002 IS NULL
      OR g_fmaz_m.fmaz003 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_fmaz002_t = g_fmaz_m.fmaz002
   LET g_fmaz003_t = g_fmaz_m.fmaz003
 
   
   LET g_fmaz_m.fmaz002 = ""
   LET g_fmaz_m.fmaz003 = ""
 
   LET g_master_insert = FALSE
   CALL afmt080_set_entry('a')
   CALL afmt080_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #清空key欄位的desc
   
   
   CALL afmt080_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_fmaz_m.* TO NULL
      INITIALIZE g_fmaz_d TO NULL
      INITIALIZE g_fmaz3_d TO NULL
 
      CALL afmt080_show()
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
   CALL afmt080_set_act_visible()
   CALL afmt080_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_fmaz002_t = g_fmaz_m.fmaz002
   LET g_fmaz003_t = g_fmaz_m.fmaz003
 
   
   #組合新增資料的條件
   LET g_add_browse = " fmazent = " ||g_enterprise|| " AND",
                      " fmaz002 = '", g_fmaz_m.fmaz002, "' "
                      ," AND fmaz003 = '", g_fmaz_m.fmaz003, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL afmt080_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL afmt080_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL afmt080_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="afmt080.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION afmt080_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE fmaz_t.*
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE afmt080_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM fmaz_t
    WHERE fmazent = g_enterprise AND fmaz002 = g_fmaz002_t
    AND fmaz003 = g_fmaz003_t
 
       INTO TEMP afmt080_detail
   
   #將key修正為調整後   
   UPDATE afmt080_detail 
      #更新key欄位
      SET fmaz002 = g_fmaz_m.fmaz002
          , fmaz003 = g_fmaz_m.fmaz003
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
       , fmazownid = g_user 
       , fmazowndp = g_dept
       , fmazcrtid = g_user
       , fmazcrtdp = g_dept 
       , fmazcrtdt = ld_date
       , fmazmodid = g_user
       , fmazmoddt = ld_date
 
 
 
                                       
   #將資料塞回原table   
   INSERT INTO fmaz_t SELECT * FROM afmt080_detail
   
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
   DROP TABLE afmt080_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_fmaz002_t = g_fmaz_m.fmaz002
   LET g_fmaz003_t = g_fmaz_m.fmaz003
 
   
   DROP TABLE afmt080_detail
   
END FUNCTION
 
{</section>}
 
{<section id="afmt080.delete" >}
#+ 資料刪除
PRIVATE FUNCTION afmt080_delete()
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
   
   IF g_fmaz_m.fmaz002 IS NULL
   OR g_fmaz_m.fmaz003 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN afmt080_cl USING g_enterprise,g_fmaz_m.fmaz002,g_fmaz_m.fmaz003
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afmt080_cl:" 
      LET g_errparam.code   =  STATUS 
      LET g_errparam.popup  = TRUE 
      CLOSE afmt080_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE afmt080_master_referesh USING g_fmaz_m.fmaz002,g_fmaz_m.fmaz003 INTO g_fmaz_m.fmaz002,g_fmaz_m.fmaz003, 
       g_fmaz_m.fmaz012,g_fmaz_m.fmaz013
   
   #遮罩相關處理
   LET g_fmaz_m_mask_o.* =  g_fmaz_m.*
   CALL afmt080_fmaz_t_mask()
   LET g_fmaz_m_mask_n.* =  g_fmaz_m.*
   
   CALL afmt080_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL afmt080_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM fmaz_t WHERE fmazent = g_enterprise AND fmaz002 = g_fmaz_m.fmaz002
                                                               AND fmaz003 = g_fmaz_m.fmaz003
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fmaz_t:",SQLERRMESSAGE 
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
      #   CLOSE afmt080_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_fmaz_d.clear() 
      CALL g_fmaz3_d.clear()       
 
     
      CALL afmt080_ui_browser_refresh()  
      #CALL afmt080_ui_headershow()  
      #CALL afmt080_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL afmt080_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL afmt080_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE afmt080_cl
 
   #功能已完成,通報訊息中心
   CALL afmt080_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="afmt080.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION afmt080_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_ooef017   LIKE ooef_t.ooef017
   DEFINE l_glaa003   LIKE glaa_t.glaa003
   DEFINE l_mindate   LIKE type_t.dat
   DEFINE l_maxdate   LIKE type_t.dat
   DEFINE l_smalldate LIKE type_t.dat
   DEFINE l_largedate LIKE type_t.dat
   DEFINE l_fmaj010   LIKE fmaj_t.fmaj010
   DEFINE l_fmam003   LIKE fmam_t.fmam003
   DEFINE l_fmal007   LIKE fmal_t.fmal007
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #先清空單身變數內容
   CALL g_fmaz_d.clear()
   CALL g_fmaz3_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT fmaz014,fmaz001,fmaz004,fmaz011,fmaz006,fmaz008,fmaz010,fmaz014,fmazownid, 
       fmazowndp,fmazcrtid,fmazcrtdp,fmazcrtdt,fmazmodid,fmazmoddt,fmazcnfid,fmazcnfdt,fmazpstid,fmazpstdt, 
       t1.ooefl003 ,t2.fmam005 ,t3.ooail003 ,t4.ooag011 ,t5.ooefl003 ,t6.ooag011 ,t7.ooefl003 ,t8.ooag011 , 
       t9.ooag011 ,t10.ooag011 FROM fmaz_t",   
               "",
               
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=fmaz001 AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN fmam_t t2 ON t2.fmament="||g_enterprise||" AND t2.fmam001=fmaz004 AND t2.fmam006=fmaz011  ",
               " LEFT JOIN ooail_t t3 ON t3.ooailent="||g_enterprise||" AND t3.ooail001=fmaz006 AND t3.ooail002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=fmazownid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=fmazowndp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=fmazcrtid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=fmazcrtdp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=fmazmodid  ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=fmazcnfid  ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=fmazpstid  ",
 
               " WHERE fmazent= ? AND fmaz002=? AND fmaz003=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("fmaz_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF afmt080_fill_chk(1) THEN
      IF g_action_choice <> 'fetch' OR cl_null(g_action_choice) THEN
         LET g_sql = g_sql, " ORDER BY fmaz_t.fmaz014"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
         
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE afmt080_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR afmt080_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs USING g_enterprise,g_fmaz_m.fmaz002,g_fmaz_m.fmaz003
                                               
      FOREACH b_fill_cs INTO g_fmaz_d[l_ac].fmaz014,g_fmaz_d[l_ac].fmaz001,g_fmaz_d[l_ac].fmaz004,g_fmaz_d[l_ac].fmaz011, 
          g_fmaz_d[l_ac].fmaz006,g_fmaz_d[l_ac].fmaz008,g_fmaz_d[l_ac].fmaz010,g_fmaz3_d[l_ac].fmaz014, 
          g_fmaz3_d[l_ac].fmazownid,g_fmaz3_d[l_ac].fmazowndp,g_fmaz3_d[l_ac].fmazcrtid,g_fmaz3_d[l_ac].fmazcrtdp, 
          g_fmaz3_d[l_ac].fmazcrtdt,g_fmaz3_d[l_ac].fmazmodid,g_fmaz3_d[l_ac].fmazmoddt,g_fmaz3_d[l_ac].fmazcnfid, 
          g_fmaz3_d[l_ac].fmazcnfdt,g_fmaz3_d[l_ac].fmazpstid,g_fmaz3_d[l_ac].fmazpstdt,g_fmaz_d[l_ac].fmaz001_desc, 
          g_fmaz_d[l_ac].fmaz011_desc,g_fmaz_d[l_ac].fmaz006_desc,g_fmaz3_d[l_ac].fmazownid_desc,g_fmaz3_d[l_ac].fmazowndp_desc, 
          g_fmaz3_d[l_ac].fmazcrtid_desc,g_fmaz3_d[l_ac].fmazcrtdp_desc,g_fmaz3_d[l_ac].fmazmodid_desc, 
          g_fmaz3_d[l_ac].fmazcnfid_desc,g_fmaz3_d[l_ac].fmazpstid_desc
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充 name="b_fill.fill"
         
         ##--start--本期計息天數
            #本期別最大和最小
         SELECT ooef017 INTO l_ooef017
          FROM ooef_t 
          WHERE ooefent = g_enterprise AND ooef001 = g_fmaz_d[l_ac].fmaz001
         
         SELECT glaa003 INTO l_glaa003 FROM glaa_t
          WHERE glaaent = g_enterprise
            AND glaa014 = 'Y'
            AND glaacomp = l_ooef017
         
         SELECT min(glav004),max(glav004) into l_mindate,l_maxdate
           FROM glav_t 
          WHERE glavent = g_enterprise
            AND glav001 = l_glaa003
            AND glav002 = g_fmaz_m.fmaz002 #年度
            AND glav006 = g_fmaz_m.fmaz003  #期別
            
            #融資到期日fmaj010
            SELECT fmaj010 INTO l_fmaj010
            FROM fmaj_t
            WHERE fmaj001 = g_fmaz_d[l_ac].fmaz004 #合同編號
            AND fmaj002 = g_fmaz_d[l_ac].fmaz001 #合同組織
            AND fmajent = g_enterprise
            #融資到賬日fmam003
            SELECT max(fmam003) INTO l_fmam003
            FROM fmam_t
            WHERE fmam001 = g_fmaz_d[l_ac].fmaz004 #合同編號
            AND fmam006 = g_fmaz_d[l_ac].fmaz011 #合同項次
            AND fmament = g_enterprise
            
            IF l_fmaj010 < l_maxdate THEN
               LET l_smalldate = l_fmaj010
            ELSE
               LET l_smalldate = l_maxdate
            END IF
            
            IF l_mindate < l_fmam003 AND l_fmam003 < l_maxdate THEN
               LET l_largedate = l_fmam003
            ELSE
               LET l_largedate = l_mindate
            END IF
            
            LET g_fmaz_d[l_ac].sumday = l_smalldate - l_largedate +1
         ##--end

         #到賬金額
            LET g_sumfmam005 = 0
            SELECT sum(fmam005) into g_sumfmam005 FROM fmam_t 
            WHERE fmament = g_enterprise
            AND fmam001 = g_fmaz_d[l_ac].fmaz004 
            AND fmam006 = g_fmaz_d[l_ac].fmaz011
            AND fmam003 <= l_maxdate 
            
            IF cl_null(g_sumfmam005) THEN
               LET g_sumfmam005 = 0
            END IF
            
#            LET g_sumfmaw008 = 0
#            SELECT sum(fmaw008) into g_sumfmaw008 FROM fmaw_t
#            WHERE fmawent = g_enterprise
#            AND fmaw003 = g_fmaz_d[l_ac].fmaz004 
#            AND fmaw010 = g_fmaz_d[l_ac].fmaz011
            
            SELECT sum(fmal007) into l_fmal007 FROM fmal_t
            WHERE fmalent = g_enterprise
            AND fmal001 = g_fmaz_d[l_ac].fmaz004 
            AND fmal008 = g_fmaz_d[l_ac].fmaz011
            AND fmal006 <= l_maxdate
            
            IF cl_null(l_fmal007) THEN
               LET l_fmal007 = 0
            END IF

            LET g_fmaz_d[l_ac].fmaz011_desc = g_sumfmam005 - l_fmal007
 
         #法人歸屬
         SELECT ooef017 INTO g_fmaz_d[l_ac].fmaz001_desc_1 FROM ooef_t 
         WHERE ooefent = g_enterprise AND ooef001 = g_fmaz_d[l_ac].fmaz001
         
         #執行利率
         SELECT fman008 INTO g_fmaz_d[l_ac].fmaz001_desc_2  FROM fman_t
         WHERE fmanent = g_enterprise AND fman001 = g_fmaz_d[l_ac].fmaz004 AND fman010 = g_fmaz_d[l_ac].fmaz011
         ORDER BY fman003 DESC
         
         
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
 
            CALL g_fmaz_d.deleteElement(g_fmaz_d.getLength())
      CALL g_fmaz3_d.deleteElement(g_fmaz3_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
   
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_fmaz_d.getLength()
      LET g_fmaz_d_mask_o[l_ac].* =  g_fmaz_d[l_ac].*
      CALL afmt080_fmaz_t_mask()
      LET g_fmaz_d_mask_n[l_ac].* =  g_fmaz_d[l_ac].*
   END FOR
   
   LET g_fmaz3_d_mask_o.* =  g_fmaz3_d.*
   FOR l_ac = 1 TO g_fmaz3_d.getLength()
      LET g_fmaz3_d_mask_o[l_ac].* =  g_fmaz3_d[l_ac].*
      CALL afmt080_fmaz_t_mask()
      LET g_fmaz3_d_mask_n[l_ac].* =  g_fmaz3_d[l_ac].*
   END FOR
 
 
   FREE afmt080_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="afmt080.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION afmt080_idx_chk()
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
      IF g_detail_idx > g_fmaz_d.getLength() THEN
         LET g_detail_idx = g_fmaz_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_fmaz_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_fmaz_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_fmaz3_d.getLength() THEN
         LET g_detail_idx = g_fmaz3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_fmaz3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_fmaz3_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="afmt080.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION afmt080_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_fmaz_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="afmt080.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION afmt080_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   
   #end add-point
   
   DELETE FROM fmaz_t
    WHERE fmazent = g_enterprise AND fmaz002 = g_fmaz_m.fmaz002 AND
                              fmaz003 = g_fmaz_m.fmaz003 AND
 
          fmaz014 = g_fmaz_d_t.fmaz014
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "fmaz_t:",SQLERRMESSAGE 
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
 
{<section id="afmt080.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION afmt080_delete_b(ps_table,ps_keys_bak,ps_page)
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
 
{<section id="afmt080.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION afmt080_insert_b(ps_table,ps_keys,ps_page)
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
 
{<section id="afmt080.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION afmt080_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
 
{<section id="afmt080.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION afmt080_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_fmaz_d[l_ac].fmaz014 = g_fmaz_d_t.fmaz014 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="afmt080.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION afmt080_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="afmt080.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION afmt080_lock_b(ps_table,ps_page)
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
   #CALL afmt080_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="afmt080.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION afmt080_unlock_b(ps_table,ps_page)
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
 
{<section id="afmt080.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION afmt080_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("fmaz002,fmaz003",TRUE)
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
 
{<section id="afmt080.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION afmt080_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("fmaz002,fmaz003",FALSE)
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
 
{<section id="afmt080.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION afmt080_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="afmt080.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION afmt080_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="afmt080.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION afmt080_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="afmt080.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION afmt080_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="afmt080.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION afmt080_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="afmt080.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION afmt080_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="afmt080.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION afmt080_default_search()
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
      LET ls_wc = ls_wc, " fmaz002 = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " fmaz003 = '", g_argv[02], "' AND "
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
 
{<section id="afmt080.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION afmt080_fill_chk(ps_idx)
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
 
{<section id="afmt080.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION afmt080_modify_detail_chk(ps_record)
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
         LET ls_return = "fmaz014"
      WHEN "s_detail3"
         LET ls_return = "fmaz014_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="afmt080.mask_functions" >}
&include "erp/afm/afmt080_mask.4gl"
 
{</section>}
 
{<section id="afmt080.state_change" >}
    
 
{</section>}
 
{<section id="afmt080.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION afmt080_set_pk_array()
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
   LET g_pk_array[1].values = g_fmaz_m.fmaz002
   LET g_pk_array[1].column = 'fmaz002'
   LET g_pk_array[2].values = g_fmaz_m.fmaz003
   LET g_pk_array[2].column = 'fmaz003'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afmt080.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION afmt080_msgcentre_notify(lc_state)
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
   CALL afmt080_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_fmaz_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afmt080.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt080_confirm()
DEFINE l_fmazstus   LIKE fmaz_t.fmazstus
DEFINE lc_state LIKE type_t.chr5
   
   IF cl_null(g_fmaz_m.fmaz002) OR cl_null(g_fmaz_m.fmaz003) THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = "std-00003"
      LET g_errparam.popup  = FALSE
      CALL cl_err()
      RETURN
   END IF
   
   SELECT DISTINCT fmazstus INTO l_fmazstus FROM fmaz_t
    WHERE fmazent = g_enterprise
      AND fmaz002 = g_fmaz_m.fmaz002 
      AND fmaz003 = g_fmaz_m.fmaz003 
      
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         CASE l_fmazstus
            WHEN "N"
               HIDE OPTION "open"

            WHEN "Y"
               HIDE OPTION "confirmed"

            WHEN "X"
               HIDE OPTION "invalid"

         END CASE


      ON ACTION open
         LET lc_state = "N"
          EXIT MENU

      ON ACTION confirmed
         LET lc_state = "Y"
         EXIT MENU 
     
      ON ACTION invalid
         LET lc_state = "X"     
         EXIT MENU 
   END MENU 
   #151125-00001#2 --- add start ---
   IF lc_state = 'X' THEN
      IF NOT cl_ask_confirm('aim-00109') THEN
         RETURN
      END IF
   END IF
   #151125-00001#2 --- add end   ---               
    IF cl_ask_confirm('afm-00010') THEN    
      UPDATE fmaz_t SET fmazstus = lc_state 
      WHERE fmazent = g_enterprise 
      AND fmaz002 = g_fmaz_m.fmaz002
      AND fmaz003 = g_fmaz_m.fmaz003
     IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ""
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = FALSE
         CALL cl_err()
     ELSE
        CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")

         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")

         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")

        END CASE
        LET l_fmazstus = lc_state  
        DISPLAY l_fmazstus TO b_stus        
     END IF
     END IF     
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt080_fmaz001_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fmaz_d[l_ac].fmaz001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_fmaz_d[l_ac].fmaz001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_fmaz_d[l_ac].fmaz001_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fmaz_d[l_ac].fmaz001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooef017 FROM ooef_t WHERE ooefent='"||g_enterprise||"' AND ooef001=? ","") RETURNING g_rtn_fields
   LET g_fmaz_d[l_ac].fmaz001_desc_1 = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_fmaz_d[l_ac].fmaz001_desc_1
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt080_s01()
   IF cl_null(g_fmaz_m.fmaz002) OR cl_null(g_fmaz_m.fmaz003) THEN
      RETURN
   END IF
   OPEN WINDOW w_afmt080_s01 WITH FORM cl_ap_formpath("afm",'afmt080_s01')
   CALL cl_set_combo_scc('fmao003','8858')
   
  # EXECUTE afmt080_master_referesh USING g_fmaz_m.fmaz002,g_fmaz_m.fmaz003 INTO g_fmaz_m.fmaz002,g_fmaz_m.fmaz003, 
  # g_fmaz_m.fmaz012,g_fmaz_m.fmaz013
   
   CALL afmt080_b_fill3()
    DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
        DISPLAY ARRAY g_fmaz_s01 TO s_detail1.* 
        END DISPLAY    
        
        ON ACTION close
           EXIT DIALOG     
             
        ON ACTION exit
           EXIT DIALOG 
    END DIALOG
    CLOSE WINDOW w_afmt080_s01
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt080_b_fill3()
   DEFINE l_sql     STRING
   DEFINE l_cnt     LIKE type_t.num5
   DEFINE l_fmaj003 LIKE fmaj_t.fmaj003
   DEFINE l_fmaj010 LIKE type_t.dat
   DEFINE l_fmaa004 LIKE fmaa_t.fmaa004
   DEFINE l_mindate_s01 LIKE type_t.dat
   DEFINE l_maxdate_s01 LIKE type_t.dat
   DEFINE l_fmao002 LIKE type_t.dat
   DEFINE l_sdate   LIKE type_t.num15_3
   DEFINE l_xdate   LIKE type_t.num15_3
   DEFINE dateqibie LIKE type_t.num5
   DEFINE qibiecha  LIKE type_t.num5
   DEFINE everm     LIKE type_t.num20_6
   DEFINE sumeverm  LIKE type_t.num20_6
   DEFINE qistar    LIKE type_t.num5
   DEFINE qibiestep LIKE type_t.num5
   DEFINE l_qs_minde LIKE type_t.dat
   DEFINE l_qs_maxde LIKE type_t.dat
   DEFINE l_ooef017  LIKE ooef_t.ooef017
   DEFINE l_glaa003  LIKE glaa_t.glaa003
   DEFINE l_fmaj010_s01 LIKE fmaj_t.fmaj010
   DEFINE l_fmam003_s01 LIKE fmam_t.fmam003
   DEFINE l_update_2 LIKE type_t.dat
   DEFINE l_update_1 LIKE type_t.dat
   DEFINE l_downdate_1 LIKE type_t.dat
   DEFINE l_fmaw002_s01 LIKE fmam_t.fmam003
   
   
   CALL g_fmaz_s01.clear()
   LET l_cnt = 1
 
#   DECLARE fmaxsel_cs CURSOR FOR SELECT fmaz014,fmaz001,fmaz004,fmaz011,fmaz005,fmaz006,'','','' FROM fmaz_t
#                              WHERE fmazent = g_enterprise 
#                              AND fmaz002 = g_fmaz_m.fmaz002 AND fmaz003 = g_fmaz_m.fmaz003
                              
   DECLARE fmaxsel_cs CURSOR FOR select fmaz014,fmaz001,fmaz004,fmaz011,fmao008,fmaz006,fmao003,sum(fmao006),''
                              from fmaz_t,fmao_t
                              where fmao001 = fmaz004 and fmao004 = fmaz006
                              and fmaz002 = g_fmaz_m.fmaz002 and fmaz003 = g_fmaz_m.fmaz003
                              group by fmaz014,fmaz001,fmaz004,fmaz011,fmaz005,fmaz006,fmao003,fmao008
                              
   FOREACH fmaxsel_cs INTO g_fmaz_s01[l_cnt].*
      
      #本期別最大和最小
      SELECT ooef017 INTO l_ooef017
       FROM ooef_t 
       WHERE ooefent = g_enterprise AND ooef001 = g_fmaz_s01[l_cnt].fmaz001
      
      SELECT glaa003 INTO l_glaa003 FROM glaa_t
       WHERE glaaent = g_enterprise
         AND glaa014 = 'Y'
         AND glaacomp = l_ooef017
      
      SELECT min(glav004),max(glav004) into l_mindate_s01,l_maxdate_s01 
        FROM glav_t 
       WHERE glavent = g_enterprise
         AND glav001 = l_glaa003
         AND glav002 = g_fmaz_m.fmaz002 #年度
         AND glav006 = g_fmaz_m.fmaz003  #期別
      
      #.....afmi010融資費用處理方式(分期攤銷執行)
      SELECT fmaj003,fmaj010 INTO l_fmaj003,l_fmaj010 FROM fmaj_t
      WHERE fmaj001 = g_fmaz_s01[l_cnt].fmaz004 AND fmaj002 = g_fmaz_s01[l_cnt].fmaz001
      
      SELECT fmaa004 INTO l_fmaa004 FROM fmaa_t
      WHERE fmaa001 = l_fmaj003
      
      IF l_fmaa004 = 2 THEN
         
#         #費用總額
#         SELECT sum(fmao006),fmao003 INTO g_fmaz_s01[l_cnt].fmaz011_desc_1,g_fmaz_s01[l_cnt].fmaz011_desc 
#         FROM fmao_t
#         WHERE fmao001 = g_fmaz_s01[l_cnt].fmaz004 #融資合同編號
#         #and fmao008 = g_fmaz_s01[l_cnt].fmaz005 #到賬單號
#         GROUP BY fmao003
         
         #本期攤銷金額
         
            #融資到期日fmaj010
            SELECT fmaj010 INTO l_fmaj010_s01
            FROM fmaj_t
            WHERE fmaj001 = g_fmaz_s01[l_cnt].fmaz004 #合同編號
            AND fmaj002 = g_fmaz_s01[l_cnt].fmaz001 #合同組織
            AND fmajent = g_enterprise
            #融資到賬日fmam003
            SELECT max(fmam003) INTO l_fmam003_s01
            FROM fmam_t
            WHERE fmam001 = g_fmaz_s01[l_cnt].fmaz004 #合同編號
            AND fmam006 = g_fmaz_s01[l_cnt].fmaz011 #合同項次
            AND fmament = g_enterprise
            
            if l_fmaj010_s01 < l_maxdate_s01 then
               let l_update_1 = l_fmaj010_s01
            else
               let l_update_1 = l_maxdate_s01
            end if
            
            if l_mindate_s01 < l_fmam003_s01 < l_maxdate_s01 then
               let l_update_2 = l_fmam003_s01
            else
               let l_update_2 = l_mindate_s01
            end if
            
            #還款日期fmaw002
            SELECT max(fmaw002) INTO l_fmaw002_s01
            FROM fmaw_t
            WHERE fmaw003 = g_fmaz_s01[l_cnt].fmaz004 #合同編號
            AND fmaw010 = g_fmaz_s01[l_cnt].fmaz011 #合同項次
            AND fmawent = g_enterprise
            
            if l_fmaj010_s01 < l_fmaw002_s01 then
               let l_downdate_1 = l_fmaw002_s01
            else
               let l_downdate_1 = l_fmaj010_s01
            end if
            
            LET g_fmaz_s01[l_cnt].thisdatem = g_fmaz_s01[l_cnt].fmaz011_desc_1 * ((l_update_1 - l_update_2 +1)/(l_downdate_1 - l_update_2 +1))

#         SELECT fmao002 INTO l_fmao002 #日期
#         FROM fmao_t
#         WHERE fmao001 = g_fmaz_s01[l_cnt].fmaz004 #融資合同編號
#         #and fmao008 = g_fmaz_s01[l_cnt].fmaz005 #到賬單號
#         AND fmao003 = g_fmaz_s01[l_cnt].fmao003 #費用種類
#         
#         LET l_sdate = l_maxdate - l_fmao002
#         LET l_xdate = l_fmaj010 - l_fmao002
#         LET g_fmaz_s01[l_cnt].thisdatem = g_fmaz_s01[l_cnt].fmaz011_desc_1 * ((l_sdate+1)/(l_xdate+1))

#         #在本期內
#         IF l_mindate <= l_fmao002 <= l_maxdate THEN
#             LET g_fmaz_s01[l_cnt].thisdatem = g_fmaz_s01[l_cnt].fmaz011_desc_1 * ((l_sdate+1)/(l_xdate+1))
#         ELSE
#            #在本期外
#            IF l_fmao002 < l_mindate THEN
##                SELECT DISTINCT glav006
##                FROM glav_t 
##                WHERE  glav004 = to_date('2013/12/12','YYYY/MM/DD')
#               INITIALIZE g_ref_fields TO NULL
#               LET g_ref_fields[1] = g_fmaz_d[l_ac].fmaz001
#               CALL ap_ref_array2(g_ref_fields,"SELECT DISTINCT glav006 FROM glav_t WHERE glav004= to_date('"||l_fmao002||"','YYYY/MM/DD')","") RETURNING g_rtn_fields
#               LET dateqibie = g_rtn_fields[1]
#               
#               LET qibiecha = g_fmaz_m.fmaz003 - dateqibie # 期別的差--本期的期別和日期的期別
#               LET everm = 0 #每個月攤銷
#               LET sumeverm = 0 #每個月攤銷之和
#               
#               FOR qistar=0 TO qibiecha
#               
#                  LET qibiestep = dateqibie + qistar
#                  
#                  SELECT min(glav004),max(glav004) INTO l_qs_minde,l_qs_maxde
#                  FROM glav_t 
#                  WHERE glav006 = qibiestep  #期別
#                  
#                  IF g_fmaz_s01[l_cnt].fmaz011_desc_1 - sumeverm > 0 THEN
#                  
#                     IF qibiestep = dateqibie THEN
#   
#                        LET everm = (g_fmaz_s01[l_cnt].fmaz011_desc_1 - sumeverm)*((l_qs_maxde - l_fmao002 + 1)/(l_fmaj010 - l_fmao002 + 1))
#                        
#                     ELSE
#                        
#                        LET everm =  (g_fmaz_s01[l_cnt].fmaz011_desc_1 - sumeverm)*((l_qs_maxde - l_qs_minde + 1)/(l_fmaj010 - l_qs_minde + 1))
#   
#                     END IF
#                  END IF
#                  
#                     LET sumeverm = sumeverm + everm 
#               END FOR
#         
#               LET g_fmaz_s01[l_cnt].thisdatem = everm
#           END IF
#         END IF
       END IF
      
      ###################################
      LET l_cnt = l_cnt + 1
   END FOREACH
   CALL g_fmaz_s01.deleteElement(l_cnt)
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt080_s02()
   IF cl_null(g_fmaz_m.fmaz002) OR cl_null(g_fmaz_m.fmaz003) THEN
      RETURN
   END IF
   OPEN WINDOW w_afmt080_s02 WITH FORM cl_ap_formpath("afm",'afmt080_s02')
   CALL afmt080_b_fill4()
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
        DISPLAY ARRAY g_fmaz_s02 TO s_detail1.* 
        END DISPLAY    
        
        ON ACTION close
           EXIT DIALOG     
             
        ON ACTION exit
           EXIT DIALOG 
    END DIALOG
    CLOSE WINDOW w_afmt080_s02
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION afmt080_b_fill4()
   DEFINE l_sql         STRING
   DEFINE l_cnt         LIKE type_t.num5
   DEFINE l_mindate_s02 LIKE type_t.dat
   DEFINE l_maxdate_s02 LIKE type_t.dat
   DEFINE l_ooef017     LIKE ooef_t.ooef017
   DEFINE l_glaa003     LIKE glaa_t.glaa003
   DEFINE l_fmam003_s02 LIKE fmam_t.fmam003
   DEFINE l_fmaw002_s02 LIKE fmam_t.fmam003
   DEFINE l_fmam005_s02 LIKE fmam_t.fmam005
   DEFINE l_fmal007_s02 LIKE fmal_t.fmal007
   DEFINE l_fmak010_s02 LIKE fmak_t.fmak010
   DEFINE l_fmaw008_s02 LIKE fmaw_t.fmaw008
   
   
   CALL g_fmaz_s02.clear()
   LET l_cnt = 1
   
   DECLARE afmt080_s02_cs CURSOR FOR SELECT fmaz014,fmaz001,fmaz004,fmaz011,fmaz005,'','','',fmaz006,'',fmaz008,'',fmaz010 
                              FROM fmaz_t
                              WHERE fmazent = g_enterprise 
                              AND fmaz002 = g_fmaz_m.fmaz002 AND fmaz003 = g_fmaz_m.fmaz003
                              
   FOREACH afmt080_s02_cs INTO g_fmaz_s02[l_cnt].*
      
      #############################################
      #本期別最大和最小
      SELECT ooef017 INTO l_ooef017
       FROM ooef_t 
       WHERE ooefent = g_enterprise AND ooef001 = g_fmaz_s02[l_cnt].fmaz001
      
      SELECT glaa003 INTO l_glaa003 FROM glaa_t
       WHERE glaaent = g_enterprise
         AND glaa014 = 'Y'
         AND glaacomp = l_ooef017
      
      SELECT min(glav004),max(glav004) into l_mindate_s02,l_maxdate_s02  
        FROM glav_t 
       WHERE glavent = g_enterprise
         AND glav001 = l_glaa003
         AND glav002 = g_fmaz_m.fmaz002 #年度
         AND glav006 = g_fmaz_m.fmaz003  #期別
         
      #起息日期
      SELECT max(fmam003) INTO l_fmam003_s02  FROM fmam_t
      WHERE fmam001 = g_fmaz_s02[l_cnt].fmaz004 #合同編號
      AND fmam006 = g_fmaz_s02[l_cnt].fmaz011 #合同項次
      AND fmament = g_enterprise
      
      IF l_mindate_s02 < l_fmam003_s02 THEN
         LET g_fmaz_s02[l_cnt].fmam003 = l_fmam003_s02
      ELSE
         LET g_fmaz_s02[l_cnt].fmam003 = l_mindate_s02
      END IF
      
      #還款日期
      SELECT min(fmaw002) INTO l_fmaw002_s02 FROM fmaw_t
      WHERE fmaw003 = g_fmaz_s02[l_cnt].fmaz004 #合同編號
      AND fmaw010 = g_fmaz_s02[l_cnt].fmaz011 #合同項次
      AND fmawent = g_enterprise
      
      IF l_maxdate_s02 <l_fmaw002_s02 THEN
         LET g_fmaz_s02[l_cnt].fmaw002 = l_maxdate_s02
      ELSE
         LET g_fmaz_s02[l_cnt].fmaw002 = l_fmaw002_s02
      END IF
      
      #本期計息天數
      LET g_fmaz_s02[l_cnt].daynum = g_fmaz_s02[l_cnt].fmaw002 - g_fmaz_s02[l_cnt].fmam003

      
      #金額
      SELECT sum(fmam005) INTO l_fmam005_s02  FROM fmam_t
      WHERE fmam001 = g_fmaz_s02[l_cnt].fmaz004 #合同編號
      AND fmam006 = g_fmaz_s02[l_cnt].fmaz011 #合同項次
      AND fmament = g_enterprise
      AND fmam003 <= l_maxdate_s02
      
      IF cl_null(l_fmam005_s02) THEN
         LET l_fmam005_s02 = 0
      END IF
         #本金
         SELECT sum(fmal007) INTO l_fmal007_s02 FROM fmal_t
         WHERE fmalent = g_enterprise
         AND fmal001 = g_fmaz_d[l_ac].fmaz004 
         AND fmal008 = g_fmaz_d[l_ac].fmaz011
         AND fmal006 <= l_maxdate_s02
         
         IF cl_null(l_fmal007_s02) THEN
            LET l_fmal007_s02 = 0
         END IF
      
      LET g_fmaz_s02[l_cnt].fmam005 = l_fmam005_s02 - l_fmal007_s02
      

      #執行利率
#      SELECT fman008 INTO g_fmaz_d[l_ac].fmaz001_desc_2  FROM fman_t
#      WHERE fmanent = g_enterprise AND fman001 = g_fmaz_s02[l_cnt].fmaz004 AND fman010 = g_fmaz_s02[l_cnt].fmaz011
#      ORDER BY fman003 DESC
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_fmaz_s02[l_cnt].fmaz004
      LET g_ref_fields[2] = g_fmaz_s02[l_cnt].fmaz011
      CALL ap_ref_array2(g_ref_fields,"SELECT fman008 FROM fman_t WHERE fmanent = '"||g_enterprise||"' AND fman001 = ? AND fman010 = ? ORDER BY fman003 DESC","") 
      RETURNING g_rtn_fields
      LET g_fmaz_s02[l_cnt].fman008 = g_rtn_fields[1]
      
      #利息金額
      LET g_fmaz_s02[l_cnt].fmaz010 = g_fmaz_s02[l_cnt].fmam005 * (g_fmaz_s02[l_cnt].fman008 / 100)
      
      #未還利息
      SELECT fmak010 INTO l_fmak010_s02
      FROM fmak_t
      WHERE fmak001 = g_fmaz_s02[l_ac].fmaz004 
      AND fmak011 = g_fmaz_s02[l_ac].fmaz011
      AND fmakent = g_enterprise
               
      IF l_fmak010_s02 = 'N' OR cl_null(l_fmak010_s02) THEN
         LET g_fmaz_d[l_ac].fmaz008 = 0
      ELSE
         #已经还款的
         SELECT sum(fmaw008) INTO l_fmaw008_s02
         FROM fmaw_t
         WHERE fmawent = g_enterprise AND fmaw006 = 2
         AND fmaw003 = g_fmaz_s02[l_ac].fmaz004 AND fmaw010 = g_fmaz_s02[l_ac].fmaz011
         AND fmaw004 = g_fmaz_s02[l_ac].fmaz001 AND fmaw002 < l_mindate_s02
                  
         LET g_fmaz_s02[l_ac].fmaz008 = g_fmaz_s02[l_cnt].fmaz010 - l_fmaw008_s02
      END IF

      #############################################

      LET l_cnt = l_cnt + 1
   END FOREACH
   CALL g_fmaz_s02.deleteElement(l_cnt)
END FUNCTION

 
{</section>}
 
