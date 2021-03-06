{<section id="aiss010.description" >}
#+ Version..: T100-ERP-1.00.00(SD版次:1,PR版次:1) Build-000062
#+ 
#+ Filename...: aiss010
#+ Description: 稅區參數設定作業
#+ Creator....: 02295(13/11/22)
#+ Modifier...: 02114(13/11/22)
#+ Buildtype..: 應用 i01 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="aiss010.global" >}

 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔

#end add-point
 
#單頭 type 宣告
PRIVATE TYPE type_g_isai_m RECORD
       isai001 LIKE isai_t.isai001, 
   isai001_desc LIKE type_t.chr80, 
   isai002 LIKE isai_t.isai002, 
   isai003 LIKE isai_t.isai003, 
   isai003_desc LIKE type_t.chr80, 
   isaistus LIKE isai_t.isaistus, 
   isaiownid LIKE isai_t.isaiownid, 
   isaiownid_desc LIKE type_t.chr80, 
   isaiowndp LIKE isai_t.isaiowndp, 
   isaiowndp_desc LIKE type_t.chr80, 
   isaicrtid LIKE isai_t.isaicrtid, 
   isaicrtid_desc LIKE type_t.chr80, 
   isaicrtdp LIKE isai_t.isaicrtdp, 
   isaicrtdp_desc LIKE type_t.chr80, 
   isaicrtdt DATETIME YEAR TO SECOND, 
   isaimodid LIKE isai_t.isaimodid, 
   isaimodid_desc LIKE type_t.chr80, 
   isaimoddt DATETIME YEAR TO SECOND
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_isai_m        type_g_isai_m  #單頭變數宣告
DEFINE g_isai_m_t      type_g_isai_m  #單頭舊值宣告(系統還原用)
DEFINE g_isai_m_o      type_g_isai_m  #單頭舊值宣告(其他用途)
 
   DEFINE g_isai001_t LIKE isai_t.isai001
 
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD  #查詢方案用陣列 
         b_statepic     LIKE type_t.chr50,
            b_isai001 LIKE isai_t.isai001
      END RECORD 
   
 
   
 
DEFINE g_wc                  STRING                        #儲存查詢條件
DEFINE g_wc_t                STRING                        #備份查詢條件
DEFINE g_wc_filter           STRING                        #儲存過濾查詢條件
DEFINE g_wc_filter_t         STRING                        #備份過濾查詢條件
DEFINE g_sql                 STRING                        #資料撈取用SQL(含reference)
DEFINE g_forupd_sql          STRING                        #資料鎖定用SQL
DEFINE g_cnt                 LIKE type_t.num10             #指標/統計用變數
DEFINE g_jump                LIKE type_t.num10             #查詢指定的筆數 
DEFINE g_no_ask              LIKE type_t.num5              #是否開啟指定筆視窗 
DEFINE g_rec_b               LIKE type_t.num5              #單身筆數                         
DEFINE l_ac                  LIKE type_t.num5              #目前處理的ARRAY CNT 
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog     
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_pagestart           LIKE type_t.num5              #page起始筆數
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
DEFINE g_ch                  base.Channel                  #外串程式用
DEFINE g_state               STRING                        #確認前一個動作是否為新增/複製
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #reference用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #reference用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #reference用陣列
DEFINE g_error_show          LIKE type_t.num5              #是否顯示資料過多的錯誤訊息
DEFINE g_aw                  STRING                        #確定當下點擊的單身(modify_detail用)
DEFINE g_chk                 BOOLEAN                       #助記碼判斷用
DEFINE g_default             BOOLEAN                       #是否有外部參數查詢
DEFINE g_log1                STRING                        #cl_log_modified_record用(舊值)
DEFINE g_log2                STRING                        #cl_log_modified_record用(新值)
 
#快速搜尋用
DEFINE g_searchcol           STRING                        #查詢欄位代碼
DEFINE g_searchstr           STRING                        #查詢欄位字串
DEFINE g_order               STRING                        #查詢排序模式
 
#Browser用
DEFINE g_current_idx         LIKE type_t.num5              #Browser 所在筆數(當下page)
DEFINE g_current_row         LIKE type_t.num5              #Browser 所在筆數(暫存用)
DEFINE g_current_cnt         LIKE type_t.num10             #Browser 總筆數(當下page)
DEFINE g_browser_idx         LIKE type_t.num5              #Browser 所在筆數(所有資料)
DEFINE g_browser_cnt         LIKE type_t.num5              #Browser 總筆數(所有資料)
DEFINE g_row_index           LIKE type_t.num5              #階層樹狀用指標
 
#add-point:自定義模組變數(Module Variable)

#end add-point
 
#add-point:傳入參數說明(global.argv)

#end add-point
 
{</section>}
 
