#該程式未解開Section, 採用最新樣板產出!
{<section id="axci801.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2016-12-27 16:37:46), PR版次:0006(2016-12-27 17:39:32)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000089
#+ Filename...: axci801
#+ Description:  LCM計算基礎設定作業
#+ Creator....: 03297(2014-09-17 16:42:58)
#+ Modifier...: 02040 -SD/PR- 02040
 
{</section>}
 
{<section id="axci801.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160107-00009#1 2016/01/07 By Dorislai 修正INSERT INTO xcfd_t時，xcfdcomp沒給值的狀況
#160318-00025#8 2016/04/21 By 07675    將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#161108-00037#2 2016/11/16 By shiun    移除xcfa010及調整xcfb_t的單價，改成起迄範圍
#161108-00037#6 2013/12/21 By 02040    貨齡和呆滯率設定：加一欄位「材料分類」，相同材料分類的天數不可重疊
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
PRIVATE type type_g_xcfa_m        RECORD
       xcfacomp LIKE xcfa_t.xcfacomp, 
   xcfacomp_desc LIKE type_t.chr80, 
   xcfa001 LIKE xcfa_t.xcfa001, 
   xcfald LIKE xcfa_t.xcfald, 
   xcfald_desc LIKE type_t.chr80, 
   xcfa002 LIKE xcfa_t.xcfa002, 
   xcfa003 LIKE xcfa_t.xcfa003, 
   xcfa004 LIKE xcfa_t.xcfa004, 
   xcfa005 LIKE xcfa_t.xcfa005, 
   xcfa006 LIKE xcfa_t.xcfa006, 
   xcfa007 LIKE xcfa_t.xcfa007, 
   xcfa008 LIKE xcfa_t.xcfa008, 
   xcfa009 LIKE xcfa_t.xcfa009, 
   xcfa011 LIKE xcfa_t.xcfa011, 
   xcfa012 LIKE xcfa_t.xcfa012, 
   xcfa013_1 LIKE type_t.chr10, 
   xcfa013_2 LIKE type_t.chr10, 
   xcfa013_3 LIKE type_t.chr10, 
   xcfa013 LIKE xcfa_t.xcfa013, 
   xcfa014 LIKE xcfa_t.xcfa014
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_xcfb_d        RECORD
       xcfbseq LIKE xcfb_t.xcfbseq, 
   xcfb010 LIKE xcfb_t.xcfb010, 
   xcfb010_desc LIKE type_t.chr500, 
   xcfb011 LIKE xcfb_t.xcfb011, 
   xcfb012 LIKE xcfb_t.xcfb012, 
   xcfb014 LIKE xcfb_t.xcfb014, 
   xcfb013 LIKE xcfb_t.xcfb013, 
   xcfbcomp LIKE xcfb_t.xcfbcomp
       END RECORD
PRIVATE TYPE type_g_xcfb2_d RECORD
       xcfcseq LIKE xcfc_t.xcfcseq, 
   xcfc013 LIKE xcfc_t.xcfc013, 
   xcfc013_desc LIKE type_t.chr500, 
   xcfc010 LIKE xcfc_t.xcfc010, 
   xcfc011 LIKE xcfc_t.xcfc011, 
   xcfc012 LIKE xcfc_t.xcfc012, 
   xcfccomp LIKE xcfc_t.xcfccomp
       END RECORD
PRIVATE TYPE type_g_xcfb3_d RECORD
       xcfdseq LIKE xcfd_t.xcfdseq, 
   xcfd010 LIKE xcfd_t.xcfd010, 
   xcfd010_desc LIKE type_t.chr500, 
   xcfdcomp LIKE xcfd_t.xcfdcomp
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_xcfald LIKE xcfa_t.xcfald,
      b_xcfa001 LIKE xcfa_t.xcfa001,
      b_xcfa002 LIKE xcfa_t.xcfa002
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_xcfa013             LIKE xcfa_t.xcfa013           #140918
DEFINE g_wc_cs_ld            STRING                #161108-00037#2-add
DEFINE g_wc_cs_comp          STRING                #161108-00037#2-add
#end add-point
       
#模組變數(Module Variables)
DEFINE g_xcfa_m          type_g_xcfa_m
DEFINE g_xcfa_m_t        type_g_xcfa_m
DEFINE g_xcfa_m_o        type_g_xcfa_m
DEFINE g_xcfa_m_mask_o   type_g_xcfa_m #轉換遮罩前資料
DEFINE g_xcfa_m_mask_n   type_g_xcfa_m #轉換遮罩後資料
 
   DEFINE g_xcfa001_t LIKE xcfa_t.xcfa001
DEFINE g_xcfald_t LIKE xcfa_t.xcfald
DEFINE g_xcfa002_t LIKE xcfa_t.xcfa002
 
 
DEFINE g_xcfb_d          DYNAMIC ARRAY OF type_g_xcfb_d
DEFINE g_xcfb_d_t        type_g_xcfb_d
DEFINE g_xcfb_d_o        type_g_xcfb_d
DEFINE g_xcfb_d_mask_o   DYNAMIC ARRAY OF type_g_xcfb_d #轉換遮罩前資料
DEFINE g_xcfb_d_mask_n   DYNAMIC ARRAY OF type_g_xcfb_d #轉換遮罩後資料
DEFINE g_xcfb2_d          DYNAMIC ARRAY OF type_g_xcfb2_d
DEFINE g_xcfb2_d_t        type_g_xcfb2_d
DEFINE g_xcfb2_d_o        type_g_xcfb2_d
DEFINE g_xcfb2_d_mask_o   DYNAMIC ARRAY OF type_g_xcfb2_d #轉換遮罩前資料
DEFINE g_xcfb2_d_mask_n   DYNAMIC ARRAY OF type_g_xcfb2_d #轉換遮罩後資料
DEFINE g_xcfb3_d          DYNAMIC ARRAY OF type_g_xcfb3_d
DEFINE g_xcfb3_d_t        type_g_xcfb3_d
DEFINE g_xcfb3_d_o        type_g_xcfb3_d
DEFINE g_xcfb3_d_mask_o   DYNAMIC ARRAY OF type_g_xcfb3_d #轉換遮罩前資料
DEFINE g_xcfb3_d_mask_n   DYNAMIC ARRAY OF type_g_xcfb3_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
DEFINE g_wc2_table2   STRING
 
DEFINE g_wc2_table3   STRING
 
 
 
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
 
{<section id="axci801.main" >}
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
   CALL cl_ap_init("axc","")
 
   #add-point:作業初始化 name="main.init"
   #161108-00037#2-s-add
   CALL s_fin_create_account_center_tmp()                      #展組織下階成員所需之暫存檔 
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_ld_str() RETURNING g_wc_cs_ld
   CALL s_fin_get_wc_str(g_wc_cs_ld)  RETURNING g_wc_cs_ld
   CALL s_axc_get_authcomp() RETURNING g_wc_cs_comp            #抓取使用者有拜訪權限據點的對應法人  
   #161108-00037#2-e-add
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT xcfacomp,'',xcfa001,xcfald,'',xcfa002,xcfa003,xcfa004,xcfa005,xcfa006, 
       xcfa007,xcfa008,xcfa009,xcfa011,xcfa012,'','','',xcfa013,xcfa014", 
                      " FROM xcfa_t",
                      " WHERE xcfaent= ? AND xcfald=? AND xcfa001=? AND xcfa002=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axci801_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.xcfacomp,t0.xcfa001,t0.xcfald,t0.xcfa002,t0.xcfa003,t0.xcfa004,t0.xcfa005, 
       t0.xcfa006,t0.xcfa007,t0.xcfa008,t0.xcfa009,t0.xcfa011,t0.xcfa012,t0.xcfa013,t0.xcfa014,t1.ooefl003 , 
       t2.glaal002",
               " FROM xcfa_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.xcfacomp AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN glaal_t t2 ON t2.glaalent="||g_enterprise||" AND t2.glaalld=t0.xcfald AND t2.glaal001='"||g_dlang||"' ",
 
               " WHERE t0.xcfaent = " ||g_enterprise|| " AND t0.xcfald = ? AND t0.xcfa001 = ? AND t0.xcfa002 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axci801_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axci801 WITH FORM cl_ap_formpath("axc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axci801_init()   
 
      #進入選單 Menu (="N")
      CALL axci801_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axci801
      
   END IF 
   
   CLOSE axci801_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axci801.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axci801_init()
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
   LET g_detail_idx_list[2] = 1
   LET g_detail_idx_list[3] = 1
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
   
      CALL cl_set_combo_scc('xcfa003','8042') 
   CALL cl_set_combo_scc('xcfa004','8043') 
   CALL cl_set_combo_scc('xcfa006','8038') 
   CALL cl_set_combo_scc('xcfa007','8039') 
   CALL cl_set_combo_scc('xcfa008','8040') 
   CALL cl_set_combo_scc('xcfa009','8038') 
   CALL cl_set_combo_scc('xcfa012','8044') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
   CALL g_idx_group.addAttribute("'3',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('xcfa013_1','8041')
   CALL cl_set_combo_scc('xcfa013_2','8041')
   CALL cl_set_combo_scc('xcfa013_3','8041')
   CALL cl_set_combo_scc('xcfa014','9980')  #20150512 By dujuan add
   #end add-point
   
   #初始化搜尋條件
   CALL axci801_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="axci801.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION axci801_ui_dialog()
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
 
   
   #action default動作
   #應用 a42 樣板自動產生(Version:3)
   #進入程式時預設執行的動作
   CASE g_actdefault
      WHEN "insert"
         LET g_action_choice="insert"
         LET g_actdefault = ""
         IF cl_auth_chk_act("insert") THEN
            CALL axci801_insert()
            #add-point:ON ACTION insert name="menu.default.insert"
            
            #END add-point
         END IF
 
      #add-point:action default自訂 name="ui_dialog.action_default"
      
      #end add-point
      OTHERWISE
   END CASE
 
 
 
   
   LET lb_first = TRUE
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
   
   WHILE TRUE 
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_xcfa_m.* TO NULL
         CALL g_xcfb_d.clear()
         CALL g_xcfb2_d.clear()
         CALL g_xcfb3_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL axci801_init()
      END IF
   
            
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
    
         DISPLAY ARRAY g_xcfb_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL axci801_idx_chk()
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
               CALL axci801_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_xcfb2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL axci801_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[2] = l_ac
               CALL g_idx_group.addAttribute("'2',",l_ac)
               
               #add-point:page2, before row動作 name="ui_dialog.body2.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_current_page = 2
               #顯示單身筆數
               CALL axci801_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_xcfb3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL axci801_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[3] = l_ac
               CALL g_idx_group.addAttribute("'3',",l_ac)
               
               #add-point:page3, before row動作 name="ui_dialog.body3.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_current_page = 3
               #顯示單身筆數
               CALL axci801_idx_chk()
               #add-point:page3自定義行為 name="ui_dialog.body3.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
         
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
 
         #end add-point
         
      
         BEFORE DIALOG
            #先填充browser資料
            CALL axci801_browser_fill("")
            CALL cl_notice()
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_sw = FALSE
            #回歸舊筆數位置 (回到當時異動的筆數)
            
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
               CALL axci801_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL axci801_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL axci801_idx_chk()
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
               INITIALIZE g_wc2_table2 TO NULL
 
               INITIALIZE g_wc2_table3 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "xcfa_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "xcfb_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "xcfc_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "xcfd_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
                  OR NOT cl_null(g_wc2_table2)
 
                  OR NOT cl_null(g_wc2_table3)
 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  #組合g_wc2
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
                  IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
                  END IF
 
                  IF g_wc2_table3 <> " 1=1" AND NOT cl_null(g_wc2_table3) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
 
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
               END IF
               CALL axci801_browser_fill("F")   #browser_fill()會將notice區塊清空
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
               INITIALIZE g_wc2_table2 TO NULL
 
               INITIALIZE g_wc2_table3 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "xcfa_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "xcfb_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "xcfc_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "xcfd_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1)
                  OR NOT cl_null(g_wc2_table2)
 
                  OR NOT cl_null(g_wc2_table3)
 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
                  IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
                  END IF
 
                  IF g_wc2_table3 <> " 1=1" AND NOT cl_null(g_wc2_table3) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL axci801_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL axci801_fetch("F")
                  END IF
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
          
         
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL axci801_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axci801_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL axci801_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axci801_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL axci801_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axci801_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL axci801_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axci801_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL axci801_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axci801_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_xcfb_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_xcfb2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_xcfb3_d)
                  LET g_export_id[3]   = "s_detail3"
 
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
               CALL axci801_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL axci801_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL axci801_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL axci801_insert()
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
               CALL axci801_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axci801_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
 
 
 
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL axci801_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL axci801_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL axci801_set_pk_array()
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
 
{<section id="axci801.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION axci801_browser_fill(ps_page_action)
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
      LET l_sub_sql = " SELECT DISTINCT xcfald,xcfa001,xcfa002 ",
                      " FROM xcfa_t ",
                      " ",
                      " LEFT JOIN xcfb_t ON xcfbent = xcfaent AND xcfald = xcfbld AND xcfa001 = xcfb001 AND xcfa002 = xcfb002 ", "  ",
                      #add-point:browser_fill段sql(xcfb_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
                      " LEFT JOIN xcfc_t ON xcfcent = xcfaent AND xcfald = xcfcld AND xcfa001 = xcfc001 AND xcfa002 = xcfc002", "  ",
                      #add-point:browser_fill段sql(xcfc_t1) name="browser_fill.cnt.join.xcfc_t1"
                      
                      #end add-point
 
                      " LEFT JOIN xcfd_t ON xcfdent = xcfaent AND xcfald = xcfdld AND xcfa001 = xcfd001 AND xcfa002 = xcfd002", "  ",
                      #add-point:browser_fill段sql(xcfd_t1) name="browser_fill.cnt.join.xcfd_t1"
                      
                      #end add-point
 
 
 
                      " ", 
                      " ", 
                      " ",                      
 
                      " ",                      
 
 
 
                      " WHERE xcfaent = " ||g_enterprise|| " AND xcfbent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("xcfa_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT xcfald,xcfa001,xcfa002 ",
                      " FROM xcfa_t ", 
                      "  ",
                      "  ",
                      " WHERE xcfaent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("xcfa_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   
   #end add-point
   
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
   
   #add-point:browser_fill,count前 name="browser_fill.before_count"
   #161108-00037#2-s-add
   #---增加帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET l_sub_sql = l_sub_sql ," AND xcfald IN ",g_wc_cs_ld
    END IF
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET l_sub_sql = l_sub_sql ," AND xcfacomp IN ",g_wc_cs_comp
   END IF
   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"
   #161108-00037#2-e-add
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
      INITIALIZE g_xcfa_m.* TO NULL
      CALL g_xcfb_d.clear()        
      CALL g_xcfb2_d.clear() 
      CALL g_xcfb3_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.xcfald,t0.xcfa001,t0.xcfa002 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT '',t0.xcfald,t0.xcfa001,t0.xcfa002 ",
                  " FROM xcfa_t t0",
                  "  ",
                  "  LEFT JOIN xcfb_t ON xcfbent = xcfaent AND xcfald = xcfbld AND xcfa001 = xcfb001 AND xcfa002 = xcfb002 ", "  ", 
                  #add-point:browser_fill段sql(xcfb_t1) name="browser_fill.join.xcfb_t1"
                  
                  #end add-point
                  "  LEFT JOIN xcfc_t ON xcfcent = xcfaent AND xcfald = xcfcld AND xcfa001 = xcfc001 AND xcfa002 = xcfc002", "  ", 
                  #add-point:browser_fill段sql(xcfc_t1) name="browser_fill.join.xcfc_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN xcfd_t ON xcfdent = xcfaent AND xcfald = xcfdld AND xcfa001 = xcfd001 AND xcfa002 = xcfd002", "  ", 
                  #add-point:browser_fill段sql(xcfd_t1) name="browser_fill.join.xcfd_t1"
                  
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
                  " ",                      
 
 
 
                  
                  " WHERE t0.xcfaent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("xcfa_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT '',t0.xcfald,t0.xcfa001,t0.xcfa002 ",
                  " FROM xcfa_t t0",
                  "  ",
                  
                  " WHERE t0.xcfaent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("xcfa_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   #161108-00037#2-s-add
   #---增加帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET g_sql = g_sql ," AND xcfald IN ",g_wc_cs_ld
    END IF
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET g_sql = g_sql ," AND xcfacomp IN ",g_wc_cs_comp
   END IF
   #161108-00037#2-e-add
   #end add-point
   LET g_sql = g_sql, " ORDER BY xcfald,xcfa001,xcfa002 ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"xcfa_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_xcfald,g_browser[g_cnt].b_xcfa001, 
          g_browser[g_cnt].b_xcfa002
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
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
   
   IF cl_null(g_browser[g_cnt].b_xcfald) THEN
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
 
{<section id="axci801.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION axci801_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_xcfa_m.xcfald = g_browser[g_current_idx].b_xcfald   
   LET g_xcfa_m.xcfa001 = g_browser[g_current_idx].b_xcfa001   
   LET g_xcfa_m.xcfa002 = g_browser[g_current_idx].b_xcfa002   
 
   EXECUTE axci801_master_referesh USING g_xcfa_m.xcfald,g_xcfa_m.xcfa001,g_xcfa_m.xcfa002 INTO g_xcfa_m.xcfacomp, 
       g_xcfa_m.xcfa001,g_xcfa_m.xcfald,g_xcfa_m.xcfa002,g_xcfa_m.xcfa003,g_xcfa_m.xcfa004,g_xcfa_m.xcfa005, 
       g_xcfa_m.xcfa006,g_xcfa_m.xcfa007,g_xcfa_m.xcfa008,g_xcfa_m.xcfa009,g_xcfa_m.xcfa011,g_xcfa_m.xcfa012, 
       g_xcfa_m.xcfa013,g_xcfa_m.xcfa014,g_xcfa_m.xcfacomp_desc,g_xcfa_m.xcfald_desc
   
   CALL axci801_xcfa_t_mask()
   CALL axci801_show()
      
END FUNCTION
 
{</section>}
 
{<section id="axci801.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION axci801_ui_detailshow()
   #add-point:ui_detailshow段define(客製用) name="ui_detailshow.define_customerization"
   
   #end add-point    
   #add-point:ui_detailshow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
 
   #add-point:Function前置處理 name="ui_detailshow.before"
   
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axci801.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION axci801_ui_browser_refresh()
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
      IF g_browser[l_i].b_xcfald = g_xcfa_m.xcfald 
         AND g_browser[l_i].b_xcfa001 = g_xcfa_m.xcfa001 
         AND g_browser[l_i].b_xcfa002 = g_xcfa_m.xcfa002 
 
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
 
{<section id="axci801.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION axci801_construct()
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
   INITIALIZE g_xcfa_m.* TO NULL
   CALL g_xcfb_d.clear()        
   CALL g_xcfb2_d.clear() 
   CALL g_xcfb3_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
 
   INITIALIZE g_wc2_table3 TO NULL
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON xcfacomp,xcfa001,xcfald,xcfa002,xcfa003,xcfa004,xcfa005,xcfa006,xcfa007, 
          xcfa008,xcfa009,xcfa011,xcfa012,xcfa013_1,xcfa013_2,xcfa013_3,xcfa013,xcfa014
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.xcfacomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfacomp
            #add-point:ON ACTION controlp INFIELD xcfacomp name="construct.c.xcfacomp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #161108-00037#2-s-add
      	   #增加法人過濾條件
            IF NOT cl_null(g_wc_cs_comp) THEN
               LET g_qryparam.where = " ooef001 IN ",g_wc_cs_comp
            END IF
            #161108-00037#2-e-add
            CALL q_ooef001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcfacomp  #顯示到畫面上
            NEXT FIELD xcfacomp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfacomp
            #add-point:BEFORE FIELD xcfacomp name="construct.b.xcfacomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfacomp
            
            #add-point:AFTER FIELD xcfacomp name="construct.a.xcfacomp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfa001
            #add-point:BEFORE FIELD xcfa001 name="construct.b.xcfa001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfa001
            
            #add-point:AFTER FIELD xcfa001 name="construct.a.xcfa001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcfa001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfa001
            #add-point:ON ACTION controlp INFIELD xcfa001 name="construct.c.xcfa001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xcfald
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfald
            #add-point:ON ACTION controlp INFIELD xcfald name="construct.c.xcfald"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            #161108-00037#2-s-add
            #增加帳套權限控制
            IF NOT cl_null(g_wc_cs_ld) THEN
               LET g_qryparam.where = " glaald IN ",g_wc_cs_ld
            END IF
            #161108-00037#2-e-add
            CALL q_authorised_ld()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcfald  #顯示到畫面上
            NEXT FIELD xcfald                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfald
            #add-point:BEFORE FIELD xcfald name="construct.b.xcfald"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfald
            
            #add-point:AFTER FIELD xcfald name="construct.a.xcfald"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfa002
            #add-point:BEFORE FIELD xcfa002 name="construct.b.xcfa002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfa002
            
            #add-point:AFTER FIELD xcfa002 name="construct.a.xcfa002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcfa002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfa002
            #add-point:ON ACTION controlp INFIELD xcfa002 name="construct.c.xcfa002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfa003
            #add-point:BEFORE FIELD xcfa003 name="construct.b.xcfa003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfa003
            
            #add-point:AFTER FIELD xcfa003 name="construct.a.xcfa003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcfa003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfa003
            #add-point:ON ACTION controlp INFIELD xcfa003 name="construct.c.xcfa003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfa004
            #add-point:BEFORE FIELD xcfa004 name="construct.b.xcfa004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfa004
            
            #add-point:AFTER FIELD xcfa004 name="construct.a.xcfa004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcfa004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfa004
            #add-point:ON ACTION controlp INFIELD xcfa004 name="construct.c.xcfa004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfa005
            #add-point:BEFORE FIELD xcfa005 name="construct.b.xcfa005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfa005
            
            #add-point:AFTER FIELD xcfa005 name="construct.a.xcfa005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcfa005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfa005
            #add-point:ON ACTION controlp INFIELD xcfa005 name="construct.c.xcfa005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfa006
            #add-point:BEFORE FIELD xcfa006 name="construct.b.xcfa006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfa006
            
            #add-point:AFTER FIELD xcfa006 name="construct.a.xcfa006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcfa006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfa006
            #add-point:ON ACTION controlp INFIELD xcfa006 name="construct.c.xcfa006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfa007
            #add-point:BEFORE FIELD xcfa007 name="construct.b.xcfa007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfa007
            
            #add-point:AFTER FIELD xcfa007 name="construct.a.xcfa007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcfa007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfa007
            #add-point:ON ACTION controlp INFIELD xcfa007 name="construct.c.xcfa007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfa008
            #add-point:BEFORE FIELD xcfa008 name="construct.b.xcfa008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfa008
            
            #add-point:AFTER FIELD xcfa008 name="construct.a.xcfa008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcfa008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfa008
            #add-point:ON ACTION controlp INFIELD xcfa008 name="construct.c.xcfa008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfa009
            #add-point:BEFORE FIELD xcfa009 name="construct.b.xcfa009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfa009
            
            #add-point:AFTER FIELD xcfa009 name="construct.a.xcfa009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcfa009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfa009
            #add-point:ON ACTION controlp INFIELD xcfa009 name="construct.c.xcfa009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfa011
            #add-point:BEFORE FIELD xcfa011 name="construct.b.xcfa011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfa011
            
            #add-point:AFTER FIELD xcfa011 name="construct.a.xcfa011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcfa011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfa011
            #add-point:ON ACTION controlp INFIELD xcfa011 name="construct.c.xcfa011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfa012
            #add-point:BEFORE FIELD xcfa012 name="construct.b.xcfa012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfa012
            
            #add-point:AFTER FIELD xcfa012 name="construct.a.xcfa012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcfa012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfa012
            #add-point:ON ACTION controlp INFIELD xcfa012 name="construct.c.xcfa012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfa013_1
            #add-point:BEFORE FIELD xcfa013_1 name="construct.b.xcfa013_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfa013_1
            
            #add-point:AFTER FIELD xcfa013_1 name="construct.a.xcfa013_1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcfa013_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfa013_1
            #add-point:ON ACTION controlp INFIELD xcfa013_1 name="construct.c.xcfa013_1"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfa013_2
            #add-point:BEFORE FIELD xcfa013_2 name="construct.b.xcfa013_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfa013_2
            
            #add-point:AFTER FIELD xcfa013_2 name="construct.a.xcfa013_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcfa013_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfa013_2
            #add-point:ON ACTION controlp INFIELD xcfa013_2 name="construct.c.xcfa013_2"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfa013_3
            #add-point:BEFORE FIELD xcfa013_3 name="construct.b.xcfa013_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfa013_3
            
            #add-point:AFTER FIELD xcfa013_3 name="construct.a.xcfa013_3"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcfa013_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfa013_3
            #add-point:ON ACTION controlp INFIELD xcfa013_3 name="construct.c.xcfa013_3"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfa013
            #add-point:BEFORE FIELD xcfa013 name="construct.b.xcfa013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfa013
            
            #add-point:AFTER FIELD xcfa013 name="construct.a.xcfa013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcfa013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfa013
            #add-point:ON ACTION controlp INFIELD xcfa013 name="construct.c.xcfa013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfa014
            #add-point:BEFORE FIELD xcfa014 name="construct.b.xcfa014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfa014
            
            #add-point:AFTER FIELD xcfa014 name="construct.a.xcfa014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcfa014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfa014
            #add-point:ON ACTION controlp INFIELD xcfa014 name="construct.c.xcfa014"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON xcfbseq,xcfb010,xcfb011,xcfb012,xcfb014,xcfb013,xcfbcomp
           FROM s_detail1[1].xcfbseq,s_detail1[1].xcfb010,s_detail1[1].xcfb011,s_detail1[1].xcfb012, 
               s_detail1[1].xcfb014,s_detail1[1].xcfb013,s_detail1[1].xcfbcomp
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfbseq
            #add-point:BEFORE FIELD xcfbseq name="construct.b.page1.xcfbseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfbseq
            
            #add-point:AFTER FIELD xcfbseq name="construct.a.page1.xcfbseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcfbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfbseq
            #add-point:ON ACTION controlp INFIELD xcfbseq name="construct.c.page1.xcfbseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xcfb010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfb010
            #add-point:ON ACTION controlp INFIELD xcfb010 name="construct.c.page1.xcfb010"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "201" #140918
            CALL q_oocq002_02()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcfb010  #顯示到畫面上
            NEXT FIELD xcfb010                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfb010
            #add-point:BEFORE FIELD xcfb010 name="construct.b.page1.xcfb010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfb010
            
            #add-point:AFTER FIELD xcfb010 name="construct.a.page1.xcfb010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcfb011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfb011
            #add-point:ON ACTION controlp INFIELD xcfb011 name="construct.c.page1.xcfb011"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcfb011  #顯示到畫面上
            NEXT FIELD xcfb011                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfb011
            #add-point:BEFORE FIELD xcfb011 name="construct.b.page1.xcfb011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfb011
            
            #add-point:AFTER FIELD xcfb011 name="construct.a.page1.xcfb011"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfb012
            #add-point:BEFORE FIELD xcfb012 name="construct.b.page1.xcfb012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfb012
            
            #add-point:AFTER FIELD xcfb012 name="construct.a.page1.xcfb012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcfb012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfb012
            #add-point:ON ACTION controlp INFIELD xcfb012 name="construct.c.page1.xcfb012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfb014
            #add-point:BEFORE FIELD xcfb014 name="construct.b.page1.xcfb014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfb014
            
            #add-point:AFTER FIELD xcfb014 name="construct.a.page1.xcfb014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcfb014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfb014
            #add-point:ON ACTION controlp INFIELD xcfb014 name="construct.c.page1.xcfb014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfb013
            #add-point:BEFORE FIELD xcfb013 name="construct.b.page1.xcfb013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfb013
            
            #add-point:AFTER FIELD xcfb013 name="construct.a.page1.xcfb013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcfb013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfb013
            #add-point:ON ACTION controlp INFIELD xcfb013 name="construct.c.page1.xcfb013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfbcomp
            #add-point:BEFORE FIELD xcfbcomp name="construct.b.page1.xcfbcomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfbcomp
            
            #add-point:AFTER FIELD xcfbcomp name="construct.a.page1.xcfbcomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcfbcomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfbcomp
            #add-point:ON ACTION controlp INFIELD xcfbcomp name="construct.c.page1.xcfbcomp"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON xcfcseq,xcfc013,xcfc010,xcfc011,xcfc012,xcfccomp
           FROM s_detail2[1].xcfcseq,s_detail2[1].xcfc013,s_detail2[1].xcfc010,s_detail2[1].xcfc011, 
               s_detail2[1].xcfc012,s_detail2[1].xcfccomp
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfcseq
            #add-point:BEFORE FIELD xcfcseq name="construct.b.page2.xcfcseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfcseq
            
            #add-point:AFTER FIELD xcfcseq name="construct.a.page2.xcfcseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xcfcseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfcseq
            #add-point:ON ACTION controlp INFIELD xcfcseq name="construct.c.page2.xcfcseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfc013
            #add-point:BEFORE FIELD xcfc013 name="construct.b.page2.xcfc013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfc013
            
            #add-point:AFTER FIELD xcfc013 name="construct.a.page2.xcfc013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xcfc013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfc013
            #add-point:ON ACTION controlp INFIELD xcfc013 name="construct.c.page2.xcfc013"
           #161108-00037#6-s-add 
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "201" 
            CALL q_oocq002_02()         
            DISPLAY g_qryparam.return1 TO xcfc013  
            NEXT FIELD xcfc013  
           #161108-00037#6-e-add            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfc010
            #add-point:BEFORE FIELD xcfc010 name="construct.b.page2.xcfc010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfc010
            
            #add-point:AFTER FIELD xcfc010 name="construct.a.page2.xcfc010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xcfc010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfc010
            #add-point:ON ACTION controlp INFIELD xcfc010 name="construct.c.page2.xcfc010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfc011
            #add-point:BEFORE FIELD xcfc011 name="construct.b.page2.xcfc011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfc011
            
            #add-point:AFTER FIELD xcfc011 name="construct.a.page2.xcfc011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xcfc011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfc011
            #add-point:ON ACTION controlp INFIELD xcfc011 name="construct.c.page2.xcfc011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfc012
            #add-point:BEFORE FIELD xcfc012 name="construct.b.page2.xcfc012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfc012
            
            #add-point:AFTER FIELD xcfc012 name="construct.a.page2.xcfc012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xcfc012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfc012
            #add-point:ON ACTION controlp INFIELD xcfc012 name="construct.c.page2.xcfc012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfccomp
            #add-point:BEFORE FIELD xcfccomp name="construct.b.page2.xcfccomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfccomp
            
            #add-point:AFTER FIELD xcfccomp name="construct.a.page2.xcfccomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xcfccomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfccomp
            #add-point:ON ACTION controlp INFIELD xcfccomp name="construct.c.page2.xcfccomp"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table3 ON xcfdseq,xcfd010,xcfdcomp
           FROM s_detail3[1].xcfdseq,s_detail3[1].xcfd010,s_detail3[1].xcfdcomp
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body3.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 3)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfdseq
            #add-point:BEFORE FIELD xcfdseq name="construct.b.page3.xcfdseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfdseq
            
            #add-point:AFTER FIELD xcfdseq name="construct.a.page3.xcfdseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xcfdseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfdseq
            #add-point:ON ACTION controlp INFIELD xcfdseq name="construct.c.page3.xcfdseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.xcfd010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfd010
            #add-point:ON ACTION controlp INFIELD xcfd010 name="construct.c.page3.xcfd010"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcfd010  #顯示到畫面上
            NEXT FIELD xcfd010                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfd010
            #add-point:BEFORE FIELD xcfd010 name="construct.b.page3.xcfd010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfd010
            
            #add-point:AFTER FIELD xcfd010 name="construct.a.page3.xcfd010"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfdcomp
            #add-point:BEFORE FIELD xcfdcomp name="construct.b.page3.xcfdcomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfdcomp
            
            #add-point:AFTER FIELD xcfdcomp name="construct.a.page3.xcfdcomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xcfdcomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfdcomp
            #add-point:ON ACTION controlp INFIELD xcfdcomp name="construct.c.page3.xcfdcomp"
            
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
            INITIALIZE g_wc2_table2 TO NULL
 
            INITIALIZE g_wc2_table3 TO NULL
 
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "xcfa_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "xcfb_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "xcfc_t" 
                     LET g_wc2_table2 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "xcfd_t" 
                     LET g_wc2_table3 = la_wc[li_idx].wc
 
 
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
   IF g_wc2_table2 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
   END IF
 
   IF g_wc2_table3 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
   END IF
 
 
 
 
   
   #add-point:cs段結束前 name="cs.after_construct"
   LET g_wc = cl_replace_str(g_wc,"xcfa013_1","xcfa013[1,1]") 
   LET g_wc = cl_replace_str(g_wc,"xcfa013_2","xcfa013[2,2]") 
   LET g_wc = cl_replace_str(g_wc,"xcfa013_3","xcfa013[3,3]") 
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="axci801.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION axci801_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point   
   DEFINE ls_wc STRING
   #add-point:query段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="query.pre_function"
   
   #end add-point
   
   #切換畫面
   
   LET ls_wc = g_wc
   
   LET INT_FLAG = 0
   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   ERROR ""
   
   #清除畫面及相關資料
   CLEAR FORM
   CALL g_browser.clear()       
   CALL g_xcfb_d.clear()
   CALL g_xcfb2_d.clear()
   CALL g_xcfb3_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL axci801_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL axci801_browser_fill("")
      CALL axci801_fetch("")
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
   LET g_detail_idx_list[2] = 1
   LET g_detail_idx_list[3] = 1
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
   CALL axci801_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL axci801_fetch("F") 
      #顯示單身筆數
      CALL axci801_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="axci801.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION axci801_fetch(p_flag)
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
   LET g_pagestart = g_current_idx
   DISPLAY g_pagestart TO FORMONLY.b_index   #當下筆數
   DISPLAY g_pagestart TO FORMONLY.h_index   #當下筆數
   
   CALL cl_navigator_setting( g_pagestart, g_browser_cnt )
 
   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF
   
   #避免超出browser資料筆數上限
   IF g_current_idx > g_browser.getLength() THEN
      LET g_browser_idx = g_browser.getLength()
      LET g_current_idx = g_browser.getLength()
   END IF
   
   LET g_xcfa_m.xcfald = g_browser[g_current_idx].b_xcfald
   LET g_xcfa_m.xcfa001 = g_browser[g_current_idx].b_xcfa001
   LET g_xcfa_m.xcfa002 = g_browser[g_current_idx].b_xcfa002
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE axci801_master_referesh USING g_xcfa_m.xcfald,g_xcfa_m.xcfa001,g_xcfa_m.xcfa002 INTO g_xcfa_m.xcfacomp, 
       g_xcfa_m.xcfa001,g_xcfa_m.xcfald,g_xcfa_m.xcfa002,g_xcfa_m.xcfa003,g_xcfa_m.xcfa004,g_xcfa_m.xcfa005, 
       g_xcfa_m.xcfa006,g_xcfa_m.xcfa007,g_xcfa_m.xcfa008,g_xcfa_m.xcfa009,g_xcfa_m.xcfa011,g_xcfa_m.xcfa012, 
       g_xcfa_m.xcfa013,g_xcfa_m.xcfa014,g_xcfa_m.xcfacomp_desc,g_xcfa_m.xcfald_desc
   
   #遮罩相關處理
   LET g_xcfa_m_mask_o.* =  g_xcfa_m.*
   CALL axci801_xcfa_t_mask()
   LET g_xcfa_m_mask_n.* =  g_xcfa_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL axci801_set_act_visible()   
   CALL axci801_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   LET g_xcfa_m.xcfa013_1 = g_xcfa_m.xcfa013[1,1]
   LET g_xcfa_m.xcfa013_2 = g_xcfa_m.xcfa013[2,2]
   LET g_xcfa_m.xcfa013_3 = g_xcfa_m.xcfa013[3,3]
   
   #end add-point
   
   #保存單頭舊值
   LET g_xcfa_m_t.* = g_xcfa_m.*
   LET g_xcfa_m_o.* = g_xcfa_m.*
   
   
   #重新顯示   
   CALL axci801_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="axci801.insert" >}
#+ 資料新增
PRIVATE FUNCTION axci801_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_xcfb_d.clear()   
   CALL g_xcfb2_d.clear()  
   CALL g_xcfb3_d.clear()  
 
 
   INITIALIZE g_xcfa_m.* TO NULL             #DEFAULT 設定
   
   LET g_xcfald_t = NULL
   LET g_xcfa001_t = NULL
   LET g_xcfa002_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_xcfa_m.xcfa003 = "1"
      LET g_xcfa_m.xcfa004 = "1"
      LET g_xcfa_m.xcfa005 = "Y"
      LET g_xcfa_m.xcfa006 = "1"
      LET g_xcfa_m.xcfa007 = "1"
      LET g_xcfa_m.xcfa008 = "3"
      LET g_xcfa_m.xcfa009 = "1"
      LET g_xcfa_m.xcfa011 = "Y"
      LET g_xcfa_m.xcfa012 = "1"
      LET g_xcfa_m.xcfa013_1 = "1"
      LET g_xcfa_m.xcfa013_2 = "2"
      LET g_xcfa_m.xcfa013_3 = "3"
      LET g_xcfa_m.xcfa014 = "1"
 
  
      #add-point:單頭預設值 name="insert.default"
      LET g_xcfa_m.xcfa014 = "1"  #货龄计算顺序默认值 20150529 By dujuan 
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_xcfa_m_t.* = g_xcfa_m.*
      LET g_xcfa_m_o.* = g_xcfa_m.*
      
      #顯示狀態(stus)圖片
      
    
      CALL axci801_input("a")
      
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
         INITIALIZE g_xcfa_m.* TO NULL
         INITIALIZE g_xcfb_d TO NULL
         INITIALIZE g_xcfb2_d TO NULL
         INITIALIZE g_xcfb3_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL axci801_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_xcfb_d.clear()
      #CALL g_xcfb2_d.clear()
      #CALL g_xcfb3_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL axci801_set_act_visible()   
   CALL axci801_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_xcfald_t = g_xcfa_m.xcfald
   LET g_xcfa001_t = g_xcfa_m.xcfa001
   LET g_xcfa002_t = g_xcfa_m.xcfa002
 
   
   #組合新增資料的條件
   LET g_add_browse = " xcfaent = " ||g_enterprise|| " AND",
                      " xcfald = '", g_xcfa_m.xcfald, "' "
                      ," AND xcfa001 = '", g_xcfa_m.xcfa001, "' "
                      ," AND xcfa002 = '", g_xcfa_m.xcfa002, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axci801_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE axci801_cl
   
   CALL axci801_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE axci801_master_referesh USING g_xcfa_m.xcfald,g_xcfa_m.xcfa001,g_xcfa_m.xcfa002 INTO g_xcfa_m.xcfacomp, 
       g_xcfa_m.xcfa001,g_xcfa_m.xcfald,g_xcfa_m.xcfa002,g_xcfa_m.xcfa003,g_xcfa_m.xcfa004,g_xcfa_m.xcfa005, 
       g_xcfa_m.xcfa006,g_xcfa_m.xcfa007,g_xcfa_m.xcfa008,g_xcfa_m.xcfa009,g_xcfa_m.xcfa011,g_xcfa_m.xcfa012, 
       g_xcfa_m.xcfa013,g_xcfa_m.xcfa014,g_xcfa_m.xcfacomp_desc,g_xcfa_m.xcfald_desc
   
   
   #遮罩相關處理
   LET g_xcfa_m_mask_o.* =  g_xcfa_m.*
   CALL axci801_xcfa_t_mask()
   LET g_xcfa_m_mask_n.* =  g_xcfa_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_xcfa_m.xcfacomp,g_xcfa_m.xcfacomp_desc,g_xcfa_m.xcfa001,g_xcfa_m.xcfald,g_xcfa_m.xcfald_desc, 
       g_xcfa_m.xcfa002,g_xcfa_m.xcfa003,g_xcfa_m.xcfa004,g_xcfa_m.xcfa005,g_xcfa_m.xcfa006,g_xcfa_m.xcfa007, 
       g_xcfa_m.xcfa008,g_xcfa_m.xcfa009,g_xcfa_m.xcfa011,g_xcfa_m.xcfa012,g_xcfa_m.xcfa013_1,g_xcfa_m.xcfa013_2, 
       g_xcfa_m.xcfa013_3,g_xcfa_m.xcfa013,g_xcfa_m.xcfa014
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   
   #功能已完成,通報訊息中心
   CALL axci801_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="axci801.modify" >}
#+ 資料修改
PRIVATE FUNCTION axci801_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
   DEFINE l_wc2_table2   STRING
 
   DEFINE l_wc2_table3   STRING
 
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_xcfa_m_t.* = g_xcfa_m.*
   LET g_xcfa_m_o.* = g_xcfa_m.*
   
   IF g_xcfa_m.xcfald IS NULL
   OR g_xcfa_m.xcfa001 IS NULL
   OR g_xcfa_m.xcfa002 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_xcfald_t = g_xcfa_m.xcfald
   LET g_xcfa001_t = g_xcfa_m.xcfa001
   LET g_xcfa002_t = g_xcfa_m.xcfa002
 
   CALL s_transaction_begin()
   
   OPEN axci801_cl USING g_enterprise,g_xcfa_m.xcfald,g_xcfa_m.xcfa001,g_xcfa_m.xcfa002
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axci801_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE axci801_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axci801_master_referesh USING g_xcfa_m.xcfald,g_xcfa_m.xcfa001,g_xcfa_m.xcfa002 INTO g_xcfa_m.xcfacomp, 
       g_xcfa_m.xcfa001,g_xcfa_m.xcfald,g_xcfa_m.xcfa002,g_xcfa_m.xcfa003,g_xcfa_m.xcfa004,g_xcfa_m.xcfa005, 
       g_xcfa_m.xcfa006,g_xcfa_m.xcfa007,g_xcfa_m.xcfa008,g_xcfa_m.xcfa009,g_xcfa_m.xcfa011,g_xcfa_m.xcfa012, 
       g_xcfa_m.xcfa013,g_xcfa_m.xcfa014,g_xcfa_m.xcfacomp_desc,g_xcfa_m.xcfald_desc
   
   #檢查是否允許此動作
   IF NOT axci801_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_xcfa_m_mask_o.* =  g_xcfa_m.*
   CALL axci801_xcfa_t_mask()
   LET g_xcfa_m_mask_n.* =  g_xcfa_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
   #LET l_wc2_table3 = g_wc2_table3
   #LET l_wc2_table3 = " 1=1"
 
 
 
   
   CALL axci801_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
   #LET  g_wc2_table3 = l_wc2_table3 
 
 
 
    
   WHILE TRUE
      LET g_xcfald_t = g_xcfa_m.xcfald
      LET g_xcfa001_t = g_xcfa_m.xcfa001
      LET g_xcfa002_t = g_xcfa_m.xcfa002
 
      
      #寫入修改者/修改日期資訊(單頭)
      
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL axci801_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
 
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_xcfa_m.* = g_xcfa_m_t.*
            CALL axci801_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_xcfa_m.xcfald != g_xcfa_m_t.xcfald
      OR g_xcfa_m.xcfa001 != g_xcfa_m_t.xcfa001
      OR g_xcfa_m.xcfa002 != g_xcfa_m_t.xcfa002
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE xcfb_t SET xcfbld = g_xcfa_m.xcfald
                                       ,xcfb001 = g_xcfa_m.xcfa001
                                       ,xcfb002 = g_xcfa_m.xcfa002
 
          WHERE xcfbent = g_enterprise AND xcfbld = g_xcfa_m_t.xcfald
            AND xcfb001 = g_xcfa_m_t.xcfa001
            AND xcfb002 = g_xcfa_m_t.xcfa002
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "xcfb_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xcfb_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         
         #add-point:單身fk修改後 name="modify.body.a_fk_update"
         
         #end add-point
         
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update2"
         
         #end add-point
         
         UPDATE xcfc_t
            SET xcfcld = g_xcfa_m.xcfald
               ,xcfc001 = g_xcfa_m.xcfa001
               ,xcfc002 = g_xcfa_m.xcfa002
 
          WHERE xcfcent = g_enterprise AND
                xcfcld = g_xcfald_t
            AND xcfc001 = g_xcfa001_t
            AND xcfc002 = g_xcfa002_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "xcfc_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xcfc_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update2"
         
         #end add-point
 
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update3"
         
         #end add-point
         
         UPDATE xcfd_t
            SET xcfdld = g_xcfa_m.xcfald
               ,xcfd001 = g_xcfa_m.xcfa001
               ,xcfd002 = g_xcfa_m.xcfa002
 
          WHERE xcfdent = g_enterprise AND
                xcfdld = g_xcfald_t
            AND xcfd001 = g_xcfa001_t
            AND xcfd002 = g_xcfa002_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update3"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "xcfd_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xcfd_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update3"
         
         #end add-point
 
 
         
 
         
         #UPDATE 多語言table key值
         
         
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL axci801_set_act_visible()   
   CALL axci801_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " xcfaent = " ||g_enterprise|| " AND",
                      " xcfald = '", g_xcfa_m.xcfald, "' "
                      ," AND xcfa001 = '", g_xcfa_m.xcfa001, "' "
                      ," AND xcfa002 = '", g_xcfa_m.xcfa002, "' "
 
   #填到對應位置
   CALL axci801_browser_fill("")
 
   CLOSE axci801_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL axci801_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="axci801.input" >}
#+ 資料輸入
PRIVATE FUNCTION axci801_input(p_cmd)
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
   DEFINE l_a                    LIKE type_t.num5
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
   DISPLAY BY NAME g_xcfa_m.xcfacomp,g_xcfa_m.xcfacomp_desc,g_xcfa_m.xcfa001,g_xcfa_m.xcfald,g_xcfa_m.xcfald_desc, 
       g_xcfa_m.xcfa002,g_xcfa_m.xcfa003,g_xcfa_m.xcfa004,g_xcfa_m.xcfa005,g_xcfa_m.xcfa006,g_xcfa_m.xcfa007, 
       g_xcfa_m.xcfa008,g_xcfa_m.xcfa009,g_xcfa_m.xcfa011,g_xcfa_m.xcfa012,g_xcfa_m.xcfa013_1,g_xcfa_m.xcfa013_2, 
       g_xcfa_m.xcfa013_3,g_xcfa_m.xcfa013,g_xcfa_m.xcfa014
   
   #切換畫面
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql name="input.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT xcfbseq,xcfb010,xcfb011,xcfb012,xcfb014,xcfb013,xcfbcomp FROM xcfb_t WHERE  
       xcfbent=? AND xcfbld=? AND xcfb001=? AND xcfb002=? AND xcfbseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axci801_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point    
   LET g_forupd_sql = "SELECT xcfcseq,xcfc013,xcfc010,xcfc011,xcfc012,xcfccomp FROM xcfc_t WHERE xcfcent=?  
       AND xcfcld=? AND xcfc001=? AND xcfc002=? AND xcfcseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axci801_bcl2 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql3"
   
   #end add-point    
   LET g_forupd_sql = "SELECT xcfdseq,xcfd010,xcfdcomp FROM xcfd_t WHERE xcfdent=? AND xcfdld=? AND  
       xcfd001=? AND xcfd002=? AND xcfdseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql3"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axci801_bcl3 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL axci801_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL axci801_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_xcfa_m.xcfacomp,g_xcfa_m.xcfa001,g_xcfa_m.xcfald,g_xcfa_m.xcfa002,g_xcfa_m.xcfa003, 
       g_xcfa_m.xcfa004,g_xcfa_m.xcfa005,g_xcfa_m.xcfa006,g_xcfa_m.xcfa007,g_xcfa_m.xcfa008,g_xcfa_m.xcfa009, 
       g_xcfa_m.xcfa011,g_xcfa_m.xcfa012,g_xcfa_m.xcfa013_1,g_xcfa_m.xcfa013_2,g_xcfa_m.xcfa013_3,g_xcfa_m.xcfa013, 
       g_xcfa_m.xcfa014
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="axci801.input.head" >}
      #單頭段
      INPUT BY NAME g_xcfa_m.xcfacomp,g_xcfa_m.xcfa001,g_xcfa_m.xcfald,g_xcfa_m.xcfa002,g_xcfa_m.xcfa003, 
          g_xcfa_m.xcfa004,g_xcfa_m.xcfa005,g_xcfa_m.xcfa006,g_xcfa_m.xcfa007,g_xcfa_m.xcfa008,g_xcfa_m.xcfa009, 
          g_xcfa_m.xcfa011,g_xcfa_m.xcfa012,g_xcfa_m.xcfa013_1,g_xcfa_m.xcfa013_2,g_xcfa_m.xcfa013_3, 
          g_xcfa_m.xcfa013,g_xcfa_m.xcfa014 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN axci801_cl USING g_enterprise,g_xcfa_m.xcfald,g_xcfa_m.xcfa001,g_xcfa_m.xcfa002
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN axci801_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE axci801_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL axci801_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL axci801_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfacomp
            
            #add-point:AFTER FIELD xcfacomp name="input.a.xcfacomp"
            IF NOT cl_null(g_xcfa_m.xcfacomp) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xcfa_m_t.xcfacomp IS NULL OR g_xcfa_m.xcfacomp != g_xcfa_m_t.xcfacomp)) THEN
                  IF NOT axci801_chk_ld_comp() THEN
                     LET g_xcfa_m.xcfacomp = g_xcfa_m_t.xcfacomp
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcfa_m.xcfacomp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcfa_m.xcfacomp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcfa_m.xcfacomp_desc

            CALL axci801_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfacomp
            #add-point:BEFORE FIELD xcfacomp name="input.b.xcfacomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcfacomp
            #add-point:ON CHANGE xcfacomp name="input.g.xcfacomp"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfa001
            #add-point:BEFORE FIELD xcfa001 name="input.b.xcfa001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfa001
            
            #add-point:AFTER FIELD xcfa001 name="input.a.xcfa001"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF NOT cl_null(g_xcfa_m.xcfa001) THEN
               IF p_cmd ='a' OR (p_cmd ='u' AND (g_xcfa_m_t.xcfa001 IS NULL OR g_xcfa_m.xcfa001 != g_xcfa_m_t.xcfa001)) THEN
                  IF NOT axci801_chk_year_period() THEN
                     LET g_xcfa_m.xcfa001 = g_xcfa_m_t.xcfa001
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF  NOT cl_null(g_xcfa_m.xcfald) AND NOT cl_null(g_xcfa_m.xcfa001) AND NOT cl_null(g_xcfa_m.xcfa002) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcfa_m.xcfald != g_xcfald_t  OR g_xcfa_m.xcfa001 != g_xcfa001_t  OR g_xcfa_m.xcfa002 != g_xcfa002_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcfa_t WHERE "||"xcfaent = '" ||g_enterprise|| "' AND "||"xcfald = '"||g_xcfa_m.xcfald ||"' AND "|| "xcfa001 = '"||g_xcfa_m.xcfa001 ||"' AND "|| "xcfa002 = '"||g_xcfa_m.xcfa002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcfa001
            #add-point:ON CHANGE xcfa001 name="input.g.xcfa001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfald
            
            #add-point:AFTER FIELD xcfald name="input.a.xcfald"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF NOT cl_null(g_xcfa_m.xcfald) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xcfa_m_t.xcfald IS NULL OR g_xcfa_m.xcfald != g_xcfa_m_t.xcfald)) THEN
                  IF NOT axci801_chk_ld_comp() THEN
                     LET g_xcfa_m.xcfald = g_xcfa_m_t.xcfald
                     NEXT FIELD CURRENT
                  END IF
               END IF 
            END IF
            IF  NOT cl_null(g_xcfa_m.xcfald) AND NOT cl_null(g_xcfa_m.xcfa001) AND NOT cl_null(g_xcfa_m.xcfa002) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcfa_m.xcfald != g_xcfald_t  OR g_xcfa_m.xcfa001 != g_xcfa001_t  OR g_xcfa_m.xcfa002 != g_xcfa002_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcfa_t WHERE "||"xcfaent = '" ||g_enterprise|| "' AND "||"xcfald = '"||g_xcfa_m.xcfald ||"' AND "|| "xcfa001 = '"||g_xcfa_m.xcfa001 ||"' AND "|| "xcfa002 = '"||g_xcfa_m.xcfa002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            CALL axci801_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfald
            #add-point:BEFORE FIELD xcfald name="input.b.xcfald"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcfald
            #add-point:ON CHANGE xcfald name="input.g.xcfald"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfa002
            #add-point:BEFORE FIELD xcfa002 name="input.b.xcfa002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfa002
            
            #add-point:AFTER FIELD xcfa002 name="input.a.xcfa002"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF NOT cl_null(g_xcfa_m.xcfa002) THEN
               IF p_cmd ='a' OR (p_cmd ='u' AND (g_xcfa_m_t.xcfa002 IS NULL OR g_xcfa_m.xcfa002 != g_xcfa_m_t.xcfa002)) THEN
                  IF NOT axci801_chk_year_period() THEN
                     LET g_xcfa_m.xcfa002 = g_xcfa_m_t.xcfa002
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
            IF  NOT cl_null(g_xcfa_m.xcfald) AND NOT cl_null(g_xcfa_m.xcfa001) AND NOT cl_null(g_xcfa_m.xcfa002) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcfa_m.xcfald != g_xcfald_t  OR g_xcfa_m.xcfa001 != g_xcfa001_t  OR g_xcfa_m.xcfa002 != g_xcfa002_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcfa_t WHERE "||"xcfaent = '" ||g_enterprise|| "' AND "||"xcfald = '"||g_xcfa_m.xcfald ||"' AND "|| "xcfa001 = '"||g_xcfa_m.xcfa001 ||"' AND "|| "xcfa002 = '"||g_xcfa_m.xcfa002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcfa002
            #add-point:ON CHANGE xcfa002 name="input.g.xcfa002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfa003
            #add-point:BEFORE FIELD xcfa003 name="input.b.xcfa003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfa003
            
            #add-point:AFTER FIELD xcfa003 name="input.a.xcfa003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcfa003
            #add-point:ON CHANGE xcfa003 name="input.g.xcfa003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfa004
            #add-point:BEFORE FIELD xcfa004 name="input.b.xcfa004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfa004
            
            #add-point:AFTER FIELD xcfa004 name="input.a.xcfa004"
           

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcfa004
            #add-point:ON CHANGE xcfa004 name="input.g.xcfa004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfa005
            #add-point:BEFORE FIELD xcfa005 name="input.b.xcfa005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfa005
            
            #add-point:AFTER FIELD xcfa005 name="input.a.xcfa005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcfa005
            #add-point:ON CHANGE xcfa005 name="input.g.xcfa005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfa006
            #add-point:BEFORE FIELD xcfa006 name="input.b.xcfa006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfa006
            
            #add-point:AFTER FIELD xcfa006 name="input.a.xcfa006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcfa006
            #add-point:ON CHANGE xcfa006 name="input.g.xcfa006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfa007
            #add-point:BEFORE FIELD xcfa007 name="input.b.xcfa007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfa007
            
            #add-point:AFTER FIELD xcfa007 name="input.a.xcfa007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcfa007
            #add-point:ON CHANGE xcfa007 name="input.g.xcfa007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfa008
            #add-point:BEFORE FIELD xcfa008 name="input.b.xcfa008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfa008
            
            #add-point:AFTER FIELD xcfa008 name="input.a.xcfa008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcfa008
            #add-point:ON CHANGE xcfa008 name="input.g.xcfa008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfa009
            #add-point:BEFORE FIELD xcfa009 name="input.b.xcfa009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfa009
            
            #add-point:AFTER FIELD xcfa009 name="input.a.xcfa009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcfa009
            #add-point:ON CHANGE xcfa009 name="input.g.xcfa009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfa011
            #add-point:BEFORE FIELD xcfa011 name="input.b.xcfa011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfa011
            
            #add-point:AFTER FIELD xcfa011 name="input.a.xcfa011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcfa011
            #add-point:ON CHANGE xcfa011 name="input.g.xcfa011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfa012
            #add-point:BEFORE FIELD xcfa012 name="input.b.xcfa012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfa012
            
            #add-point:AFTER FIELD xcfa012 name="input.a.xcfa012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcfa012
            #add-point:ON CHANGE xcfa012 name="input.g.xcfa012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfa013_1
            #add-point:BEFORE FIELD xcfa013_1 name="input.b.xcfa013_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfa013_1
            
            #add-point:AFTER FIELD xcfa013_1 name="input.a.xcfa013_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcfa013_1
            #add-point:ON CHANGE xcfa013_1 name="input.g.xcfa013_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfa013_2
            #add-point:BEFORE FIELD xcfa013_2 name="input.b.xcfa013_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfa013_2
            
            #add-point:AFTER FIELD xcfa013_2 name="input.a.xcfa013_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcfa013_2
            #add-point:ON CHANGE xcfa013_2 name="input.g.xcfa013_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfa013_3
            #add-point:BEFORE FIELD xcfa013_3 name="input.b.xcfa013_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfa013_3
            
            #add-point:AFTER FIELD xcfa013_3 name="input.a.xcfa013_3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcfa013_3
            #add-point:ON CHANGE xcfa013_3 name="input.g.xcfa013_3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfa013
            #add-point:BEFORE FIELD xcfa013 name="input.b.xcfa013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfa013
            
            #add-point:AFTER FIELD xcfa013 name="input.a.xcfa013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcfa013
            #add-point:ON CHANGE xcfa013 name="input.g.xcfa013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfa014
            #add-point:BEFORE FIELD xcfa014 name="input.b.xcfa014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfa014
            
            #add-point:AFTER FIELD xcfa014 name="input.a.xcfa014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcfa014
            #add-point:ON CHANGE xcfa014 name="input.g.xcfa014"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.xcfacomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfacomp
            #add-point:ON ACTION controlp INFIELD xcfacomp name="input.c.xcfacomp"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcfa_m.xcfacomp             #給予default值
            LET g_qryparam.default2 = "" #g_xcfa_m.ooefl003 #說明(簡稱)            
            IF NOT cl_null(g_xcfa_m.xcfald) THEN
               #給予arg
               LET g_qryparam.arg1 = g_xcfa_m.xcfald
               #161108-00037#2-s-add
      	      #增加法人過濾條件
               IF NOT cl_null(g_wc_cs_comp) THEN
                  LET g_qryparam.where = " glaacomp IN ",g_wc_cs_comp
               END IF
               #161108-00037#2-e-add
               CALL q_glaacomp()                #呼叫開窗
            ELSE 
               #161108-00037#2-s-add
      	      #增加法人過濾條件
               IF NOT cl_null(g_wc_cs_comp) THEN
                  LET g_qryparam.where = " ooef001 IN ",g_wc_cs_comp
               END IF
               #161108-00037#2-e-add
               CALL q_ooef001_2()
            END IF
            LET g_xcfa_m.xcfacomp = g_qryparam.return1              
            #LET g_xcfa_m.ooefl003 = g_qryparam.return2 
            DISPLAY g_xcfa_m.xcfacomp TO xcfacomp              #
            #DISPLAY g_xcfa_m.ooefl003 TO ooefl003 #說明(簡稱)
            NEXT FIELD xcfacomp                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xcfa001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfa001
            #add-point:ON ACTION controlp INFIELD xcfa001 name="input.c.xcfa001"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcfald
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfald
            #add-point:ON ACTION controlp INFIELD xcfald name="input.c.xcfald"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcfa_m.xcfald             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            #161108-00037#2-s-add
            #增加帳套權限控制
            IF NOT cl_null(g_wc_cs_ld) THEN
               LET g_qryparam.where = " glaald IN ",g_wc_cs_ld
            END IF
            #161108-00037#2-e-add
            CALL q_authorised_ld()                                #呼叫開窗

            LET g_xcfa_m.xcfald = g_qryparam.return1              

            DISPLAY g_xcfa_m.xcfald TO xcfald              #
            CALL axci801_ref()
            NEXT FIELD xcfald                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xcfa002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfa002
            #add-point:ON ACTION controlp INFIELD xcfa002 name="input.c.xcfa002"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcfa003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfa003
            #add-point:ON ACTION controlp INFIELD xcfa003 name="input.c.xcfa003"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcfa004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfa004
            #add-point:ON ACTION controlp INFIELD xcfa004 name="input.c.xcfa004"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcfa005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfa005
            #add-point:ON ACTION controlp INFIELD xcfa005 name="input.c.xcfa005"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcfa006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfa006
            #add-point:ON ACTION controlp INFIELD xcfa006 name="input.c.xcfa006"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcfa007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfa007
            #add-point:ON ACTION controlp INFIELD xcfa007 name="input.c.xcfa007"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcfa008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfa008
            #add-point:ON ACTION controlp INFIELD xcfa008 name="input.c.xcfa008"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcfa009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfa009
            #add-point:ON ACTION controlp INFIELD xcfa009 name="input.c.xcfa009"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcfa011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfa011
            #add-point:ON ACTION controlp INFIELD xcfa011 name="input.c.xcfa011"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcfa012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfa012
            #add-point:ON ACTION controlp INFIELD xcfa012 name="input.c.xcfa012"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcfa013_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfa013_1
            #add-point:ON ACTION controlp INFIELD xcfa013_1 name="input.c.xcfa013_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcfa013_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfa013_2
            #add-point:ON ACTION controlp INFIELD xcfa013_2 name="input.c.xcfa013_2"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcfa013_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfa013_3
            #add-point:ON ACTION controlp INFIELD xcfa013_3 name="input.c.xcfa013_3"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcfa013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfa013
            #add-point:ON ACTION controlp INFIELD xcfa013 name="input.c.xcfa013"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcfa014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfa014
            #add-point:ON ACTION controlp INFIELD xcfa014 name="input.c.xcfa014"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_xcfa_m.xcfald,g_xcfa_m.xcfa001,g_xcfa_m.xcfa002
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               #140918--begin
               LET g_xcfa013 = g_xcfa_m.xcfa013_1 CLIPPED,g_xcfa_m.xcfa013_2 CLIPPED,g_xcfa_m.xcfa013_3
               IF 1=2 THEN
               #140918--end
               #end add-point
               
               INSERT INTO xcfa_t (xcfaent,xcfacomp,xcfa001,xcfald,xcfa002,xcfa003,xcfa004,xcfa005,xcfa006, 
                   xcfa007,xcfa008,xcfa009,xcfa011,xcfa012,xcfa013,xcfa014)
               VALUES (g_enterprise,g_xcfa_m.xcfacomp,g_xcfa_m.xcfa001,g_xcfa_m.xcfald,g_xcfa_m.xcfa002, 
                   g_xcfa_m.xcfa003,g_xcfa_m.xcfa004,g_xcfa_m.xcfa005,g_xcfa_m.xcfa006,g_xcfa_m.xcfa007, 
                   g_xcfa_m.xcfa008,g_xcfa_m.xcfa009,g_xcfa_m.xcfa011,g_xcfa_m.xcfa012,g_xcfa_m.xcfa013, 
                   g_xcfa_m.xcfa014) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_xcfa_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               #140918----add xcfa013
               ELSE
                  #161108-00037#2-mod-s
