#該程式已解開Section, 不再透過樣板產出!
{<section id="azzi001.description" >}
#+ Version..: T100-ERP-1.00.00(SD版次:1,PR版次:1) Build-000597
#+ 
#+ Filename...: azzi001
#+ Description: 系統流程圖維護作業
#+ Creator....: 01274(2014-09-18 11:47:24)
#+ Modifier...: 01274(2014-09-25 15:57:04) -SD/PR- 07688
#+ Buildtype..: 應用 i01 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="azzi001.global" >}
#+ Modifier...: No.161018-00026#1 2016/10/27 By bruceliu1999 複製
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目
IMPORT com
IMPORT FGL azz_azzi000_03
IMPORT FGL azz_azzi001_01
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔
DEFINE counti INTEGER   #161018-00026#1

#end add-point
 
#單頭 type 宣告
PRIVATE TYPE type_g_gzba_m RECORD
       gzbal003 LIKE gzbal_t.gzbal003, 
   gzbal003_1 LIKE type_t.chr500, 
   gzba003 LIKE gzba_t.gzba003, 
   gzba001 LIKE gzba_t.gzba001, 
   gzba002 LIKE gzba_t.gzba002, 
   gzbastus LIKE gzba_t.gzbastus, 
   gzbaownid LIKE gzba_t.gzbaownid, 
   gzbaownid_desc LIKE type_t.chr80, 
   gzbacrtid LIKE gzba_t.gzbacrtid, 
   gzbacrtid_desc LIKE type_t.chr80, 
   gzbaowndp LIKE gzba_t.gzbaowndp, 
   gzbaowndp_desc LIKE type_t.chr80, 
   gzbacrtdp LIKE gzba_t.gzbacrtdp, 
   gzbacrtdp_desc LIKE type_t.chr80, 
   gzbacrtdt LIKE gzba_t.gzbacrtdt, 
   gzbamodid LIKE gzba_t.gzbamodid, 
   gzbamodid_desc LIKE type_t.chr80, 
   gzbamoddt LIKE gzba_t.gzbamoddt
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_gzba_m        type_g_gzba_m  #單頭變數宣告
DEFINE g_gzba_m_t      type_g_gzba_m  #單頭舊值宣告(系統還原用)
DEFINE g_gzba_m_o      type_g_gzba_m  #單頭舊值宣告(其他用途)
 
   DEFINE g_gzba001_t LIKE gzba_t.gzba001
 
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD  #查詢方案用陣列 
         b_statepic     LIKE type_t.chr50,
            b_gzba001 LIKE gzba_t.gzba001
      END RECORD 
   
 
   
DEFINE g_master_multi_table_t    RECORD
      gzbal001 LIKE gzbal_t.gzbal001,
      gzbal003 LIKE gzbal_t.gzbal003
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
DEFINE g_add_browse          STRING                        #新增填充用WC
 
#add-point:自定義模組變數(Module Variable)
DEFINE g_detail1             DYNAMIC ARRAY OF RECORD
            name             STRING,
            id               STRING,
            pid              STRING,
            isnode           BOOLEAN,
            expanded         BOOLEAN
       END RECORD
       
TYPE t_position      RECORD
         top            STRING,
         left           STRING
                     END RECORD
TYPE t_size          RECORD
         width          STRING,
         height         STRING
                     END RECORD
TYPE t_containers    DYNAMIC ARRAY OF RECORD
         id             STRING,
         label          STRING,    #gzbbl_t.gzbbl003 簡稱
         desc           STRING,    #gzbbl_t.gzbbl004 全稱
         module         STRING,    #gzbb_t.gzbb003   節點類型
         other          STRING,    #gzbb_t.gzbb005  類型是program用的
         image          STRING,    
         template       STRING,    #可用節點類型gzbb005
         position       t_position,
         size           t_size,
         css            STRING
                     END RECORD
TYPE t_parameters    RECORD         #gzbc_t.gzbc004   其它資訊
         label          STRING
                     END RECORD
TYPE t_connections   DYNAMIC ARRAY OF RECORD
         parameters  t_parameters,
         source      STRING,  #gzbc_t.gzbc001   來源節點代號
         target      STRING   #gzbc_t.gzbc002   目的節點代號

                     END RECORD
#節點多語言，為了能讓使用者反悔，所以先將指定分類下的所有節點多語言資訊都暫存下來
DEFINE g_multi_lang  DYNAMIC ARRAY OF RECORD   
         gzbb001        LIKE gzbb_t.gzbb001,   #節點代碼
         gzbbl_arr      DYNAMIC ARRAY OF RECORD LIKE gzbbl_t.*
                     END RECORD
DEFINE g_curr_gzba001      LIKE gzba_t.gzba001  #目前的選單代號
DEFINE g_idx         INTEGER
#end add-point
 
#add-point:傳入參數說明(global.argv)

#end add-point
 
{</section>}
 
{<section id="azzi001.main" >}
#+ 此段落由子樣板a26產生
#OPTIONS SHORT CIRCUIT
#+ 作業開始 
MAIN
   #add-point:main段define
   DEFINE l_wcpath      STRING
   #end add-point   
 
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("azz","")
 
   #add-point:作業初始化
   IF cl_null(FGL_GETENV("GUIMODE")) OR FGL_GETENV("GUIMODE") = "GDC" THEN
      # webComponent需在開啟視窗前設定路徑
      LET l_wcpath = FGL_GETENV("FGLASIP"),"/components"
      CALL ui.interface.frontCall("standard", "setwebcomponentpath",[l_wcpath],[])   #不支援GWC
   END IF
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define

   #end add-point
   LET g_forupd_sql = " SELECT '','',gzba003,gzba001,gzba002,gzbastus,gzbaownid,'',gzbacrtid,'',gzbaowndp, 
       '',gzbacrtdp,'',gzbacrtdt,gzbamodid,'',gzbamoddt", 
                      " FROM gzba_t",
                      " WHERE gzbaent= ? AND gzba001=? FOR UPDATE"
   #add-point:SQL_define

   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE azzi001_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT UNIQUE t0.gzba003,t0.gzba001,t0.gzba002,t0.gzbastus,t0.gzbaownid,t0.gzbacrtid, 
       t0.gzbaowndp,t0.gzbacrtdp,t0.gzbacrtdt,t0.gzbamodid,t0.gzbamoddt,t1.oofa011 ,t2.oofa011 ,t3.ooefl003 , 
       t4.ooefl003 ,t5.oofa011",
               " FROM gzba_t t0",
                              " LEFT JOIN oofa_t t1 ON t1.oofaent='"||g_enterprise||"' AND t1.oofa002='2' AND t1.oofa003=t0.gzbaownid  ",
               " LEFT JOIN oofa_t t2 ON t2.oofaent='"||g_enterprise||"' AND t2.oofa002='2' AND t2.oofa003=t0.gzbacrtid  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent='"||g_enterprise||"' AND t3.ooefl001=t0.gzbaowndp AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent='"||g_enterprise||"' AND t4.ooefl001=t0.gzbacrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oofa_t t5 ON t5.oofaent='"||g_enterprise||"' AND t5.oofa002='2' AND t5.oofa003=t0.gzbamodid  ",
 
               " WHERE t0.gzbaent = '" ||g_enterprise|| "' AND t0.gzba001 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define

   #end add-point
   PREPARE azzi001_master_referesh FROM g_sql
 
 
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call

      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_azzi001 WITH FORM cl_ap_formpath("azz","azzi001")
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL azzi001_init()   
 
      #進入選單 Menu (="N")
      CALL azzi001_ui_dialog() 
      
      #add-point:畫面關閉前

      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_azzi001
      
   END IF 
   
   CLOSE azzi001_cl
   
   
 
   #add-point:作業離開前

   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN
 
 
 
{</section>}
 
