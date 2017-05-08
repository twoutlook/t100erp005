#該程式已解開Section, 不再透過樣板產出!
{<section id="axcq920.description" >}
#應用 a00 樣板自動產生(Version:1)
#+ Version..: T100-ERP-1.00.00(SD版次:4,PR版次:4) Build-000070
#+ 
#+ Filename...: axcq920
#+ Description: 庫存調整成本查詢作業
#+ Creator....: 00537(2014-09-04 00:00:00)
#+ Modifier...: 01588(2015-10-19 15:21:56) -SD/PR- 02040
 
{</section>}
 
{<section id="axcq920.global" >}
#應用 i07 樣板自動產生(Version:30)
#160318-00025#10  2016/04/22 By 07675       將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160816-00001#11  2016/08/17  By 08734      抓取理由碼改CALL sub
#160802-00020#9   2016/09/26  By 02097      法人:視azzi800的据點權限/帳套: 視USER的帳套權限/QBE下法人/帳套不用互相勾稽
#161019-00017#10  2016/10/26  By 08734      调整法人组织开窗由q_ooef001变为q_ooef001_2
 
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
PRIVATE type type_g_xcco_m        RECORD
       xccocomp LIKE xcco_t.xccocomp, 
   xccocomp_desc LIKE type_t.chr80,
   xcco004 LIKE xcco_t.xcco004, 
   xcco005 LIKE xcco_t.xcco005,
   xcco001 LIKE xcco_t.xcco001, 
   xcco001_desc LIKE type_t.chr80, 
   xccold LIKE xcco_t.xccold, 
   xccold_desc LIKE type_t.chr80, 
   xcco003 LIKE xcco_t.xcco003, 
   xcco003_desc LIKE type_t.chr80
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_xcco_d        RECORD
   xcco002 LIKE xcco_t.xcco002, 
   xcco002_desc LIKE type_t.chr500, 
   xcco006 LIKE xcco_t.xcco006, 
   xcco006_desc LIKE type_t.chr500, 
   xcco006_desc_1 LIKE type_t.chr500, 
   xcco007 LIKE xcco_t.xcco007, 
   xcco008 LIKE xcco_t.xcco008, 
   xcco010 LIKE xcco_t.xcco010, 
   xcco009 LIKE xcco_t.xcco009, 
   xcco102 LIKE xcco_t.xcco102, 
   xcco102a LIKE xcco_t.xcco102a, 
   xcco102b LIKE xcco_t.xcco102b, 
   xcco102d LIKE xcco_t.xcco102d, 
   xcco102e LIKE xcco_t.xcco102e, 
   xcco102f LIKE xcco_t.xcco102f, 
   xcco102g LIKE xcco_t.xcco102g, 
   xcco102h LIKE xcco_t.xcco102h, 
   xcco102c LIKE xcco_t.xcco102c
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)
DEFINE g_acc                 LIKE gzcb_t.gzcb007
#2015/3/27 ouhz add------begin----
TYPE type_g_xcco_e RECORD
       v          STRING
       END RECORD
DEFINE g_param                     type_g_xcco_e
DEFINE g_sql_tmp             STRING
#2015/3/27 ouhz add------end----
#160802-00020#9-s-add
DEFINE g_wc_cs_ld            STRING
DEFINE g_wc_cs_comp          STRING
#160802-00020#9-e-add
#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_xcco_m          type_g_xcco_m
DEFINE g_xcco_m_t        type_g_xcco_m
DEFINE g_xcco_m_o        type_g_xcco_m
DEFINE g_xcco_m_mask_o   type_g_xcco_m #轉換遮罩前資料
DEFINE g_xcco_m_mask_n   type_g_xcco_m #轉換遮罩後資料
 
   DEFINE g_xcco001_t LIKE xcco_t.xcco001
DEFINE g_xccold_t LIKE xcco_t.xccold
DEFINE g_xcco003_t LIKE xcco_t.xcco003
DEFINE g_xcco005_t LIKE xcco_t.xcco005 
DEFINE g_xcco004_t LIKE xcco_t.xcco004
 
 
DEFINE g_xcco_d          DYNAMIC ARRAY OF type_g_xcco_d
DEFINE g_xcco_d_t        type_g_xcco_d
DEFINE g_xcco_d_o        type_g_xcco_d
DEFINE g_xcco_d_mask_o   DYNAMIC ARRAY OF type_g_xcco_d #轉換遮罩前資料
DEFINE g_xcco_d_mask_n   DYNAMIC ARRAY OF type_g_xcco_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_xccold LIKE xcco_t.xccold,
      b_xcco001 LIKE xcco_t.xcco001,
      b_xcco003 LIKE xcco_t.xcco003,
      b_xcco004 LIKE xcco_t.xcco004,
      b_xcco005 LIKE xcco_t.xcco005
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
 
#add-point:自定義客戶專用模組變數(Module Variable)

#end add-point
 
#add-point:傳入參數說明(global.argv)

#end add-point
 
{</section>}
 
{<section id="axcq920.main" >}
#應用 a26 樣板自動產生(Version:5)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用)

   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)

   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("axc","")
 
   #add-point:作業初始化
   LET g_acc = ''
   #抓取[T:系統分類值檔].[C:系統分類碼]=24且[T:系統分類值檔].[C:系統分類碼]=g_prog 的[T:系統分類值檔].[C:參考欄位二]的欄位值
   #SELECT gzcb004 INTO g_acc FROM gzcb_t WHERE gzcb001 = '24' AND gzcb002 = 'aint302'  #160816-00001#11  2016/08/17  By 08734 Mark
   LET g_acc = s_fin_get_scc_value('24','aint302','2')  #160816-00001#11  2016/08/17  By 08734 add
   #160802-00020#9-s-add
   CALL s_fin_create_account_center_tmp()                      #展組織下階成員所需之暫存檔 
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_ld_str() RETURNING g_wc_cs_ld
   CALL s_fin_get_wc_str(g_wc_cs_ld)  RETURNING g_wc_cs_ld
   CALL s_axc_get_authcomp() RETURNING g_wc_cs_comp            #抓取使用者有拜訪權限據點的對應法人  
   #160802-00020#9-e-add
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define

   #end add-point
   LET g_forupd_sql = " SELECT xccocomp,'',xcco004,xcco001,'',xccold,'',xcco005,xcco003,''", 
                      " FROM xcco_t",
                      " WHERE xccoent= ? AND xccold=? AND xcco001=? AND xcco003=? AND xcco004=? AND  
                          xcco005=? FOR UPDATE"
   #add-point:SQL_define

   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axcq920_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT UNIQUE t0.xccocomp,t0.xcco004,t0.xcco001,t0.xccold,t0.xcco005,t0.xcco003,t1.ooefl003 , 
       t2.ooail003 ,t3.glaal002 ,t4.xcatl003",
               " FROM xcco_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent='"||g_enterprise||"' AND t1.ooefl001=t0.xccocomp AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t2 ON t2.ooailent='"||g_enterprise||"' AND t2.ooail001=t0.xcco001 AND t2.ooail002='"||g_dlang||"' ",
               " LEFT JOIN glaal_t t3 ON t3.glaalent='"||g_enterprise||"' AND t3.glaalld=t0.xccold AND t3.glaal001='"||g_dlang||"' ",
               " LEFT JOIN xcatl_t t4 ON t4.xcatlent='"||g_enterprise||"' AND t4.xcatl001=t0.xcco003 AND t4.xcatl002='"||g_dlang||"' ",
 
               " WHERE t0.xccoent = '" ||g_enterprise|| "' AND t0.xccold = ? AND t0.xcco001 = ? AND t0.xcco003 = ? AND t0.xcco004 = ? AND t0.xcco005 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define

   #end add-point
   PREPARE axcq920_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call

      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axcq920 WITH FORM cl_ap_formpath("axc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axcq920_init()   
 
      #進入選單 Menu (="N")
      CALL axcq920_ui_dialog() 
      
      #add-point:畫面關閉前

      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axcq920
      
   END IF 
   
   CLOSE axcq920_cl
   
   
 
   #add-point:作業離開前

   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
{</section>}
 
{<section id="axcq920.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axcq920_init()
   #add-point:init段define
   
   #end add-point   
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)
   
   #end add-point
   
   LET g_bfill = "Y"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
      CALL cl_set_combo_scc('xcco001','8914') 
 
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #add-point:畫面資料初始化
   CALL cl_set_combo_scc('xcco001','8914')
   CALL cl_set_combo_scc("xcco010",'8916')
   #特性
   IF cl_get_para(g_enterprise,g_site,'S-FIN-6013') = 'N' THEN
      CALL cl_set_comp_visible('xcco007',FALSE)
   END IF
   #成本域
   IF cl_get_para(g_enterprise,g_site,'S-FIN-6001') = 'N' THEN
      CALL cl_set_comp_visible('xcco002,xcco002_desc',FALSE) 
   END IF 
   #end add-point
   
   CALL axcq920_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="axcq920.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION axcq920_ui_dialog()
   #add-point:ui_dialog段define
   
   #end add-point
   DEFINE la_param  RECORD
          prog       STRING,
          actionid   STRING,
          background LIKE type_t.chr1,
          param      DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   DEFINE li_idx    LIKE type_t.num10
   DEFINE ls_wc     STRING
   DEFINE lb_first  BOOLEAN
   #add-point:ui_dialog段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)
   
   #end add-point  
   
   LET lb_first = TRUE
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   #add-point:ui_dialog段before dialog 
   IF cl_null(g_wc) OR g_wc = " 1=1" THEN
      CALL axcq920_query()
   END IF
   #end add-point
   
   WHILE TRUE
      
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_xcco_m.* TO NULL
         CALL g_xcco_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL axcq920_init()
      END IF
 
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
        
         DISPLAY ARRAY g_xcco_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL axcq920_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL axcq920_ui_detailshow()
               
               #add-point:page1自定義行為
               
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
               
               
            
 
            #add-point:page1自定義行為
            
            #end add-point
               
         END DISPLAY
        
 
         
 
         
         #add-point:ui_dialog段自定義display array
 
         #end add-point
         
         
         BEFORE DIALOG
            #先填充browser資料
            CALL axcq920_browser_fill("")
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
               CALL axcq920_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL axcq920_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2
            #ouhz 2015/3/27 add ----begin-----
            ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN  
               #創建臨時表，存放當前單身數據
               CALL axcq920_create_temp_table()        
               #把單身內容放入暫存檔，以便XG調用打印
               CALL axcq920_ins_temp()          
               LET g_param.v = "axcq920_tmp"
               CALL axcq520_x01('1=1',g_param.v)
               EXIT DIALOG
            END IF
            #ouhz 2015/3/27 add ----end-----   
            

            #end add-point
 
         
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL axcq920_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq920_idx_chk()
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL axcq920_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq920_idx_chk()
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL axcq920_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq920_idx_chk()
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL axcq920_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq920_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL axcq920_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq920_idx_chk()
            
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
                  LET g_export_node[1] = base.typeInfo.create(g_xcco_d)
                  LET g_export_id[1]   = "s_detail1"
 
                  #add-point:ON ACTION exporttoexcel
                  
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
               NEXT FIELD xcco002
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
               CALL axcq920_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL axcq920_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL axcq920_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axcq920_query()
               #add-point:ON ACTION query
               
               #END add-point
               #應用 a59 樣板自動產生(Version:2)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
            END IF
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:2)
         #新增相關文件
         ON ACTION related_document
            CALL axcq920_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL axcq920_set_pk_array()
            #add-point:ON ACTION agendum
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL axcq920_set_pk_array()
            #add-point:ON ACTION followup
            
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
 
{<section id="axcq920.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION axcq920_browser_search(p_type)
 
   #add-point:browser_search段define

   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)

   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axcq920.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION axcq920_browser_fill(ps_page_action)
   #add-point:browser_fill段define

   #end add-point   
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   DEFINE l_searchcol       STRING
   #add-point:browser_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)
 
   #end add-point
   
   #add-point:browser_fill段動作開始前
 
   #end add-point    
 
    LET l_searchcol = "xccold,xcco001,xcco003,xcco004,xcco005"
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
      LET l_sub_sql = " SELECT UNIQUE xccold ",
                      ", xcco001 ",
                      ", xcco003 ",
                      ", xcco004 ",
                      ", xcco005 ",
 
                      " FROM xcco_t ",
                      " ",
                      " ",
 
                      " WHERE xccoent = '" ||g_enterprise|| "' AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("xcco_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE xccold ",
                      ", xcco001 ",
                      ", xcco003 ",
                      ", xcco004 ",
                      ", xcco005 ",
                      
                      " FROM xcco_t ",
                      " ",
                      " ",
                      " WHERE xccoent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED, cl_sql_add_filter("xcco_t")
   END IF 
   
   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"
 
   #add-point:browser_fill,count前
   #160802-00020#9-s-add
   #---增加帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET l_sub_sql = l_sub_sql , " AND xccold IN ",g_wc_cs_ld
   END IF
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET l_sub_sql = l_sub_sql," AND xccocomp IN ",g_wc_cs_comp
   END IF  
   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"   
   #160802-00020#9-e-add
   #end add-point
   
   PREPARE header_cnt_pre FROM g_sql
   EXECUTE header_cnt_pre INTO g_browser_cnt   #總筆數
   FREE header_cnt_pre
   
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
      INITIALIZE g_xcco_m.* TO NULL
      CALL g_xcco_d.clear()        
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
  #依照t0.xccold,t0.xcco001,t0.xcco003,t0.xcco004,t0.xcco005 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.xccold,t0.xcco001,t0.xcco003,t0.xcco004,t0.xcco005",
                " FROM xcco_t t0",
                " ",
                " ",
                 
                " WHERE t0.xccoent = '" ||g_enterprise|| "' AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("xcco_t")
 
   #add-point:browser_fill,sql_rank前
   #160802-00020#9-s-add
   #---增加帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET g_sql = g_sql , " AND t0.xccold IN ",g_wc_cs_ld
   END IF
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET g_sql = g_sql," AND t0.xccocomp IN ",g_wc_cs_comp
   END IF  
   #160802-00020#9-e-add
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前
 
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"xcco_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre
 
    FOREACH browse_cur INTO g_browser[g_cnt].b_xccold,g_browser[g_cnt].b_xcco001,g_browser[g_cnt].b_xcco003, 
       g_browser[g_cnt].b_xcco004,g_browser[g_cnt].b_xcco005  
 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = 'Foreach:' 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      
      
      #add-point:browser_fill段reference

      #end add-point  
 
      
      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_browse THEN
         EXIT FOREACH
      END IF
   END FOREACH
 
   #清空g_add_browse, 並指定指標位置
   IF NOT cl_null(g_add_browse) THEN
      LET g_add_browse = ""
      CALL g_curr_diag.setCurrentRow("s_browse",g_current_idx)
   END IF
   
   IF cl_null(g_browser[g_cnt].b_xccold) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_xcco_m.* TO NULL
      CALL g_xcco_d.clear()
 
      #add-point:browser_fill段after_clear

      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL axcq920_fetch('')
   
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
   
   FREE browse_pre
    
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
 
   #add-point:browser_fill段結束前

   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="axcq920.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION axcq920_ui_headershow()
   #add-point:ui_headershow段define

   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)

   #end add-point  
   
   LET g_xcco_m.xccold = g_browser[g_current_idx].b_xccold   
   LET g_xcco_m.xcco001 = g_browser[g_current_idx].b_xcco001   
   LET g_xcco_m.xcco003 = g_browser[g_current_idx].b_xcco003
   LET g_xcco_m.xcco004 = g_browser[g_current_idx].b_xcco004   
   LET g_xcco_m.xcco005 = g_browser[g_current_idx].b_xcco005      
 
   EXECUTE axcq920_master_referesh USING g_xcco_m.xccold,g_xcco_m.xcco001,g_xcco_m.xcco003,g_xcco_m.xcco004, 
       g_xcco_m.xcco005 INTO g_xcco_m.xccocomp,g_xcco_m.xcco004,g_xcco_m.xcco001,g_xcco_m.xccold,g_xcco_m.xcco005, 
       g_xcco_m.xcco003,g_xcco_m.xccocomp_desc,g_xcco_m.xcco001_desc,g_xcco_m.xccold_desc,g_xcco_m.xcco003_desc 
   CALL axcq920_show()
   
