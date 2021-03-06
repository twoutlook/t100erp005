#該程式未解開Section, 採用最新樣板產出!
{<section id="anmt830.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0010(2015-11-11 09:46:39), PR版次:0010(2017-01-13 18:33:07)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000060
#+ Filename...: anmt830
#+ Description: 未達帳項維護作業
#+ Creator....: 00810(2014-09-09 17:30:32)
#+ Modifier...: 06821 -SD/PR- 08171
 
{</section>}
 
{<section id="anmt830.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#151002-00011#2                          若己有【對帳單號】者，仍能開放修改單身的資料
#151103-00010#1   2015/11/03 By Jessy    單身日記帳來源單號/日記帳來源項次,開放欄位修改
#151013-00019#10  2015/11/11 By Reanna   單身加合計
#150813-00015#23  2016/01/19 By 02599    增加年度、期别栏位检查，年度+期别不可小于关帐日期年度+期别
#160122-00001#29  2016/02/19 By 02599    增加交易账户用户权限控管
#160122-00001#29  2016/03/17 By 07900    增加交易账户用户权限控管,增加部门权限
#160318-00005#29  2016/03/25 By 07900    重复错误信息修改
#160321-00016#40  2016/03/30 By Jessy    將重複內容的錯誤訊息置換為公用錯誤訊息
#160726-00020#13  2016/08/22 By 08729    複製時清空特定欄位
#160816-00012#3   2016/09/12 By 01531    ANM增加资金中心，帐套，法人三个栏位权限
#160930-00021#1   2016/10/08 By 07900    新增时，单头的年度+期别需存在于法人组织的主账套对应的会计期间档中
#161021-00050#11  2016/10/28 By Reanna   资金中心开窗需调整为q_ooef001_33 新增时where条件限定ooefstus= 'Y'查询时不限定此条件；
#                                        法人开窗调整为q_ooef001_2,要注意原本where条件中的权限设置要保留;
#160824-00007#319 2017/01/13 By 08171    新舊值調整
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
PRIVATE type type_g_nmdf_m        RECORD
       nmdfsite LIKE nmdf_t.nmdfsite, 
   nmdfsite_desc LIKE type_t.chr80, 
   nmdfcomf LIKE nmdf_t.nmdfcomf, 
   nmdfcomf_desc LIKE type_t.chr80, 
   nmdf003 LIKE nmdf_t.nmdf003, 
   nmdf003_desc LIKE type_t.chr80, 
   nmdf003_desc_1 LIKE type_t.chr80, 
   nmdf001 LIKE nmdf_t.nmdf001, 
   nmdf002 LIKE nmdf_t.nmdf002, 
   nmdf014 LIKE nmdf_t.nmdf014
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_nmdf_d        RECORD
       nmdfseq LIKE nmdf_t.nmdfseq, 
   nmdf005 LIKE nmdf_t.nmdf005, 
   nmdf006 LIKE nmdf_t.nmdf006, 
   nmdf007 LIKE nmdf_t.nmdf007, 
   nmdf008 LIKE nmdf_t.nmdf008, 
   nmdf009 LIKE nmdf_t.nmdf009, 
   nmdf010 LIKE nmdf_t.nmdf010, 
   nmdf004 LIKE nmdf_t.nmdf004, 
   nmdf012 LIKE nmdf_t.nmdf012, 
   nmdf013 LIKE nmdf_t.nmdf013
       END RECORD
PRIVATE TYPE type_g_nmdf2_d RECORD
       nmdfownid LIKE nmdf_t.nmdfownid, 
   nmdfownid_desc LIKE type_t.chr500, 
   nmdfowndp LIKE nmdf_t.nmdfowndp, 
   nmdfowndp_desc LIKE type_t.chr500, 
   nmdfcrtid LIKE nmdf_t.nmdfcrtid, 
   nmdfcrtid_desc LIKE type_t.chr500, 
   nmdfcrtdp LIKE nmdf_t.nmdfcrtdp, 
   nmdfcrtdp_desc LIKE type_t.chr500, 
   nmdfcrtdt DATETIME YEAR TO SECOND, 
   nmdfmodid LIKE nmdf_t.nmdfmodid, 
   nmdfmodid_desc LIKE type_t.chr500, 
   nmdfmoddt DATETIME YEAR TO SECOND
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE l_origin_str     STRING   #組織範圍
DEFINE g_sql_bank       STRING   #160122-00001#29 By 07900 -add
DEFINE g_site_wc        STRING   #160816-00012#3 
DEFINE g_comp_wc        STRING   #160816-00012#3
#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_nmdf_m          type_g_nmdf_m
DEFINE g_nmdf_m_t        type_g_nmdf_m
DEFINE g_nmdf_m_o        type_g_nmdf_m
DEFINE g_nmdf_m_mask_o   type_g_nmdf_m #轉換遮罩前資料
DEFINE g_nmdf_m_mask_n   type_g_nmdf_m #轉換遮罩後資料
 
   DEFINE g_nmdf003_t LIKE nmdf_t.nmdf003
DEFINE g_nmdf001_t LIKE nmdf_t.nmdf001
DEFINE g_nmdf002_t LIKE nmdf_t.nmdf002
 
 
DEFINE g_nmdf_d          DYNAMIC ARRAY OF type_g_nmdf_d
DEFINE g_nmdf_d_t        type_g_nmdf_d
DEFINE g_nmdf_d_o        type_g_nmdf_d
DEFINE g_nmdf_d_mask_o   DYNAMIC ARRAY OF type_g_nmdf_d #轉換遮罩前資料
DEFINE g_nmdf_d_mask_n   DYNAMIC ARRAY OF type_g_nmdf_d #轉換遮罩後資料
DEFINE g_nmdf2_d   DYNAMIC ARRAY OF type_g_nmdf2_d
DEFINE g_nmdf2_d_t type_g_nmdf2_d
DEFINE g_nmdf2_d_o type_g_nmdf2_d
DEFINE g_nmdf2_d_mask_o   DYNAMIC ARRAY OF type_g_nmdf2_d #轉換遮罩前資料
DEFINE g_nmdf2_d_mask_n   DYNAMIC ARRAY OF type_g_nmdf2_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_nmdf001 LIKE nmdf_t.nmdf001,
      b_nmdf002 LIKE nmdf_t.nmdf002,
      b_nmdf003 LIKE nmdf_t.nmdf003
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
 
{<section id="anmt830.main" >}
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
   LET g_forupd_sql = " SELECT nmdfsite,'',nmdfcomf,'',nmdf003,'','',nmdf001,nmdf002,nmdf014", 
                      " FROM nmdf_t",
                      " WHERE nmdfent= ? AND nmdf001=? AND nmdf002=? AND nmdf003=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE anmt830_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.nmdfsite,t0.nmdfcomf,t0.nmdf003,t0.nmdf001,t0.nmdf002,t0.nmdf014, 
       t1.ooefl003 ,t2.ooefl003",
               " FROM nmdf_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.nmdfsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.nmdfcomf AND t2.ooefl002='"||g_dlang||"' ",
 
               " WHERE t0.nmdfent = " ||g_enterprise|| " AND t0.nmdf001 = ? AND t0.nmdf002 = ? AND t0.nmdf003 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE anmt830_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_anmt830 WITH FORM cl_ap_formpath("anm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL anmt830_init()   
 
      #進入選單 Menu (="N")
      CALL anmt830_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_anmt830
      
   END IF 
   
   CLOSE anmt830_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="anmt830.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION anmt830_init()
   #add-point:init段define name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill = "Y"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
      CALL cl_set_combo_scc('nmdf006','9945') 
 
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #add-point:畫面資料初始化 name="init.init"
   CALL s_fin_create_account_center_tmp()
   #160122-00001#25 By 07900--add--str--
   LET g_sql_bank=NULL
   CALL s_anmi120_get_bank_account_sql(g_user,g_dept) RETURNING g_sub_success,g_sql_bank
   #160122-00001#25 By 07900--add--end
   #end add-point
   
   CALL anmt830_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="anmt830.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION anmt830_ui_dialog()
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
         INITIALIZE g_nmdf_m.* TO NULL
         CALL g_nmdf_d.clear()
         CALL g_nmdf2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL anmt830_init()
      END IF
 
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
        
         DISPLAY ARRAY g_nmdf_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL anmt830_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL anmt830_ui_detailshow()
               
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
        
         DISPLAY ARRAY g_nmdf2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL anmt830_idx_chk()
               CALL anmt830_ui_detailshow()
               
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
            CALL anmt830_browser_fill("")
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
               CALL anmt830_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL anmt830_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL anmt830_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL anmt830_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL anmt830_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL anmt830_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL anmt830_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL anmt830_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL anmt830_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL anmt830_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL anmt830_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL anmt830_idx_chk()
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
                  LET g_export_node[1] = base.typeInfo.create(g_nmdf_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_nmdf2_d)
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
               NEXT FIELD nmdfseq
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
               CALL anmt830_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL anmt830_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL anmt830_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL anmt830_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL anmt830_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL anmt830_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL anmt830_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/anm/anmt830_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/anm/anmt830_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL anmt830_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL anmt830_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_nmdf014
            LET g_action_choice="prog_nmdf014"
            IF cl_auth_chk_act("prog_nmdf014") THEN
               
               #add-point:ON ACTION prog_nmdf014 name="menu.prog_nmdf014"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'anmt850'
               LET la_param.param[1] = g_nmdf_m.nmdf014

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
 


               #END add-point
               
            END IF
 
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL anmt830_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL anmt830_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL anmt830_set_pk_array()
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
 
{<section id="anmt830.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION anmt830_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="anmt830.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION anmt830_browser_fill(ps_page_action)
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
   DEFINE l_comp_str        STRING #160816-00012#3 add 
   #end add-point
   
   #add-point:Function前置處理  name="browser_fill.before_browser_fill"
   #160122-00001#29--add--str--
   IF cl_null(g_wc) THEN
      LET g_wc=" nmdf003 IN (",g_sql_bank,")"     #160122-00001#29 By 07900 --mod
   ELSE
      LET g_wc=g_wc," AND nmdf003 IN (",g_sql_bank,")"  #160122-00001#29 By 07900 --mod
   END IF
   #160122-00001#29--add--end
   
   #160816-00012#3 add s---
   CALL s_axrt300_get_site(g_user,'','3') RETURNING l_comp_str
   LET l_comp_str = cl_replace_str(l_comp_str,"ooef017","nmdfcomf")
   LET g_wc = g_wc," AND ",l_comp_str  
   #160816-00012#3 add e---   
   #end add-point    
 
   LET l_searchcol = "nmdf001,nmdf002,nmdf003"
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
      LET l_sub_sql = " SELECT DISTINCT nmdf001 ",
                      ", nmdf002 ",
                      ", nmdf003 ",
 
                      " FROM nmdf_t ",
                      " ",
                      " ", 
 
 
 
                      " WHERE nmdfent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("nmdf_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT nmdf001 ",
                      ", nmdf002 ",
                      ", nmdf003 ",
 
                      " FROM nmdf_t ",
                      " ",
                      " ", 
 
 
                      " WHERE nmdfent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("nmdf_t")
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
      INITIALIZE g_nmdf_m.* TO NULL
      CALL g_nmdf_d.clear()        
      CALL g_nmdf2_d.clear() 
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.nmdf001,t0.nmdf002,t0.nmdf003 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.nmdf001,t0.nmdf002,t0.nmdf003",
                " FROM nmdf_t t0",
                #" ",
                " ",
 
 
 
                
                " WHERE t0.nmdfent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("nmdf_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
   
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"nmdf_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_nmdf001,g_browser[g_cnt].b_nmdf002,g_browser[g_cnt].b_nmdf003  
 
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
   
   IF cl_null(g_browser[g_cnt].b_nmdf001) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_nmdf_m.* TO NULL
      CALL g_nmdf_d.clear()
      CALL g_nmdf2_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL anmt830_fetch('')
   
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
 
{<section id="anmt830.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION anmt830_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_nmdf_m.nmdf001 = g_browser[g_current_idx].b_nmdf001   
   LET g_nmdf_m.nmdf002 = g_browser[g_current_idx].b_nmdf002   
   LET g_nmdf_m.nmdf003 = g_browser[g_current_idx].b_nmdf003   
 
   EXECUTE anmt830_master_referesh USING g_nmdf_m.nmdf001,g_nmdf_m.nmdf002,g_nmdf_m.nmdf003 INTO g_nmdf_m.nmdfsite, 
       g_nmdf_m.nmdfcomf,g_nmdf_m.nmdf003,g_nmdf_m.nmdf001,g_nmdf_m.nmdf002,g_nmdf_m.nmdf014,g_nmdf_m.nmdfsite_desc, 
       g_nmdf_m.nmdfcomf_desc
   CALL anmt830_show()
   
END FUNCTION
 
{</section>}
 
{<section id="anmt830.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION anmt830_ui_detailshow()
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
 
{<section id="anmt830.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION anmt830_ui_browser_refresh()
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
      IF g_browser[l_i].b_nmdf001 = g_nmdf_m.nmdf001 
         AND g_browser[l_i].b_nmdf002 = g_nmdf_m.nmdf002 
         AND g_browser[l_i].b_nmdf003 = g_nmdf_m.nmdf003 
 
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
 
{<section id="anmt830.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION anmt830_construct()
   #add-point:cs段define name="cs.define_customerization"
   
   #end add-point    
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   #add-point:cs段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   DEFINE l_wc        STRING #160816-00012#3
   #end add-point 
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
   
   #清除畫面上相關資料
   CLEAR FORM                 
   INITIALIZE g_nmdf_m.* TO NULL
   CALL g_nmdf_d.clear()
   CALL g_nmdf2_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON nmdfsite,nmdfcomf,nmdf003,nmdf003_desc,nmdf003_desc_1,nmdf001,nmdf002, 
          nmdf014
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
                 #Ctrlp:construct.c.nmdfsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmdfsite
            #add-point:ON ACTION controlp INFIELD nmdfsite name="construct.c.nmdfsite"
            #資金中心
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef206 = 'Y'"
            #CALL q_ooef001()    #161021-00050#11 mark
            CALL q_ooef001_33()  #161021-00050#11
            DISPLAY g_qryparam.return1 TO nmdfsite
            NEXT FIELD nmdfsite
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmdfsite
            #add-point:BEFORE FIELD nmdfsite name="construct.b.nmdfsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmdfsite
            
            #add-point:AFTER FIELD nmdfsite name="construct.a.nmdfsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmdfcomf
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmdfcomf
            #add-point:ON ACTION controlp INFIELD nmdfcomf name="construct.c.nmdfcomf"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef003 = 'Y' "
            #160816-00012#3 Add  ---(S)---
            CALL s_axrt300_get_site(g_user,'','3') RETURNING l_wc
            LET g_qryparam.where = g_qryparam.where," AND ",l_wc CLIPPED
            #160816-00012#3 Add  ---(E)---
            #CALL q_ooef001()  #161021-00050#11 mark
            CALL q_ooef001_2() #161021-00050#11
            DISPLAY g_qryparam.return1 TO nmdfcomf
            NEXT FIELD nmdfcomf
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmdfcomf
            #add-point:BEFORE FIELD nmdfcomf name="construct.b.nmdfcomf"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmdfcomf
            
            #add-point:AFTER FIELD nmdfcomf name="construct.a.nmdfcomf"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmdf003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmdf003
            #add-point:ON ACTION controlp INFIELD nmdf003 name="construct.c.nmdf003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #160122-00001#29--add---str-
            LET g_qryparam.where = " nmas002 IN (",g_sql_bank,")"   #160122-00001#29 By 07900 --mod
            #160122-00001#29--add---end
            CALL q_nmas002_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmdf003  #顯示到畫面上
            NEXT FIELD nmdf003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmdf003
            #add-point:BEFORE FIELD nmdf003 name="construct.b.nmdf003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmdf003
            
            #add-point:AFTER FIELD nmdf003 name="construct.a.nmdf003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmdf003_desc
            #add-point:BEFORE FIELD nmdf003_desc name="construct.b.nmdf003_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmdf003_desc
            
            #add-point:AFTER FIELD nmdf003_desc name="construct.a.nmdf003_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmdf003_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmdf003_desc
            #add-point:ON ACTION controlp INFIELD nmdf003_desc name="construct.c.nmdf003_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmdf003_desc_1
            #add-point:BEFORE FIELD nmdf003_desc_1 name="construct.b.nmdf003_desc_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmdf003_desc_1
            
            #add-point:AFTER FIELD nmdf003_desc_1 name="construct.a.nmdf003_desc_1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmdf003_desc_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmdf003_desc_1
            #add-point:ON ACTION controlp INFIELD nmdf003_desc_1 name="construct.c.nmdf003_desc_1"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmdf001
            #add-point:BEFORE FIELD nmdf001 name="construct.b.nmdf001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmdf001
            
            #add-point:AFTER FIELD nmdf001 name="construct.a.nmdf001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmdf001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmdf001
            #add-point:ON ACTION controlp INFIELD nmdf001 name="construct.c.nmdf001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmdf002
            #add-point:BEFORE FIELD nmdf002 name="construct.b.nmdf002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmdf002
            
            #add-point:AFTER FIELD nmdf002 name="construct.a.nmdf002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmdf002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmdf002
            #add-point:ON ACTION controlp INFIELD nmdf002 name="construct.c.nmdf002"
            
            #END add-point
 
 
         #Ctrlp:construct.c.nmdf014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmdf014
            #add-point:ON ACTION controlp INFIELD nmdf014 name="construct.c.nmdf014"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_nmdjdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmdf014  #顯示到畫面上
            NEXT FIELD nmdf014                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmdf014
            #add-point:BEFORE FIELD nmdf014 name="construct.b.nmdf014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmdf014
            
            #add-point:AFTER FIELD nmdf014 name="construct.a.nmdf014"
            
            #END add-point
            
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON nmdfseq,nmdf005,nmdf006,nmdf007,nmdf008,nmdf009,nmdf010,nmdf004,nmdf012, 
          nmdf013,nmdfownid,nmdfowndp,nmdfcrtid,nmdfcrtdp,nmdfcrtdt,nmdfmodid,nmdfmoddt
           FROM s_detail1[1].nmdfseq,s_detail1[1].nmdf005,s_detail1[1].nmdf006,s_detail1[1].nmdf007, 
               s_detail1[1].nmdf008,s_detail1[1].nmdf009,s_detail1[1].nmdf010,s_detail1[1].nmdf004,s_detail1[1].nmdf012, 
               s_detail1[1].nmdf013,s_detail2[1].nmdfownid,s_detail2[1].nmdfowndp,s_detail2[1].nmdfcrtid, 
               s_detail2[1].nmdfcrtdp,s_detail2[1].nmdfcrtdt,s_detail2[1].nmdfmodid,s_detail2[1].nmdfmoddt 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<nmdfcrtdt>>----
         AFTER FIELD nmdfcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<nmdfmoddt>>----
         AFTER FIELD nmdfmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<nmdfcnfdt>>----
         
         #----<<nmdfpstdt>>----
 
 
 
           
         #單身一般欄位開窗相關處理
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmdfseq
            #add-point:BEFORE FIELD nmdfseq name="construct.b.page1.nmdfseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmdfseq
            
            #add-point:AFTER FIELD nmdfseq name="construct.a.page1.nmdfseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmdfseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmdfseq
            #add-point:ON ACTION controlp INFIELD nmdfseq name="construct.c.page1.nmdfseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmdf005
            #add-point:BEFORE FIELD nmdf005 name="construct.b.page1.nmdf005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmdf005
            
            #add-point:AFTER FIELD nmdf005 name="construct.a.page1.nmdf005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmdf005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmdf005
            #add-point:ON ACTION controlp INFIELD nmdf005 name="construct.c.page1.nmdf005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmdf006
            #add-point:BEFORE FIELD nmdf006 name="construct.b.page1.nmdf006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmdf006
            
            #add-point:AFTER FIELD nmdf006 name="construct.a.page1.nmdf006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmdf006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmdf006
            #add-point:ON ACTION controlp INFIELD nmdf006 name="construct.c.page1.nmdf006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmdf007
            #add-point:BEFORE FIELD nmdf007 name="construct.b.page1.nmdf007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmdf007
            
            #add-point:AFTER FIELD nmdf007 name="construct.a.page1.nmdf007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmdf007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmdf007
            #add-point:ON ACTION controlp INFIELD nmdf007 name="construct.c.page1.nmdf007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmdf008
            #add-point:BEFORE FIELD nmdf008 name="construct.b.page1.nmdf008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmdf008
            
            #add-point:AFTER FIELD nmdf008 name="construct.a.page1.nmdf008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmdf008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmdf008
            #add-point:ON ACTION controlp INFIELD nmdf008 name="construct.c.page1.nmdf008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmdf009
            #add-point:BEFORE FIELD nmdf009 name="construct.b.page1.nmdf009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmdf009
            
            #add-point:AFTER FIELD nmdf009 name="construct.a.page1.nmdf009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmdf009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmdf009
            #add-point:ON ACTION controlp INFIELD nmdf009 name="construct.c.page1.nmdf009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmdf010
            #add-point:BEFORE FIELD nmdf010 name="construct.b.page1.nmdf010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmdf010
            
            #add-point:AFTER FIELD nmdf010 name="construct.a.page1.nmdf010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmdf010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmdf010
            #add-point:ON ACTION controlp INFIELD nmdf010 name="construct.c.page1.nmdf010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmdf004
            #add-point:BEFORE FIELD nmdf004 name="construct.b.page1.nmdf004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmdf004
            
            #add-point:AFTER FIELD nmdf004 name="construct.a.page1.nmdf004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmdf004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmdf004
            #add-point:ON ACTION controlp INFIELD nmdf004 name="construct.c.page1.nmdf004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmdf012
            #add-point:BEFORE FIELD nmdf012 name="construct.b.page1.nmdf012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmdf012
            
            #add-point:AFTER FIELD nmdf012 name="construct.a.page1.nmdf012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmdf012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmdf012
            #add-point:ON ACTION controlp INFIELD nmdf012 name="construct.c.page1.nmdf012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmdf013
            #add-point:BEFORE FIELD nmdf013 name="construct.b.page1.nmdf013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmdf013
            
            #add-point:AFTER FIELD nmdf013 name="construct.a.page1.nmdf013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmdf013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmdf013
            #add-point:ON ACTION controlp INFIELD nmdf013 name="construct.c.page1.nmdf013"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.nmdfownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmdfownid
            #add-point:ON ACTION controlp INFIELD nmdfownid name="construct.c.page2.nmdfownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmdfownid  #顯示到畫面上
            NEXT FIELD nmdfownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmdfownid
            #add-point:BEFORE FIELD nmdfownid name="construct.b.page2.nmdfownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmdfownid
            
            #add-point:AFTER FIELD nmdfownid name="construct.a.page2.nmdfownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.nmdfowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmdfowndp
            #add-point:ON ACTION controlp INFIELD nmdfowndp name="construct.c.page2.nmdfowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmdfowndp  #顯示到畫面上
            NEXT FIELD nmdfowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmdfowndp
            #add-point:BEFORE FIELD nmdfowndp name="construct.b.page2.nmdfowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmdfowndp
            
            #add-point:AFTER FIELD nmdfowndp name="construct.a.page2.nmdfowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.nmdfcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmdfcrtid
            #add-point:ON ACTION controlp INFIELD nmdfcrtid name="construct.c.page2.nmdfcrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmdfcrtid  #顯示到畫面上
            NEXT FIELD nmdfcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmdfcrtid
            #add-point:BEFORE FIELD nmdfcrtid name="construct.b.page2.nmdfcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmdfcrtid
            
            #add-point:AFTER FIELD nmdfcrtid name="construct.a.page2.nmdfcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.nmdfcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmdfcrtdp
            #add-point:ON ACTION controlp INFIELD nmdfcrtdp name="construct.c.page2.nmdfcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmdfcrtdp  #顯示到畫面上
            NEXT FIELD nmdfcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmdfcrtdp
            #add-point:BEFORE FIELD nmdfcrtdp name="construct.b.page2.nmdfcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmdfcrtdp
            
            #add-point:AFTER FIELD nmdfcrtdp name="construct.a.page2.nmdfcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmdfcrtdt
            #add-point:BEFORE FIELD nmdfcrtdt name="construct.b.page2.nmdfcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.nmdfmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmdfmodid
            #add-point:ON ACTION controlp INFIELD nmdfmodid name="construct.c.page2.nmdfmodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmdfmodid  #顯示到畫面上
            NEXT FIELD nmdfmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmdfmodid
            #add-point:BEFORE FIELD nmdfmodid name="construct.b.page2.nmdfmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmdfmodid
            
            #add-point:AFTER FIELD nmdfmodid name="construct.a.page2.nmdfmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmdfmoddt
            #add-point:BEFORE FIELD nmdfmoddt name="construct.b.page2.nmdfmoddt"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
  
 
  
      #add-point:cs段more_construct name="cs.more_construct"
      
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:ui_dialog段b_dialog name="cs.before_dialog"
         #151013-00019#10 add ------
         LET l_ac = 1
         LET g_nmdf_d[l_ac].nmdf005 = ''
         DISPLAY ARRAY g_nmdf_d TO s_detail1.*
            BEFORE DISPLAY
               EXIT DISPLAY
         END DISPLAY
         #151013-00019#10 add end---
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
 
{<section id="anmt830.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION anmt830_query()
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
   CALL g_nmdf_d.clear()
   CALL g_nmdf2_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL anmt830_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL anmt830_browser_fill(g_wc)
      CALL anmt830_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL anmt830_browser_fill("F")
   
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
      CALL anmt830_fetch("F") 
   END IF
   
   CALL anmt830_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="anmt830.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION anmt830_fetch(p_flag)
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
   
   #CALL anmt830_browser_fill(p_flag)
   
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
   
   LET g_nmdf_m.nmdf001 = g_browser[g_current_idx].b_nmdf001
   LET g_nmdf_m.nmdf002 = g_browser[g_current_idx].b_nmdf002
   LET g_nmdf_m.nmdf003 = g_browser[g_current_idx].b_nmdf003
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE anmt830_master_referesh USING g_nmdf_m.nmdf001,g_nmdf_m.nmdf002,g_nmdf_m.nmdf003 INTO g_nmdf_m.nmdfsite, 
       g_nmdf_m.nmdfcomf,g_nmdf_m.nmdf003,g_nmdf_m.nmdf001,g_nmdf_m.nmdf002,g_nmdf_m.nmdf014,g_nmdf_m.nmdfsite_desc, 
       g_nmdf_m.nmdfcomf_desc
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "nmdf_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_nmdf_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_nmdf_m_mask_o.* =  g_nmdf_m.*
   CALL anmt830_nmdf_t_mask()
   LET g_nmdf_m_mask_n.* =  g_nmdf_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL anmt830_set_act_visible()
   CALL anmt830_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_nmdf_m_t.* = g_nmdf_m.*
   LET g_nmdf_m_o.* = g_nmdf_m.*
   
   #重新顯示   
   CALL anmt830_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="anmt830.insert" >}
#+ 資料新增
PRIVATE FUNCTION anmt830_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_nmdf_d.clear()
   CALL g_nmdf2_d.clear()
 
 
   INITIALIZE g_nmdf_m.* TO NULL             #DEFAULT 設定
   LET g_nmdf001_t = NULL
   LET g_nmdf002_t = NULL
   LET g_nmdf003_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
      
     
      #add-point:單頭預設值 name="insert.default"
      #取得預設的資金中心,因新增階段的時候,並不會知道site,所以以登入人員做為依據
      CALL s_fin_get_account_center('',g_user,'6',g_today) 
      RETURNING g_sub_success,g_nmdf_m.nmdfsite,g_errno
      
      SELECT ooef017 INTO g_nmdf_m.nmdfcomf
        FROM ooef_t
       WHERE ooefent = g_enterprise
        AND ooef001 = g_nmdf_m.nmdfsite
        
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_nmdf_m.nmdfsite
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_nmdf_m.nmdfsite_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_nmdf_m.nmdfsite_desc
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_nmdf_m.nmdfcomf
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_nmdf_m.nmdfcomf_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_nmdf_m.nmdfcomf_desc 
 
      CALL s_anm_get_site_wc('6',g_nmdf_m.nmdfcomf,g_today) RETURNING g_site_wc  #160816-00012#3
      CALL s_anm_get_comp_wc('6',g_nmdf_m.nmdfsite,g_today) RETURNING g_comp_wc  #160816-00012#3
      #160930-00021#1--add--s--
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_nmdf_m_t.* = g_nmdf_m.*
      LET g_nmdf_m_o.* = g_nmdf_m.*
      #160930-00021#1--add--e--
      #end add-point 
 
      CALL anmt830_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_nmdf_m.* TO NULL
         INITIALIZE g_nmdf_d TO NULL
         INITIALIZE g_nmdf2_d TO NULL
 
         CALL anmt830_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_nmdf_m.* = g_nmdf_m_t.*
         CALL anmt830_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_nmdf_d.clear()
      #CALL g_nmdf2_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL anmt830_set_act_visible()
   CALL anmt830_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_nmdf001_t = g_nmdf_m.nmdf001
   LET g_nmdf002_t = g_nmdf_m.nmdf002
   LET g_nmdf003_t = g_nmdf_m.nmdf003
 
   
   #組合新增資料的條件
   LET g_add_browse = " nmdfent = " ||g_enterprise|| " AND",
                      " nmdf001 = '", g_nmdf_m.nmdf001, "' "
                      ," AND nmdf002 = '", g_nmdf_m.nmdf002, "' "
                      ," AND nmdf003 = '", g_nmdf_m.nmdf003, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL anmt830_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL anmt830_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE anmt830_master_referesh USING g_nmdf_m.nmdf001,g_nmdf_m.nmdf002,g_nmdf_m.nmdf003 INTO g_nmdf_m.nmdfsite, 
       g_nmdf_m.nmdfcomf,g_nmdf_m.nmdf003,g_nmdf_m.nmdf001,g_nmdf_m.nmdf002,g_nmdf_m.nmdf014,g_nmdf_m.nmdfsite_desc, 
       g_nmdf_m.nmdfcomf_desc
   
   #遮罩相關處理
   LET g_nmdf_m_mask_o.* =  g_nmdf_m.*
   CALL anmt830_nmdf_t_mask()
   LET g_nmdf_m_mask_n.* =  g_nmdf_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_nmdf_m.nmdfsite,g_nmdf_m.nmdfsite_desc,g_nmdf_m.nmdfcomf,g_nmdf_m.nmdfcomf_desc, 
       g_nmdf_m.nmdf003,g_nmdf_m.nmdf003_desc,g_nmdf_m.nmdf003_desc_1,g_nmdf_m.nmdf001,g_nmdf_m.nmdf002, 
       g_nmdf_m.nmdf014
   
   #功能已完成,通報訊息中心
   CALL anmt830_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="anmt830.modify" >}
#+ 資料修改
PRIVATE FUNCTION anmt830_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   DEFINE l_para_date LIKE type_t.dat #150813-00015#23 add
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   #150813-00015#23--add--str--
   IF g_nmdf_m.nmdf001 IS NULL
   OR g_nmdf_m.nmdf002 IS NULL
   OR g_nmdf_m.nmdf003 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   #檢查當年度+期别小於等於關帳日期的年度+期别時，不可異動單據
   CALL cl_get_para(g_enterprise,g_nmdf_m.nmdfcomf,'S-FIN-4007') RETURNING l_para_date
   IF g_nmdf_m.nmdf001 < YEAR(l_para_date) OR
      (g_nmdf_m.nmdf001 =YEAR(l_para_date) AND g_nmdf_m.nmdf002 < MONTH(l_para_date))
   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = g_nmdf_m.nmdf001,"/",g_nmdf_m.nmdf002
      LET g_errparam.code   = 'anm-00388'
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   #150813-00015#23--add--end
   #end add-point
   
   IF g_nmdf_m.nmdf001 IS NULL
   OR g_nmdf_m.nmdf002 IS NULL
   OR g_nmdf_m.nmdf003 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_nmdf001_t = g_nmdf_m.nmdf001
   LET g_nmdf002_t = g_nmdf_m.nmdf002
   LET g_nmdf003_t = g_nmdf_m.nmdf003
 
   CALL s_transaction_begin()
   
   OPEN anmt830_cl USING g_enterprise,g_nmdf_m.nmdf001,g_nmdf_m.nmdf002,g_nmdf_m.nmdf003
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN anmt830_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE anmt830_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE anmt830_master_referesh USING g_nmdf_m.nmdf001,g_nmdf_m.nmdf002,g_nmdf_m.nmdf003 INTO g_nmdf_m.nmdfsite, 
       g_nmdf_m.nmdfcomf,g_nmdf_m.nmdf003,g_nmdf_m.nmdf001,g_nmdf_m.nmdf002,g_nmdf_m.nmdf014,g_nmdf_m.nmdfsite_desc, 
       g_nmdf_m.nmdfcomf_desc
   
   #遮罩相關處理
   LET g_nmdf_m_mask_o.* =  g_nmdf_m.*
   CALL anmt830_nmdf_t_mask()
   LET g_nmdf_m_mask_n.* =  g_nmdf_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL anmt830_show()
   WHILE TRUE
      LET g_nmdf001_t = g_nmdf_m.nmdf001
      LET g_nmdf002_t = g_nmdf_m.nmdf002
      LET g_nmdf003_t = g_nmdf_m.nmdf003
 
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL anmt830_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_nmdf_m.* = g_nmdf_m_t.*
         CALL anmt830_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_nmdf_m.nmdf001 != g_nmdf001_t 
      OR g_nmdf_m.nmdf002 != g_nmdf002_t 
      OR g_nmdf_m.nmdf003 != g_nmdf003_t 
 
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
   CALL anmt830_set_act_visible()
   CALL anmt830_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " nmdfent = " ||g_enterprise|| " AND",
                      " nmdf001 = '", g_nmdf_m.nmdf001, "' "
                      ," AND nmdf002 = '", g_nmdf_m.nmdf002, "' "
                      ," AND nmdf003 = '", g_nmdf_m.nmdf003, "' "
 
   #填到對應位置
   CALL anmt830_browser_fill("")
 
   CALL anmt830_idx_chk()
 
   CLOSE anmt830_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL anmt830_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="anmt830.input" >}
#+ 資料輸入
PRIVATE FUNCTION anmt830_input(p_cmd)
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
   DEFINE l_ooef RECORD
                 ooef206  LIKE ooef_t.ooef206,
                 ooefstus LIKE ooef_t.ooefstus
                 END RECORD
   DEFINE r_wc       STRING
   DEFINE tok        base.StringTokenizer
   DEFINE l_str      STRING
   DEFINE  l_n1                  LIKE type_t.num5  #否存在
   DEFINE l_edate        LIKE type_t.dat
   DEFINE l_bdate        LIKE type_t.dat
   DEFINE l_day          LIKE type_t.num5
   DEFINE l_string    STRING
   DEFINE l_date      LIKE type_t.dat
   DEFINE l_datechr   STRING
   DEFINE l_num5      LIKE type_t.num5
   DEFINE l_chr5      LIKE type_t.chr5  
   DEFINE l_para_date LIKE type_t.dat #150813-00015#23 add 
   DEFINE l_wc        STRING #160816-00012#3
   DEFINE l_sql       STRING #160816-00012#3
   DEFINE l_glaa003   LIKE glaa_t.glaa003 
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
   DISPLAY BY NAME g_nmdf_m.nmdfsite,g_nmdf_m.nmdfsite_desc,g_nmdf_m.nmdfcomf,g_nmdf_m.nmdfcomf_desc, 
       g_nmdf_m.nmdf003,g_nmdf_m.nmdf003_desc,g_nmdf_m.nmdf003_desc_1,g_nmdf_m.nmdf001,g_nmdf_m.nmdf002, 
       g_nmdf_m.nmdf014
   
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
   LET g_forupd_sql = "SELECT nmdfseq,nmdf005,nmdf006,nmdf007,nmdf008,nmdf009,nmdf010,nmdf004,nmdf012, 
       nmdf013,nmdfownid,nmdfowndp,nmdfcrtid,nmdfcrtdp,nmdfcrtdt,nmdfmodid,nmdfmoddt FROM nmdf_t WHERE  
       nmdfent=? AND nmdf001=? AND nmdf002=? AND nmdf003=? AND nmdfseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE anmt830_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL anmt830_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL anmt830_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_nmdf_m.nmdfsite,g_nmdf_m.nmdfcomf,g_nmdf_m.nmdf003,g_nmdf_m.nmdf001,g_nmdf_m.nmdf002 
 
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="anmt830.input.head" >}
   
      #單頭段
      INPUT BY NAME g_nmdf_m.nmdfsite,g_nmdf_m.nmdfcomf,g_nmdf_m.nmdf003,g_nmdf_m.nmdf001,g_nmdf_m.nmdf002  
 
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
         AFTER FIELD nmdfsite
            
            #add-point:AFTER FIELD nmdfsite name="input.a.nmdfsite"
            IF NOT cl_null(g_nmdf_m.nmdfsite) THEN 
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_nmdf_m.nmdfsite != g_nmdf_m_t.nmdfsite OR g_nmdf_m_t.nmdfsite IS NULL )) THEN #160824-00007#319 170113 By 08171 mark
               IF cl_null(g_nmdf_m_o.nmdfsite) OR g_nmdf_m.nmdfsite != g_nmdf_m_o.nmdfsite THEN #160824-00007#319 170113 By 08171 add
#160816-00012#3 mark s---
#                  CALL s_fin_account_center_chk(g_nmdf_m.nmdfsite,'','6','')
#                     RETURNING g_sub_success,g_errno
#                  IF NOT g_sub_success THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = 'anm-00275'
#                     LET g_errparam.extend = ''
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#                     LET g_nmdf_m.nmdfsite = g_nmdf_m_t.nmdfsite
#                     NEXT FIELD CURRENT
#                  END IF
#160816-00012#3 mark e---

                  LET g_errno = ''
                  SELECT ooef206,ooefstus INTO l_ooef.*
                  FROM ooef_t
                  WHERE ooefent = g_enterprise
                  AND ooef001 = g_nmdf_m.nmdfsite  
                  CASE 
                     WHEN SQLCA.SQLCODE = 100 LET g_errno = 'aoo-00094'
                     WHEN l_ooef.ooefstus = 'N' LET g_errno = 'sub-01302' #aoo-00095 #160318-00005#29  By 07900 --mod
                     WHEN l_ooef.ooef206<>'Y' LET g_errno = 'anm-00272'
                  END CASE
                  
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmdf_m.nmdfsite
                      #160318-00005#29 by 07900 --add--str
                     LET g_errparam.replace[1] = 'aooi125'
                     LET g_errparam.replace[2] = cl_get_progname("aooi125",g_lang,"2")
                     LET g_errparam.exeprog ='aooi125'
                     #160318-00005#29 by 07900 --add--end
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                    #LET g_nmdf_m.nmdfsite = g_nmdf_m_t.nmdfsite #160824-00007#319 170113 By 08171 mark
                     LET g_nmdf_m.nmdfsite = g_nmdf_m_o.nmdfsite #160824-00007#319 170113 By 08171 add
                     NEXT FIELD CURRENT
                  END IF
#160816-00012#3 add s---                  
                  CALL s_fin_account_center_with_ld_chk(g_nmdf_m.nmdfsite,'',g_user,'6','N','',g_today) RETURNING g_sub_success,g_errno  
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno       
                     LET g_errparam.extend = g_nmdf_m.nmdfsite
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                    #LET g_nmdf_m.nmdfsite = g_nmdf_m_t.nmdfsite #160824-00007#319 170113 By 08171 mark
                     LET g_nmdf_m.nmdfsite = g_nmdf_m_o.nmdfsite #160824-00007#319 170113 By 08171 add
                     NEXT FIELD CURRENT
                  END IF
                  
                  CALL s_anm_get_comp_wc('6',g_nmdf_m.nmdfsite,g_today) RETURNING g_comp_wc
                  IF NOT cl_null(g_nmdf_m.nmdfcomf) THEN
                     IF s_chr_get_index_of(g_comp_wc,g_nmdf_m.nmdfcomf,1) = 0 THEN    
                        SELECT ooef017 INTO g_nmdf_m.nmdfcomf
                          FROM ooef_t
                         WHERE ooefent = g_enterprise
                           AND ooef001 = g_nmdf_m.nmdfsite

                        #检查用户是否有资金中心对应法人的权限
                        CALL s_axrt300_get_site(g_user,'','3') RETURNING l_wc
                        LET l_count = 0
                        LET l_sql = "SELECT COUNT(*) FROM ooef_t WHERE ooefent = '",g_enterprise,"' ",
                                    "   AND ooef001 = '",g_nmdf_m.nmdfcomf,"'",
                                    "   AND ooef003 = 'Y'",
                                    "   AND ",l_wc CLIPPED
                        PREPARE anmt830_count_prep FROM l_sql
                        EXECUTE anmt830_count_prep INTO l_count
                        IF cl_null(l_count) THEN LET l_count = 0 END IF
                        IF l_count = 0 THEN
                           LET g_nmdf_m.nmdfcomf = ''
                           LET g_nmdf_m.nmdfcomf_desc = ''
                           DISPLAY BY NAME g_nmdf_m.nmdfcomf,g_nmdf_m.nmdfcomf_desc
                        END IF

                        DISPLAY BY NAME g_nmdf_m.nmdfcomf
                        CALL s_anm_get_site_wc('6',g_nmdf_m.nmdfcomf,g_today) RETURNING g_site_wc
                     END IF
                  END IF              
#160816-00012#3 add e---                  
               END IF
            END IF 
           INITIALIZE g_ref_fields TO NULL
           LET g_ref_fields[1] = g_nmdf_m.nmdfsite
           CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
           LET g_nmdf_m.nmdfsite_desc = '', g_rtn_fields[1] , ''
           DISPLAY BY NAME g_nmdf_m.nmdfsite_desc
           LET g_nmdf_m_o.* = g_nmdf_m.* #160824-00007#319 170113 By 08171 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmdfsite
            #add-point:BEFORE FIELD nmdfsite name="input.b.nmdfsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmdfsite
            #add-point:ON CHANGE nmdfsite name="input.g.nmdfsite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmdfcomf
            
            #add-point:AFTER FIELD nmdfcomf name="input.a.nmdfcomf"
  
            IF NOT cl_null(g_nmdf_m.nmdfcomf) THEN 
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_nmdf_m.nmdfcomf != g_nmdf_m_t.nmdfcomf OR g_nmdf_m_t.nmdfcomf IS NULL )) THEN #160824-00007#319 170113 By 08171 mark
               IF cl_null(g_nmdf_m_o.nmdfcomf) OR g_nmdf_m.nmdfcomf != g_nmdf_m_o.nmdfcomf THEN #160824-00007#319 170113 By 08171 add
                  CALL s_fin_comp_chk(g_nmdf_m.nmdfcomf) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     #160321-00016#40 --s add
                     LET g_errparam.replace[1] = 'aooi100'
                     LET g_errparam.replace[2] = cl_get_progname('aooi100',g_lang,"2")
                     LET g_errparam.exeprog = 'aooi100'
                     #160321-00016#40 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                    #LET g_nmdf_m.nmdfcomf = g_nmdf_m_t.nmdfcomf #160824-00007#319 170113 By 08171 mark
                     LET g_nmdf_m.nmdfcomf = g_nmdf_m_o.nmdfcomf #160824-00007#319 170113 By 08171 add
                     NEXT FIELD CURRENT
                  END IF
                  #160816-00012#3 add s---
                  IF NOT cl_null(g_nmdf_m.nmdfsite) THEN  
                     IF s_chr_get_index_of(g_comp_wc,g_nmdf_m.nmdfcomf,1) = 0 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'anm-02928'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                       #LET g_nmdf_m.nmdfcomf = g_nmdf_m_t.nmdfcomf #160824-00007#319 170113 By 08171 mark
                        LET g_nmdf_m.nmdfcomf = g_nmdf_m_o.nmdfcomf #160824-00007#319 170113 By 08171 add
                        NEXT FIELD CURRENT
                     END IF
                  END IF  

                  #检查用户是否有资金中心对应法人的权限
                  CALL s_axrt300_get_site(g_user,'','3') RETURNING l_wc
                  LET l_count = 0
                  LET l_sql = "SELECT COUNT(*) FROM ooef_t WHERE ooefent = '",g_enterprise,"' ",
                              "   AND ooef001 = '",g_nmdf_m.nmdfcomf,"'",
                              "   AND ooef003 = 'Y'",
                              "   AND ",l_wc CLIPPED
                  PREPARE anmt830_count_prep1 FROM l_sql
                  EXECUTE anmt830_count_prep1 INTO l_count
                  IF cl_null(l_count) THEN LET l_count = 0 END IF
                  IF l_count = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "ais-00228"
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                    #LET g_nmdf_m.nmdfcomf = g_nmdf_m_t.nmdfcomf #160824-00007#319 170113 By 08171 mark
                     LET g_nmdf_m.nmdfcomf = g_nmdf_m_o.nmdfcomf #160824-00007#319 170113 By 08171 add
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_anm_get_site_wc('6',g_nmdf_m_t.nmdfcomf,g_today) RETURNING g_site_wc
                  #160816-00012#3 add e--- 
               END IF
            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_nmdf_m.nmdfcomf
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_nmdf_m.nmdfcomf_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_nmdf_m.nmdfcomf_desc         
            LET g_nmdf_m_o.* = g_nmdf_m.*   #160824-00007#319 170113 By 08171 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmdfcomf
            #add-point:BEFORE FIELD nmdfcomf name="input.b.nmdfcomf"
           
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmdfcomf
            #add-point:ON CHANGE nmdfcomf name="input.g.nmdfcomf"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmdf003
            
            #add-point:AFTER FIELD nmdf003 name="input.a.nmdf003"

            #此段落由子樣板a05產生
            
            IF NOT cl_null(g_nmdf_m.nmdf003) THEN
               SELECT COUNT(*) INTO l_n1 FROM nmas_t 
               WHERE nmasent = g_enterprise #2015/04/02 by 02599 add
                 AND nmas002 = g_nmdf_m.nmdf003
               IF l_n1 = 0 THEN
                  NEXT FIELD CURRENT
               END IF
            END　IF
            
            
            #確認資料無重複
            IF  NOT cl_null(g_nmdf_m.nmdf001) AND NOT cl_null(g_nmdf_m.nmdf002) AND NOT cl_null(g_nmdf_m.nmdf003) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_nmdf_m.nmdf001 != g_nmdf001_t  OR g_nmdf_m.nmdf002 != g_nmdf002_t  OR g_nmdf_m.nmdf003 != g_nmdf003_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM nmdf_t WHERE "||"nmdfent = '" ||g_enterprise|| "' AND "||"nmdf001 = '"||g_nmdf_m.nmdf001 ||"' AND "|| "nmdf002 = '"||g_nmdf_m.nmdf002 ||"' AND "|| "nmdf003 = '"||g_nmdf_m.nmdf003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #確認資料無重複
            IF NOT cl_null(g_nmdf_m.nmdf003) THEN
               IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM nmdf_t WHERE "||"nmdfent = '" ||g_enterprise|| "' AND "|| "nmdf003 = '"||g_nmdf_m.nmdf003 ||"'",'anm-00367',0) THEN 
                  NEXT FIELD CURRENT
               END IF
            END IF
            
            #160122-00001#29--add---str--
            IF NOT cl_null(g_nmdf_m.nmdf003) THEN
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_nmdf_m.nmdf003 != g_nmdf_m_t.nmdf003 OR cl_null(g_nmdf_m_t.nmdf003))) THEN  #160824-00007#319 170113 By 08171 mark
               IF cl_null(g_nmdf_m_o.nmdf003) OR g_nmdf_m.nmdf003 != g_nmdf_m_o.nmdf003 THEN #160824-00007#319 170113 By 08171 add
                  IF NOT s_anmi120_nmll002_chk(g_nmdf_m.nmdf003,g_user) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'anm-00574'
                     LET g_errparam.extend = g_nmdf_m.nmdf003
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     
                    #LET g_nmdf_m.nmdf003 = g_nmdf_m_t.nmdf003 #160824-00007#319 170113 By 08171 mark
                     LET g_nmdf_m.nmdf003 = g_nmdf_m_o.nmdf003 #160824-00007#319 170113 By 08171 add
                     INITIALIZE g_ref_fields TO NULL
                     LET g_ref_fields[1] = g_nmdf_m.nmdf003
                     CALL ap_ref_array2(g_ref_fields,"SELECT nmas003 FROM nmas_t WHERE nmasent='"||g_enterprise||"' AND nmas002=? ","") RETURNING g_rtn_fields
                     LET g_nmdf_m.nmdf003_desc_1 = '', g_rtn_fields[1] , ''
                     DISPLAY BY NAME  g_nmdf_m.nmdf003_desc_1
                     
                     INITIALIZE g_ref_fields TO NULL
                     LET g_ref_fields[1] = g_nmdf_m.nmdf003
                     CALL ap_ref_array2(g_ref_fields,"select  nmaal003 from nmas_t left join  (select  distinct nmaal001,nmaal003 from nmaal_t where nmaalent = '"||g_enterprise||"' and nmaal002 = '"||g_dlang||"' ) on nmas001 = nmaal001 where nmas002=?","") 
                     RETURNING g_rtn_fields
                     LET g_nmdf_m.nmdf003_desc = '', g_rtn_fields[1] , ''
                     DISPLAY BY NAME g_nmdf_m.nmdf003_desc
                     
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #160122-00001#29--add---end
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_nmdf_m.nmdf003
            CALL ap_ref_array2(g_ref_fields,"SELECT nmas003 FROM nmas_t WHERE nmasent='"||g_enterprise||"' AND nmas002=? ","") RETURNING g_rtn_fields
            LET g_nmdf_m.nmdf003_desc_1 = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME  g_nmdf_m.nmdf003_desc_1
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_nmdf_m.nmdf003
            CALL ap_ref_array2(g_ref_fields,"select  nmaal003 from nmas_t left join  (select  distinct nmaal001,nmaal003 from nmaal_t where nmaalent = '"||g_enterprise||"' and nmaal002 = '"||g_dlang||"' ) on nmas001 = nmaal001 where nmas002=?","") 
            RETURNING g_rtn_fields
            LET g_nmdf_m.nmdf003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_nmdf_m.nmdf003_desc
            LET g_nmdf_m_o.* = g_nmdf_m.* #160824-00007#319 170113 By 08171 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmdf003
            #add-point:BEFORE FIELD nmdf003 name="input.b.nmdf003"
          
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmdf003
            #add-point:ON CHANGE nmdf003 name="input.g.nmdf003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmdf001
            #add-point:BEFORE FIELD nmdf001 name="input.b.nmdf001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmdf001
            
            #add-point:AFTER FIELD nmdf001 name="input.a.nmdf001"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_nmdf_m.nmdf001) AND NOT cl_null(g_nmdf_m.nmdf002) AND NOT cl_null(g_nmdf_m.nmdf003) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_nmdf_m.nmdf001 != g_nmdf001_t  OR g_nmdf_m.nmdf002 != g_nmdf002_t  OR g_nmdf_m.nmdf003 != g_nmdf003_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM nmdf_t WHERE "||"nmdfent = '" ||g_enterprise|| "' AND "||"nmdf001 = '"||g_nmdf_m.nmdf001 ||"' AND "|| "nmdf002 = '"||g_nmdf_m.nmdf002 ||"' AND "|| "nmdf003 = '"||g_nmdf_m.nmdf003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
      
            #150813-00015#23--add--str--
            IF NOT cl_null(g_nmdf_m.nmdf001) THEN
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_nmdf_m.nmdf001 != g_nmdf_m_t.nmdf001 OR cl_null(g_nmdf_m_t.nmdf001))) THEN  #160824-00007#319 170113 By 08171 mark
               IF cl_null(g_nmdf_m_o.nmdf001) OR g_nmdf_m.nmdf001 != g_nmdf_m_o.nmdf001 THEN #160824-00007#319 170113 By 08171 add
                  #檢查年度+期别不可小於等於關帳日期的年度+期别
                  CALL cl_get_para(g_enterprise,g_nmdf_m.nmdfcomf,'S-FIN-4007') RETURNING l_para_date
                  IF g_nmdf_m.nmdf001 < YEAR(l_para_date) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = g_nmdf_m.nmdf001
                     LET g_errparam.code   = 'anm-00387'
                     LET g_errparam.popup  = FALSE 
                     CALL cl_err()
                    #LET g_nmdf_m.nmdf001 = g_nmdf_m_t.nmdf001 #160824-00007#319 170113 By 08171 mark
                     LET g_nmdf_m.nmdf001 = g_nmdf_m_o.nmdf001 #160824-00007#319 170113 By 08171 add
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(g_nmdf_m.nmdf002) THEN
                     IF g_nmdf_m.nmdf001 =YEAR(l_para_date) AND g_nmdf_m.nmdf002 < MONTH(l_para_date) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = g_nmdf_m.nmdf002
                        LET g_errparam.code   = 'anm-00387'
                        LET g_errparam.popup  = FALSE 
                        CALL cl_err()
                        NEXT FIELD nmdf002
                     END IF
                  END IF
                  #160930-00021#1--add--s--
                  IF NOT cl_null(g_nmdf_m.nmdf002) AND NOT cl_null(g_nmdf_m.nmdfcomf) AND g_nmdf_m.nmdf001 <> 0 THEN
                     SELECT glaa003 INTO l_glaa003
                       FROM glaa_t
                      WHERE glaaent = g_enterprise 
                        AND glaald=( SELECT glaald FROM glaa_t WHERE glaaent = g_enterprise AND glaa014 ='Y' AND glaacomp = g_nmdf_m.nmdfcomf)
                     LET l_count = 0   
                     SELECT COUNT(1) INTO l_count
                       FROM glav_t 
                      WHERE glavent = g_enterprise
                        AND glav001 = l_glaa003
                        AND glav002 = g_nmdf_m.nmdf001
                        AND glav006 = g_nmdf_m.nmdf002 
                     IF l_count =0 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = g_nmdf_m.nmdf001,'+',g_nmdf_m.nmdf002
                        LET g_errparam.code   = 'anm-03025'
                        LET g_errparam.popup  = FALSE 
                        CALL cl_err()
                       #LET g_nmdf_m.nmdf001 = g_nmdf_m_t.nmdf001 #160824-00007#319 170113 By 08171 mark
                        LET g_nmdf_m.nmdf001 = g_nmdf_m_o.nmdf001 #160824-00007#319 170113 By 08171 add
                        NEXT FIELD CURRENT
                     END IF                     
                  END IF                  
                  #160930-00021#1--add--e--
               END IF
            END IF
            #150813-00015#23--add--end
            LET g_nmdf_m_o.* = g_nmdf_m.* #160824-00007#319 170113 By 08171 add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmdf001
            #add-point:ON CHANGE nmdf001 name="input.g.nmdf001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmdf002
            #add-point:BEFORE FIELD nmdf002 name="input.b.nmdf002"
           
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmdf002
            
            #add-point:AFTER FIELD nmdf002 name="input.a.nmdf002"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_nmdf_m.nmdf001) AND NOT cl_null(g_nmdf_m.nmdf002) AND NOT cl_null(g_nmdf_m.nmdf003) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_nmdf_m.nmdf001 != g_nmdf001_t  OR g_nmdf_m.nmdf002 != g_nmdf002_t  OR g_nmdf_m.nmdf003 != g_nmdf003_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM nmdf_t WHERE "||"nmdfent = '" ||g_enterprise|| "' AND "||"nmdf001 = '"||g_nmdf_m.nmdf001 ||"' AND "|| "nmdf002 = '"||g_nmdf_m.nmdf002 ||"' AND "|| "nmdf003 = '"||g_nmdf_m.nmdf003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #150813-00015#23--add--str--
            IF NOT cl_null(g_nmdf_m.nmdf002) THEN
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_nmdf_m.nmdf002 != g_nmdf_m_t.nmdf002 OR cl_null(g_nmdf_m_t.nmdf002))) THEN  #160824-00007#319 170113 By 08171 mark
               IF cl_null(g_nmdf_m_o.nmdf002) OR g_nmdf_m.nmdf002 != g_nmdf_m_o.nmdf002 THEN #160824-00007#319 170113 By 08171 add
                  #檢查年度+期别不可小於等於關帳日期的年度+期别
                  CALL cl_get_para(g_enterprise,g_nmdf_m.nmdfcomf,'S-FIN-4007') RETURNING l_para_date
                  IF g_nmdf_m.nmdf001 =YEAR(l_para_date) AND g_nmdf_m.nmdf002 < MONTH(l_para_date) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = g_nmdf_m.nmdf002
                     LET g_errparam.code   = 'anm-00387'
                     LET g_errparam.popup  = FALSE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
                   #160930-00021#1--add--s--
                  IF NOT cl_null(g_nmdf_m.nmdf001) AND NOT cl_null(g_nmdf_m.nmdfcomf) AND g_nmdf_m.nmdf002 <> 0 THEN
                     SELECT glaa003 INTO l_glaa003
                       FROM glaa_t
                      WHERE glaaent = g_enterprise 
                        AND glaald=( SELECT glaald FROM glaa_t WHERE glaaent = g_enterprise AND glaa014 ='Y' AND glaacomp = g_nmdf_m.nmdfcomf)
                     LET l_count = 0   
                     SELECT COUNT(1) INTO l_count
                       FROM glav_t 
                      WHERE glavent = g_enterprise
                        AND glav001 = l_glaa003
                        AND glav002 = g_nmdf_m.nmdf001
                        AND glav006 = g_nmdf_m.nmdf002 
                     IF l_count =0 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = g_nmdf_m.nmdf001,'+',g_nmdf_m.nmdf002
                        LET g_errparam.code   = 'anm-03025'
                        LET g_errparam.popup  = FALSE 
                        CALL cl_err()                    
                       #LET g_nmdf_m.nmdf002 = g_nmdf_m_t.nmdf002 #160824-00007#319 170113 By 08171 mark
                        LET g_nmdf_m.nmdf002 = g_nmdf_m_o.nmdf002 #160824-00007#319 170113 By 08171 add
                        NEXT FIELD CURRENT
                     END IF                     
                  END IF                  
                  #160930-00021#1--add--e--
               END IF
            END IF
            #150813-00015#23--add--end
            LET g_nmdf_m_o.* = g_nmdf_m.* #160824-00007#319 170113 By 08171 add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmdf002
            #add-point:ON CHANGE nmdf002 name="input.g.nmdf002"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.nmdfsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmdfsite
            #add-point:ON ACTION controlp INFIELD nmdfsite name="input.c.nmdfsite"
            #資金中心
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmdf_m.nmdfsite
            LET g_qryparam.where = " ooef206 = 'Y'"
            LET g_qryparam.where = g_qryparam.where," AND ooefstus= 'Y'" #161021-00050#11
            #CALL q_ooef001()    #161021-00050#11 mark
            CALL q_ooef001_33()  #161021-00050#11
            LET g_nmdf_m.nmdfsite = g_qryparam.return1
            DISPLAY g_nmdf_m.nmdfsite TO nmdfsite
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_nmdf_m.nmdfsite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_nmdf_m.nmdfsite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_nmdf_m.nmdfsite_desc
            NEXT FIELD nmdfsite
            #END add-point
 
 
         #Ctrlp:input.c.nmdfcomf
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmdfcomf
            #add-point:ON ACTION controlp INFIELD nmdfcomf name="input.c.nmdfcomf"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmdf_m.nmdfcomf
            #160816-00012#3 add s---
            #CALL s_fin_account_center_sons_query('6',g_nmdf_m.nmdfsite,g_today,'')
            #CALL s_fin_account_center_comp_str()
            #RETURNING l_origin_str
            #LET tok = base.StringTokenizer.create(l_origin_str,",")
            #WHILE tok.hasMoreTokens()
            #   IF cl_null(l_str) THEN
            #      LET l_str = tok.nextToken()
            #   ELSE
            #      LET l_str = l_str,"','",tok.nextToken()
            #   END IF
            #END WHILE
            #LET l_origin_str = "'",l_str,"'"
            #LET g_qryparam.where = " ooef003 = 'Y' AND ooef001 IN(",l_origin_str CLIPPED,") "
            ##LET g_qryparam.where = " ooef001 IN (",l_origin_str CLIPPED,") AND ooef017 ='",g_nmdf_m.nmdfsite,"' "
            CALL s_anm_get_comp_wc('6',g_nmdf_m.nmdfsite,g_today) RETURNING g_comp_wc
            LET g_qryparam.where = " ooef001 IN ",g_comp_wc 
            CALL s_axrt300_get_site(g_user,'','3') RETURNING l_wc
            LET g_qryparam.where = g_qryparam.where," AND ",l_wc CLIPPED," AND ooef003 = 'Y'"
            #160816-00012#3 mod e---
            #CALL q_ooef001()  #161021-00050#11 mark
            CALL q_ooef001_2() #161021-00050#11
            LET g_nmdf_m.nmdfcomf = g_qryparam.return1
            DISPLAY g_nmdf_m.nmdfcomf TO nmdfcomf
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_nmdf_m.nmdfcomf
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_nmdf_m.nmdfcomf_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_nmdf_m.nmdfcomf_desc
            NEXT FIELD nmdfcomf
            #END add-point
 
 
         #Ctrlp:input.c.nmdf003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmdf003
            #add-point:ON ACTION controlp INFIELD nmdf003 name="input.c.nmdf003"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            IF NOT cl_null(g_nmdf_m.nmdfcomf) THEN
               LET g_qryparam.where =" ooef017='",g_nmdf_m.nmdfcomf,"' "
            END IF
            #160122-00001#29--add---str--
            IF cl_null(g_qryparam.where) THEN
               LET g_qryparam.where=" nmas002 IN (",g_sql_bank,")"        #160122-00001#29 By 07900 --mod
            ELSE
               LET g_qryparam.where=g_qryparam.where," AND nmas002 IN (",g_sql_bank,")"   #160122-00001#29 By 07900 --mod
            END IF
            #160122-00001#29--add---end
            LET g_qryparam.default1 = g_nmdf_m.nmdf003             #給予default值
            LET g_qryparam.default2 = "" #g_nmdf_m.nmas002 #交易帳戶編碼
            LET g_qryparam.default3 = "" #g_nmdf_m.nmas003 #交易幣別
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_nmas002_5()                                #呼叫開窗

            LET g_nmdf_m.nmdf003 = g_qryparam.return1              
            LET g_nmdf_m.nmdf003_desc_1 = g_qryparam.return2 
            LET g_nmdf_m.nmdf003_desc = g_qryparam.return3 
            DISPLAY g_nmdf_m.nmdf003 TO nmdf003              #
            DISPLAY BY NAME g_nmdf_m.nmdf003_desc_1
            DISPLAY BY NAME g_nmdf_m.nmdf003_desc #交易幣別
            NEXT FIELD nmdf003                          #返回原欄位
           
            #END add-point
 
 
         #Ctrlp:input.c.nmdf001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmdf001
            #add-point:ON ACTION controlp INFIELD nmdf001 name="input.c.nmdf001"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmdf002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmdf002
            #add-point:ON ACTION controlp INFIELD nmdf002 name="input.c.nmdf002"
            
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
            DISPLAY BY NAME g_nmdf_m.nmdf001             
                            ,g_nmdf_m.nmdf002   
                            ,g_nmdf_m.nmdf003   
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
            
               #將遮罩欄位還原
               CALL anmt830_nmdf_t_mask_restore('restore_mask_o')
            
               UPDATE nmdf_t SET (nmdfsite,nmdfcomf,nmdf003,nmdf001,nmdf002,nmdf014) = (g_nmdf_m.nmdfsite, 
                   g_nmdf_m.nmdfcomf,g_nmdf_m.nmdf003,g_nmdf_m.nmdf001,g_nmdf_m.nmdf002,g_nmdf_m.nmdf014) 
 
                WHERE nmdfent = g_enterprise AND nmdf001 = g_nmdf001_t
                  AND nmdf002 = g_nmdf002_t
                  AND nmdf003 = g_nmdf003_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "nmdf_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "nmdf_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_nmdf_m.nmdf001
               LET gs_keys_bak[1] = g_nmdf001_t
               LET gs_keys[2] = g_nmdf_m.nmdf002
               LET gs_keys_bak[2] = g_nmdf002_t
               LET gs_keys[3] = g_nmdf_m.nmdf003
               LET gs_keys_bak[3] = g_nmdf003_t
               LET gs_keys[4] = g_nmdf_d[g_detail_idx].nmdfseq
               LET gs_keys_bak[4] = g_nmdf_d_t.nmdfseq
               CALL anmt830_update_b('nmdf_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_nmdf_m_t)
                     #LET g_log2 = util.JSON.stringify(g_nmdf_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL anmt830_nmdf_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL anmt830_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_nmdf001_t = g_nmdf_m.nmdf001
           LET g_nmdf002_t = g_nmdf_m.nmdf002
           LET g_nmdf003_t = g_nmdf_m.nmdf003
 
           
           IF g_nmdf_d.getLength() = 0 THEN
              NEXT FIELD nmdfseq
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="anmt830.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_nmdf_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_nmdf_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL anmt830_b_fill(g_wc2) #test 
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
            CALL anmt830_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN anmt830_cl USING g_enterprise,g_nmdf_m.nmdf001,g_nmdf_m.nmdf002,g_nmdf_m.nmdf003                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE anmt830_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN anmt830_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_nmdf_d[l_ac].nmdfseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_nmdf_d_t.* = g_nmdf_d[l_ac].*  #BACKUP
               LET g_nmdf_d_o.* = g_nmdf_d[l_ac].*  #BACKUP
               CALL anmt830_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL anmt830_set_no_entry_b(l_cmd)
               OPEN anmt830_bcl USING g_enterprise,g_nmdf_m.nmdf001,
                                                g_nmdf_m.nmdf002,
                                                g_nmdf_m.nmdf003,
 
                                                g_nmdf_d_t.nmdfseq
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN anmt830_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH anmt830_bcl INTO g_nmdf_d[l_ac].nmdfseq,g_nmdf_d[l_ac].nmdf005,g_nmdf_d[l_ac].nmdf006, 
                      g_nmdf_d[l_ac].nmdf007,g_nmdf_d[l_ac].nmdf008,g_nmdf_d[l_ac].nmdf009,g_nmdf_d[l_ac].nmdf010, 
                      g_nmdf_d[l_ac].nmdf004,g_nmdf_d[l_ac].nmdf012,g_nmdf_d[l_ac].nmdf013,g_nmdf2_d[l_ac].nmdfownid, 
                      g_nmdf2_d[l_ac].nmdfowndp,g_nmdf2_d[l_ac].nmdfcrtid,g_nmdf2_d[l_ac].nmdfcrtdp, 
                      g_nmdf2_d[l_ac].nmdfcrtdt,g_nmdf2_d[l_ac].nmdfmodid,g_nmdf2_d[l_ac].nmdfmoddt
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_nmdf_d_t.nmdfseq,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_nmdf_d_mask_o[l_ac].* =  g_nmdf_d[l_ac].*
                  CALL anmt830_nmdf_t_mask()
                  LET g_nmdf_d_mask_n[l_ac].* =  g_nmdf_d[l_ac].*
                  
                  CALL anmt830_ref_show()
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
            INITIALIZE g_nmdf_d_t.* TO NULL
            INITIALIZE g_nmdf_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_nmdf_d[l_ac].* TO NULL
            #公用欄位預設值
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_nmdf2_d[l_ac].nmdfownid = g_user
      LET g_nmdf2_d[l_ac].nmdfowndp = g_dept
      LET g_nmdf2_d[l_ac].nmdfcrtid = g_user
      LET g_nmdf2_d[l_ac].nmdfcrtdp = g_dept 
      LET g_nmdf2_d[l_ac].nmdfcrtdt = cl_get_current()
      LET g_nmdf2_d[l_ac].nmdfmodid = g_user
      LET g_nmdf2_d[l_ac].nmdfmoddt = cl_get_current()
 
 
  
            #一般欄位預設值
                  LET g_nmdf_d[l_ac].nmdf007 = "0"
      LET g_nmdf_d[l_ac].nmdf008 = "0"
 
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            LET g_nmdf_d[l_ac].nmdf010='N'
            #end add-point
            LET g_nmdf_d_t.* = g_nmdf_d[l_ac].*     #新輸入資料
            LET g_nmdf_d_o.* = g_nmdf_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL anmt830_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL anmt830_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_nmdf_d[li_reproduce_target].* = g_nmdf_d[li_reproduce].*
               LET g_nmdf2_d[li_reproduce_target].* = g_nmdf2_d[li_reproduce].*
 
               LET g_nmdf_d[g_nmdf_d.getLength()].nmdfseq = NULL
 
            END IF
            
 
 
            #add-point:modify段before insert name="input.body.before_insert"
            #項次
            SELECT MAX(nmdfseq) INTO g_nmdf_d[l_ac].nmdfseq
              FROM nmdf_t
             WHERE nmdfent=g_enterprise
               AND nmdf001=g_nmdf_m.nmdf001
               AND nmdf002=g_nmdf_m.nmdf002
               AND nmdf003=g_nmdf_m.nmdf003
            IF cl_null(g_nmdf_d[l_ac].nmdfseq) THEN
               LET g_nmdf_d[l_ac].nmdfseq=1
            ELSE
               LET g_nmdf_d[l_ac].nmdfseq=g_nmdf_d[l_ac].nmdfseq+1
            END IF
            DISPLAY g_nmdf_d[l_ac].nmdfseq TO nmdfseq
            
            #流水號      
            LET l_datechr = g_today USING 'YYYYMMDD'            
            LET l_date= MDY(g_nmdf_m.nmdf002,1,g_nmdf_m.nmdf001)
            LET l_datechr = l_date USING 'YYYYMMDD'
            
            SELECT MAX(nmdf004) INTO g_nmdf_d[l_ac].nmdf004
              FROM nmdf_t
             WHERE nmdfent=g_enterprise
               AND nmdf001=g_nmdf_m.nmdf001
               AND nmdf002=g_nmdf_m.nmdf002
               AND nmdf003=g_nmdf_m.nmdf003
                     
            IF NOT cl_null(g_nmdf_d[l_ac].nmdf004) THEN  
               LET l_string=g_nmdf_d[l_ac].nmdf004
               LET l_num5=g_nmdf_d[l_ac].nmdf004[l_string.getLength()-4,l_string.getLength()]
               LET l_num5=l_num5+1 USING '&&&&&'
            ELSE
               LET l_num5=1
               LET l_num5 = l_num5 USING '&&&&&'
            END IF
            
            LET l_chr5=l_num5 USING '&&&&&'
            
            LET g_nmdf_d[l_ac].nmdf004=g_nmdf_m.nmdfsite,l_datechr,l_chr5            
            DISPLAY g_nmdf_d[l_ac].nmdf004 TO nmdf004
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
            SELECT COUNT(1) INTO l_count FROM nmdf_t 
             WHERE nmdfent = g_enterprise AND nmdf001 = g_nmdf_m.nmdf001
               AND nmdf002 = g_nmdf_m.nmdf002
               AND nmdf003 = g_nmdf_m.nmdf003
 
               AND nmdfseq = g_nmdf_d[l_ac].nmdfseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
               INSERT INTO nmdf_t
                           (nmdfent,
                            nmdfsite,nmdfcomf,nmdf003,nmdf001,nmdf002,nmdf014,
                            nmdfseq
                            ,nmdf005,nmdf006,nmdf007,nmdf008,nmdf009,nmdf010,nmdf004,nmdf012,nmdf013,nmdfownid,nmdfowndp,nmdfcrtid,nmdfcrtdp,nmdfcrtdt,nmdfmodid,nmdfmoddt) 
                     VALUES(g_enterprise,
                            g_nmdf_m.nmdfsite,g_nmdf_m.nmdfcomf,g_nmdf_m.nmdf003,g_nmdf_m.nmdf001,g_nmdf_m.nmdf002,g_nmdf_m.nmdf014,
                            g_nmdf_d[l_ac].nmdfseq
                            ,g_nmdf_d[l_ac].nmdf005,g_nmdf_d[l_ac].nmdf006,g_nmdf_d[l_ac].nmdf007,g_nmdf_d[l_ac].nmdf008, 
                                g_nmdf_d[l_ac].nmdf009,g_nmdf_d[l_ac].nmdf010,g_nmdf_d[l_ac].nmdf004, 
                                g_nmdf_d[l_ac].nmdf012,g_nmdf_d[l_ac].nmdf013,g_nmdf2_d[l_ac].nmdfownid, 
                                g_nmdf2_d[l_ac].nmdfowndp,g_nmdf2_d[l_ac].nmdfcrtid,g_nmdf2_d[l_ac].nmdfcrtdp, 
                                g_nmdf2_d[l_ac].nmdfcrtdt,g_nmdf2_d[l_ac].nmdfmodid,g_nmdf2_d[l_ac].nmdfmoddt) 
 
               #add-point:單身新增中 name="input.body.m_insert"
               
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_nmdf_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "nmdf_t:",SQLERRMESSAGE 
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
               IF anmt830_before_delete() THEN 
                  
 
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_nmdf_m.nmdf001
                  LET gs_keys[gs_keys.getLength()+1] = g_nmdf_m.nmdf002
                  LET gs_keys[gs_keys.getLength()+1] = g_nmdf_m.nmdf003
 
                  LET gs_keys[gs_keys.getLength()+1] = g_nmdf_d_t.nmdfseq
 
 
                  #刪除下層單身
                  IF NOT anmt830_key_delete_b(gs_keys,'nmdf_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE anmt830_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE anmt830_bcl
               LET l_count = g_nmdf_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_nmdf_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmdfseq
            #add-point:BEFORE FIELD nmdfseq name="input.b.page1.nmdfseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmdfseq
            
            #add-point:AFTER FIELD nmdfseq name="input.a.page1.nmdfseq"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_nmdf_m.nmdf001 IS NOT NULL AND g_nmdf_m.nmdf002 IS NOT NULL AND g_nmdf_m.nmdf003 IS NOT NULL AND g_nmdf_d[g_detail_idx].nmdfseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_nmdf_m.nmdf001 != g_nmdf001_t OR g_nmdf_m.nmdf002 != g_nmdf002_t OR g_nmdf_m.nmdf003 != g_nmdf003_t OR g_nmdf_d[g_detail_idx].nmdfseq != g_nmdf_d_t.nmdfseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM nmdf_t WHERE "||"nmdfent = '" ||g_enterprise|| "' AND "||"nmdf001 = '"||g_nmdf_m.nmdf001 ||"' AND "|| "nmdf002 = '"||g_nmdf_m.nmdf002 ||"' AND "|| "nmdf003 = '"||g_nmdf_m.nmdf003 ||"' AND "|| "nmdfseq = '"||g_nmdf_d[g_detail_idx].nmdfseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmdfseq
            #add-point:ON CHANGE nmdfseq name="input.g.page1.nmdfseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmdf005
            #add-point:BEFORE FIELD nmdf005 name="input.b.page1.nmdf005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmdf005
            
            #add-point:AFTER FIELD nmdf005 name="input.a.page1.nmdf005"
            IF g_nmdf_d[l_ac].nmdf005 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_nmdf_d[l_ac].nmdf005 != g_nmdf_d_t.nmdf005)) THEN 
                  CALL s_date_get_max_day(g_nmdf_m.nmdf001,g_nmdf_m.nmdf002) RETURNING l_day
                  LET l_bdate= MDY(g_nmdf_m.nmdf002,1,g_nmdf_m.nmdf001)
                  LET l_edate= MDY(g_nmdf_m.nmdf002,l_day,g_nmdf_m.nmdf001)
                  IF g_nmdf_d[l_ac].nmdf005<l_bdate OR g_nmdf_d[l_ac].nmdf005>l_edate THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = '' 
                     LET g_errparam.code   = "anm-00335" 
                     LET g_errparam.popup  = FALSE 
                     CALL cl_err()   
                     NEXT FIELD nmdf005                                         
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmdf005
            #add-point:ON CHANGE nmdf005 name="input.g.page1.nmdf005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmdf006
            #add-point:BEFORE FIELD nmdf006 name="input.b.page1.nmdf006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmdf006
            
            #add-point:AFTER FIELD nmdf006 name="input.a.page1.nmdf006"
            IF g_nmdf_d[l_ac].nmdf006 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_nmdf_d[l_ac].nmdf006 != g_nmdf_d_t.nmdf006)) THEN 
               
                  IF g_nmdf_d[l_ac].nmdf006='1' OR g_nmdf_d[l_ac].nmdf006='3' THEN
                     LET g_nmdf_d[l_ac].nmdf008=0
                  END IF
                  IF g_nmdf_d[l_ac].nmdf006='2' OR g_nmdf_d[l_ac].nmdf006='4' THEN
                     LET g_nmdf_d[l_ac].nmdf007=0
                  END IF                
                  CALL anmt830_set_entry_b(l_cmd)
                  CALL anmt830_set_no_entry_b(l_cmd)                  
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmdf006
            #add-point:ON CHANGE nmdf006 name="input.g.page1.nmdf006"
            IF g_nmdf_d[l_ac].nmdf006 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_nmdf_d[l_ac].nmdf006 != g_nmdf_d_t.nmdf006)) THEN 
               
                  IF g_nmdf_d[l_ac].nmdf006='1' OR g_nmdf_d[l_ac].nmdf006='3' THEN
                     LET g_nmdf_d[l_ac].nmdf008=0
                  END IF
                  IF g_nmdf_d[l_ac].nmdf006='2' OR g_nmdf_d[l_ac].nmdf006='4' THEN
                     LET g_nmdf_d[l_ac].nmdf007=0
                  END IF                
                  CALL anmt830_set_entry_b(l_cmd)
                  CALL anmt830_set_no_entry_b(l_cmd)                  
               END IF
            END IF
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmdf007
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_nmdf_d[l_ac].nmdf007,"0","1","","","azz-00079",1) THEN
               NEXT FIELD nmdf007
            END IF 
 
 
 
            #add-point:AFTER FIELD nmdf007 name="input.a.page1.nmdf007"
            IF NOT cl_null(g_nmdf_d[l_ac].nmdf007) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmdf007
            #add-point:BEFORE FIELD nmdf007 name="input.b.page1.nmdf007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmdf007
            #add-point:ON CHANGE nmdf007 name="input.g.page1.nmdf007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmdf008
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_nmdf_d[l_ac].nmdf008,"0","1","","","azz-00079",1) THEN
               NEXT FIELD nmdf008
            END IF 
 
 
 
            #add-point:AFTER FIELD nmdf008 name="input.a.page1.nmdf008"
            IF NOT cl_null(g_nmdf_d[l_ac].nmdf008) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmdf008
            #add-point:BEFORE FIELD nmdf008 name="input.b.page1.nmdf008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmdf008
            #add-point:ON CHANGE nmdf008 name="input.g.page1.nmdf008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmdf009
            #add-point:BEFORE FIELD nmdf009 name="input.b.page1.nmdf009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmdf009
            
            #add-point:AFTER FIELD nmdf009 name="input.a.page1.nmdf009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmdf009
            #add-point:ON CHANGE nmdf009 name="input.g.page1.nmdf009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmdf010
            #add-point:BEFORE FIELD nmdf010 name="input.b.page1.nmdf010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmdf010
            
            #add-point:AFTER FIELD nmdf010 name="input.a.page1.nmdf010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmdf010
            #add-point:ON CHANGE nmdf010 name="input.g.page1.nmdf010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmdf004
            #add-point:BEFORE FIELD nmdf004 name="input.b.page1.nmdf004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmdf004
            
            #add-point:AFTER FIELD nmdf004 name="input.a.page1.nmdf004"
            #此段落由子樣板a05產生
            #確認資料無重複



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmdf004
            #add-point:ON CHANGE nmdf004 name="input.g.page1.nmdf004"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.nmdfseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmdfseq
            #add-point:ON ACTION controlp INFIELD nmdfseq name="input.c.page1.nmdfseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmdf005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmdf005
            #add-point:ON ACTION controlp INFIELD nmdf005 name="input.c.page1.nmdf005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmdf006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmdf006
            #add-point:ON ACTION controlp INFIELD nmdf006 name="input.c.page1.nmdf006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmdf007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmdf007
            #add-point:ON ACTION controlp INFIELD nmdf007 name="input.c.page1.nmdf007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmdf008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmdf008
            #add-point:ON ACTION controlp INFIELD nmdf008 name="input.c.page1.nmdf008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmdf009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmdf009
            #add-point:ON ACTION controlp INFIELD nmdf009 name="input.c.page1.nmdf009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmdf010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmdf010
            #add-point:ON ACTION controlp INFIELD nmdf010 name="input.c.page1.nmdf010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmdf004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmdf004
            #add-point:ON ACTION controlp INFIELD nmdf004 name="input.c.page1.nmdf004"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_nmdf_d[l_ac].* = g_nmdf_d_t.*
               CLOSE anmt830_bcl
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
               LET g_errparam.extend = g_nmdf_d[l_ac].nmdfseq 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_nmdf_d[l_ac].* = g_nmdf_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               LET g_nmdf2_d[l_ac].nmdfmodid = g_user 
