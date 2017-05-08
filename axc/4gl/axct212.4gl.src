#該程式已解開Section, 不再透過樣板產出!
{<section id="axct212.description" >}
#+ Version..: T100-ERP-1.00.00(SD版次:1,PR版次:1) Build-000055
#+ 
#+ Filename...: axct212
#+ Description: 工時費用成本次要素統計和作業
#+ Creator....: 00768(2014/09/11)
#+ Modifier...: 00768(2014/09/13) -SD/PR- 08734
#+ Buildtype..: 應用 i07 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="axct212.global" >}
#150916-00015#1  2015/12/7   By Xiaozg   1.快捷带出类似科目编号 2.当有账套时，科目检查改为检查是否存在于glad_t中
#160318-00025#11 2016/04/25  By 07675    將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160802-00020#5  2016/10/12  By 02040    增加帳套權限管控、法人權限管控
#161108-00012#4  2016/11/09  By 08734    g_browser_cnt 由num5改為num10
 
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
PRIVATE type type_g_xcdr_m        RECORD
       xcdrcomp LIKE xcdr_t.xcdrcomp, 
   xcdrcomp_desc LIKE type_t.chr80, 
   xcdrld LIKE xcdr_t.xcdrld, 
   xcdrld_desc LIKE type_t.chr80, 
   xcdr002 LIKE xcdr_t.xcdr002, 
   xcdr003 LIKE xcdr_t.xcdr003, 
   xcdr001 LIKE xcdr_t.xcdr001, 
   xcdr001_desc LIKE type_t.chr80
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_xcdr_d        RECORD
       xcdr004 LIKE xcdr_t.xcdr004, 
   xcdr005 LIKE xcdr_t.xcdr005, 
   xcau003 LIKE type_t.num10, 
   xcdr006 LIKE xcdr_t.xcdr006, 
   xcdr010 LIKE xcdr_t.xcdr010, 
   xcdr011 LIKE xcdr_t.xcdr011, 
   xcdr021 LIKE xcdr_t.xcdr021, 
   xcdr020 LIKE xcdr_t.xcdr020, 
   xcdr101 LIKE xcdr_t.xcdr101, 
   xcdr102 LIKE xcdr_t.xcdr102, 
   xcdr104 LIKE xcdr_t.xcdr104, 
   xcdr103 LIKE xcdr_t.xcdr103, 
   xcdr105 LIKE xcdr_t.xcdr105
       END RECORD
PRIVATE TYPE type_g_xcdr2_d RECORD
       xcdr004 LIKE xcdr_t.xcdr004, 
   xcdr005 LIKE xcdr_t.xcdr005, 
   xcau003 LIKE xcau_t.xcau003, 
   xcdr006 LIKE xcdr_t.xcdr006, 
   xcdr010 LIKE xcdr_t.xcdr010, 
   xcdr011 LIKE xcdr_t.xcdr011, 
   xcdr021 LIKE xcdr_t.xcdr021, 
   xcdr020 LIKE xcdr_t.xcdr020, 
   xcdr111 LIKE xcdr_t.xcdr111, 
   xcdr112 LIKE xcdr_t.xcdr112, 
   xcdr114 LIKE xcdr_t.xcdr114, 
   xcdr113 LIKE xcdr_t.xcdr113, 
   xcdr115 LIKE xcdr_t.xcdr115
       END RECORD
PRIVATE TYPE type_g_xcdr3_d RECORD
       xcdr004 LIKE xcdr_t.xcdr004, 
   xcdr005 LIKE xcdr_t.xcdr005, 
   xcau003 LIKE xcau_t.xcau003, 
   xcdr006 LIKE xcdr_t.xcdr006, 
   xcdr010 LIKE xcdr_t.xcdr010, 
   xcdr011 LIKE xcdr_t.xcdr011, 
   xcdr021 LIKE xcdr_t.xcdr021, 
   xcdr020 LIKE xcdr_t.xcdr020, 
   xcdr121 LIKE xcdr_t.xcdr121, 
   xcdr122 LIKE xcdr_t.xcdr122, 
   xcdr124 LIKE xcdr_t.xcdr124, 
   xcdr123 LIKE xcdr_t.xcdr123, 
   xcdr125 LIKE xcdr_t.xcdr125
       END RECORD
 
 
 
#模組變數(Module Variables)
DEFINE g_xcdr_m          type_g_xcdr_m
DEFINE g_xcdr_m_t        type_g_xcdr_m
DEFINE g_xcdr_m_o        type_g_xcdr_m
 
   DEFINE g_xcdrld_t LIKE xcdr_t.xcdrld
DEFINE g_xcdr002_t LIKE xcdr_t.xcdr002
DEFINE g_xcdr003_t LIKE xcdr_t.xcdr003
DEFINE g_xcdr001_t LIKE xcdr_t.xcdr001
 
 
DEFINE g_xcdr_d          DYNAMIC ARRAY OF type_g_xcdr_d
DEFINE g_xcdr_d_t        type_g_xcdr_d
DEFINE g_xcdr_d_o        type_g_xcdr_d
DEFINE g_xcdr2_d   DYNAMIC ARRAY OF type_g_xcdr2_d
DEFINE g_xcdr2_d_t type_g_xcdr2_d
DEFINE g_xcdr2_d_o type_g_xcdr2_d
DEFINE g_xcdr3_d   DYNAMIC ARRAY OF type_g_xcdr3_d
DEFINE g_xcdr3_d_t type_g_xcdr3_d
DEFINE g_xcdr3_d_o type_g_xcdr3_d
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_xcdrld LIKE xcdr_t.xcdrld,
      b_xcdr001 LIKE xcdr_t.xcdr001,
      b_xcdr002 LIKE xcdr_t.xcdr002,
      b_xcdr003 LIKE xcdr_t.xcdr003
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
DEFINE g_rec_b               LIKE type_t.num10    #161108-00012#4 num5==》num10         
DEFINE l_ac                  LIKE type_t.num10    #161108-00012#4 num5==》num10
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog
 
DEFINE g_pagestart           LIKE type_t.num10    #161108-00012#4 num5==》num10       
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁
DEFINE g_bfill               LIKE type_t.chr5              #是否刷新單身
 
DEFINE g_detail_cnt          LIKE type_t.num10              #單身總筆數   #161108-00012#4 num5==》num10
DEFINE g_detail_idx          LIKE type_t.num10              #單身目前所在筆數  #161108-00012#4 num5==》num10
DEFINE g_detail_idx2         LIKE type_t.num10              #單身2目前所在筆數  #161108-00012#4 num5==》num10
DEFINE g_browser_cnt         LIKE type_t.num10              #Browser總筆數   #161108-00012#4 num5==》num10
DEFINE g_browser_idx         LIKE type_t.num10              #Browser目前所在筆數   #161108-00012#4 num5==》num10
DEFINE g_temp_idx            LIKE type_t.num10              #Browser目前所在筆數(暫存用)  #161108-00012#4 num5==》num10
 
DEFINE g_searchcol           STRING                        #查詢欄位代碼
DEFINE g_searchstr           STRING                        #查詢欄位字串
DEFINE g_order               STRING                        #查詢排序欄位
DEFINE g_state               STRING                        
DEFINE g_insert              LIKE type_t.chr5              #是否導到其他page                    
DEFINE g_current_row         LIKE type_t.num10              #Browser所在筆數  #161108-00012#4 num5==》num10
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
 
#add-point:自定義模組變數(Module Variable)
DEFINE g_wc2_table2          STRING
DEFINE g_wc2_table3          STRING

DEFINE g_glaa001    LIKE glaa_t.glaa001 #使用幣別
DEFINE g_glaa002    LIKE glaa_t.glaa002 #匯率參照表號
DEFINE g_glaa003    LIKE glaa_t.glaa003 #會計週期參照表號
DEFINE g_glaa004    LIKE glaa_t.glaa004 #會計科目參照表號
DEFINE g_glaa015    LIKE glaa_t.glaa015 #啟用本位幣二
DEFINE g_glaa016    LIKE glaa_t.glaa016 #本位幣二
DEFINE g_glaa018    LIKE glaa_t.glaa018 #本位幣二匯率採用
DEFINE g_glaa019    LIKE glaa_t.glaa019 #啟用本位幣三
DEFINE g_glaa020    LIKE glaa_t.glaa020 #本位幣三
DEFINE g_glaa022    LIKE glaa_t.glaa022 #本位幣三匯率採用
DEFINE g_glaa024    LIKE glaa_t.glaa024 #單據別參照表號
#160802-00020#5-s-add
DEFINE g_wc_cs_ld            STRING
DEFINE g_wc_cs_comp          STRING
#160802-00020#5-e-add
#end add-point
 
#add-point:傳入參數說明(global.argv)

#end add-point
 
{</section>}
 