END FUNCTION
 
{</section>}
 
{<section id="axcq920.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION axcq920_ui_detailshow()
   #add-point:ui_detailshow段define
   
   #end add-point
   #add-point:ui_detailshow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)
   
   #end add-point    
   
   #add-point:ui_detailshow段before
   
   #end add-point  
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
 
      #add-point:ui_detailshow段more
      
      #end add-point 
   END IF
   
   #add-point:ui_detailshow段after
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="axcq920.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION axcq920_ui_browser_refresh()
   #add-point:ui_browser_refresh段define

   #end add-point   
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)

   #end add-point 
   
   LET g_browser_cnt = g_browser.getLength()
   LET g_header_cnt  = g_browser.getLength()
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_xccold = g_xcco_m.xccold 
         AND g_browser[l_i].b_xcco001 = g_xcco_m.xcco001 
         AND g_browser[l_i].b_xcco003 = g_xcco_m.xcco003 
         AND g_browser[l_i].b_xcco004 = g_xcco_m.xcco004 
         AND g_browser[l_i].b_xcco005 = g_xcco_m.xcco005 
 
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
 
{<section id="axcq920.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION axcq920_construct()
   #add-point:cs段define

   #end add-point    
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   #add-point:cs段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)

   #end add-point 
   
   #清除畫面上相關資料
   CLEAR FORM                 
   INITIALIZE g_xcco_m.* TO NULL
   CALL g_xcco_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
       CONSTRUCT BY NAME g_wc ON xccocomp,xcco004,xcco001,xccold,xcco005,xcco003
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct
            CALL axcq920_default()   
            #end add-point 
            
                 #Ctrlp:construct.c.xccocomp
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xccocomp
            #add-point:ON ACTION controlp INFIELD xccocomp
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #160802-00020#9-s
            IF cl_null(g_wc_cs_comp) THEN
               LET g_qryparam.where = " ooef003 = 'Y'"
            ELSE
               LET g_qryparam.where = " ooef003 = 'Y' AND ooef001 IN ",g_wc_cs_comp
            END IF
            #160802-00020#9-e
           # CALL q_ooef001()                           #呼叫開窗   #161019-00017#10  2016/10/26  By 08734  mark
            CALL q_ooef001_2()   #161019-00017#10  2016/10/26  By 08734 add
            DISPLAY g_qryparam.return1 TO xccocomp  #顯示到畫面上
            NEXT FIELD xccocomp                     #返回原欄位
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xccocomp
            #add-point:BEFORE FIELD xccocomp

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xccocomp
            
            #add-point:AFTER FIELD xccocomp

            #END add-point
         
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcco004
            #add-point:BEFORE FIELD xcco004
 
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcco004
            
            #add-point:AFTER FIELD xcco004
 
            #END add-point
            
 
         #Ctrlp:construct.c.xcco004         
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcco004
            #add-point:ON ACTION controlp INFIELD xcco004
 
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcco005
            #add-point:BEFORE FIELD xcco005
 
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcco005
            
            #add-point:AFTER FIELD xcco005
 
            #END add-point
            
 
         #Ctrlp:construct.c.xcco005
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcco005
            #add-point:ON ACTION controlp INFIELD xcco005
 
            #END add-point
 
         #Ctrlp:construct.c.xcco003

         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcco001
            #add-point:BEFORE FIELD xcco001

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcco001
            
            #add-point:AFTER FIELD xcco001

            #END add-point
            
 
         #Ctrlp:construct.c.xcco001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcco001
            #add-point:ON ACTION controlp INFIELD xcco001

            #END add-point
 
         #Ctrlp:construct.c.xccold
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xccold
            #add-point:ON ACTION controlp INFIELD xccold
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #160802-00020#9-s-add
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept             
            #增加帳套權限控制
            IF NOT cl_null(g_wc_cs_ld) THEN
               LET g_qryparam.where = " glaald IN ",g_wc_cs_ld
            END IF
            #160802-00020#9-e-add             
            CALL q_authorised_ld()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccold  #顯示到畫面上
            NEXT FIELD xccold                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xccold
            #add-point:BEFORE FIELD xccold

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xccold
            
            #add-point:AFTER FIELD xccold

            #END add-point
            
 
         #Ctrlp:construct.c.xcco003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcco003
            #add-point:ON ACTION controlp INFIELD xcco003
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcat001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcco003  #顯示到畫面上
            NEXT FIELD xcco003                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcco003
            #add-point:BEFORE FIELD xcco003

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcco003
            
            #add-point:AFTER FIELD xcco003

            #END add-point
            
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON xcco002,xcco006,xcco007,xcco008,xcco010,xcco009,xcco102,xcco102a,xcco102b, 
          xcco102d,xcco102e,xcco102f,xcco102g,xcco102h,xcco102c
           FROM s_detail1[1].xcco002,s_detail1[1].xcco006,s_detail1[1].xcco007,s_detail1[1].xcco008, 
               s_detail1[1].xcco010,s_detail1[1].xcco009,s_detail1[1].xcco102,s_detail1[1].xcco102a, 
               s_detail1[1].xcco102b,s_detail1[1].xcco102d,s_detail1[1].xcco102e,s_detail1[1].xcco102f, 
               s_detail1[1].xcco102g,s_detail1[1].xcco102h,s_detail1[1].xcco102c
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct

            #end add-point 
            
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理

               

          

 

 

         

         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcco002
            #add-point:BEFORE FIELD xcco002

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcco002
            
            #add-point:AFTER FIELD xcco002

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcco002
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcco002
            #add-point:ON ACTION controlp INFIELD xcco002
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcbf001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcco002  #顯示到畫面上            
            NEXT FIELD xcco002                     #返回原欄位
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcco006
            #add-point:BEFORE FIELD xcco006

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcco006
            
            #add-point:AFTER FIELD xcco006

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcco006
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcco006
            #add-point:ON ACTION controlp INFIELD xcco006
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_imaf001_15()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcco006  #顯示到畫面上
            NEXT FIELD xcco006                     #返回原欄位
            #END add-point
 
         #Ctrlp:construct.c.page1.xcco007
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcco007
            #add-point:ON ACTION controlp INFIELD xcco007
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcco007()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcco007  #顯示到畫面上
            NEXT FIELD xcco007                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcco007
            #add-point:BEFORE FIELD xcco007

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcco007
            
            #add-point:AFTER FIELD xcco007

            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcco008
            #add-point:BEFORE FIELD xcco008

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcco008
            
            #add-point:AFTER FIELD xcco008

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcco008
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcco008
            #add-point:ON ACTION controlp INFIELD xcco008

            #END add-point
 
 

 

 

         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcco010
            #add-point:BEFORE FIELD xcco010

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcco010
            
            #add-point:AFTER FIELD xcco010

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcco010
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcco010
            #add-point:ON ACTION controlp INFIELD xcco010

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcco009
            #add-point:BEFORE FIELD xcco009

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcco009
            
            #add-point:AFTER FIELD xcco009

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcco009
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcco009
            #add-point:ON ACTION controlp INFIELD xcco009
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcco009()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcco009  #顯示到畫面上
            NEXT FIELD xcco009                     #返回原欄位
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcco102
            #add-point:BEFORE FIELD xcco102

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcco102
            
            #add-point:AFTER FIELD xcco102

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcco102
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcco102
            #add-point:ON ACTION controlp INFIELD xcco102

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcco102a
            #add-point:BEFORE FIELD xcco102a

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcco102a
            
            #add-point:AFTER FIELD xcco102a

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcco102a
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcco102a
            #add-point:ON ACTION controlp INFIELD xcco102a

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcco102b
            #add-point:BEFORE FIELD xcco102b

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcco102b
            
            #add-point:AFTER FIELD xcco102b

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcco102b
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcco102b
            #add-point:ON ACTION controlp INFIELD xcco102b

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcco102d
            #add-point:BEFORE FIELD xcco102d

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcco102d
            
            #add-point:AFTER FIELD xcco102d

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcco102d
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcco102d
            #add-point:ON ACTION controlp INFIELD xcco102d

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcco102e
            #add-point:BEFORE FIELD xcco102e

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcco102e
            
            #add-point:AFTER FIELD xcco102e

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcco102e
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcco102e
            #add-point:ON ACTION controlp INFIELD xcco102e

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcco102f
            #add-point:BEFORE FIELD xcco102f

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcco102f
            
            #add-point:AFTER FIELD xcco102f

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcco102f
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcco102f
            #add-point:ON ACTION controlp INFIELD xcco102f

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcco102g
            #add-point:BEFORE FIELD xcco102g

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcco102g
            
            #add-point:AFTER FIELD xcco102g

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcco102g
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcco102g
            #add-point:ON ACTION controlp INFIELD xcco102g

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcco102h
            #add-point:BEFORE FIELD xcco102h

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcco102h
            
            #add-point:AFTER FIELD xcco102h

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcco102h
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcco102h
            #add-point:ON ACTION controlp INFIELD xcco102h

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcco102c
            #add-point:BEFORE FIELD xcco102c

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcco102c
            
            #add-point:AFTER FIELD xcco102c

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcco102c
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcco102c
            #add-point:ON ACTION controlp INFIELD xcco102c

            #END add-point
 
   
       
      END CONSTRUCT
  
 
  
      #add-point:cs段more_construct
      
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
 
{<section id="axcq920.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION axcq920_query()
   #add-point:query段define

   #end add-point   
   DEFINE ls_wc STRING
   #add-point:query段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)

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
   CALL g_xcco_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL axcq920_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      CALL axcq920_browser_fill(g_wc)
      CALL axcq920_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL axcq920_browser_fill("F")
   
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
      CALL axcq920_fetch("F") 
   END IF
   
   CALL axcq920_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="axcq920.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION axcq920_fetch(p_flag)
   #add-point:fetch段define

   #end add-point   
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)

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
   
   #CALL axcq920_browser_fill(p_flag)
   
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
   
   LET g_xcco_m.xccold = g_browser[g_current_idx].b_xccold
   LET g_xcco_m.xcco001 = g_browser[g_current_idx].b_xcco001
   LET g_xcco_m.xcco003 = g_browser[g_current_idx].b_xcco003
   LET g_xcco_m.xcco004 = g_browser[g_current_idx].b_xcco004
   LET g_xcco_m.xcco005 = g_browser[g_current_idx].b_xcco005
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE axcq920_master_referesh USING g_xcco_m.xccold,g_xcco_m.xcco001,g_xcco_m.xcco003,g_xcco_m.xcco004, 
       g_xcco_m.xcco005 INTO g_xcco_m.xccocomp,g_xcco_m.xcco004,g_xcco_m.xcco001,g_xcco_m.xccold,g_xcco_m.xcco005, 
       g_xcco_m.xcco003,g_xcco_m.xccocomp_desc,g_xcco_m.xcco001_desc,g_xcco_m.xccold_desc,g_xcco_m.xcco003_desc 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcco_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_xcco_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_xcco_m_mask_o.* =  g_xcco_m.*
   CALL axcq920_xcco_t_mask()
   LET g_xcco_m_mask_n.* =  g_xcco_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axcq920_set_act_visible()
   CALL axcq920_set_act_no_visible()
 
   #保存單頭舊值
   LET g_xcco_m_t.* = g_xcco_m.*
   LET g_xcco_m_o.* = g_xcco_m.*
   
   #重新顯示   
   CALL axcq920_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="axcq920.insert" >}
#+ 資料新增
PRIVATE FUNCTION axcq920_insert()
   #add-point:insert段define

   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)

   #end add-point
   
   #add-point:insert段before

   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_xcco_d.clear()
 
 
   INITIALIZE g_xcco_m.* LIKE xcco_t.*             #DEFAULT 設定
   LET g_xccold_t = NULL
   LET g_xcco001_t = NULL
   LET g_xcco003_t = NULL
   LET g_xcco004_t = NULL
   LET g_xcco005_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
            LET g_xcco_m.xcco001 = "1"
 
     
      #add-point:單頭預設值

      #end add-point 
 
      CALL axcq920_input("a")
      
      #add-point:單頭輸入後

      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         LET INT_FLAG = 0
         LET g_xcco_m.* = g_xcco_m_t.*
         CALL axcq920_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_xcco_m.* TO NULL
         INITIALIZE g_xcco_d TO NULL
 
         CALL axcq920_show()
         RETURN
      END IF
    
      #CALL g_xcco_d.clear()
 
      
      #add-point:單頭輸入後2

      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axcq920_set_act_visible()
   CALL axcq920_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_xccold_t = g_xcco_m.xccold
   LET g_xcco001_t = g_xcco_m.xcco001
   LET g_xcco003_t = g_xcco_m.xcco003
   LET g_xcco004_t = g_xcco_m.xcco004
   LET g_xcco005_t = g_xcco_m.xcco005 
   
   #組合新增資料的條件
   LET g_add_browse = " xccoent = '" ||g_enterprise|| "' AND",
                      " xccold = '", g_xcco_m.xccold, "' "
                      ," AND xcco001 = '", g_xcco_m.xcco001, "' "
                      ," AND xcco003 = '", g_xcco_m.xcco003, "' "
                      ," AND xcco004 = '", g_xcco_m.xcco004, "' "
                      ," AND xcco005 = '", g_xcco_m.xcco005, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axcq920_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL axcq920_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE axcq920_master_referesh USING g_xcco_m.xccold,g_xcco_m.xcco001,g_xcco_m.xcco003,g_xcco_m.xcco004, 
       g_xcco_m.xcco005 INTO g_xcco_m.xccocomp,g_xcco_m.xcco004,g_xcco_m.xcco001,g_xcco_m.xccold,g_xcco_m.xcco005, 
       g_xcco_m.xcco003,g_xcco_m.xccocomp_desc,g_xcco_m.xcco001_desc,g_xcco_m.xccold_desc,g_xcco_m.xcco003_desc 
   
   #遮罩相關處理
   LET g_xcco_m_mask_o.* =  g_xcco_m.*
   CALL axcq920_xcco_t_mask()
   LET g_xcco_m_mask_n.* =  g_xcco_m.*
   
   #將資料顯示到畫面上
  DISPLAY BY NAME g_xcco_m.xccocomp,g_xcco_m.xccocomp_desc,g_xcco_m.xcco004,g_xcco_m.xcco001,g_xcco_m.xcco001_desc, 
       g_xcco_m.xccold,g_xcco_m.xccold_desc,g_xcco_m.xcco005,g_xcco_m.xcco003,g_xcco_m.xcco003_desc
   
   #功能已完成,通報訊息中心
   CALL axcq920_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="axcq920.modify" >}