LET g_nmdf2_d[l_ac].nmdfmoddt = cl_get_current()
LET g_nmdf2_d[l_ac].nmdfmodid_desc = cl_get_username(g_nmdf2_d[l_ac].nmdfmodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
         
               #將遮罩欄位還原
               CALL anmt830_nmdf_t_mask_restore('restore_mask_o')
         
               UPDATE nmdf_t SET (nmdf001,nmdf002,nmdf003,nmdfseq,nmdf005,nmdf006,nmdf007,nmdf008,nmdf009, 
                   nmdf010,nmdf004,nmdf012,nmdf013,nmdfownid,nmdfowndp,nmdfcrtid,nmdfcrtdp,nmdfcrtdt, 
                   nmdfmodid,nmdfmoddt) = (g_nmdf_m.nmdf001,g_nmdf_m.nmdf002,g_nmdf_m.nmdf003,g_nmdf_d[l_ac].nmdfseq, 
                   g_nmdf_d[l_ac].nmdf005,g_nmdf_d[l_ac].nmdf006,g_nmdf_d[l_ac].nmdf007,g_nmdf_d[l_ac].nmdf008, 
                   g_nmdf_d[l_ac].nmdf009,g_nmdf_d[l_ac].nmdf010,g_nmdf_d[l_ac].nmdf004,g_nmdf_d[l_ac].nmdf012, 
                   g_nmdf_d[l_ac].nmdf013,g_nmdf2_d[l_ac].nmdfownid,g_nmdf2_d[l_ac].nmdfowndp,g_nmdf2_d[l_ac].nmdfcrtid, 
                   g_nmdf2_d[l_ac].nmdfcrtdp,g_nmdf2_d[l_ac].nmdfcrtdt,g_nmdf2_d[l_ac].nmdfmodid,g_nmdf2_d[l_ac].nmdfmoddt) 
 
                WHERE nmdfent = g_enterprise AND nmdf001 = g_nmdf_m.nmdf001 
                 AND nmdf002 = g_nmdf_m.nmdf002 
                 AND nmdf003 = g_nmdf_m.nmdf003 
 
                 AND nmdfseq = g_nmdf_d_t.nmdfseq #項次   
 
                 
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "nmdf_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "nmdf_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_nmdf_m.nmdf001
               LET gs_keys_bak[1] = g_nmdf001_t
               LET gs_keys[2] = g_nmdf_m.nmdf002
               LET gs_keys_bak[2] = g_nmdf002_t
               LET gs_keys[3] = g_nmdf_m.nmdf003
               LET gs_keys_bak[3] = g_nmdf003_t
               LET gs_keys[4] = g_nmdf_d[g_detail_idx].nmdfseq
               LET gs_keys_bak[4] = g_nmdf_d_t.nmdfseq
               CALL anmt830_update_b('nmdf_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_nmdf_m),util.JSON.stringify(g_nmdf_d_t)
                     LET g_log2 = util.JSON.stringify(g_nmdf_m),util.JSON.stringify(g_nmdf_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL anmt830_nmdf_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_nmdf_m.nmdf001
               LET ls_keys[ls_keys.getLength()+1] = g_nmdf_m.nmdf002
               LET ls_keys[ls_keys.getLength()+1] = g_nmdf_m.nmdf003
 
               LET ls_keys[ls_keys.getLength()+1] = g_nmdf_d_t.nmdfseq
 
               CALL anmt830_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE anmt830_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_nmdf_d[l_ac].* = g_nmdf_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE anmt830_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_nmdf_d.getLength() = 0 THEN
               NEXT FIELD nmdfseq
            END IF
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_nmdf_d[li_reproduce_target].* = g_nmdf_d[li_reproduce].*
               LET g_nmdf2_d[li_reproduce_target].* = g_nmdf2_d[li_reproduce].*
 
               LET g_nmdf_d[li_reproduce_target].nmdfseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_nmdf_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_nmdf_d.getLength()+1
            END IF
            
      END INPUT
 
 
      
      DISPLAY ARRAY g_nmdf2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
      
         BEFORE ROW
            CALL anmt830_b_fill(g_wc2) #test 
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_page = 2
            CALL anmt830_idx_chk()
            CALL anmt830_ui_detailshow()
        
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
            NEXT FIELD nmdf001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD nmdfseq
               WHEN "s_detail2"
                  NEXT FIELD nmdfownid
 
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
 
{<section id="anmt830.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION anmt830_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = g_nmdf_m.nmdfsite
    CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
    LET g_nmdf_m.nmdfsite_desc = '', g_rtn_fields[1] , ''
    DISPLAY BY NAME g_nmdf_m.nmdfsite_desc
    
    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = g_nmdf_m.nmdfcomf
    CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
    LET g_nmdf_m.nmdfcomf_desc = '', g_rtn_fields[1] , ''
    DISPLAY BY NAME g_nmdf_m.nmdfcomf_desc
      
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_nmdf_m.nmdf003
   CALL ap_ref_array2(g_ref_fields,"SELECT nmas003 FROM nmas_t WHERE nmasent='"||g_enterprise||"' AND nmas002=? ","") RETURNING g_rtn_fields
   LET g_nmdf_m.nmdf003_desc_1 = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME  g_nmdf_m.nmdf003_desc_1
            
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_nmdf_m.nmdf003
   CALL ap_ref_array2(g_ref_fields,"select  nmaal003 from nmas_t left join  (select  distinct nmaal001,nmaal003 from nmaal_t where nmaalent = '"||g_enterprise||"' and nmaal002 = '"||g_dlang||"' ) on nmas001 = nmaal001 where nmas002=?","") 
   RETURNING g_rtn_fields
   LET g_nmdf_m.nmdf003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_nmdf_m.nmdf003_desc
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL anmt830_b_fill(g_wc2) #第一階單身填充
      CALL anmt830_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL anmt830_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_nmdf_m.nmdfsite,g_nmdf_m.nmdfsite_desc,g_nmdf_m.nmdfcomf,g_nmdf_m.nmdfcomf_desc, 
       g_nmdf_m.nmdf003,g_nmdf_m.nmdf003_desc,g_nmdf_m.nmdf003_desc_1,g_nmdf_m.nmdf001,g_nmdf_m.nmdf002, 
       g_nmdf_m.nmdf014
 
   CALL anmt830_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
   
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="anmt830.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION anmt830_ref_show()
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
   FOR l_ac = 1 TO g_nmdf_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_nmdf2_d.getLength()
      #add-point:ref_show段d2_reference name="ref_show.body2.reference"
      
      #end add-point
   END FOR
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="anmt830.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION anmt830_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE nmdf_t.nmdf001 
   DEFINE l_oldno     LIKE nmdf_t.nmdf001 
   DEFINE l_newno02     LIKE nmdf_t.nmdf002 
   DEFINE l_oldno02     LIKE nmdf_t.nmdf002 
   DEFINE l_newno03     LIKE nmdf_t.nmdf003 
   DEFINE l_oldno03     LIKE nmdf_t.nmdf003 
 
   DEFINE l_master    RECORD LIKE nmdf_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE nmdf_t.* #此變數樣板目前無使用
 
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
 
   IF g_nmdf_m.nmdf001 IS NULL
      OR g_nmdf_m.nmdf002 IS NULL
      OR g_nmdf_m.nmdf003 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_nmdf001_t = g_nmdf_m.nmdf001
   LET g_nmdf002_t = g_nmdf_m.nmdf002
   LET g_nmdf003_t = g_nmdf_m.nmdf003
 
   
   LET g_nmdf_m.nmdf001 = ""
   LET g_nmdf_m.nmdf002 = ""
   LET g_nmdf_m.nmdf003 = ""
 
   LET g_master_insert = FALSE
   CALL anmt830_set_entry('a')
   CALL anmt830_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_nmdf_m.nmdf014 = ''     #160726-00020#13
   #end add-point
   
   #清空key欄位的desc
      LET g_nmdf_m.nmdf003_desc = ''
   DISPLAY BY NAME g_nmdf_m.nmdf003_desc
   LET g_nmdf_m.nmdf003_desc_1 = ''
   DISPLAY BY NAME g_nmdf_m.nmdf003_desc_1
 
   
   CALL anmt830_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_nmdf_m.* TO NULL
      INITIALIZE g_nmdf_d TO NULL
      INITIALIZE g_nmdf2_d TO NULL
 
      CALL anmt830_show()
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
   CALL anmt830_set_act_visible()
   CALL anmt830_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_nmdf001_t = g_nmdf_m.nmdf001
   LET g_nmdf002_t = g_nmdf_m.nmdf002
   LET g_nmdf003_t = g_nmdf_m.nmdf003
 
   
   #組合新增資料的條件
   LET g_add_browse = " nmdfent = " ||g_enterprise|| " AND",
                      " nmdf001 = '", g_nmdf_m.nmdf001, "' "
                      ," AND nmdf002 = '", g_nmdf_m.nmdf002, "' "
                      ," AND nmdf003 = '", g_nmdf_m.nmdf003, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL anmt830_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL anmt830_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL anmt830_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="anmt830.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION anmt830_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE nmdf_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE anmt830_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM nmdf_t
    WHERE nmdfent = g_enterprise AND nmdf001 = g_nmdf001_t
    AND nmdf002 = g_nmdf002_t
    AND nmdf003 = g_nmdf003_t
 
       INTO TEMP anmt830_detail
   
   #將key修正為調整後   
   UPDATE anmt830_detail 
      #更新key欄位
      SET nmdf001 = g_nmdf_m.nmdf001
          , nmdf002 = g_nmdf_m.nmdf002
          , nmdf003 = g_nmdf_m.nmdf003
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
       , nmdfownid = g_user 
       , nmdfowndp = g_dept
       , nmdfcrtid = g_user
       , nmdfcrtdp = g_dept 
       , nmdfcrtdt = ld_date
       , nmdfmodid = g_user
       , nmdfmoddt = ld_date
 
 
 
                                       
   #將資料塞回原table   
   INSERT INTO nmdf_t SELECT * FROM anmt830_detail
   
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
   DROP TABLE anmt830_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_nmdf001_t = g_nmdf_m.nmdf001
   LET g_nmdf002_t = g_nmdf_m.nmdf002
   LET g_nmdf003_t = g_nmdf_m.nmdf003
 
   
   DROP TABLE anmt830_detail
   
END FUNCTION
 
{</section>}
 
{<section id="anmt830.delete" >}
#+ 資料刪除
PRIVATE FUNCTION anmt830_delete()
   #add-point:delete段define name="delete.define_customerization"
   
   #end add-point
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE l_para_date LIKE type_t.dat #150813-00015#23 add
   DEFINE l_n         LIKE type_t.num5 #160122-00001#29 By 07900 --add
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   #150813-00015#23--add--str--
   IF g_nmdf_m.nmdf001 IS NULL
   OR g_nmdf_m.nmdf002 IS NULL
   OR g_nmdf_m.nmdf003 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   #檢查當年度+期别小於等於關帳日期的年度+期别時，不可異動單據
   CALL cl_get_para(g_enterprise,g_nmdf_m.nmdfcomf,'S-FIN-4007') RETURNING l_para_date
   IF g_nmdf_m.nmdf001 < YEAR(l_para_date) OR
      (g_nmdf_m.nmdf001 =YEAR(l_para_date) AND g_nmdf_m.nmdf002 < MONTH(l_para_date))
   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = g_nmdf_m.nmdf001,"/",g_nmdf_m.nmdf002
      LET g_errparam.code   = 'anm-00388'
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   #150813-00015#23--add--end
   #end add-point
   
   IF g_nmdf_m.nmdf001 IS NULL
   OR g_nmdf_m.nmdf002 IS NULL
   OR g_nmdf_m.nmdf003 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN anmt830_cl USING g_enterprise,g_nmdf_m.nmdf001,g_nmdf_m.nmdf002,g_nmdf_m.nmdf003
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN anmt830_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE anmt830_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE anmt830_master_referesh USING g_nmdf_m.nmdf001,g_nmdf_m.nmdf002,g_nmdf_m.nmdf003 INTO g_nmdf_m.nmdfsite, 
       g_nmdf_m.nmdfcomf,g_nmdf_m.nmdf003,g_nmdf_m.nmdf001,g_nmdf_m.nmdf002,g_nmdf_m.nmdf014,g_nmdf_m.nmdfsite_desc, 
       g_nmdf_m.nmdfcomf_desc
   
   #遮罩相關處理
   LET g_nmdf_m_mask_o.* =  g_nmdf_m.*
   CALL anmt830_nmdf_t_mask()
   LET g_nmdf_m_mask_n.* =  g_nmdf_m.*
   
   CALL anmt830_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL anmt830_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      #160122-00001#29 By 07900-add -str
      LET l_n = 0 
      #單头存在當前用戶沒有權限的交易帳戶編碼
      SELECT COUNT(*) INTO l_n FROM nmbb_t
       WHERE nmdfent = g_enterprise AND nmdf001 = g_nmdf_m.nmdf001 AND nmdf002 = g_nmdf_m.nmdf002
         AND nmdf003 NOT IN( SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = g_enterprise AND nmll002 = g_user AND nmllstus ='Y')
         AND nmdf003 NOT IN( SELECT UNIQUE nmlm001 FROM nmlm_t WHERE nmlment = g_enterprise AND nmlm002 = g_dept AND nmlmstus ='Y')
         AND TRIM(nmdf003) IS NOT NULL
      IF l_n > 0 THEN
         IF NOT cl_ask_confirm('anm-00395') THEN
            CLOSE anmt830_cl
            CALL s_transaction_end('N','0')
            RETURN
         END IF
      END IF
      #160122-00001#29 By 07900-add -end
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM nmdf_t WHERE nmdfent = g_enterprise AND nmdf001 = g_nmdf_m.nmdf001
                                                               AND nmdf002 = g_nmdf_m.nmdf002
                                                               AND nmdf003 = g_nmdf_m.nmdf003
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
      #160122-00001#29--add--str--
      #AND nmdf003 IN (SELECT nmll001 FROM nmll_t WHERE nmllent = g_enterprise AND nmll002 = g_user) #160122-00001#29 By 07900--mark
      #160122-00001#29--add--end
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "nmdf_t:",SQLERRMESSAGE 
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
      #   CLOSE anmt830_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_nmdf_d.clear() 
      CALL g_nmdf2_d.clear()       
 
     
      CALL anmt830_ui_browser_refresh()  
      #CALL anmt830_ui_headershow()  
      #CALL anmt830_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL anmt830_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL anmt830_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE anmt830_cl
 
   #功能已完成,通報訊息中心
   CALL anmt830_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="anmt830.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION anmt830_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #先清空單身變數內容
   CALL g_nmdf_d.clear()
   CALL g_nmdf2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT nmdfseq,nmdf005,nmdf006,nmdf007,nmdf008,nmdf009,nmdf010,nmdf004,nmdf012, 
       nmdf013,nmdfownid,nmdfowndp,nmdfcrtid,nmdfcrtdp,nmdfcrtdt,nmdfmodid,nmdfmoddt,t1.ooag011 ,t2.ooefl003 , 
       t3.ooag011 ,t4.ooefl003 ,t5.ooag011 FROM nmdf_t",   
               "",
               
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=nmdfownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=nmdfowndp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=nmdfcrtid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=nmdfcrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=nmdfmodid  ",
 
               " WHERE nmdfent= ? AND nmdf001=? AND nmdf002=? AND nmdf003=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("nmdf_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   #160122-00001#29--add--str--
   LET g_sql=g_sql," AND nmdf003 IN (",g_sql_bank,")"  #160122-00001#29 By 07900 --mod
   #160122-00001#29--add--end
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF anmt830_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY nmdf_t.nmdfseq"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
         
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE anmt830_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR anmt830_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_nmdf_m.nmdf001,g_nmdf_m.nmdf002,g_nmdf_m.nmdf003   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_nmdf_m.nmdf001,g_nmdf_m.nmdf002,g_nmdf_m.nmdf003 INTO g_nmdf_d[l_ac].nmdfseq, 
          g_nmdf_d[l_ac].nmdf005,g_nmdf_d[l_ac].nmdf006,g_nmdf_d[l_ac].nmdf007,g_nmdf_d[l_ac].nmdf008, 
          g_nmdf_d[l_ac].nmdf009,g_nmdf_d[l_ac].nmdf010,g_nmdf_d[l_ac].nmdf004,g_nmdf_d[l_ac].nmdf012, 
          g_nmdf_d[l_ac].nmdf013,g_nmdf2_d[l_ac].nmdfownid,g_nmdf2_d[l_ac].nmdfowndp,g_nmdf2_d[l_ac].nmdfcrtid, 
          g_nmdf2_d[l_ac].nmdfcrtdp,g_nmdf2_d[l_ac].nmdfcrtdt,g_nmdf2_d[l_ac].nmdfmodid,g_nmdf2_d[l_ac].nmdfmoddt, 
          g_nmdf2_d[l_ac].nmdfownid_desc,g_nmdf2_d[l_ac].nmdfowndp_desc,g_nmdf2_d[l_ac].nmdfcrtid_desc, 
          g_nmdf2_d[l_ac].nmdfcrtdp_desc,g_nmdf2_d[l_ac].nmdfmodid_desc   #(ver:49)
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充 name="b_fill.fill"
         
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
 
            CALL g_nmdf_d.deleteElement(g_nmdf_d.getLength())
      CALL g_nmdf2_d.deleteElement(g_nmdf2_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
   
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_nmdf_d.getLength()
      LET g_nmdf_d_mask_o[l_ac].* =  g_nmdf_d[l_ac].*
      CALL anmt830_nmdf_t_mask()
      LET g_nmdf_d_mask_n[l_ac].* =  g_nmdf_d[l_ac].*
   END FOR
   
   LET g_nmdf2_d_mask_o.* =  g_nmdf2_d.*
   FOR l_ac = 1 TO g_nmdf2_d.getLength()
      LET g_nmdf2_d_mask_o[l_ac].* =  g_nmdf2_d[l_ac].*
      CALL anmt830_nmdf_t_mask()
      LET g_nmdf2_d_mask_n[l_ac].* =  g_nmdf2_d[l_ac].*
   END FOR
 
 
   FREE anmt830_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="anmt830.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION anmt830_idx_chk()
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
      IF g_detail_idx > g_nmdf_d.getLength() THEN
         LET g_detail_idx = g_nmdf_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_nmdf_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_nmdf_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_nmdf2_d.getLength() THEN
         LET g_detail_idx = g_nmdf2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_nmdf2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_nmdf2_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="anmt830.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION anmt830_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_nmdf_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="anmt830.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION anmt830_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   
   #end add-point
   
   DELETE FROM nmdf_t
    WHERE nmdfent = g_enterprise AND nmdf001 = g_nmdf_m.nmdf001 AND
                              nmdf002 = g_nmdf_m.nmdf002 AND
                              nmdf003 = g_nmdf_m.nmdf003 AND
 
          nmdfseq = g_nmdf_d_t.nmdfseq
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
   #160122-00001#29--add--str--
   #AND nmdf003 IN (SELECT nmll001 FROM nmll_t WHERE nmllent = g_enterprise AND nmll002 = g_user)  #160122-00001#29 By 07900--mark
   #160122-00001#29--add--end
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "nmdf_t:",SQLERRMESSAGE 
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
 
{<section id="anmt830.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION anmt830_delete_b(ps_table,ps_keys_bak,ps_page)
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
 
{<section id="anmt830.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION anmt830_insert_b(ps_table,ps_keys,ps_page)
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
 
{<section id="anmt830.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION anmt830_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
 
{<section id="anmt830.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION anmt830_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_nmdf_d[l_ac].nmdfseq = g_nmdf_d_t.nmdfseq 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="anmt830.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION anmt830_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="anmt830.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION anmt830_lock_b(ps_table,ps_page)
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
   #CALL anmt830_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="anmt830.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION anmt830_unlock_b(ps_table,ps_page)
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
 
{<section id="anmt830.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION anmt830_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("nmdf001,nmdf002,nmdf003",TRUE)
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
 
{<section id="anmt830.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION anmt830_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("nmdf001,nmdf002,nmdf003",FALSE)
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
 
{<section id="anmt830.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION anmt830_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   IF g_nmdf_d[l_ac].nmdf006='1' OR g_nmdf_d[l_ac].nmdf006='3' THEN
      CALL cl_set_comp_entry("nmdf007",TRUE)
      CALL cl_set_comp_required("nmdf007",TRUE)
   END IF
   IF g_nmdf_d[l_ac].nmdf006='2' OR g_nmdf_d[l_ac].nmdf006='4' THEN
      CALL cl_set_comp_entry("nmdf008",TRUE)
      CALL cl_set_comp_required("nmdf008",TRUE)
   END IF 
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="anmt830.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION anmt830_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   IF g_nmdf_d[l_ac].nmdf006='1' OR g_nmdf_d[l_ac].nmdf006='3' THEN
      CALL cl_set_comp_required("nmdf008",FALSE)
      CALL cl_set_comp_entry("nmdf008",FALSE)
   END IF
   IF g_nmdf_d[l_ac].nmdf006='2' OR g_nmdf_d[l_ac].nmdf006='4' THEN
      CALL cl_set_comp_required("nmdf007",FALSE)
      CALL cl_set_comp_entry("nmdf007",FALSE)
   END IF   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="anmt830.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION anmt830_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="anmt830.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION anmt830_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   IF NOT cl_null(g_nmdf_m.nmdf014) THEN
      #CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", FALSE)
      CALL cl_set_act_visible("delete,reproduce", FALSE) #151002-00011#2
   END IF
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="anmt830.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION anmt830_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="anmt830.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION anmt830_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="anmt830.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION anmt830_default_search()
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
      LET ls_wc = ls_wc, " nmdf001 = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " nmdf002 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " nmdf003 = '", g_argv[03], "' AND "
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
 
{<section id="anmt830.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION anmt830_fill_chk(ps_idx)
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
 
{<section id="anmt830.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION anmt830_modify_detail_chk(ps_record)
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
         LET ls_return = "nmdfseq"
      WHEN "s_detail2"
         LET ls_return = "nmdfownid"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="anmt830.mask_functions" >}
&include "erp/anm/anmt830_mask.4gl"
 
{</section>}
 
{<section id="anmt830.state_change" >}
    
 
{</section>}
 
{<section id="anmt830.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION anmt830_set_pk_array()
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
   LET g_pk_array[1].values = g_nmdf_m.nmdf001
   LET g_pk_array[1].column = 'nmdf001'
   LET g_pk_array[2].values = g_nmdf_m.nmdf002
   LET g_pk_array[2].column = 'nmdf002'
   LET g_pk_array[3].values = g_nmdf_m.nmdf003
   LET g_pk_array[3].column = 'nmdf003'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="anmt830.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION anmt830_msgcentre_notify(lc_state)
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
   CALL anmt830_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_nmdf_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="anmt830.other_function" readonly="Y" >}

 
{</section>}
 