#                  INSERT INTO xcfa_t (xcfaent,xcfald,xcfa001,xcfacomp,xcfa002,xcfa003,xcfa004,xcfa005,xcfa006, 
#                      xcfa007,xcfa008,xcfa009,xcfa010,xcfa011,xcfa012,xcfa013,xcfa014) #20150512 By dujuan add  (,xcfa014)
#                  VALUES (g_enterprise,g_xcfa_m.xcfald,g_xcfa_m.xcfa001,g_xcfa_m.xcfacomp,g_xcfa_m.xcfa002, 
#                      g_xcfa_m.xcfa003,g_xcfa_m.xcfa004,g_xcfa_m.xcfa005,g_xcfa_m.xcfa006,g_xcfa_m.xcfa007, 
#                      g_xcfa_m.xcfa008,g_xcfa_m.xcfa009,g_xcfa_m.xcfa010,g_xcfa_m.xcfa011,g_xcfa_m.xcfa012,g_xcfa013,g_xcfa_m.xcfa014) #20150512 By dujuan add  (,g_xcfa_m.xcfa014) 
                  INSERT INTO xcfa_t (xcfaent,xcfald,xcfa001,xcfacomp,xcfa002,xcfa003,xcfa004,xcfa005,xcfa006, 
                      xcfa007,xcfa008,xcfa009,xcfa011,xcfa012,xcfa013,xcfa014)
                  VALUES (g_enterprise,g_xcfa_m.xcfald,g_xcfa_m.xcfa001,g_xcfa_m.xcfacomp,g_xcfa_m.xcfa002, 
                      g_xcfa_m.xcfa003,g_xcfa_m.xcfa004,g_xcfa_m.xcfa005,g_xcfa_m.xcfa006,g_xcfa_m.xcfa007, 
                      g_xcfa_m.xcfa008,g_xcfa_m.xcfa009,g_xcfa_m.xcfa011,g_xcfa_m.xcfa012,g_xcfa013,g_xcfa_m.xcfa014)
                  #161108-00037#2-mod-e
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "g_xcfa_m" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                  
                     CALL s_transaction_end('N','0')
                     CONTINUE DIALOG
                  END IF
               END IF
               #140918  --add xcfa013 end
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
 
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL axci801_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL axci801_b_fill()
                  CALL axci801_b_fill2('0')
               END IF
               
               #add-point:單頭新增後 name="input.head.a_insert2"
               
               #end add-point
               
               LET g_master_insert = TRUE
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前 name="input.head.b_update"
               #140918
               LET g_xcfa013 = g_xcfa_m.xcfa013_1 CLIPPED,g_xcfa_m.xcfa013_2 CLIPPED,g_xcfa_m.xcfa013_3
               IF 1=2 THEN
               #end add-point
               
               #將遮罩欄位還原
               CALL axci801_xcfa_t_mask_restore('restore_mask_o')
               
               UPDATE xcfa_t SET (xcfacomp,xcfa001,xcfald,xcfa002,xcfa003,xcfa004,xcfa005,xcfa006,xcfa007, 
                   xcfa008,xcfa009,xcfa011,xcfa012,xcfa013,xcfa014) = (g_xcfa_m.xcfacomp,g_xcfa_m.xcfa001, 
                   g_xcfa_m.xcfald,g_xcfa_m.xcfa002,g_xcfa_m.xcfa003,g_xcfa_m.xcfa004,g_xcfa_m.xcfa005, 
                   g_xcfa_m.xcfa006,g_xcfa_m.xcfa007,g_xcfa_m.xcfa008,g_xcfa_m.xcfa009,g_xcfa_m.xcfa011, 
                   g_xcfa_m.xcfa012,g_xcfa_m.xcfa013,g_xcfa_m.xcfa014)
                WHERE xcfaent = g_enterprise AND xcfald = g_xcfald_t
                  AND xcfa001 = g_xcfa001_t
                  AND xcfa002 = g_xcfa002_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "xcfa_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               #140918
               ELSE 
                  #161108-00037#2-mod-s