#+ 資料修改
PRIVATE FUNCTION axcq920_modify()
   #add-point:modify段define

   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)

   #end add-point  
   
   IF g_xcco_m.xccold IS NULL
   OR g_xcco_m.xcco001 IS NULL
   OR g_xcco_m.xcco003 IS NULL
   OR g_xcco_m.xcco004 IS NULL
   OR g_xcco_m.xcco005 IS NULL 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_xccold_t = g_xcco_m.xccold
   LET g_xcco001_t = g_xcco_m.xcco001
   LET g_xcco003_t = g_xcco_m.xcco003
   LET g_xcco004_t = g_xcco_m.xcco004
   LET g_xcco005_t = g_xcco_m.xcco005 
   CALL s_transaction_begin()
   
    OPEN axcq920_cl USING g_enterprise,g_xcco_m.xccold,g_xcco_m.xcco001,g_xcco_m.xcco003,g_xcco_m.xcco004,g_xcco_m.xcco005
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axcq920_cl:" 
      LET g_errparam.code   =  STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CLOSE axcq920_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axcq920_master_referesh USING g_xcco_m.xccold,g_xcco_m.xcco001,g_xcco_m.xcco003,g_xcco_m.xcco004, 
       g_xcco_m.xcco005 INTO g_xcco_m.xccocomp,g_xcco_m.xcco004,g_xcco_m.xcco001,g_xcco_m.xccold,g_xcco_m.xcco005, 
       g_xcco_m.xcco003,g_xcco_m.xccocomp_desc,g_xcco_m.xcco001_desc,g_xcco_m.xccold_desc,g_xcco_m.xcco003_desc 
   
   #遮罩相關處理
   LET g_xcco_m_mask_o.* =  g_xcco_m.*
   CALL axcq920_xcco_t_mask()
   LET g_xcco_m_mask_n.* =  g_xcco_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL axcq920_show()
   WHILE TRUE
      LET g_xccold_t = g_xcco_m.xccold
      LET g_xcco001_t = g_xcco_m.xcco001
      LET g_xcco003_t = g_xcco_m.xcco003
      LET g_xcco004_t = g_xcco_m.xcco004
      LET g_xcco005_t = g_xcco_m.xcco005 
 
      #add-point:modify段修改前

      #end add-point
      
      CALL axcq920_input("u")     #欄位更改
      
      #add-point:modify段修改後

      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_xcco_m.* = g_xcco_m_t.*
         CALL axcq920_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_xcco_m.xccold != g_xccold_t 
      OR g_xcco_m.xcco001 != g_xcco001_t 
      OR g_xcco_m.xcco003 != g_xcco003_t 
      OR g_xcco_m.xcco004 != g_xcco004_t 
      OR g_xcco_m.xcco005 != g_xcco005_t  
      THEN
         CALL s_transaction_begin()
         
         #add-point:單頭(偽)修改前

         #end add-point
         
         #add-point:單頭(偽)修改中

         #end add-point
         
 
         
         #add-point:單頭(偽)修改後

         #end add-point
         
      END IF
      
      EXIT WHILE
      
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axcq920_set_act_visible()
   CALL axcq920_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " xccoent = '" ||g_enterprise|| "' AND",
                      " xccold = '", g_xcco_m.xccold, "' "
                      ," AND xcco001 = '", g_xcco_m.xcco001, "' "
                      ," AND xcco003 = '", g_xcco_m.xcco003, "' "
                      ," AND xcco004 = '", g_xcco_m.xcco004, "' "
                      ," AND xcco005 = '", g_xcco_m.xcco005, "' " 
   #填到對應位置
   CALL axcq920_browser_fill("")
 
   CALL axcq920_idx_chk()
 
   CLOSE axcq920_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL axcq920_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="axcq920.input" >}