{<section id="aiss010.main" >}
#+ 此段落由子樣板a26產生
#OPTIONS SHORT CIRCUIT
#+ 作業開始 
MAIN
   #add-point:main段define
   
   #end add-point   
 
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ais","")
 
   #add-point:作業初始化
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = " SELECT isai001,'',isai002,isai003,'',isaistus,isaiownid,'',isaiowndp,'',isaicrtid, 
       '',isaicrtdp,'',isaicrtdt,isaimodid,'',isaimoddt", 
                      " FROM isai_t",
                      " WHERE isaient= ? AND isai001=? FOR UPDATE"
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aiss010_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT UNIQUE isai001,isai002,isai003,isaistus,isaiownid,isaiowndp,isaicrtid,isaicrtdp, 
       isaicrtdt,isaimodid,isaimoddt,t1.ooall004 ,t2.isacl004 ,t3.oofa011 ,t4.ooeal003 ,t5.oofa011 , 
       t6.ooeal003 ,t7.oofa011",
               " FROM isai_t",
                              " LEFT JOIN ooall_t t1 ON t1.ooallent='"||g_enterprise||"' AND t1.ooall001='2' AND t1.ooall002=isai001 AND t1.ooall003='"||g_dlang||"' ",
               " LEFT JOIN isacl_t t2 ON t2.isaclent='"||g_enterprise||"' AND t2.isacl001=isai001 AND t2.isacl002=isai003 AND t2.isacl003='"||g_dlang||"' ",
               " LEFT JOIN oofa_t t3 ON t3.oofaent='"||g_enterprise||"' AND t3.oofa002='2' AND t3.oofa003=isaiownid  ",
               " LEFT JOIN ooeal_t t4 ON t4.ooealent='"||g_enterprise||"' AND t4.ooeal001=isaiowndp AND t4.ooeal002='"||g_dlang||"' ",
               " LEFT JOIN oofa_t t5 ON t5.oofaent='"||g_enterprise||"' AND t5.oofa002='2' AND t5.oofa003=isaicrtid  ",
               " LEFT JOIN ooeal_t t6 ON t6.ooealent='"||g_enterprise||"' AND t6.ooeal001=isaicrtdp AND t6.ooeal002='"||g_dlang||"' ",
               " LEFT JOIN oofa_t t7 ON t7.oofaent='"||g_enterprise||"' AND t7.oofa002='2' AND t7.oofa003=isaimodid  ",
 
               " WHERE isaient = '" ||g_enterprise|| "' AND isai001 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define
   
   #end add-point
   PREPARE aiss010_master_referesh FROM g_sql
 
 
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aiss010 WITH FORM cl_ap_formpath("ais",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aiss010_init()   
 
      #進入選單 Menu (="N")
      CALL aiss010_ui_dialog() 
      
      #add-point:畫面關閉前
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aiss010
      
   END IF 
   
   CLOSE aiss010_cl
   
   
 
   #add-point:作業離開前
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN
 
 
 
{</section>}
 
{<section id="aiss010.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aiss010_init()
   #add-point:init段define
   
   #end add-point
 
   #定義combobox狀態
      CALL cl_set_combo_scc_part('isaistus','13','N,X,Y')
 
      CALL cl_set_combo_scc('isai002','9714') 
 
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   #add-point:畫面資料初始化
   
   #end add-point
   
   #根據外部參數進行搜尋
   CALL aiss010_default_search()
 
END FUNCTION
 
{</section>}
 
{<section id="aiss010.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aiss010_ui_dialog() 
   DEFINE li_exit   LIKE type_t.num5        #判別是否為離開作業
   DEFINE li_idx    LIKE type_t.num5        #指標變數
   DEFINE ls_wc     STRING                  #wc用
   DEFINE la_param  RECORD                  #程式串查用變數
             prog   STRING,                 #串查程式名稱
             param  DYNAMIC ARRAY OF STRING #傳遞變數
                    END RECORD
   DEFINE ls_js     STRING                  #轉換後的json字串
   #add-point:ui_dialog段define
   
   #end add-point
   
   LET li_exit = FALSE
   LET g_current_row = 0
   LET g_current_idx = 1
   
   
   
   #action default動作
   #+ 此段落由子樣板a42產生
   CASE g_actdefault
      WHEN "insert"
         LET g_action_choice="insert"
         LET g_actdefault = ""
         IF cl_auth_chk_act("insert") THEN
            CALL aiss010_insert()
            #add-point:ON ACTION insert
            
            #END add-point
         END IF
 
      #add-point:action default自訂
      
      #end add-point
      OTHERWISE
         
   END CASE
 
 
   
   #add-point:ui_dialog段before dialog 
   
   #end add-point
 
   WHILE li_exit = FALSE
      
      CALL aiss010_browser_fill(g_wc,"")
      
      #判斷前一個動作是否為新增或複製, 若是的話切換到新增的筆數
      IF g_state = "Y" THEN
         FOR li_idx = 1 TO g_browser.getLength()
            IF g_browser[li_idx].b_isai001 = g_isai001_t
 
               THEN
               LET g_current_row = li_idx
               EXIT FOR
            END IF
         END FOR
         LET g_state = ""
      END IF
    
      IF g_main_hidden = 0 THEN
         MENU
            BEFORE MENU 
                  
               CALL cl_navigator_setting(g_current_idx, g_current_cnt)
               
               #還原為原本指定筆數
               IF g_current_row > 0 THEN
                  LET g_current_idx = g_current_row
               END IF
               
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL aiss010_fetch("")   
               END IF               
            
            #狀態碼切換
            ON ACTION statechange
               CALL aiss010_statechange()
               LET g_action_choice="statechange"
               
            #第一筆資料
            ON ACTION first
               CALL aiss010_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL aiss010_fetch("N")
               LET g_current_row = g_current_idx
            
            #指定筆資料
            ON ACTION jump
               CALL aiss010_fetch("/")
               LET g_current_row = g_current_idx
            
            #上一筆資料
            ON ACTION previous
               CALL aiss010_fetch("P")
               LET g_current_row = g_current_idx
            
            #最後筆資料
            ON ACTION last 
               CALL aiss010_fetch("L")  
               LET g_current_row = g_current_idx
            
            #離開程式
            ON ACTION exit
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT MENU 
            
            #離開程式
            ON ACTION close
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT MENU
            
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
               END IF
               EXIT MENU
               
            ON ACTION worksheethidden   #瀏覽頁折疊
            
            #單頭摺疊，可利用hot key "Ctrl-s"開啟/關閉單頭
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
          
            #查詢方案用
            ON ACTION queryplansel
               CALL cl_dlg_qryplan_select() RETURNING ls_wc
               #不是空條件才寫入g_wc跟重新找資料
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  CALL aiss010_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL aiss010_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     CALL cl_err("","-100",1)
                     CLEAR FORM
                  ELSE
                     CALL aiss010_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
            
            
         #+ 此段落由子樣板a43產生
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aiss010_delete()
               #add-point:ON ACTION delete
               
               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aiss010_insert()
               #add-point:ON ACTION insert
               
               #END add-point
               EXIT MENU
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL aiss010_modify()
               #add-point:ON ACTION modify
               
               #END add-point
               EXIT MENU
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output
               
               #END add-point
               EXIT MENU
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aiss010_query()
               #add-point:ON ACTION query
               
               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL aiss010_reproduce()
               #add-point:ON ACTION reproduce
               
               #END add-point
               EXIT MENU
            END IF
 
 
            
            
            
            #+ 此段落由子樣板a46產生
         #新增相關文件
         ON ACTION related_document
            CALL aiss010_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aiss010_set_pk_array()
            #add-point:ON ACTION agendum
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aiss010_set_pk_array()
            #add-point:ON ACTION followup
            
            #END add-point
            CALL cl_user_overview_follow('')
 
 
            
            #主選單用ACTION
            &include "main_menu.4gl"
            &include "relating_action.4gl"
            #交談指令共用ACTION
            &include "common_action.4gl"
            
         END MENU
      
      ELSE
      
         DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
           
      
            #左側瀏覽頁簽
            DISPLAY ARRAY g_browser TO s_browse.* ATTRIBUTE(COUNT=g_rec_b)
            
               BEFORE ROW
                  #回歸舊筆數位置 (回到當時異動的筆數)
                  LET g_current_idx = DIALOG.getCurrentRow("s_browse")
                  IF g_current_idx = 0 THEN
                     LET g_current_idx = 1
                  END IF
                  LET g_current_row = g_current_idx  #目前指標
                  LET g_current_sw = TRUE
                  CALL cl_show_fld_cont()     
                  
                  #當每次點任一筆資料都會需要用到               
                  CALL aiss010_fetch("")      
                  
               
            
            END DISPLAY
 
            #add-point:ui_dialog段自定義display array
            
            #end add-point
 
         
            BEFORE DIALOG
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL aiss010_fetch("")   
               END IF               
               
            AFTER DIALOG
               #add-point:ui_dialog段 after dialog
               
               #end add-point
            
            #狀態碼切換
            ON ACTION statechange
               LET g_action_choice="statechange"
               CALL aiss010_statechange()
               EXIT DIALOG
         
            
            
            #第一筆資料
            ON ACTION first
               CALL aiss010_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL aiss010_fetch("N")
               LET g_current_row = g_current_idx
         
            #指定筆資料
            ON ACTION jump
               CALL aiss010_fetch("/")
               LET g_current_row = g_current_idx
         
            #上一筆資料
            ON ACTION previous
               CALL aiss010_fetch("P")
               LET g_current_row = g_current_idx
          
            #最後筆資料
            ON ACTION last 
               CALL aiss010_fetch("L")  
               LET g_current_row = g_current_idx
         
            #離開程式
            ON ACTION exit
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT DIALOG 
         
            #離開程式
            ON ACTION close
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
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
               END IF
               EXIT DIALOG
               
         
            #單頭摺疊，可利用hot key "Ctrl-s"開啟/關閉單頭
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
 
            
            #查詢方案用
            ON ACTION queryplansel
               CALL cl_dlg_qryplan_select() RETURNING ls_wc
               #不是空條件才寫入g_wc跟重新找資料
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  CALL aiss010_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL aiss010_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     CALL cl_err("","-100",1)
                     CLEAR FORM
                  ELSE
                     CALL aiss010_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
               
            
         #+ 此段落由子樣板a43產生
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aiss010_delete()
               #add-point:ON ACTION delete
               
               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aiss010_insert()
               #add-point:ON ACTION insert
               
               #END add-point
               EXIT DIALOG
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL aiss010_modify()
               #add-point:ON ACTION modify
               
               #END add-point
               EXIT DIALOG
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output
               
               #END add-point
               EXIT DIALOG
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aiss010_query()
               #add-point:ON ACTION query
               
               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL aiss010_reproduce()
               #add-point:ON ACTION reproduce
               
               #END add-point
               EXIT DIALOG
            END IF
 
 
            
            
 
            #+ 此段落由子樣板a46產生
         #新增相關文件
         ON ACTION related_document
            CALL aiss010_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aiss010_set_pk_array()
            #add-point:ON ACTION agendum
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aiss010_set_pk_array()
            #add-point:ON ACTION followup
            
            #END add-point
            CALL cl_user_overview_follow('')
 
 
 
            #主選單用ACTION
            &include "main_menu.4gl"
            &include "relating_action.4gl"
            #交談指令共用ACTION
            &include "common_action.4gl"
            
         END DIALOG 
      
      END IF
      
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="aiss010.browser_fill" >}
#+ 瀏覽頁簽資料填充(一般單檔)
PRIVATE FUNCTION aiss010_browser_fill(p_wc,ps_page_action) 
   DEFINE p_wc              STRING
   DEFINE ps_page_action    STRING
   DEFINE l_searchcol       STRING
   DEFINE l_sql             STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define
   
   #end add-point
   
   CLEAR FORM
   INITIALIZE g_isai_m.* TO NULL
   INITIALIZE g_wc TO NULL
   CALL g_browser.clear()
   
   #搜尋用
   IF cl_null(g_searchcol) OR g_searchcol = "0" THEN
      LET l_searchcol = "isai001"
   ELSE
      LET l_searchcol = g_searchcol
   END IF
 
   LET p_wc = p_wc.trim() #當查詢按下Q時 按下放棄 g_wc = "  " 所以要清掉空白
   IF cl_null(p_wc) THEN  #p_wc 查詢條件
      LET p_wc = " 1=1 " 
   END IF
   
   #add-point:browser_fill段wc控制
   
   #end add-point
 
   LET g_sql = " SELECT COUNT(*) FROM isai_t ",
               "  ",
               "  ",
               " WHERE isaient = '" ||g_enterprise|| "' AND ", 
               p_wc CLIPPED, cl_sql_add_filter("isai_t")
                
   #add-point:browser_fill段cnt_sql
   
   #end add-point
                
   PREPARE header_cnt_pre FROM g_sql
   EXECUTE header_cnt_pre INTO g_browser_cnt
   FREE header_cnt_pre 
   
   #若超過最大顯示筆數
   
   
   DISPLAY g_browser_cnt TO FORMONLY.b_count
   DISPLAY g_browser_cnt TO FORMONLY.h_count
   
   LET g_wc = p_wc
   
   IF ps_page_action = "F" OR
      ps_page_action = "P"  OR
      ps_page_action = "N"  OR
      ps_page_action = "L"  THEN
      LET g_page_action = ps_page_action
   END IF
   
   LET g_sql = " SELECT isaistus,isai001",
               " FROM isai_t ",
               "  ",
               "  ",
               
               " WHERE isaient = '" ||g_enterprise|| "' AND ", g_wc, cl_sql_add_filter("isai_t"),
               "  ORDER BY ",l_searchcol," ",g_order
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:browser_fill段before_pre
   
   #end add-point                    
 
   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre
 
   CALL g_browser.clear()
   LET g_cnt = 1
   FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_isai001
      IF SQLCA.sqlcode THEN
         CALL cl_err("foreach:",SQLCA.sqlcode,1)
         EXIT FOREACH
      END IF
      
      
      
      #add-point:browser_fill段reference
      
      #end add-point
      
            #此段落由子樣板a24產生
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/open.png"
         WHEN "X"
            LET g_browser[g_cnt].b_statepic = "stus/16/invalid.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
         
      END CASE
 
 
      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         CALL cl_err("Max_Row:"||g_max_rec USING "<<<<<","std-00002",0)
         EXIT FOREACH
      END IF
   END FOREACH
 
   CALL g_browser.deleteElement(g_cnt)
   LET g_header_cnt = g_browser_cnt
   LET g_rec_b = g_cnt - 1
   LET g_current_cnt = g_browser_cnt
   LET g_cnt = 0
   
   
   FREE browse_pre
   
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,delete,reproduce", FALSE)
   ELSE
      CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   END IF
   
END FUNCTION
 
 
 
{</section>}
 
{<section id="aiss010.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aiss010_construct()
   DEFINE ls_return      STRING
   DEFINE ls_result      STRING 
   DEFINE ls_wc          STRING 
   #add-point:cs段define
   
   #end add-point
   
   #清空畫面&資料初始化
   CLEAR FORM
   INITIALIZE g_isai_m.* TO NULL
   INITIALIZE g_wc TO NULL
   LET g_current_row = 1
 
   LET g_qryparam.state = "c"
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #螢幕上取條件
      CONSTRUCT BY NAME g_wc ON isai001,isai002,isai003,isaistus,isaiownid,isaiowndp,isaicrtid,isaicrtdp, 
          isaicrtdt,isaimodid,isaimoddt
      
         BEFORE CONSTRUCT                                    
            #add-point:cs段more_construct
            
            #end add-point             
      
         #公用欄位開窗相關處理
         #此段落由子樣板a11產生
         ##----<<isaicrtdt>>----
         AFTER FIELD isaicrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<isaimoddt>>----
         AFTER FIELD isaimoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<isaicnfdt>>----
         
         #----<<isaipstdt>>----
 
 
      
         #一般欄位
                  #Ctrlp:construct.c.isai001
         ON ACTION controlp INFIELD isai001
            #add-point:ON ACTION controlp INFIELD isai001
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooal002_11()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO isai001  #顯示到畫面上
            NEXT FIELD isai001                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD isai001
            #add-point:BEFORE FIELD isai001
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD isai001
            
            #add-point:AFTER FIELD isai001
            
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD isai002
            #add-point:BEFORE FIELD isai002
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD isai002
            
            #add-point:AFTER FIELD isai002
            
            #END add-point
            
 
         #Ctrlp:construct.c.isai002
#         ON ACTION controlp INFIELD isai002
            #add-point:ON ACTION controlp INFIELD isai002
            
            #END add-point
 
         #Ctrlp:construct.c.isai003
         ON ACTION controlp INFIELD isai003
            #add-point:ON ACTION controlp INFIELD isai003
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_isac002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO isai003  #顯示到畫面上
            NEXT FIELD isai003                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD isai003
            #add-point:BEFORE FIELD isai003
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD isai003
            
            #add-point:AFTER FIELD isai003
            
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD isaistus
            #add-point:BEFORE FIELD isaistus
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD isaistus
            
            #add-point:AFTER FIELD isaistus
            
            #END add-point
            
 
         #Ctrlp:construct.c.isaistus
#         ON ACTION controlp INFIELD isaistus
            #add-point:ON ACTION controlp INFIELD isaistus
            
            #END add-point
 
         #Ctrlp:construct.c.isaiownid
         ON ACTION controlp INFIELD isaiownid
            #add-point:ON ACTION controlp INFIELD isaiownid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO isaiownid  #顯示到畫面上
            NEXT FIELD isaiownid                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD isaiownid
            #add-point:BEFORE FIELD isaiownid
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD isaiownid
            
            #add-point:AFTER FIELD isaiownid
            
            #END add-point
            
 
         #Ctrlp:construct.c.isaiowndp
         ON ACTION controlp INFIELD isaiowndp
            #add-point:ON ACTION controlp INFIELD isaiowndp
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooea001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO isaiowndp  #顯示到畫面上
            NEXT FIELD isaiowndp                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD isaiowndp
            #add-point:BEFORE FIELD isaiowndp
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD isaiowndp
            
            #add-point:AFTER FIELD isaiowndp
            
            #END add-point
            
 
         #Ctrlp:construct.c.isaicrtid
         ON ACTION controlp INFIELD isaicrtid
            #add-point:ON ACTION controlp INFIELD isaicrtid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO isaicrtid  #顯示到畫面上
            NEXT FIELD isaicrtid                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD isaicrtid
            #add-point:BEFORE FIELD isaicrtid
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD isaicrtid
            
            #add-point:AFTER FIELD isaicrtid
            
            #END add-point
            
 
         #Ctrlp:construct.c.isaicrtdp
         ON ACTION controlp INFIELD isaicrtdp
            #add-point:ON ACTION controlp INFIELD isaicrtdp
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooea001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO isaicrtdp  #顯示到畫面上
            NEXT FIELD isaicrtdp                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD isaicrtdp
            #add-point:BEFORE FIELD isaicrtdp
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD isaicrtdp
            
            #add-point:AFTER FIELD isaicrtdp
            
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD isaicrtdt
            #add-point:BEFORE FIELD isaicrtdt
            
            #END add-point
 
         #Ctrlp:construct.c.isaimodid
         ON ACTION controlp INFIELD isaimodid
            #add-point:ON ACTION controlp INFIELD isaimodid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO isaimodid  #顯示到畫面上
            NEXT FIELD isaimodid                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD isaimodid
            #add-point:BEFORE FIELD isaimodid
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD isaimodid
            
            #add-point:AFTER FIELD isaimodid
            
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD isaimoddt
            #add-point:BEFORE FIELD isaimoddt
            
            #END add-point
 
 
           
      END CONSTRUCT
      
      #add-point:cs段more_construct
      
      #end add-point   
      
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog
         
         #end add-point  
      
      ON ACTION accept
         ACCEPT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
 
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
    
      #條件儲存為方案
      ON ACTION qbe_save
         CALL cl_qbe_save()
 
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   END DIALOG
  
   #add-point:cs段after_construct
   
   #end add-point
  
END FUNCTION
 
{</section>}
 
{<section id="aiss010.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aiss010_query()
   DEFINE ls_wc STRING
   #add-point:query段define
   
   #end add-point
   
   LET INT_FLAG = 0
   LET ls_wc = g_wc
   
   #切換畫面
 
   CALL g_browser.clear() 
 
   #browser panel折疊
   IF g_worksheet_hidden THEN
      CALL gfrm_curr.setElementHidden("worksheet_vbox",0)
      CALL gfrm_curr.setElementImage("worksheethidden","worksheethidden-24.png")
      LET g_worksheet_hidden = 0
   END IF
   
   #單頭折疊
   IF g_header_hidden THEN
      CALL gfrm_curr.setElementHidden("vb_master",0)
      CALL gfrm_curr.setElementImage("controls","headerhidden-24")
      LET g_header_hidden = 0
   END IF
 
   INITIALIZE g_isai_m.* TO NULL
   ERROR ""
 
   DISPLAY " " TO FORMONLY.b_count
   DISPLAY " " TO FORMONLY.h_count
   CALL aiss010_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      CALL aiss010_browser_fill(g_wc,"F")
      CALL aiss010_fetch("")
      RETURN
   ELSE
      LET g_current_row = 1
      LET g_current_cnt = 0
   END IF
   
   #根據條件從新抓取資料
   LET g_error_show = 1
   CALL aiss010_browser_fill(g_wc,"F")   # 移到第一頁
   
   #儲存WC資訊
   CALL cl_dlg_save_user_latestqry("("||g_wc||")")
   
   #備份搜尋條件
   LET ls_wc = g_wc
   
   IF g_browser.getLength() = 0 THEN
      CALL cl_err("","-100",1)
   ELSE
      CALL aiss010_fetch("F") 
   END IF
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="aiss010.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aiss010_fetch(p_fl)
   DEFINE p_fl       LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define
   
   #end add-point  
   
   #根據傳入的條件決定抓取的資料
   CASE p_fl
      WHEN "F" 
         LET g_current_idx = 1
      WHEN "P"
         IF g_current_idx > 1 THEN               
            LET g_current_idx = g_current_idx - 1
         END IF 
      WHEN "N"
         IF g_current_idx < g_header_cnt THEN
            LET g_current_idx =  g_current_idx + 1
         END IF        
      WHEN "L" 
         LET g_current_idx = g_header_cnt        
      WHEN "/"
         #詢問要指定的筆數
         IF (NOT g_no_ask) THEN      
            CALL cl_getmsg("fetch", g_lang) RETURNING ls_msg
            LET INT_FLAG = 0
 
            PROMPT ls_msg CLIPPED,": " FOR g_jump
               #交談指令共用ACTION
               &include "common_action.4gl"
            END PROMPT
            
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               EXIT CASE  
            END IF           
         END IF
         IF g_jump > 0 THEN
            LET g_current_idx = g_jump
         END IF
         LET g_no_ask = FALSE     
   END CASE
   
   LET g_browser_cnt = g_browser.getLength()
 
   #瀏覽頁筆數顯示
   LET g_browser_idx = g_current_idx 
   DISPLAY g_browser_idx TO FORMONLY.b_index        #當下筆數
   DISPLAY g_browser_cnt TO FORMONLY.b_count        #總筆數
   DISPLAY g_browser_idx TO FORMONLY.h_index        #當下筆數
   
   #單頭筆數顯示
   #DISPLAY g_browser_idx TO FORMONLY.idx            #當下筆數
   #DISPLAY g_browser_cnt TO FORMONLY.cnt            #總筆數
   
   
   
   #避免超出browser資料筆數上限
   IF g_current_idx > g_browser.getLength() THEN
      LET g_current_idx = g_browser.getLength()
   END IF
   
   # 設定browse索引
   CALL cl_navigator_setting(g_browser_idx, g_browser_cnt )
 
   #代表沒有資料, 無需做後續資料撈取之動作
   IF g_current_idx = 0 THEN
      RETURN
   END IF
 
   #根據選定的筆數給予key欄位值
   LET g_isai_m.isai001 = g_browser[g_current_idx].b_isai001
 
                       
   #讀取單頭所有欄位資料
   EXECUTE aiss010_master_referesh USING g_isai_m.isai001 INTO g_isai_m.isai001,g_isai_m.isai002,g_isai_m.isai003, 
       g_isai_m.isaistus,g_isai_m.isaiownid,g_isai_m.isaiowndp,g_isai_m.isaicrtid,g_isai_m.isaicrtdp, 
       g_isai_m.isaicrtdt,g_isai_m.isaimodid,g_isai_m.isaimoddt,g_isai_m.isai001_desc,g_isai_m.isai003_desc, 
       g_isai_m.isaiownid_desc,g_isai_m.isaiowndp_desc,g_isai_m.isaicrtid_desc,g_isai_m.isaicrtdp_desc, 
       g_isai_m.isaimodid_desc
   IF SQLCA.sqlcode THEN
      CALL cl_err("isai_t",SQLCA.sqlcode,0)
      INITIALIZE g_isai_m.* TO NULL
      RETURN
   END IF
   
   #add-point:fetch段action控制
   
   #end add-point  
   
   
   
   #保存單頭舊值
   LET g_isai_m_t.* = g_isai_m.*
   LET g_isai_m_o.* = g_isai_m.*
   
   #重新顯示
   CALL aiss010_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="aiss010.insert" >}
#+ 資料新增
PRIVATE FUNCTION aiss010_insert()
   #add-point:insert段define
   
   #end add-point    
   
   CLEAR FORM #清畫面欄位內容
   INITIALIZE g_isai_m.* LIKE isai_t.*             #DEFAULT 設定
   LET g_isai001_t = NULL
 
   CALL s_transaction_begin()
   
   WHILE TRUE
      
      #公用欄位給值
      #此段落由子樣板a14產生    
      LET g_isai_m.isaiownid = g_user
      LET g_isai_m.isaiowndp = g_dept
      LET g_isai_m.isaicrtid = g_user
      LET g_isai_m.isaicrtdp = g_dept 
      LET g_isai_m.isaicrtdt = cl_get_current()
      LET g_isai_m.isaimodid = ""
      LET g_isai_m.isaimoddt = ""
      LET g_isai_m.isaistus = "N"
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_isai_m.isai002 = "1"
      LET g_isai_m.isaistus = "N"
 
 
      #add-point:單頭預設值
      
      #end add-point   
     
      #資料輸入
      CALL aiss010_input("a")
      
      #add-point:單頭輸入後
      
      #end add-point
      
      IF INT_FLAG THEN
         #若取消則還原資料
         LET INT_FLAG = 0
         LET g_isai_m.* = g_isai_m_t.*
         CALL aiss010_show()
         CALL cl_err("",9001,0)
         EXIT WHILE
      END IF
 
      LET g_rec_b = 0
      EXIT WHILE
   END WHILE
   
   #將新增的資料併入搜尋條件中
   LET g_state = "Y"
 
   LET g_wc = "(",g_wc,  
              " OR ( isaient = '" ||g_enterprise|| "' AND",
              " isai001 = '", g_isai_m.isai001 CLIPPED, "' "
 
              , ")) "
 
END FUNCTION
 
{</section>}
 
{<section id="aiss010.modify" >}
#+ 資料修改
PRIVATE FUNCTION aiss010_modify()
   #add-point:modify段define
   
   #end add-point
   
   #先確定key值無遺漏
   IF g_isai_m.isai001 IS NULL
 
   THEN
      CALL cl_err("","std-00003",0)
      RETURN
   END IF 
 
   ERROR ""
  
   #備份key值
   LET g_isai001_t = g_isai_m.isai001
 
   
   CALL s_transaction_begin()
   
   #先lock資料
   OPEN aiss010_cl USING g_enterprise,g_isai_m.isai001
   IF STATUS THEN
      CALL cl_err("OPEN aiss010_cl:", STATUS, 1)
      CLOSE aiss010_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aiss010_master_referesh USING g_isai_m.isai001 INTO g_isai_m.isai001,g_isai_m.isai002,g_isai_m.isai003, 
       g_isai_m.isaistus,g_isai_m.isaiownid,g_isai_m.isaiowndp,g_isai_m.isaicrtid,g_isai_m.isaicrtdp, 
       g_isai_m.isaicrtdt,g_isai_m.isaimodid,g_isai_m.isaimoddt,g_isai_m.isai001_desc,g_isai_m.isai003_desc, 
       g_isai_m.isaiownid_desc,g_isai_m.isaiowndp_desc,g_isai_m.isaicrtid_desc,g_isai_m.isaicrtdp_desc, 
       g_isai_m.isaimodid_desc
 
   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      CALL cl_err("isai_t",SQLCA.sqlcode,0)
      CLOSE aiss010_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   
 
   #顯示資料
   CALL aiss010_show()
   
   WHILE TRUE
      LET g_isai_m.isai001 = g_isai001_t
 
      
      #寫入修改者/修改日期資訊
      LET g_isai_m.isaimodid = g_user 
LET g_isai_m.isaimoddt = cl_get_current()
 
      
      #add-point:modify段修改前
      
      #end add-point
 
      #資料輸入
      CALL aiss010_input("u")     
 
      #add-point:modify段修改後
      
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_isai_m.* = g_isai_m_t.*
         CALL aiss010_show()
         CALL cl_err("",9001,0)
         EXIT WHILE
      END IF
 
      #若有modid跟moddt則進行update
      UPDATE isai_t SET (isaimodid,isaimoddt) = (g_isai_m.isaimodid,g_isai_m.isaimoddt)
       WHERE isaient = g_enterprise AND isai001 = g_isai001_t
 
 
      EXIT WHILE
      
   END WHILE
   
   CLOSE aiss010_cl
   CALL s_transaction_end('Y','0')
 
   #流程通知預埋點-U(暫時無用)
   #CALL cl_flow_notify(g_isai_m.isai001,"U")
   
   LET g_worksheet_hidden = 0
   
END FUNCTION   
 
{</section>}
 
{<section id="aiss010.input" >}
#+ 資料輸入
PRIVATE FUNCTION aiss010_input(p_cmd)
   DEFINE p_cmd           LIKE type_t.chr1
   DEFINE l_ac_t          LIKE type_t.num5        #未取消的ARRAY CNT 
   DEFINE l_n             LIKE type_t.num5        #檢查重複用  
   DEFINE l_cnt           LIKE type_t.num5        #檢查重複用  
   DEFINE l_lock_sw       LIKE type_t.chr1        #單身鎖住否  
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num5
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_insert        LIKE type_t.num5
   DEFINE ls_return       STRING
   DEFINE l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak  DYNAMIC ARRAY OF STRING
   DEFINE l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE l_vars          DYNAMIC ARRAY OF STRING
   DEFINE l_fields        DYNAMIC ARRAY OF STRING
   #add-point:input段define
   
   #end add-point
 
   #切換至輸入畫面
   
   CALL cl_set_head_visible("","YES")  
   
   #a-新增,r-複製,u-修改
   IF p_cmd = 'r' THEN
      #此段落的r動作等同於a
      LET p_cmd = 'a'
   END IF
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   LET g_qryparam.state = "i"
   
   #控制key欄位可否輸入
   CALL aiss010_set_entry(p_cmd)
   #add-point:set_entry後
   
   #end add-point
   CALL aiss010_set_no_entry(p_cmd)
   #add-point:資料輸入前
   
   #end add-point
   
   DISPLAY BY NAME g_isai_m.isai001,g_isai_m.isai002,g_isai_m.isai003,g_isai_m.isaistus
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #單頭段
      INPUT BY NAME g_isai_m.isai001,g_isai_m.isai002,g_isai_m.isai003,g_isai_m.isaistus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            #其他table資料備份(確定是否更改用)
            
            #add-point:input開始前
            
            #end add-point
   
                  #此段落由子樣板a02產生
         AFTER FIELD isai001
            
            #add-point:AFTER FIELD isai001
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_isai_m.isai001
            CALL ap_ref_array2(g_ref_fields,"SELECT ooall004 FROM ooall_t WHERE ooallent='"||g_enterprise||"' AND ooall001='2' AND ooall002=? AND ooall003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_isai_m.isai001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_isai_m.isai001_desc

            #此段落由子樣板a05產生
            IF  NOT cl_null(g_isai_m.isai001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_isai_m.isai001 != g_isai001_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM isai_t WHERE "||"isaient = '" ||g_enterprise|| "' AND "||"isai001 = '"||g_isai_m.isai001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD isai001
            #add-point:BEFORE FIELD isai001
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE isai001
            #add-point:ON CHANGE isai001
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD isai002
            #add-point:BEFORE FIELD isai002
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD isai002
            
            #add-point:AFTER FIELD isai002
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE isai002
            #add-point:ON CHANGE isai002
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD isai003
            
            #add-point:AFTER FIELD isai003
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_isai_m.isai001
            LET g_ref_fields[2] = g_isai_m.isai003
            CALL ap_ref_array2(g_ref_fields,"SELECT isacl004 FROM isacl_t WHERE isaclent='"||g_enterprise||"' AND isacl001=? AND isacl002=? AND isacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_isai_m.isai003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_isai_m.isai003_desc


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD isai003
            #add-point:BEFORE FIELD isai003
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE isai003
            #add-point:ON CHANGE isai003
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD isaistus
            #add-point:BEFORE FIELD isaistus
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD isaistus
            
            #add-point:AFTER FIELD isaistus
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE isaistus
            #add-point:ON CHANGE isaistus
            
            #END add-point
 
 #欄位檢查
                  #Ctrlp:input.c.isai001
         ON ACTION controlp INFIELD isai001
            #add-point:ON ACTION controlp INFIELD isai001
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_isai_m.isai001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooal002_11()                                #呼叫開窗

            LET g_isai_m.isai001 = g_qryparam.return1              

            DISPLAY g_isai_m.isai001 TO isai001              #

            NEXT FIELD isai001                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.isai002
#         ON ACTION controlp INFIELD isai002
            #add-point:ON ACTION controlp INFIELD isai002
            
            #END add-point
 
         #Ctrlp:input.c.isai003
         ON ACTION controlp INFIELD isai003
            #add-point:ON ACTION controlp INFIELD isai003
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_isai_m.isai003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_isac002()                                #呼叫開窗

            LET g_isai_m.isai003 = g_qryparam.return1              

            DISPLAY g_isai_m.isai003 TO isai003              #

            NEXT FIELD isai003                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.isaistus
#         ON ACTION controlp INFIELD isaistus
            #add-point:ON ACTION controlp INFIELD isaistus
            
            #END add-point
 
 #欄位開窗
 
         AFTER INPUT
            #若點選cancel則離開dialog
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
            
            #錯誤訊息統整顯示
            CALL cl_showmsg()
  
            IF p_cmd <> "u" THEN
               #當p_cmd不為u代表為新增/複製
               LET l_count = 1  
 
               #確定新增的資料不存在(不重複)
               SELECT COUNT(*) INTO l_count FROM isai_t
                WHERE isaient = g_enterprise AND isai001 = g_isai_m.isai001
 
               IF l_count = 0 THEN
               
                  #add-point:單頭新增前
                  
                  #end add-point
               
                  #將新增的單頭資料寫入資料庫
                  INSERT INTO isai_t (isaient,isai001,isai002,isai003,isaistus,isaiownid,isaiowndp,isaicrtid, 
                      isaicrtdp,isaicrtdt)
                  VALUES (g_enterprise,g_isai_m.isai001,g_isai_m.isai002,g_isai_m.isai003,g_isai_m.isaistus, 
                      g_isai_m.isaiownid,g_isai_m.isaiowndp,g_isai_m.isaicrtid,g_isai_m.isaicrtdp,g_isai_m.isaicrtdt)  
 
                  
                  #add-point:單頭新增中
                  
                  #end add-point
                  
                  #若寫入錯誤則提示錯誤訊息並返回輸入頁面
                  IF SQLCA.sqlcode THEN
                     CALL cl_err("isai_t",SQLCA.sqlcode,1)  
                     CONTINUE DIALOG
                  END IF
                  
                  
                  
                  #資料多語言用-增/改
                  
                  
                  #add-point:單頭新增後
                  
                  #end add-point
                  
                  CALL s_transaction_end('Y','0')
               ELSE
                  CALL cl_err( "g_isai_m.isai001", "std-00006", 0 )
                  CALL s_transaction_end('N','0')
               END IF 
            ELSE
               #add-point:單頭修改前
               
               #end add-point
               UPDATE isai_t SET (isai001,isai002,isai003,isaistus,isaiownid,isaiowndp,isaicrtid,isaicrtdp, 
                   isaicrtdt) = (g_isai_m.isai001,g_isai_m.isai002,g_isai_m.isai003,g_isai_m.isaistus, 
                   g_isai_m.isaiownid,g_isai_m.isaiowndp,g_isai_m.isaicrtid,g_isai_m.isaicrtdp,g_isai_m.isaicrtdt) 
 
                WHERE isaient = g_enterprise AND isai001 = g_isai001_t #
 
               #add-point:單頭修改中
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL cl_err("isai_t","std-00009",1)
                     CALL s_transaction_end('N','0')
                  WHEN SQLCA.sqlcode #其他錯誤
                     CALL cl_err("isai_t",SQLCA.sqlcode,1)  
                     CALL s_transaction_end('N','0')
                  OTHERWISE
                     
                     #資料多語言用-增/改
                     
                     #add-point:單頭修改後
                     
                     #end add-point
                     #紀錄資料更動
                     LET g_log1 = util.JSON.stringify(g_isai_m_t)
                     LET g_log2 = util.JSON.stringify(g_isai_m)
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     ELSE
                        CALL s_transaction_end('Y','0')
                     END IF
               END CASE
            END IF
           #controlp
      END INPUT
          
      #add-point:input段more input 
      
      #end add-point
          
      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name, g_fld_name, g_lang)
 
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
         
      #放棄輸入
      ON ACTION cancel
         LET g_action_choice=""
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      #在dialog 右上角 (X)
      ON ACTION close 
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
         LET INT_FLAG = TRUE 
         EXIT DIALOG
   
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input 
   
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="aiss010.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aiss010_reproduce()
   DEFINE l_newno     LIKE isai_t.isai001 
   DEFINE l_oldno     LIKE isai_t.isai001 
 
   DEFINE l_master    RECORD LIKE isai_t.*
   DEFINE l_cnt       LIKE type_t.num5
   #add-point:reproduce段define
   
   #end add-point   
   
   #切換畫面
   
   #先確定key值無遺漏
   IF g_isai_m.isai001 IS NULL
 
   THEN
      CALL cl_err("","std-00003",0)
      RETURN
   END IF
   
   #備份key值
   LET g_isai001_t = g_isai_m.isai001
 
   
   #清空key值
   LET g_isai_m.isai001 = ""
 
    
   CALL aiss010_set_entry("a")
   CALL aiss010_set_no_entry("a")
   
   #公用欄位給予預設值
   #此段落由子樣板a14產生    
      LET g_isai_m.isaiownid = g_user
      LET g_isai_m.isaiowndp = g_dept
      LET g_isai_m.isaicrtid = g_user
      LET g_isai_m.isaicrtdp = g_dept 
      LET g_isai_m.isaicrtdt = cl_get_current()
      LET g_isai_m.isaimodid = ""
      LET g_isai_m.isaimoddt = ""
      LET g_isai_m.isaistus = "N"
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前
   
   #end add-point
   
   #資料輸入
   CALL aiss010_input("r")
 
   #清空key欄位的desc
      LET g_isai_m.isai001_desc = ''
   DISPLAY BY NAME g_isai_m.isai001_desc
 
   
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      RETURN
   END IF
   
   CALL s_transaction_begin()
   
   #add-point:單頭複製前
   
   #end add-point
   
   #add-point:單頭複製中
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      CALL cl_err("isai_t",SQLCA.sqlcode,1)
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:單頭複製後
   
   #end add-point
   
   CALL s_transaction_end('Y','0')
   
   #將新增的資料併入搜尋條件中
   LET g_state = "Y"
   
   LET g_wc = "(",g_wc,  
              " OR (",
              " isai001 = '", g_isai_m.isai001 CLIPPED, "' "
 
              , ")) "
   
   LET g_isai001_t = g_isai_m.isai001
 
   
   #add-point:完成複製段落後
   
   #end add-point
                   
END FUNCTION
 
{</section>}
 
{<section id="aiss010.show" >}
#+ 資料顯示 
PRIVATE FUNCTION aiss010_show()
   #add-point:show段define
   
   #end add-point  
   
   #add-point:show段之前
   
   #end add-point
   
   
   
   #在browser 移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()
   
   #帶出公用欄位reference值
   #此段落由子樣板a12產生
      #LET g_isai_m.isaiownid_desc = cl_get_username(g_isai_m.isaiownid)
      #LET g_isai_m.isaiowndp_desc = cl_get_deptname(g_isai_m.isaiowndp)
      #LET g_isai_m.isaicrtid_desc = cl_get_username(g_isai_m.isaicrtid)
      #LET g_isai_m.isaicrtdp_desc = cl_get_deptname(g_isai_m.isaicrtdp)
      #LET g_isai_m.isaimodid_desc = cl_get_username(g_isai_m.isaimodid)
      
 
 
    
   #顯示followup圖示
   #+ 此段落由子樣板a48產生
   CALL aiss010_set_pk_array()
   #add-point:ON ACTION agendum
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
 
 
   
   #讀入ref值(單頭)
   #add-point:show段reference

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_isai_m.isai001
            CALL ap_ref_array2(g_ref_fields,"SELECT ooall004 FROM ooall_t WHERE ooallent='"||g_enterprise||"' AND ooall001='2' AND ooall002=? AND ooall003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_isai_m.isai001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_isai_m.isai001_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_isai_m.isai001
            LET g_ref_fields[2] = g_isai_m.isai003
            CALL ap_ref_array2(g_ref_fields,"SELECT isacl004 FROM isacl_t WHERE isaclent='"||g_enterprise||"' AND isacl001=? AND isacl002=? AND isacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_isai_m.isai003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_isai_m.isai003_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_isai_m.isaiownid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_isai_m.isaiownid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_isai_m.isaiownid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_isai_m.isaiowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooeal003 FROM ooeal_t WHERE ooealent='"||g_enterprise||"' AND ooeal001=? AND ooeal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_isai_m.isaiowndp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_isai_m.isaiowndp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_isai_m.isaicrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_isai_m.isaicrtid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_isai_m.isaicrtid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_isai_m.isaicrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooeal003 FROM ooeal_t WHERE ooealent='"||g_enterprise||"' AND ooeal001=? AND ooeal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_isai_m.isaicrtdp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_isai_m.isaicrtdp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_isai_m.isaimodid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_isai_m.isaimodid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_isai_m.isaimodid_desc

   #end add-point
 
   #將資料輸出到畫面上
   DISPLAY BY NAME g_isai_m.isai001,g_isai_m.isai001_desc,g_isai_m.isai002,g_isai_m.isai003,g_isai_m.isai003_desc, 
       g_isai_m.isaistus,g_isai_m.isaiownid,g_isai_m.isaiownid_desc,g_isai_m.isaiowndp,g_isai_m.isaiowndp_desc, 
       g_isai_m.isaicrtid,g_isai_m.isaicrtid_desc,g_isai_m.isaicrtdp,g_isai_m.isaicrtdp_desc,g_isai_m.isaicrtdt, 
       g_isai_m.isaimodid,g_isai_m.isaimodid_desc,g_isai_m.isaimoddt
   
   #顯示狀態(stus)圖片
         #此段落由子樣板a21產生
      CASE g_isai_m.isaistus
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         
      END CASE
 
 
 
   #add-point:show段之後
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aiss010.delete" >}
#+ 資料刪除 
PRIVATE FUNCTION aiss010_delete()
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define
   
   #end add-point  
   
   #先確定key值無遺漏
   IF g_isai_m.isai001 IS NULL
 
   THEN
      CALL cl_err("","std-00003",0)
      RETURN
   END IF
 
   CALL s_transaction_begin()
    
   LET g_isai001_t = g_isai_m.isai001
 
   
   
 
   OPEN aiss010_cl USING g_enterprise,g_isai_m.isai001
 
   IF STATUS THEN
      CALL cl_err("OPEN aiss010_cl:", STATUS, 0)
      CLOSE aiss010_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aiss010_master_referesh USING g_isai_m.isai001 INTO g_isai_m.isai001,g_isai_m.isai002,g_isai_m.isai003, 
       g_isai_m.isaistus,g_isai_m.isaiownid,g_isai_m.isaiowndp,g_isai_m.isaicrtid,g_isai_m.isaicrtdp, 
       g_isai_m.isaicrtdt,g_isai_m.isaimodid,g_isai_m.isaimoddt,g_isai_m.isai001_desc,g_isai_m.isai003_desc, 
       g_isai_m.isaiownid_desc,g_isai_m.isaiowndp_desc,g_isai_m.isaicrtid_desc,g_isai_m.isaicrtdp_desc, 
       g_isai_m.isaimodid_desc
   IF SQLCA.sqlcode THEN
      CALL cl_err(g_isai_m.isai001,SQLCA.sqlcode,0)
      RETURN
   END IF
   
   #將最新資料顯示到畫面上
   CALL aiss010_show()
   
   IF cl_ask_delete() THEN
 
      #add-point:單頭刪除前
      
      #end add-point
 
      #+ 此段落由子樣板a47產生
      #刪除相關文件
      CALL aiss010_set_pk_array()
      #add-point:相關文件刪除前
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
      DELETE FROM isai_t 
       WHERE isaient = g_enterprise AND isai001 = g_isai_m.isai001 
 
 
      #add-point:單頭刪除中
      
      #end add-point
         
      IF SQLCA.sqlcode THEN
         CALL cl_err("isai_t",SQLCA.sqlcode,0)
         CALL s_transaction_end('N','0')
      END IF
  
      
      
      #add-point:單頭刪除後
      
      #end add-point
      
          
      CLEAR FORM
      #ALL aiss010_ui_browser_refresh()
      
      #確保畫面上保有資料
      IF g_browser_cnt > 0 THEN
         CALL aiss010_browser_fill(g_wc,"")
         CALL aiss010_fetch("P")
      ELSE
         CALL aiss010_browser_fill(" 1=1 ","F")
      END IF
      
   END IF
 
   CLOSE aiss010_cl
   CALL s_transaction_end('Y','0')
 
   #流程通知預埋點-D
   CALL cl_flow_notify(g_isai_m.isai001,"D")
 
END FUNCTION
 
{</section>}
 
{<section id="aiss010.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aiss010_ui_browser_refresh()
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define
   
   #end add-point     
 
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_isai001 = g_isai_m.isai001
 
         THEN
         CALL g_browser.deleteElement(l_i)
         LET g_header_cnt = g_header_cnt - 1
       END IF
   END FOR
   
   DISPLAY g_header_cnt TO FORMONLY.b_count     #page count
   DISPLAY g_header_cnt TO FORMONLY.h_count     #page count
   LET g_browser_cnt = g_browser_cnt-1
   IF g_current_idx > g_browser_cnt THEN        #確定browse 筆數指在同一筆
      LET g_current_idx = g_browser_cnt
   END IF
  
END FUNCTION
 
{</section>}
 
{<section id="aiss010.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aiss010_set_entry(p_cmd)
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_entry段define
   
   #end add-point     
 
   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("isai001",TRUE)
      #add-point:set_entry段欄位控制
      
      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aiss010.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aiss010_set_no_entry(p_cmd)
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_no_entry段define
   
   #end add-point     
 
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("isai001",FALSE)
      #add-point:set_no_entry段欄位控制
      
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aiss010.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aiss010_default_search()
   DEFINE li_idx  LIKE type_t.num5
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE ls_wc   STRING
   #add-point:default_search段define
   
   #end add-point  
   
   #add-point:default_search段開始前
   
   #end add-point  
 
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   #根據外部參數(g_argv)組合wc
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " isai001 = '", g_argv[01], "' AND "
   END IF
   
 
   
   IF NOT cl_null(ls_wc) THEN
      #若有外部參數則根據該參數組合
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_default = TRUE
   ELSE
      #若無外部參數則預設為1=1
      LET g_default = FALSE
      #預設查詢條件
      LET g_wc = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=1"
      END IF
   END IF
   
   #add-point:default_search段結束前
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="aiss010.state_change" >}
   #+ 此段落由子樣板a09產生
#+ 確認碼變更
PRIVATE FUNCTION aiss010_statechange()
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define
   
   #end add-point  
   
   #add-point:statechange段開始前
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_isai_m.isai001 IS NULL
 
   THEN
      CALL cl_err("","std-00003",0)
      RETURN
   END IF
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_isai_m.isaistus
            WHEN "N"
               HIDE OPTION "open"
            WHEN "X"
               HIDE OPTION "invalid"
            WHEN "Y"
               HIDE OPTION "confirmed"
            
         END CASE
     
      #add-point:menu前
      
      #end add-point
      
      ON ACTION open
         LET lc_state = "N"
         #add-point:action控制
         
         #end add-point
         EXIT MENU
      ON ACTION invalid
         LET lc_state = "X"
         #add-point:action控制
         
         #end add-point
         EXIT MENU
      ON ACTION confirmed
         LET lc_state = "Y"
         #add-point:action控制
         
         #end add-point
         EXIT MENU
      
      
      
      #add-point:stus控制
      
      #end add-point
      
   END MENU
   
   IF (lc_state <> "N" 
      AND lc_state <> "X"
      AND lc_state <> "Y"
      ) OR 
      cl_null(lc_state) THEN
      RETURN
   END IF
   
   #add-point:stus修改前
   
   #end add-point
      
   UPDATE isai_t SET isaistus = lc_state 
    WHERE isaient = g_enterprise AND isai001 = g_isai_m.isai001
 
  
   IF SQLCA.sqlcode THEN
      CALL cl_err("",SQLCA.sqlcode,0)
   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         
      END CASE
      LET g_isai_m.isaistus = lc_state
      DISPLAY BY NAME g_isai_m.isaistus
   END IF
 
   #add-point:stus修改後
   
   #end add-point
 
   #add-point:statechange段結束前
   
   #end add-point  
 
END FUNCTION
 
 
 
{</section>}
 
{<section id="aiss010.signature" >}
   
 
{</section>}
 
{<section id="aiss010.set_pk_array" >}
   #+ 此段落由子樣板a51產生
#+ 給予pk_array內容
PRIVATE FUNCTION aiss010_set_pk_array()
   #add-point:set_pk_array段define
   
   #end add-point
   
   #add-point:set_pk_array段之前
   
   #end add-point  
   
   CALL g_pk_array.clear()
   LET g_pk_array[1].values = g_isai_m.isai001
   LET g_pk_array[1].column = 'isai001'
 
   
   #add-point:set_pk_array段之後
   
   #end add-point  
   
END FUNCTION
 
 
 
{</section>}
 
{<section id="aiss010.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="aiss010.other_function" readonly="Y" >}

 
{</section>}
 