{<section id="azzi001.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION azzi001_init()
   #add-point:init段define
   
   #end add-point
 
   #定義combobox狀態
      CALL cl_set_combo_scc_part('gzbastus','17','N,Y')
 
   
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   #add-point:畫面資料初始化
   
   #end add-point
   
   #根據外部參數進行搜尋
   CALL azzi001_default_search()
 
END FUNCTION
 
{</section>}
 
{<section id="azzi001.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION azzi001_ui_dialog() 
   DEFINE li_exit   LIKE type_t.num5        #判別是否為離開作業
   DEFINE li_idx    LIKE type_t.num5        #指標變數
   DEFINE ls_wc     STRING                  #wc用
   DEFINE la_param  RECORD                  #程式串查用變數
             prog   STRING,                 #串查程式名稱
             param  DYNAMIC ARRAY OF STRING #傳遞變數
                    END RECORD
   DEFINE ls_js     STRING                  #轉換後的json字串
   #add-point:ui_dialog段define
   DEFINE ls_sql              STRING
   #end add-point
   
   LET li_exit = FALSE
   LET g_current_row = 0
   LET g_current_idx = 1
   
   
   
   #action default動作
   #+ 此段落由子樣板a42產生
   #進入程式時預設執行的動作
   CASE g_actdefault
      WHEN "insert"
         LET g_action_choice="insert"
         LET g_actdefault = ""
         IF cl_auth_chk_act("insert") THEN
            CALL azzi001_insert()
            #add-point:ON ACTION insert
            
            #END add-point
         END IF
 
      #add-point:action default自訂
      
      #end add-point
      OTHERWISE
         
   END CASE
 
 
   
   #add-point:ui_dialog段before dialog 
   
   #g_browser相關的4GL是多餘的；azzi001沒用到g_browse，可忽略
   
   
   LET ls_sql = " SELECT gzba001, gzba002, gzbal003  ",
                " FROM gzba_t ",
                " LEFT JOIN gzbal_t ON gzbalent = '"||g_enterprise||"' AND gzba001 = gzbal001 AND gzbal002 = '",g_dlang,"' ",
                " WHERE gzbaent = '" ||g_enterprise|| "' AND gzba002 IS NULL ORDER BY gzba003 ASC"
   PREPARE detail1_root_pre FROM ls_sql
   
   LET ls_sql = " SELECT gzba001, gzba002, gzbal003  ",
                " FROM gzba_t ",
                " LEFT JOIN gzbal_t ON gzbalent = '"||g_enterprise||"' AND gzba001 = gzbal001 AND gzbal002 = '",g_dlang,"' ",
                " WHERE gzbaent = '" ||g_enterprise|| "' AND gzba002 = ? ORDER BY gzba003 ASC"
   PREPARE detail1_children_pre FROM ls_sql
   
   LET ls_sql = " SELECT COUNT(*)  ",
                " FROM gzba_t ",
                " WHERE gzbaent = '" ||g_enterprise|| "' AND gzba002 = ?  "
   
   PREPARE detail1_children_cnt_pre FROM ls_sql
   
   LET ls_sql = "SELECT gzba001 FROM gzba_t WHERE gzba002 = ? AND gzbaent = '"||g_enterprise||"' "
   PREPARE detail1_gzba001_pre FROM ls_sql
   
   LET ls_sql = "SELECT gzbd001, gzbdl003, gzbd002, gzbd003 FROM gzbd_t ",
                " LEFT JOIN gzbdl_t ON gzbd001 = gzbdl001 AND gzbdent = gzbdlent ", 
                " AND gzbdl002 = '"||g_lang||"' WHERE gzbdent = ", g_enterprise
                
   DECLARE azzi001_gzbd_declare CURSOR FROM ls_sql
   
   CALL azzi001_dialog()
   
   LET li_exit = TRUE
   #end add-point
 
   WHILE li_exit = FALSE
      
      CALL azzi001_browser_fill(g_wc,"")
      
      #判斷前一個動作是否為新增或複製, 若是的話切換到新增的筆數
      #IF g_state = "Y" THEN
      #   FOR li_idx = 1 TO g_browser.getLength()
      #      IF g_browser[li_idx].b_gzba001 = g_gzba001_t
 
      #         THEN
      #         LET g_current_row = li_idx
      #         EXIT FOR
      #      END IF
      #   END FOR
      #   LET g_state = ""
      #END IF
    
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
                  CALL azzi001_fetch("")   
               END IF               
               #add-point:ui_dialog段 before menu
               
               #end add-point
            
            #狀態碼切換
            ON ACTION statechange
               CALL azzi001_statechange()
               LET g_action_choice="statechange"
               
            #第一筆資料
            ON ACTION first
               CALL azzi001_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL azzi001_fetch("N")
               LET g_current_row = g_current_idx
            
            #指定筆資料
            ON ACTION jump
               CALL azzi001_fetch("/")
               LET g_current_row = g_current_idx
            
            #上一筆資料
            ON ACTION previous
               CALL azzi001_fetch("P")
               LET g_current_row = g_current_idx
            
            #最後筆資料
            ON ACTION last 
               CALL azzi001_fetch("L")  
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
                  CALL azzi001_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL azzi001_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     CLEAR FORM
                  ELSE
                     CALL azzi001_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
            
            
         #+ 此段落由子樣板a43產生
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL azzi001_modify()
               #add-point:ON ACTION modify
               
               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL azzi001_delete()
               #add-point:ON ACTION delete
               
               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL azzi001_insert()
               #add-point:ON ACTION insert
               
               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output
               
               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL azzi001_reproduce()
               #add-point:ON ACTION reproduce
               
               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL azzi001_query()
               #add-point:ON ACTION query
               
               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION save
            LET g_action_choice="save"
               
               #add-point:ON ACTION save
               
               #END add-point
 
 
            
            
            
            #+ 此段落由子樣板a46產生
         #新增相關文件
         ON ACTION related_document
            CALL azzi001_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL azzi001_set_pk_array()
            #add-point:ON ACTION agendum
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL azzi001_set_pk_array()
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
                  CALL azzi001_fetch("")      
                  
               
            
            END DISPLAY
 
            #add-point:ui_dialog段自定義display array
            
            #end add-point
 
         
            BEFORE DIALOG
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL azzi001_fetch("")   
               END IF               
               
            AFTER DIALOG
               #add-point:ui_dialog段 after dialog
               
               #end add-point
            
            #狀態碼切換
            ON ACTION statechange
               LET g_action_choice="statechange"
               CALL azzi001_statechange()
               #EXIT DIALOG
         
            
            
            #第一筆資料
            ON ACTION first
               CALL azzi001_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL azzi001_fetch("N")
               LET g_current_row = g_current_idx
         
            #指定筆資料
            ON ACTION jump
               CALL azzi001_fetch("/")
               LET g_current_row = g_current_idx
         
            #上一筆資料
            ON ACTION previous
               CALL azzi001_fetch("P")
               LET g_current_row = g_current_idx
          
            #最後筆資料
            ON ACTION last 
               CALL azzi001_fetch("L")  
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
               #EXIT DIALOG
               
         
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
                  CALL azzi001_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL azzi001_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     CLEAR FORM
                  ELSE
                     CALL azzi001_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
               
            
         #+ 此段落由子樣板a43產生
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL azzi001_modify()
               #add-point:ON ACTION modify
               
               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL azzi001_delete()
               #add-point:ON ACTION delete
               
               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL azzi001_insert()
               #add-point:ON ACTION insert
               
               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output
               
               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL azzi001_reproduce()
               #add-point:ON ACTION reproduce
               
               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL azzi001_query()
               #add-point:ON ACTION query
               
               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION save
            LET g_action_choice="save"
               
               #add-point:ON ACTION save
               
               #END add-point
 
 
            
            
 
            #+ 此段落由子樣板a46產生
         #新增相關文件
         ON ACTION related_document
            CALL azzi001_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL azzi001_set_pk_array()
            #add-point:ON ACTION agendum
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL azzi001_set_pk_array()
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
      
      #add-point:ui_dialog段 after dialog
      
      #end add-point
      
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="azzi001.browser_fill" >}
#+ 瀏覽頁簽資料填充(一般單檔)
PRIVATE FUNCTION azzi001_browser_fill(p_wc,ps_page_action) 
   DEFINE p_wc              STRING
   DEFINE ls_wc             STRING
   DEFINE ps_page_action    STRING
   DEFINE l_searchcol       STRING
   DEFINE l_sql             STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define
   
   #end add-point
   
   #搜尋用
   IF cl_null(g_searchcol) OR g_searchcol = "0" THEN
      LET l_searchcol = "gzba001"
   ELSE
      LET l_searchcol = g_searchcol
   END IF
 
   LET p_wc = p_wc.trim() #當查詢按下Q時 按下放棄 g_wc = "  " 所以要清掉空白
   IF cl_null(p_wc) THEN  #p_wc 查詢條件
      LET p_wc = " 1=1 " 
   END IF
   
   #add-point:browser_fill段wc控制
   
   #end add-point
 
   LET g_sql = " SELECT COUNT(*) FROM gzba_t ",
               "  ",
               "  LEFT JOIN gzbal_t ON gzbalent = '"||g_enterprise||"' AND gzba001 = gzbal001 AND gzbal002 = '",g_dlang,"' ",
               " WHERE gzbaent = '" ||g_enterprise|| "' AND ", 
               p_wc CLIPPED, cl_sql_add_filter("gzba_t")
                
   #add-point:browser_fill段cnt_sql
   
   #end add-point
                
   PREPARE header_cnt_pre FROM g_sql
   EXECUTE header_cnt_pre INTO g_browser_cnt
   FREE header_cnt_pre 
   
   #若超過最大顯示筆數
   IF g_browser_cnt > g_max_browse AND g_error_show = 1 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_browser_cnt 
      LET g_errparam.code   = 9035
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET g_browser_cnt = g_max_browse
   END IF
   
   
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_count
   DISPLAY g_browser_cnt TO FORMONLY.b_count
   DISPLAY g_browser_cnt TO FORMONLY.h_count
   
   IF ps_page_action = "F" OR
      ps_page_action = "P"  OR
      ps_page_action = "N"  OR
      ps_page_action = "L"  THEN
      LET g_page_action = ps_page_action
   END IF
   
   IF cl_null(g_add_browse) THEN
      #清除畫面
      CLEAR FORM
      INITIALIZE g_gzba_m.* TO NULL
      CALL g_browser.clear()
      LET g_cnt = 1
      LET ls_wc = p_wc
   ELSE
      LET ls_wc = g_add_browse
      LET g_cnt = g_browser.getLength() + 1
      LET g_add_browse = ""
   END IF
   
   LET g_sql = " SELECT t0.gzbastus,t0.gzba001",
               " FROM gzba_t t0 ",
               "  ",
               
               " LEFT JOIN gzbal_t ON gzbalent = '"||g_enterprise||"' AND gzba001 = gzbal001 AND gzbal002 = '",g_dlang,"' ",
               " WHERE t0.gzbaent = '" ||g_enterprise|| "' AND ", ls_wc, cl_sql_add_filter("gzba_t")
   #add-point:browser_fill段fill_wc
   
   #end add-point 
   LET g_sql = g_sql, " ORDER BY ",l_searchcol," ",g_order
   #add-point:browser_fill段before_pre
   
   #end add-point                    
 
   #LET g_sql = cl_sql_add_tabid(g_sql,"gzba_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre
 
   #CALL g_browser.clear()
   #LET g_cnt = 1
   FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_gzba001
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "foreach:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      
      
      #add-point:browser_fill段reference
      
      #end add-point
      
            #此段落由子樣板a24產生
      #browser段落顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/inactive.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/active.png"
         
      END CASE
 
 
      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
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
   
   #add-point:browser_fill段結束前
   
   #end add-point   
   
END FUNCTION
 
 
 
{</section>}
 
{<section id="azzi001.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION azzi001_construct()
   DEFINE ls_return      STRING
   DEFINE ls_result      STRING 
   DEFINE ls_wc          STRING 
   #add-point:cs段define

   #end add-point
   
   #清空畫面&資料初始化
   CLEAR Undefined.*
   
   INITIALIZE g_gzba_m.* TO NULL
   INITIALIZE g_wc TO NULL
   LET g_current_row = 1
 
   LET g_qryparam.state = "c"
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #螢幕上取條件
      CONSTRUCT BY NAME g_wc ON gzbal003,gzbastus,gzbaownid,gzbacrtid, 
          gzbaowndp,gzbacrtdp,gzbacrtdt,gzbamodid,gzbamoddt
      
         BEFORE CONSTRUCT                                    
            #add-point:cs段more_construct

            #end add-point             
      
         #公用欄位開窗相關處理
         #此段落由子樣板a11產生
         #共用欄位查詢處理
         ##----<<gzbacrtdt>>----
         AFTER FIELD gzbacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<gzbamoddt>>----
         AFTER FIELD gzbamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<gzbacnfdt>>----
         
         #----<<gzbapstdt>>----
 
 
      
         #一般欄位
                  #此段落由子樣板a01產生
         BEFORE FIELD gzbal003
            #add-point:BEFORE FIELD gzbal003

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzbal003
            
            #add-point:AFTER FIELD gzbal003

            #END add-point
            
 
         #Ctrlp:construct.c.gzbal003
         ON ACTION controlp INFIELD gzbal003
            #add-point:ON ACTION controlp INFIELD gzbal003

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD gzbal003_1
            #add-point:BEFORE FIELD gzbal003_1

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzbal003_1
            
            #add-point:AFTER FIELD gzbal003_1

            #END add-point
            
 
         #Ctrlp:construct.c.gzbal003_1
         ON ACTION controlp INFIELD gzbal003_1
            #add-point:ON ACTION controlp INFIELD gzbal003_1

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD gzba003
            #add-point:BEFORE FIELD gzba003

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzba003
            
            #add-point:AFTER FIELD gzba003

            #END add-point
            
 
         #Ctrlp:construct.c.gzba003
         ON ACTION controlp INFIELD gzba003
            #add-point:ON ACTION controlp INFIELD gzba003

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD gzba001
            #add-point:BEFORE FIELD gzba001

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzba001
            
            #add-point:AFTER FIELD gzba001

            #END add-point
            
 
         #Ctrlp:construct.c.gzba001
         ON ACTION controlp INFIELD gzba001
            #add-point:ON ACTION controlp INFIELD gzba001

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD gzba002
            #add-point:BEFORE FIELD gzba002

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzba002
            
            #add-point:AFTER FIELD gzba002

            #END add-point
            
 
         #Ctrlp:construct.c.gzba002
         ON ACTION controlp INFIELD gzba002
            #add-point:ON ACTION controlp INFIELD gzba002

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD gzbastus
            #add-point:BEFORE FIELD gzbastus

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzbastus
            
            #add-point:AFTER FIELD gzbastus

            #END add-point
            
 
         #Ctrlp:construct.c.gzbastus
         ON ACTION controlp INFIELD gzbastus
            #add-point:ON ACTION controlp INFIELD gzbastus

            #END add-point
 
         #Ctrlp:construct.c.gzbaownid
         ON ACTION controlp INFIELD gzbaownid
            #add-point:ON ACTION controlp INFIELD gzbaownid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzbaownid  #顯示到畫面上
            NEXT FIELD gzbaownid                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD gzbaownid
            #add-point:BEFORE FIELD gzbaownid

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzbaownid
            
            #add-point:AFTER FIELD gzbaownid

            #END add-point
            
 
         #Ctrlp:construct.c.gzbacrtid
         ON ACTION controlp INFIELD gzbacrtid
            #add-point:ON ACTION controlp INFIELD gzbacrtid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzbacrtid  #顯示到畫面上
            NEXT FIELD gzbacrtid                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD gzbacrtid
            #add-point:BEFORE FIELD gzbacrtid

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzbacrtid
            
            #add-point:AFTER FIELD gzbacrtid

            #END add-point
            
 
         #Ctrlp:construct.c.gzbaowndp
         ON ACTION controlp INFIELD gzbaowndp
            #add-point:ON ACTION controlp INFIELD gzbaowndp
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooea001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzbaowndp  #顯示到畫面上
            NEXT FIELD gzbaowndp                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD gzbaowndp
            #add-point:BEFORE FIELD gzbaowndp

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzbaowndp
            
            #add-point:AFTER FIELD gzbaowndp

            #END add-point
            
 
         #Ctrlp:construct.c.gzbacrtdp
         ON ACTION controlp INFIELD gzbacrtdp
            #add-point:ON ACTION controlp INFIELD gzbacrtdp
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooea001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzbacrtdp  #顯示到畫面上
            NEXT FIELD gzbacrtdp                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD gzbacrtdp
            #add-point:BEFORE FIELD gzbacrtdp

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzbacrtdp
            
            #add-point:AFTER FIELD gzbacrtdp

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD gzbacrtdt
            #add-point:BEFORE FIELD gzbacrtdt

            #END add-point
 
         #Ctrlp:construct.c.gzbamodid
         ON ACTION controlp INFIELD gzbamodid
            #add-point:ON ACTION controlp INFIELD gzbamodid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzbamodid  #顯示到畫面上
            NEXT FIELD gzbamodid                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD gzbamodid
            #add-point:BEFORE FIELD gzbamodid

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzbamodid
            
            #add-point:AFTER FIELD gzbamodid

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD gzbamoddt
            #add-point:BEFORE FIELD gzbamoddt

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
 
{<section id="azzi001.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION azzi001_query()
   DEFINE ls_wc STRING
   #add-point:query段define

   #end add-point
   
   LET INT_FLAG = 0
   LET ls_wc = g_wc
   
   #切換畫面
 
   CALL g_browser.clear() 
  
   INITIALIZE g_gzba_m.* TO NULL
   ERROR ""
 
   DISPLAY " " TO FORMONLY.b_count
   DISPLAY " " TO FORMONLY.h_count
   
   CALL azzi001_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      CALL azzi001_browser_fill(g_wc,"F")
      CALL azzi001_fetch("")
      RETURN
   ELSE
      LET g_current_row = 1
      LET g_current_cnt = 0
   END IF
   
   #根據條件從新抓取資料
   LET g_error_show = 1
   CALL azzi001_browser_fill(g_wc,"F")   # 移到第一頁
   
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
      CALL azzi001_fetch("F") 
   END IF
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="azzi001.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION azzi001_fetch(p_fl)
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
         #LET g_current_idx = g_header_cnt        
         LET g_current_idx = g_browser.getLength()    
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
   DISPLAY g_browser_cnt TO FORMONLY.h_count        #總筆數
   
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
   LET g_gzba_m.gzba001 = g_browser[g_current_idx].b_gzba001
 
                       
   #讀取單頭所有欄位資料
   EXECUTE azzi001_master_referesh USING g_gzba_m.gzba001 INTO g_gzba_m.gzba003,g_gzba_m.gzba001,g_gzba_m.gzba002, 
       g_gzba_m.gzbastus,g_gzba_m.gzbaownid,g_gzba_m.gzbacrtid,g_gzba_m.gzbaowndp,g_gzba_m.gzbacrtdp, 
       g_gzba_m.gzbacrtdt,g_gzba_m.gzbamodid,g_gzba_m.gzbamoddt,g_gzba_m.gzbaownid_desc,g_gzba_m.gzbacrtid_desc, 
       g_gzba_m.gzbaowndp_desc,g_gzba_m.gzbacrtdp_desc,g_gzba_m.gzbamodid_desc
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "gzba_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      INITIALIZE g_gzba_m.* TO NULL
      RETURN
   END IF
   
   #add-point:fetch段action控制
   
   #end add-point  
   
   
   
   #保存單頭舊值
   LET g_gzba_m_t.* = g_gzba_m.*
   LET g_gzba_m_o.* = g_gzba_m.*
   
   LET g_data_owner = g_gzba_m.gzbaownid      
   LET g_data_dept  = g_gzba_m.gzbaowndp
   
   #重新顯示
   CALL azzi001_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="azzi001.insert" >}
#+ 資料新增
PRIVATE FUNCTION azzi001_insert()
   #add-point:insert段define
   
   #end add-point    
   
   CLEAR FORM #清畫面欄位內容
   INITIALIZE g_gzba_m.* LIKE gzba_t.*             #DEFAULT 設定
   LET g_gzba001_t = NULL
 
   CALL s_transaction_begin()
   
   WHILE TRUE
      
      #公用欄位給值
      #此段落由子樣板a14產生    
      #公用欄位新增給值
      LET g_gzba_m.gzbaownid = g_user
      LET g_gzba_m.gzbaowndp = g_dept
      LET g_gzba_m.gzbacrtid = g_user
      LET g_gzba_m.gzbacrtdp = g_dept 
      LET g_gzba_m.gzbacrtdt = cl_get_current()
      LET g_gzba_m.gzbamodid = ""
      LET g_gzba_m.gzbamoddt = ""
      LET g_gzba_m.gzbastus = "N"
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
      
 
      #add-point:單頭預設值
      
      #end add-point   
     
      #顯示狀態(stus)圖片
            #此段落由子樣板a21產生
	  #根據狀態碼顯示對應圖片
      CASE g_gzba_m.gzbastus
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
     
      #資料輸入
      CALL azzi001_input("a")
      
      #add-point:單頭輸入後
      
      #end add-point
      
      IF INT_FLAG THEN
         #取消
         LET INT_FLAG = 0
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         DISPLAY g_current_cnt TO FORMONLY.h_count     #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index     #當下筆數
         INITIALIZE g_gzba_m.* TO NULL
         CALL azzi001_show()
         RETURN
      END IF
 
      LET g_rec_b = 0
      EXIT WHILE
   END WHILE
   
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_gzba001_t = g_gzba_m.gzba001
 
   
   #組合新增資料的條件
   LET g_add_browse = " gzbaent = '" ||g_enterprise|| "' AND",
                      " gzba001 = '", g_gzba_m.gzba001 CLIPPED, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL azzi001_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
 
END FUNCTION
 
{</section>}
 
{<section id="azzi001.modify" >}
#+ 資料修改
PRIVATE FUNCTION azzi001_modify()
   #add-point:modify段define
   
   #end add-point
   
   #先確定key值無遺漏
   IF g_gzba_m.gzba001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      RETURN
   END IF 
 
   ERROR ""
  
   #備份key值
   LET g_gzba001_t = g_gzba_m.gzba001
 
   
   CALL s_transaction_begin()
   
   #先lock資料
   OPEN azzi001_cl USING g_enterprise,g_gzba_m.gzba001
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN azzi001_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      CLOSE azzi001_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE azzi001_master_referesh USING g_gzba_m.gzba001 INTO g_gzba_m.gzba003,g_gzba_m.gzba001,g_gzba_m.gzba002, 
       g_gzba_m.gzbastus,g_gzba_m.gzbaownid,g_gzba_m.gzbacrtid,g_gzba_m.gzbaowndp,g_gzba_m.gzbacrtdp, 
       g_gzba_m.gzbacrtdt,g_gzba_m.gzbamodid,g_gzba_m.gzbamoddt,g_gzba_m.gzbaownid_desc,g_gzba_m.gzbacrtid_desc, 
       g_gzba_m.gzbaowndp_desc,g_gzba_m.gzbacrtdp_desc,g_gzba_m.gzbamodid_desc
 
   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "gzba_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      CLOSE azzi001_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   
 
   #顯示資料
   CALL azzi001_show()
   
   WHILE TRUE
      LET g_gzba_m.gzba001 = g_gzba001_t
 
      
      #寫入修改者/修改日期資訊
      LET g_gzba_m.gzbamodid = g_user 
LET g_gzba_m.gzbamoddt = cl_get_current()
LET g_gzba_m.gzbamodid_desc = cl_get_username(g_gzba_m.gzbamodid)
      
      #add-point:modify段修改前
      
      #end add-point
 
      #資料輸入
      CALL azzi001_input("u")     
 
      #add-point:modify段修改後
      
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_gzba_m.* = g_gzba_m_t.*
         CALL azzi001_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
         EXIT WHILE
      END IF
 
      #若有modid跟moddt則進行update
      UPDATE gzba_t SET (gzbamodid,gzbamoddt) = (g_gzba_m.gzbamodid,g_gzba_m.gzbamoddt)
       WHERE gzbaent = g_enterprise AND gzba001 = g_gzba001_t
 
 
      EXIT WHILE
      
   END WHILE
   
   CLOSE azzi001_cl
   CALL s_transaction_end('Y','0')
 
   #流程通知預埋點-U(暫時無用)
   #CALL cl_flow_notify(g_gzba_m.gzba001,"U")
   
   LET g_worksheet_hidden = 0
   
END FUNCTION   
 
{</section>}
 
{<section id="azzi001.input" >}
#+ 資料輸入
PRIVATE FUNCTION azzi001_input(p_cmd)
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
   DEFINE l_cmd_t          LIKE type_t.chr1   #161018-00026#1
   DEFINE l_flow_wc        STRING  #流程圖用
   DEFINE l_save_cnt       INTEGER #通知WebComponent要取得資料的計數器
   DEFINE l_flow_changed   BOOLEAN
   DEFINE l_con_opts          RECORD
            id                   STRING,
            module               STRING
                              END RECORD
   #先做狀態判定   #161018-00026#1
   IF p_cmd = 'r' THEN
      LET l_cmd_t = 'r'
      LET p_cmd   = 'a'
   ELSE
      LET l_cmd_t = p_cmd
   END IF  
   #end add-point
 
   #切換至輸入畫面
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_gzba_m.gzbal003,g_gzba_m.gzbal003_1,g_gzba_m.gzba003,g_gzba_m.gzba001,g_gzba_m.gzba002, 
       g_gzba_m.gzbastus,g_gzba_m.gzbaownid,g_gzba_m.gzbaownid_desc,g_gzba_m.gzbacrtid,g_gzba_m.gzbacrtid_desc, 
       g_gzba_m.gzbaowndp,g_gzba_m.gzbaowndp_desc,g_gzba_m.gzbacrtdp,g_gzba_m.gzbacrtdp_desc,g_gzba_m.gzbacrtdt, 
       g_gzba_m.gzbamodid,g_gzba_m.gzbamodid_desc,g_gzba_m.gzbamoddt
   
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
   CALL azzi001_set_entry(p_cmd)
   #add-point:set_entry後

   #end add-point
   CALL azzi001_set_no_entry(p_cmd)
   #add-point:資料輸入前
 
   #end add-point
   
   DISPLAY BY NAME g_gzba_m.gzbal003,g_gzba_m.gzbal003_1,g_gzba_m.gzba003,g_gzba_m.gzba001,g_gzba_m.gzba002, 
       g_gzba_m.gzbastus
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #單頭段
      INPUT BY NAME g_gzba_m.gzbal003,g_gzba_m.gzbal003_1,g_gzba_m.gzba003,g_gzba_m.gzba001,g_gzba_m.gzba002, 
          g_gzba_m.gzbastus, l_flow_wc
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         #+ 此段落由子樣板a43產生
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item
               CALL n_gzbal(g_gzba_m.gzba001)
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_gzba_m.gzba001
               CALL ap_ref_array2(g_ref_fields," SELECT gzbal003 FROM gzbal_t WHERE gzbal001 = ? AND gzbal002 = '"||g_lang||"' AND gzbalent = '"||g_enterprise||"' ","") RETURNING g_rtn_fields
               LET g_gzba_m.gzbal003 = g_rtn_fields[1]
               DISPLAY BY NAME g_gzba_m.gzbal003
                              
               #END add-point
            END IF
 
 
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            #其他table資料備份(確定是否更改用)
            LET g_master_multi_table_t.gzbal001 = g_gzba_m.gzba001
LET g_master_multi_table_t.gzbal003 = g_gzba_m.gzbal003
 
            #add-point:input開始前
            #通知WebComponent可設定
            #如果是新增，則清空流程圖
            IF p_cmd = 'a' AND l_cmd_t <> 'r' THEN   #161018-00026#1
               #LET g_curr_gzba001 = g_gzba_m.gzba001
               CALL azzi001_submit_wc("l_flow_wc", "flow", azzi001_get_flow(NULL, TRUE))
               CALL ui.interface.refresh()
               CALL azzi001_render_modules()
            END IF
            
            IF l_cmd_t <> 'r' THEN    #161018-00026#1
               CALL azzi001_submit_wc("l_flow_wc", "enable", "true")
            END IF

            #end add-point
   
                  #此段落由子樣板a01產生
         BEFORE FIELD gzbal003
            #add-point:BEFORE FIELD gzbal003

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzbal003
            
            #add-point:AFTER FIELD gzbal003

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE gzbal003
            #add-point:ON CHANGE gzbal003

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD gzbal003_1
            #add-point:BEFORE FIELD gzbal003_1

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzbal003_1
            
            #add-point:AFTER FIELD gzbal003_1

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE gzbal003_1
            #add-point:ON CHANGE gzbal003_1

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD gzba003
            #add-point:BEFORE FIELD gzba003

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzba003
            
            #add-point:AFTER FIELD gzba003

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE gzba003
            #add-point:ON CHANGE gzba003

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD gzba001
            #add-point:BEFORE FIELD gzba001

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzba001
            
            #add-point:AFTER FIELD gzba001
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_gzba_m.gzba001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_gzba_m.gzba001 != g_gzba001_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gzba_t WHERE "||"gzbaent = '" ||g_enterprise|| "' AND "||"gzba001 = '"||g_gzba_m.gzba001 ||"' ",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE gzba001
            #add-point:ON CHANGE gzba001

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD gzba002
            #add-point:BEFORE FIELD gzba002

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzba002
            
            #add-point:AFTER FIELD gzba002
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_gzba_m.gzba001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_gzba_m.gzba001 != g_gzba001_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gzba_t WHERE "||"gzbaent = '" ||g_enterprise|| "' AND "||"gzba001 = '"||g_gzba_m.gzba001 ||"' ",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE gzba002
            #add-point:ON CHANGE gzba002

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD gzbastus
            #add-point:BEFORE FIELD gzbastus

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzbastus
            
            #add-point:AFTER FIELD gzbastus

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE gzbastus
            #add-point:ON CHANGE gzbastus

            #END add-point
 
 #欄位檢查
                  #Ctrlp:input.c.gzbal003
         ON ACTION controlp INFIELD gzbal003
            #add-point:ON ACTION controlp INFIELD gzbal003

            #END add-point
 
         #Ctrlp:input.c.gzbal003_1
         ON ACTION controlp INFIELD gzbal003_1
            #add-point:ON ACTION controlp INFIELD gzbal003_1

            #END add-point
 
         #Ctrlp:input.c.gzba003
         ON ACTION controlp INFIELD gzba003
            #add-point:ON ACTION controlp INFIELD gzba003

            #END add-point
 
         #Ctrlp:input.c.gzba001
         ON ACTION controlp INFIELD gzba001
            #add-point:ON ACTION controlp INFIELD gzba001

            #END add-point
 
         #Ctrlp:input.c.gzba002
         ON ACTION controlp INFIELD gzba002
            #add-point:ON ACTION controlp INFIELD gzba002

            #END add-point
 
         #Ctrlp:input.c.gzbastus
         ON ACTION controlp INFIELD gzbastus
            #add-point:ON ACTION controlp INFIELD gzbastus

            #END add-point
 
 #欄位開窗
 
         AFTER INPUT
            #若點選cancel則離開dialog
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
            
            #錯誤訊息統整顯示
            #CALL cl_err_collect_show()
            #CALL cl_showmsg()
  
            IF p_cmd <> "u" THEN
               #當p_cmd不為u代表為新增/複製
               LET l_count = 1  
 
               #確定新增的資料不存在(不重複)
               SELECT COUNT(*) INTO l_count FROM gzba_t
                WHERE gzbaent = g_enterprise AND gzba001 = g_gzba_m.gzba001
 
               IF l_count = 0 THEN
               
                  #add-point:單頭新增前
 
                  #end add-point
               
                  #將新增的單頭資料寫入資料庫
                  INSERT INTO gzba_t (gzbaent,gzba003,gzba001,gzba002,gzbastus,gzbaownid,gzbacrtid,gzbaowndp, 
                      gzbacrtdp,gzbacrtdt)
                  VALUES (g_enterprise,g_gzba_m.gzba003,g_gzba_m.gzba001,g_gzba_m.gzba002,g_gzba_m.gzbastus, 
                      g_gzba_m.gzbaownid,g_gzba_m.gzbacrtid,g_gzba_m.gzbaowndp,g_gzba_m.gzbacrtdp,g_gzba_m.gzbacrtdt)  
 
                  
                  #add-point:單頭新增中

                  #end add-point
                  
                  #若寫入錯誤則提示錯誤訊息並返回輸入頁面
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzba_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     CONTINUE DIALOG
                  END IF
                  
                  
                  
                  #資料多語言用-增/改
                           INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         IF g_gzba_m.gzba001 = g_master_multi_table_t.gzbal001 AND
         g_gzba_m.gzbal003 = g_master_multi_table_t.gzbal003  THEN
         ELSE 
            LET l_var_keys[01] = g_gzba_m.gzba001
            LET l_field_keys[01] = 'gzbal001'
            LET l_var_keys_bak[01] = g_master_multi_table_t.gzbal001
            LET l_var_keys[02] = g_dlang
            LET l_field_keys[02] = 'gzbal002'
            LET l_var_keys_bak[02] = g_dlang
            LET l_vars[01] = g_gzba_m.gzbal003
            LET l_fields[01] = 'gzbal003'
            LET l_vars[02] = g_enterprise 
            LET l_fields[02] = 'gzbalent'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'gzbal_t')
         END IF 
 
                  
                  #add-point:單頭新增後
#                   IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
#                      #CALL azzi001_detail_reproduce()
#                   END IF
                   CALL azzi001_refresh_tree(DIALOG)
                  #end add-point
                  
                  CALL s_transaction_end('Y','0')
               ELSE
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend =  "g_gzba_m.gzba001" 
                  LET g_errparam.code   = "std-00006" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
               END IF 
            ELSE
               #add-point:單頭修改前
 
               #end add-point
               UPDATE gzba_t SET (gzba003,gzba001,gzba002,gzbastus,gzbaownid,gzbacrtid,gzbaowndp,gzbacrtdp, 
                   gzbacrtdt) = (g_gzba_m.gzba003,g_gzba_m.gzba001,g_gzba_m.gzba002,g_gzba_m.gzbastus, 
                   g_gzba_m.gzbaownid,g_gzba_m.gzbacrtid,g_gzba_m.gzbaowndp,g_gzba_m.gzbacrtdp,g_gzba_m.gzbacrtdt) 
 
                WHERE gzbaent = g_enterprise AND gzba001 = g_gzba001_t #
 
               #add-point:單頭修改中

               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzba_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzba_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                  OTHERWISE
                     
                     #資料多語言用-增/改
                              INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         IF g_gzba_m.gzba001 = g_master_multi_table_t.gzbal001 AND
         g_gzba_m.gzbal003 = g_master_multi_table_t.gzbal003  THEN
         ELSE 
            LET l_var_keys[01] = g_gzba_m.gzba001
            LET l_field_keys[01] = 'gzbal001'
            LET l_var_keys_bak[01] = g_master_multi_table_t.gzbal001
            LET l_var_keys[02] = g_dlang
            LET l_field_keys[02] = 'gzbal002'
            LET l_var_keys_bak[02] = g_dlang
            LET l_vars[01] = g_gzba_m.gzbal003
            LET l_fields[01] = 'gzbal003'
            LET l_vars[02] = g_enterprise 
            LET l_fields[02] = 'gzbalent'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'gzbal_t')
         END IF 
 
                     #add-point:單頭修改後
         CALL azzi001_refresh_tree(DIALOG)
                     #end add-point
                     #紀錄資料更動
                     LET g_log1 = util.JSON.stringify(g_gzba_m_t)
                     LET g_log2 = util.JSON.stringify(g_gzba_m)
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
      #狀態碼切換
      ON ACTION statechange
         CALL azzi001_statechange()
         LET g_action_choice="statechange"
         