#+ 資料輸入
PRIVATE FUNCTION axcq920_input(p_cmd)
   #add-point:input段define

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
   #add-point:input段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)

   #end add-point
   
   #先做狀態判定
   IF p_cmd = 'r' THEN
      LET l_cmd_t = 'r'
      LET p_cmd   = 'a'
   ELSE
      LET l_cmd_t = p_cmd
   END IF   
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_xcco_m.xccocomp,g_xcco_m.xccocomp_desc,g_xcco_m.xcco004,g_xcco_m.xcco001,g_xcco_m.xcco001_desc, 
       g_xcco_m.xccold,g_xcco_m.xccold_desc,g_xcco_m.xcco005,g_xcco_m.xcco003,g_xcco_m.xcco003_desc
   
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
 LET g_forupd_sql = "SELECT xcco002,xcco006,xcco007,xcco008,xcco010,xcco009,xcco102,xcco102a,xcco102b, 
       xcco102d,xcco102e,xcco102f,xcco102g,xcco102h,xcco102c FROM xcco_t WHERE xccoent=? AND xccold=?  
       AND xcco001=? AND xcco003=? AND xcco004=? AND xcco005=? AND xcco002=? AND xcco006=? AND xcco007=?  
       AND xcco008=? AND xcco009=? FOR UPDATE"
   #add-point:input段define_sql

   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axcq920_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL axcq920_set_entry(p_cmd)
   #add-point:set_entry後

   #end add-point
   CALL axcq920_set_no_entry(p_cmd)
   #add-point:set_no_entry後

   #end add-point
 
   DISPLAY BY NAME g_xcco_m.xccocomp,g_xcco_m.xcco004,g_xcco_m.xcco001,g_xcco_m.xccold,g_xcco_m.xcco005, 
       g_xcco_m.xcco003
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前

   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="axcq920.input.head" >}
   
      #單頭段
      INPUT BY NAME g_xcco_m.xccocomp,g_xcco_m.xcco004,g_xcco_m.xcco001,g_xcco_m.xccold,g_xcco_m.xcco005, 
          g_xcco_m.xcco003  
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
          
                  #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xccocomp
            
            #add-point:AFTER FIELD xccocomp
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcco_m.xccocomp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcco_m.xccocomp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcco_m.xccocomp_desc


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xccocomp
            #add-point:BEFORE FIELD xccocomp

            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xccocomp
            #add-point:ON CHANGE xccocomp

            #END add-point 
  #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcco004
            #add-point:BEFORE FIELD xcco004
 
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcco004
            
            #add-point:AFTER FIELD xcco004
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xcco_m.xccold) AND NOT cl_null(g_xcco_m.xcco001) AND NOT cl_null(g_xcco_m.xcco003) AND NOT cl_null(g_xcco_m.xcco004) AND NOT cl_null(g_xcco_m.xcco005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcco_m.xccold != g_xccold_t  OR g_xcco_m.xcco001 != g_xcco001_t  OR g_xcco_m.xcco003 != g_xcco003_t  OR g_xcco_m.xcco004 != g_xcco004_t  OR g_xcco_m.xcco005 != g_xcco005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcco_t WHERE "||"xccoent = '" ||g_enterprise|| "' AND "||"xccold = '"||g_xcco_m.xccold ||"' AND "|| "xcco001 = '"||g_xcco_m.xcco001 ||"' AND "|| "xcco003 = '"||g_xcco_m.xcco003 ||"' AND "|| "xcco004 = '"||g_xcco_m.xcco004 ||"' AND "|| "xcco005 = '"||g_xcco_m.xcco005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
 
 
 
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcco004
            #add-point:ON CHANGE xcco004
 
            #END add-point 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcco005
            #add-point:BEFORE FIELD xcco005
 
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcco005
            
            #add-point:AFTER FIELD xcco005
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xcco_m.xccold) AND NOT cl_null(g_xcco_m.xcco001) AND NOT cl_null(g_xcco_m.xcco003) AND NOT cl_null(g_xcco_m.xcco004) AND NOT cl_null(g_xcco_m.xcco005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcco_m.xccold != g_xccold_t  OR g_xcco_m.xcco001 != g_xcco001_t  OR g_xcco_m.xcco003 != g_xcco003_t  OR g_xcco_m.xcco004 != g_xcco004_t  OR g_xcco_m.xcco005 != g_xcco005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcco_t WHERE "||"xccoent = '" ||g_enterprise|| "' AND "||"xccold = '"||g_xcco_m.xccold ||"' AND "|| "xcco001 = '"||g_xcco_m.xcco001 ||"' AND "|| "xcco003 = '"||g_xcco_m.xcco003 ||"' AND "|| "xcco004 = '"||g_xcco_m.xcco004 ||"' AND "|| "xcco005 = '"||g_xcco_m.xcco005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
 
 
 
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcco005
            #add-point:ON CHANGE xcco005
 
            #END add-point 
             
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcco001
            
            #add-point:AFTER FIELD xcco001
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcco_m.xcco001
            CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcco_m.xcco001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcco_m.xcco001_desc

            #此段落由子樣板a05產生
            #確認資料無重複
    
            IF  NOT cl_null(g_xcco_m.xccold) AND NOT cl_null(g_xcco_m.xcco001) AND NOT cl_null(g_xcco_m.xcco003) AND NOT cl_null(g_xcco_m.xcco004) AND NOT cl_null(g_xcco_m.xcco005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcco_m.xccold != g_xccold_t  OR g_xcco_m.xcco001 != g_xcco001_t  OR g_xcco_m.xcco003 != g_xcco003_t  OR g_xcco_m.xcco004 != g_xcco004_t  OR g_xcco_m.xcco005 != g_xcco005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcco_t WHERE "||"xccoent = '" ||g_enterprise|| "' AND "||"xccold = '"||g_xcco_m.xccold ||"' AND "|| "xcco001 = '"||g_xcco_m.xcco001 ||"' AND "|| "xcco003 = '"||g_xcco_m.xcco003 ||"' AND "|| "xcco004 = '"||g_xcco_m.xcco004 ||"' AND "|| "xcco005 = '"||g_xcco_m.xcco005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcco001
            #add-point:BEFORE FIELD xcco001

            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcco001
            #add-point:ON CHANGE xcco001

            #END add-point 
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xccold
            
            #add-point:AFTER FIELD xccold
            IF NOT cl_null(g_xcco_m.xccold) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xcco_m.xccold
               #160318-00025#10--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
               #160318-00025#10--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_glaald") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcco_m.xccold
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcco_m.xccold_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcco_m.xccold_desc

            #此段落由子樣板a05產生
            #確認資料無重複

            IF  NOT cl_null(g_xcco_m.xccold) AND NOT cl_null(g_xcco_m.xcco001) AND NOT cl_null(g_xcco_m.xcco003) AND NOT cl_null(g_xcco_m.xcco004) AND NOT cl_null(g_xcco_m.xcco005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcco_m.xccold != g_xccold_t  OR g_xcco_m.xcco001 != g_xcco001_t  OR g_xcco_m.xcco003 != g_xcco003_t  OR g_xcco_m.xcco004 != g_xcco004_t  OR g_xcco_m.xcco005 != g_xcco005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcco_t WHERE "||"xccoent = '" ||g_enterprise|| "' AND "||"xccold = '"||g_xcco_m.xccold ||"' AND "|| "xcco001 = '"||g_xcco_m.xcco001 ||"' AND "|| "xcco003 = '"||g_xcco_m.xcco003 ||"' AND "|| "xcco004 = '"||g_xcco_m.xcco004 ||"' AND "|| "xcco005 = '"||g_xcco_m.xcco005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xccold
            #add-point:BEFORE FIELD xccold

            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xccold
            #add-point:ON CHANGE xccold

            #END add-point 
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcco003
            
            #add-point:AFTER FIELD xcco003
            IF NOT cl_null(g_xcco_m.xcco003) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xcco_m.xcco003
               #160318-00025#10--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "agl-00195:sub-01302|axci100|",cl_get_progname("axci100",g_lang,"2"),"|:EXEPROGaxci100"
               #160318-00025#10--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_xcat001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcco_m.xcco003
            CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcco_m.xcco003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcco_m.xcco003_desc

            #此段落由子樣板a05產生
            #確認資料無重複

            IF  NOT cl_null(g_xcco_m.xccold) AND NOT cl_null(g_xcco_m.xcco001) AND NOT cl_null(g_xcco_m.xcco003) AND NOT cl_null(g_xcco_m.xcco004) AND NOT cl_null(g_xcco_m.xcco005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcco_m.xccold != g_xccold_t  OR g_xcco_m.xcco001 != g_xcco001_t  OR g_xcco_m.xcco003 != g_xcco003_t  OR g_xcco_m.xcco004 != g_xcco004_t  OR g_xcco_m.xcco005 != g_xcco005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcco_t WHERE "||"xccoent = '" ||g_enterprise|| "' AND "||"xccold = '"||g_xcco_m.xccold ||"' AND "|| "xcco001 = '"||g_xcco_m.xcco001 ||"' AND "|| "xcco003 = '"||g_xcco_m.xcco003 ||"' AND "|| "xcco004 = '"||g_xcco_m.xcco004 ||"' AND "|| "xcco005 = '"||g_xcco_m.xcco005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcco003
            #add-point:BEFORE FIELD xcco003

            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcco003
            #add-point:ON CHANGE xcco003

            #END add-point 
 
 #欄位檢查
                  #Ctrlp:input.c.xccocomp
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xccocomp
            #add-point:ON ACTION controlp INFIELD xccocomp

            #END add-point
         #Ctrlp:input.c.xcco004
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcco004
            #add-point:ON ACTION controlp INFIELD xcco004
 
            #END add-point 
         #Ctrlp:input.c.xcco005
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcco005
            #add-point:ON ACTION controlp INFIELD xcco005
 
            #END add-point            
         #Ctrlp:input.c.xcco001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcco001
            #add-point:ON ACTION controlp INFIELD xcco001

            #END add-point
 
         #Ctrlp:input.c.xccold
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xccold
            #add-point:ON ACTION controlp INFIELD xccold
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcco_m.xccold             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.arg2 = "" #
            
            CALL q_authorised_ld()                                #呼叫開窗

            LET g_xcco_m.xccold = g_qryparam.return1              

            DISPLAY g_xcco_m.xccold TO xccold              #

            NEXT FIELD xccold                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.xcco003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcco003
            #add-point:ON ACTION controlp INFIELD xcco003
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcco_m.xcco003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_xcat001()                                #呼叫開窗

            LET g_xcco_m.xcco003 = g_qryparam.return1              

            DISPLAY g_xcco_m.xcco003 TO xcco003              #

            NEXT FIELD xcco003                          #返回原欄位


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
            DISPLAY BY NAME g_xcco_m.xccold             
                            ,g_xcco_m.xcco001   
                            ,g_xcco_m.xcco003   
                            ,g_xcco_m.xcco004   
                            ,g_xcco_m.xcco005  
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前

               #end add-point
            
               #將遮罩欄位還原
               CALL axcq920_xcco_t_mask_restore('restore_mask_o')
            
               UPDATE xcco_t SET (xccocomp,xcco004,xcco001,xccold,xcco005,xcco003) = (g_xcco_m.xccocomp, 
                   g_xcco_m.xcco004,g_xcco_m.xcco001,g_xcco_m.xccold,g_xcco_m.xcco005,g_xcco_m.xcco003) 
 
                WHERE xccoent = g_enterprise AND xccold = g_xccold_t
                  AND xcco001 = g_xcco001_t
                  AND xcco003 = g_xcco003_t
                  AND xcco004 = g_xcco004_t
                  AND xcco005 = g_xcco005_t
 
               #add-point:單頭修改中

               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcco_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcco_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xcco_m.xccold
               LET gs_keys_bak[1] = g_xccold_t
               LET gs_keys[2] = g_xcco_m.xcco001
               LET gs_keys_bak[2] = g_xcco001_t
               LET gs_keys[3] = g_xcco_m.xcco003
               LET gs_keys_bak[3] = g_xcco003_t
               LET gs_keys[4] = g_xcco_m.xcco004               
               LET gs_keys_bak[4] = g_xcco004_t
               LET gs_keys[5] = g_xcco_m.xcco005
               LET gs_keys_bak[5] = g_xcco005_t
               LET gs_keys[6] = g_xcco_d[g_detail_idx].xcco002
               LET gs_keys_bak[6] = g_xcco_d_t.xcco002
               LET gs_keys[7] = g_xcco_d[g_detail_idx].xcco006
               LET gs_keys_bak[7] = g_xcco_d_t.xcco006
               LET gs_keys[8] = g_xcco_d[g_detail_idx].xcco007
               LET gs_keys_bak[8] = g_xcco_d_t.xcco007
               LET gs_keys[9] = g_xcco_d[g_detail_idx].xcco008
               LET gs_keys_bak[9] = g_xcco_d_t.xcco008
               LET gs_keys[10] = g_xcco_d[g_detail_idx].xcco009
               LET gs_keys_bak[10] = g_xcco_d_t.xcco009
               CALL axcq920_update_b('xcco_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後

                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_xcco_m_t)
                     #LET g_log2 = util.JSON.stringify(g_xcco_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL axcq920_xcco_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增

               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL axcq920_detail_reproduce()
               END IF
            END IF
 
           LET g_xccold_t = g_xcco_m.xccold
           LET g_xcco001_t = g_xcco_m.xcco001
           LET g_xcco003_t = g_xcco_m.xcco003
           LET g_xcco004_t = g_xcco_m.xcco004
           LET g_xcco005_t = g_xcco_m.xcco005 
           
           IF g_xcco_d.getLength() = 0 THEN
              NEXT FIELD xcco002
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="axcq920.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_xcco_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xcco_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axcq920_b_fill(g_wc2) #test 
            #如果一直都在單頭則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_detail_idx)
            END IF
            LET g_loc = 'm' 
            #add-point:資料輸入前

            #end add-point
         
         BEFORE ROW
            #add-point:modify段before row

            #end add-point  
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq920_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN axcq920_cl USING g_enterprise,g_xcco_m.xccold,g_xcco_m.xcco001,g_xcco_m.xcco003                          
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axcq920_cl:" 
                  LET g_errparam.code   =  STATUS 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLOSE axcq920_cl
                  CALL s_transaction_end('N','0')
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_xcco_d[l_ac].xcco002 IS NOT NULL
               AND g_xcco_d[l_ac].xcco006 IS NOT NULL
               AND g_xcco_d[l_ac].xcco007 IS NOT NULL
               AND g_xcco_d[l_ac].xcco008 IS NOT NULL
               AND g_xcco_d[l_ac].xcco009 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_xcco_d_t.* = g_xcco_d[l_ac].*  #BACKUP
               LET g_xcco_d_o.* = g_xcco_d[l_ac].*  #BACKUP
               CALL axcq920_set_entry_b(l_cmd)
               #add-point:set_entry_b後

               #end add-point
               CALL axcq920_set_no_entry_b(l_cmd)
               OPEN axcq920_bcl USING g_enterprise,g_xcco_m.xccold,
                                                g_xcco_m.xcco001,
                                                g_xcco_m.xcco003,
                                                g_xcco_m.xcco004,
                                                g_xcco_m.xcco005,
                                                
                                                g_xcco_d_t.xcco002
                                                ,g_xcco_d_t.xcco006
                                                ,g_xcco_d_t.xcco007
                                                ,g_xcco_d_t.xcco008
                                                ,g_xcco_d_t.xcco009
 
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axcq920_bcl:" 
                  LET g_errparam.code   =  STATUS 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axcq920_bcl INTO g_xcco_d[l_ac].xcco002,g_xcco_d[l_ac].xcco006,g_xcco_d[l_ac].xcco007, 
                      g_xcco_d[l_ac].xcco008,g_xcco_d[l_ac].xcco010,g_xcco_d[l_ac].xcco009,g_xcco_d[l_ac].xcco102, 
                      g_xcco_d[l_ac].xcco102a,g_xcco_d[l_ac].xcco102b,g_xcco_d[l_ac].xcco102d,g_xcco_d[l_ac].xcco102e, 
                      g_xcco_d[l_ac].xcco102f,g_xcco_d[l_ac].xcco102g,g_xcco_d[l_ac].xcco102h,g_xcco_d[l_ac].xcco102c 
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_xcco_d_t.xcco002 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xcco_d_mask_o[l_ac].* =  g_xcco_d[l_ac].*
                  CALL axcq920_xcco_t_mask()
                  LET g_xcco_d_mask_n[l_ac].* =  g_xcco_d[l_ac].*
                  
                  CALL axcq920_ref_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row

            #end add-point  
            
        
         BEFORE INSERT
            
            INITIALIZE g_xcco_d_t.* TO NULL
            INITIALIZE g_xcco_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xcco_d[l_ac].* TO NULL
            #公用欄位預設值
              
            #一般欄位預設值
                  LET g_xcco_d[l_ac].xcco010 = "1"
 
            
            #add-point:modify段before備份

            #end add-point
            LET g_xcco_d_t.* = g_xcco_d[l_ac].*     #新輸入資料
            LET g_xcco_d_o.* = g_xcco_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axcq920_set_entry_b(l_cmd)
            #add-point:set_entry_b後

            #end add-point
            CALL axcq920_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xcco_d[li_reproduce_target].* = g_xcco_d[li_reproduce].*
 
               LET g_xcco_d[g_xcco_d.getLength()].xcco002 = NULL
               LET g_xcco_d[g_xcco_d.getLength()].xcco006 = NULL
               LET g_xcco_d[g_xcco_d.getLength()].xcco007 = NULL
               LET g_xcco_d[g_xcco_d.getLength()].xcco008 = NULL
               LET g_xcco_d[g_xcco_d.getLength()].xcco009 = NULL
 
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
            SELECT COUNT(*) INTO l_count FROM xcco_t 
             WHERE xccoent = g_enterprise AND xccold = g_xcco_m.xccold
               AND xcco001 = g_xcco_m.xcco001
               AND xcco003 = g_xcco_m.xcco003
               AND xcco004 = g_xcco_m.xcco004
               AND xcco005 = g_xcco_m.xcco005
               
               AND xcco002 = g_xcco_d[l_ac].xcco002
               AND xcco006 = g_xcco_d[l_ac].xcco006
               AND xcco007 = g_xcco_d[l_ac].xcco007
               AND xcco008 = g_xcco_d[l_ac].xcco008
               AND xcco009 = g_xcco_d[l_ac].xcco009
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前

               #end add-point
                INSERT INTO xcco_t
                           (xccoent,
                            xccocomp,xcco004,xcco001,xccold,xcco005,xcco003,
                            xcco002,xcco006,xcco007,xcco008,xcco009
                            ,xcco010,xcco102,xcco102a,xcco102b,xcco102d,xcco102e,xcco102f,xcco102g,xcco102h,xcco102c) 
                     VALUES(g_enterprise,
                            g_xcco_m.xccocomp,g_xcco_m.xcco004,g_xcco_m.xcco001,g_xcco_m.xccold,g_xcco_m.xcco005,g_xcco_m.xcco003,
                            g_xcco_d[l_ac].xcco002,g_xcco_d[l_ac].xcco006,g_xcco_d[l_ac].xcco007,g_xcco_d[l_ac].xcco008, 
                                g_xcco_d[l_ac].xcco009
                            ,g_xcco_d[l_ac].xcco010,g_xcco_d[l_ac].xcco102,g_xcco_d[l_ac].xcco102a,g_xcco_d[l_ac].xcco102b, 
                                g_xcco_d[l_ac].xcco102d,g_xcco_d[l_ac].xcco102e,g_xcco_d[l_ac].xcco102f, 
                                g_xcco_d[l_ac].xcco102g,g_xcco_d[l_ac].xcco102h,g_xcco_d[l_ac].xcco102c) 
 
               #add-point:單身新增中

               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               INITIALIZE g_xcco_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xcco_t" 
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
               #ERROR 'INSERT O.K'
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
               IF axcq920_before_delete() THEN 
                  
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE axcq920_bcl
               LET l_count = g_xcco_d.getLength()
            END IF 
            
            #add-point:單身刪除後

            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE 

               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_xcco_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF            

 
 
 

 

 
 
 

         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcco002
            
            #add-point:AFTER FIELD xcco002
            #此段落由子樣板a05產生
            #確認資料無重複

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcco_d[l_ac].xcco002
            CALL ap_ref_array2(g_ref_fields,"SELECT xcbfl003 FROM xcbfl_t WHERE xcbflent='"||g_enterprise||"' AND xcbfl001=? AND xcbfl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcco_d[l_ac].xcco002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcco_d[l_ac].xcco002_desc


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcco002
            #add-point:BEFORE FIELD xcco002

            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcco002
            #add-point:ON CHANGE xcco002

            #END add-point 
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcco006
            
            #add-point:AFTER FIELD xcco006
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcco_d[l_ac].xcco006
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcco_d[l_ac].xcco006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcco_d[l_ac].xcco006_desc


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcco006
            #add-point:BEFORE FIELD xcco006

            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcco006
            #add-point:ON CHANGE xcco006

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcco007
            #add-point:BEFORE FIELD xcco007

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcco007
            
            #add-point:AFTER FIELD xcco007
            #此段落由子樣板a05產生
            #確認資料無重複

            IF  g_xcco_m.xccold IS NOT NULL AND g_xcco_m.xcco001 IS NOT NULL AND g_xcco_m.xcco003 IS NOT NULL AND g_xcco_m.xcco004 IS NOT NULL AND g_xcco_m.xcco005 IS NOT NULL AND g_xcco_d[g_detail_idx].xcco002 IS NOT NULL AND g_xcco_d[g_detail_idx].xcco006 IS NOT NULL AND g_xcco_d[g_detail_idx].xcco007 IS NOT NULL AND g_xcco_d[g_detail_idx].xcco008 IS NOT NULL AND g_xcco_d[g_detail_idx].xcco009 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcco_m.xccold != g_xccold_t OR g_xcco_m.xcco001 != g_xcco001_t OR g_xcco_m.xcco003 != g_xcco003_t OR g_xcco_m.xcco004 != g_xcco004_t OR g_xcco_m.xcco005 != g_xcco005_t OR g_xcco_d[g_detail_idx].xcco002 != g_xcco_d_t.xcco002 OR g_xcco_d[g_detail_idx].xcco006 != g_xcco_d_t.xcco006 OR g_xcco_d[g_detail_idx].xcco007 != g_xcco_d_t.xcco007 OR g_xcco_d[g_detail_idx].xcco008 != g_xcco_d_t.xcco008 OR g_xcco_d[g_detail_idx].xcco009 != g_xcco_d_t.xcco009)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcco_t WHERE "||"xccoent = '" ||g_enterprise|| "' AND "||"xccold = '"||g_xcco_m.xccold ||"' AND "|| "xcco001 = '"||g_xcco_m.xcco001 ||"' AND "|| "xcco003 = '"||g_xcco_m.xcco003 ||"' AND "|| "xcco004 = '"||g_xcco_m.xcco004 ||"' AND "|| "xcco005 = '"||g_xcco_m.xcco005 ||"' AND "|| "xcco002 = '"||g_xcco_d[g_detail_idx].xcco002 ||"' AND "|| "xcco006 = '"||g_xcco_d[g_detail_idx].xcco006 ||"' AND "|| "xcco007 = '"||g_xcco_d[g_detail_idx].xcco007 ||"' AND "|| "xcco008 = '"||g_xcco_d[g_detail_idx].xcco008 ||"' AND "|| "xcco009 = '"||g_xcco_d[g_detail_idx].xcco009 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcco007
            #add-point:ON CHANGE xcco007

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcco008
            #add-point:BEFORE FIELD xcco008

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcco008
            
            #add-point:AFTER FIELD xcco008
            #此段落由子樣板a05產生
            #確認資料無重複

            IF  g_xcco_m.xccold IS NOT NULL AND g_xcco_m.xcco001 IS NOT NULL AND g_xcco_m.xcco003 IS NOT NULL AND g_xcco_m.xcco004 IS NOT NULL AND g_xcco_m.xcco005 IS NOT NULL AND g_xcco_d[g_detail_idx].xcco002 IS NOT NULL AND g_xcco_d[g_detail_idx].xcco006 IS NOT NULL AND g_xcco_d[g_detail_idx].xcco007 IS NOT NULL AND g_xcco_d[g_detail_idx].xcco008 IS NOT NULL AND g_xcco_d[g_detail_idx].xcco009 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcco_m.xccold != g_xccold_t OR g_xcco_m.xcco001 != g_xcco001_t OR g_xcco_m.xcco003 != g_xcco003_t OR g_xcco_m.xcco004 != g_xcco004_t OR g_xcco_m.xcco005 != g_xcco005_t OR g_xcco_d[g_detail_idx].xcco002 != g_xcco_d_t.xcco002 OR g_xcco_d[g_detail_idx].xcco006 != g_xcco_d_t.xcco006 OR g_xcco_d[g_detail_idx].xcco007 != g_xcco_d_t.xcco007 OR g_xcco_d[g_detail_idx].xcco008 != g_xcco_d_t.xcco008 OR g_xcco_d[g_detail_idx].xcco009 != g_xcco_d_t.xcco009)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcco_t WHERE "||"xccoent = '" ||g_enterprise|| "' AND "||"xccold = '"||g_xcco_m.xccold ||"' AND "|| "xcco001 = '"||g_xcco_m.xcco001 ||"' AND "|| "xcco003 = '"||g_xcco_m.xcco003 ||"' AND "|| "xcco004 = '"||g_xcco_m.xcco004 ||"' AND "|| "xcco005 = '"||g_xcco_m.xcco005 ||"' AND "|| "xcco002 = '"||g_xcco_d[g_detail_idx].xcco002 ||"' AND "|| "xcco006 = '"||g_xcco_d[g_detail_idx].xcco006 ||"' AND "|| "xcco007 = '"||g_xcco_d[g_detail_idx].xcco007 ||"' AND "|| "xcco008 = '"||g_xcco_d[g_detail_idx].xcco008 ||"' AND "|| "xcco009 = '"||g_xcco_d[g_detail_idx].xcco009 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcco008
            #add-point:ON CHANGE xcco008

            #END add-point 
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD imag011
            
            #add-point:AFTER FIELD imag011



            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD imag011
            #add-point:BEFORE FIELD imag011

            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE imag011
            #add-point:ON CHANGE imag011

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcco010
            #add-point:BEFORE FIELD xcco010

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcco010
            
            #add-point:AFTER FIELD xcco010

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcco010
            #add-point:ON CHANGE xcco010

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcco009
            #add-point:BEFORE FIELD xcco009

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcco009
            
            #add-point:AFTER FIELD xcco009
            #此段落由子樣板a05產生
            #確認資料無重複

            IF  g_xcco_m.xccold IS NOT NULL AND g_xcco_m.xcco001 IS NOT NULL AND g_xcco_m.xcco003 IS NOT NULL AND g_xcco_m.xcco004 IS NOT NULL AND g_xcco_m.xcco005 IS NOT NULL AND g_xcco_d[g_detail_idx].xcco002 IS NOT NULL AND g_xcco_d[g_detail_idx].xcco006 IS NOT NULL AND g_xcco_d[g_detail_idx].xcco007 IS NOT NULL AND g_xcco_d[g_detail_idx].xcco008 IS NOT NULL AND g_xcco_d[g_detail_idx].xcco009 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcco_m.xccold != g_xccold_t OR g_xcco_m.xcco001 != g_xcco001_t OR g_xcco_m.xcco003 != g_xcco003_t OR g_xcco_m.xcco004 != g_xcco004_t OR g_xcco_m.xcco005 != g_xcco005_t OR g_xcco_d[g_detail_idx].xcco002 != g_xcco_d_t.xcco002 OR g_xcco_d[g_detail_idx].xcco006 != g_xcco_d_t.xcco006 OR g_xcco_d[g_detail_idx].xcco007 != g_xcco_d_t.xcco007 OR g_xcco_d[g_detail_idx].xcco008 != g_xcco_d_t.xcco008 OR g_xcco_d[g_detail_idx].xcco009 != g_xcco_d_t.xcco009)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcco_t WHERE "||"xccoent = '" ||g_enterprise|| "' AND "||"xccold = '"||g_xcco_m.xccold ||"' AND "|| "xcco001 = '"||g_xcco_m.xcco001 ||"' AND "|| "xcco003 = '"||g_xcco_m.xcco003 ||"' AND "|| "xcco004 = '"||g_xcco_m.xcco004 ||"' AND "|| "xcco005 = '"||g_xcco_m.xcco005 ||"' AND "|| "xcco002 = '"||g_xcco_d[g_detail_idx].xcco002 ||"' AND "|| "xcco006 = '"||g_xcco_d[g_detail_idx].xcco006 ||"' AND "|| "xcco007 = '"||g_xcco_d[g_detail_idx].xcco007 ||"' AND "|| "xcco008 = '"||g_xcco_d[g_detail_idx].xcco008 ||"' AND "|| "xcco009 = '"||g_xcco_d[g_detail_idx].xcco009 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcco009
            #add-point:ON CHANGE xcco009

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcco102
            #add-point:BEFORE FIELD xcco102

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcco102
            
            #add-point:AFTER FIELD xcco102

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcco102
            #add-point:ON CHANGE xcco102

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcco102a
            #add-point:BEFORE FIELD xcco102a

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcco102a
            
            #add-point:AFTER FIELD xcco102a

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcco102a
            #add-point:ON CHANGE xcco102a

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcco102b
            #add-point:BEFORE FIELD xcco102b

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcco102b
            
            #add-point:AFTER FIELD xcco102b

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcco102b
            #add-point:ON CHANGE xcco102b

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcco102d
            #add-point:BEFORE FIELD xcco102d

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcco102d
            
            #add-point:AFTER FIELD xcco102d

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcco102d
            #add-point:ON CHANGE xcco102d

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcco102e
            #add-point:BEFORE FIELD xcco102e

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcco102e
            
            #add-point:AFTER FIELD xcco102e

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcco102e
            #add-point:ON CHANGE xcco102e

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcco102f
            #add-point:BEFORE FIELD xcco102f

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcco102f
            
            #add-point:AFTER FIELD xcco102f

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcco102f
            #add-point:ON CHANGE xcco102f

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcco102g
            #add-point:BEFORE FIELD xcco102g

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcco102g
            
            #add-point:AFTER FIELD xcco102g

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcco102g
            #add-point:ON CHANGE xcco102g

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcco102h
            #add-point:BEFORE FIELD xcco102h

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcco102h
            
            #add-point:AFTER FIELD xcco102h

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcco102h
            #add-point:ON CHANGE xcco102h

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcco102c
            #add-point:BEFORE FIELD xcco102c

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcco102c
            
            #add-point:AFTER FIELD xcco102c

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcco102c
            #add-point:ON CHANGE xcco102c

            #END add-point 

 

         #Ctrlp:input.c.page1.xcco002
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcco002
            #add-point:ON ACTION controlp INFIELD xcco002

            #END add-point
 
         #Ctrlp:input.c.page1.xcco006
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcco006
            #add-point:ON ACTION controlp INFIELD xcco006

            #END add-point
 
         #Ctrlp:input.c.page1.xcco007
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcco007
            #add-point:ON ACTION controlp INFIELD xcco007

            #END add-point
 
         #Ctrlp:input.c.page1.xcco008
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcco008
            #add-point:ON ACTION controlp INFIELD xcco008

            #END add-point
 
         #Ctrlp:input.c.page1.imag011
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD imag011
            #add-point:ON ACTION controlp INFIELD imag011

            #END add-point
 
         #Ctrlp:input.c.page1.xcco010
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcco010
            #add-point:ON ACTION controlp INFIELD xcco010

            #END add-point
 
         #Ctrlp:input.c.page1.xcco009
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcco009
            #add-point:ON ACTION controlp INFIELD xcco009

            #END add-point
 
         #Ctrlp:input.c.page1.xcco102
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcco102
            #add-point:ON ACTION controlp INFIELD xcco102

            #END add-point
 
         #Ctrlp:input.c.page1.xcco102a
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcco102a
            #add-point:ON ACTION controlp INFIELD xcco102a

            #END add-point
 
         #Ctrlp:input.c.page1.xcco102b
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcco102b
            #add-point:ON ACTION controlp INFIELD xcco102b

            #END add-point
 
         #Ctrlp:input.c.page1.xcco102d
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcco102d
            #add-point:ON ACTION controlp INFIELD xcco102d

            #END add-point
 
         #Ctrlp:input.c.page1.xcco102e
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcco102e
            #add-point:ON ACTION controlp INFIELD xcco102e

            #END add-point
 
         #Ctrlp:input.c.page1.xcco102f
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcco102f
            #add-point:ON ACTION controlp INFIELD xcco102f

            #END add-point
 
         #Ctrlp:input.c.page1.xcco102g
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcco102g
            #add-point:ON ACTION controlp INFIELD xcco102g

            #END add-point
 
         #Ctrlp:input.c.page1.xcco102h
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcco102h
            #add-point:ON ACTION controlp INFIELD xcco102h

            #END add-point
 
         #Ctrlp:input.c.page1.xcco102c
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcco102c
            #add-point:ON ACTION controlp INFIELD xcco102c

            #END add-point
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_xcco_d[l_ac].* = g_xcco_d_t.*
               CLOSE axcq920_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_xcco_d[l_ac].xcco002 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_xcco_d[l_ac].* = g_xcco_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               
            
               #add-point:單身修改前

               #end add-point
         
               #將遮罩欄位還原
               CALL axcq920_xcco_t_mask_restore('restore_mask_o')
         
               UPDATE xcco_t SET (xccold,xcco001,xcco003,xcco004,xcco005,xcco002,xcco006,xcco007,xcco008, 
                   xcco010,xcco009,xcco102,xcco102a,xcco102b,xcco102d,xcco102e,xcco102f,xcco102g,xcco102h, 
                   xcco102c) = (g_xcco_m.xccold,g_xcco_m.xcco001,g_xcco_m.xcco003,g_xcco_m.xcco004,g_xcco_m.xcco005, 
                   g_xcco_d[l_ac].xcco002,g_xcco_d[l_ac].xcco006,g_xcco_d[l_ac].xcco007,g_xcco_d[l_ac].xcco008, 
                   g_xcco_d[l_ac].xcco010,g_xcco_d[l_ac].xcco009,g_xcco_d[l_ac].xcco102,g_xcco_d[l_ac].xcco102a, 
                   g_xcco_d[l_ac].xcco102b,g_xcco_d[l_ac].xcco102d,g_xcco_d[l_ac].xcco102e,g_xcco_d[l_ac].xcco102f, 
                   g_xcco_d[l_ac].xcco102g,g_xcco_d[l_ac].xcco102h,g_xcco_d[l_ac].xcco102c)      
 
                WHERE xccoent = g_enterprise AND xccold = g_xcco_m.xccold 
                 AND xcco001 = g_xcco_m.xcco001 
                 AND xcco003 = g_xcco_m.xcco003 
                 AND xcco004 = g_xcco_m.xcco004 
                 AND xcco005 = g_xcco_m.xcco005 
                 
                 AND xcco002 = g_xcco_d_t.xcco002 #項次     
                 AND xcco006 = g_xcco_d_t.xcco006  
                 AND xcco007 = g_xcco_d_t.xcco007  
                 AND xcco008 = g_xcco_d_t.xcco008  
                 AND xcco009 = g_xcco_d_t.xcco009  
 
                 
               #add-point:單身修改中

               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcco_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "xcco_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xcco_m.xccold
               LET gs_keys_bak[1] = g_xccold_t
               LET gs_keys[2] = g_xcco_m.xcco001
               LET gs_keys_bak[2] = g_xcco001_t
               LET gs_keys[3] = g_xcco_m.xcco003
               LET gs_keys_bak[3] = g_xcco003_t
              LET gs_keys[4] = g_xcco_m.xcco004
               LET gs_keys_bak[4] = g_xcco004_t
               LET gs_keys[5] = g_xcco_m.xcco005
               LET gs_keys_bak[5] = g_xcco005_t
               LET gs_keys[6] = g_xcco_d[g_detail_idx].xcco002
               LET gs_keys_bak[6] = g_xcco_d_t.xcco002
               LET gs_keys[7] = g_xcco_d[g_detail_idx].xcco006
               LET gs_keys_bak[7] = g_xcco_d_t.xcco006
               LET gs_keys[8] = g_xcco_d[g_detail_idx].xcco007
               LET gs_keys_bak[8] = g_xcco_d_t.xcco007
               LET gs_keys[9] = g_xcco_d[g_detail_idx].xcco008
               LET gs_keys_bak[9] = g_xcco_d_t.xcco008
               LET gs_keys[10] = g_xcco_d[g_detail_idx].xcco009
               LET gs_keys_bak[10] = g_xcco_d_t.xcco009
               CALL axcq920_update_b('xcco_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_xcco_m),util.JSON.stringify(g_xcco_d_t)
                     LET g_log2 = util.JSON.stringify(g_xcco_m),util.JSON.stringify(g_xcco_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL axcq920_xcco_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_xcco_m.xccold
               LET ls_keys[ls_keys.getLength()+1] = g_xcco_m.xcco001
               LET ls_keys[ls_keys.getLength()+1] = g_xcco_m.xcco003
               LET ls_keys[ls_keys.getLength()+1] = g_xcco_m.xcco004
               LET ls_keys[ls_keys.getLength()+1] = g_xcco_m.xcco005
 
               LET ls_keys[ls_keys.getLength()+1] = g_xcco_d_t.xcco002
               LET ls_keys[ls_keys.getLength()+1] = g_xcco_d_t.xcco006
               LET ls_keys[ls_keys.getLength()+1] = g_xcco_d_t.xcco007
               LET ls_keys[ls_keys.getLength()+1] = g_xcco_d_t.xcco008
               LET ls_keys[ls_keys.getLength()+1] = g_xcco_d_t.xcco009
 
               CALL axcq920_key_update_b(ls_keys)
               
               #add-point:單身修改後

               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row

            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xcco_d[l_ac].* = g_xcco_d_t.*
               END IF
               CLOSE axcq920_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
 
            CLOSE axcq920_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_xcco_d.getLength() = 0 THEN
               NEXT FIELD xcco002
            END IF
            #add-point:input段after input 

            #end add-point    
            
         ON ACTION controlo   
            CALL FGL_SET_ARR_CURR(g_xcco_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_xcco_d.getLength()+1
            
      END INPUT
 
 
      
 
      
 
      
 
    
      #add-point:input段more_input

      #end add-point    
      
      BEFORE DIALOG
         #CALL cl_err_collect_init()    
         #add-point:input段before_dialog

         #end add-point 
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)      
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD xccold
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD xcco002
 
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
 
 
   
   #add-point:input段after_input

   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axcq920.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION axcq920_show()
   #add-point:show段define

   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)
   DEFINE l_glaa001 LIKE glaa_t.glaa001
   DEFINE l_glaa016 LIKE glaa_t.glaa016
   DEFINE l_glaa020 LIKE glaa_t.glaa020
   #end add-point
   
   #add-point:show段之前

   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL axcq920_b_fill(g_wc2) #第一階單身填充
      CALL axcq920_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:2)
   CALL axcq920_set_pk_array()
   #add-point:ON ACTION agendum
   SELECT glaa001,glaa016,glaa020 INTO l_glaa001,l_glaa016,l_glaa020
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_xcco_m.xccold
      
      
   CASE g_xcco_m.xcco001
      WHEN '1' 
        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = l_glaa001
        CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
        LET g_xcco_m.xcco001_desc = '', g_rtn_fields[1] , ''                  
      WHEN '2'
        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = l_glaa016
        CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
        LET g_xcco_m.xcco001_desc = '', g_rtn_fields[1] , ''
      WHEN '3'
        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = l_glaa020
        CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
        LET g_xcco_m.xcco001_desc = '', g_rtn_fields[1] , ''
   END CASE                             
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
   
  DISPLAY BY NAME g_xcco_m.xccocomp,g_xcco_m.xccocomp_desc,g_xcco_m.xcco004,g_xcco_m.xcco001,g_xcco_m.xcco001_desc, 
       g_xcco_m.xccold,g_xcco_m.xccold_desc,g_xcco_m.xcco005,g_xcco_m.xcco003,g_xcco_m.xcco003_desc
 
   CALL axcq920_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後

   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="axcq920.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION axcq920_ref_show()
   #add-point:ref_show段define
   
   #end add-point 
   DEFINE l_ac_t LIKE type_t.num10 #l_ac暫存用
   #add-point:ref_show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)
   
   #end add-point
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:ref_show段m_reference
   
   #end add-point
 
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_xcco_d.getLength()
      #add-point:ref_show段d_reference
 
      #end add-point
   END FOR
   
 
   
   #add-point:ref_show段自訂
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="axcq920.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION axcq920_reproduce()
   #add-point:reproduce段define

   #end add-point
   DEFINE l_newno     LIKE xcco_t.xccold 
   DEFINE l_oldno     LIKE xcco_t.xccold 
   DEFINE l_newno02     LIKE xcco_t.xcco001 
   DEFINE l_oldno02     LIKE xcco_t.xcco001 
   DEFINE l_newno03     LIKE xcco_t.xcco003 
   DEFINE l_oldno03     LIKE xcco_t.xcco003 
   DEFINE l_newno04     LIKE xcco_t.xcco004 
   DEFINE l_oldno04     LIKE xcco_t.xcco004 
   DEFINE l_newno05     LIKE xcco_t.xcco005 
   DEFINE l_oldno05     LIKE xcco_t.xcco005  
   DEFINE l_master    RECORD LIKE xcco_t.*
   DEFINE l_detail    RECORD LIKE xcco_t.*
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)

   #end add-point
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF     
 
   IF g_xcco_m.xccold IS NULL
      OR g_xcco_m.xcco001 IS NULL
      OR g_xcco_m.xcco003 IS NULL
      OR g_xcco_m.xcco004 IS NULL
      OR g_xcco_m.xcco005 IS NULL 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_xccold_t = g_xcco_m.xccold
   LET g_xcco001_t = g_xcco_m.xcco001
   LET g_xcco003_t = g_xcco_m.xcco003
   LET g_xcco004_t = g_xcco_m.xcco004
   LET g_xcco005_t = g_xcco_m.xcco005 
   
   LET g_xcco_m.xccold = ""
   LET g_xcco_m.xcco001 = ""
   LET g_xcco_m.xcco003 = ""
   LET g_xcco_m.xcco004 = ""
   LET g_xcco_m.xcco005 = "" 
   LET g_master_insert = FALSE
   CALL axcq920_set_entry('a')
   CALL axcq920_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前

   #end add-point
   
   #清空key欄位的desc
      LET g_xcco_m.xcco001_desc = ''
   DISPLAY BY NAME g_xcco_m.xcco001_desc
   LET g_xcco_m.xccold_desc = ''
   DISPLAY BY NAME g_xcco_m.xccold_desc
   LET g_xcco_m.xcco003_desc = ''
   DISPLAY BY NAME g_xcco_m.xcco003_desc
 
   
   CALL axcq920_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = 9001 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_xcco_m.* TO NULL
      INITIALIZE g_xcco_d TO NULL
 
      CALL axcq920_show()
      LET INT_FLAG = 0
      RETURN 
   END IF
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axcq920_set_act_visible()
   CALL axcq920_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_xccold_t = g_xcco_m.xccold
   LET g_xcco001_t = g_xcco_m.xcco001
   LET g_xcco003_t = g_xcco_m.xcco003
   LET g_xcco004_t = g_xcco_m.xcco004
   LET g_xcco005_t = g_xcco_m.xcco005 
   
   #組合新增資料的條件
   LET g_add_browse = " xccoent = '" ||g_enterprise|| "' AND",
                      " xccold = '", g_xcco_m.xccold, "' "
                      ," AND xcco001 = '", g_xcco_m.xcco001, "' "
                      ," AND xcco003 = '", g_xcco_m.xcco003, "' "
                      ," AND xcco004 = '", g_xcco_m.xcco004, "' "
                      ," AND xcco005 = '", g_xcco_m.xcco005, "' "                      
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axcq920_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL axcq920_idx_chk()
   
   #add-point:完成複製段落後

   #end add-point
   
   #功能已完成,通報訊息中心
   CALL axcq920_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="axcq920.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION axcq920_detail_reproduce()
   #add-point:delete段define

   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE xcco_t.*
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)

   #end add-point    
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE axcq920_detail
   
   #add-point:單身複製前1

   #end add-point
   
   #CREATE TEMP TABLE
    LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE axcq920_detail AS ",
                "SELECT * FROM xcco_t "
   PREPARE repro_tbl FROM ls_sql
   EXECUTE repro_tbl
   FREE repro_tbl
                
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO axcq920_detail SELECT * FROM xcco_t 
                                         WHERE xccoent = g_enterprise AND xccold = g_xccold_t
                                         AND xcco001 = g_xcco001_t
                                         AND xcco003 = g_xcco003_t
                                         AND xcco004 = g_xcco004_t
                                         AND xcco005 = g_xcco005_t
 
   
   #將key修正為調整後   
   UPDATE axcq920_detail 
      #更新key欄位
      SET xccold = g_xcco_m.xccold
          , xcco001 = g_xcco_m.xcco001
          , xcco003 = g_xcco_m.xcco003
          , xcco004 = g_xcco_m.xcco004
          , xcco005 = g_xcco_m.xcco005 
      #更新共用欄位
      
                                       
   #將資料塞回原table   
   INSERT INTO xcco_t SELECT * FROM axcq920_detail
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單身複製中1

   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE axcq920_detail
   
   #add-point:單身複製後1

   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_xccold_t = g_xcco_m.xccold
   LET g_xcco001_t = g_xcco_m.xcco001
   LET g_xcco003_t = g_xcco_m.xcco003
   LET g_xcco004_t = g_xcco_m.xcco004
   LET g_xcco005_t = g_xcco_m.xcco005 
   
   DROP TABLE axcq920_detail
   
