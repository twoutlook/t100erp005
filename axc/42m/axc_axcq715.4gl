#該程式未解開Section, 採用最新樣板產出!
{<section id="axcq715.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2014-11-03 11:30:35), PR版次:0006(2016-10-21 16:17:19)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000060
#+ Filename...: axcq715
#+ Description: 拆件工單成本次要素查詢作業
#+ Creator....: 03297(2014-10-23 14:29:45)
#+ Modifier...: 03297 -SD/PR- 02294
 
{</section>}
 
{<section id="axcq715.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#10   2016/04/22 By 07675       將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160414-00018#55   2016/05/23 By earl        效能改善
#160802-00020#8    2016/08/16 By dorislai    增加帳套權限管控、法人權限管控
#161019-00017#6    2016/10/21 By lixiang  调整组织栏位的开窗
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
PRIVATE type type_g_xcdk_m        RECORD
       xcdkcomp LIKE xcdk_t.xcdkcomp, 
   xcdkcomp_desc LIKE type_t.chr80, 
   xcdk004 LIKE xcdk_t.xcdk004, 
   xcdk001 LIKE xcdk_t.xcdk001, 
   xcdk001_desc LIKE type_t.chr80, 
   xcdkld LIKE xcdk_t.xcdkld, 
   xcdkld_desc LIKE type_t.chr80, 
   xcdk005 LIKE xcdk_t.xcdk005, 
   xcdk003 LIKE xcdk_t.xcdk003, 
   xcdk003_desc LIKE type_t.chr80
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_xcdk_d        RECORD
       xcdksite LIKE xcdk_t.xcdksite, 
   xcdksite_desc LIKE type_t.chr500, 
   xcdk014 LIKE xcdk_t.xcdk014, 
   xcdk047 LIKE xcdk_t.xcdk047, 
   xcdk006 LIKE xcdk_t.xcdk006, 
   xcdk007 LIKE xcdk_t.xcdk007, 
   xcdk008 LIKE xcdk_t.xcdk008, 
   xcdk025 LIKE xcdk_t.xcdk025, 
   xcdk021 LIKE xcdk_t.xcdk021, 
   xcdk011 LIKE xcdk_t.xcdk011, 
   xcdk011_desc LIKE type_t.chr500, 
   xcdk011_desc_desc LIKE type_t.chr500, 
   xcdk010 LIKE xcdk_t.xcdk010, 
   xcdk010_desc LIKE type_t.chr500, 
   xcdk012 LIKE xcdk_t.xcdk012, 
   xcdk016 LIKE xcdk_t.xcdk016, 
   xcdk016_desc LIKE type_t.chr500, 
   xcdk018 LIKE xcdk_t.xcdk018, 
   xcdk002 LIKE xcdk_t.xcdk002, 
   xcdk002_desc LIKE type_t.chr500, 
   xcdk009 LIKE xcdk_t.xcdk009, 
   xcdk022 LIKE xcdk_t.xcdk022, 
   xcdk023 LIKE xcdk_t.xcdk023, 
   xcdk024 LIKE xcdk_t.xcdk024, 
   xcdk026 LIKE xcdk_t.xcdk026, 
   xcdk027 LIKE xcdk_t.xcdk027, 
   xcdk028 LIKE xcdk_t.xcdk028, 
   xcdk029 LIKE xcdk_t.xcdk029, 
   xcdk030 LIKE xcdk_t.xcdk030, 
   xcdk031 LIKE xcdk_t.xcdk031, 
   xcdk048 LIKE xcdk_t.xcdk048, 
   xcdk049 LIKE xcdk_t.xcdk049, 
   xcdk050 LIKE xcdk_t.xcdk050, 
   xcdk051 LIKE xcdk_t.xcdk051, 
   xcdk201 LIKE xcdk_t.xcdk201, 
   l_xcdk202a LIKE type_t.num20_6, 
   l_xcdk202b LIKE type_t.num20_6, 
   l_xcdk202c LIKE type_t.num20_6, 
   l_xcdk202d LIKE type_t.num20_6, 
   l_xcdk202e LIKE type_t.num20_6, 
   l_xcdk202f LIKE type_t.num20_6, 
   l_xcdk202g LIKE type_t.num20_6, 
   l_xcdk202h LIKE type_t.num20_6, 
   xcdk202 LIKE xcdk_t.xcdk202
       END RECORD
PRIVATE TYPE type_g_xcdk2_d RECORD
       xcdkownid LIKE xcdk_t.xcdkownid, 
   xcdkownid_desc LIKE type_t.chr500, 
   xcdkowndp LIKE xcdk_t.xcdkowndp, 
   xcdkowndp_desc LIKE type_t.chr500, 
   xcdkcrtid LIKE xcdk_t.xcdkcrtid, 
   xcdkcrtid_desc LIKE type_t.chr500, 
   xcdkcrtdp LIKE xcdk_t.xcdkcrtdp, 
   xcdkcrtdp_desc LIKE type_t.chr500, 
   xcdkcrtdt DATETIME YEAR TO SECOND, 
   xcdkmodid LIKE xcdk_t.xcdkmodid, 
   xcdkmodid_desc LIKE type_t.chr500, 
   xcdkmoddt DATETIME YEAR TO SECOND, 
   xcdk002 LIKE xcdk_t.xcdk002, 
   xcdk006 LIKE xcdk_t.xcdk006, 
   xcdk007 LIKE xcdk_t.xcdk007, 
   xcdk008 LIKE xcdk_t.xcdk008, 
   xcdk009 LIKE xcdk_t.xcdk009, 
   xcdk010 LIKE xcdk_t.xcdk010
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_para_data           LIKE type_t.chr80     #采用成本域否  #fengmy150113
DEFINE g_para_data1          LIKE type_t.chr80     #采用特性否    #fengmy150113
DEFINE g_wc_cs_ld            STRING                #160802-00020#8-add
DEFINE g_wc_cs_comp          STRING                #160802-00020#8-add
#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_xcdk_m          type_g_xcdk_m
DEFINE g_xcdk_m_t        type_g_xcdk_m
DEFINE g_xcdk_m_o        type_g_xcdk_m
DEFINE g_xcdk_m_mask_o   type_g_xcdk_m #轉換遮罩前資料
DEFINE g_xcdk_m_mask_n   type_g_xcdk_m #轉換遮罩後資料
 
   DEFINE g_xcdk004_t LIKE xcdk_t.xcdk004
DEFINE g_xcdk001_t LIKE xcdk_t.xcdk001
DEFINE g_xcdkld_t LIKE xcdk_t.xcdkld
DEFINE g_xcdk005_t LIKE xcdk_t.xcdk005
DEFINE g_xcdk003_t LIKE xcdk_t.xcdk003
 
 
DEFINE g_xcdk_d          DYNAMIC ARRAY OF type_g_xcdk_d
DEFINE g_xcdk_d_t        type_g_xcdk_d
DEFINE g_xcdk_d_o        type_g_xcdk_d
DEFINE g_xcdk_d_mask_o   DYNAMIC ARRAY OF type_g_xcdk_d #轉換遮罩前資料
DEFINE g_xcdk_d_mask_n   DYNAMIC ARRAY OF type_g_xcdk_d #轉換遮罩後資料
DEFINE g_xcdk2_d   DYNAMIC ARRAY OF type_g_xcdk2_d
DEFINE g_xcdk2_d_t type_g_xcdk2_d
DEFINE g_xcdk2_d_o type_g_xcdk2_d
DEFINE g_xcdk2_d_mask_o   DYNAMIC ARRAY OF type_g_xcdk2_d #轉換遮罩前資料
DEFINE g_xcdk2_d_mask_n   DYNAMIC ARRAY OF type_g_xcdk2_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_xcdkld LIKE xcdk_t.xcdkld,
      b_xcdk001 LIKE xcdk_t.xcdk001,
      b_xcdk003 LIKE xcdk_t.xcdk003,
      b_xcdk004 LIKE xcdk_t.xcdk004,
      b_xcdk005 LIKE xcdk_t.xcdk005
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
 
{<section id="axcq715.main" >}
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
   #160802-00020#8-add-(S)
   CALL s_fin_create_account_center_tmp()                      #展組織下階成員所需之暫存檔 
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_ld_str() RETURNING g_wc_cs_ld
   CALL s_fin_get_wc_str(g_wc_cs_ld)  RETURNING g_wc_cs_ld
   CALL s_axc_get_authcomp() RETURNING g_wc_cs_comp            #抓取使用者有拜訪權限據點的對應法人  
   #160802-00020#8-add-(E)
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT xcdkcomp,'',xcdk004,xcdk001,'',xcdkld,'',xcdk005,xcdk003,''", 
                      " FROM xcdk_t",
                      " WHERE xcdkent= ? AND xcdkld=? AND xcdk001=? AND xcdk003=? AND xcdk004=? AND  
                          xcdk005=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axcq715_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.xcdkcomp,t0.xcdk004,t0.xcdk001,t0.xcdkld,t0.xcdk005,t0.xcdk003,t1.ooefl003 , 
       t2.glaal002 ,t3.xcatl003",
               " FROM xcdk_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.xcdkcomp AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN glaal_t t2 ON t2.glaalent="||g_enterprise||" AND t2.glaalld=t0.xcdkld AND t2.glaal001='"||g_dlang||"' ",
               " LEFT JOIN xcatl_t t3 ON t3.xcatlent="||g_enterprise||" AND t3.xcatl001=t0.xcdk003 AND t3.xcatl002='"||g_dlang||"' ",
 
               " WHERE t0.xcdkent = " ||g_enterprise|| " AND t0.xcdkld = ? AND t0.xcdk001 = ? AND t0.xcdk003 = ? AND t0.xcdk004 = ? AND t0.xcdk005 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axcq715_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axcq715 WITH FORM cl_ap_formpath("axc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axcq715_init()   
 
      #進入選單 Menu (="N")
      CALL axcq715_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axcq715
      
   END IF 
   
   CLOSE axcq715_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axcq715.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axcq715_init()
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
   CALL cl_set_combo_scc('xcdk001','8914')
   #fengmy 150113----begin
   #根據參數顯示隱藏成本域 和 料件特性
   CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
   CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data1  #采用特性否       
         
   IF g_para_data = 'Y' THEN
      CALL cl_set_comp_visible('xcdk002,xcdk002_desc',TRUE)                    
   ELSE                        
      CALL cl_set_comp_visible('xcdk002,xcdk002_desc',FALSE)                
   END IF   
   IF g_para_data1 = 'Y' THEN
      CALL cl_set_comp_visible('xcdk012',TRUE)                    
   ELSE                       
      CALL cl_set_comp_visible('xcdk012',FALSE)                
   END IF   
   #fengmy 150113----end   
   #end add-point
   
   CALL axcq715_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="axcq715.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION axcq715_ui_dialog()
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
         INITIALIZE g_xcdk_m.* TO NULL
         CALL g_xcdk_d.clear()
         CALL g_xcdk2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL axcq715_init()
      END IF
 
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
        
         DISPLAY ARRAY g_xcdk_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL axcq715_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL axcq715_ui_detailshow()
               
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
        
         DISPLAY ARRAY g_xcdk2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL axcq715_idx_chk()
               CALL axcq715_ui_detailshow()
               
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
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         
         BEFORE DIALOG
            #先填充browser資料
            CALL axcq715_browser_fill("")
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
               CALL axcq715_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL axcq715_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL axcq715_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq715_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL axcq715_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq715_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL axcq715_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq715_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL axcq715_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq715_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL axcq715_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq715_idx_chk()
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
                  LET g_export_node[1] = base.typeInfo.create(g_xcdk_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_xcdk2_d)
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
               NEXT FIELD xcdk002
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
               CALL axcq715_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL axcq715_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL axcq715_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
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
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axcq715_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN
               
               #add-point:ON ACTION datainfo name="menu.datainfo"
               
               #END add-point
               
            END IF
 
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL axcq715_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL axcq715_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL axcq715_set_pk_array()
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
 
{<section id="axcq715.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION axcq715_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axcq715.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION axcq715_browser_fill(ps_page_action)
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
 
   LET l_searchcol = "xcdkld,xcdk001,xcdk003,xcdk004,xcdk005"
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
      LET l_sub_sql = " SELECT DISTINCT xcdkld ",
                      ", xcdk001 ",
                      ", xcdk003 ",
                      ", xcdk004 ",
                      ", xcdk005 ",
 
                      " FROM xcdk_t ",
                      " ",
                      " ", 
 
 
 
                      " WHERE xcdkent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("xcdk_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT xcdkld ",
                      ", xcdk001 ",
                      ", xcdk003 ",
                      ", xcdk004 ",
                      ", xcdk005 ",
 
                      " FROM xcdk_t ",
                      " ",
                      " ", 
 
 
                      " WHERE xcdkent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("xcdk_t")
   END IF 
   
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
 
   #add-point:browser_fill,count前 name="browser_fill.before_count"
   IF l_wc2 <> " 1=1" OR NOT cl_null(l_wc2) THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT UNIQUE xcdkld ",
                      ", xcdk001 ",
                      ", xcdk003 ",
                      ", xcdk004 ",
                      ", xcdk005 ",
 
                      " FROM xcdk_t ",
                      " ",
                      " ",
 
                      " WHERE xcdkent = '" ||g_enterprise|| "' AND ",l_wc, " AND ", l_wc2, 
                      "   AND xcdk020 IN ('113','106') ",cl_sql_add_filter("xcdk_t")
#                     "   AND xcdk055 = '2052' ",cl_sql_add_filter("xcdk_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE xcdkld ",
                      ", xcdk001 ",
                      ", xcdk003 ",
                      ", xcdk004 ",
                      ", xcdk005 ",
 
                      " FROM xcdk_t ",
                      " ",
                      " ",
                   #  " WHERE xcdkent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED, "   AND xcdk055 = '2052' ",cl_sql_add_filter("xcdk_t")          #wuxja mark
                      " WHERE xcdkent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED, "   AND xcdk020 IN ('113','106')  ",cl_sql_add_filter("xcdk_t") #wuxja add
   END IF 
   
   #160802-00020#8-add-(S)
   #---增加帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET l_sub_sql = l_sub_sql ," AND xcdkld IN ",g_wc_cs_ld
    END IF
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET l_sub_sql = l_sub_sql ," AND xcdkcomp IN ",g_wc_cs_comp
   END IF
   #160802-00020#8-add-(E)
   
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
      INITIALIZE g_xcdk_m.* TO NULL
      CALL g_xcdk_d.clear()        
      CALL g_xcdk2_d.clear() 
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.xcdkld,t0.xcdk001,t0.xcdk003,t0.xcdk004,t0.xcdk005 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.xcdkld,t0.xcdk001,t0.xcdk003,t0.xcdk004,t0.xcdk005",
                " FROM xcdk_t t0",
                #" ",
                " ",
 
 
 
                
                " WHERE t0.xcdkent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("xcdk_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
   LET g_sql  = "SELECT DISTINCT t0.xcdkld,t0.xcdk001,t0.xcdk003,t0.xcdk004,t0.xcdk005",
                " FROM xcdk_t t0",
 
                
              # " WHERE t0.xcdkent = '" ||g_enterprise|| "' AND ", l_wc," AND ",l_wc2,"   AND xcdk055 = '2052' ", cl_sql_add_filter("xcdk_t")
                " WHERE t0.xcdkent = '" ||g_enterprise|| "' AND ", l_wc," AND ",l_wc2,"   AND xcdk020 IN ('113','106') ", cl_sql_add_filter("xcdk_t")
   
   #160802-00020#8-add-(S)
   #---增加帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET g_sql = g_sql ," AND xcdkld IN ",g_wc_cs_ld
    END IF
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET g_sql = g_sql ," AND xcdkcomp IN ",g_wc_cs_comp
   END IF
   #160802-00020#8-add-(E)             
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"xcdk_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_xcdkld,g_browser[g_cnt].b_xcdk001,g_browser[g_cnt].b_xcdk003, 
          g_browser[g_cnt].b_xcdk004,g_browser[g_cnt].b_xcdk005 
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
   
   IF cl_null(g_browser[g_cnt].b_xcdkld) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_xcdk_m.* TO NULL
      CALL g_xcdk_d.clear()
      CALL g_xcdk2_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL axcq715_fetch('')
   
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
 
{<section id="axcq715.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION axcq715_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_xcdk_m.xcdkld = g_browser[g_current_idx].b_xcdkld   
   LET g_xcdk_m.xcdk001 = g_browser[g_current_idx].b_xcdk001   
   LET g_xcdk_m.xcdk003 = g_browser[g_current_idx].b_xcdk003   
   LET g_xcdk_m.xcdk004 = g_browser[g_current_idx].b_xcdk004   
   LET g_xcdk_m.xcdk005 = g_browser[g_current_idx].b_xcdk005   
 
   EXECUTE axcq715_master_referesh USING g_xcdk_m.xcdkld,g_xcdk_m.xcdk001,g_xcdk_m.xcdk003,g_xcdk_m.xcdk004, 
       g_xcdk_m.xcdk005 INTO g_xcdk_m.xcdkcomp,g_xcdk_m.xcdk004,g_xcdk_m.xcdk001,g_xcdk_m.xcdkld,g_xcdk_m.xcdk005, 
       g_xcdk_m.xcdk003,g_xcdk_m.xcdkcomp_desc,g_xcdk_m.xcdkld_desc,g_xcdk_m.xcdk003_desc
   CALL axcq715_show()
   
END FUNCTION
 
{</section>}
 
{<section id="axcq715.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION axcq715_ui_detailshow()
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
 
{<section id="axcq715.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION axcq715_ui_browser_refresh()
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
      IF g_browser[l_i].b_xcdkld = g_xcdk_m.xcdkld 
         AND g_browser[l_i].b_xcdk001 = g_xcdk_m.xcdk001 
         AND g_browser[l_i].b_xcdk003 = g_xcdk_m.xcdk003 
         AND g_browser[l_i].b_xcdk004 = g_xcdk_m.xcdk004 
         AND g_browser[l_i].b_xcdk005 = g_xcdk_m.xcdk005 
 
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
 
{<section id="axcq715.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION axcq715_construct()
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
   INITIALIZE g_xcdk_m.* TO NULL
   CALL g_xcdk_d.clear()
   CALL g_xcdk2_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON xcdkcomp,xcdk004,xcdk001,xcdkld,xcdk005,xcdk003
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            CALL axcq715_default()
            #end add-point 
            
                 #Ctrlp:construct.c.xcdkcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdkcomp
            #add-point:ON ACTION controlp INFIELD xcdkcomp name="construct.c.xcdkcomp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #160802-00020#8-add-(S)
      	   #增加法人過濾條件
            IF NOT cl_null(g_wc_cs_comp) THEN
               LET g_qryparam.where = " ooef001 IN ",g_wc_cs_comp
            END IF
            #160802-00020#8-add-(E)
            #CALL q_ooef001()                           #呼叫開窗 #161019-00017#6
            CALL q_ooef001_2()   #161019-00017#6
            DISPLAY g_qryparam.return1 TO xcdkcomp  #顯示到畫面上
            NEXT FIELD xcdkcomp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdkcomp
            #add-point:BEFORE FIELD xcdkcomp name="construct.b.xcdkcomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdkcomp
            
            #add-point:AFTER FIELD xcdkcomp name="construct.a.xcdkcomp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk004
            #add-point:BEFORE FIELD xcdk004 name="construct.b.xcdk004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk004
            
            #add-point:AFTER FIELD xcdk004 name="construct.a.xcdk004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcdk004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk004
            #add-point:ON ACTION controlp INFIELD xcdk004 name="construct.c.xcdk004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk001
            #add-point:BEFORE FIELD xcdk001 name="construct.b.xcdk001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk001
            
            #add-point:AFTER FIELD xcdk001 name="construct.a.xcdk001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcdk001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk001
            #add-point:ON ACTION controlp INFIELD xcdk001 name="construct.c.xcdk001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xcdkld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdkld
            #add-point:ON ACTION controlp INFIELD xcdkld name="construct.c.xcdkld"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            #160802-00020#8-add-(S)
            #增加帳套權限控制
            IF NOT cl_null(g_wc_cs_ld) THEN
               LET g_qryparam.where = " glaald IN ",g_wc_cs_ld
            END IF
            #160802-00020#8-add-(E)
            CALL q_authorised_ld()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcdkld  #顯示到畫面上
            NEXT FIELD xcdkld                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdkld
            #add-point:BEFORE FIELD xcdkld name="construct.b.xcdkld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdkld
            
            #add-point:AFTER FIELD xcdkld name="construct.a.xcdkld"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk005
            #add-point:BEFORE FIELD xcdk005 name="construct.b.xcdk005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk005
            
            #add-point:AFTER FIELD xcdk005 name="construct.a.xcdk005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcdk005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk005
            #add-point:ON ACTION controlp INFIELD xcdk005 name="construct.c.xcdk005"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xcdk003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk003
            #add-point:ON ACTION controlp INFIELD xcdk003 name="construct.c.xcdk003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcat001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcdk003  #顯示到畫面上
            NEXT FIELD xcdk003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk003
            #add-point:BEFORE FIELD xcdk003 name="construct.b.xcdk003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk003
            
            #add-point:AFTER FIELD xcdk003 name="construct.a.xcdk003"
            
            #END add-point
            
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON xcdksite,xcdk014,xcdk047,xcdk006,xcdk007,xcdk008,xcdk025,xcdk021,xcdk011, 
          xcdk010,xcdk012,xcdk016,xcdk018,xcdk002,xcdk009,xcdk022,xcdk023,xcdk024,xcdk026,xcdk027,xcdk028, 
          xcdk029,xcdk030,xcdk031,xcdk048,xcdk049,xcdk050,xcdk051,xcdk201,l_xcdk202a,l_xcdk202b,l_xcdk202c, 
          l_xcdk202d,l_xcdk202e,l_xcdk202f,l_xcdk202g,l_xcdk202h,xcdk202,xcdkownid,xcdkowndp,xcdkcrtid, 
          xcdkcrtdp,xcdkcrtdt,xcdkmodid,xcdkmoddt
           FROM s_detail1[1].xcdksite,s_detail1[1].xcdk014,s_detail1[1].xcdk047,s_detail1[1].xcdk006, 
               s_detail1[1].xcdk007,s_detail1[1].xcdk008,s_detail1[1].xcdk025,s_detail1[1].xcdk021,s_detail1[1].xcdk011, 
               s_detail1[1].xcdk010,s_detail1[1].xcdk012,s_detail1[1].xcdk016,s_detail1[1].xcdk018,s_detail1[1].xcdk002, 
               s_detail1[1].xcdk009,s_detail1[1].xcdk022,s_detail1[1].xcdk023,s_detail1[1].xcdk024,s_detail1[1].xcdk026, 
               s_detail1[1].xcdk027,s_detail1[1].xcdk028,s_detail1[1].xcdk029,s_detail1[1].xcdk030,s_detail1[1].xcdk031, 
               s_detail1[1].xcdk048,s_detail1[1].xcdk049,s_detail1[1].xcdk050,s_detail1[1].xcdk051,s_detail1[1].xcdk201, 
               s_detail1[1].l_xcdk202a,s_detail1[1].l_xcdk202b,s_detail1[1].l_xcdk202c,s_detail1[1].l_xcdk202d, 
               s_detail1[1].l_xcdk202e,s_detail1[1].l_xcdk202f,s_detail1[1].l_xcdk202g,s_detail1[1].l_xcdk202h, 
               s_detail1[1].xcdk202,s_detail2[1].xcdkownid,s_detail2[1].xcdkowndp,s_detail2[1].xcdkcrtid, 
               s_detail2[1].xcdkcrtdp,s_detail2[1].xcdkcrtdt,s_detail2[1].xcdkmodid,s_detail2[1].xcdkmoddt 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<xcdkcrtdt>>----
         AFTER FIELD xcdkcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<xcdkmoddt>>----
         AFTER FIELD xcdkmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<xcdkcnfdt>>----
         
         #----<<xcdkpstdt>>----
 
 
 
           
         #單身一般欄位開窗相關處理
                  #Ctrlp:construct.c.page1.xcdksite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdksite
            #add-point:ON ACTION controlp INFIELD xcdksite name="construct.c.page1.xcdksite"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()                           #呼叫開窗 #161019-00017#6
            CALL q_ooef001_1()   #161019-00017#6
            DISPLAY g_qryparam.return1 TO xcdksite  #顯示到畫面上
            NEXT FIELD xcdksite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdksite
            #add-point:BEFORE FIELD xcdksite name="construct.b.page1.xcdksite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdksite
            
            #add-point:AFTER FIELD xcdksite name="construct.a.page1.xcdksite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk014
            #add-point:BEFORE FIELD xcdk014 name="construct.b.page1.xcdk014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk014
            
            #add-point:AFTER FIELD xcdk014 name="construct.a.page1.xcdk014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcdk014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk014
            #add-point:ON ACTION controlp INFIELD xcdk014 name="construct.c.page1.xcdk014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk047
            #add-point:BEFORE FIELD xcdk047 name="construct.b.page1.xcdk047"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk047
            
            #add-point:AFTER FIELD xcdk047 name="construct.a.page1.xcdk047"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcdk047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk047
            #add-point:ON ACTION controlp INFIELD xcdk047 name="construct.c.page1.xcdk047"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xcdk006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk006
            #add-point:ON ACTION controlp INFIELD xcdk006 name="construct.c.page1.xcdk006"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inbadocno_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcdk006  #顯示到畫面上
            NEXT FIELD xcdk006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk006
            #add-point:BEFORE FIELD xcdk006 name="construct.b.page1.xcdk006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk006
            
            #add-point:AFTER FIELD xcdk006 name="construct.a.page1.xcdk006"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk007
            #add-point:BEFORE FIELD xcdk007 name="construct.b.page1.xcdk007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk007
            
            #add-point:AFTER FIELD xcdk007 name="construct.a.page1.xcdk007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcdk007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk007
            #add-point:ON ACTION controlp INFIELD xcdk007 name="construct.c.page1.xcdk007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk008
            #add-point:BEFORE FIELD xcdk008 name="construct.b.page1.xcdk008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk008
            
            #add-point:AFTER FIELD xcdk008 name="construct.a.page1.xcdk008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcdk008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk008
            #add-point:ON ACTION controlp INFIELD xcdk008 name="construct.c.page1.xcdk008"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xcdk025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk025
            #add-point:ON ACTION controlp INFIELD xcdk025 name="construct.c.page1.xcdk025"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcdk025  #顯示到畫面上
            NEXT FIELD xcdk025                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk025
            #add-point:BEFORE FIELD xcdk025 name="construct.b.page1.xcdk025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk025
            
            #add-point:AFTER FIELD xcdk025 name="construct.a.page1.xcdk025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcdk021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk021
            #add-point:ON ACTION controlp INFIELD xcdk021 name="construct.c.page1.xcdk021"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcdk021  #顯示到畫面上
            NEXT FIELD xcdk021                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk021
            #add-point:BEFORE FIELD xcdk021 name="construct.b.page1.xcdk021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk021
            
            #add-point:AFTER FIELD xcdk021 name="construct.a.page1.xcdk021"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk011
            #add-point:BEFORE FIELD xcdk011 name="construct.b.page1.xcdk011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk011
            
            #add-point:AFTER FIELD xcdk011 name="construct.a.page1.xcdk011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcdk011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk011
            #add-point:ON ACTION controlp INFIELD xcdk011 name="construct.c.page1.xcdk011"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xcdk010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk010
            #add-point:ON ACTION controlp INFIELD xcdk010 name="construct.c.page1.xcdk010"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcau001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcdk010  #顯示到畫面上
            NEXT FIELD xcdk010                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk010
            #add-point:BEFORE FIELD xcdk010 name="construct.b.page1.xcdk010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk010
            
            #add-point:AFTER FIELD xcdk010 name="construct.a.page1.xcdk010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcdk012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk012
            #add-point:ON ACTION controlp INFIELD xcdk012 name="construct.c.page1.xcdk012"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcck011()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcdk012  #顯示到畫面上
            NEXT FIELD xcdk012                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk012
            #add-point:BEFORE FIELD xcdk012 name="construct.b.page1.xcdk012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk012
            
            #add-point:AFTER FIELD xcdk012 name="construct.a.page1.xcdk012"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk016
            #add-point:BEFORE FIELD xcdk016 name="construct.b.page1.xcdk016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk016
            
            #add-point:AFTER FIELD xcdk016 name="construct.a.page1.xcdk016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcdk016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk016
            #add-point:ON ACTION controlp INFIELD xcdk016 name="construct.c.page1.xcdk016"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xcdk018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk018
            #add-point:ON ACTION controlp INFIELD xcdk018 name="construct.c.page1.xcdk018"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inaj010()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcdk018  #顯示到畫面上
            NEXT FIELD xcdk018                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk018
            #add-point:BEFORE FIELD xcdk018 name="construct.b.page1.xcdk018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk018
            
            #add-point:AFTER FIELD xcdk018 name="construct.a.page1.xcdk018"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk002
            #add-point:BEFORE FIELD xcdk002 name="construct.b.page1.xcdk002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk002
            
            #add-point:AFTER FIELD xcdk002 name="construct.a.page1.xcdk002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcdk002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk002
            #add-point:ON ACTION controlp INFIELD xcdk002 name="construct.c.page1.xcdk002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk009
            #add-point:BEFORE FIELD xcdk009 name="construct.b.page1.xcdk009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk009
            
            #add-point:AFTER FIELD xcdk009 name="construct.a.page1.xcdk009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcdk009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk009
            #add-point:ON ACTION controlp INFIELD xcdk009 name="construct.c.page1.xcdk009"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xcdk022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk022
            #add-point:ON ACTION controlp INFIELD xcdk022 name="construct.c.page1.xcdk022"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcdk022  #顯示到畫面上
            NEXT FIELD xcdk022                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk022
            #add-point:BEFORE FIELD xcdk022 name="construct.b.page1.xcdk022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk022
            
            #add-point:AFTER FIELD xcdk022 name="construct.a.page1.xcdk022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcdk023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk023
            #add-point:ON ACTION controlp INFIELD xcdk023 name="construct.c.page1.xcdk023"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcdk023  #顯示到畫面上
            NEXT FIELD xcdk023                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk023
            #add-point:BEFORE FIELD xcdk023 name="construct.b.page1.xcdk023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk023
            
            #add-point:AFTER FIELD xcdk023 name="construct.a.page1.xcdk023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcdk024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk024
            #add-point:ON ACTION controlp INFIELD xcdk024 name="construct.c.page1.xcdk024"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcdk024  #顯示到畫面上
            NEXT FIELD xcdk024                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk024
            #add-point:BEFORE FIELD xcdk024 name="construct.b.page1.xcdk024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk024
            
            #add-point:AFTER FIELD xcdk024 name="construct.a.page1.xcdk024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcdk026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk026
            #add-point:ON ACTION controlp INFIELD xcdk026 name="construct.c.page1.xcdk026"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_gzcb001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcdk026  #顯示到畫面上
            NEXT FIELD xcdk026                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk026
            #add-point:BEFORE FIELD xcdk026 name="construct.b.page1.xcdk026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk026
            
            #add-point:AFTER FIELD xcdk026 name="construct.a.page1.xcdk026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcdk027
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk027
            #add-point:ON ACTION controlp INFIELD xcdk027 name="construct.c.page1.xcdk027"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcdk027  #顯示到畫面上
            NEXT FIELD xcdk027                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk027
            #add-point:BEFORE FIELD xcdk027 name="construct.b.page1.xcdk027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk027
            
            #add-point:AFTER FIELD xcdk027 name="construct.a.page1.xcdk027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcdk028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk028
            #add-point:ON ACTION controlp INFIELD xcdk028 name="construct.c.page1.xcdk028"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcdk028  #顯示到畫面上
            NEXT FIELD xcdk028                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk028
            #add-point:BEFORE FIELD xcdk028 name="construct.b.page1.xcdk028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk028
            
            #add-point:AFTER FIELD xcdk028 name="construct.a.page1.xcdk028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcdk029
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk029
            #add-point:ON ACTION controlp INFIELD xcdk029 name="construct.c.page1.xcdk029"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcdk029  #顯示到畫面上
            NEXT FIELD xcdk029                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk029
            #add-point:BEFORE FIELD xcdk029 name="construct.b.page1.xcdk029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk029
            
            #add-point:AFTER FIELD xcdk029 name="construct.a.page1.xcdk029"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcdk030
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk030
            #add-point:ON ACTION controlp INFIELD xcdk030 name="construct.c.page1.xcdk030"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcdk030  #顯示到畫面上
            NEXT FIELD xcdk030                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk030
            #add-point:BEFORE FIELD xcdk030 name="construct.b.page1.xcdk030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk030
            
            #add-point:AFTER FIELD xcdk030 name="construct.a.page1.xcdk030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcdk031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk031
            #add-point:ON ACTION controlp INFIELD xcdk031 name="construct.c.page1.xcdk031"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pjbb002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcdk031  #顯示到畫面上
            NEXT FIELD xcdk031                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk031
            #add-point:BEFORE FIELD xcdk031 name="construct.b.page1.xcdk031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk031
            
            #add-point:AFTER FIELD xcdk031 name="construct.a.page1.xcdk031"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk048
            #add-point:BEFORE FIELD xcdk048 name="construct.b.page1.xcdk048"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk048
            
            #add-point:AFTER FIELD xcdk048 name="construct.a.page1.xcdk048"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcdk048
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk048
            #add-point:ON ACTION controlp INFIELD xcdk048 name="construct.c.page1.xcdk048"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk049
            #add-point:BEFORE FIELD xcdk049 name="construct.b.page1.xcdk049"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk049
            
            #add-point:AFTER FIELD xcdk049 name="construct.a.page1.xcdk049"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcdk049
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk049
            #add-point:ON ACTION controlp INFIELD xcdk049 name="construct.c.page1.xcdk049"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk050
            #add-point:BEFORE FIELD xcdk050 name="construct.b.page1.xcdk050"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk050
            
            #add-point:AFTER FIELD xcdk050 name="construct.a.page1.xcdk050"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcdk050
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk050
            #add-point:ON ACTION controlp INFIELD xcdk050 name="construct.c.page1.xcdk050"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk051
            #add-point:BEFORE FIELD xcdk051 name="construct.b.page1.xcdk051"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk051
            
            #add-point:AFTER FIELD xcdk051 name="construct.a.page1.xcdk051"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcdk051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk051
            #add-point:ON ACTION controlp INFIELD xcdk051 name="construct.c.page1.xcdk051"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk201
            #add-point:BEFORE FIELD xcdk201 name="construct.b.page1.xcdk201"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk201
            
            #add-point:AFTER FIELD xcdk201 name="construct.a.page1.xcdk201"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcdk201
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk201
            #add-point:ON ACTION controlp INFIELD xcdk201 name="construct.c.page1.xcdk201"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xcdk202a
            #add-point:BEFORE FIELD l_xcdk202a name="construct.b.page1.l_xcdk202a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xcdk202a
            
            #add-point:AFTER FIELD l_xcdk202a name="construct.a.page1.l_xcdk202a"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_xcdk202a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xcdk202a
            #add-point:ON ACTION controlp INFIELD l_xcdk202a name="construct.c.page1.l_xcdk202a"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xcdk202b
            #add-point:BEFORE FIELD l_xcdk202b name="construct.b.page1.l_xcdk202b"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xcdk202b
            
            #add-point:AFTER FIELD l_xcdk202b name="construct.a.page1.l_xcdk202b"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_xcdk202b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xcdk202b
            #add-point:ON ACTION controlp INFIELD l_xcdk202b name="construct.c.page1.l_xcdk202b"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xcdk202c
            #add-point:BEFORE FIELD l_xcdk202c name="construct.b.page1.l_xcdk202c"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xcdk202c
            
            #add-point:AFTER FIELD l_xcdk202c name="construct.a.page1.l_xcdk202c"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_xcdk202c
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xcdk202c
            #add-point:ON ACTION controlp INFIELD l_xcdk202c name="construct.c.page1.l_xcdk202c"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xcdk202d
            #add-point:BEFORE FIELD l_xcdk202d name="construct.b.page1.l_xcdk202d"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xcdk202d
            
            #add-point:AFTER FIELD l_xcdk202d name="construct.a.page1.l_xcdk202d"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_xcdk202d
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xcdk202d
            #add-point:ON ACTION controlp INFIELD l_xcdk202d name="construct.c.page1.l_xcdk202d"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xcdk202e
            #add-point:BEFORE FIELD l_xcdk202e name="construct.b.page1.l_xcdk202e"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xcdk202e
            
            #add-point:AFTER FIELD l_xcdk202e name="construct.a.page1.l_xcdk202e"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_xcdk202e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xcdk202e
            #add-point:ON ACTION controlp INFIELD l_xcdk202e name="construct.c.page1.l_xcdk202e"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xcdk202f
            #add-point:BEFORE FIELD l_xcdk202f name="construct.b.page1.l_xcdk202f"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xcdk202f
            
            #add-point:AFTER FIELD l_xcdk202f name="construct.a.page1.l_xcdk202f"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_xcdk202f
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xcdk202f
            #add-point:ON ACTION controlp INFIELD l_xcdk202f name="construct.c.page1.l_xcdk202f"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xcdk202g
            #add-point:BEFORE FIELD l_xcdk202g name="construct.b.page1.l_xcdk202g"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xcdk202g
            
            #add-point:AFTER FIELD l_xcdk202g name="construct.a.page1.l_xcdk202g"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_xcdk202g
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xcdk202g
            #add-point:ON ACTION controlp INFIELD l_xcdk202g name="construct.c.page1.l_xcdk202g"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xcdk202h
            #add-point:BEFORE FIELD l_xcdk202h name="construct.b.page1.l_xcdk202h"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xcdk202h
            
            #add-point:AFTER FIELD l_xcdk202h name="construct.a.page1.l_xcdk202h"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_xcdk202h
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xcdk202h
            #add-point:ON ACTION controlp INFIELD l_xcdk202h name="construct.c.page1.l_xcdk202h"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk202
            #add-point:BEFORE FIELD xcdk202 name="construct.b.page1.xcdk202"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk202
            
            #add-point:AFTER FIELD xcdk202 name="construct.a.page1.xcdk202"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcdk202
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk202
            #add-point:ON ACTION controlp INFIELD xcdk202 name="construct.c.page1.xcdk202"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.xcdkownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdkownid
            #add-point:ON ACTION controlp INFIELD xcdkownid name="construct.c.page2.xcdkownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcdkownid  #顯示到畫面上
            NEXT FIELD xcdkownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdkownid
            #add-point:BEFORE FIELD xcdkownid name="construct.b.page2.xcdkownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdkownid
            
            #add-point:AFTER FIELD xcdkownid name="construct.a.page2.xcdkownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xcdkowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdkowndp
            #add-point:ON ACTION controlp INFIELD xcdkowndp name="construct.c.page2.xcdkowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcdkowndp  #顯示到畫面上
            NEXT FIELD xcdkowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdkowndp
            #add-point:BEFORE FIELD xcdkowndp name="construct.b.page2.xcdkowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdkowndp
            
            #add-point:AFTER FIELD xcdkowndp name="construct.a.page2.xcdkowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xcdkcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdkcrtid
            #add-point:ON ACTION controlp INFIELD xcdkcrtid name="construct.c.page2.xcdkcrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcdkcrtid  #顯示到畫面上
            NEXT FIELD xcdkcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdkcrtid
            #add-point:BEFORE FIELD xcdkcrtid name="construct.b.page2.xcdkcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdkcrtid
            
            #add-point:AFTER FIELD xcdkcrtid name="construct.a.page2.xcdkcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xcdkcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdkcrtdp
            #add-point:ON ACTION controlp INFIELD xcdkcrtdp name="construct.c.page2.xcdkcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcdkcrtdp  #顯示到畫面上
            NEXT FIELD xcdkcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdkcrtdp
            #add-point:BEFORE FIELD xcdkcrtdp name="construct.b.page2.xcdkcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdkcrtdp
            
            #add-point:AFTER FIELD xcdkcrtdp name="construct.a.page2.xcdkcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdkcrtdt
            #add-point:BEFORE FIELD xcdkcrtdt name="construct.b.page2.xcdkcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.xcdkmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdkmodid
            #add-point:ON ACTION controlp INFIELD xcdkmodid name="construct.c.page2.xcdkmodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcdkmodid  #顯示到畫面上
            NEXT FIELD xcdkmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdkmodid
            #add-point:BEFORE FIELD xcdkmodid name="construct.b.page2.xcdkmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdkmodid
            
            #add-point:AFTER FIELD xcdkmodid name="construct.a.page2.xcdkmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdkmoddt
            #add-point:BEFORE FIELD xcdkmoddt name="construct.b.page2.xcdkmoddt"
            
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
 
{<section id="axcq715.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION axcq715_query()
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
   CALL g_xcdk_d.clear()
   CALL g_xcdk2_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL axcq715_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL axcq715_browser_fill(g_wc)
      CALL axcq715_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL axcq715_browser_fill("F")
   
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
      CALL axcq715_fetch("F") 
   END IF
   
   CALL axcq715_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="axcq715.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION axcq715_fetch(p_flag)
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
   
   #CALL axcq715_browser_fill(p_flag)
   
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
   
   LET g_xcdk_m.xcdkld = g_browser[g_current_idx].b_xcdkld
   LET g_xcdk_m.xcdk001 = g_browser[g_current_idx].b_xcdk001
   LET g_xcdk_m.xcdk003 = g_browser[g_current_idx].b_xcdk003
   LET g_xcdk_m.xcdk004 = g_browser[g_current_idx].b_xcdk004
   LET g_xcdk_m.xcdk005 = g_browser[g_current_idx].b_xcdk005
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE axcq715_master_referesh USING g_xcdk_m.xcdkld,g_xcdk_m.xcdk001,g_xcdk_m.xcdk003,g_xcdk_m.xcdk004, 
       g_xcdk_m.xcdk005 INTO g_xcdk_m.xcdkcomp,g_xcdk_m.xcdk004,g_xcdk_m.xcdk001,g_xcdk_m.xcdkld,g_xcdk_m.xcdk005, 
       g_xcdk_m.xcdk003,g_xcdk_m.xcdkcomp_desc,g_xcdk_m.xcdkld_desc,g_xcdk_m.xcdk003_desc
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcdk_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_xcdk_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_xcdk_m_mask_o.* =  g_xcdk_m.*
   CALL axcq715_xcdk_t_mask()
   LET g_xcdk_m_mask_n.* =  g_xcdk_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axcq715_set_act_visible()
   CALL axcq715_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_xcdk_m_t.* = g_xcdk_m.*
   LET g_xcdk_m_o.* = g_xcdk_m.*
   
   #重新顯示   
   CALL axcq715_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="axcq715.insert" >}
#+ 資料新增
PRIVATE FUNCTION axcq715_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_xcdk_d.clear()
   CALL g_xcdk2_d.clear()
 
 
   INITIALIZE g_xcdk_m.* TO NULL             #DEFAULT 設定
   LET g_xcdkld_t = NULL
   LET g_xcdk001_t = NULL
   LET g_xcdk003_t = NULL
   LET g_xcdk004_t = NULL
   LET g_xcdk005_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
      
     
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point 
 
      CALL axcq715_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_xcdk_m.* TO NULL
         INITIALIZE g_xcdk_d TO NULL
         INITIALIZE g_xcdk2_d TO NULL
 
         CALL axcq715_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_xcdk_m.* = g_xcdk_m_t.*
         CALL axcq715_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_xcdk_d.clear()
      #CALL g_xcdk2_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axcq715_set_act_visible()
   CALL axcq715_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_xcdkld_t = g_xcdk_m.xcdkld
   LET g_xcdk001_t = g_xcdk_m.xcdk001
   LET g_xcdk003_t = g_xcdk_m.xcdk003
   LET g_xcdk004_t = g_xcdk_m.xcdk004
   LET g_xcdk005_t = g_xcdk_m.xcdk005
 
   
   #組合新增資料的條件
   LET g_add_browse = " xcdkent = " ||g_enterprise|| " AND",
                      " xcdkld = '", g_xcdk_m.xcdkld, "' "
                      ," AND xcdk001 = '", g_xcdk_m.xcdk001, "' "
                      ," AND xcdk003 = '", g_xcdk_m.xcdk003, "' "
                      ," AND xcdk004 = '", g_xcdk_m.xcdk004, "' "
                      ," AND xcdk005 = '", g_xcdk_m.xcdk005, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axcq715_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL axcq715_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE axcq715_master_referesh USING g_xcdk_m.xcdkld,g_xcdk_m.xcdk001,g_xcdk_m.xcdk003,g_xcdk_m.xcdk004, 
       g_xcdk_m.xcdk005 INTO g_xcdk_m.xcdkcomp,g_xcdk_m.xcdk004,g_xcdk_m.xcdk001,g_xcdk_m.xcdkld,g_xcdk_m.xcdk005, 
       g_xcdk_m.xcdk003,g_xcdk_m.xcdkcomp_desc,g_xcdk_m.xcdkld_desc,g_xcdk_m.xcdk003_desc
   
   #遮罩相關處理
   LET g_xcdk_m_mask_o.* =  g_xcdk_m.*
   CALL axcq715_xcdk_t_mask()
   LET g_xcdk_m_mask_n.* =  g_xcdk_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_xcdk_m.xcdkcomp,g_xcdk_m.xcdkcomp_desc,g_xcdk_m.xcdk004,g_xcdk_m.xcdk001,g_xcdk_m.xcdk001_desc, 
       g_xcdk_m.xcdkld,g_xcdk_m.xcdkld_desc,g_xcdk_m.xcdk005,g_xcdk_m.xcdk003,g_xcdk_m.xcdk003_desc
   
   #功能已完成,通報訊息中心
   CALL axcq715_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="axcq715.modify" >}
#+ 資料修改
PRIVATE FUNCTION axcq715_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_xcdk_m.xcdkld IS NULL
   OR g_xcdk_m.xcdk001 IS NULL
   OR g_xcdk_m.xcdk003 IS NULL
   OR g_xcdk_m.xcdk004 IS NULL
   OR g_xcdk_m.xcdk005 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_xcdkld_t = g_xcdk_m.xcdkld
   LET g_xcdk001_t = g_xcdk_m.xcdk001
   LET g_xcdk003_t = g_xcdk_m.xcdk003
   LET g_xcdk004_t = g_xcdk_m.xcdk004
   LET g_xcdk005_t = g_xcdk_m.xcdk005
 
   CALL s_transaction_begin()
   
   OPEN axcq715_cl USING g_enterprise,g_xcdk_m.xcdkld,g_xcdk_m.xcdk001,g_xcdk_m.xcdk003,g_xcdk_m.xcdk004,g_xcdk_m.xcdk005
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axcq715_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE axcq715_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axcq715_master_referesh USING g_xcdk_m.xcdkld,g_xcdk_m.xcdk001,g_xcdk_m.xcdk003,g_xcdk_m.xcdk004, 
       g_xcdk_m.xcdk005 INTO g_xcdk_m.xcdkcomp,g_xcdk_m.xcdk004,g_xcdk_m.xcdk001,g_xcdk_m.xcdkld,g_xcdk_m.xcdk005, 
       g_xcdk_m.xcdk003,g_xcdk_m.xcdkcomp_desc,g_xcdk_m.xcdkld_desc,g_xcdk_m.xcdk003_desc
   
   #遮罩相關處理
   LET g_xcdk_m_mask_o.* =  g_xcdk_m.*
   CALL axcq715_xcdk_t_mask()
   LET g_xcdk_m_mask_n.* =  g_xcdk_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL axcq715_show()
   WHILE TRUE
      LET g_xcdkld_t = g_xcdk_m.xcdkld
      LET g_xcdk001_t = g_xcdk_m.xcdk001
      LET g_xcdk003_t = g_xcdk_m.xcdk003
      LET g_xcdk004_t = g_xcdk_m.xcdk004
      LET g_xcdk005_t = g_xcdk_m.xcdk005
 
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL axcq715_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_xcdk_m.* = g_xcdk_m_t.*
         CALL axcq715_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_xcdk_m.xcdkld != g_xcdkld_t 
      OR g_xcdk_m.xcdk001 != g_xcdk001_t 
      OR g_xcdk_m.xcdk003 != g_xcdk003_t 
      OR g_xcdk_m.xcdk004 != g_xcdk004_t 
      OR g_xcdk_m.xcdk005 != g_xcdk005_t 
 
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
   CALL axcq715_set_act_visible()
   CALL axcq715_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " xcdkent = " ||g_enterprise|| " AND",
                      " xcdkld = '", g_xcdk_m.xcdkld, "' "
                      ," AND xcdk001 = '", g_xcdk_m.xcdk001, "' "
                      ," AND xcdk003 = '", g_xcdk_m.xcdk003, "' "
                      ," AND xcdk004 = '", g_xcdk_m.xcdk004, "' "
                      ," AND xcdk005 = '", g_xcdk_m.xcdk005, "' "
 
   #填到對應位置
   CALL axcq715_browser_fill("")
 
   CALL axcq715_idx_chk()
 
   CLOSE axcq715_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL axcq715_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="axcq715.input" >}
#+ 資料輸入
PRIVATE FUNCTION axcq715_input(p_cmd)
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
   DISPLAY BY NAME g_xcdk_m.xcdkcomp,g_xcdk_m.xcdkcomp_desc,g_xcdk_m.xcdk004,g_xcdk_m.xcdk001,g_xcdk_m.xcdk001_desc, 
       g_xcdk_m.xcdkld,g_xcdk_m.xcdkld_desc,g_xcdk_m.xcdk005,g_xcdk_m.xcdk003,g_xcdk_m.xcdk003_desc
   
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
   LET g_forupd_sql = "SELECT xcdksite,xcdk014,xcdk047,xcdk006,xcdk007,xcdk008,xcdk025,xcdk021,xcdk011, 
       xcdk010,xcdk012,xcdk016,xcdk018,xcdk002,xcdk009,xcdk022,xcdk023,xcdk024,xcdk026,xcdk027,xcdk028, 
       xcdk029,xcdk030,xcdk031,xcdk048,xcdk049,xcdk050,xcdk051,xcdk201,xcdk202,xcdkownid,xcdkowndp,xcdkcrtid, 
       xcdkcrtdp,xcdkcrtdt,xcdkmodid,xcdkmoddt,xcdk002,xcdk006,xcdk007,xcdk008,xcdk009,xcdk010 FROM  
       xcdk_t WHERE xcdkent=? AND xcdkld=? AND xcdk001=? AND xcdk003=? AND xcdk004=? AND xcdk005=? AND  
       xcdk002=? AND xcdk006=? AND xcdk007=? AND xcdk008=? AND xcdk009=? AND xcdk010=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axcq715_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL axcq715_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL axcq715_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_xcdk_m.xcdkcomp,g_xcdk_m.xcdk004,g_xcdk_m.xcdk001,g_xcdk_m.xcdkld,g_xcdk_m.xcdk005, 
       g_xcdk_m.xcdk003
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="axcq715.input.head" >}
   
      #單頭段
      INPUT BY NAME g_xcdk_m.xcdkcomp,g_xcdk_m.xcdk004,g_xcdk_m.xcdk001,g_xcdk_m.xcdkld,g_xcdk_m.xcdk005, 
          g_xcdk_m.xcdk003 
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
         AFTER FIELD xcdkcomp
            
            #add-point:AFTER FIELD xcdkcomp name="input.a.xcdkcomp"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcdk_m.xcdkcomp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcdk_m.xcdkcomp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcdk_m.xcdkcomp_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdkcomp
            #add-point:BEFORE FIELD xcdkcomp name="input.b.xcdkcomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdkcomp
            #add-point:ON CHANGE xcdkcomp name="input.g.xcdkcomp"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk004
            #add-point:BEFORE FIELD xcdk004 name="input.b.xcdk004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk004
            
            #add-point:AFTER FIELD xcdk004 name="input.a.xcdk004"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xcdk_m.xcdkld) AND NOT cl_null(g_xcdk_m.xcdk001) AND NOT cl_null(g_xcdk_m.xcdk003) AND NOT cl_null(g_xcdk_m.xcdk004) AND NOT cl_null(g_xcdk_m.xcdk005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcdk_m.xcdkld != g_xcdkld_t  OR g_xcdk_m.xcdk001 != g_xcdk001_t  OR g_xcdk_m.xcdk003 != g_xcdk003_t  OR g_xcdk_m.xcdk004 != g_xcdk004_t  OR g_xcdk_m.xcdk005 != g_xcdk005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcdk_t WHERE "||"xcdkent = '" ||g_enterprise|| "' AND "||"xcdkld = '"||g_xcdk_m.xcdkld ||"' AND "|| "xcdk001 = '"||g_xcdk_m.xcdk001 ||"' AND "|| "xcdk003 = '"||g_xcdk_m.xcdk003 ||"' AND "|| "xcdk004 = '"||g_xcdk_m.xcdk004 ||"' AND "|| "xcdk005 = '"||g_xcdk_m.xcdk005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdk004
            #add-point:ON CHANGE xcdk004 name="input.g.xcdk004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk001
            
            #add-point:AFTER FIELD xcdk001 name="input.a.xcdk001"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xcdk_m.xcdkld) AND NOT cl_null(g_xcdk_m.xcdk001) AND NOT cl_null(g_xcdk_m.xcdk003) AND NOT cl_null(g_xcdk_m.xcdk004) AND NOT cl_null(g_xcdk_m.xcdk005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcdk_m.xcdkld != g_xcdkld_t  OR g_xcdk_m.xcdk001 != g_xcdk001_t  OR g_xcdk_m.xcdk003 != g_xcdk003_t  OR g_xcdk_m.xcdk004 != g_xcdk004_t  OR g_xcdk_m.xcdk005 != g_xcdk005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcdk_t WHERE "||"xcdkent = '" ||g_enterprise|| "' AND "||"xcdkld = '"||g_xcdk_m.xcdkld ||"' AND "|| "xcdk001 = '"||g_xcdk_m.xcdk001 ||"' AND "|| "xcdk003 = '"||g_xcdk_m.xcdk003 ||"' AND "|| "xcdk004 = '"||g_xcdk_m.xcdk004 ||"' AND "|| "xcdk005 = '"||g_xcdk_m.xcdk005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF




            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xcdk_m.xcdkld) AND NOT cl_null(g_xcdk_m.xcdk001) AND NOT cl_null(g_xcdk_m.xcdk003) AND NOT cl_null(g_xcdk_m.xcdk004) AND NOT cl_null(g_xcdk_m.xcdk005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcdk_m.xcdkld != g_xcdkld_t  OR g_xcdk_m.xcdk001 != g_xcdk001_t  OR g_xcdk_m.xcdk003 != g_xcdk003_t  OR g_xcdk_m.xcdk004 != g_xcdk004_t  OR g_xcdk_m.xcdk005 != g_xcdk005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcdk_t WHERE "||"xcdkent = '" ||g_enterprise|| "' AND "||"xcdkld = '"||g_xcdk_m.xcdkld ||"' AND "|| "xcdk001 = '"||g_xcdk_m.xcdk001 ||"' AND "|| "xcdk003 = '"||g_xcdk_m.xcdk003 ||"' AND "|| "xcdk004 = '"||g_xcdk_m.xcdk004 ||"' AND "|| "xcdk005 = '"||g_xcdk_m.xcdk005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk001
            #add-point:BEFORE FIELD xcdk001 name="input.b.xcdk001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdk001
            #add-point:ON CHANGE xcdk001 name="input.g.xcdk001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdkld
            
            #add-point:AFTER FIELD xcdkld name="input.a.xcdkld"
            IF NOT cl_null(g_xcdk_m.xcdkld) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xcdk_m.xcdkld
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
            LET g_ref_fields[1] = g_xcdk_m.xcdkld
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcdk_m.xcdkld_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcdk_m.xcdkld_desc

            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xcdk_m.xcdkld) AND NOT cl_null(g_xcdk_m.xcdk001) AND NOT cl_null(g_xcdk_m.xcdk003) AND NOT cl_null(g_xcdk_m.xcdk004) AND NOT cl_null(g_xcdk_m.xcdk005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcdk_m.xcdkld != g_xcdkld_t  OR g_xcdk_m.xcdk001 != g_xcdk001_t  OR g_xcdk_m.xcdk003 != g_xcdk003_t  OR g_xcdk_m.xcdk004 != g_xcdk004_t  OR g_xcdk_m.xcdk005 != g_xcdk005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcdk_t WHERE "||"xcdkent = '" ||g_enterprise|| "' AND "||"xcdkld = '"||g_xcdk_m.xcdkld ||"' AND "|| "xcdk001 = '"||g_xcdk_m.xcdk001 ||"' AND "|| "xcdk003 = '"||g_xcdk_m.xcdk003 ||"' AND "|| "xcdk004 = '"||g_xcdk_m.xcdk004 ||"' AND "|| "xcdk005 = '"||g_xcdk_m.xcdk005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdkld
            #add-point:BEFORE FIELD xcdkld name="input.b.xcdkld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdkld
            #add-point:ON CHANGE xcdkld name="input.g.xcdkld"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk005
            #add-point:BEFORE FIELD xcdk005 name="input.b.xcdk005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk005
            
            #add-point:AFTER FIELD xcdk005 name="input.a.xcdk005"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xcdk_m.xcdkld) AND NOT cl_null(g_xcdk_m.xcdk001) AND NOT cl_null(g_xcdk_m.xcdk003) AND NOT cl_null(g_xcdk_m.xcdk004) AND NOT cl_null(g_xcdk_m.xcdk005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcdk_m.xcdkld != g_xcdkld_t  OR g_xcdk_m.xcdk001 != g_xcdk001_t  OR g_xcdk_m.xcdk003 != g_xcdk003_t  OR g_xcdk_m.xcdk004 != g_xcdk004_t  OR g_xcdk_m.xcdk005 != g_xcdk005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcdk_t WHERE "||"xcdkent = '" ||g_enterprise|| "' AND "||"xcdkld = '"||g_xcdk_m.xcdkld ||"' AND "|| "xcdk001 = '"||g_xcdk_m.xcdk001 ||"' AND "|| "xcdk003 = '"||g_xcdk_m.xcdk003 ||"' AND "|| "xcdk004 = '"||g_xcdk_m.xcdk004 ||"' AND "|| "xcdk005 = '"||g_xcdk_m.xcdk005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdk005
            #add-point:ON CHANGE xcdk005 name="input.g.xcdk005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk003
            
            #add-point:AFTER FIELD xcdk003 name="input.a.xcdk003"
            IF NOT cl_null(g_xcdk_m.xcdk003) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xcdk_m.xcdk003
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
            LET g_ref_fields[1] = g_xcdk_m.xcdk003
            CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcdk_m.xcdk003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcdk_m.xcdk003_desc

            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xcdk_m.xcdkld) AND NOT cl_null(g_xcdk_m.xcdk001) AND NOT cl_null(g_xcdk_m.xcdk003) AND NOT cl_null(g_xcdk_m.xcdk004) AND NOT cl_null(g_xcdk_m.xcdk005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcdk_m.xcdkld != g_xcdkld_t  OR g_xcdk_m.xcdk001 != g_xcdk001_t  OR g_xcdk_m.xcdk003 != g_xcdk003_t  OR g_xcdk_m.xcdk004 != g_xcdk004_t  OR g_xcdk_m.xcdk005 != g_xcdk005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcdk_t WHERE "||"xcdkent = '" ||g_enterprise|| "' AND "||"xcdkld = '"||g_xcdk_m.xcdkld ||"' AND "|| "xcdk001 = '"||g_xcdk_m.xcdk001 ||"' AND "|| "xcdk003 = '"||g_xcdk_m.xcdk003 ||"' AND "|| "xcdk004 = '"||g_xcdk_m.xcdk004 ||"' AND "|| "xcdk005 = '"||g_xcdk_m.xcdk005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk003
            #add-point:BEFORE FIELD xcdk003 name="input.b.xcdk003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdk003
            #add-point:ON CHANGE xcdk003 name="input.g.xcdk003"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.xcdkcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdkcomp
            #add-point:ON ACTION controlp INFIELD xcdkcomp name="input.c.xcdkcomp"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcdk_m.xcdkcomp             #給予default值
            LET g_qryparam.default2 = "" #g_xcdk_m.ooefl003 #說明(簡稱)
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooef001_2()                                #呼叫開窗

            LET g_xcdk_m.xcdkcomp = g_qryparam.return1              
            #LET g_xcdk_m.ooefl003 = g_qryparam.return2 
            DISPLAY g_xcdk_m.xcdkcomp TO xcdkcomp              #
            #DISPLAY g_xcdk_m.ooefl003 TO ooefl003 #說明(簡稱)
            NEXT FIELD xcdkcomp                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xcdk004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk004
            #add-point:ON ACTION controlp INFIELD xcdk004 name="input.c.xcdk004"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcdk001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk001
            #add-point:ON ACTION controlp INFIELD xcdk001 name="input.c.xcdk001"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcdkld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdkld
            #add-point:ON ACTION controlp INFIELD xcdkld name="input.c.xcdkld"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcdk_m.xcdkld             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.arg2 = "" #
            
            CALL q_authorised_ld()                                #呼叫開窗

            LET g_xcdk_m.xcdkld = g_qryparam.return1              

            DISPLAY g_xcdk_m.xcdkld TO xcdkld              #

            NEXT FIELD xcdkld                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xcdk005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk005
            #add-point:ON ACTION controlp INFIELD xcdk005 name="input.c.xcdk005"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcdk003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk003
            #add-point:ON ACTION controlp INFIELD xcdk003 name="input.c.xcdk003"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcdk_m.xcdk003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_xcat001()                                #呼叫開窗

            LET g_xcdk_m.xcdk003 = g_qryparam.return1              

            DISPLAY g_xcdk_m.xcdk003 TO xcdk003              #

            NEXT FIELD xcdk003                          #返回原欄位


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
            DISPLAY BY NAME g_xcdk_m.xcdkld             
                            ,g_xcdk_m.xcdk001   
                            ,g_xcdk_m.xcdk003   
                            ,g_xcdk_m.xcdk004   
                            ,g_xcdk_m.xcdk005   
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
            
               #將遮罩欄位還原
               CALL axcq715_xcdk_t_mask_restore('restore_mask_o')
            
               UPDATE xcdk_t SET (xcdkcomp,xcdk004,xcdk001,xcdkld,xcdk005,xcdk003) = (g_xcdk_m.xcdkcomp, 
                   g_xcdk_m.xcdk004,g_xcdk_m.xcdk001,g_xcdk_m.xcdkld,g_xcdk_m.xcdk005,g_xcdk_m.xcdk003) 
 
                WHERE xcdkent = g_enterprise AND xcdkld = g_xcdkld_t
                  AND xcdk001 = g_xcdk001_t
                  AND xcdk003 = g_xcdk003_t
                  AND xcdk004 = g_xcdk004_t
                  AND xcdk005 = g_xcdk005_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcdk_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcdk_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xcdk_m.xcdkld
               LET gs_keys_bak[1] = g_xcdkld_t
               LET gs_keys[2] = g_xcdk_m.xcdk001
               LET gs_keys_bak[2] = g_xcdk001_t
               LET gs_keys[3] = g_xcdk_m.xcdk003
               LET gs_keys_bak[3] = g_xcdk003_t
               LET gs_keys[4] = g_xcdk_m.xcdk004
               LET gs_keys_bak[4] = g_xcdk004_t
               LET gs_keys[5] = g_xcdk_m.xcdk005
               LET gs_keys_bak[5] = g_xcdk005_t
               LET gs_keys[6] = g_xcdk_d[g_detail_idx].xcdk002
               LET gs_keys_bak[6] = g_xcdk_d_t.xcdk002
               LET gs_keys[7] = g_xcdk_d[g_detail_idx].xcdk006
               LET gs_keys_bak[7] = g_xcdk_d_t.xcdk006
               LET gs_keys[8] = g_xcdk_d[g_detail_idx].xcdk007
               LET gs_keys_bak[8] = g_xcdk_d_t.xcdk007
               LET gs_keys[9] = g_xcdk_d[g_detail_idx].xcdk008
               LET gs_keys_bak[9] = g_xcdk_d_t.xcdk008
               LET gs_keys[10] = g_xcdk_d[g_detail_idx].xcdk009
               LET gs_keys_bak[10] = g_xcdk_d_t.xcdk009
               LET gs_keys[11] = g_xcdk_d[g_detail_idx].xcdk010
               LET gs_keys_bak[11] = g_xcdk_d_t.xcdk010
               CALL axcq715_update_b('xcdk_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_xcdk_m_t)
                     #LET g_log2 = util.JSON.stringify(g_xcdk_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL axcq715_xcdk_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL axcq715_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_xcdkld_t = g_xcdk_m.xcdkld
           LET g_xcdk001_t = g_xcdk_m.xcdk001
           LET g_xcdk003_t = g_xcdk_m.xcdk003
           LET g_xcdk004_t = g_xcdk_m.xcdk004
           LET g_xcdk005_t = g_xcdk_m.xcdk005
 
           
           IF g_xcdk_d.getLength() = 0 THEN
              NEXT FIELD xcdk002
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="axcq715.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_xcdk_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xcdk_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axcq715_b_fill(g_wc2) #test 
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
            CALL axcq715_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN axcq715_cl USING g_enterprise,g_xcdk_m.xcdkld,g_xcdk_m.xcdk001,g_xcdk_m.xcdk003,g_xcdk_m.xcdk004,g_xcdk_m.xcdk005                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE axcq715_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axcq715_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_xcdk_d[l_ac].xcdk002 IS NOT NULL
               AND g_xcdk_d[l_ac].xcdk006 IS NOT NULL
               AND g_xcdk_d[l_ac].xcdk007 IS NOT NULL
               AND g_xcdk_d[l_ac].xcdk008 IS NOT NULL
               AND g_xcdk_d[l_ac].xcdk009 IS NOT NULL
               AND g_xcdk_d[l_ac].xcdk010 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_xcdk_d_t.* = g_xcdk_d[l_ac].*  #BACKUP
               LET g_xcdk_d_o.* = g_xcdk_d[l_ac].*  #BACKUP
               CALL axcq715_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL axcq715_set_no_entry_b(l_cmd)
               OPEN axcq715_bcl USING g_enterprise,g_xcdk_m.xcdkld,
                                                g_xcdk_m.xcdk001,
                                                g_xcdk_m.xcdk003,
                                                g_xcdk_m.xcdk004,
                                                g_xcdk_m.xcdk005,
 
                                                g_xcdk_d_t.xcdk002
                                                ,g_xcdk_d_t.xcdk006
                                                ,g_xcdk_d_t.xcdk007
                                                ,g_xcdk_d_t.xcdk008
                                                ,g_xcdk_d_t.xcdk009
                                                ,g_xcdk_d_t.xcdk010
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axcq715_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axcq715_bcl INTO g_xcdk_d[l_ac].xcdksite,g_xcdk_d[l_ac].xcdk014,g_xcdk_d[l_ac].xcdk047, 
                      g_xcdk_d[l_ac].xcdk006,g_xcdk_d[l_ac].xcdk007,g_xcdk_d[l_ac].xcdk008,g_xcdk_d[l_ac].xcdk025, 
                      g_xcdk_d[l_ac].xcdk021,g_xcdk_d[l_ac].xcdk011,g_xcdk_d[l_ac].xcdk010,g_xcdk_d[l_ac].xcdk012, 
                      g_xcdk_d[l_ac].xcdk016,g_xcdk_d[l_ac].xcdk018,g_xcdk_d[l_ac].xcdk002,g_xcdk_d[l_ac].xcdk009, 
                      g_xcdk_d[l_ac].xcdk022,g_xcdk_d[l_ac].xcdk023,g_xcdk_d[l_ac].xcdk024,g_xcdk_d[l_ac].xcdk026, 
                      g_xcdk_d[l_ac].xcdk027,g_xcdk_d[l_ac].xcdk028,g_xcdk_d[l_ac].xcdk029,g_xcdk_d[l_ac].xcdk030, 
                      g_xcdk_d[l_ac].xcdk031,g_xcdk_d[l_ac].xcdk048,g_xcdk_d[l_ac].xcdk049,g_xcdk_d[l_ac].xcdk050, 
                      g_xcdk_d[l_ac].xcdk051,g_xcdk_d[l_ac].xcdk201,g_xcdk_d[l_ac].xcdk202,g_xcdk2_d[l_ac].xcdkownid, 
                      g_xcdk2_d[l_ac].xcdkowndp,g_xcdk2_d[l_ac].xcdkcrtid,g_xcdk2_d[l_ac].xcdkcrtdp, 
                      g_xcdk2_d[l_ac].xcdkcrtdt,g_xcdk2_d[l_ac].xcdkmodid,g_xcdk2_d[l_ac].xcdkmoddt, 
                      g_xcdk2_d[l_ac].xcdk002,g_xcdk2_d[l_ac].xcdk006,g_xcdk2_d[l_ac].xcdk007,g_xcdk2_d[l_ac].xcdk008, 
                      g_xcdk2_d[l_ac].xcdk009,g_xcdk2_d[l_ac].xcdk010
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_xcdk_d_t.xcdk002,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xcdk_d_mask_o[l_ac].* =  g_xcdk_d[l_ac].*
                  CALL axcq715_xcdk_t_mask()
                  LET g_xcdk_d_mask_n[l_ac].* =  g_xcdk_d[l_ac].*
                  
                  CALL axcq715_ref_show()
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
            INITIALIZE g_xcdk_d_t.* TO NULL
            INITIALIZE g_xcdk_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xcdk_d[l_ac].* TO NULL
            #公用欄位預設值
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_xcdk2_d[l_ac].xcdkownid = g_user
      LET g_xcdk2_d[l_ac].xcdkowndp = g_dept
      LET g_xcdk2_d[l_ac].xcdkcrtid = g_user
      LET g_xcdk2_d[l_ac].xcdkcrtdp = g_dept 
      LET g_xcdk2_d[l_ac].xcdkcrtdt = cl_get_current()
      LET g_xcdk2_d[l_ac].xcdkmodid = g_user
      LET g_xcdk2_d[l_ac].xcdkmoddt = cl_get_current()
 
 
  
            #一般欄位預設值
            
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            
            #end add-point
            LET g_xcdk_d_t.* = g_xcdk_d[l_ac].*     #新輸入資料
            LET g_xcdk_d_o.* = g_xcdk_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axcq715_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL axcq715_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xcdk_d[li_reproduce_target].* = g_xcdk_d[li_reproduce].*
               LET g_xcdk2_d[li_reproduce_target].* = g_xcdk2_d[li_reproduce].*
 
               LET g_xcdk_d[g_xcdk_d.getLength()].xcdk002 = NULL
               LET g_xcdk_d[g_xcdk_d.getLength()].xcdk006 = NULL
               LET g_xcdk_d[g_xcdk_d.getLength()].xcdk007 = NULL
               LET g_xcdk_d[g_xcdk_d.getLength()].xcdk008 = NULL
               LET g_xcdk_d[g_xcdk_d.getLength()].xcdk009 = NULL
               LET g_xcdk_d[g_xcdk_d.getLength()].xcdk010 = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM xcdk_t 
             WHERE xcdkent = g_enterprise AND xcdkld = g_xcdk_m.xcdkld
               AND xcdk001 = g_xcdk_m.xcdk001
               AND xcdk003 = g_xcdk_m.xcdk003
               AND xcdk004 = g_xcdk_m.xcdk004
               AND xcdk005 = g_xcdk_m.xcdk005
 
               AND xcdk002 = g_xcdk_d[l_ac].xcdk002
               AND xcdk006 = g_xcdk_d[l_ac].xcdk006
               AND xcdk007 = g_xcdk_d[l_ac].xcdk007
               AND xcdk008 = g_xcdk_d[l_ac].xcdk008
               AND xcdk009 = g_xcdk_d[l_ac].xcdk009
               AND xcdk010 = g_xcdk_d[l_ac].xcdk010
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
               INSERT INTO xcdk_t
                           (xcdkent,
                            xcdkcomp,xcdk004,xcdk001,xcdkld,xcdk005,xcdk003,
                            xcdk002,xcdk006,xcdk007,xcdk008,xcdk009,xcdk010
                            ,xcdksite,xcdk014,xcdk047,xcdk025,xcdk021,xcdk011,xcdk012,xcdk016,xcdk018,xcdk022,xcdk023,xcdk024,xcdk026,xcdk027,xcdk028,xcdk029,xcdk030,xcdk031,xcdk048,xcdk049,xcdk050,xcdk051,xcdk201,xcdk202,xcdkownid,xcdkowndp,xcdkcrtid,xcdkcrtdp,xcdkcrtdt,xcdkmodid,xcdkmoddt) 
                     VALUES(g_enterprise,
                            g_xcdk_m.xcdkcomp,g_xcdk_m.xcdk004,g_xcdk_m.xcdk001,g_xcdk_m.xcdkld,g_xcdk_m.xcdk005,g_xcdk_m.xcdk003,
                            g_xcdk_d[l_ac].xcdk002,g_xcdk_d[l_ac].xcdk006,g_xcdk_d[l_ac].xcdk007,g_xcdk_d[l_ac].xcdk008, 
                                g_xcdk_d[l_ac].xcdk009,g_xcdk_d[l_ac].xcdk010
                            ,g_xcdk_d[l_ac].xcdksite,g_xcdk_d[l_ac].xcdk014,g_xcdk_d[l_ac].xcdk047,g_xcdk_d[l_ac].xcdk025, 
                                g_xcdk_d[l_ac].xcdk021,g_xcdk_d[l_ac].xcdk011,g_xcdk_d[l_ac].xcdk012, 
                                g_xcdk_d[l_ac].xcdk016,g_xcdk_d[l_ac].xcdk018,g_xcdk_d[l_ac].xcdk022, 
                                g_xcdk_d[l_ac].xcdk023,g_xcdk_d[l_ac].xcdk024,g_xcdk_d[l_ac].xcdk026, 
                                g_xcdk_d[l_ac].xcdk027,g_xcdk_d[l_ac].xcdk028,g_xcdk_d[l_ac].xcdk029, 
                                g_xcdk_d[l_ac].xcdk030,g_xcdk_d[l_ac].xcdk031,g_xcdk_d[l_ac].xcdk048, 
                                g_xcdk_d[l_ac].xcdk049,g_xcdk_d[l_ac].xcdk050,g_xcdk_d[l_ac].xcdk051, 
                                g_xcdk_d[l_ac].xcdk201,g_xcdk_d[l_ac].xcdk202,g_xcdk2_d[l_ac].xcdkownid, 
                                g_xcdk2_d[l_ac].xcdkowndp,g_xcdk2_d[l_ac].xcdkcrtid,g_xcdk2_d[l_ac].xcdkcrtdp, 
                                g_xcdk2_d[l_ac].xcdkcrtdt,g_xcdk2_d[l_ac].xcdkmodid,g_xcdk2_d[l_ac].xcdkmoddt) 
 
               #add-point:單身新增中 name="input.body.m_insert"
               
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_xcdk_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "xcdk_t:",SQLERRMESSAGE 
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
               IF axcq715_before_delete() THEN 
                  
 
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_xcdk_m.xcdkld
                  LET gs_keys[gs_keys.getLength()+1] = g_xcdk_m.xcdk001
                  LET gs_keys[gs_keys.getLength()+1] = g_xcdk_m.xcdk003
                  LET gs_keys[gs_keys.getLength()+1] = g_xcdk_m.xcdk004
                  LET gs_keys[gs_keys.getLength()+1] = g_xcdk_m.xcdk005
 
                  LET gs_keys[gs_keys.getLength()+1] = g_xcdk_d_t.xcdk002
                  LET gs_keys[gs_keys.getLength()+1] = g_xcdk_d_t.xcdk006
                  LET gs_keys[gs_keys.getLength()+1] = g_xcdk_d_t.xcdk007
                  LET gs_keys[gs_keys.getLength()+1] = g_xcdk_d_t.xcdk008
                  LET gs_keys[gs_keys.getLength()+1] = g_xcdk_d_t.xcdk009
                  LET gs_keys[gs_keys.getLength()+1] = g_xcdk_d_t.xcdk010
 
 
                  #刪除下層單身
                  IF NOT axcq715_key_delete_b(gs_keys,'xcdk_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE axcq715_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE axcq715_bcl
               LET l_count = g_xcdk_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_xcdk_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdksite
            
            #add-point:AFTER FIELD xcdksite name="input.a.page1.xcdksite"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcdk_d[l_ac].xcdksite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcdk_d[l_ac].xcdksite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcdk_d[l_ac].xcdksite_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdksite
            #add-point:BEFORE FIELD xcdksite name="input.b.page1.xcdksite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdksite
            #add-point:ON CHANGE xcdksite name="input.g.page1.xcdksite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk014
            #add-point:BEFORE FIELD xcdk014 name="input.b.page1.xcdk014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk014
            
            #add-point:AFTER FIELD xcdk014 name="input.a.page1.xcdk014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdk014
            #add-point:ON CHANGE xcdk014 name="input.g.page1.xcdk014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk047
            #add-point:BEFORE FIELD xcdk047 name="input.b.page1.xcdk047"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk047
            
            #add-point:AFTER FIELD xcdk047 name="input.a.page1.xcdk047"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdk047
            #add-point:ON CHANGE xcdk047 name="input.g.page1.xcdk047"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk006
            #add-point:BEFORE FIELD xcdk006 name="input.b.page1.xcdk006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk006
            
            #add-point:AFTER FIELD xcdk006 name="input.a.page1.xcdk006"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcdk_m.xcdkld IS NOT NULL AND g_xcdk_m.xcdk001 IS NOT NULL AND g_xcdk_m.xcdk003 IS NOT NULL AND g_xcdk_m.xcdk004 IS NOT NULL AND g_xcdk_m.xcdk005 IS NOT NULL AND g_xcdk_d[g_detail_idx].xcdk002 IS NOT NULL AND g_xcdk_d[g_detail_idx].xcdk006 IS NOT NULL AND g_xcdk_d[g_detail_idx].xcdk007 IS NOT NULL AND g_xcdk_d[g_detail_idx].xcdk008 IS NOT NULL AND g_xcdk_d[g_detail_idx].xcdk009 IS NOT NULL AND g_xcdk_d[g_detail_idx].xcdk010 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcdk_m.xcdkld != g_xcdkld_t OR g_xcdk_m.xcdk001 != g_xcdk001_t OR g_xcdk_m.xcdk003 != g_xcdk003_t OR g_xcdk_m.xcdk004 != g_xcdk004_t OR g_xcdk_m.xcdk005 != g_xcdk005_t OR g_xcdk_d[g_detail_idx].xcdk002 != g_xcdk_d_t.xcdk002 OR g_xcdk_d[g_detail_idx].xcdk006 != g_xcdk_d_t.xcdk006 OR g_xcdk_d[g_detail_idx].xcdk007 != g_xcdk_d_t.xcdk007 OR g_xcdk_d[g_detail_idx].xcdk008 != g_xcdk_d_t.xcdk008 OR g_xcdk_d[g_detail_idx].xcdk009 != g_xcdk_d_t.xcdk009 OR g_xcdk_d[g_detail_idx].xcdk010 != g_xcdk_d_t.xcdk010)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcdk_t WHERE "||"xcdkent = '" ||g_enterprise|| "' AND "||"xcdkld = '"||g_xcdk_m.xcdkld ||"' AND "|| "xcdk001 = '"||g_xcdk_m.xcdk001 ||"' AND "|| "xcdk003 = '"||g_xcdk_m.xcdk003 ||"' AND "|| "xcdk004 = '"||g_xcdk_m.xcdk004 ||"' AND "|| "xcdk005 = '"||g_xcdk_m.xcdk005 ||"' AND "|| "xcdk002 = '"||g_xcdk_d[g_detail_idx].xcdk002 ||"' AND "|| "xcdk006 = '"||g_xcdk_d[g_detail_idx].xcdk006 ||"' AND "|| "xcdk007 = '"||g_xcdk_d[g_detail_idx].xcdk007 ||"' AND "|| "xcdk008 = '"||g_xcdk_d[g_detail_idx].xcdk008 ||"' AND "|| "xcdk009 = '"||g_xcdk_d[g_detail_idx].xcdk009 ||"' AND "|| "xcdk010 = '"||g_xcdk_d[g_detail_idx].xcdk010 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdk006
            #add-point:ON CHANGE xcdk006 name="input.g.page1.xcdk006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk007
            #add-point:BEFORE FIELD xcdk007 name="input.b.page1.xcdk007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk007
            
            #add-point:AFTER FIELD xcdk007 name="input.a.page1.xcdk007"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcdk_m.xcdkld IS NOT NULL AND g_xcdk_m.xcdk001 IS NOT NULL AND g_xcdk_m.xcdk003 IS NOT NULL AND g_xcdk_m.xcdk004 IS NOT NULL AND g_xcdk_m.xcdk005 IS NOT NULL AND g_xcdk_d[g_detail_idx].xcdk002 IS NOT NULL AND g_xcdk_d[g_detail_idx].xcdk006 IS NOT NULL AND g_xcdk_d[g_detail_idx].xcdk007 IS NOT NULL AND g_xcdk_d[g_detail_idx].xcdk008 IS NOT NULL AND g_xcdk_d[g_detail_idx].xcdk009 IS NOT NULL AND g_xcdk_d[g_detail_idx].xcdk010 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcdk_m.xcdkld != g_xcdkld_t OR g_xcdk_m.xcdk001 != g_xcdk001_t OR g_xcdk_m.xcdk003 != g_xcdk003_t OR g_xcdk_m.xcdk004 != g_xcdk004_t OR g_xcdk_m.xcdk005 != g_xcdk005_t OR g_xcdk_d[g_detail_idx].xcdk002 != g_xcdk_d_t.xcdk002 OR g_xcdk_d[g_detail_idx].xcdk006 != g_xcdk_d_t.xcdk006 OR g_xcdk_d[g_detail_idx].xcdk007 != g_xcdk_d_t.xcdk007 OR g_xcdk_d[g_detail_idx].xcdk008 != g_xcdk_d_t.xcdk008 OR g_xcdk_d[g_detail_idx].xcdk009 != g_xcdk_d_t.xcdk009 OR g_xcdk_d[g_detail_idx].xcdk010 != g_xcdk_d_t.xcdk010)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcdk_t WHERE "||"xcdkent = '" ||g_enterprise|| "' AND "||"xcdkld = '"||g_xcdk_m.xcdkld ||"' AND "|| "xcdk001 = '"||g_xcdk_m.xcdk001 ||"' AND "|| "xcdk003 = '"||g_xcdk_m.xcdk003 ||"' AND "|| "xcdk004 = '"||g_xcdk_m.xcdk004 ||"' AND "|| "xcdk005 = '"||g_xcdk_m.xcdk005 ||"' AND "|| "xcdk002 = '"||g_xcdk_d[g_detail_idx].xcdk002 ||"' AND "|| "xcdk006 = '"||g_xcdk_d[g_detail_idx].xcdk006 ||"' AND "|| "xcdk007 = '"||g_xcdk_d[g_detail_idx].xcdk007 ||"' AND "|| "xcdk008 = '"||g_xcdk_d[g_detail_idx].xcdk008 ||"' AND "|| "xcdk009 = '"||g_xcdk_d[g_detail_idx].xcdk009 ||"' AND "|| "xcdk010 = '"||g_xcdk_d[g_detail_idx].xcdk010 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdk007
            #add-point:ON CHANGE xcdk007 name="input.g.page1.xcdk007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk008
            #add-point:BEFORE FIELD xcdk008 name="input.b.page1.xcdk008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk008
            
            #add-point:AFTER FIELD xcdk008 name="input.a.page1.xcdk008"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcdk_m.xcdkld IS NOT NULL AND g_xcdk_m.xcdk001 IS NOT NULL AND g_xcdk_m.xcdk003 IS NOT NULL AND g_xcdk_m.xcdk004 IS NOT NULL AND g_xcdk_m.xcdk005 IS NOT NULL AND g_xcdk_d[g_detail_idx].xcdk002 IS NOT NULL AND g_xcdk_d[g_detail_idx].xcdk006 IS NOT NULL AND g_xcdk_d[g_detail_idx].xcdk007 IS NOT NULL AND g_xcdk_d[g_detail_idx].xcdk008 IS NOT NULL AND g_xcdk_d[g_detail_idx].xcdk009 IS NOT NULL AND g_xcdk_d[g_detail_idx].xcdk010 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcdk_m.xcdkld != g_xcdkld_t OR g_xcdk_m.xcdk001 != g_xcdk001_t OR g_xcdk_m.xcdk003 != g_xcdk003_t OR g_xcdk_m.xcdk004 != g_xcdk004_t OR g_xcdk_m.xcdk005 != g_xcdk005_t OR g_xcdk_d[g_detail_idx].xcdk002 != g_xcdk_d_t.xcdk002 OR g_xcdk_d[g_detail_idx].xcdk006 != g_xcdk_d_t.xcdk006 OR g_xcdk_d[g_detail_idx].xcdk007 != g_xcdk_d_t.xcdk007 OR g_xcdk_d[g_detail_idx].xcdk008 != g_xcdk_d_t.xcdk008 OR g_xcdk_d[g_detail_idx].xcdk009 != g_xcdk_d_t.xcdk009 OR g_xcdk_d[g_detail_idx].xcdk010 != g_xcdk_d_t.xcdk010)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcdk_t WHERE "||"xcdkent = '" ||g_enterprise|| "' AND "||"xcdkld = '"||g_xcdk_m.xcdkld ||"' AND "|| "xcdk001 = '"||g_xcdk_m.xcdk001 ||"' AND "|| "xcdk003 = '"||g_xcdk_m.xcdk003 ||"' AND "|| "xcdk004 = '"||g_xcdk_m.xcdk004 ||"' AND "|| "xcdk005 = '"||g_xcdk_m.xcdk005 ||"' AND "|| "xcdk002 = '"||g_xcdk_d[g_detail_idx].xcdk002 ||"' AND "|| "xcdk006 = '"||g_xcdk_d[g_detail_idx].xcdk006 ||"' AND "|| "xcdk007 = '"||g_xcdk_d[g_detail_idx].xcdk007 ||"' AND "|| "xcdk008 = '"||g_xcdk_d[g_detail_idx].xcdk008 ||"' AND "|| "xcdk009 = '"||g_xcdk_d[g_detail_idx].xcdk009 ||"' AND "|| "xcdk010 = '"||g_xcdk_d[g_detail_idx].xcdk010 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdk008
            #add-point:ON CHANGE xcdk008 name="input.g.page1.xcdk008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk025
            #add-point:BEFORE FIELD xcdk025 name="input.b.page1.xcdk025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk025
            
            #add-point:AFTER FIELD xcdk025 name="input.a.page1.xcdk025"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdk025
            #add-point:ON CHANGE xcdk025 name="input.g.page1.xcdk025"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk021
            #add-point:BEFORE FIELD xcdk021 name="input.b.page1.xcdk021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk021
            
            #add-point:AFTER FIELD xcdk021 name="input.a.page1.xcdk021"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdk021
            #add-point:ON CHANGE xcdk021 name="input.g.page1.xcdk021"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk011
            
            #add-point:AFTER FIELD xcdk011 name="input.a.page1.xcdk011"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcdk_d[l_ac].xcdk011
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcdk_d[l_ac].xcdk011_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcdk_d[l_ac].xcdk011_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk011
            #add-point:BEFORE FIELD xcdk011 name="input.b.page1.xcdk011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdk011
            #add-point:ON CHANGE xcdk011 name="input.g.page1.xcdk011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk010
            
            #add-point:AFTER FIELD xcdk010 name="input.a.page1.xcdk010"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcdk_m.xcdkld IS NOT NULL AND g_xcdk_m.xcdk001 IS NOT NULL AND g_xcdk_m.xcdk003 IS NOT NULL AND g_xcdk_m.xcdk004 IS NOT NULL AND g_xcdk_m.xcdk005 IS NOT NULL AND g_xcdk_d[g_detail_idx].xcdk002 IS NOT NULL AND g_xcdk_d[g_detail_idx].xcdk006 IS NOT NULL AND g_xcdk_d[g_detail_idx].xcdk007 IS NOT NULL AND g_xcdk_d[g_detail_idx].xcdk008 IS NOT NULL AND g_xcdk_d[g_detail_idx].xcdk009 IS NOT NULL AND g_xcdk_d[g_detail_idx].xcdk010 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcdk_m.xcdkld != g_xcdkld_t OR g_xcdk_m.xcdk001 != g_xcdk001_t OR g_xcdk_m.xcdk003 != g_xcdk003_t OR g_xcdk_m.xcdk004 != g_xcdk004_t OR g_xcdk_m.xcdk005 != g_xcdk005_t OR g_xcdk_d[g_detail_idx].xcdk002 != g_xcdk_d_t.xcdk002 OR g_xcdk_d[g_detail_idx].xcdk006 != g_xcdk_d_t.xcdk006 OR g_xcdk_d[g_detail_idx].xcdk007 != g_xcdk_d_t.xcdk007 OR g_xcdk_d[g_detail_idx].xcdk008 != g_xcdk_d_t.xcdk008 OR g_xcdk_d[g_detail_idx].xcdk009 != g_xcdk_d_t.xcdk009 OR g_xcdk_d[g_detail_idx].xcdk010 != g_xcdk_d_t.xcdk010)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcdk_t WHERE "||"xcdkent = '" ||g_enterprise|| "' AND "||"xcdkld = '"||g_xcdk_m.xcdkld ||"' AND "|| "xcdk001 = '"||g_xcdk_m.xcdk001 ||"' AND "|| "xcdk003 = '"||g_xcdk_m.xcdk003 ||"' AND "|| "xcdk004 = '"||g_xcdk_m.xcdk004 ||"' AND "|| "xcdk005 = '"||g_xcdk_m.xcdk005 ||"' AND "|| "xcdk002 = '"||g_xcdk_d[g_detail_idx].xcdk002 ||"' AND "|| "xcdk006 = '"||g_xcdk_d[g_detail_idx].xcdk006 ||"' AND "|| "xcdk007 = '"||g_xcdk_d[g_detail_idx].xcdk007 ||"' AND "|| "xcdk008 = '"||g_xcdk_d[g_detail_idx].xcdk008 ||"' AND "|| "xcdk009 = '"||g_xcdk_d[g_detail_idx].xcdk009 ||"' AND "|| "xcdk010 = '"||g_xcdk_d[g_detail_idx].xcdk010 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            IF NOT cl_null(g_xcdk_d[l_ac].xcdk010) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xcdk_d[l_ac].xcdk010
               #160318-00025#10--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "axc-00056:sub-01302|axci111|",cl_get_progname("axci111",g_lang,"2"),"|:EXEPROGaxci111"
               #160318-00025#10--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_xcau001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcdk_d[l_ac].xcdk010
            CALL ap_ref_array2(g_ref_fields,"SELECT xcaul003 FROM xcaul_t WHERE xcaulent='"||g_enterprise||"' AND xcaul001=? AND xcaul002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcdk_d[l_ac].xcdk010_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcdk_d[l_ac].xcdk010_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk010
            #add-point:BEFORE FIELD xcdk010 name="input.b.page1.xcdk010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdk010
            #add-point:ON CHANGE xcdk010 name="input.g.page1.xcdk010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk012
            #add-point:BEFORE FIELD xcdk012 name="input.b.page1.xcdk012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk012
            
            #add-point:AFTER FIELD xcdk012 name="input.a.page1.xcdk012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdk012
            #add-point:ON CHANGE xcdk012 name="input.g.page1.xcdk012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk016
            
            #add-point:AFTER FIELD xcdk016 name="input.a.page1.xcdk016"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk016
            #add-point:BEFORE FIELD xcdk016 name="input.b.page1.xcdk016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdk016
            #add-point:ON CHANGE xcdk016 name="input.g.page1.xcdk016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk018
            #add-point:BEFORE FIELD xcdk018 name="input.b.page1.xcdk018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk018
            
            #add-point:AFTER FIELD xcdk018 name="input.a.page1.xcdk018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdk018
            #add-point:ON CHANGE xcdk018 name="input.g.page1.xcdk018"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk002
            
            #add-point:AFTER FIELD xcdk002 name="input.a.page1.xcdk002"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcdk_m.xcdkld IS NOT NULL AND g_xcdk_m.xcdk001 IS NOT NULL AND g_xcdk_m.xcdk003 IS NOT NULL AND g_xcdk_m.xcdk004 IS NOT NULL AND g_xcdk_m.xcdk005 IS NOT NULL AND g_xcdk_d[g_detail_idx].xcdk002 IS NOT NULL AND g_xcdk_d[g_detail_idx].xcdk006 IS NOT NULL AND g_xcdk_d[g_detail_idx].xcdk007 IS NOT NULL AND g_xcdk_d[g_detail_idx].xcdk008 IS NOT NULL AND g_xcdk_d[g_detail_idx].xcdk009 IS NOT NULL AND g_xcdk_d[g_detail_idx].xcdk010 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcdk_m.xcdkld != g_xcdkld_t OR g_xcdk_m.xcdk001 != g_xcdk001_t OR g_xcdk_m.xcdk003 != g_xcdk003_t OR g_xcdk_m.xcdk004 != g_xcdk004_t OR g_xcdk_m.xcdk005 != g_xcdk005_t OR g_xcdk_d[g_detail_idx].xcdk002 != g_xcdk_d_t.xcdk002 OR g_xcdk_d[g_detail_idx].xcdk006 != g_xcdk_d_t.xcdk006 OR g_xcdk_d[g_detail_idx].xcdk007 != g_xcdk_d_t.xcdk007 OR g_xcdk_d[g_detail_idx].xcdk008 != g_xcdk_d_t.xcdk008 OR g_xcdk_d[g_detail_idx].xcdk009 != g_xcdk_d_t.xcdk009 OR g_xcdk_d[g_detail_idx].xcdk010 != g_xcdk_d_t.xcdk010)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcdk_t WHERE "||"xcdkent = '" ||g_enterprise|| "' AND "||"xcdkld = '"||g_xcdk_m.xcdkld ||"' AND "|| "xcdk001 = '"||g_xcdk_m.xcdk001 ||"' AND "|| "xcdk003 = '"||g_xcdk_m.xcdk003 ||"' AND "|| "xcdk004 = '"||g_xcdk_m.xcdk004 ||"' AND "|| "xcdk005 = '"||g_xcdk_m.xcdk005 ||"' AND "|| "xcdk002 = '"||g_xcdk_d[g_detail_idx].xcdk002 ||"' AND "|| "xcdk006 = '"||g_xcdk_d[g_detail_idx].xcdk006 ||"' AND "|| "xcdk007 = '"||g_xcdk_d[g_detail_idx].xcdk007 ||"' AND "|| "xcdk008 = '"||g_xcdk_d[g_detail_idx].xcdk008 ||"' AND "|| "xcdk009 = '"||g_xcdk_d[g_detail_idx].xcdk009 ||"' AND "|| "xcdk010 = '"||g_xcdk_d[g_detail_idx].xcdk010 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcdk_m.xcdkcomp
            LET g_ref_fields[2] = g_xcdk_d[l_ac].xcdk002
            CALL ap_ref_array2(g_ref_fields,"SELECT xcbfl003 FROM xcbfl_t WHERE xcbflent='"||g_enterprise||"' AND xcbflcomp=? AND xcbfl001=? AND xcbfl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcdk_d[l_ac].xcdk002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcdk_d[l_ac].xcdk002_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk002
            #add-point:BEFORE FIELD xcdk002 name="input.b.page1.xcdk002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdk002
            #add-point:ON CHANGE xcdk002 name="input.g.page1.xcdk002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk009
            #add-point:BEFORE FIELD xcdk009 name="input.b.page1.xcdk009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk009
            
            #add-point:AFTER FIELD xcdk009 name="input.a.page1.xcdk009"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcdk_m.xcdkld IS NOT NULL AND g_xcdk_m.xcdk001 IS NOT NULL AND g_xcdk_m.xcdk003 IS NOT NULL AND g_xcdk_m.xcdk004 IS NOT NULL AND g_xcdk_m.xcdk005 IS NOT NULL AND g_xcdk_d[g_detail_idx].xcdk002 IS NOT NULL AND g_xcdk_d[g_detail_idx].xcdk006 IS NOT NULL AND g_xcdk_d[g_detail_idx].xcdk007 IS NOT NULL AND g_xcdk_d[g_detail_idx].xcdk008 IS NOT NULL AND g_xcdk_d[g_detail_idx].xcdk009 IS NOT NULL AND g_xcdk_d[g_detail_idx].xcdk010 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcdk_m.xcdkld != g_xcdkld_t OR g_xcdk_m.xcdk001 != g_xcdk001_t OR g_xcdk_m.xcdk003 != g_xcdk003_t OR g_xcdk_m.xcdk004 != g_xcdk004_t OR g_xcdk_m.xcdk005 != g_xcdk005_t OR g_xcdk_d[g_detail_idx].xcdk002 != g_xcdk_d_t.xcdk002 OR g_xcdk_d[g_detail_idx].xcdk006 != g_xcdk_d_t.xcdk006 OR g_xcdk_d[g_detail_idx].xcdk007 != g_xcdk_d_t.xcdk007 OR g_xcdk_d[g_detail_idx].xcdk008 != g_xcdk_d_t.xcdk008 OR g_xcdk_d[g_detail_idx].xcdk009 != g_xcdk_d_t.xcdk009 OR g_xcdk_d[g_detail_idx].xcdk010 != g_xcdk_d_t.xcdk010)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcdk_t WHERE "||"xcdkent = '" ||g_enterprise|| "' AND "||"xcdkld = '"||g_xcdk_m.xcdkld ||"' AND "|| "xcdk001 = '"||g_xcdk_m.xcdk001 ||"' AND "|| "xcdk003 = '"||g_xcdk_m.xcdk003 ||"' AND "|| "xcdk004 = '"||g_xcdk_m.xcdk004 ||"' AND "|| "xcdk005 = '"||g_xcdk_m.xcdk005 ||"' AND "|| "xcdk002 = '"||g_xcdk_d[g_detail_idx].xcdk002 ||"' AND "|| "xcdk006 = '"||g_xcdk_d[g_detail_idx].xcdk006 ||"' AND "|| "xcdk007 = '"||g_xcdk_d[g_detail_idx].xcdk007 ||"' AND "|| "xcdk008 = '"||g_xcdk_d[g_detail_idx].xcdk008 ||"' AND "|| "xcdk009 = '"||g_xcdk_d[g_detail_idx].xcdk009 ||"' AND "|| "xcdk010 = '"||g_xcdk_d[g_detail_idx].xcdk010 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdk009
            #add-point:ON CHANGE xcdk009 name="input.g.page1.xcdk009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk022
            #add-point:BEFORE FIELD xcdk022 name="input.b.page1.xcdk022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk022
            
            #add-point:AFTER FIELD xcdk022 name="input.a.page1.xcdk022"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdk022
            #add-point:ON CHANGE xcdk022 name="input.g.page1.xcdk022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk023
            #add-point:BEFORE FIELD xcdk023 name="input.b.page1.xcdk023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk023
            
            #add-point:AFTER FIELD xcdk023 name="input.a.page1.xcdk023"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdk023
            #add-point:ON CHANGE xcdk023 name="input.g.page1.xcdk023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk024
            #add-point:BEFORE FIELD xcdk024 name="input.b.page1.xcdk024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk024
            
            #add-point:AFTER FIELD xcdk024 name="input.a.page1.xcdk024"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdk024
            #add-point:ON CHANGE xcdk024 name="input.g.page1.xcdk024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk026
            #add-point:BEFORE FIELD xcdk026 name="input.b.page1.xcdk026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk026
            
            #add-point:AFTER FIELD xcdk026 name="input.a.page1.xcdk026"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdk026
            #add-point:ON CHANGE xcdk026 name="input.g.page1.xcdk026"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk027
            #add-point:BEFORE FIELD xcdk027 name="input.b.page1.xcdk027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk027
            
            #add-point:AFTER FIELD xcdk027 name="input.a.page1.xcdk027"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdk027
            #add-point:ON CHANGE xcdk027 name="input.g.page1.xcdk027"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk028
            #add-point:BEFORE FIELD xcdk028 name="input.b.page1.xcdk028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk028
            
            #add-point:AFTER FIELD xcdk028 name="input.a.page1.xcdk028"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdk028
            #add-point:ON CHANGE xcdk028 name="input.g.page1.xcdk028"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk029
            #add-point:BEFORE FIELD xcdk029 name="input.b.page1.xcdk029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk029
            
            #add-point:AFTER FIELD xcdk029 name="input.a.page1.xcdk029"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdk029
            #add-point:ON CHANGE xcdk029 name="input.g.page1.xcdk029"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk030
            #add-point:BEFORE FIELD xcdk030 name="input.b.page1.xcdk030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk030
            
            #add-point:AFTER FIELD xcdk030 name="input.a.page1.xcdk030"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdk030
            #add-point:ON CHANGE xcdk030 name="input.g.page1.xcdk030"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk031
            #add-point:BEFORE FIELD xcdk031 name="input.b.page1.xcdk031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk031
            
            #add-point:AFTER FIELD xcdk031 name="input.a.page1.xcdk031"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdk031
            #add-point:ON CHANGE xcdk031 name="input.g.page1.xcdk031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk048
            #add-point:BEFORE FIELD xcdk048 name="input.b.page1.xcdk048"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk048
            
            #add-point:AFTER FIELD xcdk048 name="input.a.page1.xcdk048"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdk048
            #add-point:ON CHANGE xcdk048 name="input.g.page1.xcdk048"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk049
            #add-point:BEFORE FIELD xcdk049 name="input.b.page1.xcdk049"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk049
            
            #add-point:AFTER FIELD xcdk049 name="input.a.page1.xcdk049"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdk049
            #add-point:ON CHANGE xcdk049 name="input.g.page1.xcdk049"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk050
            #add-point:BEFORE FIELD xcdk050 name="input.b.page1.xcdk050"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk050
            
            #add-point:AFTER FIELD xcdk050 name="input.a.page1.xcdk050"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdk050
            #add-point:ON CHANGE xcdk050 name="input.g.page1.xcdk050"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk051
            #add-point:BEFORE FIELD xcdk051 name="input.b.page1.xcdk051"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk051
            
            #add-point:AFTER FIELD xcdk051 name="input.a.page1.xcdk051"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdk051
            #add-point:ON CHANGE xcdk051 name="input.g.page1.xcdk051"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk201
            #add-point:BEFORE FIELD xcdk201 name="input.b.page1.xcdk201"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk201
            
            #add-point:AFTER FIELD xcdk201 name="input.a.page1.xcdk201"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdk201
            #add-point:ON CHANGE xcdk201 name="input.g.page1.xcdk201"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xcdk202a
            #add-point:BEFORE FIELD l_xcdk202a name="input.b.page1.l_xcdk202a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xcdk202a
            
            #add-point:AFTER FIELD l_xcdk202a name="input.a.page1.l_xcdk202a"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xcdk202a
            #add-point:ON CHANGE l_xcdk202a name="input.g.page1.l_xcdk202a"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xcdk202b
            #add-point:BEFORE FIELD l_xcdk202b name="input.b.page1.l_xcdk202b"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xcdk202b
            
            #add-point:AFTER FIELD l_xcdk202b name="input.a.page1.l_xcdk202b"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xcdk202b
            #add-point:ON CHANGE l_xcdk202b name="input.g.page1.l_xcdk202b"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xcdk202c
            #add-point:BEFORE FIELD l_xcdk202c name="input.b.page1.l_xcdk202c"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xcdk202c
            
            #add-point:AFTER FIELD l_xcdk202c name="input.a.page1.l_xcdk202c"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xcdk202c
            #add-point:ON CHANGE l_xcdk202c name="input.g.page1.l_xcdk202c"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xcdk202d
            #add-point:BEFORE FIELD l_xcdk202d name="input.b.page1.l_xcdk202d"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xcdk202d
            
            #add-point:AFTER FIELD l_xcdk202d name="input.a.page1.l_xcdk202d"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xcdk202d
            #add-point:ON CHANGE l_xcdk202d name="input.g.page1.l_xcdk202d"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xcdk202e
            #add-point:BEFORE FIELD l_xcdk202e name="input.b.page1.l_xcdk202e"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xcdk202e
            
            #add-point:AFTER FIELD l_xcdk202e name="input.a.page1.l_xcdk202e"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xcdk202e
            #add-point:ON CHANGE l_xcdk202e name="input.g.page1.l_xcdk202e"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xcdk202f
            #add-point:BEFORE FIELD l_xcdk202f name="input.b.page1.l_xcdk202f"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xcdk202f
            
            #add-point:AFTER FIELD l_xcdk202f name="input.a.page1.l_xcdk202f"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xcdk202f
            #add-point:ON CHANGE l_xcdk202f name="input.g.page1.l_xcdk202f"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xcdk202g
            #add-point:BEFORE FIELD l_xcdk202g name="input.b.page1.l_xcdk202g"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xcdk202g
            
            #add-point:AFTER FIELD l_xcdk202g name="input.a.page1.l_xcdk202g"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xcdk202g
            #add-point:ON CHANGE l_xcdk202g name="input.g.page1.l_xcdk202g"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xcdk202h
            #add-point:BEFORE FIELD l_xcdk202h name="input.b.page1.l_xcdk202h"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xcdk202h
            
            #add-point:AFTER FIELD l_xcdk202h name="input.a.page1.l_xcdk202h"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xcdk202h
            #add-point:ON CHANGE l_xcdk202h name="input.g.page1.l_xcdk202h"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdk202
            #add-point:BEFORE FIELD xcdk202 name="input.b.page1.xcdk202"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdk202
            
            #add-point:AFTER FIELD xcdk202 name="input.a.page1.xcdk202"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdk202
            #add-point:ON CHANGE xcdk202 name="input.g.page1.xcdk202"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.xcdksite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdksite
            #add-point:ON ACTION controlp INFIELD xcdksite name="input.c.page1.xcdksite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcdk014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk014
            #add-point:ON ACTION controlp INFIELD xcdk014 name="input.c.page1.xcdk014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcdk047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk047
            #add-point:ON ACTION controlp INFIELD xcdk047 name="input.c.page1.xcdk047"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcdk006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk006
            #add-point:ON ACTION controlp INFIELD xcdk006 name="input.c.page1.xcdk006"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcdk_d[l_ac].xcdk006             #給予default值
            LET g_qryparam.default2 = "" #g_xcdk_d[l_ac].inba002 #扣帐日期
            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.arg2 = "" #
            
            CALL q_inbadocno_4()                                #呼叫開窗

            LET g_xcdk_d[l_ac].xcdk006 = g_qryparam.return1              
            #LET g_xcdk_d[l_ac].inba002 = g_qryparam.return2 
            DISPLAY g_xcdk_d[l_ac].xcdk006 TO xcdk006              #
            #DISPLAY g_xcdk_d[l_ac].inba002 TO inba002 #扣帐日期
            NEXT FIELD xcdk006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xcdk007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk007
            #add-point:ON ACTION controlp INFIELD xcdk007 name="input.c.page1.xcdk007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcdk008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk008
            #add-point:ON ACTION controlp INFIELD xcdk008 name="input.c.page1.xcdk008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcdk025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk025
            #add-point:ON ACTION controlp INFIELD xcdk025 name="input.c.page1.xcdk025"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcdk021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk021
            #add-point:ON ACTION controlp INFIELD xcdk021 name="input.c.page1.xcdk021"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcdk011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk011
            #add-point:ON ACTION controlp INFIELD xcdk011 name="input.c.page1.xcdk011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcdk010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk010
            #add-point:ON ACTION controlp INFIELD xcdk010 name="input.c.page1.xcdk010"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcdk_d[l_ac].xcdk010             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_xcau001()                                #呼叫開窗

            LET g_xcdk_d[l_ac].xcdk010 = g_qryparam.return1              

            DISPLAY g_xcdk_d[l_ac].xcdk010 TO xcdk010              #

            NEXT FIELD xcdk010                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xcdk012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk012
            #add-point:ON ACTION controlp INFIELD xcdk012 name="input.c.page1.xcdk012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcdk016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk016
            #add-point:ON ACTION controlp INFIELD xcdk016 name="input.c.page1.xcdk016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcdk018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk018
            #add-point:ON ACTION controlp INFIELD xcdk018 name="input.c.page1.xcdk018"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcdk_d[l_ac].xcdk018             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_inaj010()                                #呼叫開窗

            LET g_xcdk_d[l_ac].xcdk018 = g_qryparam.return1              

            DISPLAY g_xcdk_d[l_ac].xcdk018 TO xcdk018              #

            NEXT FIELD xcdk018                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xcdk002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk002
            #add-point:ON ACTION controlp INFIELD xcdk002 name="input.c.page1.xcdk002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcdk009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk009
            #add-point:ON ACTION controlp INFIELD xcdk009 name="input.c.page1.xcdk009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcdk022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk022
            #add-point:ON ACTION controlp INFIELD xcdk022 name="input.c.page1.xcdk022"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcdk023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk023
            #add-point:ON ACTION controlp INFIELD xcdk023 name="input.c.page1.xcdk023"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcdk024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk024
            #add-point:ON ACTION controlp INFIELD xcdk024 name="input.c.page1.xcdk024"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcdk026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk026
            #add-point:ON ACTION controlp INFIELD xcdk026 name="input.c.page1.xcdk026"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcdk027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk027
            #add-point:ON ACTION controlp INFIELD xcdk027 name="input.c.page1.xcdk027"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcdk028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk028
            #add-point:ON ACTION controlp INFIELD xcdk028 name="input.c.page1.xcdk028"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcdk029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk029
            #add-point:ON ACTION controlp INFIELD xcdk029 name="input.c.page1.xcdk029"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcdk030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk030
            #add-point:ON ACTION controlp INFIELD xcdk030 name="input.c.page1.xcdk030"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcdk031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk031
            #add-point:ON ACTION controlp INFIELD xcdk031 name="input.c.page1.xcdk031"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcdk048
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk048
            #add-point:ON ACTION controlp INFIELD xcdk048 name="input.c.page1.xcdk048"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcdk049
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk049
            #add-point:ON ACTION controlp INFIELD xcdk049 name="input.c.page1.xcdk049"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcdk050
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk050
            #add-point:ON ACTION controlp INFIELD xcdk050 name="input.c.page1.xcdk050"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcdk051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk051
            #add-point:ON ACTION controlp INFIELD xcdk051 name="input.c.page1.xcdk051"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcdk201
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk201
            #add-point:ON ACTION controlp INFIELD xcdk201 name="input.c.page1.xcdk201"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xcdk202a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xcdk202a
            #add-point:ON ACTION controlp INFIELD l_xcdk202a name="input.c.page1.l_xcdk202a"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xcdk202b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xcdk202b
            #add-point:ON ACTION controlp INFIELD l_xcdk202b name="input.c.page1.l_xcdk202b"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xcdk202c
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xcdk202c
            #add-point:ON ACTION controlp INFIELD l_xcdk202c name="input.c.page1.l_xcdk202c"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xcdk202d
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xcdk202d
            #add-point:ON ACTION controlp INFIELD l_xcdk202d name="input.c.page1.l_xcdk202d"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xcdk202e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xcdk202e
            #add-point:ON ACTION controlp INFIELD l_xcdk202e name="input.c.page1.l_xcdk202e"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xcdk202f
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xcdk202f
            #add-point:ON ACTION controlp INFIELD l_xcdk202f name="input.c.page1.l_xcdk202f"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xcdk202g
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xcdk202g
            #add-point:ON ACTION controlp INFIELD l_xcdk202g name="input.c.page1.l_xcdk202g"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xcdk202h
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xcdk202h
            #add-point:ON ACTION controlp INFIELD l_xcdk202h name="input.c.page1.l_xcdk202h"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcdk202
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdk202
            #add-point:ON ACTION controlp INFIELD xcdk202 name="input.c.page1.xcdk202"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_xcdk_d[l_ac].* = g_xcdk_d_t.*
               CLOSE axcq715_bcl
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
               LET g_errparam.extend = g_xcdk_d[l_ac].xcdk002 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_xcdk_d[l_ac].* = g_xcdk_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               LET g_xcdk2_d[l_ac].xcdkmodid = g_user 
LET g_xcdk2_d[l_ac].xcdkmoddt = cl_get_current()
LET g_xcdk2_d[l_ac].xcdkmodid_desc = cl_get_username(g_xcdk2_d[l_ac].xcdkmodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
         
               #將遮罩欄位還原
               CALL axcq715_xcdk_t_mask_restore('restore_mask_o')
         
               UPDATE xcdk_t SET (xcdkld,xcdk001,xcdk003,xcdk004,xcdk005,xcdksite,xcdk014,xcdk047,xcdk006, 
                   xcdk007,xcdk008,xcdk025,xcdk021,xcdk011,xcdk010,xcdk012,xcdk016,xcdk018,xcdk002,xcdk009, 
                   xcdk022,xcdk023,xcdk024,xcdk026,xcdk027,xcdk028,xcdk029,xcdk030,xcdk031,xcdk048,xcdk049, 
                   xcdk050,xcdk051,xcdk201,xcdk202,xcdkownid,xcdkowndp,xcdkcrtid,xcdkcrtdp,xcdkcrtdt, 
                   xcdkmodid,xcdkmoddt) = (g_xcdk_m.xcdkld,g_xcdk_m.xcdk001,g_xcdk_m.xcdk003,g_xcdk_m.xcdk004, 
                   g_xcdk_m.xcdk005,g_xcdk_d[l_ac].xcdksite,g_xcdk_d[l_ac].xcdk014,g_xcdk_d[l_ac].xcdk047, 
                   g_xcdk_d[l_ac].xcdk006,g_xcdk_d[l_ac].xcdk007,g_xcdk_d[l_ac].xcdk008,g_xcdk_d[l_ac].xcdk025, 
                   g_xcdk_d[l_ac].xcdk021,g_xcdk_d[l_ac].xcdk011,g_xcdk_d[l_ac].xcdk010,g_xcdk_d[l_ac].xcdk012, 
                   g_xcdk_d[l_ac].xcdk016,g_xcdk_d[l_ac].xcdk018,g_xcdk_d[l_ac].xcdk002,g_xcdk_d[l_ac].xcdk009, 
                   g_xcdk_d[l_ac].xcdk022,g_xcdk_d[l_ac].xcdk023,g_xcdk_d[l_ac].xcdk024,g_xcdk_d[l_ac].xcdk026, 
                   g_xcdk_d[l_ac].xcdk027,g_xcdk_d[l_ac].xcdk028,g_xcdk_d[l_ac].xcdk029,g_xcdk_d[l_ac].xcdk030, 
                   g_xcdk_d[l_ac].xcdk031,g_xcdk_d[l_ac].xcdk048,g_xcdk_d[l_ac].xcdk049,g_xcdk_d[l_ac].xcdk050, 
                   g_xcdk_d[l_ac].xcdk051,g_xcdk_d[l_ac].xcdk201,g_xcdk_d[l_ac].xcdk202,g_xcdk2_d[l_ac].xcdkownid, 
                   g_xcdk2_d[l_ac].xcdkowndp,g_xcdk2_d[l_ac].xcdkcrtid,g_xcdk2_d[l_ac].xcdkcrtdp,g_xcdk2_d[l_ac].xcdkcrtdt, 
                   g_xcdk2_d[l_ac].xcdkmodid,g_xcdk2_d[l_ac].xcdkmoddt)
                WHERE xcdkent = g_enterprise AND xcdkld = g_xcdk_m.xcdkld 
                 AND xcdk001 = g_xcdk_m.xcdk001 
                 AND xcdk003 = g_xcdk_m.xcdk003 
                 AND xcdk004 = g_xcdk_m.xcdk004 
                 AND xcdk005 = g_xcdk_m.xcdk005 
 
                 AND xcdk002 = g_xcdk_d_t.xcdk002 #項次   
                 AND xcdk006 = g_xcdk_d_t.xcdk006  
                 AND xcdk007 = g_xcdk_d_t.xcdk007  
                 AND xcdk008 = g_xcdk_d_t.xcdk008  
                 AND xcdk009 = g_xcdk_d_t.xcdk009  
                 AND xcdk010 = g_xcdk_d_t.xcdk010  
 
                 
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcdk_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "xcdk_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xcdk_m.xcdkld
               LET gs_keys_bak[1] = g_xcdkld_t
               LET gs_keys[2] = g_xcdk_m.xcdk001
               LET gs_keys_bak[2] = g_xcdk001_t
               LET gs_keys[3] = g_xcdk_m.xcdk003
               LET gs_keys_bak[3] = g_xcdk003_t
               LET gs_keys[4] = g_xcdk_m.xcdk004
               LET gs_keys_bak[4] = g_xcdk004_t
               LET gs_keys[5] = g_xcdk_m.xcdk005
               LET gs_keys_bak[5] = g_xcdk005_t
               LET gs_keys[6] = g_xcdk_d[g_detail_idx].xcdk002
               LET gs_keys_bak[6] = g_xcdk_d_t.xcdk002
               LET gs_keys[7] = g_xcdk_d[g_detail_idx].xcdk006
               LET gs_keys_bak[7] = g_xcdk_d_t.xcdk006
               LET gs_keys[8] = g_xcdk_d[g_detail_idx].xcdk007
               LET gs_keys_bak[8] = g_xcdk_d_t.xcdk007
               LET gs_keys[9] = g_xcdk_d[g_detail_idx].xcdk008
               LET gs_keys_bak[9] = g_xcdk_d_t.xcdk008
               LET gs_keys[10] = g_xcdk_d[g_detail_idx].xcdk009
               LET gs_keys_bak[10] = g_xcdk_d_t.xcdk009
               LET gs_keys[11] = g_xcdk_d[g_detail_idx].xcdk010
               LET gs_keys_bak[11] = g_xcdk_d_t.xcdk010
               CALL axcq715_update_b('xcdk_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_xcdk_m),util.JSON.stringify(g_xcdk_d_t)
                     LET g_log2 = util.JSON.stringify(g_xcdk_m),util.JSON.stringify(g_xcdk_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL axcq715_xcdk_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_xcdk_m.xcdkld
               LET ls_keys[ls_keys.getLength()+1] = g_xcdk_m.xcdk001
               LET ls_keys[ls_keys.getLength()+1] = g_xcdk_m.xcdk003
               LET ls_keys[ls_keys.getLength()+1] = g_xcdk_m.xcdk004
               LET ls_keys[ls_keys.getLength()+1] = g_xcdk_m.xcdk005
 
               LET ls_keys[ls_keys.getLength()+1] = g_xcdk_d_t.xcdk002
               LET ls_keys[ls_keys.getLength()+1] = g_xcdk_d_t.xcdk006
               LET ls_keys[ls_keys.getLength()+1] = g_xcdk_d_t.xcdk007
               LET ls_keys[ls_keys.getLength()+1] = g_xcdk_d_t.xcdk008
               LET ls_keys[ls_keys.getLength()+1] = g_xcdk_d_t.xcdk009
               LET ls_keys[ls_keys.getLength()+1] = g_xcdk_d_t.xcdk010
 
               CALL axcq715_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE axcq715_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xcdk_d[l_ac].* = g_xcdk_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE axcq715_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_xcdk_d.getLength() = 0 THEN
               NEXT FIELD xcdk002
            END IF
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_xcdk_d[li_reproduce_target].* = g_xcdk_d[li_reproduce].*
               LET g_xcdk2_d[li_reproduce_target].* = g_xcdk2_d[li_reproduce].*
 
               LET g_xcdk_d[li_reproduce_target].xcdk002 = NULL
               LET g_xcdk_d[li_reproduce_target].xcdk006 = NULL
               LET g_xcdk_d[li_reproduce_target].xcdk007 = NULL
               LET g_xcdk_d[li_reproduce_target].xcdk008 = NULL
               LET g_xcdk_d[li_reproduce_target].xcdk009 = NULL
               LET g_xcdk_d[li_reproduce_target].xcdk010 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_xcdk_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xcdk_d.getLength()+1
            END IF
            
      END INPUT
 
 
      
      DISPLAY ARRAY g_xcdk2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
      
         BEFORE ROW
            CALL axcq715_b_fill(g_wc2) #test 
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_page = 2
            CALL axcq715_idx_chk()
            CALL axcq715_ui_detailshow()
        
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
            NEXT FIELD xcdkld
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD xcdksite
               WHEN "s_detail2"
                  NEXT FIELD xcdkownid
 
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
 
{<section id="axcq715.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION axcq715_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   #fengmy 150113----begin
   #根據參數顯示隱藏成本域 和 料件特性
   IF cl_null(g_xcdk_m.xcdkcomp) THEN
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data1   #采用特性否       
   ELSE
      CALL cl_get_para(g_enterprise,g_xcdk_m.xcdkcomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
      CALL cl_get_para(g_enterprise,g_xcdk_m.xcdkcomp,'S-FIN-6013') RETURNING g_para_data1   #采用特性否       
   END IF   
   IF g_para_data = 'Y' THEN
      CALL cl_set_comp_visible('xcdk002,xcdk002_desc',TRUE)                    
   ELSE                        
      CALL cl_set_comp_visible('xcdk002,xcdk002_desc',FALSE)                
   END IF   
   IF g_para_data1 = 'Y' THEN
      CALL cl_set_comp_visible('xcdk012',TRUE)                    
   ELSE                       
      CALL cl_set_comp_visible('xcdk012',FALSE)                
   END IF   
   #fengmy 150113----end
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL axcq715_b_fill(g_wc2) #第一階單身填充
      CALL axcq715_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL axcq715_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   CALL axcq715_ref()
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_xcdk_m.xcdkcomp,g_xcdk_m.xcdkcomp_desc,g_xcdk_m.xcdk004,g_xcdk_m.xcdk001,g_xcdk_m.xcdk001_desc, 
       g_xcdk_m.xcdkld,g_xcdk_m.xcdkld_desc,g_xcdk_m.xcdk005,g_xcdk_m.xcdk003,g_xcdk_m.xcdk003_desc
 
   CALL axcq715_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
   
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="axcq715.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION axcq715_ref_show()
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
   FOR l_ac = 1 TO g_xcdk_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_xcdk2_d.getLength()
      #add-point:ref_show段d2_reference name="ref_show.body2.reference"
      
      #end add-point
   END FOR
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="axcq715.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION axcq715_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE xcdk_t.xcdkld 
   DEFINE l_oldno     LIKE xcdk_t.xcdkld 
   DEFINE l_newno02     LIKE xcdk_t.xcdk001 
   DEFINE l_oldno02     LIKE xcdk_t.xcdk001 
   DEFINE l_newno03     LIKE xcdk_t.xcdk003 
   DEFINE l_oldno03     LIKE xcdk_t.xcdk003 
   DEFINE l_newno04     LIKE xcdk_t.xcdk004 
   DEFINE l_oldno04     LIKE xcdk_t.xcdk004 
   DEFINE l_newno05     LIKE xcdk_t.xcdk005 
   DEFINE l_oldno05     LIKE xcdk_t.xcdk005 
 
   DEFINE l_master    RECORD LIKE xcdk_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE xcdk_t.* #此變數樣板目前無使用
 
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
 
   IF g_xcdk_m.xcdkld IS NULL
      OR g_xcdk_m.xcdk001 IS NULL
      OR g_xcdk_m.xcdk003 IS NULL
      OR g_xcdk_m.xcdk004 IS NULL
      OR g_xcdk_m.xcdk005 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_xcdkld_t = g_xcdk_m.xcdkld
   LET g_xcdk001_t = g_xcdk_m.xcdk001
   LET g_xcdk003_t = g_xcdk_m.xcdk003
   LET g_xcdk004_t = g_xcdk_m.xcdk004
   LET g_xcdk005_t = g_xcdk_m.xcdk005
 
   
   LET g_xcdk_m.xcdkld = ""
   LET g_xcdk_m.xcdk001 = ""
   LET g_xcdk_m.xcdk003 = ""
   LET g_xcdk_m.xcdk004 = ""
   LET g_xcdk_m.xcdk005 = ""
 
   LET g_master_insert = FALSE
   CALL axcq715_set_entry('a')
   CALL axcq715_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #清空key欄位的desc
      LET g_xcdk_m.xcdk001_desc = ''
   DISPLAY BY NAME g_xcdk_m.xcdk001_desc
   LET g_xcdk_m.xcdkld_desc = ''
   DISPLAY BY NAME g_xcdk_m.xcdkld_desc
   LET g_xcdk_m.xcdk003_desc = ''
   DISPLAY BY NAME g_xcdk_m.xcdk003_desc
 
   
   CALL axcq715_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_xcdk_m.* TO NULL
      INITIALIZE g_xcdk_d TO NULL
      INITIALIZE g_xcdk2_d TO NULL
 
      CALL axcq715_show()
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
   CALL axcq715_set_act_visible()
   CALL axcq715_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_xcdkld_t = g_xcdk_m.xcdkld
   LET g_xcdk001_t = g_xcdk_m.xcdk001
   LET g_xcdk003_t = g_xcdk_m.xcdk003
   LET g_xcdk004_t = g_xcdk_m.xcdk004
   LET g_xcdk005_t = g_xcdk_m.xcdk005
 
   
   #組合新增資料的條件
   LET g_add_browse = " xcdkent = " ||g_enterprise|| " AND",
                      " xcdkld = '", g_xcdk_m.xcdkld, "' "
                      ," AND xcdk001 = '", g_xcdk_m.xcdk001, "' "
                      ," AND xcdk003 = '", g_xcdk_m.xcdk003, "' "
                      ," AND xcdk004 = '", g_xcdk_m.xcdk004, "' "
                      ," AND xcdk005 = '", g_xcdk_m.xcdk005, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axcq715_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL axcq715_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL axcq715_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="axcq715.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION axcq715_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE xcdk_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE axcq715_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xcdk_t
    WHERE xcdkent = g_enterprise AND xcdkld = g_xcdkld_t
    AND xcdk001 = g_xcdk001_t
    AND xcdk003 = g_xcdk003_t
    AND xcdk004 = g_xcdk004_t
    AND xcdk005 = g_xcdk005_t
 
       INTO TEMP axcq715_detail
   
   #將key修正為調整後   
   UPDATE axcq715_detail 
      #更新key欄位
      SET xcdkld = g_xcdk_m.xcdkld
          , xcdk001 = g_xcdk_m.xcdk001
          , xcdk003 = g_xcdk_m.xcdk003
          , xcdk004 = g_xcdk_m.xcdk004
          , xcdk005 = g_xcdk_m.xcdk005
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
       , xcdkownid = g_user 
       , xcdkowndp = g_dept
       , xcdkcrtid = g_user
       , xcdkcrtdp = g_dept 
       , xcdkcrtdt = ld_date
       , xcdkmodid = g_user
       , xcdkmoddt = ld_date
 
 
 
                                       
   #將資料塞回原table   
   INSERT INTO xcdk_t SELECT * FROM axcq715_detail
   
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
   DROP TABLE axcq715_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_xcdkld_t = g_xcdk_m.xcdkld
   LET g_xcdk001_t = g_xcdk_m.xcdk001
   LET g_xcdk003_t = g_xcdk_m.xcdk003
   LET g_xcdk004_t = g_xcdk_m.xcdk004
   LET g_xcdk005_t = g_xcdk_m.xcdk005
 
   
   DROP TABLE axcq715_detail
   
END FUNCTION
 
{</section>}
 
{<section id="axcq715.delete" >}
#+ 資料刪除
PRIVATE FUNCTION axcq715_delete()
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
   
   IF g_xcdk_m.xcdkld IS NULL
   OR g_xcdk_m.xcdk001 IS NULL
   OR g_xcdk_m.xcdk003 IS NULL
   OR g_xcdk_m.xcdk004 IS NULL
   OR g_xcdk_m.xcdk005 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN axcq715_cl USING g_enterprise,g_xcdk_m.xcdkld,g_xcdk_m.xcdk001,g_xcdk_m.xcdk003,g_xcdk_m.xcdk004,g_xcdk_m.xcdk005
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axcq715_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE axcq715_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axcq715_master_referesh USING g_xcdk_m.xcdkld,g_xcdk_m.xcdk001,g_xcdk_m.xcdk003,g_xcdk_m.xcdk004, 
       g_xcdk_m.xcdk005 INTO g_xcdk_m.xcdkcomp,g_xcdk_m.xcdk004,g_xcdk_m.xcdk001,g_xcdk_m.xcdkld,g_xcdk_m.xcdk005, 
       g_xcdk_m.xcdk003,g_xcdk_m.xcdkcomp_desc,g_xcdk_m.xcdkld_desc,g_xcdk_m.xcdk003_desc
   
   #遮罩相關處理
   LET g_xcdk_m_mask_o.* =  g_xcdk_m.*
   CALL axcq715_xcdk_t_mask()
   LET g_xcdk_m_mask_n.* =  g_xcdk_m.*
   
   CALL axcq715_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL axcq715_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM xcdk_t WHERE xcdkent = g_enterprise AND xcdkld = g_xcdk_m.xcdkld
                                                               AND xcdk001 = g_xcdk_m.xcdk001
                                                               AND xcdk003 = g_xcdk_m.xcdk003
                                                               AND xcdk004 = g_xcdk_m.xcdk004
                                                               AND xcdk005 = g_xcdk_m.xcdk005
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xcdk_t:",SQLERRMESSAGE 
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
      #   CLOSE axcq715_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_xcdk_d.clear() 
      CALL g_xcdk2_d.clear()       
 
     
      CALL axcq715_ui_browser_refresh()  
      #CALL axcq715_ui_headershow()  
      #CALL axcq715_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL axcq715_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL axcq715_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE axcq715_cl
 
   #功能已完成,通報訊息中心
   CALL axcq715_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="axcq715.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axcq715_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_xcau003  LIKE xcau_t.xcau003
   DEFINE l_xcdk202a_sum1   LIKE xcdk_t.xcdk202
   DEFINE l_xcdk202a_sum2   LIKE xcdk_t.xcdk202
   DEFINE l_xcdk202a_total  LIKE xcdk_t.xcdk202
   DEFINE l_xcdk202b_sum1   LIKE xcdk_t.xcdk202
   DEFINE l_xcdk202b_sum2   LIKE xcdk_t.xcdk202
   DEFINE l_xcdk202b_total  LIKE xcdk_t.xcdk202
   DEFINE l_xcdk202c_sum1   LIKE xcdk_t.xcdk202
   DEFINE l_xcdk202c_sum2   LIKE xcdk_t.xcdk202
   DEFINE l_xcdk202c_total  LIKE xcdk_t.xcdk202
   DEFINE l_xcdk202d_sum1   LIKE xcdk_t.xcdk202
   DEFINE l_xcdk202d_sum2   LIKE xcdk_t.xcdk202
   DEFINE l_xcdk202d_total  LIKE xcdk_t.xcdk202
   DEFINE l_xcdk202e_sum1   LIKE xcdk_t.xcdk202
   DEFINE l_xcdk202e_sum2   LIKE xcdk_t.xcdk202
   DEFINE l_xcdk202e_total  LIKE xcdk_t.xcdk202
   DEFINE l_xcdk202f_sum1   LIKE xcdk_t.xcdk202
   DEFINE l_xcdk202f_sum2   LIKE xcdk_t.xcdk202
   DEFINE l_xcdk202f_total  LIKE xcdk_t.xcdk202
   DEFINE l_xcdk202g_sum1   LIKE xcdk_t.xcdk202
   DEFINE l_xcdk202g_sum2   LIKE xcdk_t.xcdk202
   DEFINE l_xcdk202g_total  LIKE xcdk_t.xcdk202
   DEFINE l_xcdk202h_sum1   LIKE xcdk_t.xcdk202
   DEFINE l_xcdk202h_sum2   LIKE xcdk_t.xcdk202
   DEFINE l_xcdk202h_total  LIKE xcdk_t.xcdk202
   DEFINE l_xcdk202_sum1   LIKE xcdk_t.xcdk202
   DEFINE l_xcdk202_sum2   LIKE xcdk_t.xcdk202
   DEFINE l_xcdk202_total  LIKE xcdk_t.xcdk202
   
   DEFINE l_subtotal_msg   STRING  #160414-00018#55   2016/05/23 By earl add
   DEFINE l_total_msg      STRING  #160414-00018#55   2016/05/23 By earl add
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
 
   #end add-point
   
   #先清空單身變數內容
   CALL g_xcdk_d.clear()
   CALL g_xcdk2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
#160414-00018#55   2016/05/23 By earl mark s
{
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT xcdksite,xcdk014,xcdk047,xcdk006,xcdk007,xcdk008,xcdk025,xcdk021,xcdk011, 
       xcdk010,xcdk012,xcdk016,xcdk018,xcdk002,xcdk009,xcdk022,xcdk023,xcdk024,xcdk026,xcdk027,xcdk028, 
       xcdk029,xcdk030,xcdk031,xcdk048,xcdk049,xcdk050,xcdk051,xcdk201,xcdk202,xcdkownid,xcdkowndp,xcdkcrtid, 
       xcdkcrtdp,xcdkcrtdt,xcdkmodid,xcdkmoddt,xcdk002,xcdk006,xcdk007,xcdk008,xcdk009,xcdk010,t1.ooefl003 , 
       t2.imaal003 ,t3.imaal004 ,t4.xcaul003 ,t5.xcbfl003 ,t6.ooag011 ,t7.ooefl003 ,t8.ooag011 ,t9.ooefl003 , 
       t10.ooag011 FROM xcdk_t",   
               "",
               
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=xcdksite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=xcdk011 AND t2.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t3 ON t3.imaalent="||g_enterprise||" AND t3.imaal001=xcdk011 AND t3.imaal002='"||g_dlang||"' ",
               " LEFT JOIN xcaul_t t4 ON t4.xcaulent="||g_enterprise||" AND t4.xcaul001=xcdk010 AND t4.xcaul002='"||g_dlang||"' ",
               " LEFT JOIN xcbfl_t t5 ON t5.xcbflent="||g_enterprise||" AND t5.xcbflcomp=xcdkcomp AND t5.xcbfl001=xcdk002 AND t5.xcbfl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=xcdkownid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=xcdkowndp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=xcdkcrtid  ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent="||g_enterprise||" AND t9.ooefl001=xcdkcrtdp AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=xcdkmodid  ",
 
               " WHERE xcdkent= ? AND xcdkld=? AND xcdk001=? AND xcdk003=? AND xcdk004=? AND xcdk005=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xcdk_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = "SELECT  UNIQUE xcdksite,xcdk014,xcdk047,xcdk006,xcdk007,xcdk008,xcdk025,xcdk021,xcdk011, 
       xcdk010,xcdk012,xcdk016,xcdk018,xcdk002,xcdk009,'','','','','','', 
       '','','','','','','',xcdk201,xcdk202,xcdkownid,xcdkowndp,xcdkcrtid, 
       xcdkcrtdp,xcdkcrtdt,xcdkmodid,xcdkmoddt,xcdk002,xcdk006,xcdk007,xcdk008,xcdk009,xcdk010,t1.ooefl003 , 
       t2.imaal003 ,t3.imaal004 ,t4.xcaul003 ,t5.xcbfl003 ,t6.ooag011 ,t7.ooefl003 ,t8.ooag011 ,t9.ooefl003 , 
       t10.ooag011 FROM xcdk_t",   
               "",
               
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent='"||g_enterprise||"' AND t1.ooefl001=xcdksite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent='"||g_enterprise||"' AND t2.imaal001=xcdk011 AND t2.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t3 ON t3.imaalent='"||g_enterprise||"' AND t3.imaal001=xcdk011 AND t3.imaal002='"||g_dlang||"' ",
               " LEFT JOIN xcaul_t t4 ON t4.xcaulent='"||g_enterprise||"' AND t4.xcaul001=xcdk010 AND t4.xcaul002='"||g_dlang||"' ",
               " LEFT JOIN xcbfl_t t5 ON t5.xcbflent='"||g_enterprise||"' AND t5.xcbflcomp=xcdkcomp AND t5.xcbfl001=xcdk002 AND t5.xcbfl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent='"||g_enterprise||"' AND t6.ooag001=xcdkownid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent='"||g_enterprise||"' AND t7.ooefl001=xcdkowndp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent='"||g_enterprise||"' AND t8.ooag001=xcdkcrtid  ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent='"||g_enterprise||"' AND t9.ooefl001=xcdkcrtdp AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent='"||g_enterprise||"' AND t10.ooag001=xcdkmodid  ",
 
               " WHERE xcdkent= ? AND xcdkld=? AND xcdk001=? AND xcdk003=? AND xcdk004=? AND xcdk005=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xcdk_t")
   END IF
   
 # LET g_sql = g_sql,"   AND xcdk055 = '2052' "
   LET g_sql = g_sql," AND xcdk020 IN ('113','106') "
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF axcq715_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY xcdk_t.xcdk002,xcdk_t.xcdk006,xcdk_t.xcdk007,xcdk_t.xcdk008,xcdk_t.xcdk009,xcdk_t.xcdk010"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
      LET g_sql = cl_replace_str(g_sql," ORDER BY xcdk_t.xcdk002,xcdk_t.xcdk006,xcdk_t.xcdk007,xcdk_t.xcdk008,xcdk_t.xcdk009,xcdk_t.xcdk010"," ORDER BY xcdk_t.xcdk047,xcdk_t.xcdk006,xcdk_t.xcdk007,xcdk_t.xcdk008,xcdk_t.xcdk011 ")
      LET l_xcdk202a_sum1  = 0 
      LET l_xcdk202a_sum2  = 0 
      LET l_xcdk202a_total = 0 
      LET l_xcdk202b_sum1  = 0 
      LET l_xcdk202b_sum2  = 0 
      LET l_xcdk202b_total = 0 
      LET l_xcdk202c_sum1  = 0 
      LET l_xcdk202c_sum2  = 0 
      LET l_xcdk202c_total = 0 
      LET l_xcdk202d_sum1  = 0 
      LET l_xcdk202d_sum2  = 0 
      LET l_xcdk202d_total = 0 
      LET l_xcdk202e_sum1  = 0 
      LET l_xcdk202e_sum2  = 0 
      LET l_xcdk202e_total = 0 
      LET l_xcdk202f_sum1  = 0 
      LET l_xcdk202f_sum2  = 0 
      LET l_xcdk202f_total = 0 
      LET l_xcdk202g_sum1  = 0 
      LET l_xcdk202g_sum2  = 0 
      LET l_xcdk202g_total = 0 
      LET l_xcdk202h_sum1  = 0 
      LET l_xcdk202h_sum2  = 0 
      LET l_xcdk202h_total = 0 
      LET l_xcdk202_sum1   = 0
      LET l_xcdk202_sum2   = 0
      LET l_xcdk202_total  = 0
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axcq715_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR axcq715_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_xcdk_m.xcdkld,g_xcdk_m.xcdk001,g_xcdk_m.xcdk003,g_xcdk_m.xcdk004,g_xcdk_m.xcdk005   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_xcdk_m.xcdkld,g_xcdk_m.xcdk001,g_xcdk_m.xcdk003,g_xcdk_m.xcdk004, 
          g_xcdk_m.xcdk005 INTO g_xcdk_d[l_ac].xcdksite,g_xcdk_d[l_ac].xcdk014,g_xcdk_d[l_ac].xcdk047, 
          g_xcdk_d[l_ac].xcdk006,g_xcdk_d[l_ac].xcdk007,g_xcdk_d[l_ac].xcdk008,g_xcdk_d[l_ac].xcdk025, 
          g_xcdk_d[l_ac].xcdk021,g_xcdk_d[l_ac].xcdk011,g_xcdk_d[l_ac].xcdk010,g_xcdk_d[l_ac].xcdk012, 
          g_xcdk_d[l_ac].xcdk016,g_xcdk_d[l_ac].xcdk018,g_xcdk_d[l_ac].xcdk002,g_xcdk_d[l_ac].xcdk009, 
          g_xcdk_d[l_ac].xcdk022,g_xcdk_d[l_ac].xcdk023,g_xcdk_d[l_ac].xcdk024,g_xcdk_d[l_ac].xcdk026, 
          g_xcdk_d[l_ac].xcdk027,g_xcdk_d[l_ac].xcdk028,g_xcdk_d[l_ac].xcdk029,g_xcdk_d[l_ac].xcdk030, 
          g_xcdk_d[l_ac].xcdk031,g_xcdk_d[l_ac].xcdk048,g_xcdk_d[l_ac].xcdk049,g_xcdk_d[l_ac].xcdk050, 
          g_xcdk_d[l_ac].xcdk051,g_xcdk_d[l_ac].xcdk201,g_xcdk_d[l_ac].xcdk202,g_xcdk2_d[l_ac].xcdkownid, 
          g_xcdk2_d[l_ac].xcdkowndp,g_xcdk2_d[l_ac].xcdkcrtid,g_xcdk2_d[l_ac].xcdkcrtdp,g_xcdk2_d[l_ac].xcdkcrtdt, 
          g_xcdk2_d[l_ac].xcdkmodid,g_xcdk2_d[l_ac].xcdkmoddt,g_xcdk2_d[l_ac].xcdk002,g_xcdk2_d[l_ac].xcdk006, 
          g_xcdk2_d[l_ac].xcdk007,g_xcdk2_d[l_ac].xcdk008,g_xcdk2_d[l_ac].xcdk009,g_xcdk2_d[l_ac].xcdk010, 
          g_xcdk_d[l_ac].xcdksite_desc,g_xcdk_d[l_ac].xcdk011_desc,g_xcdk_d[l_ac].xcdk011_desc_desc, 
          g_xcdk_d[l_ac].xcdk010_desc,g_xcdk_d[l_ac].xcdk002_desc,g_xcdk2_d[l_ac].xcdkownid_desc,g_xcdk2_d[l_ac].xcdkowndp_desc, 
          g_xcdk2_d[l_ac].xcdkcrtid_desc,g_xcdk2_d[l_ac].xcdkcrtdp_desc,g_xcdk2_d[l_ac].xcdkmodid_desc  
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
         #仓库
         CALL s_desc_get_stock_desc(g_xcdk_d[l_ac].xcdksite,g_xcdk_d[l_ac].xcdk016) RETURNING g_xcdk_d[l_ac].xcdk016_desc 
         #主要素
         SELECT xcau003 INTO l_xcau003 FROM xcau_t
          WHERE xcauent = g_enterprise
            AND xcau001 = g_xcdk_d[l_ac].xcdk010
         LET g_xcdk_d[l_ac].l_xcdk202a = 0
         LET g_xcdk_d[l_ac].l_xcdk202b = 0
         LET g_xcdk_d[l_ac].l_xcdk202c = 0
         LET g_xcdk_d[l_ac].l_xcdk202d = 0
         LET g_xcdk_d[l_ac].l_xcdk202e = 0
         LET g_xcdk_d[l_ac].l_xcdk202f = 0
         LET g_xcdk_d[l_ac].l_xcdk202g = 0
         LET g_xcdk_d[l_ac].l_xcdk202h = 0   
         IF l_xcau003 = '1' THEN LET g_xcdk_d[l_ac].l_xcdk202a = g_xcdk_d[l_ac].xcdk202 END IF
         IF l_xcau003 = '2' THEN LET g_xcdk_d[l_ac].l_xcdk202b = g_xcdk_d[l_ac].xcdk202 END IF
         IF l_xcau003 = '3' THEN LET g_xcdk_d[l_ac].l_xcdk202c = g_xcdk_d[l_ac].xcdk202 END IF
         IF l_xcau003 = '4' THEN LET g_xcdk_d[l_ac].l_xcdk202d = g_xcdk_d[l_ac].xcdk202 END IF
         IF l_xcau003 = '5' THEN LET g_xcdk_d[l_ac].l_xcdk202e = g_xcdk_d[l_ac].xcdk202 END IF
         IF l_xcau003 = '6' THEN LET g_xcdk_d[l_ac].l_xcdk202f = g_xcdk_d[l_ac].xcdk202 END IF
         IF l_xcau003 = '7' THEN LET g_xcdk_d[l_ac].l_xcdk202g = g_xcdk_d[l_ac].xcdk202 END IF
         IF l_xcau003 = '8' THEN LET g_xcdk_d[l_ac].l_xcdk202h = g_xcdk_d[l_ac].xcdk202 END IF
         #end add-point
      
         #帶出公用欄位reference值
         
         
         #應用 a12 樣板自動產生(Version:4)
 
 
 
 
        
         #add-point:單身資料抓取 name="bfill.foreach"
         LET l_xcdk202a_total = l_xcdk202a_total + g_xcdk_d[l_ac].l_xcdk202a
         LET l_xcdk202b_total = l_xcdk202b_total + g_xcdk_d[l_ac].l_xcdk202b
         LET l_xcdk202c_total = l_xcdk202c_total + g_xcdk_d[l_ac].l_xcdk202c
         LET l_xcdk202d_total = l_xcdk202d_total + g_xcdk_d[l_ac].l_xcdk202d
         LET l_xcdk202e_total = l_xcdk202e_total + g_xcdk_d[l_ac].l_xcdk202e
         LET l_xcdk202f_total = l_xcdk202f_total + g_xcdk_d[l_ac].l_xcdk202f
         LET l_xcdk202g_total = l_xcdk202g_total + g_xcdk_d[l_ac].l_xcdk202g
         LET l_xcdk202h_total = l_xcdk202h_total + g_xcdk_d[l_ac].l_xcdk202h
         LET l_xcdk202_total  = l_xcdk202_total  + g_xcdk_d[l_ac].xcdk202
         #小计 按料
         LET l_xcdk202a_sum1 = l_xcdk202a_sum1 + g_xcdk_d[l_ac].l_xcdk202a
         LET l_xcdk202b_sum1 = l_xcdk202b_sum1 + g_xcdk_d[l_ac].l_xcdk202b
         LET l_xcdk202c_sum1 = l_xcdk202c_sum1 + g_xcdk_d[l_ac].l_xcdk202c
         LET l_xcdk202d_sum1 = l_xcdk202d_sum1 + g_xcdk_d[l_ac].l_xcdk202d
         LET l_xcdk202e_sum1 = l_xcdk202e_sum1 + g_xcdk_d[l_ac].l_xcdk202e
         LET l_xcdk202f_sum1 = l_xcdk202f_sum1 + g_xcdk_d[l_ac].l_xcdk202f
         LET l_xcdk202g_sum1 = l_xcdk202g_sum1 + g_xcdk_d[l_ac].l_xcdk202g
         LET l_xcdk202h_sum1 = l_xcdk202h_sum1 + g_xcdk_d[l_ac].l_xcdk202h
         LET l_xcdk202_sum1  = l_xcdk202_sum1  + g_xcdk_d[l_ac].xcdk202
         IF l_ac > 1 THEN
            IF g_xcdk_d[l_ac].xcdk011 IS  NULL THEN LET  g_xcdk_d[l_ac].xcdk011 = ' ' END IF      
            IF g_xcdk_d[l_ac].xcdk011 !=  g_xcdk_d[l_ac - 1].xcdk011 THEN
               LET g_xcdk_d[l_ac + 1].* = g_xcdk_d[l_ac].*  
               INITIALIZE  g_xcdk_d[l_ac].* TO NULL
               #LET g_xcdk_d[l_ac].xcdk011  = cl_getmsg("axc-00205",g_lang)  #151029-00010#1 151029 By pomelo mark
               LET g_xcdk_d[l_ac].xcdk011_desc = g_xcdk_d[l_ac - 1].xcdk011,cl_getmsg("axc-00205",g_lang)  #151029-00010#1 151029 By pomelo add
               LET g_xcdk_d[l_ac].l_xcdk202a = l_xcdk202a_sum1 - g_xcdk_d[l_ac + 1].l_xcdk202a
               LET g_xcdk_d[l_ac].l_xcdk202b = l_xcdk202b_sum1 - g_xcdk_d[l_ac + 1].l_xcdk202b
               LET g_xcdk_d[l_ac].l_xcdk202c = l_xcdk202c_sum1 - g_xcdk_d[l_ac + 1].l_xcdk202c
               LET g_xcdk_d[l_ac].l_xcdk202d = l_xcdk202d_sum1 - g_xcdk_d[l_ac + 1].l_xcdk202d
               LET g_xcdk_d[l_ac].l_xcdk202e = l_xcdk202e_sum1 - g_xcdk_d[l_ac + 1].l_xcdk202e
               LET g_xcdk_d[l_ac].l_xcdk202f = l_xcdk202f_sum1 - g_xcdk_d[l_ac + 1].l_xcdk202f
               LET g_xcdk_d[l_ac].l_xcdk202g = l_xcdk202g_sum1 - g_xcdk_d[l_ac + 1].l_xcdk202g
               LET g_xcdk_d[l_ac].l_xcdk202h = l_xcdk202h_sum1 - g_xcdk_d[l_ac + 1].l_xcdk202h
               LET g_xcdk_d[l_ac].xcdk202    = l_xcdk202_sum1  - g_xcdk_d[l_ac + 1].xcdk202
               LET l_ac = l_ac + 1
               LET l_xcdk202a_sum1 =  g_xcdk_d[l_ac].l_xcdk202a
               LET l_xcdk202b_sum1 =  g_xcdk_d[l_ac].l_xcdk202b
               LET l_xcdk202c_sum1 =  g_xcdk_d[l_ac].l_xcdk202c
               LET l_xcdk202d_sum1 =  g_xcdk_d[l_ac].l_xcdk202d
               LET l_xcdk202e_sum1 =  g_xcdk_d[l_ac].l_xcdk202e
               LET l_xcdk202f_sum1 =  g_xcdk_d[l_ac].l_xcdk202f
               LET l_xcdk202g_sum1 =  g_xcdk_d[l_ac].l_xcdk202g
               LET l_xcdk202h_sum1 =  g_xcdk_d[l_ac].l_xcdk202h
               LET l_xcdk202_sum1  =  g_xcdk_d[l_ac].xcdk202 
            ELSE 
               IF g_xcdk_d[l_ac].xcdk047 !=  g_xcdk_d[l_ac - 1].xcdk047 THEN
                  LET g_xcdk_d[l_ac + 1].* = g_xcdk_d[l_ac].*  
                  INITIALIZE  g_xcdk_d[l_ac].* TO NULL
                  #LET g_xcdk_d[l_ac].xcdk011  = cl_getmsg("axc-00205",g_lang)  #151029-00010#1 151029 By pomelo mark
                  LET g_xcdk_d[l_ac].xcdk011_desc = g_xcdk_d[l_ac - 1].xcdk011,cl_getmsg("axc-00205",g_lang)  #151029-00010#1 151029 By pomelo add
                  LET g_xcdk_d[l_ac].l_xcdk202a = l_xcdk202a_sum1 - g_xcdk_d[l_ac + 1].l_xcdk202a
                  LET g_xcdk_d[l_ac].l_xcdk202b = l_xcdk202b_sum1 - g_xcdk_d[l_ac + 1].l_xcdk202b
                  LET g_xcdk_d[l_ac].l_xcdk202c = l_xcdk202c_sum1 - g_xcdk_d[l_ac + 1].l_xcdk202c
                  LET g_xcdk_d[l_ac].l_xcdk202d = l_xcdk202d_sum1 - g_xcdk_d[l_ac + 1].l_xcdk202d
                  LET g_xcdk_d[l_ac].l_xcdk202e = l_xcdk202e_sum1 - g_xcdk_d[l_ac + 1].l_xcdk202e
                  LET g_xcdk_d[l_ac].l_xcdk202f = l_xcdk202f_sum1 - g_xcdk_d[l_ac + 1].l_xcdk202f
                  LET g_xcdk_d[l_ac].l_xcdk202g = l_xcdk202g_sum1 - g_xcdk_d[l_ac + 1].l_xcdk202g
                  LET g_xcdk_d[l_ac].l_xcdk202h = l_xcdk202h_sum1 - g_xcdk_d[l_ac + 1].l_xcdk202h
                  LET g_xcdk_d[l_ac].xcdk202    = l_xcdk202_sum1  - g_xcdk_d[l_ac + 1].xcdk202
                  LET l_ac = l_ac + 1
                  LET l_xcdk202a_sum1 =  g_xcdk_d[l_ac].l_xcdk202a
                  LET l_xcdk202b_sum1 =  g_xcdk_d[l_ac].l_xcdk202b
                  LET l_xcdk202c_sum1 =  g_xcdk_d[l_ac].l_xcdk202c
                  LET l_xcdk202d_sum1 =  g_xcdk_d[l_ac].l_xcdk202d
                  LET l_xcdk202e_sum1 =  g_xcdk_d[l_ac].l_xcdk202e
                  LET l_xcdk202f_sum1 =  g_xcdk_d[l_ac].l_xcdk202f
                  LET l_xcdk202g_sum1 =  g_xcdk_d[l_ac].l_xcdk202g
                  LET l_xcdk202h_sum1 =  g_xcdk_d[l_ac].l_xcdk202h
                  LET l_xcdk202_sum1  =  g_xcdk_d[l_ac].xcdk202
               END IF               
            END IF
             
          END IF
         #小计 按料
         LET l_xcdk202a_sum2 = l_xcdk202a_sum2 + g_xcdk_d[l_ac].l_xcdk202a
         LET l_xcdk202b_sum2 = l_xcdk202b_sum2 + g_xcdk_d[l_ac].l_xcdk202b
         LET l_xcdk202c_sum2 = l_xcdk202c_sum2 + g_xcdk_d[l_ac].l_xcdk202c
         LET l_xcdk202d_sum2 = l_xcdk202d_sum2 + g_xcdk_d[l_ac].l_xcdk202d
         LET l_xcdk202e_sum2 = l_xcdk202e_sum2 + g_xcdk_d[l_ac].l_xcdk202e
         LET l_xcdk202f_sum2 = l_xcdk202f_sum2 + g_xcdk_d[l_ac].l_xcdk202f
         LET l_xcdk202g_sum2 = l_xcdk202g_sum2 + g_xcdk_d[l_ac].l_xcdk202g
         LET l_xcdk202h_sum2 = l_xcdk202h_sum2 + g_xcdk_d[l_ac].l_xcdk202h
         LET l_xcdk202_sum2  = l_xcdk202_sum2  + g_xcdk_d[l_ac].xcdk202
         IF l_ac > 2 THEN
            IF g_xcdk_d[l_ac - 2].xcdk047 != cl_getmsg("axc-00204",g_lang) THEN        
               IF g_xcdk_d[l_ac].xcdk047 !=  g_xcdk_d[l_ac - 2].xcdk047 THEN
                  LET g_xcdk_d[l_ac + 1].* = g_xcdk_d[l_ac].*  
                  INITIALIZE  g_xcdk_d[l_ac].* TO NULL               
                  LET g_xcdk_d[l_ac].xcdk047  = cl_getmsg("axc-00204",g_lang)                
                  LET g_xcdk_d[l_ac].l_xcdk202a = l_xcdk202a_sum2 - g_xcdk_d[l_ac + 1].l_xcdk202a
                  LET g_xcdk_d[l_ac].l_xcdk202b = l_xcdk202b_sum2 - g_xcdk_d[l_ac + 1].l_xcdk202b
                  LET g_xcdk_d[l_ac].l_xcdk202c = l_xcdk202c_sum2 - g_xcdk_d[l_ac + 1].l_xcdk202c
                  LET g_xcdk_d[l_ac].l_xcdk202d = l_xcdk202d_sum2 - g_xcdk_d[l_ac + 1].l_xcdk202d
                  LET g_xcdk_d[l_ac].l_xcdk202e = l_xcdk202e_sum2 - g_xcdk_d[l_ac + 1].l_xcdk202e
                  LET g_xcdk_d[l_ac].l_xcdk202f = l_xcdk202f_sum2 - g_xcdk_d[l_ac + 1].l_xcdk202f
                  LET g_xcdk_d[l_ac].l_xcdk202g = l_xcdk202g_sum2 - g_xcdk_d[l_ac + 1].l_xcdk202g
                  LET g_xcdk_d[l_ac].l_xcdk202h = l_xcdk202h_sum2 - g_xcdk_d[l_ac + 1].l_xcdk202h
                  LET g_xcdk_d[l_ac].xcdk202    = l_xcdk202_sum2  - g_xcdk_d[l_ac + 1].xcdk202
                  LET l_ac = l_ac + 1
                  LET l_xcdk202a_sum2 =  g_xcdk_d[l_ac].l_xcdk202a
                  LET l_xcdk202b_sum2 =  g_xcdk_d[l_ac].l_xcdk202b
                  LET l_xcdk202c_sum2 =  g_xcdk_d[l_ac].l_xcdk202c
                  LET l_xcdk202d_sum2 =  g_xcdk_d[l_ac].l_xcdk202d
                  LET l_xcdk202e_sum2 =  g_xcdk_d[l_ac].l_xcdk202e
                  LET l_xcdk202f_sum2 =  g_xcdk_d[l_ac].l_xcdk202f
                  LET l_xcdk202g_sum2 =  g_xcdk_d[l_ac].l_xcdk202g
                  LET l_xcdk202h_sum2 =  g_xcdk_d[l_ac].l_xcdk202h
                  LET l_xcdk202_sum2  =  g_xcdk_d[l_ac].xcdk202   
               END IF
            END IF
         END IF
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
 
            CALL g_xcdk_d.deleteElement(g_xcdk_d.getLength())
      CALL g_xcdk2_d.deleteElement(g_xcdk2_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
}
#160414-00018#55   2016/05/23 By earl mark e

#160414-00018#55   2016/05/23 By earl add s
   #小計
   LET l_subtotal_msg = cl_getmsg("axc-00205",g_lang)
   LET l_subtotal_msg = l_subtotal_msg CLIPPED
   #合計
   LET l_total_msg = cl_getmsg("axc-00204",g_lang)
   LET l_total_msg = l_total_msg CLIPPED
   
   LET g_sql = "SELECT UNIQUE xcdksite,xcdk014,xcdk047,xcdk006,",
               "              xcdk007,xcdk008,xcdk025,xcdk021,",
               "              xcdk011,xcdk010,xcdk012,xcdk016,",
               "              xcdk018,xcdk002,xcdk009,'',",
               "              '','','','',",
               "              '','','','',",
               "              '','','','',",
               "              xcdk201,xcdk202,xcdkownid,xcdkowndp,",
               "              xcdkcrtid,xcdkcrtdp,xcdkcrtdt,",
               "              xcdkmodid,xcdkmoddt,",
               "              xcdk002,xcdk006,xcdk007,",
               "              xcdk008,xcdk009,xcdk010,",
               "              0,0,0,0,",
               "              0,0,0,0,",
               "              (SELECT ooefl003 FROM ooefl_t WHERE ooeflent = xcdkent AND ooefl001 = xcdksite AND ooefl002 = '",g_dlang,"') ooefl003,",
               "              (SELECT imaal003 FROM imaal_t WHERE imaalent = xcdkent AND imaal001 = xcdk011 AND imaal002 = '",g_dlang,"') imaal003,",
               "              (SELECT imaal004 FROM imaal_t WHERE imaalent = xcdkent AND imaal001 = xcdk011 AND imaal002 = '",g_dlang,"') imaal004,",
               "              (SELECT xcaul003 FROM xcaul_t WHERE xcaulent = xcdkent AND xcaul001 = xcdk010 AND xcaul002 = '",g_dlang,"') xcaul003,",
               "              (SELECT xcbfl003 FROM xcbfl_t WHERE xcbflent = xcdkent AND xcbflcomp = xcdkcomp AND xcbfl001 = xcdk002 AND xcbfl002 = '",g_dlang,"') xcbfl003,",
               "              (SELECT ooag011  FROM ooag_t  WHERE ooagent  = xcdkent AND ooag001 = xcdkownid ) ooag011,",
               "              (SELECT ooefl003 FROM ooefl_t WHERE ooeflent = xcdkent AND ooefl001 = xcdkowndp AND ooefl002 = '",g_dlang,"') ooefl003,",
               "              (SELECT ooag011  FROM ooag_t  WHERE ooagent  = xcdkent AND ooag001 = xcdkcrtid ) ooag011,",
               "              (SELECT ooefl003 FROM ooefl_t WHERE ooeflent = xcdkent AND ooefl001 = xcdkcrtdp AND ooefl002 = '",g_dlang,"') ooefl003,",
               "              (SELECT ooag011  FROM ooag_t  WHERE ooagent  = xcdkent AND ooag001 = xcdkmodid ) ooag011,",
               "              (SELECT inayl003 FROM inayl_t WHERE inaylent = xcdkent AND inayl001 = xcdk016 AND inayl002 = '",g_dlang,"') inayl003,",
               "              (SELECT xcau003  FROM xcau_t  WHERE xcauent = xcdkent  AND xcau001 = xcdk010) xcau003",
               "  FROM xcdk_t",
               " WHERE xcdkent =  ? AND xcdkld = ? AND xcdk001 = ? AND xcdk003 = ? AND xcdk004 = ? AND xcdk005 = ?",
               "   AND xcdk020 IN ('113','106') "
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xcdk_t")
   END IF
   
   IF axcq715_fill_chk(1) THEN
      IF g_action_choice <> 'fetch' OR cl_null(g_action_choice) THEN
         LET g_sql = g_sql," ORDER BY xcdk_t.xcdk047,xcdk_t.xcdk006,xcdk_t.xcdk007,xcdk_t.xcdk008,xcdk_t.xcdk011 "
         
         LET l_xcdk202a_sum1  = 0 
         LET l_xcdk202a_sum2  = 0 
         LET l_xcdk202a_total = 0 
         LET l_xcdk202b_sum1  = 0 
         LET l_xcdk202b_sum2  = 0 
         LET l_xcdk202b_total = 0 
         LET l_xcdk202c_sum1  = 0 
         LET l_xcdk202c_sum2  = 0 
         LET l_xcdk202c_total = 0 
         LET l_xcdk202d_sum1  = 0 
         LET l_xcdk202d_sum2  = 0 
         LET l_xcdk202d_total = 0 
         LET l_xcdk202e_sum1  = 0 
         LET l_xcdk202e_sum2  = 0 
         LET l_xcdk202e_total = 0 
         LET l_xcdk202f_sum1  = 0 
         LET l_xcdk202f_sum2  = 0 
         LET l_xcdk202f_total = 0 
         LET l_xcdk202g_sum1  = 0 
         LET l_xcdk202g_sum2  = 0 
         LET l_xcdk202g_total = 0 
         LET l_xcdk202h_sum1  = 0 
         LET l_xcdk202h_sum2  = 0 
         LET l_xcdk202h_total = 0 
         LET l_xcdk202_sum1   = 0
         LET l_xcdk202_sum2   = 0
         LET l_xcdk202_total  = 0
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axcq715_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR axcq715_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs USING g_enterprise,g_xcdk_m.xcdkld,g_xcdk_m.xcdk001,g_xcdk_m.xcdk003,g_xcdk_m.xcdk004,g_xcdk_m.xcdk005
                                               
      FOREACH b_fill_cs INTO g_xcdk_d[l_ac].xcdksite,g_xcdk_d[l_ac].xcdk014,g_xcdk_d[l_ac].xcdk047,g_xcdk_d[l_ac].xcdk006, 
                             g_xcdk_d[l_ac].xcdk007,g_xcdk_d[l_ac].xcdk008,g_xcdk_d[l_ac].xcdk025,g_xcdk_d[l_ac].xcdk021, 
                             g_xcdk_d[l_ac].xcdk011,g_xcdk_d[l_ac].xcdk010,g_xcdk_d[l_ac].xcdk012,g_xcdk_d[l_ac].xcdk016, 
                             g_xcdk_d[l_ac].xcdk018,g_xcdk_d[l_ac].xcdk002,g_xcdk_d[l_ac].xcdk009,g_xcdk_d[l_ac].xcdk022, 
                             g_xcdk_d[l_ac].xcdk023,g_xcdk_d[l_ac].xcdk024,g_xcdk_d[l_ac].xcdk026,g_xcdk_d[l_ac].xcdk027, 
                             g_xcdk_d[l_ac].xcdk028,g_xcdk_d[l_ac].xcdk029,g_xcdk_d[l_ac].xcdk030,g_xcdk_d[l_ac].xcdk031, 
                             g_xcdk_d[l_ac].xcdk048,g_xcdk_d[l_ac].xcdk049,g_xcdk_d[l_ac].xcdk050,g_xcdk_d[l_ac].xcdk051, 
                             g_xcdk_d[l_ac].xcdk201,g_xcdk_d[l_ac].xcdk202,g_xcdk2_d[l_ac].xcdkownid,g_xcdk2_d[l_ac].xcdkowndp, 
                             g_xcdk2_d[l_ac].xcdkcrtid,g_xcdk2_d[l_ac].xcdkcrtdp,g_xcdk2_d[l_ac].xcdkcrtdt,
                             g_xcdk2_d[l_ac].xcdkmodid,g_xcdk2_d[l_ac].xcdkmoddt,
                             g_xcdk2_d[l_ac].xcdk002,g_xcdk2_d[l_ac].xcdk006,g_xcdk2_d[l_ac].xcdk007, 
                             g_xcdk2_d[l_ac].xcdk008,g_xcdk2_d[l_ac].xcdk009,g_xcdk2_d[l_ac].xcdk010,
                             g_xcdk_d[l_ac].l_xcdk202a,g_xcdk_d[l_ac].l_xcdk202b,g_xcdk_d[l_ac].l_xcdk202c,g_xcdk_d[l_ac].l_xcdk202d,
                             g_xcdk_d[l_ac].l_xcdk202e,g_xcdk_d[l_ac].l_xcdk202f,g_xcdk_d[l_ac].l_xcdk202g,g_xcdk_d[l_ac].l_xcdk202h,
                             g_xcdk_d[l_ac].xcdksite_desc, 
                             g_xcdk_d[l_ac].xcdk011_desc,
                             g_xcdk_d[l_ac].xcdk011_desc_desc,
                             g_xcdk_d[l_ac].xcdk010_desc,
                             g_xcdk_d[l_ac].xcdk002_desc, 
                             g_xcdk2_d[l_ac].xcdkownid_desc,
                             g_xcdk2_d[l_ac].xcdkowndp_desc,
                             g_xcdk2_d[l_ac].xcdkcrtid_desc, 
                             g_xcdk2_d[l_ac].xcdkcrtdp_desc,
                             g_xcdk2_d[l_ac].xcdkmodid_desc,
                             g_xcdk_d[l_ac].xcdk016_desc,
                             l_xcau003
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF

         IF l_xcau003 = '1' THEN LET g_xcdk_d[l_ac].l_xcdk202a = g_xcdk_d[l_ac].xcdk202 END IF
         IF l_xcau003 = '2' THEN LET g_xcdk_d[l_ac].l_xcdk202b = g_xcdk_d[l_ac].xcdk202 END IF
         IF l_xcau003 = '3' THEN LET g_xcdk_d[l_ac].l_xcdk202c = g_xcdk_d[l_ac].xcdk202 END IF
         IF l_xcau003 = '4' THEN LET g_xcdk_d[l_ac].l_xcdk202d = g_xcdk_d[l_ac].xcdk202 END IF
         IF l_xcau003 = '5' THEN LET g_xcdk_d[l_ac].l_xcdk202e = g_xcdk_d[l_ac].xcdk202 END IF
         IF l_xcau003 = '6' THEN LET g_xcdk_d[l_ac].l_xcdk202f = g_xcdk_d[l_ac].xcdk202 END IF
         IF l_xcau003 = '7' THEN LET g_xcdk_d[l_ac].l_xcdk202g = g_xcdk_d[l_ac].xcdk202 END IF
         IF l_xcau003 = '8' THEN LET g_xcdk_d[l_ac].l_xcdk202h = g_xcdk_d[l_ac].xcdk202 END IF

         LET l_xcdk202a_total = l_xcdk202a_total + g_xcdk_d[l_ac].l_xcdk202a
         LET l_xcdk202b_total = l_xcdk202b_total + g_xcdk_d[l_ac].l_xcdk202b
         LET l_xcdk202c_total = l_xcdk202c_total + g_xcdk_d[l_ac].l_xcdk202c
         LET l_xcdk202d_total = l_xcdk202d_total + g_xcdk_d[l_ac].l_xcdk202d
         LET l_xcdk202e_total = l_xcdk202e_total + g_xcdk_d[l_ac].l_xcdk202e
         LET l_xcdk202f_total = l_xcdk202f_total + g_xcdk_d[l_ac].l_xcdk202f
         LET l_xcdk202g_total = l_xcdk202g_total + g_xcdk_d[l_ac].l_xcdk202g
         LET l_xcdk202h_total = l_xcdk202h_total + g_xcdk_d[l_ac].l_xcdk202h
         LET l_xcdk202_total  = l_xcdk202_total  + g_xcdk_d[l_ac].xcdk202
         #小计 按料
         LET l_xcdk202a_sum1 = l_xcdk202a_sum1 + g_xcdk_d[l_ac].l_xcdk202a
         LET l_xcdk202b_sum1 = l_xcdk202b_sum1 + g_xcdk_d[l_ac].l_xcdk202b
         LET l_xcdk202c_sum1 = l_xcdk202c_sum1 + g_xcdk_d[l_ac].l_xcdk202c
         LET l_xcdk202d_sum1 = l_xcdk202d_sum1 + g_xcdk_d[l_ac].l_xcdk202d
         LET l_xcdk202e_sum1 = l_xcdk202e_sum1 + g_xcdk_d[l_ac].l_xcdk202e
         LET l_xcdk202f_sum1 = l_xcdk202f_sum1 + g_xcdk_d[l_ac].l_xcdk202f
         LET l_xcdk202g_sum1 = l_xcdk202g_sum1 + g_xcdk_d[l_ac].l_xcdk202g
         LET l_xcdk202h_sum1 = l_xcdk202h_sum1 + g_xcdk_d[l_ac].l_xcdk202h
         LET l_xcdk202_sum1  = l_xcdk202_sum1  + g_xcdk_d[l_ac].xcdk202
         
         IF l_ac > 1 THEN
            IF g_xcdk_d[l_ac].xcdk011 IS  NULL THEN LET  g_xcdk_d[l_ac].xcdk011 = ' ' END IF      
            IF g_xcdk_d[l_ac].xcdk011 !=  g_xcdk_d[l_ac - 1].xcdk011 THEN
               LET g_xcdk_d[l_ac + 1].* = g_xcdk_d[l_ac].*  
               INITIALIZE  g_xcdk_d[l_ac].* TO NULL
               #LET g_xcdk_d[l_ac].xcdk011  = l_subtotal_msg  #151029-00010#1 151029 By pomelo mark
               LET g_xcdk_d[l_ac].xcdk011_desc = g_xcdk_d[l_ac - 1].xcdk011,l_subtotal_msg  #151029-00010#1 151029 By pomelo add
               LET g_xcdk_d[l_ac].l_xcdk202a = l_xcdk202a_sum1 - g_xcdk_d[l_ac + 1].l_xcdk202a
               LET g_xcdk_d[l_ac].l_xcdk202b = l_xcdk202b_sum1 - g_xcdk_d[l_ac + 1].l_xcdk202b
               LET g_xcdk_d[l_ac].l_xcdk202c = l_xcdk202c_sum1 - g_xcdk_d[l_ac + 1].l_xcdk202c
               LET g_xcdk_d[l_ac].l_xcdk202d = l_xcdk202d_sum1 - g_xcdk_d[l_ac + 1].l_xcdk202d
               LET g_xcdk_d[l_ac].l_xcdk202e = l_xcdk202e_sum1 - g_xcdk_d[l_ac + 1].l_xcdk202e
               LET g_xcdk_d[l_ac].l_xcdk202f = l_xcdk202f_sum1 - g_xcdk_d[l_ac + 1].l_xcdk202f
               LET g_xcdk_d[l_ac].l_xcdk202g = l_xcdk202g_sum1 - g_xcdk_d[l_ac + 1].l_xcdk202g
               LET g_xcdk_d[l_ac].l_xcdk202h = l_xcdk202h_sum1 - g_xcdk_d[l_ac + 1].l_xcdk202h
               LET g_xcdk_d[l_ac].xcdk202    = l_xcdk202_sum1  - g_xcdk_d[l_ac + 1].xcdk202
               LET l_ac = l_ac + 1
               LET l_xcdk202a_sum1 =  g_xcdk_d[l_ac].l_xcdk202a
               LET l_xcdk202b_sum1 =  g_xcdk_d[l_ac].l_xcdk202b
               LET l_xcdk202c_sum1 =  g_xcdk_d[l_ac].l_xcdk202c
               LET l_xcdk202d_sum1 =  g_xcdk_d[l_ac].l_xcdk202d
               LET l_xcdk202e_sum1 =  g_xcdk_d[l_ac].l_xcdk202e
               LET l_xcdk202f_sum1 =  g_xcdk_d[l_ac].l_xcdk202f
               LET l_xcdk202g_sum1 =  g_xcdk_d[l_ac].l_xcdk202g
               LET l_xcdk202h_sum1 =  g_xcdk_d[l_ac].l_xcdk202h
               LET l_xcdk202_sum1  =  g_xcdk_d[l_ac].xcdk202 
            ELSE 
               IF g_xcdk_d[l_ac].xcdk047 !=  g_xcdk_d[l_ac - 1].xcdk047 THEN
                  LET g_xcdk_d[l_ac + 1].* = g_xcdk_d[l_ac].*  
                  INITIALIZE  g_xcdk_d[l_ac].* TO NULL
                  #LET g_xcdk_d[l_ac].xcdk011  = l_subtotal_msg  #151029-00010#1 151029 By pomelo mark
                  LET g_xcdk_d[l_ac].xcdk011_desc = g_xcdk_d[l_ac - 1].xcdk011,l_subtotal_msg  #151029-00010#1 151029 By pomelo add
                  LET g_xcdk_d[l_ac].l_xcdk202a = l_xcdk202a_sum1 - g_xcdk_d[l_ac + 1].l_xcdk202a
                  LET g_xcdk_d[l_ac].l_xcdk202b = l_xcdk202b_sum1 - g_xcdk_d[l_ac + 1].l_xcdk202b
                  LET g_xcdk_d[l_ac].l_xcdk202c = l_xcdk202c_sum1 - g_xcdk_d[l_ac + 1].l_xcdk202c
                  LET g_xcdk_d[l_ac].l_xcdk202d = l_xcdk202d_sum1 - g_xcdk_d[l_ac + 1].l_xcdk202d
                  LET g_xcdk_d[l_ac].l_xcdk202e = l_xcdk202e_sum1 - g_xcdk_d[l_ac + 1].l_xcdk202e
                  LET g_xcdk_d[l_ac].l_xcdk202f = l_xcdk202f_sum1 - g_xcdk_d[l_ac + 1].l_xcdk202f
                  LET g_xcdk_d[l_ac].l_xcdk202g = l_xcdk202g_sum1 - g_xcdk_d[l_ac + 1].l_xcdk202g
                  LET g_xcdk_d[l_ac].l_xcdk202h = l_xcdk202h_sum1 - g_xcdk_d[l_ac + 1].l_xcdk202h
                  LET g_xcdk_d[l_ac].xcdk202    = l_xcdk202_sum1  - g_xcdk_d[l_ac + 1].xcdk202
                  LET l_ac = l_ac + 1
                  LET l_xcdk202a_sum1 =  g_xcdk_d[l_ac].l_xcdk202a
                  LET l_xcdk202b_sum1 =  g_xcdk_d[l_ac].l_xcdk202b
                  LET l_xcdk202c_sum1 =  g_xcdk_d[l_ac].l_xcdk202c
                  LET l_xcdk202d_sum1 =  g_xcdk_d[l_ac].l_xcdk202d
                  LET l_xcdk202e_sum1 =  g_xcdk_d[l_ac].l_xcdk202e
                  LET l_xcdk202f_sum1 =  g_xcdk_d[l_ac].l_xcdk202f
                  LET l_xcdk202g_sum1 =  g_xcdk_d[l_ac].l_xcdk202g
                  LET l_xcdk202h_sum1 =  g_xcdk_d[l_ac].l_xcdk202h
                  LET l_xcdk202_sum1  =  g_xcdk_d[l_ac].xcdk202
               END IF               
            END IF
             
          END IF
         #小计 按料
         LET l_xcdk202a_sum2 = l_xcdk202a_sum2 + g_xcdk_d[l_ac].l_xcdk202a
         LET l_xcdk202b_sum2 = l_xcdk202b_sum2 + g_xcdk_d[l_ac].l_xcdk202b
         LET l_xcdk202c_sum2 = l_xcdk202c_sum2 + g_xcdk_d[l_ac].l_xcdk202c
         LET l_xcdk202d_sum2 = l_xcdk202d_sum2 + g_xcdk_d[l_ac].l_xcdk202d
         LET l_xcdk202e_sum2 = l_xcdk202e_sum2 + g_xcdk_d[l_ac].l_xcdk202e
         LET l_xcdk202f_sum2 = l_xcdk202f_sum2 + g_xcdk_d[l_ac].l_xcdk202f
         LET l_xcdk202g_sum2 = l_xcdk202g_sum2 + g_xcdk_d[l_ac].l_xcdk202g
         LET l_xcdk202h_sum2 = l_xcdk202h_sum2 + g_xcdk_d[l_ac].l_xcdk202h
         LET l_xcdk202_sum2  = l_xcdk202_sum2  + g_xcdk_d[l_ac].xcdk202
         IF l_ac > 2 THEN
            IF g_xcdk_d[l_ac - 2].xcdk047 != l_total_msg THEN        
               IF g_xcdk_d[l_ac].xcdk047 !=  g_xcdk_d[l_ac - 2].xcdk047 THEN
                  LET g_xcdk_d[l_ac + 1].* = g_xcdk_d[l_ac].*  
                  INITIALIZE  g_xcdk_d[l_ac].* TO NULL               
                  LET g_xcdk_d[l_ac].xcdk047  = l_total_msg                
                  LET g_xcdk_d[l_ac].l_xcdk202a = l_xcdk202a_sum2 - g_xcdk_d[l_ac + 1].l_xcdk202a
                  LET g_xcdk_d[l_ac].l_xcdk202b = l_xcdk202b_sum2 - g_xcdk_d[l_ac + 1].l_xcdk202b
                  LET g_xcdk_d[l_ac].l_xcdk202c = l_xcdk202c_sum2 - g_xcdk_d[l_ac + 1].l_xcdk202c
                  LET g_xcdk_d[l_ac].l_xcdk202d = l_xcdk202d_sum2 - g_xcdk_d[l_ac + 1].l_xcdk202d
                  LET g_xcdk_d[l_ac].l_xcdk202e = l_xcdk202e_sum2 - g_xcdk_d[l_ac + 1].l_xcdk202e
                  LET g_xcdk_d[l_ac].l_xcdk202f = l_xcdk202f_sum2 - g_xcdk_d[l_ac + 1].l_xcdk202f
                  LET g_xcdk_d[l_ac].l_xcdk202g = l_xcdk202g_sum2 - g_xcdk_d[l_ac + 1].l_xcdk202g
                  LET g_xcdk_d[l_ac].l_xcdk202h = l_xcdk202h_sum2 - g_xcdk_d[l_ac + 1].l_xcdk202h
                  LET g_xcdk_d[l_ac].xcdk202    = l_xcdk202_sum2  - g_xcdk_d[l_ac + 1].xcdk202
                  LET l_ac = l_ac + 1
                  LET l_xcdk202a_sum2 =  g_xcdk_d[l_ac].l_xcdk202a
                  LET l_xcdk202b_sum2 =  g_xcdk_d[l_ac].l_xcdk202b
                  LET l_xcdk202c_sum2 =  g_xcdk_d[l_ac].l_xcdk202c
                  LET l_xcdk202d_sum2 =  g_xcdk_d[l_ac].l_xcdk202d
                  LET l_xcdk202e_sum2 =  g_xcdk_d[l_ac].l_xcdk202e
                  LET l_xcdk202f_sum2 =  g_xcdk_d[l_ac].l_xcdk202f
                  LET l_xcdk202g_sum2 =  g_xcdk_d[l_ac].l_xcdk202g
                  LET l_xcdk202h_sum2 =  g_xcdk_d[l_ac].l_xcdk202h
                  LET l_xcdk202_sum2  =  g_xcdk_d[l_ac].xcdk202   
               END IF
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
 
      CALL g_xcdk_d.deleteElement(g_xcdk_d.getLength())
      CALL g_xcdk2_d.deleteElement(g_xcdk2_d.getLength())
      
   END IF
   
#160414-00018#55   2016/05/23 By earl add e



   IF l_ac > 1 THEN
      #LET g_xcdk_d[l_ac].xcdk011  = l_subtotal_msg  #151029-00010#1 151029 By pomelo mark
      LET g_xcdk_d[l_ac].xcdk011_desc = g_xcdk_d[l_ac - 1].xcdk011,l_subtotal_msg  #151029-00010#1 151029 By pomelo add
      LET g_xcdk_d[l_ac].l_xcdk202a = l_xcdk202a_sum1
      LET g_xcdk_d[l_ac].l_xcdk202b = l_xcdk202b_sum1
      LET g_xcdk_d[l_ac].l_xcdk202c = l_xcdk202c_sum1
      LET g_xcdk_d[l_ac].l_xcdk202d = l_xcdk202d_sum1
      LET g_xcdk_d[l_ac].l_xcdk202e = l_xcdk202e_sum1
      LET g_xcdk_d[l_ac].l_xcdk202f = l_xcdk202f_sum1
      LET g_xcdk_d[l_ac].l_xcdk202g = l_xcdk202g_sum1
      LET g_xcdk_d[l_ac].l_xcdk202h = l_xcdk202h_sum1
      LET g_xcdk_d[l_ac].xcdk202    = l_xcdk202_sum1  
      LET l_ac = l_ac + 1        
      LET g_xcdk_d[l_ac].xcdk047  = l_total_msg          
      LET g_xcdk_d[l_ac].l_xcdk202a = l_xcdk202a_sum2 
      LET g_xcdk_d[l_ac].l_xcdk202b = l_xcdk202b_sum2 
      LET g_xcdk_d[l_ac].l_xcdk202c = l_xcdk202c_sum2 
      LET g_xcdk_d[l_ac].l_xcdk202d = l_xcdk202d_sum2 
      LET g_xcdk_d[l_ac].l_xcdk202e = l_xcdk202e_sum2 
      LET g_xcdk_d[l_ac].l_xcdk202f = l_xcdk202f_sum2 
      LET g_xcdk_d[l_ac].l_xcdk202g = l_xcdk202g_sum2 
      LET g_xcdk_d[l_ac].l_xcdk202h = l_xcdk202h_sum2 
      LET g_xcdk_d[l_ac].xcdk202    = l_xcdk202_sum2  
      LET l_ac = l_ac + 1
      LET g_xcdk_d[l_ac].xcdksite  = cl_getmsg("lib-00133",g_lang) 
      LET g_xcdk_d[l_ac].l_xcdk202a = l_xcdk202a_total 
      LET g_xcdk_d[l_ac].l_xcdk202b = l_xcdk202b_total 
      LET g_xcdk_d[l_ac].l_xcdk202c = l_xcdk202c_total 
      LET g_xcdk_d[l_ac].l_xcdk202d = l_xcdk202d_total 
      LET g_xcdk_d[l_ac].l_xcdk202e = l_xcdk202e_total 
      LET g_xcdk_d[l_ac].l_xcdk202f = l_xcdk202f_total 
      LET g_xcdk_d[l_ac].l_xcdk202g = l_xcdk202g_total 
      LET g_xcdk_d[l_ac].l_xcdk202h = l_xcdk202h_total 
      LET g_xcdk_d[l_ac].xcdk202    = l_xcdk202_total  
      LET l_ac = l_ac + 1       
   END IF
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_xcdk_d.getLength()
      LET g_xcdk_d_mask_o[l_ac].* =  g_xcdk_d[l_ac].*
      CALL axcq715_xcdk_t_mask()
      LET g_xcdk_d_mask_n[l_ac].* =  g_xcdk_d[l_ac].*
   END FOR
   
   LET g_xcdk2_d_mask_o.* =  g_xcdk2_d.*
   FOR l_ac = 1 TO g_xcdk2_d.getLength()
      LET g_xcdk2_d_mask_o[l_ac].* =  g_xcdk2_d[l_ac].*
      CALL axcq715_xcdk_t_mask()
      LET g_xcdk2_d_mask_n[l_ac].* =  g_xcdk2_d[l_ac].*
   END FOR
 
 
   FREE axcq715_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="axcq715.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION axcq715_idx_chk()
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
      IF g_detail_idx > g_xcdk_d.getLength() THEN
         LET g_detail_idx = g_xcdk_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_xcdk_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xcdk_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_xcdk2_d.getLength() THEN
         LET g_detail_idx = g_xcdk2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_xcdk2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xcdk2_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axcq715.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axcq715_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_xcdk_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="axcq715.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION axcq715_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   
   #end add-point
   
   DELETE FROM xcdk_t
    WHERE xcdkent = g_enterprise AND xcdkld = g_xcdk_m.xcdkld AND
                              xcdk001 = g_xcdk_m.xcdk001 AND
                              xcdk003 = g_xcdk_m.xcdk003 AND
                              xcdk004 = g_xcdk_m.xcdk004 AND
                              xcdk005 = g_xcdk_m.xcdk005 AND
 
          xcdk002 = g_xcdk_d_t.xcdk002
      AND xcdk006 = g_xcdk_d_t.xcdk006
      AND xcdk007 = g_xcdk_d_t.xcdk007
      AND xcdk008 = g_xcdk_d_t.xcdk008
      AND xcdk009 = g_xcdk_d_t.xcdk009
      AND xcdk010 = g_xcdk_d_t.xcdk010
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcdk_t:",SQLERRMESSAGE 
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
 
{<section id="axcq715.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION axcq715_delete_b(ps_table,ps_keys_bak,ps_page)
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
 
{<section id="axcq715.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION axcq715_insert_b(ps_table,ps_keys,ps_page)
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
 
{<section id="axcq715.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION axcq715_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
 
{<section id="axcq715.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION axcq715_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_xcdk_d[l_ac].xcdk002 = g_xcdk_d_t.xcdk002 
      AND g_xcdk_d[l_ac].xcdk006 = g_xcdk_d_t.xcdk006 
      AND g_xcdk_d[l_ac].xcdk007 = g_xcdk_d_t.xcdk007 
      AND g_xcdk_d[l_ac].xcdk008 = g_xcdk_d_t.xcdk008 
      AND g_xcdk_d[l_ac].xcdk009 = g_xcdk_d_t.xcdk009 
      AND g_xcdk_d[l_ac].xcdk010 = g_xcdk_d_t.xcdk010 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="axcq715.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION axcq715_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="axcq715.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION axcq715_lock_b(ps_table,ps_page)
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
   #CALL axcq715_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axcq715.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION axcq715_unlock_b(ps_table,ps_page)
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
 
{<section id="axcq715.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION axcq715_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("xcdkld,xcdk001,xcdk003,xcdk004,xcdk005",TRUE)
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
 
{<section id="axcq715.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION axcq715_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("xcdkld,xcdk001,xcdk003,xcdk004,xcdk005",FALSE)
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
 
{<section id="axcq715.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION axcq715_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axcq715.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION axcq715_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="axcq715.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION axcq715_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq715.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION axcq715_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq715.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION axcq715_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq715.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION axcq715_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq715.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION axcq715_default_search()
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
      LET ls_wc = ls_wc, " xcdkld = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " xcdk001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " xcdk003 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " xcdk004 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET ls_wc = ls_wc, " xcdk005 = '", g_argv[05], "' AND "
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
 
{<section id="axcq715.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION axcq715_fill_chk(ps_idx)
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
 
{<section id="axcq715.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION axcq715_modify_detail_chk(ps_record)
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
         LET ls_return = "xcdksite"
      WHEN "s_detail2"
         LET ls_return = "xcdkownid"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="axcq715.mask_functions" >}
&include "erp/axc/axcq715_mask.4gl"
 
{</section>}
 
{<section id="axcq715.state_change" >}
    
 
{</section>}
 
{<section id="axcq715.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION axcq715_set_pk_array()
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
   LET g_pk_array[1].values = g_xcdk_m.xcdkld
   LET g_pk_array[1].column = 'xcdkld'
   LET g_pk_array[2].values = g_xcdk_m.xcdk001
   LET g_pk_array[2].column = 'xcdk001'
   LET g_pk_array[3].values = g_xcdk_m.xcdk003
   LET g_pk_array[3].column = 'xcdk003'
   LET g_pk_array[4].values = g_xcdk_m.xcdk004
   LET g_pk_array[4].column = 'xcdk004'
   LET g_pk_array[5].values = g_xcdk_m.xcdk005
   LET g_pk_array[5].column = 'xcdk005'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axcq715.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION axcq715_msgcentre_notify(lc_state)
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
   CALL axcq715_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_xcdk_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axcq715.other_function" readonly="Y" >}

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
PRIVATE FUNCTION axcq715_default()
   DEFINE  l_glaa001        LIKE glaa_t.glaa001

   #预设当前site的法人，主账套，年度期别，成本计算类型
   CALL s_axc_set_site_default() RETURNING g_xcdk_m.xcdkcomp,g_xcdk_m.xcdkld,g_xcdk_m.xcdk004,g_xcdk_m.xcdk005,g_xcdk_m.xcdk003
   DISPLAY BY NAME g_xcdk_m.xcdkcomp,g_xcdk_m.xcdkld,g_xcdk_m.xcdk004,g_xcdk_m.xcdk005,g_xcdk_m.xcdk003
   #fengmy 150113----begin
   #根據參數顯示隱藏成本域 和 料件特性
   IF cl_null(g_xcdk_m.xcdkcomp) THEN
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data1   #采用特性否       
   ELSE
      CALL cl_get_para(g_enterprise,g_xcdk_m.xcdkcomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
      CALL cl_get_para(g_enterprise,g_xcdk_m.xcdkcomp,'S-FIN-6013') RETURNING g_para_data1   #采用特性否       
   END IF   
   IF g_para_data = 'Y' THEN
      CALL cl_set_comp_visible('xcdk002,xcdk002_desc',TRUE)                    
   ELSE                        
      CALL cl_set_comp_visible('xcdk002,xcdk002_desc',FALSE)                
   END IF   
   IF g_para_data1 = 'Y' THEN
      CALL cl_set_comp_visible('xcdk012',TRUE)                    
   ELSE                       
      CALL cl_set_comp_visible('xcdk012',FALSE)                
   END IF   
   #fengmy 150113----end  
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xcdk_m.xcdkcomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcdk_m.xcdkcomp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcdk_m.xcdkcomp_desc 
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xcdk_m.xcdkld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcdk_m.xcdkld_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcdk_m.xcdkld_desc 

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xcdk_m.xcdk003
   CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcdk_m.xcdk003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcdk_m.xcdk003_desc
      
   LET g_xcdk_m.xcdk001 = '1'
   DISPLAY BY NAME g_xcdk_m.xcdk001
   
   SELECT glaa001 INTO l_glaa001
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_xcdk_m.xcdkld

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = l_glaa001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcdk_m.xcdk001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcdk_m.xcdk001_desc    
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
PRIVATE FUNCTION axcq715_ref()
DEFINE  l_glaa001        LIKE glaa_t.glaa001
  
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xcdk_m.xcdkcomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcdk_m.xcdkcomp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcdk_m.xcdkcomp_desc 
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xcdk_m.xcdkld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcdk_m.xcdkld_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcdk_m.xcdkld_desc 

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xcdk_m.xcdk003
   CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcdk_m.xcdk003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcdk_m.xcdk003_desc
      
  LET l_glaa001 = ' '
   CASE g_xcdk_m.xcdk001
      WHEN '1'
         SELECT glaa001 INTO l_glaa001
          FROM glaa_t
         WHERE glaaent = g_enterprise
           AND glaald  = g_xcdk_m.xcdkld
      WHEN '2'
         SELECT glaa016 INTO l_glaa001
          FROM glaa_t
         WHERE glaaent = g_enterprise
           AND glaald  = g_xcdk_m.xcdkld
      WHEN '3'
         SELECT glaa020 INTO l_glaa001
          FROM glaa_t
         WHERE glaaent = g_enterprise
           AND glaald  = g_xcdk_m.xcdkld
   END CASE
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = l_glaa001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcdk_m.xcdk001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcdk_m.xcdk001_desc
END FUNCTION

 
{</section>}
 