{<section id="axct212.main" >}
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
   CALL cl_ap_init("axc","")
 
   #add-point:作業初始化
   #160802-00020#5-s-add
   CALL s_fin_create_account_center_tmp()                      #展組織下階成員所需之暫存檔 
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_ld_str() RETURNING g_wc_cs_ld
   CALL s_fin_get_wc_str(g_wc_cs_ld)  RETURNING g_wc_cs_ld
   CALL s_axc_get_authcomp() RETURNING g_wc_cs_comp            #抓取使用者有拜訪權限據點的對應法人  
   #160802-00020#5-e-add 
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = " SELECT xcdrcomp,'',xcdrld,'',xcdr002,xcdr003,xcdr001,''", 
                      " FROM xcdr_t",
                      " WHERE xcdrent= ? AND xcdrld=? AND xcdr001=? AND xcdr002=? AND xcdr003=? FOR  
                          UPDATE"
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axct212_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT UNIQUE t0.xcdrcomp,t0.xcdrld,t0.xcdr002,t0.xcdr003,t0.xcdr001",
               " FROM xcdr_t t0",
               
               " WHERE t0.xcdrent = '" ||g_enterprise|| "' AND t0.xcdrld = ? AND t0.xcdr001 = ? AND t0.xcdr002 = ? AND t0.xcdr003 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define
   
   #end add-point
   PREPARE axct212_master_referesh FROM g_sql
 
 
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axct212 WITH FORM cl_ap_formpath("axc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axct212_init()   
 
      #進入選單 Menu (="N")
      CALL axct212_ui_dialog() 
      
      #add-point:畫面關閉前
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axct212
      
   END IF 
   
   CLOSE axct212_cl
   
   
 
   #add-point:作業離開前
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN
 
 
 
{</section>}
 
{<section id="axct212.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axct212_init()
   #add-point:init段define
   
   #end add-point    
  
   LET g_bfill = "Y"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #add-point:畫面資料初始化
   CALL cl_set_combo_scc('xcau003','8901')
   CALL cl_set_combo_scc('xcau003_2','8901')
   CALL cl_set_combo_scc('xcau003_3','8901')
   CALL cl_set_combo_scc('xcdr006','8909')
   CALL cl_set_combo_scc('xcdr006_2','8909')
   CALL cl_set_combo_scc('xcdr006_3','8909')
   CALL cl_set_combo_scc('xcdr010','8014')
   CALL cl_set_combo_scc('xcdr010_2','8014')
   CALL cl_set_combo_scc('xcdr010_3','8014')
   
   #CALL cl_set_act_visible_toolbaritem("modify",FALSE)  #仅允许修改单身  mark让按钮灰色不隐藏还是修改硬框架吧
   CALL cl_set_comp_visible('page_1,page_2',TRUE)
   #end add-point
   
   CALL axct212_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="axct212.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION axct212_ui_dialog()
   DEFINE la_param  RECORD
             prog   STRING,
             param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   DEFINE li_idx    LIKE type_t.num10  #161108-00012#4 num5==》num10
   DEFINE ls_wc     STRING
   DEFINE lb_first  BOOLEAN
   #add-point:ui_dialog段define

   #end add-point  
   
   LET lb_first = TRUE
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   
   #add-point:ui_dialog段before dialog 

   #end add-point
   
   WHILE TRUE
   
      CALL axct212_browser_fill("")
 
      
      ##判斷前一個動作是否為新增, 若是的話切換到新增的筆數
      #IF g_state = "Y" THEN
      #   FOR li_idx = 1 TO g_browser.getLength()
      #      IF g_browser[li_idx].b_xcdrld = g_xcdrld_t
      #         AND g_browser[li_idx].b_xcdr001 = g_xcdr001_t
      #         AND g_browser[li_idx].b_xcdr002 = g_xcdr002_t
      #         AND g_browser[li_idx].b_xcdr003 = g_xcdr003_t
 
      #         THEN
      #         LET g_current_row = li_idx
      #         EXIT FOR
      #      END IF
      #   END FOR
      #   LET g_state = ""
      #END IF
      
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
        
         DISPLAY ARRAY g_xcdr_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL axct212_ui_detailshow()
               
               #add-point:page1自定義行為

               #end add-point
            
            BEFORE DISPLAY 
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               
               #控制stus哪個按鈕可以按
               
               
            
 
            #add-point:page1自定義行為

            #end add-point
               
         END DISPLAY
        
         DISPLAY ARRAY g_xcdr2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL axct212_ui_detailshow()
               
               #add-point:page1自定義行為

               #end add-point
            
            BEFORE DISPLAY 
               CALL FGL_SET_ARR_CURR(g_detail_idx)      
            
            
         
            #add-point:page2自定義行為

            #end add-point
         
         END DISPLAY
         DISPLAY ARRAY g_xcdr3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL axct212_ui_detailshow()
               
               #add-point:page1自定義行為

               #end add-point
            
            BEFORE DISPLAY 
               CALL FGL_SET_ARR_CURR(g_detail_idx)      
            
            
         
            #add-point:page3自定義行為

            #end add-point
         
         END DISPLAY
 
         
         #add-point:ui_dialog段自定義display array

         #end add-point
         
         
         BEFORE DIALOG
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
               CALL axct212_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL axct212_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2

         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_xcdr_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_xcdr2_d)
               LET g_export_id[2]   = "s_detail2"
               LET g_export_node[3] = base.typeInfo.create(g_xcdr3_d)
               LET g_export_id[3]   = "s_detail3"
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
            #end add-point
 
         
         
         ON ACTION first
            CALL axct212_fetch('F')
            LET g_current_row = g_current_idx         
          
         ON ACTION previous
            CALL axct212_fetch('P')
            LET g_current_row = g_current_idx
          
         ON ACTION jump
            CALL axct212_fetch('/')
            LET g_current_row = g_current_idx
        
         ON ACTION next
            CALL axct212_fetch('N')
            LET g_current_row = g_current_idx
         
         ON ACTION last
            CALL axct212_fetch('L')
            LET g_current_row = g_current_idx
          
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
               NEXT FIELD xcdr004
            END IF
       
         ON ACTION controls      #單頭摺疊，可利用hot key "Ctrl-s"開啟/關閉單頭
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
               CALL axct212_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL axct212_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  CLEAR FORM
               ELSE
                  CALL axct212_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #+ 此段落由子樣板a43產生
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL axct212_modify()
               #add-point:ON ACTION modify
#修改硬框架，让灰色，不隐藏
               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL axct212_modify()
               #add-point:ON ACTION modify_detail

               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL axct212_delete()
               #add-point:ON ACTION delete

               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL axct212_insert()
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
               CALL axct212_reproduce()
               #add-point:ON ACTION reproduce

               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axct212_query()
               #add-point:ON ACTION query

               #END add-point
               
            END IF
 
 
         
         
         
         #+ 此段落由子樣板a46產生
         #新增相關文件
         ON ACTION related_document
            CALL axct212_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document

               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL axct212_set_pk_array()
            #add-point:ON ACTION agendum

            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL axct212_set_pk_array()
            #add-point:ON ACTION followup

            #END add-point
            CALL cl_user_overview_follow('')
 
 
         
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
 
{<section id="axct212.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION axct212_browser_search(p_type)
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define
   
   #end add-point    
   
   #若無輸入關鍵字則查找出所有資料
   IF NOT cl_null(g_searchstr) AND g_searchcol='0' THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "searchcol" 
      LET g_errparam.code   = "std-00005" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      RETURN FALSE 
   END IF 
   
   IF NOT cl_null(g_searchstr) THEN
      LET g_wc = " lower(", g_searchcol, ") LIKE '%", g_searchstr, "%'"
      LET g_wc = g_wc.toLowerCase()
   ELSE
      LET g_wc = " 1=1"
   END IF         
   
   #若為排序搜尋則添加以下條件
   IF cl_null(g_searchcol) OR g_searchcol = "0" THEN
      LET g_wc = g_wc, " ORDER BY xcdrld"
   ELSE
      LET g_wc = g_wc, " ORDER BY ", g_searchcol
   END IF 
 
   CALL axct212_browser_fill("F")
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axct212.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION axct212_browser_fill(ps_page_action)
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   DEFINE l_searchcol       STRING
   #add-point:browser_fill段define
   
   #end add-point    
   
   #add-point:browser_fill段動作開始前
   
   #end add-point    
 
   #搜尋用
   IF cl_null(g_searchcol) OR g_searchcol = '0' THEN
      LET l_searchcol = "xcdrld"
   ELSE
      LET l_searchcol = g_searchcol
   END IF
   
   LET l_wc  = g_wc.trim() 
   LET l_wc2 = g_wc2.trim()
   IF cl_null(l_wc) THEN  #p_wc 查詢條件
      LET l_wc = " 1=1"
   END IF
   IF cl_null(l_wc2) THEN  #p_wc 查詢條件
      LET l_wc2 = " 1=1"
   END IF
   
   IF l_wc2 <> " 1=1" OR NOT cl_null(l_wc2) THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT UNIQUE xcdrld ",
                      ", xcdr001 ",
                      ", xcdr002 ",
                      ", xcdr003 ",
 
                      " FROM xcdr_t ",
                      " ",
                      " ",
 
                      " WHERE xcdrent = '" ||g_enterprise|| "' AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("xcdr_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE xcdrld ",
                      ", xcdr001 ",
                      ", xcdr002 ",
                      ", xcdr003 ",
 
                      " FROM xcdr_t ",
                      " ",
                      " ",
                      " WHERE xcdrent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED, cl_sql_add_filter("xcdr_t")
   END IF 
   
   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"
 
   #add-point:browser_fill,count前
  #160802-00020#5-s-add  
   #---增加帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET l_sub_sql = l_sub_sql , " AND xcdrld IN ",g_wc_cs_ld
   END IF
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET l_sub_sql = l_sub_sql," AND xcdrcomp IN ",g_wc_cs_comp
   END IF  
   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"
  #160802-00020#5-e-add
   #end add-point
   
   PREPARE header_cnt_pre FROM g_sql
   EXECUTE header_cnt_pre INTO g_browser_cnt   #總筆數
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
   LET g_error_show = 0
 
   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
 
   IF cl_null(g_add_browse) THEN
      #清除畫面
      CLEAR FORM                
      INITIALIZE g_xcdr_m.* TO NULL
      CALL g_xcdr_d.clear()        
      CALL g_xcdr2_d.clear() 
      CALL g_xcdr3_d.clear() 
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_browser.getLength() + 1
      LET g_add_browse = ""
   END IF
 
   #依照t0.xcdrld,t0.xcdr001,t0.xcdr002,t0.xcdr003 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.xcdrld,t0.xcdr001,t0.xcdr002,t0.xcdr003",
                " FROM xcdr_t t0",
 
                
                " WHERE t0.xcdrent = '" ||g_enterprise|| "' AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("xcdr_t")
 
   #add-point:browser_fill,sql_rank前
   #160802-00020#5-s-add
   #---增加帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET g_sql = g_sql , " AND t0.xcdrld IN ",g_wc_cs_ld
   END IF
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET g_sql = g_sql," AND t0.xcdrcomp IN ",g_wc_cs_comp
   END IF  
   #160802-00020#5-e-add
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"xcdr_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre
 
   #CALL g_browser.clear()
   #LET g_cnt = 1
   FOREACH browse_cur INTO g_browser[g_cnt].b_xcdrld,g_browser[g_cnt].b_xcdr001,g_browser[g_cnt].b_xcdr002, 
       g_browser[g_cnt].b_xcdr003 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = 'foreach:' 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      
      
      #add-point:browser_fill段reference
      
      #end add-point    
      
      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
 
   CALL g_browser.deleteElement(g_cnt)
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_xcdr_m.* TO NULL
      CALL g_xcdr_d.clear()
      CALL g_xcdr2_d.clear()
      CALL g_xcdr3_d.clear()
 
      #add-point:browser_fill段after_clear
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
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
 
{<section id="axct212.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION axct212_ui_headershow()
   #add-point:ui_headershow段define
   
   #end add-point    
   
   LET g_xcdr_m.xcdrld = g_browser[g_current_idx].b_xcdrld   
   LET g_xcdr_m.xcdr001 = g_browser[g_current_idx].b_xcdr001   
   LET g_xcdr_m.xcdr002 = g_browser[g_current_idx].b_xcdr002   
   LET g_xcdr_m.xcdr003 = g_browser[g_current_idx].b_xcdr003   
 
   EXECUTE axct212_master_referesh USING g_xcdr_m.xcdrld,g_xcdr_m.xcdr001,g_xcdr_m.xcdr002,g_xcdr_m.xcdr003 INTO g_xcdr_m.xcdrcomp, 
       g_xcdr_m.xcdrld,g_xcdr_m.xcdr002,g_xcdr_m.xcdr003,g_xcdr_m.xcdr001
   CALL axct212_show()
   
END FUNCTION
 
{</section>}
 
{<section id="axct212.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION axct212_ui_detailshow()
   #add-point:ui_detailshow段define
   
   #end add-point    
   
   #add-point:ui_detailshow段before
   
   #end add-point  
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
 
      #add-point:ui_detailshow段more
      
      #end add-point 
   END IF
   
   #add-point:ui_detailshow段after
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="axct212.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION axct212_ui_browser_refresh()
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define
   
   #end add-point    
   
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_xcdrld = g_xcdr_m.xcdrld 
         AND g_browser[l_i].b_xcdr001 = g_xcdr_m.xcdr001 
         AND g_browser[l_i].b_xcdr002 = g_xcdr_m.xcdr002 
         AND g_browser[l_i].b_xcdr003 = g_xcdr_m.xcdr003 
 
         THEN  
         CALL g_browser.deleteElement(l_i)
         LET g_header_cnt = g_header_cnt - 1
      END IF
   END FOR
 
   LET g_browser_cnt = g_browser.getLength()
   #IF g_current_row > g_browser_cnt THEN        #確定browse 筆數指在同一筆
   #   LET g_current_row = g_browser_cnt
   #END IF
 
   DISPLAY g_browser_cnt TO FORMONLY.b_count    #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數的顯示
   
END FUNCTION
 
{</section>}
 
{<section id="axct212.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION axct212_construct()
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   #add-point:cs段define
   
   #end add-point    
 
   #清除畫面上相關資料
   CLEAR FORM                 
   INITIALIZE g_xcdr_m.* TO NULL
   CALL g_xcdr_d.clear()
   CALL g_xcdr2_d.clear()
   CALL g_xcdr3_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON xcdrcomp,xcdrld,xcdr002,xcdr003,xcdr001
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct
            
            #end add-point 
            
                 #此段落由子樣板a01產生
         BEFORE FIELD xcdrcomp
            #add-point:BEFORE FIELD xcdrcomp
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdrcomp
            
            #add-point:AFTER FIELD xcdrcomp
            
            #END add-point
            
 
         #Ctrlp:construct.c.xcdrcomp
         ON ACTION controlp INFIELD xcdrcomp
            #add-point:ON ACTION controlp INFIELD xcdrcomp
            #法人組織
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.where = " ooefstus = 'Y'"
           #160802-00020#5-s-add 
            #增加法人過濾條件
            IF NOT cl_null(g_wc_cs_comp) THEN
               LET g_qryparam.where = " ooef001 IN ",g_wc_cs_comp
            END IF
           #160802-00020#5-e-add              
            CALL q_ooef001_2()                      #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcdrcomp  #顯示到畫面上
            NEXT FIELD xcdrcomp                     #返回原欄位
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdrld
            #add-point:BEFORE FIELD xcdrld
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdrld
            
            #add-point:AFTER FIELD xcdrld
            
            #END add-point
            
 
         #Ctrlp:construct.c.xcdrld
         ON ACTION controlp INFIELD xcdrld
            #add-point:ON ACTION controlp INFIELD xcdrld
            #账别编号
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            #160802-00020#5-s-add
            #增加帳套權限控制
            IF NOT cl_null(g_wc_cs_ld) THEN
               LET g_qryparam.where = " glaald IN ",g_wc_cs_ld
            END IF
            #160802-00020#5-e-add             
            CALL q_authorised_ld()                #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcdrld  #顯示到畫面上
            NEXT FIELD xcdrld                     #返回原欄位
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdr002
            #add-point:BEFORE FIELD xcdr002
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdr002
            
            #add-point:AFTER FIELD xcdr002
            
            #END add-point
            
 
         #Ctrlp:construct.c.xcdr002
         ON ACTION controlp INFIELD xcdr002
            #add-point:ON ACTION controlp INFIELD xcdr002
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdr003
            #add-point:BEFORE FIELD xcdr003
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdr003
            
            #add-point:AFTER FIELD xcdr003
            
            #END add-point
            
 
         #Ctrlp:construct.c.xcdr003
         ON ACTION controlp INFIELD xcdr003
            #add-point:ON ACTION controlp INFIELD xcdr003
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdr001
            #add-point:BEFORE FIELD xcdr001
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdr001
            
            #add-point:AFTER FIELD xcdr001
            
            #END add-point
            
 
         #Ctrlp:construct.c.xcdr001
         ON ACTION controlp INFIELD xcdr001
            #add-point:ON ACTION controlp INFIELD xcdr001
            #成本计算类型
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcat001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcdr001  #顯示到畫面上
            NEXT FIELD xcdr001                     #返回原欄位
            #END add-point
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON xcdr004,xcdr005,xcdr006,xcdr010,xcdr011,xcdr021,xcdr020,xcdr101,xcdr102, 
          xcdr104,xcdr103,xcdr105
           FROM s_detail1[1].xcdr004,s_detail1[1].xcdr005,s_detail1[1].xcdr006,s_detail1[1].xcdr010, 
               s_detail1[1].xcdr011,s_detail1[1].xcdr021,s_detail1[1].xcdr020,s_detail1[1].xcdr101,s_detail1[1].xcdr102, 
               s_detail1[1].xcdr104,s_detail1[1].xcdr103,s_detail1[1].xcdr105
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #此段落由子樣板a01產生
         BEFORE FIELD xcdr004
            #add-point:BEFORE FIELD xcdr004
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdr004
            
            #add-point:AFTER FIELD xcdr004
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcdr004
         ON ACTION controlp INFIELD xcdr004
            #add-point:ON ACTION controlp INFIELD xcdr004
            #成本中心
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = cl_get_today()
            CALL q_ooeg001_8()           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcdr004              #顯示到畫面上
            NEXT FIELD xcdr004                          #返回原欄位
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdr005
            #add-point:BEFORE FIELD xcdr005
 
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdr005
            
            #add-point:AFTER FIELD xcdr005
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcdr005
         ON ACTION controlp INFIELD xcdr005
            #add-point:ON ACTION controlp INFIELD xcdr005
            #成本次要素
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcau001()                               #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcdr005              #顯示到畫面上
            NEXT FIELD xcdr005                          #返回原欄位
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdr006
            #add-point:BEFORE FIELD xcdr006
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdr006
            
            #add-point:AFTER FIELD xcdr006
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcdr006
         ON ACTION controlp INFIELD xcdr006
            #add-point:ON ACTION controlp INFIELD xcdr006
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdr010
            #add-point:BEFORE FIELD xcdr010
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdr010
            
            #add-point:AFTER FIELD xcdr010
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcdr010
         ON ACTION controlp INFIELD xcdr010
            #add-point:ON ACTION controlp INFIELD xcdr010
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdr011
            #add-point:BEFORE FIELD xcdr011
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdr011
            
            #add-point:AFTER FIELD xcdr011
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcdr011
         ON ACTION controlp INFIELD xcdr011
            #add-point:ON ACTION controlp INFIELD xcdr011
            #会计科目
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " glac003 != '1' AND glac006 = '1' AND glac007 = '5'"
            #CALL q_glac002_4()  
            CALL aglt310_04() 
            #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcdr011              #顯示到畫面上
            NEXT FIELD xcdr011                          #返回原欄位
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdr021
            #add-point:BEFORE FIELD xcdr021
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdr021
            
            #add-point:AFTER FIELD xcdr021
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcdr021
         ON ACTION controlp INFIELD xcdr021
            #add-point:ON ACTION controlp INFIELD xcdr021
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdr020
            #add-point:BEFORE FIELD xcdr020
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdr020
            
            #add-point:AFTER FIELD xcdr020
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcdr020
         ON ACTION controlp INFIELD xcdr020
            #add-point:ON ACTION controlp INFIELD xcdr020
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdr101
            #add-point:BEFORE FIELD xcdr101
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdr101
            
            #add-point:AFTER FIELD xcdr101
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcdr101
         ON ACTION controlp INFIELD xcdr101
            #add-point:ON ACTION controlp INFIELD xcdr101
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdr102
            #add-point:BEFORE FIELD xcdr102
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdr102
            
            #add-point:AFTER FIELD xcdr102
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcdr102
         ON ACTION controlp INFIELD xcdr102
            #add-point:ON ACTION controlp INFIELD xcdr102
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdr104
            #add-point:BEFORE FIELD xcdr104
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdr104
            
            #add-point:AFTER FIELD xcdr104
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcdr104
         ON ACTION controlp INFIELD xcdr104
            #add-point:ON ACTION controlp INFIELD xcdr104
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdr103
            #add-point:BEFORE FIELD xcdr103
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdr103
            
            #add-point:AFTER FIELD xcdr103
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcdr103
         ON ACTION controlp INFIELD xcdr103
            #add-point:ON ACTION controlp INFIELD xcdr103
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdr105
            #add-point:BEFORE FIELD xcdr105
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdr105
            
            #add-point:AFTER FIELD xcdr105
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcdr105
         ON ACTION controlp INFIELD xcdr105
            #add-point:ON ACTION controlp INFIELD xcdr105
            
            #END add-point
 
   
       
      END CONSTRUCT
  
 
  
      #add-point:cs段more_construct
      CONSTRUCT g_wc2_table2 ON xcdr111,xcdr112,xcdr114,xcdr113,xcdr115
           FROM s_detail2[1].xcdr111_2,s_detail2[1].xcdr112_2,s_detail2[1].xcdr114_2,
                s_detail2[1].xcdr113_2,s_detail2[1].xcdr115_2
                      
         BEFORE CONSTRUCT
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table3 ON xcdr121,xcdr122,xcdr124,xcdr123,xcdr125
           FROM s_detail3[1].xcdr121_3,s_detail3[1].xcdr122_3,s_detail3[1].xcdr124_3,
                s_detail3[1].xcdr123_3,s_detail3[1].xcdr125_3
                      
         BEFORE CONSTRUCT
      END CONSTRUCT
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:ui_dialog段b_dialog
         
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
   
   #add-point:cs段after_construct
   LET g_wc2_table1 = g_wc2_table1," AND ",g_wc2_table2," AND ",g_wc2_table3
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
 
{<section id="axct212.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION axct212_query()
   DEFINE ls_wc STRING
   #add-point:query段define
   
   #end add-point   
 
   #add-point:query開始前
   
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
   CALL g_xcdr_d.clear()
   CALL g_xcdr2_d.clear()
   CALL g_xcdr3_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL axct212_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      CALL axct212_browser_fill(g_wc)
      CALL axct212_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL axct212_browser_fill("F")
   
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
      CALL axct212_fetch("F") 
   END IF
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="axct212.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION axct212_fetch(p_flag)
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define
   
   #end add-point    
   
   #add-point:fetch段動作開始前
   
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
   
   CALL axct212_browser_fill(p_flag)
   
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
   LET g_browser_idx = g_pagestart+g_current_idx-1
   DISPLAY g_browser_idx TO FORMONLY.b_index   #當下筆數
   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數
   DISPLAY g_browser_idx TO FORMONLY.h_index   #當下筆數
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數
   
   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   
   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF
   
   #超出範圍
   IF g_current_idx > g_browser.getLength() THEN
      LET g_current_idx = g_browser.getLength()
   END IF
   
   LET g_xcdr_m.xcdrld = g_browser[g_current_idx].b_xcdrld
   LET g_xcdr_m.xcdr001 = g_browser[g_current_idx].b_xcdr001
   LET g_xcdr_m.xcdr002 = g_browser[g_current_idx].b_xcdr002
   LET g_xcdr_m.xcdr003 = g_browser[g_current_idx].b_xcdr003
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE axct212_master_referesh USING g_xcdr_m.xcdrld,g_xcdr_m.xcdr001,g_xcdr_m.xcdr002,g_xcdr_m.xcdr003 INTO g_xcdr_m.xcdrcomp, 
       g_xcdr_m.xcdrld,g_xcdr_m.xcdr002,g_xcdr_m.xcdr003,g_xcdr_m.xcdr001
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcdr_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      INITIALIZE g_xcdr_m.* TO NULL
      RETURN
   END IF
   
   #LET g_data_owner =       
   #LET g_data_dept =   
   
   #保存單頭舊值
   LET g_xcdr_m_t.* = g_xcdr_m.*
   LET g_xcdr_m_o.* = g_xcdr_m.*
   
   #重新顯示   
   CALL axct212_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="axct212.insert" >}
#+ 資料新增
PRIVATE FUNCTION axct212_insert()
   #add-point:insert段define
   
   #end add-point    
   
   #add-point:insert段before
   CALL cl_set_comp_visible('page_1,page_2',TRUE)
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_xcdr_d.clear()
   CALL g_xcdr2_d.clear()
   CALL g_xcdr3_d.clear()
 
 
   INITIALIZE g_xcdr_m.* LIKE xcdr_t.*             #DEFAULT 設定
   LET g_xcdrld_t = NULL
   LET g_xcdr001_t = NULL
   LET g_xcdr002_t = NULL
   LET g_xcdr003_t = NULL
 
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
      
     
      #add-point:單頭預設值
      
      #end add-point 
 
      CALL axct212_input("a")
      
      #add-point:單頭輸入後
      
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_xcdr_m.* = g_xcdr_m_t.*
         CALL axct212_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_xcdr_m.* TO NULL
         INITIALIZE g_xcdr_d TO NULL
         INITIALIZE g_xcdr2_d TO NULL
         INITIALIZE g_xcdr3_d TO NULL
 
         CALL axct212_show()
         RETURN
      END IF
    
      #CALL g_xcdr_d.clear()
      #CALL g_xcdr2_d.clear()
      #CALL g_xcdr3_d.clear()
 
      
      #add-point:單頭輸入後2
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_xcdrld_t = g_xcdr_m.xcdrld
   LET g_xcdr001_t = g_xcdr_m.xcdr001
   LET g_xcdr002_t = g_xcdr_m.xcdr002
   LET g_xcdr003_t = g_xcdr_m.xcdr003
 
   
   #組合新增資料的條件
   LET g_add_browse = " xcdrent = '" ||g_enterprise|| "' AND",
                      " xcdrld = '", g_xcdr_m.xcdrld CLIPPED, "' "
                      ," AND xcdr001 = '", g_xcdr_m.xcdr001 CLIPPED, "' "
                      ," AND xcdr002 = '", g_xcdr_m.xcdr002 CLIPPED, "' "
                      ," AND xcdr003 = '", g_xcdr_m.xcdr003 CLIPPED, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axct212_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
END FUNCTION
 
{</section>}
 
{<section id="axct212.modify" >}
#+ 資料修改
PRIVATE FUNCTION axct212_modify()
   #add-point:modify段define
   
   #end add-point    
   
   IF g_xcdr_m.xcdrld IS NULL
   OR g_xcdr_m.xcdr001 IS NULL
   OR g_xcdr_m.xcdr002 IS NULL
   OR g_xcdr_m.xcdr003 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      RETURN
   END IF
   
   EXECUTE axct212_master_referesh USING g_xcdr_m.xcdrld,g_xcdr_m.xcdr001,g_xcdr_m.xcdr002,g_xcdr_m.xcdr003 INTO g_xcdr_m.xcdrcomp, 
       g_xcdr_m.xcdrld,g_xcdr_m.xcdr002,g_xcdr_m.xcdr003,g_xcdr_m.xcdr001
 
   ERROR ""
  
   LET g_xcdrld_t = g_xcdr_m.xcdrld
   LET g_xcdr001_t = g_xcdr_m.xcdr001
   LET g_xcdr002_t = g_xcdr_m.xcdr002
   LET g_xcdr003_t = g_xcdr_m.xcdr003
 
   CALL s_transaction_begin()
   
   OPEN axct212_cl USING g_enterprise,g_xcdr_m.xcdrld
                                                       ,g_xcdr_m.xcdr001
                                                       ,g_xcdr_m.xcdr002
                                                       ,g_xcdr_m.xcdr003
 
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axct212_cl:" 
      LET g_errparam.code   =  STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      CLOSE axct212_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #鎖住將被更改或取消的資料
   FETCH axct212_cl INTO g_xcdr_m.xcdrcomp,g_xcdr_m.xcdrcomp_desc,g_xcdr_m.xcdrld,g_xcdr_m.xcdrld_desc, 
       g_xcdr_m.xcdr002,g_xcdr_m.xcdr003,g_xcdr_m.xcdr001,g_xcdr_m.xcdr001_desc
 
   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_xcdr_m.xcdrld 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      CLOSE axct212_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   CALL s_transaction_end('Y','0')
 
   CALL axct212_show()
   WHILE TRUE
      LET g_xcdrld_t = g_xcdr_m.xcdrld
      LET g_xcdr001_t = g_xcdr_m.xcdr001
      LET g_xcdr002_t = g_xcdr_m.xcdr002
      LET g_xcdr003_t = g_xcdr_m.xcdr003
 
 
      #add-point:modify段修改前
      
      #end add-point
      
      CALL axct212_input("u")     #欄位更改
      
      #add-point:modify段修改後
      
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_xcdr_m.* = g_xcdr_m_t.*
         CALL axct212_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更
      IF g_xcdr_m.xcdrld != g_xcdrld_t 
      OR g_xcdr_m.xcdr001 != g_xcdr001_t 
      OR g_xcdr_m.xcdr002 != g_xcdr002_t 
      OR g_xcdr_m.xcdr003 != g_xcdr003_t 
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單頭(偽)修改前
         
         #end add-point
         
         #更新單頭key值
         UPDATE xcdr_t SET xcdrld = g_xcdr_m.xcdrld
                                       , xcdr001 = g_xcdr_m.xcdr001
                                       , xcdr002 = g_xcdr_m.xcdr002
                                       , xcdr003 = g_xcdr_m.xcdr003
 
          WHERE xcdrent = g_enterprise AND xcdrld = g_xcdrld_t
            AND xcdr001 = g_xcdr001_t
            AND xcdr002 = g_xcdr002_t
            AND xcdr003 = g_xcdr003_t
 
         #add-point:單頭(偽)修改中
         
         #end add-point
         
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xcdr_t" 
               LET g_errparam.code   = "std-00009" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xcdr_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
         END CASE
 
 
         
         #add-point:單頭(偽)修改後
         
         #end add-point
         
      END IF
      
      EXIT WHILE
      
   END WHILE
 
   #修改歷程記錄
   #IF NOT cl_log_modified_record(g_xcdr_m.xcdrld,g_site) THEN 
   #   CALL s_transaction_end('N','0')
   #END IF
 
   CLOSE axct212_cl
   CALL s_transaction_end('Y','0')
 
   #流程通知預埋點-U
   CALL cl_flow_notify(g_xcdr_m.xcdrld,'U')
 
   CALL axct212_b_fill("1=1")
   
END FUNCTION   
 
{</section>}
 
{<section id="axct212.input" >}
#+ 資料輸入
PRIVATE FUNCTION axct212_input(p_cmd)
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd_t               LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_ac_t                LIKE type_t.num10                #未取消的ARRAY CNT   #161108-00012#4 num5==》num10
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
   #add-point:input段define
   #ADD BY XZG20151203 B
   DEFINE l_sql                  STRING
   DEFINE l_glaa004              LIKE  glaa_t.glaa004 
   #ADD BY XZG20151203 e  
  CALL axct212_input2(p_cmd)
   RETURN
   #end add-point    
   
   #先做狀態判定
   IF p_cmd = 'r' THEN
      LET l_cmd_t = 'r'
      LET p_cmd   = 'a'
   ELSE
      LET l_cmd_t = p_cmd
   END IF   
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_xcdr_m.xcdrcomp,g_xcdr_m.xcdrcomp_desc,g_xcdr_m.xcdrld,g_xcdr_m.xcdrld_desc,g_xcdr_m.xcdr002, 
       g_xcdr_m.xcdr003,g_xcdr_m.xcdr001,g_xcdr_m.xcdr001_desc
   
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

   #end add-point 
   LET g_forupd_sql = "SELECT xcdr004,xcdr005,xcdr006,xcdr010,xcdr011,xcdr021,xcdr020,xcdr101,xcdr102, 
       xcdr104,xcdr103,xcdr105,xcdr004,xcdr005,xcdr006,xcdr010,xcdr011,xcdr021,xcdr020,xcdr111,xcdr112, 
       xcdr114,xcdr113,xcdr115,xcdr004,xcdr005,xcdr006,xcdr010,xcdr011,xcdr021,xcdr020,xcdr121,xcdr122, 
       xcdr124,xcdr123,xcdr125 FROM xcdr_t WHERE xcdrent=? AND xcdrld=? AND xcdr001=? AND xcdr002=?  
       AND xcdr003=? AND xcdr004=? AND xcdr005=? AND xcdr006=? FOR UPDATE"
   #add-point:input段define_sql

   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axct212_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL axct212_set_entry(p_cmd)
   #add-point:set_entry後

   #end add-point
   CALL axct212_set_no_entry(p_cmd)
   #add-point:set_no_entry後

   #end add-point
 
   DISPLAY BY NAME g_xcdr_m.xcdrcomp,g_xcdr_m.xcdrld,g_xcdr_m.xcdr002,g_xcdr_m.xcdr003,g_xcdr_m.xcdr001 
 
   
   LET lb_reproduce = FALSE
   
   #add-point:進入修改段前

   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="axct212.input.head" >}
   
      #單頭段
      INPUT BY NAME g_xcdr_m.xcdrcomp,g_xcdr_m.xcdrld,g_xcdr_m.xcdr002,g_xcdr_m.xcdr003,g_xcdr_m.xcdr001  
 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂單頭ACTION
         
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #add-point:單頭input前
            
            #end add-point
          
                  #此段落由子樣板a02產生
         AFTER FIELD xcdrcomp
            
            #add-point:AFTER FIELD xcdrcomp
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcdr_m.xcdrcomp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcdr_m.xcdrcomp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcdr_m.xcdrcomp_desc


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdrcomp
            #add-point:BEFORE FIELD xcdrcomp
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE xcdrcomp
            #add-point:ON CHANGE xcdrcomp
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdrld
            
            #add-point:AFTER FIELD xcdrld
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcdr_m.xcdrld
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcdr_m.xcdrld_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcdr_m.xcdrld_desc

            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xcdr_m.xcdrld) AND NOT cl_null(g_xcdr_m.xcdr001) AND NOT cl_null(g_xcdr_m.xcdr002) AND NOT cl_null(g_xcdr_m.xcdr003) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcdr_m.xcdrld != g_xcdrld_t  OR g_xcdr_m.xcdr001 != g_xcdr001_t  OR g_xcdr_m.xcdr002 != g_xcdr002_t  OR g_xcdr_m.xcdr003 != g_xcdr003_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcdr_t WHERE "||"xcdrent = '" ||g_enterprise|| "' AND "||"xcdrld = '"||g_xcdr_m.xcdrld ||"' AND "|| "xcdr001 = '"||g_xcdr_m.xcdr001 ||"' AND "|| "xcdr002 = '"||g_xcdr_m.xcdr002 ||"' AND "|| "xcdr003 = '"||g_xcdr_m.xcdr003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdrld
            #add-point:BEFORE FIELD xcdrld
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE xcdrld
            #add-point:ON CHANGE xcdrld
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdr002
            #add-point:BEFORE FIELD xcdr002
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdr002
            
            #add-point:AFTER FIELD xcdr002
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xcdr_m.xcdrld) AND NOT cl_null(g_xcdr_m.xcdr001) AND NOT cl_null(g_xcdr_m.xcdr002) AND NOT cl_null(g_xcdr_m.xcdr003) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcdr_m.xcdrld != g_xcdrld_t  OR g_xcdr_m.xcdr001 != g_xcdr001_t  OR g_xcdr_m.xcdr002 != g_xcdr002_t  OR g_xcdr_m.xcdr003 != g_xcdr003_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcdr_t WHERE "||"xcdrent = '" ||g_enterprise|| "' AND "||"xcdrld = '"||g_xcdr_m.xcdrld ||"' AND "|| "xcdr001 = '"||g_xcdr_m.xcdr001 ||"' AND "|| "xcdr002 = '"||g_xcdr_m.xcdr002 ||"' AND "|| "xcdr003 = '"||g_xcdr_m.xcdr003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcdr002
            #add-point:ON CHANGE xcdr002
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdr003
            #add-point:BEFORE FIELD xcdr003
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdr003
            
            #add-point:AFTER FIELD xcdr003
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xcdr_m.xcdrld) AND NOT cl_null(g_xcdr_m.xcdr001) AND NOT cl_null(g_xcdr_m.xcdr002) AND NOT cl_null(g_xcdr_m.xcdr003) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcdr_m.xcdrld != g_xcdrld_t  OR g_xcdr_m.xcdr001 != g_xcdr001_t  OR g_xcdr_m.xcdr002 != g_xcdr002_t  OR g_xcdr_m.xcdr003 != g_xcdr003_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcdr_t WHERE "||"xcdrent = '" ||g_enterprise|| "' AND "||"xcdrld = '"||g_xcdr_m.xcdrld ||"' AND "|| "xcdr001 = '"||g_xcdr_m.xcdr001 ||"' AND "|| "xcdr002 = '"||g_xcdr_m.xcdr002 ||"' AND "|| "xcdr003 = '"||g_xcdr_m.xcdr003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcdr003
            #add-point:ON CHANGE xcdr003
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdr001
            
            #add-point:AFTER FIELD xcdr001
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcdr_m.xcdr001
            CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcdr_m.xcdr001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcdr_m.xcdr001_desc

            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xcdr_m.xcdrld) AND NOT cl_null(g_xcdr_m.xcdr001) AND NOT cl_null(g_xcdr_m.xcdr002) AND NOT cl_null(g_xcdr_m.xcdr003) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcdr_m.xcdrld != g_xcdrld_t  OR g_xcdr_m.xcdr001 != g_xcdr001_t  OR g_xcdr_m.xcdr002 != g_xcdr002_t  OR g_xcdr_m.xcdr003 != g_xcdr003_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcdr_t WHERE "||"xcdrent = '" ||g_enterprise|| "' AND "||"xcdrld = '"||g_xcdr_m.xcdrld ||"' AND "|| "xcdr001 = '"||g_xcdr_m.xcdr001 ||"' AND "|| "xcdr002 = '"||g_xcdr_m.xcdr002 ||"' AND "|| "xcdr003 = '"||g_xcdr_m.xcdr003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdr001
            #add-point:BEFORE FIELD xcdr001
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE xcdr001
            #add-point:ON CHANGE xcdr001
            
            #END add-point
 
 #欄位檢查
                  #Ctrlp:input.c.xcdrcomp
         ON ACTION controlp INFIELD xcdrcomp
            #add-point:ON ACTION controlp INFIELD xcdrcomp
            
            #END add-point
 
         #Ctrlp:input.c.xcdrld
         ON ACTION controlp INFIELD xcdrld
            #add-point:ON ACTION controlp INFIELD xcdrld
            
            #END add-point
 
         #Ctrlp:input.c.xcdr002
         ON ACTION controlp INFIELD xcdr002
            #add-point:ON ACTION controlp INFIELD xcdr002
            
            #END add-point
 
         #Ctrlp:input.c.xcdr003
         ON ACTION controlp INFIELD xcdr003
            #add-point:ON ACTION controlp INFIELD xcdr003
            
            #END add-point
 
         #Ctrlp:input.c.xcdr001
         ON ACTION controlp INFIELD xcdr001
            #add-point:ON ACTION controlp INFIELD xcdr001
            
            #END add-point
 
 #欄位開窗
 
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
            
            IF s_transaction_chk("N",0) THEN
                CALL s_transaction_begin()
            END IF
 
            #多語言處理
            
            
            #錯誤訊息統整顯示
            #CALL cl_err_collect_show()
            #CALL cl_showmsg()
            DISPLAY BY NAME g_xcdr_m.xcdrld             
                            ,g_xcdr_m.xcdr001   
                            ,g_xcdr_m.xcdr002   
                            ,g_xcdr_m.xcdr003   
 
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前
               
               #end add-point
            
               UPDATE xcdr_t SET (xcdrcomp,xcdrld,xcdr002,xcdr003,xcdr001) = (g_xcdr_m.xcdrcomp,g_xcdr_m.xcdrld, 
                   g_xcdr_m.xcdr002,g_xcdr_m.xcdr003,g_xcdr_m.xcdr001)
                WHERE xcdrent = g_enterprise AND xcdrld = g_xcdrld_t
                  AND xcdr001 = g_xcdr001_t
                  AND xcdr002 = g_xcdr002_t
                  AND xcdr003 = g_xcdr003_t
 
               #add-point:單頭修改中
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcdr_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcdr_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xcdr_m.xcdrld
               LET gs_keys_bak[1] = g_xcdrld_t
               LET gs_keys[2] = g_xcdr_m.xcdr001
               LET gs_keys_bak[2] = g_xcdr001_t
               LET gs_keys[3] = g_xcdr_m.xcdr002
               LET gs_keys_bak[3] = g_xcdr002_t
               LET gs_keys[4] = g_xcdr_m.xcdr003
               LET gs_keys_bak[4] = g_xcdr003_t
               LET gs_keys[5] = g_xcdr_d[g_detail_idx].xcdr004
               LET gs_keys_bak[5] = g_xcdr_d_t.xcdr004
               LET gs_keys[6] = g_xcdr_d[g_detail_idx].xcdr005
               LET gs_keys_bak[6] = g_xcdr_d_t.xcdr005
               LET gs_keys[7] = g_xcdr_d[g_detail_idx].xcdr006
               LET gs_keys_bak[7] = g_xcdr_d_t.xcdr006
               CALL axct212_update_b('xcdr_t',gs_keys,gs_keys_bak,"'1'")
                     
                     LET g_xcdrld_t = g_xcdr_m.xcdrld
                     LET g_xcdr001_t = g_xcdr_m.xcdr001
                     LET g_xcdr002_t = g_xcdr_m.xcdr002
                     LET g_xcdr003_t = g_xcdr_m.xcdr003
 
                     #add-point:單頭修改後
                     
                     #end add-point
                     
                     LET g_log1 = util.JSON.stringify(g_xcdr_m_t)
                     LET g_log2 = util.JSON.stringify(g_xcdr_m)
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     ELSE
                        CALL s_transaction_end('Y','0')
                     END IF
               END CASE
            
            ELSE    
               #add-point:單頭新增
               
               #end add-point
                                 
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL axct212_detail_reproduce()
               END IF
            END IF
           #controlp
                     
           LET g_xcdrld_t = g_xcdr_m.xcdrld
           LET g_xcdr001_t = g_xcdr_m.xcdr001
           LET g_xcdr002_t = g_xcdr_m.xcdr002
           LET g_xcdr003_t = g_xcdr_m.xcdr003
 
           
           #若單身還沒有輸入資料, 強制切換至單身
           #IF cl_null(g_xcdr_d[1].xcdr004) THEN
           #   CALL g_xcdr_d.deleteElement(1)
           #   NEXT FIELD xcdr004
           #END IF
           
           IF g_xcdr_d.getLength() = 0 THEN
              NEXT FIELD xcdr004
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="axct212.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_xcdr_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xcdr_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axct212_b_fill(g_wc2) 
            IF g_rec_b != 0 THEN
               CALL fgl_set_arr_curr(l_ac)
            END IF
            #add-point:資料輸入前
            
            #end add-point
         
         BEFORE ROW
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN axct212_cl USING g_enterprise,
                                               g_xcdr_m.xcdrld
                                               ,g_xcdr_m.xcdr001
                                               ,g_xcdr_m.xcdr002
                                               ,g_xcdr_m.xcdr003
 
                                               
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axct212_cl:" 
                  LET g_errparam.code   =  STATUS 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  CLOSE axct212_cl
                  CALL s_transaction_end('N','0')
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            
            IF g_rec_b >= l_ac 
               AND g_xcdr_d[l_ac].xcdr004 IS NOT NULL
               AND g_xcdr_d[l_ac].xcdr005 IS NOT NULL
               AND g_xcdr_d[l_ac].xcdr006 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_xcdr_d_t.* = g_xcdr_d[l_ac].*  #BACKUP
               LET g_xcdr_d_o.* = g_xcdr_d[l_ac].*  #BACKUP
               CALL axct212_set_entry_b(l_cmd)
               #add-point:set_entry_b後
               
               #end add-point
               CALL axct212_set_no_entry_b(l_cmd)
               OPEN axct212_bcl USING g_enterprise,g_xcdr_m.xcdrld,
                                                g_xcdr_m.xcdr001,
                                                g_xcdr_m.xcdr002,
                                                g_xcdr_m.xcdr003,
 
                                                g_xcdr_d_t.xcdr004
                                                ,g_xcdr_d_t.xcdr005
                                                ,g_xcdr_d_t.xcdr006
 
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axct212_bcl:" 
                  LET g_errparam.code   =  STATUS 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axct212_bcl INTO g_xcdr_d[l_ac].xcdr004,g_xcdr_d[l_ac].xcdr005,g_xcdr_d[l_ac].xcdr006, 
                      g_xcdr_d[l_ac].xcdr010,g_xcdr_d[l_ac].xcdr011,g_xcdr_d[l_ac].xcdr021,g_xcdr_d[l_ac].xcdr020, 
                      g_xcdr_d[l_ac].xcdr101,g_xcdr_d[l_ac].xcdr102,g_xcdr_d[l_ac].xcdr104,g_xcdr_d[l_ac].xcdr103, 
                      g_xcdr_d[l_ac].xcdr105,g_xcdr2_d[l_ac].xcdr004,g_xcdr2_d[l_ac].xcdr005,g_xcdr2_d[l_ac].xcdr006, 
                      g_xcdr2_d[l_ac].xcdr010,g_xcdr2_d[l_ac].xcdr011,g_xcdr2_d[l_ac].xcdr021,g_xcdr2_d[l_ac].xcdr020, 
                      g_xcdr2_d[l_ac].xcdr111,g_xcdr2_d[l_ac].xcdr112,g_xcdr2_d[l_ac].xcdr114,g_xcdr2_d[l_ac].xcdr113, 
                      g_xcdr2_d[l_ac].xcdr115,g_xcdr3_d[l_ac].xcdr004,g_xcdr3_d[l_ac].xcdr005,g_xcdr3_d[l_ac].xcdr006, 
                      g_xcdr3_d[l_ac].xcdr010,g_xcdr3_d[l_ac].xcdr011,g_xcdr3_d[l_ac].xcdr021,g_xcdr3_d[l_ac].xcdr020, 
                      g_xcdr3_d[l_ac].xcdr121,g_xcdr3_d[l_ac].xcdr122,g_xcdr3_d[l_ac].xcdr124,g_xcdr3_d[l_ac].xcdr123, 
                      g_xcdr3_d[l_ac].xcdr125
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_xcdr_d_t.xcdr004 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
 
                      LET l_lock_sw = "Y"
                  END IF
                  
                  CALL axct212_ref_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row
            
            #end add-point  
            
        
         BEFORE INSERT
            
            INITIALIZE g_xcdr_d_t.* TO NULL
            INITIALIZE g_xcdr_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xcdr_d[l_ac].* TO NULL
            #公用欄位預設值
              
            #一般欄位預設值
            
            
            #add-point:modify段before備份
            
            #end add-point
            LET g_xcdr_d_t.* = g_xcdr_d[l_ac].*     #新輸入資料
            LET g_xcdr_d_o.* = g_xcdr_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axct212_set_entry_b(l_cmd)
            #add-point:set_entry_b後
            
            #end add-point
            CALL axct212_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xcdr_d[li_reproduce_target].* = g_xcdr_d[li_reproduce].*
               LET g_xcdr2_d[li_reproduce_target].* = g_xcdr2_d[li_reproduce].*
               LET g_xcdr3_d[li_reproduce_target].* = g_xcdr3_d[li_reproduce].*
 
               LET g_xcdr_d[g_xcdr_d.getLength()].xcdr004 = NULL
               LET g_xcdr_d[g_xcdr_d.getLength()].xcdr005 = NULL
               LET g_xcdr_d[g_xcdr_d.getLength()].xcdr006 = NULL
 
            END IF
            
            #add-point:modify段before insert
            
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
            SELECT COUNT(*) INTO l_count FROM xcdr_t 
             WHERE xcdrent = g_enterprise AND xcdrld = g_xcdr_m.xcdrld
               AND xcdr001 = g_xcdr_m.xcdr001
               AND xcdr002 = g_xcdr_m.xcdr002
               AND xcdr003 = g_xcdr_m.xcdr003
 
               AND xcdr004 = g_xcdr_d[l_ac].xcdr004
               AND xcdr005 = g_xcdr_d[l_ac].xcdr005
               AND xcdr006 = g_xcdr_d[l_ac].xcdr006
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前
            
               #end add-point
               INSERT INTO xcdr_t
                           (xcdrent,
                            xcdrcomp,xcdrld,xcdr002,xcdr003,xcdr001,
                            xcdr004,xcdr005,xcdr006
                            ,xcdr010,xcdr011,xcdr021,xcdr020,xcdr101,xcdr102,xcdr104,xcdr103,xcdr105,xcdr010,xcdr011,xcdr021,xcdr020,xcdr111,xcdr112,xcdr114,xcdr113,xcdr115,xcdr010,xcdr011,xcdr021,xcdr020,xcdr121,xcdr122,xcdr124,xcdr123,xcdr125) 
                     VALUES(g_enterprise,
                            g_xcdr_m.xcdrcomp,g_xcdr_m.xcdrld,g_xcdr_m.xcdr002,g_xcdr_m.xcdr003,g_xcdr_m.xcdr001,
                            g_xcdr_d[l_ac].xcdr004,g_xcdr_d[l_ac].xcdr005,g_xcdr_d[l_ac].xcdr006
                            ,g_xcdr_d[l_ac].xcdr010,g_xcdr_d[l_ac].xcdr011,g_xcdr_d[l_ac].xcdr021,g_xcdr_d[l_ac].xcdr020, 
                                g_xcdr_d[l_ac].xcdr101,g_xcdr_d[l_ac].xcdr102,g_xcdr_d[l_ac].xcdr104, 
                                g_xcdr_d[l_ac].xcdr103,g_xcdr_d[l_ac].xcdr105,g_xcdr_d[l_ac].xcdr010, 
                                g_xcdr_d[l_ac].xcdr011,g_xcdr_d[l_ac].xcdr021,g_xcdr_d[l_ac].xcdr020, 
                                g_xcdr2_d[l_ac].xcdr111,g_xcdr2_d[l_ac].xcdr112,g_xcdr2_d[l_ac].xcdr114, 
                                g_xcdr2_d[l_ac].xcdr113,g_xcdr2_d[l_ac].xcdr115,g_xcdr_d[l_ac].xcdr010, 
                                g_xcdr_d[l_ac].xcdr011,g_xcdr_d[l_ac].xcdr021,g_xcdr_d[l_ac].xcdr020, 
                                g_xcdr3_d[l_ac].xcdr121,g_xcdr3_d[l_ac].xcdr122,g_xcdr3_d[l_ac].xcdr124, 
                                g_xcdr3_d[l_ac].xcdr123,g_xcdr3_d[l_ac].xcdr125)
               #add-point:單身新增中
               
               #end add-point
               LET p_cmd = 'u'
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               INITIALIZE g_xcdr_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xcdr_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #資料多語言用-增/改
               
               #add-point:input段-after_insert
               
               #end add-point
               CALL s_transaction_end('Y','0')
               ERROR "INSERT O.K"
               LET g_rec_b=g_rec_b+1
               DISPLAY g_rec_b TO FORMONLY.cnt
            END IF
            
            #add-point:單身新增後
            
            #end add-point
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               #add-point:單身刪除前
               
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
               IF axct212_before_delete() THEN 
                  
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE axct212_bcl
               LET l_count = g_xcdr_d.getLength()
            END IF 
            
            #add-point:單身刪除後
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE 
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_xcdr_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #此段落由子樣板a01產生
         BEFORE FIELD xcdr004
            #add-point:BEFORE FIELD xcdr004
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdr004
            
            #add-point:AFTER FIELD xcdr004
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcdr_m.xcdrld IS NOT NULL AND g_xcdr_m.xcdr001 IS NOT NULL AND g_xcdr_m.xcdr002 IS NOT NULL AND g_xcdr_m.xcdr003 IS NOT NULL AND g_xcdr_d[g_detail_idx].xcdr004 IS NOT NULL AND g_xcdr_d[g_detail_idx].xcdr005 IS NOT NULL AND g_xcdr_d[g_detail_idx].xcdr006 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcdr_m.xcdrld != g_xcdrld_t OR g_xcdr_m.xcdr001 != g_xcdr001_t OR g_xcdr_m.xcdr002 != g_xcdr002_t OR g_xcdr_m.xcdr003 != g_xcdr003_t OR g_xcdr_d[g_detail_idx].xcdr004 != g_xcdr_d_t.xcdr004 OR g_xcdr_d[g_detail_idx].xcdr005 != g_xcdr_d_t.xcdr005 OR g_xcdr_d[g_detail_idx].xcdr006 != g_xcdr_d_t.xcdr006)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcdr_t WHERE "||"xcdrent = '" ||g_enterprise|| "' AND "||"xcdrld = '"||g_xcdr_m.xcdrld ||"' AND "|| "xcdr001 = '"||g_xcdr_m.xcdr001 ||"' AND "|| "xcdr002 = '"||g_xcdr_m.xcdr002 ||"' AND "|| "xcdr003 = '"||g_xcdr_m.xcdr003 ||"' AND "|| "xcdr004 = '"||g_xcdr_d[g_detail_idx].xcdr004 ||"' AND "|| "xcdr005 = '"||g_xcdr_d[g_detail_idx].xcdr005 ||"' AND "|| "xcdr006 = '"||g_xcdr_d[g_detail_idx].xcdr006 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcdr004
            #add-point:ON CHANGE xcdr004
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdr005
            #add-point:BEFORE FIELD xcdr005
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdr005
            
            #add-point:AFTER FIELD xcdr005
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcdr_m.xcdrld IS NOT NULL AND g_xcdr_m.xcdr001 IS NOT NULL AND g_xcdr_m.xcdr002 IS NOT NULL AND g_xcdr_m.xcdr003 IS NOT NULL AND g_xcdr_d[g_detail_idx].xcdr004 IS NOT NULL AND g_xcdr_d[g_detail_idx].xcdr005 IS NOT NULL AND g_xcdr_d[g_detail_idx].xcdr006 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcdr_m.xcdrld != g_xcdrld_t OR g_xcdr_m.xcdr001 != g_xcdr001_t OR g_xcdr_m.xcdr002 != g_xcdr002_t OR g_xcdr_m.xcdr003 != g_xcdr003_t OR g_xcdr_d[g_detail_idx].xcdr004 != g_xcdr_d_t.xcdr004 OR g_xcdr_d[g_detail_idx].xcdr005 != g_xcdr_d_t.xcdr005 OR g_xcdr_d[g_detail_idx].xcdr006 != g_xcdr_d_t.xcdr006)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcdr_t WHERE "||"xcdrent = '" ||g_enterprise|| "' AND "||"xcdrld = '"||g_xcdr_m.xcdrld ||"' AND "|| "xcdr001 = '"||g_xcdr_m.xcdr001 ||"' AND "|| "xcdr002 = '"||g_xcdr_m.xcdr002 ||"' AND "|| "xcdr003 = '"||g_xcdr_m.xcdr003 ||"' AND "|| "xcdr004 = '"||g_xcdr_d[g_detail_idx].xcdr004 ||"' AND "|| "xcdr005 = '"||g_xcdr_d[g_detail_idx].xcdr005 ||"' AND "|| "xcdr006 = '"||g_xcdr_d[g_detail_idx].xcdr006 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcdr005
            #add-point:ON CHANGE xcdr005
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdr006
            #add-point:BEFORE FIELD xcdr006
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdr006
            
            #add-point:AFTER FIELD xcdr006
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcdr_m.xcdrld IS NOT NULL AND g_xcdr_m.xcdr001 IS NOT NULL AND g_xcdr_m.xcdr002 IS NOT NULL AND g_xcdr_m.xcdr003 IS NOT NULL AND g_xcdr_d[g_detail_idx].xcdr004 IS NOT NULL AND g_xcdr_d[g_detail_idx].xcdr005 IS NOT NULL AND g_xcdr_d[g_detail_idx].xcdr006 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcdr_m.xcdrld != g_xcdrld_t OR g_xcdr_m.xcdr001 != g_xcdr001_t OR g_xcdr_m.xcdr002 != g_xcdr002_t OR g_xcdr_m.xcdr003 != g_xcdr003_t OR g_xcdr_d[g_detail_idx].xcdr004 != g_xcdr_d_t.xcdr004 OR g_xcdr_d[g_detail_idx].xcdr005 != g_xcdr_d_t.xcdr005 OR g_xcdr_d[g_detail_idx].xcdr006 != g_xcdr_d_t.xcdr006)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcdr_t WHERE "||"xcdrent = '" ||g_enterprise|| "' AND "||"xcdrld = '"||g_xcdr_m.xcdrld ||"' AND "|| "xcdr001 = '"||g_xcdr_m.xcdr001 ||"' AND "|| "xcdr002 = '"||g_xcdr_m.xcdr002 ||"' AND "|| "xcdr003 = '"||g_xcdr_m.xcdr003 ||"' AND "|| "xcdr004 = '"||g_xcdr_d[g_detail_idx].xcdr004 ||"' AND "|| "xcdr005 = '"||g_xcdr_d[g_detail_idx].xcdr005 ||"' AND "|| "xcdr006 = '"||g_xcdr_d[g_detail_idx].xcdr006 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcdr006
            #add-point:ON CHANGE xcdr006
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdr010
            #add-point:BEFORE FIELD xcdr010
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdr010
            
            #add-point:AFTER FIELD xcdr010
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcdr010
            #add-point:ON CHANGE xcdr010
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdr011
            #add-point:BEFORE FIELD xcdr011
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdr011
            
            #add-point:AFTER FIELD xcdr011
 
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcdr011
            #add-point:ON CHANGE xcdr011
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdr021
            #add-point:BEFORE FIELD xcdr021
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdr021
            
            #add-point:AFTER FIELD xcdr021
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcdr021
            #add-point:ON CHANGE xcdr021
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdr020
            #add-point:BEFORE FIELD xcdr020
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdr020
            
            #add-point:AFTER FIELD xcdr020
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcdr020
            #add-point:ON CHANGE xcdr020
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdr101
            #add-point:BEFORE FIELD xcdr101
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdr101
            
            #add-point:AFTER FIELD xcdr101
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcdr101
            #add-point:ON CHANGE xcdr101
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdr102
            #add-point:BEFORE FIELD xcdr102
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdr102
            
            #add-point:AFTER FIELD xcdr102
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcdr102
            #add-point:ON CHANGE xcdr102
            
            #END add-point
 
 
                  #Ctrlp:input.c.page1.xcdr004
         ON ACTION controlp INFIELD xcdr004
            #add-point:ON ACTION controlp INFIELD xcdr004
            
            #END add-point
 
         #Ctrlp:input.c.page1.xcdr005
         ON ACTION controlp INFIELD xcdr005
            #add-point:ON ACTION controlp INFIELD xcdr005
            
            #END add-point
 
         #Ctrlp:input.c.page1.xcdr006
         ON ACTION controlp INFIELD xcdr006
            #add-point:ON ACTION controlp INFIELD xcdr006
            
            #END add-point
 
         #Ctrlp:input.c.page1.xcdr010
         ON ACTION controlp INFIELD xcdr010
            #add-point:ON ACTION controlp INFIELD xcdr010
            
            #END add-point
 
         #Ctrlp:input.c.page1.xcdr011
         ON ACTION controlp INFIELD xcdr011
            #add-point:ON ACTION controlp INFIELD xcdr011
            
            #END add-point
 
         #Ctrlp:input.c.page1.xcdr021
         ON ACTION controlp INFIELD xcdr021
            #add-point:ON ACTION controlp INFIELD xcdr021
            
            #END add-point
 
         #Ctrlp:input.c.page1.xcdr020
         ON ACTION controlp INFIELD xcdr020
            #add-point:ON ACTION controlp INFIELD xcdr020
            
            #END add-point
 
         #Ctrlp:input.c.page1.xcdr101
         ON ACTION controlp INFIELD xcdr101
            #add-point:ON ACTION controlp INFIELD xcdr101
            
            #END add-point
 
         #Ctrlp:input.c.page1.xcdr102
         ON ACTION controlp INFIELD xcdr102
            #add-point:ON ACTION controlp INFIELD xcdr102
            
            #END add-point
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
 
               LET INT_FLAG = 0
               LET g_xcdr_d[l_ac].* = g_xcdr_d_t.*
               CLOSE axct212_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_xcdr_d[l_ac].xcdr004 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               LET g_xcdr_d[l_ac].* = g_xcdr_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               
            
               #add-point:單身修改前
               
               #end add-point
         
               UPDATE xcdr_t SET (xcdrld,xcdr001,xcdr002,xcdr003,xcdr004,xcdr005,xcdr006,xcdr010,xcdr011, 
                   xcdr021,xcdr020,xcdr101,xcdr102,xcdr104,xcdr103,xcdr105,xcdr111,xcdr112,xcdr114,xcdr113, 
                   xcdr115,xcdr121,xcdr122,xcdr124,xcdr123,xcdr125) = (g_xcdr_m.xcdrld,g_xcdr_m.xcdr001, 
                   g_xcdr_m.xcdr002,g_xcdr_m.xcdr003,g_xcdr_d[l_ac].xcdr004,g_xcdr_d[l_ac].xcdr005,g_xcdr_d[l_ac].xcdr006, 
                   g_xcdr_d[l_ac].xcdr010,g_xcdr_d[l_ac].xcdr011,g_xcdr_d[l_ac].xcdr021,g_xcdr_d[l_ac].xcdr020, 
                   g_xcdr_d[l_ac].xcdr101,g_xcdr_d[l_ac].xcdr102,g_xcdr_d[l_ac].xcdr104,g_xcdr_d[l_ac].xcdr103, 
                   g_xcdr_d[l_ac].xcdr105,g_xcdr2_d[l_ac].xcdr111,g_xcdr2_d[l_ac].xcdr112,g_xcdr2_d[l_ac].xcdr114, 
                   g_xcdr2_d[l_ac].xcdr113,g_xcdr2_d[l_ac].xcdr115,g_xcdr3_d[l_ac].xcdr121,g_xcdr3_d[l_ac].xcdr122, 
                   g_xcdr3_d[l_ac].xcdr124,g_xcdr3_d[l_ac].xcdr123,g_xcdr3_d[l_ac].xcdr125)
                WHERE xcdrent = g_enterprise AND xcdrld = g_xcdr_m.xcdrld 
                 AND xcdr001 = g_xcdr_m.xcdr001 
                 AND xcdr002 = g_xcdr_m.xcdr002 
                 AND xcdr003 = g_xcdr_m.xcdr003 
 
                 AND xcdr004 = g_xcdr_d_t.xcdr004 #項次   
                 AND xcdr005 = g_xcdr_d_t.xcdr005  
                 AND xcdr006 = g_xcdr_d_t.xcdr006  
 
                 
               #add-point:單身修改中
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcdr_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "xcdr_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
 
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xcdr_m.xcdrld
               LET gs_keys_bak[1] = g_xcdrld_t
               LET gs_keys[2] = g_xcdr_m.xcdr001
               LET gs_keys_bak[2] = g_xcdr001_t
               LET gs_keys[3] = g_xcdr_m.xcdr002
               LET gs_keys_bak[3] = g_xcdr002_t
               LET gs_keys[4] = g_xcdr_m.xcdr003
               LET gs_keys_bak[4] = g_xcdr003_t
               LET gs_keys[5] = g_xcdr_d[g_detail_idx].xcdr004
               LET gs_keys_bak[5] = g_xcdr_d_t.xcdr004
               LET gs_keys[6] = g_xcdr_d[g_detail_idx].xcdr005
               LET gs_keys_bak[6] = g_xcdr_d_t.xcdr005
               LET gs_keys[7] = g_xcdr_d[g_detail_idx].xcdr006
               LET gs_keys_bak[7] = g_xcdr_d_t.xcdr006
               CALL axct212_update_b('xcdr_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     LET g_log1 = util.JSON.stringify(g_xcdr_m),util.JSON.stringify(g_xcdr_d_t)
                     LET g_log2 = util.JSON.stringify(g_xcdr_m),util.JSON.stringify(g_xcdr_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #add-point:單身修改後
               
               #end add-point
            END IF
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_xcdr_d.getLength() = 0 THEN
               NEXT FIELD xcdr004
            END IF
            #add-point:input段after input 
            
            #end add-point    
            
         ON ACTION controlo   
            CALL FGL_SET_ARR_CURR(g_xcdr_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_xcdr_d.getLength()+1
            
      END INPUT
 
 
      
      DISPLAY ARRAY g_xcdr2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
      
         BEFORE ROW
            CALL axct212_b_fill(g_wc2) 
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            DISPLAY g_detail_idx TO FORMONLY.idx
            CALL axct212_ui_detailshow()
        
         BEFORE DISPLAY 
            CALL FGL_SET_ARR_CURR(g_detail_idx)      
         
         #add-point:page2自定義行為
         
         #end add-point
         
      END DISPLAY
      DISPLAY ARRAY g_xcdr3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
      
         BEFORE ROW
            CALL axct212_b_fill(g_wc2) 
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail3")
            LET l_ac = g_detail_idx
            DISPLAY g_detail_idx TO FORMONLY.idx
            CALL axct212_ui_detailshow()
        
         BEFORE DISPLAY 
            CALL FGL_SET_ARR_CURR(g_detail_idx)      
         
         #add-point:page3自定義行為
         
         #end add-point
         
      END DISPLAY
 
      
 
      
      #add-point:input段more_input
      
      #end add-point    
      
      BEFORE DIALOG
         #CALL cl_err_collect_init()    
         #add-point:input段before_dialog
         
         #end add-point 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD xcdrld
        ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD xcdr004
               WHEN "s_detail2"
                  NEXT FIELD xcdr004_2
               WHEN "s_detail3"
                  NEXT FIELD xcdr004_3
 
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
   
   #add-point:input段after_input
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axct212.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION axct212_show()
   #add-point:show段define
   
   #end add-point
   
   #add-point:show段之前
 
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL axct212_b_fill(g_wc2) #單身填充
      CALL axct212_b_fill2('0') #單身填充
   END IF
   
   
 
   #顯示followup圖示
   #+ 此段落由子樣板a48產生
   CALL axct212_set_pk_array()
   #add-point:ON ACTION agendum
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
 
 
   
   DISPLAY BY NAME g_xcdr_m.xcdrcomp,g_xcdr_m.xcdrcomp_desc,g_xcdr_m.xcdrld,g_xcdr_m.xcdrld_desc,g_xcdr_m.xcdr002, 
       g_xcdr_m.xcdr003,g_xcdr_m.xcdr001,g_xcdr_m.xcdr001_desc
   CALL axct212_b_fill(g_wc2_table1)                 #單身
   CALL axct212_b_fill2('0') #單身填充
 
   CALL axct212_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後
   CALL axct212_get_glaa()
   IF g_glaa015 = 'Y' THEN
      CALL cl_set_comp_visible('page_1',TRUE)
   ELSE
      CALL cl_set_comp_visible('page_1',FALSE)
   END IF
   IF g_glaa019 = 'Y' THEN
      CALL cl_set_comp_visible('page_2',TRUE)
   ELSE
      CALL cl_set_comp_visible('page_2',FALSE)
   END IF

   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="axct212.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION axct212_ref_show()
   DEFINE l_ac_t LIKE type_t.num10 #l_ac暫存用
   #add-point:ref_show段define
   
   #end add-point
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:ref_show段m_reference
   
   #end add-point
 
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_xcdr_d.getLength()
      #add-point:ref_show段d_reference
      #根据成本次要素获得成本主要素
      SELECT xcau003 INTO g_xcdr_d[l_ac].xcau003
        FROM xcau_t
       WHERE xcauent = g_enterprise
         AND xcau001 = g_xcdr_d[l_ac].xcdr005
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_xcdr2_d.getLength()
      #add-point:ref_show段d2_reference
      #根据成本次要素获得成本主要素,不用sql，为节省效能，直接从第一单身复制过来，值是一样的
      LET g_xcdr2_d[l_ac].xcau003 = g_xcdr_d[l_ac].xcau003
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_xcdr3_d.getLength()
      #add-point:ref_show段d3_reference
      #根据成本次要素获得成本主要素,不用sql，为节省效能，直接从第一单身复制过来，值是一样的
      LET g_xcdr3_d[l_ac].xcau003 = g_xcdr_d[l_ac].xcau003
      #end add-point
   END FOR
 
   
   #add-point:ref_show段自訂
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="axct212.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION axct212_reproduce()
   DEFINE l_newno     LIKE xcdr_t.xcdrld 
   DEFINE l_oldno     LIKE xcdr_t.xcdrld 
   DEFINE l_newno02     LIKE xcdr_t.xcdr001 
   DEFINE l_oldno02     LIKE xcdr_t.xcdr001 
   DEFINE l_newno03     LIKE xcdr_t.xcdr002 
   DEFINE l_oldno03     LIKE xcdr_t.xcdr002 
   DEFINE l_newno04     LIKE xcdr_t.xcdr003 
   DEFINE l_oldno04     LIKE xcdr_t.xcdr003 
 
   DEFINE l_master    RECORD LIKE xcdr_t.*
   DEFINE l_detail    RECORD LIKE xcdr_t.*
 
   DEFINE l_cnt       LIKE type_t.num5
   #add-point:reproduce段define
   
   #end add-point
 
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF     
 
   IF g_xcdr_m.xcdrld IS NULL
      OR g_xcdr_m.xcdr001 IS NULL
      OR g_xcdr_m.xcdr002 IS NULL
      OR g_xcdr_m.xcdr003 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      RETURN
   END IF
   
   LET g_xcdrld_t = g_xcdr_m.xcdrld
   LET g_xcdr001_t = g_xcdr_m.xcdr001
   LET g_xcdr002_t = g_xcdr_m.xcdr002
   LET g_xcdr003_t = g_xcdr_m.xcdr003
 
   
   LET g_xcdr_m.xcdrld = ""
   LET g_xcdr_m.xcdr001 = ""
   LET g_xcdr_m.xcdr002 = ""
   LET g_xcdr_m.xcdr003 = ""
 
    
   CALL axct212_set_entry('a')
   CALL axct212_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前
   
   #end add-point
   
   CALL axct212_input("r")
   
      LET g_xcdr_m.xcdrld_desc = ''
   DISPLAY BY NAME g_xcdr_m.xcdrld_desc
   LET g_xcdr_m.xcdr001_desc = ''
   DISPLAY BY NAME g_xcdr_m.xcdr001_desc
 
    
   IF INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = 9001 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_xcdr_m.* TO NULL
      INITIALIZE g_xcdr_d TO NULL
      INITIALIZE g_xcdr2_d TO NULL
      INITIALIZE g_xcdr3_d TO NULL
 
      CALL axct212_show()
      LET INT_FLAG = 0
      RETURN
   END IF
   
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_xcdrld_t = g_xcdr_m.xcdrld
   LET g_xcdr001_t = g_xcdr_m.xcdr001
   LET g_xcdr002_t = g_xcdr_m.xcdr002
   LET g_xcdr003_t = g_xcdr_m.xcdr003
 
   
   #組合新增資料的條件
   LET g_add_browse = " xcdrent = '" ||g_enterprise|| "' AND",
                      " xcdrld = '", g_xcdr_m.xcdrld CLIPPED, "' "
                      ," AND xcdr001 = '", g_xcdr_m.xcdr001 CLIPPED, "' "
                      ," AND xcdr002 = '", g_xcdr_m.xcdr002 CLIPPED, "' "
                      ," AND xcdr003 = '", g_xcdr_m.xcdr003 CLIPPED, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axct212_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axct212.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION axct212_detail_reproduce()
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE xcdr_t.*
 
 
   #add-point:delete段define
   
   #end add-point    
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE axct212_detail
   
   #add-point:單身複製前1
   
   #end add-point
   
   #CREATE TEMP TABLE
   LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE axct212_detail AS ",
                "SELECT * FROM xcdr_t "
   PREPARE repro_tbl FROM ls_sql
   EXECUTE repro_tbl
   FREE repro_tbl
                
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO axct212_detail SELECT * FROM xcdr_t 
                                         WHERE xcdrent = g_enterprise AND xcdrld = g_xcdrld_t
                                         AND xcdr001 = g_xcdr001_t
                                         AND xcdr002 = g_xcdr002_t
                                         AND xcdr003 = g_xcdr003_t
 
   
   #將key修正為調整後   
   UPDATE axct212_detail 
      #更新key欄位
      SET xcdrld = g_xcdr_m.xcdrld
          , xcdr001 = g_xcdr_m.xcdr001
          , xcdr002 = g_xcdr_m.xcdr002
          , xcdr003 = g_xcdr_m.xcdr003
 
      #更新共用欄位
      
                                       
   #將資料塞回原table   
   INSERT INTO xcdr_t SELECT * FROM axct212_detail
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      RETURN
   END IF
   
   #add-point:單身複製中1
   #將key修正為調整後   
   UPDATE xcdr_t 
      #更新key欄位
      SET xcdrcomp = g_xcdr_m.xcdrcomp
    WHERE xcdrent = g_enterprise
      AND xcdrld  = g_xcdr_m.xcdrld
      AND xcdr001 = g_xcdr_m.xcdr001
      AND xcdr002 = g_xcdr_m.xcdr002
      AND xcdr003 = g_xcdr_m.xcdr003
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE axct212_detail
   
   #add-point:單身複製後1
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_xcdrld_t = g_xcdr_m.xcdrld
   LET g_xcdr001_t = g_xcdr_m.xcdr001
   LET g_xcdr002_t = g_xcdr_m.xcdr002
   LET g_xcdr003_t = g_xcdr_m.xcdr003
 
   
   DROP TABLE axct212_detail
   
END FUNCTION
 
{</section>}
 
{<section id="axct212.delete" >}
#+ 資料刪除
PRIVATE FUNCTION axct212_delete()
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define
   
   #end add-point     
   
   IF g_xcdr_m.xcdrld IS NULL
   OR g_xcdr_m.xcdr001 IS NULL
   OR g_xcdr_m.xcdr002 IS NULL
   OR g_xcdr_m.xcdr003 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      RETURN
   END IF
 
   EXECUTE axct212_master_referesh USING g_xcdr_m.xcdrld,g_xcdr_m.xcdr001,g_xcdr_m.xcdr002,g_xcdr_m.xcdr003 INTO g_xcdr_m.xcdrcomp, 
       g_xcdr_m.xcdrld,g_xcdr_m.xcdr002,g_xcdr_m.xcdr003,g_xcdr_m.xcdr001
   
   CALL axct212_show()
   
   CALL s_transaction_begin()
   
   
 
   OPEN axct212_cl USING g_enterprise,g_xcdr_m.xcdrld
                                                       ,g_xcdr_m.xcdr001
                                                       ,g_xcdr_m.xcdr002
                                                       ,g_xcdr_m.xcdr003
 
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axct212_cl:" 
      LET g_errparam.code   =  STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      CLOSE axct212_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #鎖住將被更改或取消的資料
   FETCH axct212_cl INTO g_xcdr_m.xcdrcomp,g_xcdr_m.xcdrcomp_desc,g_xcdr_m.xcdrld,g_xcdr_m.xcdrld_desc, 
       g_xcdr_m.xcdr002,g_xcdr_m.xcdr003,g_xcdr_m.xcdr001,g_xcdr_m.xcdr001_desc
   
   #若資料已被他人LOCK
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_xcdr_m.xcdrld 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #IF NOT cl_ask_delete() THEN             #確認一下
   IF cl_ask_del_master() THEN              #確認一下
      #+ 此段落由子樣板a47產生
      #刪除相關文件
      CALL axct212_set_pk_array()
      #add-point:相關文件刪除前
      
      #end add-point   
      CALL cl_doc_remove()  
 
  
 
      #add-point:單身刪除前
      
      #end add-point
      
      DELETE FROM xcdr_t WHERE xcdrent = g_enterprise AND xcdrld = g_xcdr_m.xcdrld
                                                               AND xcdr001 = g_xcdr_m.xcdr001
                                                               AND xcdr002 = g_xcdr_m.xcdr002
                                                               AND xcdr003 = g_xcdr_m.xcdr003
 
                                                               
      #add-point:單身刪除中
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xcdr_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
      END IF
 
      
  
      #add-point:單身刪除後 
      
      #end add-point
      
 
      
      CLEAR FORM
      CALL g_xcdr_d.clear() 
      CALL g_xcdr2_d.clear()       
      CALL g_xcdr3_d.clear()       
 
     
      CALL axct212_ui_browser_refresh()  
      CALL axct212_ui_headershow()  
      CALL axct212_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL axct212_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL axct212_browser_fill("F")
         CLEAR FORM
      END IF
       
   END IF
 
   CLOSE axct212_cl
   CALL s_transaction_end('Y','0')
 
   #流程通知預埋點-D
   CALL cl_flow_notify(g_xcdr_m.xcdrld,'D')
    
END FUNCTION
 
{</section>}
 
{<section id="axct212.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axct212_b_fill(p_wc2)
   DEFINE p_wc2      STRING
   #add-point:b_fill段define
   
   #end add-point     
 
   #先清空單身變數內容
   CALL g_xcdr_d.clear()
   CALL g_xcdr2_d.clear()
   CALL g_xcdr3_d.clear()
 
 
   #add-point:b_fill段sql_before
   
   #end add-point
   
   LET g_sql = "SELECT  UNIQUE xcdr004,xcdr005,xcdr006,xcdr010,xcdr011,xcdr021,xcdr020,xcdr101,xcdr102, 
       xcdr104,xcdr103,xcdr105,xcdr004,xcdr005,xcdr006,xcdr010,xcdr011,xcdr021,xcdr020,xcdr111,xcdr112, 
       xcdr114,xcdr113,xcdr115,xcdr004,xcdr005,xcdr006,xcdr010,xcdr011,xcdr021,xcdr020,xcdr121,xcdr122, 
       xcdr124,xcdr123,xcdr125 FROM xcdr_t",   
               "",
               
               
               " WHERE xcdrent= ? AND xcdrld=? AND xcdr001=? AND xcdr002=? AND xcdr003=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xcdr_t")
   END IF
   
   #add-point:b_fill段sql_after
   
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF axct212_fill_chk(1) THEN
      LET g_sql = g_sql, " ORDER BY xcdr_t.xcdr004,xcdr_t.xcdr005,xcdr_t.xcdr006"
      
      #add-point:b_fill段fill_before
      
      #end add-point
      
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE axct212_pb FROM g_sql
      DECLARE b_fill_cs CURSOR FOR axct212_pb
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs USING g_enterprise,g_xcdr_m.xcdrld,g_xcdr_m.xcdr001,g_xcdr_m.xcdr002,g_xcdr_m.xcdr003
                                               
      FOREACH b_fill_cs INTO g_xcdr_d[l_ac].xcdr004,g_xcdr_d[l_ac].xcdr005,g_xcdr_d[l_ac].xcdr006,g_xcdr_d[l_ac].xcdr010, 
          g_xcdr_d[l_ac].xcdr011,g_xcdr_d[l_ac].xcdr021,g_xcdr_d[l_ac].xcdr020,g_xcdr_d[l_ac].xcdr101, 
          g_xcdr_d[l_ac].xcdr102,g_xcdr_d[l_ac].xcdr104,g_xcdr_d[l_ac].xcdr103,g_xcdr_d[l_ac].xcdr105, 
          g_xcdr2_d[l_ac].xcdr004,g_xcdr2_d[l_ac].xcdr005,g_xcdr2_d[l_ac].xcdr006,g_xcdr2_d[l_ac].xcdr010, 
          g_xcdr2_d[l_ac].xcdr011,g_xcdr2_d[l_ac].xcdr021,g_xcdr2_d[l_ac].xcdr020,g_xcdr2_d[l_ac].xcdr111, 
          g_xcdr2_d[l_ac].xcdr112,g_xcdr2_d[l_ac].xcdr114,g_xcdr2_d[l_ac].xcdr113,g_xcdr2_d[l_ac].xcdr115, 
          g_xcdr3_d[l_ac].xcdr004,g_xcdr3_d[l_ac].xcdr005,g_xcdr3_d[l_ac].xcdr006,g_xcdr3_d[l_ac].xcdr010, 
          g_xcdr3_d[l_ac].xcdr011,g_xcdr3_d[l_ac].xcdr021,g_xcdr3_d[l_ac].xcdr020,g_xcdr3_d[l_ac].xcdr121, 
          g_xcdr3_d[l_ac].xcdr122,g_xcdr3_d[l_ac].xcdr124,g_xcdr3_d[l_ac].xcdr123,g_xcdr3_d[l_ac].xcdr125 
 
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充
         
         #end add-point
      
         #帶出公用欄位reference值
         
         
         
         
 
        
         #add-point:單身資料抓取
         
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
 
            CALL g_xcdr_d.deleteElement(g_xcdr_d.getLength())
      CALL g_xcdr2_d.deleteElement(g_xcdr2_d.getLength())
      CALL g_xcdr3_d.deleteElement(g_xcdr3_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more
   
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   FREE axct212_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="axct212.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axct212_b_fill2(pi_idx)
   DEFINE pi_idx          LIKE type_t.num10  #161108-00012#4 num5==》num10
   DEFINE li_ac           LIKE type_t.num10  #161108-00012#4 num5==》num10
   #add-point:b_fill2段define

   #end add-point
   
   LET li_ac = l_ac 
   
 
      
   #add-point:單身填充後

   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="axct212.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION axct212_before_delete()
   #add-point:before_delete段define
   
   #end add-point 
   
   #add-point:單筆刪除前
   
   #end add-point
   
   DELETE FROM xcdr_t
    WHERE xcdrent = g_enterprise AND xcdrld = g_xcdr_m.xcdrld AND
                              xcdr001 = g_xcdr_m.xcdr001 AND
                              xcdr002 = g_xcdr_m.xcdr002 AND
                              xcdr003 = g_xcdr_m.xcdr003 AND
 
          xcdr004 = g_xcdr_d_t.xcdr004
      AND xcdr005 = g_xcdr_d_t.xcdr005
      AND xcdr006 = g_xcdr_d_t.xcdr006
 
      
   #add-point:單筆刪除中
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcdr_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      RETURN FALSE 
   END IF
   
   #add-point:單筆刪除後
   
   #end add-point
 
   LET g_rec_b = g_rec_b-1
   DISPLAY g_rec_b TO FORMONLY.cnt
 
   RETURN TRUE
    
END FUNCTION
 
{</section>}
 
{<section id="axct212.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION axct212_delete_b(ps_table,ps_keys_bak,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:delete_b段define
   
   #end add-point     
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="axct212.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION axct212_insert_b(ps_table,ps_keys,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   #add-point:insert_b段define
   
   #end add-point     
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="axct212.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION axct212_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   DEFINE ps_table         STRING
   DEFINE ps_page          STRING
   DEFINE ps_keys          DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group         STRING
   DEFINE li_idx           LIKE type_t.num10   #161108-00012#4 num5==》num10
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   #add-point:update_b段define

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
 
{<section id="axct212.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION axct212_lock_b(ps_table,ps_page)
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:lock_b段define
   
   #end add-point   
   
   #先刷新資料
   #CALL axct212_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axct212.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION axct212_unlock_b(ps_table,ps_page)
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define
   
   #end add-point  
   
 
 
END FUNCTION
 
{</section>}
 
{<section id="axct212.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION axct212_set_entry(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define
   
   #end add-point       
 
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("xcdrld,xcdr001,xcdr002,xcdr003",TRUE)
      #add-point:set_entry段欄位控制
      CALL cl_set_comp_entry("xcdrcomp",TRUE)
      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axct212.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION axct212_set_no_entry(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define
   
   #end add-point     
 
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("xcdrld,xcdr001,xcdr002,xcdr003",FALSE)
      #add-point:set_no_entry段欄位控制
      #IF NOT cl_null(g_aw) THEN
         CALL cl_set_comp_entry("xcdrcomp",FALSE)  #修改单身，单头不允许修改
      #END IF
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axct212.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION axct212_set_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define
   
   #end add-point     
   
   #add-point:set_entry_b段
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axct212.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION axct212_set_no_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define
   
   #end add-point    
   
   #add-point:set_no_entry_b段
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="axct212.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION axct212_default_search()
   DEFINE li_idx  LIKE type_t.num10  #161108-00012#4 num5==》num10
   DEFINE li_cnt  LIKE type_t.num10  #161108-00012#4 num5==》num10
   DEFINE ls_wc   STRING
   #add-point:default_search段define

   #end add-point  
   
   #add-point:default_search段開始前

   #end add-point  
   
   LET g_pagestart = 1
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " xcdrld = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " xcdr001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " xcdr002 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " xcdr003 = '", g_argv[04], "' AND "
   END IF
 
   
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
   
   #add-point:default_search段結束前

   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="axct212.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION axct212_fill_chk(ps_idx)
   DEFINE ps_idx        LIKE type_t.chr10
   DEFINE lst_token     base.StringTokenizer
   DEFINE ls_token      STRING
   #add-point:fill_chk段define

   RETURN TRUE   #add 150206 跟着版型调整mail for 150205
   #end add-point
   
   #全部為1=1 or null時回傳true
   IF (cl_null(g_wc2_table1) OR g_wc2_table1.trim() = '1=1') THEN
      RETURN TRUE
   END IF
   
   #第一單身
   IF ps_idx = 1 AND
      ((NOT cl_null(g_wc2_table1) AND g_wc2_table1.trim() <> '1=1')) THEN
      RETURN TRUE
   END IF
   
   #根據wc判定是否需要填充
 
 
   
   #add-point:fill_chk段other
   
   #end add-point
   
   RETURN FALSE
 
END FUNCTION
 
{</section>}
 
{<section id="axct212.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION axct212_modify_detail_chk(ps_record)
   DEFINE ps_record STRING
   DEFINE ls_return STRING
   #add-point:modify_detail_chk段define
   
   #end add-point
   
   #add-point:modify_detail_chk段開始前
   
   #end add-point
   
   CASE ps_record
      WHEN "s_detail1" 
         LET ls_return = "xcdr004"
      WHEN "s_detail2"
         LET ls_return = "xcdr004_2"
      WHEN "s_detail3"
         LET ls_return = "xcdr004_3"
 
      #add-point:modify_detail_chk段自訂page控制
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="axct212.state_change" >}
    
 
{</section>}
 
{<section id="axct212.set_pk_array" >}
   #+ 此段落由子樣板a51產生
#+ 給予pk_array內容
PRIVATE FUNCTION axct212_set_pk_array()
   #add-point:set_pk_array段define
   
   #end add-point
   
   #add-point:set_pk_array段之前
   
   #end add-point  
   
   CALL g_pk_array.clear()
   LET g_pk_array[1].values = g_xcdr_m.xcdrld
   LET g_pk_array[1].column = 'xcdrld'
   LET g_pk_array[2].values = g_xcdr_m.xcdr001
   LET g_pk_array[2].column = 'xcdr001'
   LET g_pk_array[3].values = g_xcdr_m.xcdr002
   LET g_pk_array[3].column = 'xcdr002'
   LET g_pk_array[4].values = g_xcdr_m.xcdr003
   LET g_pk_array[4].column = 'xcdr003'
   
   #add-point:set_pk_array段之後
   
   #end add-point  
   
END FUNCTION
 
 
 
{</section>}
 
{<section id="axct212.other_function" readonly="Y" >}

#版型限制，修改input()
PRIVATE FUNCTION axct212_input2(p_cmd)
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd_t               LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_ac_t                LIKE type_t.num10                #未取消的ARRAY CNT  #161108-00012#4 num5==》num10
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
   DEFINE  l_success             LIKE type_t.num5     
    DEFINE l_sql                  STRING
   #先做狀態判定
   IF p_cmd = 'r' THEN
      LET l_cmd_t = 'r'
      LET p_cmd   = 'a'
   ELSE
      LET l_cmd_t = p_cmd
   END IF   
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_xcdr_m.xcdrcomp,g_xcdr_m.xcdrcomp_desc,g_xcdr_m.xcdrld,g_xcdr_m.xcdrld_desc,g_xcdr_m.xcdr002, 
       g_xcdr_m.xcdr003,g_xcdr_m.xcdr001,g_xcdr_m.xcdr001_desc
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF  
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
   
   LET g_forupd_sql = "SELECT xcdr004,xcdr005,xcdr006,xcdr010,xcdr011,xcdr021,xcdr020,xcdr101,xcdr102, 
       xcdr104,xcdr103,xcdr105 FROM xcdr_t WHERE xcdrent=? AND xcdrld=? AND xcdr001=? AND xcdr002=?  
       AND xcdr003=? AND xcdr004=? AND xcdr005=? AND xcdr006=? FOR UPDATE"
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axct212_bcl21 CURSOR FROM g_forupd_sql      # LOCK CURSOR
   
   
   LET g_forupd_sql = "SELECT xcdr004,xcdr005,xcdr006,xcdr010,xcdr011,xcdr021,xcdr020,xcdr111,xcdr112, 
       xcdr114,xcdr113,xcdr115 FROM xcdr_t WHERE xcdrent=? AND xcdrld=? AND xcdr001=? AND xcdr002=?  
       AND xcdr003=? AND xcdr004=? AND xcdr005=? AND xcdr006=? FOR UPDATE"
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axct212_bcl22 CURSOR FROM g_forupd_sql      # LOCK CURSOR
   
   
   LET g_forupd_sql = "SELECT xcdr004,xcdr005,xcdr006,xcdr010,xcdr011,xcdr021,xcdr020,xcdr121,xcdr122, 
       xcdr124,xcdr123,xcdr125 FROM xcdr_t WHERE xcdrent=? AND xcdrld=? AND xcdr001=? AND xcdr002=?  
       AND xcdr003=? AND xcdr004=? AND xcdr005=? AND xcdr006=? FOR UPDATE"
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axct212_bcl23 CURSOR FROM g_forupd_sql      # LOCK CURSOR
   
   #LET g_forupd_sql = "SELECT xcdr004,xcdr005,xcdr006,xcdr010,xcdr011,xcdr021,xcdr020, ",
   #                   "       xcdr101,xcdr102,xcdr104,xcdr103,xcdr105, ",
   #                   "       xcdr111,xcdr112,xcdr114,xcdr113,xcdr115, ",
   #                   "       xcdr121,xcdr122,xcdr124,xcdr123,xcdr125  ",
   #                   "  FROM xcdr_t WHERE xcdrent=? AND xcdrld=? AND xcdr001=? AND xcdr002=?  
   #    AND xcdr003=? AND xcdr004=? AND xcdr005=? AND xcdr006=? FOR UPDATE"
   #LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   #LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   #DECLARE axct212_bcl2 CURSOR FROM g_forupd_sql      # LOCK CURSOR
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL axct212_set_entry(p_cmd)
   CALL axct212_set_no_entry(p_cmd)

 
   DISPLAY BY NAME g_xcdr_m.xcdrcomp,g_xcdr_m.xcdrld,g_xcdr_m.xcdr002,g_xcdr_m.xcdr003,g_xcdr_m.xcdr001 

   
   LET lb_reproduce = FALSE
   IF p_cmd   = 'a' THEN
      CALL axct212_default()
   END IF
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #單頭段
      INPUT BY NAME g_xcdr_m.xcdrcomp,g_xcdr_m.xcdrld,g_xcdr_m.xcdr002,g_xcdr_m.xcdr003,g_xcdr_m.xcdr001  

         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂單頭ACTION
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF

         AFTER FIELD xcdrcomp
            CALL axct212_chk_column('xcdrcomp') RETURNING l_success
            IF NOT l_success THEN
               NEXT FIELD CURRENT
            END IF
            CALL s_desc_get_department_desc(g_xcdr_m.xcdrcomp) RETURNING g_xcdr_m.xcdrcomp_desc  #法人組織
            DISPLAY g_xcdr_m.xcdrcomp_desc TO xcdrcomp_desc

         AFTER FIELD xcdrld
            CALL axct212_chk_column('xcdrld') RETURNING l_success
            IF NOT l_success THEN
               NEXT FIELD CURRENT
            END IF
            CALL s_desc_get_ld_desc(g_xcdr_m.xcdrld) RETURNING g_xcdr_m.xcdrld_desc #帳別編號
            DISPLAY g_xcdr_m.xcdrld_desc TO xcdrld_desc
            
            CALL axct212_get_glaa()
            IF g_glaa015 = 'Y' THEN
               CALL cl_set_comp_visible('page_1',TRUE)
            ELSE
               CALL cl_set_comp_visible('page_1',FALSE)
            END IF
            IF g_glaa019 = 'Y' THEN
               CALL cl_set_comp_visible('page_2',TRUE)
            ELSE
               CALL cl_set_comp_visible('page_2',FALSE)
            END IF
   
         AFTER FIELD xcdr002
            CALL axct212_chk_column('xcdr002') RETURNING l_success
            IF NOT l_success THEN
               NEXT FIELD CURRENT
            END IF

         AFTER FIELD xcdr003
            CALL axct212_chk_column('xcdr003') RETURNING l_success
            IF NOT l_success THEN
               NEXT FIELD CURRENT
            END IF

         AFTER FIELD xcdr001
            CALL axct212_chk_column('xcdr001') RETURNING l_success
            IF NOT l_success THEN
               NEXT FIELD CURRENT
            END IF
            #成本計算類型说明
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcdr_m.xcdr001
            CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcdr_m.xcdr001_desc = '', g_rtn_fields[1] , ''
            DISPLAY g_xcdr_m.xcdr001_desc TO xcdr001_desc

         ON ACTION controlp INFIELD xcdrcomp #法人组织
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001_2()                      #呼叫開窗
            LET g_xcdr_m.xcdrcomp = g_qryparam.return1
            DISPLAY g_xcdr_m.xcdrcomp TO xcdrcomp  #顯示到畫面上

            CALL s_desc_get_department_desc(g_xcdr_m.xcdrcomp) RETURNING g_xcdr_m.xcdrcomp_desc #法人組織
            DISPLAY g_xcdr_m.xcdrcomp_desc TO xcdrcomp_desc

            NEXT FIELD xcdrcomp                     #返回原欄位

         ON ACTION controlp INFIELD xcdrld   #账别编号
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            LET g_qryparam.where = " glaacomp = '",g_xcdr_m.xcdrcomp,"'"
            CALL q_authorised_ld()                #呼叫開窗
            LET g_xcdr_m.xcdrld = g_qryparam.return1
            DISPLAY g_xcdr_m.xcdrld TO xcdrld  #顯示到畫面上

            CALL s_desc_get_ld_desc(g_xcdr_m.xcdrld) RETURNING g_xcdr_m.xcdrld_desc #帳別編號
            DISPLAY g_xcdr_m.xcdrld_desc TO xcdrld_desc

            NEXT FIELD xcdrld                     #返回原欄位

         ON ACTION controlp INFIELD xcdr001   #成本计算类型
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            CALL q_xcat001()                       #呼叫開窗
            LET g_xcdr_m.xcdr001 = g_qryparam.return1
            DISPLAY g_xcdr_m.xcdr001 TO xcdr001  #顯示到畫面上

            #成本計算類型说明
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcdr_m.xcdr001
            CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcdr_m.xcdr001_desc = '', g_rtn_fields[1] , ''
            DISPLAY g_xcdr_m.xcdr001_desc TO xcdr001_desc

            NEXT FIELD xcdr001                     #返回原欄位
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
            
            CALL axct212_chk_column('xcdrcomp+xcdrld') RETURNING l_success
            IF NOT l_success THEN
               NEXT FIELD xcdrcomp
            END IF
            
            #CALL axct212_chk_column('xcdrld+xcdr002+xcdr003') RETURNING l_success
            #IF NOT l_success THEN
            #   NEXT FIELD xcdrld
            #END IF
            

            IF  NOT cl_null(g_xcdr_m.xcdrld) AND NOT cl_null(g_xcdr_m.xcdr001) AND NOT cl_null(g_xcdr_m.xcdr002) AND NOT cl_null(g_xcdr_m.xcdr003) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcdr_m.xcdrld != g_xcdrld_t  OR g_xcdr_m.xcdr001 != g_xcdr001_t  OR g_xcdr_m.xcdr002 != g_xcdr002_t  OR g_xcdr_m.xcdr003 != g_xcdr003_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcdr_t WHERE "||"xcdrent = '" ||g_enterprise|| "' AND "||"xcdrld = '"||g_xcdr_m.xcdrld ||"' AND "|| "xcdr001 = '"||g_xcdr_m.xcdr001 ||"' AND "|| "xcdr002 = '"||g_xcdr_m.xcdr002 ||"' AND "|| "xcdr003 = '"||g_xcdr_m.xcdr003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD xcdrld
                  END IF
               END IF
            END IF

            IF s_transaction_chk("N",0) THEN
                CALL s_transaction_begin()
            END IF
 
            #多語言處理
            DISPLAY BY NAME g_xcdr_m.xcdrld             
                            ,g_xcdr_m.xcdr001   
                            ,g_xcdr_m.xcdr002   
                            ,g_xcdr_m.xcdr003   
 
 
            IF p_cmd = 'u' THEN
               UPDATE xcdr_t SET (xcdrcomp,xcdrld,xcdr002,xcdr003,xcdr001) = (g_xcdr_m.xcdrcomp,g_xcdr_m.xcdrld, 
                   g_xcdr_m.xcdr002,g_xcdr_m.xcdr003,g_xcdr_m.xcdr001)
                WHERE xcdrent = g_enterprise AND xcdrld = g_xcdrld_t
                  AND xcdr001 = g_xcdr001_t
                  AND xcdr002 = g_xcdr002_t
                  AND xcdr003 = g_xcdr003_t
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcdr_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcdr_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                  OTHERWISE
                     #資料多語言用-增/改
                     INITIALIZE gs_keys TO NULL 
                     LET gs_keys[1] = g_xcdr_m.xcdrld
                     LET gs_keys_bak[1] = g_xcdrld_t
                     LET gs_keys[2] = g_xcdr_m.xcdr001
                     LET gs_keys_bak[2] = g_xcdr001_t
                     LET gs_keys[3] = g_xcdr_m.xcdr002
                     LET gs_keys_bak[3] = g_xcdr002_t
                     LET gs_keys[4] = g_xcdr_m.xcdr003
                     LET gs_keys_bak[4] = g_xcdr003_t
                     LET gs_keys[5] = g_xcdr_d[g_detail_idx].xcdr004
                     LET gs_keys_bak[5] = g_xcdr_d_t.xcdr004
                     LET gs_keys[6] = g_xcdr_d[g_detail_idx].xcdr005
                     LET gs_keys_bak[6] = g_xcdr_d_t.xcdr005
                     LET gs_keys[7] = g_xcdr_d[g_detail_idx].xcdr006
                     LET gs_keys_bak[7] = g_xcdr_d_t.xcdr006
                     CALL axct212_update_b('xcdr_t',gs_keys,gs_keys_bak,"'1'")
                     
                     LET g_xcdrld_t = g_xcdr_m.xcdrld
                     LET g_xcdr001_t = g_xcdr_m.xcdr001
                     LET g_xcdr002_t = g_xcdr_m.xcdr002
                     LET g_xcdr003_t = g_xcdr_m.xcdr003
 
                     LET g_log1 = util.JSON.stringify(g_xcdr_m_t)
                     LET g_log2 = util.JSON.stringify(g_xcdr_m)
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     ELSE
                        CALL s_transaction_end('Y','0')
                     END IF
               END CASE
            
            ELSE      
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL axct212_detail_reproduce()
               END IF
            END IF
                     
            LET g_xcdrld_t = g_xcdr_m.xcdrld
            LET g_xcdr001_t = g_xcdr_m.xcdr001
            LET g_xcdr002_t = g_xcdr_m.xcdr002
            LET g_xcdr003_t = g_xcdr_m.xcdr003
            
            CALL axct212_get_glaa()
            IF g_glaa015 = 'Y' THEN
               CALL cl_set_comp_visible('page_1',TRUE)
            ELSE
               CALL cl_set_comp_visible('page_1',FALSE)
            END IF
            IF g_glaa019 = 'Y' THEN
               CALL cl_set_comp_visible('page_2',TRUE)
            ELSE
               CALL cl_set_comp_visible('page_2',FALSE)
            END IF

           #若單身還沒有輸入資料, 強制切換至單身
           #IF cl_null(g_xcdr_d[1].xcdr004) THEN
           #   CALL g_xcdr_d.deleteElement(1)
           #   NEXT FIELD xcdr004
           #END IF
           
            IF g_xcdr_d.getLength() = 0 THEN
               NEXT FIELD xcdr004
            END IF
 
      END INPUT

      #Page1 預設值產生於此處
      INPUT ARRAY g_xcdr_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xcdr_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axct212_b_fill(g_wc2) 
            IF g_rec_b != 0 THEN
               CALL fgl_set_arr_curr(l_ac)
            END IF
         
         BEFORE ROW
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN axct212_cl USING g_enterprise,
                                               g_xcdr_m.xcdrld
                                               ,g_xcdr_m.xcdr001
                                               ,g_xcdr_m.xcdr002
                                               ,g_xcdr_m.xcdr003
 
                                               
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axct212_cl:" 
                  LET g_errparam.code   =  STATUS 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  CLOSE axct212_cl
                  CALL s_transaction_end('N','0')
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            
            IF g_rec_b >= l_ac 
               AND g_xcdr_d[l_ac].xcdr004 IS NOT NULL
               AND g_xcdr_d[l_ac].xcdr005 IS NOT NULL
               AND g_xcdr_d[l_ac].xcdr006 IS NOT NULL
            THEN
               LET l_cmd='u'
               LET g_xcdr_d_t.* = g_xcdr_d[l_ac].*  #BACKUP
               LET g_xcdr_d_o.* = g_xcdr_d[l_ac].*  #BACKUP
               CALL axct212_set_entry_b(l_cmd)
               CALL axct212_set_no_entry_b(l_cmd)
               OPEN axct212_bcl21 USING g_enterprise,g_xcdr_m.xcdrld,
                                                g_xcdr_m.xcdr001,
                                                g_xcdr_m.xcdr002,
                                                g_xcdr_m.xcdr003,
                                                g_xcdr_d_t.xcdr004
                                                ,g_xcdr_d_t.xcdr005
                                                ,g_xcdr_d_t.xcdr006
 
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axct212_bcl21:" 
                  LET g_errparam.code   =  STATUS 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axct212_bcl21 INTO g_xcdr_d[l_ac].xcdr004,g_xcdr_d[l_ac].xcdr005,g_xcdr_d[l_ac].xcdr006, 
                      g_xcdr_d[l_ac].xcdr010,g_xcdr_d[l_ac].xcdr011,g_xcdr_d[l_ac].xcdr021,g_xcdr_d[l_ac].xcdr020, 
                      g_xcdr_d[l_ac].xcdr101,g_xcdr_d[l_ac].xcdr102,g_xcdr_d[l_ac].xcdr104,g_xcdr_d[l_ac].xcdr103, 
                      g_xcdr_d[l_ac].xcdr105
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_xcdr_d_t.xcdr004 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  CALL axct212_ref_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF 
            
        
         BEFORE INSERT
            INITIALIZE g_xcdr_d_t.* TO NULL
            INITIALIZE g_xcdr_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xcdr_d[l_ac].* TO NULL
            LET g_xcdr_d_t.* = g_xcdr_d[l_ac].*     #新輸入資料
            LET g_xcdr_d_o.* = g_xcdr_d[l_ac].*     #新輸入資料
            #初始值
            LET g_xcdr_d[l_ac].xcdr006 = '1'
            LET g_xcdr_d[l_ac].xcdr010 = 'F'
            LET g_xcdr_d[l_ac].xcdr021 = 0
            LET g_xcdr_d[l_ac].xcdr020 = 0
            LET g_xcdr_d[l_ac].xcdr101 = 0
            LET g_xcdr_d[l_ac].xcdr102 = 0
            LET g_xcdr_d[l_ac].xcdr103 = 0
            LET g_xcdr_d[l_ac].xcdr104 = 0
            LET g_xcdr_d[l_ac].xcdr105 = 0
            CALL cl_show_fld_cont()
            CALL axct212_set_entry_b(l_cmd)
            CALL axct212_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xcdr_d[li_reproduce_target].* = g_xcdr_d[li_reproduce].*
               LET g_xcdr2_d[li_reproduce_target].* = g_xcdr2_d[li_reproduce].*
               LET g_xcdr3_d[li_reproduce_target].* = g_xcdr3_d[li_reproduce].*
 
               LET g_xcdr_d[g_xcdr_d.getLength()].xcdr004 = NULL
               LET g_xcdr_d[g_xcdr_d.getLength()].xcdr005 = NULL
               LET g_xcdr_d[g_xcdr_d.getLength()].xcdr006 = NULL
            END IF 
 
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
            SELECT COUNT(*) INTO l_count FROM xcdr_t 
             WHERE xcdrent = g_enterprise AND xcdrld = g_xcdr_m.xcdrld
               AND xcdr001 = g_xcdr_m.xcdr001
               AND xcdr002 = g_xcdr_m.xcdr002
               AND xcdr003 = g_xcdr_m.xcdr003
               AND xcdr004 = g_xcdr_d[l_ac].xcdr004
               AND xcdr005 = g_xcdr_d[l_ac].xcdr005
               AND xcdr006 = g_xcdr_d[l_ac].xcdr006
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               INSERT INTO xcdr_t
                           (xcdrent,
                            xcdrcomp,xcdrld,xcdr002,xcdr003,xcdr001,
                            xcdr004,xcdr005,xcdr006
                            ,xcdr010,xcdr011,xcdr021,xcdr020,xcdr101,xcdr102,xcdr104,xcdr103,xcdr105
                            ,xcdr111,xcdr112,xcdr114,xcdr113,xcdr115
                            ,xcdr121,xcdr122,xcdr124,xcdr123,xcdr125
                            ) 
                     VALUES(g_enterprise,
                            g_xcdr_m.xcdrcomp,g_xcdr_m.xcdrld,g_xcdr_m.xcdr002,g_xcdr_m.xcdr003,g_xcdr_m.xcdr001,
                            g_xcdr_d[l_ac].xcdr004,g_xcdr_d[l_ac].xcdr005,g_xcdr_d[l_ac].xcdr006
                            ,g_xcdr_d[l_ac].xcdr010,g_xcdr_d[l_ac].xcdr011,g_xcdr_d[l_ac].xcdr021,g_xcdr_d[l_ac].xcdr020, 
                                g_xcdr_d[l_ac].xcdr101,g_xcdr_d[l_ac].xcdr102,g_xcdr_d[l_ac].xcdr104, 
                                g_xcdr_d[l_ac].xcdr103,g_xcdr_d[l_ac].xcdr105,
                                g_xcdr2_d[l_ac].xcdr111,g_xcdr2_d[l_ac].xcdr112,g_xcdr2_d[l_ac].xcdr114, 
                                g_xcdr2_d[l_ac].xcdr113,g_xcdr2_d[l_ac].xcdr115,
                                g_xcdr3_d[l_ac].xcdr121,g_xcdr3_d[l_ac].xcdr122,g_xcdr3_d[l_ac].xcdr124, 
                                g_xcdr3_d[l_ac].xcdr123,g_xcdr3_d[l_ac].xcdr125
                                )
               LET p_cmd = 'u'
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               INITIALIZE g_xcdr_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xcdr_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               CALL s_transaction_end('Y','0')
               ERROR "INSERT O.K"
               LET g_rec_b=g_rec_b+1
               DISPLAY g_rec_b TO FORMONLY.cnt
            END IF
              
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
               IF axct212_before_delete() THEN 
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE axct212_bcl21
               LET l_count = g_xcdr_d.getLength()
            END IF 
              
         AFTER DELETE 
            #如果是最後一筆
            IF l_ac = (g_xcdr_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF

         AFTER FIELD xcdr004
            #成本中心
            CALL axct212_chk_column_b(l_ac,'xcdr004') RETURNING l_success
            IF NOT l_success THEN
               LET g_xcdr_d[l_ac].xcdr004 = g_xcdr_d_o.xcdr004
               NEXT FIELD CURRENT
            END IF
            CALL axct212_chk_column_b(l_ac,'xcdrld+xcdr004+xcdr005+xcdr006') RETURNING l_success
            IF NOT l_success THEN
               LET g_xcdr_d[l_ac].xcdr004 = g_xcdr_d_o.xcdr004
               NEXT FIELD CURRENT
            END IF
            
            IF  g_xcdr_m.xcdrld IS NOT NULL AND g_xcdr_m.xcdr001 IS NOT NULL AND g_xcdr_m.xcdr002 IS NOT NULL AND g_xcdr_m.xcdr003 IS NOT NULL AND g_xcdr_d[g_detail_idx].xcdr004 IS NOT NULL AND g_xcdr_d[g_detail_idx].xcdr005 IS NOT NULL AND g_xcdr_d[g_detail_idx].xcdr006 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcdr_m.xcdrld != g_xcdrld_t OR g_xcdr_m.xcdr001 != g_xcdr001_t OR g_xcdr_m.xcdr002 != g_xcdr002_t OR g_xcdr_m.xcdr003 != g_xcdr003_t OR g_xcdr_d[g_detail_idx].xcdr004 != g_xcdr_d_t.xcdr004 OR g_xcdr_d[g_detail_idx].xcdr005 != g_xcdr_d_t.xcdr005 OR g_xcdr_d[g_detail_idx].xcdr006 != g_xcdr_d_t.xcdr006)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcdr_t WHERE "||"xcdrent = '" ||g_enterprise|| "' AND "||"xcdrld = '"||g_xcdr_m.xcdrld ||"' AND "|| "xcdr001 = '"||g_xcdr_m.xcdr001 ||"' AND "|| "xcdr002 = '"||g_xcdr_m.xcdr002 ||"' AND "|| "xcdr003 = '"||g_xcdr_m.xcdr003 ||"' AND "|| "xcdr004 = '"||g_xcdr_d[g_detail_idx].xcdr004 ||"' AND "|| "xcdr005 = '"||g_xcdr_d[g_detail_idx].xcdr005 ||"' AND "|| "xcdr006 = '"||g_xcdr_d[g_detail_idx].xcdr006 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_xcdr_d_o.xcdr004 = g_xcdr_d[l_ac].xcdr004

         AFTER FIELD xcdr005
            #成本次要素
            CALL axct212_chk_column_b(l_ac,'xcdr005') RETURNING l_success
            IF NOT l_success THEN
               LET g_xcdr_d[l_ac].xcdr005 = g_xcdr_d_o.xcdr005
               NEXT FIELD CURRENT
            END IF
            IF  g_xcdr_m.xcdrld IS NOT NULL AND g_xcdr_m.xcdr001 IS NOT NULL AND g_xcdr_m.xcdr002 IS NOT NULL AND g_xcdr_m.xcdr003 IS NOT NULL AND g_xcdr_d[g_detail_idx].xcdr004 IS NOT NULL AND g_xcdr_d[g_detail_idx].xcdr005 IS NOT NULL AND g_xcdr_d[g_detail_idx].xcdr006 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcdr_m.xcdrld != g_xcdrld_t OR g_xcdr_m.xcdr001 != g_xcdr001_t OR g_xcdr_m.xcdr002 != g_xcdr002_t OR g_xcdr_m.xcdr003 != g_xcdr003_t OR g_xcdr_d[g_detail_idx].xcdr004 != g_xcdr_d_t.xcdr004 OR g_xcdr_d[g_detail_idx].xcdr005 != g_xcdr_d_t.xcdr005 OR g_xcdr_d[g_detail_idx].xcdr006 != g_xcdr_d_t.xcdr006)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcdr_t WHERE "||"xcdrent = '" ||g_enterprise|| "' AND "||"xcdrld = '"||g_xcdr_m.xcdrld ||"' AND "|| "xcdr001 = '"||g_xcdr_m.xcdr001 ||"' AND "|| "xcdr002 = '"||g_xcdr_m.xcdr002 ||"' AND "|| "xcdr003 = '"||g_xcdr_m.xcdr003 ||"' AND "|| "xcdr004 = '"||g_xcdr_d[g_detail_idx].xcdr004 ||"' AND "|| "xcdr005 = '"||g_xcdr_d[g_detail_idx].xcdr005 ||"' AND "|| "xcdr006 = '"||g_xcdr_d[g_detail_idx].xcdr006 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #显示成本主要素
            IF NOT cl_null(g_xcdr_d[l_ac].xcdr005) THEN
               SELECT xcau003 INTO g_xcdr_d[l_ac].xcau003 FROM xcau_t
                WHERE xcauent = g_enterprise
                  AND xcau001 = g_xcdr_d[l_ac].xcdr005
               DISPLAY g_xcdr_d[l_ac].xcau003 TO xcau003
            ELSE
               LET g_xcdr_d[l_ac].xcau003 = ''
               DISPLAY g_xcdr_d[l_ac].xcau003 TO xcau003
            END IF
            
            CALL axct212_chk_column_b(l_ac,'xcdrld+xcdr004+xcdr005+xcdr006') RETURNING l_success
            IF NOT l_success THEN
               LET g_xcdr_d[l_ac].xcdr005 = g_xcdr_d_o.xcdr005
               NEXT FIELD CURRENT
            END IF
            
            LET g_xcdr_d_o.xcdr005 = g_xcdr_d[l_ac].xcdr005

         AFTER FIELD xcdr006
            #分摊方式
            CALL axct212_chk_column_b(l_ac,'xcdr006') RETURNING l_success
            IF NOT l_success THEN
               LET g_xcdr_d[l_ac].xcdr006 = g_xcdr_d_o.xcdr006
               NEXT FIELD CURRENT
            END IF
            CALL axct212_chk_column_b(l_ac,'xcdrld+xcdr004+xcdr005+xcdr006') RETURNING l_success
            IF NOT l_success THEN
               LET g_xcdr_d[l_ac].xcdr006 = g_xcdr_d_o.xcdr006
               NEXT FIELD CURRENT
            END IF
            
            IF  g_xcdr_m.xcdrld IS NOT NULL AND g_xcdr_m.xcdr001 IS NOT NULL AND g_xcdr_m.xcdr002 IS NOT NULL AND g_xcdr_m.xcdr003 IS NOT NULL AND g_xcdr_d[g_detail_idx].xcdr004 IS NOT NULL AND g_xcdr_d[g_detail_idx].xcdr005 IS NOT NULL AND g_xcdr_d[g_detail_idx].xcdr006 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcdr_m.xcdrld != g_xcdrld_t OR g_xcdr_m.xcdr001 != g_xcdr001_t OR g_xcdr_m.xcdr002 != g_xcdr002_t OR g_xcdr_m.xcdr003 != g_xcdr003_t OR g_xcdr_d[g_detail_idx].xcdr004 != g_xcdr_d_t.xcdr004 OR g_xcdr_d[g_detail_idx].xcdr005 != g_xcdr_d_t.xcdr005 OR g_xcdr_d[g_detail_idx].xcdr006 != g_xcdr_d_t.xcdr006)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcdr_t WHERE "||"xcdrent = '" ||g_enterprise|| "' AND "||"xcdrld = '"||g_xcdr_m.xcdrld ||"' AND "|| "xcdr001 = '"||g_xcdr_m.xcdr001 ||"' AND "|| "xcdr002 = '"||g_xcdr_m.xcdr002 ||"' AND "|| "xcdr003 = '"||g_xcdr_m.xcdr003 ||"' AND "|| "xcdr004 = '"||g_xcdr_d[g_detail_idx].xcdr004 ||"' AND "|| "xcdr005 = '"||g_xcdr_d[g_detail_idx].xcdr005 ||"' AND "|| "xcdr006 = '"||g_xcdr_d[g_detail_idx].xcdr006 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_xcdr_d_o.xcdr006 = g_xcdr_d[l_ac].xcdr006

         AFTER FIELD xcdr010
            #制费类别
            CALL axct212_chk_column_b(l_ac,'xcdr010') RETURNING l_success
            IF NOT l_success THEN
               LET g_xcdr_d[l_ac].xcdr010 = g_xcdr_d_o.xcdr010
               NEXT FIELD CURRENT
            END IF
            LET g_xcdr_d_o.xcdr010 = g_xcdr_d[l_ac].xcdr010

         AFTER FIELD xcdr011
            #会计科目
            #  150916-00015#1 BEGIN    快捷带出类似科目编号     ADD BY XZG201511207
       
         IF NOT cl_null(g_xcdr_d[l_ac].xcdr011) THEN
              LET l_sql = "AND glac007 = '5'"
              IF  s_aglt310_getlike_lc_subject(g_xcdr_m.xcdrld,g_xcdr_d[l_ac].xcdr011,l_sql) THEN
                 INITIALIZE g_qryparam.* TO NULL

                LET g_qryparam.state = 'i'
                LET g_qryparam.reqry = 'FALSE'
                LET g_qryparam.default1 = g_xcdr_d[l_ac].xcdr011
                
                LET g_qryparam.arg1 = g_glaa004
                LET g_qryparam.arg2 = g_xcdr_d[l_ac].xcdr011
                LET g_qryparam.arg3 = g_xcdr_m.xcdrld
                LET g_qryparam.arg4 = "1 "
                LET g_qryparam.where = " glac007 = '5'"
                CALL q_glac002_6()
                LET g_xcdr_d[l_ac].xcdr011 = g_qryparam.return1              #將開窗取得的值回傳到變數
                DISPLAY g_xcdr_d[l_ac].xcdr011 TO xcdr011  
                
              END IF
               IF NOT  s_aglt310_lc_subject(g_xcdr_m.xcdrld,g_xcdr_d[l_ac].xcdr011,'N') THEN
                   LET g_xcdr_d[l_ac].xcdr011 = g_xcdr_d_o.xcdr011
                          
                   NEXT FIELD CURRENT
              END IF
          END IF
 #  150916-00015#1 END
            CALL axct212_chk_column_b(l_ac,'xcdr011') RETURNING l_success
            
            IF NOT l_success THEN
               LET g_xcdr_d[l_ac].xcdr011 = g_xcdr_d_o.xcdr011
               NEXT FIELD CURRENT
            END IF
            LET g_xcdr_d_o.xcdr011 = g_xcdr_d[l_ac].xcdr011

         AFTER FIELD xcdr021
            #标准产能
            CALL axct212_chk_column_b(l_ac,'xcdr021') RETURNING l_success
            IF NOT l_success THEN
               LET g_xcdr_d[l_ac].xcdr021 = g_xcdr_d_o.xcdr021
               NEXT FIELD CURRENT
            END IF
            #计算：闲置费用xcdr104|xcdr114|xcdr124，分摊金额xcdr103|xcdr113|xcdr123，单位成本xcdr105|xcdr115|xcdr125
            CALL axct212_get_xcdr104(g_xcdr_d[l_ac].xcdr021,g_xcdr_d[l_ac].xcdr020,g_xcdr_d[l_ac].xcdr102,g_xcdr_d[l_ac].xcdr101)
               RETURNING g_xcdr_d[l_ac].xcdr104,g_xcdr_d[l_ac].xcdr103,g_xcdr_d[l_ac].xcdr105
            DISPLAY g_xcdr_d[l_ac].xcdr104 TO xcdr104
            DISPLAY g_xcdr_d[l_ac].xcdr103 TO xcdr103
            DISPLAY g_xcdr_d[l_ac].xcdr105 TO xcdr105
            
            CALL axct212_get_xcdr104(g_xcdr_d[l_ac].xcdr021,g_xcdr_d[l_ac].xcdr020,g_xcdr2_d[l_ac].xcdr112,g_xcdr2_d[l_ac].xcdr111)
               RETURNING g_xcdr2_d[l_ac].xcdr114,g_xcdr2_d[l_ac].xcdr113,g_xcdr2_d[l_ac].xcdr115
            DISPLAY g_xcdr2_d[l_ac].xcdr114 TO xcdr114_2
            DISPLAY g_xcdr2_d[l_ac].xcdr113 TO xcdr113_2
            DISPLAY g_xcdr2_d[l_ac].xcdr115 TO xcdr115_2
            
            CALL axct212_get_xcdr104(g_xcdr_d[l_ac].xcdr021,g_xcdr_d[l_ac].xcdr020,g_xcdr3_d[l_ac].xcdr122,g_xcdr3_d[l_ac].xcdr121)
               RETURNING g_xcdr3_d[l_ac].xcdr124,g_xcdr3_d[l_ac].xcdr123,g_xcdr3_d[l_ac].xcdr125
            DISPLAY g_xcdr3_d[l_ac].xcdr124 TO xcdr124_3
            DISPLAY g_xcdr3_d[l_ac].xcdr123 TO xcdr123_3
            DISPLAY g_xcdr3_d[l_ac].xcdr125 TO xcdr125_3
            
            LET g_xcdr_d_o.xcdr021 = g_xcdr_d[l_ac].xcdr021

         AFTER FIELD xcdr020
            #分摊基础指标总数
            CALL axct212_chk_column_b(l_ac,'xcdr020') RETURNING l_success
            IF NOT l_success THEN
               LET g_xcdr_d[l_ac].xcdr020 = g_xcdr_d_o.xcdr020
               NEXT FIELD CURRENT
            END IF

            #计算：闲置费用xcdr104|xcdr114|xcdr124，分摊金额xcdr103|xcdr113|xcdr123，单位成本xcdr105|xcdr115|xcdr125
            CALL axct212_get_xcdr104(g_xcdr_d[l_ac].xcdr021,g_xcdr_d[l_ac].xcdr020,g_xcdr_d[l_ac].xcdr102,g_xcdr_d[l_ac].xcdr101)
               RETURNING g_xcdr_d[l_ac].xcdr104,g_xcdr_d[l_ac].xcdr103,g_xcdr_d[l_ac].xcdr105
            DISPLAY g_xcdr_d[l_ac].xcdr104 TO xcdr104
            DISPLAY g_xcdr_d[l_ac].xcdr103 TO xcdr103
            DISPLAY g_xcdr_d[l_ac].xcdr105 TO xcdr105
            
            CALL axct212_get_xcdr104(g_xcdr_d[l_ac].xcdr021,g_xcdr_d[l_ac].xcdr020,g_xcdr2_d[l_ac].xcdr112,g_xcdr2_d[l_ac].xcdr111)
               RETURNING g_xcdr2_d[l_ac].xcdr114,g_xcdr2_d[l_ac].xcdr113,g_xcdr2_d[l_ac].xcdr115
            DISPLAY g_xcdr2_d[l_ac].xcdr114 TO xcdr114_2
            DISPLAY g_xcdr2_d[l_ac].xcdr113 TO xcdr113_2
            DISPLAY g_xcdr2_d[l_ac].xcdr115 TO xcdr115_2
            
            CALL axct212_get_xcdr104(g_xcdr_d[l_ac].xcdr021,g_xcdr_d[l_ac].xcdr020,g_xcdr3_d[l_ac].xcdr122,g_xcdr3_d[l_ac].xcdr121)
               RETURNING g_xcdr3_d[l_ac].xcdr124,g_xcdr3_d[l_ac].xcdr123,g_xcdr3_d[l_ac].xcdr125
            DISPLAY g_xcdr3_d[l_ac].xcdr124 TO xcdr124_3
            DISPLAY g_xcdr3_d[l_ac].xcdr123 TO xcdr123_3
            DISPLAY g_xcdr3_d[l_ac].xcdr125 TO xcdr125_3
            
            #CALL axct212_get_xcdr105(g_xcdr_d[l_ac].xcdr103,g_xcdr_d[l_ac].xcdr020) RETURNING g_xcdr_d[l_ac].xcdr105
            #CALL axct212_get_xcdr105(g_xcdr_d[l_ac].xcdr113,g_xcdr_d[l_ac].xcdr020) RETURNING g_xcdr_d[l_ac].xcdr115
            #CALL axct212_get_xcdr105(g_xcdr_d[l_ac].xcdr123,g_xcdr_d[l_ac].xcdr020) RETURNING g_xcdr_d[l_ac].xcdr125
            #DISPLAY g_xcdr_d[l_ac].xcdr105 TO xcdr105
            #DISPLAY g_xcdr_d[l_ac].xcdr115 TO xcdr115
            #DISPLAY g_xcdr_d[l_ac].xcdr125 TO xcdr125
            
            LET g_xcdr_d_o.xcdr020 = g_xcdr_d[l_ac].xcdr020

         AFTER FIELD xcdr101
            #费用总额
            CALL axct212_chk_column_b(l_ac,'xcdr101') RETURNING l_success
            IF NOT l_success THEN
               LET g_xcdr_d[l_ac].xcdr101 = g_xcdr_d_o.xcdr101
               NEXT FIELD CURRENT
            END IF
            #计算：闲置费用xcdr104|xcdr114|xcdr124，分摊金额xcdr103|xcdr113|xcdr123，单位成本xcdr105|xcdr115|xcdr125
            CALL axct212_get_xcdr104(g_xcdr_d[l_ac].xcdr021,g_xcdr_d[l_ac].xcdr020,g_xcdr_d[l_ac].xcdr102,g_xcdr_d[l_ac].xcdr101)
               RETURNING g_xcdr_d[l_ac].xcdr104,g_xcdr_d[l_ac].xcdr103,g_xcdr_d[l_ac].xcdr105
            DISPLAY g_xcdr_d[l_ac].xcdr104 TO xcdr104
            DISPLAY g_xcdr_d[l_ac].xcdr103 TO xcdr103
            DISPLAY g_xcdr_d[l_ac].xcdr105 TO xcdr105
            
            #更新其他两页签资料
            CALL axct212_get_glaa()
            IF g_glaa015 = 'Y' THEN #本位币二
               IF g_xcdr_d[l_ac].xcdr101 <> 0 THEN
                  CALL s_aooi160_get_exrate('2',g_xcdr_m.xcdrld,'',g_glaa001,g_glaa016,g_xcdr_d[l_ac].xcdr101,g_glaa018)
                      RETURNING g_xcdr2_d[l_ac].xcdr111
               ELSE
                  LET g_xcdr2_d[l_ac].xcdr111 = 0
               END IF
               IF g_xcdr_d[l_ac].xcdr104 <> 0 THEN
                  CALL s_aooi160_get_exrate('2',g_xcdr_m.xcdrld,'',g_glaa001,g_glaa016,g_xcdr_d[l_ac].xcdr104,g_glaa018)
                      RETURNING g_xcdr2_d[l_ac].xcdr114
               ELSE
                  LET g_xcdr2_d[l_ac].xcdr114 = 0
               END IF
               IF g_xcdr_d[l_ac].xcdr103 <> 0 THEN
                  CALL s_aooi160_get_exrate('2',g_xcdr_m.xcdrld,'',g_glaa001,g_glaa016,g_xcdr_d[l_ac].xcdr103,g_glaa018)
                      RETURNING g_xcdr2_d[l_ac].xcdr113
               ELSE
                  LET g_xcdr2_d[l_ac].xcdr113 = 0
               END IF
               IF g_xcdr_d[l_ac].xcdr105 <> 0 THEN
                  CALL s_aooi160_get_exrate('2',g_xcdr_m.xcdrld,'',g_glaa001,g_glaa016,g_xcdr_d[l_ac].xcdr105,g_glaa018)
                      RETURNING g_xcdr2_d[l_ac].xcdr115
               ELSE
                  LET g_xcdr2_d[l_ac].xcdr115 = 0
               END IF
            END IF
            IF g_glaa019 = 'Y' THEN #本位币三
               IF g_xcdr_d[l_ac].xcdr101 <> 0 THEN
                  CALL s_aooi160_get_exrate('2',g_xcdr_m.xcdrld,'',g_glaa001,g_glaa020,g_xcdr_d[l_ac].xcdr101,g_glaa022)
                       RETURNING g_xcdr3_d[l_ac].xcdr121
               ELSE
                  LET g_xcdr3_d[l_ac].xcdr121 = 0
               END IF
               IF g_xcdr_d[l_ac].xcdr104 <> 0 THEN
                  CALL s_aooi160_get_exrate('2',g_xcdr_m.xcdrld,'',g_glaa001,g_glaa020,g_xcdr_d[l_ac].xcdr104,g_glaa022)
                       RETURNING g_xcdr3_d[l_ac].xcdr124
               ELSE
                  LET g_xcdr3_d[l_ac].xcdr124 = 0
               END IF
               IF g_xcdr_d[l_ac].xcdr103 <> 0 THEN
                  CALL s_aooi160_get_exrate('2',g_xcdr_m.xcdrld,'',g_glaa001,g_glaa020,g_xcdr_d[l_ac].xcdr103,g_glaa022)
                       RETURNING g_xcdr3_d[l_ac].xcdr123
               ELSE
                  LET g_xcdr3_d[l_ac].xcdr123 = 0
               END IF
               IF g_xcdr_d[l_ac].xcdr105 <> 0 THEN
                  CALL s_aooi160_get_exrate('2',g_xcdr_m.xcdrld,'',g_glaa001,g_glaa020,g_xcdr_d[l_ac].xcdr105,g_glaa022)
                       RETURNING g_xcdr3_d[l_ac].xcdr125
               ELSE
                  LET g_xcdr3_d[l_ac].xcdr125 = 0
               END IF
            END IF
            
            LET g_xcdr_d_o.xcdr101= g_xcdr_d[l_ac].xcdr101

         AFTER FIELD xcdr102
            #固定费用
            CALL axct212_chk_column_b(l_ac,'xcdr102') RETURNING l_success
            IF NOT l_success THEN
               LET g_xcdr_d[l_ac].xcdr102 = g_xcdr_d_o.xcdr102
               NEXT FIELD CURRENT
            END IF
            #计算：闲置费用xcdr104|xcdr114|xcdr124，分摊金额xcdr103|xcdr113|xcdr123，单位成本xcdr105|xcdr115|xcdr125
            CALL axct212_get_xcdr104(g_xcdr_d[l_ac].xcdr021,g_xcdr_d[l_ac].xcdr020,g_xcdr_d[l_ac].xcdr102,g_xcdr_d[l_ac].xcdr101)
               RETURNING g_xcdr_d[l_ac].xcdr104,g_xcdr_d[l_ac].xcdr103,g_xcdr_d[l_ac].xcdr105
            DISPLAY g_xcdr_d[l_ac].xcdr104 TO xcdr104
            DISPLAY g_xcdr_d[l_ac].xcdr103 TO xcdr103
            DISPLAY g_xcdr_d[l_ac].xcdr105 TO xcdr105
            
            #更新其他两页签资料
            CALL axct212_get_glaa()
            IF g_glaa015 = 'Y' THEN #本位币二
               IF g_xcdr_d[l_ac].xcdr102 <> 0 THEN
                  CALL s_aooi160_get_exrate('2',g_xcdr_m.xcdrld,'',g_glaa001,g_glaa016,g_xcdr_d[l_ac].xcdr102,g_glaa018)
                      RETURNING g_xcdr2_d[l_ac].xcdr112
               ELSE
                  LET g_xcdr2_d[l_ac].xcdr112 = 0
               END IF
               IF g_xcdr_d[l_ac].xcdr104 <> 0 THEN
                  CALL s_aooi160_get_exrate('2',g_xcdr_m.xcdrld,'',g_glaa001,g_glaa016,g_xcdr_d[l_ac].xcdr104,g_glaa018)
                      RETURNING g_xcdr2_d[l_ac].xcdr114
               ELSE
                  LET g_xcdr2_d[l_ac].xcdr114 = 0
               END IF
               IF g_xcdr_d[l_ac].xcdr103 <> 0 THEN
                  CALL s_aooi160_get_exrate('2',g_xcdr_m.xcdrld,'',g_glaa001,g_glaa016,g_xcdr_d[l_ac].xcdr103,g_glaa018)
                      RETURNING g_xcdr2_d[l_ac].xcdr113
               ELSE
                  LET g_xcdr2_d[l_ac].xcdr113 = 0
               END IF
               IF g_xcdr_d[l_ac].xcdr105 <> 0 THEN
                  CALL s_aooi160_get_exrate('2',g_xcdr_m.xcdrld,'',g_glaa001,g_glaa016,g_xcdr_d[l_ac].xcdr105,g_glaa018)
                      RETURNING g_xcdr2_d[l_ac].xcdr115
               ELSE
                  LET g_xcdr2_d[l_ac].xcdr115 = 0
               END IF
            END IF
            IF g_glaa019 = 'Y' THEN #本位币三
               IF g_xcdr_d[l_ac].xcdr102 <> 0 THEN
                  CALL s_aooi160_get_exrate('2',g_xcdr_m.xcdrld,'',g_glaa001,g_glaa020,g_xcdr_d[l_ac].xcdr102,g_glaa022)
                       RETURNING g_xcdr3_d[l_ac].xcdr122
               ELSE
                  LET g_xcdr3_d[l_ac].xcdr122 = 0
               END IF
               IF g_xcdr_d[l_ac].xcdr104 <> 0 THEN
                  CALL s_aooi160_get_exrate('2',g_xcdr_m.xcdrld,'',g_glaa001,g_glaa020,g_xcdr_d[l_ac].xcdr104,g_glaa022)
                       RETURNING g_xcdr3_d[l_ac].xcdr124
               ELSE
                  LET g_xcdr3_d[l_ac].xcdr124 = 0
               END IF
               IF g_xcdr_d[l_ac].xcdr103 <> 0 THEN
                  CALL s_aooi160_get_exrate('2',g_xcdr_m.xcdrld,'',g_glaa001,g_glaa020,g_xcdr_d[l_ac].xcdr103,g_glaa022)
                       RETURNING g_xcdr3_d[l_ac].xcdr123
               ELSE
                  LET g_xcdr3_d[l_ac].xcdr123 = 0
               END IF
               IF g_xcdr_d[l_ac].xcdr105 <> 0 THEN
                  CALL s_aooi160_get_exrate('2',g_xcdr_m.xcdrld,'',g_glaa001,g_glaa020,g_xcdr_d[l_ac].xcdr105,g_glaa022)
                       RETURNING g_xcdr3_d[l_ac].xcdr125
               ELSE
                  LET g_xcdr3_d[l_ac].xcdr125 = 0
               END IF
            END IF
            
            LET g_xcdr_d_o.xcdr102= g_xcdr_d[l_ac].xcdr102

         ON ACTION controlp INFIELD xcdr004  #成本中心
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xcdr_d[l_ac].xcdr004             #給予default值
            LET g_qryparam.arg1 = cl_get_today()
            LET g_qryparam.where = " ooeg009 = '",g_xcdr_m.xcdrcomp,"'"
            CALL q_ooeg001_8()                               #呼叫開窗
            LET g_xcdr_d[l_ac].xcdr004 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_xcdr_d[l_ac].xcdr004 TO xcdr004              #顯示到畫面上
            NEXT FIELD xcdr004                          #返回原欄位

         ON ACTION controlp INFIELD xcdr005  #成本次要素
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xcdr_d[l_ac].xcdr005             #給予default值
            CALL q_xcau001()                               #呼叫開窗
            LET g_xcdr_d[l_ac].xcdr005 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_xcdr_d[l_ac].xcdr005 TO xcdr005              #顯示到畫面上
            NEXT FIELD xcdr005                          #返回原欄位

         ON ACTION controlp INFIELD xcdr011  #会计科目
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xcdr_d[l_ac].xcdr011             #給予default值
            CALL axct212_get_glaa()
            LET g_qryparam.where = " glac001 = '",g_glaa004,"' AND glac003 != '1' AND glac006 = '1' AND glac007 = '5'",
                                     " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   "AND gladld='",g_xcdr_m.xcdrld,"' AND gladent='",g_enterprise,"'",
                                   " AND gladstus = 'Y' )"
            #CALL q_glac002_4() 
            CALL aglt310_04() 
            #呼叫開窗
            LET g_xcdr_d[l_ac].xcdr011 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_xcdr_d[l_ac].xcdr011 TO xcdr011              #顯示到畫面上
            NEXT FIELD xcdr011                          #返回原欄位

         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
 
               LET INT_FLAG = 0
               LET g_xcdr_d[l_ac].* = g_xcdr_d_t.*
               CLOSE axct212_bcl21
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_xcdr_d[l_ac].xcdr004 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_xcdr_d[l_ac].* = g_xcdr_d_t.*
            ELSE
               UPDATE xcdr_t SET (xcdrld,xcdr001,xcdr002,xcdr003,xcdr004,xcdr005,xcdr006,xcdr010,xcdr011, 
                   xcdr021,xcdr020,xcdr101,xcdr102,xcdr104,xcdr103,xcdr105,xcdr111,xcdr112,xcdr114,xcdr113, 
                   xcdr115,xcdr121,xcdr122,xcdr124,xcdr123,xcdr125) = (g_xcdr_m.xcdrld,g_xcdr_m.xcdr001, 
                   g_xcdr_m.xcdr002,g_xcdr_m.xcdr003,g_xcdr_d[l_ac].xcdr004,g_xcdr_d[l_ac].xcdr005,g_xcdr_d[l_ac].xcdr006, 
                   g_xcdr_d[l_ac].xcdr010,g_xcdr_d[l_ac].xcdr011,g_xcdr_d[l_ac].xcdr021,g_xcdr_d[l_ac].xcdr020, 
                   g_xcdr_d[l_ac].xcdr101,g_xcdr_d[l_ac].xcdr102,g_xcdr_d[l_ac].xcdr104,g_xcdr_d[l_ac].xcdr103, 
                   g_xcdr_d[l_ac].xcdr105,g_xcdr2_d[l_ac].xcdr111,g_xcdr2_d[l_ac].xcdr112,g_xcdr2_d[l_ac].xcdr114, 
                   g_xcdr2_d[l_ac].xcdr113,g_xcdr2_d[l_ac].xcdr115,g_xcdr3_d[l_ac].xcdr121,g_xcdr3_d[l_ac].xcdr122, 
                   g_xcdr3_d[l_ac].xcdr124,g_xcdr3_d[l_ac].xcdr123,g_xcdr3_d[l_ac].xcdr125)
                WHERE xcdrent = g_enterprise AND xcdrld = g_xcdr_m.xcdrld 
                 AND xcdr001 = g_xcdr_m.xcdr001 
                 AND xcdr002 = g_xcdr_m.xcdr002 
                 AND xcdr003 = g_xcdr_m.xcdr003 
                 AND xcdr004 = g_xcdr_d_t.xcdr004 #項次   
                 AND xcdr005 = g_xcdr_d_t.xcdr005  
                 AND xcdr006 = g_xcdr_d_t.xcdr006  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcdr_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "xcdr_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
 
                  #   CALL s_transaction_end('N','0')
                     LET g_xcdr_d[l_ac].* = g_xcdr_d_t.*  #add
                  
                  OTHERWISE
                     INITIALIZE gs_keys TO NULL 
                     LET gs_keys[1] = g_xcdr_m.xcdrld
                     LET gs_keys_bak[1] = g_xcdrld_t
                     LET gs_keys[2] = g_xcdr_m.xcdr001
                     LET gs_keys_bak[2] = g_xcdr001_t
                     LET gs_keys[3] = g_xcdr_m.xcdr002
                     LET gs_keys_bak[3] = g_xcdr002_t
                     LET gs_keys[4] = g_xcdr_m.xcdr003
                     LET gs_keys_bak[4] = g_xcdr003_t
                     LET gs_keys[5] = g_xcdr_d[g_detail_idx].xcdr004
                     LET gs_keys_bak[5] = g_xcdr_d_t.xcdr004
                     LET gs_keys[6] = g_xcdr_d[g_detail_idx].xcdr005
                     LET gs_keys_bak[6] = g_xcdr_d_t.xcdr005
                     LET gs_keys[7] = g_xcdr_d[g_detail_idx].xcdr006
                     LET gs_keys_bak[7] = g_xcdr_d_t.xcdr006
                     CALL axct212_update_b('xcdr_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     LET g_log1 = util.JSON.stringify(g_xcdr_m),util.JSON.stringify(g_xcdr_d_t)
                     LET g_log2 = util.JSON.stringify(g_xcdr_m),util.JSON.stringify(g_xcdr_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
            END IF
            
         #add begin
         AFTER ROW
           IF l_cmd = 'u' THEN
              CLOSE axct212_bcl21
           END IF
           CALL s_transaction_end('Y','0')
         #add end

         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_xcdr_d.getLength() = 0 THEN
               NEXT FIELD xcdr004
            END IF 
            
         ON ACTION controlo   
            CALL FGL_SET_ARR_CURR(g_xcdr_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_xcdr_d.getLength()+1
            
      END INPUT

      #本位币二
      INPUT ARRAY g_xcdr2_d FROM s_detail2.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
 
         BEFORE INPUT
            #IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
            #  CALL FGL_SET_ARR_CURR(g_xcdr2_d.getLength()+1) 
            #  LET g_insert = 'N' 
            #END IF 
 
            CALL axct212_b_fill(g_wc2) 
            IF g_rec_b != 0 THEN
               CALL fgl_set_arr_curr(l_ac)
            END IF
         
         BEFORE ROW
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx

            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN axct212_cl USING g_enterprise,
                                               g_xcdr_m.xcdrld
                                               ,g_xcdr_m.xcdr001
                                               ,g_xcdr_m.xcdr002
                                               ,g_xcdr_m.xcdr003
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = "OPEN axct212_cl:" 
                  LET g_errparam.code   =  STATUS 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLOSE axct212_cl
                  CALL s_transaction_end('N','0')
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            
            IF g_rec_b >= l_ac 
               AND g_xcdr2_d[l_ac].xcdr004 IS NOT NULL
               AND g_xcdr2_d[l_ac].xcdr005 IS NOT NULL
               AND g_xcdr2_d[l_ac].xcdr006 IS NOT NULL
            THEN
               LET l_cmd='u'
               LET g_xcdr2_d_t.* = g_xcdr2_d[l_ac].*  #BACKUP
               LET g_xcdr2_d_o.* = g_xcdr2_d[l_ac].*  #BACKUP
               CALL axct212_set_entry_b(l_cmd)
               CALL axct212_set_no_entry_b(l_cmd)
               OPEN axct212_bcl22 USING g_enterprise,g_xcdr_m.xcdrld,
                                                g_xcdr_m.xcdr001,
                                                g_xcdr_m.xcdr002,
                                                g_xcdr_m.xcdr003,
                                                g_xcdr2_d_t.xcdr004
                                                ,g_xcdr2_d_t.xcdr005
                                                ,g_xcdr2_d_t.xcdr006
 
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axct212_bcl22:" 
                  LET g_errparam.code   =  STATUS 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axct212_bcl22 INTO g_xcdr2_d[l_ac].xcdr004,g_xcdr2_d[l_ac].xcdr005,g_xcdr2_d[l_ac].xcdr006, 
                      g_xcdr2_d[l_ac].xcdr010,g_xcdr2_d[l_ac].xcdr011,g_xcdr2_d[l_ac].xcdr021,g_xcdr2_d[l_ac].xcdr020, 
                      g_xcdr2_d[l_ac].xcdr111,g_xcdr2_d[l_ac].xcdr112,g_xcdr2_d[l_ac].xcdr114,g_xcdr2_d[l_ac].xcdr113, 
                      g_xcdr2_d[l_ac].xcdr115
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_xcdr2_d_t.xcdr004 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  CALL axct212_ref_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF 

         AFTER FIELD xcdr111_2
            #费用总额
            CALL axct212_chk_column_b(l_ac,'xcdr111') RETURNING l_success
            IF NOT l_success THEN
               LET g_xcdr2_d[l_ac].xcdr111 = g_xcdr2_d_o.xcdr111
               NEXT FIELD CURRENT
            END IF
            #计算：闲置费用xcdr104|xcdr114|xcdr124，分摊金额xcdr103|xcdr113|xcdr123，单位成本xcdr105|xcdr115|xcdr125
            CALL axct212_get_xcdr104(g_xcdr2_d[l_ac].xcdr021,g_xcdr2_d[l_ac].xcdr020,g_xcdr2_d[l_ac].xcdr112,g_xcdr2_d[l_ac].xcdr111)
               RETURNING g_xcdr2_d[l_ac].xcdr114,g_xcdr2_d[l_ac].xcdr113,g_xcdr2_d[l_ac].xcdr115
            DISPLAY g_xcdr2_d[l_ac].xcdr114 TO xcdr114_2
            DISPLAY g_xcdr2_d[l_ac].xcdr113 TO xcdr113_2
            DISPLAY g_xcdr2_d[l_ac].xcdr115 TO xcdr115_2
            
            LET g_xcdr2_d_o.xcdr111= g_xcdr2_d[l_ac].xcdr111

         AFTER FIELD xcdr112_2
            #固定费用
            CALL axct212_chk_column_b(l_ac,'xcdr112') RETURNING l_success
            IF NOT l_success THEN
               LET g_xcdr2_d[l_ac].xcdr112 = g_xcdr2_d_o.xcdr112
               NEXT FIELD CURRENT
            END IF
            #计算：闲置费用xcdr104|xcdr114|xcdr124，分摊金额xcdr103|xcdr113|xcdr123，单位成本xcdr105|xcdr115|xcdr125
            CALL axct212_get_xcdr104(g_xcdr2_d[l_ac].xcdr021,g_xcdr2_d[l_ac].xcdr020,g_xcdr2_d[l_ac].xcdr112,g_xcdr2_d[l_ac].xcdr111)
               RETURNING g_xcdr2_d[l_ac].xcdr114,g_xcdr2_d[l_ac].xcdr113,g_xcdr2_d[l_ac].xcdr115
            DISPLAY g_xcdr2_d[l_ac].xcdr114 TO xcdr114_2
            DISPLAY g_xcdr2_d[l_ac].xcdr113 TO xcdr113_2
            DISPLAY g_xcdr2_d[l_ac].xcdr115 TO xcdr115_2
            
            LET g_xcdr2_d_o.xcdr112= g_xcdr2_d[l_ac].xcdr112

         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
 
               LET INT_FLAG = 0
               LET g_xcdr2_d[l_ac].* = g_xcdr2_d_t.*
               CLOSE axct212_bcl22
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_xcdr2_d[l_ac].xcdr004 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_xcdr2_d[l_ac].* = g_xcdr2_d_t.*
            ELSE
               UPDATE xcdr_t SET (xcdrld,xcdr001,xcdr002,xcdr003,xcdr004,xcdr005,xcdr006,xcdr010,xcdr011, 
                   xcdr021,xcdr020,xcdr101,xcdr102,xcdr104,xcdr103,xcdr105,xcdr111,xcdr112,xcdr114,xcdr113, 
                   xcdr115,xcdr121,xcdr122,xcdr124,xcdr123,xcdr125) = (g_xcdr_m.xcdrld,g_xcdr_m.xcdr001, 
                   g_xcdr_m.xcdr002,g_xcdr_m.xcdr003,g_xcdr_d[l_ac].xcdr004,g_xcdr_d[l_ac].xcdr005,g_xcdr_d[l_ac].xcdr006, 
                   g_xcdr_d[l_ac].xcdr010,g_xcdr_d[l_ac].xcdr011,g_xcdr_d[l_ac].xcdr021,g_xcdr_d[l_ac].xcdr020, 
                   g_xcdr_d[l_ac].xcdr101,g_xcdr_d[l_ac].xcdr102,g_xcdr_d[l_ac].xcdr104,g_xcdr_d[l_ac].xcdr103, 
                   g_xcdr_d[l_ac].xcdr105,g_xcdr2_d[l_ac].xcdr111,g_xcdr2_d[l_ac].xcdr112,g_xcdr2_d[l_ac].xcdr114, 
                   g_xcdr2_d[l_ac].xcdr113,g_xcdr2_d[l_ac].xcdr115,g_xcdr3_d[l_ac].xcdr121,g_xcdr3_d[l_ac].xcdr122, 
                   g_xcdr3_d[l_ac].xcdr124,g_xcdr3_d[l_ac].xcdr123,g_xcdr3_d[l_ac].xcdr125)
                WHERE xcdrent = g_enterprise AND xcdrld = g_xcdr_m.xcdrld 
                 AND xcdr001 = g_xcdr_m.xcdr001 
                 AND xcdr002 = g_xcdr_m.xcdr002 
                 AND xcdr003 = g_xcdr_m.xcdr003
                 AND xcdr004 = g_xcdr2_d_t.xcdr004 #項次   
                 AND xcdr005 = g_xcdr2_d_t.xcdr005  
                 AND xcdr006 = g_xcdr2_d_t.xcdr006  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcdr_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "xcdr_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
 
                  #   CALL s_transaction_end('N','0')
                     LET g_xcdr2_d[l_ac].* = g_xcdr2_d_t.*  #add
                  
                  OTHERWISE
                     INITIALIZE gs_keys TO NULL 
                     LET gs_keys[1] = g_xcdr_m.xcdrld
                     LET gs_keys_bak[1] = g_xcdrld_t
                     LET gs_keys[2] = g_xcdr_m.xcdr001
                     LET gs_keys_bak[2] = g_xcdr001_t
                     LET gs_keys[3] = g_xcdr_m.xcdr002
                     LET gs_keys_bak[3] = g_xcdr002_t
                     LET gs_keys[4] = g_xcdr_m.xcdr003
                     LET gs_keys_bak[4] = g_xcdr003_t
                     LET gs_keys[5] = g_xcdr2_d[g_detail_idx].xcdr004
                     LET gs_keys_bak[5] = g_xcdr2_d_t.xcdr004
                     LET gs_keys[6] = g_xcdr2_d[g_detail_idx].xcdr005
                     LET gs_keys_bak[6] = g_xcdr2_d_t.xcdr005
                     LET gs_keys[7] = g_xcdr2_d[g_detail_idx].xcdr006
                     LET gs_keys_bak[7] = g_xcdr2_d_t.xcdr006
                     CALL axct212_update_b('xcdr_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     LET g_log1 = util.JSON.stringify(g_xcdr_m),util.JSON.stringify(g_xcdr2_d_t)
                     LET g_log2 = util.JSON.stringify(g_xcdr_m),util.JSON.stringify(g_xcdr2_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
            END IF
            
         #add begin
         AFTER ROW
           IF l_cmd = 'u' THEN
              CLOSE axct212_bcl22
           END IF
           CALL s_transaction_end('Y','0')
         #add end

         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_xcdr2_d.getLength() = 0 THEN
               NEXT FIELD xcdr004
            END IF 
            
         ON ACTION controlo   
            CALL FGL_SET_ARR_CURR(g_xcdr2_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_xcdr2_d.getLength()+1
      END INPUT

      #本位币三
      INPUT ARRAY g_xcdr3_d FROM s_detail3.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
 
         BEFORE INPUT
            #IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
            #  CALL FGL_SET_ARR_CURR(g_xcdr3_d.getLength()+1) 
            #  LET g_insert = 'N' 
            #END IF 
 
            CALL axct212_b_fill(g_wc2) 
            IF g_rec_b != 0 THEN
               CALL fgl_set_arr_curr(l_ac)
            END IF
         
         BEFORE ROW
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx

            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN axct212_cl USING g_enterprise,
                                               g_xcdr_m.xcdrld
                                               ,g_xcdr_m.xcdr001
                                               ,g_xcdr_m.xcdr002
                                               ,g_xcdr_m.xcdr003
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = "OPEN axct212_cl:" 
                  LET g_errparam.code   =  STATUS 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLOSE axct212_cl
                  CALL s_transaction_end('N','0')
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            
            IF g_rec_b >= l_ac 
               AND g_xcdr3_d[l_ac].xcdr004 IS NOT NULL
               AND g_xcdr3_d[l_ac].xcdr005 IS NOT NULL
               AND g_xcdr3_d[l_ac].xcdr006 IS NOT NULL
            THEN
               LET l_cmd='u'
               LET g_xcdr3_d_t.* = g_xcdr3_d[l_ac].*  #BACKUP
               LET g_xcdr3_d_o.* = g_xcdr3_d[l_ac].*  #BACKUP
               CALL axct212_set_entry_b(l_cmd)
               CALL axct212_set_no_entry_b(l_cmd)
               OPEN axct212_bcl23 USING g_enterprise,g_xcdr_m.xcdrld,
                                                g_xcdr_m.xcdr001,
                                                g_xcdr_m.xcdr002,
                                                g_xcdr_m.xcdr003,
                                                g_xcdr3_d_t.xcdr004
                                                ,g_xcdr3_d_t.xcdr005
                                                ,g_xcdr3_d_t.xcdr006
 
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axct212_bcl23:" 
                  LET g_errparam.code   =  STATUS 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axct212_bcl23 INTO g_xcdr3_d[l_ac].xcdr004,g_xcdr3_d[l_ac].xcdr005,g_xcdr3_d[l_ac].xcdr006, 
                      g_xcdr3_d[l_ac].xcdr010,g_xcdr3_d[l_ac].xcdr011,g_xcdr3_d[l_ac].xcdr021,g_xcdr3_d[l_ac].xcdr020, 
                      g_xcdr3_d[l_ac].xcdr121,g_xcdr3_d[l_ac].xcdr122,g_xcdr3_d[l_ac].xcdr124,g_xcdr3_d[l_ac].xcdr123, 
                      g_xcdr3_d[l_ac].xcdr125
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_xcdr3_d_t.xcdr004 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  CALL axct212_ref_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF 

         AFTER FIELD xcdr121_3
            #费用总额
            CALL axct212_chk_column_b(l_ac,'xcdr121') RETURNING l_success
            IF NOT l_success THEN
               LET g_xcdr3_d[l_ac].xcdr121 = g_xcdr3_d_o.xcdr121
               NEXT FIELD CURRENT
            END IF
            #计算：闲置费用xcdr104|xcdr114|xcdr124，分摊金额xcdr103|xcdr113|xcdr123，单位成本xcdr105|xcdr115|xcdr125
            CALL axct212_get_xcdr104(g_xcdr3_d[l_ac].xcdr021,g_xcdr3_d[l_ac].xcdr020,g_xcdr3_d[l_ac].xcdr122,g_xcdr3_d[l_ac].xcdr121)
               RETURNING g_xcdr3_d[l_ac].xcdr124,g_xcdr3_d[l_ac].xcdr123,g_xcdr3_d[l_ac].xcdr125
            DISPLAY g_xcdr3_d[l_ac].xcdr124 TO xcdr124_3
            DISPLAY g_xcdr3_d[l_ac].xcdr123 TO xcdr123_3
            DISPLAY g_xcdr3_d[l_ac].xcdr125 TO xcdr125_3
            
            LET g_xcdr3_d_o.xcdr121= g_xcdr3_d[l_ac].xcdr121

         AFTER FIELD xcdr122_3
            #固定费用
            CALL axct212_chk_column_b(l_ac,'xcdr122') RETURNING l_success
            IF NOT l_success THEN
               LET g_xcdr3_d[l_ac].xcdr122 = g_xcdr3_d_o.xcdr122
               NEXT FIELD CURRENT
            END IF
            #计算：闲置费用xcdr104|xcdr114|xcdr124，分摊金额xcdr103|xcdr113|xcdr123，单位成本xcdr105|xcdr115|xcdr125
            CALL axct212_get_xcdr104(g_xcdr3_d[l_ac].xcdr021,g_xcdr3_d[l_ac].xcdr020,g_xcdr3_d[l_ac].xcdr122,g_xcdr3_d[l_ac].xcdr121)
               RETURNING g_xcdr3_d[l_ac].xcdr124,g_xcdr3_d[l_ac].xcdr123,g_xcdr3_d[l_ac].xcdr125
            DISPLAY g_xcdr3_d[l_ac].xcdr124 TO xcdr124_3
            DISPLAY g_xcdr3_d[l_ac].xcdr123 TO xcdr123_3
            DISPLAY g_xcdr3_d[l_ac].xcdr125 TO xcdr125_3
            
            LET g_xcdr3_d_o.xcdr122= g_xcdr3_d[l_ac].xcdr122

         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
 
               LET INT_FLAG = 0
               LET g_xcdr3_d[l_ac].* = g_xcdr3_d_t.*
               CLOSE axct212_bcl23
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_xcdr3_d[l_ac].xcdr004 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_xcdr3_d[l_ac].* = g_xcdr3_d_t.*
            ELSE
               UPDATE xcdr_t SET (xcdrld,xcdr001,xcdr002,xcdr003,xcdr004,xcdr005,xcdr006,xcdr010,xcdr011, 
                   xcdr021,xcdr020,xcdr101,xcdr102,xcdr104,xcdr103,xcdr105,xcdr111,xcdr112,xcdr114,xcdr113, 
                   xcdr115,xcdr121,xcdr122,xcdr124,xcdr123,xcdr125) = (g_xcdr_m.xcdrld,g_xcdr_m.xcdr001, 
                   g_xcdr_m.xcdr002,g_xcdr_m.xcdr003,g_xcdr_d[l_ac].xcdr004,g_xcdr_d[l_ac].xcdr005,g_xcdr_d[l_ac].xcdr006, 
                   g_xcdr_d[l_ac].xcdr010,g_xcdr_d[l_ac].xcdr011,g_xcdr_d[l_ac].xcdr021,g_xcdr_d[l_ac].xcdr020, 
                   g_xcdr_d[l_ac].xcdr101,g_xcdr_d[l_ac].xcdr102,g_xcdr_d[l_ac].xcdr104,g_xcdr_d[l_ac].xcdr103, 
                   g_xcdr_d[l_ac].xcdr105,g_xcdr2_d[l_ac].xcdr111,g_xcdr2_d[l_ac].xcdr112,g_xcdr2_d[l_ac].xcdr114, 
                   g_xcdr2_d[l_ac].xcdr113,g_xcdr2_d[l_ac].xcdr115,g_xcdr3_d[l_ac].xcdr121,g_xcdr3_d[l_ac].xcdr122, 
                   g_xcdr3_d[l_ac].xcdr124,g_xcdr3_d[l_ac].xcdr123,g_xcdr3_d[l_ac].xcdr125)
                WHERE xcdrent = g_enterprise AND xcdrld = g_xcdr_m.xcdrld 
                 AND xcdr001 = g_xcdr_m.xcdr001 
                 AND xcdr002 = g_xcdr_m.xcdr002 
                 AND xcdr003 = g_xcdr_m.xcdr003
                 AND xcdr004 = g_xcdr3_d_t.xcdr004 #項次   
                 AND xcdr005 = g_xcdr3_d_t.xcdr005  
                 AND xcdr006 = g_xcdr3_d_t.xcdr006  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcdr_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "xcdr_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
 
                  #   CALL s_transaction_end('N','0')
                     LET g_xcdr3_d[l_ac].* = g_xcdr3_d_t.*  #add
                  
                  OTHERWISE
                     INITIALIZE gs_keys TO NULL 
                     LET gs_keys[1] = g_xcdr_m.xcdrld
                     LET gs_keys_bak[1] = g_xcdrld_t
                     LET gs_keys[2] = g_xcdr_m.xcdr001
                     LET gs_keys_bak[2] = g_xcdr001_t
                     LET gs_keys[3] = g_xcdr_m.xcdr002
                     LET gs_keys_bak[3] = g_xcdr002_t
                     LET gs_keys[4] = g_xcdr_m.xcdr003
                     LET gs_keys_bak[4] = g_xcdr003_t
                     LET gs_keys[5] = g_xcdr3_d[g_detail_idx].xcdr004
                     LET gs_keys_bak[5] = g_xcdr3_d_t.xcdr004
                     LET gs_keys[6] = g_xcdr3_d[g_detail_idx].xcdr005
                     LET gs_keys_bak[6] = g_xcdr3_d_t.xcdr005
                     LET gs_keys[7] = g_xcdr3_d[g_detail_idx].xcdr006
                     LET gs_keys_bak[7] = g_xcdr3_d_t.xcdr006
                     CALL axct212_update_b('xcdr_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     LET g_log1 = util.JSON.stringify(g_xcdr_m),util.JSON.stringify(g_xcdr3_d_t)
                     LET g_log2 = util.JSON.stringify(g_xcdr_m),util.JSON.stringify(g_xcdr3_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
            END IF
            
         #add begin
         AFTER ROW
           IF l_cmd = 'u' THEN
              CLOSE axct212_bcl23
           END IF
           CALL s_transaction_end('Y','0')
         #add end

         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_xcdr3_d.getLength() = 0 THEN
               NEXT FIELD xcdr004
            END IF 
            
         ON ACTION controlo   
            CALL FGL_SET_ARR_CURR(g_xcdr3_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_xcdr3_d.getLength()+1
      END INPUT
      
      #DISPLAY ARRAY g_xcdr2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
      #
      #   BEFORE ROW
      #      CALL axct212_b_fill(g_wc2) 
      #      LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
      #      LET l_ac = g_detail_idx
      #      DISPLAY g_detail_idx TO FORMONLY.idx
      #      CALL axct212_ui_detailshow()
      #  
      #   BEFORE DISPLAY 
      #      CALL FGL_SET_ARR_CURR(g_detail_idx)      
      #
      #   
      #END DISPLAY
      #DISPLAY ARRAY g_xcdr3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
      #
      #   BEFORE ROW
      #      CALL axct212_b_fill(g_wc2) 
      #      LET g_detail_idx = DIALOG.getCurrentRow("s_detail3")
      #      LET l_ac = g_detail_idx
      #      DISPLAY g_detail_idx TO FORMONLY.idx
      #      CALL axct212_ui_detailshow()
      #  
      #   BEFORE DISPLAY 
      #      CALL FGL_SET_ARR_CURR(g_detail_idx)      
      #
      #END DISPLAY
 
      
  
      
      BEFORE DIALOG
         IF p_cmd = 'a' THEN
            NEXT FIELD xcdrcomp
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD xcdr004
               WHEN "s_detail2"
                  NEXT FIELD xcdr004_2
               WHEN "s_detail3"
                  NEXT FIELD xcdr004_3
 
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
   
END FUNCTION

#
PRIVATE FUNCTION axct212_chk_column(p_column)
   DEFINE p_column      LIKE type_t.chr100
   DEFINE r_success     LIKE type_t.num5


   WHENEVER ERROR CONTINUE
   LET r_success = TRUE

   CASE p_column
      WHEN 'xcdrcomp'  #法人
           IF NOT cl_null(g_xcdr_m.xcdrcomp) THEN
              #校验
              INITIALIZE g_chkparam.* TO NULL
              LET g_chkparam.arg1 = g_xcdr_m.xcdrcomp
              IF NOT cl_chk_exist("v_ooef001_1") THEN
                 LET r_success = FALSE
                 RETURN r_success
              END IF
           END IF
      WHEN 'xcdrld'    #帐套
           IF NOT cl_null(g_xcdr_m.xcdrld) THEN
              #校验
              INITIALIZE g_chkparam.* TO NULL
              LET g_chkparam.arg1 = g_xcdr_m.xcdrld
              #160318-00025#11--add--str
              LET g_errshow = TRUE 
              LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
              #160318-00025#11--add--end
              IF NOT cl_chk_exist("v_glaald") THEN
                 LET r_success = FALSE
                 RETURN r_success
              END IF
           END IF
      WHEN 'xcdr001'   #成本计算类型
           IF NOT cl_null(g_xcdr_m.xcdr001) THEN
              #校验
              INITIALIZE g_chkparam.* TO NULL
              LET g_chkparam.arg1 = g_xcdr_m.xcdr001
              #160318-00025#11--add--str
              LET g_errshow = TRUE 
              LET g_chkparam.err_str[1] = "agl-00195:sub-01302|axci100|",cl_get_progname("axci100",g_lang,"2"),"|:EXEPROGaxci100"
              #160318-00025#11--add--end
              IF NOT cl_chk_exist("v_xcat001") THEN
                 LET r_success = FALSE
                 RETURN r_success
              END IF
           END IF
      WHEN 'xcdr002'  #年度
           IF NOT cl_null(g_xcdr_m.xcdr002) THEN
              IF NOT s_fin_date_chk_year(g_xcdr_m.xcdr002) THEN
                 LET r_success = FALSE
                 RETURN r_success
              END IF
           END IF
      WHEN 'xcdr003'  #期别
           IF NOT cl_null(g_xcdr_m.xcdr003) THEN
              IF NOT s_fin_date_chk_month(g_xcdr_m.xcdr003) THEN
                 LET r_success = FALSE
                 RETURN r_success
              END IF
           END IF
      WHEN 'xcdrcomp+xcdrld'  #法人+帐套
           IF NOT cl_null(g_xcdr_m.xcdrcomp) AND NOT cl_null(g_xcdr_m.xcdrld) THEN
              #校验
              INITIALIZE g_chkparam.* TO NULL
              LET g_chkparam.arg1 = g_xcdr_m.xcdrld
              LET g_chkparam.arg2 = g_xcdr_m.xcdrcomp
              #160318-00025#11--add--str
              LET g_errshow = TRUE 
              LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
              #160318-00025#11--add--end
              IF NOT cl_chk_exist("v_glaald_5") THEN
                 LET r_success = FALSE
                 RETURN r_success
              END IF
           END IF
      WHEN 'xcdrld+xcdr002+xcdr003'  #帐套+年度期别
           #IF NOT cl_null(g_xcdr_m.xcdrld) AND NOT cl_null(g_xcdr_m.xcdr002) AND NOT cl_null(g_xcdr_m.xcdr003) THEN
           #   IF NOT s_axc_chk_year_period(g_xcdr_m.xcdrld,g_xcdr_m.xcdr002,g_xcdr_m.xcdr003) THEN
           #      LET r_success = FALSE
           #      RETURN r_success
           #   END IF
           #END IF
   END CASE
   RETURN r_success

END FUNCTION

#
PRIVATE FUNCTION axct212_chk_column_b(p_ac,p_column)
   DEFINE p_ac          LIKE type_t.num10  #传参为null或0 代表全体检查  #161108-00012#4 num5==》num10
   DEFINE p_column      LIKE type_t.chr100
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_cnt         LIKE type_t.num5
   DEFINE l_xcba001     LIKE xcba_t.xcba001

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE

   CASE p_column
      WHEN 'xcdr004'  #成本中心
           IF NOT cl_null(g_xcdr_d[p_ac].xcdr004) THEN
              #校验
              INITIALIZE g_chkparam.* TO NULL
              LET g_chkparam.arg1 = g_xcdr_d[p_ac].xcdr004
              LET g_chkparam.arg2 = cl_get_today()
              #160318-00025#11--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#11--add--end 
              IF NOT cl_chk_exist("v_ooeg001_4") THEN
                 LET r_success = FALSE
                 RETURN r_success
              END IF
           END IF
      WHEN 'xcdr005'  #成本次要素
           IF NOT cl_null(g_xcdr_d[p_ac].xcdr005) THEN
              #校验
              INITIALIZE g_chkparam.* TO NULL
              LET g_chkparam.arg1 = g_xcdr_d[p_ac].xcdr005
              #160318-00025#11--add--str
              LET g_errshow = TRUE 
              LET g_chkparam.err_str[1] = "axc-00056:sub-01302|axci111|",cl_get_progname("axci111",g_lang,"2"),"|:EXEPROGaxci111"
              #160318-00025#11--add--end
              IF NOT cl_chk_exist("v_xcau001") THEN
                 LET r_success = FALSE
                 RETURN r_success
              END IF
           END IF
      WHEN 'xcdr006'   #分摊方式
           IF NOT cl_null(g_xcdr_d[p_ac].xcdr006) THEN
              #无检查
           END IF
      WHEN 'xcdr010'  #制费类别
           IF NOT cl_null(g_xcdr_d[p_ac].xcdr010) THEN
              #无检查
           END IF
      WHEN 'xcdr011'  #会计科目
           IF NOT cl_null(g_xcdr_d[p_ac].xcdr011) THEN
              CALL axct212_get_glaa()
              #校验
              INITIALIZE g_chkparam.* TO NULL
              LET g_chkparam.arg1 = g_glaa004  #会计科目参照表
              LET g_chkparam.arg2 = g_xcdr_d[p_ac].xcdr011
              #160318-00025#11--add--str
              LET g_errshow = TRUE 
              LET g_chkparam.err_str[1] = "agl-00012:sub-01302|agli020|",cl_get_progname("agli020",g_lang,"2"),"|:EXEPROGagli020"
              #160318-00025#11--add--end
              IF NOT cl_chk_exist("v_glac002_5") THEN
                 LET r_success = FALSE
                 RETURN r_success
              END IF
           END IF
      WHEN 'xcdr020'  #分摊基础指标总数
           IF NOT cl_null(g_xcdr_d[p_ac].xcdr020) THEN
              #IF g_xcdr_d[p_ac].xcdr021 < 0 THEN
              #   #输入值不可小于0！
              #   INITIALIZE g_errparam TO NULL
              #   LET g_errparam.extend = ''
              #   LET g_errparam.code   = 'aim-00009'
              #   LET g_errparam.popup  = TRUE
              #   CALL cl_err()
              #   LET r_success = FALSE
              #   RETURN r_success
              #END IF
              #作为除数可能为0
              IF g_xcdr_d[p_ac].xcdr020 <= 0 THEN
                 #输入值不可小于等于0
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = ''
                 LET g_errparam.code   = 'asf-00155'
                 LET g_errparam.popup  = TRUE
                 CALL cl_err()
                 LET r_success = FALSE
                 RETURN r_success
              END IF
           END IF
      WHEN 'xcdr021'  #标准产能
           IF NOT cl_null(g_xcdr_d[p_ac].xcdr021) THEN
              IF g_xcdr_d[p_ac].xcdr021 < 0 THEN
                 #输入值不可小于0！
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = ''
                 LET g_errparam.code   = 'aim-00009'
                 LET g_errparam.popup  = TRUE
                 CALL cl_err()
                 LET r_success = FALSE
                 RETURN r_success
              END IF
           END IF
      WHEN 'xcdr101'  #费用总额
           IF NOT cl_null(g_xcdr_d[p_ac].xcdr101) THEN
              IF g_xcdr_d[p_ac].xcdr101 < 0 THEN
                 #输入值不可小于0！
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = ''
                 LET g_errparam.code   = 'aim-00009'
                 LET g_errparam.popup  = TRUE
                 CALL cl_err()
                 LET r_success = FALSE
                 RETURN r_success
              END IF
           END IF
      WHEN 'xcdr102'  #固定费用
           IF NOT cl_null(g_xcdr_d[p_ac].xcdr102) THEN
              IF g_xcdr_d[p_ac].xcdr102 < 0 THEN
                 #输入值不可小于0！
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = ''
                 LET g_errparam.code   = 'aim-00009'
                 LET g_errparam.popup  = TRUE
                 CALL cl_err()
                 LET r_success = FALSE
                 RETURN r_success
              END IF
           END IF
      WHEN 'xcdr111'  #费用总额
           IF NOT cl_null(g_xcdr2_d[p_ac].xcdr111) THEN
              IF g_xcdr2_d[p_ac].xcdr111 < 0 THEN
                 #输入值不可小于0！
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = ''
                 LET g_errparam.code   = 'aim-00009'
                 LET g_errparam.popup  = TRUE
                 CALL cl_err()
                 LET r_success = FALSE
                 RETURN r_success
              END IF
           END IF
      WHEN 'xcdr112'  #固定费用
           IF NOT cl_null(g_xcdr2_d[p_ac].xcdr112) THEN
              IF g_xcdr2_d[p_ac].xcdr112 < 0 THEN
                 #输入值不可小于0！
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = ''
                 LET g_errparam.code   = 'aim-00009'
                 LET g_errparam.popup  = TRUE
                 CALL cl_err()
                 LET r_success = FALSE
                 RETURN r_success
              END IF
           END IF
      WHEN 'xcdr121'  #费用总额
           IF NOT cl_null(g_xcdr3_d[p_ac].xcdr121) THEN
              IF g_xcdr3_d[p_ac].xcdr121 < 0 THEN
                 #输入值不可小于0！
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = ''
                 LET g_errparam.code   = 'aim-00009'
                 LET g_errparam.popup  = TRUE
                 CALL cl_err()
                 LET r_success = FALSE
                 RETURN r_success
              END IF
           END IF
      WHEN 'xcdr122'  #固定费用
           IF NOT cl_null(g_xcdr3_d[p_ac].xcdr122) THEN
              IF g_xcdr3_d[p_ac].xcdr122 < 0 THEN
                 #输入值不可小于0！
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = ''
                 LET g_errparam.code   = 'aim-00009'
                 LET g_errparam.popup  = TRUE
                 CALL cl_err()
                 LET r_success = FALSE
                 RETURN r_success
              END IF
           END IF
      WHEN 'xcdrld+xcdr004+xcdr005+xcdr006'  #成本中心 成本次要素 分摊方式
           #检核"帐别编号+成本中心+成本主要素+分摊方式"的组合，
           #  是否在成本要素分摊设置档有“帐别编号+成本中心+分摊类型+分摊公式”组合存在
           IF NOT cl_null(g_xcdr_m.xcdrld) AND NOT cl_null(g_xcdr_d[p_ac].xcdr004)
           AND NOT cl_null(g_xcdr_d[l_ac].xcau003) AND NOT cl_null(g_xcdr_d[l_ac].xcdr006) THEN
              #成本主要素与分摊类型两者不是相同的SCC，所以需要手工对应关系
              CASE g_xcdr_d[l_ac].xcau003
                 WHEN '1' #直接材料  axci115中没对应关系
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.extend = ''
                      LET g_errparam.code   = 'axc-00575'
                      LET g_errparam.popup  = TRUE
                      CALL cl_err()
                      LET r_success = FALSE
                      RETURN r_success
                 WHEN '2' #直接人工
                      LET l_xcba001 = '1'
                 WHEN '3' #委外加工  axci115中没对应关系
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.extend = ''
                      LET g_errparam.code   = 'axc-00575'
                      LET g_errparam.popup  = TRUE
                      CALL cl_err()
                      LET r_success = FALSE
                      RETURN r_success
                 WHEN '4' #制造费用1
                      LET l_xcba001 = '2'
                 WHEN '5' #制造费用2
                      LET l_xcba001 = '3'
                 WHEN '6' #制造费用3
                      LET l_xcba001 = '4'
                 WHEN '7' #制造费用4
                      LET l_xcba001 = '5'
                 WHEN '8' #制造费用5
                      LET l_xcba001 = '6'
              END CASE
              #校验
              #INITIALIZE g_chkparam.* TO NULL
              #LET g_chkparam.arg1 = g_xcdr_m.xcdrld
              #LET g_chkparam.arg2 = g_xcdr_d[p_ac].xcdr004
              #LET g_chkparam.arg3 = g_xcdr_d[l_ac].xcdr006
              #LET g_chkparam.arg4 = l_xcba001  #g_xcdr_d[l_ac].xcau003
              #IF NOT cl_chk_exist("v_xcba004") THEN
              #   LET r_success = FALSE
              #   RETURN r_success
              #END IF
              #过单过不过去，暂时用下面写法
              SELECT COUNT(*) INTO l_cnt
                FROM xcba_t
               WHERE xcbaent=g_enterprise
                 AND xcbald = g_xcdr_m.xcdrld
                 AND xcba004= g_xcdr_d[p_ac].xcdr004
                 AND xcba007= g_xcdr_d[l_ac].xcdr006
                 AND xcba001= l_xcba001  #g_xcdr_d[l_ac].xcau003
                 AND xcbastus='Y'
              IF l_cnt = 0 THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = ''
                 LET g_errparam.code   = 'axc-00574'
                 LET g_errparam.popup  = TRUE
                 CALL cl_err()
                 LET r_success = FALSE
                 RETURN r_success
              END IF
           END IF
   END CASE
   RETURN r_success
END FUNCTION

#闲置费用
#标准产能等于0时,闲置费用=0
#若标准产能>0,“标准产能”>“分摊指标总数”,且固定制费>0,则“闲置费用”＝“固定费用”＊((标准产能-分摊指标总数)/标准产能)
#若“标准产能”<“分摊指标总数”,则闲置费用=0
PRIVATE FUNCTION axct212_get_xcdr104(p_xcdr021,p_xcdr020,p_xcdr102,p_xcdr101)
   DEFINE p_xcdr021    LIKE xcdr_t.xcdr021  #标准产能--直接
   DEFINE p_xcdr020    LIKE xcdr_t.xcdr020  #分摊指标总数--直接
   DEFINE p_xcdr102    LIKE xcdr_t.xcdr102  #固定费用--直接
   DEFINE p_xcdr101    LIKE xcdr_t.xcdr101  #费用总额--间接
   DEFINE r_xcdr104    LIKE xcdr_t.xcdr104  #闲置费用
   DEFINE r_xcdr103    LIKE xcdr_t.xcdr103  #分摊金额
   DEFINE r_xcdr105    LIKE xcdr_t.xcdr105  #单位成本

   LET r_xcdr104 = 0
   LET r_xcdr103 = 0
   LET r_xcdr105 = 0
   
   #          固定费用               标准产能             分摊指标总数     固定费用 
   IF cl_null(p_xcdr102) OR cl_null(p_xcdr021) OR cl_null(p_xcdr020) OR p_xcdr102 = 0
   #  标准产能          标准产能     分摊指标总数 
   OR p_xcdr021 = 0 OR p_xcdr021 <= p_xcdr020 THEN
      #   闲置费用
      LET r_xcdr104 = 0
      #计算：分摊金额xcdr103|xcdr113|xcdr123，单位成本xcdr105|xcdr115|xcdr125
      CALL axct212_get_xcdr103(p_xcdr101,r_xcdr104,p_xcdr020)  RETURNING r_xcdr103,r_xcdr105
      RETURN r_xcdr104,r_xcdr103,r_xcdr105
   END IF
   #  标准产能           标准产能    分摊指标总数    固定费用
   IF p_xcdr021 > 0 AND p_xcdr021 > p_xcdr020 AND p_xcdr102 > 0 THEN
      #   闲置费用     固定费用    (标准产能 - 分摊指标总数)/标准产能
      LET r_xcdr104 = p_xcdr102 * (p_xcdr021 - p_xcdr020)/p_xcdr021
      #计算：分摊金额xcdr103|xcdr113|xcdr123，单位成本xcdr105|xcdr115|xcdr125
      CALL axct212_get_xcdr103(p_xcdr101,r_xcdr104,p_xcdr020)  RETURNING r_xcdr103,r_xcdr105
      RETURN r_xcdr104,r_xcdr103,r_xcdr105
   END IF
   
   #计算：分摊金额xcdr103|xcdr113|xcdr123，单位成本xcdr105|xcdr115|xcdr125
   CALL axct212_get_xcdr103(p_xcdr101,r_xcdr104,p_xcdr020)  RETURNING r_xcdr103,r_xcdr105
   RETURN r_xcdr104,r_xcdr103,r_xcdr105
END FUNCTION

#分摊金额=费用总额-闲置费用
PRIVATE FUNCTION axct212_get_xcdr103(p_xcdr101,p_xcdr104,p_xcdr020)
   DEFINE p_xcdr101    LIKE xcdr_t.xcdr101  #费用总额--直接
   DEFINE p_xcdr104    LIKE xcdr_t.xcdr104  #闲置费用--直接
   DEFINE p_xcdr020    LIKE xcdr_t.xcdr020  #分摊基础指标总数--间接
   DEFINE r_xcdr103    LIKE xcdr_t.xcdr103  #分摊金额
   DEFINE r_xcdr105    LIKE xcdr_t.xcdr105  #单位成本
   
   LET r_xcdr103 = 0
   LET r_xcdr105 = 0
   
   IF NOT cl_null(p_xcdr101) AND NOT cl_null(p_xcdr104) THEN
      LET r_xcdr103 = p_xcdr101-p_xcdr104
      IF r_xcdr103 < 0 THEN LET r_xcdr103 = 0 END IF
      #计算：单位成本xcdr105|xcdr115|xcdr125
      CALL axct212_get_xcdr105(r_xcdr103,p_xcdr020) RETURNING r_xcdr105
      RETURN r_xcdr103,r_xcdr105
   END IF
   
   #计算：单位成本xcdr105|xcdr115|xcdr125
   CALL axct212_get_xcdr105(r_xcdr103,p_xcdr020) RETURNING r_xcdr105
   RETURN r_xcdr103,r_xcdr105
END FUNCTION

#单位成本=分摊金额/分摊基础指标总数
PRIVATE FUNCTION axct212_get_xcdr105(p_xcdr103,p_xcdr020)
   DEFINE p_xcdr103    LIKE xcdr_t.xcdr103  #分摊金额--直接
   DEFINE p_xcdr020    LIKE xcdr_t.xcdr020  #分摊基础指标总数--直接
   DEFINE r_xcdr105    LIKE xcdr_t.xcdr105  #单位成本
   
   LET r_xcdr105 = 0
   IF NOT cl_null(p_xcdr103) AND NOT cl_null(p_xcdr020) AND p_xcdr020!=0 THEN
      LET r_xcdr105 = p_xcdr103 / p_xcdr020
   END IF
   RETURN r_xcdr105
END FUNCTION

#预设
PRIVATE FUNCTION axct212_default()


   #预设当前site的法人，主账套，年度期别，成本计算类型
   CALL s_axc_set_site_default() RETURNING g_xcdr_m.xcdrcomp,g_xcdr_m.xcdrld,g_xcdr_m.xcdr002,g_xcdr_m.xcdr003,g_xcdr_m.xcdr001

   #说明栏位
   CALL s_desc_get_department_desc(g_xcdr_m.xcdrcomp) RETURNING g_xcdr_m.xcdrcomp_desc #法人組織
   CALL s_desc_get_ld_desc(g_xcdr_m.xcdrld) RETURNING g_xcdr_m.xcdrld_desc #帳別編號
   #成本計算類型
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xcdr_m.xcdr001
   CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcdr_m.xcdr001_desc = '', g_rtn_fields[1] , ''

END FUNCTION

#根據帳套獲取相關資料
PRIVATE FUNCTION axct212_get_glaa()
   LET g_glaa001 = ''  #使用幣別
   LET g_glaa002 = ''  #匯率參照表號
   LET g_glaa003 = ''  #會計週期參照表號
   LET g_glaa004 = ''  #會計科目參照表號
   LET g_glaa015 = ''  #啟用本位幣二
   LET g_glaa016 = ''  #本位幣二
   LET g_glaa018 = ''  #本位幣二匯率採用
   LET g_glaa019 = ''  #啟用本位幣三
   LET g_glaa020 = ''  #本位幣三
   LET g_glaa022 = ''  #本位幣三匯率採用
   LET g_glaa024 = ''  #單據別參照表號

   SELECT glaa001,glaa002,glaa003,glaa004,glaa015,glaa016,glaa018,glaa019,glaa020,glaa022,glaa024
     INTO g_glaa001,g_glaa002,g_glaa003,g_glaa004,g_glaa015,g_glaa016,g_glaa018,g_glaa019,g_glaa020,g_glaa022,g_glaa024
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = g_xcdr_m.xcdrld
END FUNCTION

 
{</section>}
 