END FUNCTION
 
{</section>}
 
{<section id="axcq920.delete" >}
#+ 資料刪除
PRIVATE FUNCTION axcq920_delete()
   #add-point:delete段define

   #end add-point
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)

   #end add-point     
   
   IF g_xcco_m.xccold IS NULL
   OR g_xcco_m.xcco001 IS NULL
   OR g_xcco_m.xcco003 IS NULL
   OR g_xcco_m.xcco004 IS NULL
   OR g_xcco_m.xcco005 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN axcq920_cl USING g_enterprise,g_xcco_m.xccold,g_xcco_m.xcco001,g_xcco_m.xcco003,g_xcco_m.xcco004,g_xcco_m.xcco005
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axcq920_cl:" 
      LET g_errparam.code   =  STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CLOSE axcq920_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axcq920_master_referesh USING g_xcco_m.xccold,g_xcco_m.xcco001,g_xcco_m.xcco003,g_xcco_m.xcco004, 
       g_xcco_m.xcco005 INTO g_xcco_m.xccocomp,g_xcco_m.xcco004,g_xcco_m.xcco001,g_xcco_m.xccold,g_xcco_m.xcco005, 
       g_xcco_m.xcco003,g_xcco_m.xccocomp_desc,g_xcco_m.xcco001_desc,g_xcco_m.xccold_desc,g_xcco_m.xcco003_desc 
   
   #遮罩相關處理
   LET g_xcco_m_mask_o.* =  g_xcco_m.*
   CALL axcq920_xcco_t_mask()
   LET g_xcco_m_mask_n.* =  g_xcco_m.*
   
   CALL axcq920_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:2)
      #刪除相關文件
      CALL axcq920_set_pk_array()
      #add-point:相關文件刪除前

      #end add-point   
      CALL cl_doc_remove()  
 
 
  
 
      #add-point:單身刪除前

      #end add-point
      
      DELETE FROM xcco_t WHERE xccoent = g_enterprise AND xccold = g_xcco_m.xccold
                                                               AND xcco001 = g_xcco_m.xcco001
                                                               AND xcco003 = g_xcco_m.xcco003
 
                                                               
      #add-point:單身刪除中

      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xcco_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         CALL s_transaction_end('N','0')
      END IF
 
      
  
      #add-point:單身刪除後 

      #end add-point
      
 
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
 
   
      #add-point:多語言刪除

      #end add-point
      
      #頭先不紀錄
      #IF NOT cl_log_modified_record('','') THEN 
      #   CLOSE axcq920_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_xcco_d.clear() 
 
     
      CALL axcq920_ui_browser_refresh()  
      #CALL axcq920_ui_headershow()  
      #CALL axcq920_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL axcq920_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL axcq920_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE axcq920_cl
 
   #功能已完成,通報訊息中心
   CALL axcq920_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="axcq920.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axcq920_b_fill(p_wc2)
   #add-point:b_fill段define

   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)
   DEFINE l_sql              STRING
   DEFINE l_xcco102_sum      LIKE xcco_t.xcco102
   DEFINE l_xcco102a_sum     LIKE xcco_t.xcco102a
   DEFINE l_xcco102b_sum     LIKE xcco_t.xcco102b
   DEFINE l_xcco102c_sum     LIKE xcco_t.xcco102c
   DEFINE l_xcco102d_sum     LIKE xcco_t.xcco102d
   DEFINE l_xcco102e_sum     LIKE xcco_t.xcco102e
   DEFINE l_xcco102f_sum     LIKE xcco_t.xcco102f
   DEFINE l_xcco102g_sum     LIKE xcco_t.xcco102g
   DEFINE l_xcco102h_sum     LIKE xcco_t.xcco102h
   DEFINE l_xcco102_total    LIKE xcco_t.xcco102
   DEFINE l_xcco102a_total   LIKE xcco_t.xcco102a
   DEFINE l_xcco102b_total   LIKE xcco_t.xcco102b
   DEFINE l_xcco102c_total   LIKE xcco_t.xcco102c
   DEFINE l_xcco102d_total   LIKE xcco_t.xcco102d
   DEFINE l_xcco102e_total   LIKE xcco_t.xcco102e
   DEFINE l_xcco102f_total   LIKE xcco_t.xcco102f
   DEFINE l_xcco102g_total   LIKE xcco_t.xcco102g
   DEFINE l_xcco102h_total   LIKE xcco_t.xcco102h

   #end add-point     
   
   #先清空單身變數內容
   CALL g_xcco_d.clear()
 
 
   #add-point:b_fill段sql_before
 
   #end add-point
   LET g_sql = "SELECT  UNIQUE xcco002,xcco006,xcco007,xcco008,xcco010,xcco009,xcco102,xcco102a,xcco102b, 
       xcco102d,xcco102e,xcco102f,xcco102g,xcco102h,xcco102c,t1.xcbfl003 ,t2.imaal003 FROM xcco_t",  
         
               "",
               
                              " LEFT JOIN xcbfl_t t1 ON t1.xcbflent='"||g_enterprise||"' AND t1.xcbfl001=xcco002 AND t1.xcbfl002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent='"||g_enterprise||"' AND t2.imaal001=xcco006 AND t2.imaal002='"||g_dlang||"' ",
 
               " WHERE xccoent= ? AND xccold=? AND xcco001=? AND xcco003=? AND xcco004=? AND xcco005=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xcco_t")
   END IF
   
   #add-point:b_fill段sql_after

   
   LET g_sql_tmp = g_sql  #by ouhz add 2015/03/27
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF axcq920_fill_chk(1) THEN
      IF g_action_choice <> 'fetch' OR cl_null(g_action_choice) THEN
        LET g_sql = g_sql, " ORDER BY xcco_t.xcco002,xcco_t.xcco006,xcco_t.xcco007,xcco_t.xcco008,xcco_t.xcco009"
         #add-point:b_fill段fill_before
      LET l_xcco102_sum = 0
      LET l_xcco102a_sum = 0
      LET l_xcco102b_sum = 0
      LET l_xcco102c_sum = 0
      LET l_xcco102d_sum = 0
      LET l_xcco102e_sum = 0
      LET l_xcco102f_sum = 0
      LET l_xcco102g_sum = 0
      LET l_xcco102h_sum = 0
      LET l_xcco102_total = 0
      LET l_xcco102a_total = 0 
      LET l_xcco102b_total = 0 
      LET l_xcco102c_total = 0
      LET l_xcco102d_total = 0
      LET l_xcco102e_total = 0
      LET l_xcco102f_total = 0
      LET l_xcco102g_total = 0
      LET l_xcco102h_total = 0  
      

         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axcq920_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR axcq920_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
       OPEN b_fill_cs USING g_enterprise,g_xcco_m.xccold,g_xcco_m.xcco001,g_xcco_m.xcco003,g_xcco_m.xcco004,g_xcco_m.xcco005
      FOREACH b_fill_cs INTO g_xcco_d[l_ac].xcco002,g_xcco_d[l_ac].xcco006,g_xcco_d[l_ac].xcco007,g_xcco_d[l_ac].xcco008, 
          g_xcco_d[l_ac].xcco010,g_xcco_d[l_ac].xcco009,g_xcco_d[l_ac].xcco102,g_xcco_d[l_ac].xcco102a, 
          g_xcco_d[l_ac].xcco102b,g_xcco_d[l_ac].xcco102d,g_xcco_d[l_ac].xcco102e,g_xcco_d[l_ac].xcco102f, 
          g_xcco_d[l_ac].xcco102g,g_xcco_d[l_ac].xcco102h,g_xcco_d[l_ac].xcco102c,g_xcco_d[l_ac].xcco002_desc, 
          g_xcco_d[l_ac].xcco006_desc
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充

         CALL s_desc_get_item_desc(g_xcco_d[l_ac].xcco006) RETURNING g_xcco_d[l_ac].xcco006_desc,g_xcco_d[l_ac].xcco006_desc_1          