#========  WebComponent 操作區塊 Start  ========#

      #WebComponent載入完成後呼叫
      ON ACTION wc_init
         #DISPLAY "Web Component初始化"
         #CALL p_dy_flow_property_comp("l_flow_wc", "type", "flow")
         #CALL p_dy_flow_property_comp("l_flow_wc", "data", 產生json格式的流程圖資料)
      
      #當節點有任何改變時
      ON ACTION wc_changed
         #DISPLAY "節點改變"
         LET l_flow_changed = TRUE
         CALL azzi001_set_act_active("save", l_flow_changed)
         
      ON ACTION wc_edit_node
         CALL azzi001_edit_node(l_flow_wc, g_curr_gzba001)
         #DISPLAY "編輯節點: ", l_flow_wc
         
      #新增連結線
      #ON ACTION wc_add_connect         
      #刪除連結線      
      #ON ACTION wc_del_connect         
      #更新節點位置
      #ON ACTION wc_position_node
      #新增節點
      ON ACTION wc_add_node
         TRY
            CALL util.JSON.parse(l_flow_wc, l_con_opts)
            CALL azzi001_edit_node(l_flow_wc, l_con_opts.id)
         CATCH 
            ERROR "parse json data error: ", l_flow_wc
         END TRY
         
      #刪除節點
      #ON ACTION wc_delete_node
      
      #由WebComponent回傳完整的資料      
      ON ACTION wc_get_data
         LET l_flow_changed = FALSE
         IF p_cmd = 'a' THEN
             LET g_curr_gzba001 = g_gzba_m.gzba001
         END IF
         CALL azzi001_set_act_active("save", l_flow_changed)
         IF l_cmd_t <> 'r' THEN #161018-00026#1
         CALL azzi001_save_flow(g_curr_gzba001, l_flow_wc)
         END　IF #161018-00026#1
         ACCEPT DIALOG
         #DISPLAY "資料已回傳:"
         #DISPLAY l_flow_wc
         #CALL show_dialog(wc2)
      #end add-point
    
      BEFORE DIALOG
         #CALL cl_err_collect_init()
         #add-point:input段before_dialog 
         CALL DIALOG.setActionHidden("wc_init", TRUE)
         CALL DIALOG.setActionHidden("wc_changed", TRUE)
         CALL DIALOG.setActionHidden("wc_edit_node", TRUE)
         CALL DIALOG.setActionHidden("wc_add_node", TRUE)
         CALL DIALOG.setActionHidden("wc_get_data", TRUE)
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
         LET l_save_cnt = l_save_cnt + 1
         CALL azzi001_submit_wc("l_flow_wc", "getData", l_save_cnt)
         NEXT FIELD l_flow_wc
         
      #放棄輸入
      ON ACTION cancel
         LET g_action_choice=""
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      #在dialog 右上角 (X)
      ON ACTION close 
         LET INT_FLAG = TRUE 
         EXIT DIALOG
    
      #toolbar 離開
      ON ACTION exit
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
 
