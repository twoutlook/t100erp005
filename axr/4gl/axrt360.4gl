#該程式未解開Section, 採用最新樣板產出!
{<section id="axrt360.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2017-02-13 10:42:25), PR版次:0002(2017-02-15 10:27:51)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: axrt360
#+ Description: 收款條件變更申請單作業
#+ Creator....: 02114(2017-02-03 15:33:09)
#+ Modifier...: 02114 -SD/PR- 02114
 
{</section>}
 
{<section id="axrt360.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#Memos
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
PRIVATE type type_g_xrcg_m        RECORD
       xrcgcomp LIKE xrcg_t.xrcgcomp, 
   xrcgcomp_desc LIKE type_t.chr80, 
   xrcgld LIKE xrcg_t.xrcgld, 
   xrcgld_desc LIKE type_t.chr80, 
   xrcgsite LIKE xrcg_t.xrcgsite, 
   xrcgsite_desc LIKE type_t.chr80, 
   xrcgdocno LIKE xrcg_t.xrcgdocno, 
   xrcgdocdt LIKE xrcg_t.xrcgdocdt, 
   xrcg001 LIKE xrcg_t.xrcg001, 
   xrcg001_desc LIKE type_t.chr80, 
   xrcg010 LIKE xrcg_t.xrcg010, 
   xrcg010_desc LIKE type_t.chr80, 
   xrcgstus LIKE xrcg_t.xrcgstus
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_xrcg_d        RECORD
       xrcgseq LIKE xrcg_t.xrcgseq, 
   xrcg002 LIKE xrcg_t.xrcg002, 
   xrca001 LIKE type_t.chr10, 
   xrcg003 LIKE xrcg_t.xrcg003, 
   xrcg004 LIKE xrcg_t.xrcg004, 
   xrcg004_desc LIKE type_t.chr500, 
   xrcg005 LIKE xrcg_t.xrcg005, 
   xrcg005_desc LIKE type_t.chr500, 
   xrcg006 LIKE xrcg_t.xrcg006, 
   xrcg007 LIKE xrcg_t.xrcg007, 
   xrcg008 LIKE xrcg_t.xrcg008, 
   xrcg009 LIKE xrcg_t.xrcg009
       END RECORD
PRIVATE TYPE type_g_xrcg2_d RECORD
       xrcgseq LIKE xrcg_t.xrcgseq, 
   xrcgownid LIKE xrcg_t.xrcgownid, 
   xrcgownid_desc LIKE type_t.chr500, 
   xrcgowndp LIKE xrcg_t.xrcgowndp, 
   xrcgowndp_desc LIKE type_t.chr500, 
   xrcgcrtid LIKE xrcg_t.xrcgcrtid, 
   xrcgcrtid_desc LIKE type_t.chr500, 
   xrcgcrtdp LIKE xrcg_t.xrcgcrtdp, 
   xrcgcrtdp_desc LIKE type_t.chr500, 
   xrcgcrtdt DATETIME YEAR TO SECOND, 
   xrcgmodid LIKE xrcg_t.xrcgmodid, 
   xrcgmodid_desc LIKE type_t.chr500, 
   xrcgmoddt DATETIME YEAR TO SECOND, 
   xrcgcnfid LIKE xrcg_t.xrcgcnfid, 
   xrcgcnfid_desc LIKE type_t.chr500, 
   xrcgcnfdt DATETIME YEAR TO SECOND, 
   xrcgpstid LIKE xrcg_t.xrcgpstid, 
   xrcgpstid_desc LIKE type_t.chr500, 
   xrcgpstdt LIKE xrcg_t.xrcgpstdt
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_sql_ctrl         STRING
DEFINE g_comp_str         STRING
#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_xrcg_m          type_g_xrcg_m
DEFINE g_xrcg_m_t        type_g_xrcg_m
DEFINE g_xrcg_m_o        type_g_xrcg_m
DEFINE g_xrcg_m_mask_o   type_g_xrcg_m #轉換遮罩前資料
DEFINE g_xrcg_m_mask_n   type_g_xrcg_m #轉換遮罩後資料
 
   DEFINE g_xrcgld_t LIKE xrcg_t.xrcgld
DEFINE g_xrcgdocno_t LIKE xrcg_t.xrcgdocno
 
 
DEFINE g_xrcg_d          DYNAMIC ARRAY OF type_g_xrcg_d
DEFINE g_xrcg_d_t        type_g_xrcg_d
DEFINE g_xrcg_d_o        type_g_xrcg_d
DEFINE g_xrcg_d_mask_o   DYNAMIC ARRAY OF type_g_xrcg_d #轉換遮罩前資料
DEFINE g_xrcg_d_mask_n   DYNAMIC ARRAY OF type_g_xrcg_d #轉換遮罩後資料
DEFINE g_xrcg2_d   DYNAMIC ARRAY OF type_g_xrcg2_d
DEFINE g_xrcg2_d_t type_g_xrcg2_d
DEFINE g_xrcg2_d_o type_g_xrcg2_d
DEFINE g_xrcg2_d_mask_o   DYNAMIC ARRAY OF type_g_xrcg2_d #轉換遮罩前資料
DEFINE g_xrcg2_d_mask_n   DYNAMIC ARRAY OF type_g_xrcg2_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_xrcgld LIKE xrcg_t.xrcgld,
      b_xrcgdocno LIKE xrcg_t.xrcgdocno
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
 
{<section id="axrt360.main" >}
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
   CALL cl_ap_init("axr","")
 
   #add-point:作業初始化 name="main.init"
   LET g_sql_ctrl = NULL
   
   SELECT ooef017 INTO g_xrcg_m.xrcgcomp
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
      AND ooefstus = 'Y'
   
   CALL s_control_get_customer_sql_pmab('2',g_site,g_user,g_dept,'',g_xrcg_m.xrcgcomp) RETURNING g_sub_success,g_sql_ctrl
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT xrcgcomp,'',xrcgld,'',xrcgsite,'',xrcgdocno,xrcgdocdt,xrcg001,'',xrcg010, 
       '',xrcgstus", 
                      " FROM xrcg_t",
                      " WHERE xrcgent= ? AND xrcgld=? AND xrcgdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axrt360_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.xrcgcomp,t0.xrcgld,t0.xrcgsite,t0.xrcgdocno,t0.xrcgdocdt,t0.xrcg001, 
       t0.xrcg010,t0.xrcgstus,t1.ooefl003 ,t2.glaal002 ,t3.ooefl003 ,t4.pmaal004 ,t5.ooag011",
               " FROM xrcg_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.xrcgcomp AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN glaal_t t2 ON t2.glaalent="||g_enterprise||" AND t2.glaalld=t0.xrcgld AND t2.glaal001='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.xrcgsite AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t4 ON t4.pmaalent="||g_enterprise||" AND t4.pmaal001=t0.xrcg001 AND t4.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.xrcg010  ",
 
               " WHERE t0.xrcgent = " ||g_enterprise|| " AND t0.xrcgld = ? AND t0.xrcgdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axrt360_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axrt360 WITH FORM cl_ap_formpath("axr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axrt360_init()   
 
      #進入選單 Menu (="N")
      CALL axrt360_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axrt360
      
   END IF 
   
   CLOSE axrt360_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axrt360.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axrt360_init()
   #add-point:init段define name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill = "Y"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
      CALL cl_set_combo_scc_part('xrcgstus','13','N,X,Y')
 
   
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('xrca001','8302')
   #end add-point
   
   CALL axrt360_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="axrt360.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION axrt360_ui_dialog()
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
   IF g_default THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0 
   ELSE
      CALL gfrm_curr.setElementHidden("mainlayout",1)
      CALL gfrm_curr.setElementHidden("worksheet",0)
      LET g_main_hidden = 1
   END IF
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
   
   WHILE TRUE
      
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_xrcg_m.* TO NULL
         CALL g_xrcg_d.clear()
         CALL g_xrcg2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL axrt360_init()
      END IF
 
      CALL lib_cl_dlg.cl_dlg_before_display()
      CALL cl_notice()
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
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
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL axrt360_idx_chk()
               CALL axrt360_fetch('') # reload data
               LET g_detail_idx = 1
               CALL axrt360_ui_detailshow() #Setting the current row 
         
            ON ACTION qbefield_user   #欄位隱藏設定 
               LET g_action_choice="qbefield_user"
               CALL cl_ui_qbefield_user()
         
         END DISPLAY
        
         DISPLAY ARRAY g_xrcg_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL axrt360_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL axrt360_ui_detailshow()
               
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
                              #此段落i02,i07樣板使用, 但目前不支援批次修改狀態, 先註解
			   ##此段落由子樣板a22產生
               ##目前選取的stus為N
               #IF . = "N" THEN
               #                     CALL cl_set_act_visible('unconfirmed',FALSE)
                  CALL cl_set_act_visible('invalid',TRUE)
                  CALL cl_set_act_visible('confirmed',TRUE)
 
               #END IF
               ##stus - Start - 
               ##目前選取的stus為}
               #IF . = "}" THEN
               #   }
               #END IF        
               ##stus -  End  -               
    
 
 
               
            
 
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         DISPLAY ARRAY g_xrcg2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL axrt360_idx_chk()
               CALL axrt360_ui_detailshow()
               
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
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps 
         
         BEFORE DIALOG
            #先填充browser資料
            CALL axrt360_browser_fill("")
            CALL cl_notice()
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL g_curr_diag.setSelectionMode("s_detail1",1)         
            LET g_page = "first"
            LET g_current_sw = FALSE
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
            
            IF g_current_idx = 0 AND g_browser.getLength() > 0 THEN
               LET g_current_idx = 1 
            END IF
            
            #有資料才進行fetch
            IF g_current_idx <> 0 THEN
               CALL axrt360_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL axrt360_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
            ON ACTION statechange
               LET g_action_choice = "statechange"
               CALL axrt360_statechange()
            #end add-point
 
         #應用 a49 樣板自動產生(Version:4)
            #過濾瀏覽頁資料
            ON ACTION filter
               LET g_action_choice = "fetch"
               #add-point:filter action name="ui_dialog.action.filter"
               
               #end add-point
               CALL axrt360_filter()
               EXIT DIALOG
 
 
 
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL axrt360_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axrt360_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL axrt360_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axrt360_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL axrt360_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axrt360_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL axrt360_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axrt360_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL axrt360_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axrt360_idx_chk()
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
                  LET g_export_node[1] = base.typeInfo.create(g_xrcg_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_xrcg2_d)
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
          
         ON ACTION mainhidden       #主頁摺疊
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
               NEXT FIELD xrcgseq
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
               CALL axrt360_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL axrt360_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL axrt360_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL axrt360_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL axrt360_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL axrt360_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL axrt360_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               CALL axrt360_output()
               #END add-point
               &include "erp/axr/axrt360_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               CALL axrt360_output()
               #END add-point
               &include "erp/axr/axrt360_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axrt360_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL axrt360_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL axrt360_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL axrt360_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_xrcg_m.xrcgdocdt)
 
 
 
         
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
 
{<section id="axrt360.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION axrt360_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axrt360.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION axrt360_browser_fill(ps_page_action)
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
   DEFINE l_ld_str          STRING
   #end add-point
   
   #add-point:Function前置處理  name="browser_fill.before_browser_fill"
   CALL s_axrt300_get_site(g_user,'','2') RETURNING l_ld_str
   LET l_ld_str = cl_replace_str(l_ld_str,"glaald","xrcgld")
   LET l_wc = l_wc," AND ",l_ld_str
   #end add-point    
 
   LET l_searchcol = "xrcgld,xrcgdocno"
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
      LET l_sub_sql = " SELECT DISTINCT xrcgld ",
                      ", xrcgdocno ",
 
                      " FROM xrcg_t ",
                      " ",
                      " ", 
 
 
 
                      " WHERE xrcgent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("xrcg_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT xrcgld ",
                      ", xrcgdocno ",
 
                      " FROM xrcg_t ",
                      " ",
                      " ", 
 
 
                      " WHERE xrcgent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("xrcg_t")
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
      INITIALIZE g_xrcg_m.* TO NULL
      CALL g_xrcg_d.clear()        
      CALL g_xrcg2_d.clear() 
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.xrcgld,t0.xrcgdocno Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.xrcgld,t0.xrcgdocno",
                " FROM xrcg_t t0",
                #" ",
                " ",
 
 
 
                
                " WHERE t0.xrcgent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("xrcg_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
   IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
      LET g_sql = g_sql," AND EXISTS (SELECT 1 FROM pmaa_t ",
                        "              WHERE pmaaent = ",g_enterprise,
                        "                AND ",g_sql_ctrl,
                        "                AND pmaaent = xrcgent ",
                        "                AND pmaa001 = xrcg001 )"
   END IF
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"xrcg_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_xrcgld,g_browser[g_cnt].b_xrcgdocno 
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
      
         #遮罩相關處理
         CALL axrt360_browser_mask()
         
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
   
   IF cl_null(g_browser[g_cnt].b_xrcgld) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_xrcg_m.* TO NULL
      CALL g_xrcg_d.clear()
      CALL g_xrcg2_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL axrt360_fetch('')
   
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
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange", FALSE)
   ELSE
      CALL cl_set_act_visible("statechange", TRUE)
   END IF
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="axrt360.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION axrt360_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_xrcg_m.xrcgld = g_browser[g_current_idx].b_xrcgld   
   LET g_xrcg_m.xrcgdocno = g_browser[g_current_idx].b_xrcgdocno   
 
   EXECUTE axrt360_master_referesh USING g_xrcg_m.xrcgld,g_xrcg_m.xrcgdocno INTO g_xrcg_m.xrcgcomp,g_xrcg_m.xrcgld, 
       g_xrcg_m.xrcgsite,g_xrcg_m.xrcgdocno,g_xrcg_m.xrcgdocdt,g_xrcg_m.xrcg001,g_xrcg_m.xrcg010,g_xrcg_m.xrcgstus, 
       g_xrcg_m.xrcgcomp_desc,g_xrcg_m.xrcgld_desc,g_xrcg_m.xrcgsite_desc,g_xrcg_m.xrcg001_desc,g_xrcg_m.xrcg010_desc 
 
   CALL axrt360_show()
   
END FUNCTION
 
{</section>}
 
{<section id="axrt360.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION axrt360_ui_detailshow()
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
 
{<section id="axrt360.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION axrt360_ui_browser_refresh()
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
      IF g_browser[l_i].b_xrcgld = g_xrcg_m.xrcgld 
         AND g_browser[l_i].b_xrcgdocno = g_xrcg_m.xrcgdocno 
 
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
 
{<section id="axrt360.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION axrt360_construct()
   #add-point:cs段define name="cs.define_customerization"
   
   #end add-point    
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   #add-point:cs段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   DEFINE l_ld_str    STRING
   DEFINE l_comp_str  STRING
   DEFINE l_site_str  STRING
   #end add-point 
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
   
   #清除畫面上相關資料
   CLEAR FORM                 
   INITIALIZE g_xrcg_m.* TO NULL
   CALL g_xrcg_d.clear()
   CALL g_xrcg2_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   LET g_comp_str = ''
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON xrcgcomp,xrcgld,xrcgsite,xrcgdocno,xrcgdocdt,xrcg001,xrcg010,xrcgstus 
 
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
                 #Ctrlp:construct.c.xrcgcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcgcomp
            #add-point:ON ACTION controlp INFIELD xrcgcomp name="construct.c.xrcgcomp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            CALL s_axrt300_get_site(g_user,'','3') RETURNING l_comp_str
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = l_comp_str
            CALL q_ooef001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrcgcomp  #顯示到畫面上
            NEXT FIELD xrcgcomp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcgcomp
            #add-point:BEFORE FIELD xrcgcomp name="construct.b.xrcgcomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcgcomp
            
            #add-point:AFTER FIELD xrcgcomp name="construct.a.xrcgcomp"
            CALL FGL_DIALOG_GETBUFFER() RETURNING g_comp_str
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrcgld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcgld
            #add-point:ON ACTION controlp INFIELD xrcgld name="construct.c.xrcgld"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            CALL s_axrt300_get_site(g_user,g_comp_str,'2') RETURNING l_ld_str
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = l_ld_str CLIPPED," AND (glaa008 = 'Y' OR glaa014 = 'Y')" 
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            CALL q_authorised_ld()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrcgld  #顯示到畫面上
            NEXT FIELD xrcgld                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcgld
            #add-point:BEFORE FIELD xrcgld name="construct.b.xrcgld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcgld
            
            #add-point:AFTER FIELD xrcgld name="construct.a.xrcgld"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrcgsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcgsite
            #add-point:ON ACTION controlp INFIELD xrcgsite name="construct.c.xrcgsite"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            CALL s_axrt300_get_site(g_user,'','1') RETURNING l_site_str
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = l_site_str
            CALL q_ooef001_14()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrcgsite  #顯示到畫面上
            NEXT FIELD xrcgsite                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcgsite
            #add-point:BEFORE FIELD xrcgsite name="construct.b.xrcgsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcgsite
            
            #add-point:AFTER FIELD xrcgsite name="construct.a.xrcgsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrcgdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcgdocno
            #add-point:ON ACTION controlp INFIELD xrcgdocno name="construct.c.xrcgdocno"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_xrcgdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrcgdocno  #顯示到畫面上
            NEXT FIELD xrcgdocno                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcgdocno
            #add-point:BEFORE FIELD xrcgdocno name="construct.b.xrcgdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcgdocno
            
            #add-point:AFTER FIELD xrcgdocno name="construct.a.xrcgdocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcgdocdt
            #add-point:BEFORE FIELD xrcgdocdt name="construct.b.xrcgdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcgdocdt
            
            #add-point:AFTER FIELD xrcgdocdt name="construct.a.xrcgdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrcgdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcgdocdt
            #add-point:ON ACTION controlp INFIELD xrcgdocdt name="construct.c.xrcgdocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xrcg001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcg001
            #add-point:ON ACTION controlp INFIELD xrcg001 name="construct.c.xrcg001"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrcg001  #顯示到畫面上
            NEXT FIELD xrcg001                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcg001
            #add-point:BEFORE FIELD xrcg001 name="construct.b.xrcg001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcg001
            
            #add-point:AFTER FIELD xrcg001 name="construct.a.xrcg001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrcg010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcg010
            #add-point:ON ACTION controlp INFIELD xrcg010 name="construct.c.xrcg010"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrcg010  #顯示到畫面上
            NEXT FIELD xrcg010                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcg010
            #add-point:BEFORE FIELD xrcg010 name="construct.b.xrcg010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcg010
            
            #add-point:AFTER FIELD xrcg010 name="construct.a.xrcg010"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcgstus
            #add-point:BEFORE FIELD xrcgstus name="construct.b.xrcgstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcgstus
            
            #add-point:AFTER FIELD xrcgstus name="construct.a.xrcgstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrcgstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcgstus
            #add-point:ON ACTION controlp INFIELD xrcgstus name="construct.c.xrcgstus"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON xrcgseq,xrcg002,xrca001,xrcg003,xrcg004,xrcg005,xrcg006,xrcg007,xrcg008, 
          xrcg009,xrcgownid,xrcgowndp,xrcgcrtid,xrcgcrtdp,xrcgcrtdt,xrcgmodid,xrcgmoddt,xrcgcnfid,xrcgcnfdt, 
          xrcgpstid,xrcgpstdt
           FROM s_detail1[1].xrcgseq,s_detail1[1].xrcg002,s_detail1[1].xrca001,s_detail1[1].xrcg003, 
               s_detail1[1].xrcg004,s_detail1[1].xrcg005,s_detail1[1].xrcg006,s_detail1[1].xrcg007,s_detail1[1].xrcg008, 
               s_detail1[1].xrcg009,s_detail2[1].xrcgownid,s_detail2[1].xrcgowndp,s_detail2[1].xrcgcrtid, 
               s_detail2[1].xrcgcrtdp,s_detail2[1].xrcgcrtdt,s_detail2[1].xrcgmodid,s_detail2[1].xrcgmoddt, 
               s_detail2[1].xrcgcnfid,s_detail2[1].xrcgcnfdt,s_detail2[1].xrcgpstid,s_detail2[1].xrcgpstdt 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<xrcgcrtdt>>----
         AFTER FIELD xrcgcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<xrcgmoddt>>----
         AFTER FIELD xrcgmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<xrcgcnfdt>>----
         AFTER FIELD xrcgcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<xrcgpstdt>>----
         AFTER FIELD xrcgpstdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
           
         #單身一般欄位開窗相關處理
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcgseq
            #add-point:BEFORE FIELD xrcgseq name="construct.b.page1.xrcgseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcgseq
            
            #add-point:AFTER FIELD xrcgseq name="construct.a.page1.xrcgseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrcgseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcgseq
            #add-point:ON ACTION controlp INFIELD xrcgseq name="construct.c.page1.xrcgseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xrcg002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcg002
            #add-point:ON ACTION controlp INFIELD xrcg002 name="construct.c.page1.xrcg002"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_xrccdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrcg002  #顯示到畫面上
            NEXT FIELD xrcg002                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcg002
            #add-point:BEFORE FIELD xrcg002 name="construct.b.page1.xrcg002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcg002
            
            #add-point:AFTER FIELD xrcg002 name="construct.a.page1.xrcg002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca001
            #add-point:BEFORE FIELD xrca001 name="construct.b.page1.xrca001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca001
            
            #add-point:AFTER FIELD xrca001 name="construct.a.page1.xrca001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrca001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca001
            #add-point:ON ACTION controlp INFIELD xrca001 name="construct.c.page1.xrca001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xrcg003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcg003
            #add-point:ON ACTION controlp INFIELD xrcg003 name="construct.c.page1.xrcg003"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_xrccseq()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrcg003  #顯示到畫面上
            NEXT FIELD xrcg003                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcg003
            #add-point:BEFORE FIELD xrcg003 name="construct.b.page1.xrcg003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcg003
            
            #add-point:AFTER FIELD xrcg003 name="construct.a.page1.xrcg003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcg004
            #add-point:BEFORE FIELD xrcg004 name="construct.b.page1.xrcg004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcg004
            
            #add-point:AFTER FIELD xrcg004 name="construct.a.page1.xrcg004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrcg004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcg004
            #add-point:ON ACTION controlp INFIELD xrcg004 name="construct.c.page1.xrcg004"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xrcg005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcg005
            #add-point:ON ACTION controlp INFIELD xrcg005 name="construct.c.page1.xrcg005"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooib001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrcg005  #顯示到畫面上
            NEXT FIELD xrcg005                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcg005
            #add-point:BEFORE FIELD xrcg005 name="construct.b.page1.xrcg005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcg005
            
            #add-point:AFTER FIELD xrcg005 name="construct.a.page1.xrcg005"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcg006
            #add-point:BEFORE FIELD xrcg006 name="construct.b.page1.xrcg006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcg006
            
            #add-point:AFTER FIELD xrcg006 name="construct.a.page1.xrcg006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrcg006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcg006
            #add-point:ON ACTION controlp INFIELD xrcg006 name="construct.c.page1.xrcg006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcg007
            #add-point:BEFORE FIELD xrcg007 name="construct.b.page1.xrcg007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcg007
            
            #add-point:AFTER FIELD xrcg007 name="construct.a.page1.xrcg007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrcg007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcg007
            #add-point:ON ACTION controlp INFIELD xrcg007 name="construct.c.page1.xrcg007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcg008
            #add-point:BEFORE FIELD xrcg008 name="construct.b.page1.xrcg008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcg008
            
            #add-point:AFTER FIELD xrcg008 name="construct.a.page1.xrcg008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrcg008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcg008
            #add-point:ON ACTION controlp INFIELD xrcg008 name="construct.c.page1.xrcg008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcg009
            #add-point:BEFORE FIELD xrcg009 name="construct.b.page1.xrcg009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcg009
            
            #add-point:AFTER FIELD xrcg009 name="construct.a.page1.xrcg009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrcg009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcg009
            #add-point:ON ACTION controlp INFIELD xrcg009 name="construct.c.page1.xrcg009"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.xrcgownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcgownid
            #add-point:ON ACTION controlp INFIELD xrcgownid name="construct.c.page2.xrcgownid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrcgownid  #顯示到畫面上
            NEXT FIELD xrcgownid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcgownid
            #add-point:BEFORE FIELD xrcgownid name="construct.b.page2.xrcgownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcgownid
            
            #add-point:AFTER FIELD xrcgownid name="construct.a.page2.xrcgownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xrcgowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcgowndp
            #add-point:ON ACTION controlp INFIELD xrcgowndp name="construct.c.page2.xrcgowndp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrcgowndp  #顯示到畫面上
            NEXT FIELD xrcgowndp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcgowndp
            #add-point:BEFORE FIELD xrcgowndp name="construct.b.page2.xrcgowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcgowndp
            
            #add-point:AFTER FIELD xrcgowndp name="construct.a.page2.xrcgowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xrcgcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcgcrtid
            #add-point:ON ACTION controlp INFIELD xrcgcrtid name="construct.c.page2.xrcgcrtid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrcgcrtid  #顯示到畫面上
            NEXT FIELD xrcgcrtid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcgcrtid
            #add-point:BEFORE FIELD xrcgcrtid name="construct.b.page2.xrcgcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcgcrtid
            
            #add-point:AFTER FIELD xrcgcrtid name="construct.a.page2.xrcgcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xrcgcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcgcrtdp
            #add-point:ON ACTION controlp INFIELD xrcgcrtdp name="construct.c.page2.xrcgcrtdp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrcgcrtdp  #顯示到畫面上
            NEXT FIELD xrcgcrtdp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcgcrtdp
            #add-point:BEFORE FIELD xrcgcrtdp name="construct.b.page2.xrcgcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcgcrtdp
            
            #add-point:AFTER FIELD xrcgcrtdp name="construct.a.page2.xrcgcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcgcrtdt
            #add-point:BEFORE FIELD xrcgcrtdt name="construct.b.page2.xrcgcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.xrcgmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcgmodid
            #add-point:ON ACTION controlp INFIELD xrcgmodid name="construct.c.page2.xrcgmodid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrcgmodid  #顯示到畫面上
            NEXT FIELD xrcgmodid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcgmodid
            #add-point:BEFORE FIELD xrcgmodid name="construct.b.page2.xrcgmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcgmodid
            
            #add-point:AFTER FIELD xrcgmodid name="construct.a.page2.xrcgmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcgmoddt
            #add-point:BEFORE FIELD xrcgmoddt name="construct.b.page2.xrcgmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.xrcgcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcgcnfid
            #add-point:ON ACTION controlp INFIELD xrcgcnfid name="construct.c.page2.xrcgcnfid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrcgcnfid  #顯示到畫面上
            NEXT FIELD xrcgcnfid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcgcnfid
            #add-point:BEFORE FIELD xrcgcnfid name="construct.b.page2.xrcgcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcgcnfid
            
            #add-point:AFTER FIELD xrcgcnfid name="construct.a.page2.xrcgcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcgcnfdt
            #add-point:BEFORE FIELD xrcgcnfdt name="construct.b.page2.xrcgcnfdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.xrcgpstid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcgpstid
            #add-point:ON ACTION controlp INFIELD xrcgpstid name="construct.c.page2.xrcgpstid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrcgpstid  #顯示到畫面上
            NEXT FIELD xrcgpstid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcgpstid
            #add-point:BEFORE FIELD xrcgpstid name="construct.b.page2.xrcgpstid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcgpstid
            
            #add-point:AFTER FIELD xrcgpstid name="construct.a.page2.xrcgpstid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcgpstdt
            #add-point:BEFORE FIELD xrcgpstdt name="construct.b.page2.xrcgpstdt"
            
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
 
{<section id="axrt360.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION axrt360_filter()
   #add-point:filter段define name="filter.define_customerization"
   
   #end add-point   
   #add-point:filter段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="filter.pre_function"
   
   #end add-point
   
   #切換畫面
   IF NOT g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",1)
      CALL gfrm_curr.setElementHidden("worksheet",0)
      LET g_main_hidden = 1
   END IF   
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter.trim()
   LET g_wc_t = g_wc
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter_t, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON xrcgld,xrcgdocno
                          FROM s_browse[1].b_xrcgld,s_browse[1].b_xrcgdocno
 
         BEFORE CONSTRUCT
               DISPLAY axrt360_filter_parser('xrcgld') TO s_browse[1].b_xrcgld
            DISPLAY axrt360_filter_parser('xrcgdocno') TO s_browse[1].b_xrcgdocno
      
         #add-point:filter段cs_ctrl name="filter.cs_ctrl"
         
         #end add-point
      
      END CONSTRUCT
 
      #add-point:filter段add_cs name="filter.add_cs"
      
      #end add-point
 
      BEFORE DIALOG
         #add-point:filter段b_dialog name="filter.b_dialog"
         
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
 
      CALL axrt360_filter_show('xrcgld')
   CALL axrt360_filter_show('xrcgdocno')
 
END FUNCTION
 
{</section>}
 
{<section id="axrt360.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION axrt360_filter_parser(ps_field)
   #add-point:filter段define name="filter_parser.define_customerization"
   
   #end add-point    
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num10
   DEFINE li_tmp2    LIKE type_t.num10
   DEFINE ls_var     STRING
   #add-point:filter段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter_parser.define"
   
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
 
{<section id="axrt360.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION axrt360_filter_show(ps_field)
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
   LET ls_condition = axrt360_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="axrt360.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION axrt360_query()
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
   CALL g_xrcg_d.clear()
   CALL g_xrcg2_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL axrt360_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL axrt360_browser_fill(g_wc)
      CALL axrt360_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL axrt360_browser_fill("F")
   
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
      CALL axrt360_fetch("F") 
   END IF
   
   CALL axrt360_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="axrt360.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION axrt360_fetch(p_flag)
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
   
   
   CALL g_curr_diag.setCurrentRow("s_browse", g_current_idx) #設定browse 索引
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
   
   LET g_xrcg_m.xrcgld = g_browser[g_current_idx].b_xrcgld
   LET g_xrcg_m.xrcgdocno = g_browser[g_current_idx].b_xrcgdocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE axrt360_master_referesh USING g_xrcg_m.xrcgld,g_xrcg_m.xrcgdocno INTO g_xrcg_m.xrcgcomp,g_xrcg_m.xrcgld, 
       g_xrcg_m.xrcgsite,g_xrcg_m.xrcgdocno,g_xrcg_m.xrcgdocdt,g_xrcg_m.xrcg001,g_xrcg_m.xrcg010,g_xrcg_m.xrcgstus, 
       g_xrcg_m.xrcgcomp_desc,g_xrcg_m.xrcgld_desc,g_xrcg_m.xrcgsite_desc,g_xrcg_m.xrcg001_desc,g_xrcg_m.xrcg010_desc 
 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xrcg_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_xrcg_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_xrcg_m_mask_o.* =  g_xrcg_m.*
   CALL axrt360_xrcg_t_mask()
   LET g_xrcg_m_mask_n.* =  g_xrcg_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axrt360_set_act_visible()
   CALL axrt360_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_xrcg_m_t.* = g_xrcg_m.*
   LET g_xrcg_m_o.* = g_xrcg_m.*
   
   #重新顯示   
   CALL axrt360_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="axrt360.insert" >}
#+ 資料新增
PRIVATE FUNCTION axrt360_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_xrcg_d.clear()
   CALL g_xrcg2_d.clear()
 
 
   INITIALIZE g_xrcg_m.* TO NULL             #DEFAULT 設定
   LET g_xrcgld_t = NULL
   LET g_xrcgdocno_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
      
     
      #add-point:單頭預設值 name="insert.default"
      SELECT ooef017 INTO g_xrcg_m.xrcgcomp
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = g_site
      
      SELECT glaald INTO g_xrcg_m.xrcgld
        FROM glaa_t
       WHERE glaaent = g_enterprise
         AND glaacomp = g_xrcg_m.xrcgcomp
         AND glaa014 = 'Y'
         
      LET g_xrcg_m.xrcgsite = g_site
      LET g_xrcg_m.xrcgdocdt = g_today   #170210-00018#1 add lujh
      LET g_xrcg_m.xrcg010 = g_user
      
      CALL s_desc_get_department_desc(g_xrcg_m.xrcgcomp) RETURNING g_xrcg_m.xrcgcomp_desc
      DISPLAY BY NAME g_xrcg_m.xrcgcomp_desc
      
      CALL s_desc_get_ld_desc(g_xrcg_m.xrcgld) RETURNING g_xrcg_m.xrcgld_desc
      DISPLAY BY NAME g_xrcg_m.xrcgld_desc
      
      CALL s_desc_get_department_desc(g_xrcg_m.xrcgsite) RETURNING g_xrcg_m.xrcgsite_desc
      DISPLAY BY NAME g_xrcg_m.xrcgsite_desc
      
      CALL s_desc_get_person_desc(g_xrcg_m.xrcg010) RETURNING g_xrcg_m.xrcg010_desc
      DISPLAY BY NAME g_xrcg_m.xrcg010_desc 

      LET g_xrcg_m.xrcgstus = 'N'
      
      CASE g_xrcg_m.xrcgstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")  
      END CASE
      #end add-point 
 
      CALL axrt360_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_xrcg_m.* TO NULL
         INITIALIZE g_xrcg_d TO NULL
         INITIALIZE g_xrcg2_d TO NULL
 
         CALL axrt360_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_xrcg_m.* = g_xrcg_m_t.*
         CALL axrt360_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_xrcg_d.clear()
      #CALL g_xrcg2_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axrt360_set_act_visible()
   CALL axrt360_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_xrcgld_t = g_xrcg_m.xrcgld
   LET g_xrcgdocno_t = g_xrcg_m.xrcgdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " xrcgent = " ||g_enterprise|| " AND",
                      " xrcgld = '", g_xrcg_m.xrcgld, "' "
                      ," AND xrcgdocno = '", g_xrcg_m.xrcgdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axrt360_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL axrt360_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE axrt360_master_referesh USING g_xrcg_m.xrcgld,g_xrcg_m.xrcgdocno INTO g_xrcg_m.xrcgcomp,g_xrcg_m.xrcgld, 
       g_xrcg_m.xrcgsite,g_xrcg_m.xrcgdocno,g_xrcg_m.xrcgdocdt,g_xrcg_m.xrcg001,g_xrcg_m.xrcg010,g_xrcg_m.xrcgstus, 
       g_xrcg_m.xrcgcomp_desc,g_xrcg_m.xrcgld_desc,g_xrcg_m.xrcgsite_desc,g_xrcg_m.xrcg001_desc,g_xrcg_m.xrcg010_desc 
 
   
   #遮罩相關處理
   LET g_xrcg_m_mask_o.* =  g_xrcg_m.*
   CALL axrt360_xrcg_t_mask()
   LET g_xrcg_m_mask_n.* =  g_xrcg_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_xrcg_m.xrcgcomp,g_xrcg_m.xrcgcomp_desc,g_xrcg_m.xrcgld,g_xrcg_m.xrcgld_desc,g_xrcg_m.xrcgsite, 
       g_xrcg_m.xrcgsite_desc,g_xrcg_m.xrcgdocno,g_xrcg_m.xrcgdocdt,g_xrcg_m.xrcg001,g_xrcg_m.xrcg001_desc, 
       g_xrcg_m.xrcg010,g_xrcg_m.xrcg010_desc,g_xrcg_m.xrcgstus
   
   #功能已完成,通報訊息中心
   CALL axrt360_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="axrt360.modify" >}
#+ 資料修改
PRIVATE FUNCTION axrt360_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_xrcg_m.xrcgld IS NULL
   OR g_xrcg_m.xrcgdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_xrcgld_t = g_xrcg_m.xrcgld
   LET g_xrcgdocno_t = g_xrcg_m.xrcgdocno
 
   CALL s_transaction_begin()
   
   OPEN axrt360_cl USING g_enterprise,g_xrcg_m.xrcgld,g_xrcg_m.xrcgdocno
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axrt360_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE axrt360_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axrt360_master_referesh USING g_xrcg_m.xrcgld,g_xrcg_m.xrcgdocno INTO g_xrcg_m.xrcgcomp,g_xrcg_m.xrcgld, 
       g_xrcg_m.xrcgsite,g_xrcg_m.xrcgdocno,g_xrcg_m.xrcgdocdt,g_xrcg_m.xrcg001,g_xrcg_m.xrcg010,g_xrcg_m.xrcgstus, 
       g_xrcg_m.xrcgcomp_desc,g_xrcg_m.xrcgld_desc,g_xrcg_m.xrcgsite_desc,g_xrcg_m.xrcg001_desc,g_xrcg_m.xrcg010_desc 
 
   
   #遮罩相關處理
   LET g_xrcg_m_mask_o.* =  g_xrcg_m.*
   CALL axrt360_xrcg_t_mask()
   LET g_xrcg_m_mask_n.* =  g_xrcg_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL axrt360_show()
   WHILE TRUE
      LET g_xrcgld_t = g_xrcg_m.xrcgld
      LET g_xrcgdocno_t = g_xrcg_m.xrcgdocno
 
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL axrt360_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_xrcg_m.* = g_xrcg_m_t.*
         CALL axrt360_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_xrcg_m.xrcgld != g_xrcgld_t 
      OR g_xrcg_m.xrcgdocno != g_xrcgdocno_t 
 
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
   CALL axrt360_set_act_visible()
   CALL axrt360_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " xrcgent = " ||g_enterprise|| " AND",
                      " xrcgld = '", g_xrcg_m.xrcgld, "' "
                      ," AND xrcgdocno = '", g_xrcg_m.xrcgdocno, "' "
 
   #填到對應位置
   CALL axrt360_browser_fill("")
 
   CALL axrt360_idx_chk()
 
   CLOSE axrt360_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL axrt360_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="axrt360.input" >}
#+ 資料輸入
PRIVATE FUNCTION axrt360_input(p_cmd)
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
   DEFINE  l_comp_str            STRING
   DEFINE  l_site_str            STRING
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_glaa003             LIKE glaa_t.glaa003
   DEFINE  l_glaa024             LIKE glaa_t.glaa024
   DEFINE  l_sql                 STRING
   DEFINE  l_type                LIKE type_t.chr1
   DEFINE  l_docno               LIKE xrcg_t.xrcgdocno
   DEFINE  l_xrcadocdt           LIKE xrca_t.xrcadocdt
   DEFINE  l_xrca061             LIKE xrca_t.xrca061
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
   DISPLAY BY NAME g_xrcg_m.xrcgcomp,g_xrcg_m.xrcgcomp_desc,g_xrcg_m.xrcgld,g_xrcg_m.xrcgld_desc,g_xrcg_m.xrcgsite, 
       g_xrcg_m.xrcgsite_desc,g_xrcg_m.xrcgdocno,g_xrcg_m.xrcgdocdt,g_xrcg_m.xrcg001,g_xrcg_m.xrcg001_desc, 
       g_xrcg_m.xrcg010,g_xrcg_m.xrcg010_desc,g_xrcg_m.xrcgstus
   
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
   LET g_forupd_sql = "SELECT xrcgseq,xrcg002,xrcg003,xrcg004,xrcg005,xrcg006,xrcg007,xrcg008,xrcg009, 
       xrcgseq,xrcgownid,xrcgowndp,xrcgcrtid,xrcgcrtdp,xrcgcrtdt,xrcgmodid,xrcgmoddt,xrcgcnfid,xrcgcnfdt, 
       xrcgpstid,xrcgpstdt FROM xrcg_t WHERE xrcgent=? AND xrcgld=? AND xrcgdocno=? AND xrcgseq=? FOR  
       UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axrt360_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL axrt360_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL axrt360_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_xrcg_m.xrcgcomp,g_xrcg_m.xrcgld,g_xrcg_m.xrcgsite,g_xrcg_m.xrcgdocno,g_xrcg_m.xrcgdocdt, 
       g_xrcg_m.xrcg001,g_xrcg_m.xrcg010,g_xrcg_m.xrcgstus
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   LET g_errshow = 1
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="axrt360.input.head" >}
   
      #單頭段
      INPUT BY NAME g_xrcg_m.xrcgcomp,g_xrcg_m.xrcgld,g_xrcg_m.xrcgsite,g_xrcg_m.xrcgdocno,g_xrcg_m.xrcgdocdt, 
          g_xrcg_m.xrcg001,g_xrcg_m.xrcg010,g_xrcg_m.xrcgstus 
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
         AFTER FIELD xrcgcomp
            
            #add-point:AFTER FIELD xrcgcomp name="input.a.xrcgcomp"
            IF NOT cl_null(g_xrcg_m.xrcgcomp) THEN 
#應用 a19 樣板自動產生(Version:2)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xrcg_m.xrcgcomp
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooef001_1") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  CALL s_axrt300_get_site(g_user,'','3') RETURNING l_comp_str
                  IF s_chr_get_index_of(l_comp_str,g_xrcg_m.xrcgcomp,1) = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axr-01057'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_xrcg_m.xrcgcomp = g_xrcg_m_t.xrcgcomp
                     CALL s_desc_get_department_desc(g_xrcg_m.xrcgcomp) RETURNING g_xrcg_m.xrcgcomp_desc
                     DISPLAY BY NAME g_xrcg_m.xrcgcomp_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  IF g_xrcg_m.xrcgcomp <> g_xrcg_m_t.xrcgcomp OR cl_null(g_xrcg_m_t.xrcgcomp) THEN 
                     LET g_xrcg_m.xrcgld = ''
                     SELECT glaald INTO g_xrcg_m.xrcgld
                       FROM glaa_t
                      WHERE glaaent = g_enterprise
                        AND glaacomp = g_xrcg_m.xrcgcomp
                        AND glaa014 = 'Y'
                     CALL s_desc_get_ld_desc(g_xrcg_m.xrcgld) RETURNING g_xrcg_m.xrcgld_desc
                     DISPLAY BY NAME g_xrcg_m.xrcgld_desc
                     
                     LET g_xrcg_m.xrcgsite = g_xrcg_m.xrcgcomp
                     CALL s_desc_get_department_desc(g_xrcg_m.xrcgsite) RETURNING g_xrcg_m.xrcgsite_desc
                     DISPLAY BY NAME g_xrcg_m.xrcgsite_desc
                  END IF
               ELSE
                  #檢查失敗時後續處理
                  LET g_xrcg_m.xrcgcomp = g_xrcg_m_t.xrcgcomp
                  CALL s_desc_get_department_desc(g_xrcg_m.xrcgcomp) RETURNING g_xrcg_m.xrcgcomp_desc
                  DISPLAY BY NAME g_xrcg_m.xrcgcomp_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 
            CALL s_desc_get_department_desc(g_xrcg_m.xrcgcomp) RETURNING g_xrcg_m.xrcgcomp_desc
            DISPLAY BY NAME g_xrcg_m.xrcgcomp_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcgcomp
            #add-point:BEFORE FIELD xrcgcomp name="input.b.xrcgcomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcgcomp
            #add-point:ON CHANGE xrcgcomp name="input.g.xrcgcomp"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcgld
            
            #add-point:AFTER FIELD xrcgld name="input.a.xrcgld"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_xrcg_m.xrcgld) AND NOT cl_null(g_xrcg_m.xrcgdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xrcg_m.xrcgld != g_xrcgld_t  OR g_xrcg_m.xrcgdocno != g_xrcgdocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xrcg_t WHERE "||"xrcgent = " ||g_enterprise|| " AND "||"xrcgld = '"||g_xrcg_m.xrcgld ||"' AND "|| "xrcgdocno = '"||g_xrcg_m.xrcgdocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_xrcg_m.xrcgld) THEN 
               CALL s_fin_ld_chk(g_xrcg_m.xrcgld,g_user,'Y') RETURNING l_success,g_errno
               IF NOT cl_null(g_errno) THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code = g_errno
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  LET g_xrcg_m.xrcgld = g_xrcg_m_t.xrcgld
                  CALL s_desc_get_ld_desc(g_xrcg_m.xrcgld) RETURNING g_xrcg_m.xrcgld_desc
                  DISPLAY BY NAME g_xrcg_m.xrcgld_desc
                  NEXT FIELD CURRENT
               END IF
               
               IF NOT cl_null(g_xrcg_m.xrcgcomp) THEN 
                  SELECT COUNT(1) INTO l_n
                    FROM glaa_t
                   WHERE glaaent = g_enterprise
                     AND glaald = g_xrcg_m.xrcgld
                     AND glaacomp = g_xrcg_m.xrcgcomp
                     
                  IF l_n = 0 THEN 
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "afa-00189" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET g_xrcg_m.xrcgld = g_xrcg_m_t.xrcgld
                     CALL s_desc_get_ld_desc(g_xrcg_m.xrcgld) RETURNING g_xrcg_m.xrcgld_desc
                     DISPLAY BY NAME g_xrcg_m.xrcgld_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_ld_desc(g_xrcg_m.xrcgld) RETURNING g_xrcg_m.xrcgld_desc
            DISPLAY BY NAME g_xrcg_m.xrcgld_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcgld
            #add-point:BEFORE FIELD xrcgld name="input.b.xrcgld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcgld
            #add-point:ON CHANGE xrcgld name="input.g.xrcgld"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcgsite
            
            #add-point:AFTER FIELD xrcgsite name="input.a.xrcgsite"
            IF NOT cl_null(g_xrcg_m.xrcgsite) THEN 
#應用 a19 樣板自動產生(Version:2)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xrcg_m.xrcgsite
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooef001_13") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  CALL s_axrt300_get_site(g_user,'','1') RETURNING l_site_str
                  IF s_chr_get_index_of(l_site_str,g_xrcg_m.xrcgsite,1) = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axr-01058'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_xrcg_m.xrcgsite = g_xrcg_m_t.xrcgsite
                     CALL s_desc_get_department_desc(g_xrcg_m.xrcgsite) RETURNING g_xrcg_m.xrcgsite_desc
                     DISPLAY BY NAME g_xrcg_m.xrcgsite_desc
                     NEXT FIELD CURRENT
                  END IF

               ELSE
                  #檢查失敗時後續處理
                  LET g_xrcg_m.xrcgsite = g_xrcg_m_t.xrcgsite
                  CALL s_desc_get_department_desc(g_xrcg_m.xrcgsite) RETURNING g_xrcg_m.xrcgsite_desc
                  DISPLAY BY NAME g_xrcg_m.xrcgsite_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 
            CALL s_desc_get_department_desc(g_xrcg_m.xrcgsite) RETURNING g_xrcg_m.xrcgsite_desc
            DISPLAY BY NAME g_xrcg_m.xrcgsite_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcgsite
            #add-point:BEFORE FIELD xrcgsite name="input.b.xrcgsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcgsite
            #add-point:ON CHANGE xrcgsite name="input.g.xrcgsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcgdocno
            #add-point:BEFORE FIELD xrcgdocno name="input.b.xrcgdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcgdocno
            
            #add-point:AFTER FIELD xrcgdocno name="input.a.xrcgdocno"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_xrcg_m.xrcgld) AND NOT cl_null(g_xrcg_m.xrcgdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xrcg_m.xrcgld != g_xrcgld_t  OR g_xrcg_m.xrcgdocno != g_xrcgdocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xrcg_t WHERE "||"xrcgent = " ||g_enterprise|| " AND "||"xrcgld = '"||g_xrcg_m.xrcgld ||"' AND "|| "xrcgdocno = '"||g_xrcg_m.xrcgdocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            SELECT glaa024 INTO l_glaa024 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xrcg_m.xrcgld
            IF NOT cl_null(g_xrcg_m.xrcgdocno) THEN
               IF NOT s_aooi200_fin_chk_slip(g_xrcg_m.xrcgld,l_glaa024,g_xrcg_m.xrcgdocno,g_prog) THEN
                  LET g_xrcg_m.xrcgdocno = g_xrcg_m_t.xrcgdocno
                  NEXT FIELD CURRENT
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcgdocno
            #add-point:ON CHANGE xrcgdocno name="input.g.xrcgdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcgdocdt
            #add-point:BEFORE FIELD xrcgdocdt name="input.b.xrcgdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcgdocdt
            
            #add-point:AFTER FIELD xrcgdocdt name="input.a.xrcgdocdt"
            #170210-00018#1--add--str--lujh
            IF NOT cl_null(g_xrcg_m.xrcgdocdt) THEN
               IF g_xrcg_m.xrcgdocdt != g_xrcg_m_o.xrcgdocdt OR cl_null(g_xrcg_m_o.xrcgdocdt) THEN 
                  #檢查當單據日期小於等於關帳日期時，不可異動單據
                  CALL s_fin_date_close_chk('',g_xrcg_m.xrcgcomp,'AXR',g_xrcg_m.xrcgdocdt) RETURNING l_success
                  IF l_success = FALSE THEN
                     LET g_xrcg_m.xrcgdocdt = g_xrcg_m_o.xrcgdocdt   
                     NEXT FIELD xrcgdocdt
                  END IF
               END IF
            END IF
            LET g_xrcg_m_o.* = g_xrcg_m.*
            #170210-00018#1--add--end--lujh
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcgdocdt
            #add-point:ON CHANGE xrcgdocdt name="input.g.xrcgdocdt"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcg001
            
            #add-point:AFTER FIELD xrcg001 name="input.a.xrcg001"
            IF NOT cl_null(g_xrcg_m.xrcg001) THEN
               IF g_xrcg_m.xrcg001 != g_xrcg_m_t.xrcg001 OR cl_null(g_xrcg_m_t.xrcg001) THEN 
                  #資料存在性、有效性檢查
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_xrcg_m.xrcg001
                  LET g_chkparam.arg2 = ' '
                  LET g_errshow = TRUE 
                  LET g_chkparam.err_str[1] = "apm-00201:sub-01302|axmm200|",cl_get_progname("axmm200",g_lang,"2"),"|:EXEPROGaxmm200"
                  IF NOT cl_chk_exist("v_pmaa001_7") THEN
                     LET g_xrcg_m.xrcg001 = g_xrcg_m_t.xrcg001
                     CALL s_desc_get_trading_partner_abbr_desc(g_xrcg_m.xrcg001) RETURNING g_xrcg_m.xrcg001_desc
                     DISPLAY BY NAME g_xrcg_m.xrcg001_desc
                     NEXT FIELD CURRENT
                  END IF
                  #检核账款对象是否在控制组内
                  LET l_count = 0
                  LET l_sql = "SELECT COUNT(1) FROM pmaa_t WHERE pmaaent = ",g_enterprise," AND pmaa001 ='",g_xrcg_m.xrcg001,"' AND ",g_sql_ctrl
                  PREPARE xrcg001_pre FROM l_sql
                  EXECUTE xrcg001_pre INTO l_count
                  IF cl_null(l_count) THEN LET l_count = 0 END IF
                  IF l_count = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axr-01047'
                     LET g_errparam.extend = g_xrcg_m.xrcg001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_xrcg_m.xrcg001 = g_xrcg_m_t.xrcg001
                     CALL s_desc_get_trading_partner_abbr_desc(g_xrcg_m.xrcg001) RETURNING g_xrcg_m.xrcg001_desc
                     DISPLAY BY NAME g_xrcg_m.xrcg001_desc
                     NEXT FIELD CURRENT
                  END IF

                  IF NOT s_control_check_customer(g_xrcg_m.xrcg001,'2',g_site,g_user,g_dept,'') THEN
                     LET g_xrcg_m.xrcg001 = g_xrcg_m_t.xrcg001
                     CALL s_desc_get_trading_partner_abbr_desc(g_xrcg_m.xrcg001) RETURNING g_xrcg_m.xrcg001_desc
                     DISPLAY BY NAME g_xrcg_m.xrcg001_desc
                     NEXT FIELD CURRENT
		    	      END IF
               END IF
            END IF

            CALL s_desc_get_trading_partner_abbr_desc(g_xrcg_m.xrcg001) RETURNING g_xrcg_m.xrcg001_desc
            DISPLAY BY NAME g_xrcg_m.xrcg001_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcg001
            #add-point:BEFORE FIELD xrcg001 name="input.b.xrcg001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcg001
            #add-point:ON CHANGE xrcg001 name="input.g.xrcg001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcg010
            
            #add-point:AFTER FIELD xrcg010 name="input.a.xrcg010"
            IF NOT cl_null(g_xrcg_m.xrcg010) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xrcg_m.xrcg010 != g_xrcg_m_t.xrcg010 OR g_xrcg_m_t.xrcg010 IS NULL )) THEN
                  #資料存在性、有效性檢查
                  CALL s_employee_chk(g_xrcg_m.xrcg010) RETURNING l_success
                  IF NOT l_success THEN
                     LET g_xrcg_m.xrcg010 = g_xrcg_m_t.xrcg010
                     CALL s_desc_get_person_desc(g_xrcg_m.xrcg010) RETURNING g_xrcg_m.xrcg010_desc
                     DISPLAY BY NAME g_xrcg_m.xrcg010_desc  
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_person_desc(g_xrcg_m.xrcg010) RETURNING g_xrcg_m.xrcg010_desc
             DISPLAY BY NAME g_xrcg_m.xrcg010_desc 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcg010
            #add-point:BEFORE FIELD xrcg010 name="input.b.xrcg010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcg010
            #add-point:ON CHANGE xrcg010 name="input.g.xrcg010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcgstus
            #add-point:BEFORE FIELD xrcgstus name="input.b.xrcgstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcgstus
            
            #add-point:AFTER FIELD xrcgstus name="input.a.xrcgstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcgstus
            #add-point:ON CHANGE xrcgstus name="input.g.xrcgstus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.xrcgcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcgcomp
            #add-point:ON ACTION controlp INFIELD xrcgcomp name="input.c.xrcgcomp"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            CALL s_axrt300_get_site(g_user,'','3') RETURNING l_comp_str
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_xrcg_m.xrcgcomp             #給予default值
            LET g_qryparam.where = l_comp_str
            #給予arg
            LET g_qryparam.arg1 = "" #

 
            CALL q_ooef001_2()                                #呼叫開窗
 
            LET g_xrcg_m.xrcgcomp = g_qryparam.return1              

            DISPLAY g_xrcg_m.xrcgcomp TO xrcgcomp              #
            CALL s_desc_get_department_desc(g_xrcg_m.xrcgcomp) RETURNING g_xrcg_m.xrcgcomp_desc
            DISPLAY BY NAME g_xrcg_m.xrcgcomp_desc
            NEXT FIELD xrcgcomp                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.xrcgld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcgld
            #add-point:ON ACTION controlp INFIELD xrcgld name="input.c.xrcgld"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_xrcg_m.xrcgld             #給予default值
 
            LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp = '",g_xrcg_m.xrcgcomp,"'"

            #給予arg
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
 
            CALL q_authorised_ld()                                #呼叫開窗
 
            LET g_xrcg_m.xrcgld = g_qryparam.return1              

            DISPLAY g_xrcg_m.xrcgld TO xrcgld              #
            CALL s_desc_get_ld_desc(g_xrcg_m.xrcgld) RETURNING g_xrcg_m.xrcgld_desc
            DISPLAY BY NAME g_xrcg_m.xrcgld_desc
            NEXT FIELD xrcgld                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.xrcgsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcgsite
            #add-point:ON ACTION controlp INFIELD xrcgsite name="input.c.xrcgsite"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            CALL s_axrt300_get_site(g_user,'','1') RETURNING l_site_str
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_xrcg_m.xrcgsite             #給予default值
            LET g_qryparam.where = l_site_str
            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_ooef001_14()                                #呼叫開窗
 
            LET g_xrcg_m.xrcgsite = g_qryparam.return1              

            DISPLAY g_xrcg_m.xrcgsite TO xrcgsite              #
            CALL s_desc_get_department_desc(g_xrcg_m.xrcgsite) RETURNING g_xrcg_m.xrcgsite_desc
            DISPLAY BY NAME g_xrcg_m.xrcgsite_desc
            NEXT FIELD xrcgsite                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.xrcgdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcgdocno
            #add-point:ON ACTION controlp INFIELD xrcgdocno name="input.c.xrcgdocno"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_xrcg_m.xrcgdocno             #給予default值

            SELECT glaa024 INTO l_glaa024 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xrcg_m.xrcgld
            #給予arg
            LET g_qryparam.arg1 = l_glaa024
            LET g_qryparam.arg2 = g_prog
 
            CALL q_ooba002_1()                                #呼叫開窗
 
            LET g_xrcg_m.xrcgdocno = g_qryparam.return1              

            DISPLAY g_xrcg_m.xrcgdocno TO xrcgdocno              #

            NEXT FIELD xrcgdocno                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.xrcgdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcgdocdt
            #add-point:ON ACTION controlp INFIELD xrcgdocdt name="input.c.xrcgdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrcg001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcg001
            #add-point:ON ACTION controlp INFIELD xrcg001 name="input.c.xrcg001"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_xrcg_m.xrcg001             #給予default值
            LET g_qryparam.where = "pmaa002 IN ('2','3')"
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where CLIPPED," AND ",g_sql_ctrl
            END IF
            #給予arg
            LET g_qryparam.arg1="('2','3')"

 
            CALL q_pmaa001_1()                                #呼叫開窗
 
            LET g_xrcg_m.xrcg001 = g_qryparam.return1              

            DISPLAY g_xrcg_m.xrcg001 TO xrcg001              #
            CALL s_desc_get_trading_partner_abbr_desc(g_xrcg_m.xrcg001) RETURNING g_xrcg_m.xrcg001_desc
            DISPLAY BY NAME g_xrcg_m.xrcg001_desc
            NEXT FIELD xrcg001                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.xrcg010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcg010
            #add-point:ON ACTION controlp INFIELD xrcg010 name="input.c.xrcg010"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_xrcg_m.xrcg010             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_ooag001()                                #呼叫開窗
 
            LET g_xrcg_m.xrcg010 = g_qryparam.return1              

            DISPLAY g_xrcg_m.xrcg010 TO xrcg010              #
            CALL s_desc_get_person_desc(g_xrcg_m.xrcg010) RETURNING g_xrcg_m.xrcg010_desc
            DISPLAY BY NAME g_xrcg_m.xrcg010_desc  
            NEXT FIELD xrcg010                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.xrcgstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcgstus
            #add-point:ON ACTION controlp INFIELD xrcgstus name="input.c.xrcgstus"
            
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
            DISPLAY BY NAME g_xrcg_m.xrcgld             
                            ,g_xrcg_m.xrcgdocno   
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
            
               #將遮罩欄位還原
               CALL axrt360_xrcg_t_mask_restore('restore_mask_o')
            
               UPDATE xrcg_t SET (xrcgcomp,xrcgld,xrcgsite,xrcgdocno,xrcgdocdt,xrcg001,xrcg010,xrcgstus) = (g_xrcg_m.xrcgcomp, 
                   g_xrcg_m.xrcgld,g_xrcg_m.xrcgsite,g_xrcg_m.xrcgdocno,g_xrcg_m.xrcgdocdt,g_xrcg_m.xrcg001, 
                   g_xrcg_m.xrcg010,g_xrcg_m.xrcgstus)
                WHERE xrcgent = g_enterprise AND xrcgld = g_xrcgld_t
                  AND xrcgdocno = g_xrcgdocno_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xrcg_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xrcg_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xrcg_m.xrcgld
               LET gs_keys_bak[1] = g_xrcgld_t
               LET gs_keys[2] = g_xrcg_m.xrcgdocno
               LET gs_keys_bak[2] = g_xrcgdocno_t
               LET gs_keys[3] = g_xrcg_d[g_detail_idx].xrcgseq
               LET gs_keys_bak[3] = g_xrcg_d_t.xrcgseq
               CALL axrt360_update_b('xrcg_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_xrcg_m_t)
                     #LET g_log2 = util.JSON.stringify(g_xrcg_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL axrt360_xrcg_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL axrt360_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_xrcgld_t = g_xrcg_m.xrcgld
           LET g_xrcgdocno_t = g_xrcg_m.xrcgdocno
 
           
           IF g_xrcg_d.getLength() = 0 THEN
              NEXT FIELD xrcgseq
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="axrt360.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_xrcg_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xrcg_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axrt360_b_fill(g_wc2) #test 
            #如果一直都在單頭則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_detail_idx)
            END IF
            LET g_loc = 'm' 
            LET g_current_page = 1
            #add-point:資料輸入前 name="input.body.before_input"
            SELECT COUNT(1) INTO l_n
              FROM xrcg_t
             WHERE xrcgent = g_enterprise
               AND xrcgld = g_xrcg_m.xrcgld
               AND xrcgdocno = g_xrcg_m.xrcgdocno
               
            IF l_n = 0 THEN 
               CALL axrt360_01(g_xrcg_m.xrcgcomp,g_xrcg_m.xrcgld,g_xrcg_m.xrcgsite,
                               g_xrcg_m.xrcgdocno,g_xrcg_m.xrcgdocdt,g_xrcg_m.xrcg001,g_xrcg_m.xrcg010)  #170210-00018#1 add g_xrcg_m.xrcgdocdt lujh
               RETURNING l_type,l_docno
               
               LET l_n = 0
               SELECT COUNT(1) INTO l_n
                 FROM xrcg_t
                WHERE xrcgent = g_enterprise
                  AND xrcgld = g_xrcg_m.xrcgld
                  AND xrcgdocno = l_docno
               
               IF l_type = '2' AND l_n > 0 THEN 
                  #組合新增資料的條件
                  LET g_add_browse = " xrcgent = " ||g_enterprise|| " AND",
                                     " xrcgld = '", g_xrcg_m.xrcgld, "' "
                                     ," AND xrcgdocno = '", l_docno, "' "
                  
                  #填到最後面
                  LET g_current_idx = 1
                  CALL axrt360_browser_fill("")
                  CALL g_browser.clear()

               END IF
            END IF
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
            CALL axrt360_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN axrt360_cl USING g_enterprise,g_xrcg_m.xrcgld,g_xrcg_m.xrcgdocno                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE axrt360_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axrt360_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_xrcg_d[l_ac].xrcgseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_xrcg_d_t.* = g_xrcg_d[l_ac].*  #BACKUP
               LET g_xrcg_d_o.* = g_xrcg_d[l_ac].*  #BACKUP
               CALL axrt360_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL axrt360_set_no_entry_b(l_cmd)
               OPEN axrt360_bcl USING g_enterprise,g_xrcg_m.xrcgld,
                                                g_xrcg_m.xrcgdocno,
 
                                                g_xrcg_d_t.xrcgseq
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axrt360_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axrt360_bcl INTO g_xrcg_d[l_ac].xrcgseq,g_xrcg_d[l_ac].xrcg002,g_xrcg_d[l_ac].xrcg003, 
                      g_xrcg_d[l_ac].xrcg004,g_xrcg_d[l_ac].xrcg005,g_xrcg_d[l_ac].xrcg006,g_xrcg_d[l_ac].xrcg007, 
                      g_xrcg_d[l_ac].xrcg008,g_xrcg_d[l_ac].xrcg009,g_xrcg2_d[l_ac].xrcgseq,g_xrcg2_d[l_ac].xrcgownid, 
                      g_xrcg2_d[l_ac].xrcgowndp,g_xrcg2_d[l_ac].xrcgcrtid,g_xrcg2_d[l_ac].xrcgcrtdp, 
                      g_xrcg2_d[l_ac].xrcgcrtdt,g_xrcg2_d[l_ac].xrcgmodid,g_xrcg2_d[l_ac].xrcgmoddt, 
                      g_xrcg2_d[l_ac].xrcgcnfid,g_xrcg2_d[l_ac].xrcgcnfdt,g_xrcg2_d[l_ac].xrcgpstid, 
                      g_xrcg2_d[l_ac].xrcgpstdt
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_xrcg_d_t.xrcgseq,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xrcg_d_mask_o[l_ac].* =  g_xrcg_d[l_ac].*
                  CALL axrt360_xrcg_t_mask()
                  LET g_xrcg_d_mask_n[l_ac].* =  g_xrcg_d[l_ac].*
                  
                  CALL axrt360_ref_show()
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
            INITIALIZE g_xrcg_d_t.* TO NULL
            INITIALIZE g_xrcg_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xrcg_d[l_ac].* TO NULL
            #公用欄位預設值
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_xrcg2_d[l_ac].xrcgownid = g_user
      LET g_xrcg2_d[l_ac].xrcgowndp = g_dept
      LET g_xrcg2_d[l_ac].xrcgcrtid = g_user
      LET g_xrcg2_d[l_ac].xrcgcrtdp = g_dept 
      LET g_xrcg2_d[l_ac].xrcgcrtdt = cl_get_current()
      LET g_xrcg2_d[l_ac].xrcgmodid = g_user
      LET g_xrcg2_d[l_ac].xrcgmoddt = cl_get_current()
 
 
  
            #一般欄位預設值
            
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            SELECT MAX(xrcgseq) INTO g_xrcg_d[l_ac].xrcgseq FROM xrcg_t
             WHERE xrcgent = g_enterprise AND xrcgld = g_xrcg_m.xrcgld
               AND xrcgdocno = g_xrcg_m.xrcgdocno
            IF cl_null(g_xrcg_d[l_ac].xrcgseq) THEN 
               LET g_xrcg_d[l_ac].xrcgseq = 1
            ELSE
               LET g_xrcg_d[l_ac].xrcgseq = g_xrcg_d[l_ac].xrcgseq+1               
            END IF
            #end add-point
            LET g_xrcg_d_t.* = g_xrcg_d[l_ac].*     #新輸入資料
            LET g_xrcg_d_o.* = g_xrcg_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axrt360_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL axrt360_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xrcg_d[li_reproduce_target].* = g_xrcg_d[li_reproduce].*
               LET g_xrcg2_d[li_reproduce_target].* = g_xrcg2_d[li_reproduce].*
 
               LET g_xrcg_d[g_xrcg_d.getLength()].xrcgseq = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM xrcg_t 
             WHERE xrcgent = g_enterprise AND xrcgld = g_xrcg_m.xrcgld
               AND xrcgdocno = g_xrcg_m.xrcgdocno
 
               AND xrcgseq = g_xrcg_d[l_ac].xrcgseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               SELECT glaa003,glaa024 INTO l_glaa003,l_glaa024 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xrcg_m.xrcgld
               CALL s_aooi200_fin_gen_docno(g_xrcg_m.xrcgld,l_glaa024,l_glaa003,g_xrcg_m.xrcgdocno,g_xrcg_m.xrcgdocdt,g_prog)
               RETURNING l_success,g_xrcg_m.xrcgdocno
               IF l_success  = 0  THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_xrcg_m.xrcgdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                
                  NEXT FIELD xrcgdocno
               END IF
               DISPLAY BY NAME g_xrcg_m.xrcgdocno
               #end add-point
               INSERT INTO xrcg_t
                           (xrcgent,
                            xrcgcomp,xrcgld,xrcgsite,xrcgdocno,xrcgdocdt,xrcg001,xrcg010,xrcgstus,
                            xrcgseq
                            ,xrcg002,xrcg003,xrcg004,xrcg005,xrcg006,xrcg007,xrcg008,xrcg009,xrcgownid,xrcgowndp,xrcgcrtid,xrcgcrtdp,xrcgcrtdt,xrcgmodid,xrcgmoddt,xrcgcnfid,xrcgcnfdt,xrcgpstid,xrcgpstdt) 
                     VALUES(g_enterprise,
                            g_xrcg_m.xrcgcomp,g_xrcg_m.xrcgld,g_xrcg_m.xrcgsite,g_xrcg_m.xrcgdocno,g_xrcg_m.xrcgdocdt,g_xrcg_m.xrcg001,g_xrcg_m.xrcg010,g_xrcg_m.xrcgstus,
                            g_xrcg_d[l_ac].xrcgseq
                            ,g_xrcg_d[l_ac].xrcg002,g_xrcg_d[l_ac].xrcg003,g_xrcg_d[l_ac].xrcg004,g_xrcg_d[l_ac].xrcg005, 
                                g_xrcg_d[l_ac].xrcg006,g_xrcg_d[l_ac].xrcg007,g_xrcg_d[l_ac].xrcg008, 
                                g_xrcg_d[l_ac].xrcg009,g_xrcg2_d[l_ac].xrcgownid,g_xrcg2_d[l_ac].xrcgowndp, 
                                g_xrcg2_d[l_ac].xrcgcrtid,g_xrcg2_d[l_ac].xrcgcrtdp,g_xrcg2_d[l_ac].xrcgcrtdt, 
                                g_xrcg2_d[l_ac].xrcgmodid,g_xrcg2_d[l_ac].xrcgmoddt,g_xrcg2_d[l_ac].xrcgcnfid, 
                                g_xrcg2_d[l_ac].xrcgcnfdt,g_xrcg2_d[l_ac].xrcgpstid,g_xrcg2_d[l_ac].xrcgpstdt) 
 
               #add-point:單身新增中 name="input.body.m_insert"
               
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_xrcg_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "xrcg_t:",SQLERRMESSAGE 
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
               IF axrt360_before_delete() THEN 
                  
 
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_xrcg_m.xrcgld
                  LET gs_keys[gs_keys.getLength()+1] = g_xrcg_m.xrcgdocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_xrcg_d_t.xrcgseq
 
 
                  #刪除下層單身
                  IF NOT axrt360_key_delete_b(gs_keys,'xrcg_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE axrt360_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE axrt360_bcl
               LET l_count = g_xrcg_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_xrcg_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcgseq
            #add-point:BEFORE FIELD xrcgseq name="input.b.page1.xrcgseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcgseq
            
            #add-point:AFTER FIELD xrcgseq name="input.a.page1.xrcgseq"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_xrcg_m.xrcgld IS NOT NULL AND g_xrcg_m.xrcgdocno IS NOT NULL AND g_xrcg_d[g_detail_idx].xrcgseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xrcg_m.xrcgld != g_xrcgld_t OR g_xrcg_m.xrcgdocno != g_xrcgdocno_t OR g_xrcg_d[g_detail_idx].xrcgseq != g_xrcg_d_t.xrcgseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xrcg_t WHERE "||"xrcgent = " ||g_enterprise|| " AND "||"xrcgld = '"||g_xrcg_m.xrcgld ||"' AND "|| "xrcgdocno = '"||g_xrcg_m.xrcgdocno ||"' AND "|| "xrcgseq = '"||g_xrcg_d[g_detail_idx].xrcgseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcgseq
            #add-point:ON CHANGE xrcgseq name="input.g.page1.xrcgseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcg002
            #add-point:BEFORE FIELD xrcg002 name="input.b.page1.xrcg002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcg002
            
            #add-point:AFTER FIELD xrcg002 name="input.a.page1.xrcg002"
            IF NOT cl_null(g_xrcg_d[l_ac].xrcg002) THEN 
               CALL axrt360_xrcg002_xrcg003_chk(g_xrcg_d[l_ac].xrcg002,g_xrcg_d[l_ac].xrcg003)
               IF NOT cl_null(g_errno) THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_xrcg_d[l_ac].xrcg002 
                  LET g_errparam.code = g_errno
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  LET g_xrcg_d[l_ac].xrcg002 = g_xrcg_d_t.xrcg002
                  CALL axrt360_xrcg002_xrcg003_get(g_xrcg_d[l_ac].xrcg002,g_xrcg_d[l_ac].xrcg003)
                  NEXT FIELD CURRENT
               END IF
               CALL axrt360_xrcg002_xrcg003_get(g_xrcg_d[l_ac].xrcg002,g_xrcg_d[l_ac].xrcg003)
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcg002
            #add-point:ON CHANGE xrcg002 name="input.g.page1.xrcg002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca001
            #add-point:BEFORE FIELD xrca001 name="input.b.page1.xrca001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca001
            
            #add-point:AFTER FIELD xrca001 name="input.a.page1.xrca001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca001
            #add-point:ON CHANGE xrca001 name="input.g.page1.xrca001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcg003
            #add-point:BEFORE FIELD xrcg003 name="input.b.page1.xrcg003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcg003
            
            #add-point:AFTER FIELD xrcg003 name="input.a.page1.xrcg003"
            IF NOT cl_null(g_xrcg_d[l_ac].xrcg003) THEN 
               CALL axrt360_xrcg002_xrcg003_chk(g_xrcg_d[l_ac].xrcg002,g_xrcg_d[l_ac].xrcg003)
               IF NOT cl_null(g_errno) THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_xrcg_d[l_ac].xrcg003
                  LET g_errparam.code = g_errno
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  LET g_xrcg_d[l_ac].xrcg003 = g_xrcg_d_t.xrcg003
                  CALL axrt360_xrcg002_xrcg003_get(g_xrcg_d[l_ac].xrcg002,g_xrcg_d[l_ac].xrcg003)
                  NEXT FIELD CURRENT
               END IF
               CALL axrt360_xrcg002_xrcg003_get(g_xrcg_d[l_ac].xrcg002,g_xrcg_d[l_ac].xrcg003)
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcg003
            #add-point:ON CHANGE xrcg003 name="input.g.page1.xrcg003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcg004
            
            #add-point:AFTER FIELD xrcg004 name="input.a.page1.xrcg004"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xrcg_d[l_ac].xrcg004
            CALL ap_ref_array2(g_ref_fields,"SELECT ooibl004 FROM ooibl_t WHERE ooiblent="||g_enterprise||" AND ooibl002=? AND ooibl003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xrcg_d[l_ac].xrcg004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xrcg_d[l_ac].xrcg004_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcg004
            #add-point:BEFORE FIELD xrcg004 name="input.b.page1.xrcg004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcg004
            #add-point:ON CHANGE xrcg004 name="input.g.page1.xrcg004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcg005
            
            #add-point:AFTER FIELD xrcg005 name="input.a.page1.xrcg005"
            IF NOT cl_null(g_xrcg_d[l_ac].xrcg005) THEN
               IF g_xrcg_d[l_ac].xrcg005 != g_xrcg_d_t.xrcg005 OR cl_null(g_xrcg_d_t.xrcg005) THEN  
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_xrcg_d[l_ac].xrcg005
                  LET g_chkparam.arg2 = ' '
                  LET g_errshow = TRUE 
                  LET g_chkparam.err_str[1] = "apm-00184:sub-01302|aooi714|",cl_get_progname("aooi714",g_lang,"2"),"|:EXEPROGaooi714"
                  IF NOT cl_chk_exist("v_ooib002_1") THEN
                     CALL s_axrt300_xrca_ref('xrca008',g_xrcg_d[l_ac].xrcg005,'','') RETURNING l_success,g_xrcg_d[l_ac].xrcg005_desc
                     DISPLAY BY NAME g_xrcg_d[l_ac].xrcg005_desc
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(g_xrcg_m.xrcg001) THEN
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_chkparam.arg1 = g_xrcg_m.xrcg001
                     LET g_chkparam.arg2 = g_xrcg_d[l_ac].xrcg005
                     LET g_chkparam.arg3 = '2'
                     LET g_errshow = TRUE 
                     LET g_chkparam.err_str[1] = "axm-00029:sub-01302|axmm200|",cl_get_progname("axmm200",g_lang,"2"),"|:EXEPROGaxmm200"
                     IF NOT cl_chk_exist("v_pmad002_3") THEN
                        CALL s_axrt300_xrca_ref('xrca008',g_xrcg_d[l_ac].xrcg005,'','') RETURNING l_success,g_xrcg_d[l_ac].xrcg005_desc
                        DISPLAY BY NAME g_xrcg_d[l_ac].xrcg005_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  #應收日期/票據到期日 
                  #發票日期結合收款條件計算應收款日
                  SELECT xrcadocdt,xrca061 INTO l_xrcadocdt,l_xrca061
                    FROM xrca_t
                   WHERE xrcaent = g_enterprise
                     AND xrcadocno = g_xrcg_d[l_ac].xrcg002
                  
                  CALL s_fin_date_ar_receivable(g_xrcg_m.xrcgcomp,g_xrcg_m.xrcg001,g_xrcg_d[l_ac].xrcg005,l_xrcadocdt,
                    l_xrca061,l_xrcadocdt,l_xrcadocdt) RETURNING l_success,g_xrcg_d[l_ac].xrcg007,g_xrcg_d[l_ac].xrcg009 
               END IF
            END IF
            CALL s_axrt300_xrca_ref('xrca008',g_xrcg_d[l_ac].xrcg005,'','') RETURNING l_success,g_xrcg_d[l_ac].xrcg005_desc
            DISPLAY BY NAME g_xrcg_d[l_ac].xrcg005_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcg005
            #add-point:BEFORE FIELD xrcg005 name="input.b.page1.xrcg005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcg005
            #add-point:ON CHANGE xrcg005 name="input.g.page1.xrcg005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcg006
            #add-point:BEFORE FIELD xrcg006 name="input.b.page1.xrcg006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcg006
            
            #add-point:AFTER FIELD xrcg006 name="input.a.page1.xrcg006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcg006
            #add-point:ON CHANGE xrcg006 name="input.g.page1.xrcg006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcg007
            #add-point:BEFORE FIELD xrcg007 name="input.b.page1.xrcg007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcg007
            
            #add-point:AFTER FIELD xrcg007 name="input.a.page1.xrcg007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcg007
            #add-point:ON CHANGE xrcg007 name="input.g.page1.xrcg007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcg008
            #add-point:BEFORE FIELD xrcg008 name="input.b.page1.xrcg008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcg008
            
            #add-point:AFTER FIELD xrcg008 name="input.a.page1.xrcg008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcg008
            #add-point:ON CHANGE xrcg008 name="input.g.page1.xrcg008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcg009
            #add-point:BEFORE FIELD xrcg009 name="input.b.page1.xrcg009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcg009
            
            #add-point:AFTER FIELD xrcg009 name="input.a.page1.xrcg009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcg009
            #add-point:ON CHANGE xrcg009 name="input.g.page1.xrcg009"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.xrcgseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcgseq
            #add-point:ON ACTION controlp INFIELD xrcgseq name="input.c.page1.xrcgseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrcg002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcg002
            #add-point:ON ACTION controlp INFIELD xrcg002 name="input.c.page1.xrcg002"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_xrcg_d[l_ac].xrcg002    #单号
            LET g_qryparam.default2 = g_xrcg_d[l_ac].xrcg003    #項次
            LET g_qryparam.default3 = g_xrcg_d[l_ac].xrcg004    #原收款条件
            LET g_qryparam.default4 = g_xrcg_d[l_ac].xrcg006    #原收款日
            LET g_qryparam.default5 = g_xrcg_d[l_ac].xrcg008    #原票到期日
            
            LET g_qryparam.where = " xrca001 IN (SELECT gzcb002 FROM gzcb_t WHERE gzcb001 = '8302' AND gzcb005 IN ('axrt300','axrt310','axrt330'))",
                                   " AND xrcc109 = 0 AND xrcastus = 'Y' AND xrccld = '",g_xrcg_m.xrcgld,"'",
                                   " AND xrca004 = '",g_xrcg_m.xrcg001,"'",
                                   " AND xrccdocno||xrccseq NOT IN (SELECT xrcg002||xrcg003 FROM xrcg_t ",
                                   "                                 WHERE xrcgent = ",g_enterprise,
                                   "                                   AND xrcgld = '",g_xrcg_m.xrcgld,"'",
                                   "                                   AND xrcgstus <> 'Y' ",
                                   "                               )"
            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_xrccdocno()                                #呼叫開窗
 
            LET g_xrcg_d[l_ac].xrcg002 = g_qryparam.return1              
            LET g_xrcg_d[l_ac].xrcg003 = g_qryparam.return2 
            LET g_xrcg_d[l_ac].xrcg004 = g_qryparam.return3 
            LET g_xrcg_d[l_ac].xrcg006 = g_qryparam.return4 
            LET g_xrcg_d[l_ac].xrcg008 = g_qryparam.return5 
            DISPLAY g_xrcg_d[l_ac].xrcg002 TO xrcg002   #单号
            DISPLAY g_xrcg_d[l_ac].xrcg003 TO xrcg003   #項次
            DISPLAY g_xrcg_d[l_ac].xrcg004 TO xrcg004   #原收款条件
            DISPLAY g_xrcg_d[l_ac].xrcg006 TO xrcg006   #原收款日
            DISPLAY g_xrcg_d[l_ac].xrcg008 TO xrcg008   #原票到期日
            CALL s_axrt300_xrca_ref('xrca008',g_xrcg_d[l_ac].xrcg004,'','') RETURNING l_success,g_xrcg_d[l_ac].xrcg004_desc
            DISPLAY BY NAME g_xrcg_d[l_ac].xrcg004_desc
            NEXT FIELD xrcg002                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.xrca001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca001
            #add-point:ON ACTION controlp INFIELD xrca001 name="input.c.page1.xrca001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrcg003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcg003
            #add-point:ON ACTION controlp INFIELD xrcg003 name="input.c.page1.xrcg003"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_xrcg_d[l_ac].xrcg003    #单号
            LET g_qryparam.default2 = g_xrcg_d[l_ac].xrcg004    #原收款条件
            LET g_qryparam.default3 = g_xrcg_d[l_ac].xrcg006    #原收款日
            LET g_qryparam.default4 = g_xrcg_d[l_ac].xrcg008    #原票到期日
            
            LET g_qryparam.where = " xrca001 IN (SELECT gzcb002 FROM gzcb_t WHERE gzcb001 = '8302' AND gzcb005 IN ('axrt300','axrt310','axrt330'))",
                                   " AND xrcc109 = 0 AND xrcastus = 'Y' AND xrccld = '",g_xrcg_m.xrcgld,"'",
                                   " AND xrccdocno = '",g_xrcg_d[l_ac].xrcg002,"'",
                                   " AND xrca004 = '",g_xrcg_m.xrcg001,"'",
                                   " AND xrccdocno||xrccseq NOT IN (SELECT xrcg002||xrcg003 FROM xrcg_t ",
                                   "                                 WHERE xrcgent = ",g_enterprise,
                                   "                                   AND xrcgld = '",g_xrcg_m.xrcgld,"'",
                                   "                                   AND xrcgstus <> 'Y' ",
                                   "                               )"
            
            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_xrccseq()                                #呼叫開窗
 
            LET g_xrcg_d[l_ac].xrcg003 = g_qryparam.return1              
            LET g_xrcg_d[l_ac].xrcg004 = g_qryparam.return2 
            LET g_xrcg_d[l_ac].xrcg006 = g_qryparam.return3 
            LET g_xrcg_d[l_ac].xrcg008 = g_qryparam.return4  
            DISPLAY g_xrcg_d[l_ac].xrcg003 TO xrcg003   #項次
            DISPLAY g_xrcg_d[l_ac].xrcg004 TO xrcg004   #原收款条件
            DISPLAY g_xrcg_d[l_ac].xrcg006 TO xrcg006   #原收款日
            DISPLAY g_xrcg_d[l_ac].xrcg008 TO xrcg008   #原票到期日
            CALL s_axrt300_xrca_ref('xrca008',g_xrcg_d[l_ac].xrcg004,'','') RETURNING l_success,g_xrcg_d[l_ac].xrcg004_desc
            DISPLAY BY NAME g_xrcg_d[l_ac].xrcg004_desc
            NEXT FIELD xrcg003                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.xrcg004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcg004
            #add-point:ON ACTION controlp INFIELD xrcg004 name="input.c.page1.xrcg004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrcg005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcg005
            #add-point:ON ACTION controlp INFIELD xrcg005 name="input.c.page1.xrcg005"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_xrcg_d[l_ac].xrcg005             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_xrcg_m.xrcg001
            LET g_qryparam.arg2 = '2'

 
            CALL q_pmad002()                                #呼叫開窗
 
            LET g_xrcg_d[l_ac].xrcg005 = g_qryparam.return1              

            DISPLAY g_xrcg_d[l_ac].xrcg005 TO xrcg005              #
            CALL s_axrt300_xrca_ref('xrca008',g_xrcg_d[l_ac].xrcg005,'','') RETURNING l_success,g_xrcg_d[l_ac].xrcg005_desc
            DISPLAY BY NAME g_xrcg_d[l_ac].xrcg005_desc
            NEXT FIELD xrcg005                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.xrcg006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcg006
            #add-point:ON ACTION controlp INFIELD xrcg006 name="input.c.page1.xrcg006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrcg007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcg007
            #add-point:ON ACTION controlp INFIELD xrcg007 name="input.c.page1.xrcg007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrcg008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcg008
            #add-point:ON ACTION controlp INFIELD xrcg008 name="input.c.page1.xrcg008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrcg009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcg009
            #add-point:ON ACTION controlp INFIELD xrcg009 name="input.c.page1.xrcg009"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_xrcg_d[l_ac].* = g_xrcg_d_t.*
               CLOSE axrt360_bcl
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
               LET g_errparam.extend = g_xrcg_d[l_ac].xrcgseq 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_xrcg_d[l_ac].* = g_xrcg_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               LET g_xrcg2_d[l_ac].xrcgmodid = g_user 
LET g_xrcg2_d[l_ac].xrcgmoddt = cl_get_current()
LET g_xrcg2_d[l_ac].xrcgmodid_desc = cl_get_username(g_xrcg2_d[l_ac].xrcgmodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
         
               #將遮罩欄位還原
               CALL axrt360_xrcg_t_mask_restore('restore_mask_o')
         
               UPDATE xrcg_t SET (xrcgld,xrcgdocno,xrcgseq,xrcg002,xrcg003,xrcg004,xrcg005,xrcg006,xrcg007, 
                   xrcg008,xrcg009,xrcgownid,xrcgowndp,xrcgcrtid,xrcgcrtdp,xrcgcrtdt,xrcgmodid,xrcgmoddt, 
                   xrcgcnfid,xrcgcnfdt,xrcgpstid,xrcgpstdt) = (g_xrcg_m.xrcgld,g_xrcg_m.xrcgdocno,g_xrcg_d[l_ac].xrcgseq, 
                   g_xrcg_d[l_ac].xrcg002,g_xrcg_d[l_ac].xrcg003,g_xrcg_d[l_ac].xrcg004,g_xrcg_d[l_ac].xrcg005, 
                   g_xrcg_d[l_ac].xrcg006,g_xrcg_d[l_ac].xrcg007,g_xrcg_d[l_ac].xrcg008,g_xrcg_d[l_ac].xrcg009, 
                   g_xrcg2_d[l_ac].xrcgownid,g_xrcg2_d[l_ac].xrcgowndp,g_xrcg2_d[l_ac].xrcgcrtid,g_xrcg2_d[l_ac].xrcgcrtdp, 
                   g_xrcg2_d[l_ac].xrcgcrtdt,g_xrcg2_d[l_ac].xrcgmodid,g_xrcg2_d[l_ac].xrcgmoddt,g_xrcg2_d[l_ac].xrcgcnfid, 
                   g_xrcg2_d[l_ac].xrcgcnfdt,g_xrcg2_d[l_ac].xrcgpstid,g_xrcg2_d[l_ac].xrcgpstdt)
                WHERE xrcgent = g_enterprise AND xrcgld = g_xrcg_m.xrcgld 
                 AND xrcgdocno = g_xrcg_m.xrcgdocno 
 
                 AND xrcgseq = g_xrcg_d_t.xrcgseq #項次   
 
                 
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xrcg_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "xrcg_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xrcg_m.xrcgld
               LET gs_keys_bak[1] = g_xrcgld_t
               LET gs_keys[2] = g_xrcg_m.xrcgdocno
               LET gs_keys_bak[2] = g_xrcgdocno_t
               LET gs_keys[3] = g_xrcg_d[g_detail_idx].xrcgseq
               LET gs_keys_bak[3] = g_xrcg_d_t.xrcgseq
               CALL axrt360_update_b('xrcg_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_xrcg_m),util.JSON.stringify(g_xrcg_d_t)
                     LET g_log2 = util.JSON.stringify(g_xrcg_m),util.JSON.stringify(g_xrcg_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL axrt360_xrcg_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_xrcg_m.xrcgld
               LET ls_keys[ls_keys.getLength()+1] = g_xrcg_m.xrcgdocno
 
               LET ls_keys[ls_keys.getLength()+1] = g_xrcg_d_t.xrcgseq
 
               CALL axrt360_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE axrt360_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xrcg_d[l_ac].* = g_xrcg_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE axrt360_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_xrcg_d.getLength() = 0 THEN
               NEXT FIELD xrcgseq
            END IF
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_xrcg_d[li_reproduce_target].* = g_xrcg_d[li_reproduce].*
               LET g_xrcg2_d[li_reproduce_target].* = g_xrcg2_d[li_reproduce].*
 
               LET g_xrcg_d[li_reproduce_target].xrcgseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_xrcg_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xrcg_d.getLength()+1
            END IF
            
      END INPUT
 
 
      
      DISPLAY ARRAY g_xrcg2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
      
         BEFORE ROW
            CALL axrt360_b_fill(g_wc2) #test 
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_page = 2
            CALL axrt360_idx_chk()
            CALL axrt360_ui_detailshow()
        
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
            NEXT FIELD xrcgld
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD xrcgseq
               WHEN "s_detail2"
                  NEXT FIELD xrcgseq_2
 
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
 
{<section id="axrt360.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION axrt360_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL axrt360_b_fill(g_wc2) #第一階單身填充
      CALL axrt360_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL axrt360_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_xrcg_m.xrcgcomp,g_xrcg_m.xrcgcomp_desc,g_xrcg_m.xrcgld,g_xrcg_m.xrcgld_desc,g_xrcg_m.xrcgsite, 
       g_xrcg_m.xrcgsite_desc,g_xrcg_m.xrcgdocno,g_xrcg_m.xrcgdocdt,g_xrcg_m.xrcg001,g_xrcg_m.xrcg001_desc, 
       g_xrcg_m.xrcg010,g_xrcg_m.xrcg010_desc,g_xrcg_m.xrcgstus
 
   CALL axrt360_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
   CASE g_xrcg_m.xrcgstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")  
   END CASE
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="axrt360.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION axrt360_ref_show()
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
   FOR l_ac = 1 TO g_xrcg_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_xrcg2_d.getLength()
      #add-point:ref_show段d2_reference name="ref_show.body2.reference"
      
      #end add-point
   END FOR
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="axrt360.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION axrt360_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE xrcg_t.xrcgld 
   DEFINE l_oldno     LIKE xrcg_t.xrcgld 
   DEFINE l_newno02     LIKE xrcg_t.xrcgdocno 
   DEFINE l_oldno02     LIKE xrcg_t.xrcgdocno 
 
   DEFINE l_master    RECORD LIKE xrcg_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE xrcg_t.* #此變數樣板目前無使用
 
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
 
   IF g_xrcg_m.xrcgld IS NULL
      OR g_xrcg_m.xrcgdocno IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_xrcgld_t = g_xrcg_m.xrcgld
   LET g_xrcgdocno_t = g_xrcg_m.xrcgdocno
 
   
   LET g_xrcg_m.xrcgld = ""
   LET g_xrcg_m.xrcgdocno = ""
 
   LET g_master_insert = FALSE
   CALL axrt360_set_entry('a')
   CALL axrt360_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #清空key欄位的desc
      LET g_xrcg_m.xrcgld_desc = ''
   DISPLAY BY NAME g_xrcg_m.xrcgld_desc
 
   
   CALL axrt360_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_xrcg_m.* TO NULL
      INITIALIZE g_xrcg_d TO NULL
      INITIALIZE g_xrcg2_d TO NULL
 
      CALL axrt360_show()
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
   CALL axrt360_set_act_visible()
   CALL axrt360_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_xrcgld_t = g_xrcg_m.xrcgld
   LET g_xrcgdocno_t = g_xrcg_m.xrcgdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " xrcgent = " ||g_enterprise|| " AND",
                      " xrcgld = '", g_xrcg_m.xrcgld, "' "
                      ," AND xrcgdocno = '", g_xrcg_m.xrcgdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axrt360_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL axrt360_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL axrt360_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="axrt360.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION axrt360_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE xrcg_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE axrt360_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xrcg_t
    WHERE xrcgent = g_enterprise AND xrcgld = g_xrcgld_t
    AND xrcgdocno = g_xrcgdocno_t
 
       INTO TEMP axrt360_detail
   
   #將key修正為調整後   
   UPDATE axrt360_detail 
      #更新key欄位
      SET xrcgld = g_xrcg_m.xrcgld
          , xrcgdocno = g_xrcg_m.xrcgdocno
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
       , xrcgownid = g_user 
       , xrcgowndp = g_dept
       , xrcgcrtid = g_user
       , xrcgcrtdp = g_dept 
       , xrcgcrtdt = ld_date
       , xrcgmodid = g_user
       , xrcgmoddt = ld_date
 
 
 
                                       
   #將資料塞回原table   
   INSERT INTO xrcg_t SELECT * FROM axrt360_detail
   
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
   DROP TABLE axrt360_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_xrcgld_t = g_xrcg_m.xrcgld
   LET g_xrcgdocno_t = g_xrcg_m.xrcgdocno
 
   
   DROP TABLE axrt360_detail
   
END FUNCTION
 
{</section>}
 
{<section id="axrt360.delete" >}
#+ 資料刪除
PRIVATE FUNCTION axrt360_delete()
   #add-point:delete段define name="delete.define_customerization"
   
   #end add-point
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE  l_success       LIKE type_t.num5 
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_xrcg_m.xrcgld IS NULL
   OR g_xrcg_m.xrcgdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN axrt360_cl USING g_enterprise,g_xrcg_m.xrcgld,g_xrcg_m.xrcgdocno
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axrt360_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE axrt360_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axrt360_master_referesh USING g_xrcg_m.xrcgld,g_xrcg_m.xrcgdocno INTO g_xrcg_m.xrcgcomp,g_xrcg_m.xrcgld, 
       g_xrcg_m.xrcgsite,g_xrcg_m.xrcgdocno,g_xrcg_m.xrcgdocdt,g_xrcg_m.xrcg001,g_xrcg_m.xrcg010,g_xrcg_m.xrcgstus, 
       g_xrcg_m.xrcgcomp_desc,g_xrcg_m.xrcgld_desc,g_xrcg_m.xrcgsite_desc,g_xrcg_m.xrcg001_desc,g_xrcg_m.xrcg010_desc 
 
   
   #遮罩相關處理
   LET g_xrcg_m_mask_o.* =  g_xrcg_m.*
   CALL axrt360_xrcg_t_mask()
   LET g_xrcg_m_mask_n.* =  g_xrcg_m.*
   
   CALL axrt360_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL axrt360_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      #170210-00018#1--add--str--lujh
      #檢查當單據日期小於等於關帳日期時，不可異動單據
      CALL s_fin_date_close_chk('',g_xrcg_m.xrcgcomp,'AXR',g_xrcg_m.xrcgdocdt) RETURNING l_success
      IF l_success = FALSE THEN
         CLOSE axrt360_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #170210-00018#1--add--end--lujh
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM xrcg_t WHERE xrcgent = g_enterprise AND xrcgld = g_xrcg_m.xrcgld
                                                               AND xrcgdocno = g_xrcg_m.xrcgdocno
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xrcg_t:",SQLERRMESSAGE 
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
      #   CLOSE axrt360_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_xrcg_d.clear() 
      CALL g_xrcg2_d.clear()       
 
     
      CALL axrt360_ui_browser_refresh()  
      #CALL axrt360_ui_headershow()  
      #CALL axrt360_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL axrt360_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL axrt360_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE axrt360_cl
 
   #功能已完成,通報訊息中心
   CALL axrt360_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="axrt360.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axrt360_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #先清空單身變數內容
   CALL g_xrcg_d.clear()
   CALL g_xrcg2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT xrcgseq,xrcg002,xrcg003,xrcg004,xrcg005,xrcg006,xrcg007,xrcg008,xrcg009, 
       xrcgseq,xrcgownid,xrcgowndp,xrcgcrtid,xrcgcrtdp,xrcgcrtdt,xrcgmodid,xrcgmoddt,xrcgcnfid,xrcgcnfdt, 
       xrcgpstid,xrcgpstdt,t1.ooibl004 ,t2.ooibl004 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011 ,t6.ooefl003 , 
       t7.ooag011 ,t8.ooag011 ,t9.ooag011 FROM xrcg_t",   
               "",
               
                              " LEFT JOIN ooibl_t t1 ON t1.ooiblent="||g_enterprise||" AND t1.ooibl002=xrcg004 AND t1.ooibl003='"||g_dlang||"' ",
               " LEFT JOIN ooibl_t t2 ON t2.ooiblent="||g_enterprise||" AND t2.ooibl002=xrcg005 AND t2.ooibl003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=xrcgownid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=xrcgowndp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=xrcgcrtid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=xrcgcrtdp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=xrcgmodid  ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=xrcgcnfid  ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=xrcgpstid  ",
 
               " WHERE xrcgent= ? AND xrcgld=? AND xrcgdocno=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xrcg_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF axrt360_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY xrcg_t.xrcgseq"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
         
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axrt360_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR axrt360_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_xrcg_m.xrcgld,g_xrcg_m.xrcgdocno   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_xrcg_m.xrcgld,g_xrcg_m.xrcgdocno INTO g_xrcg_d[l_ac].xrcgseq, 
          g_xrcg_d[l_ac].xrcg002,g_xrcg_d[l_ac].xrcg003,g_xrcg_d[l_ac].xrcg004,g_xrcg_d[l_ac].xrcg005, 
          g_xrcg_d[l_ac].xrcg006,g_xrcg_d[l_ac].xrcg007,g_xrcg_d[l_ac].xrcg008,g_xrcg_d[l_ac].xrcg009, 
          g_xrcg2_d[l_ac].xrcgseq,g_xrcg2_d[l_ac].xrcgownid,g_xrcg2_d[l_ac].xrcgowndp,g_xrcg2_d[l_ac].xrcgcrtid, 
          g_xrcg2_d[l_ac].xrcgcrtdp,g_xrcg2_d[l_ac].xrcgcrtdt,g_xrcg2_d[l_ac].xrcgmodid,g_xrcg2_d[l_ac].xrcgmoddt, 
          g_xrcg2_d[l_ac].xrcgcnfid,g_xrcg2_d[l_ac].xrcgcnfdt,g_xrcg2_d[l_ac].xrcgpstid,g_xrcg2_d[l_ac].xrcgpstdt, 
          g_xrcg_d[l_ac].xrcg004_desc,g_xrcg_d[l_ac].xrcg005_desc,g_xrcg2_d[l_ac].xrcgownid_desc,g_xrcg2_d[l_ac].xrcgowndp_desc, 
          g_xrcg2_d[l_ac].xrcgcrtid_desc,g_xrcg2_d[l_ac].xrcgcrtdp_desc,g_xrcg2_d[l_ac].xrcgmodid_desc, 
          g_xrcg2_d[l_ac].xrcgcnfid_desc,g_xrcg2_d[l_ac].xrcgpstid_desc   #(ver:49)
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充 name="b_fill.fill"
         SELECT xrca001 INTO g_xrcg_d[l_ac].xrca001
           FROM xrca_t
          WHERE xrcaent = g_enterprise
            AND xrcald = g_xrcg_m.xrcgld
            AND xrcadocno = g_xrcg_d[l_ac].xrcg002
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
 
            CALL g_xrcg_d.deleteElement(g_xrcg_d.getLength())
      CALL g_xrcg2_d.deleteElement(g_xrcg2_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
   
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_xrcg_d.getLength()
      LET g_xrcg_d_mask_o[l_ac].* =  g_xrcg_d[l_ac].*
      CALL axrt360_xrcg_t_mask()
      LET g_xrcg_d_mask_n[l_ac].* =  g_xrcg_d[l_ac].*
   END FOR
   
   LET g_xrcg2_d_mask_o.* =  g_xrcg2_d.*
   FOR l_ac = 1 TO g_xrcg2_d.getLength()
      LET g_xrcg2_d_mask_o[l_ac].* =  g_xrcg2_d[l_ac].*
      CALL axrt360_xrcg_t_mask()
      LET g_xrcg2_d_mask_n[l_ac].* =  g_xrcg2_d[l_ac].*
   END FOR
 
 
   FREE axrt360_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="axrt360.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION axrt360_idx_chk()
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
      IF g_detail_idx > g_xrcg_d.getLength() THEN
         LET g_detail_idx = g_xrcg_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_xrcg_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xrcg_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_xrcg2_d.getLength() THEN
         LET g_detail_idx = g_xrcg2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_xrcg2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xrcg2_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axrt360.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axrt360_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_xrcg_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="axrt360.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION axrt360_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   
   #end add-point
   
   DELETE FROM xrcg_t
    WHERE xrcgent = g_enterprise AND xrcgld = g_xrcg_m.xrcgld AND
                              xrcgdocno = g_xrcg_m.xrcgdocno AND
 
          xrcgseq = g_xrcg_d_t.xrcgseq
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xrcg_t:",SQLERRMESSAGE 
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
 
{<section id="axrt360.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION axrt360_delete_b(ps_table,ps_keys_bak,ps_page)
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
 
{<section id="axrt360.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION axrt360_insert_b(ps_table,ps_keys,ps_page)
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
 
{<section id="axrt360.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION axrt360_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
 
{<section id="axrt360.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION axrt360_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_xrcg_d[l_ac].xrcgseq = g_xrcg_d_t.xrcgseq 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="axrt360.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION axrt360_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="axrt360.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION axrt360_lock_b(ps_table,ps_page)
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
   #CALL axrt360_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axrt360.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION axrt360_unlock_b(ps_table,ps_page)
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
 
{<section id="axrt360.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION axrt360_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("xrcgld,xrcgdocno",TRUE)
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
 
{<section id="axrt360.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION axrt360_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_success    LIKE type_t.num5     
   DEFINE l_slip       LIKE type_t.chr10    
   DEFINE l_dfin0033   LIKE type_t.chr80    
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("xrcgld,xrcgdocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   #170210-00018#1--add--str--lujh
   IF NOT cl_chk_update_docdt() THEN
      CALL cl_set_comp_entry("xrcgdocdt",FALSE)
   END IF
   
    IF NOT cl_null(g_xrcg_m.xrcgdocno) AND p_cmd = 'u' THEN  
      #获取单别
      CALL s_aooi200_fin_get_slip(g_xrcg_m.xrcgdocno) RETURNING l_success,l_slip
      #是否可改日期
      CALL s_fin_get_doc_para(g_xrcg_m.xrcgld,g_xrcg_m.xrcgcomp,l_slip,'D-FIN-0033') RETURNING l_dfin0033
      IF l_dfin0033 = "N"  THEN 
         CALL cl_set_comp_entry("xrcgdocdt",FALSE)
         ELSE 
         CALL cl_set_comp_entry("xrcgdocdt",TRUE)
      END IF 
   END IF 
   #170210-00018#1--add--end--lujh
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axrt360.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION axrt360_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axrt360.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION axrt360_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="axrt360.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION axrt360_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axrt360.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION axrt360_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   IF g_xrcg_m.xrcgstus NOT MATCHES "[N]" THEN   
      CALL cl_set_act_visible('modify,modify_detail,delete',FALSE)
   END IF
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axrt360.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION axrt360_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axrt360.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION axrt360_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axrt360.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION axrt360_default_search()
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
      LET ls_wc = ls_wc, " xrcgld = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " xrcgdocno = '", g_argv[02], "' AND "
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
 
{<section id="axrt360.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION axrt360_fill_chk(ps_idx)
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
 
{<section id="axrt360.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION axrt360_modify_detail_chk(ps_record)
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
         LET ls_return = "xrcgseq"
      WHEN "s_detail2"
         LET ls_return = "xrcgseq_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="axrt360.mask_functions" >}
&include "erp/axr/axrt360_mask.4gl"
 
{</section>}
 
{<section id="axrt360.state_change" >}
    
 
{</section>}
 
{<section id="axrt360.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION axrt360_set_pk_array()
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
   LET g_pk_array[1].values = g_xrcg_m.xrcgld
   LET g_pk_array[1].column = 'xrcgld'
   LET g_pk_array[2].values = g_xrcg_m.xrcgdocno
   LET g_pk_array[2].column = 'xrcgdocno'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axrt360.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION axrt360_msgcentre_notify(lc_state)
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
   CALL axrt360_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_xrcg_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axrt360.other_function" readonly="Y" >}
# 多帳期單號項次檢查
PRIVATE FUNCTION axrt360_xrcg002_xrcg003_chk(p_xrcg002,p_xrcg003)
   DEFINE p_xrcg002            LIKE xrcg_t.xrcg002
   DEFINE p_xrcg003            LIKE xrcg_t.xrcg003
   DEFINE l_xrcastus           LIKE xrca_t.xrcastus
   DEFINE l_xrcc109            LIKE xrcc_t.xrcc109
   DEFINE l_n                  LIKE type_t.num5
   
   LET g_errno = ''
   
   LET l_n = 0
   SELECT COUNT(1) INTO l_n
     FROM xrcc_t,xrca_t
    WHERE xrccent = g_enterprise
      AND xrccent = xrcaent
      AND xrccld = xrcald
      AND xrccdocno = xrcadocno
      AND xrca001 IN (SELECT gzcb002 FROM gzcb_t WHERE gzcb001 = '8302' AND gzcb005 IN ('axrt300','axrt310','axrt330'))
      AND xrccld = g_xrcg_m.xrcgld
      AND xrccdocno = p_xrcg002
   
   IF l_n = 0 THEN 
      LET g_errno = 'axr-01049'
      RETURN
   END IF
   
   SELECT xrcastus INTO l_xrcastus
     FROM xrca_t
    WHERE xrcaent = g_enterprise
      AND xrcald = g_xrcg_m.xrcgld
      AND xrcadocno = p_xrcg002
   
   IF l_xrcastus <> 'Y' THEN 
      LET g_errno = 'axr-00103'
      RETURN 
   END IF
   
   IF NOT cl_null(p_xrcg003) THEN 
      LET l_n = 0
      SELECT COUNT(1) INTO l_n
        FROM xrcc_t
       WHERE xrccent = g_enterprise
         AND xrccld = g_xrcg_m.xrcgld
         AND xrccdocno = p_xrcg002
         AND xrccseq = p_xrcg003
         
      IF l_n = 0 THEN 
         LET g_errno = 'axr-01050'
         RETURN
      END IF
      
      LET l_n = 0
      SELECT COUNT(1) INTO l_n
        FROM xrcg_t
       WHERE xrcgent = g_enterprise
         AND xrcgld = g_xrcg_m.xrcgld
         AND xrcg002 = p_xrcg002
         AND xrcg003 = p_xrcg003
         AND xrcgstus = 'N'
         AND (xrcgdocno <> g_xrcg_m.xrcgdocno
          OR (xrcgdocno = g_xrcg_m.xrcgdocno AND xrcgseq <> g_xrcg_d[l_ac].xrcgseq)
             )
             
      IF l_n > 0 THEN 
         LET g_errno = 'axr-01055'
         RETURN
      END IF
   
      SELECT xrcc109 INTO l_xrcc109
        FROM xrcc_t
       WHERE xrccent = g_enterprise
         AND xrccld = g_xrcg_m.xrcgld
         AND xrccdocno = p_xrcg002
         AND xrccseq = p_xrcg003
         
      IF l_xrcc109 <> 0 THEN 
         LET g_errno = 'axr-01051'
         RETURN
      END IF
   END IF
   
END FUNCTION
# 單號+項次帶值
PRIVATE FUNCTION axrt360_xrcg002_xrcg003_get(p_xrcg002,p_xrcg003)
   DEFINE p_xrcg002            LIKE xrcg_t.xrcg002
   DEFINE p_xrcg003            LIKE xrcg_t.xrcg003
   DEFINE l_success            LIKE type_t.num5
   
   SELECT xrcc015,xrcc003,xrcc004
     INTO g_xrcg_d[l_ac].xrcg004,g_xrcg_d[l_ac].xrcg006,g_xrcg_d[l_ac].xrcg008
     FROM xrcc_t
    WHERE xrccent = g_enterprise
      AND xrccld = g_xrcg_m.xrcgld
      AND xrccdocno = p_xrcg002
      AND xrccseq = p_xrcg003 
      
   SELECT xrca001 INTO g_xrcg_d[l_ac].xrca001
     FROM xrca_t
    WHERE xrcaent = g_enterprise
      AND xrcald = g_xrcg_m.xrcgld
      AND xrcadocno = p_xrcg002
      
   DISPLAY g_xrcg_d[l_ac].xrca001 TO xrca001
      
   CALL s_axrt300_xrca_ref('xrca008',g_xrcg_d[l_ac].xrcg004,'','') RETURNING l_success,g_xrcg_d[l_ac].xrcg004_desc
   DISPLAY BY NAME g_xrcg_d[l_ac].xrcg004_desc
END FUNCTION
# 確認碼變更
PRIVATE FUNCTION axrt360_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"

   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success    LIKE type_t.num5
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   #170210-00018#1--add--str--lujh
   CALL s_axrt300_date_chk(g_xrcg_m.xrcgsite,g_xrcg_m.xrcgdocdt) RETURNING l_success
   IF NOT l_success THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "axr-00300"
      LET g_errparam.popup  = TRUE 
      CALL cl_err() 
      RETURN
   END IF
   #170210-00018#1--add--end--lujh
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_xrcg_m.xrcgld IS NULL OR g_xrcg_m.xrcgdocno IS NULL
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN axrt360_cl USING g_enterprise,g_xrcg_m.xrcgld,g_xrcg_m.xrcgdocno
   IF STATUS THEN
      CLOSE axrt360_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axrt360_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE axrt360_master_referesh USING g_xrcg_m.xrcgld,g_xrcg_m.xrcgdocno INTO g_xrcg_m.xrcgcomp,g_xrcg_m.xrcgld, 
       g_xrcg_m.xrcgsite,g_xrcg_m.xrcgdocno,g_xrcg_m.xrcgdocdt,g_xrcg_m.xrcg001,g_xrcg_m.xrcg010,g_xrcg_m.xrcgstus,    #170210-00018#1 add xrcgdocdt lujh
       g_xrcg_m.xrcgcomp_desc,g_xrcg_m.xrcgld_desc,g_xrcg_m.xrcgsite_desc,g_xrcg_m.xrcg001_desc,g_xrcg_m.xrcg010_desc 
   
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_xrcg_m.xrcgcomp,g_xrcg_m.xrcgcomp_desc,g_xrcg_m.xrcgld,g_xrcg_m.xrcgld_desc,g_xrcg_m.xrcgsite, 
       g_xrcg_m.xrcgsite_desc,g_xrcg_m.xrcgdocno,g_xrcg_m.xrcgdocdt,g_xrcg_m.xrcg001,g_xrcg_m.xrcg001_desc,    #170210-00018#1 add xrcgdocdt lujh
       g_xrcg_m.xrcg010,g_xrcg_m.xrcg010_desc,g_xrcg_m.xrcgstus

   CASE g_xrcg_m.xrcgstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")  
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   LET l_success = TRUE
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_xrcg_m.xrcgstus
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "Y"
               HIDE OPTION "confirmed,invalid"
            WHEN "X"
              HIDE OPTION "invalid"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      CALL cl_set_act_visible("unconfirmed,confirmed,invalid",TRUE)
      CASE g_xrcg_m.xrcgstus 
         WHEN "X"
            CALL cl_set_act_visible("unconfirmed,confirmed,invalid",FALSE)
            CLOSE axrt360_cl
            CALL s_transaction_end('N','0')
            RETURN
         WHEN "Y"
            CALL cl_set_act_visible("confirmed,invalid",FALSE)
         WHEN "N"
            CALL cl_set_act_visible("unconfirmed",FALSE)
      END CASE
      #end add-point
      
      
    
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.open"
            CALL s_axrt360_unconfirm_chk(g_xrcg_m.xrcgld,g_xrcg_m.xrcgdocno) RETURNING l_success
            IF l_success = FALSE THEN 
               CLOSE axrt360_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            CALL s_axrt360_unconfirm(g_xrcg_m.xrcgld,g_xrcg_m.xrcgdocno) RETURNING l_success
            IF l_success = FALSE THEN 
               CLOSE axrt360_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            #end add-point
         END IF
         EXIT MENU
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.valid"
            CALL s_axrt360_confirm_chk(g_xrcg_m.xrcgld,g_xrcg_m.xrcgdocno) RETURNING l_success
            IF l_success = FALSE THEN 
               CLOSE axrt360_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            CALL s_axrt360_confirm(g_xrcg_m.xrcgld,g_xrcg_m.xrcgdocno) RETURNING l_success
            IF l_success = FALSE THEN 
               CLOSE axrt360_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            #end add-point
         END IF
         EXIT MENU
      ON ACTION invalid
         IF cl_auth_chk_act("invalid") THEN
            LET lc_state = "X"
            #add-point:action控制 name="statechange.void"
            
            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"

      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "N" 
      AND lc_state <> "Y"
      AND lc_state <> "X"
      ) OR 
      g_xrcg_m.xrcgstus = lc_state OR cl_null(lc_state) THEN
      CLOSE axrt360_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"

   #end add-point
   
   LET g_xrcg_m.xrcgstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE xrcg_t SET xrcgstus = g_xrcg_m.xrcgstus   
    WHERE xrcgent = g_enterprise 
      AND xrcgld = g_xrcg_m.xrcgld
      AND xrcgdocno = g_xrcg_m.xrcgdocno      
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE g_xrcg_m.xrcgstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")  
      END CASE
    
      #顯示最新的資料
      EXECUTE axrt360_master_referesh USING g_xrcg_m.xrcgld,g_xrcg_m.xrcgdocno INTO g_xrcg_m.xrcgcomp,g_xrcg_m.xrcgld, 
         g_xrcg_m.xrcgsite,g_xrcg_m.xrcgdocno,g_xrcg_m.xrcgdocdt,g_xrcg_m.xrcg001,g_xrcg_m.xrcg010,g_xrcg_m.xrcgstus,    #170210-00018#1 add xrcgdocdt lujh
         g_xrcg_m.xrcgcomp_desc,g_xrcg_m.xrcgld_desc,g_xrcg_m.xrcgsite_desc,g_xrcg_m.xrcg001_desc,g_xrcg_m.xrcg010_desc 
      
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_xrcg_m.xrcgcomp,g_xrcg_m.xrcgcomp_desc,g_xrcg_m.xrcgld,g_xrcg_m.xrcgld_desc,g_xrcg_m.xrcgsite, 
         g_xrcg_m.xrcgsite_desc,g_xrcg_m.xrcgdocno,g_xrcg_m.xrcgdocdt,g_xrcg_m.xrcg001,g_xrcg_m.xrcg001_desc,   #170210-00018#1 add xrcgdocdt lujh
         g_xrcg_m.xrcg010,g_xrcg_m.xrcg010_desc,g_xrcg_m.xrcgstus

   END IF
 
   #add-point:stus修改後 name="statechange.a_update"

   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"

   #end add-point  
 
   CLOSE axrt360_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL axrt360_msgcentre_notify('statechange:'||lc_state)
   CALL axrt360_browser_fill("")
END FUNCTION
# 打印
PRIVATE FUNCTION axrt360_output()
   DEFINE l_i,l_count        LIKE type_t.num5
   DEFINE l_xrcgcomp_desc    LIKE type_t.chr80,
          l_xrcgld_desc      LIKE type_t.chr80,
          l_xrcgsite_desc    LIKE type_t.chr80,
          l_xrcg001_desc     LIKE type_t.chr80,
          l_xrcg010_desc     LIKE type_t.chr80,
          l_stus             LIKE type_t.chr80,
          l_xrcg004_desc     LIKE type_t.chr80,
          l_xrcg005_desc     LIKE type_t.chr80,
          l_xrca001_desc     LIKE type_t.chr80
       
   DROP TABLE axrt360_tmp01              
   CREATE TEMP TABLE axrt360_tmp01(     
   xrcgcomp_desc    LIKE type_t.chr80,
   xrcgld_desc      LIKE type_t.chr80,
   xrcgsite_desc    LIKE type_t.chr80,
   xrcgdocno        LIKE xrcg_t.xrcgdocno,
   xrcg001_desc     LIKE type_t.chr80,
   xrcg010_desc     LIKE type_t.chr80,
   xrcgstus         LIKE type_t.chr80,
   xrcgseq          LIKE xrcg_t.xrcgseq,
   xrcg002          LIKE xrcg_t.xrcg002,
   xrca001          LIKE type_t.chr80,   
   xrcg003          LIKE xrcg_t.xrcg003, 
   xrcg004_desc     LIKE type_t.chr80,
   xrcg005_desc     LIKE type_t.chr80,
   xrcg006          LIKE xrcg_t.xrcg006,
   xrcg007          LIKE xrcg_t.xrcg007,
   xrcg008          LIKE xrcg_t.xrcg008,   
   xrcg009          LIKE xrcg_t.xrcg009
   )
       
   DELETE FROM axrt360_tmp01          
   LET l_count = g_xrcg_d.getLength()
   
   LET l_xrcgcomp_desc = g_xrcg_m.xrcgcomp," ",g_xrcg_m.xrcgcomp_desc
   LET l_xrcgld_desc = g_xrcg_m.xrcgld," ",g_xrcg_m.xrcgld_desc
   LET l_xrcgsite_desc = g_xrcg_m.xrcgsite," ",g_xrcg_m.xrcgsite_desc
   LET l_xrcg001_desc = g_xrcg_m.xrcg001," ",g_xrcg_m.xrcg001_desc
   LET l_xrcg010_desc = g_xrcg_m.xrcg010," ",g_xrcg_m.xrcg010_desc
   LET l_stus = g_xrcg_m.xrcgstus,":",s_desc_gzcbl004_desc('13',g_xrcg_m.xrcgstus)
   
   FOR l_i = 1 TO l_count
      LET l_xrcg004_desc = g_xrcg_d[l_i].xrcg004," ",g_xrcg_d[l_i].xrcg004_desc
      LET l_xrcg005_desc = g_xrcg_d[l_i].xrcg005," ",g_xrcg_d[l_i].xrcg005_desc
      LET l_xrca001_desc = g_xrcg_d[l_i].xrca001,":",s_desc_gzcbl004_desc('8302',g_xrcg_d[l_i].xrca001)
   
      INSERT INTO axrt360_tmp01      
      VALUES(l_xrcgcomp_desc,l_xrcgld_desc,l_xrcgsite_desc,g_xrcg_m.xrcgdocno,l_xrcg001_desc,
         l_xrcg010_desc,l_stus,g_xrcg_d[l_i].xrcgseq,g_xrcg_d[l_i].xrcg002,l_xrca001_desc,
         g_xrcg_d[l_i].xrcg003,l_xrcg004_desc,l_xrcg005_desc,g_xrcg_d[l_i].xrcg006,
         g_xrcg_d[l_i].xrcg007,g_xrcg_d[l_i].xrcg008,g_xrcg_d[l_i].xrcg009)
         
   END FOR
   CALL axrt360_x01(' 1=1','axrt360_tmp01')
END FUNCTION

 
{</section>}
 