#合计
         LET l_xcco102_total = l_xcco102_total + g_xcco_d[l_ac].xcco102
         LET l_xcco102a_total = l_xcco102a_total + g_xcco_d[l_ac].xcco102a
         LET l_xcco102b_total = l_xcco102b_total + g_xcco_d[l_ac].xcco102b
         LET l_xcco102c_total = l_xcco102c_total + g_xcco_d[l_ac].xcco102e
         LET l_xcco102d_total = l_xcco102d_total + g_xcco_d[l_ac].xcco102d
         LET l_xcco102e_total = l_xcco102e_total + g_xcco_d[l_ac].xcco102e
         LET l_xcco102f_total = l_xcco102f_total + g_xcco_d[l_ac].xcco102f
         LET l_xcco102g_total = l_xcco102g_total + g_xcco_d[l_ac].xcco102g
         LET l_xcco102h_total = l_xcco102h_total + g_xcco_d[l_ac].xcco102h
         
       
         
         IF cl_get_para(g_enterprise,g_site,'S-FIN-6001') = 'Y' THEN
            #依成本域小计
            LET l_xcco102_sum = l_xcco102_sum + g_xcco_d[l_ac].xcco102
            LET l_xcco102a_sum = l_xcco102a_sum + g_xcco_d[l_ac].xcco102a
            LET l_xcco102b_sum = l_xcco102b_sum + g_xcco_d[l_ac].xcco102b
            LET l_xcco102c_sum = l_xcco102c_sum + g_xcco_d[l_ac].xcco102c
            LET l_xcco102d_sum = l_xcco102d_sum + g_xcco_d[l_ac].xcco102d
            LET l_xcco102e_sum = l_xcco102e_sum + g_xcco_d[l_ac].xcco102e
            LET l_xcco102f_sum = l_xcco102f_sum + g_xcco_d[l_ac].xcco102f
            LET l_xcco102g_sum = l_xcco102g_sum + g_xcco_d[l_ac].xcco102g
            LET l_xcco102h_sum = l_xcco102h_sum + g_xcco_d[l_ac].xcco102h
            IF l_ac > 1 THEN        

                 IF g_xcco_d[l_ac].xcco002 != g_xcco_d[l_ac - 1].xcco002  THEN   

                  #把当前行下移，并在当前行显示小计
                  LET g_xcco_d[l_ac + 1].* = g_xcco_d[l_ac].*  
                  INITIALIZE  g_xcco_d[l_ac].* TO NULL         
                  LET g_xcco_d[l_ac].xcco002 = cl_getmsg("axc-00205",g_lang)   #151029-00010#3 20151029 mark by beckxie
            
                  LET g_xcco_d[l_ac].xcco102 = l_xcco102_sum - g_xcco_d[l_ac + 1].xcco102
                  LET g_xcco_d[l_ac].xcco102a = l_xcco102a_sum - g_xcco_d[l_ac + 1].xcco102a
                  LET g_xcco_d[l_ac].xcco102b = l_xcco102b_sum - g_xcco_d[l_ac + 1].xcco102b
                  LET g_xcco_d[l_ac].xcco102c = l_xcco102c_sum - g_xcco_d[l_ac + 1].xcco102c
                  LET g_xcco_d[l_ac].xcco102d = l_xcco102d_sum - g_xcco_d[l_ac + 1].xcco102d
                  LET g_xcco_d[l_ac].xcco102e = l_xcco102e_sum - g_xcco_d[l_ac + 1].xcco102e
                  LET g_xcco_d[l_ac].xcco102f = l_xcco102f_sum - g_xcco_d[l_ac + 1].xcco102f
                  LET g_xcco_d[l_ac].xcco102g = l_xcco102g_sum - g_xcco_d[l_ac + 1].xcco102g
                  LET g_xcco_d[l_ac].xcco102h = l_xcco102h_sum - g_xcco_d[l_ac + 1].xcco102h
                  LET l_ac = l_ac + 1
                  LET l_xcco102_sum = g_xcco_d[l_ac].xcco102
                  LET l_xcco102a_sum = g_xcco_d[l_ac].xcco102a
                  LET l_xcco102b_sum = g_xcco_d[l_ac].xcco102b
                  LET l_xcco102c_sum = g_xcco_d[l_ac].xcco102c
                  LET l_xcco102d_sum = g_xcco_d[l_ac].xcco102d
                  LET l_xcco102e_sum = g_xcco_d[l_ac].xcco102e
                  LET l_xcco102f_sum = g_xcco_d[l_ac].xcco102f
                  LET l_xcco102g_sum = g_xcco_d[l_ac].xcco102g
                  LET l_xcco102h_sum = g_xcco_d[l_ac].xcco102h
               END IF
            END IF
          
         END IF
         
         
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
 
            CALL g_xcco_d.deleteElement(g_xcco_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more
  
   
   IF cl_get_para(g_enterprise,g_site,'S-FIN-6001') = 'Y' THEN
      #最后一组小计
      LET g_xcco_d[l_ac].xcco002 = cl_getmsg("axc-00205",g_lang)      
      LET g_xcco_d[l_ac].xcco102 = l_xcco102_sum
      LET g_xcco_d[l_ac].xcco102a = l_xcco102a_sum
      LET g_xcco_d[l_ac].xcco102b = l_xcco102b_sum
      LET g_xcco_d[l_ac].xcco102c = l_xcco102c_sum
      LET g_xcco_d[l_ac].xcco102d = l_xcco102d_sum
      LET g_xcco_d[l_ac].xcco102e = l_xcco102e_sum
      LET g_xcco_d[l_ac].xcco102f = l_xcco102f_sum
      LET g_xcco_d[l_ac].xcco102g = l_xcco102g_sum
      LET g_xcco_d[l_ac].xcco102h = l_xcco102h_sum
      LET l_ac = l_ac + 1
   END IF
   #合计
   IF cl_get_para(g_enterprise,g_site,'S-FIN-6001') = 'N' THEN    #成本域隐藏的时候，合计字样放到料件栏位
      LET g_xcco_d[l_ac].xcco006 = cl_getmsg("axc-00204",g_lang)
   ELSE
      LET g_xcco_d[l_ac].xcco002 = cl_getmsg("axc-00204",g_lang)
   END IF
   LET g_xcco_d[l_ac].xcco102 = l_xcco102_total
   LET g_xcco_d[l_ac].xcco102a = l_xcco102a_total
   LET g_xcco_d[l_ac].xcco102b = l_xcco102b_total
   LET g_xcco_d[l_ac].xcco102c = l_xcco102c_total
   LET g_xcco_d[l_ac].xcco102d = l_xcco102d_total
   LET g_xcco_d[l_ac].xcco102e = l_xcco102e_total
   LET g_xcco_d[l_ac].xcco102f = l_xcco102f_total
   LET g_xcco_d[l_ac].xcco102g = l_xcco102g_total
   LET g_xcco_d[l_ac].xcco102h = l_xcco102h_total
   LET l_ac = l_ac + 1
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_xcco_d.getLength()
      LET g_xcco_d_mask_o[l_ac].* =  g_xcco_d[l_ac].*
      CALL axcq920_xcco_t_mask()
      LET g_xcco_d_mask_n[l_ac].* =  g_xcco_d[l_ac].*
   END FOR
   
 
 
   FREE axcq920_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="axcq920.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION axcq920_idx_chk()
   #add-point:idx_chk段define
   
   #end add-point
   #add-point:idx_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)
   
   #end add-point  
   
   #判定目前選擇的頁面
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      #確保當下指標的位置未超過上限
      IF g_detail_idx > g_xcco_d.getLength() THEN
         LET g_detail_idx = g_xcco_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_xcco_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xcco_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
 
   
   #add-point:idx_chk段other
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axcq920.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axcq920_b_fill2(pi_idx)
   #add-point:b_fill2段define
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)
 
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_xcco_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後
 
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="axcq920.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION axcq920_before_delete()
   #add-point:before_delete段define

   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)

   #end add-point 
   
   #add-point:單筆刪除前

   #end add-point
   
   DELETE FROM xcco_t
    WHERE xccoent = g_enterprise AND xccold = g_xcco_m.xccold AND
                              xcco001 = g_xcco_m.xcco001 AND
                              xcco003 = g_xcco_m.xcco003 AND
                              xcco004 = g_xcco_m.xcco004 AND
                              xcco005 = g_xcco_m.xcco005 AND
 
          xcco002 = g_xcco_d_t.xcco002
      AND xcco006 = g_xcco_d_t.xcco006
      AND xcco007 = g_xcco_d_t.xcco007
      AND xcco008 = g_xcco_d_t.xcco008
      AND xcco009 = g_xcco_d_t.xcco009
 
      
   #add-point:單筆刪除中

   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcco_t" 
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
 