{<section id="azzi001.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION azzi001_reproduce()
   DEFINE l_newno     LIKE gzba_t.gzba001 
   DEFINE l_oldno     LIKE gzba_t.gzba001 
 
   DEFINE l_master    RECORD LIKE gzba_t.*
   DEFINE l_cnt       LIKE type_t.num5
   #add-point:reproduce段define
 
   #end add-point   
   
   #切換畫面
   
   #先確定key值無遺漏
   IF g_gzba_m.gzba001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   #備份key值
   LET g_gzba001_t = g_gzba_m.gzba001
 
   
   #清空key值
   LET g_gzba_m.gzba001 = ""
 
    
   CALL azzi001_set_entry("a")
   CALL azzi001_set_no_entry("a")
   
   #公用欄位給予預設值
   #此段落由子樣板a14產生    
      #公用欄位新增給值
      LET g_gzba_m.gzbaownid = g_user
      LET g_gzba_m.gzbaowndp = g_dept
      LET g_gzba_m.gzbacrtid = g_user
      LET g_gzba_m.gzbacrtdp = g_dept 
      LET g_gzba_m.gzbacrtdt = cl_get_current()
      LET g_gzba_m.gzbamodid = ""
      LET g_gzba_m.gzbamoddt = ""
      #LET g_gzba_m.gzbastus = "N" #161018-00026#1
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前
   LET g_gzba_m.gzba001 = azzi001_gen_gzba001()   #161018-00026#1
   CALL azzi001_detail_reproduce()                #161018-00026#1
   LET g_curr_gzba001 = g_gzba_m.gzba001          #161018-00026#1
   #end add-point
   
   #顯示狀態(stus)圖片
         #此段落由子樣板a21產生
	  #根據狀態碼顯示對應圖片
      CASE g_gzba_m.gzbastus
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
   
   #資料輸入
   CALL azzi001_input("r")
 
   #清空key欄位的desc
   
    
   IF INT_FLAG THEN
      #取消
      LET INT_FLAG = 0
      CALL azzi001_delete1(g_gzba_m.gzba001,false) #161018-00026#1           
      INITIALIZE g_gzba_m.* TO NULL
      #LET g_gzba_m.gzba001 = g_gzba001_t #161018-00026#1 
      LET g_curr_gzba001 = g_gzba001_t #161018-00026#1
      CALL azzi001_show()  
      
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = 9001 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      RETURN
   END IF
   
   #CALL s_transaction_begin()   #161018-00026#1 mark
   
   #add-point:單頭複製前

   #end add-point
   
   #add-point:單頭複製中

   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "gzba_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:單頭複製後
    
   #end add-point
   
   CALL s_transaction_end('Y','0')
   
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_gzba001_t = g_gzba_m.gzba001
 
   
   #組合新增資料的條件
   LET g_add_browse = " gzbaent = '" ||g_enterprise|| "' AND",
                      " gzba001 = '", g_gzba_m.gzba001 CLIPPED, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL azzi001_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後
    #call azzi001_detail_reproduce()
   #end add-point
                   
END FUNCTION
 
{</section>}
 
{<section id="azzi001.show" >}
#+ 資料顯示 
PRIVATE FUNCTION azzi001_show()
   #add-point:show段define
   
   #end add-point  
   
   #add-point:show段之前
   
   #end add-point
   
   
   
   #在browser 移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()
   
   #帶出公用欄位reference值
   
 
    
   #顯示followup圖示
   #+ 此段落由子樣板a48產生
   CALL azzi001_set_pk_array()
   #add-point:ON ACTION agendum
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
 
 
   
   #讀入ref值(單頭)
   #add-point:show段reference

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_gzba_m.gzba001
   CALL ap_ref_array2(g_ref_fields," SELECT gzbal003 FROM gzbal_t WHERE gzbalent = '"||g_enterprise||"' AND gzbal001 = ? AND gzbal002 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET g_gzba_m.gzbal003 = g_rtn_fields[1] 
   DISPLAY g_gzba_m.gzbal003 TO gzbal003
   #end add-point
 
   #將資料輸出到畫面上
   DISPLAY BY NAME g_gzba_m.gzbal003,g_gzba_m.gzbal003_1,g_gzba_m.gzba003,g_gzba_m.gzba001,g_gzba_m.gzba002, 
       g_gzba_m.gzbastus,g_gzba_m.gzbaownid,g_gzba_m.gzbaownid_desc,g_gzba_m.gzbacrtid,g_gzba_m.gzbacrtid_desc, 
       g_gzba_m.gzbaowndp,g_gzba_m.gzbaowndp_desc,g_gzba_m.gzbacrtdp,g_gzba_m.gzbacrtdp_desc,g_gzba_m.gzbacrtdt, 
       g_gzba_m.gzbamodid,g_gzba_m.gzbamodid_desc,g_gzba_m.gzbamoddt
   
   #顯示狀態(stus)圖片
         #此段落由子樣板a21產生
	  #根據狀態碼顯示對應圖片
      CASE g_gzba_m.gzbastus
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
   #add-point:show段之後
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="azzi001.delete" >}
#+ 資料刪除 
PRIVATE FUNCTION azzi001_delete()
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define
   
   #end add-point  
   
   #先確定key值無遺漏
   IF g_gzba_m.gzba001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
    
   LET g_gzba001_t = g_gzba_m.gzba001
 
   
   LET g_master_multi_table_t.gzbal001 = g_gzba_m.gzba001
LET g_master_multi_table_t.gzbal003 = g_gzba_m.gzbal003
 
 
   OPEN azzi001_cl USING g_enterprise,g_gzba_m.gzba001
 
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN azzi001_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      CLOSE azzi001_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE azzi001_master_referesh USING g_gzba_m.gzba001 INTO g_gzba_m.gzba003,g_gzba_m.gzba001,g_gzba_m.gzba002, 
       g_gzba_m.gzbastus,g_gzba_m.gzbaownid,g_gzba_m.gzbacrtid,g_gzba_m.gzbaowndp,g_gzba_m.gzbacrtdp, 
       g_gzba_m.gzbacrtdt,g_gzba_m.gzbamodid,g_gzba_m.gzbamoddt,g_gzba_m.gzbaownid_desc,g_gzba_m.gzbacrtid_desc, 
       g_gzba_m.gzbaowndp_desc,g_gzba_m.gzbacrtdp_desc,g_gzba_m.gzbamodid_desc
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_gzba_m.gzba001 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      RETURN
   END IF
   
   #將最新資料顯示到畫面上
   CALL azzi001_show()
   
   IF cl_ask_delete() THEN
 
      #add-point:單頭刪除前
      
      #end add-point
 
      #+ 此段落由子樣板a47產生
      #刪除相關文件
      CALL azzi001_set_pk_array()
      #add-point:相關文件刪除前
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
      DELETE FROM gzba_t 
       WHERE gzbaent = g_enterprise AND gzba001 = g_gzba_m.gzba001 
 
 
      #add-point:單頭刪除中
      
      #end add-point
         
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gzba_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
      END IF
  
      INITIALIZE l_var_keys_bak TO NULL 
   INITIALIZE l_field_keys   TO NULL 
   LET l_var_keys_bak[01] = g_master_multi_table_t.gzbal001
   LET l_field_keys[01] = 'gzbal001'
   CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'gzbal_t')
 
      
      #add-point:單頭刪除後
      
      #end add-point
      
          
      CLEAR FORM
      CALL azzi001_ui_browser_refresh()
      
      #確保畫面上保有資料
      IF g_browser_cnt > 0 THEN
         #CALL azzi001_browser_fill(g_wc,"")
         CALL azzi001_fetch("P")
      ELSE
         #CALL azzi001_browser_fill(" 1=2","F")
         CLEAR FORM
      END IF
      
   END IF
 
   CLOSE azzi001_cl
   CALL s_transaction_end('Y','0')
 
   #流程通知預埋點-D
   CALL cl_flow_notify(g_gzba_m.gzba001,"D")
 
END FUNCTION
 
{</section>}
 
