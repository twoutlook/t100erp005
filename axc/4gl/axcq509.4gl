#該程式未解開Section, 採用最新樣板產出!
{<section id="axcq509.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0017(2015-08-13 18:18:16), PR版次:0017(2016-10-21 15:29:38)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000129
#+ Filename...: axcq509
#+ Description: 生產入庫成本查詢作業
#+ Creator....: 01258(2014-09-04 00:00:00)
#+ Modifier...: 03297 -SD/PR- 02294
 
{</section>}
 
{<section id="axcq509.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#150902-00008#7   15/09/24   By Alberti   以成本分群做小計/總計 
#151130-00003#9   15/11/30   By earl      加上二次篩選功能
#160113-00011#1   16/01/13   By dorislai  整單操作action 串出各作業時，需串到下那筆資料，查不到資料也需顯示無資料
#160411-00040#1   16/04/11   By Ann_Huang 處理單價/金額為NULL的部分,將轉換成0
#160318-00025#9   16/04/21   By 07675     將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160414-00018#44  16/05/20   By Reanna    效能調整
#160802-00020#4   16/08/04   By dorislai  增加帳套權限管控
#160802-00020#10  16/08/11   By dorislai  增加法人權限管控
#160811-00010#1   16/08/30   By Ann_Huang 修正 axcq509、axcr509 資料需多撈取xcck055 ='2030'、'2050'、'2090'
#161006-00032#2   16/10/07   By 02040     拿掉'2030'資料抓取
#161019-00017#4  2016/10/21 By lixiang  调整组织栏位的开窗
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
PRIVATE type type_g_xcck_m        RECORD
       xcckcomp LIKE xcck_t.xcckcomp, 
   xcckcomp_desc LIKE type_t.chr80, 
   xcck004 LIKE xcck_t.xcck004, 
   xcck005 LIKE xcck_t.xcck005, 
   xcck001 LIKE xcck_t.xcck001, 
   xcck001_desc LIKE type_t.chr80, 
   xcckld LIKE xcck_t.xcckld, 
   xcckld_desc LIKE type_t.chr80, 
   xcck004_1 LIKE type_t.num5, 
   xcck005_1 LIKE type_t.num5, 
   xcck003 LIKE xcck_t.xcck003, 
   xcck003_desc LIKE type_t.chr80, 
   query_type LIKE type_t.chr500
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_xcck_d        RECORD
       xcck002 LIKE xcck_t.xcck002, 
   xcck002_desc LIKE type_t.chr500, 
   xcck025 LIKE xcck_t.xcck025, 
   xcck025_desc LIKE type_t.chr500, 
   xcck006 LIKE xcck_t.xcck006, 
   xcck007 LIKE xcck_t.xcck007, 
   xcck008 LIKE xcck_t.xcck008, 
   xcck009 LIKE xcck_t.xcck009, 
   xcck013 LIKE xcck_t.xcck013, 
   xcck010 LIKE xcck_t.xcck010, 
   xcck010_desc LIKE type_t.chr500, 
   xcck010_desc_1 LIKE type_t.chr500, 
   imag011 LIKE type_t.chr500, 
   imag011_desc LIKE type_t.chr500, 
   xcck011 LIKE xcck_t.xcck011, 
   xcck047 LIKE xcck_t.xcck047, 
   xcck015 LIKE xcck_t.xcck015, 
   xcck015_desc LIKE type_t.chr500, 
   xcck017 LIKE xcck_t.xcck017, 
   xcck044 LIKE xcck_t.xcck044, 
   xcck044_desc LIKE type_t.chr500, 
   xcck201 LIKE xcck_t.xcck201, 
   xcck282a LIKE xcck_t.xcck282a, 
   xcck282b LIKE xcck_t.xcck282b, 
   xcck282c LIKE xcck_t.xcck282c, 
   xcck282d LIKE xcck_t.xcck282d, 
   xcck282e LIKE xcck_t.xcck282e, 
   xcck282f LIKE xcck_t.xcck282f, 
   xcck282g LIKE xcck_t.xcck282g, 
   xcck282h LIKE xcck_t.xcck282h, 
   xcck282 LIKE xcck_t.xcck282, 
   xcck202a LIKE xcck_t.xcck202a, 
   xcck202b LIKE xcck_t.xcck202b, 
   xcck202c LIKE xcck_t.xcck202c, 
   xcck202d LIKE xcck_t.xcck202d, 
   xcck202e LIKE xcck_t.xcck202e, 
   xcck202f LIKE xcck_t.xcck202f, 
   xcck202g LIKE xcck_t.xcck202g, 
   xcck202h LIKE xcck_t.xcck202h, 
   xcck202 LIKE xcck_t.xcck202
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_wc_xcck055          STRING
DEFINE g_query_type          LIKE type_t.chr500
DEFINE g_para_data           LIKE type_t.chr80     #采用成本域否  #fengmy150109
DEFINE g_para_data1          LIKE type_t.chr80     #采用特性否    #fengmy150109
#fengmy150807-----add
DEFINE g_yy1 LIKE type_t.num5
DEFINE g_mm1 LIKE type_t.num5
DEFINE g_yy2 LIKE type_t.num5
DEFINE g_mm2 LIKE type_t.num5
#fengmy150807-----end
DEFINE g_wc_cs_ld            STRING                #160802-00020#4-add
DEFINE g_wc_cs_comp          STRING                #160802-00020#10-add
#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_xcck_m          type_g_xcck_m
DEFINE g_xcck_m_t        type_g_xcck_m
DEFINE g_xcck_m_o        type_g_xcck_m
DEFINE g_xcck_m_mask_o   type_g_xcck_m #轉換遮罩前資料
DEFINE g_xcck_m_mask_n   type_g_xcck_m #轉換遮罩後資料
 
   DEFINE g_xcck004_t LIKE xcck_t.xcck004
DEFINE g_xcck005_t LIKE xcck_t.xcck005
DEFINE g_xcck001_t LIKE xcck_t.xcck001
DEFINE g_xcckld_t LIKE xcck_t.xcckld
DEFINE g_xcck003_t LIKE xcck_t.xcck003
 
 
DEFINE g_xcck_d          DYNAMIC ARRAY OF type_g_xcck_d
DEFINE g_xcck_d_t        type_g_xcck_d
DEFINE g_xcck_d_o        type_g_xcck_d
DEFINE g_xcck_d_mask_o   DYNAMIC ARRAY OF type_g_xcck_d #轉換遮罩前資料
DEFINE g_xcck_d_mask_n   DYNAMIC ARRAY OF type_g_xcck_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_xcckld LIKE xcck_t.xcckld,
      b_xcck001 LIKE xcck_t.xcck001,
      b_xcck003 LIKE xcck_t.xcck003,
      b_xcck004 LIKE xcck_t.xcck004,
      b_xcck005 LIKE xcck_t.xcck005
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
#wangxina 15/03/27 add   start
DEFINE g_sql_tmp             STRING
TYPE type_g_xcck_e RECORD
       v          STRING
       END RECORD
DEFINE g_param     type_g_xcck_e
#wangxina 15/03/27 add   end
#end add-point
 
{</section>}
 
{<section id="axcq509.main" >}
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
   #160802-00020#4-add-(S)
   CALL s_fin_create_account_center_tmp()                      #展組織下階成員所需之暫存檔 
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_ld_str() RETURNING g_wc_cs_ld
   CALL s_fin_get_wc_str(g_wc_cs_ld)  RETURNING g_wc_cs_ld
   #160802-00020#4-add-(E)
   CALL s_axc_get_authcomp() RETURNING g_wc_cs_comp            #抓取使用者有拜訪權限據點的對應法人  #160802-00020#10-add
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT xcckcomp,'',xcck004,xcck005,xcck001,'',xcckld,'','','',xcck003,'',''", 
        
                      " FROM xcck_t",
                      " WHERE xcckent= ? AND xcckld=? AND xcck001=? AND xcck003=? AND xcck004=? AND  
                          xcck005=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axcq509_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.xcckcomp,t0.xcck004,t0.xcck005,t0.xcck001,t0.xcckld,t0.xcck003,t1.ooefl003 , 
       t2.ooail003 ,t3.glaal002 ,t4.xcatl003",
               " FROM xcck_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.xcckcomp AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t2 ON t2.ooailent="||g_enterprise||" AND t2.ooail001=t0.xcck001 AND t2.ooail002='"||g_dlang||"' ",
               " LEFT JOIN glaal_t t3 ON t3.glaalent="||g_enterprise||" AND t3.glaalld=t0.xcckld AND t3.glaal001='"||g_dlang||"' ",
               " LEFT JOIN xcatl_t t4 ON t4.xcatlent="||g_enterprise||" AND t4.xcatl001=t0.xcck003 AND t4.xcatl002='"||g_dlang||"' ",
 
               " WHERE t0.xcckent = " ||g_enterprise|| " AND t0.xcckld = ? AND t0.xcck001 = ? AND t0.xcck003 = ? AND t0.xcck004 = ? AND t0.xcck005 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axcq509_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axcq509 WITH FORM cl_ap_formpath("axc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axcq509_init()   
 
      #進入選單 Menu (="N")
      CALL axcq509_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      CALL axcq509_ins_xckk()
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axcq509
      
   END IF 
   
   CLOSE axcq509_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axcq509.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axcq509_init()
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
   CALL cl_set_combo_scc('xcck001','8914')
   CALL cl_set_combo_scc('query_type','8923')
   #fengmy 150109----begin
   #根據參數顯示隱藏成本域 和 料件特性
   CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data   #采用成本域否            
   IF g_para_data = 'Y' THEN
      CALL cl_set_comp_visible('xcck002,xcck002_desc',TRUE)                    
   ELSE
      CALL cl_set_comp_visible('xcck002,xcck002_desc',FALSE)                
   END IF 
   CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data1   #采用成本域否            
   IF g_para_data1 = 'Y' THEN
      CALL cl_set_comp_visible('xcck011,xcck011_desc',TRUE)                    
   ELSE
      CALL cl_set_comp_visible('xcck011,xcck011_desc',FALSE)                
   END IF   
   #fengmy 150109----end
   #end add-point
   
   CALL axcq509_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="axcq509.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION axcq509_ui_dialog()
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
   IF cl_null(g_wc) OR g_wc = " 1=1" THEN
      CALL axcq509_query()
   END IF
   #end add-point
   
   WHILE TRUE
      
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_xcck_m.* TO NULL
         CALL g_xcck_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL axcq509_init()
      END IF
 
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
        
         DISPLAY ARRAY g_xcck_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL axcq509_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL axcq509_ui_detailshow()
               
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
        
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
 
         #end add-point
         
         
         BEFORE DIALOG
            #先填充browser資料
            CALL axcq509_browser_fill("")
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
               CALL axcq509_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL axcq509_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"

         #151130-00003#7   151130   By earl add s
         ON ACTION filter
            LET g_action_choice="filter"
            CALL axcq509_filter()
         #151130-00003#7   151130   By earl add e


#wangxina 15/03/27 add   start 
        ON ACTION output
            LET g_action_choice="output"
            
              IF g_xcck_d.getLength()>0 THEN
                 CALL axcq509_create_temp_table()  
                 CALL axcq509_ins_temp()               
                 LET g_param.v = "axcq509_tmp"
                 CALL axcq509_x01('1=1',g_param.v)
              END IF
            
#wangxina 15/03/27 add   end
            #end add-point
 
         
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL axcq509_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq509_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL axcq509_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq509_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL axcq509_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq509_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL axcq509_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq509_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL axcq509_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq509_idx_chk()
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
                  LET g_export_node[1] = base.typeInfo.create(g_xcck_d)
                  LET g_export_id[1]   = "s_detail1"
 
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
               NEXT FIELD xcck002
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
               CALL axcq509_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL axcq509_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL axcq509_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axcq509_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL axcq509_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL axcq509_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL axcq509_set_pk_array()
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
 
{<section id="axcq509.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION axcq509_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axcq509.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION axcq509_browser_fill(ps_page_action)
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
   CASE g_query_type
     WHEN '1'    #一般工单
       #LET g_wc_xcck055 = " xcck055 IN('205','2050', '2030') "   #160811-00010#1 add '2050', '2030' #161006-00032#2 mark
        LET g_wc_xcck055 = " xcck055 IN('205','2050') "           #161006-00032#2 add
     WHEN '2'    #返工工单
       #LET g_wc_xcck055 = " xcck055 IN( '209','2090', '2030') "  #160811-00010#1 add '2090', '2030' #161006-00032#2 mark 
        LET g_wc_xcck055 = " xcck055 IN( '209','2090') "  #161006-00032#2 
     WHEN '3'    #拆件工单
       #LET g_wc_xcck055 = " xcck055 IN('2052') " #wujie 150301 去掉205 #fengmy150514 mark
        LET g_wc_xcck055 = " xcck020 IN('106','113') "                  #fengmy150514
     WHEN '9'    #全部
       #LET g_wc_xcck055 = " xcck055 IN('205','209','2051','2052') "   #150109 fengmy mark
       #LET g_wc_xcck055 = " xcck055 IN('205','209', '2050','2090','2030') "   #150109 fengmy   #160811-00010#1 add '2050','2090','2030' #161006-00032#2 mark
        LET g_wc_xcck055 = " xcck055 IN('205','209', '2050','2090') "   #161006-00032#2
     OTHERWISE
       #LET g_wc_xcck055 = " xcck055 IN('205','209','2051','2052') "   #150109 fengmy mark
       #LET g_wc_xcck055 = " xcck055 IN('205','209', '2050','2090','2030') "   #150109 fengmy   #160811-00010#1 add '2050','2090','2030' #161006-00032#2 mark
        LET g_wc_xcck055 = " xcck055 IN('205','209', '2050','2090') "          #161006-00032#2
   END CASE
   IF cl_null(g_wc) THEN
      LET g_wc = g_wc_xcck055
      LET g_wc = g_wc," AND (xcck004*12+xcck005 BETWEEN ",g_yy1,"*12+",g_mm1," AND ",g_yy2,"*12+",g_mm2,")"  #fengmy150807        
   ELSE
      LET g_wc = g_wc," AND ",g_wc_xcck055
      LET g_wc = g_wc," AND (xcck004*12+xcck005 BETWEEN ",g_yy1,"*12+",g_mm1," AND ",g_yy2,"*12+",g_mm2,")"  #fengmy150807  
   END IF
   #end add-point    
 
   LET l_searchcol = "xcckld,xcck001,xcck003,xcck004,xcck005"
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
      LET l_sub_sql = " SELECT DISTINCT xcckld ",
                      ", xcck001 ",
                      ", xcck003 ",
                      ", xcck004 ",
                      ", xcck005 ",
 
                      " FROM xcck_t ",
                      " ",
                      " ", 
 
 
 
                      " WHERE xcckent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("xcck_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT xcckld ",
                      ", xcck001 ",
                      ", xcck003 ",
                      ", xcck004 ",
                      ", xcck005 ",
 
                      " FROM xcck_t ",
                      " ",
                      " ", 
 
 
                      " WHERE xcckent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("xcck_t")
   END IF 
   
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
 
   #add-point:browser_fill,count前 name="browser_fill.before_count"
   #fengmy150807----begin
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT UNIQUE xcckld ",
                      ", xcck001 ",
                      ", xcck003 ",
 
                      " FROM xcck_t ",
                      " ",
                      " ",
 
                      " WHERE xcckent = '" ||g_enterprise|| "' AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("xcck_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE xcckld ",
                      ", xcck001 ",
                      ", xcck003 ",
 
                      " FROM xcck_t ",
                      " ",
                      " ",
                      " WHERE xcckent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED, cl_sql_add_filter("xcck_t")
   END IF 
   
   #160802-00020#4-add-(S)
   #---增帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET g_sql = g_sql , " AND xcckld IN ",g_wc_cs_ld
    END IF
   #160802-00020#4-add-(E)
   #160802-00020#10-add-(S)
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET g_sql = g_sql," AND xcckcomp IN ",g_wc_cs_comp
   END IF
   #160802-00020#10-add-(E)
   
   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"
   #fengmy150807----end
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
      INITIALIZE g_xcck_m.* TO NULL
      CALL g_xcck_d.clear()        
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.xcckld,t0.xcck001,t0.xcck003,t0.xcck004,t0.xcck005 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.xcckld,t0.xcck001,t0.xcck003,t0.xcck004,t0.xcck005",
                " FROM xcck_t t0",
                #" ",
                " ",
 
 
 
                
                " WHERE t0.xcckent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("xcck_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"


   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   #fengmy150807----begin
   LET g_sql  = "SELECT DISTINCT t0.xcckld,t0.xcck001,t0.xcck003,'','' ",                 
                " FROM xcck_t t0",
                " ",
                " ",
                
 
                
                " WHERE t0.xcckent = '" ||g_enterprise|| "' AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("xcck_t")
   #160802-00020#4-add-(S)
   #---增加帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET g_sql = g_sql , " AND xcckld IN ",g_wc_cs_ld
    END IF
   #160802-00020#4-add-(E)
   #160802-00020#10-add-(S)
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET g_sql = g_sql," AND xcckcomp IN ",g_wc_cs_comp
   END IF
   #160802-00020#10-add-(E)
   LET g_sql= g_sql, " ORDER BY ","xcckld,xcck001,xcck003", " ", g_order
   #fengmy150807----end
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"xcck_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_xcckld,g_browser[g_cnt].b_xcck001,g_browser[g_cnt].b_xcck003, 
          g_browser[g_cnt].b_xcck004,g_browser[g_cnt].b_xcck005 
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
   
   IF cl_null(g_browser[g_cnt].b_xcckld) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_xcck_m.* TO NULL
      CALL g_xcck_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      #160113-00011#1-add----(S)
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = "-100"
      LET g_errparam.popup  = FALSE
      CALL cl_err()
      #160113-00011#1-add----(E)
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL axcq509_fetch('')
   
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
 
{<section id="axcq509.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION axcq509_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_xcck_m.xcckld = g_browser[g_current_idx].b_xcckld   
   LET g_xcck_m.xcck001 = g_browser[g_current_idx].b_xcck001   
   LET g_xcck_m.xcck003 = g_browser[g_current_idx].b_xcck003   
   LET g_xcck_m.xcck004 = g_browser[g_current_idx].b_xcck004   
   LET g_xcck_m.xcck005 = g_browser[g_current_idx].b_xcck005   
 
   EXECUTE axcq509_master_referesh USING g_xcck_m.xcckld,g_xcck_m.xcck001,g_xcck_m.xcck003,g_xcck_m.xcck004, 
       g_xcck_m.xcck005 INTO g_xcck_m.xcckcomp,g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_m.xcck001,g_xcck_m.xcckld, 
       g_xcck_m.xcck003,g_xcck_m.xcckcomp_desc,g_xcck_m.xcck001_desc,g_xcck_m.xcckld_desc,g_xcck_m.xcck003_desc 
 
   CALL axcq509_show()
   
END FUNCTION
 
{</section>}
 
{<section id="axcq509.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION axcq509_ui_detailshow()
   #add-point:ui_detailshow段define name="ui_detailshow.define_customerization"
   
   #end add-point
   #add-point:ui_detailshow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="ui_detailshow.before"
   
   #end add-point  
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
 
      #add-point:ui_detailshow段more name="ui_detailshow.more"
      
      #end add-point 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="axcq509.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION axcq509_ui_browser_refresh()
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
      IF g_browser[l_i].b_xcckld = g_xcck_m.xcckld 
         AND g_browser[l_i].b_xcck001 = g_xcck_m.xcck001 
         AND g_browser[l_i].b_xcck003 = g_xcck_m.xcck003 
         AND g_browser[l_i].b_xcck004 = g_xcck_m.xcck004 
         AND g_browser[l_i].b_xcck005 = g_xcck_m.xcck005 
 
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
 
{<section id="axcq509.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION axcq509_construct()
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
   INITIALIZE g_xcck_m.* TO NULL
   CALL g_xcck_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON xcckcomp,xcck001,xcckld,xcck003
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            CALL axcq509_default()
            #end add-point 
            
                 #Ctrlp:construct.c.xcckcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcckcomp
            #add-point:ON ACTION controlp INFIELD xcckcomp name="construct.c.xcckcomp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #160802-00020#10-add-(S)
            #增加法人過濾條件
            IF NOT cl_null(g_wc_cs_comp) THEN
               LET g_qryparam.where = " ooef001 IN ",g_wc_cs_comp
            END IF
            #160802-00020#10-add-(E)
            #CALL q_ooef001()                           #呼叫開窗  #161019-00017#4
            CALL q_ooef001_2()   #161019-00017#4
            DISPLAY g_qryparam.return1 TO xcckcomp  #顯示到畫面上
            NEXT FIELD xcckcomp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcckcomp
            #add-point:BEFORE FIELD xcckcomp name="construct.b.xcckcomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcckcomp
            
            #add-point:AFTER FIELD xcckcomp name="construct.a.xcckcomp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck001
            #add-point:BEFORE FIELD xcck001 name="construct.b.xcck001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck001
            
            #add-point:AFTER FIELD xcck001 name="construct.a.xcck001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcck001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck001
            #add-point:ON ACTION controlp INFIELD xcck001 name="construct.c.xcck001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xcckld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcckld
            #add-point:ON ACTION controlp INFIELD xcckld name="construct.c.xcckld"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #160802-00020#4-add-(S)
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            IF NOT cl_null(g_wc_cs_ld) THEN
               LET g_qryparam.where = " glaald IN ",g_wc_cs_ld
            END IF
            #160802-00020#4-add-(E)
            CALL q_authorised_ld()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcckld  #顯示到畫面上
            NEXT FIELD xcckld                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcckld
            #add-point:BEFORE FIELD xcckld name="construct.b.xcckld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcckld
            
            #add-point:AFTER FIELD xcckld name="construct.a.xcckld"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcck003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck003
            #add-point:ON ACTION controlp INFIELD xcck003 name="construct.c.xcck003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcat001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck003  #顯示到畫面上
            NEXT FIELD xcck003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck003
            #add-point:BEFORE FIELD xcck003 name="construct.b.xcck003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck003
            
            #add-point:AFTER FIELD xcck003 name="construct.a.xcck003"
            
            #END add-point
            
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON xcck002,xcck025,xcck006,xcck007,xcck008,xcck009,xcck013,xcck010,xcck011, 
          xcck047,xcck015,xcck015_desc,xcck017,xcck044,xcck201,xcck282a,xcck282b,xcck282c,xcck282d,xcck282e, 
          xcck282f,xcck282g,xcck282h,xcck282,xcck202a,xcck202b,xcck202c,xcck202d,xcck202e,xcck202f,xcck202g, 
          xcck202h,xcck202
           FROM s_detail1[1].xcck002,s_detail1[1].xcck025,s_detail1[1].xcck006,s_detail1[1].xcck007, 
               s_detail1[1].xcck008,s_detail1[1].xcck009,s_detail1[1].xcck013,s_detail1[1].xcck010,s_detail1[1].xcck011, 
               s_detail1[1].xcck047,s_detail1[1].xcck015,s_detail1[1].xcck015_desc,s_detail1[1].xcck017, 
               s_detail1[1].xcck044,s_detail1[1].xcck201,s_detail1[1].xcck282a,s_detail1[1].xcck282b, 
               s_detail1[1].xcck282c,s_detail1[1].xcck282d,s_detail1[1].xcck282e,s_detail1[1].xcck282f, 
               s_detail1[1].xcck282g,s_detail1[1].xcck282h,s_detail1[1].xcck282,s_detail1[1].xcck202a, 
               s_detail1[1].xcck202b,s_detail1[1].xcck202c,s_detail1[1].xcck202d,s_detail1[1].xcck202e, 
               s_detail1[1].xcck202f,s_detail1[1].xcck202g,s_detail1[1].xcck202h,s_detail1[1].xcck202 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck002
            #add-point:BEFORE FIELD xcck002 name="construct.b.page1.xcck002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck002
            
            #add-point:AFTER FIELD xcck002 name="construct.a.page1.xcck002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck002
            #add-point:ON ACTION controlp INFIELD xcck002 name="construct.c.page1.xcck002"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcbf001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck002  #顯示到畫面上            
            NEXT FIELD xcck002                     #返回原欄位
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xcck025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck025
            #add-point:ON ACTION controlp INFIELD xcck025 name="construct.c.page1.xcck025"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck025  #顯示到畫面上
            NEXT FIELD xcck025                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck025
            #add-point:BEFORE FIELD xcck025 name="construct.b.page1.xcck025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck025
            
            #add-point:AFTER FIELD xcck025 name="construct.a.page1.xcck025"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck006
            #add-point:BEFORE FIELD xcck006 name="construct.b.page1.xcck006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck006
            
            #add-point:AFTER FIELD xcck006 name="construct.a.page1.xcck006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck006
            #add-point:ON ACTION controlp INFIELD xcck006 name="construct.c.page1.xcck006"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " inbastus = 'S'"
            CALL q_inbadocno_2()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck006  #顯示到畫面上            
            NEXT FIELD xcck006                     #返回原欄位
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck007
            #add-point:BEFORE FIELD xcck007 name="construct.b.page1.xcck007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck007
            
            #add-point:AFTER FIELD xcck007 name="construct.a.page1.xcck007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck007
            #add-point:ON ACTION controlp INFIELD xcck007 name="construct.c.page1.xcck007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck008
            #add-point:BEFORE FIELD xcck008 name="construct.b.page1.xcck008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck008
            
            #add-point:AFTER FIELD xcck008 name="construct.a.page1.xcck008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck008
            #add-point:ON ACTION controlp INFIELD xcck008 name="construct.c.page1.xcck008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck009
            #add-point:BEFORE FIELD xcck009 name="construct.b.page1.xcck009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck009
            
            #add-point:AFTER FIELD xcck009 name="construct.a.page1.xcck009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck009
            #add-point:ON ACTION controlp INFIELD xcck009 name="construct.c.page1.xcck009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck013
            #add-point:BEFORE FIELD xcck013 name="construct.b.page1.xcck013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck013
            
            #add-point:AFTER FIELD xcck013 name="construct.a.page1.xcck013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck013
            #add-point:ON ACTION controlp INFIELD xcck013 name="construct.c.page1.xcck013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck010
            #add-point:BEFORE FIELD xcck010 name="construct.b.page1.xcck010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck010
            
            #add-point:AFTER FIELD xcck010 name="construct.a.page1.xcck010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck010
            #add-point:ON ACTION controlp INFIELD xcck010 name="construct.c.page1.xcck010"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_imaf001_15()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck010  #顯示到畫面上
            NEXT FIELD xcck010                     #返回原欄位
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xcck011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck011
            #add-point:ON ACTION controlp INFIELD xcck011 name="construct.c.page1.xcck011"
            #此段落由子樣板a08產生
            
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck011
            #add-point:BEFORE FIELD xcck011 name="construct.b.page1.xcck011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck011
            
            #add-point:AFTER FIELD xcck011 name="construct.a.page1.xcck011"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck047
            #add-point:BEFORE FIELD xcck047 name="construct.b.page1.xcck047"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck047
            
            #add-point:AFTER FIELD xcck047 name="construct.a.page1.xcck047"
            #開窗c段
            
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck047
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck047
            #add-point:ON ACTION controlp INFIELD xcck047 name="construct.c.page1.xcck047"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_sfec001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck047  #顯示到畫面上
            NEXT FIELD xcck047                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck015
            #add-point:BEFORE FIELD xcck015 name="construct.b.page1.xcck015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck015
            
            #add-point:AFTER FIELD xcck015 name="construct.a.page1.xcck015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck015
            #add-point:ON ACTION controlp INFIELD xcck015 name="construct.c.page1.xcck015"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_inaa001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck015  #顯示到畫面上
            NEXT FIELD xcck015                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck015_desc
            #add-point:BEFORE FIELD xcck015_desc name="construct.b.page1.xcck015_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck015_desc
            
            #add-point:AFTER FIELD xcck015_desc name="construct.a.page1.xcck015_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck015_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck015_desc
            #add-point:ON ACTION controlp INFIELD xcck015_desc name="construct.c.page1.xcck015_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck017
            #add-point:BEFORE FIELD xcck017 name="construct.b.page1.xcck017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck017
            
            #add-point:AFTER FIELD xcck017 name="construct.a.page1.xcck017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck017
            #add-point:ON ACTION controlp INFIELD xcck017 name="construct.c.page1.xcck017"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xcck044
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck044
            #add-point:ON ACTION controlp INFIELD xcck044 name="construct.c.page1.xcck044"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck044  #顯示到畫面上
            NEXT FIELD xcck044                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck044
            #add-point:BEFORE FIELD xcck044 name="construct.b.page1.xcck044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck044
            
            #add-point:AFTER FIELD xcck044 name="construct.a.page1.xcck044"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck201
            #add-point:BEFORE FIELD xcck201 name="construct.b.page1.xcck201"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck201
            
            #add-point:AFTER FIELD xcck201 name="construct.a.page1.xcck201"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck201
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck201
            #add-point:ON ACTION controlp INFIELD xcck201 name="construct.c.page1.xcck201"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck282a
            #add-point:BEFORE FIELD xcck282a name="construct.b.page1.xcck282a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck282a
            
            #add-point:AFTER FIELD xcck282a name="construct.a.page1.xcck282a"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck282a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck282a
            #add-point:ON ACTION controlp INFIELD xcck282a name="construct.c.page1.xcck282a"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck282b
            #add-point:BEFORE FIELD xcck282b name="construct.b.page1.xcck282b"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck282b
            
            #add-point:AFTER FIELD xcck282b name="construct.a.page1.xcck282b"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck282b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck282b
            #add-point:ON ACTION controlp INFIELD xcck282b name="construct.c.page1.xcck282b"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck282c
            #add-point:BEFORE FIELD xcck282c name="construct.b.page1.xcck282c"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck282c
            
            #add-point:AFTER FIELD xcck282c name="construct.a.page1.xcck282c"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck282c
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck282c
            #add-point:ON ACTION controlp INFIELD xcck282c name="construct.c.page1.xcck282c"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck282d
            #add-point:BEFORE FIELD xcck282d name="construct.b.page1.xcck282d"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck282d
            
            #add-point:AFTER FIELD xcck282d name="construct.a.page1.xcck282d"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck282d
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck282d
            #add-point:ON ACTION controlp INFIELD xcck282d name="construct.c.page1.xcck282d"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck282e
            #add-point:BEFORE FIELD xcck282e name="construct.b.page1.xcck282e"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck282e
            
            #add-point:AFTER FIELD xcck282e name="construct.a.page1.xcck282e"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck282e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck282e
            #add-point:ON ACTION controlp INFIELD xcck282e name="construct.c.page1.xcck282e"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck282f
            #add-point:BEFORE FIELD xcck282f name="construct.b.page1.xcck282f"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck282f
            
            #add-point:AFTER FIELD xcck282f name="construct.a.page1.xcck282f"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck282f
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck282f
            #add-point:ON ACTION controlp INFIELD xcck282f name="construct.c.page1.xcck282f"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck282g
            #add-point:BEFORE FIELD xcck282g name="construct.b.page1.xcck282g"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck282g
            
            #add-point:AFTER FIELD xcck282g name="construct.a.page1.xcck282g"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck282g
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck282g
            #add-point:ON ACTION controlp INFIELD xcck282g name="construct.c.page1.xcck282g"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck282h
            #add-point:BEFORE FIELD xcck282h name="construct.b.page1.xcck282h"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck282h
            
            #add-point:AFTER FIELD xcck282h name="construct.a.page1.xcck282h"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck282h
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck282h
            #add-point:ON ACTION controlp INFIELD xcck282h name="construct.c.page1.xcck282h"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck282
            #add-point:BEFORE FIELD xcck282 name="construct.b.page1.xcck282"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck282
            
            #add-point:AFTER FIELD xcck282 name="construct.a.page1.xcck282"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck282
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck282
            #add-point:ON ACTION controlp INFIELD xcck282 name="construct.c.page1.xcck282"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck202a
            #add-point:BEFORE FIELD xcck202a name="construct.b.page1.xcck202a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck202a
            
            #add-point:AFTER FIELD xcck202a name="construct.a.page1.xcck202a"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck202a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck202a
            #add-point:ON ACTION controlp INFIELD xcck202a name="construct.c.page1.xcck202a"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck202b
            #add-point:BEFORE FIELD xcck202b name="construct.b.page1.xcck202b"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck202b
            
            #add-point:AFTER FIELD xcck202b name="construct.a.page1.xcck202b"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck202b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck202b
            #add-point:ON ACTION controlp INFIELD xcck202b name="construct.c.page1.xcck202b"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck202c
            #add-point:BEFORE FIELD xcck202c name="construct.b.page1.xcck202c"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck202c
            
            #add-point:AFTER FIELD xcck202c name="construct.a.page1.xcck202c"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck202c
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck202c
            #add-point:ON ACTION controlp INFIELD xcck202c name="construct.c.page1.xcck202c"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck202d
            #add-point:BEFORE FIELD xcck202d name="construct.b.page1.xcck202d"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck202d
            
            #add-point:AFTER FIELD xcck202d name="construct.a.page1.xcck202d"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck202d
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck202d
            #add-point:ON ACTION controlp INFIELD xcck202d name="construct.c.page1.xcck202d"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck202e
            #add-point:BEFORE FIELD xcck202e name="construct.b.page1.xcck202e"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck202e
            
            #add-point:AFTER FIELD xcck202e name="construct.a.page1.xcck202e"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck202e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck202e
            #add-point:ON ACTION controlp INFIELD xcck202e name="construct.c.page1.xcck202e"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck202f
            #add-point:BEFORE FIELD xcck202f name="construct.b.page1.xcck202f"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck202f
            
            #add-point:AFTER FIELD xcck202f name="construct.a.page1.xcck202f"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck202f
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck202f
            #add-point:ON ACTION controlp INFIELD xcck202f name="construct.c.page1.xcck202f"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck202g
            #add-point:BEFORE FIELD xcck202g name="construct.b.page1.xcck202g"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck202g
            
            #add-point:AFTER FIELD xcck202g name="construct.a.page1.xcck202g"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck202g
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck202g
            #add-point:ON ACTION controlp INFIELD xcck202g name="construct.c.page1.xcck202g"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck202h
            #add-point:BEFORE FIELD xcck202h name="construct.b.page1.xcck202h"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck202h
            
            #add-point:AFTER FIELD xcck202h name="construct.a.page1.xcck202h"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck202h
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck202h
            #add-point:ON ACTION controlp INFIELD xcck202h name="construct.c.page1.xcck202h"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck202
            #add-point:BEFORE FIELD xcck202 name="construct.b.page1.xcck202"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck202
            
            #add-point:AFTER FIELD xcck202 name="construct.a.page1.xcck202"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck202
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck202
            #add-point:ON ACTION controlp INFIELD xcck202 name="construct.c.page1.xcck202"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
  
 
  
      #add-point:cs段more_construct name="cs.more_construct"
      INPUT BY NAME g_xcck_m.query_type 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂單頭ACTION
         
         
         BEFORE INPUT

         AFTER FIELD query_type
         IF g_xcck_m.query_type IS NOT NULL THEN
            LET g_query_type = g_xcck_m.query_type
         END IF


      END INPUT
      #fengmy150807---begin
      INPUT g_yy1,g_mm1,g_yy2,g_mm2 FROM xcck004,xcck005,xcck004_1,xcck005_1
         AFTER FIELD xcck004 
            IF NOT cl_null(g_yy1) AND NOT cl_null(g_yy2) THEN
                IF g_yy1 > g_yy2 THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'acr-00064'
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   NEXT FIELD xcck004
                END IF
             END IF
         AFTER FIELD xcck005
            IF NOT cl_null(g_mm1) AND NOT cl_null(g_mm2) THEN
               IF g_yy1 = g_yy2 AND 
                  g_mm1 > g_mm2 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'acr-00067'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD xcck005
               END IF
            END IF
         AFTER FIELD xcck004_1
            IF NOT cl_null(g_yy1) AND NOT cl_null(g_yy2) THEN
                IF g_yy1 > g_yy2 THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'acr-00064'
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   NEXT FIELD xcck004_1
                END IF
             END IF
         AFTER FIELD xcck005_1   
            IF NOT cl_null(g_mm1) AND NOT cl_null(g_mm2) THEN
               IF g_yy1 = g_yy2 AND 
                  g_mm1 > g_mm2 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'acr-00067'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD xcck005_1
               END IF
            END IF          
      END INPUT
      #fengmy150807---end
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:ui_dialog段b_dialog name="cs.before_dialog"
         IF g_xcck_m.query_type IS NULL THEN
            LET g_xcck_m.query_type = '1'
            LET g_query_type = g_xcck_m.query_type
         END IF
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
 
{<section id="axcq509.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION axcq509_query()
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
   CALL g_xcck_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL axcq509_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL axcq509_browser_fill(g_wc)
      CALL axcq509_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL axcq509_browser_fill("F")
   
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
      CALL axcq509_fetch("F") 
   END IF
   
   CALL axcq509_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="axcq509.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION axcq509_fetch(p_flag)
   #add-point:fetch段define name="fetch.define_customerization"
   
   #end add-point   
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="fetch.before_fetch"
   #fengmy150807---begin---跳开模板key:xcck004&xcck005
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
   
   #CALL axcq509_browser_fill(p_flag)
   
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
   
   LET g_xcck_m.xcckld = g_browser[g_current_idx].b_xcckld
   LET g_xcck_m.xcck001 = g_browser[g_current_idx].b_xcck001
   LET g_xcck_m.xcck003 = g_browser[g_current_idx].b_xcck003
   LET g_xcck_m.xcck004 = g_browser[g_current_idx].b_xcck004
   LET g_xcck_m.xcck005 = g_browser[g_current_idx].b_xcck005
 
   
   #重讀DB,因TEMP有不被更新特性
#fengmy150807---begin----去掉xcck004&xcck005  
   LET g_sql = " SELECT UNIQUE t0.xcckcomp,t0.xcck001,t0.xcckld,
       t0.xcck003,t1.ooefl003 ,t2.ooail003 ,t3.glaal002 ,t4.xcatl003",
               " FROM xcck_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent='"||g_enterprise||"' AND t1.ooefl001=t0.xcckcomp AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t2 ON t2.ooailent='"||g_enterprise||"' AND t2.ooail001=t0.xcck001 AND t2.ooail002='"||g_dlang||"' ",
               " LEFT JOIN glaal_t t3 ON t3.glaalent='"||g_enterprise||"' AND t3.glaalld=t0.xcckld AND t3.glaal001='"||g_dlang||"' ",
               " LEFT JOIN xcatl_t t4 ON t4.xcatlent='"||g_enterprise||"' AND t4.xcatl001=t0.xcck003 AND t4.xcatl002='"||g_dlang||"' ",
 
               " WHERE t0.xcckent = '" ||g_enterprise|| "' AND t0.xcckld = ? AND t0.xcck001 = ? AND t0.xcck003 = ? ",
               "   AND ",g_wc
               
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axcq509_master_referesh1 FROM g_sql
#fengmy150807---end----去掉xcck004&xcck005  
   EXECUTE axcq509_master_referesh1 USING g_xcck_m.xcckld,g_xcck_m.xcck001,g_xcck_m.xcck003
      INTO g_xcck_m.xcckcomp,g_xcck_m.xcck001,g_xcck_m.xcckld, 
       g_xcck_m.xcck003,g_xcck_m.xcckcomp_desc,g_xcck_m.xcck001_desc, 
       g_xcck_m.xcckld_desc,g_xcck_m.xcck003_desc
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcck_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_xcck_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_xcck_m_mask_o.* =  g_xcck_m.*
   CALL axcq509_xcck_t_mask()
   LET g_xcck_m_mask_n.* =  g_xcck_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axcq509_set_act_visible()
   CALL axcq509_set_act_no_visible()
 
   #保存單頭舊值
   LET g_xcck_m_t.* = g_xcck_m.*
   LET g_xcck_m_o.* = g_xcck_m.*
   
   #重新顯示   
   CALL axcq509_show()
   RETURN
   #fengmy150806---end---跳开模板key:xcck004&xcck005
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
   
   #CALL axcq509_browser_fill(p_flag)
   
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
   
   LET g_xcck_m.xcckld = g_browser[g_current_idx].b_xcckld
   LET g_xcck_m.xcck001 = g_browser[g_current_idx].b_xcck001
   LET g_xcck_m.xcck003 = g_browser[g_current_idx].b_xcck003
   LET g_xcck_m.xcck004 = g_browser[g_current_idx].b_xcck004
   LET g_xcck_m.xcck005 = g_browser[g_current_idx].b_xcck005
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE axcq509_master_referesh USING g_xcck_m.xcckld,g_xcck_m.xcck001,g_xcck_m.xcck003,g_xcck_m.xcck004, 
       g_xcck_m.xcck005 INTO g_xcck_m.xcckcomp,g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_m.xcck001,g_xcck_m.xcckld, 
       g_xcck_m.xcck003,g_xcck_m.xcckcomp_desc,g_xcck_m.xcck001_desc,g_xcck_m.xcckld_desc,g_xcck_m.xcck003_desc 
 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcck_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_xcck_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_xcck_m_mask_o.* =  g_xcck_m.*
   CALL axcq509_xcck_t_mask()
   LET g_xcck_m_mask_n.* =  g_xcck_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axcq509_set_act_visible()
   CALL axcq509_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_xcck_m_t.* = g_xcck_m.*
   LET g_xcck_m_o.* = g_xcck_m.*
   
   #重新顯示   
   CALL axcq509_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="axcq509.insert" >}
#+ 資料新增
PRIVATE FUNCTION axcq509_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_xcck_d.clear()
 
 
   INITIALIZE g_xcck_m.* TO NULL             #DEFAULT 設定
   LET g_xcckld_t = NULL
   LET g_xcck001_t = NULL
   LET g_xcck003_t = NULL
   LET g_xcck004_t = NULL
   LET g_xcck005_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
      
     
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point 
 
      CALL axcq509_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_xcck_m.* TO NULL
         INITIALIZE g_xcck_d TO NULL
 
         CALL axcq509_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_xcck_m.* = g_xcck_m_t.*
         CALL axcq509_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_xcck_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axcq509_set_act_visible()
   CALL axcq509_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_xcckld_t = g_xcck_m.xcckld
   LET g_xcck001_t = g_xcck_m.xcck001
   LET g_xcck003_t = g_xcck_m.xcck003
   LET g_xcck004_t = g_xcck_m.xcck004
   LET g_xcck005_t = g_xcck_m.xcck005
 
   
   #組合新增資料的條件
   LET g_add_browse = " xcckent = " ||g_enterprise|| " AND",
                      " xcckld = '", g_xcck_m.xcckld, "' "
                      ," AND xcck001 = '", g_xcck_m.xcck001, "' "
                      ," AND xcck003 = '", g_xcck_m.xcck003, "' "
                      ," AND xcck004 = '", g_xcck_m.xcck004, "' "
                      ," AND xcck005 = '", g_xcck_m.xcck005, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axcq509_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL axcq509_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE axcq509_master_referesh USING g_xcck_m.xcckld,g_xcck_m.xcck001,g_xcck_m.xcck003,g_xcck_m.xcck004, 
       g_xcck_m.xcck005 INTO g_xcck_m.xcckcomp,g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_m.xcck001,g_xcck_m.xcckld, 
       g_xcck_m.xcck003,g_xcck_m.xcckcomp_desc,g_xcck_m.xcck001_desc,g_xcck_m.xcckld_desc,g_xcck_m.xcck003_desc 
 
   
   #遮罩相關處理
   LET g_xcck_m_mask_o.* =  g_xcck_m.*
   CALL axcq509_xcck_t_mask()
   LET g_xcck_m_mask_n.* =  g_xcck_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_xcck_m.xcckcomp,g_xcck_m.xcckcomp_desc,g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_m.xcck001, 
       g_xcck_m.xcck001_desc,g_xcck_m.xcckld,g_xcck_m.xcckld_desc,g_xcck_m.xcck004_1,g_xcck_m.xcck005_1, 
       g_xcck_m.xcck003,g_xcck_m.xcck003_desc,g_xcck_m.query_type
   
   #功能已完成,通報訊息中心
   CALL axcq509_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="axcq509.modify" >}
#+ 資料修改
PRIVATE FUNCTION axcq509_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_xcck_m.xcckld IS NULL
   OR g_xcck_m.xcck001 IS NULL
   OR g_xcck_m.xcck003 IS NULL
   OR g_xcck_m.xcck004 IS NULL
   OR g_xcck_m.xcck005 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_xcckld_t = g_xcck_m.xcckld
   LET g_xcck001_t = g_xcck_m.xcck001
   LET g_xcck003_t = g_xcck_m.xcck003
   LET g_xcck004_t = g_xcck_m.xcck004
   LET g_xcck005_t = g_xcck_m.xcck005
 
   CALL s_transaction_begin()
   
   OPEN axcq509_cl USING g_enterprise,g_xcck_m.xcckld,g_xcck_m.xcck001,g_xcck_m.xcck003,g_xcck_m.xcck004,g_xcck_m.xcck005
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axcq509_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE axcq509_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axcq509_master_referesh USING g_xcck_m.xcckld,g_xcck_m.xcck001,g_xcck_m.xcck003,g_xcck_m.xcck004, 
       g_xcck_m.xcck005 INTO g_xcck_m.xcckcomp,g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_m.xcck001,g_xcck_m.xcckld, 
       g_xcck_m.xcck003,g_xcck_m.xcckcomp_desc,g_xcck_m.xcck001_desc,g_xcck_m.xcckld_desc,g_xcck_m.xcck003_desc 
 
   
   #遮罩相關處理
   LET g_xcck_m_mask_o.* =  g_xcck_m.*
   CALL axcq509_xcck_t_mask()
   LET g_xcck_m_mask_n.* =  g_xcck_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL axcq509_show()
   WHILE TRUE
      LET g_xcckld_t = g_xcck_m.xcckld
      LET g_xcck001_t = g_xcck_m.xcck001
      LET g_xcck003_t = g_xcck_m.xcck003
      LET g_xcck004_t = g_xcck_m.xcck004
      LET g_xcck005_t = g_xcck_m.xcck005
 
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL axcq509_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_xcck_m.* = g_xcck_m_t.*
         CALL axcq509_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_xcck_m.xcckld != g_xcckld_t 
      OR g_xcck_m.xcck001 != g_xcck001_t 
      OR g_xcck_m.xcck003 != g_xcck003_t 
      OR g_xcck_m.xcck004 != g_xcck004_t 
      OR g_xcck_m.xcck005 != g_xcck005_t 
 
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
   CALL axcq509_set_act_visible()
   CALL axcq509_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " xcckent = " ||g_enterprise|| " AND",
                      " xcckld = '", g_xcck_m.xcckld, "' "
                      ," AND xcck001 = '", g_xcck_m.xcck001, "' "
                      ," AND xcck003 = '", g_xcck_m.xcck003, "' "
                      ," AND xcck004 = '", g_xcck_m.xcck004, "' "
                      ," AND xcck005 = '", g_xcck_m.xcck005, "' "
 
   #填到對應位置
   CALL axcq509_browser_fill("")
 
   CALL axcq509_idx_chk()
 
   CLOSE axcq509_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL axcq509_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="axcq509.input" >}
#+ 資料輸入
PRIVATE FUNCTION axcq509_input(p_cmd)
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
   DISPLAY BY NAME g_xcck_m.xcckcomp,g_xcck_m.xcckcomp_desc,g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_m.xcck001, 
       g_xcck_m.xcck001_desc,g_xcck_m.xcckld,g_xcck_m.xcckld_desc,g_xcck_m.xcck004_1,g_xcck_m.xcck005_1, 
       g_xcck_m.xcck003,g_xcck_m.xcck003_desc,g_xcck_m.query_type
   
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
   LET g_forupd_sql = "SELECT xcck002,xcck025,xcck006,xcck007,xcck008,xcck009,xcck013,xcck010,xcck011, 
       xcck047,xcck015,xcck017,xcck044,xcck201,xcck282a,xcck282b,xcck282c,xcck282d,xcck282e,xcck282f, 
       xcck282g,xcck282h,xcck282,xcck202a,xcck202b,xcck202c,xcck202d,xcck202e,xcck202f,xcck202g,xcck202h, 
       xcck202 FROM xcck_t WHERE xcckent=? AND xcckld=? AND xcck001=? AND xcck003=? AND xcck004=? AND  
       xcck005=? AND xcck002=? AND xcck006=? AND xcck007=? AND xcck008=? AND xcck009=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axcq509_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL axcq509_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL axcq509_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_xcck_m.xcckcomp,g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_m.xcck001,g_xcck_m.xcckld, 
       g_xcck_m.xcck004_1,g_xcck_m.xcck005_1,g_xcck_m.xcck003,g_xcck_m.query_type
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="axcq509.input.head" >}
   
      #單頭段
      INPUT BY NAME g_xcck_m.xcckcomp,g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_m.xcck001,g_xcck_m.xcckld, 
          g_xcck_m.xcck004_1,g_xcck_m.xcck005_1,g_xcck_m.xcck003,g_xcck_m.query_type 
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
         AFTER FIELD xcckcomp
            
            #add-point:AFTER FIELD xcckcomp name="input.a.xcckcomp"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcck_m.xcckcomp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcck_m.xcckcomp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcck_m.xcckcomp_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcckcomp
            #add-point:BEFORE FIELD xcckcomp name="input.b.xcckcomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcckcomp
            #add-point:ON CHANGE xcckcomp name="input.g.xcckcomp"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck004
            #add-point:BEFORE FIELD xcck004 name="input.b.xcck004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck004
            
            #add-point:AFTER FIELD xcck004 name="input.a.xcck004"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xcck_m.xcckld) AND NOT cl_null(g_xcck_m.xcck001) AND NOT cl_null(g_xcck_m.xcck003) AND NOT cl_null(g_xcck_m.xcck004) AND NOT cl_null(g_xcck_m.xcck005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcck_m.xcckld != g_xcckld_t  OR g_xcck_m.xcck001 != g_xcck001_t  OR g_xcck_m.xcck003 != g_xcck003_t  OR g_xcck_m.xcck004 != g_xcck004_t  OR g_xcck_m.xcck005 != g_xcck005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcck_t WHERE "||"xcckent = '" ||g_enterprise|| "' AND "||"xcckld = '"||g_xcck_m.xcckld ||"' AND "|| "xcck001 = '"||g_xcck_m.xcck001 ||"' AND "|| "xcck003 = '"||g_xcck_m.xcck003 ||"' AND "|| "xcck004 = '"||g_xcck_m.xcck004 ||"' AND "|| "xcck005 = '"||g_xcck_m.xcck005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck004
            #add-point:ON CHANGE xcck004 name="input.g.xcck004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck005
            #add-point:BEFORE FIELD xcck005 name="input.b.xcck005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck005
            
            #add-point:AFTER FIELD xcck005 name="input.a.xcck005"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xcck_m.xcckld) AND NOT cl_null(g_xcck_m.xcck001) AND NOT cl_null(g_xcck_m.xcck003) AND NOT cl_null(g_xcck_m.xcck004) AND NOT cl_null(g_xcck_m.xcck005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcck_m.xcckld != g_xcckld_t  OR g_xcck_m.xcck001 != g_xcck001_t  OR g_xcck_m.xcck003 != g_xcck003_t  OR g_xcck_m.xcck004 != g_xcck004_t  OR g_xcck_m.xcck005 != g_xcck005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcck_t WHERE "||"xcckent = '" ||g_enterprise|| "' AND "||"xcckld = '"||g_xcck_m.xcckld ||"' AND "|| "xcck001 = '"||g_xcck_m.xcck001 ||"' AND "|| "xcck003 = '"||g_xcck_m.xcck003 ||"' AND "|| "xcck004 = '"||g_xcck_m.xcck004 ||"' AND "|| "xcck005 = '"||g_xcck_m.xcck005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck005
            #add-point:ON CHANGE xcck005 name="input.g.xcck005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck001
            
            #add-point:AFTER FIELD xcck001 name="input.a.xcck001"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcck_m.xcck001
            CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcck_m.xcck001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcck_m.xcck001_desc

            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xcck_m.xcckld) AND NOT cl_null(g_xcck_m.xcck001) AND NOT cl_null(g_xcck_m.xcck003) AND NOT cl_null(g_xcck_m.xcck004) AND NOT cl_null(g_xcck_m.xcck005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcck_m.xcckld != g_xcckld_t  OR g_xcck_m.xcck001 != g_xcck001_t  OR g_xcck_m.xcck003 != g_xcck003_t  OR g_xcck_m.xcck004 != g_xcck004_t  OR g_xcck_m.xcck005 != g_xcck005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcck_t WHERE "||"xcckent = '" ||g_enterprise|| "' AND "||"xcckld = '"||g_xcck_m.xcckld ||"' AND "|| "xcck001 = '"||g_xcck_m.xcck001 ||"' AND "|| "xcck003 = '"||g_xcck_m.xcck003 ||"' AND "|| "xcck004 = '"||g_xcck_m.xcck004 ||"' AND "|| "xcck005 = '"||g_xcck_m.xcck005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck001
            #add-point:BEFORE FIELD xcck001 name="input.b.xcck001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck001
            #add-point:ON CHANGE xcck001 name="input.g.xcck001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcckld
            
            #add-point:AFTER FIELD xcckld name="input.a.xcckld"
            IF NOT cl_null(g_xcck_m.xcckld) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xcck_m.xcckld
               #160318-00025#9--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
               #160318-00025#9--add--end
                  
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
            LET g_ref_fields[1] = g_xcck_m.xcckld
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcck_m.xcckld_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcck_m.xcckld_desc

            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xcck_m.xcckld) AND NOT cl_null(g_xcck_m.xcck001) AND NOT cl_null(g_xcck_m.xcck003) AND NOT cl_null(g_xcck_m.xcck004) AND NOT cl_null(g_xcck_m.xcck005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcck_m.xcckld != g_xcckld_t  OR g_xcck_m.xcck001 != g_xcck001_t  OR g_xcck_m.xcck003 != g_xcck003_t  OR g_xcck_m.xcck004 != g_xcck004_t  OR g_xcck_m.xcck005 != g_xcck005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcck_t WHERE "||"xcckent = '" ||g_enterprise|| "' AND "||"xcckld = '"||g_xcck_m.xcckld ||"' AND "|| "xcck001 = '"||g_xcck_m.xcck001 ||"' AND "|| "xcck003 = '"||g_xcck_m.xcck003 ||"' AND "|| "xcck004 = '"||g_xcck_m.xcck004 ||"' AND "|| "xcck005 = '"||g_xcck_m.xcck005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcckld
            #add-point:BEFORE FIELD xcckld name="input.b.xcckld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcckld
            #add-point:ON CHANGE xcckld name="input.g.xcckld"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck004_1
            #add-point:BEFORE FIELD xcck004_1 name="input.b.xcck004_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck004_1
            
            #add-point:AFTER FIELD xcck004_1 name="input.a.xcck004_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck004_1
            #add-point:ON CHANGE xcck004_1 name="input.g.xcck004_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck005_1
            #add-point:BEFORE FIELD xcck005_1 name="input.b.xcck005_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck005_1
            
            #add-point:AFTER FIELD xcck005_1 name="input.a.xcck005_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck005_1
            #add-point:ON CHANGE xcck005_1 name="input.g.xcck005_1"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck003
            
            #add-point:AFTER FIELD xcck003 name="input.a.xcck003"
            IF NOT cl_null(g_xcck_m.xcck003) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xcck_m.xcck003
               #160318-00025#9--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "agl-00195:sub-01302|axci100|",cl_get_progname("axci100",g_lang,"2"),"|:EXEPROGaxci100"
               #160318-00025#9--add--end
                  
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
            LET g_ref_fields[1] = g_xcck_m.xcck003
            CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcck_m.xcck003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcck_m.xcck003_desc

            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xcck_m.xcckld) AND NOT cl_null(g_xcck_m.xcck001) AND NOT cl_null(g_xcck_m.xcck003) AND NOT cl_null(g_xcck_m.xcck004) AND NOT cl_null(g_xcck_m.xcck005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcck_m.xcckld != g_xcckld_t  OR g_xcck_m.xcck001 != g_xcck001_t  OR g_xcck_m.xcck003 != g_xcck003_t  OR g_xcck_m.xcck004 != g_xcck004_t  OR g_xcck_m.xcck005 != g_xcck005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcck_t WHERE "||"xcckent = '" ||g_enterprise|| "' AND "||"xcckld = '"||g_xcck_m.xcckld ||"' AND "|| "xcck001 = '"||g_xcck_m.xcck001 ||"' AND "|| "xcck003 = '"||g_xcck_m.xcck003 ||"' AND "|| "xcck004 = '"||g_xcck_m.xcck004 ||"' AND "|| "xcck005 = '"||g_xcck_m.xcck005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck003
            #add-point:BEFORE FIELD xcck003 name="input.b.xcck003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck003
            #add-point:ON CHANGE xcck003 name="input.g.xcck003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD query_type
            #add-point:BEFORE FIELD query_type name="input.b.query_type"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD query_type
            
            #add-point:AFTER FIELD query_type name="input.a.query_type"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE query_type
            #add-point:ON CHANGE query_type name="input.g.query_type"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.xcckcomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcckcomp
            #add-point:ON ACTION controlp INFIELD xcckcomp name="input.c.xcckcomp"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcck004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck004
            #add-point:ON ACTION controlp INFIELD xcck004 name="input.c.xcck004"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcck005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck005
            #add-point:ON ACTION controlp INFIELD xcck005 name="input.c.xcck005"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcck001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck001
            #add-point:ON ACTION controlp INFIELD xcck001 name="input.c.xcck001"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcckld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcckld
            #add-point:ON ACTION controlp INFIELD xcckld name="input.c.xcckld"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcck_m.xcckld             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.arg2 = "" #
            
            CALL q_authorised_ld()                                #呼叫開窗

            LET g_xcck_m.xcckld = g_qryparam.return1              

            DISPLAY g_xcck_m.xcckld TO xcckld              #

            NEXT FIELD xcckld                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xcck004_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck004_1
            #add-point:ON ACTION controlp INFIELD xcck004_1 name="input.c.xcck004_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcck005_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck005_1
            #add-point:ON ACTION controlp INFIELD xcck005_1 name="input.c.xcck005_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcck003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck003
            #add-point:ON ACTION controlp INFIELD xcck003 name="input.c.xcck003"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcck_m.xcck003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_xcat001()                                #呼叫開窗

            LET g_xcck_m.xcck003 = g_qryparam.return1              

            DISPLAY g_xcck_m.xcck003 TO xcck003              #

            NEXT FIELD xcck003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.query_type
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD query_type
            #add-point:ON ACTION controlp INFIELD query_type name="input.c.query_type"
            
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
            DISPLAY BY NAME g_xcck_m.xcckld             
                            ,g_xcck_m.xcck001   
                            ,g_xcck_m.xcck003   
                            ,g_xcck_m.xcck004   
                            ,g_xcck_m.xcck005   
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
            
               #將遮罩欄位還原
               CALL axcq509_xcck_t_mask_restore('restore_mask_o')
            
               UPDATE xcck_t SET (xcckcomp,xcck004,xcck005,xcck001,xcckld,xcck003) = (g_xcck_m.xcckcomp, 
                   g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_m.xcck001,g_xcck_m.xcckld,g_xcck_m.xcck003) 
 
                WHERE xcckent = g_enterprise AND xcckld = g_xcckld_t
                  AND xcck001 = g_xcck001_t
                  AND xcck003 = g_xcck003_t
                  AND xcck004 = g_xcck004_t
                  AND xcck005 = g_xcck005_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcck_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcck_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xcck_m.xcckld
               LET gs_keys_bak[1] = g_xcckld_t
               LET gs_keys[2] = g_xcck_m.xcck001
               LET gs_keys_bak[2] = g_xcck001_t
               LET gs_keys[3] = g_xcck_m.xcck003
               LET gs_keys_bak[3] = g_xcck003_t
               LET gs_keys[4] = g_xcck_m.xcck004
               LET gs_keys_bak[4] = g_xcck004_t
               LET gs_keys[5] = g_xcck_m.xcck005
               LET gs_keys_bak[5] = g_xcck005_t
               LET gs_keys[6] = g_xcck_d[g_detail_idx].xcck002
               LET gs_keys_bak[6] = g_xcck_d_t.xcck002
               LET gs_keys[7] = g_xcck_d[g_detail_idx].xcck006
               LET gs_keys_bak[7] = g_xcck_d_t.xcck006
               LET gs_keys[8] = g_xcck_d[g_detail_idx].xcck007
               LET gs_keys_bak[8] = g_xcck_d_t.xcck007
               LET gs_keys[9] = g_xcck_d[g_detail_idx].xcck008
               LET gs_keys_bak[9] = g_xcck_d_t.xcck008
               LET gs_keys[10] = g_xcck_d[g_detail_idx].xcck009
               LET gs_keys_bak[10] = g_xcck_d_t.xcck009
               CALL axcq509_update_b('xcck_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_xcck_m_t)
                     #LET g_log2 = util.JSON.stringify(g_xcck_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL axcq509_xcck_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL axcq509_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_xcckld_t = g_xcck_m.xcckld
           LET g_xcck001_t = g_xcck_m.xcck001
           LET g_xcck003_t = g_xcck_m.xcck003
           LET g_xcck004_t = g_xcck_m.xcck004
           LET g_xcck005_t = g_xcck_m.xcck005
 
           
           IF g_xcck_d.getLength() = 0 THEN
              NEXT FIELD xcck002
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="axcq509.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_xcck_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xcck_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axcq509_b_fill(g_wc2) #test 
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
            CALL axcq509_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN axcq509_cl USING g_enterprise,g_xcck_m.xcckld,g_xcck_m.xcck001,g_xcck_m.xcck003,g_xcck_m.xcck004,g_xcck_m.xcck005                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE axcq509_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axcq509_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_xcck_d[l_ac].xcck002 IS NOT NULL
               AND g_xcck_d[l_ac].xcck006 IS NOT NULL
               AND g_xcck_d[l_ac].xcck007 IS NOT NULL
               AND g_xcck_d[l_ac].xcck008 IS NOT NULL
               AND g_xcck_d[l_ac].xcck009 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_xcck_d_t.* = g_xcck_d[l_ac].*  #BACKUP
               LET g_xcck_d_o.* = g_xcck_d[l_ac].*  #BACKUP
               CALL axcq509_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL axcq509_set_no_entry_b(l_cmd)
               OPEN axcq509_bcl USING g_enterprise,g_xcck_m.xcckld,
                                                g_xcck_m.xcck001,
                                                g_xcck_m.xcck003,
                                                g_xcck_m.xcck004,
                                                g_xcck_m.xcck005,
 
                                                g_xcck_d_t.xcck002
                                                ,g_xcck_d_t.xcck006
                                                ,g_xcck_d_t.xcck007
                                                ,g_xcck_d_t.xcck008
                                                ,g_xcck_d_t.xcck009
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axcq509_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axcq509_bcl INTO g_xcck_d[l_ac].xcck002,g_xcck_d[l_ac].xcck025,g_xcck_d[l_ac].xcck006, 
                      g_xcck_d[l_ac].xcck007,g_xcck_d[l_ac].xcck008,g_xcck_d[l_ac].xcck009,g_xcck_d[l_ac].xcck013, 
                      g_xcck_d[l_ac].xcck010,g_xcck_d[l_ac].xcck011,g_xcck_d[l_ac].xcck047,g_xcck_d[l_ac].xcck015, 
                      g_xcck_d[l_ac].xcck017,g_xcck_d[l_ac].xcck044,g_xcck_d[l_ac].xcck201,g_xcck_d[l_ac].xcck282a, 
                      g_xcck_d[l_ac].xcck282b,g_xcck_d[l_ac].xcck282c,g_xcck_d[l_ac].xcck282d,g_xcck_d[l_ac].xcck282e, 
                      g_xcck_d[l_ac].xcck282f,g_xcck_d[l_ac].xcck282g,g_xcck_d[l_ac].xcck282h,g_xcck_d[l_ac].xcck282, 
                      g_xcck_d[l_ac].xcck202a,g_xcck_d[l_ac].xcck202b,g_xcck_d[l_ac].xcck202c,g_xcck_d[l_ac].xcck202d, 
                      g_xcck_d[l_ac].xcck202e,g_xcck_d[l_ac].xcck202f,g_xcck_d[l_ac].xcck202g,g_xcck_d[l_ac].xcck202h, 
                      g_xcck_d[l_ac].xcck202
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_xcck_d_t.xcck002,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xcck_d_mask_o[l_ac].* =  g_xcck_d[l_ac].*
                  CALL axcq509_xcck_t_mask()
                  LET g_xcck_d_mask_n[l_ac].* =  g_xcck_d[l_ac].*
                  
                  CALL axcq509_ref_show()
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
            INITIALIZE g_xcck_d_t.* TO NULL
            INITIALIZE g_xcck_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xcck_d[l_ac].* TO NULL
            #公用欄位預設值
              
            #一般欄位預設值
            
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            
            #end add-point
            LET g_xcck_d_t.* = g_xcck_d[l_ac].*     #新輸入資料
            LET g_xcck_d_o.* = g_xcck_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axcq509_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL axcq509_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xcck_d[li_reproduce_target].* = g_xcck_d[li_reproduce].*
 
               LET g_xcck_d[g_xcck_d.getLength()].xcck002 = NULL
               LET g_xcck_d[g_xcck_d.getLength()].xcck006 = NULL
               LET g_xcck_d[g_xcck_d.getLength()].xcck007 = NULL
               LET g_xcck_d[g_xcck_d.getLength()].xcck008 = NULL
               LET g_xcck_d[g_xcck_d.getLength()].xcck009 = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM xcck_t 
             WHERE xcckent = g_enterprise AND xcckld = g_xcck_m.xcckld
               AND xcck001 = g_xcck_m.xcck001
               AND xcck003 = g_xcck_m.xcck003
               AND xcck004 = g_xcck_m.xcck004
               AND xcck005 = g_xcck_m.xcck005
 
               AND xcck002 = g_xcck_d[l_ac].xcck002
               AND xcck006 = g_xcck_d[l_ac].xcck006
               AND xcck007 = g_xcck_d[l_ac].xcck007
               AND xcck008 = g_xcck_d[l_ac].xcck008
               AND xcck009 = g_xcck_d[l_ac].xcck009
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
               INSERT INTO xcck_t
                           (xcckent,
                            xcckcomp,xcck004,xcck005,xcck001,xcckld,xcck003,
                            xcck002,xcck006,xcck007,xcck008,xcck009
                            ,xcck025,xcck013,xcck010,xcck011,xcck047,xcck015,xcck017,xcck044,xcck201,xcck282a,xcck282b,xcck282c,xcck282d,xcck282e,xcck282f,xcck282g,xcck282h,xcck282,xcck202a,xcck202b,xcck202c,xcck202d,xcck202e,xcck202f,xcck202g,xcck202h,xcck202) 
                     VALUES(g_enterprise,
                            g_xcck_m.xcckcomp,g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_m.xcck001,g_xcck_m.xcckld,g_xcck_m.xcck003,
                            g_xcck_d[l_ac].xcck002,g_xcck_d[l_ac].xcck006,g_xcck_d[l_ac].xcck007,g_xcck_d[l_ac].xcck008, 
                                g_xcck_d[l_ac].xcck009
                            ,g_xcck_d[l_ac].xcck025,g_xcck_d[l_ac].xcck013,g_xcck_d[l_ac].xcck010,g_xcck_d[l_ac].xcck011, 
                                g_xcck_d[l_ac].xcck047,g_xcck_d[l_ac].xcck015,g_xcck_d[l_ac].xcck017, 
                                g_xcck_d[l_ac].xcck044,g_xcck_d[l_ac].xcck201,g_xcck_d[l_ac].xcck282a, 
                                g_xcck_d[l_ac].xcck282b,g_xcck_d[l_ac].xcck282c,g_xcck_d[l_ac].xcck282d, 
                                g_xcck_d[l_ac].xcck282e,g_xcck_d[l_ac].xcck282f,g_xcck_d[l_ac].xcck282g, 
                                g_xcck_d[l_ac].xcck282h,g_xcck_d[l_ac].xcck282,g_xcck_d[l_ac].xcck202a, 
                                g_xcck_d[l_ac].xcck202b,g_xcck_d[l_ac].xcck202c,g_xcck_d[l_ac].xcck202d, 
                                g_xcck_d[l_ac].xcck202e,g_xcck_d[l_ac].xcck202f,g_xcck_d[l_ac].xcck202g, 
                                g_xcck_d[l_ac].xcck202h,g_xcck_d[l_ac].xcck202)
               #add-point:單身新增中 name="input.body.m_insert"
               
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_xcck_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "xcck_t:",SQLERRMESSAGE 
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
               IF axcq509_before_delete() THEN 
                  
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_xcck_m.xcckld
                  LET gs_keys[gs_keys.getLength()+1] = g_xcck_m.xcck001
                  LET gs_keys[gs_keys.getLength()+1] = g_xcck_m.xcck003
                  LET gs_keys[gs_keys.getLength()+1] = g_xcck_m.xcck004
                  LET gs_keys[gs_keys.getLength()+1] = g_xcck_m.xcck005
 
                  LET gs_keys[gs_keys.getLength()+1] = g_xcck_d_t.xcck002
                  LET gs_keys[gs_keys.getLength()+1] = g_xcck_d_t.xcck006
                  LET gs_keys[gs_keys.getLength()+1] = g_xcck_d_t.xcck007
                  LET gs_keys[gs_keys.getLength()+1] = g_xcck_d_t.xcck008
                  LET gs_keys[gs_keys.getLength()+1] = g_xcck_d_t.xcck009
 
 
                  #刪除下層單身
                  IF NOT axcq509_key_delete_b(gs_keys,'xcck_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE axcq509_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE axcq509_bcl
               LET l_count = g_xcck_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_xcck_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck002
            
            #add-point:AFTER FIELD xcck002 name="input.a.page1.xcck002"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcck_m.xcckld IS NOT NULL AND g_xcck_m.xcck001 IS NOT NULL AND g_xcck_m.xcck003 IS NOT NULL AND g_xcck_m.xcck004 IS NOT NULL AND g_xcck_m.xcck005 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck002 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck006 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck007 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck008 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck009 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcck_m.xcckld != g_xcckld_t OR g_xcck_m.xcck001 != g_xcck001_t OR g_xcck_m.xcck003 != g_xcck003_t OR g_xcck_m.xcck004 != g_xcck004_t OR g_xcck_m.xcck005 != g_xcck005_t OR g_xcck_d[g_detail_idx].xcck002 != g_xcck_d_t.xcck002 OR g_xcck_d[g_detail_idx].xcck006 != g_xcck_d_t.xcck006 OR g_xcck_d[g_detail_idx].xcck007 != g_xcck_d_t.xcck007 OR g_xcck_d[g_detail_idx].xcck008 != g_xcck_d_t.xcck008 OR g_xcck_d[g_detail_idx].xcck009 != g_xcck_d_t.xcck009)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcck_t WHERE "||"xcckent = '" ||g_enterprise|| "' AND "||"xcckld = '"||g_xcck_m.xcckld ||"' AND "|| "xcck001 = '"||g_xcck_m.xcck001 ||"' AND "|| "xcck003 = '"||g_xcck_m.xcck003 ||"' AND "|| "xcck004 = '"||g_xcck_m.xcck004 ||"' AND "|| "xcck005 = '"||g_xcck_m.xcck005 ||"' AND "|| "xcck002 = '"||g_xcck_d[g_detail_idx].xcck002 ||"' AND "|| "xcck006 = '"||g_xcck_d[g_detail_idx].xcck006 ||"' AND "|| "xcck007 = '"||g_xcck_d[g_detail_idx].xcck007 ||"' AND "|| "xcck008 = '"||g_xcck_d[g_detail_idx].xcck008 ||"' AND "|| "xcck009 = '"||g_xcck_d[g_detail_idx].xcck009 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcck_d[l_ac].xcck002
            CALL ap_ref_array2(g_ref_fields,"SELECT xcbfl003 FROM xcbfl_t WHERE xcbflent='"||g_enterprise||"' AND xcbfl001=? AND xcbfl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcck_d[l_ac].xcck002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcck_d[l_ac].xcck002_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck002
            #add-point:BEFORE FIELD xcck002 name="input.b.page1.xcck002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck002
            #add-point:ON CHANGE xcck002 name="input.g.page1.xcck002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck025
            
            #add-point:AFTER FIELD xcck025 name="input.a.page1.xcck025"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcck_d[l_ac].xcck025
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcck_d[l_ac].xcck025_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcck_d[l_ac].xcck025_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck025
            #add-point:BEFORE FIELD xcck025 name="input.b.page1.xcck025"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck025
            #add-point:ON CHANGE xcck025 name="input.g.page1.xcck025"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck006
            #add-point:BEFORE FIELD xcck006 name="input.b.page1.xcck006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck006
            
            #add-point:AFTER FIELD xcck006 name="input.a.page1.xcck006"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcck_m.xcckld IS NOT NULL AND g_xcck_m.xcck001 IS NOT NULL AND g_xcck_m.xcck003 IS NOT NULL AND g_xcck_m.xcck004 IS NOT NULL AND g_xcck_m.xcck005 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck002 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck006 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck007 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck008 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck009 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcck_m.xcckld != g_xcckld_t OR g_xcck_m.xcck001 != g_xcck001_t OR g_xcck_m.xcck003 != g_xcck003_t OR g_xcck_m.xcck004 != g_xcck004_t OR g_xcck_m.xcck005 != g_xcck005_t OR g_xcck_d[g_detail_idx].xcck002 != g_xcck_d_t.xcck002 OR g_xcck_d[g_detail_idx].xcck006 != g_xcck_d_t.xcck006 OR g_xcck_d[g_detail_idx].xcck007 != g_xcck_d_t.xcck007 OR g_xcck_d[g_detail_idx].xcck008 != g_xcck_d_t.xcck008 OR g_xcck_d[g_detail_idx].xcck009 != g_xcck_d_t.xcck009)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcck_t WHERE "||"xcckent = '" ||g_enterprise|| "' AND "||"xcckld = '"||g_xcck_m.xcckld ||"' AND "|| "xcck001 = '"||g_xcck_m.xcck001 ||"' AND "|| "xcck003 = '"||g_xcck_m.xcck003 ||"' AND "|| "xcck004 = '"||g_xcck_m.xcck004 ||"' AND "|| "xcck005 = '"||g_xcck_m.xcck005 ||"' AND "|| "xcck002 = '"||g_xcck_d[g_detail_idx].xcck002 ||"' AND "|| "xcck006 = '"||g_xcck_d[g_detail_idx].xcck006 ||"' AND "|| "xcck007 = '"||g_xcck_d[g_detail_idx].xcck007 ||"' AND "|| "xcck008 = '"||g_xcck_d[g_detail_idx].xcck008 ||"' AND "|| "xcck009 = '"||g_xcck_d[g_detail_idx].xcck009 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck006
            #add-point:ON CHANGE xcck006 name="input.g.page1.xcck006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck007
            #add-point:BEFORE FIELD xcck007 name="input.b.page1.xcck007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck007
            
            #add-point:AFTER FIELD xcck007 name="input.a.page1.xcck007"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcck_m.xcckld IS NOT NULL AND g_xcck_m.xcck001 IS NOT NULL AND g_xcck_m.xcck003 IS NOT NULL AND g_xcck_m.xcck004 IS NOT NULL AND g_xcck_m.xcck005 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck002 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck006 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck007 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck008 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck009 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcck_m.xcckld != g_xcckld_t OR g_xcck_m.xcck001 != g_xcck001_t OR g_xcck_m.xcck003 != g_xcck003_t OR g_xcck_m.xcck004 != g_xcck004_t OR g_xcck_m.xcck005 != g_xcck005_t OR g_xcck_d[g_detail_idx].xcck002 != g_xcck_d_t.xcck002 OR g_xcck_d[g_detail_idx].xcck006 != g_xcck_d_t.xcck006 OR g_xcck_d[g_detail_idx].xcck007 != g_xcck_d_t.xcck007 OR g_xcck_d[g_detail_idx].xcck008 != g_xcck_d_t.xcck008 OR g_xcck_d[g_detail_idx].xcck009 != g_xcck_d_t.xcck009)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcck_t WHERE "||"xcckent = '" ||g_enterprise|| "' AND "||"xcckld = '"||g_xcck_m.xcckld ||"' AND "|| "xcck001 = '"||g_xcck_m.xcck001 ||"' AND "|| "xcck003 = '"||g_xcck_m.xcck003 ||"' AND "|| "xcck004 = '"||g_xcck_m.xcck004 ||"' AND "|| "xcck005 = '"||g_xcck_m.xcck005 ||"' AND "|| "xcck002 = '"||g_xcck_d[g_detail_idx].xcck002 ||"' AND "|| "xcck006 = '"||g_xcck_d[g_detail_idx].xcck006 ||"' AND "|| "xcck007 = '"||g_xcck_d[g_detail_idx].xcck007 ||"' AND "|| "xcck008 = '"||g_xcck_d[g_detail_idx].xcck008 ||"' AND "|| "xcck009 = '"||g_xcck_d[g_detail_idx].xcck009 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck007
            #add-point:ON CHANGE xcck007 name="input.g.page1.xcck007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck008
            #add-point:BEFORE FIELD xcck008 name="input.b.page1.xcck008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck008
            
            #add-point:AFTER FIELD xcck008 name="input.a.page1.xcck008"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcck_m.xcckld IS NOT NULL AND g_xcck_m.xcck001 IS NOT NULL AND g_xcck_m.xcck003 IS NOT NULL AND g_xcck_m.xcck004 IS NOT NULL AND g_xcck_m.xcck005 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck002 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck006 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck007 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck008 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck009 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcck_m.xcckld != g_xcckld_t OR g_xcck_m.xcck001 != g_xcck001_t OR g_xcck_m.xcck003 != g_xcck003_t OR g_xcck_m.xcck004 != g_xcck004_t OR g_xcck_m.xcck005 != g_xcck005_t OR g_xcck_d[g_detail_idx].xcck002 != g_xcck_d_t.xcck002 OR g_xcck_d[g_detail_idx].xcck006 != g_xcck_d_t.xcck006 OR g_xcck_d[g_detail_idx].xcck007 != g_xcck_d_t.xcck007 OR g_xcck_d[g_detail_idx].xcck008 != g_xcck_d_t.xcck008 OR g_xcck_d[g_detail_idx].xcck009 != g_xcck_d_t.xcck009)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcck_t WHERE "||"xcckent = '" ||g_enterprise|| "' AND "||"xcckld = '"||g_xcck_m.xcckld ||"' AND "|| "xcck001 = '"||g_xcck_m.xcck001 ||"' AND "|| "xcck003 = '"||g_xcck_m.xcck003 ||"' AND "|| "xcck004 = '"||g_xcck_m.xcck004 ||"' AND "|| "xcck005 = '"||g_xcck_m.xcck005 ||"' AND "|| "xcck002 = '"||g_xcck_d[g_detail_idx].xcck002 ||"' AND "|| "xcck006 = '"||g_xcck_d[g_detail_idx].xcck006 ||"' AND "|| "xcck007 = '"||g_xcck_d[g_detail_idx].xcck007 ||"' AND "|| "xcck008 = '"||g_xcck_d[g_detail_idx].xcck008 ||"' AND "|| "xcck009 = '"||g_xcck_d[g_detail_idx].xcck009 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck008
            #add-point:ON CHANGE xcck008 name="input.g.page1.xcck008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck009
            #add-point:BEFORE FIELD xcck009 name="input.b.page1.xcck009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck009
            
            #add-point:AFTER FIELD xcck009 name="input.a.page1.xcck009"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcck_m.xcckld IS NOT NULL AND g_xcck_m.xcck001 IS NOT NULL AND g_xcck_m.xcck003 IS NOT NULL AND g_xcck_m.xcck004 IS NOT NULL AND g_xcck_m.xcck005 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck002 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck006 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck007 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck008 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck009 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcck_m.xcckld != g_xcckld_t OR g_xcck_m.xcck001 != g_xcck001_t OR g_xcck_m.xcck003 != g_xcck003_t OR g_xcck_m.xcck004 != g_xcck004_t OR g_xcck_m.xcck005 != g_xcck005_t OR g_xcck_d[g_detail_idx].xcck002 != g_xcck_d_t.xcck002 OR g_xcck_d[g_detail_idx].xcck006 != g_xcck_d_t.xcck006 OR g_xcck_d[g_detail_idx].xcck007 != g_xcck_d_t.xcck007 OR g_xcck_d[g_detail_idx].xcck008 != g_xcck_d_t.xcck008 OR g_xcck_d[g_detail_idx].xcck009 != g_xcck_d_t.xcck009)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcck_t WHERE "||"xcckent = '" ||g_enterprise|| "' AND "||"xcckld = '"||g_xcck_m.xcckld ||"' AND "|| "xcck001 = '"||g_xcck_m.xcck001 ||"' AND "|| "xcck003 = '"||g_xcck_m.xcck003 ||"' AND "|| "xcck004 = '"||g_xcck_m.xcck004 ||"' AND "|| "xcck005 = '"||g_xcck_m.xcck005 ||"' AND "|| "xcck002 = '"||g_xcck_d[g_detail_idx].xcck002 ||"' AND "|| "xcck006 = '"||g_xcck_d[g_detail_idx].xcck006 ||"' AND "|| "xcck007 = '"||g_xcck_d[g_detail_idx].xcck007 ||"' AND "|| "xcck008 = '"||g_xcck_d[g_detail_idx].xcck008 ||"' AND "|| "xcck009 = '"||g_xcck_d[g_detail_idx].xcck009 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck009
            #add-point:ON CHANGE xcck009 name="input.g.page1.xcck009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck013
            #add-point:BEFORE FIELD xcck013 name="input.b.page1.xcck013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck013
            
            #add-point:AFTER FIELD xcck013 name="input.a.page1.xcck013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck013
            #add-point:ON CHANGE xcck013 name="input.g.page1.xcck013"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck010
            
            #add-point:AFTER FIELD xcck010 name="input.a.page1.xcck010"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcck_d[l_ac].xcck010
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcck_d[l_ac].xcck010_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcck_d[l_ac].xcck010_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck010
            #add-point:BEFORE FIELD xcck010 name="input.b.page1.xcck010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck010
            #add-point:ON CHANGE xcck010 name="input.g.page1.xcck010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck011
            #add-point:BEFORE FIELD xcck011 name="input.b.page1.xcck011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck011
            
            #add-point:AFTER FIELD xcck011 name="input.a.page1.xcck011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck011
            #add-point:ON CHANGE xcck011 name="input.g.page1.xcck011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck047
            #add-point:BEFORE FIELD xcck047 name="input.b.page1.xcck047"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck047
            
            #add-point:AFTER FIELD xcck047 name="input.a.page1.xcck047"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck047
            #add-point:ON CHANGE xcck047 name="input.g.page1.xcck047"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck015
            
            #add-point:AFTER FIELD xcck015 name="input.a.page1.xcck015"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck015
            #add-point:BEFORE FIELD xcck015 name="input.b.page1.xcck015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck015
            #add-point:ON CHANGE xcck015 name="input.g.page1.xcck015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck015_desc
            #add-point:BEFORE FIELD xcck015_desc name="input.b.page1.xcck015_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck015_desc
            
            #add-point:AFTER FIELD xcck015_desc name="input.a.page1.xcck015_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck015_desc
            #add-point:ON CHANGE xcck015_desc name="input.g.page1.xcck015_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck017
            #add-point:BEFORE FIELD xcck017 name="input.b.page1.xcck017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck017
            
            #add-point:AFTER FIELD xcck017 name="input.a.page1.xcck017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck017
            #add-point:ON CHANGE xcck017 name="input.g.page1.xcck017"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck044
            
            #add-point:AFTER FIELD xcck044 name="input.a.page1.xcck044"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcck_d[l_ac].xcck044
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcck_d[l_ac].xcck044_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcck_d[l_ac].xcck044_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck044
            #add-point:BEFORE FIELD xcck044 name="input.b.page1.xcck044"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck044
            #add-point:ON CHANGE xcck044 name="input.g.page1.xcck044"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck201
            #add-point:BEFORE FIELD xcck201 name="input.b.page1.xcck201"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck201
            
            #add-point:AFTER FIELD xcck201 name="input.a.page1.xcck201"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck201
            #add-point:ON CHANGE xcck201 name="input.g.page1.xcck201"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck282a
            #add-point:BEFORE FIELD xcck282a name="input.b.page1.xcck282a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck282a
            
            #add-point:AFTER FIELD xcck282a name="input.a.page1.xcck282a"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck282a
            #add-point:ON CHANGE xcck282a name="input.g.page1.xcck282a"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck282b
            #add-point:BEFORE FIELD xcck282b name="input.b.page1.xcck282b"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck282b
            
            #add-point:AFTER FIELD xcck282b name="input.a.page1.xcck282b"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck282b
            #add-point:ON CHANGE xcck282b name="input.g.page1.xcck282b"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck282c
            #add-point:BEFORE FIELD xcck282c name="input.b.page1.xcck282c"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck282c
            
            #add-point:AFTER FIELD xcck282c name="input.a.page1.xcck282c"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck282c
            #add-point:ON CHANGE xcck282c name="input.g.page1.xcck282c"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck282d
            #add-point:BEFORE FIELD xcck282d name="input.b.page1.xcck282d"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck282d
            
            #add-point:AFTER FIELD xcck282d name="input.a.page1.xcck282d"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck282d
            #add-point:ON CHANGE xcck282d name="input.g.page1.xcck282d"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck282e
            #add-point:BEFORE FIELD xcck282e name="input.b.page1.xcck282e"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck282e
            
            #add-point:AFTER FIELD xcck282e name="input.a.page1.xcck282e"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck282e
            #add-point:ON CHANGE xcck282e name="input.g.page1.xcck282e"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck282f
            #add-point:BEFORE FIELD xcck282f name="input.b.page1.xcck282f"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck282f
            
            #add-point:AFTER FIELD xcck282f name="input.a.page1.xcck282f"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck282f
            #add-point:ON CHANGE xcck282f name="input.g.page1.xcck282f"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck282g
            #add-point:BEFORE FIELD xcck282g name="input.b.page1.xcck282g"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck282g
            
            #add-point:AFTER FIELD xcck282g name="input.a.page1.xcck282g"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck282g
            #add-point:ON CHANGE xcck282g name="input.g.page1.xcck282g"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck282h
            #add-point:BEFORE FIELD xcck282h name="input.b.page1.xcck282h"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck282h
            
            #add-point:AFTER FIELD xcck282h name="input.a.page1.xcck282h"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck282h
            #add-point:ON CHANGE xcck282h name="input.g.page1.xcck282h"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck282
            #add-point:BEFORE FIELD xcck282 name="input.b.page1.xcck282"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck282
            
            #add-point:AFTER FIELD xcck282 name="input.a.page1.xcck282"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck282
            #add-point:ON CHANGE xcck282 name="input.g.page1.xcck282"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck202a
            #add-point:BEFORE FIELD xcck202a name="input.b.page1.xcck202a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck202a
            
            #add-point:AFTER FIELD xcck202a name="input.a.page1.xcck202a"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck202a
            #add-point:ON CHANGE xcck202a name="input.g.page1.xcck202a"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck202b
            #add-point:BEFORE FIELD xcck202b name="input.b.page1.xcck202b"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck202b
            
            #add-point:AFTER FIELD xcck202b name="input.a.page1.xcck202b"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck202b
            #add-point:ON CHANGE xcck202b name="input.g.page1.xcck202b"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck202c
            #add-point:BEFORE FIELD xcck202c name="input.b.page1.xcck202c"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck202c
            
            #add-point:AFTER FIELD xcck202c name="input.a.page1.xcck202c"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck202c
            #add-point:ON CHANGE xcck202c name="input.g.page1.xcck202c"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck202d
            #add-point:BEFORE FIELD xcck202d name="input.b.page1.xcck202d"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck202d
            
            #add-point:AFTER FIELD xcck202d name="input.a.page1.xcck202d"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck202d
            #add-point:ON CHANGE xcck202d name="input.g.page1.xcck202d"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck202e
            #add-point:BEFORE FIELD xcck202e name="input.b.page1.xcck202e"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck202e
            
            #add-point:AFTER FIELD xcck202e name="input.a.page1.xcck202e"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck202e
            #add-point:ON CHANGE xcck202e name="input.g.page1.xcck202e"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck202f
            #add-point:BEFORE FIELD xcck202f name="input.b.page1.xcck202f"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck202f
            
            #add-point:AFTER FIELD xcck202f name="input.a.page1.xcck202f"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck202f
            #add-point:ON CHANGE xcck202f name="input.g.page1.xcck202f"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck202g
            #add-point:BEFORE FIELD xcck202g name="input.b.page1.xcck202g"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck202g
            
            #add-point:AFTER FIELD xcck202g name="input.a.page1.xcck202g"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck202g
            #add-point:ON CHANGE xcck202g name="input.g.page1.xcck202g"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck202h
            #add-point:BEFORE FIELD xcck202h name="input.b.page1.xcck202h"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck202h
            
            #add-point:AFTER FIELD xcck202h name="input.a.page1.xcck202h"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck202h
            #add-point:ON CHANGE xcck202h name="input.g.page1.xcck202h"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck202
            #add-point:BEFORE FIELD xcck202 name="input.b.page1.xcck202"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck202
            
            #add-point:AFTER FIELD xcck202 name="input.a.page1.xcck202"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck202
            #add-point:ON CHANGE xcck202 name="input.g.page1.xcck202"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.xcck002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck002
            #add-point:ON ACTION controlp INFIELD xcck002 name="input.c.page1.xcck002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck025
            #add-point:ON ACTION controlp INFIELD xcck025 name="input.c.page1.xcck025"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck006
            #add-point:ON ACTION controlp INFIELD xcck006 name="input.c.page1.xcck006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck007
            #add-point:ON ACTION controlp INFIELD xcck007 name="input.c.page1.xcck007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck008
            #add-point:ON ACTION controlp INFIELD xcck008 name="input.c.page1.xcck008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck009
            #add-point:ON ACTION controlp INFIELD xcck009 name="input.c.page1.xcck009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck013
            #add-point:ON ACTION controlp INFIELD xcck013 name="input.c.page1.xcck013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck010
            #add-point:ON ACTION controlp INFIELD xcck010 name="input.c.page1.xcck010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck011
            #add-point:ON ACTION controlp INFIELD xcck011 name="input.c.page1.xcck011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck047
            #add-point:ON ACTION controlp INFIELD xcck047 name="input.c.page1.xcck047"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck015
            #add-point:ON ACTION controlp INFIELD xcck015 name="input.c.page1.xcck015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck015_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck015_desc
            #add-point:ON ACTION controlp INFIELD xcck015_desc name="input.c.page1.xcck015_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck017
            #add-point:ON ACTION controlp INFIELD xcck017 name="input.c.page1.xcck017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck044
            #add-point:ON ACTION controlp INFIELD xcck044 name="input.c.page1.xcck044"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck201
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck201
            #add-point:ON ACTION controlp INFIELD xcck201 name="input.c.page1.xcck201"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck282a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck282a
            #add-point:ON ACTION controlp INFIELD xcck282a name="input.c.page1.xcck282a"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck282b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck282b
            #add-point:ON ACTION controlp INFIELD xcck282b name="input.c.page1.xcck282b"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck282c
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck282c
            #add-point:ON ACTION controlp INFIELD xcck282c name="input.c.page1.xcck282c"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck282d
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck282d
            #add-point:ON ACTION controlp INFIELD xcck282d name="input.c.page1.xcck282d"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck282e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck282e
            #add-point:ON ACTION controlp INFIELD xcck282e name="input.c.page1.xcck282e"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck282f
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck282f
            #add-point:ON ACTION controlp INFIELD xcck282f name="input.c.page1.xcck282f"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck282g
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck282g
            #add-point:ON ACTION controlp INFIELD xcck282g name="input.c.page1.xcck282g"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck282h
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck282h
            #add-point:ON ACTION controlp INFIELD xcck282h name="input.c.page1.xcck282h"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck282
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck282
            #add-point:ON ACTION controlp INFIELD xcck282 name="input.c.page1.xcck282"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck202a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck202a
            #add-point:ON ACTION controlp INFIELD xcck202a name="input.c.page1.xcck202a"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck202b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck202b
            #add-point:ON ACTION controlp INFIELD xcck202b name="input.c.page1.xcck202b"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck202c
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck202c
            #add-point:ON ACTION controlp INFIELD xcck202c name="input.c.page1.xcck202c"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck202d
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck202d
            #add-point:ON ACTION controlp INFIELD xcck202d name="input.c.page1.xcck202d"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck202e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck202e
            #add-point:ON ACTION controlp INFIELD xcck202e name="input.c.page1.xcck202e"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck202f
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck202f
            #add-point:ON ACTION controlp INFIELD xcck202f name="input.c.page1.xcck202f"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck202g
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck202g
            #add-point:ON ACTION controlp INFIELD xcck202g name="input.c.page1.xcck202g"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck202h
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck202h
            #add-point:ON ACTION controlp INFIELD xcck202h name="input.c.page1.xcck202h"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck202
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck202
            #add-point:ON ACTION controlp INFIELD xcck202 name="input.c.page1.xcck202"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_xcck_d[l_ac].* = g_xcck_d_t.*
               CLOSE axcq509_bcl
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
               LET g_errparam.extend = g_xcck_d[l_ac].xcck002 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_xcck_d[l_ac].* = g_xcck_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
         
               #將遮罩欄位還原
               CALL axcq509_xcck_t_mask_restore('restore_mask_o')
         
               UPDATE xcck_t SET (xcckld,xcck001,xcck003,xcck004,xcck005,xcck002,xcck025,xcck006,xcck007, 
                   xcck008,xcck009,xcck013,xcck010,xcck011,xcck047,xcck015,xcck017,xcck044,xcck201,xcck282a, 
                   xcck282b,xcck282c,xcck282d,xcck282e,xcck282f,xcck282g,xcck282h,xcck282,xcck202a,xcck202b, 
                   xcck202c,xcck202d,xcck202e,xcck202f,xcck202g,xcck202h,xcck202) = (g_xcck_m.xcckld, 
                   g_xcck_m.xcck001,g_xcck_m.xcck003,g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_d[l_ac].xcck002, 
                   g_xcck_d[l_ac].xcck025,g_xcck_d[l_ac].xcck006,g_xcck_d[l_ac].xcck007,g_xcck_d[l_ac].xcck008, 
                   g_xcck_d[l_ac].xcck009,g_xcck_d[l_ac].xcck013,g_xcck_d[l_ac].xcck010,g_xcck_d[l_ac].xcck011, 
                   g_xcck_d[l_ac].xcck047,g_xcck_d[l_ac].xcck015,g_xcck_d[l_ac].xcck017,g_xcck_d[l_ac].xcck044, 
                   g_xcck_d[l_ac].xcck201,g_xcck_d[l_ac].xcck282a,g_xcck_d[l_ac].xcck282b,g_xcck_d[l_ac].xcck282c, 
                   g_xcck_d[l_ac].xcck282d,g_xcck_d[l_ac].xcck282e,g_xcck_d[l_ac].xcck282f,g_xcck_d[l_ac].xcck282g, 
                   g_xcck_d[l_ac].xcck282h,g_xcck_d[l_ac].xcck282,g_xcck_d[l_ac].xcck202a,g_xcck_d[l_ac].xcck202b, 
                   g_xcck_d[l_ac].xcck202c,g_xcck_d[l_ac].xcck202d,g_xcck_d[l_ac].xcck202e,g_xcck_d[l_ac].xcck202f, 
                   g_xcck_d[l_ac].xcck202g,g_xcck_d[l_ac].xcck202h,g_xcck_d[l_ac].xcck202)
                WHERE xcckent = g_enterprise AND xcckld = g_xcck_m.xcckld 
                 AND xcck001 = g_xcck_m.xcck001 
                 AND xcck003 = g_xcck_m.xcck003 
                 AND xcck004 = g_xcck_m.xcck004 
                 AND xcck005 = g_xcck_m.xcck005 
 
                 AND xcck002 = g_xcck_d_t.xcck002 #項次   
                 AND xcck006 = g_xcck_d_t.xcck006  
                 AND xcck007 = g_xcck_d_t.xcck007  
                 AND xcck008 = g_xcck_d_t.xcck008  
                 AND xcck009 = g_xcck_d_t.xcck009  
 
                 
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcck_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "xcck_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xcck_m.xcckld
               LET gs_keys_bak[1] = g_xcckld_t
               LET gs_keys[2] = g_xcck_m.xcck001
               LET gs_keys_bak[2] = g_xcck001_t
               LET gs_keys[3] = g_xcck_m.xcck003
               LET gs_keys_bak[3] = g_xcck003_t
               LET gs_keys[4] = g_xcck_m.xcck004
               LET gs_keys_bak[4] = g_xcck004_t
               LET gs_keys[5] = g_xcck_m.xcck005
               LET gs_keys_bak[5] = g_xcck005_t
               LET gs_keys[6] = g_xcck_d[g_detail_idx].xcck002
               LET gs_keys_bak[6] = g_xcck_d_t.xcck002
               LET gs_keys[7] = g_xcck_d[g_detail_idx].xcck006
               LET gs_keys_bak[7] = g_xcck_d_t.xcck006
               LET gs_keys[8] = g_xcck_d[g_detail_idx].xcck007
               LET gs_keys_bak[8] = g_xcck_d_t.xcck007
               LET gs_keys[9] = g_xcck_d[g_detail_idx].xcck008
               LET gs_keys_bak[9] = g_xcck_d_t.xcck008
               LET gs_keys[10] = g_xcck_d[g_detail_idx].xcck009
               LET gs_keys_bak[10] = g_xcck_d_t.xcck009
               CALL axcq509_update_b('xcck_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_xcck_m),util.JSON.stringify(g_xcck_d_t)
                     LET g_log2 = util.JSON.stringify(g_xcck_m),util.JSON.stringify(g_xcck_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL axcq509_xcck_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_xcck_m.xcckld
               LET ls_keys[ls_keys.getLength()+1] = g_xcck_m.xcck001
               LET ls_keys[ls_keys.getLength()+1] = g_xcck_m.xcck003
               LET ls_keys[ls_keys.getLength()+1] = g_xcck_m.xcck004
               LET ls_keys[ls_keys.getLength()+1] = g_xcck_m.xcck005
 
               LET ls_keys[ls_keys.getLength()+1] = g_xcck_d_t.xcck002
               LET ls_keys[ls_keys.getLength()+1] = g_xcck_d_t.xcck006
               LET ls_keys[ls_keys.getLength()+1] = g_xcck_d_t.xcck007
               LET ls_keys[ls_keys.getLength()+1] = g_xcck_d_t.xcck008
               LET ls_keys[ls_keys.getLength()+1] = g_xcck_d_t.xcck009
 
               CALL axcq509_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE axcq509_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xcck_d[l_ac].* = g_xcck_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE axcq509_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_xcck_d.getLength() = 0 THEN
               NEXT FIELD xcck002
            END IF
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_xcck_d[li_reproduce_target].* = g_xcck_d[li_reproduce].*
 
               LET g_xcck_d[li_reproduce_target].xcck002 = NULL
               LET g_xcck_d[li_reproduce_target].xcck006 = NULL
               LET g_xcck_d[li_reproduce_target].xcck007 = NULL
               LET g_xcck_d[li_reproduce_target].xcck008 = NULL
               LET g_xcck_d[li_reproduce_target].xcck009 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_xcck_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xcck_d.getLength()+1
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
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD xcckld
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD xcck002
 
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
 
 
   
   #add-point:input段after_input name="input.after_input"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axcq509.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION axcq509_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE l_glaa001 LIKE glaa_t.glaa001
   DEFINE l_glaa016 LIKE glaa_t.glaa016
   DEFINE l_glaa020 LIKE glaa_t.glaa020
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   #fengmy 150109----begin
   #根據參數顯示隱藏成本域 和 料件特性
   IF cl_null(g_xcck_m.xcckcomp) THEN
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data1   #采用成本域否       
   ELSE
      CALL cl_get_para(g_enterprise,g_xcck_m.xcckcomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
      CALL cl_get_para(g_enterprise,g_xcck_m.xcckcomp,'S-FIN-6013') RETURNING g_para_data1   #采用成本域否       
   END IF
              
   IF g_para_data = 'Y' THEN
      CALL cl_set_comp_visible('xcck002,xcck002_desc',TRUE)                    
   ELSE
      CALL cl_set_comp_visible('xcck002,xcck002_desc',FALSE)                
   END IF  
   IF g_para_data1 = 'Y' THEN
      CALL cl_set_comp_visible('xcck011,xcck011_desc',TRUE)                    
   ELSE
      CALL cl_set_comp_visible('xcck011,xcck011_desc',FALSE)                
   END IF   
   #fengmy 150109----end
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL axcq509_b_fill(g_wc2) #第一階單身填充
      CALL axcq509_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL axcq509_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   SELECT glaa001,glaa016,glaa020 INTO l_glaa001,l_glaa016,l_glaa020
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_xcck_m.xcckld
      
      
   CASE g_xcck_m.xcck001
      WHEN '1' 
        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = l_glaa001
        CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
        LET g_xcck_m.xcck001_desc = '', g_rtn_fields[1] , ''                  
      WHEN '2'
        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = l_glaa016
        CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
        LET g_xcck_m.xcck001_desc = '', g_rtn_fields[1] , ''
      WHEN '3'
        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = l_glaa020
        CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
        LET g_xcck_m.xcck001_desc = '', g_rtn_fields[1] , ''
   END CASE                             
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_xcck_m.xcckcomp,g_xcck_m.xcckcomp_desc,g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_m.xcck001, 
       g_xcck_m.xcck001_desc,g_xcck_m.xcckld,g_xcck_m.xcckld_desc,g_xcck_m.xcck004_1,g_xcck_m.xcck005_1, 
       g_xcck_m.xcck003,g_xcck_m.xcck003_desc,g_xcck_m.query_type
 
   CALL axcq509_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
   IF g_query_type IS NOT NULL AND g_xcck_m.query_type IS NULL THEN
      DISPLAY g_query_type TO query_type
   END IF
   #fengmy150806----begin
   DISPLAY g_yy1 TO xcck004
   DISPLAY g_mm1 TO xcck005
   DISPLAY g_yy2 TO xcck004_1
   DISPLAY g_mm2 TO xcck005_1
   #fengmy150806----end
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="axcq509.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION axcq509_ref_show()
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
   FOR l_ac = 1 TO g_xcck_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"
 
      #end add-point
   END FOR
   
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="axcq509.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION axcq509_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE xcck_t.xcckld 
   DEFINE l_oldno     LIKE xcck_t.xcckld 
   DEFINE l_newno02     LIKE xcck_t.xcck001 
   DEFINE l_oldno02     LIKE xcck_t.xcck001 
   DEFINE l_newno03     LIKE xcck_t.xcck003 
   DEFINE l_oldno03     LIKE xcck_t.xcck003 
   DEFINE l_newno04     LIKE xcck_t.xcck004 
   DEFINE l_oldno04     LIKE xcck_t.xcck004 
   DEFINE l_newno05     LIKE xcck_t.xcck005 
   DEFINE l_oldno05     LIKE xcck_t.xcck005 
 
   DEFINE l_master    RECORD LIKE xcck_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE xcck_t.* #此變數樣板目前無使用
 
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
 
   IF g_xcck_m.xcckld IS NULL
      OR g_xcck_m.xcck001 IS NULL
      OR g_xcck_m.xcck003 IS NULL
      OR g_xcck_m.xcck004 IS NULL
      OR g_xcck_m.xcck005 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_xcckld_t = g_xcck_m.xcckld
   LET g_xcck001_t = g_xcck_m.xcck001
   LET g_xcck003_t = g_xcck_m.xcck003
   LET g_xcck004_t = g_xcck_m.xcck004
   LET g_xcck005_t = g_xcck_m.xcck005
 
   
   LET g_xcck_m.xcckld = ""
   LET g_xcck_m.xcck001 = ""
   LET g_xcck_m.xcck003 = ""
   LET g_xcck_m.xcck004 = ""
   LET g_xcck_m.xcck005 = ""
 
   LET g_master_insert = FALSE
   CALL axcq509_set_entry('a')
   CALL axcq509_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #清空key欄位的desc
      LET g_xcck_m.xcck001_desc = ''
   DISPLAY BY NAME g_xcck_m.xcck001_desc
   LET g_xcck_m.xcckld_desc = ''
   DISPLAY BY NAME g_xcck_m.xcckld_desc
   LET g_xcck_m.xcck003_desc = ''
   DISPLAY BY NAME g_xcck_m.xcck003_desc
 
   
   CALL axcq509_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_xcck_m.* TO NULL
      INITIALIZE g_xcck_d TO NULL
 
      CALL axcq509_show()
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
   CALL axcq509_set_act_visible()
   CALL axcq509_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_xcckld_t = g_xcck_m.xcckld
   LET g_xcck001_t = g_xcck_m.xcck001
   LET g_xcck003_t = g_xcck_m.xcck003
   LET g_xcck004_t = g_xcck_m.xcck004
   LET g_xcck005_t = g_xcck_m.xcck005
 
   
   #組合新增資料的條件
   LET g_add_browse = " xcckent = " ||g_enterprise|| " AND",
                      " xcckld = '", g_xcck_m.xcckld, "' "
                      ," AND xcck001 = '", g_xcck_m.xcck001, "' "
                      ," AND xcck003 = '", g_xcck_m.xcck003, "' "
                      ," AND xcck004 = '", g_xcck_m.xcck004, "' "
                      ," AND xcck005 = '", g_xcck_m.xcck005, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axcq509_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL axcq509_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL axcq509_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="axcq509.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION axcq509_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE xcck_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE axcq509_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xcck_t
    WHERE xcckent = g_enterprise AND xcckld = g_xcckld_t
    AND xcck001 = g_xcck001_t
    AND xcck003 = g_xcck003_t
    AND xcck004 = g_xcck004_t
    AND xcck005 = g_xcck005_t
 
       INTO TEMP axcq509_detail
   
   #將key修正為調整後   
   UPDATE axcq509_detail 
      #更新key欄位
      SET xcckld = g_xcck_m.xcckld
          , xcck001 = g_xcck_m.xcck001
          , xcck003 = g_xcck_m.xcck003
          , xcck004 = g_xcck_m.xcck004
          , xcck005 = g_xcck_m.xcck005
 
      #更新共用欄位
      
                                       
   #將資料塞回原table   
   INSERT INTO xcck_t SELECT * FROM axcq509_detail
   
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
   DROP TABLE axcq509_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_xcckld_t = g_xcck_m.xcckld
   LET g_xcck001_t = g_xcck_m.xcck001
   LET g_xcck003_t = g_xcck_m.xcck003
   LET g_xcck004_t = g_xcck_m.xcck004
   LET g_xcck005_t = g_xcck_m.xcck005
 
   
   DROP TABLE axcq509_detail
   
END FUNCTION
 
{</section>}
 
{<section id="axcq509.delete" >}
#+ 資料刪除
PRIVATE FUNCTION axcq509_delete()
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
   
   IF g_xcck_m.xcckld IS NULL
   OR g_xcck_m.xcck001 IS NULL
   OR g_xcck_m.xcck003 IS NULL
   OR g_xcck_m.xcck004 IS NULL
   OR g_xcck_m.xcck005 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN axcq509_cl USING g_enterprise,g_xcck_m.xcckld,g_xcck_m.xcck001,g_xcck_m.xcck003,g_xcck_m.xcck004,g_xcck_m.xcck005
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axcq509_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE axcq509_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axcq509_master_referesh USING g_xcck_m.xcckld,g_xcck_m.xcck001,g_xcck_m.xcck003,g_xcck_m.xcck004, 
       g_xcck_m.xcck005 INTO g_xcck_m.xcckcomp,g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_m.xcck001,g_xcck_m.xcckld, 
       g_xcck_m.xcck003,g_xcck_m.xcckcomp_desc,g_xcck_m.xcck001_desc,g_xcck_m.xcckld_desc,g_xcck_m.xcck003_desc 
 
   
   #遮罩相關處理
   LET g_xcck_m_mask_o.* =  g_xcck_m.*
   CALL axcq509_xcck_t_mask()
   LET g_xcck_m_mask_n.* =  g_xcck_m.*
   
   CALL axcq509_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL axcq509_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM xcck_t WHERE xcckent = g_enterprise AND xcckld = g_xcck_m.xcckld
                                                               AND xcck001 = g_xcck_m.xcck001
                                                               AND xcck003 = g_xcck_m.xcck003
                                                               AND xcck004 = g_xcck_m.xcck004
                                                               AND xcck005 = g_xcck_m.xcck005
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xcck_t:",SQLERRMESSAGE 
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
      #   CLOSE axcq509_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_xcck_d.clear() 
 
     
      CALL axcq509_ui_browser_refresh()  
      #CALL axcq509_ui_headershow()  
      #CALL axcq509_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL axcq509_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL axcq509_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE axcq509_cl
 
   #功能已完成,通報訊息中心
   CALL axcq509_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="axcq509.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axcq509_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_sql             STRING
   DEFINE l_xcck202a_sum     LIKE xcck_t.xcck202a
   DEFINE l_xcck202b_sum     LIKE xcck_t.xcck202b
   DEFINE l_xcck202c_sum     LIKE xcck_t.xcck202c
   DEFINE l_xcck202d_sum     LIKE xcck_t.xcck202d
   DEFINE l_xcck202e_sum     LIKE xcck_t.xcck202e
   DEFINE l_xcck202f_sum     LIKE xcck_t.xcck202f
   DEFINE l_xcck202g_sum     LIKE xcck_t.xcck202g
   DEFINE l_xcck202h_sum     LIKE xcck_t.xcck202h
   DEFINE l_xcck202_sum      LIKE xcck_t.xcck202
   DEFINE l_xcck202a_total   LIKE xcck_t.xcck202a
   DEFINE l_xcck202b_total   LIKE xcck_t.xcck202b
   DEFINE l_xcck202c_total   LIKE xcck_t.xcck202c
   DEFINE l_xcck202d_total   LIKE xcck_t.xcck202d
   DEFINE l_xcck202e_total   LIKE xcck_t.xcck202e
   DEFINE l_xcck202f_total   LIKE xcck_t.xcck202f
   DEFINE l_xcck202g_total   LIKE xcck_t.xcck202g
   DEFINE l_xcck202h_total   LIKE xcck_t.xcck202h
   DEFINE l_xcck202_total    LIKE xcck_t.xcck202
   DEFINE l_wc2_table1_t     STRING #151130-00003#8   151130   By earl add
   #160411-00040#1  By Ann_Huang  --- add Start ---
   DEFINE l_xcck202a_2     LIKE xcck_t.xcck202a
   DEFINE l_xcck202b_2     LIKE xcck_t.xcck202b
   DEFINE l_xcck202c_2     LIKE xcck_t.xcck202c
   DEFINE l_xcck202d_2     LIKE xcck_t.xcck202d
   DEFINE l_xcck202e_2     LIKE xcck_t.xcck202e
   DEFINE l_xcck202f_2     LIKE xcck_t.xcck202f
   DEFINE l_xcck202g_2     LIKE xcck_t.xcck202g
   DEFINE l_xcck202h_2     LIKE xcck_t.xcck202h
   DEFINE l_xcck202_2      LIKE xcck_t.xcck202
   #160411-00040#1  By Ann_Huang  --- add End ---
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #先清空單身變數內容
   CALL g_xcck_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"

   #151130-00003#8   151130   By earl add s
   LET l_wc2_table1_t = g_wc2_table1
   IF NOT cl_null(g_wc_filter) THEN
      IF cl_null(g_wc2_table1) THEN
         LET g_wc2_table1 = g_wc_filter
      ELSE
         LET g_wc2_table1 = g_wc2_table1," AND ",g_wc_filter
      END IF
   END IF
   #151130-00003#8   151130   By earl add e

   #fengmy150806----begin
   CALL axcq509_b_fill_1(p_wc2)
   LET g_wc2_table1 = l_wc2_table1_t #151130-00003#8   151130   By earl add
   RETURN
   #fengmy150806----end
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT xcck002,xcck025,xcck006,xcck007,xcck008,xcck009,xcck013,xcck010,xcck011, 
       xcck047,xcck015,xcck017,xcck044,xcck201,xcck282a,xcck282b,xcck282c,xcck282d,xcck282e,xcck282f, 
       xcck282g,xcck282h,xcck282,xcck202a,xcck202b,xcck202c,xcck202d,xcck202e,xcck202f,xcck202g,xcck202h, 
       xcck202,t1.xcbfl003 ,t2.ooefl003 ,t3.imaal003 ,t5.oocal003 FROM xcck_t",   
               "",
               
                              " LEFT JOIN xcbfl_t t1 ON t1.xcbflent="||g_enterprise||" AND t1.xcbfl001=xcck002 AND t1.xcbfl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=xcck025 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t3 ON t3.imaalent="||g_enterprise||" AND t3.imaal001=xcck010 AND t3.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t5 ON t5.oocalent="||g_enterprise||" AND t5.oocal001=xcck044 AND t5.oocal002='"||g_dlang||"' ",
 
               " WHERE xcckent= ? AND xcckld=? AND xcck001=? AND xcck003=? AND xcck004=? AND xcck005=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xcck_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   CASE g_query_type
     WHEN '1'    #一般工单
        LET g_wc_xcck055 = " xcck055 IN('205') "
     WHEN '2'    #返工工单    
        LET g_wc_xcck055 = " xcck055 = '209' "
     WHEN '3'    #拆件工单     
#        LET g_wc_xcck055 = " xcck055 IN('2052') "   #wujie 150301 去掉205   #fengmy150514 mark
        LET g_wc_xcck055 = " xcck020 IN('106','113') "   #fengmy150514  
     WHEN '9'    #全部       
#        LET g_wc_xcck055 = " xcck055 IN('205','209','2051','2052') "   #150109 fengmy mark 去拆件
        LET g_wc_xcck055 = " xcck055 IN('205','209')  "   #150109 fengmy
     OTHERWISE 
#        LET g_wc_xcck055 = " xcck055 IN('205','209','2051','2052') "   #150109 fengmy mark
        LET g_wc_xcck055 = " xcck055 IN('205','209')  "   #150109 fengmy
   END CASE

   LET g_sql = g_sql," AND ",g_wc_xcck055
   LET l_sql = g_sql
   
   LET g_sql_tmp=g_sql   #wangxina 150327 add
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF axcq509_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY xcck_t.xcck002,xcck_t.xcck006,xcck_t.xcck007,xcck_t.xcck008,xcck_t.xcck009"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
      LET g_sql = l_sql, " ORDER BY xcck_t.xcck002,xcck_t.xcck025,xcck_t.xcck006,xcck_t.xcck007,xcck_t.xcck008,xcck_t.xcck009"
      LET l_xcck202a_sum = 0
      LET l_xcck202b_sum = 0
      LET l_xcck202c_sum = 0
      LET l_xcck202d_sum = 0
      LET l_xcck202e_sum = 0
      LET l_xcck202f_sum = 0
      LET l_xcck202g_sum = 0
      LET l_xcck202h_sum = 0
      LET l_xcck202_sum  = 0
      LET l_xcck202a_total = 0
      LET l_xcck202b_total = 0
      LET l_xcck202c_total = 0
      LET l_xcck202d_total = 0
      LET l_xcck202e_total = 0
      LET l_xcck202f_total = 0
      LET l_xcck202g_total = 0
      LET l_xcck202h_total = 0
      LET l_xcck202_total  = 0
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axcq509_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR axcq509_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_xcck_m.xcckld,g_xcck_m.xcck001,g_xcck_m.xcck003,g_xcck_m.xcck004,g_xcck_m.xcck005   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_xcck_m.xcckld,g_xcck_m.xcck001,g_xcck_m.xcck003,g_xcck_m.xcck004, 
          g_xcck_m.xcck005 INTO g_xcck_d[l_ac].xcck002,g_xcck_d[l_ac].xcck025,g_xcck_d[l_ac].xcck006, 
          g_xcck_d[l_ac].xcck007,g_xcck_d[l_ac].xcck008,g_xcck_d[l_ac].xcck009,g_xcck_d[l_ac].xcck013, 
          g_xcck_d[l_ac].xcck010,g_xcck_d[l_ac].xcck011,g_xcck_d[l_ac].xcck047,g_xcck_d[l_ac].xcck015, 
          g_xcck_d[l_ac].xcck017,g_xcck_d[l_ac].xcck044,g_xcck_d[l_ac].xcck201,g_xcck_d[l_ac].xcck282a, 
          g_xcck_d[l_ac].xcck282b,g_xcck_d[l_ac].xcck282c,g_xcck_d[l_ac].xcck282d,g_xcck_d[l_ac].xcck282e, 
          g_xcck_d[l_ac].xcck282f,g_xcck_d[l_ac].xcck282g,g_xcck_d[l_ac].xcck282h,g_xcck_d[l_ac].xcck282, 
          g_xcck_d[l_ac].xcck202a,g_xcck_d[l_ac].xcck202b,g_xcck_d[l_ac].xcck202c,g_xcck_d[l_ac].xcck202d, 
          g_xcck_d[l_ac].xcck202e,g_xcck_d[l_ac].xcck202f,g_xcck_d[l_ac].xcck202g,g_xcck_d[l_ac].xcck202h, 
          g_xcck_d[l_ac].xcck202,g_xcck_d[l_ac].xcck002_desc,g_xcck_d[l_ac].xcck025_desc,g_xcck_d[l_ac].xcck010_desc, 
          g_xcck_d[l_ac].xcck044_desc   #(ver:49)
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充 name="b_fill.fill"
         #160411-00040#1  By Ann_Huang  --- add Start ---
         IF cl_null(g_xcck_d[l_ac].xcck282a) THEN  LET g_xcck_d[l_ac].xcck282a = 0  END IF
         IF cl_null(g_xcck_d[l_ac].xcck282b) THEN  LET g_xcck_d[l_ac].xcck282b = 0  END IF
         IF cl_null(g_xcck_d[l_ac].xcck282c) THEN  LET g_xcck_d[l_ac].xcck282c = 0  END IF
         IF cl_null(g_xcck_d[l_ac].xcck282d) THEN  LET g_xcck_d[l_ac].xcck282d = 0  END IF
         IF cl_null(g_xcck_d[l_ac].xcck282e) THEN  LET g_xcck_d[l_ac].xcck282e = 0  END IF
         IF cl_null(g_xcck_d[l_ac].xcck282f) THEN  LET g_xcck_d[l_ac].xcck282f = 0  END IF
         IF cl_null(g_xcck_d[l_ac].xcck282g) THEN  LET g_xcck_d[l_ac].xcck282g = 0  END IF
         IF cl_null(g_xcck_d[l_ac].xcck282h) THEN  LET g_xcck_d[l_ac].xcck282h = 0  END IF
         IF cl_null(g_xcck_d[l_ac].xcck282 ) THEN  LET g_xcck_d[l_ac].xcck282  = 0  END IF
         
         IF cl_null(g_xcck_d[l_ac].xcck202a) THEN  LET g_xcck_d[l_ac].xcck202a = 0  END IF
         IF cl_null(g_xcck_d[l_ac].xcck202b) THEN  LET g_xcck_d[l_ac].xcck202b = 0  END IF
         IF cl_null(g_xcck_d[l_ac].xcck202c) THEN  LET g_xcck_d[l_ac].xcck202c = 0  END IF
         IF cl_null(g_xcck_d[l_ac].xcck202d) THEN  LET g_xcck_d[l_ac].xcck202d = 0  END IF
         IF cl_null(g_xcck_d[l_ac].xcck202e) THEN  LET g_xcck_d[l_ac].xcck202e = 0  END IF
         IF cl_null(g_xcck_d[l_ac].xcck202f) THEN  LET g_xcck_d[l_ac].xcck202f = 0  END IF
         IF cl_null(g_xcck_d[l_ac].xcck202g) THEN  LET g_xcck_d[l_ac].xcck202g = 0  END IF
         IF cl_null(g_xcck_d[l_ac].xcck202h) THEN  LET g_xcck_d[l_ac].xcck202h = 0  END IF
         IF cl_null(g_xcck_d[l_ac].xcck202 ) THEN  LET g_xcck_d[l_ac].xcck202  = 0  END IF         
         #160411-00040#1  By Ann_Huang  --- add End ---
         
         LET g_xcck_d[l_ac].xcck202a = g_xcck_d[l_ac].xcck202a * g_xcck_d[l_ac].xcck009
         LET g_xcck_d[l_ac].xcck202b = g_xcck_d[l_ac].xcck202b * g_xcck_d[l_ac].xcck009
         LET g_xcck_d[l_ac].xcck202c = g_xcck_d[l_ac].xcck202c * g_xcck_d[l_ac].xcck009
         LET g_xcck_d[l_ac].xcck202d = g_xcck_d[l_ac].xcck202d * g_xcck_d[l_ac].xcck009
         LET g_xcck_d[l_ac].xcck202e = g_xcck_d[l_ac].xcck202e * g_xcck_d[l_ac].xcck009
         LET g_xcck_d[l_ac].xcck202f = g_xcck_d[l_ac].xcck202f * g_xcck_d[l_ac].xcck009
         LET g_xcck_d[l_ac].xcck202g = g_xcck_d[l_ac].xcck202g * g_xcck_d[l_ac].xcck009
         LET g_xcck_d[l_ac].xcck202h = g_xcck_d[l_ac].xcck202h * g_xcck_d[l_ac].xcck009
         LET g_xcck_d[l_ac].xcck202  = g_xcck_d[l_ac].xcck202  * g_xcck_d[l_ac].xcck009

#成本分群
         SELECT imag011,oocql004 INTO g_xcck_d[l_ac].imag011,g_xcck_d[l_ac].imag011_desc 
           FROM imag_t
           LEFT OUTER JOIN oocql_t ON imagent  = oocqlent AND oocql001 = '206' AND oocql002 = imag011 AND oocql003 = g_dlang
          WHERE imagent  = g_enterprise 
            AND imagsite = g_xcck_m.xcckcomp 
            AND imag001  = g_xcck_d[l_ac].xcck010
            
         CALL s_desc_get_stock_desc(g_site,g_xcck_d[l_ac].xcck015) RETURNING g_xcck_d[l_ac].xcck015_desc
   
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_xcck_d[l_ac].xcck010
         CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_xcck_d[l_ac].xcck010_desc = '', g_rtn_fields[1] , ''
         LET g_xcck_d[l_ac].xcck010_desc_1 = '', g_rtn_fields[2] , ''
          
         CALL s_desc_get_unit_desc(g_xcck_d[l_ac].xcck044) RETURNING g_xcck_d[l_ac].xcck044_desc
         
         #依成本域、成本中心小计
         LET l_xcck202a_sum = l_xcck202a_sum + g_xcck_d[l_ac].xcck202a
         LET l_xcck202b_sum = l_xcck202b_sum + g_xcck_d[l_ac].xcck202b
         LET l_xcck202c_sum = l_xcck202c_sum + g_xcck_d[l_ac].xcck202c
         LET l_xcck202d_sum = l_xcck202d_sum + g_xcck_d[l_ac].xcck202d
         LET l_xcck202e_sum = l_xcck202e_sum + g_xcck_d[l_ac].xcck202e
         LET l_xcck202f_sum = l_xcck202f_sum + g_xcck_d[l_ac].xcck202f
         LET l_xcck202g_sum = l_xcck202g_sum + g_xcck_d[l_ac].xcck202g
         LET l_xcck202h_sum = l_xcck202h_sum + g_xcck_d[l_ac].xcck202h
         LET l_xcck202_sum  = l_xcck202_sum  + g_xcck_d[l_ac].xcck202
         LET l_xcck202a_total = l_xcck202a_total + g_xcck_d[l_ac].xcck202a
         LET l_xcck202b_total = l_xcck202b_total + g_xcck_d[l_ac].xcck202b
         LET l_xcck202c_total = l_xcck202c_total + g_xcck_d[l_ac].xcck202c
         LET l_xcck202d_total = l_xcck202d_total + g_xcck_d[l_ac].xcck202d
         LET l_xcck202e_total = l_xcck202e_total + g_xcck_d[l_ac].xcck202e
         LET l_xcck202f_total = l_xcck202f_total + g_xcck_d[l_ac].xcck202f
         LET l_xcck202g_total = l_xcck202g_total + g_xcck_d[l_ac].xcck202g
         LET l_xcck202h_total = l_xcck202h_total + g_xcck_d[l_ac].xcck202h
         LET l_xcck202_total  = l_xcck202_total  + g_xcck_d[l_ac].xcck202
         IF l_ac > 1 THEN
           IF g_xcck_d[l_ac].xcck002 != g_xcck_d[l_ac - 1].xcck002 OR g_xcck_d[l_ac].xcck025 != g_xcck_d[l_ac - 1].xcck025 THEN                  
               #把当前行下移，并在当前行显示小计
               LET g_xcck_d[l_ac + 1].* = g_xcck_d[l_ac].*  
               INITIALIZE  g_xcck_d[l_ac].* TO NULL           
               #fengmy 150109 modify--begin
               #LET g_xcck_d[l_ac].xcck002 = cl_getmsg("axc-00205",g_lang)
               CALL cl_get_para(g_enterprise,g_xcck_m.xcckcomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
               IF g_para_data = 'Y' THEN
                  LET g_xcck_d[l_ac].xcck002 = cl_getmsg("axc-00205",g_lang)               
               ELSE
                  LET g_xcck_d[l_ac].xcck025 = cl_getmsg("axc-00205",g_lang) 
               END IF      
               #fengmy 150109 modify--begin
               
               #160411-00040#1  By Ann_Huang  --- add Start ---
               #處理NULL
               LET l_xcck202a_2 = g_xcck_d[l_ac + 1].xcck202a
               LET l_xcck202b_2 = g_xcck_d[l_ac + 1].xcck202b
               LET l_xcck202c_2 = g_xcck_d[l_ac + 1].xcck202c
               LET l_xcck202d_2 = g_xcck_d[l_ac + 1].xcck202d
               LET l_xcck202e_2 = g_xcck_d[l_ac + 1].xcck202e
               LET l_xcck202f_2 = g_xcck_d[l_ac + 1].xcck202f
               LET l_xcck202g_2 = g_xcck_d[l_ac + 1].xcck202g
               LET l_xcck202h_2 = g_xcck_d[l_ac + 1].xcck202h
               LET l_xcck202_2  = g_xcck_d[l_ac + 1].xcck202
               
               IF cl_null(l_xcck202a_2) THEN  LET l_xcck202a_2 = 0  END IF
               IF cl_null(l_xcck202b_2) THEN  LET l_xcck202b_2 = 0  END IF
               IF cl_null(l_xcck202c_2) THEN  LET l_xcck202c_2 = 0  END IF
               IF cl_null(l_xcck202d_2) THEN  LET l_xcck202d_2 = 0  END IF
               IF cl_null(l_xcck202e_2) THEN  LET l_xcck202e_2 = 0  END IF
               IF cl_null(l_xcck202f_2) THEN  LET l_xcck202f_2 = 0  END IF
               IF cl_null(l_xcck202g_2) THEN  LET l_xcck202g_2 = 0  END IF
               IF cl_null(l_xcck202h_2) THEN  LET l_xcck202h_2 = 0  END IF
               IF cl_null(l_xcck202_2)  THEN  LET l_xcck202_2 = 0   END IF
               #160411-00040#1  By Ann_Huang  --- add End ---
               
               #160411-00040#1  By Ann_Huang  --- mark Start ---
               #LET g_xcck_d[l_ac].xcck202a = l_xcck202a_sum - g_xcck_d[l_ac + 1].xcck202a
               #LET g_xcck_d[l_ac].xcck202b = l_xcck202b_sum - g_xcck_d[l_ac + 1].xcck202b
               #LET g_xcck_d[l_ac].xcck202c = l_xcck202c_sum - g_xcck_d[l_ac + 1].xcck202c
               #LET g_xcck_d[l_ac].xcck202d = l_xcck202d_sum - g_xcck_d[l_ac + 1].xcck202d
               #LET g_xcck_d[l_ac].xcck202e = l_xcck202e_sum - g_xcck_d[l_ac + 1].xcck202e
               #LET g_xcck_d[l_ac].xcck202f = l_xcck202f_sum - g_xcck_d[l_ac + 1].xcck202f
               #LET g_xcck_d[l_ac].xcck202g = l_xcck202g_sum - g_xcck_d[l_ac + 1].xcck202g
               #LET g_xcck_d[l_ac].xcck202h = l_xcck202h_sum - g_xcck_d[l_ac + 1].xcck202h
               #LET g_xcck_d[l_ac].xcck202  = l_xcck202_sum  - g_xcck_d[l_ac + 1].xcck202
               ##160411-00040#1  By Ann_Huang  --- mark End ---
               #160411-00040#1  By Ann_Huang  --- add Start ---
               LET g_xcck_d[l_ac].xcck202a = l_xcck202a_sum - l_xcck202a_2
               LET g_xcck_d[l_ac].xcck202b = l_xcck202b_sum - l_xcck202b_2
               LET g_xcck_d[l_ac].xcck202c = l_xcck202c_sum - l_xcck202c_2
               LET g_xcck_d[l_ac].xcck202d = l_xcck202d_sum - l_xcck202d_2
               LET g_xcck_d[l_ac].xcck202e = l_xcck202e_sum - l_xcck202e_2
               LET g_xcck_d[l_ac].xcck202f = l_xcck202f_sum - l_xcck202f_2
               LET g_xcck_d[l_ac].xcck202g = l_xcck202g_sum - l_xcck202g_2
               LET g_xcck_d[l_ac].xcck202h = l_xcck202h_sum - l_xcck202h_2
               LET g_xcck_d[l_ac].xcck202  = l_xcck202_sum  - l_xcck202_2
               #160411-00040#1  By Ann_Huang  --- add End ---
               LET l_ac = l_ac + 1
               LET l_xcck202a_sum = g_xcck_d[l_ac].xcck202a
               LET l_xcck202b_sum = g_xcck_d[l_ac].xcck202b
               LET l_xcck202c_sum = g_xcck_d[l_ac].xcck202c
               LET l_xcck202d_sum = g_xcck_d[l_ac].xcck202d
               LET l_xcck202e_sum = g_xcck_d[l_ac].xcck202e
               LET l_xcck202f_sum = g_xcck_d[l_ac].xcck202f
               LET l_xcck202g_sum = g_xcck_d[l_ac].xcck202g
               LET l_xcck202h_sum = g_xcck_d[l_ac].xcck202h
               LET l_xcck202_sum  = g_xcck_d[l_ac].xcck202
            END IF
         END IF
               
         #end add-point
      
         #帶出公用欄位reference值
         
         
 
        
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
 
            CALL g_xcck_d.deleteElement(g_xcck_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
   #最后一组小计     
#fengmy 150109 modify--begin
#  LET g_xcck_d[l_ac].xcck002 = cl_getmsg("axc-00205",g_lang)
   CALL cl_get_para(g_enterprise,g_xcck_m.xcckcomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
   IF g_para_data = 'Y' THEN
      LET g_xcck_d[l_ac].xcck002 = cl_getmsg("axc-00205",g_lang)     
   ELSE
      LET g_xcck_d[l_ac].xcck025 = cl_getmsg("axc-00205",g_lang)         
   END IF
##fengmy 150109 modify--begin  
   LET g_xcck_d[l_ac].xcck202a = l_xcck202a_sum
   LET g_xcck_d[l_ac].xcck202b = l_xcck202b_sum
   LET g_xcck_d[l_ac].xcck202c = l_xcck202c_sum
   LET g_xcck_d[l_ac].xcck202d = l_xcck202d_sum
   LET g_xcck_d[l_ac].xcck202e = l_xcck202e_sum
   LET g_xcck_d[l_ac].xcck202f = l_xcck202f_sum
   LET g_xcck_d[l_ac].xcck202g = l_xcck202g_sum
   LET g_xcck_d[l_ac].xcck202h = l_xcck202h_sum
   LET g_xcck_d[l_ac].xcck202  = l_xcck202_sum
   LET l_ac = l_ac + 1
   #合计

#fengmy 150109 modify--begin
#  LET g_xcck_d[l_ac].xcck002 = cl_getmsg("axc-00204",g_lang)
   CALL cl_get_para(g_enterprise,g_xcck_m.xcckcomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
   IF g_para_data = 'Y' THEN
      LET g_xcck_d[l_ac].xcck002 = cl_getmsg("axc-00204",g_lang)                    
   ELSE
      LET g_xcck_d[l_ac].xcck025 = cl_getmsg("axc-00204",g_lang)                
   END IF
#fengmy 150109 modify--begin 
   LET g_xcck_d[l_ac].xcck202a = l_xcck202a_total
   LET g_xcck_d[l_ac].xcck202b = l_xcck202b_total
   LET g_xcck_d[l_ac].xcck202c = l_xcck202c_total
   LET g_xcck_d[l_ac].xcck202d = l_xcck202d_total
   LET g_xcck_d[l_ac].xcck202e = l_xcck202e_total
   LET g_xcck_d[l_ac].xcck202f = l_xcck202f_total
   LET g_xcck_d[l_ac].xcck202g = l_xcck202g_total
   LET g_xcck_d[l_ac].xcck202h = l_xcck202h_total
   LET g_xcck_d[l_ac].xcck202  = l_xcck202_total
   LET l_ac = l_ac + 1
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_xcck_d.getLength()
      LET g_xcck_d_mask_o[l_ac].* =  g_xcck_d[l_ac].*
      CALL axcq509_xcck_t_mask()
      LET g_xcck_d_mask_n[l_ac].* =  g_xcck_d[l_ac].*
   END FOR
   
 
 
   FREE axcq509_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="axcq509.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION axcq509_idx_chk()
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
      IF g_detail_idx > g_xcck_d.getLength() THEN
         LET g_detail_idx = g_xcck_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_xcck_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xcck_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axcq509.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axcq509_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
 
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_xcck_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
 
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="axcq509.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION axcq509_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   
   #end add-point
   
   DELETE FROM xcck_t
    WHERE xcckent = g_enterprise AND xcckld = g_xcck_m.xcckld AND
                              xcck001 = g_xcck_m.xcck001 AND
                              xcck003 = g_xcck_m.xcck003 AND
                              xcck004 = g_xcck_m.xcck004 AND
                              xcck005 = g_xcck_m.xcck005 AND
 
          xcck002 = g_xcck_d_t.xcck002
      AND xcck006 = g_xcck_d_t.xcck006
      AND xcck007 = g_xcck_d_t.xcck007
      AND xcck008 = g_xcck_d_t.xcck008
      AND xcck009 = g_xcck_d_t.xcck009
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcck_t:",SQLERRMESSAGE 
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
 
{<section id="axcq509.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION axcq509_delete_b(ps_table,ps_keys_bak,ps_page)
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
 
{<section id="axcq509.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION axcq509_insert_b(ps_table,ps_keys,ps_page)
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
 
{<section id="axcq509.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION axcq509_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
 
{<section id="axcq509.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION axcq509_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_xcck_d[l_ac].xcck002 = g_xcck_d_t.xcck002 
      AND g_xcck_d[l_ac].xcck006 = g_xcck_d_t.xcck006 
      AND g_xcck_d[l_ac].xcck007 = g_xcck_d_t.xcck007 
      AND g_xcck_d[l_ac].xcck008 = g_xcck_d_t.xcck008 
      AND g_xcck_d[l_ac].xcck009 = g_xcck_d_t.xcck009 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="axcq509.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION axcq509_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="axcq509.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION axcq509_lock_b(ps_table,ps_page)
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
   #CALL axcq509_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axcq509.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION axcq509_unlock_b(ps_table,ps_page)
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
 
{<section id="axcq509.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION axcq509_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("xcckld,xcck001,xcck003,xcck004,xcck005",TRUE)
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
 
{<section id="axcq509.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION axcq509_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("xcckld,xcck001,xcck003,xcck004,xcck005",FALSE)
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
 
{<section id="axcq509.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION axcq509_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axcq509.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION axcq509_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="axcq509.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION axcq509_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq509.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION axcq509_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq509.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION axcq509_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq509.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION axcq509_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq509.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION axcq509_default_search()
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
      LET ls_wc = ls_wc, " xcckld = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " xcck001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " xcck003 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " xcck004 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET ls_wc = ls_wc, " xcck005 = '", g_argv[05], "' AND "
   END IF
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   #160113-00011#1-add----(S)
   #法人組織
   IF NOT cl_null(g_argv[06]) THEN
      LET ls_wc = ls_wc, " xcckcomp = '", g_argv[06], "' AND "
   END IF
   #料號
   IF NOT cl_null(g_argv[07]) THEN
      LET ls_wc = ls_wc, " xcck010 = '", g_argv[07], "' AND "
   END IF
   #特性
   IF NOT cl_null(g_argv[08]) THEN
      LET ls_wc = ls_wc, " xcck011 = '", g_argv[08], "' AND "
   END IF
   #批號
   IF NOT cl_null(g_argv[09]) THEN
      LET ls_wc = ls_wc, " xcck017 = '", g_argv[09], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_yy1 = g_argv[04]
      LET g_yy2 = g_argv[04]
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET g_mm1 = g_argv[05]
      LET g_mm2 = g_argv[05]
   END IF
   IF NOT cl_null(g_argv[01]) OR NOT cl_null(g_argv[03]) 
      OR NOT cl_null(g_argv[04]) OR NOT cl_null(g_argv[05]) THEN  
      LET g_query_type = 9
   END IF
   #160113-00011#1-add----(E)
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
 
{<section id="axcq509.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION axcq509_fill_chk(ps_idx)
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
 
{<section id="axcq509.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION axcq509_modify_detail_chk(ps_record)
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
         LET ls_return = "xcck002"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="axcq509.mask_functions" >}
&include "erp/axc/axcq509_mask.4gl"
 
{</section>}
 
{<section id="axcq509.state_change" >}
    
 
{</section>}
 
{<section id="axcq509.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION axcq509_set_pk_array()
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
   LET g_pk_array[1].values = g_xcck_m.xcckld
   LET g_pk_array[1].column = 'xcckld'
   LET g_pk_array[2].values = g_xcck_m.xcck001
   LET g_pk_array[2].column = 'xcck001'
   LET g_pk_array[3].values = g_xcck_m.xcck003
   LET g_pk_array[3].column = 'xcck003'
   LET g_pk_array[4].values = g_xcck_m.xcck004
   LET g_pk_array[4].column = 'xcck004'
   LET g_pk_array[5].values = g_xcck_m.xcck005
   LET g_pk_array[5].column = 'xcck005'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axcq509.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION axcq509_msgcentre_notify(lc_state)
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
   CALL axcq509_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_xcck_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axcq509.other_function" readonly="Y" >}

#查询时预设条件
PRIVATE FUNCTION axcq509_default()
DEFINE  l_glaa001        LIKE glaa_t.glaa001

   #预设当前site的法人，主账套，年度期别，成本计算类型
   #fengmy150806----begin
   #CALL s_axc_set_site_default() RETURNING g_xcck_m.xcckcomp,g_xcck_m.xcckld,g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_m.xcck003
   #DISPLAY BY NAME g_xcck_m.xcckcomp,g_xcck_m.xcckld,g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_m.xcck003
   IF cl_null(g_xcck_m.xcckcomp) AND cl_null(g_xcck_m.xcckld) AND cl_null(g_yy1) AND cl_null(g_mm1) 
             AND cl_null(g_yy2) AND cl_null(g_mm2) AND cl_null(g_xcck_m.xcck003) AND cl_null(g_xcck_m.xcck001) THEN
      CALL s_axc_set_site_default() RETURNING g_xcck_m.xcckcomp,g_xcck_m.xcckld,g_yy2,g_mm2,g_xcck_m.xcck003
      DISPLAY BY NAME g_xcck_m.xcckcomp,g_xcck_m.xcckld,g_xcck_m.xcck003
      LET g_yy1 = g_yy2
      LET g_mm1 = g_mm2
      DISPLAY g_yy1 TO xcck004
      DISPLAY g_mm1 TO xcck005
      DISPLAY g_yy2 TO xcck004_1
      DISPLAY g_mm2 TO xcck005_1
   END IF
   #fengmy150806----end
   #fengmy 150109----begin
   #根據參數顯示隱藏成本域 和 料件特性
   IF cl_null(g_xcck_m.xcckcomp) THEN
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data1   #采用成本域否       
   ELSE
      CALL cl_get_para(g_enterprise,g_xcck_m.xcckcomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
      CALL cl_get_para(g_enterprise,g_xcck_m.xcckcomp,'S-FIN-6013') RETURNING g_para_data1   #采用成本域否       
   END IF
              
   IF g_para_data = 'Y' THEN
      CALL cl_set_comp_visible('xcck002,xcck002_desc',TRUE)                    
   ELSE
      CALL cl_set_comp_visible('xcck002,xcck002_desc',FALSE)                
   END IF  
   IF g_para_data1 = 'Y' THEN
      CALL cl_set_comp_visible('xcck011,xcck011_desc',TRUE)                    
   ELSE
      CALL cl_set_comp_visible('xcck011,xcck011_desc',FALSE)                
   END IF   
   #fengmy 150109----end   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xcck_m.xcckcomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcck_m.xcckcomp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcck_m.xcckcomp_desc 
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xcck_m.xcckld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcck_m.xcckld_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcck_m.xcckld_desc 

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xcck_m.xcck003
   CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcck_m.xcck003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcck_m.xcck003_desc
      
   LET g_xcck_m.xcck001 = '1'
   DISPLAY BY NAME g_xcck_m.xcck001
   
   SELECT glaa001 INTO l_glaa001
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_xcck_m.xcckld

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = l_glaa001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcck_m.xcck001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcck_m.xcck001_desc      
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
PRIVATE FUNCTION axcq509_ins_xckk()
   DEFINE l_sum_xcck201        LIKE xcck_t.xcck201
   DEFINE l_sum_xcck202        LIKE xcck_t.xcck202
   DEFINE l_sum_xcck202a       LIKE xcck_t.xcck202a
   DEFINE l_sum_xcck202b       LIKE xcck_t.xcck202b
   DEFINE l_sum_xcck202c       LIKE xcck_t.xcck202c
   DEFINE l_sum_xcck202d       LIKE xcck_t.xcck202d
   DEFINE l_sum_xcck202e       LIKE xcck_t.xcck202e
   DEFINE l_sum_xcck202f       LIKE xcck_t.xcck202f
   DEFINE l_sum_xcck202g       LIKE xcck_t.xcck202g
   DEFINE l_sum_xcck202h       LIKE xcck_t.xcck202h
   DEFINE i                    LIKE type_t.num5
 
   RETURN   #wujie 150301 暂时取消  

   IF g_xcck_d.getLength() = 0 AND g_xcck_d.getLength() = 0 THEN RETURN END IF
#先判断单头条件是否存在与axci601的设置资料里，不存在则退出
#再判断是否已有重复单头资料的xckk/xckl，提示是否删除，若不删除，则退出
 #150902-00008#7-Start-Mark
 #  IF NOT s_axcq004_upd_xckk_chk_del('2',                                     #type         传入更新类型 1：axcq004更新总报表 2：子查询作业更新分项报表
 #                                    g_enterprise,                            #xckkent      传入企业编号
 #                                    g_xcck_m.xcckcomp,                       #xckkcomp     传入法人
 #                                    g_xcck_m.xcckld,                         #xckkld       传入账套
 #                                    g_xcck_m.xcck004,                        #xckk003      传入年度
 #                                    g_xcck_m.xcck005,                        #xckk004      传入期别
 #                                    g_prog,                                  #xckk005      传入程序代号
 #                                    g_xcck_m.xcck003,                        #xckk006      传入成本计算类型
 #                                    g_xcck_m.xcck001)                                      #xckk007      传入本位币顺序
 #  THEN
 #     RETURN
 #  END IF
 #150902-00008#7-End-Mark  
   LET l_sum_xcck201 = 0
   LET l_sum_xcck202 = 0
   LET l_sum_xcck202a = 0
   LET l_sum_xcck202b = 0
   LET l_sum_xcck202c = 0
   LET l_sum_xcck202d = 0
   LET l_sum_xcck202e = 0
   LET l_sum_xcck202f = 0
   LET l_sum_xcck202g = 0
   LET l_sum_xcck202h = 0
   FOR i = 1 TO g_xcck_d.getLength()
       IF g_xcck_d[i].xcck201 IS NULL THEN
          LET g_xcck_d[i].xcck201 = 0
       END IF
       IF g_xcck_d[i].xcck202 IS NULL THEN
          LET g_xcck_d[i].xcck202 = 0
       END IF
       IF g_xcck_d[i].xcck202a IS NULL THEN
          LET g_xcck_d[i].xcck202a = 0
       END IF
       IF g_xcck_d[i].xcck202b IS NULL THEN
          LET g_xcck_d[i].xcck202b = 0
       END IF
       IF g_xcck_d[i].xcck202c IS NULL THEN
          LET g_xcck_d[i].xcck202c = 0
       END IF
       IF g_xcck_d[i].xcck202d IS NULL THEN
          LET g_xcck_d[i].xcck202d = 0
       END IF
       IF g_xcck_d[i].xcck202e IS NULL THEN
          LET g_xcck_d[i].xcck202e = 0
       END IF
       IF g_xcck_d[i].xcck202f IS NULL THEN
          LET g_xcck_d[i].xcck202f = 0
       END IF
       IF g_xcck_d[i].xcck202g IS NULL THEN
          LET g_xcck_d[i].xcck202g = 0
       END IF
       IF g_xcck_d[i].xcck202h IS NULL THEN
          LET g_xcck_d[i].xcck202h = 0
       END IF
       LET l_sum_xcck201 = l_sum_xcck201 + g_xcck_d[i].xcck009*g_xcck_d[i].xcck201
       LET l_sum_xcck202 = l_sum_xcck202 + g_xcck_d[i].xcck009*g_xcck_d[i].xcck202
       LET l_sum_xcck202a = l_sum_xcck202a + g_xcck_d[i].xcck009*g_xcck_d[i].xcck202a
       LET l_sum_xcck202b = l_sum_xcck202b + g_xcck_d[i].xcck009*g_xcck_d[i].xcck202b
       LET l_sum_xcck202c = l_sum_xcck202c + g_xcck_d[i].xcck009*g_xcck_d[i].xcck202c
       LET l_sum_xcck202d = l_sum_xcck202d + g_xcck_d[i].xcck009*g_xcck_d[i].xcck202d
       LET l_sum_xcck202e = l_sum_xcck202e + g_xcck_d[i].xcck009*g_xcck_d[i].xcck202e
       LET l_sum_xcck202f = l_sum_xcck202f + g_xcck_d[i].xcck009*g_xcck_d[i].xcck202f
       LET l_sum_xcck202g = l_sum_xcck202g + g_xcck_d[i].xcck009*g_xcck_d[i].xcck202g
       LET l_sum_xcck202h = l_sum_xcck202h + g_xcck_d[i].xcck009*g_xcck_d[i].xcck202h
   END FOR
   

   FOR i = 1 TO g_xcck_d.getLength()
  # 150902-00008#7-Start-Mark
   #   IF NOT s_axcq004_upd_xckk('2',                                          #type         传入更新类型 1：axcq004更新总报表 2：子查询作业更新分项报表
   #                             g_enterprise,                                 #xckkent      传入企业编号
   #                             g_xcck_m.xcckcomp,                            #xckkcomp     传入法人
   #                             g_xcck_m.xcckld,                              #xckkld       传入账套
   #                             '105',                                        #xckk001      传入类型代码
   #                             g_xcck_m.xcck004,                             #xckk003      传入年度
   #                             g_xcck_m.xcck005,                             #xckk004      传入期别
   #                             g_prog,                                       #xckk005      传入程序代号
   #                             g_xcck_m.xcck003,                             #xckk006      传入成本计算类型
   #                             g_xcck_m.xcck001,                             #xckk007      传入本位币顺序
   #                             l_sum_xcck201,                                #xckk103      传入总表/分项报表数量
   #                             l_sum_xcck202,                                #xckk104      传入总表/分项报表金额
   #                             l_sum_xcck202a,                               #xckk104a     传入总表/分项报表金额-材料
   #                             l_sum_xcck202b,                               #xckk104b     传入总表/分项报表金额-人工
   #                             l_sum_xcck202c,                               #xckk104c     传入总表/分项报表金额-加工
   #                             l_sum_xcck202d,                               #xckk104d     传入总表/分项报表金额-制费一
   #                             l_sum_xcck202e,                               #xckk104e     传入总表/分项报表金额-制费二
   #                             l_sum_xcck202f,                               #xckk104f     传入总表/分项报表金额-制费三
   #                             l_sum_xcck202g,                               #xckk104g     传入总表/分项报表金额-制费四
   #                             l_sum_xcck202h,                               #xckk104h     传入总表/分项报表金额-制费五
   #                             g_xcck_d[1].xcck006,                          #xckl007      传入成本勾稽明细表-单据编号
   #                             g_xcck_d[1].xcck007,                          #xckl008      传入成本勾稽明细表-项次
   #                             g_xcck_d[1].xcck008,                          #xckl009      传入成本勾稽明细表-序号
   #                             g_xcck_d[1].xcck010,                          #xckl010      传入成本勾稽明细表-料件
   #                             g_xcck_d[1].xcck011,                          #xckl011      传入成本勾稽明细表-特性
   #                             g_xcck_d[1].xcck017,                          #xckl012      传入成本勾稽明细表-批号
   #                             g_xcck_d[i].xcck009*g_xcck_d[1].xcck201,      #xckl014      传入成本勾稽明细表-数量
   #                             g_xcck_d[i].xcck009*g_xcck_d[10].xcck202)     #xckl015      传入成本勾稽明细表-金额
   #     THEN
   #      RETURN
   #   END IF 
   #150902-00008#7-End-Mark
   END FOR
END FUNCTION

################################################################################
# Descriptions...: 创建临时表
# Memo...........:
# Date & Author..: 150327 By wangxina
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq509_create_temp_table()
DROP TABLE axcq509_tmp;
   CREATE TEMP TABLE axcq509_tmp(
   xcck002        LIKE xcck_t.xcck002,
   xcck002_desc   LIKE type_t.chr100,
   xcck025        LIKE xcck_t.xcck025,
   xcck025_desc   LIKE type_t.chr100,
   xcck006        LIKE xcck_t.xcck006, 
   xcck007        LIKE xcck_t.xcck007, 
   xcck008        LIKE xcck_t.xcck008, 
   xcck009        LIKE xcck_t.xcck009,
   xcck013        LIKE xcck_t.xcck013, 
   xcck010        LIKE xcck_t.xcck010, 
   xcck010_desc   LIKE type_t.chr100,
   xcck010_desc2  LIKE type_t.chr100,
   imag011        LIKE type_t.chr100, 
   imag011_desc   LIKE type_t.chr100, 
   xcck011        LIKE xcck_t.xcck011, 
   xcck047        LIKE xcck_t.xcck047, 
   xcck015        LIKE xcck_t.xcck015, 
   xcck015_desc   LIKE type_t.chr100,
   xcck017        LIKE xcck_t.xcck017, 
   xcck044        LIKE xcck_t.xcck044, 
   xcck044_desc   LIKE type_t.chr100,
   xcck201        LIKE xcck_t.xcck201, 
   xcck282a       LIKE xcck_t.xcck282a, 
   xcck282b       LIKE xcck_t.xcck282b, 
   xcck282c       LIKE xcck_t.xcck282c, 
   xcck282d       LIKE xcck_t.xcck282d, 
   xcck282e       LIKE xcck_t.xcck282e, 
   xcck282f       LIKE xcck_t.xcck282f, 
   xcck282g       LIKE xcck_t.xcck282g, 
   xcck282h       LIKE xcck_t.xcck282h, 
   xcck282        LIKE xcck_t.xcck282,    
   xcck202a       LIKE xcck_t.xcck202a, 
   xcck202b       LIKE xcck_t.xcck202b, 
   xcck202c       LIKE xcck_t.xcck202c, 
   xcck202d       LIKE xcck_t.xcck202d, 
   xcck202e       LIKE xcck_t.xcck202e, 
   xcck202f       LIKE xcck_t.xcck202f, 
   xcck202g       LIKE xcck_t.xcck202g, 
   xcck202h       LIKE xcck_t.xcck202h,
   xcck202        LIKE xcck_t.xcck202, 
   xcckcomp       LIKE xcck_t.xcckcomp,
   xcckcomp_desc  LIKE type_t.chr100,     
   xcck004        LIKE xcck_t.xcck004,
   xcck001        LIKE xcck_t.xcck001,
   xcck001_desc   LIKE type_t.chr100,
   xcckld         LIKE xcck_t.xcckld,
   xcckld_desc    LIKE type_t.chr100,
   xcck005        LIKE xcck_t.xcck005,
   xcck003        LIKE xcck_t.xcck003,
   xcck003_desc   LIKE type_t.chr100,
   query_type     LIKE type_t.chr100,
   l_key          LIKE type_t.chr100,
   l_xcck004_s    LIKE type_t.chr100,  #150902-00008#7 add
   l_xcck004_e    LIKE type_t.chr100,  #150902-00008#7 add
   l_odr          LIKE type_t.num5     #150902-00008#7 add
);
END FUNCTION

################################################################################
# Descriptions...: 临时表获取数据
# Memo...........:
# Date & Author..: 150327 By wangxina
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq509_ins_temp()
DEFINE sr           RECORD
   xcck002        LIKE xcck_t.xcck002,
   xcck002_desc   LIKE type_t.chr100,
   xcck025        LIKE xcck_t.xcck025,
   xcck025_desc   LIKE type_t.chr100,
   xcck006        LIKE xcck_t.xcck006, 
   xcck007        LIKE xcck_t.xcck007, 
   xcck008        LIKE xcck_t.xcck008, 
   xcck009        LIKE xcck_t.xcck009,
   xcck013        LIKE xcck_t.xcck013, 
   xcck010        LIKE xcck_t.xcck010, 
   xcck010_desc   LIKE type_t.chr100,
   xcck010_desc2  LIKE type_t.chr100,
   imag011        LIKE type_t.chr100, 
   imag011_desc   LIKE type_t.chr100, 
   xcck011        LIKE xcck_t.xcck011, 
   xcck047        LIKE xcck_t.xcck047, 
   xcck015        LIKE xcck_t.xcck015, 
   xcck015_desc   LIKE type_t.chr100,
   xcck017        LIKE xcck_t.xcck017, 
   xcck044        LIKE xcck_t.xcck044, 
   xcck044_desc   LIKE type_t.chr100,
   xcck201        LIKE xcck_t.xcck201, 
   xcck282a       LIKE xcck_t.xcck282a, 
   xcck282b       LIKE xcck_t.xcck282b, 
   xcck282c       LIKE xcck_t.xcck282c, 
   xcck282d       LIKE xcck_t.xcck282d, 
   xcck282e       LIKE xcck_t.xcck282e, 
   xcck282f       LIKE xcck_t.xcck282f, 
   xcck282g       LIKE xcck_t.xcck282g, 
   xcck282h       LIKE xcck_t.xcck282h, 
   xcck282        LIKE xcck_t.xcck282,    
   xcck202a       LIKE xcck_t.xcck202a, 
   xcck202b       LIKE xcck_t.xcck202b, 
   xcck202c       LIKE xcck_t.xcck202c, 
   xcck202d       LIKE xcck_t.xcck202d, 
   xcck202e       LIKE xcck_t.xcck202e, 
   xcck202f       LIKE xcck_t.xcck202f, 
   xcck202g       LIKE xcck_t.xcck202g, 
   xcck202h       LIKE xcck_t.xcck202h,
   xcck202        LIKE xcck_t.xcck202, 
   xcckcomp       LIKE xcck_t.xcckcomp,
   xcckcomp_desc  LIKE type_t.chr100,     
   xcck004        LIKE xcck_t.xcck004,
   xcck001        LIKE xcck_t.xcck001,
   xcck001_desc   LIKE type_t.chr100,
   xcckld         LIKE xcck_t.xcckld,
   xcckld_desc    LIKE type_t.chr100,
   xcck005        LIKE xcck_t.xcck005,
   xcck003        LIKE xcck_t.xcck003,
   xcck003_desc   LIKE type_t.chr100,
   query_type     LIKE type_t.chr100,
   l_key          LIKE type_t.chr100,
   l_xcck004_s    LIKE type_t.chr100,  #150902-00008#7 add
   l_xcck004_e    LIKE type_t.chr100   #150902-00008#7 add
       END RECORD
DEFINE l_i               LIKE type_t.num5
DEFINE l_success         LIKE type_t.num5
#160414-00018#44 mark ------
DEFINE l_xcck005         LIKE type_t.chr100
DEFINE l_xcck004         LIKE type_t.chr100
#160414-00018#44 mark end---
DEFINE l_cnt1            LIKE type_t.num5    #150902-00008#7 add
DEFINE l_odr             LIKE type_t.num5    #150902-00008#7 add
#160414-00018#44 add ------
DEFINE l_ooefl003_desc   LIKE type_t.chr100
DEFINE l_glaal002_desc   LIKE type_t.chr100
DEFINE l_xcatl003_desc   LIKE type_t.chr100
DEFINE l_xcatl001_desc   LIKE type_t.chr100
#160414-00018#44 add end---

 LET l_success = TRUE


#150902-00008#7-Start-Mark
#FOR l_i = 1 TO g_browser.getLength()
#   
#   LET sr.xcck004  = g_browser[l_i].b_xcck004
#   LET sr.xcck001  = g_browser[l_i].b_xcck001
#   LET sr.xcckld   = g_browser[l_i].b_xcckld
#   LET sr.xcck005  = g_browser[l_i].b_xcck005
#   LET sr.xcck003  = g_browser[l_i].b_xcck003
#   
#   SELECT xcckcomp INTO sr.xcckcomp FROM xcck_t
#       WHERE xcckent = g_enterprise AND xcckld = sr.xcckld AND xcck001 = sr.xcck001
#         AND xcck003 = sr.xcck003 AND xcck004 = sr.xcck004 AND xcck005 = sr.xcck005  
##fengmy150807------begin         
##      EXECUTE axcq509_master_referesh USING sr.xcckld,sr.xcck001,sr.xcck003,sr.xcck004,sr.xcck005 
##      INTO sr.xcckcomp,sr.xcck004,sr.xcck001,sr.xcckld,sr.xcck005,sr.xcck003,sr.xcckcomp_desc,
##           sr.xcck001_desc,sr.xcckld_desc,sr.xcck003_desc
#   EXECUTE axcq509_master_referesh1 USING sr.xcckld,sr.xcck001,sr.xcck003
#      INTO sr.xcckcomp,sr.xcck001,sr.xcckld, 
#       sr.xcck004,sr.xcck005,sr.xcck003,sr.xcckcomp_desc,sr.xcck001_desc, 
#       sr.xcckld_desc,sr.xcck003_desc
##fengmy150807------end          
#
#     LET l_xcck005=sr.xcck005
#     LET l_xcck004=sr.xcck004
#      LET sr.l_key = sr.xcckcomp,"-",sr.xcckld CLIPPED,"-" CLIPPED,l_xcck004 CLIPPED,"-" CLIPPED,l_xcck005,"-",sr.xcck001,"-",sr.xcck003 CLIPPED
#
#    INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] = sr.xcckcomp
#      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#      LET sr.xcckcomp_desc = '', g_rtn_fields[1] , ''
#      DISPLAY BY NAME sr.xcckcomp_desc 
#    INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] = sr.xcckld
#      CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
#      LET sr.xcckld_desc = '', g_rtn_fields[1] , ''
#      DISPLAY BY NAME sr.xcckld_desc 
#    INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] = sr.xcck003
#      CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#      LET sr.xcck003_desc = '', g_rtn_fields[1] , ''
#      DISPLAY BY NAME sr.xcck003_desc
#    INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] = sr.xcck001
#      CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
#      LET sr.xcck001_desc = '', g_rtn_fields[1] , ''
#      DISPLAY BY NAME sr.xcck001_desc
# 
#      PREPARE axcq509_xcck_tmp FROM g_sql_tmp
#      DECLARE axcq509_ins_tmp_cs CURSOR FOR axcq509_xcck_tmp
#     #OPEN axcq509_ins_tmp_cs USING g_enterprise,sr.xcckld,sr.xcck001,sr.xcck003,sr.xcck004,sr.xcck005 #150902-00008#7 mark
#      OPEN axcq509_ins_tmp_cs USING g_enterprise,sr.xcckld,sr.xcck001,sr.xcck003  #150902-00008#7 add
#   
#      FOREACH axcq509_ins_tmp_cs INTO sr.xcck002,sr.xcck025,sr.xcck006,sr.xcck007,sr.xcck008,sr.xcck009,sr.xcck013,sr.xcck010,sr.xcck011,
#                          sr.xcck047,sr.xcck015,sr.xcck017,sr.xcck044,sr.xcck201,sr.xcck282a,sr.xcck282b,sr.xcck282c,sr.xcck282d,sr.xcck282e,
#                          sr.xcck282f,sr.xcck282g,sr.xcck282h,sr.xcck282,sr.xcck202a,sr.xcck202b,sr.xcck202c,sr.xcck202d,sr.xcck202e,
#                          sr.xcck202f,sr.xcck202g,sr.xcck202h,sr.xcck202,sr.xcck002_desc,sr.xcck025_desc,sr.xcck010_desc,sr.xcck044_desc
#         
#      SELECT imag011,oocql004 INTO sr.imag011,sr.imag011_desc 
#         FROM imag_t
#         LEFT OUTER JOIN oocql_t ON imagent  = oocqlent AND oocql001 = '206' AND oocql002 = imag011 AND oocql003 = g_dlang
#         WHERE imagent  = g_enterprise 
#            AND imagsite = sr.xcckcomp 
#            AND imag001  = sr.xcck010
#         
#       INITIALIZE g_ref_fields TO NULL
#       LET g_ref_fields[1] = sr.xcck010
#       CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#       LET sr.xcck010_desc = '', g_rtn_fields[1] , ''
#       LET sr.xcck010_desc2 = '', g_rtn_fields[2] , ''
#       
#       CALL s_desc_get_stock_desc(g_site,sr.xcck015) RETURNING sr.xcck015_desc
#       
#      INSERT INTO axcq509_tmp (xcck002,xcck002_desc,xcck025,xcck025_desc,xcck006,xcck007,xcck008,xcck009,xcck013,xcck010,xcck010_desc,xcck010_desc2,imag011,imag011_desc,xcck011,xcck047,xcck015,
#                               xcck015_desc,xcck017,xcck044,xcck044_desc,xcck201,xcck282a,xcck282b,xcck282c,xcck282d,xcck282e,xcck282f,xcck282g,xcck282h,xcck282,xcck202a,xcck202b,xcck202c,
#                               xcck202d,xcck202e,xcck202f,xcck202g,xcck202h,xcck202,xcckcomp,xcckcomp_desc,xcck004,xcck001,xcck001_desc,xcckld,xcckld_desc,xcck005,xcck003,xcck003_desc,query_type,l_key)
#                  VALUES (sr.xcck002,sr.xcck002_desc,sr.xcck025,sr.xcck025_desc,sr.xcck006,sr.xcck007,sr.xcck008,sr.xcck009,sr.xcck013,sr.xcck010,sr.xcck010_desc,sr.xcck010_desc2,sr.imag011,sr.imag011_desc,
#                          sr.xcck011,sr.xcck047,sr.xcck015,sr.xcck015_desc,sr.xcck017,sr.xcck044,sr.xcck044_desc,sr.xcck201,sr.xcck282a,sr.xcck282b,sr.xcck282c,sr.xcck282d,sr.xcck282e,
#                          sr.xcck282f,sr.xcck282g,sr.xcck282h,sr.xcck282,sr.xcck202a,sr.xcck202b,sr.xcck202c,sr.xcck202d,sr.xcck202e,sr.xcck202f,sr.xcck202g,sr.xcck202h,sr.xcck202,sr.xcckcomp,sr.xcckcomp_desc,
#                          sr.xcck004,sr.xcck001,sr.xcck001_desc,sr.xcckld,sr.xcckld_desc,sr.xcck005,sr.xcck003,sr.xcck003_desc,sr.query_type,sr.l_key)
#   
#       IF SQLCA.sqlcode  THEN
#          INITIALIZE g_errparam TO NULL
#          LET g_errparam.extend = 'insert tmp'
#          LET g_errparam.code = SQLCA.SQLCODE
#          LET g_errparam.popup = TRUE
#          CALL cl_err()
#           LET l_success = FALSE
#       END IF
#       
#       END FOREACH
#       
#       CALL cl_err_collect_show()
#       IF l_success = FALSE THEN
#          DELETE FROM axcq508_tmp
#       END IF
#       FREE axcq509_ins_tmp_cs
#   END FOR 
#150902-00008#7-End-Mark


   #150902-00008#7-Start-Add
   #將畫面資料擷取傳至temptable
   #160414-00018#44 add ------
   #法人名稱
   SELECT ooefl003 INTO l_ooefl003_desc FROM ooefl_t
    WHERE ooeflent=g_enterprise AND ooefl001=g_xcck_m.xcckcomp AND ooefl002=g_dlang
   #帳套名稱
   SELECT glaal002 INTO l_glaal002_desc FROM glaal_t
    WHERE glaalent=g_enterprise AND glaalld=g_xcck_m.xcckld AND glaal001=g_dlang
   #成本計算類型名稱
   SELECT xcatl003 INTO l_xcatl003_desc FROM xcatl_t
    WHERE xcatlent=g_enterprise AND xcatl001=g_xcck_m.xcck003 AND xcatl002=g_dlang
   #帳套本位幣順序名稱
   SELECT ooail003 INTO l_xcatl001_desc FROM ooail_t
    WHERE ooailent=g_enterprise AND ooail001=g_xcck_m.xcck001 AND ooail002=g_dlang
   #160414-00018#44 add end---
   
   FOR l_cnt1 = 1 TO g_rec_b
      INITIALIZE sr.* TO NULL
      LET sr.xcck004       = g_xcck_m.xcck004
      LET sr.xcck001       = g_xcck_m.xcck001
      LET sr.xcckld        = g_xcck_m.xcckld
      LET sr.xcck005       = g_xcck_m.xcck005
      LET sr.xcck003       = g_xcck_m.xcck003
      LET sr.xcck002       = g_xcck_d[l_cnt1].xcck002
      LET sr.xcck002_desc  = g_xcck_d[l_cnt1].xcck002_desc
      LET sr.xcck025       = g_xcck_d[l_cnt1].xcck025
      LET sr.xcck025_desc  = g_xcck_d[l_cnt1].xcck025_desc
      LET sr.xcck006       = g_xcck_d[l_cnt1].xcck006
      LET sr.xcck007       = g_xcck_d[l_cnt1].xcck007
      LET sr.xcck008       = g_xcck_d[l_cnt1].xcck008
      LET sr.xcck009       = g_xcck_d[l_cnt1].xcck009
      LET sr.xcck013       = g_xcck_d[l_cnt1].xcck013
      LET sr.xcck010       = g_xcck_d[l_cnt1].xcck010
      LET sr.imag011       = g_xcck_d[l_cnt1].imag011        
      LET sr.imag011_desc  = g_xcck_d[l_cnt1].imag011_desc #160128-00013#1-add
      LET sr.xcck011       = g_xcck_d[l_cnt1].xcck011      
      LET sr.xcck047       = g_xcck_d[l_cnt1].xcck047      
      LET sr.xcck015       = g_xcck_d[l_cnt1].xcck015      
      LET sr.xcck017       = g_xcck_d[l_cnt1].xcck017      
      LET sr.xcck044       = g_xcck_d[l_cnt1].xcck044      
      LET sr.xcck044_desc  = g_xcck_d[l_cnt1].xcck044_desc 
      LET sr.xcck201       = g_xcck_d[l_cnt1].xcck201      
      LET sr.xcck282a      = g_xcck_d[l_cnt1].xcck282a      
      LET sr.xcck282b      = g_xcck_d[l_cnt1].xcck282b      
      LET sr.xcck282c      = g_xcck_d[l_cnt1].xcck282c      
      LET sr.xcck282d      = g_xcck_d[l_cnt1].xcck282d      
      LET sr.xcck282e      = g_xcck_d[l_cnt1].xcck282e      
      LET sr.xcck282f      = g_xcck_d[l_cnt1].xcck282f      
      LET sr.xcck282g      = g_xcck_d[l_cnt1].xcck282g      
      LET sr.xcck282h      = g_xcck_d[l_cnt1].xcck282h      
      LET sr.xcck282       = g_xcck_d[l_cnt1].xcck282         
      LET sr.xcck202a      = g_xcck_d[l_cnt1].xcck202a      
      LET sr.xcck202b      = g_xcck_d[l_cnt1].xcck202b      
      LET sr.xcck202c      = g_xcck_d[l_cnt1].xcck202c      
      LET sr.xcck202d      = g_xcck_d[l_cnt1].xcck202d      
      LET sr.xcck202e      = g_xcck_d[l_cnt1].xcck202e      
      LET sr.xcck202f      = g_xcck_d[l_cnt1].xcck202f      
      LET sr.xcck202g      = g_xcck_d[l_cnt1].xcck202g      
      LET sr.xcck202h      = g_xcck_d[l_cnt1].xcck202h     
      LET sr.xcck202       = g_xcck_d[l_cnt1].xcck202
      #160414-00018#44 add ------
      LET sr.xcck010_desc  = g_xcck_d[l_cnt1].xcck010_desc   #料號
      LET sr.xcck010_desc2 = g_xcck_d[l_cnt1].xcck010_desc_1 #品名
      LET sr.xcck015_desc  = g_xcck_d[l_cnt1].xcck015_desc   #倉庫編號名稱
      LET sr.xcckcomp      = g_xcck_m.xcckcomp
      LET sr.xcckcomp_desc = l_ooefl003_desc
      LET sr.xcckld_desc   = l_glaal002_desc
      LET sr.xcck003_desc  = l_xcatl003_desc
      LET sr.xcck001_desc  = l_xcatl001_desc
      #160414-00018#44 add end---
      LET sr.l_xcck004_s   = g_yy1 USING "<<<<" CLIPPED ," ",g_mm1 USING "<<" CLIPPED
      LET sr.l_xcck004_e   = g_yy2 USING "<<<<" CLIPPED ," ",g_mm2 USING "<<" CLIPPED
      LET sr.query_type    = g_query_type
      LET l_odr = l_cnt1
      
      
      #160414-00018#44 mark ------
      #SELECT xcckcomp INTO sr.xcckcomp FROM xcck_t
      # WHERE xcckent = g_enterprise AND xcckld = sr.xcckld AND xcck001 = sr.xcck001
      #   AND xcck003 = sr.xcck003 AND xcck004 = sr.xcck004 AND xcck005 = sr.xcck005
      #EXECUTE axcq509_master_referesh1 USING sr.xcckld,sr.xcck001,sr.xcck003
      #   INTO sr.xcckcomp,sr.xcck001,sr.xcckld,
      #        sr.xcck004,sr.xcck005,sr.xcck003,sr.xcckcomp_desc,sr.xcck001_desc,
      #        sr.xcckld_desc,sr.xcck003_desc
      #160414-00018#44 mark end---
      #
      #LET l_xcck005=sr.xcck005
      #LET l_xcck004=sr.xcck004
      #LET sr.l_key = sr.xcckcomp,"-",sr.xcckld CLIPPED,"-" CLIPPED,l_xcck004 CLIPPED,"-" CLIPPED,l_xcck005,"-",sr.xcck001,"-",sr.xcck003 CLIPPED
      #160414-00018#44 mark end---
      
      LET sr.l_key = sr.xcckcomp,"-",sr.xcckld CLIPPED,"-" CLIPPED,sr.xcck004 CLIPPED,"-" CLIPPED,sr.xcck005,"-",sr.xcck001,"-",sr.xcck003 CLIPPED #160414-00018#44
      
      #160414-00018#44 mark ------
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = sr.xcckcomp
      #CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      #LET sr.xcckcomp_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME sr.xcckcomp_desc 
      #
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = sr.xcckld
      #CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
      #LET sr.xcckld_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME sr.xcckld_desc 
      #
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = sr.xcck003
      #CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      #LET sr.xcck003_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME sr.xcck003_desc
      #
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = sr.xcck001
      #CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
      #LET sr.xcck001_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME sr.xcck001_desc
      #
      #IF cl_null(sr.imag011) OR sr.imag011 = ' ' THEN
      #   SELECT imag011,oocql004 INTO sr.imag011,sr.imag011_desc 
      #     FROM imag_t
      #     LEFT OUTER JOIN oocql_t ON imagent  = oocqlent AND oocql001 = '206' AND oocql002 = imag011 AND oocql003 = g_dlang
      #    WHERE imagent  = g_enterprise 
      #      AND imagsite = sr.xcckcomp 
      #      AND imag001  = sr.xcck010
      #ELSE
      #  SELECT oocql004 INTO sr.imag011_desc 
      #    FROM imag_t
      #    LEFT OUTER JOIN oocql_t ON imagent  = oocqlent AND oocql001 = '206' AND oocql002 = imag011 AND oocql003 = g_dlang
      #   WHERE imagent  = g_enterprise 
      #     AND imagsite = sr.xcckcomp 
      #     AND imag001  = sr.xcck010
      #END IF
      #
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = sr.xcck010
      #CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      #LET sr.xcck010_desc = '', g_rtn_fields[1] , ''
      #LET sr.xcck010_desc2 = '', g_rtn_fields[2] , ''
      # 
      #CALL s_desc_get_stock_desc(g_site,sr.xcck015) RETURNING sr.xcck015_desc
      #160414-00018#44 mark end---
      
      INSERT INTO axcq509_tmp (xcck002,xcck002_desc,xcck025,xcck025_desc,xcck006,xcck007,xcck008,xcck009,xcck013,xcck010,xcck010_desc,xcck010_desc2,imag011,imag011_desc,xcck011,xcck047,xcck015,
                               xcck015_desc,xcck017,xcck044,xcck044_desc,xcck201,xcck282a,xcck282b,xcck282c,xcck282d,xcck282e,xcck282f,xcck282g,xcck282h,xcck282,xcck202a,xcck202b,xcck202c,
                               xcck202d,xcck202e,xcck202f,xcck202g,xcck202h,xcck202,xcckcomp,xcckcomp_desc,xcck004,xcck001,xcck001_desc,xcckld,xcckld_desc,xcck005,xcck003,xcck003_desc,query_type,l_key
                              ,l_xcck004_s,l_xcck004_e,l_odr)
                  VALUES (sr.xcck002,sr.xcck002_desc,sr.xcck025,sr.xcck025_desc,sr.xcck006,sr.xcck007,sr.xcck008,sr.xcck009,sr.xcck013,sr.xcck010,sr.xcck010_desc,sr.xcck010_desc2,sr.imag011,sr.imag011_desc,
                          sr.xcck011,sr.xcck047,sr.xcck015,sr.xcck015_desc,sr.xcck017,sr.xcck044,sr.xcck044_desc,sr.xcck201,sr.xcck282a,sr.xcck282b,sr.xcck282c,sr.xcck282d,sr.xcck282e,
                          sr.xcck282f,sr.xcck282g,sr.xcck282h,sr.xcck282,sr.xcck202a,sr.xcck202b,sr.xcck202c,sr.xcck202d,sr.xcck202e,sr.xcck202f,sr.xcck202g,sr.xcck202h,sr.xcck202,sr.xcckcomp,sr.xcckcomp_desc,
                          sr.xcck004,sr.xcck001,sr.xcck001_desc,sr.xcckld,sr.xcckld_desc,sr.xcck005,sr.xcck003,sr.xcck003_desc,sr.query_type,sr.l_key
                         ,sr.l_xcck004_s,sr.l_xcck004_e,l_odr)
   END FOR
  #150902-00008#7-End-Add 
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
PRIVATE FUNCTION axcq509_b_fill_1(p_wc2)
DEFINE p_wc2              STRING
#add-point:b_fill段define
DEFINE l_sql              STRING
DEFINE l_xcck202a_sum     LIKE xcck_t.xcck202a
DEFINE l_xcck202b_sum     LIKE xcck_t.xcck202b
DEFINE l_xcck202c_sum     LIKE xcck_t.xcck202c
DEFINE l_xcck202d_sum     LIKE xcck_t.xcck202d
DEFINE l_xcck202e_sum     LIKE xcck_t.xcck202e
DEFINE l_xcck202f_sum     LIKE xcck_t.xcck202f
DEFINE l_xcck202g_sum     LIKE xcck_t.xcck202g
DEFINE l_xcck202h_sum     LIKE xcck_t.xcck202h
DEFINE l_xcck202_sum      LIKE xcck_t.xcck202
DEFINE l_xcck202a_total   LIKE xcck_t.xcck202a
DEFINE l_xcck202b_total   LIKE xcck_t.xcck202b
DEFINE l_xcck202c_total   LIKE xcck_t.xcck202c
DEFINE l_xcck202d_total   LIKE xcck_t.xcck202d
DEFINE l_xcck202e_total   LIKE xcck_t.xcck202e
DEFINE l_xcck202f_total   LIKE xcck_t.xcck202f
DEFINE l_xcck202g_total   LIKE xcck_t.xcck202g
DEFINE l_xcck202h_total   LIKE xcck_t.xcck202h
DEFINE l_xcck202_total    LIKE xcck_t.xcck202
DEFINE l_xcck201_total    LIKE xcck_t.xcck201   #150902-00008#7 add
DEFINE l_xcck201_sum      LIKE xcck_t.xcck201   #150902-00008#7 add
#160411-00040#1  By Ann_Huang  --- add Start ---
DEFINE l_xcck202a_2       LIKE xcck_t.xcck202a
DEFINE l_xcck202b_2       LIKE xcck_t.xcck202b
DEFINE l_xcck202c_2       LIKE xcck_t.xcck202c
DEFINE l_xcck202d_2       LIKE xcck_t.xcck202d
DEFINE l_xcck202e_2       LIKE xcck_t.xcck202e
DEFINE l_xcck202f_2       LIKE xcck_t.xcck202f
DEFINE l_xcck202g_2       LIKE xcck_t.xcck202g
DEFINE l_xcck202h_2       LIKE xcck_t.xcck202h
DEFINE l_xcck202_2        LIKE xcck_t.xcck202
#160411-00040#1  By Ann_Huang  --- add End ---
DEFINE l_axc00205         LIKE type_t.chr50     #160414-00018#44
   #end add-point
   #add-point:b_fill段define

   #end add-point
   

   #end add-point
   #160414-00018#44 mark ------
   #LET g_sql = "SELECT  UNIQUE xcck002,xcck025,xcck006,xcck007,xcck008,xcck009,xcck013,xcck010,xcck011, 
   #    xcck047,xcck015,xcck017,xcck044,xcck201,xcck282a,xcck282b,xcck282c,xcck282d,xcck282e,xcck282f, 
   #    xcck282g,xcck282h,xcck282,xcck202a,xcck202b,xcck202c,xcck202d,xcck202e,xcck202f,xcck202g,xcck202h, ", 
   #  #" xcck202,t1.xcbfl003 ,t2.ooefl003 ,t3.imaal003 ,t5.oocal003 FROM xcck_t",  #150902-00008#7 mark
   #   " xcck202,t1.xcbfl003 ,t2.ooefl003 ,t3.imaal003 ,t5.oocal003,t6.imag011 FROM xcck_t",  #150902-00008#7 add        
   #    
   #            "",
   #            
   #                           " LEFT JOIN xcbfl_t t1 ON t1.xcbflent='"||g_enterprise||"' AND t1.xcbfl001=xcck002 AND t1.xcbfl002='"||g_dlang||"' ",
   #            " LEFT JOIN ooefl_t t2 ON t2.ooeflent='"||g_enterprise||"' AND t2.ooefl001=xcck025 AND t2.ooefl002='"||g_dlang||"' ",
   #            " LEFT JOIN imaal_t t3 ON t3.imaalent='"||g_enterprise||"' AND t3.imaal001=xcck010 AND t3.imaal002='"||g_dlang||"' ",
   #            " LEFT JOIN oocal_t t5 ON t5.oocalent='"||g_enterprise||"' AND t5.oocal001=xcck044 AND t5.oocal002='"||g_dlang||"' ",
   #            " LEFT JOIN imag_t t6 ON t6.imagent='"||g_enterprise||"' AND t6.imag001 = xcck010 AND t6.imagsite = xcckcomp ",  #150902-00008#7 add  
   #160414-00018#44 mark end---
   #160414-00018#44 add ------
   LET g_sql = "SELECT UNIQUE xcck002,xcck025,xcck006,xcck007,xcck008,",
               "       xcck009,xcck013,xcck010,xcck011,xcck047,",
               "       xcck015,xcck017,xcck044,xcck201,xcck282a,",
               "       xcck282b,xcck282c,xcck282d,xcck282e,xcck282f,",
               "       xcck282g,xcck282h,xcck282,xcck202a,xcck202b,",
               "       xcck202c,xcck202d,xcck202e,xcck202f,xcck202g,",
               "       xcck202h,xcck202,",
               #成本域名稱
               "       (SELECT xcbfl003 FROM xcbfl_t WHERE xcbflent=xcckent AND xcbfl001=xcck002 AND xcbfl002='",g_dlang,"'),",
               #成本中心名稱
               "       (SELECT ooefl003 FROM ooefl_t WHERE ooeflent=xcckent AND ooefl001=xcck025 AND ooefl002='",g_dlang,"'),",
               #品名
               "       (SELECT imaal003 FROM imaal_t WHERE imaalent=xcckent AND imaal001=xcck010 AND imaal002='",g_dlang,"'),",
               #成本單位名稱
               "       (SELECT oocal003 FROM oocal_t WHERE oocalent=xcckent AND oocal001=xcck044 AND oocal002='",g_dlang,"'),",
               #成本分群
               "       (SELECT imag011 FROM imag_t WHERE imagent=xcckent AND imag001=xcck010 AND imagsite=xcckcomp AND imag001=xcck010) AS imag011,",
               #成本分群名稱
               "       (SELECT oocql004 FROM imag_t LEFT OUTER JOIN oocql_t ON imagent=oocqlent AND oocql001='206' AND oocql002=imag011 AND oocql003='",g_dlang,"'",
               "         WHERE imagent=xcckent AND imagsite=xcckcomp AND imag001=xcck010),",
               #倉庫編號
               "       (SELECT inayl003 FROM inayl_t WHERE inaylent=xcckent AND inayl001=xcck015 AND inayl002='",g_dlang,"'),",
               #規格
               "       (SELECT imaal004 FROM imaal_t WHERE imaalent=xcckent AND imaal001=xcck010 AND imaal002='",g_dlang,"')",
               "  FROM xcck_t",
   #160414-00018#44 add end---
               " WHERE xcckent= ? AND xcckld=? AND xcck001=? AND xcck003=? "," AND ",g_wc
   IF NOT cl_null(g_wc2_table1) THEN
     #LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED," AND ",g_wc CLIPPED, cl_sql_add_filter("xcck_t") #160113-00011#1-mod-(S)
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED,cl_sql_add_filter("xcck_t")                        #160113-00011#1-mod-(E)
   END IF

   #add-point:b_fill段sql_after
   CASE g_query_type
     WHEN '1'    #一般工单
       #LET g_wc_xcck055 = " xcck055 IN('205','2050','2030') "  #160811-00010#1 add '2050', '2030' #161006-00032#2 mark
        LET g_wc_xcck055 = " xcck055 IN('205','2050') "  #161006-00032#2
     WHEN '2'    #返工工单    
       #LET g_wc_xcck055 = " xcck055 IN ('209','2090','2030') " #160811-00010#1 add '2090', '2030' #161006-00032#2 mark
        LET g_wc_xcck055 = " xcck055 IN ('209','2090') "        #161006-00032#2
     WHEN '3'    #拆件工单     
       #LET g_wc_xcck055 = " xcck055 IN('2052') " #wujie 150301 去掉205 #fengmy150514 mark
        LET g_wc_xcck055 = " xcck020 IN('106','113') "                  #fengmy150514
     WHEN '9'    #全部       
       #LET g_wc_xcck055 = " xcck055 IN('205','209','2051','2052') "           #150109 fengmy mark 去拆件
       #LET g_wc_xcck055 = " xcck055 IN('205','209','2050','2090','2030')  "   #150109 fengmy   #160811-00010#1 add '2050','2090','2030' #161006-00032#2 mark
        LET g_wc_xcck055 = " xcck055 IN('205','209','2050','2090')  "          #161006-00032#2
     OTHERWISE 
       #LET g_wc_xcck055 = " xcck055 IN('205','209','2051','2052') "           #150109 fengmy mark
       #LET g_wc_xcck055 = " xcck055 IN('205','209','2050','2090','2030')  "   #150109 fengmy   #160811-00010#1 add '2050','2090','2030' #161006-00032#2 mark
        LET g_wc_xcck055 = " xcck055 IN('205','209','2050','2090') "           #161006-00032#2
   END CASE
   LET g_sql = g_sql," AND ",g_wc_xcck055
   LET l_sql = g_sql
   LET g_sql_tmp=g_sql   #wangxina 150327 add
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF axcq509_fill_chk(1) THEN
      #IF g_action_choice <> 'fetch' OR cl_null(g_action_choice) THEN
         LET g_sql = g_sql, " ORDER BY xcck_t.xcck002,xcck_t.xcck006,xcck_t.xcck007,xcck_t.xcck008,xcck_t.xcck009"
         #add-point:b_fill段fill_before
         #LET g_sql = l_sql, " ORDER BY xcck_t.xcck002,xcck_t.xcck025,xcck_t.xcck006,xcck_t.xcck007,xcck_t.xcck008,xcck_t.xcck009" ##150902-00008#7 mark
         #LET g_sql = l_sql, " ORDER BY t6.imag011,xcck_t.xcck002,xcck_t.xcck025,xcck_t.xcck006,xcck_t.xcck007,xcck_t.xcck008,xcck_t.xcck009" ##150902-00008#7 mark#150902-00008#7 add #160414-00018#44 mark
         LET g_sql = l_sql, " ORDER BY imag011,xcck002,xcck025,xcck006,xcck007,xcck008,xcck009" #160414-00018#44
         LET l_xcck202a_sum = 0
         LET l_xcck202b_sum = 0
         LET l_xcck202c_sum = 0
         LET l_xcck202d_sum = 0
         LET l_xcck202e_sum = 0
         LET l_xcck202f_sum = 0
         LET l_xcck202g_sum = 0
         LET l_xcck202h_sum = 0
         LET l_xcck202_sum  = 0
         LET l_xcck202a_total = 0
         LET l_xcck202b_total = 0
         LET l_xcck202c_total = 0
         LET l_xcck202d_total = 0
         LET l_xcck202e_total = 0
         LET l_xcck202f_total = 0
         LET l_xcck202g_total = 0
         LET l_xcck202h_total = 0
         LET l_xcck202_total  = 0
         LET l_xcck201_total  = 0 #150902-00008#7 add
         LET l_xcck201_sum    = 0 #150902-00008#7 add
         
         #取得"小計"的字
         LET l_axc00205 = cl_getmsg("axc-00205",g_lang) #160414-00018#44
         
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axcq509_pb1 FROM g_sql
         DECLARE b_fill_cs1 CURSOR FOR axcq509_pb1
      #END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs1 USING g_enterprise,g_xcck_m.xcckld,g_xcck_m.xcck001,g_xcck_m.xcck003
      
      FOREACH b_fill_cs1 INTO g_xcck_d[l_ac].xcck002,g_xcck_d[l_ac].xcck025,g_xcck_d[l_ac].xcck006,g_xcck_d[l_ac].xcck007, 
         g_xcck_d[l_ac].xcck008,g_xcck_d[l_ac].xcck009,g_xcck_d[l_ac].xcck013,g_xcck_d[l_ac].xcck010, 
         g_xcck_d[l_ac].xcck011,g_xcck_d[l_ac].xcck047,g_xcck_d[l_ac].xcck015,g_xcck_d[l_ac].xcck017, 
         g_xcck_d[l_ac].xcck044,g_xcck_d[l_ac].xcck201,g_xcck_d[l_ac].xcck282a,g_xcck_d[l_ac].xcck282b, 
         g_xcck_d[l_ac].xcck282c,g_xcck_d[l_ac].xcck282d,g_xcck_d[l_ac].xcck282e,g_xcck_d[l_ac].xcck282f, 
         g_xcck_d[l_ac].xcck282g,g_xcck_d[l_ac].xcck282h,g_xcck_d[l_ac].xcck282,g_xcck_d[l_ac].xcck202a, 
         g_xcck_d[l_ac].xcck202b,g_xcck_d[l_ac].xcck202c,g_xcck_d[l_ac].xcck202d,g_xcck_d[l_ac].xcck202e, 
         g_xcck_d[l_ac].xcck202f,g_xcck_d[l_ac].xcck202g,g_xcck_d[l_ac].xcck202h,g_xcck_d[l_ac].xcck202, 
         g_xcck_d[l_ac].xcck002_desc,g_xcck_d[l_ac].xcck025_desc,g_xcck_d[l_ac].xcck010_desc,g_xcck_d[l_ac].xcck044_desc, #160414-00018#44 add,
       #,g_xcck_d[l_ac].imag011 #150902-00008#7 add #160414-00018#44 mark
         g_xcck_d[l_ac].imag011,g_xcck_d[l_ac].imag011_desc,g_xcck_d[l_ac].xcck015_desc,g_xcck_d[l_ac].xcck010_desc_1 #160414-00018#44 add
         
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         #add-point:b_fill段資料填充
         #160411-00040#1  By Ann_Huang  --- add Start ---
         IF cl_null(g_xcck_d[l_ac].xcck282a) THEN  LET g_xcck_d[l_ac].xcck282a = 0  END IF
         IF cl_null(g_xcck_d[l_ac].xcck282b) THEN  LET g_xcck_d[l_ac].xcck282b = 0  END IF
         IF cl_null(g_xcck_d[l_ac].xcck282c) THEN  LET g_xcck_d[l_ac].xcck282c = 0  END IF
         IF cl_null(g_xcck_d[l_ac].xcck282d) THEN  LET g_xcck_d[l_ac].xcck282d = 0  END IF
         IF cl_null(g_xcck_d[l_ac].xcck282e) THEN  LET g_xcck_d[l_ac].xcck282e = 0  END IF
         IF cl_null(g_xcck_d[l_ac].xcck282f) THEN  LET g_xcck_d[l_ac].xcck282f = 0  END IF
         IF cl_null(g_xcck_d[l_ac].xcck282g) THEN  LET g_xcck_d[l_ac].xcck282g = 0  END IF
         IF cl_null(g_xcck_d[l_ac].xcck282h) THEN  LET g_xcck_d[l_ac].xcck282h = 0  END IF
         IF cl_null(g_xcck_d[l_ac].xcck282 ) THEN  LET g_xcck_d[l_ac].xcck282  = 0  END IF
         
         IF cl_null(g_xcck_d[l_ac].xcck202a) THEN  LET g_xcck_d[l_ac].xcck202a = 0  END IF
         IF cl_null(g_xcck_d[l_ac].xcck202b) THEN  LET g_xcck_d[l_ac].xcck202b = 0  END IF
         IF cl_null(g_xcck_d[l_ac].xcck202c) THEN  LET g_xcck_d[l_ac].xcck202c = 0  END IF
         IF cl_null(g_xcck_d[l_ac].xcck202d) THEN  LET g_xcck_d[l_ac].xcck202d = 0  END IF
         IF cl_null(g_xcck_d[l_ac].xcck202e) THEN  LET g_xcck_d[l_ac].xcck202e = 0  END IF
         IF cl_null(g_xcck_d[l_ac].xcck202f) THEN  LET g_xcck_d[l_ac].xcck202f = 0  END IF
         IF cl_null(g_xcck_d[l_ac].xcck202g) THEN  LET g_xcck_d[l_ac].xcck202g = 0  END IF
         IF cl_null(g_xcck_d[l_ac].xcck202h) THEN  LET g_xcck_d[l_ac].xcck202h = 0  END IF
         IF cl_null(g_xcck_d[l_ac].xcck202 ) THEN  LET g_xcck_d[l_ac].xcck202  = 0  END IF
         #160411-00040#1  By Ann_Huang  --- add End ---
         
         LET g_xcck_d[l_ac].xcck202a = g_xcck_d[l_ac].xcck202a * g_xcck_d[l_ac].xcck009
         LET g_xcck_d[l_ac].xcck202b = g_xcck_d[l_ac].xcck202b * g_xcck_d[l_ac].xcck009
         LET g_xcck_d[l_ac].xcck202c = g_xcck_d[l_ac].xcck202c * g_xcck_d[l_ac].xcck009
         LET g_xcck_d[l_ac].xcck202d = g_xcck_d[l_ac].xcck202d * g_xcck_d[l_ac].xcck009
         LET g_xcck_d[l_ac].xcck202e = g_xcck_d[l_ac].xcck202e * g_xcck_d[l_ac].xcck009
         LET g_xcck_d[l_ac].xcck202f = g_xcck_d[l_ac].xcck202f * g_xcck_d[l_ac].xcck009
         LET g_xcck_d[l_ac].xcck202g = g_xcck_d[l_ac].xcck202g * g_xcck_d[l_ac].xcck009
         LET g_xcck_d[l_ac].xcck202h = g_xcck_d[l_ac].xcck202h * g_xcck_d[l_ac].xcck009
         LET g_xcck_d[l_ac].xcck202  = g_xcck_d[l_ac].xcck202  * g_xcck_d[l_ac].xcck009
         
         #160414-00018#44 mark ------
         #優化改寫成SUB-QUERY
         ##成本分群
         #SELECT imag011,oocql004 INTO g_xcck_d[l_ac].imag011,g_xcck_d[l_ac].imag011_desc 
         #  FROM imag_t
         #  LEFT OUTER JOIN oocql_t ON imagent  = oocqlent AND oocql001 = '206' AND oocql002 = imag011 AND oocql003 = g_dlang
         # WHERE imagent  = g_enterprise
         #   AND imagsite = g_xcck_m.xcckcomp
         #   AND imag001  = g_xcck_d[l_ac].xcck010
         #CALL s_desc_get_stock_desc(g_site,g_xcck_d[l_ac].xcck015) RETURNING g_xcck_d[l_ac].xcck015_desc
         #INITIALIZE g_ref_fields TO NULL
         #LET g_ref_fields[1] = g_xcck_d[l_ac].xcck010
         #CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
         #LET g_xcck_d[l_ac].xcck010_desc = '', g_rtn_fields[1] , ''
         #LET g_xcck_d[l_ac].xcck010_desc_1 = '', g_rtn_fields[2] , ''
         #CALL s_desc_get_unit_desc(g_xcck_d[l_ac].xcck044) RETURNING g_xcck_d[l_ac].xcck044_desc
         #160414-00018#44 mark end---
         
         #依成本域、成本中心小计
         LET l_xcck202a_sum = l_xcck202a_sum + g_xcck_d[l_ac].xcck202a
         LET l_xcck202b_sum = l_xcck202b_sum + g_xcck_d[l_ac].xcck202b
         LET l_xcck202c_sum = l_xcck202c_sum + g_xcck_d[l_ac].xcck202c
         LET l_xcck202d_sum = l_xcck202d_sum + g_xcck_d[l_ac].xcck202d
         LET l_xcck202e_sum = l_xcck202e_sum + g_xcck_d[l_ac].xcck202e
         LET l_xcck202f_sum = l_xcck202f_sum + g_xcck_d[l_ac].xcck202f
         LET l_xcck202g_sum = l_xcck202g_sum + g_xcck_d[l_ac].xcck202g
         LET l_xcck202h_sum = l_xcck202h_sum + g_xcck_d[l_ac].xcck202h
         LET l_xcck202_sum  = l_xcck202_sum  + g_xcck_d[l_ac].xcck202
         LET l_xcck201_sum  = l_xcck201_sum  + g_xcck_d[l_ac].xcck201                     #150902-00008#7 add
         LET l_xcck202a_total = l_xcck202a_total + g_xcck_d[l_ac].xcck202a
         LET l_xcck202b_total = l_xcck202b_total + g_xcck_d[l_ac].xcck202b
         LET l_xcck202c_total = l_xcck202c_total + g_xcck_d[l_ac].xcck202c
         LET l_xcck202d_total = l_xcck202d_total + g_xcck_d[l_ac].xcck202d
         LET l_xcck202e_total = l_xcck202e_total + g_xcck_d[l_ac].xcck202e
         LET l_xcck202f_total = l_xcck202f_total + g_xcck_d[l_ac].xcck202f
         LET l_xcck202g_total = l_xcck202g_total + g_xcck_d[l_ac].xcck202g
         LET l_xcck202h_total = l_xcck202h_total + g_xcck_d[l_ac].xcck202h
         LET l_xcck202_total  = l_xcck202_total  + g_xcck_d[l_ac].xcck202
         LET l_xcck201_total  = l_xcck201_total  + g_xcck_d[l_ac].xcck201                 #150902-00008#7 add
         IF cl_null(g_xcck_d[l_ac].imag011) THEN LET g_xcck_d[l_ac].imag011 = ' ' END IF  #150902-00008#7 add
        
         IF l_ac > 1 THEN
            #成本分群做小計  #150902-00008#7 add
            #IF g_xcck_d[l_ac].xcck002 != g_xcck_d[l_ac - 1].xcck002 OR g_xcck_d[l_ac].xcck025 != g_xcck_d[l_ac - 1].xcck025 THEN  #150902-00008#7 mark
            IF g_xcck_d[l_ac].imag011 != g_xcck_d[l_ac - 1].imag011 THEN #150902-00008#7 add
               #把当前行下移，并在当前行显示小计
               LET g_xcck_d[l_ac + 1].* = g_xcck_d[l_ac].*
               INITIALIZE  g_xcck_d[l_ac].* TO NULL
               #150902-00008#7-Start-Mark
               ##fengmy 150109 modify--begin
               ##LET g_xcck_d[l_ac].xcck002 = cl_getmsg("axc-00205",g_lang)
               #CALL cl_get_para(g_enterprise,g_xcck_m.xcckcomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
               #IF g_para_data = 'Y' THEN
               #   LET g_xcck_d[l_ac].xcck002 = cl_getmsg("axc-00205",g_lang)
               #ELSE
               #   LET g_xcck_d[l_ac].xcck025 = cl_getmsg("axc-00205",g_lang)
               #END IF
               ##fengmy 150109 modify--begin
               #150902-00008#7-ENd-Mark

               #160411-00040#1  By Ann_Huang  --- add Start ---
               #處理NULL
               LET l_xcck202a_2 = g_xcck_d[l_ac + 1].xcck202a
               LET l_xcck202b_2 = g_xcck_d[l_ac + 1].xcck202b
               LET l_xcck202c_2 = g_xcck_d[l_ac + 1].xcck202c
               LET l_xcck202d_2 = g_xcck_d[l_ac + 1].xcck202d
               LET l_xcck202e_2 = g_xcck_d[l_ac + 1].xcck202e
               LET l_xcck202f_2 = g_xcck_d[l_ac + 1].xcck202f
               LET l_xcck202g_2 = g_xcck_d[l_ac + 1].xcck202g
               LET l_xcck202h_2 = g_xcck_d[l_ac + 1].xcck202h
               LET l_xcck202_2  = g_xcck_d[l_ac + 1].xcck202
               
               IF cl_null(l_xcck202a_2) THEN  LET l_xcck202a_2 = 0  END IF
               IF cl_null(l_xcck202b_2) THEN  LET l_xcck202b_2 = 0  END IF
               IF cl_null(l_xcck202c_2) THEN  LET l_xcck202c_2 = 0  END IF
               IF cl_null(l_xcck202d_2) THEN  LET l_xcck202d_2 = 0  END IF
               IF cl_null(l_xcck202e_2) THEN  LET l_xcck202e_2 = 0  END IF
               IF cl_null(l_xcck202f_2) THEN  LET l_xcck202f_2 = 0  END IF
               IF cl_null(l_xcck202g_2) THEN  LET l_xcck202g_2 = 0  END IF
               IF cl_null(l_xcck202h_2) THEN  LET l_xcck202h_2 = 0  END IF
               IF cl_null(l_xcck202_2)  THEN  LET l_xcck202_2 = 0   END IF
               #160411-00040#1  By Ann_Huang  --- add End ---
              
               #151029-00010#2 20151029 s983961  modify(axcq小計整批顯示優化)--s
               #LET g_xcck_d[l_ac].imag011 = cl_getmsg("axc-00205",g_lang)             #150902-00008#7 add
               #LET g_xcck_d[l_ac].imag011_desc = g_xcck_d[l_ac-1].imag011,cl_getmsg("axc-00205",g_lang) #160414-00018#44 mark
               LET g_xcck_d[l_ac].imag011_desc = g_xcck_d[l_ac-1].imag011,l_axc00205                     #160414-00018#44
               #151029-00010#2 20151029 s983961  modify(axcq小計整批顯示優化)--e
               LET g_xcck_d[l_ac].xcck201 = l_xcck201_sum - g_xcck_d[l_ac + 1].xcck201 #150902-00008#7 add
               #160411-00040#1  By Ann_Huang  --- mark Start ---
               #LET g_xcck_d[l_ac].xcck202a = l_xcck202a_sum - g_xcck_d[l_ac + 1].xcck202a
               #LET g_xcck_d[l_ac].xcck202b = l_xcck202b_sum - g_xcck_d[l_ac + 1].xcck202b
               #LET g_xcck_d[l_ac].xcck202c = l_xcck202c_sum - g_xcck_d[l_ac + 1].xcck202c
               #LET g_xcck_d[l_ac].xcck202d = l_xcck202d_sum - g_xcck_d[l_ac + 1].xcck202d
               #LET g_xcck_d[l_ac].xcck202e = l_xcck202e_sum - g_xcck_d[l_ac + 1].xcck202e
               #LET g_xcck_d[l_ac].xcck202f = l_xcck202f_sum - g_xcck_d[l_ac + 1].xcck202f
               #LET g_xcck_d[l_ac].xcck202g = l_xcck202g_sum - g_xcck_d[l_ac + 1].xcck202g
               #LET g_xcck_d[l_ac].xcck202h = l_xcck202h_sum - g_xcck_d[l_ac + 1].xcck202h
               #LET g_xcck_d[l_ac].xcck202  = l_xcck202_sum  - g_xcck_d[l_ac + 1].xcck202
               #160411-00040#1  By Ann_Huang  --- mark End ---
               #160411-00040#1  By Ann_Huang  --- add Start ---
               LET g_xcck_d[l_ac].xcck202a = l_xcck202a_sum - l_xcck202a_2
               LET g_xcck_d[l_ac].xcck202b = l_xcck202b_sum - l_xcck202b_2
               LET g_xcck_d[l_ac].xcck202c = l_xcck202c_sum - l_xcck202c_2
               LET g_xcck_d[l_ac].xcck202d = l_xcck202d_sum - l_xcck202d_2
               LET g_xcck_d[l_ac].xcck202e = l_xcck202e_sum - l_xcck202e_2
               LET g_xcck_d[l_ac].xcck202f = l_xcck202f_sum - l_xcck202f_2
               LET g_xcck_d[l_ac].xcck202g = l_xcck202g_sum - l_xcck202g_2
               LET g_xcck_d[l_ac].xcck202h = l_xcck202h_sum - l_xcck202h_2
               LET g_xcck_d[l_ac].xcck202  = l_xcck202_sum  - l_xcck202_2
               #160411-00040#1  By Ann_Huang  --- add End ---
               LET l_ac = l_ac + 1
               LET l_xcck202a_sum = g_xcck_d[l_ac].xcck202a
               LET l_xcck202b_sum = g_xcck_d[l_ac].xcck202b
               LET l_xcck202c_sum = g_xcck_d[l_ac].xcck202c
               LET l_xcck202d_sum = g_xcck_d[l_ac].xcck202d
               LET l_xcck202e_sum = g_xcck_d[l_ac].xcck202e
               LET l_xcck202f_sum = g_xcck_d[l_ac].xcck202f
               LET l_xcck202g_sum = g_xcck_d[l_ac].xcck202g
               LET l_xcck202h_sum = g_xcck_d[l_ac].xcck202h
               LET l_xcck202_sum  = g_xcck_d[l_ac].xcck202
               LET l_xcck201_sum  = g_xcck_d[l_ac].xcck201 #150902-00008#7 add
            END IF
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
      CALL g_xcck_d.deleteElement(g_xcck_d.getLength())
   END IF
   
   #add-point:b_fill段more
   #最后一组小计
   #150902-00008#7-Start-Mark
   ##fengmy 150109 modify--begin
   #LET g_xcck_d[l_ac].xcck002 = cl_getmsg("axc-00205",g_lang)
   #CALL cl_get_para(g_enterprise,g_xcck_m.xcckcomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
   #IF g_para_data = 'Y' THEN
   #   LET g_xcck_d[l_ac].xcck002 = cl_getmsg("axc-00205",g_lang)
   #ELSE
   #   LET g_xcck_d[l_ac].xcck025 = cl_getmsg("axc-00205",g_lang)
   #END IF
   ##fengmy 150109 modify--begin
   #150902-00008#7-End-Mark
   #151029-00010#2 20151029 s983961  modify(axcq小計整批顯示優化)--s
   #LET g_xcck_d[l_ac].imag011 = cl_getmsg("axc-00205",g_lang) #150902-00008#7 add
   #LET g_xcck_d[l_ac].imag011_desc = g_xcck_d[l_ac-1].imag011,cl_getmsg("axc-00205",g_lang) #160414-00018#44
   LET g_xcck_d[l_ac].imag011_desc = g_xcck_d[l_ac-1].imag011,l_axc00205                     #160414-00018#44
   #151029-00010#2 20151029 s983961  modify(axcq小計整批顯示優化)--e
   LET g_xcck_d[l_ac].xcck201  = l_xcck201_sum                #150902-00008#7 add
   LET g_xcck_d[l_ac].xcck202a = l_xcck202a_sum
   LET g_xcck_d[l_ac].xcck202b = l_xcck202b_sum
   LET g_xcck_d[l_ac].xcck202c = l_xcck202c_sum
   LET g_xcck_d[l_ac].xcck202d = l_xcck202d_sum
   LET g_xcck_d[l_ac].xcck202e = l_xcck202e_sum
   LET g_xcck_d[l_ac].xcck202f = l_xcck202f_sum
   LET g_xcck_d[l_ac].xcck202g = l_xcck202g_sum
   LET g_xcck_d[l_ac].xcck202h = l_xcck202h_sum
   LET g_xcck_d[l_ac].xcck202  = l_xcck202_sum
   LET l_ac = l_ac + 1
   #合计
   #150902-00008#7-Start-Mark
   ##fengmy 150109 modify--begin
   #LET g_xcck_d[l_ac].xcck002 = cl_getmsg("axc-00204",g_lang)
   #CALL cl_get_para(g_enterprise,g_xcck_m.xcckcomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
   #IF g_para_data = 'Y' THEN
   #   LET g_xcck_d[l_ac].xcck002 = cl_getmsg("axc-00204",g_lang)
   #ELSE
   #   LET g_xcck_d[l_ac].xcck025 = cl_getmsg("axc-00204",g_lang)
   #END IF
   ##fengmy 150109 modify--begin
   #150902-00008#7-End-Mark
   LET g_xcck_d[l_ac].imag011 = cl_getmsg("axc-00204",g_lang) #150902-00008#7 add
   LET g_xcck_d[l_ac].xcck201  = l_xcck201_total              #150902-00008#7 add
   LET g_xcck_d[l_ac].xcck202a = l_xcck202a_total
   LET g_xcck_d[l_ac].xcck202b = l_xcck202b_total
   LET g_xcck_d[l_ac].xcck202c = l_xcck202c_total
   LET g_xcck_d[l_ac].xcck202d = l_xcck202d_total
   LET g_xcck_d[l_ac].xcck202e = l_xcck202e_total
   LET g_xcck_d[l_ac].xcck202f = l_xcck202f_total
   LET g_xcck_d[l_ac].xcck202g = l_xcck202g_total
   LET g_xcck_d[l_ac].xcck202h = l_xcck202h_total
   LET g_xcck_d[l_ac].xcck202  = l_xcck202_total
   LET l_ac = l_ac + 1
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_xcck_d.getLength()
      LET g_xcck_d_mask_o[l_ac].* =  g_xcck_d[l_ac].*
      CALL axcq509_xcck_t_mask()
      LET g_xcck_d_mask_n[l_ac].* =  g_xcck_d[l_ac].*
   END FOR
   
   FREE axcq509_pb1
   
END FUNCTION

################################################################################
# Descriptions...: 加上二次篩選功能
# Memo...........: #151130-00003#9   15/11/30   By earl
# Usage..........: CALL axcq509_filter()
#                  
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 151130 By earl
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq509_filter()
   DEFINE ls_result        STRING
   
   LET l_ac = 1
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1

   LET INT_FLAG = 0

   LET g_qryparam.state = 'c'

   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)

   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      CONSTRUCT g_wc_filter ON xcck002,xcck025,xcck006,xcck007,xcck008,
                               xcck009,xcck013,xcck010,xcck011,xcck047,
                               xcck015,xcck017,xcck044,xcck201,xcck282a,
                               xcck282b,xcck282c,xcck282d,xcck282e,xcck282f,
                               xcck282g,xcck282h,xcck282,xcck202a,xcck202b,
                               xcck202c,xcck202d,xcck202e,xcck202f,xcck202g, 
                               xcck202h,xcck202
           FROM s_detail1[1].xcck002,s_detail1[1].xcck025,s_detail1[1].xcck006,s_detail1[1].xcck007,s_detail1[1].xcck008,
                s_detail1[1].xcck009,s_detail1[1].xcck013,s_detail1[1].xcck010,s_detail1[1].xcck011,s_detail1[1].xcck047,
                s_detail1[1].xcck015,s_detail1[1].xcck017,s_detail1[1].xcck044,s_detail1[1].xcck201,s_detail1[1].xcck282a,
                s_detail1[1].xcck282b,s_detail1[1].xcck282c,s_detail1[1].xcck282d,s_detail1[1].xcck282e,s_detail1[1].xcck282f, 
                s_detail1[1].xcck282g,s_detail1[1].xcck282h,s_detail1[1].xcck282,s_detail1[1].xcck202a,s_detail1[1].xcck202b,
                s_detail1[1].xcck202c,s_detail1[1].xcck202d,s_detail1[1].xcck202e,s_detail1[1].xcck202f,s_detail1[1].xcck202g,
                s_detail1[1].xcck202h,s_detail1[1].xcck202 

         BEFORE CONSTRUCT
            DISPLAY axcq509_filter_parser('xcck002') TO s_detail1[1].xcck002
            DISPLAY axcq509_filter_parser('xcck025') TO s_detail1[1].xcck025
            DISPLAY axcq509_filter_parser('xcck006') TO s_detail1[1].xcck006
            DISPLAY axcq509_filter_parser('xcck007') TO s_detail1[1].xcck007
            DISPLAY axcq509_filter_parser('xcck008') TO s_detail1[1].xcck008
            DISPLAY axcq509_filter_parser('xcck009') TO s_detail1[1].xcck009
            DISPLAY axcq509_filter_parser('xcck013') TO s_detail1[1].xcck013
            DISPLAY axcq509_filter_parser('xcck010') TO s_detail1[1].xcck010
            DISPLAY axcq509_filter_parser('xcck011') TO s_detail1[1].xcck011
            DISPLAY axcq509_filter_parser('xcck047') TO s_detail1[1].xcck047
            DISPLAY axcq509_filter_parser('xcck015') TO s_detail1[1].xcck015
            DISPLAY axcq509_filter_parser('xcck017') TO s_detail1[1].xcck017
            DISPLAY axcq509_filter_parser('xcck044') TO s_detail1[1].xcck044
            DISPLAY axcq509_filter_parser('xcck201') TO s_detail1[1].xcck201
            DISPLAY axcq509_filter_parser('xcck282a') TO s_detail1[1].xcck282a
            DISPLAY axcq509_filter_parser('xcck282b') TO s_detail1[1].xcck282b
            DISPLAY axcq509_filter_parser('xcck282c') TO s_detail1[1].xcck282c
            DISPLAY axcq509_filter_parser('xcck282d') TO s_detail1[1].xcck282d
            DISPLAY axcq509_filter_parser('xcck282e') TO s_detail1[1].xcck282e
            DISPLAY axcq509_filter_parser('xcck282f') TO s_detail1[1].xcck282f
            DISPLAY axcq509_filter_parser('xcck282g') TO s_detail1[1].xcck282g
            DISPLAY axcq509_filter_parser('xcck282h') TO s_detail1[1].xcck282h
            DISPLAY axcq509_filter_parser('xcck282') TO s_detail1[1].xcck282
            DISPLAY axcq509_filter_parser('xcck202a') TO s_detail1[1].xcck202a
            DISPLAY axcq509_filter_parser('xcck202b') TO s_detail1[1].xcck202b
            DISPLAY axcq509_filter_parser('xcck202c') TO s_detail1[1].xcck202c
            DISPLAY axcq509_filter_parser('xcck202d') TO s_detail1[1].xcck202d
            DISPLAY axcq509_filter_parser('xcck202e') TO s_detail1[1].xcck202e
            DISPLAY axcq509_filter_parser('xcck202f') TO s_detail1[1].xcck202f
            DISPLAY axcq509_filter_parser('xcck202g') TO s_detail1[1].xcck202g
            DISPLAY axcq509_filter_parser('xcck202h') TO s_detail1[1].xcck202h
            DISPLAY axcq509_filter_parser('xcck202') TO s_detail1[1].xcck202 
            
         ON ACTION controlp INFIELD xcck002
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcbf001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck002  #顯示到畫面上            
            NEXT FIELD xcck002                     #返回原欄位

         ON ACTION controlp INFIELD xcck025
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck025  #顯示到畫面上
            NEXT FIELD xcck025                     #返回原欄位
    
         ON ACTION controlp INFIELD xcck006
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " inbastus = 'S'"
            CALL q_inbadocno_2()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck006  #顯示到畫面上            
            NEXT FIELD xcck006                     #返回原欄位
            
         ON ACTION controlp INFIELD xcck010
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_imaf001_15()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck010  #顯示到畫面上
            NEXT FIELD xcck010                     #返回原欄位
 
         ON ACTION controlp INFIELD xcck047
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_sfec001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck047  #顯示到畫面上
            NEXT FIELD xcck047                     #返回原欄位

         ON ACTION controlp INFIELD xcck015
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_inaa001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck015  #顯示到畫面上
            NEXT FIELD xcck015                     #返回原欄位

         ON ACTION controlp INFIELD xcck044
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck044  #顯示到畫面上
            NEXT FIELD xcck044                     #返回原欄位
      
      END CONSTRUCT
   
   BEFORE DIALOG

      ON ACTION accept
         ACCEPT DIALOG

      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
      
      &include "common_action.4gl"
         CONTINUE DIALOG

   END DIALOG

   IF NOT INT_FLAG THEN
      LET g_wc_filter = g_wc_filter, " "
      LET g_wc_filter_t = g_wc_filter
   ELSE
      LET g_wc_filter = g_wc_filter_t
   END IF
   
   IF cl_null(g_wc_filter) THEN
      LET g_wc_filter = '1=1'
   END IF
   
   
   IF NOT cl_null(g_wc_filter) THEN
      IF cl_null(g_wc) THEN
         LET g_wc = g_wc_filter
      ELSE
         LET g_wc = g_wc," AND ",g_wc_filter
      END IF
   END IF
   
   CALL axcq509_browser_fill("")
   
   LET g_wc = g_wc_t
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
END FUNCTION

################################################################################
# Descriptions...: filter欄位解析
# Memo...........: #151130-00003#9   15/11/30   By earl
# Usage..........: CALL axcq509_filter_parser(ps_field)
#                  RETURNING ls_var
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 151130 By earl
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq509_filter_parser(ps_field)
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
   
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
 