{<section id="axcq920.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION axcq920_delete_b(ps_table,ps_keys_bak,ps_page)
   #add-point:delete_b段define
   
   #end add-point
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:delete_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)
   
   #end add-point     
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="axcq920.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION axcq920_insert_b(ps_table,ps_keys,ps_page)
   #add-point:insert_b段define
   
   #end add-point
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   #add-point:insert_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)
   
   #end add-point     
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="axcq920.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION axcq920_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   #add-point:update_b段define
   
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
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)
   
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
 
{<section id="axcq920.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION axcq920_key_update_b(ps_keys_bak)
   #add-point:update_b段define

   #end add-point
DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)

   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_xcco_d[l_ac].xcco002 = g_xcco_d_t.xcco002 
      AND g_xcco_d[l_ac].xcco006 = g_xcco_d_t.xcco006 
      AND g_xcco_d[l_ac].xcco007 = g_xcco_d_t.xcco007 
      AND g_xcco_d[l_ac].xcco008 = g_xcco_d_t.xcco008 
      AND g_xcco_d[l_ac].xcco009 = g_xcco_d_t.xcco009 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="axcq920.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION axcq920_lock_b(ps_table,ps_page)
   #add-point:lock_b段define
   
   #end add-point
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)
   
   #end add-point   
   
   #先刷新資料
   #CALL axcq920_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axcq920.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION axcq920_unlock_b(ps_table,ps_page)
   #add-point:unlock_b段define
   
   #end add-point
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)
   
   #end add-point  
   
 
 
END FUNCTION
 
{</section>}
 
{<section id="axcq920.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION axcq920_set_entry(p_cmd)
   #add-point:set_entry段define

   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)

   #end add-point       
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("xccold,xcco001,xcco003,xcco004,xcco005",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制

      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後

   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axcq920.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION axcq920_set_no_entry(p_cmd)
   #add-point:set_no_entry段define

   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)

   #end add-point     
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("xccold,xcco001,xcco003,xcco004,xcco005",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制

      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後

   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axcq920.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION axcq920_set_entry_b(p_cmd)
   #add-point:set_entry_b段define
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)
   
   #end add-point     
   
   #add-point:set_entry_b段
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axcq920.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION axcq920_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)
   
   #end add-point    
   
   #add-point:set_no_entry_b段
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="axcq920.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION axcq920_set_act_visible()
   #add-point:set_act_visible段define
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)
   
   #end add-point
   
   #add-point:set_act_visible段
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq920.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION axcq920_set_act_no_visible()
   #add-point:set_act_no_visible段define
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)
   
   #end add-point
   
   #add-point:set_act_no_visible段
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq920.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION axcq920_set_act_visible_b()
   #add-point:set_act_visible_b段define
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)
   
   #end add-point
   
   #add-point:set_act_visible_b段
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq920.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION axcq920_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)
   
   #end add-point
   
   #add-point:set_act_no_visible_b段
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq920.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION axcq920_default_search()
   #add-point:default_search段define

   #end add-point    
   DEFINE li_idx  LIKE type_t.num10
   DEFINE li_cnt  LIKE type_t.num10
   DEFINE ls_wc   STRING
   #add-point:default_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)

   #end add-point 
   
   LET g_pagestart = 1
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   #add-point:default_search段開始前

   #end add-point  
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " xccold = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " xcco001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " xcco003 = '", g_argv[03], "' AND "
   END IF
    IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " xcco004 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET ls_wc = ls_wc, " xcco005 = '", g_argv[05], "' AND "
   END IF
   
   #add-point:default_search段after sql

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
   
   #add-point:default_search段結束前

   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="axcq920.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION axcq920_fill_chk(ps_idx)
   #add-point:fill_chk段define
   
   #end add-point
   DEFINE ps_idx        LIKE type_t.chr10
   DEFINE lst_token     base.StringTokenizer
   DEFINE ls_token      STRING
   #add-point:fill_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)
   
   #end add-point
   
   #此funtion功能暫時停用(2015/1/12)
   #無論傳入值為何皆回傳true(代表要填充該單身)
   
   #add-point:fill_chk段other
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axcq920.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION axcq920_modify_detail_chk(ps_record)
   #add-point:modify_detail_chk段define

   #end add-point
   DEFINE ps_record STRING
   DEFINE ls_return STRING
   #add-point:modify_detail_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)

   #end add-point
   
   #add-point:modify_detail_chk段開始前

   #end add-point
   
   CASE ps_record
      WHEN "s_detail1" 
         LET ls_return = "xcco002"
 
      #add-point:modify_detail_chk段自訂page控制

      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前

   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="axcq920.mask_functions" >}
&include "erp/axc/axcq920_mask.4gl"
 
{</section>}
 
{<section id="axcq920.state_change" >}
    
 
{</section>}
 
