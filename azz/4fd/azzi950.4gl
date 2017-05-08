{<section id="azzi950.description" >}
#+ Version..: T100-ERP-1.00.00(版次:1) Build-000249
#+ 
#+ Filename...: azzi950
#+ Description: 排程設定作業
#+ Creator....: 00845(2013/12/12)
#+ Modifier...: 00845(2013/12/26)
#+ Buildtype..: 應用 t01 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="azzi950.global" >}
{<point name="global.memo" />}
    
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目
{<point name="global.import" />}
#end add-point
 
SCHEMA ds 
 
GLOBALS "../../cfg/top_global.inc"

GLOBALS "../../../erp/cfg/top_schedule.inc"
 
{<Module define>}
 
#單頭 type 宣告
PRIVATE type type_g_gzpa_m        RECORD
       gzpa001 LIKE gzpa_t.gzpa001, 
   gzpa004 DATETIME YEAR TO SECOND, 
   gzpa002 LIKE gzpa_t.gzpa002, 
   gzpa005 DATETIME YEAR TO SECOND, 
   gzpa003 LIKE gzpa_t.gzpa003, 
   gzpa006 LIKE gzpa_t.gzpa006, 
   gzpa007 LIKE gzpa_t.gzpa007, 
   gzpa008 LIKE gzpa_t.gzpa008, 
   
   m01      LIKE type_t.chr1,
      m02      LIKE type_t.chr1,
      m03      LIKE type_t.chr1,
      m04      LIKE type_t.chr1,
      m05      LIKE type_t.chr1,
      m06      LIKE type_t.chr1,
      m07      LIKE type_t.chr1,
      m08      LIKE type_t.chr1,
      m09      LIKE type_t.chr1,
      m10      LIKE type_t.chr1,
      m11      LIKE type_t.chr1,
      m12      LIKE type_t.chr1, 
   gzpa010 LIKE gzpa_t.gzpa010, 

   wk1      LIKE type_t.chr1,
      wk2      LIKE type_t.chr1,
      wk3      LIKE type_t.chr1,
      wk4      LIKE type_t.chr1,
      wk5      LIKE type_t.chr1,
   gzpa012  LIKE gzpa_t.gzpa012, #日別
   
   wd0      LIKE type_t.chr1,
      wd1      LIKE type_t.chr1,
      wd2      LIKE type_t.chr1,
      wd3      LIKE type_t.chr1,
      wd4      LIKE type_t.chr1,
      wd5      LIKE type_t.chr1,
      wd6      LIKE type_t.chr1,
      d01      LIKE type_t.chr1,
      d02      LIKE type_t.chr1,
      d03      LIKE type_t.chr1,
      d04      LIKE type_t.chr1,
      d05      LIKE type_t.chr1,
      d06      LIKE type_t.chr1,
      d07      LIKE type_t.chr1,
      d08      LIKE type_t.chr1,
      d09      LIKE type_t.chr1,
      d10      LIKE type_t.chr1,
      d11      LIKE type_t.chr1,
      d12      LIKE type_t.chr1,
      d13      LIKE type_t.chr1,
      d14      LIKE type_t.chr1,
      d15      LIKE type_t.chr1,
      d16      LIKE type_t.chr1,
      d17      LIKE type_t.chr1,
      d18      LIKE type_t.chr1,
      d19      LIKE type_t.chr1,
      d20      LIKE type_t.chr1,
      d21      LIKE type_t.chr1,
      d22      LIKE type_t.chr1,
      d23      LIKE type_t.chr1,
      d24      LIKE type_t.chr1,
      d25      LIKE type_t.chr1,
      d26      LIKE type_t.chr1,
      d27      LIKE type_t.chr1,
      d28      LIKE type_t.chr1,
      d29      LIKE type_t.chr1,
      d30      LIKE type_t.chr1,
      d31      LIKE type_t.chr1,
      den      LIKE type_t.chr1,
   gzpa015 LIKE gzpa_t.gzpa015, 
   gzpa016 LIKE gzpa_t.gzpa016, 
   sc1 LIKE type_t.chr1,
   gzpa017 LIKE gzpa_t.gzpa017, 
   gzpa018 LIKE gzpa_t.gzpa018, 
   gzpa019 LIKE gzpa_t.gzpa019, 
   gzpa020 LIKE gzpa_t.gzpa020, 
   sc2 LIKE type_t.chr1,
   gzpa021 LIKE gzpa_t.gzpa021, 
   gzpa022 LIKE gzpa_t.gzpa022, 
   gzpa023 LIKE gzpa_t.gzpa023, 
   gzpa024 LIKE gzpa_t.gzpa024, 
   sc3 LIKE type_t.chr1, 
   gzpa025 LIKE gzpa_t.gzpa025, 
   gzpa026 LIKE gzpa_t.gzpa026, 
   gzpa027 LIKE gzpa_t.gzpa027, 
   gzpa028 LIKE gzpa_t.gzpa028, 
   gzpa029 LIKE gzpa_t.gzpa029, 
   gzpa030 LIKE gzpa_t.gzpa030, 
   gzpa031 LIKE gzpa_t.gzpa031, 
   gzpastus LIKE gzpa_t.gzpastus, 
   gzpaownid LIKE gzpa_t.gzpaownid, 
   gzpaownid_desc LIKE type_t.chr80, 
   gzpaowndp LIKE gzpa_t.gzpaowndp, 
   gzpaowndp_desc LIKE type_t.chr80, 
   gzpacrtid LIKE gzpa_t.gzpacrtid, 
   gzpacrtid_desc LIKE type_t.chr80, 
   gzpacrtdp LIKE gzpa_t.gzpacrtdp, 
   gzpacrtdp_desc LIKE type_t.chr80, 
   gzpacrtdt DATETIME YEAR TO SECOND, 
   gzpamodid LIKE gzpa_t.gzpamodid, 
   gzpamodid_desc LIKE type_t.chr80, 
   gzpamoddt DATETIME YEAR TO SECOND, 
   gzpe003 LIKE gzpe_t.gzpe003, 
   gzpe004 LIKE gzpe_t.gzpe004, 
   gzpe004_desc LIKE type_t.chr80, 
   addr LIKE type_t.chr80, 
   gzpe005 LIKE gzpe_t.gzpe005
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_gzpb_d        RECORD
       gzpb002 LIKE gzpb_t.gzpb002, 
   gzpb003 LIKE gzpb_t.gzpb003, 
   gzpb003_desc LIKE type_t.chr500, 
   gzpb004 LIKE gzpb_t.gzpb004, 
   gzpb005 LIKE gzpb_t.gzpb005
       END RECORD
 
 
#模組變數(Module Variables)
DEFINE g_gzpa_m          type_g_gzpa_m
DEFINE g_gzpa_m_t        type_g_gzpa_m
 
   DEFINE g_gzpa001_t LIKE gzpa_t.gzpa001
 
 
DEFINE g_gzpb_d          DYNAMIC ARRAY OF type_g_gzpb_d
DEFINE g_gzpb_d_t        type_g_gzpb_d
 
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位 
         b_statepic     LIKE type_t.chr50,
            b_gzpa001 LIKE gzpa_t.gzpa001,
      b_gzpa002 LIKE gzpa_t.gzpa002,
      b_gzpa003 LIKE gzpa_t.gzpa003,
      b_gzpa004 LIKE gzpa_t.gzpa004,
      b_gzpa005 LIKE gzpa_t.gzpa005
         #,rank           LIKE type_t.num10
      END RECORD 
      
DEFINE g_browser_f  RECORD    #資料瀏覽之欄位 
         b_statepic     LIKE type_t.chr50,
            b_gzpa001 LIKE gzpa_t.gzpa001,
      b_gzpa002 LIKE gzpa_t.gzpa002,
      b_gzpa003 LIKE gzpa_t.gzpa003,
      b_gzpa004 LIKE gzpa_t.gzpa004,
      b_gzpa005 LIKE gzpa_t.gzpa005
         #,rank           LIKE type_t.num10
      END RECORD 
      
#無單頭append欄位定義
#無單身append欄位定義
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING

#140316
DEFINE g_wc3                 STRING
DEFINE g_wc3_table1          STRING
#
 
 
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
 
DEFINE g_sql                 STRING
DEFINE g_forupd_sql          STRING
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_current_idx         LIKE type_t.num10     
DEFINE g_jump                LIKE type_t.num10        
DEFINE g_no_ask              LIKE type_t.num5        
DEFINE g_rec_b               LIKE type_t.num5           
DEFINE l_ac                  LIKE type_t.num5    
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog
    
DEFINE g_pagestart           LIKE type_t.num5           
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁
DEFINE g_state               STRING       
 
DEFINE g_detail_cnt          LIKE type_t.num5              #單身總筆數
DEFINE g_detail_idx          LIKE type_t.num5              #單身目前所在筆數
DEFINE g_detail_idx2         LIKE type_t.num5              #單身2目前所在筆數
DEFINE g_browser_cnt         LIKE type_t.num5              #Browser總筆數
DEFINE g_browser_idx         LIKE type_t.num5              #Browser目前所在筆數
DEFINE g_temp_idx            LIKE type_t.num5              #Browser目前所在筆數(暫存用)
 
DEFINE g_searchcol           STRING                        #查詢欄位代碼
DEFINE g_searchstr           STRING                        #查詢欄位字串
DEFINE g_order               STRING                        #查詢排序欄位
                                                        
DEFINE g_current_row         LIKE type_t.num5              #Browser所在筆數
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
DEFINE g_current_page        LIKE type_t.num5              #目前所在頁數
DEFINE g_insert              LIKE type_t.chr5              #是否導到其他page
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys               DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak           DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_bfill               LIKE type_t.chr5              #是否刷新單身
DEFINE g_error_show          LIKE type_t.num5              #
 
DEFINE g_wc_frozen           STRING                        #凍結欄位使用
DEFINE g_chk                 BOOLEAN                       #助記碼判斷用
DEFINE g_aw                  STRING                        #確定當下點擊的單身
DEFINE g_default             BOOLEAN                       #是否有外部參數查詢
 
{</Module define>}
 
#add-point:自定義模組變數(Module Variable)
{<point name="global.variable"/>}
DEFINE g_schedule_d DYNAMIC ARRAY OF RECORD
       gzpe003      LIKE gzpe_t.gzpe003,
       gzpe004      LIKE gzpe_t.gzpe004,
       gzpe004_desc LIKE type_t.chr80,
       addr         LIKE type_t.chr80,
       gzpe005      LIKE gzpe_t.gzpe005
  
  END RECORD 
#end add-point
 
#add-point:傳入參數說明(global.argv)
{<point name="global.argv"/>}
#end add-point
 
{</section>}
 