#                  UPDATE xcfa_t SET (xcfald,xcfa001,xcfacomp,xcfa002,xcfa003,xcfa004,xcfa005,xcfa006,xcfa007, 
#                      xcfa008,xcfa009,xcfa010,xcfa011,xcfa012,xcfa013,xcfa014) = (g_xcfa_m.xcfald,g_xcfa_m.xcfa001,g_xcfa_m.xcfacomp, 
#                      g_xcfa_m.xcfa002,g_xcfa_m.xcfa003,g_xcfa_m.xcfa004,g_xcfa_m.xcfa005,g_xcfa_m.xcfa006, 
#                      g_xcfa_m.xcfa007,g_xcfa_m.xcfa008,g_xcfa_m.xcfa009,g_xcfa_m.xcfa010,g_xcfa_m.xcfa011, 
#                      g_xcfa_m.xcfa012,g_xcfa013,g_xcfa_m.xcfa014) #20150512 By dujuan add (,xcfa014 和 ,g_xcfa_m.xcfa014)
                   UPDATE xcfa_t SET (xcfald,xcfa001,xcfacomp,xcfa002,xcfa003,xcfa004,xcfa005,xcfa006,xcfa007, 
                      xcfa008,xcfa009,xcfa011,xcfa012,xcfa013,xcfa014) = (g_xcfa_m.xcfald,g_xcfa_m.xcfa001,g_xcfa_m.xcfacomp, 
                      g_xcfa_m.xcfa002,g_xcfa_m.xcfa003,g_xcfa_m.xcfa004,g_xcfa_m.xcfa005,g_xcfa_m.xcfa006, 
                      g_xcfa_m.xcfa007,g_xcfa_m.xcfa008,g_xcfa_m.xcfa009,g_xcfa_m.xcfa011, 
                      g_xcfa_m.xcfa012,g_xcfa013,g_xcfa_m.xcfa014)
                   #161108-00037#2-mod-e
                   WHERE xcfaent = g_enterprise AND xcfald = g_xcfald_t
                     AND xcfa001 = g_xcfa001_t
                     AND xcfa002 = g_xcfa002_t
                  
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcfa_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                  
                     CALL s_transaction_end('N','0')
                     CONTINUE DIALOG
                  END IF
               END IF
               #140918
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL axci801_xcfa_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_xcfa_m_t)
               LET g_log2 = util.JSON.stringify(g_xcfa_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
 
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_xcfald_t = g_xcfa_m.xcfald
            LET g_xcfa001_t = g_xcfa_m.xcfa001
            LET g_xcfa002_t = g_xcfa_m.xcfa002
 
            
      END INPUT
   
 
{</section>}
 
{<section id="axci801.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_xcfb_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xcfb_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axci801_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_xcfb_d.getLength()
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
            OPEN axci801_cl USING g_enterprise,g_xcfa_m.xcfald,g_xcfa_m.xcfa001,g_xcfa_m.xcfa002
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN axci801_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE axci801_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_xcfb_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_xcfb_d[l_ac].xcfbseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_xcfb_d_t.* = g_xcfb_d[l_ac].*  #BACKUP
               LET g_xcfb_d_o.* = g_xcfb_d[l_ac].*  #BACKUP
               CALL axci801_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL axci801_set_no_entry_b(l_cmd)
               IF NOT axci801_lock_b("xcfb_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axci801_bcl INTO g_xcfb_d[l_ac].xcfbseq,g_xcfb_d[l_ac].xcfb010,g_xcfb_d[l_ac].xcfb011, 
                      g_xcfb_d[l_ac].xcfb012,g_xcfb_d[l_ac].xcfb014,g_xcfb_d[l_ac].xcfb013,g_xcfb_d[l_ac].xcfbcomp 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_xcfb_d_t.xcfbseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xcfb_d_mask_o[l_ac].* =  g_xcfb_d[l_ac].*
                  CALL axci801_xcfb_t_mask()
                  LET g_xcfb_d_mask_n[l_ac].* =  g_xcfb_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL axci801_show()
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
            INITIALIZE g_xcfb_d[l_ac].* TO NULL 
            INITIALIZE g_xcfb_d_t.* TO NULL 
            INITIALIZE g_xcfb_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_xcfb_d[l_ac].xcfb013 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            LET g_xcfb_d[l_ac].xcfbcomp = g_xcfa_m.xcfacomp   #161108-00037#2-add
            #end add-point
            LET g_xcfb_d_t.* = g_xcfb_d[l_ac].*     #新輸入資料
            LET g_xcfb_d_o.* = g_xcfb_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axci801_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL axci801_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xcfb_d[li_reproduce_target].* = g_xcfb_d[li_reproduce].*
 
               LET g_xcfb_d[li_reproduce_target].xcfbseq = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            LET g_xcfb_d[l_ac].xcfbseq = l_ac
            NEXT FIELD xcfb010
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
            SELECT COUNT(1) INTO l_count FROM xcfb_t 
             WHERE xcfbent = g_enterprise AND xcfbld = g_xcfa_m.xcfald
               AND xcfb001 = g_xcfa_m.xcfa001
               AND xcfb002 = g_xcfa_m.xcfa002
 
               AND xcfbseq = g_xcfb_d[l_ac].xcfbseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xcfa_m.xcfald
               LET gs_keys[2] = g_xcfa_m.xcfa001
               LET gs_keys[3] = g_xcfa_m.xcfa002
               LET gs_keys[4] = g_xcfb_d[g_detail_idx].xcfbseq
               CALL axci801_insert_b('xcfb_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_xcfb_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xcfb_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL axci801_b_fill()
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
               LET gs_keys[01] = g_xcfa_m.xcfald
               LET gs_keys[gs_keys.getLength()+1] = g_xcfa_m.xcfa001
               LET gs_keys[gs_keys.getLength()+1] = g_xcfa_m.xcfa002
 
               LET gs_keys[gs_keys.getLength()+1] = g_xcfb_d_t.xcfbseq
 
            
               #刪除同層單身
               IF NOT axci801_delete_b('xcfb_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axci801_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT axci801_key_delete_b(gs_keys,'xcfb_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axci801_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE axci801_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_xcfb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_xcfb_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfbseq
            #add-point:BEFORE FIELD xcfbseq name="input.b.page1.xcfbseq"
            LET g_xcfb_d[l_ac].xcfbseq = l_ac
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfbseq
            
            #add-point:AFTER FIELD xcfbseq name="input.a.page1.xcfbseq"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcfa_m.xcfald IS NOT NULL AND g_xcfa_m.xcfa001 IS NOT NULL AND g_xcfa_m.xcfa002 IS NOT NULL AND g_xcfb_d[g_detail_idx].xcfbseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcfa_m.xcfald != g_xcfald_t OR g_xcfa_m.xcfa001 != g_xcfa001_t OR g_xcfa_m.xcfa002 != g_xcfa002_t OR g_xcfb_d[g_detail_idx].xcfbseq != g_xcfb_d_t.xcfbseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcfb_t WHERE "||"xcfbent = '" ||g_enterprise|| "' AND "||"xcfbld = '"||g_xcfa_m.xcfald ||"' AND "|| "xcfb001 = '"||g_xcfa_m.xcfa001 ||"' AND "|| "xcfb002 = '"||g_xcfa_m.xcfa002 ||"' AND "|| "xcfbseq = '"||g_xcfb_d[g_detail_idx].xcfbseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcfbseq
            #add-point:ON CHANGE xcfbseq name="input.g.page1.xcfbseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfb010
            
            #add-point:AFTER FIELD xcfb010 name="input.a.page1.xcfb010"
            
            IF NOT cl_null(g_xcfb_d[l_ac].xcfb010) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               #140918
               LET g_chkparam.arg1 = '201'
               LET g_chkparam.arg2 = g_xcfb_d[l_ac].xcfb010
               #160318-00025#8--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aqc-00032:sub-01302|aqci030|",cl_get_progname("aqci030",g_lang,"2"),"|:EXEPROGaqci030"
               #160318-00025#8--add--end  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oocq002_1") THEN #140918
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            
           
               
            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcfb_d[l_ac].xcfb010
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='201' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcfb_d[l_ac].xcfb010_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcfb_d[l_ac].xcfb010_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfb010
            #add-point:BEFORE FIELD xcfb010 name="input.b.page1.xcfb010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcfb010
            #add-point:ON CHANGE xcfb010 name="input.g.page1.xcfb010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfb011
            
            #add-point:AFTER FIELD xcfb011 name="input.a.page1.xcfb011"
            IF NOT cl_null(g_xcfb_d[l_ac].xcfb011) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xcfb_d[l_ac].xcfb011
               #160318-00025#8--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00011:sub-01302|aooi140|",cl_get_progname("aooi140",g_lang,"2"),"|:EXEPROGaooi140"
               #160318-00025#8--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooai001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfb011
            #add-point:BEFORE FIELD xcfb011 name="input.b.page1.xcfb011"
 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcfb011
            #add-point:ON CHANGE xcfb011 name="input.g.page1.xcfb011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfb012
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xcfb_d[l_ac].xcfb012,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xcfb012
            END IF 
 
 
 
            #add-point:AFTER FIELD xcfb012 name="input.a.page1.xcfb012"
            #161108-00037#2-add-s
            IF NOT cl_null(g_xcfb_d[l_ac].xcfb012) THEN
               IF NOT axci801_xcfb012_014_chk() THEN
                  NEXT FIELD xcfb012
               END IF
               IF NOT axci801_xcfb012_014_chk2(g_xcfb_d[l_ac].xcfb012) THEN
                  NEXT FIELD xcfb012
               END IF
            END IF
            #161108-00037#2-add-e
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfb012
            #add-point:BEFORE FIELD xcfb012 name="input.b.page1.xcfb012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcfb012
            #add-point:ON CHANGE xcfb012 name="input.g.page1.xcfb012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfb014
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xcfb_d[l_ac].xcfb014,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xcfb014
            END IF 
 
 
 
            #add-point:AFTER FIELD xcfb014 name="input.a.page1.xcfb014"
            #161108-00037#2-add-s
            IF NOT cl_null(g_xcfb_d[l_ac].xcfb014) THEN
               IF NOT axci801_xcfb012_014_chk() THEN
                  NEXT FIELD xcfb014
               END IF
               IF NOT axci801_xcfb012_014_chk2(g_xcfb_d[l_ac].xcfb014) THEN
                  NEXT FIELD xcfb014
               END IF
            END IF
            #161108-00037#2-add-e
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfb014
            #add-point:BEFORE FIELD xcfb014 name="input.b.page1.xcfb014"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcfb014
            #add-point:ON CHANGE xcfb014 name="input.g.page1.xcfb014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfb013
            #add-point:BEFORE FIELD xcfb013 name="input.b.page1.xcfb013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfb013
            
            #add-point:AFTER FIELD xcfb013 name="input.a.page1.xcfb013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcfb013
            #add-point:ON CHANGE xcfb013 name="input.g.page1.xcfb013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfbcomp
            #add-point:BEFORE FIELD xcfbcomp name="input.b.page1.xcfbcomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfbcomp
            
            #add-point:AFTER FIELD xcfbcomp name="input.a.page1.xcfbcomp"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcfbcomp
            #add-point:ON CHANGE xcfbcomp name="input.g.page1.xcfbcomp"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.xcfbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfbseq
            #add-point:ON ACTION controlp INFIELD xcfbseq name="input.c.page1.xcfbseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcfb010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfb010
            #add-point:ON ACTION controlp INFIELD xcfb010 name="input.c.page1.xcfb010"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcfb_d[l_ac].xcfb010             #給予default值
            LET g_qryparam.default2 = "201" #g_xcfb_d[l_ac].oocq002 #應用分類碼  #140918
            #給予arg
            LET g_qryparam.arg1 = "201" #140918

            
            CALL q_oocq002_02()                                #呼叫開窗

            LET g_xcfb_d[l_ac].xcfb010 = g_qryparam.return1              
            #LET g_xcfb_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_xcfb_d[l_ac].xcfb010 TO xcfb010              #
            #DISPLAY g_xcfb_d[l_ac].oocq002 TO oocq002 #應用分類碼
            NEXT FIELD xcfb010                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xcfb011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfb011
            #add-point:ON ACTION controlp INFIELD xcfb011 name="input.c.page1.xcfb011"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcfb_d[l_ac].xcfb011             #給予default值
            LET g_qryparam.default2 = "" #g_xcfb_d[l_ac].ooail003 #說明
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooai001_1()                                #呼叫開窗

            LET g_xcfb_d[l_ac].xcfb011 = g_qryparam.return1              
            #LET g_xcfb_d[l_ac].ooail003 = g_qryparam.return2 
            DISPLAY g_xcfb_d[l_ac].xcfb011 TO xcfb011              #
            #DISPLAY g_xcfb_d[l_ac].ooail003 TO ooail003 #說明
            NEXT FIELD xcfb011                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xcfb012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfb012
            #add-point:ON ACTION controlp INFIELD xcfb012 name="input.c.page1.xcfb012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcfb014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfb014
            #add-point:ON ACTION controlp INFIELD xcfb014 name="input.c.page1.xcfb014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcfb013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfb013
            #add-point:ON ACTION controlp INFIELD xcfb013 name="input.c.page1.xcfb013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcfbcomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfbcomp
            #add-point:ON ACTION controlp INFIELD xcfbcomp name="input.c.page1.xcfbcomp"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_xcfb_d[l_ac].* = g_xcfb_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE axci801_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_xcfb_d[l_ac].xcfbseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_xcfb_d[l_ac].* = g_xcfb_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL axci801_xcfb_t_mask_restore('restore_mask_o')
      
               UPDATE xcfb_t SET (xcfbld,xcfb001,xcfb002,xcfbseq,xcfb010,xcfb011,xcfb012,xcfb014,xcfb013, 
                   xcfbcomp) = (g_xcfa_m.xcfald,g_xcfa_m.xcfa001,g_xcfa_m.xcfa002,g_xcfb_d[l_ac].xcfbseq, 
                   g_xcfb_d[l_ac].xcfb010,g_xcfb_d[l_ac].xcfb011,g_xcfb_d[l_ac].xcfb012,g_xcfb_d[l_ac].xcfb014, 
                   g_xcfb_d[l_ac].xcfb013,g_xcfb_d[l_ac].xcfbcomp)
                WHERE xcfbent = g_enterprise AND xcfbld = g_xcfa_m.xcfald 
                  AND xcfb001 = g_xcfa_m.xcfa001 
                  AND xcfb002 = g_xcfa_m.xcfa002 
 
                  AND xcfbseq = g_xcfb_d_t.xcfbseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_xcfb_d[l_ac].* = g_xcfb_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcfb_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_xcfb_d[l_ac].* = g_xcfb_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcfb_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xcfa_m.xcfald
               LET gs_keys_bak[1] = g_xcfald_t
               LET gs_keys[2] = g_xcfa_m.xcfa001
               LET gs_keys_bak[2] = g_xcfa001_t
               LET gs_keys[3] = g_xcfa_m.xcfa002
               LET gs_keys_bak[3] = g_xcfa002_t
               LET gs_keys[4] = g_xcfb_d[g_detail_idx].xcfbseq
               LET gs_keys_bak[4] = g_xcfb_d_t.xcfbseq
               CALL axci801_update_b('xcfb_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL axci801_xcfb_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_xcfb_d[g_detail_idx].xcfbseq = g_xcfb_d_t.xcfbseq 
 
                  ) THEN
                  LET gs_keys[01] = g_xcfa_m.xcfald
                  LET gs_keys[gs_keys.getLength()+1] = g_xcfa_m.xcfa001
                  LET gs_keys[gs_keys.getLength()+1] = g_xcfa_m.xcfa002
 
                  LET gs_keys[gs_keys.getLength()+1] = g_xcfb_d_t.xcfbseq
 
                  CALL axci801_key_update_b(gs_keys,'xcfb_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_xcfa_m),util.JSON.stringify(g_xcfb_d_t)
               LET g_log2 = util.JSON.stringify(g_xcfa_m),util.JSON.stringify(g_xcfb_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL axci801_unlock_b("xcfb_t","'1'")
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
               LET g_xcfb_d[li_reproduce_target].* = g_xcfb_d[li_reproduce].*
 
               LET g_xcfb_d[li_reproduce_target].xcfbseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_xcfb_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xcfb_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_xcfb2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body2.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xcfb2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axci801_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_xcfb2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xcfb2_d[l_ac].* TO NULL 
            INITIALIZE g_xcfb2_d_t.* TO NULL 
            INITIALIZE g_xcfb2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
                  LET g_xcfb2_d[l_ac].xcfc012 = "0"
 
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            LET g_xcfb2_d[l_ac].xcfccomp = g_xcfa_m.xcfacomp   #161108-00037#2-add
            #end add-point
            LET g_xcfb2_d_t.* = g_xcfb2_d[l_ac].*     #新輸入資料
            LET g_xcfb2_d_o.* = g_xcfb2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axci801_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
            
            #end add-point
            CALL axci801_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xcfb2_d[li_reproduce_target].* = g_xcfb2_d[li_reproduce].*
 
               LET g_xcfb2_d[li_reproduce_target].xcfcseq = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body2.before_insert"
            LET g_xcfb2_d[l_ac].xcfcseq = l_ac
            NEXT FIELD xcfc013   #161108-00037#6 xcfc010 mod xcfc013
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body2.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[2] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 2
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN axci801_cl USING g_enterprise,g_xcfa_m.xcfald,g_xcfa_m.xcfa001,g_xcfa_m.xcfa002
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN axci801_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE axci801_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_xcfb2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_xcfb2_d[l_ac].xcfcseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_xcfb2_d_t.* = g_xcfb2_d[l_ac].*  #BACKUP
               LET g_xcfb2_d_o.* = g_xcfb2_d[l_ac].*  #BACKUP
               CALL axci801_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
               
               #end add-point  
               CALL axci801_set_no_entry_b(l_cmd)
               IF NOT axci801_lock_b("xcfc_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axci801_bcl2 INTO g_xcfb2_d[l_ac].xcfcseq,g_xcfb2_d[l_ac].xcfc013,g_xcfb2_d[l_ac].xcfc010, 
                      g_xcfb2_d[l_ac].xcfc011,g_xcfb2_d[l_ac].xcfc012,g_xcfb2_d[l_ac].xcfccomp
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xcfb2_d_mask_o[l_ac].* =  g_xcfb2_d[l_ac].*
                  CALL axci801_xcfc_t_mask()
                  LET g_xcfb2_d_mask_n[l_ac].* =  g_xcfb2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL axci801_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body2.before_row"
 
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body2.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body2.b_delete_ask"
               
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
               
               #add-point:單身2刪除前 name="input.body2.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_xcfa_m.xcfald
               LET gs_keys[gs_keys.getLength()+1] = g_xcfa_m.xcfa001
               LET gs_keys[gs_keys.getLength()+1] = g_xcfa_m.xcfa002
               LET gs_keys[gs_keys.getLength()+1] = g_xcfb2_d_t.xcfcseq
            
               #刪除同層單身
               IF NOT axci801_delete_b('xcfc_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axci801_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT axci801_key_delete_b(gs_keys,'xcfc_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axci801_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE axci801_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
               
               #end add-point
               LET l_count = g_xcfb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_xcfb2_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
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
               
            #add-point:單身2新增前 name="input.body2.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM xcfc_t 
             WHERE xcfcent = g_enterprise AND xcfcld = g_xcfa_m.xcfald
               AND xcfc001 = g_xcfa_m.xcfa001
               AND xcfc002 = g_xcfa_m.xcfa002
               AND xcfcseq = g_xcfb2_d[l_ac].xcfcseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xcfa_m.xcfald
               LET gs_keys[2] = g_xcfa_m.xcfa001
               LET gs_keys[3] = g_xcfa_m.xcfa002
               LET gs_keys[4] = g_xcfb2_d[g_detail_idx].xcfcseq
               CALL axci801_insert_b('xcfc_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_xcfb_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xcfc_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL axci801_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body2.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_xcfb2_d[l_ac].* = g_xcfb2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE axci801_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_xcfb2_d[l_ac].* = g_xcfb2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL axci801_xcfc_t_mask_restore('restore_mask_o')
                              
               UPDATE xcfc_t SET (xcfcld,xcfc001,xcfc002,xcfcseq,xcfc013,xcfc010,xcfc011,xcfc012,xcfccomp) = (g_xcfa_m.xcfald, 
                   g_xcfa_m.xcfa001,g_xcfa_m.xcfa002,g_xcfb2_d[l_ac].xcfcseq,g_xcfb2_d[l_ac].xcfc013, 
                   g_xcfb2_d[l_ac].xcfc010,g_xcfb2_d[l_ac].xcfc011,g_xcfb2_d[l_ac].xcfc012,g_xcfb2_d[l_ac].xcfccomp)  
                   #自訂欄位頁簽
                WHERE xcfcent = g_enterprise AND xcfcld = g_xcfa_m.xcfald
                  AND xcfc001 = g_xcfa_m.xcfa001
                  AND xcfc002 = g_xcfa_m.xcfa002
                  AND xcfcseq = g_xcfb2_d_t.xcfcseq #項次 
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_xcfb2_d[l_ac].* = g_xcfb2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcfc_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_xcfb2_d[l_ac].* = g_xcfb2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcfc_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xcfa_m.xcfald
               LET gs_keys_bak[1] = g_xcfald_t
               LET gs_keys[2] = g_xcfa_m.xcfa001
               LET gs_keys_bak[2] = g_xcfa001_t
               LET gs_keys[3] = g_xcfa_m.xcfa002
               LET gs_keys_bak[3] = g_xcfa002_t
               LET gs_keys[4] = g_xcfb2_d[g_detail_idx].xcfcseq
               LET gs_keys_bak[4] = g_xcfb2_d_t.xcfcseq
               CALL axci801_update_b('xcfc_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL axci801_xcfc_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_xcfb2_d[g_detail_idx].xcfcseq = g_xcfb2_d_t.xcfcseq 
                  ) THEN
                  LET gs_keys[01] = g_xcfa_m.xcfald
                  LET gs_keys[gs_keys.getLength()+1] = g_xcfa_m.xcfa001
                  LET gs_keys[gs_keys.getLength()+1] = g_xcfa_m.xcfa002
                  LET gs_keys[gs_keys.getLength()+1] = g_xcfb2_d_t.xcfcseq
                  CALL axci801_key_update_b(gs_keys,'xcfc_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_xcfa_m),util.JSON.stringify(g_xcfb2_d_t)
               LET g_log2 = util.JSON.stringify(g_xcfa_m),util.JSON.stringify(g_xcfb2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfcseq
            #add-point:BEFORE FIELD xcfcseq name="input.b.page2.xcfcseq"
            LET g_xcfb2_d[l_ac].xcfcseq = l_ac
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfcseq
            
            #add-point:AFTER FIELD xcfcseq name="input.a.page2.xcfcseq"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcfa_m.xcfald IS NOT NULL AND g_xcfa_m.xcfa001 IS NOT NULL AND g_xcfa_m.xcfa002 IS NOT NULL AND g_xcfb2_d[g_detail_idx].xcfcseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcfa_m.xcfald != g_xcfald_t OR g_xcfa_m.xcfa001 != g_xcfa001_t OR g_xcfa_m.xcfa002 != g_xcfa002_t OR g_xcfb2_d[g_detail_idx].xcfcseq != g_xcfb2_d_t.xcfcseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcfc_t WHERE "||"xcfcent = '" ||g_enterprise|| "' AND "||"xcfcld = '"||g_xcfa_m.xcfald ||"' AND "|| "xcfc001 = '"||g_xcfa_m.xcfa001 ||"' AND "|| "xcfc002 = '"||g_xcfa_m.xcfa002 ||"' AND "|| "xcfcseq = '"||g_xcfb2_d[g_detail_idx].xcfcseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcfcseq
            #add-point:ON CHANGE xcfcseq name="input.g.page2.xcfcseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfc013
            
            #add-point:AFTER FIELD xcfc013 name="input.a.page2.xcfc013"
           #161108-00037#6-s-add 
            LET g_xcfb2_d[l_ac].xcfc013_desc = ''
            IF NOT cl_null(g_xcfb2_d[l_ac].xcfc013) THEN 
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = '201'
               LET g_chkparam.arg2 = g_xcfb2_d[l_ac].xcfc013
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aqc-00032:sub-01302|aqci030|",cl_get_progname("aqci030",g_lang,"2"),"|:EXEPROGaqci030"
               IF NOT cl_chk_exist("v_oocq002_1") THEN 
                  LET g_xcfb2_d[l_ac].xcfc013 = g_xcfb2_d_t.xcfc013
                  NEXT FIELD CURRENT
               END IF          
               IF NOT axci801_chk_xcfc013() THEN
                  LET g_xcfb2_d[l_ac].xcfc013 = g_xcfb2_d_t.xcfc013
                  NEXT FIELD CURRENT                 
               END IF                               
               CALL s_desc_get_acc_desc('201',g_xcfb2_d[l_ac].xcfc013) RETURNING g_xcfb2_d[l_ac].xcfc013_desc
               DISPLAY BY NAME g_xcfb2_d[l_ac].xcfc013_desc 
               LET g_xcfb2_d_t.xcfc013 = g_xcfb2_d[l_ac].xcfc013              
            ELSE
               IF NOT axci801_chk_xcfc013() THEN
                  LET g_xcfb2_d[l_ac].xcfc013 = g_xcfb2_d_t.xcfc013
                  NEXT FIELD CURRENT                 
               END IF                            
            END IF 
           #161108-00037#6-e-add 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfc013
            #add-point:BEFORE FIELD xcfc013 name="input.b.page2.xcfc013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcfc013
            #add-point:ON CHANGE xcfc013 name="input.g.page2.xcfc013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfc010
            #add-point:BEFORE FIELD xcfc010 name="input.b.page2.xcfc010"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfc010
            
            #add-point:AFTER FIELD xcfc010 name="input.a.page2.xcfc010"
            #140918--begin            
            IF NOT cl_null(g_xcfb2_d[l_ac].xcfc010) THEN
               #起始<截至
               IF NOT cl_null(g_xcfb2_d[l_ac].xcfc011) THEN
                  IF g_xcfb2_d[l_ac].xcfc010 >= g_xcfb2_d[l_ac].xcfc011 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "axc-00579" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
               END IF
               ###########################################
#               #起始>前一行 截至   #天数不跳着填
#               IF l_ac <>1 THEN
#                  IF NOT cl_null(g_xcfb2_d[l_ac-1].xcfc011) THEN
#                     IF g_xcfb2_d[l_ac].xcfc010 <= g_xcfb2_d[l_ac-1].xcfc011 THEN
#                        INITIALIZE g_errparam TO NULL 
#                        LET g_errparam.extend = "" 
#                        LET g_errparam.code   = "axc-00580" 
#                        LET g_errparam.popup  = TRUE 
#                        CALL cl_err()
#                        NEXT FIELD CURRENT
#                     END IF
#                  END IF
#               END IF   
               ###########################################
               ###########################################
              #161108-00037#6-s-mark 
              ##天数跳着填... 起始天数不能在任何一行的数据中间  150129
              #FOR l_a = 1 TO g_xcfb2_d.getlength()
              #   IF l_a = l_ac THEN CONTINUE FOR END IF
              #   IF g_xcfb2_d[l_ac].xcfc010 <= g_xcfb2_d[l_a].xcfc011 AND g_xcfb2_d[l_ac].xcfc010 >= g_xcfb2_d[l_a].xcfc010 THEN
              #      INITIALIZE g_errparam TO NULL 
              #      LET g_errparam.extend = "" 
              #      LET g_errparam.code   = "axc-00580" 
              #      LET g_errparam.popup  = TRUE 
              #      CALL cl_err()
              #      NEXT FIELD CURRENT
              #   END IF
              #END FOR                
              ############################################
              #161108-00037#6-e-mark 
              #161108-00037#6-s-add
               IF NOT axci801_chk_xcfc013() THEN 
                  NEXT FIELD CURRENT
               END IF
              #161108-00037#6-e-add
            END IF
            
            
            #140918--end
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcfc010
            #add-point:ON CHANGE xcfc010 name="input.g.page2.xcfc010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfc011
            #add-point:BEFORE FIELD xcfc011 name="input.b.page2.xcfc011"
                        
           #140918--begin
            #起始不为空
            IF cl_null(g_xcfb2_d[l_ac].xcfc010) THEN
               NEXT FIELD xcfc010
            END IF
            #140918--end
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfc011
            
            #add-point:AFTER FIELD xcfc011 name="input.a.page2.xcfc011"
            IF NOT cl_null(g_xcfb2_d[l_ac].xcfc011) THEN
               #起始<截至
               IF NOT cl_null(g_xcfb2_d[l_ac].xcfc010) THEN
                  IF g_xcfb2_d[l_ac].xcfc010 >= g_xcfb2_d[l_ac].xcfc011 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "axc-00579" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
               END IF
#               #起始>前一行 截至
#               IF l_ac < g_rec_b THEN
#                  IF NOT cl_null(g_xcfb2_d[l_ac+1].xcfc010) THEN
#                     IF g_xcfb2_d[l_ac+1].xcfc010 <= g_xcfb2_d[l_ac].xcfc011 THEN
#                        INITIALIZE g_errparam TO NULL 
#                        LET g_errparam.extend = "" 
#                        LET g_errparam.code   = "axc-00580" 
#                        LET g_errparam.popup  = TRUE 
#                        CALL cl_err()
#                        NEXT FIELD CURRENT
#                     END IF
#                  END IF
#               END IF 
              #161108-00037#6-s-mark 
              ############################################              
              ##天数跳着填... 起始天数不能在任何一行的数据中间  150129
              #FOR l_a = 1 TO g_xcfb2_d.getlength()
              #   IF l_a = l_ac THEN CONTINUE FOR END IF                  
              #   IF g_xcfb2_d[l_ac].xcfc011 <= g_xcfb2_d[l_a].xcfc011 AND g_xcfb2_d[l_ac].xcfc011 >= g_xcfb2_d[l_a].xcfc010 THEN
              #      INITIALIZE g_errparam TO NULL 
              #      LET g_errparam.extend = "" 
              #      LET g_errparam.code   = "axc-00580" 
              #      LET g_errparam.popup  = TRUE 
              #      CALL cl_err()
              #      NEXT FIELD CURRENT
              #   END IF
              #END FOR                
              ############################################
              #161108-00037#6-e-mark 
              #161108-00037#6-s-add
               IF NOT axci801_chk_xcfc013() THEN 
                  NEXT FIELD CURRENT
               END IF
              #161108-00037#6-e-add              
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcfc011
            #add-point:ON CHANGE xcfc011 name="input.g.page2.xcfc011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfc012
            #add-point:BEFORE FIELD xcfc012 name="input.b.page2.xcfc012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfc012
            
            #add-point:AFTER FIELD xcfc012 name="input.a.page2.xcfc012"
                   
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcfc012
            #add-point:ON CHANGE xcfc012 name="input.g.page2.xcfc012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfccomp
            #add-point:BEFORE FIELD xcfccomp name="input.b.page2.xcfccomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfccomp
            
            #add-point:AFTER FIELD xcfccomp name="input.a.page2.xcfccomp"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcfccomp
            #add-point:ON CHANGE xcfccomp name="input.g.page2.xcfccomp"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.xcfcseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfcseq
            #add-point:ON ACTION controlp INFIELD xcfcseq name="input.c.page2.xcfcseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xcfc013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfc013
            #add-point:ON ACTION controlp INFIELD xcfc013 name="input.c.page2.xcfc013"
           #161108-00037#6-s-add 
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xcfb2_d[l_ac].xcfc013          
            LET g_qryparam.default2 = "201" 
            LET g_qryparam.arg1 = "201"             
            CALL q_oocq002_02()                             
            LET g_xcfb2_d[l_ac].xcfc013 = g_qryparam.return1              
            DISPLAY g_xcfb2_d[l_ac].xcfc013 TO xcfc013              # 
            CALL s_desc_get_acc_desc('201',g_xcfb2_d[l_ac].xcfc013) RETURNING g_xcfb2_d[l_ac].xcfc013_desc            
            DISPLAY BY NAME g_xcfb2_d[l_ac].xcfc013_desc
            NEXT FIELD xcfc013                          #返回原欄位  
           #161108-00037#6-e-add 
            #END add-point
 
 
         #Ctrlp:input.c.page2.xcfc010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfc010
            #add-point:ON ACTION controlp INFIELD xcfc010 name="input.c.page2.xcfc010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xcfc011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfc011
            #add-point:ON ACTION controlp INFIELD xcfc011 name="input.c.page2.xcfc011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xcfc012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfc012
            #add-point:ON ACTION controlp INFIELD xcfc012 name="input.c.page2.xcfc012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xcfccomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfccomp
            #add-point:ON ACTION controlp INFIELD xcfccomp name="input.c.page2.xcfccomp"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body2.after_row"
           #161108-00037#6-s-mark 
           ############################################
           ##天数跳着填... 起始天数不能在任何一行的数据中间  150129
           #FOR l_a = 1 TO g_xcfb2_d.getlength()
           #   IF l_a = l_ac THEN CONTINUE FOR END IF             
           #   IF g_xcfb2_d[l_ac].xcfc010 <= g_xcfb2_d[l_a].xcfc011 AND g_xcfb2_d[l_ac].xcfc010 >= g_xcfb2_d[l_a].xcfc010 THEN
           #      INITIALIZE g_errparam TO NULL 
           #      LET g_errparam.extend = "" 
           #      LET g_errparam.code   = "axc-00580" 
           #      LET g_errparam.popup  = TRUE 
           #      CALL cl_err()
           #      NEXT FIELD xcfc010
           #   END IF               
           #   IF g_xcfb2_d[l_ac].xcfc011 <= g_xcfb2_d[l_a].xcfc011 AND g_xcfb2_d[l_ac].xcfc011 >= g_xcfb2_d[l_a].xcfc010 THEN
           #      INITIALIZE g_errparam TO NULL 
           #      LET g_errparam.extend = "" 
           #      LET g_errparam.code   = "axc-00580" 
           #      LET g_errparam.popup  = TRUE 
           #      CALL cl_err()
           #      NEXT FIELD xcfc011
           #   END IF
           #END FOR                
           ############################################
           #161108-00037#6-s-mark 
           #161108-00037#6-s-add
            IF NOT axci801_chk_xcfc013() THEN 
               NEXT FIELD CURRENT
            END IF
           #161108-00037#6-e-add           
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xcfb2_d[l_ac].* = g_xcfb2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE axci801_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL axci801_unlock_b("xcfc_t","'2'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page2 after_row2 name="input.body2.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body2.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_xcfb2_d[li_reproduce_target].* = g_xcfb2_d[li_reproduce].*
 
               LET g_xcfb2_d[li_reproduce_target].xcfcseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_xcfb2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xcfb2_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_xcfb3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_3)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body3.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xcfb3_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axci801_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_xcfb3_d.getLength()
            #add-point:資料輸入前 name="input.body3.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xcfb3_d[l_ac].* TO NULL 
            INITIALIZE g_xcfb3_d_t.* TO NULL 
            INITIALIZE g_xcfb3_d_o.* TO NULL 
            #公用欄位給值(單身3)
            
            #自定義預設值(單身3)
            
            #add-point:modify段before備份 name="input.body3.insert.before_bak"
            LET g_xcfb3_d[l_ac].xcfdcomp = g_xcfa_m.xcfacomp   #161108-00037#2-add
            #end add-point
            LET g_xcfb3_d_t.* = g_xcfb3_d[l_ac].*     #新輸入資料
            LET g_xcfb3_d_o.* = g_xcfb3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axci801_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body3.insert.after_set_entry_b"
            
            #end add-point
            CALL axci801_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xcfb3_d[li_reproduce_target].* = g_xcfb3_d[li_reproduce].*
 
               LET g_xcfb3_d[li_reproduce_target].xcfdseq = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body3.before_insert"
            LET g_xcfb3_d[l_ac].xcfdseq = l_ac
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body3.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[3] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 3
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN axci801_cl USING g_enterprise,g_xcfa_m.xcfald,g_xcfa_m.xcfa001,g_xcfa_m.xcfa002
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN axci801_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE axci801_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_xcfb3_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_xcfb3_d[l_ac].xcfdseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_xcfb3_d_t.* = g_xcfb3_d[l_ac].*  #BACKUP
               LET g_xcfb3_d_o.* = g_xcfb3_d[l_ac].*  #BACKUP
               CALL axci801_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body3.after_set_entry_b"
               
               #end add-point  
               CALL axci801_set_no_entry_b(l_cmd)
               IF NOT axci801_lock_b("xcfd_t","'3'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axci801_bcl3 INTO g_xcfb3_d[l_ac].xcfdseq,g_xcfb3_d[l_ac].xcfd010,g_xcfb3_d[l_ac].xcfdcomp 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xcfb3_d_mask_o[l_ac].* =  g_xcfb3_d[l_ac].*
                  CALL axci801_xcfd_t_mask()
                  LET g_xcfb3_d_mask_n[l_ac].* =  g_xcfb3_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL axci801_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body3.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body3.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body3.b_delete_ask"
               
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
               
               #add-point:單身3刪除前 name="input.body3.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_xcfa_m.xcfald
               LET gs_keys[gs_keys.getLength()+1] = g_xcfa_m.xcfa001
               LET gs_keys[gs_keys.getLength()+1] = g_xcfa_m.xcfa002
               LET gs_keys[gs_keys.getLength()+1] = g_xcfb3_d_t.xcfdseq
            
               #刪除同層單身
               IF NOT axci801_delete_b('xcfd_t',gs_keys,"'3'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axci801_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT axci801_key_delete_b(gs_keys,'xcfd_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axci801_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身3刪除中 name="input.body3.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE axci801_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身3刪除後 name="input.body3.a_delete"
               
               #end add-point
               LET l_count = g_xcfb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body3.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_xcfb3_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
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
               
            #add-point:單身3新增前 name="input.body3.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM xcfd_t 
             WHERE xcfdent = g_enterprise AND xcfdld = g_xcfa_m.xcfald
               AND xcfd001 = g_xcfa_m.xcfa001
               AND xcfd002 = g_xcfa_m.xcfa002
               AND xcfdseq = g_xcfb3_d[l_ac].xcfdseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前 name="input.body3.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xcfa_m.xcfald
               LET gs_keys[2] = g_xcfa_m.xcfa001
               LET gs_keys[3] = g_xcfa_m.xcfa002
               LET gs_keys[4] = g_xcfb3_d[g_detail_idx].xcfdseq
               CALL axci801_insert_b('xcfd_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3 name="input.body3.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_xcfb_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xcfd_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL axci801_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body3.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_xcfb3_d[l_ac].* = g_xcfb3_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE axci801_bcl3
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_xcfb3_d[l_ac].* = g_xcfb3_d_t.*
            ELSE
               #add-point:單身page3修改前 name="input.body3.b_update"
                
               #end add-point
               
               #寫入修改者/修改日期資訊(單身3)
               
               
               #將遮罩欄位還原
               CALL axci801_xcfd_t_mask_restore('restore_mask_o')
                              
               UPDATE xcfd_t SET (xcfdld,xcfd001,xcfd002,xcfdseq,xcfd010,xcfdcomp) = (g_xcfa_m.xcfald, 
                   g_xcfa_m.xcfa001,g_xcfa_m.xcfa002,g_xcfb3_d[l_ac].xcfdseq,g_xcfb3_d[l_ac].xcfd010, 
                   g_xcfb3_d[l_ac].xcfdcomp) #自訂欄位頁簽
                WHERE xcfdent = g_enterprise AND xcfdld = g_xcfa_m.xcfald
                  AND xcfd001 = g_xcfa_m.xcfa001
                  AND xcfd002 = g_xcfa_m.xcfa002
                  AND xcfdseq = g_xcfb3_d_t.xcfdseq #項次 
                  
               #add-point:單身page3修改中 name="input.body3.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_xcfb3_d[l_ac].* = g_xcfb3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcfd_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_xcfb3_d[l_ac].* = g_xcfb3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcfd_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xcfa_m.xcfald
               LET gs_keys_bak[1] = g_xcfald_t
               LET gs_keys[2] = g_xcfa_m.xcfa001
               LET gs_keys_bak[2] = g_xcfa001_t
               LET gs_keys[3] = g_xcfa_m.xcfa002
               LET gs_keys_bak[3] = g_xcfa002_t
               LET gs_keys[4] = g_xcfb3_d[g_detail_idx].xcfdseq
               LET gs_keys_bak[4] = g_xcfb3_d_t.xcfdseq
               CALL axci801_update_b('xcfd_t',gs_keys,gs_keys_bak,"'3'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL axci801_xcfd_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_xcfb3_d[g_detail_idx].xcfdseq = g_xcfb3_d_t.xcfdseq 
                  ) THEN
                  LET gs_keys[01] = g_xcfa_m.xcfald
                  LET gs_keys[gs_keys.getLength()+1] = g_xcfa_m.xcfa001
                  LET gs_keys[gs_keys.getLength()+1] = g_xcfa_m.xcfa002
                  LET gs_keys[gs_keys.getLength()+1] = g_xcfb3_d_t.xcfdseq
                  CALL axci801_key_update_b(gs_keys,'xcfd_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_xcfa_m),util.JSON.stringify(g_xcfb3_d_t)
               LET g_log2 = util.JSON.stringify(g_xcfa_m),util.JSON.stringify(g_xcfb3_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page3修改後 name="input.body3.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfdseq
            #add-point:BEFORE FIELD xcfdseq name="input.b.page3.xcfdseq"
            LET g_xcfb3_d[l_ac].xcfdseq = l_ac
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfdseq
            
            #add-point:AFTER FIELD xcfdseq name="input.a.page3.xcfdseq"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcfa_m.xcfald IS NOT NULL AND g_xcfa_m.xcfa001 IS NOT NULL AND g_xcfa_m.xcfa002 IS NOT NULL AND g_xcfb3_d[g_detail_idx].xcfdseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcfa_m.xcfald != g_xcfald_t OR g_xcfa_m.xcfa001 != g_xcfa001_t OR g_xcfa_m.xcfa002 != g_xcfa002_t OR g_xcfb3_d[g_detail_idx].xcfdseq != g_xcfb3_d_t.xcfdseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcfd_t WHERE "||"xcfdent = '" ||g_enterprise|| "' AND "||"xcfdld = '"||g_xcfa_m.xcfald ||"' AND "|| "xcfd001 = '"||g_xcfa_m.xcfa001 ||"' AND "|| "xcfd002 = '"||g_xcfa_m.xcfa002 ||"' AND "|| "xcfdseq = '"||g_xcfb3_d[g_detail_idx].xcfdseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcfdseq
            #add-point:ON CHANGE xcfdseq name="input.g.page3.xcfdseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfd010
            
            #add-point:AFTER FIELD xcfd010 name="input.a.page3.xcfd010"
            #161108-00037#2-add-s
            IF NOT cl_null(g_xcfb3_d[l_ac].xcfd010) THEN 
               IF g_xcfb3_d[l_ac].xcfd010 != g_xcfb3_d_o.xcfd010 OR g_xcfb3_d_o.xcfd010 IS NULL THEN
                  INITIALIZE g_chkparam.* TO NULL               
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_xcfa_m.xcfacomp
                  LET g_chkparam.arg2 = g_xcfb3_d[l_ac].xcfd010
                  IF NOT cl_chk_exist("v_inaa001_21") THEN
                     LET g_xcfb3_d[l_ac].xcfd010 = g_xcfb3_d_o.xcfd010                     
                     NEXT FIELD CURRENT
                  END IF
                  LET g_xcfb3_d_o.xcfd010 = g_xcfb3_d[l_ac].xcfd010
               END IF
            END IF
            #161108-00037#2-add-e
            CALL axci801_xcfd010_desc()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfd010
            #add-point:BEFORE FIELD xcfd010 name="input.b.page3.xcfd010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcfd010
            #add-point:ON CHANGE xcfd010 name="input.g.page3.xcfd010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfdcomp
            #add-point:BEFORE FIELD xcfdcomp name="input.b.page3.xcfdcomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfdcomp
            
            #add-point:AFTER FIELD xcfdcomp name="input.a.page3.xcfdcomp"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcfdcomp
            #add-point:ON CHANGE xcfdcomp name="input.g.page3.xcfdcomp"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.xcfdseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfdseq
            #add-point:ON ACTION controlp INFIELD xcfdseq name="input.c.page3.xcfdseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xcfd010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfd010
            #add-point:ON ACTION controlp INFIELD xcfd010 name="input.c.page3.xcfd010"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcfb3_d[l_ac].xcfd010             #給予default值

            #給予arg            
            LET g_qryparam.arg1 = g_xcfa_m.xcfacomp            
            #161108-00037#2-mod-s
#            CALL q_inaa001_23()                                #呼叫開窗
            CALL q_inaa001_33()
            #161108-00037#2-mod-e

            LET g_xcfb3_d[l_ac].xcfd010 = g_qryparam.return1              

            DISPLAY g_xcfb3_d[l_ac].xcfd010 TO xcfd010              #

            NEXT FIELD xcfd010                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page3.xcfdcomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfdcomp
            #add-point:ON ACTION controlp INFIELD xcfdcomp name="input.c.page3.xcfdcomp"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page3 after_row name="input.body3.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xcfb3_d[l_ac].* = g_xcfb3_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE axci801_bcl3
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL axci801_unlock_b("xcfd_t","'3'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page3 after_row2 name="input.body3.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body3.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_xcfb3_d[li_reproduce_target].* = g_xcfb3_d[li_reproduce].*
 
               LET g_xcfb3_d[li_reproduce_target].xcfdseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_xcfb3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xcfb3_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
 
 
 
{</section>}
 
{<section id="axci801.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
         CALL DIALOG.setCurrentRow("s_detail2",g_idx_group.getValue("'2',"))
         CALL DIALOG.setCurrentRow("s_detail3",g_idx_group.getValue("'3',"))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD xcfald
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD xcfbseq
               WHEN "s_detail2"
                  NEXT FIELD xcfcseq
               WHEN "s_detail3"
                  NEXT FIELD xcfdseq
 
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

         #141009
         IF g_xcfa_m.xcfa004 = '1' THEN             
            IF cl_null(g_xcfb_d[1].xcfb010)  THEN
               NEXT FIELD xcfb010
            END IF
         ELSE            
            IF cl_null(g_xcfb2_d[1].xcfc010) THEN
               NEXT FIELD xcfc010
            END IF
            IF cl_null(g_xcfb2_d[1].xcfc011)  THEN
               NEXT FIELD xcfc011
            END IF
         END IF
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
         LET g_detail_idx_list[2] = 1
         LET g_detail_idx_list[3] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
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
         LET g_detail_idx_list[2] = 1
         LET g_detail_idx_list[3] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="axci801.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION axci801_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL axci801_b_fill() #單身填充
      CALL axci801_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL axci801_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   
   #end add-point
   
   #遮罩相關處理
   LET g_xcfa_m_mask_o.* =  g_xcfa_m.*
   CALL axci801_xcfa_t_mask()
   LET g_xcfa_m_mask_n.* =  g_xcfa_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_xcfa_m.xcfacomp,g_xcfa_m.xcfacomp_desc,g_xcfa_m.xcfa001,g_xcfa_m.xcfald,g_xcfa_m.xcfald_desc, 
       g_xcfa_m.xcfa002,g_xcfa_m.xcfa003,g_xcfa_m.xcfa004,g_xcfa_m.xcfa005,g_xcfa_m.xcfa006,g_xcfa_m.xcfa007, 
       g_xcfa_m.xcfa008,g_xcfa_m.xcfa009,g_xcfa_m.xcfa011,g_xcfa_m.xcfa012,g_xcfa_m.xcfa013_1,g_xcfa_m.xcfa013_2, 
       g_xcfa_m.xcfa013_3,g_xcfa_m.xcfa013,g_xcfa_m.xcfa014
   
   #顯示狀態(stus)圖片
   
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_xcfb_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_xcfb2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_xcfb3_d.getLength()
      #add-point:show段單身reference name="show.body3.reference"
      
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL axci801_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axci801.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION axci801_detail_show()
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
 
{<section id="axci801.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION axci801_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE xcfa_t.xcfald 
   DEFINE l_oldno     LIKE xcfa_t.xcfald 
   DEFINE l_newno02     LIKE xcfa_t.xcfa001 
   DEFINE l_oldno02     LIKE xcfa_t.xcfa001 
   DEFINE l_newno03     LIKE xcfa_t.xcfa002 
   DEFINE l_oldno03     LIKE xcfa_t.xcfa002 
 
   DEFINE l_master    RECORD LIKE xcfa_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE xcfb_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE xcfc_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE xcfd_t.* #此變數樣板目前無使用
 
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   
   LET g_master_insert = FALSE
   
   IF g_xcfa_m.xcfald IS NULL
   OR g_xcfa_m.xcfa001 IS NULL
   OR g_xcfa_m.xcfa002 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_xcfald_t = g_xcfa_m.xcfald
   LET g_xcfa001_t = g_xcfa_m.xcfa001
   LET g_xcfa002_t = g_xcfa_m.xcfa002
 
    
   LET g_xcfa_m.xcfald = ""
   LET g_xcfa_m.xcfa001 = ""
   LET g_xcfa_m.xcfa002 = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
   
   
   #清空key欄位的desc
      LET g_xcfa_m.xcfald_desc = ''
   DISPLAY BY NAME g_xcfa_m.xcfald_desc
 
   
   CALL axci801_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_xcfa_m.* TO NULL
      INITIALIZE g_xcfb_d TO NULL
      INITIALIZE g_xcfb2_d TO NULL
      INITIALIZE g_xcfb3_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL axci801_show()
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
   CALL axci801_set_act_visible()   
   CALL axci801_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_xcfald_t = g_xcfa_m.xcfald
   LET g_xcfa001_t = g_xcfa_m.xcfa001
   LET g_xcfa002_t = g_xcfa_m.xcfa002
 
   
   #組合新增資料的條件
   LET g_add_browse = " xcfaent = " ||g_enterprise|| " AND",
                      " xcfald = '", g_xcfa_m.xcfald, "' "
                      ," AND xcfa001 = '", g_xcfa_m.xcfa001, "' "
                      ," AND xcfa002 = '", g_xcfa_m.xcfa002, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axci801_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL axci801_idx_chk()
   
   
   #功能已完成,通報訊息中心
   CALL axci801_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="axci801.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION axci801_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE xcfb_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE xcfc_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE xcfd_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE axci801_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xcfb_t
    WHERE xcfbent = g_enterprise AND xcfbld = g_xcfald_t
     AND xcfb001 = g_xcfa001_t
     AND xcfb002 = g_xcfa002_t
 
    INTO TEMP axci801_detail
 
   #將key修正為調整後   
   UPDATE axci801_detail 
      #更新key欄位
      SET xcfbld = g_xcfa_m.xcfald
          , xcfb001 = g_xcfa_m.xcfa001
          , xcfb002 = g_xcfa_m.xcfa002
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO xcfb_t SELECT * FROM axci801_detail
   
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
   DROP TABLE axci801_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xcfc_t 
    WHERE xcfcent = g_enterprise AND xcfcld = g_xcfald_t
      AND xcfc001 = g_xcfa001_t   
      AND xcfc002 = g_xcfa002_t   
 
    INTO TEMP axci801_detail
 
   #將key修正為調整後   
   UPDATE axci801_detail SET xcfcld = g_xcfa_m.xcfald
                                       , xcfc001 = g_xcfa_m.xcfa001
                                       , xcfc002 = g_xcfa_m.xcfa002
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO xcfc_t SELECT * FROM axci801_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE axci801_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table3.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xcfd_t 
    WHERE xcfdent = g_enterprise AND xcfdld = g_xcfald_t
      AND xcfd001 = g_xcfa001_t   
      AND xcfd002 = g_xcfa002_t   
 
    INTO TEMP axci801_detail
 
   #將key修正為調整後   
   UPDATE axci801_detail SET xcfdld = g_xcfa_m.xcfald
                                       , xcfd001 = g_xcfa_m.xcfa001
                                       , xcfd002 = g_xcfa_m.xcfa002
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table3.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO xcfd_t SELECT * FROM axci801_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table3.m_insert"
   CALL axci801_xcfdcomp_upd() #160107-00009#1-add
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE axci801_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table3.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_xcfald_t = g_xcfa_m.xcfald
   LET g_xcfa001_t = g_xcfa_m.xcfa001
   LET g_xcfa002_t = g_xcfa_m.xcfa002
 
   
END FUNCTION
 
{</section>}
 
{<section id="axci801.delete" >}
#+ 資料刪除
PRIVATE FUNCTION axci801_delete()
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
   
   IF g_xcfa_m.xcfald IS NULL
   OR g_xcfa_m.xcfa001 IS NULL
   OR g_xcfa_m.xcfa002 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN axci801_cl USING g_enterprise,g_xcfa_m.xcfald,g_xcfa_m.xcfa001,g_xcfa_m.xcfa002
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axci801_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE axci801_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axci801_master_referesh USING g_xcfa_m.xcfald,g_xcfa_m.xcfa001,g_xcfa_m.xcfa002 INTO g_xcfa_m.xcfacomp, 
       g_xcfa_m.xcfa001,g_xcfa_m.xcfald,g_xcfa_m.xcfa002,g_xcfa_m.xcfa003,g_xcfa_m.xcfa004,g_xcfa_m.xcfa005, 
       g_xcfa_m.xcfa006,g_xcfa_m.xcfa007,g_xcfa_m.xcfa008,g_xcfa_m.xcfa009,g_xcfa_m.xcfa011,g_xcfa_m.xcfa012, 
       g_xcfa_m.xcfa013,g_xcfa_m.xcfa014,g_xcfa_m.xcfacomp_desc,g_xcfa_m.xcfald_desc
   
   
   #檢查是否允許此動作
   IF NOT axci801_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_xcfa_m_mask_o.* =  g_xcfa_m.*
   CALL axci801_xcfa_t_mask()
   LET g_xcfa_m_mask_n.* =  g_xcfa_m.*
   
   CALL axci801_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL axci801_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_xcfald_t = g_xcfa_m.xcfald
      LET g_xcfa001_t = g_xcfa_m.xcfa001
      LET g_xcfa002_t = g_xcfa_m.xcfa002
 
 
      DELETE FROM xcfa_t
       WHERE xcfaent = g_enterprise AND xcfald = g_xcfa_m.xcfald
         AND xcfa001 = g_xcfa_m.xcfa001
         AND xcfa002 = g_xcfa_m.xcfa002
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_xcfa_m.xcfald,":",SQLERRMESSAGE  
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
      
      DELETE FROM xcfb_t
       WHERE xcfbent = g_enterprise AND xcfbld = g_xcfa_m.xcfald
         AND xcfb001 = g_xcfa_m.xcfa001
         AND xcfb002 = g_xcfa_m.xcfa002
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xcfb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
      #add-point:單身刪除前 name="delete.body.b_delete2"
      
      #end add-point
      DELETE FROM xcfc_t
       WHERE xcfcent = g_enterprise AND
             xcfcld = g_xcfa_m.xcfald AND xcfc001 = g_xcfa_m.xcfa001 AND xcfc002 = g_xcfa_m.xcfa002
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xcfc_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete2"
      
      #end add-point
 
      #add-point:單身刪除前 name="delete.body.b_delete3"
      
      #end add-point
      DELETE FROM xcfd_t
       WHERE xcfdent = g_enterprise AND
             xcfdld = g_xcfa_m.xcfald AND xcfd001 = g_xcfa_m.xcfa001 AND xcfd002 = g_xcfa_m.xcfa002
      #add-point:單身刪除中 name="delete.body.m_delete3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xcfd_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete3"
      
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_xcfa_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE axci801_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_xcfb_d.clear() 
      CALL g_xcfb2_d.clear()       
      CALL g_xcfb3_d.clear()       
 
     
      CALL axci801_ui_browser_refresh()  
      #CALL axci801_ui_headershow()  
      #CALL axci801_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL axci801_browser_fill("")
         CALL axci801_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE axci801_cl
 
   #功能已完成,通報訊息中心
   CALL axci801_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="axci801.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axci801_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_xcfb_d.clear()
   CALL g_xcfb2_d.clear()
   CALL g_xcfb3_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF axci801_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT xcfbseq,xcfb010,xcfb011,xcfb012,xcfb014,xcfb013,xcfbcomp ,t1.oocql004 FROM xcfb_t", 
                
                     " INNER JOIN xcfa_t ON xcfaent = " ||g_enterprise|| " AND xcfald = xcfbld ",
                     " AND xcfa001 = xcfb001 ",
                     " AND xcfa002 = xcfb002 ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN oocql_t t1 ON t1.oocqlent="||g_enterprise||" AND t1.oocql001='201' AND t1.oocql002=xcfb010 AND t1.oocql003='"||g_dlang||"' ",
 
                     " WHERE xcfbent=? AND xcfbld=? AND xcfb001=? AND xcfb002=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY xcfb_t.xcfbseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axci801_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR axci801_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_xcfa_m.xcfald,g_xcfa_m.xcfa001,g_xcfa_m.xcfa002   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_xcfa_m.xcfald,g_xcfa_m.xcfa001,g_xcfa_m.xcfa002 INTO g_xcfb_d[l_ac].xcfbseq, 
          g_xcfb_d[l_ac].xcfb010,g_xcfb_d[l_ac].xcfb011,g_xcfb_d[l_ac].xcfb012,g_xcfb_d[l_ac].xcfb014, 
          g_xcfb_d[l_ac].xcfb013,g_xcfb_d[l_ac].xcfbcomp,g_xcfb_d[l_ac].xcfb010_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         
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
    
   #判斷是否填充
   IF axci801_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT xcfcseq,xcfc013,xcfc010,xcfc011,xcfc012,xcfccomp ,t2.oocql004 FROM xcfc_t", 
                
                     " INNER JOIN  xcfa_t ON xcfaent = " ||g_enterprise|| " AND xcfald = xcfcld ",
                     " AND xcfa001 = xcfc001 ",
                     " AND xcfa002 = xcfc002 ",
 
                     "",
                     
                                    " LEFT JOIN oocql_t t2 ON t2.oocqlent="||g_enterprise||" AND t2.oocql001='201' AND t2.oocql002=xcfc013 AND t2.oocql003='"||g_dlang||"' ",
 
                     " WHERE xcfcent=? AND xcfcld=? AND xcfc001=? AND xcfc002=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY xcfc_t.xcfcseq"
         
         #add-point:單身填充控制 name="b_fill.sql2"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axci801_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR axci801_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise,g_xcfa_m.xcfald,g_xcfa_m.xcfa001,g_xcfa_m.xcfa002   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise,g_xcfa_m.xcfald,g_xcfa_m.xcfa001,g_xcfa_m.xcfa002 INTO g_xcfb2_d[l_ac].xcfcseq, 
          g_xcfb2_d[l_ac].xcfc013,g_xcfb2_d[l_ac].xcfc010,g_xcfb2_d[l_ac].xcfc011,g_xcfb2_d[l_ac].xcfc012, 
          g_xcfb2_d[l_ac].xcfccomp,g_xcfb2_d[l_ac].xcfc013_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill2.fill"
         
         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_ac
            LET g_errparam.code = 9035 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
      END FOREACH
   END IF
 
   #判斷是否填充
   IF axci801_fill_chk(3) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body3.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT xcfdseq,xcfd010,xcfdcomp  FROM xcfd_t",   
                     " INNER JOIN  xcfa_t ON xcfaent = " ||g_enterprise|| " AND xcfald = xcfdld ",
                     " AND xcfa001 = xcfd001 ",
                     " AND xcfa002 = xcfd002 ",
 
                     "",
                     
                     
                     " WHERE xcfdent=? AND xcfdld=? AND xcfd001=? AND xcfd002=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body3.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table3) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY xcfd_t.xcfdseq"
         
         #add-point:單身填充控制 name="b_fill.sql3"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axci801_pb3 FROM g_sql
         DECLARE b_fill_cs3 CURSOR FOR axci801_pb3
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs3 USING g_enterprise,g_xcfa_m.xcfald,g_xcfa_m.xcfa001,g_xcfa_m.xcfa002   #(ver:78)
                                               
      FOREACH b_fill_cs3 USING g_enterprise,g_xcfa_m.xcfald,g_xcfa_m.xcfa001,g_xcfa_m.xcfa002 INTO g_xcfb3_d[l_ac].xcfdseq, 
          g_xcfb3_d[l_ac].xcfd010,g_xcfb3_d[l_ac].xcfdcomp   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill3.fill"
         CALL axci801_xcfd010_desc() 
         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_ac
            LET g_errparam.code = 9035 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
      END FOREACH
   END IF
 
 
   
   #add-point:browser_fill段其他table處理 name="browser_fill.other_fill"
   
   #end add-point
   
   CALL g_xcfb_d.deleteElement(g_xcfb_d.getLength())
   CALL g_xcfb2_d.deleteElement(g_xcfb2_d.getLength())
   CALL g_xcfb3_d.deleteElement(g_xcfb3_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE axci801_pb
   FREE axci801_pb2
 
   FREE axci801_pb3
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_xcfb_d.getLength()
      LET g_xcfb_d_mask_o[l_ac].* =  g_xcfb_d[l_ac].*
      CALL axci801_xcfb_t_mask()
      LET g_xcfb_d_mask_n[l_ac].* =  g_xcfb_d[l_ac].*
   END FOR
   
   LET g_xcfb2_d_mask_o.* =  g_xcfb2_d.*
   FOR l_ac = 1 TO g_xcfb2_d.getLength()
      LET g_xcfb2_d_mask_o[l_ac].* =  g_xcfb2_d[l_ac].*
      CALL axci801_xcfc_t_mask()
      LET g_xcfb2_d_mask_n[l_ac].* =  g_xcfb2_d[l_ac].*
   END FOR
   LET g_xcfb3_d_mask_o.* =  g_xcfb3_d.*
   FOR l_ac = 1 TO g_xcfb3_d.getLength()
      LET g_xcfb3_d_mask_o[l_ac].* =  g_xcfb3_d[l_ac].*
      CALL axci801_xcfd_t_mask()
      LET g_xcfb3_d_mask_n[l_ac].* =  g_xcfb3_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="axci801.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION axci801_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM xcfb_t
       WHERE xcfbent = g_enterprise AND
         xcfbld = ps_keys_bak[1] AND xcfb001 = ps_keys_bak[2] AND xcfb002 = ps_keys_bak[3] AND xcfbseq = ps_keys_bak[4]
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
         CALL g_xcfb_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM xcfc_t
       WHERE xcfcent = g_enterprise AND
             xcfcld = ps_keys_bak[1] AND xcfc001 = ps_keys_bak[2] AND xcfc002 = ps_keys_bak[3] AND xcfcseq = ps_keys_bak[4]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xcfc_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_xcfb2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete3"
      
      #end add-point    
      DELETE FROM xcfd_t
       WHERE xcfdent = g_enterprise AND
             xcfdld = ps_keys_bak[1] AND xcfd001 = ps_keys_bak[2] AND xcfd002 = ps_keys_bak[3] AND xcfdseq = ps_keys_bak[4]
      #add-point:delete_b段刪除中 name="delete_b.m_delete3"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xcfd_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_xcfb3_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete3"
      
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="axci801.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION axci801_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO xcfb_t
                  (xcfbent,
                   xcfbld,xcfb001,xcfb002,
                   xcfbseq
                   ,xcfb010,xcfb011,xcfb012,xcfb014,xcfb013,xcfbcomp) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
                   ,g_xcfb_d[g_detail_idx].xcfb010,g_xcfb_d[g_detail_idx].xcfb011,g_xcfb_d[g_detail_idx].xcfb012, 
                       g_xcfb_d[g_detail_idx].xcfb014,g_xcfb_d[g_detail_idx].xcfb013,g_xcfb_d[g_detail_idx].xcfbcomp) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xcfb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_xcfb_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      
      #end add-point 
      INSERT INTO xcfc_t
                  (xcfcent,
                   xcfcld,xcfc001,xcfc002,
                   xcfcseq
                   ,xcfc013,xcfc010,xcfc011,xcfc012,xcfccomp) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
                   ,g_xcfb2_d[g_detail_idx].xcfc013,g_xcfb2_d[g_detail_idx].xcfc010,g_xcfb2_d[g_detail_idx].xcfc011, 
                       g_xcfb2_d[g_detail_idx].xcfc012,g_xcfb2_d[g_detail_idx].xcfccomp)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xcfc_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_xcfb2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert3"
      
      #end add-point 
      INSERT INTO xcfd_t
                  (xcfdent,
                   xcfdld,xcfd001,xcfd002,
                   xcfdseq
                   ,xcfd010,xcfdcomp) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
                   ,g_xcfb3_d[g_detail_idx].xcfd010,g_xcfb3_d[g_detail_idx].xcfdcomp)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xcfd_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_xcfb3_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert3"
      CALL axci801_xcfdcomp_upd() #160107-00009#1-add
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="axci801.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION axci801_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "xcfb_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL axci801_xcfb_t_mask_restore('restore_mask_o')
               
      UPDATE xcfb_t 
         SET (xcfbld,xcfb001,xcfb002,
              xcfbseq
              ,xcfb010,xcfb011,xcfb012,xcfb014,xcfb013,xcfbcomp) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
              ,g_xcfb_d[g_detail_idx].xcfb010,g_xcfb_d[g_detail_idx].xcfb011,g_xcfb_d[g_detail_idx].xcfb012, 
                  g_xcfb_d[g_detail_idx].xcfb014,g_xcfb_d[g_detail_idx].xcfb013,g_xcfb_d[g_detail_idx].xcfbcomp)  
 
         WHERE xcfbent = g_enterprise AND xcfbld = ps_keys_bak[1] AND xcfb001 = ps_keys_bak[2] AND xcfb002 = ps_keys_bak[3] AND xcfbseq = ps_keys_bak[4]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xcfb_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xcfb_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL axci801_xcfb_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "xcfc_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL axci801_xcfc_t_mask_restore('restore_mask_o')
               
      UPDATE xcfc_t 
         SET (xcfcld,xcfc001,xcfc002,
              xcfcseq
              ,xcfc013,xcfc010,xcfc011,xcfc012,xcfccomp) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
              ,g_xcfb2_d[g_detail_idx].xcfc013,g_xcfb2_d[g_detail_idx].xcfc010,g_xcfb2_d[g_detail_idx].xcfc011, 
                  g_xcfb2_d[g_detail_idx].xcfc012,g_xcfb2_d[g_detail_idx].xcfccomp) 
         WHERE xcfcent = g_enterprise AND xcfcld = ps_keys_bak[1] AND xcfc001 = ps_keys_bak[2] AND xcfc002 = ps_keys_bak[3] AND xcfcseq = ps_keys_bak[4]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xcfc_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xcfc_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL axci801_xcfc_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update2"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "xcfd_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update3"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL axci801_xcfd_t_mask_restore('restore_mask_o')
               
      UPDATE xcfd_t 
         SET (xcfdld,xcfd001,xcfd002,
              xcfdseq
              ,xcfd010,xcfdcomp) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
              ,g_xcfb3_d[g_detail_idx].xcfd010,g_xcfb3_d[g_detail_idx].xcfdcomp) 
         WHERE xcfdent = g_enterprise AND xcfdld = ps_keys_bak[1] AND xcfd001 = ps_keys_bak[2] AND xcfd002 = ps_keys_bak[3] AND xcfdseq = ps_keys_bak[4]
      #add-point:update_b段修改中 name="update_b.m_update3"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xcfd_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xcfd_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL axci801_xcfd_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update3"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
 
   
 
   
   #add-point:update_b段other name="update_b.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axci801.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION axci801_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="axci801.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION axci801_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="axci801.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION axci801_lock_b(ps_table,ps_page)
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
   #CALL axci801_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "xcfb_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN axci801_bcl USING g_enterprise,
                                       g_xcfa_m.xcfald,g_xcfa_m.xcfa001,g_xcfa_m.xcfa002,g_xcfb_d[g_detail_idx].xcfbseq  
                                               
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "axci801_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "xcfc_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN axci801_bcl2 USING g_enterprise,
                                             g_xcfa_m.xcfald,g_xcfa_m.xcfa001,g_xcfa_m.xcfa002,g_xcfb2_d[g_detail_idx].xcfcseq 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "axci801_bcl2:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'3',"
   #僅鎖定自身table
   LET ls_group = "xcfd_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN axci801_bcl3 USING g_enterprise,
                                             g_xcfa_m.xcfald,g_xcfa_m.xcfa001,g_xcfa_m.xcfa002,g_xcfb3_d[g_detail_idx].xcfdseq 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "axci801_bcl3:",SQLERRMESSAGE 
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
 
{<section id="axci801.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION axci801_unlock_b(ps_table,ps_page)
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
      CLOSE axci801_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE axci801_bcl2
   END IF
 
   LET ls_group = "'3',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE axci801_bcl3
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="axci801.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION axci801_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("xcfald",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("xcfald,xcfa001,xcfa002",TRUE)
      CALL cl_set_comp_entry("",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("xcfacomp",TRUE)
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axci801.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION axci801_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("xcfald,xcfa001,xcfa002",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      CALL cl_set_comp_entry("xcfacomp",FALSE)
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("xcfald",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axci801.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION axci801_set_entry_b(p_cmd)
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
      CALL cl_set_comp_entry("xcfbseq,xcfcseq,xcfdseq",TRUE)

      #end add-point  
   END IF
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   CALL cl_set_comp_required('xcfb010',TRUE)
   CALL cl_set_comp_required('xcfc010,xcfc011',TRUE) 
   
     
   
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="axci801.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION axci801_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point    
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="set_no_entry_b.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #add-point:set_no_entry_b段欄位控制 name="set_no_entry_b.field_control"
      CALL cl_set_comp_entry("xcfbseq,xcfcseq,xcfdseq",FALSE)
      #end add-point 
   END IF 
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b"
   IF g_xcfa_m.xcfa004 = '1' THEN      
      CALL cl_set_comp_required('xcfc010,xcfc011',FALSE) 
   ELSE
      CALL cl_set_comp_required('xcfb010',FALSE)                    
   END IF
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="axci801.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION axci801_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axci801.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION axci801_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axci801.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION axci801_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axci801.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION axci801_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axci801.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION axci801_default_search()
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
   
   #end add-point  
   
   #add-point:Function前置處理 name="default_search.before"
   
   #end add-point  
   
   LET g_pagestart = 1
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " xcfald = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " xcfa001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " xcfa002 = '", g_argv[03], "' AND "
   END IF
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   
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
         INITIALIZE g_wc2_table2 TO NULL
 
         INITIALIZE g_wc2_table3 TO NULL
 
 
         FOR li_idx = 1 TO la_wc.getLength()
            CASE
               WHEN la_wc[li_idx].tableid = "xcfa_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "xcfb_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "xcfc_t" 
                  LET g_wc2_table2 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "xcfd_t" 
                  LET g_wc2_table3 = la_wc[li_idx].wc
 
 
               WHEN la_wc[li_idx].tableid = "EXTENDWC"
                  LET g_wc2_extend = la_wc[li_idx].wc
            END CASE
         END FOR
         IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
            OR NOT cl_null(g_wc2_table2)
 
            OR NOT cl_null(g_wc2_table3)
 
 
            OR NOT cl_null(g_wc2_extend)
            THEN
            #組合g_wc2
            IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
               LET g_wc2 = g_wc2_table1
            END IF
            IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
            END IF
 
            IF g_wc2_table3 <> " 1=1" AND NOT cl_null(g_wc2_table3) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
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
   
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="axci801.state_change" >}
   
 
{</section>}
 
{<section id="axci801.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION axci801_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_xcfb_d.getLength() THEN
         LET g_detail_idx = g_xcfb_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_xcfb_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xcfb_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_xcfb2_d.getLength() THEN
         LET g_detail_idx = g_xcfb2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_xcfb2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xcfb2_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_xcfb3_d.getLength() THEN
         LET g_detail_idx = g_xcfb3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_xcfb3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xcfb3_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axci801.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axci801_b_fill2(pi_idx)
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
   
   CALL axci801_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="axci801.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION axci801_fill_chk(ps_idx)
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
   IF (cl_null(g_wc2_table1) OR g_wc2_table1.trim() = '1=1')  AND 
      (cl_null(g_wc2_table2) OR g_wc2_table2.trim() = '1=1')  AND 
      (cl_null(g_wc2_table3) OR g_wc2_table3.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk name="fill_chk.other_chk"
      
      #end add-point
      RETURN TRUE
   END IF
   
   #add-point:fill_chk段after_chk name="fill_chk.after_chk"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axci801.status_show" >}
PRIVATE FUNCTION axci801_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axci801.mask_functions" >}
&include "erp/axc/axci801_mask.4gl"
 
{</section>}
 
{<section id="axci801.signature" >}
   
 
{</section>}
 
{<section id="axci801.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION axci801_set_pk_array()
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
   LET g_pk_array[1].values = g_xcfa_m.xcfald
   LET g_pk_array[1].column = 'xcfald'
   LET g_pk_array[2].values = g_xcfa_m.xcfa001
   LET g_pk_array[2].column = 'xcfa001'
   LET g_pk_array[3].values = g_xcfa_m.xcfa002
   LET g_pk_array[3].column = 'xcfa002'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axci801.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="axci801.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION axci801_msgcentre_notify(lc_state)
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
   CALL axci801_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_xcfa_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axci801.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION axci801_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="axci801.other_function" readonly="Y" >}

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
PRIVATE FUNCTION axci801_xcfd010_desc()
   
   CALL s_desc_get_stock_desc(g_site,g_xcfb3_d[l_ac].xcfd010) RETURNING g_xcfb3_d[l_ac].xcfd010_desc
      
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
PRIVATE FUNCTION axci801_chk_ld_comp()
   DEFINE r_success        LIKE type_t.num5
   DEFINE l_success        LIKE type_t.num5
   
   LET r_success = TRUE

#只检查法人
   IF g_xcfa_m.xcfald IS NULL AND g_xcfa_m.xcfacomp IS NOT NULL THEN   
      #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
      INITIALIZE g_chkparam.* TO NULL
      
      #設定g_chkparam.*的參數
      LET g_chkparam.arg1 = g_xcfa_m.xcfacomp
         
      #呼叫檢查存在並帶值的library
      IF cl_chk_exist("v_ooef001_1") THEN
         #檢查成功時後續處理
         #LET  = g_chkparam.return1
         #DISPLAY BY NAME 
      ELSE
         #檢查失敗時後續處理
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF

#只检查账套
   IF g_xcfa_m.xcfald IS NOT NULL AND g_xcfa_m.xcfacomp IS NULL THEN
      #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
      INITIALIZE g_chkparam.* TO NULL
      
      #設定g_chkparam.*的參數
      LET g_chkparam.arg1 = g_xcfa_m.xcfald
      #160318-00025#8--add--str
      LET g_errshow = TRUE 
      LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
      #160318-00025#8--add--end  
      #呼叫檢查存在並帶值的library
      IF cl_chk_exist("v_glaald") THEN
         #檢查成功時後續處理
         #LET  = g_chkparam.return1
         #DISPLAY BY NAME 
         CALL s_ld_chk_authorization(g_user,g_xcfa_m.xcfald) RETURNING l_success
         IF l_success = FALSE THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'axr-00022'
            LET g_errparam.extend = g_xcfa_m.xcfald
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success
         END IF 
      ELSE
         #檢查失敗時後續處理
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF

#法人账套都存在，检查他们的关系
   IF NOT s_ld_chk_comp(g_xcfa_m.xcfald,g_xcfa_m.xcfacomp) THEN  #v_glaald_5 
      LET g_xcfa_m.xcfacomp = g_xcfa_m_t.xcfacomp
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
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
PRIVATE FUNCTION axci801_ref()
INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xcfa_m.xcfald
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcfa_m.xcfald_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcfa_m.xcfald_desc 
  
   IF g_xcfa_m.xcfacomp IS NULL THEN     
      SELECT glaacomp
        INTO g_xcfa_m.xcfacomp
        FROM glaa_t  
       WHERE glaaent = g_enterprise 
         AND glaald = g_xcfa_m.xcfald
      DISPLAY BY NAME g_xcfa_m.xcfacomp
   END IF
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xcfa_m.xcfacomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcfa_m.xcfacomp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcfa_m.xcfacomp_desc

   
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
PRIVATE FUNCTION axci801_chk_year_period()
   DEFINE r_success        LIKE type_t.num5
   DEFINE l_bdate          LIKE type_t.dat    #起始年度+期別對應的起始截止日期
   DEFINE l_edate          LIKE type_t.dat
   DEFINE l_glaa003        LIKE glaa_t.glaa003
   DEFINE l_date  DATE
   DEFINE l_cnt            LIKE type_t.num5
   LET r_success = TRUE 
   SELECT glaa003 INTO l_glaa003
        FROM glaa_t
       WHERE glaaent  = g_enterprise
         AND glaacomp = g_xcfa_m.xcfacomp
         AND glaa014  = 'Y'   
   IF g_xcfa_m.xcfa001 IS NOT NULL AND g_xcfa_m.xcfa002 IS NULL THEN
      IF NOT s_fin_date_chk_year(g_xcfa_m.xcfa001) THEN
#      LET g_xcfa_m.xcfa001 = g_xcfa001_t
#      DISPLAY BY NAME g_xcfa_m.xcfa001
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = 'aoo-00113'
#         LET g_errparam.extend = g_xcfa_m.xcfa001
#         LET g_errparam.popup = TRUE
#         CALL cl_err()      
         LET r_success = FALSE
         RETURN r_success      
      END IF
      SELECT COUNT(*) INTO l_cnt FROM glav_t
      WHERE glavent = g_enterprise
        AND glav001 = l_glaa003
        AND glav002 = g_xcfa_m.xcfa001
        AND glavstus = 'Y' 
      IF l_cnt = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'axc-00581'
         LET g_errparam.extend = g_xcfa_m.xcfa001
         LET g_errparam.popup = TRUE
         CALL cl_err() 
         LET r_success = FALSE
         RETURN r_success 
      END IF
   END IF
   
#有年度有期别，年度期别所属的结束日期，不得小于等于关账日期
   IF g_xcfa_m.xcfa001 IS NOT NULL AND g_xcfa_m.xcfa002 IS NOT NULL THEN
#抓出会计周期参考表号  glaa003
       

      IF NOT s_fin_date_chk_period(l_glaa003,g_xcfa_m.xcfa001,g_xcfa_m.xcfa002) THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = 'afa-00119'
#         LET g_errparam.extend = g_xcfa_m.xcfa002
#         LET g_errparam.popup = TRUE
#         CALL cl_err()

#         LET g_xcfa_m.xcfa002 = g_xcfa002_t
#         DISPLAY BY NAME g_xcfa_m.xcfa002
         LET r_success = FALSE
         RETURN r_success      
      END IF
   END IF
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 給xcfdcomp值
# Memo...........:
# Usage..........: CALL axci801_xcfdcomp_upd()
# Input parameter: 
# Return code....:
# Date & Author..: 2016/01/07 By Dorislai(160107-00009#1)
# Modify.........:
################################################################################
PRIVATE FUNCTION axci801_xcfdcomp_upd()
   DEFINE l_xcfdcomp LIKE xcfd_t.xcfdcomp
   
   LET l_xcfdcomp = g_xcfa_m.xcfacomp
   
   UPDATE xcfd_t SET xcfdcomp = l_xcfdcomp 
    WHERE xcfdent = g_enterprise 
      AND xcfdld = g_xcfa_m.xcfald
      AND xcfd001 = g_xcfa_m.xcfa001
      AND xcfd002 = g_xcfa_m.xcfa002
      
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = 'FOREACH:' 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err() 
   END IF
END FUNCTION

################################################################################
# Descriptions...: 單價起訖大小檢查
# Memo...........:
# Usage..........: CALL axci801_xcfb012_014_chk()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success   TRUE/FALSE
# Date & Author..: 2016/11/16 By shiun
# Modify.........: 161108-00037#2
################################################################################
PRIVATE FUNCTION axci801_xcfb012_014_chk()
   DEFINE r_success  LIKE type_t.num5
   
   LET r_success = TRUE
   IF NOT cl_null(g_xcfb_d[l_ac].xcfb012) AND NOT cl_null(g_xcfb_d[l_ac].xcfb014) THEN
      IF g_xcfb_d[l_ac].xcfb012 > g_xcfb_d[l_ac].xcfb014 THEN
         LET g_errparam.code   = 'axc-00796'     #單價(起)值不可大於單價(訖)！
         LET g_errparam.popup  = TRUE
         LET r_success = FALSE
         CALL cl_err()
      END IF
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 單價起訖檢查
# Memo...........:
# Usage..........: CALL axci801_xcfb012_014_chk2()
#                  RETURNING r_success
# Input parameter: p_price     輸入單價
# Return code....: r_success   TRUE/FALSE
# Date & Author..: 2016/11/16 By shiun
# Modify.........: 161108-00037#2
################################################################################
PRIVATE FUNCTION axci801_xcfb012_014_chk2(p_price)
   DEFINE p_price    LIKE xcfb_t.xcfb012
   DEFINE r_success  LIKE type_t.num5
   DEFINE l_sql      STRING
   DEFINE l_xcfb012  LIKE xcfb_t.xcfb012
   DEFINE l_xcfb014  LIKE xcfb_t.xcfb014
   DEFINE l_success  LIKE type_t.num5
   
   LET r_success = TRUE
   
   LET l_sql = " SELECT xcfb012,xcfb014 ",
               "   FROM xcfb_t ",
               "  WHERE xcfbent = '",g_enterprise,"' ",
               "    AND xcfbld = '",g_xcfa_m.xcfald,"' ",
               "    AND xcfb001 = '",g_xcfa_m.xcfa001,"' ",
               "    AND xcfb002 = '",g_xcfa_m.xcfa002,"' ",
               "    AND xcfbseq <> '",g_xcfb_d[l_ac].xcfbseq,"' "
   PREPARE axci801_price_chk_p FROM l_sql
   DECLARE axci801_price_chk_c CURSOR FOR axci801_price_chk_p
   
   CALL cl_err_collect_init()
   FOREACH axci801_price_chk_c INTO l_xcfb012,l_xcfb014
      IF NOT cl_null(p_price) THEN
         IF p_price >= l_xcfb012 AND p_price <= l_xcfb014 THEN
            LET g_errparam.code   = 'axc-00795'     #輸入的單價起訖範圍不可為:起%1~訖%2！\
            LET g_errparam.extend = p_price
            LET g_errparam.popup  = TRUE
            LET g_errparam.replace[1] = l_xcfb012
            LET g_errparam.replace[2] = l_xcfb014
            LET r_success = FALSE
            CALL cl_err()
         END IF
      END IF
   END FOREACH
   
   CALL cl_err_collect_show()
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 檢核天數不可重覆
# Memo...........:
# Usage..........: CALL axci801_chk_xcfc013()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success  TRUE/FALSE
# Date & Author..: #161108-00037#6 By 02040
# Modify.........:
################################################################################
PRIVATE FUNCTION axci801_chk_xcfc013()
DEFINE r_success  LIKE type_t.num5
DEFINE l_a        LIKE type_t.num5

  LET r_success  = TRUE
  
  IF NOT cl_null(g_xcfb2_d[l_ac].xcfc013) THEN
     FOR l_a = 1 TO g_xcfb2_d.getlength()
         IF l_a = l_ac THEN CONTINUE FOR END IF
         IF cl_null(g_xcfb2_d[l_a].xcfc013) THEN
            CONTINUE FOR
         END IF
         IF g_xcfb2_d[l_a].xcfc013 = g_xcfb2_d[l_ac].xcfc013 THEN
            IF g_xcfb2_d[l_ac].xcfc010 <= g_xcfb2_d[l_a].xcfc011 AND g_xcfb2_d[l_ac].xcfc010 >= g_xcfb2_d[l_a].xcfc010 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "" 
               LET g_errparam.code   = "axc-00580" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET r_success = FALSE
               RETURN r_success               
            END IF
            IF g_xcfb2_d[l_ac].xcfc011 <= g_xcfb2_d[l_a].xcfc011 AND g_xcfb2_d[l_ac].xcfc011 >= g_xcfb2_d[l_a].xcfc010 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "" 
               LET g_errparam.code   = "axc-00580" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET r_success = FALSE
               RETURN r_success                  
            END IF
            
         END IF     
     END FOR
  ELSE
     FOR l_a = 1 TO g_xcfb2_d.getlength()
         IF l_a = l_ac THEN CONTINUE FOR END IF
         IF NOT cl_null(g_xcfb2_d[l_a].xcfc013) THEN
            CONTINUE FOR
         END IF
         IF g_xcfb2_d[l_ac].xcfc010 <= g_xcfb2_d[l_a].xcfc011 AND g_xcfb2_d[l_ac].xcfc010 >= g_xcfb2_d[l_a].xcfc010 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "" 
            LET g_errparam.code   = "axc-00580" 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success               
         END IF
         IF g_xcfb2_d[l_ac].xcfc011 <= g_xcfb2_d[l_a].xcfc011 AND g_xcfb2_d[l_ac].xcfc011 >= g_xcfb2_d[l_a].xcfc010 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "" 
            LET g_errparam.code   = "axc-00580" 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success                  
         END IF       
     END FOR  
  END IF
  
  RETURN r_success

END FUNCTION

 
{</section>}
 