{<section id="azzi001.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION azzi001_ui_browser_refresh()
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define
   
   #end add-point     
 
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_gzba001 = g_gzba_m.gzba001
 
         THEN
         CALL g_browser.deleteElement(l_i)
         LET g_header_cnt = g_header_cnt - 1
       END IF
   END FOR
   
   DISPLAY g_header_cnt TO FORMONLY.b_count     #page count
   DISPLAY g_header_cnt TO FORMONLY.h_count     #page count
   LET g_browser_cnt = g_browser.getLength()
   #IF g_current_idx > g_browser_cnt THEN        #確定browse 筆數指在同一筆
   #   LET g_current_idx = g_browser_cnt
   #END IF
  
END FUNCTION
 
{</section>}
 
{<section id="azzi001.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION azzi001_set_entry(p_cmd)
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_entry段define
   
   #end add-point     
 
   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("gzba001",TRUE)
      #add-point:set_entry段欄位控制
      
      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="azzi001.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION azzi001_set_no_entry(p_cmd)
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_no_entry段define
   
   #end add-point     
 
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("gzba001",FALSE)
      #add-point:set_no_entry段欄位控制
      
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="azzi001.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION azzi001_default_search()
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
      LET ls_wc = ls_wc, " gzba001 = '", g_argv[01], "' AND "
   END IF
   
 
   
   #add-point:default_search段after sql
   
   #end add-point  
   
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
         LET g_wc = " 1=2"
      END IF
   END IF
   
   #add-point:default_search段結束前
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="azzi001.state_change" >}
   #+ 此段落由子樣板a09產生
#+ 確認碼變更
PRIVATE FUNCTION azzi001_statechange()
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define
   
   #end add-point  
   
   #add-point:statechange段開始前
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_gzba_m.gzba001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      RETURN
   END IF
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_gzba_m.gzbastus
            WHEN "N"
               HIDE OPTION "inactive"
            WHEN "Y"
               HIDE OPTION "active"
            
         END CASE
     
      #add-point:menu前
      
      #end add-point
      
      ON ACTION inactive
         IF cl_auth_chk_act("inactive") THEN
            LET lc_state = "N"
            #add-point:action控制
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION active
         IF cl_auth_chk_act("active") THEN
            LET lc_state = "Y"
            #add-point:action控制
            
            #end add-point
         END IF
         EXIT MENU
    
      
      
      #add-point:stus控制
      
      #end add-point
      
   END MENU
   
   IF (lc_state <> "N" 
      AND lc_state <> "Y"
      ) OR 
      cl_null(lc_state) THEN
      RETURN
   END IF
   
   #add-point:stus修改前
   
   #end add-point
      
   UPDATE gzba_t SET gzbastus = lc_state 
    WHERE gzbaent = g_enterprise AND gzba001 = g_gzba_m.gzba001
 
  
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
      LET g_gzba_m.gzbastus = lc_state
      DISPLAY BY NAME g_gzba_m.gzbastus
   END IF
 
   #add-point:stus修改後
   
   #end add-point
 
   #add-point:statechange段結束前
   
   #end add-point  
 
END FUNCTION
 
 
 
{</section>}
 
{<section id="azzi001.signature" >}
   
 
{</section>}
 
{<section id="azzi001.set_pk_array" >}
   #+ 此段落由子樣板a51產生
#+ 給予pk_array內容
PRIVATE FUNCTION azzi001_set_pk_array()
   #add-point:set_pk_array段define
   
   #end add-point
   
   #add-point:set_pk_array段之前
   
   #end add-point  
   
   CALL g_pk_array.clear()
   LET g_pk_array[1].values = g_gzba_m.gzba001
   LET g_pk_array[1].column = 'gzba001'
 
   
   #add-point:set_pk_array段之後
   
   #end add-point  
   
END FUNCTION
 
 
 
{</section>}
 
{<section id="azzi001.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="azzi001.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 填充系統流程選單
# Memo...........:
# Usage..........: CALL azzi001_fill_tree()
#                  RETURNING none
# Input parameter: none
# Return code....: none
# Date & Author..: 劉偉先
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi001_fill_tree()
   DEFINE ls_sql        STRING
   DEFINE li_len        INTEGER
   DEFINE li_cnt        INTEGER
   DEFINE li_idx        INTEGER
   DEFINE l_gzba_t      DYNAMIC ARRAY OF RECORD 
            gzba001     LIKE gzba_t.gzba001,
            gzba002     LIKE gzba_t.gzba002,
            gzbal003    LIKE gzbal_t.gzbal003
          END RECORD

   
   CALL g_detail1.clear()
   

   DECLARE detail1_root_cur CURSOR FOR detail1_root_pre
   LET li_idx = 1
   FOREACH detail1_root_cur INTO l_gzba_t[li_idx].*
      LET li_idx = li_idx + 1
   END FOREACH
   CALL l_gzba_t.deleteElement(li_idx)
   
   FOR li_idx = 1 TO l_gzba_t.getLength()
      CALL g_detail1.appendElement()
      LET li_len = g_detail1.getLength()
      
      #IF cl_null(l_gzba_t[li_idx].gzbal003) THEN LET l_gzba_t[li_idx].gzbal003 = l_gzba_t[li_idx].gzba001 END IF
      
      LET g_detail1[li_len].id = l_gzba_t[li_idx].gzba001
      LET g_detail1[li_len].pid = l_gzba_t[li_idx].gzba002
      LET g_detail1[li_len].name = l_gzba_t[li_idx].gzbal003  #, "(", l_gzba_t[li_idx].gzba001, ")"
      
      #展開子項
      EXECUTE detail1_children_cnt_pre USING l_gzba_t[li_idx].gzba001 INTO li_cnt
      IF li_cnt > 0 THEN
         CALL azzi001_fill_child(l_gzba_t[li_idx].gzba001)
         LET g_detail1[li_len].isnode = TRUE
         LET g_detail1[li_len].expanded = TRUE
      END IF
   END FOR
   FREE detail1_root_cur

END FUNCTION

################################################################################
# Descriptions...: 填充系統流程選單的子項
# Memo...........:
# Usage..........: CALL azzi001_fill_child(p_gzba001)
#                  RETURNING none
# Input parameter: p_gzba001    上層系統代號
# Return code....: none
# Date & Author..: 劉偉先
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi001_fill_child(p_gzba001)
   DEFINE p_gzba001     LIKE gzba_t.gzba001  #選單代號
   DEFINE li_len        INTEGER
   DEFINE li_cnt        INTEGER
   DEFINE li_idx        INTEGER
   DEFINE l_gzba_t      DYNAMIC ARRAY OF RECORD 
            gzba001     LIKE gzba_t.gzba001,
            gzba002     LIKE gzba_t.gzba002,
            gzbal003    LIKE gzbal_t.gzbal003
          END RECORD

   DECLARE detail1_children_cur CURSOR FOR detail1_children_pre
   
   LET li_idx = 1
   
   FOREACH detail1_children_cur USING p_gzba001 
                                INTO l_gzba_t[li_idx].*
      LET li_idx = li_idx + 1
   END FOREACH
   FREE detail1_children_cur
   
   CALL l_gzba_t.deleteElement(li_idx)
   
   FOR li_idx = 1 TO l_gzba_t.getLength()
      CALL g_detail1.appendElement()
      LET li_len = g_detail1.getLength()
      
      #IF cl_null(l_gzba_t[li_idx].gzbal003) THEN LET l_gzba_t[li_idx].gzbal003 = l_gzba_t[li_idx].gzba001 END IF
      
      LET g_detail1[li_len].id = l_gzba_t[li_idx].gzba001
      LET g_detail1[li_len].pid = l_gzba_t[li_idx].gzba002
      LET g_detail1[li_len].name = l_gzba_t[li_idx].gzbal003  #, "(", l_gzba_t[li_idx].gzba001, ")"
      #展開子項
      EXECUTE detail1_children_cnt_pre USING l_gzba_t[li_idx].gzba001 INTO li_cnt
      IF li_cnt > 0 THEN
         CALL azzi001_fill_child(l_gzba_t[li_idx].gzba001)
         LET g_detail1[li_len].isnode = TRUE
         LET g_detail1[li_len].expanded = TRUE
      END IF
   END FOR
   
END FUNCTION

################################################################################
# Descriptions...: 取代azzi001_ui_dialog()
# Memo...........:
# Usage..........: CALL azzi001_dialog()
#                  RETURNING none
# Input parameter: none
# Return code....: none
# Date & Author..: 劉偉先
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi001_dialog()
   DEFINE l_arr_curr          INTEGER
   DEFINE l_curr_gzba001      LIKE gzba_t.gzba001
   DEFINE l_last_dr           INTEGER
   DEFINE l_result            BOOLEAN
   DEFINE l_sql               STRING
   DEFINE dnd                 ui.DragDrop
   DEFINE l_flow_wc           STRING   #流程圖
   DEFINE l_flow_changed      BOOLEAN  #用來記錄流程圖是否已變更
   DEFINE l_flow_cfg          RECORD   #flow的設定
            editable          BOOLEAN, #是否可編輯
            enable            BOOLEAN, #是否啟用
            imagepath         STRING,  #節點圖示是相對路徑，必須指定image路徑給WebComponents使用
               lans              RECORD
                  C_TOOLS           STRING,
                  C_DELETE          STRING,
                  C_MODIFY          STRING,
                  C_GROUP_INTO      STRING,
                  C_UNGROUP         STRING,
                  C_DELETE_NODE     STRING,
                  C_DELETE_CONNECTION STRING,
                  C_DEFAULT         STRING,
                  C_RED             STRING,
                  C_ORANGE          STRING,
                  C_YELLOW          STRING,
                  C_GREEN           STRING,
                  C_BLUE            STRING,
                  C_DARKVIOLET      STRING
                                 END RECORD
          END RECORD
   DEFINE l_keys              DYNAMIC ARRAY OF LIKE gzba_t.gzba001 #用來記錄已選分類代碼及其所有子分類代碼
   DEFINE l_save_cnt          INTEGER  
   DEFINE la_param            RECORD                  #程式串查用變數
             prog                STRING,                 #串查程式名稱
             param               DYNAMIC ARRAY OF STRING #傳遞變數
                              END RECORD
   DEFINE l_con_opts          RECORD
            id                   STRING,
            module               STRING
                              END RECORD
   DEFINE l_sb                base.StringBuffer
   DEFINE l_json              STRING
   DEFINE l_gzba001           LIKE gzba_t.gzba001,
          l_gzba002           LIKE gzba_t.gzba002
   
   #組成GAS的ImageSource路徑 http://....../wa/i/app/xxx/DUA_HTML5/Image/
   INITIALIZE la_param TO null
   LET la_param.prog = "azzi001"
   LET l_sb = base.StringBuffer.create()
   CALL l_sb.append(cl_ap_url("GWC", util.JSON.stringify(la_param)))
   CALL l_sb.append("/DUA_HTML5/Image/")
   CALL l_sb.replace("/wa/r/", "/wa/i/", 1)
   
   LET l_sql = "SELECT * FROM gzbb_t WHERE gzbb002 = ? AND gzbbent = '", g_enterprise CLIPPED ,"'"
   PREPARE pre_gzbb_by_gzbb002  FROM l_sql
   
   LET l_sql = "SELECT * FROM gzbc_t WHERE gzbc001 = ? AND gzbc003 = ? "
   PREPARE pre_gzbc_by_gzbb001 FROM l_sql
   
   #LET l_sql = "SELECT gzbbl_t.*, gzzal003 FROM gzbbl_t LEFT JOIN gzzal_t ON gzzal001 = gzbbl003 ",
   #            " WHERE gzbbl001 = ? AND gzbblent = '", g_enterprise, "' "

   LET l_sql = "SELECT * FROM gzbbl_t ",
               " WHERE gzbbl001 = ? AND gzbblent = '", g_enterprise, "' "
               
   PREPARE pre_gzbbl_by_gzbb001 FROM l_sql
   
   LET l_sql = "SELECT * FROM gzbb_t WHERE gzbb002 = ? AND gzbbent = '", g_enterprise CLIPPED ,"'"   #161018-00026#1
   PREPARE pre_gzbb_by_gzbb0021  FROM l_sql                           #161018-00026#1
   DECLARE declare_gzbb_by_gzbb0021 CURSOR FOR pre_gzbb_by_gzbb0021   #161018-00026#1
   
   DECLARE declare_gzbb_by_gzbb002 CURSOR FOR pre_gzbb_by_gzbb002
   DECLARE declare_gzbc_by_gzbb001 CURSOR FOR pre_gzbc_by_gzbb001
   DECLARE declare_gzbbl_by_gzbb001 CURSOR FOR pre_gzbbl_by_gzbb001
   
   #開啟Flow為編輯模式
   LET l_flow_cfg.editable = TRUE
   LET l_flow_cfg.enable = FALSE
   LET l_flow_cfg.imagepath = l_sb.toString()
   LET l_flow_cfg.lans.C_TOOLS            = cl_getmsg("azz-00269", g_dlang)
   LET l_flow_cfg.lans.C_DELETE           = cl_getmsg("azz-00270", g_dlang)
   LET l_flow_cfg.lans.C_MODIFY           = cl_getmsg("azz-00271", g_dlang)
   LET l_flow_cfg.lans.C_GROUP_INTO       = cl_getmsg("azz-00272", g_dlang)
   LET l_flow_cfg.lans.C_UNGROUP          = cl_getmsg("azz-00273", g_dlang)
   LET l_flow_cfg.lans.C_DELETE_NODE      = cl_getmsg("azz-00275", g_dlang)
   LET l_flow_cfg.lans.C_DELETE_CONNECTION= cl_getmsg("azz-00276", g_dlang)
   LET l_flow_cfg.lans.C_DEFAULT          = cl_getmsg("azz-00414", g_dlang)
   LET l_flow_cfg.lans.C_RED              = cl_getmsg("azz-00408", g_dlang)
   LET l_flow_cfg.lans.C_ORANGE           = cl_getmsg("azz-00409", g_dlang)
   LET l_flow_cfg.lans.C_YELLOW           = cl_getmsg("azz-00410", g_dlang)
   LET l_flow_cfg.lans.C_GREEN            = cl_getmsg("azz-00411", g_dlang)
   LET l_flow_cfg.lans.C_BLUE             = cl_getmsg("azz-00412", g_dlang)
   LET l_flow_cfg.lans.C_DARKVIOLET       = cl_getmsg("azz-00413", g_dlang)

   LET l_flow_wc = util.JSON.stringify(l_flow_cfg)

   CALL azzi001_fill_tree()

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         
         
      DISPLAY ARRAY g_detail1 TO s_detail1.*
         ON DRAG_START (dnd)
            LET l_last_dr = arr_curr()
            CALL dnd.setOperation("move")
            LET l_gzba001 = g_detail1[l_last_dr].id


         ON DROP (dnd)
            #自動替換pid
            LET l_last_dr = dnd.getLocationRow()
            LET l_gzba002 = g_detail1[l_last_dr].id 
            LET g_gzba_m.gzba002 = g_detail1[l_last_dr].id 
            CALL dnd.dropInternal()

            #更新上層gzba002
            UPDATE gzba_t SET gzba002 = l_gzba002
                WHERE gzba001 = l_gzba001
                  AND gzbaent = g_enterprise
            #更新順序gzba003
            CALL azzi001_reorder_tree(g_gzba_m.gzba002)
            CALL azzi001_show()            
            
         BEFORE ROW
            #檢查流程圖是否已變更，要詢問是否儲存
            IF l_flow_changed == TRUE THEN
               LET l_result = FALSE
               MENU ATTRIBUTE (STYLE="dialog", 
                                        COMMENT="流程圖已變更，是否儲存？", 
                                        IMAGE="question")
                  ON ACTION yes
                     LET l_result = TRUE
                     EXIT MENU
                  ON ACTION no
                     EXIT MENU
               END MENU               
               IF l_result == TRUE THEN
                  CALL Dialog.setCurrentRow("s_detail1", l_arr_curr)
                  CALL azzi001_submit_wc("l_flow_wc", "getData", "")
                  CONTINUE DIALOG   
               END IF
            END IF
            LET l_arr_curr = ARR_CURR()
            LET l_flow_changed = FALSE
            CALL azzi001_set_act_active("save", l_flow_changed)
            LET l_curr_gzba001 = g_detail1[l_arr_curr].id
            LET g_curr_gzba001 = g_detail1[l_arr_curr].id
            CALL azzi001_fetch_master(g_curr_gzba001)
            LET l_json = azzi001_get_flow(g_curr_gzba001, FALSE)
            CALL azzi001_submit_wc("l_flow_wc", "flow", l_json)
      END DISPLAY
      
      INPUT l_flow_wc FROM l_flow_wc ATTRIBUTES(WITHOUT DEFAULTS=TRUE)
         BEFORE INPUT
            CALL azzi001_render_modules()

      END INPUT
      
      #由WebComponent回傳完整的資料      
      #ON ACTION wc_get_data
      #   LET l_flow_changed = FALSE
      #   CALL azzi001_set_act_active("save", l_flow_changed)
      #   CALL azzi001_save_flow(g_curr_gzba001, l_flow_wc)

      
      ON ACTION modify
         IF cl_auth_chk_act("modify") AND g_curr_gzba001 IS NOT NULL THEN
            LET g_aw = ''
            #進入修改區段，並判斷是否取消修改
            IF azzi001_modify1(g_curr_gzba001) == 0 THEN
               #取消修改時則直接通知WebComponent不可編輯
               #重新顯示Flow
               LET l_json = azzi001_get_flow(g_curr_gzba001, FALSE)
               CALL azzi001_submit_wc("l_flow_wc", "flow", l_json)
            ELSE
               #儲存修改則取得流程圖資料
               LET l_save_cnt = l_save_cnt + 1
               CALL azzi001_submit_wc("l_flow_wc", "getData", l_save_cnt)
            END IF
            
            #重新顯示資料
            CALL azzi001_fetch_master(g_curr_gzba001)
            CALL azzi001_refresh_tree(DIALOG)
            CALL ui.interface.refresh()

            LET INT_FLAG = FALSE
         END IF

      ON ACTION insert
         IF cl_auth_chk_act("insert") THEN
            
            IF azzi001_insert1(g_gzba_m.gzba001) == 0 THEN
               #把原本的Flow取回，取消修改時則直接通知WebComponent不可編輯
               LET g_curr_gzba001 = l_curr_gzba001
               CALL azzi001_fetch_master(g_curr_gzba001)
               LET l_json = azzi001_get_flow(g_curr_gzba001, FALSE)
               CALL azzi001_submit_wc("l_flow_wc", "flow", l_json)
            ELSE
               CALL azzi001_refresh_tree(DIALOG)
               #儲存修改則取得流程圖資料
               #LET l_save_cnt = l_save_cnt + 1
               #CALL azzi001_submit_wc("l_flow_wc", "getData", l_save_cnt)
               #CALL azzi001_refresh_tree(DIALOG)
            END IF
         END IF
         
      ON ACTION delete
         IF cl_auth_chk_act("delete") AND g_curr_gzba001 IS NOT NULL THEN
            call azzi001_delete1(g_curr_gzba001,true)
            CALL azzi001_refresh_tree(DIALOG)
            CALL azzi001_fetch_master(g_curr_gzba001)
            LET l_json = azzi001_get_flow(g_curr_gzba001, FALSE)
            CALL azzi001_submit_wc("l_flow_wc", "flow", l_json)
            
         END IF         
              
      ON ACTION close
         EXIT DIALOG
         
      ON ACTION exit
         EXIT DIALOG
         
      #azzi001_01可用的節點維護作業
      ON ACTION azzi001_01
         CALL azz_azzi001_01.azzi001_01()
         CALL azzi001_render_modules()
      
      ON ACTION reproduce
           LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL azzi001_reproduce()
               CALL azzi001_refresh_tree(DIALOG) #161018-00026#1
               CALL azzi001_fetch_master(g_curr_gzba001)#161018-00026#1
               LET l_json = azzi001_get_flow(g_curr_gzba001, FALSE)
               CALL azzi001_submit_wc("l_flow_wc", "flow", l_json)
            END IF
         
      #主選單用ACTION
      &include "main_menu.4gl"
      &include "relating_action.4gl"
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   END DIALOG
   
   FREE declare_gzbb_by_gzbb002   
   FREE declare_gzbc_by_gzbb001
   FREE declare_gzbbl_by_gzbb001
   FREE declare_gzbb_by_gzbb0021   #161018-00026#1
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
PRIVATE FUNCTION azzi001_fetch_master(p_gzba001)
   DEFINE p_gzba001     LIKE gzba_t.gzba001
   
   INITIALIZE g_gzba_m.* TO NULL
   
   IF p_gzba001 IS NOT NULL THEN   
      #讀取單頭所有欄位資料
      EXECUTE azzi001_master_referesh USING p_gzba001 INTO g_gzba_m.gzba003,g_gzba_m.gzba001,g_gzba_m.gzba002, 
         g_gzba_m.gzbastus,g_gzba_m.gzbaownid,g_gzba_m.gzbaowndp,g_gzba_m.gzbacrtid,g_gzba_m.gzbacrtdp, 
         g_gzba_m.gzbacrtdt,g_gzba_m.gzbamodid,g_gzba_m.gzbamoddt,g_gzba_m.gzbaownid_desc,g_gzba_m.gzbaowndp_desc, 
         g_gzba_m.gzbacrtid_desc,g_gzba_m.gzbacrtdp_desc,g_gzba_m.gzbamodid_desc
      LET g_gzba_m.gzbal003_1 = azzi001_get_lang(g_gzba_m.gzba002)
   END IF
   
   CALL azzi001_show()
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
PRIVATE FUNCTION azzi001_modify1(p_gzba001)
   DEFINE p_gzba001     LIKE gzba_t.gzba001
   DEFINE l_int_flag    BOOLEAN
   
   
   IF p_gzba001 IS NULL THEN
      LET INT_FLAG = TRUE
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err() 
      RETURN 0
   END IF 
 
   ERROR ""
  
   #備份key值
   LET g_gzba001_t = p_gzba001
 
   
   CALL s_transaction_begin()
   
   #先lock資料
   OPEN azzi001_cl USING g_enterprise, p_gzba001
   IF STATUS THEN
       LET INT_FLAG = TRUE
      INITIALIZE g_errparam TO NULL 
      LET INT_FLAG = TRUE
      LET g_errparam.extend = "OPEN azzi001_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      CLOSE azzi001_cl
      CALL s_transaction_end('N','0')
      RETURN 0
   END IF
 
   #顯示最新的資料
   EXECUTE azzi001_master_referesh USING p_gzba001 INTO g_gzba_m.gzba003,g_gzba_m.gzba001,g_gzba_m.gzba002, 
       g_gzba_m.gzbastus,g_gzba_m.gzbaownid,g_gzba_m.gzbaowndp,g_gzba_m.gzbacrtid,g_gzba_m.gzbacrtdp, 
       g_gzba_m.gzbacrtdt,g_gzba_m.gzbamodid,g_gzba_m.gzbamoddt,g_gzba_m.gzbaownid_desc,g_gzba_m.gzbaowndp_desc, 
       g_gzba_m.gzbacrtid_desc,g_gzba_m.gzbacrtdp_desc,g_gzba_m.gzbamodid_desc
   LET g_gzba_m.gzbal003_1 = azzi001_get_lang(g_gzba_m.gzba002)
   
   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      LET INT_FLAG = TRUE
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "gzba_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      CLOSE azzi001_cl
      CALL s_transaction_end('N','0')
      RETURN 0
   END IF
   
   
   WHILE TRUE
      LET g_gzba_m.gzba001 = g_gzba001_t
 
      
      #寫入修改者/修改日期資訊
      LET g_gzba_m.gzbamodid = g_user 
      LET g_gzba_m.gzbamoddt = cl_get_current()
 
      
      #add-point:modify段修改前

      #end add-point
 
      #資料輸入
      CALL azzi001_input("u")     
      LET l_int_flag = NOT INT_FLAG
      #add-point:modify段修改後

      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_gzba_m.* = g_gzba_m_t.*
         CALL azzi001_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
         EXIT WHILE
      END IF
 
      #若有modid跟moddt則進行update
      UPDATE gzba_t SET (gzbamodid,gzbamoddt) = (g_gzba_m.gzbamodid,g_gzba_m.gzbamoddt)
       WHERE gzbaent = g_enterprise AND gzba001 = g_gzba001_t
 
 
      EXIT WHILE
      
   END WHILE
   
   CLOSE azzi001_cl
   CALL s_transaction_end('Y','0')
   RETURN l_int_flag
END FUNCTION

################################################################################
# Descriptions...: 在目前的節點下建立新節點
# Memo...........:
# Usage..........: CALL azzi001_insert1(p_gzba002)
#                  RETURNING none
# Input parameter: p_gzba002    上層代號
# Return code....: none
# Date & Author..: 劉偉先
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi001_insert1(p_gzba002)
   DEFINE p_gzba002     LIKE gzba_t.gzba002
   DEFINE l_int_flag    INTEGER
   #清單頭欄位內容
   CLEAR g_gzba_m.* 
   INITIALIZE g_gzba_m.* TO NULL
   LET g_gzba001_t = NULL
 
   CALL s_transaction_begin()
   
   WHILE TRUE
      
      #自動建立選單代號
      LET g_gzba_m.gzba001 = azzi001_gen_gzba001()
      LET g_gzba_m.gzba002 = p_gzba002
      LET g_gzba_m.gzbal003_1 = azzi001_get_lang(p_gzba002)
      #公用欄位給值
      LET g_gzba_m.gzbaownid = g_user
      LET g_gzba_m.gzbaowndp = g_dept
      LET g_gzba_m.gzbacrtid = g_user
      LET g_gzba_m.gzbacrtdp = g_dept 
      LET g_gzba_m.gzbacrtdt = cl_get_current()
      LET g_gzba_m.gzbamodid = ""
      LET g_gzba_m.gzbamoddt = ""
      LET g_gzba_m.gzbastus = "Y" 

	   #根據狀態碼顯示對應圖片
      CASE g_gzba_m.gzbastus
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
      END CASE
      
      #資料輸入
      CALL azzi001_input("a")
      
      #add-point:單頭輸入後

      #end add-point
      LET l_int_flag = NOT INT_FLAG
      IF INT_FLAG THEN
         #取消
         LET INT_FLAG = 0
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         DISPLAY g_current_cnt TO FORMONLY.h_count     #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index     #當下筆數
         INITIALIZE g_gzba_m.* TO NULL
         CALL azzi001_show()
         RETURN l_int_flag
      END IF
      
      LET g_rec_b = 0
      EXIT WHILE
   END WHILE
   
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_gzba001_t = g_gzba_m.gzba001
   LET g_curr_gzba001 = g_gzba_m.gzba001
   RETURN l_int_flag
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
PRIVATE FUNCTION azzi001_get_lang(p_gzbal001)
   DEFINE p_gzbal001    LIKE gzbal_t.gzbal001
   DEFINE l_gzbal003    LIKE gzbal_t.gzbal003
   DEFINE l_cnt         INTEGER

   SELECT COUNT(*) INTO l_cnt FROM gzbal_t WHERE gzbal001 = p_gzbal001 AND gzbal002 = g_dlang AND gzbalent = g_enterprise
   
   IF l_cnt == 1 THEN
      SELECT gzbal003 INTO l_gzbal003 FROM gzbal_t
         WHERE gzbal001 = p_gzbal001
           AND gzbal002 = g_dlang
           AND gzbalent = g_enterprise
   END IF
   RETURN l_gzbal003
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
PRIVATE FUNCTION azzi001_refresh_tree(p_dialog)
   DEFINE p_dialog      ui.Dialog
   DEFINE l_arr_curr    INTEGER
   DEFINE l_idx         INTEGER
   LET l_arr_curr = p_dialog.getCurrentRow("s_detail1")
   CALL azzi001_fill_tree()
   FOR l_idx = 1 TO g_detail1.getLength()
      IF g_detail1[l_idx].id = g_curr_gzba001 THEN
         LET l_arr_curr = l_idx
         EXIT FOR
      END IF
   END FOR
   IF l_arr_curr == 0 THEN RETURN END IF
   LET g_curr_gzba001 = g_detail1[l_arr_curr].id
   CALL p_dialog.setCurrentRow("s_detail1", l_arr_curr)
END FUNCTION

################################################################################
# Descriptions...: 刪除分類及其所有子分類
# Memo...........:
# Usage..........: CALL azzi001_delete1(p_gzba001)
#                  RETURNING none
# Input parameter: p_gzba001      分類代號
# Input parameter: del      true為刪除false為複製取消
# Return code....: none
# Date & Author..: 劉偉先
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi001_delete1(p_gzba001,del)
   DEFINE  p_gzba001       LIKE gzba_t.gzba001
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   DEFINE  l_keys          DYNAMIC ARRAY OF LIKE gzba_t.gzba001
   DEFINE  l_idx           INTEGER
   DEFINE  del             BOOLEAN

   #先確定key值無遺漏
   IF p_gzba001 IS NULL THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   #先取得分類下的所有子分類代號   
   CALL l_keys.clear()
   LET l_keys[1] = p_gzba001
   CALL azzi001_get_children_key(p_gzba001, l_keys)   

   
   CALL s_transaction_begin()
    
   LET g_gzba001_t = p_gzba001
   
   OPEN azzi001_cl USING g_enterprise, p_gzba001
 
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN azzi001_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      CLOSE azzi001_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF 
   
   #是刪除跳出詢問視窗
   IF del THEN
     IF cl_ask_delete()!=true THEN
       CLOSE azzi001_cl
       CALL s_transaction_end('Y','0') 
       #流程通知預埋點-D
       CALL cl_flow_notify(g_gzba_m.gzba001,"D")
       RETURN
     END IF     
   END IF
   
   
   #執行刪除工作
      FOR l_idx = 1 TO l_keys.getLength()  
         #刪除選單分類      
         DELETE FROM gzba_t 
            WHERE gzbaent = g_enterprise AND gzba001 = l_keys[l_idx]
         IF SQLCA.sqlcode THEN EXIT FOR END IF
         #刪除相關的多語言
         DELETE FROM gzbal_t
            WHERE gzbalent = g_enterprise AND gzbal001 = l_keys[l_idx]
         IF SQLCA.sqlcode THEN EXIT FOR END IF
         #刪除節點
         CALL azzi001_del_gzbb_by_gzba001(l_keys[l_idx])
      END FOR
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gzba_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
      ELSE
         #刪除相關文件
         CALL g_pk_array.clear()
         INITIALIZE l_var_keys_bak TO NULL 
         INITIALIZE l_field_keys   TO NULL 
         FOR l_idx = 1 TO l_keys.getLength()            
            LET g_pk_array[l_idx].values = l_keys[l_idx]
            LET g_pk_array[l_idx].column = 'gzba001'
         END FOR
         CALL cl_doc_remove()  
    
         CLEAR FORM
      END IF
   
      

 
   CLOSE azzi001_cl
   CALL s_transaction_end('Y','0')
 
   #流程通知預埋點-D
   CALL cl_flow_notify(g_gzba_m.gzba001,"D")
END FUNCTION

################################################################################
# Descriptions...: 依據樹的順序更新gzba003
# Memo...........:
# Usage..........: CALL azzi001_reorder_tree(p_gzba002)
#                  RETURNING none
# Input parameter: p_gzba002   上層代號
# Return code....: none
# Date & Author..: 劉偉先
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi001_reorder_tree(p_gzba002)
   DEFINE p_gzba002     LIKE gzba_t.gzba002
   DEFINE l_gzba001     LIKE gzba_t.gzba001,
          l_gzba002     LIKE gzba_t.gzba002   
   DEFINE li_idx        INTEGER
   DEFINE li_i          INTEGER
   
   LET li_i = 0
   FOR li_idx = 1 TO g_detail1.getLength()
      IF g_detail1[li_idx].pid == p_gzba002 THEN
         LET li_i = li_i + 1
         LET l_gzba001 = g_detail1[li_idx].id
         LET l_gzba002 = g_detail1[li_idx].pid
         UPDATE gzba_t SET gzba003 = li_id 
          WHERE gzba001 = l_gzba001
            AND gzba002 = l_gzba002
            AND gzbaent = g_enterprise
      END IF
   END FOR
   
END FUNCTION

################################################################################
# Descriptions...: 取得指定的所有子分類gzba001
# Memo...........:
# Usage..........: CALL azzi001_get_children_key(p_gzba001)
#                  RETURNING none
# Input parameter: p_gzba001      指定的分類代號
#                : p_keys         要存放的代號的陣列
# Return code....: none
# Date & Author..: 劉偉先
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi001_get_children_key(p_gzba001,p_keys)
   DEFINE p_gzba001     LIKE gzba_t.gzba001
   DEFINE p_keys        DYNAMIC ARRAY OF LIKE gzba_t.gzba001
   DEFINE l_keys        DYNAMIC ARRAY OF LIKE gzba_t.gzba001
   DEFINE li_idx        INTEGER
   DEFINE li_cnt        INTEGER
   LET li_idx = 1
   DECLARE detail1_gzba001_cur CURSOR FOR detail1_gzba001_pre   
   FOREACH detail1_gzba001_cur USING p_gzba001 INTO l_keys[li_idx]
      LET li_idx = li_idx + 1
   END FOREACH
   FREE detail1_gzba001_cur
   LET li_cnt = li_idx - 1

   
   FOR li_idx = 1 TO li_cnt
      CALL p_keys.appendElement()
      LET p_keys[p_keys.getLength()] = l_keys[li_idx]
      CALL azzi001_get_children_key(l_keys[li_idx], p_keys)
   END FOR

   
END FUNCTION

################################################################################
# Descriptions...: 更新WebComponent
# Memo...........:
# Usage..........: CALL azzi001_property_comp(p_wcname, p_prop_name, p_prop_value)
#                  RETURNING none
# Input parameter: p_wcname       WebComponent控件代號
#                : p_prop_name    WebComponent屬性名稱
#                : p_prop_value   WebComponent屬性值
# Return code....: none
# Date & Author..: 劉偉先
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi001_property_comp(p_wcname,p_prop_name,p_prop_value)
   DEFINE p_wcname STRING
   DEFINE p_prop_name STRING
   DEFINE p_prop_value STRING
   DEFINE win ui.Window
   DEFINE l_ff    om.DomNode
   DEFINE win_node      om.DomNode
   DEFINE l_nl   om.NodeList
   DEFINE l_wc  om.DomNode
   DEFINE l_dict    om.DomNode
   DEFINE l_prop    om.DomNode

   LET win = ui.Window.getCurrent()
   LET win_node = win.getNode()

   LET l_nl = win_node.selectByPath("//FormField[@name=\"formonly."|| p_wcname ||"\"]")

   IF l_nl.getLength() > 0 THEN
      LET l_ff = l_nl.item(1)
      LET l_wc = l_ff.getFirstChild()
      LET l_dict = l_wc.getFirstChild()
      IF l_dict IS NULL THEN
        LET l_dict = l_wc.createChild("PropertyDict")
        CALL l_dict.setAttribute("name", "properties")
      END IF
      LET l_nl = l_dict.selectByPath("//Property[@name=\"" || p_prop_name || "\"]")
      LET l_prop = l_nl.item(1)
      IF l_prop IS NULL THEN
         LET l_prop = l_dict.createChild("Property")
         CALL l_prop.setAttribute("name", p_prop_name)
      END IF
      CALL l_prop.setAttribute("value", p_prop_value)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 指定按鈕是否可以按
# Memo...........:
# Usage..........: CALL azzi001_set_act_active(p_actname, p_active)
#                  RETURNING none
# Input parameter: p_actname      Action代號
#                : p_active       是否啟用
# Return code....: none
# Date & Author..: 劉偉先
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi001_set_act_active(p_actname,p_active)
   DEFINE p_actname     STRING,
          p_active      Boolean
   DEFINE l_dialog      ui.Dialog
   
   LET l_dialog = ui.Dialog.getCurrent()
   CALL l_dialog.setActionActive(p_actname, p_active)
END FUNCTION

################################################################################
# Descriptions...: 儲存流程圖資訊
# Memo...........:
# Usage..........: CALL azzi001_save_flow(p_gzba001, p_data)
#                  RETURNING none
# Input parameter: p_gzba001      選單代號
#                : p_data         要儲存的json string
# Return code....: none
# Date & Author..: 劉偉先
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi001_save_flow(p_gzba001,p_data)
   DEFINE p_gzba001     LIKE gzba_t.gzba001
   DEFINE p_data        STRING
   DEFINE l_flow        RECORD
            containers     t_containers,
            connections    t_connections
                        END RECORD
   DEFINE idx           INTEGER
   DEFINE l_idx1        INTEGER
   DEFINE l_idx         INTEGER
   DEFINE l_gzbb_arr    DYNAMIC ARRAY OF RECORD LIKE gzbb_t.*
   DEFINE l_success     BOOLEAN
   DEFINE l_gzbb_t      RECORD LIKE gzbb_t.*    #暫存用
   DEFINE l_gzbc_t      RECORD LIKE gzbc_t.*    #暫存用
   DEFINE l_gzbbl_t     RECORD LIKE gzbbl_t.*   #暫存用
   DEFINE l_opts        RECORD
            size           RECORD
               width          STRING,
               height         STRING
                           END RECORD,
            position       RECORD
               top            STRING,
               left           STRING
                           END RECORD,
            css            STRING
                        END RECORD
                        
   LET l_success = TRUE
   TRY
      CALL util.JSON.parse(p_data, l_flow)
   CATCH
      ERROR "json parse error:", p_data
   END TRY
   
   OPEN declare_gzbb_by_gzbb002 USING p_gzba001
   FOREACH declare_gzbb_by_gzbb002 INTO l_gzbb_t.*
      IF l_gzbb_t.gzbb001 IS NOT NULL THEN
         LET l_gzbb_arr[l_gzbb_arr.getLength() + 1].* = l_gzbb_t.*
      END IF
   END FOREACH   
   
   CLOSE declare_gzbb_by_gzbb002
   
   #CALL s_transaction_begin()
   
   #儲存節點步驟：(全部刪除，再依傳入的資料全部新增)
   #  1.清除節點多語言
   #  2.清除節點連結線
   #  3.清除節點
   #  4.依據現有的暫存多語言g_multi_lang及流程圖回傳的資訊寫回DB
   FOR l_idx = 1 TO l_gzbb_arr.getLength()
      CALL azzi001_delete_gzbb_info(l_gzbb_arr[l_idx].gzbb001, p_gzba001) RETURNING l_success
      IF l_success == FALSE THEN
         EXIT FOR
      END IF
   END FOR
   
   #清除失敗時
   IF l_success == FALSE THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #新增連結線
   FOR idx = 1 TO l_flow.connections.getLength()
      LET l_gzbc_t.gzbc001 = l_flow.connections[idx].source
      LET l_gzbc_t.gzbc002 = l_flow.connections[idx].target
      LET l_gzbc_t.gzbc003 = p_gzba001
      LET l_gzbc_t.gzbc004 = l_flow.connections[idx].parameters.label
      
      INSERT INTO gzbc_t VALUES l_gzbc_t.*
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gzbc_t"
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF
   END FOR
   
   ##新增節點及新增多語言: 將g_multi_lang的資料，全部倒回DB
   #DEFINE g_multi_lang  DYNAMIC ARRAY OF RECORD   
   #      gzbb001        LIKE gzbb_t.gzbb001,   #節點代碼
   #      gzbbl_arr      DYNAMIC ARRAY OF RECORD LIKE gzbbl_t.*
   #                  END RECORD     
   
   
   FOR l_idx1 = 1 TO l_flow.containers.getLength()
      LET l_opts.size.width      = l_flow.containers[l_idx1].size.width
      LET l_opts.size.height     = l_flow.containers[l_idx1].size.height
      LET l_opts.position.top    = l_flow.containers[l_idx1].position.top
      LET l_opts.position.left   = l_flow.containers[l_idx1].position.left
      LET l_opts.css             = l_flow.containers[l_idx1].css
      LET l_gzbb_t.gzbb001   = l_flow.containers[l_idx1].id
      LET l_gzbb_t.gzbb002   = p_gzba001
      LET l_gzbb_t.gzbb003   = l_flow.containers[l_idx1].module
      LET l_gzbb_t.gzbb004   = util.JSON.stringify(l_opts) #坐標、尺寸
      LET l_gzbb_t.gzbb005   = l_flow.containers[l_idx1].template
      
      IF l_flow.containers[l_idx1].module == "program" OR l_flow.containers[l_idx1].module == "subflow" THEN
         #其它資訊(如果module = 'program' 那就是程式代號, 如果module='subflow'，就是流程選單編號)
         LET l_gzbb_t.gzbb006   = l_flow.containers[l_idx1].other
      #ELSE
      #   LET l_gzbb_t.gzbb005   = l_flow.containers[l_idx1].image　#其它資訊(如果module = 'program' 那就是程式代號)
      END IF
      
      LET l_gzbb_t.gzbbent   = g_enterprise
      
      #新增節點資料
      INSERT INTO gzbb_t VALUES l_gzbb_t.*
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = l_gzbb_t.gzbb001
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      FOR idx = 1 TO g_multi_lang.getLength()
         #只有存在於節點中的多語言資料才要新增
         IF l_gzbb_t.gzbb001 == g_multi_lang[idx].gzbb001 AND l_gzbb_t.gzbb003 != "program" THEN
         
            FOR l_idx = 1 TO g_multi_lang[idx].gzbbl_arr.getLength()
               LET l_gzbbl_t.gzbbl001 = l_gzbb_t.gzbb001
               LET l_gzbbl_t.gzbbl002 = g_multi_lang[idx].gzbbl_arr[l_idx].gzbbl002
               LET l_gzbbl_t.gzbbl003 = g_multi_lang[idx].gzbbl_arr[l_idx].gzbbl003
               LET l_gzbbl_t.gzbbl004 = g_multi_lang[idx].gzbbl_arr[l_idx].gzbbl004
               LET l_gzbbl_t.gzbblent = g_enterprise

               #新增多語言資料
               #雖然gzbb003="program"是不需要語言的，因為程式代號是記錄在gzbb005，
               #但還是先與其它節點統一作法吧
               INSERT INTO gzbbl_t VALUES l_gzbbl_t.*
               
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "gzbbl_t"
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  RETURN
               END IF
            END FOR
         END IF
      END FOR
   END FOR
   
   
   #CALL s_transaction_end('Y','0')

   CALL util.JSON.parse(p_data, l_flow)
   
   #display ""
   #display "-----------節點--------------"
   #FOR idx = 1 TO l_flow.containers.getLength()
   #   display sfmt("類型：%1", l_flow.containers[idx].module)
   #   display sfmt("內容：%1", l_flow.containers[idx].label)
   #   display sfmt("編號：%1", l_flow.containers[idx].id)
   #   display sfmt("坐標：(%1,%2)", l_flow.containers[idx].position.top, l_flow.containers[idx].position.left)
   #   display sfmt("尺寸：%1, %2", l_flow.containers[idx].size.width, l_flow.containers[idx].size.height)
   #   display "========================"
   #END FOR
   #display ""
   #display "-----------連結線--------------"
   #FOR idx = 1 to l_flow.connections.getLength()
   #   display sfmt("來源編號：%1", l_flow.connections[idx].source)
   #   display sfmt("目的編號：%1", l_flow.connections[idx].target)
   #   display sfmt("標籤：%1", l_flow.connections[idx].parameters.label)
   #END FOR
   
   INITIALIZE g_errparam TO NULL
   LET g_errparam.code = "azz-00243"   #儲存已完成
   LET g_errparam.extend = ''
   LET g_errparam.popup = TRUE
   CALL cl_err()
END FUNCTION

################################################################################
# Descriptions...: 依據分類代號取得流程圖資料
# Memo...........:
# Usage..........: CALL azzi001_get_flow(p_gzba001)
#                  RETURNING lr_json
# Input parameter: p_gzba001      選單分類代號
#                : p_enable       是否Enable
# Return code....: lr_json        JSON.stringify後的資料
# Date & Author..: 劉偉先
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi001_get_flow(p_gzba001,p_enable)
   DEFINE p_gzba001     LIKE gzba_t.gzba001,
          p_enable      BOOLEAN
   DEFINE l_gzbb_t      RECORD LIKE gzbb_t.*
   DEFINE l_gzbbl_t     RECORD LIKE gzbbl_t.*
   DEFINE l_gzbc_t      RECORD LIKE gzbc_t.*
   DEFINE l_gzbd003     LIKE gzbd_t.gzbd003 #圖片名稱
   DEFINE l_gzzal003    LIKE gzzal_t.gzzal003
   DEFINE l_flow        RECORD          #將轉成JSON格式的model
            enable         Boolean,
            containers     t_containers, #節點們
            connections    t_connections #連結線們
                        END RECORD
   DEFINE l_len_1       INTEGER
   DEFINE l_len_2       INTEGER
   DEFINE l_len_3       INTEGER
   DEFINE l_len_4       INTEGER
   DEFINE lr_json       STRING
   DEFINE l_opts        RECORD
            size           t_size,
            position       t_position,
            css            STRING
                        END RECORD
   DEFINE l_json        STRING         #l_flow轉換成json後的字串
   
   CALL g_multi_lang.clear()
   LET l_flow.enable = p_enable
   IF p_gzba001 IS NULL THEN
      RETURN util.JSON.stringify(l_flow)
   END IF
   
      
   #  將分類下的節點及相關資訊取出(連結線、多語言資料)
   #     1.取出節點轉成l_flow.containers
   #     2.取出連結線轉成l_flow.connections
   #     3.
   
   OPEN declare_gzbb_by_gzbb002 USING p_gzba001
   FOREACH declare_gzbb_by_gzbb002 INTO l_gzbb_t.*
      #將節點轉換成預備的JSON model (有機會改用util.JSONObject替代？)
      CALL l_flow.containers.appendElement()
      LET l_len_1 = l_flow.containers.getLength()
      CALL util.JSON.parse(l_gzbb_t.gzbb004, l_opts)
      LET l_flow.containers[l_len_1].id       = l_gzbb_t.gzbb001
      LET l_flow.containers[l_len_1].module   = l_gzbb_t.gzbb003
      LET l_flow.containers[l_len_1].label    = ""
      LET l_flow.containers[l_len_1].desc     = ""
      LET l_flow.containers[l_len_1].template = l_gzbb_t.gzbb005
      
      LET l_gzbd003 = NULL
      SELECT gzbd003 INTO l_gzbd003 FROM gzbd_t 
         WHERE gzbd001 = l_gzbb_t.gzbb005
           AND gzbdent = g_enterprise
      LET l_flow.containers[l_len_1].image = l_gzbd003
      
      IF l_gzbb_t.gzbb003 == "program" THEN
         LET l_flow.containers[l_len_1].other = l_gzbb_t.gzbb006
         LET l_flow.containers[l_len_1].label = l_gzbb_t.gzbb006
         LET l_flow.containers[l_len_1].desc  = cl_get_progname(l_gzbb_t.gzbb006,g_dlang,1), "(", l_gzbb_t.gzbb006, ")"
      END IF
      
      IF l_gzbb_t.gzbb003 == "subflow" THEN
         INITIALIZE g_ref_fields TO NULL 
         LET g_ref_fields[1] = l_gzbb_t.gzbb006
         CALL ap_ref_array2(g_ref_fields,"SELECT gzbal003 FROM gzbal_t WHERE gzbalent='"||g_enterprise||"' AND gzbal001=? AND gzbal002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET l_flow.containers[l_len_1].other = l_gzbb_t.gzbb006
         LET l_flow.containers[l_len_1].label = g_rtn_fields[1]
      END IF
      
      LET l_flow.containers[l_len_1].size.*     = l_opts.size.*
      LET l_flow.containers[l_len_1].position.* = l_opts.position.*
      LET l_flow.containers[l_len_1].css        = l_opts.css
      
      #將連結線轉換成預備的JSON modle (有機會改用util.JSONObject替代？)     
      OPEN declare_gzbc_by_gzbb001 USING l_gzbb_t.gzbb001, p_gzba001
      FOREACH declare_gzbc_by_gzbb001 INTO l_gzbc_t.*
         CALL l_flow.connections.appendElement()
         LET l_len_4 = l_flow.connections.getLength()
         LET l_flow.connections[l_len_4].source = l_gzbc_t.gzbc001
         LET l_flow.connections[l_len_4].target = l_gzbc_t.gzbc002
         LET l_flow.connections[l_len_4].parameters.label = l_gzbc_t.gzbc004
      END FOREACH
      CLOSE declare_gzbc_by_gzbb001      
      
      #程式類型的直接抓azzi900
      IF l_gzbb_t.gzbb003 != "program" AND l_gzbb_t.gzbb003 != "subflow" THEN
         #將節點的多語言全部拿出來暫存至g_multi_lang      
         CALL g_multi_lang.appendElement()
         LET l_len_2 = g_multi_lang.getLength()
         LET g_multi_lang[l_len_2].gzbb001 = l_gzbb_t.gzbb001
         
         OPEN declare_gzbbl_by_gzbb001 USING l_gzbb_t.gzbb001  
         FOREACH declare_gzbbl_by_gzbb001 INTO l_gzbbl_t.* #, l_gzzal003
            #撈到與目前相同的語系時，賦值給節點的多語言label, desc
            IF l_gzbbl_t.gzbbl002 = g_lang THEN
               LET l_flow.containers[l_len_1].label = l_gzbbl_t.gzbbl003
               LET l_flow.containers[l_len_1].desc  = l_gzbbl_t.gzbbl004
               IF l_gzbb_t.gzbb003 = "program" THEN
                  LET l_flow.containers[l_len_1].desc  = l_gzbbl_t.gzbbl004, "(", l_gzbbl_t.gzbbl003, ")"
               END IF
            END IF
            CALL g_multi_lang[l_len_2].gzbbl_arr.appendElement()
            LET l_len_3 =  g_multi_lang[l_len_2].gzbbl_arr.getLength()
            LET g_multi_lang[l_len_2].gzbbl_arr[l_len_3].* = l_gzbbl_t.*
         END FOREACH
         CLOSE declare_gzbbl_by_gzbb001
      END IF
   END FOREACH 
   
   CLOSE declare_gzbb_by_gzbb002
   
   LET l_json = util.JSON.stringify(l_flow)

   RETURN l_json
END FUNCTION

################################################################################
# Descriptions...: 編輯節點
# Memo...........:
# Usage..........: CALL azzi001_edit_node(p_data, p_gzbb001)
#                  RETURNING none
# Input parameter: p_data         JSON{id: xxx, module: 'program'}
#                : p_gzba001      分類代號
# Return code....: none
# Date & Author..: 劉偉先
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi001_edit_node(p_data,p_gzba001)
   DEFINE p_data        STRING,                 #json
          p_gzba001     LIKE gzba_t.gzba001     #分類代號
   DEFINE l_node        RECORD
            id             STRING,  #節點代號
            label          STRING,  #文字
            module         STRING,  #節點類型
            other          STRING   #其它補充
                        END RECORD
   DEFINE l_gzbb001     LIKE gzbb_t.gzbb001,  #節點代號
          l_gzbb003     LIKE gzbb_t.gzbb003   #節點類型
   DEFINE l_form        STRING
   DEFINE lr_gzbbl003   LIKE gzbbl_t.gzbbl003,
          lr_gzbbl004   LIKE gzbbl_t.gzbbl004,
          l_gzbal001    LIKE gzbal_t.gzbal001,  #選單id
          l_gzbal003    LIKE gzbal_t.gzbal003   #選單名稱
   DEFINE l_json        RECORD      #要回傳給WebComponent的json資訊
            node_name      STRING,  #節點名稱(簡稱)
            node_desc      STRING,  #全稱
            node_id        STRING,  #節點代號
            other          STRING   #給gzbb003="program"用的 程式代號
                        END RECORD

   TRY
      CALL util.JSON.parse(p_data, l_node)
   CATCH
      ERROR "parse JSON error: ", p_data
      RETURN
   END TRY
   LET l_gzbb001 = l_node.id
   LET l_gzbb003 = l_node.module
   
   #依據節點不同，開啟不同的畫面進行多語言的編輯
   CASE l_gzbb003
      WHEN "note"    #使用TextEdit
         OPEN WINDOW w_azzi001_lng WITH FORM cl_ap_formpath("azz", "azzi001_s01") ATTRIBUTE(STYLE="openwin")
      WHEN "program" #程式節點，要可輸入程式代號...吧
         OPEN WINDOW w_azzi001_lng WITH FORM cl_ap_formpath("azz", "azzi001_s02") ATTRIBUTE(STYLE="openwin")
      WHEN "subflow"         
      OTHERWISE      #單純的文字(還要補縮寫？)
         OPEN WINDOW w_azzi001_lng WITH FORM cl_ap_formpath("azz", "azzi001_s03") ATTRIBUTE(STYLE="openwin")
   END CASE
   
   CALL cl_ui_init()
   
   CASE l_gzbb003
   
      WHEN "program"
         #如果是程式類型，只需變更程式代號gzbb005
         CALL azzi001_edit_prog(l_gzbb001) RETURNING lr_gzbbl003, lr_gzbbl004
         LET l_json.node_name = lr_gzbbl004, "(", lr_gzbbl003, ")"
         LET l_json.node_desc = lr_gzbbl004, "(", lr_gzbbl003, ")"
         LET l_json.other = lr_gzbbl003
      WHEN "subflow"
         CALL azzi001_sel_subflow(l_node.other) RETURNING l_gzbal001, l_gzbal003
         LET l_json.node_name = l_gzbal003
         LET l_json.other = l_gzbal001
      OTHERWISE
         #先幫忙塞預設的說明文字      
         CALL azzi001_lang_modify(l_gzbb001, l_node.label) RETURNING lr_gzbbl003, lr_gzbbl004
         LET l_json.node_name = lr_gzbbl003
         LET l_json.node_desc = lr_gzbbl004
   END CASE
   
   CLOSE WINDOW w_azzi001_lng
   LET l_json.node_id = l_gzbb001   
   
   CALL azzi001_submit_wc("l_flow_wc", "update", util.JSON.stringify(l_json))

END FUNCTION

################################################################################
# Descriptions...: 開啟azzi001_s02畫面，程式代號編輯
# Memo...........:
# Usage..........: CALL azzi001_edit_prog(p_gzbb001)
#                  RETURNING lr_
# Input parameter: p_gzbb001      節點代號
# Return code....: l_gzzb005      程式編號
#                : l_gzzal003     程式名稱
# Date & Author..: 劉偉先
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi001_edit_prog(p_gzbb001)
   DEFINE p_gzbb001     LIKE gzbb_t.gzbb001     #節點代號
   DEFINE l_idx         INTEGER
   DEFINE l_gzbbl_t     RECORD LIKE gzbbl_t.*    #備份
   DEFINE l_find        BOOLEAN
   DEFINE l_len         INTEGER
   DEFINE l_ac          INTEGER
   DEFINE l_gzbbl_d     DYNAMIC ARRAY OF RECORD LIKE gzbbl_t.*  
   DEFINE lr_gzbbl003   LIKE gzbbl_t.gzbbl003,
          lr_gzbbl004   LIKE gzbbl_t.gzbbl004
   DEFINE l_gzzal003    LIKE gzzal_t.gzzal003
   
   FOR l_idx = 1 TO g_multi_lang.getLength()
      IF g_multi_lang[l_idx].gzbb001 == p_gzbb001 THEN
         LET l_gzbbl_d = g_multi_lang[l_idx].gzbbl_arr
         LET l_find = TRUE
         EXIT FOR
      END IF
   END FOR
   IF l_find == FALSE THEN
      CALL g_multi_lang.appendElement()
      LET l_len = g_multi_lang.getLength()
      LET g_multi_lang[l_len].gzbb001 = p_gzbb001
      LET l_gzbbl_d = g_multi_lang[l_len].gzbbl_arr
   END IF
   
   #因為是拿gzbbl_t.gzzbl003來記錄程式編號，所以只會有一筆資訊
   #備份  
   LET l_gzbbl_t.* = l_gzbbl_d[1].*    
   
   #取得程式名稱
   CALL cl_get_progname(l_gzbbl_t.gzbbl003, g_lang, 1) RETURNING l_gzbbl_t.gzbbl004
   DISPLAY l_gzbbl_t.gzbbl004 TO gzzal003
   
   DIALOG ATTRIBUTE(UNBUFFERED)
   
      INPUT l_gzbbl_t.gzbbl003 FROM gzza001
         ATTRIBUTE(WITHOUT DEFAULTS)
 
         ON CHANGE gzza001
            CALL cl_get_progname(l_gzbbl_t.gzbbl003, g_lang, 1) RETURNING l_gzbbl_t.gzbbl004  
            DISPLAY l_gzbbl_t.gzbbl004 TO gzzal003
            
         ON ACTION controlp INFIELD gzza001
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            CALL q_gzza001_5()                     #呼叫開窗
            IF NOT cl_null(g_qryparam.return1) THEN
               LET l_gzbbl_t.gzbbl003 = g_qryparam.return1
               CALL cl_get_progname(l_gzbbl_t.gzbbl003, g_lang, 1) RETURNING l_gzbbl_t.gzbbl004 
               DISPLAY l_gzbbl_t.gzbbl004 TO gzzal003
            END IF
            
      END INPUT
 
      ON ACTION accept
         ACCEPT DIALOG
 
      ON ACTION cancel      #在dialog button (放棄)
         #從備份還原
         LET INT_FLAG = TRUE
         EXIT DIALOG 
 
      ON ACTION close       #在dialog 右上角 (X)
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
         EXIT DIALOG    
   END DIALOG
   
   IF INT_FLAG == TRUE THEN 
      LET INT_FLAG = FALSE
      #還原
      LET l_gzbbl_t.gzbbl003 = l_gzbbl_d[1].gzbbl003
   ELSE
      #更新暫存
      LET l_gzbbl_d[1].gzbbl003 = l_gzbbl_t.gzbbl003
      LET l_gzbbl_d[1].gzbbl004 = l_gzbbl_t.gzbbl004
   END IF
      
   RETURN l_gzbbl_t.gzbbl003, l_gzbbl_t.gzbbl004
END FUNCTION

################################################################################
# Descriptions...: 從暫存的多語言table進行編輯
# Memo...........:
# Usage..........: CALL azzi001_lang_modify(p_gzbb001, p_gzbbl003)
#                  RETURNING lr_gzbbl003
# Input parameter: p_gzbb001      節點代號
#                : p_gzbbl003     預設的說明文字
# Return code....: lr_gzbbl003    簡稱
# Date & Author..: 劉偉先
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi001_lang_modify(p_gzbb001,p_gzbbl003)
   DEFINE p_gzbb001     LIKE gzbb_t.gzbb001,    #節點代號
          p_gzbbl003    LIKE gzbbl_t.gzbbl003   #預設說明文字
   DEFINE l_idx         INTEGER
   DEFINE l_gzbbl_t     DYNAMIC ARRAY OF RECORD LIKE gzbbl_t.*    #備份
   DEFINE l_gzbbl_d     DYNAMIC ARRAY OF RECORD LIKE gzbbl_t.*  
   DEFINE l_find        BOOLEAN
   DEFINE l_len         INTEGER
   DEFINE l_ac          INTEGER
   DEFINE lr_gzbbl003   LIKE gzbbl_t.gzbbl003,
          lr_gzbbl004   LIKE gzbbl_t.gzbbl004
          
   #從暫存的多語言表gzbbl_t中查詢出對應節點代號的多語言資料
   LET l_find = FALSE
   FOR l_idx = 1 TO g_multi_lang.getLength()
      IF g_multi_lang[l_idx].gzbb001 == p_gzbb001 THEN
         LET l_gzbbl_d = g_multi_lang[l_idx].gzbbl_arr
         LET l_find = TRUE
         EXIT FOR
      END IF
   END FOR
   #如果沒找到，新增一筆
   IF l_find == FALSE THEN
      CALL g_multi_lang.appendElement()
      LET l_len = g_multi_lang.getLength()
      LET g_multi_lang[l_len].gzbb001 = p_gzbb001
      LET g_multi_lang[l_len].gzbbl_arr[1].gzbbl002 = g_lang
      LET g_multi_lang[l_len].gzbbl_arr[1].gzbbl003 = p_gzbbl003
      LET l_gzbbl_d = g_multi_lang[l_len].gzbbl_arr
   END IF
   
   #備份
   FOR l_len = 1 TO l_gzbbl_d.getLength()
      LET l_gzbbl_t[l_len].* = l_gzbbl_d[l_len].*
   END FOR
   
   CALL cl_set_combo_lang("gzbbl002")
   
   DIALOG ATTRIBUTE(UNBUFFERED)
   
      INPUT ARRAY l_gzbbl_d FROM s_detail1.*
         ATTRIBUTE(WITHOUT DEFAULTS, INSERT ROW = 1, DELETE ROW = 1, APPEND ROW = 1)
 
         BEFORE ROW
            LET l_ac = ARR_CURR()
        
         ON CHANGE gzbbl002
            FOR l_len = 1 TO l_gzbbl_d.getLength()
               IF l_len != l_ac THEN
                  IF l_gzbbl_d[l_ac].gzbbl002 == l_gzbbl_d[l_len].gzbbl002 THEN
                     ERROR "語系重覆"
                     LET l_gzbbl_d[l_ac].gzbbl002 = NULL
                  END IF
               END IF
            END FOR
            
         BEFORE INSERT
            LET l_gzbbl_d[l_ac].gzbbl002 = g_lang
            
         BEFORE DELETE                        #是否取消單身
            IF l_gzbbl_d[l_ac].gzbbl002 IS NOT NULL THEN #語言別
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF              
            END IF 
 
      END INPUT
 
      ON ACTION accept
         ACCEPT DIALOG
 
      ON ACTION cancel      #在dialog button (放棄)
         #從備份還原
         CALL l_gzbbl_d.clear()
         FOR l_len = 1 TO l_gzbbl_t.getLength()
            LET l_gzbbl_d[l_len].* = l_gzbbl_t[l_len].*
         END FOR
         EXIT DIALOG 
 
      ON ACTION close       #在dialog 右上角 (X)
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
         EXIT DIALOG    
   END DIALOG
   
   #DISPLAY l_gzbbl_t.getLength()
   FOR l_len = 1 TO l_gzbbl_d.getLength()
      IF l_gzbbl_d[l_len].gzbbl002 == g_lang THEN
         LET lr_gzbbl003 = l_gzbbl_d[l_len].gzbbl003
         LET lr_gzbbl004 = l_gzbbl_d[l_len].gzbbl004
      END IF
   END FOR
   RETURN lr_gzbbl003, lr_gzbbl004
END FUNCTION

################################################################################
# Descriptions...: 刪除指定的節點及多語言與連結線
# Memo...........:
# Usage..........: CALL azzi001_delete_gzbb_info(p_gzbb001, p_gzbb002)
#                  RETURNING lr_success
# Input parameter: p_gzbb001      節點代號
#                : p_gzbb002      上層節點代號
# Return code....: lr_success     是否成功
# Date & Author..: 劉偉先
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi001_delete_gzbb_info(p_gzbb001,p_gzbb002)
   DEFINE p_gzbb001     LIKE gzbb_t.gzbb001,
          p_gzbb002     LIKE gzbb_t.gzbb002
   DEFINE lr_success    BOOLEAN
   DEFINE l_len         INTEGER
   
   INITIALIZE g_errparam TO NULL 
   LET lr_success = TRUE
   FOR l_len = 1 TO 1
   
      #清空節點相關的多語言
      DELETE FROM gzbbl_t WHERE gzbbl001 = p_gzbb001 AND gzbblent = g_enterprise
      IF SQLCA.sqlcode THEN
         LET g_errparam.extend = "gzbbl_t" 
         EXIT FOR
      END IF
      
      #清空節點相關的連結線
      DELETE FROM gzbc_t WHERE gzbc001 = p_gzbb001
      IF SQLCA.sqlcode THEN
         LET g_errparam.extend = "gzbc_t" 
         EXIT FOR
      END IF
      
      #清空目前分類下的所有節點   
      DELETE FROM gzbb_t WHERE gzbb002 = p_gzbb002 AND gzbb001 = p_gzbb001 AND gzbbent = g_enterprise
      IF SQLCA.sqlcode THEN
         LET g_errparam.extend = "gzbb_t" 
         EXIT FOR
      END IF
   END FOR
   
   IF SQLCA.sqlcode THEN
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()    
      LET lr_success = FALSE
   END IF
   
   RETURN lr_success
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
PRIVATE FUNCTION azzi001_submit_wc(p_wcname,p_type,p_data)
   DEFINE p_wcname      STRING,
          p_type        STRING,
          p_data        STRING

   CALL azzi001_property_comp(p_wcname, "type", p_type)
   CALL azzi001_property_comp(p_wcname, "data", p_data)

END FUNCTION

################################################################################
# Descriptions...: 刪除指定目類下的所有節點及節點資訊
# Memo...........:
# Usage..........: CALL azzi001_del_gzbb_by_gzba001(p_gzba001)
#                  RETURNING none
# Input parameter: p_gzba001      選單分類代號
# Return code....: lr_success
# Date & Author..: 劉偉先
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi001_del_gzbb_by_gzba001(p_gzba001)
   DEFINE p_gzba001     LIKE gzba_t.gzba001  #分類代號
   DEFINE l_idx         INTEGER
   DEFINE l_gzbb_t      RECORD LIKE gzbb_t.*

   DECLARE declare_gzbb_by_gzba001 CURSOR FOR SELECT * FROM gzbb_t WHERE gzbb002 = p_gzba001 AND gzbbent = g_enterprise
   #列舉分類代號下的所有節點
   FOREACH declare_gzbb_by_gzba001 INTO l_gzbb_t.*
      #刪除節點多語言
      DELETE FROM gzbbl_t WHERE gzbbl001 = l_gzbb_t.gzbb001 AND gzbblent = g_enterprise
      IF SQLCA.sqlcode THEN EXIT FOREACH END IF
      #刪除連結線
      DELETE FROM gzbc_t WHERE gzbc003 = p_gzba001
      IF SQLCA.sqlcode THEN EXIT FOREACH END IF
      #刪除節點
      DELETE FROM gzbb_t WHERE gzbb001 = l_gzbb_t.gzbb001 AND gzbbent = g_enterprise
      IF SQLCA.sqlcode THEN EXIT FOREACH END IF
   END FOREACH
   
   
END FUNCTION

PRIVATE FUNCTION azzi001_gen_gzba001()
   DEFINE l_gzba001     LIKE gzba_t.gzba001
   DEFINE l_cnt         INTEGER
   
   WHILE TRUE
      LET l_gzba001 = com.Util.CreateUUIDString()
      SELECT COUNT(*) INTO l_cnt FROM gzba_t WHERE gzba001 = l_gzba001 AND gzbaent = g_enterprise
      IF l_cnt == 0 THEN
         EXIT WHILE
      END IF
   END WHILE
   RETURN l_gzba001
END FUNCTION

################################################################################
# Descriptions...: 產生可操作的自定義節點
# Memo...........:
# Usage..........: CALL azzi001_render_modules()
#                  RETURNING none
# Input parameter: none
# Return code....: none
# Date & Author..: 劉偉先
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi001_render_modules()
   DEFINE l_modules     DYNAMIC ARRAY OF RECORD
            label          STRING,  #節點文字
            module         STRING,  #節點類型
            image          STRING,  #圖片名稱
            template       STRING   #節點樣版id
                        END RECORD
   DEFINE l_gzbd_t      RECORD
            gzbd001        LIKE gzbd_t.gzbd001,
            gzbdl003       LIKE gzbdl_t.gzbdl003,  #節點文字
            gzbd002        LIKE gzbd_t.gzbd002,    #節點類型
            gzbd003        LIKE gzbd_t.gzbd003     #圖片名稱
                        END RECORD
   DEFINE l_len         INTEGER
   
   OPEN azzi001_gzbd_declare
   FOREACH azzi001_gzbd_declare INTO l_gzbd_t.*
      CALL l_modules.appendElement()
      LET l_len = l_modules.getLength()
      IF cl_null(l_gzbd_t.gzbdl003) THEN LET l_gzbd_t.gzbdl003 = " " END IF
      LET l_modules[l_len].label    = l_gzbd_t.gzbdl003
      LET l_modules[l_len].module   = l_gzbd_t.gzbd002
      LET l_modules[l_len].image    = l_gzbd_t.gzbd003
      LET l_modules[l_len].template = l_gzbd_t.gzbd001
   END FOREACH
   CALL azzi001_submit_wc("l_flow_wc", "modules", util.JSON.stringify(l_modules))
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzi001_sel_subflow(p_gzxa013)
#                  RETURNING 選單編號,選單名稱
# Input parameter: p_gzxa013   原選單編號
# Return code....: none
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi001_sel_subflow(p_gzxa013)
   DEFINE p_gzxa013        LIKE gzxa_t.gzxa013
   DEFINE l_gzxa013        STRING
   define l_gzxa013_desc   STRING
   LET l_gzxa013 = azzi800_05(p_gzxa013)
   INITIALIZE g_ref_fields TO NULL 
   LET g_ref_fields[1] = l_gzxa013
   CALL ap_ref_array2(g_ref_fields,"SELECT gzbal003 FROM gzbal_t WHERE gzbalent='"||g_enterprise||"' AND gzbal001=? AND gzbal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET l_gzxa013_desc = g_rtn_fields[1]
   RETURN l_gzxa013, l_gzxa013_desc
END FUNCTION

################################################################################
# Descriptions...: 單身複製
# Memo...........: No.161018-00026#1
# Usage..........: 
# Input parameter:
# Return code....: 
# Date & Author..: 2016/10/27 By Bruce Liu
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi001_detail_reproduce()
DEFINE l_gzbb_copy      RECORD LIKE gzbb_t.*
DEFINE l_gzbbl_copy     RECORD LIKE gzbbl_t.*
DEFINE l_gzbc_copy     RECORD LIKE gzbc_t.*   

DEFINE ls_sql      STRING
DEFINE l_gzbb001  LIKE gzbb_t.gzbb001
DEFINE l_gzbbl001  LIKE gzbbl_t.gzbbl001


   DROP TABLE gzbb_t_detail
   
    #CREATE gzbb_t TEMP TABLE
    SELECT * FROM gzbb_t
    WHERE gzbbent = g_enterprise AND gzbb002=g_gzba001_t
　　INTO TEMP gzbb_t_detail

    #CREATE gzbc_t TEMP TABLE
    SELECT * FROM gzbc_t
    WHERE  gzbc003=g_gzba001_t
　  INTO TEMP gzbc_t_detail

    UPDATE gzbc_t_detail      
    SET gzbc003 =g_gzba_m.gzba001  
    

      LET ls_sql = "SELECT * FROM gzbb_t_detail"
      PREPARE pre_gzbb_t_detail  FROM ls_sql
      DECLARE declare_gzbb_t_detail CURSOR FOR pre_gzbb_t_detail
      OPEN declare_gzbb_t_detail
      FOREACH declare_gzbb_t_detail INTO l_gzbb_copy.*
      


         #gzbb_t_detail、gzbc_t_detail將key修正為調整後 
         LET l_gzbb001=azzi001_gen_gzbb001() 
         
            #處理gzbb_t_detail tmp
            UPDATE gzbb_t_detail 
            SET gzbb001=l_gzbb001 where gzbb001=l_gzbb_copy.gzbb001 and gzbb002=l_gzbb_copy.gzbb002
            
            #處理gzbc_t_detail tmp
            UPDATE gzbc_t_detail           
            SET gzbc001=l_gzbb001 where gzbc001=l_gzbb_copy.gzbb001            
            UPDATE gzbc_t_detail 
            SET gzbc002=l_gzbb001 where gzbc002=l_gzbb_copy.gzbb001
                
               #複製gzbbl_t資料#########
               DROP TABLE gzbbl_t_detail
               #CREATE TEMP TABLE 
               SELECT * FROM gzbbl_t
               WHERE gzbblent = g_enterprise AND gzbbl001=l_gzbb_copy.gzbb001
            　 INTO TEMP gzbbl_t_detail
            
               LET ls_sql = "SELECT * FROM gzbbl_t_detail"
               PREPARE pre_gzbbl_t_detail  FROM ls_sql
               DECLARE declare_gzbbl_t_detail CURSOR FOR pre_gzbbl_t_detail
               OPEN declare_gzbbl_t_detail
               FOREACH declare_gzbbl_t_detail INTO l_gzbbl_copy.*
                  #將key修正為調整後 
                  LET l_gzbbl001=l_gzbb001
                  
                     UPDATE gzbbl_t_detail 
                     #更新欄位
                     SET gzbbl001=l_gzbbl001 where gzbbl001=l_gzbbl_copy.gzbbl001
              
               END FOREACH 
            　 CLOSE declare_gzbbl_t_detail
            
               INSERT INTO gzbbl_t SELECT * FROM gzbbl_t_detail
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "gzbbl_t copy detail:",SQLERRMESSAGE 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
             
                  RETURN
               END IF
               
               DROP TABLE gzbbl_t_detail
               #複製gzbbl_t資料##########
               
      END FOREACH 
      CLOSE declare_gzbb_t_detail
    
         #更新共用欄位
         #複製資料給gzbb_t  
      UPDATE gzbb_t_detail  SET gzbb002 =g_gzba_m.gzba001
      INSERT INTO gzbb_t SELECT * FROM gzbb_t_detail
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gzbb_t reproduce detail:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
    
         RETURN
      END IF
      
      DROP TABLE gzbb_t_detail
  
      #複製資料給gzbc_t 
      INSERT INTO gzbc_t SELECT * FROM gzbc_t_detail      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gzbc_t reproduce detail:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
    
         RETURN
      END IF
      
      DROP TABLE gzbc_t_detail    

  
END FUNCTION

################################################################################
# Descriptions...: 單身複製
# Memo...........: No.161018-00026#1
# Usage..........: 
# Input parameter:
# Return code....: 
# Date & Author..: 2016/10/27 By Bruce Liu
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi001_gen_gzbb001()
   DEFINE l_gzbb001     LIKE gzbb_t.gzbb001
   DEFINE l_cnt         INTEGER
   
   WHILE TRUE
      LET l_gzbb001 = com.Util.CreateUUIDString()
      SELECT COUNT(*) INTO l_cnt FROM gzbb_t WHERE gzbb001 = l_gzbb001 AND gzbbent = g_enterprise
      IF l_cnt == 0 THEN
         EXIT WHILE
      END IF
   END WHILE
   RETURN l_gzbb001
END FUNCTION

 
{</section>}
 