{<section id="azzi950.main" >}
#test
#+ 此段落由子樣板a26產生
#OPTIONS SHORT CIRCUIT
#+ 作業開始 
MAIN
   #add-point:main段define
   {<point name="main.define"/>}
   #end add-point   
 
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("azz","")
 
   #add-point:作業初始化
   {<point name="main.init" />}
   #end add-point
   
   
 
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define
   {<point name="main.define_sql" />}
   #end add-point
   LET g_forupd_sql = "SELECT gzpa001,gzpa004,gzpa002,gzpa005,gzpa003,gzpa006,gzpa007,gzpa008,'','', 
       '','','','','','','','','','',gzpa010,'','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','',gzpa015,gzpa016, 
       '',gzpa017,gzpa018,gzpa019,gzpa020,'',gzpa021,gzpa022,gzpa023,gzpa024,'',gzpa025,gzpa026,gzpa027, 
       gzpa028,gzpa029,gzpa030,gzpa031,gzpastus,gzpaownid,'',gzpaowndp,'',gzpacrtid,'',gzpacrtdp,'', 
       gzpacrtdt,gzpamodid,'',gzpamoddt,'','','','','' FROM gzpa_t WHERE gzpaent= ? AND gzpa001=? FOR  
       UPDATE"
   #add-point:SQL_define
   {<point name="main.after_define_sql"/>}
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   DECLARE azzi950_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call
      {<point name="main.servicecall" />}
      #end add-point
 
   ELSE
      
      #畫面開啟 (identifier)
      OPEN WINDOW w_azzi950 WITH FORM cl_ap_formpath("azz",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL azzi950_init()   
 
      #進入選單 Menu (="N")
      CALL azzi950_ui_dialog() 
	  
      #add-point:畫面關閉前
      {<point name="main.before_close" />}
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_azzi950
      
   END IF 
   
   CLOSE azzi950_cl
   
   
 
   #add-point:作業離開前
   {<point name="main.exit" />}
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN
 
 
 
{</section>}
 
{<section id="azzi950.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION azzi950_init()
   #add-point:init段define
   {<point name="init.define"/>}
   #end add-point    
   
   LET g_bfill       = "Y"
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_error_show  = 1
      CALL cl_set_combo_scc_part('gzpastus','17','N,Y')
 
      CALL cl_set_combo_scc('gzpa003','75') 
   CALL cl_set_combo_scc('gzpa008','73') 
   CALL cl_set_combo_scc('gzpa010','72') 
   CALL cl_set_combo_scc('gzpa012','71') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
 
   #add-point:畫面資料初始化
  
  CALL cl_set_combo_scc('b_gzpa003','80') 

   CALL cl_set_combo_scc("gzpa030","70")
   CALL cl_set_combo_scc("gzpa015","80")
   #CALL cl_set_combo_scc("gzpa010","72")
   #CALL cl_set_combo_scc("gzpa008","73")
   CALL cl_set_combo_scc("gzpa020","69")
   CALL cl_set_combo_scc("gzpa024","69")
   CALL cl_set_combo_scc("gzpa028","69")
   #CALL cl_set_combo_scc("formonly.schedule_period","68")
   CALL cl_set_combo_scc("gzpe003","67")

   CALL azzi950_schedule_init() 
   #end add-point
   
   CALL azzi950_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="azzi950.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION azzi950_ui_dialog()
   {<Local define>}
   DEFINE li_idx    LIKE type_t.num5
   DEFINE ls_wc     STRING
   DEFINE lb_first  BOOLEAN
   {</Local define>}
   #add-point:ui_dialog段define
   {<point name="ui_dialog.define"/>}
   #end add-point
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
 
   CALL gfrm_curr.setElementImage("logo","logo/applogo.png") 
   IF g_default THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   ELSE
      CALL gfrm_curr.setElementHidden("mainlayout",1)
      CALL gfrm_curr.setElementHidden("worksheet",0)
      LET g_main_hidden = 1
   END IF
   
   #action default動作
   #+ 此段落由子樣板a42產生
   CASE g_actdefault
      WHEN "insert"
         LET g_action_choice="insert"
         LET g_actdefault = ""
         IF cl_auth_chk_act("insert") THEN
            CALL azzi950_insert()
            #add-point:ON ACTION insert
            {<point name="menu.default.insert" />}
            #END add-point
         END IF
 
      #add-point:action default自訂
      {<point name="ui_dialog.action_default"/>}
      #end add-point
      OTHERWISE
         
   END CASE
 
 
   
   LET lb_first = TRUE
   
   #add-point:ui_dialog段before dialog 
   {<point name="ui_dialog.before_dialog"/>}
   #end add-point
   
   WHILE TRUE 
   
      CALL azzi950_browser_fill("")
      CALL lib_cl_dlg.cl_dlg_before_display()
      CALL cl_notice()
            
      #判斷前一個動作是否為新增, 若是的話切換到新增的筆數
      IF g_state = "Y" THEN
         FOR li_idx = 1 TO g_browser.getLength()
            IF g_browser[li_idx].b_gzpa001 = g_gzpa001_t
 
               THEN
               LET g_current_row = li_idx
               LET g_current_idx = li_idx
               EXIT FOR
            END IF
         END FOR
         LET g_state = ""
      END IF
            
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
         #INPUT g_searchstr,g_searchcol FROM formonly.searchstr,formonly.cbo_searchcol
         #
         #   BEFORE INPUT
         #   
         #END INPUT
 
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
               
               CALL azzi950_fetch('') # reload data
               LET l_ac = 1
               CALL azzi950_ui_detailshow() #Setting the current row 
      
               CALL azzi950_idx_chk()
               #NEXT FIELD gzpb002
         
         END DISPLAY
        
         DISPLAY ARRAY g_gzpb_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               CALL azzi950_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               
               #add-point:page1, before row動作
               {<point name="ui_dialog.page1.before_row"/>}
               #end add-point
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
               CALL azzi950_idx_chk()
               #add-point:page1自定義行為
               {<point name="ui_dialog.page1.before_display"/>}
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為
            {<point name="ui_dialog.page1.action"/>}
            #end add-point
               
         END DISPLAY
        
 
         
         #add-point:ui_dialog段自定義display array
         {<point name="ui_dialog.more_displayarray"/>}

          DISPLAY ARRAY g_schedule_d TO s_schedule1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               CALL azzi950_idx_chk()
               #LET l_ac = DIALOG.getCurrentRow("s_schedule1")
               LET g_detail_idx = l_ac
               

               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               #LET l_ac = DIALOG.getCurrentRow("s_schedule1")
               LET g_current_page = 1
               #CALL azzi950_idx_chk()

               
            #自訂ACTION(detail_show,page_1)
            
            
               
         END DISPLAY
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_page = "first"
            LET g_current_sw = FALSE
            #回歸舊筆數位置 (回到當時異動的筆數)
            LET g_current_idx = DIALOG.getCurrentRow("s_browse")
            IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
               CALL DIALOG.setCurrentRow("s_browse",g_current_row)
               LET g_current_idx = g_current_row
            END IF
            LET g_current_row = g_current_idx #目前指標
            IF g_current_idx = 0 THEN
               LET g_current_idx = 1
            END IF
            LET g_current_sw = TRUE
            
            IF g_current_idx > g_browser.getLength() THEN
               LEt g_current_idx = g_browser.getLength()
            END IF 
            
            #有資料才進行fetch
            IF g_current_idx <> 0 THEN
               CALL azzi950_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL azzi950_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL azzi950_idx_chk()
            
            #add-point:ui_dialog段before_dialog2
            {<point name="ui_dialog.before_dialog2"/>}
            #end add-point
            
            IF lb_first THEN
               LET lb_first = FALSE
               NEXT FIELD gzpb002
            END IF
        
         ON ACTION statechange
            CALL azzi950_statechange()
            LET g_action_choice = "statechange"
            EXIT DIALOG
      
         
          
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               CALL azzi950_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
 
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL azzi950_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  CALL cl_err("","-100",1)
                  CLEAR FORM
               ELSE
                  CALL azzi950_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
          
         #ACTION表單列
         ON ACTION filter
            CALL azzi950_filter()
            EXIT DIALOG
         
         ON ACTION first
            CALL azzi950_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL azzi950_idx_chk()
            
         ON ACTION previous
            CALL azzi950_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL azzi950_idx_chk()
            
         ON ACTION jump
            CALL azzi950_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL azzi950_idx_chk()
            
         ON ACTION next
            CALL azzi950_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL azzi950_idx_chk()
            
         ON ACTION last
            CALL azzi950_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL azzi950_idx_chk()
            
         ON ACTION close
            LET INT_FLAG = FALSE
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
       
         ON ACTION controls      #單頭摺疊，可利用hot key "Ctrl-s"開啟/關閉單頭
            IF g_header_hidden THEN
               CALL gfrm_curr.setElementHidden("worksheet_detail",0)
               CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
               LET g_header_hidden = 0     #visible
            ELSE
               CALL gfrm_curr.setElementHidden("worksheet_detail",1)
               CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
               LET g_header_hidden = 1     #hidden     
            END IF
    
         
 
         ON ACTION delete
 
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN 
               CALL azzi950_delete()
               #add-point:ON ACTION delete
               {<point name="menu.delete" />}
               #END add-point
            END IF
 
 
         ON ACTION insert
 
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN 
               CALL azzi950_insert()
               #add-point:ON ACTION insert
               {<point name="menu.insert" />}
               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION modify
 
            LET g_aw = ''
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN 
               CALL azzi950_modify()
               #add-point:ON ACTION modify
               {<point name="menu.modify" />}
               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION modify_detail
 
            LET g_aw = g_curr_diag.getCurrentItem()
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN 
               CALL azzi950_modify()
               #add-point:ON ACTION modify_detail
               {<point name="menu.modify_detail" />}
               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION output
 
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN 
               #add-point:ON ACTION output
               {<point name="menu.output" />}
               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION query
 
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN 
               CALL azzi950_query()
               #add-point:ON ACTION query
               {<point name="menu.query" />}
               #END add-point
            END IF
 
 
         ON ACTION reproduce
 
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN 
               CALL azzi950_reproduce()
               #add-point:ON ACTION reproduce
               {<point name="menu.reproduce" />}
               #END add-point
               EXIT DIALOG
            END IF
 
         
         ON ACTION related_document
            CALL cl_doc()
         
         #主選單用ACTION
         &include "main_menu.4gl"
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
 
{<section id="azzi950.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION azzi950_browser_search(p_type)
   {<Local define>}
   DEFINE p_type LIKE type_t.chr10
   {</Local define>}
   #add-point:browser_search段define
   {<point name="browser_search.define"/>}
   #end add-point    
   
   #若無輸入關鍵字則查找出所有資料
   IF NOT cl_null(g_searchstr) AND g_searchcol='0' THEN
      CALL cl_err("searchcol","std-00005",0)
      RETURN FALSE 
   END IF 
   
   IF NOT cl_null(g_searchstr) THEN
      LET g_wc = " lower(", g_searchcol, ") LIKE '%", g_searchstr, "%'"
      LET g_wc = g_wc.toLowerCase()
   ELSE
      LET g_wc = " 1=1 "
   END IF         
   
   #若為排序搜尋則添加以下條件
   IF cl_null(g_searchcol) OR g_searchcol = "0" THEN
      LET g_wc = g_wc, " ORDER BY gzpa001"
   ELSE
      LET g_wc = g_wc, " ORDER BY ", g_searchcol
   END IF 
 
   CALL azzi950_browser_fill("F")
   CALL ui.Interface.refresh()
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="azzi950.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION azzi950_browser_fill(ps_page_action)
   {<Local define>}
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   DEFINE l_searchcol       STRING
   {</Local define>}
   #add-point:browser_fill段define
   {<point name="browser_fill.define"/>}
   #end add-point    
 
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_gzpa_m.* TO NULL
   CALL g_gzpb_d.clear()        
 
   CALL g_browser.clear()
   
   #搜尋用
   IF cl_null(g_searchcol) OR g_searchcol = '0' THEN
      LET l_searchcol = "gzpa001"
 
   ELSE
      LET l_searchcol = g_searchcol
   END IF
   
   LET l_wc  = g_wc.trim() 
   LET l_wc2 = g_wc2.trim()
   IF cl_null(l_wc) THEN  #p_wc 查詢條件
      RETURN
   END IF
   
   #add-point:browser_fill,foreach前
   {<point name="browser_fill.before_foreach"/>}
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT UNIQUE gzpa001 ",
 
                        " FROM gzpa_t ",
                              " ",
                              " LEFT JOIN gzpb_t ON gzpbent = gzpaent AND gzpa001 = gzpb001 ",
 
                              #140316
                              " LEFT JOIN gzpe_t ON gzpbent = gzpeent AND gzpb001 = gzpe001 ",
                              " AND gzpb002 = gzpe002  AND gzpb003 = gzpe003 ",
                              #140316
                              " ", 
                              " ", 
                       " WHERE gzpaent = '" ||g_enterprise|| "' AND gzpbent = '" ||g_enterprise|| "' AND ",l_wc, " AND ", l_wc2
 
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE gzpa001 ",
 
                        " FROM gzpa_t ", 
                              " ",
                              " ",
                        "WHERE gzpaent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED
 
   END IF
   
   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"
   
   #add-point:browser_fill,count前
   {<point name="browser_fill.before_count"/>}
   #end add-point
   DISPLAY "pre g_sql:",g_sql
   PREPARE header_cnt_pre FROM g_sql
   EXECUTE header_cnt_pre INTO g_browser_cnt   #總筆數
   FREE header_cnt_pre
 
   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
   
   #LET g_page_action = ps_page_action          # Keep Action
   
   IF ps_page_action = "F" OR
      ps_page_action = "P" OR
      ps_page_action = "N" OR
      ps_page_action = "L" THEN
      LET g_page_action = ps_page_action
   END IF
   
   CASE ps_page_action
      WHEN "F" 
         LET g_pagestart = 1
          
      WHEN "P"  
         LET g_pagestart = g_pagestart - g_max_browse
         IF g_pagestart < 1 THEN
            LET g_pagestart = 1
         END IF
          
      WHEN "N"  
         LET g_pagestart = g_pagestart + g_max_browse
         IF g_pagestart > g_browser_cnt THEN
            LET g_pagestart = g_browser_cnt - (g_browser_cnt mod g_max_browse) + 1
            WHILE g_pagestart > g_browser_cnt 
               LET g_pagestart = g_pagestart - g_max_browse
            END WHILE
         END IF
      
      WHEN "L"  
         LET g_pagestart = g_browser_cnt - (g_browser_cnt mod g_max_browse) + 1
         WHILE g_pagestart > g_browser_cnt 
            LET g_pagestart = g_pagestart - g_max_browse
         END WHILE
         
      WHEN '/'
         LET g_pagestart = g_jump
         IF g_pagestart > g_browser_cnt THEN
            LET g_pagestart = 1
         END IF
         
   END CASE
  
   #單身有輸入查詢條件且非null
   IF g_wc2 <> " 1=1" AND NOT cl_null(g_wc2) THEN 
      #依照gzpa001,gzpa002,gzpa003,gzpa004,gzpa005 Browser欄位定義(取代原本bs_sql功能)
      LET l_sql_rank = "SELECT DISTINCT gzpastus,gzpa001,gzpa002,gzpa003,gzpa004,gzpa005,DENSE_RANK() OVER(ORDER BY gzpa001 ", 
          g_order,") AS RANK ",
                        " FROM gzpa_t ",
                              " ",
                              " LEFT JOIN gzpb_t ON gzpbent = gzpaent AND gzpa001 = gzpb001 ",
 
                              #140316
                              " LEFT JOIN gzpe_t ON gzpbent = gzpeent AND gzpb001 = gzpe001 ",
                              " AND gzpb002 = gzpe002  AND gzpb003 = gzpe003 ",
                              #140316
                              " ",
                              " ",
                       " ",
                       " WHERE gzpaent = '" ||g_enterprise|| "' AND ",g_wc," AND ",g_wc2
   ELSE
      #單身無輸入資料
      LET l_sql_rank = "SELECT DISTINCT gzpastus,gzpa001,gzpa002,gzpa003,gzpa004,gzpa005,DENSE_RANK() OVER(ORDER BY gzpa001 ", 
          g_order,") AS RANK ",
                       " FROM gzpa_t ",
                            "  ",
                            "  ",
                       " WHERE gzpaent = '" ||g_enterprise|| "' AND ", g_wc
   END IF
   
   #定義翻頁CURSOR
   LET g_sql= "SELECT gzpastus,gzpa001,gzpa002,gzpa003,gzpa004,gzpa005 FROM (",l_sql_rank,") WHERE ", 
 
              " RANK >= ",1," AND RANK<",1+g_max_browse,
              " ORDER BY ",l_searchcol," ",g_order
               
   DISPLAY "g_sql:",g_sql
   #add-point:browser_fill,before_prepare
   {<point name="browser_fill.before_prepare"/>}
   #end add-point
               
   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre
   
   #add-point:browser_fill,open
   {<point name="browser_fill.open"/>}
   #end add-point
 
   CALL g_browser.clear()
   LET g_cnt = 1
   FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_gzpa001,g_browser[g_cnt].b_gzpa002, 
       g_browser[g_cnt].b_gzpa003,g_browser[g_cnt].b_gzpa004,g_browser[g_cnt].b_gzpa005
      IF SQLCA.sqlcode THEN
         CALL cl_err('foreach:',SQLCA.sqlcode,1)
         EXIT FOREACH
      END IF
  
      
  
      #add-point:browser_fill段reference
      {<point name="browser_fill.reference"/>}
      #end add-point
  
            #此段落由子樣板a24產生
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/inactive.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/active.png"
 
 
         
      END CASE
 
 
      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         CALL cl_err('',9035,0)
         EXIT FOREACH
      END IF
      
   END FOREACH
 
   CALL g_browser.deleteElement(g_cnt)
   LET g_header_cnt = g_browser.getLength()
 
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   FREE browse_pre
   
   #add-point:browser_fill段結束前
   {<point name="browser_fill.after"/>}
   #end add-point
   
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,delete,reproduce", FALSE)
   ELSE
      CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   END IF
   
END FUNCTION
 
{</section>}
 
{<section id="azzi950.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION azzi950_ui_headershow()
   #add-point:ui_headershow段define
   {<point name="ui_headershow.define"/>}
   #end add-point    
   
   LET g_gzpa_m.gzpa001 = g_browser[g_current_idx].b_gzpa001   
 
    SELECT UNIQUE gzpa001,gzpa004,gzpa002,gzpa005,gzpa003,gzpa006,gzpa007,gzpa008,gzpa010,gzpa012,gzpa015, 
        gzpa016,gzpa017,gzpa018,gzpa019,gzpa020,gzpa021,gzpa022,gzpa023,gzpa024,gzpa025,gzpa026,gzpa027, 
        gzpa028,gzpa029,gzpa030,gzpa031,gzpastus,gzpaownid,gzpaowndp,gzpacrtid,gzpacrtdp,gzpacrtdt,gzpamodid, 
        gzpamoddt
 INTO g_gzpa_m.gzpa001,g_gzpa_m.gzpa004,g_gzpa_m.gzpa002,g_gzpa_m.gzpa005,g_gzpa_m.gzpa003,g_gzpa_m.gzpa006, 
     g_gzpa_m.gzpa007,g_gzpa_m.gzpa008,g_gzpa_m.gzpa010,g_gzpa_m.gzpa012,g_gzpa_m.gzpa015,g_gzpa_m.gzpa016, 
     g_gzpa_m.gzpa017,g_gzpa_m.gzpa018,g_gzpa_m.gzpa019,g_gzpa_m.gzpa020,g_gzpa_m.gzpa021,g_gzpa_m.gzpa022, 
     g_gzpa_m.gzpa023,g_gzpa_m.gzpa024,g_gzpa_m.gzpa025,g_gzpa_m.gzpa026,g_gzpa_m.gzpa027,g_gzpa_m.gzpa028, 
     g_gzpa_m.gzpa029,g_gzpa_m.gzpa030,g_gzpa_m.gzpa031,g_gzpa_m.gzpastus,g_gzpa_m.gzpaownid,g_gzpa_m.gzpaowndp, 
     g_gzpa_m.gzpacrtid,g_gzpa_m.gzpacrtdp,g_gzpa_m.gzpacrtdt,g_gzpa_m.gzpamodid,g_gzpa_m.gzpamoddt
 FROM gzpa_t
 WHERE gzpaent = g_enterprise AND gzpa001 = g_gzpa_m.gzpa001
   CALL azzi950_show()
   
END FUNCTION
 
{</section>}
 
{<section id="azzi950.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION azzi950_ui_detailshow()
   #add-point:ui_detailshow段define
   {<point name="ui_detailshow.define"/>}
   #end add-point    
   
   #add-point:ui_detailshow段before
   {<point name="ui_detailshow.before"/>}
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
 
   END IF
   
   #add-point:ui_detailshow段after
   {<point name="ui_detailshow.after"/>}
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="azzi950.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION azzi950_ui_browser_refresh()
   {<Local define>}
   DEFINE l_i  LIKE type_t.num10
   {</Local define>}
   #add-point:ui_browser_refresh段define
   {<point name="ui_browser_refresh.define"/>}
   #end add-point    
   
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_gzpa001 = g_gzpa_m.gzpa001 
 
         THEN  
         CALL g_browser.deleteElement(l_i)
         LET g_header_cnt = g_header_cnt - 1
      END IF
   END FOR
 
   LET g_browser_cnt = g_browser_cnt - 1
   IF g_current_row > g_browser_cnt THEN        #確定browse 筆數指在同一筆
      LET g_current_row = g_browser_cnt
   END IF
 
   #DISPLAY g_browser_cnt TO FORMONLY.b_count    #總筆數的顯示
   
END FUNCTION
 
{</section>}
 
{<section id="azzi950.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION azzi950_construct()
   {<Local define>}
   DEFINE lc_qbe_sn   LIKE type_t.num10
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   {</Local define>}
   #add-point:cs段define
   {<point name="cs.define"/>}
   #end add-point    
 
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_gzpa_m.* TO NULL
   CALL g_gzpb_d.clear()        
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前
   {<point name="cs.before_construct"/>}
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON gzpa001,gzpa004,gzpa002,gzpa005,gzpa003,gzpa006,gzpa007,gzpa008,gzpa010, 
          gzpa012,gzpa015,gzpa016,gzpa017,gzpa018,gzpa019,gzpa020,gzpa021,gzpa022,gzpa023,gzpa024,gzpa025, 
          gzpa026,gzpa027,gzpa028,gzpa029,gzpa030,gzpa031,gzpastus,gzpaownid,gzpaowndp,gzpacrtid,gzpacrtdp, 
          gzpacrtdt,gzpamodid,gzpamoddt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct
            {<point name="cs.head.before_construct"/>}
            #end add-point 
            
         #公用欄位開窗相關處理
         #此段落由子樣板a11產生
         ##----<<gzpaownid>>----
         #ON ACTION controlp INFIELD gzpaownid
         #   CALL q_common('gzpa_t','gzpaownid',TRUE,FALSE,g_gzpa_m.gzpaownid) RETURNING ls_return
         #   DISPLAY ls_return TO gzpaownid
         #   NEXT FIELD gzpaownid  
         #
         ##----<<gzpaowndp>>----
         #ON ACTION controlp INFIELD gzpaowndp
         #   CALL q_common('gzpa_t','gzpaowndp',TRUE,FALSE,g_gzpa_m.gzpaowndp) RETURNING ls_return
         #   DISPLAY ls_return TO gzpaowndp
         #   NEXT FIELD gzpaowndp
         #
         ##----<<gzpacrtid>>----
         #ON ACTION controlp INFIELD gzpacrtid
         #   CALL q_common('gzpa_t','gzpacrtid',TRUE,FALSE,g_gzpa_m.gzpacrtid) RETURNING ls_return
         #   DISPLAY ls_return TO gzpacrtid
         #   NEXT FIELD gzpacrtid
         #
         ##----<<gzpacrtdp>>----
         #ON ACTION controlp INFIELD gzpacrtdp
         #   CALL q_common('gzpa_t','gzpacrtdp',TRUE,FALSE,g_gzpa_m.gzpacrtdp) RETURNING ls_return
         #   DISPLAY ls_return TO gzpacrtdp
         #   NEXT FIELD gzpacrtdp
         #
         ##----<<gzpamodid>>----
         #ON ACTION controlp INFIELD gzpamodid
         #   CALL q_common('gzpa_t','gzpamodid',TRUE,FALSE,g_gzpa_m.gzpamodid) RETURNING ls_return
         #   DISPLAY ls_return TO gzpamodid
         #   NEXT FIELD gzpamodid
         #
         ##----<<gzpacnfid>>----
         ##ON ACTION controlp INFIELD gzpacnfid
         ##   CALL q_common('gzpa_t','gzpacnfid',TRUE,FALSE,g_gzpa_m.gzpacnfid) RETURNING ls_return
         ##   DISPLAY ls_return TO gzpacnfid
         ##   NEXT FIELD gzpacnfid
         #
         ##----<<gzpapstid>>----
         ##ON ACTION controlp INFIELD gzpapstid
         ##   CALL q_common('gzpa_t','gzpapstid',TRUE,FALSE,g_gzpa_m.gzpapstid) RETURNING ls_return
         ##   DISPLAY ls_return TO gzpapstid
         ##   NEXT FIELD gzpapstid
         
         ##----<<gzpacrtdt>>----
         AFTER FIELD gzpacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<gzpamoddt>>----
         AFTER FIELD gzpamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<gzpacnfdt>>----
         #AFTER FIELD gzpacnfdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<gzpapstdt>>----
         #AFTER FIELD gzpapstdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
            
         #一般欄位開窗相關處理    
         #---------------------------<  Master  >---------------------------
         #----<<gzpa001>>----
         #Ctrlp:construct.c.gzpa001
         ON ACTION controlp INFIELD gzpa001
            #add-point:ON ACTION controlp INFIELD gzpa001
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_gzpa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzpa001  #顯示到畫面上

            NEXT FIELD gzpa001                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD gzpa001
            #add-point:BEFORE FIELD gzpa001
            {<point name="construct.b.gzpa001" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpa001
            
            #add-point:AFTER FIELD gzpa001
            {<point name="construct.a.gzpa001" />}
            #END add-point
            
 
         #----<<gzpa004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpa004
            #add-point:BEFORE FIELD gzpa004
            {<point name="construct.b.gzpa004" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpa004
            
            #add-point:AFTER FIELD gzpa004
            {<point name="construct.a.gzpa004" />}
            #END add-point
            
 
         #Ctrlp:construct.c.gzpa004
#         ON ACTION controlp INFIELD gzpa004
            #add-point:ON ACTION controlp INFIELD gzpa004
            {<point name="construct.c.gzpa004" />}
            #END add-point
 
         #----<<gzpa002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpa002
            #add-point:BEFORE FIELD gzpa002
            {<point name="construct.b.gzpa002" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpa002
            
            #add-point:AFTER FIELD gzpa002
            {<point name="construct.a.gzpa002" />}
            #END add-point
            
 
         #Ctrlp:construct.c.gzpa002
#         ON ACTION controlp INFIELD gzpa002
            #add-point:ON ACTION controlp INFIELD gzpa002
            {<point name="construct.c.gzpa002" />}
            #END add-point
 
         #----<<gzpa005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpa005
            #add-point:BEFORE FIELD gzpa005
            {<point name="construct.b.gzpa005" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpa005
            
            #add-point:AFTER FIELD gzpa005
            {<point name="construct.a.gzpa005" />}
            #END add-point
            
 
         #Ctrlp:construct.c.gzpa005
#         ON ACTION controlp INFIELD gzpa005
            #add-point:ON ACTION controlp INFIELD gzpa005
            {<point name="construct.c.gzpa005" />}
            #END add-point
 
         #----<<gzpa003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpa003
            #add-point:BEFORE FIELD gzpa003
            {<point name="construct.b.gzpa003" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpa003
            
            #add-point:AFTER FIELD gzpa003
            {<point name="construct.a.gzpa003" />}
            #END add-point
            
 
         #Ctrlp:construct.c.gzpa003
#         ON ACTION controlp INFIELD gzpa003
            #add-point:ON ACTION controlp INFIELD gzpa003
            {<point name="construct.c.gzpa003" />}
            #END add-point
 
         #----<<gzpa006>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpa006
            #add-point:BEFORE FIELD gzpa006
            {<point name="construct.b.gzpa006" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpa006
            
            #add-point:AFTER FIELD gzpa006
            {<point name="construct.a.gzpa006" />}
            #END add-point
            
 
         #Ctrlp:construct.c.gzpa006
#         ON ACTION controlp INFIELD gzpa006
            #add-point:ON ACTION controlp INFIELD gzpa006
            {<point name="construct.c.gzpa006" />}
            #END add-point
 
         #----<<gzpa007>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpa007
            #add-point:BEFORE FIELD gzpa007
            {<point name="construct.b.gzpa007" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpa007
            
            #add-point:AFTER FIELD gzpa007
            {<point name="construct.a.gzpa007" />}
            #END add-point
            
 
         #Ctrlp:construct.c.gzpa007
#         ON ACTION controlp INFIELD gzpa007
            #add-point:ON ACTION controlp INFIELD gzpa007
            {<point name="construct.c.gzpa007" />}
            #END add-point
 
         #----<<gzpa008>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpa008
            #add-point:BEFORE FIELD gzpa008
            {<point name="construct.b.gzpa008" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpa008
            
            #add-point:AFTER FIELD gzpa008
            {<point name="construct.a.gzpa008" />}
            #END add-point
            
 
         #Ctrlp:construct.c.gzpa008
#         ON ACTION controlp INFIELD gzpa008
            #add-point:ON ACTION controlp INFIELD gzpa008
            {<point name="construct.c.gzpa008" />}
            #END add-point
 
         #----<<gzpa010>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpa010
            #add-point:BEFORE FIELD gzpa010
            {<point name="construct.b.gzpa010" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpa010
            
            #add-point:AFTER FIELD gzpa010
            {<point name="construct.a.gzpa010" />}
            #END add-point
            
 
         #Ctrlp:construct.c.gzpa010
#         ON ACTION controlp INFIELD gzpa010
            #add-point:ON ACTION controlp INFIELD gzpa010
            {<point name="construct.c.gzpa010" />}
            #END add-point
 
         #----<<gzpa012>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpa012
            #add-point:BEFORE FIELD gzpa012
            {<point name="construct.b.gzpa012" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpa012
            
            #add-point:AFTER FIELD gzpa012
            {<point name="construct.a.gzpa012" />}
            #END add-point
            
 
         #Ctrlp:construct.c.gzpa012
#         ON ACTION controlp INFIELD gzpa012
            #add-point:ON ACTION controlp INFIELD gzpa012
            {<point name="construct.c.gzpa012" />}
            #END add-point
 
         #----<<gzpa015>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpa015
            #add-point:BEFORE FIELD gzpa015
            {<point name="construct.b.gzpa015" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpa015
            
            #add-point:AFTER FIELD gzpa015
            {<point name="construct.a.gzpa015" />}
            #END add-point
            
 
         #Ctrlp:construct.c.gzpa015
#         ON ACTION controlp INFIELD gzpa015
            #add-point:ON ACTION controlp INFIELD gzpa015
            {<point name="construct.c.gzpa015" />}
            #END add-point
 
         #----<<gzpa016>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpa016
            #add-point:BEFORE FIELD gzpa016
            {<point name="construct.b.gzpa016" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpa016
            
            #add-point:AFTER FIELD gzpa016
            {<point name="construct.a.gzpa016" />}
            #END add-point
            
 
         #Ctrlp:construct.c.gzpa016
#         ON ACTION controlp INFIELD gzpa016
            #add-point:ON ACTION controlp INFIELD gzpa016
            {<point name="construct.c.gzpa016" />}
            #END add-point
 
         #----<<gzpa017>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpa017
            #add-point:BEFORE FIELD gzpa017
            {<point name="construct.b.gzpa017" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpa017
            
            #add-point:AFTER FIELD gzpa017
            {<point name="construct.a.gzpa017" />}
            #END add-point
            
 
         #Ctrlp:construct.c.gzpa017
#         ON ACTION controlp INFIELD gzpa017
            #add-point:ON ACTION controlp INFIELD gzpa017
            {<point name="construct.c.gzpa017" />}
            #END add-point
 
         #----<<gzpa018>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpa018
            #add-point:BEFORE FIELD gzpa018
            {<point name="construct.b.gzpa018" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpa018
            
            #add-point:AFTER FIELD gzpa018
            {<point name="construct.a.gzpa018" />}
            #END add-point
            
 
         #Ctrlp:construct.c.gzpa018
#         ON ACTION controlp INFIELD gzpa018
            #add-point:ON ACTION controlp INFIELD gzpa018
            {<point name="construct.c.gzpa018" />}
            #END add-point
 
         #----<<gzpa019>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpa019
            #add-point:BEFORE FIELD gzpa019
            {<point name="construct.b.gzpa019" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpa019
            
            #add-point:AFTER FIELD gzpa019
            {<point name="construct.a.gzpa019" />}
            #END add-point
            
 
         #Ctrlp:construct.c.gzpa019
#         ON ACTION controlp INFIELD gzpa019
            #add-point:ON ACTION controlp INFIELD gzpa019
            {<point name="construct.c.gzpa019" />}
            #END add-point
 
         #----<<gzpa020>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpa020
            #add-point:BEFORE FIELD gzpa020
            {<point name="construct.b.gzpa020" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpa020
            
            #add-point:AFTER FIELD gzpa020
            {<point name="construct.a.gzpa020" />}
            #END add-point
            
 
         #Ctrlp:construct.c.gzpa020
#         ON ACTION controlp INFIELD gzpa020
            #add-point:ON ACTION controlp INFIELD gzpa020
            {<point name="construct.c.gzpa020" />}
            #END add-point
 
         #----<<gzpa021>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpa021
            #add-point:BEFORE FIELD gzpa021
            {<point name="construct.b.gzpa021" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpa021
            
            #add-point:AFTER FIELD gzpa021
            {<point name="construct.a.gzpa021" />}
            #END add-point
            
 
         #Ctrlp:construct.c.gzpa021
#         ON ACTION controlp INFIELD gzpa021
            #add-point:ON ACTION controlp INFIELD gzpa021
            {<point name="construct.c.gzpa021" />}
            #END add-point
 
         #----<<gzpa022>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpa022
            #add-point:BEFORE FIELD gzpa022
            {<point name="construct.b.gzpa022" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpa022
            
            #add-point:AFTER FIELD gzpa022
            {<point name="construct.a.gzpa022" />}
            #END add-point
            
 
         #Ctrlp:construct.c.gzpa022
#         ON ACTION controlp INFIELD gzpa022
            #add-point:ON ACTION controlp INFIELD gzpa022
            {<point name="construct.c.gzpa022" />}
            #END add-point
 
         #----<<gzpa023>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpa023
            #add-point:BEFORE FIELD gzpa023
            {<point name="construct.b.gzpa023" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpa023
            
            #add-point:AFTER FIELD gzpa023
            {<point name="construct.a.gzpa023" />}
            #END add-point
            
 
         #Ctrlp:construct.c.gzpa023
#         ON ACTION controlp INFIELD gzpa023
            #add-point:ON ACTION controlp INFIELD gzpa023
            {<point name="construct.c.gzpa023" />}
            #END add-point
 
         #----<<gzpa024>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpa024
            #add-point:BEFORE FIELD gzpa024
            {<point name="construct.b.gzpa024" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpa024
            
            #add-point:AFTER FIELD gzpa024
            {<point name="construct.a.gzpa024" />}
            #END add-point
            
 
         #Ctrlp:construct.c.gzpa024
#         ON ACTION controlp INFIELD gzpa024
            #add-point:ON ACTION controlp INFIELD gzpa024
            {<point name="construct.c.gzpa024" />}
            #END add-point
 
         #----<<gzpa025>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpa025
            #add-point:BEFORE FIELD gzpa025
            {<point name="construct.b.gzpa025" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpa025
            
            #add-point:AFTER FIELD gzpa025
            {<point name="construct.a.gzpa025" />}
            #END add-point
            
 
         #Ctrlp:construct.c.gzpa025
#         ON ACTION controlp INFIELD gzpa025
            #add-point:ON ACTION controlp INFIELD gzpa025
            {<point name="construct.c.gzpa025" />}
            #END add-point
 
         #----<<gzpa026>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpa026
            #add-point:BEFORE FIELD gzpa026
            {<point name="construct.b.gzpa026" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpa026
            
            #add-point:AFTER FIELD gzpa026
            {<point name="construct.a.gzpa026" />}
            #END add-point
            
 
         #Ctrlp:construct.c.gzpa026
#         ON ACTION controlp INFIELD gzpa026
            #add-point:ON ACTION controlp INFIELD gzpa026
            {<point name="construct.c.gzpa026" />}
            #END add-point
 
         #----<<gzpa027>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpa027
            #add-point:BEFORE FIELD gzpa027
            {<point name="construct.b.gzpa027" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpa027
            
            #add-point:AFTER FIELD gzpa027
            {<point name="construct.a.gzpa027" />}
            #END add-point
            
 
         #Ctrlp:construct.c.gzpa027
#         ON ACTION controlp INFIELD gzpa027
            #add-point:ON ACTION controlp INFIELD gzpa027
            {<point name="construct.c.gzpa027" />}
            #END add-point
 
         #----<<gzpa028>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpa028
            #add-point:BEFORE FIELD gzpa028
            {<point name="construct.b.gzpa028" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpa028
            
            #add-point:AFTER FIELD gzpa028
            {<point name="construct.a.gzpa028" />}
            #END add-point
            
 
         #Ctrlp:construct.c.gzpa028
#         ON ACTION controlp INFIELD gzpa028
            #add-point:ON ACTION controlp INFIELD gzpa028
            {<point name="construct.c.gzpa028" />}
            #END add-point
 
         #----<<gzpa029>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpa029
            #add-point:BEFORE FIELD gzpa029
            {<point name="construct.b.gzpa029" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpa029
            
            #add-point:AFTER FIELD gzpa029
            {<point name="construct.a.gzpa029" />}
            #END add-point
            
 
         #Ctrlp:construct.c.gzpa029
#         ON ACTION controlp INFIELD gzpa029
            #add-point:ON ACTION controlp INFIELD gzpa029
            {<point name="construct.c.gzpa029" />}
            #END add-point
 
         #----<<gzpa030>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpa030
            #add-point:BEFORE FIELD gzpa030
            {<point name="construct.b.gzpa030" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpa030
            
            #add-point:AFTER FIELD gzpa030
            {<point name="construct.a.gzpa030" />}
            #END add-point
            
 
         #Ctrlp:construct.c.gzpa030
#         ON ACTION controlp INFIELD gzpa030
            #add-point:ON ACTION controlp INFIELD gzpa030
            {<point name="construct.c.gzpa030" />}
            #END add-point
 
         #----<<gzpa031>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpa031
            #add-point:BEFORE FIELD gzpa031
            {<point name="construct.b.gzpa031" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpa031
            
            #add-point:AFTER FIELD gzpa031
            {<point name="construct.a.gzpa031" />}
            #END add-point
            
 
         #Ctrlp:construct.c.gzpa031
#         ON ACTION controlp INFIELD gzpa031
            #add-point:ON ACTION controlp INFIELD gzpa031
            {<point name="construct.c.gzpa031" />}
            #END add-point
 
         #----<<gzpastus>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpastus
            #add-point:BEFORE FIELD gzpastus
            {<point name="construct.b.gzpastus" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpastus
            
            #add-point:AFTER FIELD gzpastus
            {<point name="construct.a.gzpastus" />}
            #END add-point
            
 
         #Ctrlp:construct.c.gzpastus
#         ON ACTION controlp INFIELD gzpastus
            #add-point:ON ACTION controlp INFIELD gzpastus
            {<point name="construct.c.gzpastus" />}
            #END add-point
 
         #----<<gzpaownid>>----
         #Ctrlp:construct.c.gzpaownid
         ON ACTION controlp INFIELD gzpaownid
            #add-point:ON ACTION controlp INFIELD gzpaownid
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzpaownid  #顯示到畫面上

            NEXT FIELD gzpaownid                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD gzpaownid
            #add-point:BEFORE FIELD gzpaownid
            {<point name="construct.b.gzpaownid" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpaownid
            
            #add-point:AFTER FIELD gzpaownid
            {<point name="construct.a.gzpaownid" />}
            #END add-point
            
 
         #----<<gzpaowndp>>----
         #Ctrlp:construct.c.gzpaowndp
         ON ACTION controlp INFIELD gzpaowndp
            #add-point:ON ACTION controlp INFIELD gzpaowndp
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooea001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzpaowndp  #顯示到畫面上

            NEXT FIELD gzpaowndp                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD gzpaowndp
            #add-point:BEFORE FIELD gzpaowndp
            {<point name="construct.b.gzpaowndp" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpaowndp
            
            #add-point:AFTER FIELD gzpaowndp
            {<point name="construct.a.gzpaowndp" />}
            #END add-point
            
 
         #----<<gzpacrtid>>----
         #Ctrlp:construct.c.gzpacrtid
         ON ACTION controlp INFIELD gzpacrtid
            #add-point:ON ACTION controlp INFIELD gzpacrtid
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzpacrtid  #顯示到畫面上

            NEXT FIELD gzpacrtid                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD gzpacrtid
            #add-point:BEFORE FIELD gzpacrtid
            {<point name="construct.b.gzpacrtid" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpacrtid
            
            #add-point:AFTER FIELD gzpacrtid
            {<point name="construct.a.gzpacrtid" />}
            #END add-point
            
 
         #----<<gzpacrtdp>>----
         #Ctrlp:construct.c.gzpacrtdp
         ON ACTION controlp INFIELD gzpacrtdp
            #add-point:ON ACTION controlp INFIELD gzpacrtdp
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooea001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzpacrtdp  #顯示到畫面上

            NEXT FIELD gzpacrtdp                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD gzpacrtdp
            #add-point:BEFORE FIELD gzpacrtdp
            {<point name="construct.b.gzpacrtdp" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpacrtdp
            
            #add-point:AFTER FIELD gzpacrtdp
            {<point name="construct.a.gzpacrtdp" />}
            #END add-point
            
 
         #----<<gzpacrtdt>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpacrtdt
            #add-point:BEFORE FIELD gzpacrtdt
            {<point name="construct.b.gzpacrtdt" />}
            #END add-point
 
         #----<<gzpamodid>>----
         #Ctrlp:construct.c.gzpamodid
         ON ACTION controlp INFIELD gzpamodid
            #add-point:ON ACTION controlp INFIELD gzpamodid
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzpamodid  #顯示到畫面上

            NEXT FIELD gzpamodid                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD gzpamodid
            #add-point:BEFORE FIELD gzpamodid
            {<point name="construct.b.gzpamodid" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpamodid
            
            #add-point:AFTER FIELD gzpamodid
            {<point name="construct.a.gzpamodid" />}
            #END add-point
            
 
         #----<<gzpamoddt>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpamoddt
            #add-point:BEFORE FIELD gzpamoddt
            {<point name="construct.b.gzpamoddt" />}
            #END add-point
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON gzpb002,gzpb003,gzpb004,gzpb005
           FROM s_detail1[1].gzpb002,s_detail1[1].gzpb003,s_detail1[1].gzpb004,s_detail1[1].gzpb005
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct
            {<point name="cs.body.before_construct"/>}
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
       #---------------------<  Detail: page1  >---------------------
         #----<<gzpb002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpb002
            #add-point:BEFORE FIELD gzpb002
            {<point name="construct.b.page1.gzpb002" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpb002
            
            #add-point:AFTER FIELD gzpb002
            {<point name="construct.a.page1.gzpb002" />}
            #END add-point
            
 
         #Ctrlp:construct.c.page1.gzpb002
#         ON ACTION controlp INFIELD gzpb002
            #add-point:ON ACTION controlp INFIELD gzpb002
            {<point name="construct.c.page1.gzpb002" />}
            #END add-point
 
         #----<<gzpb003>>----
         #Ctrlp:construct.c.page1.gzpb003
         ON ACTION controlp INFIELD gzpb003
            #add-point:ON ACTION controlp INFIELD gzpb003
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_gzpb001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzpb003  #顯示到畫面上

            NEXT FIELD gzpb003                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD gzpb003
            #add-point:BEFORE FIELD gzpb003
            {<point name="construct.b.page1.gzpb003" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpb003
            
            #add-point:AFTER FIELD gzpb003
            {<point name="construct.a.page1.gzpb003" />}
            #END add-point
            
 
         #----<<gzpb004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpb004
            #add-point:BEFORE FIELD gzpb004
            {<point name="construct.b.page1.gzpb004" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpb004
            
            #add-point:AFTER FIELD gzpb004
            {<point name="construct.a.page1.gzpb004" />}
            #END add-point
            
 
         #Ctrlp:construct.c.page1.gzpb004
#         ON ACTION controlp INFIELD gzpb004
            #add-point:ON ACTION controlp INFIELD gzpb004
            {<point name="construct.c.page1.gzpb004" />}
            #END add-point
 
         #----<<gzpb005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpb005
            #add-point:BEFORE FIELD gzpb005
            {<point name="construct.b.page1.gzpb005" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpb005
            
            #add-point:AFTER FIELD gzpb005
            {<point name="construct.a.page1.gzpb005" />}
            #END add-point
            
 
         #Ctrlp:construct.c.page1.gzpb005
#         ON ACTION controlp INFIELD gzpb005
            #add-point:ON ACTION controlp INFIELD gzpb005
            {<point name="construct.c.page1.gzpb005" />}
            #END add-point
 
   
       
      END CONSTRUCT
      
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令)
      {<point name="cs.add_cs"/>}
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog
         {<point name="cs.b_dialog"/>}
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
   
   #組合g_wc2
   LET g_wc2 = g_wc2_table1
 
 
 
   
   #add-point:cs段結束前
   {<point name="cs.after_construct"/>}
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="azzi950.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION azzi950_filter()
   {<Local define>}
   {</Local define>}
   #add-point:filter段define
   {<point name="filter.define"/>}
   #end add-point   
 
   #切換畫面
   IF NOT g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",1)
      CALL gfrm_curr.setElementHidden("worksheet",0)
      LET g_main_hidden = 1
   END IF   
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON gzpa001,gzpa002,gzpa003,gzpa004,gzpa005
                          FROM s_browse[1].b_gzpa001,s_browse[1].b_gzpa002,s_browse[1].b_gzpa003,s_browse[1].b_gzpa004, 
                              s_browse[1].b_gzpa005
 
         BEFORE CONSTRUCT
               DISPLAY azzi950_filter_parser('gzpa001') TO s_browse[1].b_gzpa001
            DISPLAY azzi950_filter_parser('gzpa002') TO s_browse[1].b_gzpa002
            DISPLAY azzi950_filter_parser('gzpa003') TO s_browse[1].b_gzpa003
            DISPLAY azzi950_filter_parser('gzpa004') TO s_browse[1].b_gzpa004
            DISPLAY azzi950_filter_parser('gzpa005') TO s_browse[1].b_gzpa005
      
      END CONSTRUCT
 
      #add-point:filter段add_cs
      {<point name="filter.add_cs"/>}
      #end add-point
 
      BEFORE DIALOG
         #add-point:filter段b_dialog
         {<point name="filter.b_dialog"/>}
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
 
      CALL azzi950_filter_show('gzpa001')
   CALL azzi950_filter_show('gzpa002')
   CALL azzi950_filter_show('gzpa003')
   CALL azzi950_filter_show('gzpa004')
   CALL azzi950_filter_show('gzpa005')
 
END FUNCTION
 
{</section>}
 
{<section id="azzi950.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION azzi950_filter_parser(ps_field)
   {<Local define>}
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
   {</Local define>}
   #add-point:filter段define
   {<point name="filter_parser.define"/>}
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
 
{<section id="azzi950.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION azzi950_filter_show(ps_field)
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
   LET ls_condition = azzi950_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="azzi950.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION azzi950_query()
   {<Local define>}
   DEFINE ls_wc STRING
   {</Local define>}
   #add-point:query段define
   {<point name="query.define"/>}
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
   CALL g_gzpb_d.clear()
 
   
   #add-point:query段other
   {<point name="query.other"/>}
   #end add-point   
   
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL azzi950_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      CALL azzi950_browser_fill("")
      CALL azzi950_fetch("")
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
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
      CALL azzi950_filter_show('gzpa001')
   CALL azzi950_filter_show('gzpa002')
   CALL azzi950_filter_show('gzpa003')
   CALL azzi950_filter_show('gzpa004')
   CALL azzi950_filter_show('gzpa005')
   CALL azzi950_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      CALL cl_err("","-100",1)
   ELSE
      CALL azzi950_fetch("F") 
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="azzi950.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION azzi950_fetch(p_flag)
   {<Local define>}
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   {</Local define>}
   #add-point:fetch段define
   {<point name="fetch.define"/>}
   #end add-point    
   
   IF g_browser_cnt = 0 THEN
      RETURN
   END IF
   
   CASE p_flag
      WHEN 'F' LET g_current_idx = 1
      WHEN 'L' LET g_current_idx = g_header_cnt        
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
   
   
   CALL g_curr_diag.setCurrentRow("s_browse", g_current_idx) #設定browse 索引
   
   LET g_detail_cnt = g_header_cnt                  
   
   #單身總筆數顯示
   #LET g_detail_idx = 1
   IF g_detail_cnt > 0 THEN
      #LET g_detail_idx = 1
      DISPLAY g_detail_idx TO FORMONLY.idx  
   ELSE
      LET g_detail_idx = 0
      DISPLAY ' ' TO FORMONLY.idx    
   END IF
   
   #瀏覽頁筆數顯示
   LET g_browser_idx = g_pagestart+g_current_idx-1
   DISPLAY g_browser_idx TO FORMONLY.b_index   #當下筆數
   DISPLAY g_browser_idx TO FORMONLY.h_index   #當下筆數
   
   CALL cl_navigator_setting( g_current_idx, g_browser_cnt )
   
   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF
   
   #超出範圍
   IF g_current_idx > g_browser.getLength() THEN
      LET g_current_idx = g_browser.getLength()
   END IF
   
   LET g_gzpa_m.gzpa001 = g_browser[g_current_idx].b_gzpa001
 
   
   #重讀DB,因TEMP有不被更新特性
    SELECT UNIQUE gzpa001,gzpa004,gzpa002,gzpa005,gzpa003,gzpa006,gzpa007,gzpa008,gzpa010,gzpa012,gzpa015, 
        gzpa016,gzpa017,gzpa018,gzpa019,gzpa020,gzpa021,gzpa022,gzpa023,gzpa024,gzpa025,gzpa026,gzpa027, 
        gzpa028,gzpa029,gzpa030,gzpa031,gzpastus,gzpaownid,gzpaowndp,gzpacrtid,gzpacrtdp,gzpacrtdt,gzpamodid, 
        gzpamoddt
 INTO g_gzpa_m.gzpa001,g_gzpa_m.gzpa004,g_gzpa_m.gzpa002,g_gzpa_m.gzpa005,g_gzpa_m.gzpa003,g_gzpa_m.gzpa006, 
     g_gzpa_m.gzpa007,g_gzpa_m.gzpa008,g_gzpa_m.gzpa010,g_gzpa_m.gzpa012,g_gzpa_m.gzpa015,g_gzpa_m.gzpa016, 
     g_gzpa_m.gzpa017,g_gzpa_m.gzpa018,g_gzpa_m.gzpa019,g_gzpa_m.gzpa020,g_gzpa_m.gzpa021,g_gzpa_m.gzpa022, 
     g_gzpa_m.gzpa023,g_gzpa_m.gzpa024,g_gzpa_m.gzpa025,g_gzpa_m.gzpa026,g_gzpa_m.gzpa027,g_gzpa_m.gzpa028, 
     g_gzpa_m.gzpa029,g_gzpa_m.gzpa030,g_gzpa_m.gzpa031,g_gzpa_m.gzpastus,g_gzpa_m.gzpaownid,g_gzpa_m.gzpaowndp, 
     g_gzpa_m.gzpacrtid,g_gzpa_m.gzpacrtdp,g_gzpa_m.gzpacrtdt,g_gzpa_m.gzpamodid,g_gzpa_m.gzpamoddt
 FROM gzpa_t
 WHERE gzpaent = g_enterprise AND gzpa001 = g_gzpa_m.gzpa001
   IF SQLCA.sqlcode THEN
      CALL cl_err("gzpa_t",SQLCA.sqlcode,1)
      INITIALIZE g_gzpa_m.* TO NULL
      RETURN
   END IF
   
   #add-point:fetch段action控制
   {<point name="fetch.action_control"/>}
   #end add-point  
   
   
   
   #add-point:fetch結束前
   {<point name="fetch.after" />}
   #end add-point
   
   #LET g_data_owner =       
   #LET g_data_group =   
   
   #重新顯示   
   CALL azzi950_show()
 
END FUNCTION
 
{</section>}
 
{<section id="azzi950.insert" >}
#+ 資料新增
PRIVATE FUNCTION azzi950_insert()
   #add-point:insert段define
   {<point name="insert.define"/>}
   #end add-point    
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_gzpb_d.clear()   
 
 
   INITIALIZE g_gzpa_m.* LIKE gzpa_t.*             #DEFAULT 設定
   
   LET g_gzpa001_t = NULL
 
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #此段落由子樣板a14產生    
      LET g_gzpa_m.gzpaownid = g_user
      LET g_gzpa_m.gzpaowndp = g_dept
      LET g_gzpa_m.gzpacrtid = g_user
      LET g_gzpa_m.gzpacrtdp = g_dept 
      LET g_gzpa_m.gzpacrtdt = cl_get_current()
      LET g_gzpa_m.gzpamodid = ""
      LET g_gzpa_m.gzpamoddt = ""
      #LET g_gzpa_m.gzpastus = ""
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_gzpa_m.gzpa008 = "N"
      LET g_gzpa_m.gzpa010 = "N"
      LET g_gzpa_m.gzpa012 = "N"
 
  
      #add-point:單頭預設值
      {<point name="insert.default"/>}
      #end add-point 
     
      CALL azzi950_input("a")
      
      #add-point:單頭輸入後
      {<point name="insert.after_insert"/>}
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_gzpa_m.* = g_gzpa_m_t.*
         CALL azzi950_show()
         CALL cl_err('',9001,0)
         CALL s_transaction_end('N','0')
         EXIT WHILE
      END IF
      
      CALL g_gzpb_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   LET g_state = "Y"
   
   LET g_gzpa001_t = g_gzpa_m.gzpa001
 
   
   LET g_wc = g_wc,  
              " OR ( gzpaent = '" ||g_enterprise|| "' AND",
              " gzpa001 = '", g_gzpa_m.gzpa001 CLIPPED, "' "
 
              , ") "
   
   CLOSE azzi950_cl
   
END FUNCTION
 
{</section>}
 
{<section id="azzi950.modify" >}
#+ 資料修改
PRIVATE FUNCTION azzi950_modify()
   {<Local define>}
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   {</Local define>}
   #add-point:modify段define
   {<point name="modify.define"/>}
   #end add-point    
   
   IF g_gzpa_m.gzpa001 IS NULL
 
   THEN
      CALL cl_err("","std-00003",0)
      RETURN
   END IF
   
    SELECT UNIQUE gzpa001,gzpa004,gzpa002,gzpa005,gzpa003,gzpa006,gzpa007,gzpa008,gzpa010,gzpa012,gzpa015, 
        gzpa016,gzpa017,gzpa018,gzpa019,gzpa020,gzpa021,gzpa022,gzpa023,gzpa024,gzpa025,gzpa026,gzpa027, 
        gzpa028,gzpa029,gzpa030,gzpa031,gzpastus,gzpaownid,gzpaowndp,gzpacrtid,gzpacrtdp,gzpacrtdt,gzpamodid, 
        gzpamoddt
 INTO g_gzpa_m.gzpa001,g_gzpa_m.gzpa004,g_gzpa_m.gzpa002,g_gzpa_m.gzpa005,g_gzpa_m.gzpa003,g_gzpa_m.gzpa006, 
     g_gzpa_m.gzpa007,g_gzpa_m.gzpa008,g_gzpa_m.gzpa010,g_gzpa_m.gzpa012,g_gzpa_m.gzpa015,g_gzpa_m.gzpa016, 
     g_gzpa_m.gzpa017,g_gzpa_m.gzpa018,g_gzpa_m.gzpa019,g_gzpa_m.gzpa020,g_gzpa_m.gzpa021,g_gzpa_m.gzpa022, 
     g_gzpa_m.gzpa023,g_gzpa_m.gzpa024,g_gzpa_m.gzpa025,g_gzpa_m.gzpa026,g_gzpa_m.gzpa027,g_gzpa_m.gzpa028, 
     g_gzpa_m.gzpa029,g_gzpa_m.gzpa030,g_gzpa_m.gzpa031,g_gzpa_m.gzpastus,g_gzpa_m.gzpaownid,g_gzpa_m.gzpaowndp, 
     g_gzpa_m.gzpacrtid,g_gzpa_m.gzpacrtdp,g_gzpa_m.gzpacrtdt,g_gzpa_m.gzpamodid,g_gzpa_m.gzpamoddt
 FROM gzpa_t
 WHERE gzpaent = g_enterprise AND gzpa001 = g_gzpa_m.gzpa001
 
   ERROR ""
  
   LET g_gzpa001_t = g_gzpa_m.gzpa001
 
   CALL s_transaction_begin()
   
   OPEN azzi950_cl USING g_enterprise,g_gzpa_m.gzpa001
 
   IF STATUS THEN
      CALL cl_err("OPEN azzi950_cl:", STATUS, 1)
      CLOSE azzi950_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #鎖住將被更改或取消的資料
   FETCH azzi950_cl INTO g_gzpa_m.gzpa001,g_gzpa_m.gzpa004,g_gzpa_m.gzpa002,g_gzpa_m.gzpa005,g_gzpa_m.gzpa003, 
       g_gzpa_m.gzpa006,g_gzpa_m.gzpa007,g_gzpa_m.gzpa008,g_gzpa_m.m01,g_gzpa_m.m02,g_gzpa_m.m03,g_gzpa_m.m04, 
       g_gzpa_m.m05,g_gzpa_m.m06,g_gzpa_m.m07,g_gzpa_m.m08,g_gzpa_m.m09,g_gzpa_m.m10,g_gzpa_m.m11,g_gzpa_m.m12, 
       g_gzpa_m.gzpa010,g_gzpa_m.wk1,g_gzpa_m.wk2,g_gzpa_m.wk3,g_gzpa_m.wk4,g_gzpa_m.wk5,g_gzpa_m.gzpa012, 
       g_gzpa_m.wd0,g_gzpa_m.wd1,g_gzpa_m.wd2,g_gzpa_m.wd3,g_gzpa_m.wd4,g_gzpa_m.wd5,g_gzpa_m.wd6,g_gzpa_m.d01, 
       g_gzpa_m.d02,g_gzpa_m.d03,g_gzpa_m.d04,g_gzpa_m.d05,g_gzpa_m.d06,g_gzpa_m.d07,g_gzpa_m.d08,g_gzpa_m.d09, 
       g_gzpa_m.d10,g_gzpa_m.d11,g_gzpa_m.d12,g_gzpa_m.d13,g_gzpa_m.d14,g_gzpa_m.d15,g_gzpa_m.d16,g_gzpa_m.d17, 
       g_gzpa_m.d18,g_gzpa_m.d19,g_gzpa_m.d20,g_gzpa_m.d21,g_gzpa_m.d22,g_gzpa_m.d23,g_gzpa_m.d24,g_gzpa_m.d25, 
       g_gzpa_m.d26,g_gzpa_m.d27,g_gzpa_m.d28,g_gzpa_m.d29,g_gzpa_m.d30,g_gzpa_m.d31,g_gzpa_m.den,g_gzpa_m.gzpa015, 
       g_gzpa_m.gzpa016,g_gzpa_m.sc1,g_gzpa_m.gzpa017,g_gzpa_m.gzpa018,g_gzpa_m.gzpa019,g_gzpa_m.gzpa020, 
       g_gzpa_m.sc2,g_gzpa_m.gzpa021,g_gzpa_m.gzpa022,g_gzpa_m.gzpa023,g_gzpa_m.gzpa024,g_gzpa_m.sc3, 
       g_gzpa_m.gzpa025,g_gzpa_m.gzpa026,g_gzpa_m.gzpa027,g_gzpa_m.gzpa028,g_gzpa_m.gzpa029,g_gzpa_m.gzpa030, 
       g_gzpa_m.gzpa031,g_gzpa_m.gzpastus,g_gzpa_m.gzpaownid,g_gzpa_m.gzpaownid_desc,g_gzpa_m.gzpaowndp, 
       g_gzpa_m.gzpaowndp_desc,g_gzpa_m.gzpacrtid,g_gzpa_m.gzpacrtid_desc,g_gzpa_m.gzpacrtdp,g_gzpa_m.gzpacrtdp_desc, 
       g_gzpa_m.gzpacrtdt,g_gzpa_m.gzpamodid,g_gzpa_m.gzpamodid_desc,g_gzpa_m.gzpamoddt,g_gzpa_m.gzpe003, 
       g_gzpa_m.gzpe004,g_gzpa_m.gzpe004_desc,g_gzpa_m.addr,g_gzpa_m.gzpe005
 
   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      CALL cl_err(g_gzpa_m.gzpa001,SQLCA.sqlcode,0)
      CLOSE azzi950_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   
 
   CALL azzi950_show()
   WHILE TRUE
      LET g_gzpa001_t = g_gzpa_m.gzpa001
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_gzpa_m.gzpamodid = g_user 
LET g_gzpa_m.gzpamoddt = cl_get_current()
 
      
      #add-point:modify段修改前
      {<point name="modify.before_input"/>}
      #end add-point
      
      CALL azzi950_input("u")     #欄位更改
 
      #add-point:modify段修改後
      {<point name="modify.after_input"/>}
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_gzpa_m.* = g_gzpa_m_t.*
         CALL azzi950_show()
         CALL cl_err('',9001,0)
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更
      IF g_gzpa_m.gzpa001 != g_gzpa001_t 
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前
         {<point name="modify.body.b_fk_update" mark="Y"/>}
         #end add-point
         
         #更新單身key值
         UPDATE gzpb_t SET gzpb001 = g_gzpa_m.gzpa001
 
          WHERE gzpbent = g_enterprise AND gzpb001 = g_gzpa001_t
 
            
         #add-point:單身fk修改中
         {<point name="modify.body.m_fk_update"/>}
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               CALL cl_err("gzpb_t","std-00009",1)
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
            WHEN SQLCA.sqlcode #其他錯誤
               CALL cl_err("gzpb_t",SQLCA.sqlcode,1)  
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
         END CASE
         
         #add-point:單身fk修改後
         {<point name="modify.body.a_fk_update"/>}
         #end add-point
         
 
         
 
         
         #UPDATE 多語言table key值
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #修改歷程記錄
   IF NOT cl_log_modified_record(g_gzpa_m.gzpa001,g_site) THEN 
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE azzi950_cl
   CALL s_transaction_end('Y','0')
 
   #流程通知預埋點-U
   CALL cl_flow_notify(g_gzpa_m.gzpa001,'U')
 
END FUNCTION   
 
{</section>}
 
{<section id="azzi950.input" >}
#+ 資料輸入
PRIVATE FUNCTION azzi950_input(p_cmd)
   {<Local define>}
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd_t               LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_n                   LIKE type_t.num5                #檢查重複用  
   DEFINE  l_cnt                 LIKE type_t.num5                #檢查重複用  
   DEFINE  l_lock_sw             LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert        LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete        LIKE type_t.num5                #可刪除否  
   DEFINE  l_count               LIKE type_t.num5
   DEFINE  l_i                   LIKE type_t.num5
   DEFINE  l_insert              BOOLEAN
   DEFINE  ls_return             STRING
   DEFINE  l_var_keys            DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys          DYNAMIC ARRAY OF STRING
   DEFINE  l_vars                DYNAMIC ARRAY OF STRING
   DEFINE  l_fields              DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak        DYNAMIC ARRAY OF STRING
   DEFINE  lb_reproduce          BOOLEAN
   DEFINE  li_reproduce          LIKE type_t.num5
   DEFINE  li_reproduce_target   LIKE type_t.num5
   {</Local define>}
   #add-point:input段define
   DEFINE ld_arr DYNAMIC ARRAY OF RECORD 
       lc_gzzc002  LIKE gzzc_t.gzzc002,     #參數序號
       lc_value    LIKE type_t.chr20,       #參數數值
       li_entry    LIKE type_t.num5,        #是否可以輸入
       li_return   LIKE type_t.num5         #是否需要回傳
    END RECORD  
   DEFINE ls_str STRING 
   DEFINE li_rtn LIKE type_t.num5
   #end add-point  
 
   #先做狀態判定
   IF p_cmd = 'r' THEN
      LET l_cmd_t = 'r'
      LET p_cmd   = 'a'
   ELSE
      LET l_cmd_t = p_cmd
   END IF   
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql
   {<point name="input.define_sql" mark="Y"/>}
   #end add-point 
   LET g_forupd_sql = "SELECT gzpb002,gzpb003,'',gzpb004,gzpb005 FROM gzpb_t WHERE gzpbent=? AND gzpb001=?  
       AND gzpb002=? FOR UPDATE"
   #add-point:input段define_sql
   {<point name="input.after_define_sql"/>}
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE azzi950_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql
   {<point name="input.other_sql"/>}
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL azzi950_set_entry(p_cmd)
   #add-point:set_entry後
   {<point name="input.after_set_entry"/>}
   #end add-point
   CALL azzi950_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_gzpa_m.gzpa001,g_gzpa_m.gzpa004,g_gzpa_m.gzpa002,g_gzpa_m.gzpa005,g_gzpa_m.gzpa003, 
       g_gzpa_m.gzpa006,g_gzpa_m.gzpa007,g_gzpa_m.gzpa008,g_gzpa_m.gzpa010,g_gzpa_m.gzpa012,g_gzpa_m.gzpa015, 
       g_gzpa_m.gzpa016,g_gzpa_m.gzpa017,g_gzpa_m.gzpa018,g_gzpa_m.gzpa019,g_gzpa_m.gzpa020,g_gzpa_m.gzpa021, 
       g_gzpa_m.gzpa022,g_gzpa_m.gzpa023,g_gzpa_m.gzpa024,g_gzpa_m.gzpa025,g_gzpa_m.gzpa026,g_gzpa_m.gzpa027, 
       g_gzpa_m.gzpa028,g_gzpa_m.gzpa029,g_gzpa_m.gzpa030,g_gzpa_m.gzpa031,g_gzpa_m.gzpastus
   
   LET lb_reproduce = FALSE
   
   #add-point:資料輸入前
   {<point name="input.before_input"/>}
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
 
{</section>}
 
{<section id="azzi950.input.head" >}
      #單頭段
      INPUT BY NAME g_gzpa_m.gzpa001,g_gzpa_m.gzpa004,g_gzpa_m.gzpa002,g_gzpa_m.gzpa005,g_gzpa_m.gzpa003, 
          g_gzpa_m.gzpa006,g_gzpa_m.gzpa007,g_gzpa_m.gzpa008,g_gzpa_m.gzpa010,g_gzpa_m.gzpa012,g_gzpa_m.gzpa015, 
          g_gzpa_m.gzpa016,g_gzpa_m.gzpa017,g_gzpa_m.gzpa018,g_gzpa_m.gzpa019,g_gzpa_m.gzpa020,g_gzpa_m.gzpa021, 
          g_gzpa_m.gzpa022,g_gzpa_m.gzpa023,g_gzpa_m.gzpa024,g_gzpa_m.gzpa025,g_gzpa_m.gzpa026,g_gzpa_m.gzpa027, 
          g_gzpa_m.gzpa028,g_gzpa_m.gzpa029,g_gzpa_m.gzpa030,g_gzpa_m.gzpa031,g_gzpa_m.gzpastus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #add-point:資料輸入前
            {<point name="input.m.before_input"/>}
            #end add-point
 
         #---------------------------<  Master  >---------------------------
         #----<<gzpa001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpa001
            #add-point:BEFORE FIELD gzpa001
            {<point name="input.b.gzpa001" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpa001
            
            #add-point:AFTER FIELD gzpa001
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_gzpa_m.gzpa001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_gzpa_m.gzpa001 != g_gzpa001_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gzpa_t WHERE "||"gzpaent = '" ||g_enterprise|| "' AND "||"gzpa001 = '"||g_gzpa_m.gzpa001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE gzpa001
            #add-point:ON CHANGE gzpa001
            {<point name="input.g.gzpa001" />}
            #END add-point
 
         #----<<gzpa004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpa004
            #add-point:BEFORE FIELD gzpa004
            {<point name="input.b.gzpa004" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpa004
            
            #add-point:AFTER FIELD gzpa004
            {<point name="input.a.gzpa004" />}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE gzpa004
            #add-point:ON CHANGE gzpa004
            {<point name="input.g.gzpa004" />}
            #END add-point
 
         #----<<gzpa002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpa002
            #add-point:BEFORE FIELD gzpa002
            {<point name="input.b.gzpa002" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpa002
            
            #add-point:AFTER FIELD gzpa002
            {<point name="input.a.gzpa002" />}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE gzpa002
            #add-point:ON CHANGE gzpa002
            {<point name="input.g.gzpa002" />}
            #END add-point
 
         #----<<gzpa005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpa005
            #add-point:BEFORE FIELD gzpa005
            {<point name="input.b.gzpa005" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpa005
            
            #add-point:AFTER FIELD gzpa005
            {<point name="input.a.gzpa005" />}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE gzpa005
            #add-point:ON CHANGE gzpa005
            {<point name="input.g.gzpa005" />}
            #END add-point
 
         #----<<gzpa003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpa003
            #add-point:BEFORE FIELD gzpa003
            {<point name="input.b.gzpa003" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpa003
            
            #add-point:AFTER FIELD gzpa003
            {<point name="input.a.gzpa003" />}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE gzpa003
            #add-point:ON CHANGE gzpa003
            {<point name="input.g.gzpa003" />}
            #END add-point
 
         #----<<gzpa006>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpa006
            #add-point:BEFORE FIELD gzpa006
            {<point name="input.b.gzpa006" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpa006
            
            #add-point:AFTER FIELD gzpa006
            {<point name="input.a.gzpa006" />}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE gzpa006
            #add-point:ON CHANGE gzpa006
            {<point name="input.g.gzpa006" />}
            #END add-point
 
         #----<<gzpa007>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpa007
            #add-point:BEFORE FIELD gzpa007
            {<point name="input.b.gzpa007" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpa007
            
            #add-point:AFTER FIELD gzpa007
            {<point name="input.a.gzpa007" />}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE gzpa007
            #add-point:ON CHANGE gzpa007
            {<point name="input.g.gzpa007" />}
            #END add-point
 
         #----<<gzpa008>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpa008
            #add-point:BEFORE FIELD gzpa008
            {<point name="input.b.gzpa008" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpa008
            
            #add-point:AFTER FIELD gzpa008
            {<point name="input.a.gzpa008" />}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE gzpa008
            #add-point:ON CHANGE gzpa008
            {<point name="input.g.gzpa008" />}
            #END add-point
 
         #----<<gzpa010>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpa010
            #add-point:BEFORE FIELD gzpa010
            {<point name="input.b.gzpa010" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpa010
            
            #add-point:AFTER FIELD gzpa010
            {<point name="input.a.gzpa010" />}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE gzpa010
            #add-point:ON CHANGE gzpa010
            {<point name="input.g.gzpa010" />}
            #END add-point
 
         #----<<gzpa012>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpa012
            #add-point:BEFORE FIELD gzpa012
            {<point name="input.b.gzpa012" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpa012
            
            #add-point:AFTER FIELD gzpa012
            {<point name="input.a.gzpa012" />}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE gzpa012
            #add-point:ON CHANGE gzpa012
            {<point name="input.g.gzpa012" />}
            #END add-point
 
         #----<<gzpa015>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpa015
            #add-point:BEFORE FIELD gzpa015
            {<point name="input.b.gzpa015" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpa015
            
            #add-point:AFTER FIELD gzpa015
            {<point name="input.a.gzpa015" />}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE gzpa015
            #add-point:ON CHANGE gzpa015
            {<point name="input.g.gzpa015" />}
            #END add-point
 
         #----<<gzpa016>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpa016
            #add-point:BEFORE FIELD gzpa016
            {<point name="input.b.gzpa016" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpa016
            
            #add-point:AFTER FIELD gzpa016
            {<point name="input.a.gzpa016" />}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE gzpa016
            #add-point:ON CHANGE gzpa016
            {<point name="input.g.gzpa016" />}
            #END add-point
 
         #----<<gzpa017>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpa017
            #add-point:BEFORE FIELD gzpa017
            {<point name="input.b.gzpa017" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpa017
            
            #add-point:AFTER FIELD gzpa017
            {<point name="input.a.gzpa017" />}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE gzpa017
            #add-point:ON CHANGE gzpa017
            {<point name="input.g.gzpa017" />}
            #END add-point
 
         #----<<gzpa018>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpa018
            #add-point:BEFORE FIELD gzpa018
            {<point name="input.b.gzpa018" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpa018
            
            #add-point:AFTER FIELD gzpa018
            {<point name="input.a.gzpa018" />}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE gzpa018
            #add-point:ON CHANGE gzpa018
            {<point name="input.g.gzpa018" />}
            #END add-point
 
         #----<<gzpa019>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpa019
            #add-point:BEFORE FIELD gzpa019
            {<point name="input.b.gzpa019" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpa019
            
            #add-point:AFTER FIELD gzpa019
            {<point name="input.a.gzpa019" />}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE gzpa019
            #add-point:ON CHANGE gzpa019
            {<point name="input.g.gzpa019" />}
            #END add-point
 
         #----<<gzpa020>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpa020
            #add-point:BEFORE FIELD gzpa020
            {<point name="input.b.gzpa020" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpa020
            
            #add-point:AFTER FIELD gzpa020
            {<point name="input.a.gzpa020" />}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE gzpa020
            #add-point:ON CHANGE gzpa020
            {<point name="input.g.gzpa020" />}
            #END add-point
 
         #----<<gzpa021>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpa021
            #add-point:BEFORE FIELD gzpa021
            {<point name="input.b.gzpa021" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpa021
            
            #add-point:AFTER FIELD gzpa021
            {<point name="input.a.gzpa021" />}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE gzpa021
            #add-point:ON CHANGE gzpa021
            {<point name="input.g.gzpa021" />}
            #END add-point
 
         #----<<gzpa022>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpa022
            #add-point:BEFORE FIELD gzpa022
            {<point name="input.b.gzpa022" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpa022
            
            #add-point:AFTER FIELD gzpa022
            {<point name="input.a.gzpa022" />}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE gzpa022
            #add-point:ON CHANGE gzpa022
            {<point name="input.g.gzpa022" />}
            #END add-point
 
         #----<<gzpa023>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpa023
            #add-point:BEFORE FIELD gzpa023
            {<point name="input.b.gzpa023" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpa023
            
            #add-point:AFTER FIELD gzpa023
            {<point name="input.a.gzpa023" />}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE gzpa023
            #add-point:ON CHANGE gzpa023
            {<point name="input.g.gzpa023" />}
            #END add-point
 
         #----<<gzpa024>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpa024
            #add-point:BEFORE FIELD gzpa024
            {<point name="input.b.gzpa024" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpa024
            
            #add-point:AFTER FIELD gzpa024
            {<point name="input.a.gzpa024" />}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE gzpa024
            #add-point:ON CHANGE gzpa024
            {<point name="input.g.gzpa024" />}
            #END add-point
 
         #----<<gzpa025>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpa025
            #add-point:BEFORE FIELD gzpa025
            {<point name="input.b.gzpa025" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpa025
            
            #add-point:AFTER FIELD gzpa025
            {<point name="input.a.gzpa025" />}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE gzpa025
            #add-point:ON CHANGE gzpa025
            {<point name="input.g.gzpa025" />}
            #END add-point
 
         #----<<gzpa026>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpa026
            #add-point:BEFORE FIELD gzpa026
            {<point name="input.b.gzpa026" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpa026
            
            #add-point:AFTER FIELD gzpa026
            {<point name="input.a.gzpa026" />}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE gzpa026
            #add-point:ON CHANGE gzpa026
            {<point name="input.g.gzpa026" />}
            #END add-point
 
         #----<<gzpa027>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpa027
            #add-point:BEFORE FIELD gzpa027
            {<point name="input.b.gzpa027" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpa027
            
            #add-point:AFTER FIELD gzpa027
            {<point name="input.a.gzpa027" />}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE gzpa027
            #add-point:ON CHANGE gzpa027
            {<point name="input.g.gzpa027" />}
            #END add-point
 
         #----<<gzpa028>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpa028
            #add-point:BEFORE FIELD gzpa028
            {<point name="input.b.gzpa028" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpa028
            
            #add-point:AFTER FIELD gzpa028
            {<point name="input.a.gzpa028" />}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE gzpa028
            #add-point:ON CHANGE gzpa028
            {<point name="input.g.gzpa028" />}
            #END add-point
 
         #----<<gzpa029>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpa029
            #add-point:BEFORE FIELD gzpa029
            {<point name="input.b.gzpa029" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpa029
            
            #add-point:AFTER FIELD gzpa029
            {<point name="input.a.gzpa029" />}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE gzpa029
            #add-point:ON CHANGE gzpa029
            {<point name="input.g.gzpa029" />}
            #END add-point
 
         #----<<gzpa030>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpa030
            #add-point:BEFORE FIELD gzpa030
            {<point name="input.b.gzpa030" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpa030
            
            #add-point:AFTER FIELD gzpa030
            {<point name="input.a.gzpa030" />}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE gzpa030
            #add-point:ON CHANGE gzpa030
            {<point name="input.g.gzpa030" />}
            #END add-point
 
         #----<<gzpa031>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpa031
            #add-point:BEFORE FIELD gzpa031
            {<point name="input.b.gzpa031" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpa031
            
            #add-point:AFTER FIELD gzpa031
            {<point name="input.a.gzpa031" />}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE gzpa031
            #add-point:ON CHANGE gzpa031
            {<point name="input.g.gzpa031" />}
            #END add-point
 
         #----<<gzpastus>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpastus
            #add-point:BEFORE FIELD gzpastus
            {<point name="input.b.gzpastus" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpastus
            
            #add-point:AFTER FIELD gzpastus
            {<point name="input.a.gzpastus" />}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE gzpastus
            #add-point:ON CHANGE gzpastus
            {<point name="input.g.gzpastus" />}
            #END add-point
 
         #----<<gzpaownid>>----
         #----<<gzpaowndp>>----
         #----<<gzpacrtid>>----
         #----<<gzpacrtdp>>----
         #----<<gzpacrtdt>>----
         #----<<gzpamodid>>----
         #----<<gzpamoddt>>----
 #欄位檢查
         #---------------------------<  Master  >---------------------------
         #----<<gzpa001>>----
         #Ctrlp:input.c.gzpa001
#         ON ACTION controlp INFIELD gzpa001
            #add-point:ON ACTION controlp INFIELD gzpa001
            {<point name="input.c.gzpa001" />}
            #END add-point
 
         #----<<gzpa004>>----
         #Ctrlp:input.c.gzpa004
#         ON ACTION controlp INFIELD gzpa004
            #add-point:ON ACTION controlp INFIELD gzpa004
            {<point name="input.c.gzpa004" />}
            #END add-point
 
         #----<<gzpa002>>----
         #Ctrlp:input.c.gzpa002
#         ON ACTION controlp INFIELD gzpa002
            #add-point:ON ACTION controlp INFIELD gzpa002
            {<point name="input.c.gzpa002" />}
            #END add-point
 
         #----<<gzpa005>>----
         #Ctrlp:input.c.gzpa005
#         ON ACTION controlp INFIELD gzpa005
            #add-point:ON ACTION controlp INFIELD gzpa005
            {<point name="input.c.gzpa005" />}
            #END add-point
 
         #----<<gzpa003>>----
         #Ctrlp:input.c.gzpa003
#         ON ACTION controlp INFIELD gzpa003
            #add-point:ON ACTION controlp INFIELD gzpa003
            {<point name="input.c.gzpa003" />}
            #END add-point
 
         #----<<gzpa006>>----
         #Ctrlp:input.c.gzpa006
#         ON ACTION controlp INFIELD gzpa006
            #add-point:ON ACTION controlp INFIELD gzpa006
            {<point name="input.c.gzpa006" />}
            #END add-point
 
         #----<<gzpa007>>----
         #Ctrlp:input.c.gzpa007
#         ON ACTION controlp INFIELD gzpa007
            #add-point:ON ACTION controlp INFIELD gzpa007
            {<point name="input.c.gzpa007" />}
            #END add-point
 
         #----<<gzpa008>>----
         #Ctrlp:input.c.gzpa008
#         ON ACTION controlp INFIELD gzpa008
            #add-point:ON ACTION controlp INFIELD gzpa008
            {<point name="input.c.gzpa008" />}
            #END add-point
 
         #----<<gzpa010>>----
         #Ctrlp:input.c.gzpa010
#         ON ACTION controlp INFIELD gzpa010
            #add-point:ON ACTION controlp INFIELD gzpa010
            {<point name="input.c.gzpa010" />}
            #END add-point
 
         #----<<gzpa012>>----
         #Ctrlp:input.c.gzpa012
#         ON ACTION controlp INFIELD gzpa012
            #add-point:ON ACTION controlp INFIELD gzpa012
            {<point name="input.c.gzpa012" />}
            #END add-point
 
         #----<<gzpa015>>----
         #Ctrlp:input.c.gzpa015
#         ON ACTION controlp INFIELD gzpa015
            #add-point:ON ACTION controlp INFIELD gzpa015
            {<point name="input.c.gzpa015" />}
            #END add-point
 
         #----<<gzpa016>>----
         #Ctrlp:input.c.gzpa016
#         ON ACTION controlp INFIELD gzpa016
            #add-point:ON ACTION controlp INFIELD gzpa016
            {<point name="input.c.gzpa016" />}
            #END add-point
 
         #----<<gzpa017>>----
         #Ctrlp:input.c.gzpa017
#         ON ACTION controlp INFIELD gzpa017
            #add-point:ON ACTION controlp INFIELD gzpa017
            {<point name="input.c.gzpa017" />}
            #END add-point
 
         #----<<gzpa018>>----
         #Ctrlp:input.c.gzpa018
#         ON ACTION controlp INFIELD gzpa018
            #add-point:ON ACTION controlp INFIELD gzpa018
            {<point name="input.c.gzpa018" />}
            #END add-point
 
         #----<<gzpa019>>----
         #Ctrlp:input.c.gzpa019
#         ON ACTION controlp INFIELD gzpa019
            #add-point:ON ACTION controlp INFIELD gzpa019
            {<point name="input.c.gzpa019" />}
            #END add-point
 
         #----<<gzpa020>>----
         #Ctrlp:input.c.gzpa020
#         ON ACTION controlp INFIELD gzpa020
            #add-point:ON ACTION controlp INFIELD gzpa020
            {<point name="input.c.gzpa020" />}
            #END add-point
 
         #----<<gzpa021>>----
         #Ctrlp:input.c.gzpa021
#         ON ACTION controlp INFIELD gzpa021
            #add-point:ON ACTION controlp INFIELD gzpa021
            {<point name="input.c.gzpa021" />}
            #END add-point
 
         #----<<gzpa022>>----
         #Ctrlp:input.c.gzpa022
#         ON ACTION controlp INFIELD gzpa022
            #add-point:ON ACTION controlp INFIELD gzpa022
            {<point name="input.c.gzpa022" />}
            #END add-point
 
         #----<<gzpa023>>----
         #Ctrlp:input.c.gzpa023
#         ON ACTION controlp INFIELD gzpa023
            #add-point:ON ACTION controlp INFIELD gzpa023
            {<point name="input.c.gzpa023" />}
            #END add-point
 
         #----<<gzpa024>>----
         #Ctrlp:input.c.gzpa024
#         ON ACTION controlp INFIELD gzpa024
            #add-point:ON ACTION controlp INFIELD gzpa024
            {<point name="input.c.gzpa024" />}
            #END add-point
 
         #----<<gzpa025>>----
         #Ctrlp:input.c.gzpa025
#         ON ACTION controlp INFIELD gzpa025
            #add-point:ON ACTION controlp INFIELD gzpa025
            {<point name="input.c.gzpa025" />}
            #END add-point
 
         #----<<gzpa026>>----
         #Ctrlp:input.c.gzpa026
#         ON ACTION controlp INFIELD gzpa026
            #add-point:ON ACTION controlp INFIELD gzpa026
            {<point name="input.c.gzpa026" />}
            #END add-point
 
         #----<<gzpa027>>----
         #Ctrlp:input.c.gzpa027
#         ON ACTION controlp INFIELD gzpa027
            #add-point:ON ACTION controlp INFIELD gzpa027
            {<point name="input.c.gzpa027" />}
            #END add-point
 
         #----<<gzpa028>>----
         #Ctrlp:input.c.gzpa028
#         ON ACTION controlp INFIELD gzpa028
            #add-point:ON ACTION controlp INFIELD gzpa028
            {<point name="input.c.gzpa028" />}
            #END add-point
 
         #----<<gzpa029>>----
         #Ctrlp:input.c.gzpa029
#         ON ACTION controlp INFIELD gzpa029
            #add-point:ON ACTION controlp INFIELD gzpa029
            {<point name="input.c.gzpa029" />}
            #END add-point
 
         #----<<gzpa030>>----
         #Ctrlp:input.c.gzpa030
#         ON ACTION controlp INFIELD gzpa030
            #add-point:ON ACTION controlp INFIELD gzpa030
            {<point name="input.c.gzpa030" />}
            #END add-point
 
         #----<<gzpa031>>----
         #Ctrlp:input.c.gzpa031
#         ON ACTION controlp INFIELD gzpa031
            #add-point:ON ACTION controlp INFIELD gzpa031
            {<point name="input.c.gzpa031" />}
            #END add-point
 
         #----<<gzpastus>>----
         #Ctrlp:input.c.gzpastus
#         ON ACTION controlp INFIELD gzpastus
            #add-point:ON ACTION controlp INFIELD gzpastus
            {<point name="input.c.gzpastus" />}
            #END add-point
 
         #----<<gzpaownid>>----
         #----<<gzpaowndp>>----
         #----<<gzpacrtid>>----
         #----<<gzpacrtdp>>----
         #----<<gzpacrtdt>>----
         #----<<gzpamodid>>----
         #----<<gzpamoddt>>----
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            CALL cl_showmsg()      #錯誤訊息統整顯示
            DISPLAY BY NAME g_gzpa_m.gzpa001             
 
                            
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前
               {<point name="input.head.b_insert" mark="Y"/>}
               #end add-point
               
               INSERT INTO gzpa_t (gzpaent,gzpa001,gzpa004,gzpa002,gzpa005,gzpa003,gzpa006,gzpa007,gzpa008, 
                   gzpa010,gzpa012,gzpa015,gzpa016,gzpa017,gzpa018,gzpa019,gzpa020,gzpa021,gzpa022,gzpa023, 
                   gzpa024,gzpa025,gzpa026,gzpa027,gzpa028,gzpa029,gzpa030,gzpa031,gzpastus,gzpaownid, 
                   gzpaowndp,gzpacrtid,gzpacrtdp,gzpacrtdt,gzpamodid,gzpamoddt)
               VALUES (g_enterprise,g_gzpa_m.gzpa001,g_gzpa_m.gzpa004,g_gzpa_m.gzpa002,g_gzpa_m.gzpa005, 
                   g_gzpa_m.gzpa003,g_gzpa_m.gzpa006,g_gzpa_m.gzpa007,g_gzpa_m.gzpa008,g_gzpa_m.gzpa010, 
                   g_gzpa_m.gzpa012,g_gzpa_m.gzpa015,g_gzpa_m.gzpa016,g_gzpa_m.gzpa017,g_gzpa_m.gzpa018, 
                   g_gzpa_m.gzpa019,g_gzpa_m.gzpa020,g_gzpa_m.gzpa021,g_gzpa_m.gzpa022,g_gzpa_m.gzpa023, 
                   g_gzpa_m.gzpa024,g_gzpa_m.gzpa025,g_gzpa_m.gzpa026,g_gzpa_m.gzpa027,g_gzpa_m.gzpa028, 
                   g_gzpa_m.gzpa029,g_gzpa_m.gzpa030,g_gzpa_m.gzpa031,g_gzpa_m.gzpastus,g_gzpa_m.gzpaownid, 
                   g_gzpa_m.gzpaowndp,g_gzpa_m.gzpacrtid,g_gzpa_m.gzpacrtdp,g_gzpa_m.gzpacrtdt,g_gzpa_m.gzpamodid, 
                   g_gzpa_m.gzpamoddt) 
               IF SQLCA.sqlcode THEN
                  CALL cl_err("g_gzpa_m",SQLCA.sqlcode,1)  
                  CALL s_transaction_end('N','0')
                  CONTINUE DIALOG
               END IF
               
               #add-point:單頭新增中
               {<point name="input.head.m_insert"/>}
               #end add-point
               
               
               
               
               #add-point:單頭新增後
               {<point name="input.head.a_insert"/>}
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL azzi950_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前
               {<point name="input.head.b_update" mark="Y"/>}
               #end add-point
               
               UPDATE gzpa_t SET (gzpa001,gzpa004,gzpa002,gzpa005,gzpa003,gzpa006,gzpa007,gzpa008,gzpa010, 
                   gzpa012,gzpa015,gzpa016,gzpa017,gzpa018,gzpa019,gzpa020,gzpa021,gzpa022,gzpa023,gzpa024, 
                   gzpa025,gzpa026,gzpa027,gzpa028,gzpa029,gzpa030,gzpa031,gzpastus,gzpaownid,gzpaowndp, 
                   gzpacrtid,gzpacrtdp,gzpacrtdt,gzpamodid,gzpamoddt) = (g_gzpa_m.gzpa001,g_gzpa_m.gzpa004, 
                   g_gzpa_m.gzpa002,g_gzpa_m.gzpa005,g_gzpa_m.gzpa003,g_gzpa_m.gzpa006,g_gzpa_m.gzpa007, 
                   g_gzpa_m.gzpa008,g_gzpa_m.gzpa010,g_gzpa_m.gzpa012,g_gzpa_m.gzpa015,g_gzpa_m.gzpa016, 
                   g_gzpa_m.gzpa017,g_gzpa_m.gzpa018,g_gzpa_m.gzpa019,g_gzpa_m.gzpa020,g_gzpa_m.gzpa021, 
                   g_gzpa_m.gzpa022,g_gzpa_m.gzpa023,g_gzpa_m.gzpa024,g_gzpa_m.gzpa025,g_gzpa_m.gzpa026, 
                   g_gzpa_m.gzpa027,g_gzpa_m.gzpa028,g_gzpa_m.gzpa029,g_gzpa_m.gzpa030,g_gzpa_m.gzpa031, 
                   g_gzpa_m.gzpastus,g_gzpa_m.gzpaownid,g_gzpa_m.gzpaowndp,g_gzpa_m.gzpacrtid,g_gzpa_m.gzpacrtdp, 
                   g_gzpa_m.gzpacrtdt,g_gzpa_m.gzpamodid,g_gzpa_m.gzpamoddt)
                WHERE gzpaent = g_enterprise AND gzpa001 = g_gzpa001_t
 
               IF SQLCA.sqlcode THEN
                  CALL cl_err("gzpa_t",SQLCA.sqlcode,1)  
                  CALL s_transaction_end('N','0')
                  CONTINUE DIALOG
               END IF
               
               #add-point:單頭修改中
               {<point name="input.head.m_update"/>}
               #end add-point
               
               
               
               CALL s_transaction_end('Y','0')
               
               #add-point:單頭修改後
               {<point name="input.head.a_update"/>}
               #end add-point
            END IF
            
            LET g_gzpa001_t = g_gzpa_m.gzpa001
 
            #controlp
            
      END INPUT
   
 
{</section>}
 
{<section id="azzi950.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_gzpb_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_gzpb_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL azzi950_b_fill()
            LET g_rec_b = g_gzpb_d.getLength()
            #add-point:資料輸入前
            {<point name="input.d.before_input"/>}
            #end add-point
         
         BEFORE ROW
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN azzi950_cl USING g_enterprise,g_gzpa_m.gzpa001
 
            IF STATUS THEN
               CALL cl_err("OPEN azzi950_cl:", STATUS, 1)
               CLOSE azzi950_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            
            LET g_rec_b = g_gzpb_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_gzpb_d[l_ac].gzpb002 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_gzpb_d_t.* = g_gzpb_d[l_ac].*  #BACKUP
               CALL azzi950_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b
               {<point name="input.body.after_set_entry_b"/>}
               #end add-point  
               CALL azzi950_set_no_entry_b(l_cmd)
               IF NOT azzi950_lock_b("gzpb_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH azzi950_bcl INTO g_gzpb_d[l_ac].gzpb002,g_gzpb_d[l_ac].gzpb003,g_gzpb_d[l_ac].gzpb003_desc, 
                      g_gzpb_d[l_ac].gzpb004,g_gzpb_d[l_ac].gzpb005
                  IF SQLCA.sqlcode THEN
                     CALL cl_err(g_gzpb_d_t.gzpb002,SQLCA.sqlcode,1)
                     LET l_lock_sw = "Y"
                  END IF
                  
                  LET g_bfill = "N"
                  CALL azzi950_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row
            {<point name="input.body.before_row"/>}
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
            #其他table進行lock
            
        
         BEFORE INSERT
            
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_gzpb_d[l_ac].* TO NULL 
            
            LET g_gzpb_d_t.* = g_gzpb_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL azzi950_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b
            {<point name="input.body.insert.after_set_entry_b"/>}
            #end add-point
            CALL azzi950_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_gzpb_d[li_reproduce_target].* = g_gzpb_d[li_reproduce].*
 
               LET g_gzpb_d[li_reproduce_target].gzpb002 = NULL
 
            END IF
            #公用欄位給值(單身)
            
            
            #add-point:modify段before insert
            {<point name="input.body.before_insert"/>}
            #end add-point  
  
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               CALL cl_err('',9001,0)
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身新增
            {<point name="input.body.b_a_insert"/>}
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM gzpb_t 
             WHERE gzpbent = g_enterprise AND gzpb001 = g_gzpa_m.gzpa001
 
               AND gzpb002 = g_gzpb_d[l_ac].gzpb002
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前
               {<point name="input.body.b_insert"/>}
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gzpa_m.gzpa001
               LET gs_keys[2] = g_gzpb_d[g_detail_idx].gzpb002
               CALL azzi950_insert_b('gzpb_t',gs_keys,"'1'")
                           
               #add-point:單身新增後
               {<point name="input.body.a_insert"/>}
               #end add-point
            ELSE    
               CALL cl_err('INSERT',"std-00006",1)
               INITIALIZE g_gzpb_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               CALL cl_err("gzpb_t",SQLCA.sqlcode,1)  
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL azzi950_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert
               {<point name="input.body.a_insert2"/>}
               #end add-point
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' AND g_gzpb_d.getLength() < l_ac THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_gzpb_d.deleteElement(l_ac)
               NEXT FIELD gzpb002
            END IF
         
            IF g_gzpb_d[l_ac].gzpb002 IS NOT NULL
 
               THEN 
               
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  CALL cl_err("", -263, 1)
                  CANCEL DELETE
               END IF
               
               #add-point:單身刪除前
               {<point name="input.body.b_delete" mark="Y"/>}
               #end add-point 
               
               DELETE FROM gzpb_t
                WHERE gzpbent = g_enterprise AND gzpb001 = g_gzpa_m.gzpa001 AND
 
                      gzpb002 = g_gzpb_d_t.gzpb002
 
                  
               #add-point:單身刪除中
               {<point name="input.body.m_delete"/>}
               #end add-point 
               
               IF SQLCA.sqlcode THEN
                  CALL cl_err("gzpb_t",SQLCA.sqlcode,1)
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_rec_b = g_rec_b-1
                  
                  #add-point:單身刪除後
                  {<point name="input.body.a_delete"/>}
                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE azzi950_bcl
               LET l_count = g_gzpb_d.getLength()
            END IF 
            
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gzpa_m.gzpa001
               LET gs_keys[2] = g_gzpb_d[g_detail_idx].gzpb002
 
              
         AFTER DELETE 
            #add-point:單身刪除後2
            {<point name="input.body.after_delete"/>}
            #end add-point
                           CALL azzi950_delete_b('gzpb_t',gs_keys,"'1'")
 
         #---------------------<  Detail: page1  >---------------------
         #----<<gzpb002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpb002
            #add-point:BEFORE FIELD gzpb002
            {<point name="input.b.page1.gzpb002" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpb002
            
            #add-point:AFTER FIELD gzpb002
            #此段落由子樣板a05產生
            IF  g_gzpa_m.gzpa001 IS NOT NULL AND g_gzpb_d[g_detail_idx].gzpb002 IS NOT NULL AND g_gzpb_d[g_detail_idx].gzpb003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gzpa_m.gzpa001 != g_gzpa001_t OR g_gzpb_d[g_detail_idx].gzpb002 != g_gzpb_d_t.gzpb002 OR g_gzpb_d[g_detail_idx].gzpb003 != g_gzpb_d_t.gzpb003)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gzpb_t WHERE "||"gzpbent = '" ||g_enterprise|| "' AND "||"gzpb001 = '"||g_gzpa_m.gzpa001 ||"' AND "|| "gzpb002 = '"||g_gzpb_d[g_detail_idx].gzpb002 ||"' AND "|| "gzpb003 = '"||g_gzpb_d[g_detail_idx].gzpb003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE gzpb002
            #add-point:ON CHANGE gzpb002
            {<point name="input.g.page1.gzpb002" />}
            #END add-point
 
         #----<<gzpb003>>----
         #此段落由子樣板a02產生
         AFTER FIELD gzpb003
            
            #add-point:AFTER FIELD gzpb003
            #此段落由子樣板a05產生
            IF  g_gzpa_m.gzpa001 IS NOT NULL AND g_gzpb_d[g_detail_idx].gzpb002 IS NOT NULL AND g_gzpb_d[g_detail_idx].gzpb003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gzpa_m.gzpa001 != g_gzpa001_t OR g_gzpb_d[g_detail_idx].gzpb002 != g_gzpb_d_t.gzpb002 OR g_gzpb_d[g_detail_idx].gzpb003 != g_gzpb_d_t.gzpb003)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gzpb_t WHERE "||"gzpbent = '" ||g_enterprise|| "' AND "||"gzpb001 = '"||g_gzpa_m.gzpa001 ||"' AND "|| "gzpb002 = '"||g_gzpb_d[g_detail_idx].gzpb002 ||"' AND "|| "gzpb003 = '"||g_gzpb_d[g_detail_idx].gzpb003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_gzpb_d[l_ac].gzpb003
            CALL ap_ref_array2(g_ref_fields,"SELECT gzzal003 FROM gzzal_t WHERE gzzal001=? AND gzzal002='"||g_lang||"'","") RETURNING g_rtn_fields
            LET g_gzpb_d[l_ac].gzpb003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_gzpb_d[l_ac].gzpb003_desc

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD gzpb003
            #add-point:BEFORE FIELD gzpb003
            {<point name="input.b.page1.gzpb003" />}
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE gzpb003
            #add-point:ON CHANGE gzpb003
            {<point name="input.g.page1.gzpb003" />}
            #END add-point
 
         #----<<gzpb004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpb004
            #add-point:BEFORE FIELD gzpb004
            CALL ld_arr.clear()
            CALL s_azzi900_app_param_token(ld_arr,g_gzpb_d[l_ac].gzpb004) RETURNING ld_arr     
            CALL azzi900_02(g_gzpa_m.gzpa001,ld_arr) RETURNING ls_str,li_rtn
            #li_rtn是TRUE 確認有異動
            IF li_rtn THEN 
               LET g_gzpb_d[l_ac].gzpb004 = ls_str  
            END IF
 
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpb004
            
            #add-point:AFTER FIELD gzpb004
            {<point name="input.a.page1.gzpb004" />}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE gzpb004
            #add-point:ON CHANGE gzpb004
            {<point name="input.g.page1.gzpb004" />}
            #END add-point
 
         #----<<gzpb005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzpb005
            #add-point:BEFORE FIELD gzpb005
            {<point name="input.b.page1.gzpb005" />}
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD gzpb005
            
            #add-point:AFTER FIELD gzpb005
            {<point name="input.a.page1.gzpb005" />}
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE gzpb005
            #add-point:ON CHANGE gzpb005
            {<point name="input.g.page1.gzpb005" />}
            #END add-point
 
 
         #---------------------<  Detail: page1  >---------------------
         #----<<gzpb002>>----
         #Ctrlp:input.c.page1.gzpb002
#         ON ACTION controlp INFIELD gzpb002
            #add-point:ON ACTION controlp INFIELD gzpb002
            {<point name="input.c.page1.gzpb002" />}
            #END add-point
 
         #----<<gzpb003>>----
         #Ctrlp:input.c.page1.gzpb003
         ON ACTION controlp INFIELD gzpb003
            #add-point:ON ACTION controlp INFIELD gzpb003
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_gzpb_d[l_ac].gzpb003             #給予default值

            #給予arg

            CALL q_gzzz001_1()                                #呼叫開窗

            LET g_gzpb_d[l_ac].gzpb003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_gzpb_d[l_ac].gzpb003 TO gzpb003              #顯示到畫面上

            NEXT FIELD gzpb003                          #返回原欄位


            #END add-point
 
         #----<<gzpb004>>----
         #Ctrlp:input.c.page1.gzpb004
#         ON ACTION controlp INFIELD gzpb004
            #add-point:ON ACTION controlp INFIELD gzpb004
             
            #END add-point
 
         #----<<gzpb005>>----
         #Ctrlp:input.c.page1.gzpb005
         ON ACTION controlp INFIELD gzpb005
            #add-point:ON ACTION controlp INFIELD gzpb005
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_gzpb_d[l_ac].gzpb005             #給予default值

            #給予arg

            CALL q_ooef001()                                #呼叫開窗

            LET g_gzpb_d[l_ac].gzpb005 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_gzpb_d[l_ac].gzpb005 TO gzpb005                    #顯示到畫面上

            NEXT FIELD gzpb005                          #返回原欄位


            #END add-point
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CALL cl_err('',9001,0)
               LET INT_FLAG = 0
               LET g_gzpb_d[l_ac].* = g_gzpb_d_t.*
               CLOSE azzi950_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               CALL cl_err(g_gzpb_d[l_ac].gzpb002,-263,1)
               LET g_gzpb_d[l_ac].* = g_gzpb_d_t.*
            ELSE
            
               #add-point:單身修改前
               {<point name="input.body.b_update" mark="Y"/>}
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               UPDATE gzpb_t SET (gzpb001,gzpb002,gzpb003,gzpb004,gzpb005) = (g_gzpa_m.gzpa001,g_gzpb_d[l_ac].gzpb002, 
                   g_gzpb_d[l_ac].gzpb003,g_gzpb_d[l_ac].gzpb004,g_gzpb_d[l_ac].gzpb005)
                WHERE gzpbent = g_enterprise AND gzpb001 = g_gzpa_m.gzpa001 
 
                  AND gzpb002 = g_gzpb_d_t.gzpb002 #項次   
 
                  
               #add-point:單身修改中
               {<point name="input.body.m_update"/>}
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL cl_err("gzpb_t","std-00009",1)
                     CALL s_transaction_end('N','0')
                     LET g_gzpb_d[l_ac].* = g_gzpb_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     CALL cl_err("gzpb_t",SQLCA.sqlcode,1)
                     LET g_gzpb_d[l_ac].* = g_gzpb_d_t.*                     
                     CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gzpa_m.gzpa001
               LET gs_keys_bak[1] = g_gzpa001_t
               LET gs_keys[2] = g_gzpb_d[g_detail_idx].gzpb002
               LET gs_keys_bak[2] = g_gzpb_d_t.gzpb002
               CALL azzi950_update_b('gzpb_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
               END CASE
               
               #add-point:單身修改後
               {<point name="input.body.a_update"/>}
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row
            {<point name="input.body.after_row"/>}
            #end add-point
            CALL azzi950_unlock_b("gzpb_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            
              
         AFTER INPUT
            #add-point:input段after input 
            {<point name="input.body.after_input"/>}
            #end add-point 
 
         ON ACTION controlo    
            CALL FGL_SET_ARR_CURR(g_gzpb_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_gzpb_d.getLength()+1
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
      
 
      
 
      
 
{</section>}
 
{<section id="azzi950.input.other" >}
      
      #add-point:自定義input
      {<point name="input.more_input"/>}

      #Page1 預設值產生於此處
      INPUT ARRAY g_schedule_d FROM s_schedule.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)

          BEFORE INPUT         

      END INPUT 


      
      #end add-point
      
      BEFORE DIALOG 
         #add-point:input段before dialog
         {<point name="input.before_dialog"/>}
         #end add-point    
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD gzpa001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD gzpb002
 
            END CASE
         END IF
    
      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang)
 
      ON ACTION controlr
         CALL cl_show_req_fields()
 
      ON ACTION controls
         CALL cl_set_head_visible("","AUTO")
 
      ON ACTION accept
         ACCEPT DIALOG
        
      ON ACTION cancel      #在dialog button (放棄)
         LET INT_FLAG = TRUE 
         LET g_detail_idx  = 1
         LET g_detail_idx2 = 1
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
    
   #add-point:input段after input 
   {<point name="input.after_input"/>}
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="azzi950.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION azzi950_show()
   {<Local define>}
   DEFINE l_ac_t    LIKE type_t.num5
   {</Local define>}
   #add-point:show段define
   {<point name="show.define"/>}
   #end add-point  
 
   #add-point:show段之前
   {<point name="show.before"/>}

    
    #CALL azzi950_schedule_init()
    
    CALL azzi950_combination()
    CALL azzi950_chk_token()
    
   #end add-point
   
   
   
   LET g_gzpa_m_t.* = g_gzpa_m.*      #保存單頭舊值
   
   IF g_bfill = "Y" THEN
      CALL azzi950_b_fill() #單身填充
      CALL azzi950_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #此段落由子樣板a12產生
      #LET g_gzpa_m.gzpaownid_desc = cl_get_username(g_gzpa_m.gzpaownid)
      #LET g_gzpa_m.gzpaowndp_desc = cl_get_deptname(g_gzpa_m.gzpaowndp)
      #LET g_gzpa_m.gzpacrtid_desc = cl_get_username(g_gzpa_m.gzpacrtid)
      #LET g_gzpa_m.gzpacrtdp_desc = cl_get_deptname(g_gzpa_m.gzpacrtdp)
      #LET g_gzpa_m.gzpamodid_desc = cl_get_username(g_gzpa_m.gzpamodid)
      ##LET g_gzpa_m.gzpacnfid_desc = cl_get_deptname(g_gzpa_m.gzpacnfid)
      ##LET g_gzpa_m.gzpapstid_desc = cl_get_deptname(g_gzpa_m.gzpapstid)
      
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference
            --INITIALIZE g_ref_fields TO NULL
            --LET g_ref_fields[1] = g_gzpa_m.gzpaownid
            --CALL ap_ref_array2(g_ref_fields,"SELECT oofa011 FROM oofa_t WHERE oofaent='"||g_enterprise||"' AND oofa002='2' AND oofa003=? ","") RETURNING g_rtn_fields
            --LET g_gzpa_m.gzpaownid_desc = '', g_rtn_fields[1] , ''
            --DISPLAY BY NAME g_gzpa_m.gzpaownid_desc
--
            --INITIALIZE g_ref_fields TO NULL
            --LET g_ref_fields[1] = g_gzpa_m.gzpaowndp
            --CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            --LET g_gzpa_m.gzpaowndp_desc = '', g_rtn_fields[1] , ''
            --DISPLAY BY NAME g_gzpa_m.gzpaowndp_desc
--
            --INITIALIZE g_ref_fields TO NULL
            --LET g_ref_fields[1] = g_gzpa_m.gzpacrtid
            --CALL ap_ref_array2(g_ref_fields,"SELECT oofa011 FROM oofa_t WHERE oofaent='"||g_enterprise||"' AND oofa002='2' AND oofa003=? ","") RETURNING g_rtn_fields
            --LET g_gzpa_m.gzpacrtid_desc = '', g_rtn_fields[1] , ''
            --DISPLAY BY NAME g_gzpa_m.gzpacrtid_desc
--
            --INITIALIZE g_ref_fields TO NULL
            --LET g_ref_fields[1] = g_gzpa_m.gzpacrtdp
            --CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            --LET g_gzpa_m.gzpacrtdp_desc = '', g_rtn_fields[1] , ''
            --DISPLAY BY NAME g_gzpa_m.gzpacrtdp_desc
--
            --INITIALIZE g_ref_fields TO NULL
            --LET g_ref_fields[1] = g_gzpa_m.gzpamodid
            --CALL ap_ref_array2(g_ref_fields,"SELECT oofa011 FROM oofa_t WHERE oofaent='"||g_enterprise||"' AND oofa002='2' AND oofa003=? ","") RETURNING g_rtn_fields
            --LET g_gzpa_m.gzpamodid_desc = '', g_rtn_fields[1] , ''
            --DISPLAY BY NAME g_gzpa_m.gzpamodid_desc

   #end add-point
   DISPLAY "g_gzpa_m.gzpa003:",g_gzpa_m.gzpa003
   #DISPLAY  g_gzpa_m.gzpa003 TO gzpa003
   #將資料輸出到畫面上
   DISPLAY BY NAME 
       g_gzpa_m.gzpa001,g_gzpa_m.gzpa004,g_gzpa_m.gzpa002
       ,g_gzpa_m.gzpa005,g_gzpa_m.gzpa003, 
       g_gzpa_m.gzpa006,g_gzpa_m.gzpa007,g_gzpa_m.gzpa008 ,

       g_gzpa_m.m01,g_gzpa_m.m02,g_gzpa_m.m03,g_gzpa_m.m04,g_gzpa_m.m05,g_gzpa_m.m06,g_gzpa_m.m07,g_gzpa_m.m08,g_gzpa_m.m09,g_gzpa_m.m10,g_gzpa_m.m11,g_gzpa_m.m12, 
       g_gzpa_m.gzpa010,
       g_gzpa_m.wk1,g_gzpa_m.wk2,g_gzpa_m.wk3,g_gzpa_m.wk4,g_gzpa_m.wk5 ,
       g_gzpa_m.gzpa012, 
       g_gzpa_m.wd0,g_gzpa_m.wd1,g_gzpa_m.wd2,g_gzpa_m.wd3,g_gzpa_m.wd4,g_gzpa_m.wd5,g_gzpa_m.wd6,g_gzpa_m.d01, 
       g_gzpa_m.d02,g_gzpa_m.d03,g_gzpa_m.d04,g_gzpa_m.d05,g_gzpa_m.d06,g_gzpa_m.d07,g_gzpa_m.d08,g_gzpa_m.d09, 
       g_gzpa_m.d10,g_gzpa_m.d11,g_gzpa_m.d12,g_gzpa_m.d13,g_gzpa_m.d14,g_gzpa_m.d15,g_gzpa_m.d16,g_gzpa_m.d17, 
       g_gzpa_m.d18,g_gzpa_m.d19,g_gzpa_m.d20,g_gzpa_m.d21,g_gzpa_m.d22,g_gzpa_m.d23,g_gzpa_m.d24,g_gzpa_m.d25, 
       g_gzpa_m.d26,g_gzpa_m.d27,g_gzpa_m.d28,g_gzpa_m.d29,g_gzpa_m.d30,g_gzpa_m.d31,g_gzpa_m.den,
       g_gzpa_m.gzpa015, 
       g_gzpa_m.gzpa016,
       g_gzpa_m.sc1,g_gzpa_m.gzpa017,g_gzpa_m.gzpa018,g_gzpa_m.gzpa019,g_gzpa_m.gzpa020, 
       g_gzpa_m.sc2,g_gzpa_m.gzpa021,g_gzpa_m.gzpa022,g_gzpa_m.gzpa023,g_gzpa_m.gzpa024,
       g_gzpa_m.sc3,g_gzpa_m.gzpa025,g_gzpa_m.gzpa026,g_gzpa_m.gzpa027,g_gzpa_m.gzpa028,g_gzpa_m.gzpa029,g_gzpa_m.gzpa030, 
       g_gzpa_m.gzpa031,g_gzpa_m.gzpastus,g_gzpa_m.gzpaownid,g_gzpa_m.gzpaownid_desc,g_gzpa_m.gzpaowndp, 
       g_gzpa_m.gzpaowndp_desc,g_gzpa_m.gzpacrtid,g_gzpa_m.gzpacrtid_desc,g_gzpa_m.gzpacrtdp,g_gzpa_m.gzpacrtdp_desc, 
       g_gzpa_m.gzpacrtdt,g_gzpa_m.gzpamodid,g_gzpa_m.gzpamodid_desc,g_gzpa_m.gzpamoddt,g_gzpa_m.gzpe003, 
       g_gzpa_m.gzpe004,g_gzpa_m.gzpe004_desc,g_gzpa_m.addr,g_gzpa_m.gzpe005
   
   #顯示狀態(stus)圖片
         #此段落由子樣板a21產生
      CASE g_gzpa_m.gzpastus
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
 
 
         
      END CASE
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_gzpb_d.getLength()
      #帶出公用欄位reference值
      
      #add-point:show段單身reference
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_gzpb_d[l_ac].gzpb003
            CALL ap_ref_array2(g_ref_fields,"SELECT gzzal003 FROM gzzal_t WHERE gzzal001=? AND gzzal002='"||g_lang||"'","") RETURNING g_rtn_fields
            LET g_gzpb_d[l_ac].gzpb003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_gzpb_d[l_ac].gzpb003_desc

      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other
   {<point name="show.other"/>}
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL azzi950_detail_show()
   
   #add-point:show段之後
   {<point name="show.after"/>}
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="azzi950.detail_show" >}
#+ 單身reference detail_show
PRIVATE FUNCTION azzi950_detail_show()
   {<Local define>}
   {</Local define>}
   #add-point:detail_show段define
   {<point name="detail_show.define"/>}
   #end add-point  
 
   #add-point:detail_show段之前
   {<point name="detail_show.before"/>}
   #end add-point
   
   #add-point:detail_show段之後
   {<point name="detail_show.after"/>}
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="azzi950.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION azzi950_reproduce()
   {<Local define>}
   DEFINE l_newno     LIKE gzpa_t.gzpa001 
   DEFINE l_oldno     LIKE gzpa_t.gzpa001 
 
   DEFINE l_master    RECORD LIKE gzpa_t.*
   DEFINE l_detail    RECORD LIKE gzpb_t.*
 
 
   DEFINE l_cnt       LIKE type_t.num5
   {</Local define>}
   #add-point:reproduce段define
   {<point name="reproduce.define"/>}
   #end add-point   
 
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
   
   IF g_gzpa_m.gzpa001 IS NULL
 
   THEN
      CALL cl_err("","std-00003",0)
      RETURN
   END IF
    
   LET g_gzpa001_t = g_gzpa_m.gzpa001
 
    
   LET g_gzpa_m.gzpa001 = ""
 
    
   CALL azzi950_set_entry('a')
   CALL azzi950_set_no_entry('a')
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #此段落由子樣板a14產生    
      LET g_gzpa_m.gzpaownid = g_user
      LET g_gzpa_m.gzpaowndp = g_dept
      LET g_gzpa_m.gzpacrtid = g_user
      LET g_gzpa_m.gzpacrtdp = g_dept 
      LET g_gzpa_m.gzpacrtdt = cl_get_current()
      LET g_gzpa_m.gzpamodid = ""
      LET g_gzpa_m.gzpamoddt = ""
      #LET g_gzpa_m.gzpastus = ""
 
 
   
   #add-point:複製輸入前
   {<point name="reproduce.head.b_input"/>}
   #end add-point
   
   CALL azzi950_input("r")
   
   
   
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      RETURN
   END IF
 
   LET g_state = "Y"
   
   LET g_wc = g_wc,  
              " OR (",
              " gzpa001 = '", g_gzpa_m.gzpa001 CLIPPED, "' "
 
              , ") "
   
   #add-point:完成複製段落後
   {<point name="reproduce.after_reproduce" />}
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="azzi950.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION azzi950_detail_reproduce()
   {<Local define>}
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE gzpb_t.*
 
 
   {</Local define>}
   #add-point:delete段define
   {<point name="detail_reproduce.define"/>}
   #end add-point    
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE azzi950_detail
   
   #add-point:單身複製前1
   {<point name="detail_reproduce.body.table1.b_insert" mark="Y"/>}
   #end add-point
   
   #CREATE TEMP TABLE
   LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE azzi950_detail AS ",
                "SELECT * FROM gzpb_t "
   PREPARE repro_tbl FROM ls_sql
   EXECUTE repro_tbl
   FREE repro_tbl
                
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO azzi950_detail SELECT * FROM gzpb_t 
                                         WHERE gzpbent = g_enterprise AND gzpb001 = g_gzpa001_t
 
   
   #將key修正為調整後   
   UPDATE azzi950_detail 
      #更新key欄位
      SET gzpb001 = g_gzpa_m.gzpa001
 
      #更新共用欄位
      
                                       
  
   #將資料塞回原table   
   INSERT INTO gzpb_t SELECT * FROM azzi950_detail
   
   IF SQLCA.sqlcode THEN
      CALL cl_err("reproduce",SQLCA.sqlcode,1)
      RETURN
   END IF
   
   #add-point:單身複製中1
   {<point name="detail_reproduce.body.table1.m_insert"/>}
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE azzi950_detail
   
   #add-point:單身複製後1
   {<point name="detail_reproduce.body.table1.a_insert"/>}
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_gzpa001_t = g_gzpa_m.gzpa001
 
   
   DROP TABLE azzi950_detail
   
END FUNCTION
 
{</section>}
 
{<section id="azzi950.delete" >}
#+ 資料刪除
PRIVATE FUNCTION azzi950_delete()
   {<Local define>}
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   {</Local define>}
   #add-point:delete段define
   {<point name="delete.define"/>}
   #end add-point     
   
   IF g_gzpa_m.gzpa001 IS NULL
 
   THEN
      CALL cl_err("","std-00003",0)
      RETURN
   END IF
 
    SELECT UNIQUE gzpa001,gzpa004,gzpa002,gzpa005,gzpa003,gzpa006,gzpa007,gzpa008,gzpa010,gzpa012,gzpa015, 
        gzpa016,gzpa017,gzpa018,gzpa019,gzpa020,gzpa021,gzpa022,gzpa023,gzpa024,gzpa025,gzpa026,gzpa027, 
        gzpa028,gzpa029,gzpa030,gzpa031,gzpastus,gzpaownid,gzpaowndp,gzpacrtid,gzpacrtdp,gzpacrtdt,gzpamodid, 
        gzpamoddt
 INTO g_gzpa_m.gzpa001,g_gzpa_m.gzpa004,g_gzpa_m.gzpa002,g_gzpa_m.gzpa005,g_gzpa_m.gzpa003,g_gzpa_m.gzpa006, 
     g_gzpa_m.gzpa007,g_gzpa_m.gzpa008,g_gzpa_m.gzpa010,g_gzpa_m.gzpa012,g_gzpa_m.gzpa015,g_gzpa_m.gzpa016, 
     g_gzpa_m.gzpa017,g_gzpa_m.gzpa018,g_gzpa_m.gzpa019,g_gzpa_m.gzpa020,g_gzpa_m.gzpa021,g_gzpa_m.gzpa022, 
     g_gzpa_m.gzpa023,g_gzpa_m.gzpa024,g_gzpa_m.gzpa025,g_gzpa_m.gzpa026,g_gzpa_m.gzpa027,g_gzpa_m.gzpa028, 
     g_gzpa_m.gzpa029,g_gzpa_m.gzpa030,g_gzpa_m.gzpa031,g_gzpa_m.gzpastus,g_gzpa_m.gzpaownid,g_gzpa_m.gzpaowndp, 
     g_gzpa_m.gzpacrtid,g_gzpa_m.gzpacrtdp,g_gzpa_m.gzpacrtdt,g_gzpa_m.gzpamodid,g_gzpa_m.gzpamoddt
 FROM gzpa_t
 WHERE gzpaent = g_enterprise AND gzpa001 = g_gzpa_m.gzpa001
   
   
 
   CALL azzi950_show()
   
   CALL s_transaction_begin()
 
   OPEN azzi950_cl USING g_enterprise,g_gzpa_m.gzpa001
 
   IF STATUS THEN
      CALL cl_err("OPEN azzi950_cl:", STATUS, 1)
      CLOSE azzi950_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   FETCH azzi950_cl INTO g_gzpa_m.gzpa001,g_gzpa_m.gzpa004,g_gzpa_m.gzpa002,g_gzpa_m.gzpa005,g_gzpa_m.gzpa003, 
       g_gzpa_m.gzpa006,g_gzpa_m.gzpa007,g_gzpa_m.gzpa008,g_gzpa_m.m01,g_gzpa_m.m02,g_gzpa_m.m03,g_gzpa_m.m04, 
       g_gzpa_m.m05,g_gzpa_m.m06,g_gzpa_m.m07,g_gzpa_m.m08,g_gzpa_m.m09,g_gzpa_m.m10,g_gzpa_m.m11,g_gzpa_m.m12, 
       g_gzpa_m.gzpa010,g_gzpa_m.wk1,g_gzpa_m.wk2,g_gzpa_m.wk3,g_gzpa_m.wk4,g_gzpa_m.wk5,g_gzpa_m.gzpa012, 
       g_gzpa_m.wd0,g_gzpa_m.wd1,g_gzpa_m.wd2,g_gzpa_m.wd3,g_gzpa_m.wd4,g_gzpa_m.wd5,g_gzpa_m.wd6,g_gzpa_m.d01, 
       g_gzpa_m.d02,g_gzpa_m.d03,g_gzpa_m.d04,g_gzpa_m.d05,g_gzpa_m.d06,g_gzpa_m.d07,g_gzpa_m.d08,g_gzpa_m.d09, 
       g_gzpa_m.d10,g_gzpa_m.d11,g_gzpa_m.d12,g_gzpa_m.d13,g_gzpa_m.d14,g_gzpa_m.d15,g_gzpa_m.d16,g_gzpa_m.d17, 
       g_gzpa_m.d18,g_gzpa_m.d19,g_gzpa_m.d20,g_gzpa_m.d21,g_gzpa_m.d22,g_gzpa_m.d23,g_gzpa_m.d24,g_gzpa_m.d25, 
       g_gzpa_m.d26,g_gzpa_m.d27,g_gzpa_m.d28,g_gzpa_m.d29,g_gzpa_m.d30,g_gzpa_m.d31,g_gzpa_m.den,g_gzpa_m.gzpa015, 
       g_gzpa_m.gzpa016,g_gzpa_m.sc1,g_gzpa_m.gzpa017,g_gzpa_m.gzpa018,g_gzpa_m.gzpa019,g_gzpa_m.gzpa020, 
       g_gzpa_m.sc2,g_gzpa_m.gzpa021,g_gzpa_m.gzpa022,g_gzpa_m.gzpa023,g_gzpa_m.gzpa024,g_gzpa_m.sc3, 
       g_gzpa_m.gzpa025,g_gzpa_m.gzpa026,g_gzpa_m.gzpa027,g_gzpa_m.gzpa028,g_gzpa_m.gzpa029,g_gzpa_m.gzpa030, 
       g_gzpa_m.gzpa031,g_gzpa_m.gzpastus,g_gzpa_m.gzpaownid,g_gzpa_m.gzpaownid_desc,g_gzpa_m.gzpaowndp, 
       g_gzpa_m.gzpaowndp_desc,g_gzpa_m.gzpacrtid,g_gzpa_m.gzpacrtid_desc,g_gzpa_m.gzpacrtdp,g_gzpa_m.gzpacrtdp_desc, 
       g_gzpa_m.gzpacrtdt,g_gzpa_m.gzpamodid,g_gzpa_m.gzpamodid_desc,g_gzpa_m.gzpamoddt,g_gzpa_m.gzpe003, 
       g_gzpa_m.gzpe004,g_gzpa_m.gzpe004_desc,g_gzpa_m.addr,g_gzpa_m.gzpe005              #鎖住將被更改或取消的資料 
 
   IF SQLCA.sqlcode THEN
      CALL cl_err(g_gzpa_m.gzpa001,SQLCA.sqlcode,0)          #資料被他人LOCK
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #IF NOT cl_ask_delete() THEN             #確認一下
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前
      {<point name="delete.head.b_delete" mark="Y"/>}
      #end add-point   
      
      INITIALIZE g_doc.* TO NULL         
      LET g_doc.column1 = "gzpa001"       
      LET g_doc.value1 = g_gzpa_m.gzpa001     
      CALL cl_doc_remove()   
  
      #資料備份
      LET g_gzpa001_t = g_gzpa_m.gzpa001
 
 
      DELETE FROM gzpa_t
       WHERE gzpaent = g_enterprise AND gzpa001 = g_gzpa_m.gzpa001
 
       
      #add-point:單頭刪除中
      {<point name="delete.head.m_delete"/>}
      #end add-point
       
      IF SQLCA.sqlcode THEN
         CALL cl_err(g_gzpa_m.gzpa001,SQLCA.sqlcode,0) 
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      #add-point:單頭刪除後
      {<point name="delete.head.a_delete"/>}
      #end add-point
  
      #add-point:單身刪除前
      {<point name="delete.body.b_delete" mark="Y"/>}
      #end add-point
      
      DELETE FROM gzpb_t
       WHERE gzpbent = g_enterprise AND gzpb001 = g_gzpa_m.gzpa001
 
 
      #add-point:單身刪除中
      {<point name="delete.body.m_delete"/>}
      #end add-point
         
      IF SQLCA.sqlcode THEN
         CALL cl_err("gzpb_t",SQLCA.sqlcode,0) 
         CALL s_transaction_end('N','0')
         RETURN
      END IF    
 
      #add-point:單身刪除後
      {<point name="delete.body.a_delete"/>}
       DELETE FROM gzpe_t
       WHERE gzpeent = g_enterprise AND gzpe001 = g_gzpa_m.gzpa001
 
      CALL g_schedule_d.clear()
      #end add-point
      
            
                                                               
 
 
 
                                                               
      CLEAR FORM
      CALL g_gzpb_d.clear() 
 
     
      CALL azzi950_ui_browser_refresh()  
      CALL azzi950_ui_headershow()  
      CALL azzi950_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL azzi950_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
      ELSE
         LET g_wc = " 1=1"
         CALL azzi950_browser_fill("F")
      END IF
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
 
   
   END IF
 
   CALL s_transaction_end('Y','0')
   
   CLOSE azzi950_cl
 
   #流程通知預埋點-D
   CALL cl_flow_notify(g_gzpa_m.gzpa001,'D')
    
END FUNCTION
 
{</section>}
 
{<section id="azzi950.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION azzi950_b_fill()
   {<Local define>}
   DEFINE p_wc2      STRING
   {</Local define>}
   #add-point:b_fill段define
   {<point name="b_fill.define"/>}
   #end add-point     
 
   CALL g_gzpb_d.clear()    #g_gzpb_d 單頭及單身 
 
 
   #add-point:b_fill段sql_before
   {<point name="b_fill.sql_before"/>}
   #end add-point
   
   #判斷是否填充
   IF azzi950_fill_chk(1) THEN
   
      LET g_sql = "SELECT  UNIQUE gzpb002,gzpb003,'',gzpb004,gzpb005 FROM gzpb_t",   
                  " INNER JOIN gzpa_t ON gzpa001 = gzpb001 ",
 
                  #"",
                  
                  "",
                  " WHERE gzpbent=? AND gzpb001=?"
      #add-point:b_fill段sql_before
      {<point name="b_fill.body.fill_sql"/>}
      #end add-point
      IF NOT cl_null(g_wc2_table1) THEN
         LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
      END IF
      
      #子單身的WC
      
      
      LET g_sql = g_sql, " ORDER BY gzpb_t.gzpb002"
      
      #add-point:單身填充控制
      {<point name="b_fill.sql"/>}
      #end add-point
      
      PREPARE azzi950_pb FROM g_sql
      DECLARE b_fill_cs CURSOR FOR azzi950_pb
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs USING g_enterprise,g_gzpa_m.gzpa001
 
                                               
      FOREACH b_fill_cs INTO g_gzpb_d[l_ac].gzpb002,g_gzpb_d[l_ac].gzpb003,g_gzpb_d[l_ac].gzpb003_desc, 
          g_gzpb_d[l_ac].gzpb004,g_gzpb_d[l_ac].gzpb005
         IF SQLCA.sqlcode THEN
            CALL cl_err("FOREACH:",SQLCA.sqlcode,1)
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充
         {<point name="b_fill.fill"/>}
         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec AND g_error_show = 1 THEN
            CALL cl_err( '', 9035, 1)
            EXIT FOREACH
         END IF
         
      END FOREACH
      LET g_error_show = 0
   
   END IF
   
 
   
   #add-point:browser_fill段其他table處理
   {<point name="browser_fill.other_fill"/>}
   #end add-point
   
   CALL g_gzpb_d.deleteElement(g_gzpb_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE azzi950_pb
 
   
END FUNCTION
 
{</section>}
 
{<section id="azzi950.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION azzi950_delete_b(ps_table,ps_keys_bak,ps_page)
   {<Local define>}
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   {</Local define>}
   #add-point:delete_b段define
   {<point name="delete_b.define"/>}
   #end add-point     
 
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前
      {<point name="delete_b.b_delete" mark="Y"/>}
      #end add-point    
      DELETE FROM gzpb_t
       WHERE gzpbent = g_enterprise AND
         gzpb001 = ps_keys_bak[1] AND gzpb002 = ps_keys_bak[2]
      #add-point:delete_b段刪除中
      {<point name="delete_b.m_delete"/>}
      #end add-point    
      IF SQLCA.sqlcode THEN
         CALL cl_err("",SQLCA.sqlcode,0)
      END IF
      #add-point:delete_b段刪除後
      {<point name="delete_b.a_delete"/>}
      #end add-point   
   END IF
   
 
   
 
   
   #add-point:delete_b段other
   {<point name="delete_b.other"/>}
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="azzi950.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION azzi950_insert_b(ps_table,ps_keys,ps_page)
   {<Local define>}
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   {</Local define>}
   #add-point:insert_b段define
   {<point name="insert_b.define"/>}
   #end add-point     
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前
      {<point name="insert_b.before_insert" mark="Y"/>}
      #end add-point 
      INSERT INTO gzpb_t
                  (gzpbent,
                   gzpb001,
                   gzpb002
                   ,gzpb003,gzpb004,gzpb005) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_gzpb_d[g_detail_idx].gzpb003,g_gzpb_d[g_detail_idx].gzpb004,g_gzpb_d[g_detail_idx].gzpb005) 
 
      #add-point:insert_b段資料新增中
      {<point name="insert_b.m_insert"/>}
      #end add-point 
      IF SQLCA.sqlcode THEN
         CALL cl_err("gzpb_t",SQLCA.sqlcode,0)
      END IF
      #add-point:insert_b段資料新增後
      {<point name="insert_b.after_insert"/>}
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other
   {<point name="insert_b.other"/>}
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="azzi950.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION azzi950_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   {<Local define>}
   DEFINE ps_table         STRING
   DEFINE ps_page          STRING
   DEFINE ps_keys          DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group         STRING
   DEFINE li_idx           LIKE type_t.num5 
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   {</Local define>}
   #add-point:update_b段define
   {<point name="update_b.define"/>}
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
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "gzpb_t" THEN
      #add-point:update_b段修改前
      {<point name="update_b.before_update" mark="Y"/>}
      #end add-point     
      UPDATE gzpb_t 
         SET (gzpb001,
              gzpb002
              ,gzpb003,gzpb004,gzpb005) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_gzpb_d[g_detail_idx].gzpb003,g_gzpb_d[g_detail_idx].gzpb004,g_gzpb_d[g_detail_idx].gzpb005)  
 
         WHERE gzpbent = g_enterprise AND gzpb001 = ps_keys_bak[1] AND gzpb002 = ps_keys_bak[2]
      #add-point:update_b段修改中
      {<point name="update_b.m_update"/>}
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            CALL cl_err("gzpb_t","std-00009",1)
            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            CALL cl_err("gzpb_t",SQLCA.sqlcode,1)  
            CALL s_transaction_end('N','0')
         OTHERWISE
            
      END CASE
      #add-point:update_b段修改後
      {<point name="update_b.after_update"/>}
      #end add-point  
   END IF
   
 
   
 
   
 
   
   #add-point:update_b段other
   {<point name="update_b.other"/>}
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="azzi950.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION azzi950_lock_b(ps_table,ps_page)
   {<Local define>}
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   {</Local define>}
   #add-point:lock_b段define
   {<point name="lock_b.define"/>}
   #end add-point   
   
   #先刷新資料
   #CALL azzi950_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "gzpb_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN azzi950_bcl USING g_enterprise,
                                       g_gzpa_m.gzpa001,g_gzpb_d[g_detail_idx].gzpb002
                                       
      IF SQLCA.sqlcode THEN
         CALL cl_err("azzi950_bcl",SQLCA.sqlcode,1)
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
 
   
   #add-point:lock_b段other
   {<point name="lock_b.other"/>}
   #end add-point  
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="azzi950.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION azzi950_unlock_b(ps_table,ps_page)
   {<Local define>}
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   {</Local define>}
   #add-point:unlock_b段define
   {<point name="unlock_b.define"/>}
   #end add-point  
   
   LET ls_group = "'1',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE azzi950_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other
   {<point name="unlock_b.other"/>}
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="azzi950.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION azzi950_set_entry(p_cmd)
   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1  
   {</Local define>}
   #add-point:set_entry段define
   {<point name="set_entry.define"/>}
   #end add-point       
 
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("gzpa001",TRUE)
      #add-point:set_entry段欄位控制
      {<point name="set_entry.field_control"/>}
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後
   {<point name="set_entry.after_control"/>}
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="azzi950.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION azzi950_set_no_entry(p_cmd)
   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1   
   {</Local define>}
   #add-point:set_no_entry段define
   {<point name="set_no_entry.define"/>}
   #end add-point     
 
   IF p_cmd = 'u' THEN
      CALL cl_set_comp_entry("gzpa001",FALSE)
      #add-point:set_no_entry段欄位控制
      {<point name="set_no_entry.field_control"/>}
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後
   {<point name="set_no_entry.after_control"/>}
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="azzi950.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION azzi950_set_entry_b(p_cmd)
   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1   
   {</Local define>}
   #add-point:set_entry_b段define
   {<point name="set_entry_b.define"/>}
   #end add-point     
   #add-point:set_entry_b段
   {<point name="set_entry_b.set_entry_b"/>}
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="azzi950.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION azzi950_set_no_entry_b(p_cmd)
   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1   
   {</Local define>}
   #add-point:set_no_entry_b段define
   {<point name="set_no_entry_b.define"/>}
   #end add-point    
   #add-point:set_no_entry_b段
   {<point name="set_no_entry_b.set_no_entry_b"/>}
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="azzi950.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION azzi950_default_search()
   {<Local define>}
   DEFINE li_idx  LIKE type_t.num5
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE ls_wc   STRING
   {</Local define>}
   #add-point:default_search段define
   {<point name="default_search.define"/>}
   #end add-point  
   
   #add-point:default_search段開始前
   {<point name="default_search.before"/>}
   #end add-point  
   
   LET g_pagestart = 1
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   IF NOT cl_null(g_argv[1]) THEN
      LET ls_wc = ls_wc, " gzpa001 = '", g_argv[1], "' AND "
   END IF
   
 
   
   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_default = TRUE
   ELSE
      LET g_default = FALSE
      #預設查詢條件
      LET g_wc = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=1"
      END IF
   END IF
   
   #add-point:default_search段結束前
   {<point name="default_search.after"/>}
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="azzi950.state_change" >}
   #+ 此段落由子樣板a09產生
#+ 確認碼變更
PRIVATE FUNCTION azzi950_statechange()
   {<Local define>}
   DEFINE lc_state LIKE type_t.chr5
   {</Local define>}
   #add-point:statechange段define
   {<point name="statechange.define"/>}
   #end add-point  
   
   #add-point:statechange段開始前
   {<point name="statechange.before"/>}
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_gzpa_m.gzpa001 IS NULL
 
   THEN
      CALL cl_err("","std-00003",0)
      RETURN
   END IF
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         CASE g_gzpa_m.gzpastus
            WHEN "N"
               HIDE OPTION "inactive"
            WHEN "Y"
               HIDE OPTION "active"
 
 
            
         END CASE
     
      #add-point:menu前
      {<point name="statechange.before_menu"/>}
      #end add-point
      
      ON ACTION inactive
         LET lc_state = "N"
         #add-point:action控制
         {<point name="statechange.inactive"/>}
         #end add-point
         EXIT MENU
      ON ACTION active
         LET lc_state = "Y"
         #add-point:action控制
         {<point name="statechange.active"/>}
         #end add-point
         EXIT MENU
 
 
      
      
      
      #add-point:stus控制
      {<point name="statechange.more_control"/>}
      #end add-point
      
   END MENU
   
   IF (lc_state <> "N" 
      AND lc_state <> "Y"
 
 
      ) OR 
      cl_null(lc_state) THEN
      RETURN
   END IF
   
   #add-point:stus修改前
   {<point name="statechange.b_update"/>}
   #end add-point
      
   UPDATE gzpa_t SET gzpastus = lc_state 
    WHERE gzpaent = g_enterprise AND gzpa001 = g_gzpa_m.gzpa001
 
  
   IF SQLCA.sqlcode THEN
      CALL cl_err("",SQLCA.sqlcode,0)
   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
 
 
         
      END CASE
      LET g_gzpa_m.gzpastus = lc_state
      DISPLAY BY NAME g_gzpa_m.gzpastus
   END IF
 
   #add-point:stus修改後
   {<point name="statechange.a_update"/>}
   #end add-point
 
   #add-point:statechange段結束前
   {<point name="statechange.after"/>}
   #end add-point  
 
END FUNCTION
 
 
 
{</section>}
 
{<section id="azzi950.idx_chk" >}
#+ 單身筆數變更
PRIVATE FUNCTION azzi950_idx_chk()
   #add-point:idx_chk段define
   {<point name="idx_chk.define"/>}
   #end add-point  
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_gzpb_d.getLength() THEN
         LET g_detail_idx = g_gzpb_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_gzpb_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_gzpb_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other
   {<point name="idx_chk.other"/>}
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="azzi950.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION azzi950_b_fill2(pi_idx)
   {<Local define>}
   DEFINE pi_idx          LIKE type_t.num5
   DEFINE li_ac           LIKE type_t.num5
   DEFINE ls_chk          LIKE type_t.chr1
   {</Local define>}
   #add-point:b_fill2段define
   {<point name="b_fill2.define"/>}
   #end add-point
   
   LET li_ac = l_ac 
   
 
      
   #add-point:單身填充後
   {<point name="b_fill2.after_fill" />}
    CALL g_schedule_d.clear()    #g_schedule_d 單身


    #判斷是否填充
   #IF azzi950_fill_chk(1) THEN
   
      LET g_sql = "SELECT  UNIQUE gzpe003 ,gzpe004,'','',gzpe005 FROM gzpb_t",   
                  " INNER JOIN gzpa_t ON gzpa001 = gzpb001 ",
 
                  #140316 
                  " INNER JOIN gzpe_t ON gzpe001 = gzpb001 AND gzpe002 = gzpb002 ",
                  
                  #140316
                  "",
                  " WHERE gzpbent=? AND gzpb001=?"

      IF NOT cl_null(g_wc3_table1) THEN
         LET g_sql = g_sql CLIPPED, " AND ", g_wc3_table1 CLIPPED
      END IF
      
      #子單身的WC
      
      
      LET g_sql = g_sql, " ORDER BY gzpb_t.gzpb001"
      

      
      PREPARE azzi950_pb2 FROM g_sql
      DECLARE b_fill_cs2 CURSOR FOR azzi950_pb2
      
      LET g_cnt = l_ac
      LET l_ac = 1
      OPEN b_fill_cs2 USING g_enterprise,g_gzpa_m.gzpa001
 
      FOREACH b_fill_cs2 INTO g_schedule_d[l_ac].gzpe003,g_schedule_d[l_ac].gzpe004,g_schedule_d[l_ac].gzpe004_desc,
                              g_schedule_d[l_ac].addr,g_schedule_d[l_ac].gzpe005 

         IF SQLCA.sqlcode THEN
            CALL cl_err("FOREACH:",SQLCA.sqlcode,1)
            EXIT FOREACH
         END IF

         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = '2'
         LET g_ref_fields[2] = g_schedule_d[l_ac].gzpe004
         CALL ap_ref_array2(g_ref_fields,"SELECT oofa011 FROM oofa_t WHERE oofaent='"||g_enterprise||"' AND oofa002=? AND oofa003=? ","") RETURNING g_rtn_fields
         LET g_schedule_d[l_ac].gzpe004_desc = '', g_rtn_fields[1] , ''
            
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_schedule_d[l_ac].gzpe004
         CALL ap_ref_array2(g_ref_fields,"SELECT gzxa004 FROM gzxa_t WHERE gzxa003=? ","") RETURNING g_rtn_fields
         LET g_schedule_d[l_ac].addr = '', g_rtn_fields[1] , ''

         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec AND g_error_show = 1 THEN
            CALL cl_err( '', 9035, 1)
            EXIT FOREACH
         END IF

      END FOREACH
      LET g_error_show = 0
   
   #END IF
   CALL g_schedule_d.deleteElement(g_gzpb_d.getLength())
 
   #LET l_ac = g_cnt
   #LET g_cnt = 0  
   FREE azzi950_pb2
   #LET l_ac = li_ac
   
   #CALL azzi950_detail_show()
   
END FUNCTION
 
{</section>}
 
{<section id="azzi950.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION azzi950_fill_chk(ps_idx)
   {<Local define>}
   DEFINE ps_idx        LIKE type_t.chr10
   {</Local define>}
   #add-point:fill_chk段define
   {<point name="fill_chk.define"/>}
   #end add-point
   
   #全部為1=1 or null時回傳true
   IF (cl_null(g_wc2_table1) OR g_wc2_table1.trim() = '1=1') THEN
      #add-point:fill_chk段define
      {<point name="fill_chk.other_chk"/>}
      #end add-point
      RETURN TRUE
   END IF
   
   #第一單身
   IF ps_idx = 1 AND
      ((NOT cl_null(g_wc2_table1) AND g_wc2_table1.trim() <> '1=1')) THEN
      RETURN TRUE
   END IF
   
   #根據wc判定是否需要填充
 
 
   RETURN FALSE
 
END FUNCTION
 
{</section>}
 
{<section id="azzi950.signature" >}
   
 
{</section>}
 
{<section id="azzi950.other_function" >}
   
{<point name="other.function"/>}
PRIVATE FUNCTION azzi950_chk_token()
   DEFINE lc_gzpa009 LIKE gzpa_t.gzpa009
   DEFINE lc_gzpa011 LIKE gzpa_t.gzpa011
   DEFINE lc_gzpa013 LIKE gzpa_t.gzpa013
   DEFINE lc_gzpa014 LIKE gzpa_t.gzpa014
   DEFINE li_cnt LIKE type_t.num5
   

   SELECT gzpa009,gzpa011,gzpa013,gzpa014 
      INTO lc_gzpa009,lc_gzpa011,lc_gzpa013,lc_gzpa014 FROM gzpa_t 
      WHERE gzpa001 = g_gzpa_m.gzpa001 
      AND gzpaent = g_enterprise 

   DISPLAY "lc_gzpa009:",lc_gzpa009 
   DISPLAY "lc_gzpa011:",lc_gzpa011
   DISPLAY "lc_gzpa013:",lc_gzpa013
   DISPLAY "lc_gzpa014:",lc_gzpa014 
   
   LET li_cnt =  1   

   FOR li_cnt = 1 TO 3 

      CASE li_cnt
      
         WHEN 1
            #月別:0 每月:1
            IF g_gzpa_m.gzpa008 = "0" THEN 
               CALL azzi950_token(lc_gzpa009,"gzpa009") 
            END IF 

         WHEN 2
            # 每周:0 週別:1
            IF g_gzpa_m.gzpa010 = "1" THEN 
               CALL azzi950_token(lc_gzpa011,"gzpa011")  
            END IF
         WHEN 3
            #週間:3 日別:2 任選:1 每日:0
           IF g_gzpa_m.gzpa012 = "1" OR g_gzpa_m.gzpa012 = "2" 
              OR g_gzpa_m.gzpa012 = "3" THEN 
              CALL azzi950_token(lc_gzpa013,"gzpa013") 
              CALL azzi950_token(lc_gzpa014,"gzpa014")
           END IF  
      END CASE 
      

   END FOR 
      --CASE 
         --WHEN g_gzpa_m.gzpa008 = "0" #月別:0 每月:1
           --CALL azzi950_token(lc_gzpa009,"gzpa009") 
         --WHEN g_gzpa_m.gzpa010 = "1" # 每周:0 週別:1
            --CALL azzi950_token(lc_gzpa011,"gzpa011") 
         --WHEN g_gzpa_m.gzpa012 = "1" OR g_gzpa_m.gzpa012 = "2" OR g_gzpa_m.gzpa012 = "3"
           #週間:3 日別:2 任選:1 每日:0
           --CALL azzi950_token(lc_gzpa013,"gzpa013") 
           --CALL azzi950_token(lc_gzpa014,"gzpa014") 
       --END CASE  
  
END FUNCTION 


PRIVATE FUNCTION azzi950_token(ps_token,pd_field)
   DEFINE ps_token   STRING 
   DEFINE l_token    base.StringTokenizer
   DEFINE ls_token   STRING 
   DEFINE pd_field   STRING 

   LET ps_token = ps_token.trim()



   #針對參數組進行token
   LET l_token = base.StringTokenizer.create(ps_token,",")

   WHILE l_token.hasMoreTokens() 
      LET ls_token = l_token.nextToken()
          CALL azzi950_chk_mapping(ls_token,pd_field) 
    END WHILE

END FUNCTION 

PRIVATE FUNCTION azzi950_chk_mapping(ls_token,ps_field)
  DEFINE ls_token  STRING 
  DEFINE ps_field  STRING 
   
  CASE 
     WHEN ls_token = "0"
        CASE 
           #WHEN pd_field = "gzpa010"
           #   LET g_gzpa_m = "Y" 

           WHEN ps_field = "gzpa011"

           WHEN ps_field = "gzpa013"
              LET g_gzpa_m.wd0 = "Y"
           WHEN ps_field = "gzpa014" 
              #LET g_gzpa_m.d01 = "Y"
        END CASE 

     WHEN ls_token = "1"
        CASE 
           WHEN ps_field = "gzpa009" 
              LET g_gzpa_m.m01 = "Y"
           WHEN ps_field = "gzpa011"
              LET g_gzpa_m.wk1 = "Y" 
           WHEN ps_field = "gzpa013"
              LET g_gzpa_m.wd1 = "Y"
           WHEN ps_field = "gzpa014"
              LET g_gzpa_m.d01 = "Y" 
        END CASE 
     WHEN ls_token = "2"
        CASE 
           WHEN ps_field = "gzpa009" 
              LET g_gzpa_m.m02 = "Y"
           WHEN ps_field = "gzpa011"
              LET g_gzpa_m.wk2 = "Y" 
           WHEN ps_field = "gzpa013"
              LET g_gzpa_m.wd2 = "Y"
           WHEN ps_field = "gzpa014"
              LET g_gzpa_m.d02 = "Y" 
        END CASE
     WHEN ls_token = "3"
        CASE 
           WHEN ps_field = "gzpa009" 
              LET g_gzpa_m.m03 = "Y"
           WHEN ps_field = "gzpa011"
              LET g_gzpa_m.wk3 = "Y" 
           WHEN ps_field = "gzpa013"
              LET g_gzpa_m.wd3 = "Y"
           WHEN ps_field = "gzpa014"
              LET g_gzpa_m.d03 = "Y" 
        END CASE
     WHEN ls_token = "4"
        CASE 
           WHEN ps_field = "gzpa009" 
              LET g_gzpa_m.m04 = "Y"
           WHEN ps_field = "gzpa011"
              LET g_gzpa_m.wk4 = "Y" 
           WHEN ps_field = "gzpa013"
              LET g_gzpa_m.wd4 = "Y"
           WHEN ps_field = "gzpa014"
              LET g_gzpa_m.d04 = "Y" 
        END CASE
     WHEN ls_token = "5"
        CASE 
           WHEN ps_field = "gzpa009" 
              LET g_gzpa_m.m05 = "Y"
           WHEN ps_field = "gzpa011"
              LET g_gzpa_m.wk5 = "Y" 
           WHEN ps_field = "gzpa013"
              LET g_gzpa_m.wd5 = "Y"
           WHEN ps_field = "gzpa014"
              LET g_gzpa_m.d05 = "Y" 
        END CASE
     WHEN ls_token = "6"
        CASE 
           WHEN ps_field = "gzpa009" 
              LET g_gzpa_m.m06 = "Y"
           WHEN ps_field = "gzpa011"
              #LET g_gzpa_m.wk6 = "Y" 
           WHEN ps_field = "gzpa013"
              LET g_gzpa_m.wd6 = "Y"
           WHEN ps_field = "gzpa014"
              LET g_gzpa_m.d06 = "Y" 
        END CASE
     WHEN ls_token = "7"
        CASE 
           WHEN ps_field = "gzpa009" 
              LET g_gzpa_m.m07 = "Y"
           WHEN ps_field = "gzpa011"
              #LET g_gzpa_m.wk7 = "Y" 
           WHEN ps_field = "gzpa013"
              #LET g_gzpa_m.wd7 = "Y"
           WHEN ps_field = "gzpa014"
              LET g_gzpa_m.d07 = "Y" 
        END CASE
     WHEN ls_token = "8"
        CASE 
           WHEN ps_field = "gzpa009" 
              LET g_gzpa_m.m08 = "Y"
           WHEN ps_field = "gzpa011"
              #LET g_gzpa_m.wk8 = "Y" 
           WHEN ps_field = "gzpa013"
              #LET g_gzpa_m.wd8 = "Y"
           WHEN ps_field = "gzpa014"
              LET g_gzpa_m.d08 = "Y" 
        END CASE
     WHEN ls_token = "9"
        CASE 
           WHEN ps_field = "gzpa009" 
              LET g_gzpa_m.m09 = "Y"
           WHEN ps_field = "gzpa011"
              #LET g_gzpa_m.wk9 = "Y" 
           WHEN ps_field = "gzpa013"
              #LET g_gzpa_m.wd9 = "Y"
           WHEN ps_field = "gzpa014"
              LET g_gzpa_m.d09 = "Y" 
        END CASE
     WHEN ls_token = "10"
        CASE 
           WHEN ps_field = "gzpa009" 
              LET g_gzpa_m.m10 = "Y"
           WHEN ps_field = "gzpa011"
              #LET g_gzpa_m.wk8 = "Y" 
           WHEN ps_field = "gzpa013"
              #LET g_gzpa_m.wd8 = "Y"
           WHEN ps_field = "gzpa014"
              LET g_gzpa_m.d10 = "Y" 
        END CASE
     WHEN ls_token = "11"
        CASE 
           WHEN ps_field = "gzpa009" 
              LET g_gzpa_m.m11 = "Y"
           WHEN ps_field = "gzpa011"
              #LET g_gzpa_m.wk8 = "Y" 
           WHEN ps_field = "gzpa013"
              #LET g_gzpa_m.wd8 = "Y"
           WHEN ps_field = "gzpa014"
              LET g_gzpa_m.d11 = "Y" 
        END CASE
     WHEN ls_token = "12"
        CASE 
           WHEN ps_field = "gzpa009" 
              LET g_gzpa_m.m12 = "Y"
           WHEN ps_field = "gzpa011"
              #LET g_gzpa_m.wk8 = "Y" 
           WHEN ps_field = "gzpa013"
              #LET g_gzpa_m.wd8 = "Y"
           WHEN ps_field = "gzpa014"
              LET g_gzpa_m.d12 = "Y" 
        END CASE
     WHEN ls_token = "13"
        CASE 
           WHEN ps_field = "gzpa009" 
              #LET g_gzpa_m.m11 = "Y"
           WHEN ps_field = "gzpa011"
              #LET g_gzpa_m.wk8 = "Y" 
           WHEN ps_field = "gzpa013"
              #LET g_gzpa_m.wd8 = "Y"
           WHEN ps_field = "gzpa014"
              LET g_gzpa_m.d13 = "Y" 
        END CASE
     WHEN ls_token = "14"
        CASE 
           WHEN ps_field = "gzpa009" 
              #LET g_gzpa_m.m11 = "Y"
           WHEN ps_field = "gzpa011"
              #LET g_gzpa_m.wk8 = "Y" 
           WHEN ps_field = "gzpa013"
              #LET g_gzpa_m.wd8 = "Y"
           WHEN ps_field = "gzpa014"
              LET g_gzpa_m.d14 = "Y" 
        END CASE
     WHEN ls_token = "15"
        CASE 
           WHEN ps_field = "gzpa009" 
              #LET g_gzpa_m.m11 = "Y"
           WHEN ps_field = "gzpa011"
              #LET g_gzpa_m.wk8 = "Y" 
           WHEN ps_field = "gzpa013"
              #LET g_gzpa_m.wd8 = "Y"
           WHEN ps_field = "gzpa014"
              LET g_gzpa_m.d15 = "Y" 
        END CASE
     WHEN ls_token = "16"
        CASE 
           WHEN ps_field = "gzpa009" 
              #LET g_gzpa_m.m11 = "Y"
           WHEN ps_field = "gzpa011"
              #LET g_gzpa_m.wk8 = "Y" 
           WHEN ps_field = "gzpa013"
              #LET g_gzpa_m.wd8 = "Y"
           WHEN ps_field = "gzpa014"
              LET g_gzpa_m.d16 = "Y" 
        END CASE
     WHEN ls_token = "17"
        CASE 
           WHEN ps_field = "gzpa009" 
              #LET g_gzpa_m.m11 = "Y"
           WHEN ps_field = "gzpa011"
              #LET g_gzpa_m.wk8 = "Y" 
           WHEN ps_field = "gzpa013"
              #LET g_gzpa_m.wd8 = "Y"
           WHEN ps_field = "gzpa014"
              LET g_gzpa_m.d17 = "Y" 
        END CASE
     WHEN ls_token = "18"
        CASE 
           WHEN ps_field = "gzpa009" 
              #LET g_gzpa_m.m11 = "Y"
           WHEN ps_field = "gzpa011"
              #LET g_gzpa_m.wk8 = "Y" 
           WHEN ps_field = "gzpa013"
              #LET g_gzpa_m.wd8 = "Y"
           WHEN ps_field = "gzpa014"
              LET g_gzpa_m.d18 = "Y" 
        END CASE
     WHEN ls_token = "19"
        CASE 
           WHEN ps_field = "gzpa009" 
              #LET g_gzpa_m.m11 = "Y"
           WHEN ps_field = "gzpa011"
              #LET g_gzpa_m.wk8 = "Y" 
           WHEN ps_field = "gzpa013"
              #LET g_gzpa_m.wd8 = "Y"
           WHEN ps_field = "gzpa014"
              LET g_gzpa_m.d19 = "Y" 
        END CASE
     WHEN ls_token = "20"
        CASE 
           WHEN ps_field = "gzpa009" 
              #LET g_gzpa_m.m11 = "Y"
           WHEN ps_field = "gzpa011"
              #LET g_gzpa_m.wk8 = "Y" 
           WHEN ps_field = "gzpa013"
              #LET g_gzpa_m.wd8 = "Y"
           WHEN ps_field = "gzpa014"
              LET g_gzpa_m.d20 = "Y" 
        END CASE
     WHEN ls_token = "21"
        CASE 
           WHEN ps_field = "gzpa009" 
              #LET g_gzpa_m.m11 = "Y"
           WHEN ps_field = "gzpa011"
              #LET g_gzpa_m.wk8 = "Y" 
           WHEN ps_field = "gzpa013"
              #LET g_gzpa_m.wd8 = "Y"
           WHEN ps_field = "gzpa014"
              LET g_gzpa_m.d21 = "Y" 
        END CASE
     WHEN ls_token = "22"
        CASE 
           WHEN ps_field = "gzpa009" 
              #LET g_gzpa_m.m11 = "Y"
           WHEN ps_field = "gzpa011"
              #LET g_gzpa_m.wk8 = "Y" 
           WHEN ps_field = "gzpa013"
              #LET g_gzpa_m.wd8 = "Y"
           WHEN ps_field = "gzpa014"
              LET g_gzpa_m.d22 = "Y" 
        END CASE
     WHEN ls_token = "23"
        CASE 
           WHEN ps_field = "gzpa009" 
              #LET g_gzpa_m.m11 = "Y"
           WHEN ps_field = "gzpa011"
              #LET g_gzpa_m.wk8 = "Y" 
           WHEN ps_field = "gzpa013"
              #LET g_gzpa_m.wd8 = "Y"
           WHEN ps_field = "gzpa014"
              LET g_gzpa_m.d23 = "Y" 
        END CASE
     WHEN ls_token = "24"
        CASE 
           WHEN ps_field = "gzpa009" 
              #LET g_gzpa_m.m11 = "Y"
           WHEN ps_field = "gzpa011"
              #LET g_gzpa_m.wk8 = "Y" 
           WHEN ps_field = "gzpa013"
              #LET g_gzpa_m.wd8 = "Y"
           WHEN ps_field = "gzpa014"
              LET g_gzpa_m.d24 = "Y" 
        END CASE
     WHEN ls_token = "25"
        CASE 
           WHEN ps_field = "gzpa009" 
              #LET g_gzpa_m.m11 = "Y"
           WHEN ps_field = "gzpa011"
              #LET g_gzpa_m.wk8 = "Y" 
           WHEN ps_field = "gzpa013"
              #LET g_gzpa_m.wd8 = "Y"
           WHEN ps_field = "gzpa014"
              LET g_gzpa_m.d25 = "Y" 
        END CASE
     WHEN ls_token = "26"
        CASE 
           WHEN ps_field = "gzpa014"
              LET g_gzpa_m.d26 = "Y" 
        END CASE
     WHEN ls_token = "27"
        CASE 
           WHEN ps_field = "gzpa014"
              LET g_gzpa_m.d27 = "Y" 
        END CASE
     WHEN ls_token = "28"
        CASE 
           WHEN ps_field = "gzpa014"
              LET g_gzpa_m.d28 = "Y" 
        END CASE
     WHEN ls_token = "29"
        CASE 
           WHEN ps_field = "gzpa014"
              LET g_gzpa_m.d29 = "Y" 
        END CASE
     WHEN ls_token = "30"
        CASE 
           WHEN ps_field = "gzpa014"
              LET g_gzpa_m.d30 = "Y" 
        END CASE
     WHEN ls_token = "31"
        CASE 
           WHEN ps_field = "gzpa014"
              LET g_gzpa_m.d31 = "Y" 
        END CASE
     WHEN ls_token = "den"
        CASE 
           WHEN ps_field = "gzpa014"
              LET g_gzpa_m.den = "Y" 
        END CASE
  END CASE 

END FUNCTION 

PRIVATE FUNCTION azzi950_schedule_init()

   #指定時間執行
   CALL cl_schedule_init_assign_time_info()
   #執行時間設定  
   CALL cl_schedule_init_exec_time_info()
   #特殊指定 
   CALL cl_schedule_init_special_info("N","N")


   
   #月份
   --CALL cl_schedule_init_month_info("N",g_gzpa_m.gzpa008)
   #第幾週
   --CALL cl_schedule_init_week_info("N",g_gzpa_m.gzpa010)
   #星期日-星期六
   --CALL cl_schedule_init_weekday_info("N")
   #日 1-31
   --CALL cl_schedule_init_day_info("N",g_gzpa_m.gzpa012)
--
   #指定執行時間  
   --CALL cl_schedule_init_assign_exec_info("1",NULL,"N")
   
   
END FUNCTION 


PRIVATE FUNCTION azzi950_combination()

   #gzpa006 LIKE gzpa_t.gzpa006, 
   #gzpa007 LIKE gzpa_t.gzpa007, 
   #gzpa008 LIKE gzpa_t.gzpa008, 

   #LET g_gzpa_m.gzpa008 = g_schedule.gzpa008 
   LET g_gzpa_m.m01 = g_schedule.m01
   LET g_gzpa_m.m02 = g_schedule.m02 
   LET g_gzpa_m.m03 = g_schedule.m03 
   LET g_gzpa_m.m04 = g_schedule.m04
   LET g_gzpa_m.m05 = g_schedule.m05
   LET g_gzpa_m.m06 = g_schedule.m06
   LET g_gzpa_m.m07 = g_schedule.m07
   LET g_gzpa_m.m08 = g_schedule.m08
   LET g_gzpa_m.m09 = g_schedule.m09 
   LET g_gzpa_m.m10 = g_schedule.m10 
   LET g_gzpa_m.m11 = g_schedule.m11 
   LET g_gzpa_m.m12 = g_schedule.m12 
   #LET g_gzpa_m.gzpa010 = g_schedule.gzpa010 
   LET g_gzpa_m.wk1 = g_schedule.wk1
   LET g_gzpa_m.wk2 = g_schedule.wk2 
   LET g_gzpa_m.wk3 = g_schedule.wk3 
   LET g_gzpa_m.wk4 = g_schedule.wk4
   LET g_gzpa_m.wk5 = g_schedule.wk5 
   #LET g_gzpa_m.gzpa012 = g_schedule.gzpa012
   LET g_gzpa_m.wd0 = g_schedule.wd0 
   LET g_gzpa_m.wd1 = g_schedule.wd1 
   LET g_gzpa_m.wd2 = g_schedule.wd2 
   LET g_gzpa_m.wd3 = g_schedule.wd3
   LET g_gzpa_m.wd4 = g_schedule.wd4
   LET g_gzpa_m.wd5 = g_schedule.wd5 
   LET g_gzpa_m.wd6 = g_schedule.wd6 
   
   LET g_gzpa_m.d01 = g_schedule.d01 
   LET g_gzpa_m.d02 = g_schedule.d02 
   LET g_gzpa_m.d03 = g_schedule.d03 
   LET g_gzpa_m.d04 = g_schedule.d04 
   LET g_gzpa_m.d05 = g_schedule.d05
   LET g_gzpa_m.d06 = g_schedule.d06 
   LET g_gzpa_m.d07 = g_schedule.d07 
   LET g_gzpa_m.d08 = g_schedule.d08 
   LET g_gzpa_m.d09 = g_schedule.d09 
   LET g_gzpa_m.d10 = g_schedule.d10 
   LET g_gzpa_m.d11 = g_schedule.d11 
   LET g_gzpa_m.d12 = g_schedule.d12 
   LET g_gzpa_m.d13 = g_schedule.d13
   LET g_gzpa_m.d14 = g_schedule.d14 
   LET g_gzpa_m.d15 = g_schedule.d15 
   LET g_gzpa_m.d16 = g_schedule.d16 
   LET g_gzpa_m.d17 = g_schedule.d17 
   LET g_gzpa_m.d18 = g_schedule.d18 
   LET g_gzpa_m.d19 = g_schedule.d19 
   LET g_gzpa_m.d20 = g_schedule.d20 
   LET g_gzpa_m.d21 = g_schedule.d21 
   LET g_gzpa_m.d22 = g_schedule.d22 
   LET g_gzpa_m.d23 = g_schedule.d23 
   LET g_gzpa_m.d24 = g_schedule.d24 
   LET g_gzpa_m.d25 = g_schedule.d25 
   LET g_gzpa_m.d26 = g_schedule.d26 
   LET g_gzpa_m.d27 = g_schedule.d27 
   LET g_gzpa_m.d28 = g_schedule.d28 
   LET g_gzpa_m.d29 = g_schedule.d29 
   LET g_gzpa_m.d30 = g_schedule.d30
   LET g_gzpa_m.d31 = g_schedule.d31
   LET g_gzpa_m.den = g_schedule.den

   #LET g_gzpa_m.gzpa015 = g_schedule.gzpa015 
   #LET g_gzpa_m.gzpa016 = g_schedule.gzpa016 

   LET g_gzpa_m.sc1 = g_schedule.sc1
   
   #LET g_gzpa_m.gzpa017 = g_schedule.gzpa017
   #LET g_gzpa_m.gzpa018 = g_schedule.gzpa018 
   #LET g_gzpa_m.gzpa019 = g_schedule.gzpa019 
   #LET g_gzpa_m.gzpa020 = g_schedule.gzpa020 
   LET g_gzpa_m.sc2 = g_schedule.sc2

   #LET g_gzpa_m.gzpa021 = g_schedule.gzpa021
   #LET g_gzpa_m.gzpa022 = g_schedule.gzpa022 
   #LET g_gzpa_m.gzpa023 = g_schedule.gzpa023
   #LET g_gzpa_m.gzpa024 = g_schedule.gzpa024 

   LET g_gzpa_m.sc3 = g_schedule.sc3 

   #LET g_gzpa_m.gzpa025 = g_schedule.gzpa025
   #LET g_gzpa_m.gzpa026 = g_schedule.gzpa026 
   #LET g_gzpa_m.gzpa027 = g_schedule.gzpa027 
   #LET g_gzpa_m.gzpa028 = g_schedule.gzpa028 
   #LET g_gzpa_m.gzpa029 = g_schedule.gzpa029
   #LET g_gzpa_m.gzpa030 = g_schedule.gzpa030 
   #LET g_gzpa_m.gzpa031 = g_schedule.gzpa031
   CALL azzi950_extra_process_assign_exec()
END FUNCTION 

PRIVATE FUNCTION azzi950_extra_process_assign_exec()
   DEFINE li_i LIKE type_t.num5
   
   FOR li_i =  1 TO 3

       IF li_i = 1 THEN 
          IF NOT cl_null(g_gzpa_m.gzpa017) OR NOT cl_null(g_gzpa_m.gzpa018) OR 
               NOT cl_null(g_gzpa_m.gzpa019) OR NOT cl_null(g_gzpa_m.gzpa020) THEN 
             #LET g_schedule.gzpa015 = "2" 
             LET g_gzpa_m.sc1 = "Y"   
          END IF 
                
       END IF 

       IF li_i = 2 THEN 

           IF NOT cl_null(g_gzpa_m.gzpa021) OR NOT cl_null(g_gzpa_m.gzpa022) OR 
                    NOT cl_null(g_gzpa_m.gzpa023) OR NOT cl_null(g_gzpa_m.gzpa024) THEN 
                    #LET g_schedule.gzpa015 = "2"
                    LET g_gzpa_m.sc2 = "Y"   
           END IF
       END IF

       IF li_i = 3 THEN 
             IF NOT cl_null(g_gzpa_m.gzpa025) OR NOT cl_null(g_gzpa_m.gzpa026) OR 
                 NOT cl_null(g_gzpa_m.gzpa027) OR NOT cl_null(g_gzpa_m.gzpa028) THEN 
                #LET g_schedule.gzpa015 = "2"
                LET g_gzpa_m.sc3 = "Y"   
             END IF
       END IF 
             
    END FOR
END FUNCTION 
{</section>}
 