{<section id="axcq920.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:6)
#+ 給予pk_array內容
PRIVATE FUNCTION axcq920_set_pk_array()
   #add-point:set_pk_array段define

   #end add-point
   #add-point:set_pk_array段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)

   #end add-point
   
   #add-point:set_pk_array段之前

   #end add-point  
   
   #若l_ac<=0代表沒有資料
   IF l_ac <= 0 THEN
      RETURN
   END IF
   
   CALL g_pk_array.clear()
   LET g_pk_array[1].values = g_xcco_m.xccold
   LET g_pk_array[1].column = 'xccold'
   LET g_pk_array[2].values = g_xcco_m.xcco001
   LET g_pk_array[2].column = 'xcco001'
   LET g_pk_array[3].values = g_xcco_m.xcco003
   LET g_pk_array[3].column = 'xcco003'
   LET g_pk_array[4].values = g_xcco_m.xcco004
   LET g_pk_array[4].column = 'xcco004'
   LET g_pk_array[5].values = g_xcco_m.xcco005
   LET g_pk_array[5].column = 'xcco005'   
   #add-point:set_pk_array段之後

   #end add-point  
   
END FUNCTION
 
 
 
{</section>}
 
{<section id="axcq920.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:4)
PRIVATE FUNCTION axcq920_msgcentre_notify(lc_state)
   #add-point:msgcentre_notify段define
   
   #end add-point   
   DEFINE lc_state LIKE type_t.chr80
   #add-point:msgcentre_notify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)
   
   #end add-point
   
   INITIALIZE g_msgparam TO NULL
 
   #action-id與狀態填寫
   LET g_msgparam.state = lc_state
 
   #PK資料填寫
   CALL axcq920_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_xcco_m)
 
   #add-point:msgcentre其他通知
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
{</section>}
 
{<section id="axcq920.other_function" readonly="Y" >}

#查询时预设条件
PRIVATE FUNCTION axcq920_default()
DEFINE  l_glaa001        LIKE glaa_t.glaa001

   #预设当前site的法人，主账套，年度期别，成本计算类型

   CALL s_axc_set_site_default() RETURNING g_xcco_m.xccocomp,g_xcco_m.xccold,g_xcco_m.xcco004,g_xcco_m.xcco005,g_xcco_m.xcco003
   DISPLAY BY NAME g_xcco_m.xccocomp,g_xcco_m.xccold,g_xcco_m.xcco004,g_xcco_m.xcco005,g_xcco_m.xcco003

   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xcco_m.xccocomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcco_m.xccocomp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcco_m.xccocomp_desc 
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xcco_m.xccold
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcco_m.xccold_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcco_m.xccold_desc 

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xcco_m.xcco003
   CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcco_m.xcco003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcco_m.xcco003_desc
      
   LET g_xcco_m.xcco001 = '1'
   DISPLAY BY NAME g_xcco_m.xcco001
   
   SELECT glaa001 INTO l_glaa001
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_xcco_m.xccold

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = l_glaa001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcco_m.xcco001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcco_m.xcco001_desc      
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
PRIVATE FUNCTION axcq920_ins_xckk()
   DEFINE l_sum_xcco102        LIKE xcco_t.xcco102
   DEFINE l_sum_xcco102a       LIKE xcco_t.xcco102a
   DEFINE l_sum_xcco102b       LIKE xcco_t.xcco102b
   DEFINE l_sum_xcco102c       LIKE xcco_t.xcco102c
   DEFINE l_sum_xcco102d       LIKE xcco_t.xcco102d
   DEFINE l_sum_xcco102e       LIKE xcco_t.xcco102e
   DEFINE l_sum_xcco102f       LIKE xcco_t.xcco102f
   DEFINE l_sum_xcco102g       LIKE xcco_t.xcco102g
   DEFINE l_sum_xcco102h       LIKE xcco_t.xcco102h
   DEFINE i                    LIKE type_t.num5
   
   IF g_xcco_d.getLength() = 0 AND g_xcco_d.getLength() = 0 THEN RETURN END IF
#先判断单头条件是否存在与axci601的设置资料里，不存在则退出
#再判断是否已有重复单头资料的xckk/xckl，提示是否删除，若不删除，则退出

#20151019 by stellar mark ----- (S)
#stellar mark:s_axcq004_upd_xckk已沒在使用
#   IF NOT s_axcq004_upd_xckk_chk_del('2',                                     #type         传入更新类型 1：axcq004更新总报表 2：子查询作业更新分项报表
#                                     g_enterprise,                            #xckkent      传入企业编号
#                                     g_xcco_m.xccocomp,                       #xckkcomp     传入法人
#                                     g_xcco_m.xccold,                         #xckkld       传入账套
#                                     g_xcco_m.xcco004,                        #xckk003      传入年度
#                                     g_xcco_m.xcco005,                        #xckk004      传入期别
#                                     g_prog,                                  #xckk005      传入程序代号
#                                     g_xcco_m.xcco003,                        #xckk006      传入成本计算类型
#                                     g_xcco_m.xcco001)                                      #xckk007      传入本位币顺序
#   THEN
#      RETURN
#   END IF
#   
#   LET l_sum_xcco102 = 0
#   LET l_sum_xcco102a = 0
#   LET l_sum_xcco102b = 0
#   LET l_sum_xcco102c = 0
#   LET l_sum_xcco102d = 0
#   LET l_sum_xcco102e = 0
#   LET l_sum_xcco102f = 0
#   LET l_sum_xcco102g = 0
#   LET l_sum_xcco102h = 0
#   FOR i = 1 TO g_xcco_d.getLength()
#       IF g_xcco_d[i].xcco102 IS NULL THEN
#          LET g_xcco_d[i].xcco102 = 0
#       END IF
#       IF g_xcco_d[i].xcco102a IS NULL THEN
#          LET g_xcco_d[i].xcco102a = 0
#       END IF
#       IF g_xcco_d[i].xcco102b IS NULL THEN
#          LET g_xcco_d[i].xcco102b = 0
#       END IF
#       IF g_xcco_d[i].xcco102c IS NULL THEN
#          LET g_xcco_d[i].xcco102c = 0
#       END IF
#       IF g_xcco_d[i].xcco102d IS NULL THEN
#          LET g_xcco_d[i].xcco102d = 0
#       END IF
#       IF g_xcco_d[i].xcco102e IS NULL THEN
#          LET g_xcco_d[i].xcco102e = 0
#       END IF
#       IF g_xcco_d[i].xcco102f IS NULL THEN
#          LET g_xcco_d[i].xcco102f = 0
#       END IF
#       IF g_xcco_d[i].xcco102g IS NULL THEN
#          LET g_xcco_d[i].xcco102g = 0
#       END IF
#       IF g_xcco_d[i].xcco102h IS NULL THEN
#          LET g_xcco_d[i].xcco102h = 0
#       END IF
#       LET l_sum_xcco102 = l_sum_xcco102 + g_xcco_d[i].xcco009*g_xcco_d[i].xcco102
#       LET l_sum_xcco102a = l_sum_xcco102a + g_xcco_d[i].xcco009*g_xcco_d[i].xcco102a
#       LET l_sum_xcco102b = l_sum_xcco102b + g_xcco_d[i].xcco009*g_xcco_d[i].xcco102b
#       LET l_sum_xcco102c = l_sum_xcco102c + g_xcco_d[i].xcco009*g_xcco_d[i].xcco102c
#       LET l_sum_xcco102d = l_sum_xcco102d + g_xcco_d[i].xcco009*g_xcco_d[i].xcco102d
#       LET l_sum_xcco102e = l_sum_xcco102e + g_xcco_d[i].xcco009*g_xcco_d[i].xcco102e
#       LET l_sum_xcco102f = l_sum_xcco102f + g_xcco_d[i].xcco009*g_xcco_d[i].xcco102f
#       LET l_sum_xcco102g = l_sum_xcco102g + g_xcco_d[i].xcco009*g_xcco_d[i].xcco102g
#       LET l_sum_xcco102h = l_sum_xcco102h + g_xcco_d[i].xcco009*g_xcco_d[i].xcco102h
#   END FOR
#   
#   FOR i = 1 TO g_xcco_d.getLength()
#      IF NOT s_axcq004_upd_xckk('2',                                          #type         传入更新类型 1：axcq004更新总报表 2：子查询作业更新分项报表
#                                g_enterprise,                                 #xckkent      传入企业编号
#                                g_xcco_m.xccocomp,                            #xckkcomp     传入法人
#                                g_xcco_m.xccold,                              #xckkld       传入账套
#                                '106',                                        #xckk001      传入类型代码
#                                g_xcco_m.xcco004,                             #xckk003      传入年度
#                                g_xcco_m.xcco005,                             #xckk004      传入期别
#                                g_prog,                                       #xckk005      传入程序代号
#                                g_xcco_m.xcco003,                             #xckk006      传入成本计算类型
#                                g_xcco_m.xcco001,                             #xckk007      传入本位币顺序
#                                0,                                            #xckk103      传入总表/分项报表数量
#                                l_sum_xcco102,                                #xckk104      传入总表/分项报表金额
#                                l_sum_xcco102a,                               #xckk104a     传入总表/分项报表金额-材料
#                                l_sum_xcco102b,                               #xckk104b     传入总表/分项报表金额-人工
#                                l_sum_xcco102c,                               #xckk104c     传入总表/分项报表金额-加工
#                                l_sum_xcco102d,                               #xckk104d     传入总表/分项报表金额-制费一
#                                l_sum_xcco102e,                               #xckk104e     传入总表/分项报表金额-制费二
#                                l_sum_xcco102f,                               #xckk104f     传入总表/分项报表金额-制费三
#                                l_sum_xcco102g,                               #xckk104g     传入总表/分项报表金额-制费四
#                                l_sum_xcco102h,                               #xckk104h     传入总表/分项报表金额-制费五
#                                g_xcco_d[1].xcco009,                          #xckl007      传入成本勾稽明细表-单据编号
#                                0,                                            #xckl008      传入成本勾稽明细表-项次
#                                0,                                            #xckl009      传入成本勾稽明细表-序号
#                                g_xcco_d[1].xcco006,                          #xckl010      传入成本勾稽明细表-料件
#                                g_xcco_d[1].xcco007,                          #xckl011      传入成本勾稽明细表-特性
#                                g_xcco_d[1].xcco008,                          #xckl012      传入成本勾稽明细表-批号
#                                0,                                            #xckl014      传入成本勾稽明细表-数量
#                                g_xcco_d[10].xcco102)                         #xckl015      传入成本勾稽明细表-金额
#        THEN
#         RETURN
#      END IF
#   END FOR
#20151019 by stellar mark ----- (E)
END FUNCTION

################################################################################
# Descriptions...: 創建暫存檔
# Date & Author..: 2015/3/27 By ouhz
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq920_create_temp_table()
DROP TABLE axcq920_tmp;
   CREATE TEMP TABLE axcq920_tmp(
   xcco002         LIKE xcco_t.xcco002,
   xcco002_desc    LIKE type_t.chr100,    
   xcco006         LIKE xcco_t.xcco006, 
   xcco006_desc    LIKE type_t.chr100, 
   xcco006_desc_1  LIKE type_t.chr100, 
   xcco007         LIKE xcco_t.xcco007, 
   xcco008         LIKE xcco_t.xcco008, 
   xcco010         LIKE xcco_t.xcco010, 
   xcco010_desc    LIKE type_t.chr100,
   xcco009         LIKE xcco_t.xcco009, 
   xcco102         LIKE xcco_t.xcco102, 
   xcco102a        LIKE xcco_t.xcco102a, 
   xcco102b        LIKE xcco_t.xcco102b, 
   xcco102d        LIKE xcco_t.xcco102d, 
   xcco102e        LIKE xcco_t.xcco102e, 
   xcco102f        LIKE xcco_t.xcco102f, 
   xcco102g        LIKE xcco_t.xcco102g, 
   xcco102h        LIKE xcco_t.xcco102h, 
   xcco102c        LIKE xcco_t.xcco102c, 
   xccocomp        LIKE xcco_t.xccocomp, 
   xccocomp_desc   LIKE type_t.chr100, 
   xcco004         LIKE xcco_t.xcco004, 
   xcco001         LIKE xcco_t.xcco001, 
   xcco001_desc    LIKE type_t.chr100, 
   xccold          LIKE xcco_t.xccold, 
   xccold_desc     LIKE type_t.chr100, 
   xcco005         LIKE xcco_t.xcco005, 
   xcco003         LIKE xcco_t.xcco003, 
   xcco003_desc    LIKE type_t.chr100,
   xccoent         LIKE xcco_t.xccoent,   
   xccokey         LIKE type_t.chr1000
   );

END FUNCTION

################################################################################
# Descriptions...: 將數據存放在暫存檔
# Date & Author..: 2015/3/27 By ouhz
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq920_ins_temp()
DEFINE sr                RECORD
   xcco002         LIKE xcco_t.xcco002,
   xcco002_desc    LIKE type_t.chr100,    
   xcco006         LIKE xcco_t.xcco006, 
   xcco006_desc    LIKE type_t.chr100, 
   xcco006_desc_1  LIKE type_t.chr100, 
   xcco007         LIKE xcco_t.xcco007, 
   xcco008         LIKE xcco_t.xcco008, 
   xcco010         LIKE xcco_t.xcco010,
   xcco010_desc    LIKE type_t.chr100, 
   xcco009         LIKE xcco_t.xcco009, 
   xcco102         LIKE xcco_t.xcco102, 
   xcco102a        LIKE xcco_t.xcco102a, 
   xcco102b        LIKE xcco_t.xcco102b, 
   xcco102d        LIKE xcco_t.xcco102d, 
   xcco102e        LIKE xcco_t.xcco102e, 
   xcco102f        LIKE xcco_t.xcco102f, 
   xcco102g        LIKE xcco_t.xcco102g, 
   xcco102h        LIKE xcco_t.xcco102h, 
   xcco102c        LIKE xcco_t.xcco102c, 
   xccocomp        LIKE xcco_t.xccocomp, 
   xccocomp_desc   LIKE type_t.chr100, 
   xcco004         LIKE xcco_t.xcco004, 
   xcco001         LIKE xcco_t.xcco001, 
   xcco001_desc    LIKE type_t.chr100, 
   xccold          LIKE xcco_t.xccold, 
   xccold_desc     LIKE type_t.chr100, 
   xcco005         LIKE xcco_t.xcco005, 
   xcco003         LIKE xcco_t.xcco003, 
   xcco003_desc    LIKE type_t.chr100,
   xccoent         LIKE xcco_t.xccoent,   
   xccokey         LIKE type_t.chr1000
                   END RECORD
DEFINE l_i               LIKE type_t.num5
DEFINE l_glaa001         LIKE glaa_t.glaa001
DEFINE l_glaa016         LIKE glaa_t.glaa016
DEFINE l_glaa020         LIKE glaa_t.glaa020
DEFINE l_xcco004         LIKE type_t.chr30
DEFINE l_xcco005         LIKE type_t.chr30 
DEFINE l_success         LIKE type_t.num5

   #刪除臨時表中資料
    DELETE FROM axcq920_tmp
    
    LET l_success = TRUE

    FOR l_i = 1 TO g_browser.getLength()


      LET sr.xcco004  = g_browser[l_i].b_xcco004
      LET sr.xcco001  = g_browser[l_i].b_xcco001
      LET sr.xccold   = g_browser[l_i].b_xccold
      LET sr.xcco005  = g_browser[l_i].b_xcco005
      LET sr.xcco003  = g_browser[l_i].b_xcco003

      EXECUTE axcq920_master_referesh USING sr.xccold,sr.xcco001,sr.xcco003,sr.xcco004,sr.xcco005 
      INTO sr.xccocomp,sr.xcco004,sr.xcco001,sr.xccold,sr.xcco005,sr.xcco003,sr.xccocomp_desc,sr.xcco001_desc,sr.xccold_desc,sr.xcco003_desc 
      LET l_xcco004=sr.xcco004
      LET l_xcco005=sr.xcco005
      LET sr.xccokey = sr.xccocomp,"-",sr.xccold,"-",l_xcco004 CLIPPED,"-",l_xcco005 CLIPPED,"-",sr.xcco001 CLIPPED,"-",sr.xcco003

     
      PREPARE axcq920_ins_tmp_pre FROM g_sql_tmp
      DECLARE axcq920_ins_tmp_cs CURSOR FOR axcq920_ins_tmp_pre
      

      OPEN axcq920_ins_tmp_cs USING g_enterprise,sr.xccold,sr.xcco001,sr.xcco003,sr.xcco004,sr.xcco005
                                               
      FOREACH axcq920_ins_tmp_cs INTO sr.xcco002,sr.xcco006,sr.xcco007,sr.xcco008,sr.xcco010,sr.xcco009,sr.xcco102,sr.xcco102a,sr.xcco102b, 
                                      sr.xcco102d,sr.xcco102e,sr.xcco102f,sr.xcco102g,sr.xcco102h,sr.xcco102c,sr.xcco002_desc,sr.xcco006_desc
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = sr.xcco006
      CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET sr.xcco006_desc = '', g_rtn_fields[1] , ''
      LET sr.xcco006_desc_1 = '', g_rtn_fields[2] , ''
        
            
     INITIALIZE g_ref_fields TO NULL
     LET g_ref_fields[1] = sr.xcco010
     CALL ap_ref_array2(g_ref_fields,"SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001='8916' AND gzcbl002=? AND gzcbl003='"||g_lang||"'","") RETURNING g_rtn_fields
     LET sr.xcco010_desc = '', g_rtn_fields[1] , ''
     DISPLAY BY NAME sr.xcco010_desc
     
     IF NOT cl_null(sr.xcco010_desc) THEN
        LET sr.xcco010_desc = sr.xcco010,":",sr.xcco010_desc CLIPPED
     ELSE
        LET sr.xcco010_desc = sr.xcco010
     END IF
     
  
INSERT INTO axcq920_tmp( xcco002,xcco002_desc,xcco006,xcco006_desc,xcco006_desc_1,xcco007,xcco008,xcco010,xcco010_desc,xcco009,xcco102,xcco102a,
                              xcco102b,xcco102d,xcco102e,xcco102f,xcco102g,xcco102h,xcco102c,
                              xccocomp,xccocomp_desc,xcco004,xcco001,xcco001_desc,xccold,xccold_desc,xcco005,xcco003,xcco003_desc,xccoent,xccokey )
                      VALUES( sr.xcco002,sr.xcco002_desc,sr.xcco006,sr.xcco006_desc,sr.xcco006_desc_1,sr.xcco007,sr.xcco008,sr.xcco010,sr.xcco010_desc, 
                              sr.xcco009,sr.xcco102,sr.xcco102a,sr.xcco102b,sr.xcco102d,sr.xcco102e,sr.xcco102f,sr.xcco102g,sr.xcco102h,sr.xcco102c,
                              sr.xccocomp,sr.xccocomp_desc,sr.xcco004,sr.xcco001,sr.xcco001_desc,sr.xccold,sr.xccold_desc,sr.xcco005,sr.xcco003,sr.xcco003_desc,sr.xccoent,sr.xccokey )
      
      IF SQLCA.sqlcode  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'insert tmp'
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF   
     END FOREACH
     
     CALL cl_err_collect_show()
     IF l_success = FALSE THEN
        DELETE FROM axcq920_tmp
     END IF
      
     FREE axcq920_ins_tmp_pre
   END FOR     
   
END FUNCTION

 
{</section>}
 
