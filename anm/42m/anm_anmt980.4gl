#該程式未解開Section, 採用最新樣板產出!
{<section id="anmt980.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2015-11-03 14:35:33), PR版次:0006(2016-10-28 10:39:27)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000041
#+ Filename...: anmt980
#+ Description: 預計資金維護
#+ Creator....: 02114(2015-10-15 14:59:45)
#+ Modifier...: 02114 -SD/PR- 08171
 
{</section>}
 
{<section id="anmt980.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#160122-00001#29 2016/02/17 By 02599    增加交易账户用户权限控管
#160318-00025#26 2016/04/28 BY 07900    校验代码重复错误讯息的修改
#160816-00012#3  2016/09/12 By 01531    ANM增加资金中心，帐套，法人三个栏位权限
#160912-00024#1  2016/09/20 By 01531    来源组织权限控管
#161006-00005#37 2016/10/28 By 08171    单头的营运据点限定为资金组织(开窗改用q_ooef001_1)，单身的来源组织只需为营运据点
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
PRIVATE type type_g_nmeg_m        RECORD
       nmegsite LIKE nmeg_t.nmegsite, 
   nmegsite_desc LIKE type_t.chr80, 
   nmeg001 LIKE nmeg_t.nmeg001, 
   nmeg003 LIKE nmeg_t.nmeg003, 
   nmeg004 LIKE nmeg_t.nmeg004, 
   nmeg005 LIKE nmeg_t.nmeg005, 
   nmeg005_desc LIKE type_t.chr80, 
   nmeg006 LIKE nmeg_t.nmeg006
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_nmeg_d        RECORD
       nmegseq LIKE nmeg_t.nmegseq, 
   nmegdocdt LIKE nmeg_t.nmegdocdt, 
   nmeg002 LIKE nmeg_t.nmeg002, 
   nmeg002_desc LIKE type_t.chr500, 
   nmbd003 LIKE type_t.chr500, 
   nmbd004 LIKE type_t.chr500, 
   nmeg007 LIKE nmeg_t.nmeg007, 
   nmeg007_desc LIKE type_t.chr500, 
   nmeg008 LIKE nmeg_t.nmeg008, 
   nmeg008_desc LIKE type_t.chr500, 
   nmeg009 LIKE nmeg_t.nmeg009, 
   nmeg010 LIKE nmeg_t.nmeg010, 
   nmeg011 LIKE nmeg_t.nmeg011, 
   nmeg012 LIKE nmeg_t.nmeg012, 
   nmeg013 LIKE nmeg_t.nmeg013, 
   nmeg014 LIKE nmeg_t.nmeg014, 
   nmeg016 LIKE nmeg_t.nmeg016, 
   nmeg016_desc LIKE type_t.chr500, 
   nmeg015 LIKE nmeg_t.nmeg015, 
   nmeg015_desc LIKE type_t.chr500, 
   nmeg017 LIKE nmeg_t.nmeg017, 
   nmegstus LIKE nmeg_t.nmegstus
       END RECORD
PRIVATE TYPE type_g_nmeg2_d RECORD
       nmegseq LIKE nmeg_t.nmegseq, 
   nmegownid LIKE nmeg_t.nmegownid, 
   nmegownid_desc LIKE type_t.chr500, 
   nmegowndp LIKE nmeg_t.nmegowndp, 
   nmegowndp_desc LIKE type_t.chr500, 
   nmegcrtid LIKE nmeg_t.nmegcrtid, 
   nmegcrtid_desc LIKE type_t.chr500, 
   nmegcrtdp LIKE nmeg_t.nmegcrtdp, 
   nmegcrtdp_desc LIKE type_t.chr500, 
   nmegcrtdt DATETIME YEAR TO SECOND, 
   nmegmodid LIKE nmeg_t.nmegmodid, 
   nmegmodid_desc LIKE type_t.chr500, 
   nmegmoddt DATETIME YEAR TO SECOND
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_nmeg_m          type_g_nmeg_m
DEFINE g_nmeg_m_t        type_g_nmeg_m
DEFINE g_nmeg_m_o        type_g_nmeg_m
DEFINE g_nmeg_m_mask_o   type_g_nmeg_m #轉換遮罩前資料
DEFINE g_nmeg_m_mask_n   type_g_nmeg_m #轉換遮罩後資料
 
   DEFINE g_nmeg001_t LIKE nmeg_t.nmeg001
 
 
DEFINE g_nmeg_d          DYNAMIC ARRAY OF type_g_nmeg_d
DEFINE g_nmeg_d_t        type_g_nmeg_d
DEFINE g_nmeg_d_o        type_g_nmeg_d
DEFINE g_nmeg_d_mask_o   DYNAMIC ARRAY OF type_g_nmeg_d #轉換遮罩前資料
DEFINE g_nmeg_d_mask_n   DYNAMIC ARRAY OF type_g_nmeg_d #轉換遮罩後資料
DEFINE g_nmeg2_d   DYNAMIC ARRAY OF type_g_nmeg2_d
DEFINE g_nmeg2_d_t type_g_nmeg2_d
DEFINE g_nmeg2_d_o type_g_nmeg2_d
DEFINE g_nmeg2_d_mask_o   DYNAMIC ARRAY OF type_g_nmeg2_d #轉換遮罩前資料
DEFINE g_nmeg2_d_mask_n   DYNAMIC ARRAY OF type_g_nmeg2_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_nmeg001 LIKE nmeg_t.nmeg001
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
DEFINE g_ooef017             LIKE ooef_t.ooef017
DEFINE g_site_wc             STRING
DEFINE g_nmeg007_comp        LIKE ooef_t.ooef017
DEFINE g_glaald              LIKE glaa_t.glaald
DEFINE g_glaa001             LIKE glaa_t.glaa001
DEFINE g_glaa025             LIKE glaa_t.glaa025
DEFINE g_sql_bank            STRING #160122-00001#29 add
#end add-point
 
{</section>}
 
{<section id="anmt980.main" >}
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
   CALL cl_ap_init("anm","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT nmegsite,'',nmeg001,nmeg003,nmeg004,nmeg005,'',nmeg006", 
                      " FROM nmeg_t",
                      " WHERE nmegent= ? AND nmeg001=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
 
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE anmt980_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.nmegsite,t0.nmeg001,t0.nmeg003,t0.nmeg004,t0.nmeg005,t0.nmeg006, 
       t1.ooefl003 ,t2.ooail003",
               " FROM nmeg_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.nmegsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t2 ON t2.ooailent="||g_enterprise||" AND t2.ooail001=t0.nmeg005 AND t2.ooail002='"||g_dlang||"' ",
 
               " WHERE t0.nmegent = " ||g_enterprise|| " AND t0.nmeg001 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   #160122-00001#29--add--str--
   LET g_sql_bank=NULL
   CALL s_anmi120_get_bank_account_sql(g_user,g_dept) RETURNING g_sub_success,g_sql_bank
#   LET g_sql=g_sql," AND nmeg016 IN (SELECT nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise," AND nmll002 = '",g_user,"')"
   LET g_sql=g_sql," AND nmeg016 IN (",g_sql_bank,")"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #160122-00001#29--add--end
   #end add-point
   PREPARE anmt980_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_anmt980 WITH FORM cl_ap_formpath("anm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL anmt980_init()   
 
      #進入選單 Menu (="N")
      CALL anmt980_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_anmt980
      
   END IF 
   
   CLOSE anmt980_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="anmt980.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION anmt980_init()
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
   CALL cl_set_combo_scc('nmbd003','8026')
   CALL cl_set_combo_scc('nmbd004','8709')
   CALL cl_set_combo_scc('nmeg017','8738')
   CALL s_fin_create_account_center_tmp()
   #end add-point
   
   CALL anmt980_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="anmt980.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION anmt980_ui_dialog()
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
         INITIALIZE g_nmeg_m.* TO NULL
         CALL g_nmeg_d.clear()
         CALL g_nmeg2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL anmt980_init()
      END IF
 
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
        
         DISPLAY ARRAY g_nmeg_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL anmt980_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL anmt980_ui_detailshow()
               
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
        
         DISPLAY ARRAY g_nmeg2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL anmt980_idx_chk()
               CALL anmt980_ui_detailshow()
               
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
            CALL anmt980_browser_fill("")
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
               CALL anmt980_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL anmt980_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL anmt980_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL anmt980_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL anmt980_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL anmt980_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL anmt980_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL anmt980_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL anmt980_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL anmt980_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL anmt980_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL anmt980_idx_chk()
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
                  LET g_export_node[1] = base.typeInfo.create(g_nmeg_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_nmeg2_d)
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
               NEXT FIELD nmegseq
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
               CALL anmt980_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL anmt980_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL anmt980_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL anmt980_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL anmt980_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL anmt980_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL anmt980_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/anm/anmt980_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/anm/anmt980_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL anmt980_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL anmt980_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL anmt980_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL anmt980_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL anmt980_set_pk_array()
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
 
{<section id="anmt980.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION anmt980_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="anmt980.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION anmt980_browser_fill(ps_page_action)
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
   #160122-00001#29--add--str--
   IF cl_null(g_wc) THEN
      LET g_wc=" nmeg016 IN (",g_sql_bank,")"
   ELSE
      LET g_wc=g_wc," AND nmeg016 IN (",g_sql_bank,")"
   END IF
   #160122-00001#29--add--end
        
   #end add-point    
 
   LET l_searchcol = "nmeg001"
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
      LET l_sub_sql = " SELECT DISTINCT nmeg001 ",
 
                      " FROM nmeg_t ",
                      " ",
                      " ", 
 
 
 
                      " WHERE nmegent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("nmeg_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT nmeg001 ",
 
                      " FROM nmeg_t ",
                      " ",
                      " ", 
 
 
                      " WHERE nmegent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("nmeg_t")
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
      INITIALIZE g_nmeg_m.* TO NULL
      CALL g_nmeg_d.clear()        
      CALL g_nmeg2_d.clear() 
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.nmeg001 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.nmeg001",
                " FROM nmeg_t t0",
                #" ",
                " ",
 
 
 
                
                " WHERE t0.nmegent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("nmeg_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
   
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"nmeg_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_nmeg001 
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
   
   IF cl_null(g_browser[g_cnt].b_nmeg001) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_nmeg_m.* TO NULL
      CALL g_nmeg_d.clear()
      CALL g_nmeg2_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL anmt980_fetch('')
   
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
 
{<section id="anmt980.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION anmt980_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_nmeg_m.nmeg001 = g_browser[g_current_idx].b_nmeg001   
 
   EXECUTE anmt980_master_referesh USING g_nmeg_m.nmeg001 INTO g_nmeg_m.nmegsite,g_nmeg_m.nmeg001,g_nmeg_m.nmeg003, 
       g_nmeg_m.nmeg004,g_nmeg_m.nmeg005,g_nmeg_m.nmeg006,g_nmeg_m.nmegsite_desc,g_nmeg_m.nmeg005_desc 
 
   CALL anmt980_show()
   
END FUNCTION
 
{</section>}
 
{<section id="anmt980.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION anmt980_ui_detailshow()
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
 
{<section id="anmt980.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION anmt980_ui_browser_refresh()
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
      IF g_browser[l_i].b_nmeg001 = g_nmeg_m.nmeg001 
 
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
 
{<section id="anmt980.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION anmt980_construct()
   #add-point:cs段define name="cs.define_customerization"
   
   #end add-point    
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   #add-point:cs段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   DEFINE l_wc        STRING #160816-00012#3 add
   #end add-point 
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
   
   #清除畫面上相關資料
   CLEAR FORM                 
   INITIALIZE g_nmeg_m.* TO NULL
   CALL g_nmeg_d.clear()
   CALL g_nmeg2_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON nmegsite,nmeg001,nmeg003,nmeg004,nmeg005,nmeg006
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
                 #Ctrlp:construct.c.nmegsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmegsite
            #add-point:ON ACTION controlp INFIELD nmegsite name="construct.c.nmegsite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef206 = 'Y'" 
            #CALL q_ooef001_14()                           #呼叫開窗 #161006-00005#37 mark
            CALL q_ooef001_1()                             #161006-00005#37 add
            DISPLAY g_qryparam.return1 TO nmegsite  #顯示到畫面上
            NEXT FIELD nmegsite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmegsite
            #add-point:BEFORE FIELD nmegsite name="construct.b.nmegsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmegsite
            
            #add-point:AFTER FIELD nmegsite name="construct.a.nmegsite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmeg001
            #add-point:BEFORE FIELD nmeg001 name="construct.b.nmeg001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmeg001
            
            #add-point:AFTER FIELD nmeg001 name="construct.a.nmeg001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmeg001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmeg001
            #add-point:ON ACTION controlp INFIELD nmeg001 name="construct.c.nmeg001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmeg003
            #add-point:BEFORE FIELD nmeg003 name="construct.b.nmeg003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmeg003
            
            #add-point:AFTER FIELD nmeg003 name="construct.a.nmeg003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmeg003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmeg003
            #add-point:ON ACTION controlp INFIELD nmeg003 name="construct.c.nmeg003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmeg004
            #add-point:BEFORE FIELD nmeg004 name="construct.b.nmeg004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmeg004
            
            #add-point:AFTER FIELD nmeg004 name="construct.a.nmeg004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmeg004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmeg004
            #add-point:ON ACTION controlp INFIELD nmeg004 name="construct.c.nmeg004"
            
            #END add-point
 
 
         #Ctrlp:construct.c.nmeg005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmeg005
            #add-point:ON ACTION controlp INFIELD nmeg005 name="construct.c.nmeg005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmeg005  #顯示到畫面上
            NEXT FIELD nmeg005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmeg005
            #add-point:BEFORE FIELD nmeg005 name="construct.b.nmeg005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmeg005
            
            #add-point:AFTER FIELD nmeg005 name="construct.a.nmeg005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmeg006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmeg006
            #add-point:ON ACTION controlp INFIELD nmeg006 name="construct.c.nmeg006"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_nmbd001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmeg006  #顯示到畫面上
            NEXT FIELD nmeg006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmeg006
            #add-point:BEFORE FIELD nmeg006 name="construct.b.nmeg006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmeg006
            
            #add-point:AFTER FIELD nmeg006 name="construct.a.nmeg006"
            
            #END add-point
            
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON nmegseq,nmegdocdt,nmeg002,nmbd003,nmbd004,nmeg007,nmeg008,nmeg009,nmeg010, 
          nmeg011,nmeg012,nmeg013,nmeg014,nmeg016,nmeg015,nmeg017,nmegstus,nmegownid,nmegowndp,nmegcrtid, 
          nmegcrtdp,nmegcrtdt,nmegmodid,nmegmoddt
           FROM s_detail1[1].nmegseq,s_detail1[1].nmegdocdt,s_detail1[1].nmeg002,s_detail1[1].nmbd003, 
               s_detail1[1].nmbd004,s_detail1[1].nmeg007,s_detail1[1].nmeg008,s_detail1[1].nmeg009,s_detail1[1].nmeg010, 
               s_detail1[1].nmeg011,s_detail1[1].nmeg012,s_detail1[1].nmeg013,s_detail1[1].nmeg014,s_detail1[1].nmeg016, 
               s_detail1[1].nmeg015,s_detail1[1].nmeg017,s_detail1[1].nmegstus,s_detail2[1].nmegownid, 
               s_detail2[1].nmegowndp,s_detail2[1].nmegcrtid,s_detail2[1].nmegcrtdp,s_detail2[1].nmegcrtdt, 
               s_detail2[1].nmegmodid,s_detail2[1].nmegmoddt
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<nmegcrtdt>>----
         AFTER FIELD nmegcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<nmegmoddt>>----
         AFTER FIELD nmegmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<nmegcnfdt>>----
         
         #----<<nmegpstdt>>----
 
 
 
           
         #單身一般欄位開窗相關處理
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmegseq
            #add-point:BEFORE FIELD nmegseq name="construct.b.page1.nmegseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmegseq
            
            #add-point:AFTER FIELD nmegseq name="construct.a.page1.nmegseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmegseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmegseq
            #add-point:ON ACTION controlp INFIELD nmegseq name="construct.c.page1.nmegseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmegdocdt
            #add-point:BEFORE FIELD nmegdocdt name="construct.b.page1.nmegdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmegdocdt
            
            #add-point:AFTER FIELD nmegdocdt name="construct.a.page1.nmegdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmegdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmegdocdt
            #add-point:ON ACTION controlp INFIELD nmegdocdt name="construct.c.page1.nmegdocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.nmeg002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmeg002
            #add-point:ON ACTION controlp INFIELD nmeg002 name="construct.c.page1.nmeg002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_nmbd002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmeg002  #顯示到畫面上
            NEXT FIELD nmeg002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmeg002
            #add-point:BEFORE FIELD nmeg002 name="construct.b.page1.nmeg002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmeg002
            
            #add-point:AFTER FIELD nmeg002 name="construct.a.page1.nmeg002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbd003
            #add-point:BEFORE FIELD nmbd003 name="construct.b.page1.nmbd003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbd003
            
            #add-point:AFTER FIELD nmbd003 name="construct.a.page1.nmbd003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbd003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbd003
            #add-point:ON ACTION controlp INFIELD nmbd003 name="construct.c.page1.nmbd003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbd004
            #add-point:BEFORE FIELD nmbd004 name="construct.b.page1.nmbd004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbd004
            
            #add-point:AFTER FIELD nmbd004 name="construct.a.page1.nmbd004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbd004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbd004
            #add-point:ON ACTION controlp INFIELD nmbd004 name="construct.c.page1.nmbd004"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.nmeg007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmeg007
            #add-point:ON ACTION controlp INFIELD nmeg007 name="construct.c.page1.nmeg007"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.where = " ooef206 = 'Y'"    #160816-00012#3
            LET g_qryparam.where = " ooef201 = 'Y'"     #161006-00005#37
            #160816-00012#3 Add  ---(S)---
            CALL s_axrt300_get_site(g_user,'','1') RETURNING l_wc
            LET g_qryparam.where = g_qryparam.where," AND ",l_wc CLIPPED
            #160816-00012#3 Add  ---(E)---            
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmeg007  #顯示到畫面上
            NEXT FIELD nmeg007                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmeg007
            #add-point:BEFORE FIELD nmeg007 name="construct.b.page1.nmeg007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmeg007
            
            #add-point:AFTER FIELD nmeg007 name="construct.a.page1.nmeg007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmeg008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmeg008
            #add-point:ON ACTION controlp INFIELD nmeg008 name="construct.c.page1.nmeg008"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmeg008  #顯示到畫面上
            NEXT FIELD nmeg008                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmeg008
            #add-point:BEFORE FIELD nmeg008 name="construct.b.page1.nmeg008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmeg008
            
            #add-point:AFTER FIELD nmeg008 name="construct.a.page1.nmeg008"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmeg009
            #add-point:BEFORE FIELD nmeg009 name="construct.b.page1.nmeg009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmeg009
            
            #add-point:AFTER FIELD nmeg009 name="construct.a.page1.nmeg009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmeg009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmeg009
            #add-point:ON ACTION controlp INFIELD nmeg009 name="construct.c.page1.nmeg009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmeg010
            #add-point:BEFORE FIELD nmeg010 name="construct.b.page1.nmeg010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmeg010
            
            #add-point:AFTER FIELD nmeg010 name="construct.a.page1.nmeg010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmeg010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmeg010
            #add-point:ON ACTION controlp INFIELD nmeg010 name="construct.c.page1.nmeg010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmeg011
            #add-point:BEFORE FIELD nmeg011 name="construct.b.page1.nmeg011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmeg011
            
            #add-point:AFTER FIELD nmeg011 name="construct.a.page1.nmeg011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmeg011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmeg011
            #add-point:ON ACTION controlp INFIELD nmeg011 name="construct.c.page1.nmeg011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmeg012
            #add-point:BEFORE FIELD nmeg012 name="construct.b.page1.nmeg012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmeg012
            
            #add-point:AFTER FIELD nmeg012 name="construct.a.page1.nmeg012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmeg012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmeg012
            #add-point:ON ACTION controlp INFIELD nmeg012 name="construct.c.page1.nmeg012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmeg013
            #add-point:BEFORE FIELD nmeg013 name="construct.b.page1.nmeg013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmeg013
            
            #add-point:AFTER FIELD nmeg013 name="construct.a.page1.nmeg013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmeg013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmeg013
            #add-point:ON ACTION controlp INFIELD nmeg013 name="construct.c.page1.nmeg013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmeg014
            #add-point:BEFORE FIELD nmeg014 name="construct.b.page1.nmeg014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmeg014
            
            #add-point:AFTER FIELD nmeg014 name="construct.a.page1.nmeg014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmeg014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmeg014
            #add-point:ON ACTION controlp INFIELD nmeg014 name="construct.c.page1.nmeg014"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.nmeg016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmeg016
            #add-point:ON ACTION controlp INFIELD nmeg016 name="construct.c.page1.nmeg016"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #160122-00001#29--add---str
            LET g_qryparam.where = " nmas002 IN (",g_sql_bank,")"
            #160122-00001#29--add---end
            CALL q_nmas_01()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmeg016  #顯示到畫面上
            NEXT FIELD nmeg016                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmeg016
            #add-point:BEFORE FIELD nmeg016 name="construct.b.page1.nmeg016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmeg016
            
            #add-point:AFTER FIELD nmeg016 name="construct.a.page1.nmeg016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmeg015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmeg015
            #add-point:ON ACTION controlp INFIELD nmeg015 name="construct.c.page1.nmeg015"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_25()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmeg015  #顯示到畫面上
            NEXT FIELD nmeg015                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmeg015
            #add-point:BEFORE FIELD nmeg015 name="construct.b.page1.nmeg015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmeg015
            
            #add-point:AFTER FIELD nmeg015 name="construct.a.page1.nmeg015"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmeg017
            #add-point:BEFORE FIELD nmeg017 name="construct.b.page1.nmeg017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmeg017
            
            #add-point:AFTER FIELD nmeg017 name="construct.a.page1.nmeg017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmeg017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmeg017
            #add-point:ON ACTION controlp INFIELD nmeg017 name="construct.c.page1.nmeg017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmegstus
            #add-point:BEFORE FIELD nmegstus name="construct.b.page1.nmegstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmegstus
            
            #add-point:AFTER FIELD nmegstus name="construct.a.page1.nmegstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmegstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmegstus
            #add-point:ON ACTION controlp INFIELD nmegstus name="construct.c.page1.nmegstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.nmegownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmegownid
            #add-point:ON ACTION controlp INFIELD nmegownid name="construct.c.page2.nmegownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmegownid  #顯示到畫面上
            NEXT FIELD nmegownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmegownid
            #add-point:BEFORE FIELD nmegownid name="construct.b.page2.nmegownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmegownid
            
            #add-point:AFTER FIELD nmegownid name="construct.a.page2.nmegownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.nmegowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmegowndp
            #add-point:ON ACTION controlp INFIELD nmegowndp name="construct.c.page2.nmegowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmegowndp  #顯示到畫面上
            NEXT FIELD nmegowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmegowndp
            #add-point:BEFORE FIELD nmegowndp name="construct.b.page2.nmegowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmegowndp
            
            #add-point:AFTER FIELD nmegowndp name="construct.a.page2.nmegowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.nmegcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmegcrtid
            #add-point:ON ACTION controlp INFIELD nmegcrtid name="construct.c.page2.nmegcrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmegcrtid  #顯示到畫面上
            NEXT FIELD nmegcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmegcrtid
            #add-point:BEFORE FIELD nmegcrtid name="construct.b.page2.nmegcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmegcrtid
            
            #add-point:AFTER FIELD nmegcrtid name="construct.a.page2.nmegcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.nmegcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmegcrtdp
            #add-point:ON ACTION controlp INFIELD nmegcrtdp name="construct.c.page2.nmegcrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmegcrtdp  #顯示到畫面上
            NEXT FIELD nmegcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmegcrtdp
            #add-point:BEFORE FIELD nmegcrtdp name="construct.b.page2.nmegcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmegcrtdp
            
            #add-point:AFTER FIELD nmegcrtdp name="construct.a.page2.nmegcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmegcrtdt
            #add-point:BEFORE FIELD nmegcrtdt name="construct.b.page2.nmegcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.nmegmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmegmodid
            #add-point:ON ACTION controlp INFIELD nmegmodid name="construct.c.page2.nmegmodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmegmodid  #顯示到畫面上
            NEXT FIELD nmegmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmegmodid
            #add-point:BEFORE FIELD nmegmodid name="construct.b.page2.nmegmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmegmodid
            
            #add-point:AFTER FIELD nmegmodid name="construct.a.page2.nmegmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmegmoddt
            #add-point:BEFORE FIELD nmegmoddt name="construct.b.page2.nmegmoddt"
            
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
 
{<section id="anmt980.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION anmt980_query()
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
   CALL g_nmeg_d.clear()
   CALL g_nmeg2_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL anmt980_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL anmt980_browser_fill(g_wc)
      CALL anmt980_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL anmt980_browser_fill("F")
   
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
      CALL anmt980_fetch("F") 
   END IF
   
   CALL anmt980_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="anmt980.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION anmt980_fetch(p_flag)
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
   
   #CALL anmt980_browser_fill(p_flag)
   
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
   
   LET g_nmeg_m.nmeg001 = g_browser[g_current_idx].b_nmeg001
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE anmt980_master_referesh USING g_nmeg_m.nmeg001 INTO g_nmeg_m.nmegsite,g_nmeg_m.nmeg001,g_nmeg_m.nmeg003, 
       g_nmeg_m.nmeg004,g_nmeg_m.nmeg005,g_nmeg_m.nmeg006,g_nmeg_m.nmegsite_desc,g_nmeg_m.nmeg005_desc 
 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "nmeg_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_nmeg_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_nmeg_m_mask_o.* =  g_nmeg_m.*
   CALL anmt980_nmeg_t_mask()
   LET g_nmeg_m_mask_n.* =  g_nmeg_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL anmt980_set_act_visible()
   CALL anmt980_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_nmeg_m_t.* = g_nmeg_m.*
   LET g_nmeg_m_o.* = g_nmeg_m.*
   
   #重新顯示   
   CALL anmt980_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="anmt980.insert" >}
#+ 資料新增
PRIVATE FUNCTION anmt980_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_nmeg_d.clear()
   CALL g_nmeg2_d.clear()
 
 
   INITIALIZE g_nmeg_m.* TO NULL             #DEFAULT 設定
   LET g_nmeg001_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
            LET g_nmeg_m.nmeg001 = "ALL"
 
     
      #add-point:單頭預設值 name="insert.default"
      CALL cl_set_comp_required("nmeg003,nmeg004,nmeg005,nmeg006",TRUE)
      #end add-point 
 
      CALL anmt980_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_nmeg_m.* TO NULL
         INITIALIZE g_nmeg_d TO NULL
         INITIALIZE g_nmeg2_d TO NULL
 
         CALL anmt980_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_nmeg_m.* = g_nmeg_m_t.*
         CALL anmt980_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_nmeg_d.clear()
      #CALL g_nmeg2_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL anmt980_set_act_visible()
   CALL anmt980_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_nmeg001_t = g_nmeg_m.nmeg001
 
   
   #組合新增資料的條件
   LET g_add_browse = " nmegent = " ||g_enterprise|| " AND",
                      " nmeg001 = '", g_nmeg_m.nmeg001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL anmt980_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL anmt980_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE anmt980_master_referesh USING g_nmeg_m.nmeg001 INTO g_nmeg_m.nmegsite,g_nmeg_m.nmeg001,g_nmeg_m.nmeg003, 
       g_nmeg_m.nmeg004,g_nmeg_m.nmeg005,g_nmeg_m.nmeg006,g_nmeg_m.nmegsite_desc,g_nmeg_m.nmeg005_desc 
 
   
   #遮罩相關處理
   LET g_nmeg_m_mask_o.* =  g_nmeg_m.*
   CALL anmt980_nmeg_t_mask()
   LET g_nmeg_m_mask_n.* =  g_nmeg_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_nmeg_m.nmegsite,g_nmeg_m.nmegsite_desc,g_nmeg_m.nmeg001,g_nmeg_m.nmeg003,g_nmeg_m.nmeg004, 
       g_nmeg_m.nmeg005,g_nmeg_m.nmeg005_desc,g_nmeg_m.nmeg006
   
   #功能已完成,通報訊息中心
   CALL anmt980_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="anmt980.modify" >}
#+ 資料修改
PRIVATE FUNCTION anmt980_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_nmeg_m.nmeg001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_nmeg001_t = g_nmeg_m.nmeg001
 
   CALL s_transaction_begin()
   
   OPEN anmt980_cl USING g_enterprise,g_nmeg_m.nmeg001
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN anmt980_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE anmt980_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE anmt980_master_referesh USING g_nmeg_m.nmeg001 INTO g_nmeg_m.nmegsite,g_nmeg_m.nmeg001,g_nmeg_m.nmeg003, 
       g_nmeg_m.nmeg004,g_nmeg_m.nmeg005,g_nmeg_m.nmeg006,g_nmeg_m.nmegsite_desc,g_nmeg_m.nmeg005_desc 
 
   
   #遮罩相關處理
   LET g_nmeg_m_mask_o.* =  g_nmeg_m.*
   CALL anmt980_nmeg_t_mask()
   LET g_nmeg_m_mask_n.* =  g_nmeg_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL anmt980_show()
   WHILE TRUE
      LET g_nmeg001_t = g_nmeg_m.nmeg001
 
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL anmt980_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_nmeg_m.* = g_nmeg_m_t.*
         CALL anmt980_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_nmeg_m.nmeg001 != g_nmeg001_t 
 
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
   CALL anmt980_set_act_visible()
   CALL anmt980_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " nmegent = " ||g_enterprise|| " AND",
                      " nmeg001 = '", g_nmeg_m.nmeg001, "' "
 
   #填到對應位置
   CALL anmt980_browser_fill("")
 
   CALL anmt980_idx_chk()
 
   CLOSE anmt980_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL anmt980_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="anmt980.input" >}
#+ 資料輸入
PRIVATE FUNCTION anmt980_input(p_cmd)
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
   DEFINE  l_err                 LIKE type_t.num5       
   DEFINE  l_err_code            STRING 
   DEFINE  l_origin_str          STRING
   DEFINE  l_success             LIKE type_t.num5
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
   DISPLAY BY NAME g_nmeg_m.nmegsite,g_nmeg_m.nmegsite_desc,g_nmeg_m.nmeg001,g_nmeg_m.nmeg003,g_nmeg_m.nmeg004, 
       g_nmeg_m.nmeg005,g_nmeg_m.nmeg005_desc,g_nmeg_m.nmeg006
   
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
   LET g_forupd_sql = "SELECT nmegseq,nmegdocdt,nmeg002,nmeg007,nmeg008,nmeg009,nmeg010,nmeg011,nmeg012, 
       nmeg013,nmeg014,nmeg016,nmeg015,nmeg017,nmegstus,nmegseq,nmegownid,nmegowndp,nmegcrtid,nmegcrtdp, 
       nmegcrtdt,nmegmodid,nmegmoddt FROM nmeg_t WHERE nmegent=? AND nmeg001=? AND nmegseq=? FOR UPDATE" 
 
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE anmt980_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL anmt980_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL anmt980_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_nmeg_m.nmegsite,g_nmeg_m.nmeg001,g_nmeg_m.nmeg003,g_nmeg_m.nmeg004,g_nmeg_m.nmeg005, 
       g_nmeg_m.nmeg006
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   LET g_errshow = 1
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="anmt980.input.head" >}
   
      #單頭段
      INPUT BY NAME g_nmeg_m.nmegsite,g_nmeg_m.nmeg001,g_nmeg_m.nmeg003,g_nmeg_m.nmeg004,g_nmeg_m.nmeg005, 
          g_nmeg_m.nmeg006 
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
         AFTER FIELD nmegsite
            
            #add-point:AFTER FIELD nmegsite name="input.a.nmegsite"
            IF NOT cl_null(g_nmeg_m.nmegsite) THEN 
##應用 a17 樣板自動產生(Version:2)
#               #欄位存在檢查
#               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#               INITIALIZE g_chkparam.* TO NULL
#
#               #設定g_chkparam.*的參數
#               LET g_chkparam.arg1 = g_nmeg_m.nmegsite
#
#                  
#               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist("v_ooef001_13") THEN
#                  #檢查成功時後續處理
#                  IF g_nmeg_m.nmeg001 = 'ALL' THEN 
#                     SELECT ooef017 INTO g_ooef017 
#                       FROM ooef_t
#                      WHERE ooefent = g_enterprise
#                        AND ooef001 = g_nmeg_m.nmegsite
#                     
#                     IF cl_null(g_nmeg_m.nmeg005) THEN                      
#                        SELECT glaa001 INTO g_nmeg_m.nmeg005
#                          FROM glaa_t
#                         WHERE glaaent = g_enterprise
#                           AND glaacomp = g_ooef017
#                           AND glaa014 = 'Y'
#                        LET g_nmeg_m_t.nmeg005 = g_nmeg_m.nmeg005
#                        CALL anmt980_nmeg005_desc(g_nmeg_m.nmeg005) RETURNING g_nmeg_m.nmeg005_desc
#                        DISPLAY g_nmeg_m.nmeg005_desc TO nmeg005_desc   
#                     END IF
#                  END IF
#               ELSE
#                  #檢查失敗時後續處理
#                  LET g_nmeg_m.nmegsite = g_nmeg_m_t.nmegsite
#                  NEXT FIELD CURRENT
#               END IF
#
#
               CALL s_fin_account_center_with_ld_chk(g_nmeg_m.nmegsite,'',g_user,'6','N','',g_today) RETURNING l_success,g_errno
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno       
                  LET g_errparam.extend = g_nmeg_m.nmegsite
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_nmeg_m.nmegsite = g_nmeg_m_t.nmegsite
                  CALL anmt980_nmegsite_desc(g_nmeg_m.nmegsite) RETURNING g_nmeg_m.nmegsite_desc
                  DISPLAY g_nmeg_m.nmegsite_desc TO nmegsite_desc
                  NEXT FIELD CURRENT
               END IF
               IF g_nmeg_m.nmeg001 = 'ALL' THEN 
                  SELECT ooef017 INTO g_ooef017 
                    FROM ooef_t
                   WHERE ooefent = g_enterprise
                     AND ooef001 = g_nmeg_m.nmegsite
                  
                  IF cl_null(g_nmeg_m.nmeg005) THEN                      
                     SELECT glaa001 INTO g_nmeg_m.nmeg005
                       FROM glaa_t
                      WHERE glaaent = g_enterprise
                        AND glaacomp = g_ooef017
                        AND glaa014 = 'Y'
                     LET g_nmeg_m_t.nmeg005 = g_nmeg_m.nmeg005
                     CALL anmt980_nmeg005_desc(g_nmeg_m.nmeg005) RETURNING g_nmeg_m.nmeg005_desc
                     DISPLAY g_nmeg_m.nmeg005_desc TO nmeg005_desc   
                  END IF
               END IF
               #CALL s_anm_get_site_wc('6',g_ooef017,g_today) RETURNING g_site_wc #160912-00024#1 
               CALL s_anm_get_site_wc('6',g_nmeg_m.nmegsite,g_today) RETURNING g_site_wc#160912-00024#1 
            END IF 

            CALL anmt980_nmegsite_desc(g_nmeg_m.nmegsite) RETURNING g_nmeg_m.nmegsite_desc
            DISPLAY g_nmeg_m.nmegsite_desc TO nmegsite_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmegsite
            #add-point:BEFORE FIELD nmegsite name="input.b.nmegsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmegsite
            #add-point:ON CHANGE nmegsite name="input.g.nmegsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmeg001
            #add-point:BEFORE FIELD nmeg001 name="input.b.nmeg001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmeg001
            
            #add-point:AFTER FIELD nmeg001 name="input.a.nmeg001"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF NOT cl_null(g_nmeg_m.nmeg001) AND g_nmeg_m.nmeg001 <> 'ALL' THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_nmeg_m.nmeg001 != g_nmeg001_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM nmeg_t WHERE "||"nmegent = '" ||g_enterprise|| "' AND "||"nmeg001 = '"||g_nmeg_m.nmeg001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            CALL anmt980_set_entry(p_cmd)
            CALL anmt980_set_no_entry(p_cmd)
            
            IF g_nmeg_m.nmeg001 = 'ALL' THEN 
               SELECT ooef017 INTO g_ooef017 
                 FROM ooef_t
                WHERE ooefent = g_enterprise
                  AND ooef001 = g_nmeg_m.nmegsite
                  
               IF cl_null(g_nmeg_m.nmeg005) THEN    
                  SELECT glaa001 INTO g_nmeg_m.nmeg005
                    FROM glaa_t
                   WHERE glaaent = g_enterprise
                     AND glaacomp = g_ooef017
                     AND glaa014 = 'Y'
                  LET g_nmeg_m_t.nmeg005 = g_nmeg_m.nmeg005
                  CALL anmt980_nmeg005_desc(g_nmeg_m.nmeg005) RETURNING g_nmeg_m.nmeg005_desc
                  DISPLAY g_nmeg_m.nmeg005_desc TO nmeg005_desc 
               END IF                  
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmeg001
            #add-point:ON CHANGE nmeg001 name="input.g.nmeg001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmeg003
            #add-point:BEFORE FIELD nmeg003 name="input.b.nmeg003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmeg003
            
            #add-point:AFTER FIELD nmeg003 name="input.a.nmeg003"
            IF NOT cl_null(g_nmeg_m.nmeg003) THEN 
               IF NOT cl_null(g_nmeg_m.nmeg004) AND g_nmeg_m.nmeg003 > g_nmeg_m.nmeg004 THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "agl-00116" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  
                  NEXT FIELD CURRENT
               END IF
               
               CALL anmt980_repeat_chk(g_nmeg_m.nmeg003) RETURNING l_err,l_err_code
               
               IF l_err THEN    # 表示有錯誤
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_err_code
                  LET g_errparam.extend = g_nmeg_m.nmeg003
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  
                  NEXT FIELD CURRENT
               END IF
               
               IF NOT cl_null(g_nmeg_m.nmeg004) THEN 
                  SELECT COUNT(*) INTO l_n
                    FROM nmeg_t
                   WHERE nmegent = g_enterprise
                     AND nmeg001 = g_nmeg_m.nmeg001
                     AND nmeg003 >= g_nmeg_m.nmeg003
                     AND nmeg004 <= g_nmeg_m.nmeg004
                     
                  IF l_n > 0 THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "anm-02960"
                     LET g_errparam.extend = g_nmeg_m.nmeg003
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     
                     NEXT FIELD CURRENT
                     END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmeg003
            #add-point:ON CHANGE nmeg003 name="input.g.nmeg003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmeg004
            #add-point:BEFORE FIELD nmeg004 name="input.b.nmeg004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmeg004
            
            #add-point:AFTER FIELD nmeg004 name="input.a.nmeg004"
            IF NOT cl_null(g_nmeg_m.nmeg004) THEN 
               IF NOT cl_null(g_nmeg_m.nmeg003) AND g_nmeg_m.nmeg004 < g_nmeg_m.nmeg003 THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "agl-00117" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  
                  NEXT FIELD CURRENT
               END IF
               
               CALL anmt980_repeat_chk(g_nmeg_m.nmeg004) RETURNING l_err,l_err_code
               
               IF l_err THEN    # 表示有錯誤
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_err_code
                  LET g_errparam.extend = g_nmeg_m.nmeg004
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  
                  NEXT FIELD CURRENT
               END IF
               
               IF NOT cl_null(g_nmeg_m.nmeg003) THEN 
                  SELECT COUNT(*) INTO l_n
                    FROM nmeg_t
                   WHERE nmegent = g_enterprise
                     AND nmeg001 = g_nmeg_m.nmeg001
                     AND nmeg003 >= g_nmeg_m.nmeg003
                     AND nmeg004 <= g_nmeg_m.nmeg004
                     
                  IF l_n > 0 THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "anm-02960"
                     LET g_errparam.extend = g_nmeg_m.nmeg004
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     
                     NEXT FIELD CURRENT
                     END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmeg004
            #add-point:ON CHANGE nmeg004 name="input.g.nmeg004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmeg005
            
            #add-point:AFTER FIELD nmeg005 name="input.a.nmeg005"
            IF NOT cl_null(g_nmeg_m.nmeg005) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_nmeg_m.nmeg005

               #160318-00025#26  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aoo-00011:sub-01302|aooi140|",cl_get_progname("aooi140",g_lang,"2"),"|:EXEPROGaooi140"
               #160318-00025#26  by 07900 --add-end   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooai001") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  LET g_nmeg_m.nmeg005 = g_nmeg_m_t.nmeg005
                  CALL anmt980_nmeg005_desc(g_nmeg_m.nmeg005) RETURNING g_nmeg_m.nmeg005_desc
                  DISPLAY g_nmeg_m.nmeg005_desc TO nmeg005_desc   
                  NEXT FIELD CURRENT
               END IF
            END IF 
 
            CALL anmt980_nmeg005_desc(g_nmeg_m.nmeg005) RETURNING g_nmeg_m.nmeg005_desc
            DISPLAY g_nmeg_m.nmeg005_desc TO nmeg005_desc   
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmeg005
            #add-point:BEFORE FIELD nmeg005 name="input.b.nmeg005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmeg005
            #add-point:ON CHANGE nmeg005 name="input.g.nmeg005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmeg006
            
            #add-point:AFTER FIELD nmeg006 name="input.a.nmeg006"
            IF NOT cl_null(g_nmeg_m.nmeg006) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_nmeg_m.nmeg006

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_nmbd001") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  LET g_nmeg_m.nmeg006 = g_nmeg_m_t.nmeg006
                  NEXT FIELD CURRENT
               END IF


            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmeg006
            #add-point:BEFORE FIELD nmeg006 name="input.b.nmeg006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmeg006
            #add-point:ON CHANGE nmeg006 name="input.g.nmeg006"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.nmegsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmegsite
            #add-point:ON ACTION controlp INFIELD nmegsite name="input.c.nmegsite"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmeg_m.nmegsite             #給予default值
            LET g_qryparam.default2 = "" #g_nmeg_m.ooef001 #组织编号
            LET g_qryparam.where = " ooef206 = 'Y'"                       
            #給予arg
            LET g_qryparam.arg1 = "" #


            #CALL q_ooef001_14()                                #呼叫開窗 #161006-00005#37 mark
            CALL q_ooef001_1()                             #161006-00005#37 add
            LET g_nmeg_m.nmegsite = g_qryparam.return1              
            CALL anmt980_nmegsite_desc(g_nmeg_m.nmegsite) RETURNING g_nmeg_m.nmegsite_desc
            DISPLAY g_nmeg_m.nmegsite TO nmegsite              #
            DISPLAY g_nmeg_m.nmegsite_desc TO nmegsite_desc
            NEXT FIELD nmegsite                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.nmeg001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmeg001
            #add-point:ON ACTION controlp INFIELD nmeg001 name="input.c.nmeg001"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmeg003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmeg003
            #add-point:ON ACTION controlp INFIELD nmeg003 name="input.c.nmeg003"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmeg004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmeg004
            #add-point:ON ACTION controlp INFIELD nmeg004 name="input.c.nmeg004"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmeg005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmeg005
            #add-point:ON ACTION controlp INFIELD nmeg005 name="input.c.nmeg005"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmeg_m.nmeg005             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #


            CALL q_ooai001()                                #呼叫開窗

            LET g_nmeg_m.nmeg005 = g_qryparam.return1              

            DISPLAY g_nmeg_m.nmeg005 TO nmeg005              #

            NEXT FIELD nmeg005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.nmeg006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmeg006
            #add-point:ON ACTION controlp INFIELD nmeg006 name="input.c.nmeg006"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmeg_m.nmeg006             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #


            CALL q_nmbd001()                                #呼叫開窗

            LET g_nmeg_m.nmeg006 = g_qryparam.return1              

            DISPLAY g_nmeg_m.nmeg006 TO nmeg006              #

            NEXT FIELD nmeg006                          #返回原欄位


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
            DISPLAY BY NAME g_nmeg_m.nmeg001             
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
            
               #將遮罩欄位還原
               CALL anmt980_nmeg_t_mask_restore('restore_mask_o')
            
               UPDATE nmeg_t SET (nmegsite,nmeg001,nmeg003,nmeg004,nmeg005,nmeg006) = (g_nmeg_m.nmegsite, 
                   g_nmeg_m.nmeg001,g_nmeg_m.nmeg003,g_nmeg_m.nmeg004,g_nmeg_m.nmeg005,g_nmeg_m.nmeg006) 
 
                WHERE nmegent = g_enterprise AND nmeg001 = g_nmeg001_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "nmeg_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "nmeg_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_nmeg_m.nmeg001
               LET gs_keys_bak[1] = g_nmeg001_t
               LET gs_keys[2] = g_nmeg_d[g_detail_idx].nmegseq
               LET gs_keys_bak[2] = g_nmeg_d_t.nmegseq
               CALL anmt980_update_b('nmeg_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_nmeg_m_t)
                     #LET g_log2 = util.JSON.stringify(g_nmeg_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL anmt980_nmeg_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL anmt980_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_nmeg001_t = g_nmeg_m.nmeg001
 
           
           IF g_nmeg_d.getLength() = 0 THEN
              NEXT FIELD nmegseq
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="anmt980.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_nmeg_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_nmeg_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL anmt980_b_fill(g_wc2) #test 
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
            CALL anmt980_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN anmt980_cl USING g_enterprise,g_nmeg_m.nmeg001                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE anmt980_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN anmt980_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_nmeg_d[l_ac].nmegseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_nmeg_d_t.* = g_nmeg_d[l_ac].*  #BACKUP
               LET g_nmeg_d_o.* = g_nmeg_d[l_ac].*  #BACKUP
               CALL anmt980_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL anmt980_set_no_entry_b(l_cmd)
               OPEN anmt980_bcl USING g_enterprise,g_nmeg_m.nmeg001,
 
                                                g_nmeg_d_t.nmegseq
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN anmt980_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH anmt980_bcl INTO g_nmeg_d[l_ac].nmegseq,g_nmeg_d[l_ac].nmegdocdt,g_nmeg_d[l_ac].nmeg002, 
                      g_nmeg_d[l_ac].nmeg007,g_nmeg_d[l_ac].nmeg008,g_nmeg_d[l_ac].nmeg009,g_nmeg_d[l_ac].nmeg010, 
                      g_nmeg_d[l_ac].nmeg011,g_nmeg_d[l_ac].nmeg012,g_nmeg_d[l_ac].nmeg013,g_nmeg_d[l_ac].nmeg014, 
                      g_nmeg_d[l_ac].nmeg016,g_nmeg_d[l_ac].nmeg015,g_nmeg_d[l_ac].nmeg017,g_nmeg_d[l_ac].nmegstus, 
                      g_nmeg2_d[l_ac].nmegseq,g_nmeg2_d[l_ac].nmegownid,g_nmeg2_d[l_ac].nmegowndp,g_nmeg2_d[l_ac].nmegcrtid, 
                      g_nmeg2_d[l_ac].nmegcrtdp,g_nmeg2_d[l_ac].nmegcrtdt,g_nmeg2_d[l_ac].nmegmodid, 
                      g_nmeg2_d[l_ac].nmegmoddt
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_nmeg_d_t.nmegseq,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_nmeg_d_mask_o[l_ac].* =  g_nmeg_d[l_ac].*
                  CALL anmt980_nmeg_t_mask()
                  LET g_nmeg_d_mask_n[l_ac].* =  g_nmeg_d[l_ac].*
                  
                  CALL anmt980_ref_show()
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
            INITIALIZE g_nmeg_d_t.* TO NULL
            INITIALIZE g_nmeg_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_nmeg_d[l_ac].* TO NULL
            #公用欄位預設值
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_nmeg2_d[l_ac].nmegownid = g_user
      LET g_nmeg2_d[l_ac].nmegowndp = g_dept
      LET g_nmeg2_d[l_ac].nmegcrtid = g_user
      LET g_nmeg2_d[l_ac].nmegcrtdp = g_dept 
      LET g_nmeg2_d[l_ac].nmegcrtdt = cl_get_current()
      LET g_nmeg2_d[l_ac].nmegmodid = g_user
      LET g_nmeg2_d[l_ac].nmegmoddt = cl_get_current()
      LET g_nmeg_d[l_ac].nmegstus = ''
 
 
  
            #一般欄位預設值
                  LET g_nmeg_d[l_ac].nmegseq = "0"
      LET g_nmeg_d[l_ac].nmeg009 = "0"
      LET g_nmeg_d[l_ac].nmeg010 = "0"
      LET g_nmeg_d[l_ac].nmeg011 = "0"
      LET g_nmeg_d[l_ac].nmeg012 = "0"
      LET g_nmeg_d[l_ac].nmeg013 = "0"
      LET g_nmeg_d[l_ac].nmeg017 = "1"
      LET g_nmeg_d[l_ac].nmegstus = "Y"
 
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            #160912-00024#1 add s---
            LET g_nmeg_d[l_ac].nmeg007 = g_nmeg_m.nmegsite  
            SELECT COUNT(*) INTO l_count FROM ooef_t WHERE ooefent = g_enterprise
               AND ooef201 = 'Y'
               AND ooef001 = g_nmeg_d[l_ac].nmeg007
            IF cl_null(l_count) THEN LET l_count = 0 END IF
            IF l_count = 0 THEN
               LET g_nmeg_d[l_ac].nmeg007 = ''
            END IF  
            #160912-00024#1 add e---            
            #end add-point
            LET g_nmeg_d_t.* = g_nmeg_d[l_ac].*     #新輸入資料
            LET g_nmeg_d_o.* = g_nmeg_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL anmt980_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL anmt980_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_nmeg_d[li_reproduce_target].* = g_nmeg_d[li_reproduce].*
               LET g_nmeg2_d[li_reproduce_target].* = g_nmeg2_d[li_reproduce].*
 
               LET g_nmeg_d[g_nmeg_d.getLength()].nmegseq = NULL
 
            END IF
            
 
 
            #add-point:modify段before insert name="input.body.before_insert"
#160122-00001#29--mark--str--
#主键是ENT + nmeg001 + nmegseq,单头编号固定，单身项次一次增加
#            IF g_nmeg_m.nmeg001 = 'ALL' THEN 
#               SELECT MAX(nmegseq) INTO g_nmeg_d[l_ac].nmegseq
#                 FROM nmeg_t
#                WHERE nmegent = g_enterprise 
#                  AND nmeg001 = g_nmeg_m.nmeg001
#                  AND nmeg003 = g_nmeg_m.nmeg003
#                  AND nmeg004 = g_nmeg_m.nmeg004
#            ELSE
#160122-00001#29--mark--end
               SELECT MAX(nmegseq) INTO g_nmeg_d[l_ac].nmegseq
                 FROM nmeg_t
                WHERE nmegent = g_enterprise 
                  AND nmeg001 = g_nmeg_m.nmeg001
#            END IF #160122-00001#29 mark
            IF cl_null(g_nmeg_d[l_ac].nmegseq) THEN
               LET g_nmeg_d[l_ac].nmegseq = 1
            ELSE
               LET g_nmeg_d[l_ac].nmegseq = g_nmeg_d[l_ac].nmegseq +1
            END IF
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
            SELECT COUNT(1) INTO l_count FROM nmeg_t 
             WHERE nmegent = g_enterprise AND nmeg001 = g_nmeg_m.nmeg001
 
               AND nmegseq = g_nmeg_d[l_ac].nmegseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
               INSERT INTO nmeg_t
                           (nmegent,
                            nmegsite,nmeg001,nmeg003,nmeg004,nmeg005,nmeg006,
                            nmegseq
                            ,nmegdocdt,nmeg002,nmeg007,nmeg008,nmeg009,nmeg010,nmeg011,nmeg012,nmeg013,nmeg014,nmeg016,nmeg015,nmeg017,nmegstus,nmegownid,nmegowndp,nmegcrtid,nmegcrtdp,nmegcrtdt,nmegmodid,nmegmoddt) 
                     VALUES(g_enterprise,
                            g_nmeg_m.nmegsite,g_nmeg_m.nmeg001,g_nmeg_m.nmeg003,g_nmeg_m.nmeg004,g_nmeg_m.nmeg005,g_nmeg_m.nmeg006,
                            g_nmeg_d[l_ac].nmegseq
                            ,g_nmeg_d[l_ac].nmegdocdt,g_nmeg_d[l_ac].nmeg002,g_nmeg_d[l_ac].nmeg007, 
                                g_nmeg_d[l_ac].nmeg008,g_nmeg_d[l_ac].nmeg009,g_nmeg_d[l_ac].nmeg010, 
                                g_nmeg_d[l_ac].nmeg011,g_nmeg_d[l_ac].nmeg012,g_nmeg_d[l_ac].nmeg013, 
                                g_nmeg_d[l_ac].nmeg014,g_nmeg_d[l_ac].nmeg016,g_nmeg_d[l_ac].nmeg015, 
                                g_nmeg_d[l_ac].nmeg017,g_nmeg_d[l_ac].nmegstus,g_nmeg2_d[l_ac].nmegownid, 
                                g_nmeg2_d[l_ac].nmegowndp,g_nmeg2_d[l_ac].nmegcrtid,g_nmeg2_d[l_ac].nmegcrtdp, 
                                g_nmeg2_d[l_ac].nmegcrtdt,g_nmeg2_d[l_ac].nmegmodid,g_nmeg2_d[l_ac].nmegmoddt) 
 
               #add-point:單身新增中 name="input.body.m_insert"
               
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_nmeg_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "nmeg_t:",SQLERRMESSAGE 
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
               IF anmt980_before_delete() THEN 
                  
 
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_nmeg_m.nmeg001
 
                  LET gs_keys[gs_keys.getLength()+1] = g_nmeg_d_t.nmegseq
 
 
                  #刪除下層單身
                  IF NOT anmt980_key_delete_b(gs_keys,'nmeg_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE anmt980_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE anmt980_bcl
               LET l_count = g_nmeg_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_nmeg_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmegseq
            #add-point:BEFORE FIELD nmegseq name="input.b.page1.nmegseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmegseq
            
            #add-point:AFTER FIELD nmegseq name="input.a.page1.nmegseq"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_nmeg_m.nmeg001 IS NOT NULL AND g_nmeg_d[g_detail_idx].nmegseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_nmeg_m.nmeg001 != g_nmeg001_t OR g_nmeg_d[g_detail_idx].nmegseq != g_nmeg_d_t.nmegseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM nmeg_t WHERE "||"nmegent = '" ||g_enterprise|| "' AND "||"nmeg001 = '"||g_nmeg_m.nmeg001 ||"' AND "|| "nmegseq = '"||g_nmeg_d[g_detail_idx].nmegseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmegseq
            #add-point:ON CHANGE nmegseq name="input.g.page1.nmegseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmegdocdt
            #add-point:BEFORE FIELD nmegdocdt name="input.b.page1.nmegdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmegdocdt
            
            #add-point:AFTER FIELD nmegdocdt name="input.a.page1.nmegdocdt"
            IF NOT cl_null(g_nmeg_d[l_ac].nmegdocdt) THEN 
               IF g_nmeg_d[l_ac].nmegdocdt < g_nmeg_m.nmeg003 OR g_nmeg_d[l_ac].nmegdocdt > g_nmeg_m.nmeg004 THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_nmeg_d[l_ac].nmegdocdt 
                  LET g_errparam.code   = "anm-02961" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  
                  LET g_nmeg_d[l_ac].nmegdocdt = g_nmeg_d_t.nmegdocdt
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmegdocdt
            #add-point:ON CHANGE nmegdocdt name="input.g.page1.nmegdocdt"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmeg002
            
            #add-point:AFTER FIELD nmeg002 name="input.a.page1.nmeg002"
            IF NOT cl_null(g_nmeg_d[l_ac].nmeg002) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_nmeg_m.nmeg006
               LET g_chkparam.arg2 = g_nmeg_d[l_ac].nmeg002
               #160318-00025#26  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aoo-00004:apr-00152"
               #160318-00025#26  by 07900 --add-end  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_nmbd002") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  LET g_nmeg_d[l_ac].nmeg002 = g_nmeg_d_t.nmeg002
                  CALL anmt980_nmeg002_desc()
                  NEXT FIELD CURRENT
               END IF


            END IF 
            
            CALL anmt980_nmeg002_desc()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmeg002
            #add-point:BEFORE FIELD nmeg002 name="input.b.page1.nmeg002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmeg002
            #add-point:ON CHANGE nmeg002 name="input.g.page1.nmeg002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbd003
            #add-point:BEFORE FIELD nmbd003 name="input.b.page1.nmbd003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbd003
            
            #add-point:AFTER FIELD nmbd003 name="input.a.page1.nmbd003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbd003
            #add-point:ON CHANGE nmbd003 name="input.g.page1.nmbd003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbd004
            #add-point:BEFORE FIELD nmbd004 name="input.b.page1.nmbd004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbd004
            
            #add-point:AFTER FIELD nmbd004 name="input.a.page1.nmbd004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbd004
            #add-point:ON CHANGE nmbd004 name="input.g.page1.nmbd004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmeg007
            
            #add-point:AFTER FIELD nmeg007 name="input.a.page1.nmeg007"
            IF NOT cl_null(g_nmeg_d[l_ac].nmeg007) THEN 
               CALL s_anm_ooef001_chk(g_nmeg_d[l_ac].nmeg007) RETURNING g_sub_success,g_errno     
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = g_errno
                  #160321-00016#41 s983961--add(s)
                  LET g_errparam.replace[1] ='aooi100'
                  LET g_errparam.replace[2] = cl_get_progname('aooi100',g_lang,"2")
                  LET g_errparam.exeprog ='aooi100'
                  #160321-00016#41 s983961--add(e)
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_nmeg_d[l_ac].nmeg007 = g_nmeg_d_t.nmeg007
                  CALL anmt980_nmegsite_desc(g_nmeg_d[l_ac].nmeg007) RETURNING g_nmeg_d[l_ac].nmeg007_desc
                  DISPLAY g_nmeg_d[l_ac].nmeg007_desc TO nmeg007_desc  
                  NEXT FIELD CURRENT
               END IF
               
               #160912-00024#1 add s---
               CALL s_anm_get_site_wc('6',g_nmeg_m.nmegsite,g_nmeg_d[l_ac].nmegdocdt) RETURNING g_site_wc
               IF cl_null(g_site_wc) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'anm-03020' #该资金中心下无可用运营据点!
                  LET g_errparam.extend = g_nmeg_m.nmegsite
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_nmeg_d[l_ac].nmeg007 = g_nmeg_d_t.nmeg007
                  CALL anmt980_nmegsite_desc(g_nmeg_d[l_ac].nmeg007) RETURNING g_nmeg_d[l_ac].nmeg007_desc
                  DISPLAY g_nmeg_d[l_ac].nmeg007_desc TO nmeg007_desc                   
                  NEXT FIELD CURRENT
               END IF                  
               #160912-00024#1 add e---
                  
               #檢查輸入組織代碼是否存在法人組織下的組織範圍內(1.與單頭法人組織法人相同2.屬於資金組織3.user具有拜訪權限)
               IF s_chr_get_index_of(g_site_wc,g_nmeg_d[l_ac].nmeg007,1) = 0 THEN
                  LET g_errno ='anm-02963'
               END IF
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = g_errno
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_nmeg_d[l_ac].nmeg007 = g_nmeg_d_t.nmeg007
                  CALL anmt980_nmegsite_desc(g_nmeg_d[l_ac].nmeg007) RETURNING g_nmeg_d[l_ac].nmeg007_desc
                  DISPLAY g_nmeg_d[l_ac].nmeg007_desc TO nmeg007_desc  
                  NEXT FIELD CURRENT                 
               END IF
               
               SELECT ooef017 INTO g_nmeg007_comp
                 FROM ooef_t
                WHERE ooefent = g_enterprise
                  AND ooef001 = g_nmeg_d[l_ac].nmeg007
                  
               SELECT glaald,glaa001,glaa025 INTO g_glaald,g_glaa001,g_glaa025
                 FROM glaa_t
                WHERE glaaent = g_enterprise
                  AND glaacomp = g_nmeg007_comp
                  AND glaa014 = 'Y'
            END IF 

            CALL anmt980_nmegsite_desc(g_nmeg_d[l_ac].nmeg007) RETURNING g_nmeg_d[l_ac].nmeg007_desc
            DISPLAY g_nmeg_d[l_ac].nmeg007_desc TO nmeg007_desc  
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmeg007
            #add-point:BEFORE FIELD nmeg007 name="input.b.page1.nmeg007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmeg007
            #add-point:ON CHANGE nmeg007 name="input.g.page1.nmeg007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmeg008
            
            #add-point:AFTER FIELD nmeg008 name="input.a.page1.nmeg008"
            IF NOT cl_null(g_nmeg_d[l_ac].nmeg008) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_nmeg_d[l_ac].nmeg008

               #160318-00025#26  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aoo-00011:sub-01302|aooi140|",cl_get_progname("aooi140",g_lang,"2"),"|:EXEPROGaooi140"
               #160318-00025#26  by 07900 --add-end   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooai001") THEN
                  #檢查成功時後續處理
                  SELECT ooef017 INTO g_nmeg007_comp
                    FROM ooef_t
                   WHERE ooefent = g_enterprise
                     AND ooef001 = g_nmeg_d[l_ac].nmeg007
                     
                  SELECT glaald,glaa001,glaa025 INTO g_glaald,g_glaa001,g_glaa025
                    FROM glaa_t
                   WHERE glaaent = g_enterprise
                     AND glaacomp = g_nmeg007_comp
                     AND glaa014 = 'Y'
                  
                  CALL s_aooi160_get_exrate('2',g_glaald,g_nmeg_d[l_ac].nmegdocdt,g_nmeg_d[l_ac].nmeg008,
                                            g_glaa001,0,g_glaa025)
                  RETURNING g_nmeg_d[l_ac].nmeg010
                  CALL s_anmi970_get_exrate('2',g_glaald,g_nmeg_d[l_ac].nmegdocdt,g_nmeg_d[l_ac].nmeg008,
                                            g_nmeg_m.nmeg005,0,'')
                  RETURNING g_nmeg_d[l_ac].nmeg012
                  
                  DISPLAY g_nmeg_d[l_ac].nmeg010 TO nmeg010
                  DISPLAY g_nmeg_d[l_ac].nmeg012 TO nmeg012
               ELSE
                  #檢查失敗時後續處理
                  LET g_nmeg_d[l_ac].nmeg008 = g_nmeg_d_t.nmeg008
                  CALL anmt980_nmeg005_desc(g_nmeg_d[l_ac].nmeg008) RETURNING g_nmeg_d[l_ac].nmeg008_desc
                  DISPLAY g_nmeg_d[l_ac].nmeg008_desc TO nmeg008_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 

            CALL anmt980_nmeg005_desc(g_nmeg_d[l_ac].nmeg008) RETURNING g_nmeg_d[l_ac].nmeg008_desc
            DISPLAY g_nmeg_d[l_ac].nmeg008_desc TO nmeg008_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmeg008
            #add-point:BEFORE FIELD nmeg008 name="input.b.page1.nmeg008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmeg008
            #add-point:ON CHANGE nmeg008 name="input.g.page1.nmeg008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmeg009
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_nmeg_d[l_ac].nmeg009,"0","1","","","azz-00079",1) THEN
               NEXT FIELD nmeg009
            END IF 
 
 
 
            #add-point:AFTER FIELD nmeg009 name="input.a.page1.nmeg009"
            IF NOT cl_null(g_nmeg_d[l_ac].nmeg009) AND g_nmeg_d[l_ac].nmeg009 <> g_nmeg_d_t.nmeg009 THEN 
               LET g_nmeg_d[l_ac].nmeg011 = g_nmeg_d[l_ac].nmeg009 * g_nmeg_d[l_ac].nmeg010
               LET g_nmeg_d[l_ac].nmeg013 = g_nmeg_d[l_ac].nmeg009 * g_nmeg_d[l_ac].nmeg012
               DISPLAY g_nmeg_d[l_ac].nmeg011 TO s_detail1[l_ac].nmeg011
               DISPLAY g_nmeg_d[l_ac].nmeg013 TO s_detail1[l_ac].nmeg013
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmeg009
            #add-point:BEFORE FIELD nmeg009 name="input.b.page1.nmeg009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmeg009
            #add-point:ON CHANGE nmeg009 name="input.g.page1.nmeg009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmeg010
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_nmeg_d[l_ac].nmeg010,"0","1","","","azz-00079",1) THEN
               NEXT FIELD nmeg010
            END IF 
 
 
 
            #add-point:AFTER FIELD nmeg010 name="input.a.page1.nmeg010"
            IF NOT cl_null(g_nmeg_d[l_ac].nmeg010) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmeg010
            #add-point:BEFORE FIELD nmeg010 name="input.b.page1.nmeg010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmeg010
            #add-point:ON CHANGE nmeg010 name="input.g.page1.nmeg010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmeg011
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_nmeg_d[l_ac].nmeg011,"0","1","","","azz-00079",1) THEN
               NEXT FIELD nmeg011
            END IF 
 
 
 
            #add-point:AFTER FIELD nmeg011 name="input.a.page1.nmeg011"
            IF NOT cl_null(g_nmeg_d[l_ac].nmeg011) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmeg011
            #add-point:BEFORE FIELD nmeg011 name="input.b.page1.nmeg011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmeg011
            #add-point:ON CHANGE nmeg011 name="input.g.page1.nmeg011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmeg012
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_nmeg_d[l_ac].nmeg012,"0","1","","","azz-00079",1) THEN
               NEXT FIELD nmeg012
            END IF 
 
 
 
            #add-point:AFTER FIELD nmeg012 name="input.a.page1.nmeg012"
            IF NOT cl_null(g_nmeg_d[l_ac].nmeg012) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmeg012
            #add-point:BEFORE FIELD nmeg012 name="input.b.page1.nmeg012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmeg012
            #add-point:ON CHANGE nmeg012 name="input.g.page1.nmeg012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmeg013
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_nmeg_d[l_ac].nmeg013,"0","1","","","azz-00079",1) THEN
               NEXT FIELD nmeg013
            END IF 
 
 
 
            #add-point:AFTER FIELD nmeg013 name="input.a.page1.nmeg013"
            IF NOT cl_null(g_nmeg_d[l_ac].nmeg013) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmeg013
            #add-point:BEFORE FIELD nmeg013 name="input.b.page1.nmeg013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmeg013
            #add-point:ON CHANGE nmeg013 name="input.g.page1.nmeg013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmeg014
            #add-point:BEFORE FIELD nmeg014 name="input.b.page1.nmeg014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmeg014
            
            #add-point:AFTER FIELD nmeg014 name="input.a.page1.nmeg014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmeg014
            #add-point:ON CHANGE nmeg014 name="input.g.page1.nmeg014"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmeg016
            
            #add-point:AFTER FIELD nmeg016 name="input.a.page1.nmeg016"
            IF NOT cl_null(g_nmeg_d[l_ac].nmeg016) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_nmeg_d[l_ac].nmeg016
               LET g_chkparam.arg2 = g_nmeg_d[l_ac].nmeg008
               LET g_chkparam.arg3 = g_nmeg_d[l_ac].nmeg007
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_nmas002_12") THEN
                  #檢查成功時後續處理
                  #160122-00001#29--add---str--
                  IF NOT s_anmi120_nmll002_chk(g_nmeg_d[l_ac].nmeg016,g_user) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'anm-00574'
                     LET g_errparam.extend = g_nmeg_d[l_ac].nmeg016
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_nmeg_d[l_ac].nmeg016 = g_nmeg_d_t.nmeg016
                     LET g_nmeg_d[l_ac].nmeg016_desc = s_desc_get_nmas002_desc(g_nmeg_d[l_ac].nmeg016)
                     DISPLAY g_nmeg_d[l_ac].nmeg016_desc TO nmeg016_desc
                     NEXT FIELD CURRENT
                  END IF
                  #160122-00001#29--add---end
               ELSE
                  #檢查失敗時後續處理
                  LET g_nmeg_d[l_ac].nmeg016 = g_nmeg_d_t.nmeg016
                  LET g_nmeg_d[l_ac].nmeg016_desc = s_desc_get_nmas002_desc(g_nmeg_d[l_ac].nmeg016)
                  DISPLAY g_nmeg_d[l_ac].nmeg016_desc TO nmeg016_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 

            LET g_nmeg_d[l_ac].nmeg016_desc = s_desc_get_nmas002_desc(g_nmeg_d[l_ac].nmeg016)
            DISPLAY g_nmeg_d[l_ac].nmeg016_desc TO nmeg016_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmeg016
            #add-point:BEFORE FIELD nmeg016 name="input.b.page1.nmeg016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmeg016
            #add-point:ON CHANGE nmeg016 name="input.g.page1.nmeg016"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmeg015
            
            #add-point:AFTER FIELD nmeg015 name="input.a.page1.nmeg015"
            IF NOT cl_null(g_nmeg_d[l_ac].nmeg015) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_nmeg_d[l_ac].nmeg015

                #160318-00025#26  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="apm-00044:sub-01302|apmm100|",cl_get_progname("apmm100",g_lang,"2"),"|:EXEPROGapmm100"
               #160318-00025#26  by 07900 --add-end   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pmaa001_2") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  LET g_nmeg_d[l_ac].nmeg015 = g_nmeg_d_t.nmeg015
                  CALL anmt980_nmeg015_desc()
                  NEXT FIELD CURRENT
               END IF


            END IF 
            
            CALL anmt980_nmeg015_desc()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmeg015
            #add-point:BEFORE FIELD nmeg015 name="input.b.page1.nmeg015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmeg015
            #add-point:ON CHANGE nmeg015 name="input.g.page1.nmeg015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmeg017
            #add-point:BEFORE FIELD nmeg017 name="input.b.page1.nmeg017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmeg017
            
            #add-point:AFTER FIELD nmeg017 name="input.a.page1.nmeg017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmeg017
            #add-point:ON CHANGE nmeg017 name="input.g.page1.nmeg017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmegstus
            #add-point:BEFORE FIELD nmegstus name="input.b.page1.nmegstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmegstus
            
            #add-point:AFTER FIELD nmegstus name="input.a.page1.nmegstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmegstus
            #add-point:ON CHANGE nmegstus name="input.g.page1.nmegstus"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.nmegseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmegseq
            #add-point:ON ACTION controlp INFIELD nmegseq name="input.c.page1.nmegseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmegdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmegdocdt
            #add-point:ON ACTION controlp INFIELD nmegdocdt name="input.c.page1.nmegdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmeg002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmeg002
            #add-point:ON ACTION controlp INFIELD nmeg002 name="input.c.page1.nmeg002"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmeg_d[l_ac].nmeg002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_nmeg_m.nmeg006


            CALL q_nmbd002()                                #呼叫開窗

            LET g_nmeg_d[l_ac].nmeg002 = g_qryparam.return1              
            CALL anmt980_nmeg002_desc()
            DISPLAY g_nmeg_d[l_ac].nmeg002 TO nmeg002              #

            NEXT FIELD nmeg002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbd003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbd003
            #add-point:ON ACTION controlp INFIELD nmbd003 name="input.c.page1.nmbd003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbd004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbd004
            #add-point:ON ACTION controlp INFIELD nmbd004 name="input.c.page1.nmbd004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmeg007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmeg007
            #add-point:ON ACTION controlp INFIELD nmeg007 name="input.c.page1.nmeg007"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmeg_d[l_ac].nmeg007             #給予default值
            #CALL s_anm_get_site_wc('6',g_nmeg_m.nmegsite,g_nmeg_d[l_ac].nmegdocdt) RETURNING g_site_wc #160912-00024#1 add #161006-00005#37 mark
            CALL s_anm_get_site_wc('8',g_nmeg_m.nmegsite,g_nmeg_d[l_ac].nmegdocdt) RETURNING g_site_wc #161006-00005#37 add
            CALL s_fin_get_wc_str(g_site_wc) RETURNING l_origin_str                              #160912-00024#1 add
            LET g_qryparam.where = " ooef001 IN ",l_origin_str  #160912-00024#1 add
            #LET g_qryparam.where = " ooef001 IN ",g_site_wc  #160912-00024#1 add
            #給予arg
            LET g_qryparam.arg1 = "" #

           
            CALL q_ooef001()                                #呼叫開窗

            LET g_nmeg_d[l_ac].nmeg007 = g_qryparam.return1              
            CALL anmt980_nmegsite_desc(g_nmeg_d[l_ac].nmeg007) RETURNING g_nmeg_d[l_ac].nmeg007_desc
            DISPLAY g_nmeg_d[l_ac].nmeg007 TO nmeg007              #
            DISPLAY g_nmeg_d[l_ac].nmeg007_desc TO nmeg007_desc  
            NEXT FIELD nmeg007                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.nmeg008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmeg008
            #add-point:ON ACTION controlp INFIELD nmeg008 name="input.c.page1.nmeg008"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmeg_d[l_ac].nmeg008             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #


            CALL q_ooai001()                                #呼叫開窗

            LET g_nmeg_d[l_ac].nmeg008 = g_qryparam.return1              
            CALL anmt980_nmeg005_desc(g_nmeg_d[l_ac].nmeg008) RETURNING g_nmeg_d[l_ac].nmeg008_desc
            DISPLAY g_nmeg_d[l_ac].nmeg008_desc TO nmeg008_desc
            DISPLAY g_nmeg_d[l_ac].nmeg008 TO nmeg008              #

            NEXT FIELD nmeg008                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.nmeg009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmeg009
            #add-point:ON ACTION controlp INFIELD nmeg009 name="input.c.page1.nmeg009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmeg010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmeg010
            #add-point:ON ACTION controlp INFIELD nmeg010 name="input.c.page1.nmeg010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmeg011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmeg011
            #add-point:ON ACTION controlp INFIELD nmeg011 name="input.c.page1.nmeg011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmeg012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmeg012
            #add-point:ON ACTION controlp INFIELD nmeg012 name="input.c.page1.nmeg012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmeg013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmeg013
            #add-point:ON ACTION controlp INFIELD nmeg013 name="input.c.page1.nmeg013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmeg014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmeg014
            #add-point:ON ACTION controlp INFIELD nmeg014 name="input.c.page1.nmeg014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmeg016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmeg016
            #add-point:ON ACTION controlp INFIELD nmeg016 name="input.c.page1.nmeg016"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmeg_d[l_ac].nmeg016             #給予default值
            LET g_qryparam.where = "     nmaa002 = '",g_nmeg_d[l_ac].nmeg007,"'",
                                   " AND nmas003 = '",g_nmeg_d[l_ac].nmeg008,"'"
                                  #160122-00001#29--add---str--
                                  ," AND nmas002 IN (",g_sql_bank,")"
                                  #160122-00001#29--add---end

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_nmas_01()                                #呼叫開窗

            LET g_nmeg_d[l_ac].nmeg016 = g_qryparam.return1              
            LET g_nmeg_d[l_ac].nmeg016_desc = s_desc_get_nmas002_desc(g_nmeg_d[l_ac].nmeg016)
            DISPLAY g_nmeg_d[l_ac].nmeg016 TO nmeg016              #
            DISPLAY g_nmeg_d[l_ac].nmeg016_desc TO nmeg016_desc

            NEXT FIELD nmeg016                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.nmeg015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmeg015
            #add-point:ON ACTION controlp INFIELD nmeg015 name="input.c.page1.nmeg015"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmeg_d[l_ac].nmeg015             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_pmaa001_25()                                #呼叫開窗

            LET g_nmeg_d[l_ac].nmeg015 = g_qryparam.return1              
            CALL anmt980_nmeg015_desc()
            DISPLAY g_nmeg_d[l_ac].nmeg015 TO nmeg015              #

            NEXT FIELD nmeg015                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.nmeg017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmeg017
            #add-point:ON ACTION controlp INFIELD nmeg017 name="input.c.page1.nmeg017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmegstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmegstus
            #add-point:ON ACTION controlp INFIELD nmegstus name="input.c.page1.nmegstus"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_nmeg_d[l_ac].* = g_nmeg_d_t.*
               CLOSE anmt980_bcl
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
               LET g_errparam.extend = g_nmeg_d[l_ac].nmegseq 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_nmeg_d[l_ac].* = g_nmeg_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               LET g_nmeg2_d[l_ac].nmegmodid = g_user 
LET g_nmeg2_d[l_ac].nmegmoddt = cl_get_current()
LET g_nmeg2_d[l_ac].nmegmodid_desc = cl_get_username(g_nmeg2_d[l_ac].nmegmodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
         
               #將遮罩欄位還原
               CALL anmt980_nmeg_t_mask_restore('restore_mask_o')
         
               UPDATE nmeg_t SET (nmeg001,nmegseq,nmegdocdt,nmeg002,nmeg007,nmeg008,nmeg009,nmeg010, 
                   nmeg011,nmeg012,nmeg013,nmeg014,nmeg016,nmeg015,nmeg017,nmegstus,nmegownid,nmegowndp, 
                   nmegcrtid,nmegcrtdp,nmegcrtdt,nmegmodid,nmegmoddt) = (g_nmeg_m.nmeg001,g_nmeg_d[l_ac].nmegseq, 
                   g_nmeg_d[l_ac].nmegdocdt,g_nmeg_d[l_ac].nmeg002,g_nmeg_d[l_ac].nmeg007,g_nmeg_d[l_ac].nmeg008, 
                   g_nmeg_d[l_ac].nmeg009,g_nmeg_d[l_ac].nmeg010,g_nmeg_d[l_ac].nmeg011,g_nmeg_d[l_ac].nmeg012, 
                   g_nmeg_d[l_ac].nmeg013,g_nmeg_d[l_ac].nmeg014,g_nmeg_d[l_ac].nmeg016,g_nmeg_d[l_ac].nmeg015, 
                   g_nmeg_d[l_ac].nmeg017,g_nmeg_d[l_ac].nmegstus,g_nmeg2_d[l_ac].nmegownid,g_nmeg2_d[l_ac].nmegowndp, 
                   g_nmeg2_d[l_ac].nmegcrtid,g_nmeg2_d[l_ac].nmegcrtdp,g_nmeg2_d[l_ac].nmegcrtdt,g_nmeg2_d[l_ac].nmegmodid, 
                   g_nmeg2_d[l_ac].nmegmoddt)
                WHERE nmegent = g_enterprise AND nmeg001 = g_nmeg_m.nmeg001 
 
                 AND nmegseq = g_nmeg_d_t.nmegseq #項次   
 
                 
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "nmeg_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "nmeg_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_nmeg_m.nmeg001
               LET gs_keys_bak[1] = g_nmeg001_t
               LET gs_keys[2] = g_nmeg_d[g_detail_idx].nmegseq
               LET gs_keys_bak[2] = g_nmeg_d_t.nmegseq
               CALL anmt980_update_b('nmeg_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_nmeg_m),util.JSON.stringify(g_nmeg_d_t)
                     LET g_log2 = util.JSON.stringify(g_nmeg_m),util.JSON.stringify(g_nmeg_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL anmt980_nmeg_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_nmeg_m.nmeg001
 
               LET ls_keys[ls_keys.getLength()+1] = g_nmeg_d_t.nmegseq
 
               CALL anmt980_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE anmt980_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_nmeg_d[l_ac].* = g_nmeg_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE anmt980_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_nmeg_d.getLength() = 0 THEN
               NEXT FIELD nmegseq
            END IF
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_nmeg_d[li_reproduce_target].* = g_nmeg_d[li_reproduce].*
               LET g_nmeg2_d[li_reproduce_target].* = g_nmeg2_d[li_reproduce].*
 
               LET g_nmeg_d[li_reproduce_target].nmegseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_nmeg_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_nmeg_d.getLength()+1
            END IF
            
      END INPUT
 
 
      
      DISPLAY ARRAY g_nmeg2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
      
         BEFORE ROW
            CALL anmt980_b_fill(g_wc2) #test 
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_page = 2
            CALL anmt980_idx_chk()
            CALL anmt980_ui_detailshow()
        
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
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)      
         CALL DIALOG.setCurrentRow("s_detail2",g_detail_idx)
         
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD nmegsite
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD nmegseq
               WHEN "s_detail2"
                  NEXT FIELD nmegseq_2
 
            END CASE
         END IF
         #end add-point 
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)      
         CALL DIALOG.setCurrentRow("s_detail2",g_detail_idx)
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD nmeg001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD nmegseq
               WHEN "s_detail2"
                  NEXT FIELD nmegseq_2
 
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
 
{<section id="anmt980.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION anmt980_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   SELECT ooef017 INTO g_ooef017 
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_nmeg_m.nmegsite
      
   #CALL s_anm_get_site_wc('6',g_ooef017,g_today) RETURNING g_site_wc       #160912-00024#1 
   CALL s_anm_get_site_wc('6',g_nmeg_m.nmegsite,g_today) RETURNING g_site_wc #160912-00024#1 
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL anmt980_b_fill(g_wc2) #第一階單身填充
      CALL anmt980_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL anmt980_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_nmeg_m.nmegsite,g_nmeg_m.nmegsite_desc,g_nmeg_m.nmeg001,g_nmeg_m.nmeg003,g_nmeg_m.nmeg004, 
       g_nmeg_m.nmeg005,g_nmeg_m.nmeg005_desc,g_nmeg_m.nmeg006
 
   CALL anmt980_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
   
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="anmt980.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION anmt980_ref_show()
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
   FOR l_ac = 1 TO g_nmeg_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_nmeg2_d.getLength()
      #add-point:ref_show段d2_reference name="ref_show.body2.reference"
      
      #end add-point
   END FOR
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="anmt980.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION anmt980_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE nmeg_t.nmeg001 
   DEFINE l_oldno     LIKE nmeg_t.nmeg001 
 
   DEFINE l_master    RECORD LIKE nmeg_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE nmeg_t.* #此變數樣板目前無使用
 
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
 
   IF g_nmeg_m.nmeg001 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_nmeg001_t = g_nmeg_m.nmeg001
 
   
   LET g_nmeg_m.nmeg001 = ""
 
   LET g_master_insert = FALSE
   CALL anmt980_set_entry('a')
   CALL anmt980_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #清空key欄位的desc
   
   
   CALL anmt980_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_nmeg_m.* TO NULL
      INITIALIZE g_nmeg_d TO NULL
      INITIALIZE g_nmeg2_d TO NULL
 
      CALL anmt980_show()
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
   CALL anmt980_set_act_visible()
   CALL anmt980_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_nmeg001_t = g_nmeg_m.nmeg001
 
   
   #組合新增資料的條件
   LET g_add_browse = " nmegent = " ||g_enterprise|| " AND",
                      " nmeg001 = '", g_nmeg_m.nmeg001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL anmt980_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL anmt980_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL anmt980_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="anmt980.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION anmt980_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE nmeg_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE anmt980_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM nmeg_t
    WHERE nmegent = g_enterprise AND nmeg001 = g_nmeg001_t
 
       INTO TEMP anmt980_detail
   
   #將key修正為調整後   
   UPDATE anmt980_detail 
      #更新key欄位
      SET nmeg001 = g_nmeg_m.nmeg001
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
       , nmegownid = g_user 
       , nmegowndp = g_dept
       , nmegcrtid = g_user
       , nmegcrtdp = g_dept 
       , nmegcrtdt = ld_date
       , nmegmodid = g_user
       , nmegmoddt = ld_date
      #, nmegstus = "Y" 
 
 
 
                                       
   #將資料塞回原table   
   INSERT INTO nmeg_t SELECT * FROM anmt980_detail
   
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
   DROP TABLE anmt980_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_nmeg001_t = g_nmeg_m.nmeg001
 
   
   DROP TABLE anmt980_detail
   
END FUNCTION
 
{</section>}
 
{<section id="anmt980.delete" >}
#+ 資料刪除
PRIVATE FUNCTION anmt980_delete()
   #add-point:delete段define name="delete.define_customerization"
   
   #end add-point
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE l_n              LIKE type_t.num5 #160122-00001#29 add
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_nmeg_m.nmeg001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN anmt980_cl USING g_enterprise,g_nmeg_m.nmeg001
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN anmt980_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE anmt980_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE anmt980_master_referesh USING g_nmeg_m.nmeg001 INTO g_nmeg_m.nmegsite,g_nmeg_m.nmeg001,g_nmeg_m.nmeg003, 
       g_nmeg_m.nmeg004,g_nmeg_m.nmeg005,g_nmeg_m.nmeg006,g_nmeg_m.nmegsite_desc,g_nmeg_m.nmeg005_desc 
 
   
   #遮罩相關處理
   LET g_nmeg_m_mask_o.* =  g_nmeg_m.*
   CALL anmt980_nmeg_t_mask()
   LET g_nmeg_m_mask_n.* =  g_nmeg_m.*
   
   CALL anmt980_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL anmt980_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
      #160122-00001#29--add--str--
      LET l_n = 0 
      #單身存在當前用戶沒有權限的交易帳戶編碼
      SELECT COUNT(*) INTO l_n FROM nmeg_t
       WHERE nmegent = g_enterprise AND nmeg001 = g_nmeg_m.nmeg001
         AND nmeg016 NOT IN( SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = g_enterprise AND nmll002 = g_user AND nmllstus='Y')
         AND nmeg016 NOT IN( SELECT UNIQUE nmlm001 FROM nmlm_t WHERE nmlment = g_enterprise AND nmlm002 = g_dept AND nmlmstus='Y')
         AND TRIM(nmeg016) IS NOT NULL
      IF l_n > 0 THEN
         IF NOT cl_ask_confirm('anm-00395') THEN
            CLOSE anmt980_cl
            CALL s_transaction_end('N','0')
            RETURN
         END IF
      END IF
      #160122-00001#29--add--end
      #end add-point
      
      DELETE FROM nmeg_t WHERE nmegent = g_enterprise AND nmeg001 = g_nmeg_m.nmeg001
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "nmeg_t:",SQLERRMESSAGE 
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
      #   CLOSE anmt980_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_nmeg_d.clear() 
      CALL g_nmeg2_d.clear()       
 
     
      CALL anmt980_ui_browser_refresh()  
      #CALL anmt980_ui_headershow()  
      #CALL anmt980_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL anmt980_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL anmt980_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE anmt980_cl
 
   #功能已完成,通報訊息中心
   CALL anmt980_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="anmt980.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION anmt980_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #先清空單身變數內容
   CALL g_nmeg_d.clear()
   CALL g_nmeg2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT nmegseq,nmegdocdt,nmeg002,nmeg007,nmeg008,nmeg009,nmeg010,nmeg011,nmeg012, 
       nmeg013,nmeg014,nmeg016,nmeg015,nmeg017,nmegstus,nmegseq,nmegownid,nmegowndp,nmegcrtid,nmegcrtdp, 
       nmegcrtdt,nmegmodid,nmegmoddt,t1.nmbdl004 ,t2.ooail003 ,t3.ooail003 ,t4.nmaal003 ,t5.pmaal004 , 
       t6.ooag011 ,t7.ooefl003 ,t8.ooag011 ,t9.ooefl003 ,t10.ooag011 FROM nmeg_t",   
               "",
               
                              " LEFT JOIN nmbdl_t t1 ON t1.nmbdlent="||g_enterprise||" AND t1.nmbdl001=nmeg006 AND t1.nmbdl002=nmeg002 AND t1.nmbdl003='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t2 ON t2.ooailent="||g_enterprise||" AND t2.ooail001=nmeg007 AND t2.ooail002='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t3 ON t3.ooailent="||g_enterprise||" AND t3.ooail001=nmeg008 AND t3.ooail002='"||g_dlang||"' ",
               " LEFT JOIN nmaal_t t4 ON t4.nmaalent="||g_enterprise||" AND t4.nmaal001=nmeg016 AND t4.nmaal002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t5 ON t5.pmaalent="||g_enterprise||" AND t5.pmaal001=nmeg015 AND t5.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=nmegownid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=nmegowndp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=nmegcrtid  ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent="||g_enterprise||" AND t9.ooefl001=nmegcrtdp AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=nmegmodid  ",
 
               " WHERE nmegent= ? AND nmeg001=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("nmeg_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   #160122-00001#29--add--str--
   LET g_sql=g_sql," AND nmeg016 IN (",g_sql_bank,")"
   #160122-00001#29--add--end
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF anmt980_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY nmeg_t.nmegseq"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
         
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE anmt980_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR anmt980_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_nmeg_m.nmeg001   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_nmeg_m.nmeg001 INTO g_nmeg_d[l_ac].nmegseq,g_nmeg_d[l_ac].nmegdocdt, 
          g_nmeg_d[l_ac].nmeg002,g_nmeg_d[l_ac].nmeg007,g_nmeg_d[l_ac].nmeg008,g_nmeg_d[l_ac].nmeg009, 
          g_nmeg_d[l_ac].nmeg010,g_nmeg_d[l_ac].nmeg011,g_nmeg_d[l_ac].nmeg012,g_nmeg_d[l_ac].nmeg013, 
          g_nmeg_d[l_ac].nmeg014,g_nmeg_d[l_ac].nmeg016,g_nmeg_d[l_ac].nmeg015,g_nmeg_d[l_ac].nmeg017, 
          g_nmeg_d[l_ac].nmegstus,g_nmeg2_d[l_ac].nmegseq,g_nmeg2_d[l_ac].nmegownid,g_nmeg2_d[l_ac].nmegowndp, 
          g_nmeg2_d[l_ac].nmegcrtid,g_nmeg2_d[l_ac].nmegcrtdp,g_nmeg2_d[l_ac].nmegcrtdt,g_nmeg2_d[l_ac].nmegmodid, 
          g_nmeg2_d[l_ac].nmegmoddt,g_nmeg_d[l_ac].nmeg002_desc,g_nmeg_d[l_ac].nmeg007_desc,g_nmeg_d[l_ac].nmeg008_desc, 
          g_nmeg_d[l_ac].nmeg016_desc,g_nmeg_d[l_ac].nmeg015_desc,g_nmeg2_d[l_ac].nmegownid_desc,g_nmeg2_d[l_ac].nmegowndp_desc, 
          g_nmeg2_d[l_ac].nmegcrtid_desc,g_nmeg2_d[l_ac].nmegcrtdp_desc,g_nmeg2_d[l_ac].nmegmodid_desc  
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
         CALL anmt980_nmeg002_desc()
         CALL anmt980_nmegsite_desc(g_nmeg_d[l_ac].nmeg007) RETURNING g_nmeg_d[l_ac].nmeg007_desc
         DISPLAY g_nmeg_d[l_ac].nmeg007_desc TO nmeg007_desc 
         CALL anmt980_nmeg005_desc(g_nmeg_d[l_ac].nmeg008) RETURNING g_nmeg_d[l_ac].nmeg008_desc
         DISPLAY g_nmeg_d[l_ac].nmeg008_desc TO nmeg008_desc
         LET g_nmeg_d[l_ac].nmeg016_desc = s_desc_get_nmas002_desc(g_nmeg_d[l_ac].nmeg016)
         DISPLAY g_nmeg_d[l_ac].nmeg016_desc TO nmeg016_desc
         CALL anmt980_nmeg015_desc()
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
 
            CALL g_nmeg_d.deleteElement(g_nmeg_d.getLength())
      CALL g_nmeg2_d.deleteElement(g_nmeg2_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
   
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_nmeg_d.getLength()
      LET g_nmeg_d_mask_o[l_ac].* =  g_nmeg_d[l_ac].*
      CALL anmt980_nmeg_t_mask()
      LET g_nmeg_d_mask_n[l_ac].* =  g_nmeg_d[l_ac].*
   END FOR
   
   LET g_nmeg2_d_mask_o.* =  g_nmeg2_d.*
   FOR l_ac = 1 TO g_nmeg2_d.getLength()
      LET g_nmeg2_d_mask_o[l_ac].* =  g_nmeg2_d[l_ac].*
      CALL anmt980_nmeg_t_mask()
      LET g_nmeg2_d_mask_n[l_ac].* =  g_nmeg2_d[l_ac].*
   END FOR
 
 
   FREE anmt980_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="anmt980.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION anmt980_idx_chk()
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
      IF g_detail_idx > g_nmeg_d.getLength() THEN
         LET g_detail_idx = g_nmeg_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_nmeg_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_nmeg_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_nmeg2_d.getLength() THEN
         LET g_detail_idx = g_nmeg2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_nmeg2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_nmeg2_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="anmt980.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION anmt980_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_nmeg_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="anmt980.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION anmt980_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   
   #end add-point
   
   DELETE FROM nmeg_t
    WHERE nmegent = g_enterprise AND nmeg001 = g_nmeg_m.nmeg001 AND
 
          nmegseq = g_nmeg_d_t.nmegseq
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
 
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "nmeg_t:",SQLERRMESSAGE 
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
 
{<section id="anmt980.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION anmt980_delete_b(ps_table,ps_keys_bak,ps_page)
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
 
{<section id="anmt980.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION anmt980_insert_b(ps_table,ps_keys,ps_page)
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
 
{<section id="anmt980.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION anmt980_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
 
{<section id="anmt980.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION anmt980_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_nmeg_d[l_ac].nmegseq = g_nmeg_d_t.nmegseq 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="anmt980.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION anmt980_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="anmt980.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION anmt980_lock_b(ps_table,ps_page)
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
   #CALL anmt980_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="anmt980.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION anmt980_unlock_b(ps_table,ps_page)
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
 
{<section id="anmt980.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION anmt980_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("nmeg001",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   IF g_nmeg_m.nmeg001 = 'ALL' THEN 
      CALL cl_set_comp_entry("nmeg003,nmeg004,nmeg005,nmeg006",TRUE)
      CALL cl_set_comp_required("nmeg003,nmeg004,nmeg005,nmeg006",TRUE)
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="anmt980.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION anmt980_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("nmeg001",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF g_nmeg_m.nmeg001 <> 'ALL' THEN 
      CALL cl_set_comp_entry("nmeg003,nmeg004,nmeg005,nmeg006",FALSE)
      CALL cl_set_comp_required("nmeg003,nmeg004,nmeg005,nmeg006",FALSE)
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="anmt980.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION anmt980_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="anmt980.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION anmt980_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="anmt980.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION anmt980_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="anmt980.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION anmt980_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="anmt980.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION anmt980_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="anmt980.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION anmt980_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="anmt980.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION anmt980_default_search()
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
      LET ls_wc = ls_wc, " nmeg001 = '", g_argv[01], "' AND "
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
 
{<section id="anmt980.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION anmt980_fill_chk(ps_idx)
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
 
{<section id="anmt980.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION anmt980_modify_detail_chk(ps_record)
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
         LET ls_return = "nmegseq"
      WHEN "s_detail2"
         LET ls_return = "nmegseq_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="anmt980.mask_functions" >}
&include "erp/anm/anmt980_mask.4gl"
 
{</section>}
 
{<section id="anmt980.state_change" >}
    
 
{</section>}
 
{<section id="anmt980.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION anmt980_set_pk_array()
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
   LET g_pk_array[1].values = g_nmeg_m.nmeg001
   LET g_pk_array[1].column = 'nmeg001'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="anmt980.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION anmt980_msgcentre_notify(lc_state)
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
   CALL anmt980_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_nmeg_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="anmt980.other_function" readonly="Y" >}
# 营运据点说明
PRIVATE FUNCTION anmt980_nmegsite_desc(p_site)
   DEFINE p_site          LIKE nmeg_t.nmegsite
   DEFINE r_desc          LIKE type_t.chr80
   
   LET r_desc = ''
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_site
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_desc = '', g_rtn_fields[1] , ''

   RETURN r_desc
END FUNCTION
#
PRIVATE FUNCTION anmt980_repeat_chk(p_date)
   DEFINE p_date            LIKE nmeg_t.nmeg003
   DEFINE l_sql             STRING
   DEFINE l_nmeg003         LIKE nmeg_t.nmeg003
   DEFINE l_nmeg004         LIKE nmeg_t.nmeg004
   DEFINE l_sta             LIKE nmeg_t.nmeg003
   DEFINE l_end             LIKE nmeg_t.nmeg004
   DEFINE l_date            LIKE nmeg_t.nmeg003
   DEFINE p_err             LIKE type_t.num5
   DEFINE p_err_code        STRING
   
   LET p_err = FALSE
   LET p_err_code = ""

   IF NOT p_err THEN   # 表示無錯誤
      LET l_date = p_date         
      LET l_sql = " SELECT nmeg003,nmeg004 FROM nmeg_t",
                  "    WHERE nmegent = ",g_enterprise,
                  "      AND nmeg001 = '",g_nmeg_m.nmeg001,"'"
                  
     
      PREPARE anmt980_repeat FROM l_sql      
      DECLARE anmt980_repeat_cs CURSOR FOR anmt980_repeat
      FOREACH anmt980_repeat_cs INTO l_nmeg003, l_nmeg004 
         LET l_sta = l_nmeg003
         LET l_end = l_nmeg004
         IF (l_date > l_sta AND l_date < l_end) OR l_date = l_sta OR l_date = l_end THEN         
            LET p_err = TRUE
            LET p_err_code = 'anm-02960'
         END IF
      END FOREACH
   END IF

   RETURN p_err,p_err_code
END FUNCTION
# 币别说明
PRIVATE FUNCTION anmt980_nmeg005_desc(p_nmeg005)
   DEFINE p_nmeg005          LIKE nmeg_t.nmeg001
   DEFINE r_desc             LIKE type_t.chr80
   
   LET r_desc = ''
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_nmeg005
   CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_desc = '', g_rtn_fields[1] , ''

   RETURN r_desc
END FUNCTION
# 收支项目说明
PRIVATE FUNCTION anmt980_nmeg002_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_nmeg_m.nmeg006
   LET g_ref_fields[2] = g_nmeg_d[l_ac].nmeg002
   CALL ap_ref_array2(g_ref_fields,"SELECT nmbdl004 FROM nmbdl_t WHERE nmbdlent='"||g_enterprise||"' AND nmbdl001=? AND nmbdl002=? AND nmbdl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmeg_d[l_ac].nmeg002_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_nmeg_d[l_ac].nmeg002_desc
   
   SELECT nmbd003,nmbd004 INTO g_nmeg_d[l_ac].nmbd003,g_nmeg_d[l_ac].nmbd004
     FROM nmbd_t
    WHERE nmbdent = g_enterprise
      AND nmbd001 = g_nmeg_m.nmeg006
      AND nmbd002 = g_nmeg_d[l_ac].nmeg002
      
   DISPLAY g_nmeg_d[l_ac].nmbd003 TO nmbd003
   DISPLAY g_nmeg_d[l_ac].nmbd004 TO nmbd004
END FUNCTION
# 交易对象名称
PRIVATE FUNCTION anmt980_nmeg015_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_nmeg_d[l_ac].nmeg015
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmeg_d[l_ac].nmeg015_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_nmeg_d[l_ac].nmeg015_desc
END FUNCTION

 
{</section>}
 
