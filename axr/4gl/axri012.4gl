#該程式未解開Section, 採用最新樣板產出!
{<section id="axri012.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2013-07-29 09:25:25), PR版次:0005(2016-12-01 10:04:14)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000348
#+ Filename...: axri012
#+ Description: 多帳期設定作業
#+ Creator....: 02299(2013-07-22 14:42:31)
#+ Modifier...: 02299 -SD/PR- 02481
 
{</section>}
 
{<section id="axri012.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#Memos
#160819-00025#1   By 00768                  单身修改后分期比率汇总若不等于100，且单头的金额设置为1依设置比率时，提示是否需要自动重新分配下
#160905-00007#3   2016/09/05 By zhujing     调整系统中无ENT的SQL条件增加ent
#160809-00047#2   2016/10/11 By shiun       刪除前先判斷s_azzi610_check
#161128-00061#3   2016/12/01 by 02481       标准程式定义采用宣告模式,弃用.*写法
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
PRIVATE type type_g_oocq_m        RECORD
       oocq002 LIKE oocq_t.oocq002, 
   oocq001 LIKE oocq_t.oocq001, 
   oocq003 LIKE oocq_t.oocq003, 
   oocql004 LIKE oocql_t.oocql004, 
   oocq004 LIKE oocq_t.oocq004, 
   oocqstus LIKE oocq_t.oocqstus, 
   oocqownid LIKE oocq_t.oocqownid, 
   oocqownid_desc LIKE type_t.chr80, 
   oocqowndp LIKE oocq_t.oocqowndp, 
   oocqowndp_desc LIKE type_t.chr80, 
   oocqcrtid LIKE oocq_t.oocqcrtid, 
   oocqcrtid_desc LIKE type_t.chr80, 
   oocqcrtdp LIKE oocq_t.oocqcrtdp, 
   oocqcrtdp_desc LIKE type_t.chr80, 
   oocqcrtdt LIKE oocq_t.oocqcrtdt, 
   oocqmodid LIKE oocq_t.oocqmodid, 
   oocqmodid_desc LIKE type_t.chr80, 
   oocqmoddt LIKE oocq_t.oocqmoddt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_xrac_d        RECORD
       xrac003 LIKE xrac_t.xrac003, 
   xrac004 LIKE xrac_t.xrac004, 
   xrac005 LIKE xrac_t.xrac005, 
   xrac006 LIKE xrac_t.xrac006, 
   xrac007 LIKE xrac_t.xrac007, 
   xrac008 LIKE xrac_t.xrac008
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_oocq001 LIKE oocq_t.oocq001,
      b_oocq002 LIKE oocq_t.oocq002
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
PRIVATE type type_g_xrac_s        RECORD
       xrac001 LIKE xrac_t.xrac001, 
   xrac002 LIKE xrac_t.xrac002, 
   xrac003 LIKE xrac_t.xrac003, 
   oocq004 LIKE oocq_t.oocq004, 
   xrac006 LIKE xrac_t.xrac006, 
   xrac005 LIKE xrac_t.xrac005, 
   xrac004 LIKE xrac_t.xrac004, 
   xrac007 LIKE xrac_t.xrac007
       END RECORD
DEFINE g_xrac_s        type_g_xrac_s
#end add-point
       
#模組變數(Module Variables)
DEFINE g_oocq_m          type_g_oocq_m
DEFINE g_oocq_m_t        type_g_oocq_m
DEFINE g_oocq_m_o        type_g_oocq_m
DEFINE g_oocq_m_mask_o   type_g_oocq_m #轉換遮罩前資料
DEFINE g_oocq_m_mask_n   type_g_oocq_m #轉換遮罩後資料
 
   DEFINE g_oocq002_t LIKE oocq_t.oocq002
DEFINE g_oocq001_t LIKE oocq_t.oocq001
 
 
DEFINE g_xrac_d          DYNAMIC ARRAY OF type_g_xrac_d
DEFINE g_xrac_d_t        type_g_xrac_d
DEFINE g_xrac_d_o        type_g_xrac_d
DEFINE g_xrac_d_mask_o   DYNAMIC ARRAY OF type_g_xrac_d #轉換遮罩前資料
DEFINE g_xrac_d_mask_n   DYNAMIC ARRAY OF type_g_xrac_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
DEFINE g_master_multi_table_t    RECORD
      oocql001 LIKE oocql_t.oocql001,
      oocql002 LIKE oocql_t.oocql002,
      oocql004 LIKE oocql_t.oocql004
      END RECORD
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
 
 
DEFINE g_wc2_extend          STRING
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
DEFINE g_curr_diag           ui.Dialog                         #Current Dialog
                                                               
DEFINE g_pagestart           LIKE type_t.num10                 
DEFINE gwin_curr             ui.Window                         #Current Window
DEFINE gfrm_curr             ui.Form                           #Current Form
DEFINE g_page_action         STRING                            #page action
DEFINE g_header_hidden       LIKE type_t.num5                  #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5                  #隱藏工作Panel
DEFINE g_page                STRING                            #第幾頁
DEFINE g_state               STRING       
DEFINE g_header_cnt          LIKE type_t.num10
DEFINE g_detail_cnt          LIKE type_t.num10                  #單身總筆數
DEFINE g_detail_idx          LIKE type_t.num10                  #單身目前所在筆數
DEFINE g_detail_idx_tmp      LIKE type_t.num10                  #單身目前所在筆數
DEFINE g_detail_idx2         LIKE type_t.num10                  #單身2目前所在筆數
DEFINE g_detail_idx_list     DYNAMIC ARRAY OF LIKE type_t.num10 #單身2目前所在筆數
DEFINE g_browser_cnt         LIKE type_t.num10                  #Browser總筆數
DEFINE g_browser_idx         LIKE type_t.num10                  #Browser目前所在筆數
DEFINE g_temp_idx            LIKE type_t.num10                  #Browser目前所在筆數(暫存用)
DEFINE g_order               STRING                             #查詢排序欄位
                                                        
DEFINE g_current_row         LIKE type_t.num10                  #Browser所在筆數
DEFINE g_current_sw          BOOLEAN                            #Browser所在筆數用開關
DEFINE g_current_page        LIKE type_t.num10                  #目前所在頁數
DEFINE g_insert              LIKE type_t.chr5                   #是否導到其他page
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys               DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak           DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_bfill               LIKE type_t.chr5              #是否刷新單身
DEFINE g_error_show          LIKE type_t.num5              #是否顯示筆數提示訊息
DEFINE g_master_insert       BOOLEAN                       #確認單頭資料是否寫入
 
DEFINE g_wc_frozen           STRING                        #凍結欄位使用
DEFINE g_chk                 BOOLEAN                       #助記碼判斷用
DEFINE g_aw                  STRING                        #確定當下點擊的單身
DEFINE g_default             BOOLEAN                       #是否有外部參數查詢
DEFINE g_log1                STRING                        #log用
DEFINE g_log2                STRING                        #log用
DEFINE g_loc                 LIKE type_t.chr5              #判斷游標所在位置
DEFINE g_add_browse          STRING                        #新增填充用WC
DEFINE g_update              BOOLEAN                       #確定單頭/身是否異動過
DEFINE g_idx_group           om.SaxAttributes              #頁籤群組
DEFINE g_master_commit       LIKE type_t.chr1              #確認單頭是否修改過
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axri012.main" >}
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
   LET g_argv[1] = '3114'
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT oocq002,oocq001,oocq003,'',oocq004,oocqstus,oocqownid,'',oocqowndp,'', 
       oocqcrtid,'',oocqcrtdp,'',oocqcrtdt,oocqmodid,'',oocqmoddt", 
                      " FROM oocq_t",
                      " WHERE oocqent= ? AND oocq001=? AND oocq002=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axri012_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.oocq002,t0.oocq001,t0.oocq003,t0.oocq004,t0.oocqstus,t0.oocqownid, 
       t0.oocqowndp,t0.oocqcrtid,t0.oocqcrtdp,t0.oocqcrtdt,t0.oocqmodid,t0.oocqmoddt,t1.ooag011",
               " FROM oocq_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.oocqmodid  ",
 
               " WHERE t0.oocqent = " ||g_enterprise|| " AND t0.oocq001 = ? AND t0.oocq002 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axri012_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axri012 WITH FORM cl_ap_formpath("axr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axri012_init()   
 
      #進入選單 Menu (="N")
      CALL axri012_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axri012
      
   END IF 
   
   CLOSE axri012_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axri012.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axri012_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill       = "Y"
   LET g_detail_idx  = 1 #第一層單身指標
   LET g_detail_idx2 = 1 #第二層單身指標
   
   #各個page指標
   LET g_detail_idx_list[1] = 1 
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('oocqstus','17','N,Y')
 
      CALL cl_set_combo_scc('xrac007','8310') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   
   #end add-point
   
   #初始化搜尋條件
   CALL axri012_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="axri012.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION axri012_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_idx     LIKE type_t.num10
   DEFINE ls_wc      STRING
   DEFINE lb_first   BOOLEAN
   DEFINE la_wc      DYNAMIC ARRAY OF RECORD
          tableid    STRING,
          wc         STRING
          END RECORD
   DEFINE la_param   RECORD
          prog       STRING,
          actionid   STRING,
          background LIKE type_t.chr1,
          param      DYNAMIC ARRAY OF STRING
          END RECORD
   DEFINE ls_js      STRING
   DEFINE la_output  DYNAMIC ARRAY OF STRING   #報表元件鬆耦合使用
   DEFINE  l_cmd_token           base.StringTokenizer   #報表作業cmdrun使用 
   DEFINE  l_cmd_next            STRING                 #報表作業cmdrun使用
   DEFINE  l_cmd_cnt             LIKE type_t.num5       #報表作業cmdrun使用
   DEFINE  l_cmd_prog_arg        STRING                 #報表作業cmdrun使用
   DEFINE  l_cmd_arg             STRING                 #報表作業cmdrun使用
   #add-point:ui_dialog段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   CALL axri012_oocq004_set()
   CALL axri012_xrac007_set()
   #end add-point
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
 
   
   #action default動作
   #應用 a42 樣板自動產生(Version:3)
   #進入程式時預設執行的動作
   CASE g_actdefault
      WHEN "insert"
         LET g_action_choice="insert"
         LET g_actdefault = ""
         IF cl_auth_chk_act("insert") THEN
            CALL axri012_insert()
            #add-point:ON ACTION insert name="menu.default.insert"
            
            #END add-point
         END IF
 
      #add-point:action default自訂 name="ui_dialog.action_default"
      
      #end add-point
      OTHERWISE
   END CASE
 
 
 
   
   LET lb_first = TRUE
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
   
   WHILE TRUE 
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_oocq_m.* TO NULL
         CALL g_xrac_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL axri012_init()
      END IF
   
            
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
    
         DISPLAY ARRAY g_xrac_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL axri012_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1',",l_ac)
               
               #add-point:page1, before row動作 name="ui_dialog.page1.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
               #顯示單身筆數
               CALL axri012_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION detail_qrystr
               MENU "" ATTRIBUTE(STYLE="popup")
                  #add-point:ON ACTION detail_qrystr相關動作 name="menu.detail_show.page1_sub.detail_qrystr"
                  
                  #END add-point
                                 #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_azzi600
                  LET g_action_choice="prog_azzi600"
                  IF cl_auth_chk_act("prog_azzi600") THEN
                     
                     #add-point:ON ACTION prog_azzi600 name="menu.detail_show.page1_sub.prog_azzi600"
               #+ 此段落由子樣板a41產生
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'azzi600'
               LET la_param.param[1] = g_xrac_d[l_ac].xrac007

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)


                     #END add-point
                     
                  END IF
 
 
 
 
               END MENU
 
 
 
               #add-point:ON ACTION detail_qrystr name="menu.detail_show.page1.detail_qrystr"
               
               #END add-point
 
 
 
 
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
      
         BEFORE DIALOG
            #先填充browser資料
            CALL axri012_browser_fill("")
            CALL cl_notice()
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_sw = FALSE
            #回歸舊筆數位置 (回到當時異動的筆數)
            
            #確保g_current_idx位於正常區間內
            #小於,等於0則指到第1筆
            IF g_current_idx <= 0 THEN
               LET g_current_idx = 1
            END IF
            #超過最大筆數則指到最後1筆
            IF g_current_idx > g_browser.getLength() THEN
               LEt g_current_idx = g_browser.getLength()
            END IF 
            
            LET g_current_sw = TRUE
            LET g_current_row = g_current_idx #目前指標
            
            #有資料才進行fetch
            IF g_current_idx <> 0 THEN
               CALL axri012_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL axri012_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL axri012_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL axri012_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL axri012_set_act_visible()   
            CALL axri012_set_act_no_visible()
            IF NOT (g_oocq_m.oocq001 IS NULL
              OR g_oocq_m.oocq002 IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " oocqent = " ||g_enterprise|| " AND",
                                  " oocq001 = '", g_oocq_m.oocq001, "' "
                                  ," AND oocq002 = '", g_oocq_m.oocq002, "' "
 
               #填到對應位置
               CALL axri012_browser_fill("")
            END IF
         
          
         #查詢方案選擇 
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "oocq_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "xrac_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  #組合g_wc2
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
 
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
               END IF
               CALL axri012_browser_fill("F")   #browser_fill()會將notice區塊清空
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "oocq_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "xrac_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1)
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL axri012_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL axri012_fetch("F")
                  END IF
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
          
         
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL axri012_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axri012_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL axri012_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axri012_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL axri012_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axri012_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL axri012_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axri012_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL axri012_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axri012_idx_chk()
          
         #excel匯出功能          
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
                  LET g_export_node[1] = base.typeInfo.create(g_xrac_d)
                  LET g_export_id[1]   = "s_detail1"
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  
                  #END add-point
                  CALL cl_export_to_excel_getpage()
                  CALL cl_export_to_excel()
               END IF
            END IF
        
         ON ACTION close
            LET INT_FLAG = FALSE
            LET g_action_choice = "exit"
            EXIT DIALOG
          
         ON ACTION exit
            LET g_action_choice = "exit"
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
               CALL cl_notice()
            END IF
            
       
         #單頭摺疊，可利用hot key "Alt-s"開啟/關閉單頭
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
    
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL axri012_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL axri012_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL axri012_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL axri012_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aooi300
            LET g_action_choice="open_aooi300"
            IF cl_auth_chk_act("open_aooi300") THEN
               
               #add-point:ON ACTION open_aooi300 name="menu.open_aooi300"
               CALL cl_cmdrun('aooi300 3114')
               #END add-point
               
            END IF
 
 
 
 
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
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL axri012_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axri012_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_axri012_1
            LET g_action_choice="open_axri012_1"
            IF cl_auth_chk_act("open_axri012_1") THEN
               
               #add-point:ON ACTION open_axri012_1 name="menu.open_axri012_1"
               CALL axri012_open_axri012_1(0)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_oocq002
            LET g_action_choice="prog_oocq002"
            IF cl_auth_chk_act("prog_oocq002") THEN
               
               #add-point:ON ACTION prog_oocq002 name="menu.prog_oocq002"
               #+ 此段落由子樣板a41產生
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'aooi300'
               LET la_param.param[1] = g_oocq_m.oocq002

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)


               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL axri012_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL axri012_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL axri012_set_pk_array()
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
 
      #(ver:79) ---add start---
      #add-point:ui_dialog段 after dialog name="ui_dialog.exit_dialog"
      
      #end add-point
      #(ver:79) --- add end ---
    
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         #add-point:ui_dialog段離開dialog前 name="ui_dialog.b_exit"
         
         #end add-point
         EXIT WHILE
      END IF
    
   END WHILE    
      
   CALL cl_set_act_visible("accept,cancel", TRUE)
    
END FUNCTION
 
{</section>}
 
{<section id="axri012.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION axri012_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   
   #end add-point    
   
   #add-point:Function前置處理 name="browser_fill.before_browser_fill"
   
   #end add-point
   
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
   LET l_wc  = g_wc.trim() 
   LET l_wc2 = g_wc2.trim()
 
   #add-point:browser_fill,foreach前 name="browser_fill.before_foreach"
   LET g_wc = g_wc ," AND oocq001 = '3114' "
   LET l_wc = g_wc
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT oocq001,oocq002 ",
                      " FROM oocq_t ",
                      " ",
                      " LEFT JOIN xrac_t ON xracent = oocqent AND oocq001 = xrac001 AND oocq002 = xrac002 ", "  ",
                      #add-point:browser_fill段sql(xrac_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " LEFT JOIN oocql_t ON oocqlent = "||g_enterprise||" AND oocq001 = oocql001 AND oocq002 = oocql002 AND oocql003 = '",g_dlang,"' ", 
                      " ", 
 
 
                      " WHERE oocqent = " ||g_enterprise|| " AND xracent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("oocq_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT oocq001,oocq002 ",
                      " FROM oocq_t ", 
                      "  ",
                      "  LEFT JOIN oocql_t ON oocqlent = "||g_enterprise||" AND oocq001 = oocql001 AND oocq002 = oocql002 AND oocql003 = '",g_dlang,"' ",
                      " WHERE oocqent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("oocq_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   
   #end add-point
   
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
    
   IF g_browser_cnt > g_max_browse THEN
      IF g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_browser_cnt
         LET g_errparam.code = 9035 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
      END IF
      LET g_browser_cnt = g_max_browse
   END IF
   
   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
 
   #根據行為確定資料填充位置及WC
   IF cl_null(g_add_browse) THEN
      #清除畫面
      CLEAR FORM                
      INITIALIZE g_oocq_m.* TO NULL
      CALL g_xrac_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.oocq001,t0.oocq002 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.oocqstus,t0.oocq001,t0.oocq002 ",
                  " FROM oocq_t t0",
                  "  ",
                  "  LEFT JOIN xrac_t ON xracent = oocqent AND oocq001 = xrac001 AND oocq002 = xrac002 ", "  ", 
                  #add-point:browser_fill段sql(xrac_t1) name="browser_fill.join.xrac_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                  
               " LEFT JOIN oocql_t ON oocqlent = "||g_enterprise||" AND oocq001 = oocql001 AND oocq002 = oocql002 AND oocql003 = '",g_dlang,"' ",
                  " WHERE t0.oocqent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("oocq_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.oocqstus,t0.oocq001,t0.oocq002 ",
                  " FROM oocq_t t0",
                  "  ",
                  
               " LEFT JOIN oocql_t ON oocqlent = "||g_enterprise||" AND oocq001 = oocql001 AND oocq002 = oocql002 AND oocql003 = '",g_dlang,"' ",
                  " WHERE t0.oocqent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("oocq_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY oocq001,oocq002 ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"oocq_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_oocq001,g_browser[g_cnt].b_oocq002 
 
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
      
         #add-point:browser_fill段reference name="browser_fill.reference"
         
         #end add-point
      
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/inactive.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/active.png"
         
      END CASE
 
 
 
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
   
   IF cl_null(g_browser[g_cnt].b_oocq001) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   LET g_header_cnt  = g_browser.getLength()
   LET g_browser_cnt = g_browser.getLength()
   
   #筆數顯示
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
 
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
 
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
                  
   
   #add-point:browser_fill段結束前 name="browser_fill.after"
   
   #end add-point   
 
END FUNCTION
 
{</section>}
 
{<section id="axri012.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION axri012_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_oocq_m.oocq001 = g_browser[g_current_idx].b_oocq001   
   LET g_oocq_m.oocq002 = g_browser[g_current_idx].b_oocq002   
 
   EXECUTE axri012_master_referesh USING g_oocq_m.oocq001,g_oocq_m.oocq002 INTO g_oocq_m.oocq002,g_oocq_m.oocq001, 
       g_oocq_m.oocq003,g_oocq_m.oocq004,g_oocq_m.oocqstus,g_oocq_m.oocqownid,g_oocq_m.oocqowndp,g_oocq_m.oocqcrtid, 
       g_oocq_m.oocqcrtdp,g_oocq_m.oocqcrtdt,g_oocq_m.oocqmodid,g_oocq_m.oocqmoddt,g_oocq_m.oocqmodid_desc 
 
   
   CALL axri012_oocq_t_mask()
   CALL axri012_show()
      
END FUNCTION
 
{</section>}
 
{<section id="axri012.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION axri012_ui_detailshow()
   #add-point:ui_detailshow段define(客製用) name="ui_detailshow.define_customerization"
   
   #end add-point    
   #add-point:ui_detailshow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
 
   #add-point:Function前置處理 name="ui_detailshow.before"
   
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axri012.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION axri012_ui_browser_refresh()
   #add-point:ui_browser_refresh段define(客製用) name="ui_browser_refresh.define_customerization"
   
   #end add-point    
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_browser_refresh.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="ui_browser_refresh.pre_function"
   
   #end add-point
   
   LET g_browser_cnt = g_browser.getLength()
   LET g_header_cnt  = g_browser.getLength()
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_oocq001 = g_oocq_m.oocq001 
         AND g_browser[l_i].b_oocq002 = g_oocq_m.oocq002 
 
         THEN
         CALL g_browser.deleteElement(l_i)
         EXIT FOR
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
   
   #add-point:ui_browser_refresh段after name="ui_browser_refresh.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axri012.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION axri012_construct()
   #add-point:cs段define(客製用) name="cs.define_customerization"
   
   #end add-point    
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   DEFINE la_wc       DYNAMIC ARRAY OF RECORD
          tableid     STRING,
          wc          STRING
          END RECORD
   DEFINE li_idx      LIKE type_t.num10
   #add-point:cs段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_oocq_m.* TO NULL
   CALL g_xrac_d.clear()        
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON oocq002,oocq001,oocq003,oocql004,oocq004,oocqstus,oocqownid,oocqowndp, 
          oocqcrtid,oocqcrtdp,oocqcrtdt,oocqmodid,oocqmoddt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<oocqcrtdt>>----
         AFTER FIELD oocqcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<oocqmoddt>>----
         AFTER FIELD oocqmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<oocqcnfdt>>----
         
         #----<<oocqpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.oocq002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocq002
            #add-point:ON ACTION controlp INFIELD oocq002 name="construct.c.oocq002"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '3114'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oocq002  #顯示到畫面上

            NEXT FIELD oocq002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocq002
            #add-point:BEFORE FIELD oocq002 name="construct.b.oocq002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocq002
            
            #add-point:AFTER FIELD oocq002 name="construct.a.oocq002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocq001
            #add-point:BEFORE FIELD oocq001 name="construct.b.oocq001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocq001
            
            #add-point:AFTER FIELD oocq001 name="construct.a.oocq001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.oocq001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocq001
            #add-point:ON ACTION controlp INFIELD oocq001 name="construct.c.oocq001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocq003
            #add-point:BEFORE FIELD oocq003 name="construct.b.oocq003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocq003
            
            #add-point:AFTER FIELD oocq003 name="construct.a.oocq003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.oocq003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocq003
            #add-point:ON ACTION controlp INFIELD oocq003 name="construct.c.oocq003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocql004
            #add-point:BEFORE FIELD oocql004 name="construct.b.oocql004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocql004
            
            #add-point:AFTER FIELD oocql004 name="construct.a.oocql004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.oocql004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocql004
            #add-point:ON ACTION controlp INFIELD oocql004 name="construct.c.oocql004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocq004
            #add-point:BEFORE FIELD oocq004 name="construct.b.oocq004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocq004
            
            #add-point:AFTER FIELD oocq004 name="construct.a.oocq004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.oocq004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocq004
            #add-point:ON ACTION controlp INFIELD oocq004 name="construct.c.oocq004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocqstus
            #add-point:BEFORE FIELD oocqstus name="construct.b.oocqstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocqstus
            
            #add-point:AFTER FIELD oocqstus name="construct.a.oocqstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.oocqstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocqstus
            #add-point:ON ACTION controlp INFIELD oocqstus name="construct.c.oocqstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.oocqownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocqownid
            #add-point:ON ACTION controlp INFIELD oocqownid name="construct.c.oocqownid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oocqownid  #顯示到畫面上

            NEXT FIELD oocqownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocqownid
            #add-point:BEFORE FIELD oocqownid name="construct.b.oocqownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocqownid
            
            #add-point:AFTER FIELD oocqownid name="construct.a.oocqownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.oocqowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocqowndp
            #add-point:ON ACTION controlp INFIELD oocqowndp name="construct.c.oocqowndp"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oocqowndp  #顯示到畫面上

            NEXT FIELD oocqowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocqowndp
            #add-point:BEFORE FIELD oocqowndp name="construct.b.oocqowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocqowndp
            
            #add-point:AFTER FIELD oocqowndp name="construct.a.oocqowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.oocqcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocqcrtid
            #add-point:ON ACTION controlp INFIELD oocqcrtid name="construct.c.oocqcrtid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oocqcrtid  #顯示到畫面上

            NEXT FIELD oocqcrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocqcrtid
            #add-point:BEFORE FIELD oocqcrtid name="construct.b.oocqcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocqcrtid
            
            #add-point:AFTER FIELD oocqcrtid name="construct.a.oocqcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.oocqcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocqcrtdp
            #add-point:ON ACTION controlp INFIELD oocqcrtdp name="construct.c.oocqcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oocqcrtdp  #顯示到畫面上

            NEXT FIELD oocqcrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocqcrtdp
            #add-point:BEFORE FIELD oocqcrtdp name="construct.b.oocqcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocqcrtdp
            
            #add-point:AFTER FIELD oocqcrtdp name="construct.a.oocqcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocqcrtdt
            #add-point:BEFORE FIELD oocqcrtdt name="construct.b.oocqcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.oocqmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocqmodid
            #add-point:ON ACTION controlp INFIELD oocqmodid name="construct.c.oocqmodid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oocqmodid  #顯示到畫面上

            NEXT FIELD oocqmodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocqmodid
            #add-point:BEFORE FIELD oocqmodid name="construct.b.oocqmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocqmodid
            
            #add-point:AFTER FIELD oocqmodid name="construct.a.oocqmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocqmoddt
            #add-point:BEFORE FIELD oocqmoddt name="construct.b.oocqmoddt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON xrac003,xrac004,xrac005,xrac006,xrac007,xrac008
           FROM s_detail1[1].xrac003,s_detail1[1].xrac004,s_detail1[1].xrac005,s_detail1[1].xrac006, 
               s_detail1[1].xrac007,s_detail1[1].xrac008
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrac003
            #add-point:BEFORE FIELD xrac003 name="construct.b.page1.xrac003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrac003
            
            #add-point:AFTER FIELD xrac003 name="construct.a.page1.xrac003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrac003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrac003
            #add-point:ON ACTION controlp INFIELD xrac003 name="construct.c.page1.xrac003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrac004
            #add-point:BEFORE FIELD xrac004 name="construct.b.page1.xrac004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrac004
            
            #add-point:AFTER FIELD xrac004 name="construct.a.page1.xrac004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrac004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrac004
            #add-point:ON ACTION controlp INFIELD xrac004 name="construct.c.page1.xrac004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrac005
            #add-point:BEFORE FIELD xrac005 name="construct.b.page1.xrac005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrac005
            
            #add-point:AFTER FIELD xrac005 name="construct.a.page1.xrac005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrac005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrac005
            #add-point:ON ACTION controlp INFIELD xrac005 name="construct.c.page1.xrac005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrac006
            #add-point:BEFORE FIELD xrac006 name="construct.b.page1.xrac006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrac006
            
            #add-point:AFTER FIELD xrac006 name="construct.a.page1.xrac006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrac006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrac006
            #add-point:ON ACTION controlp INFIELD xrac006 name="construct.c.page1.xrac006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrac007
            #add-point:BEFORE FIELD xrac007 name="construct.b.page1.xrac007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrac007
            
            #add-point:AFTER FIELD xrac007 name="construct.a.page1.xrac007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrac007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrac007
            #add-point:ON ACTION controlp INFIELD xrac007 name="construct.c.page1.xrac007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrac008
            #add-point:BEFORE FIELD xrac008 name="construct.b.page1.xrac008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrac008
            
            #add-point:AFTER FIELD xrac008 name="construct.a.page1.xrac008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrac008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrac008
            #add-point:ON ACTION controlp INFIELD xrac008 name="construct.c.page1.xrac008"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
      
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="cs.b_dialog"
         
         #end add-point  
 
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
         IF NOT cl_null(ls_wc) THEN
            CALL util.JSON.parse(ls_wc, la_wc)
            INITIALIZE g_wc, g_wc2, g_wc2_table1, g_wc2_extend TO NULL
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "oocq_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "xrac_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
 
               END CASE
            END FOR
         END IF
    
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
 
 
 
   
   #add-point:cs段結束前 name="cs.after_construct"
   
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="axri012.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION axri012_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point   
   DEFINE ls_wc STRING
   #add-point:query段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="query.pre_function"
   
   #end add-point
   
   #切換畫面
   
   LET ls_wc = g_wc
   
   LET INT_FLAG = 0
   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   ERROR ""
   
   #清除畫面及相關資料
   CLEAR FORM
   CALL g_browser.clear()       
   CALL g_xrac_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL axri012_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL axri012_browser_fill("")
      CALL axri012_fetch("")
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
   LET g_detail_idx_list[1] = 1
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
   CALL axri012_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL axri012_fetch("F") 
      #顯示單身筆數
      CALL axri012_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="axri012.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION axri012_fetch(p_flag)
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point    
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="fetch.pre_function"
   
   #end add-point
   
   IF g_browser_cnt = 0 THEN
      RETURN
   END IF
 
   #清空第二階單身
 
   
   CALL cl_ap_performance_next_start()
   CASE p_flag
      WHEN 'F' 
         LET g_current_idx = 1
      WHEN 'L'  
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
 
   
   LET g_current_row = g_current_idx
   LET g_detail_cnt = g_header_cnt                  
   
   #單身總筆數顯示
   IF g_detail_cnt > 0 THEN
      #若單身有資料時, idx至少為1
      IF g_detail_idx <= 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx  
   ELSE
      LET g_detail_idx = 0
      DISPLAY '' TO FORMONLY.idx    
   END IF
   
   #瀏覽頁筆數顯示
   LET g_pagestart = g_current_idx
   DISPLAY g_pagestart TO FORMONLY.b_index   #當下筆數
   DISPLAY g_pagestart TO FORMONLY.h_index   #當下筆數
   
   CALL cl_navigator_setting( g_pagestart, g_browser_cnt )
 
   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF
   
   #避免超出browser資料筆數上限
   IF g_current_idx > g_browser.getLength() THEN
      LET g_browser_idx = g_browser.getLength()
      LET g_current_idx = g_browser.getLength()
   END IF
   
   LET g_oocq_m.oocq001 = g_browser[g_current_idx].b_oocq001
   LET g_oocq_m.oocq002 = g_browser[g_current_idx].b_oocq002
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE axri012_master_referesh USING g_oocq_m.oocq001,g_oocq_m.oocq002 INTO g_oocq_m.oocq002,g_oocq_m.oocq001, 
       g_oocq_m.oocq003,g_oocq_m.oocq004,g_oocq_m.oocqstus,g_oocq_m.oocqownid,g_oocq_m.oocqowndp,g_oocq_m.oocqcrtid, 
       g_oocq_m.oocqcrtdp,g_oocq_m.oocqcrtdt,g_oocq_m.oocqmodid,g_oocq_m.oocqmoddt,g_oocq_m.oocqmodid_desc 
 
   
   #遮罩相關處理
   LET g_oocq_m_mask_o.* =  g_oocq_m.*
   CALL axri012_oocq_t_mask()
   LET g_oocq_m_mask_n.* =  g_oocq_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL axri012_set_act_visible()   
   CALL axri012_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   IF g_oocq_m.oocqstus = 'Y' THEN
      CALL cl_set_act_visible("modify,delete,reproduce", TRUE)
   ELSE
      CALL cl_set_act_visible("modify,delete,reproduce", FALSE)
   END IF 
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_oocq_m_t.* = g_oocq_m.*
   LET g_oocq_m_o.* = g_oocq_m.*
   
   LET g_data_owner = g_oocq_m.oocqownid      
   LET g_data_dept  = g_oocq_m.oocqowndp
   
   #重新顯示   
   CALL axri012_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="axri012.insert" >}
#+ 資料新增
PRIVATE FUNCTION axri012_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_xrac_d.clear()   
 
 
   INITIALIZE g_oocq_m.* TO NULL             #DEFAULT 設定
   
   LET g_oocq001_t = NULL
   LET g_oocq002_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_oocq_m.oocqownid = g_user
      LET g_oocq_m.oocqowndp = g_dept
      LET g_oocq_m.oocqcrtid = g_user
      LET g_oocq_m.oocqcrtdp = g_dept 
      LET g_oocq_m.oocqcrtdt = cl_get_current()
      LET g_oocq_m.oocqmodid = g_user
      LET g_oocq_m.oocqmoddt = cl_get_current()
      LET g_oocq_m.oocqstus = 'Y'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_oocq_m.oocq001 = "3114"
      LET g_oocq_m.oocq003 = "3114"
 
  
      #add-point:單頭預設值 name="insert.default"
      #根據azzi650預設個默認值
      SELECT gzad014 INTO g_oocq_m.oocq004 FROM gzad_t
       WHERE gzad001 = '3114' AND gzad002 = '1' 
      LET g_oocq_m.oocqmodid = ''
      LET g_oocq_m.oocqmoddt = ''
      LET g_oocq_m.oocqstus = "Y"
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_oocq_m_t.* = g_oocq_m.*
      LET g_oocq_m_o.* = g_oocq_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_oocq_m.oocqstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
    
      CALL axri012_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
      
      IF NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_oocq_m.* TO NULL
         INITIALIZE g_xrac_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL axri012_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_xrac_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL axri012_set_act_visible()   
   CALL axri012_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_oocq001_t = g_oocq_m.oocq001
   LET g_oocq002_t = g_oocq_m.oocq002
 
   
   #組合新增資料的條件
   LET g_add_browse = " oocqent = " ||g_enterprise|| " AND",
                      " oocq001 = '", g_oocq_m.oocq001, "' "
                      ," AND oocq002 = '", g_oocq_m.oocq002, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axri012_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE axri012_cl
   
   CALL axri012_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE axri012_master_referesh USING g_oocq_m.oocq001,g_oocq_m.oocq002 INTO g_oocq_m.oocq002,g_oocq_m.oocq001, 
       g_oocq_m.oocq003,g_oocq_m.oocq004,g_oocq_m.oocqstus,g_oocq_m.oocqownid,g_oocq_m.oocqowndp,g_oocq_m.oocqcrtid, 
       g_oocq_m.oocqcrtdp,g_oocq_m.oocqcrtdt,g_oocq_m.oocqmodid,g_oocq_m.oocqmoddt,g_oocq_m.oocqmodid_desc 
 
   
   
   #遮罩相關處理
   LET g_oocq_m_mask_o.* =  g_oocq_m.*
   CALL axri012_oocq_t_mask()
   LET g_oocq_m_mask_n.* =  g_oocq_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_oocq_m.oocq002,g_oocq_m.oocq001,g_oocq_m.oocq003,g_oocq_m.oocql004,g_oocq_m.oocq004, 
       g_oocq_m.oocqstus,g_oocq_m.oocqownid,g_oocq_m.oocqownid_desc,g_oocq_m.oocqowndp,g_oocq_m.oocqowndp_desc, 
       g_oocq_m.oocqcrtid,g_oocq_m.oocqcrtid_desc,g_oocq_m.oocqcrtdp,g_oocq_m.oocqcrtdp_desc,g_oocq_m.oocqcrtdt, 
       g_oocq_m.oocqmodid,g_oocq_m.oocqmodid_desc,g_oocq_m.oocqmoddt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_oocq_m.oocqownid      
   LET g_data_dept  = g_oocq_m.oocqowndp
   
   #功能已完成,通報訊息中心
   CALL axri012_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="axri012.modify" >}
#+ 資料修改
PRIVATE FUNCTION axri012_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_oocq_m_t.* = g_oocq_m.*
   LET g_oocq_m_o.* = g_oocq_m.*
   
   IF g_oocq_m.oocq001 IS NULL
   OR g_oocq_m.oocq002 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_oocq001_t = g_oocq_m.oocq001
   LET g_oocq002_t = g_oocq_m.oocq002
 
   CALL s_transaction_begin()
   
   OPEN axri012_cl USING g_enterprise,g_oocq_m.oocq001,g_oocq_m.oocq002
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axri012_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE axri012_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axri012_master_referesh USING g_oocq_m.oocq001,g_oocq_m.oocq002 INTO g_oocq_m.oocq002,g_oocq_m.oocq001, 
       g_oocq_m.oocq003,g_oocq_m.oocq004,g_oocq_m.oocqstus,g_oocq_m.oocqownid,g_oocq_m.oocqowndp,g_oocq_m.oocqcrtid, 
       g_oocq_m.oocqcrtdp,g_oocq_m.oocqcrtdt,g_oocq_m.oocqmodid,g_oocq_m.oocqmoddt,g_oocq_m.oocqmodid_desc 
 
   
   #檢查是否允許此動作
   IF NOT axri012_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_oocq_m_mask_o.* =  g_oocq_m.*
   CALL axri012_oocq_t_mask()
   LET g_oocq_m_mask_n.* =  g_oocq_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL axri012_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_oocq001_t = g_oocq_m.oocq001
      LET g_oocq002_t = g_oocq_m.oocq002
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_oocq_m.oocqmodid = g_user 
LET g_oocq_m.oocqmoddt = cl_get_current()
LET g_oocq_m.oocqmodid_desc = cl_get_username(g_oocq_m.oocqmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL axri012_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE oocq_t SET (oocqmodid,oocqmoddt) = (g_oocq_m.oocqmodid,g_oocq_m.oocqmoddt)
          WHERE oocqent = g_enterprise AND oocq001 = g_oocq001_t
            AND oocq002 = g_oocq002_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_oocq_m.* = g_oocq_m_t.*
            CALL axri012_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_oocq_m.oocq001 != g_oocq_m_t.oocq001
      OR g_oocq_m.oocq002 != g_oocq_m_t.oocq002
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE xrac_t SET xrac001 = g_oocq_m.oocq001
                                       ,xrac002 = g_oocq_m.oocq002
 
          WHERE xracent = g_enterprise AND xrac001 = g_oocq_m_t.oocq001
            AND xrac002 = g_oocq_m_t.oocq002
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "xrac_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xrac_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         
         #add-point:單身fk修改後 name="modify.body.a_fk_update"
         
         #end add-point
         
 
         
 
         
         #UPDATE 多語言table key值
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL axri012_set_act_visible()   
   CALL axri012_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " oocqent = " ||g_enterprise|| " AND",
                      " oocq001 = '", g_oocq_m.oocq001, "' "
                      ," AND oocq002 = '", g_oocq_m.oocq002, "' "
 
   #填到對應位置
   CALL axri012_browser_fill("")
 
   CLOSE axri012_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL axri012_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="axri012.input" >}
#+ 資料輸入
PRIVATE FUNCTION axri012_input(p_cmd)
   #add-point:input段define(客製用) name="input.define_customerization"
   
   #end add-point  
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd_t               LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_n                   LIKE type_t.num10                #檢查重複用  
   DEFINE  l_cnt                 LIKE type_t.num10                #檢查重複用  
   DEFINE  l_lock_sw             LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert        LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete        LIKE type_t.num5                #可刪除否  
   DEFINE  l_count               LIKE type_t.num10
   DEFINE  l_i                   LIKE type_t.num10
   DEFINE  l_ac_t                LIKE type_t.num10
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
   #add-point:input段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   DEFINE l_return_b       LIKE type_t.num5
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
   DISPLAY BY NAME g_oocq_m.oocq002,g_oocq_m.oocq001,g_oocq_m.oocq003,g_oocq_m.oocql004,g_oocq_m.oocq004, 
       g_oocq_m.oocqstus,g_oocq_m.oocqownid,g_oocq_m.oocqownid_desc,g_oocq_m.oocqowndp,g_oocq_m.oocqowndp_desc, 
       g_oocq_m.oocqcrtid,g_oocq_m.oocqcrtid_desc,g_oocq_m.oocqcrtdp,g_oocq_m.oocqcrtdp_desc,g_oocq_m.oocqcrtdt, 
       g_oocq_m.oocqmodid,g_oocq_m.oocqmodid_desc,g_oocq_m.oocqmoddt
   
   #切換畫面
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql name="input.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT xrac003,xrac004,xrac005,xrac006,xrac007,xrac008 FROM xrac_t WHERE xracent=?  
       AND xrac001=? AND xrac002=? AND xrac003=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axri012_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL axri012_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL axri012_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_oocq_m.oocq002,g_oocq_m.oocql004,g_oocq_m.oocq004,g_oocq_m.oocqstus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   LET l_return_b = FALSE
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="axri012.input.head" >}
      #單頭段
      INPUT BY NAME g_oocq_m.oocq002,g_oocq_m.oocql004,g_oocq_m.oocq004,g_oocq_m.oocqstus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item name="input.master_input.update_item"
               IF NOT cl_null(g_oocq_m.oocq002)  THEN
                  CALL n_oocql('3114',g_oocq_m.oocq002)
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = '3114'
                  LET g_ref_fields[2] = g_oocq_m.oocq002
                  CALL ap_ref_array2(g_ref_fields," SELECT oocql004 FROM oocql_t WHERE oocqlent = '"
                      ||g_enterprise||"' AND oocql001 = ? AND oocql002 = ? AND oocql003 = '"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_oocq_m.oocql004= g_rtn_fields[1]

                  DISPLAY BY NAME g_oocq_m.oocql004
               END IF
               #END add-point
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_axri012_1
            LET g_action_choice="open_axri012_1"
            IF cl_auth_chk_act("open_axri012_1") THEN
               
               #add-point:ON ACTION open_axri012_1 name="input.master_input.open_axri012_1"
               CALL axri012_open_axri012_1(0)
               #END add-point
            END IF
 
 
 
 
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN axri012_cl USING g_enterprise,g_oocq_m.oocq001,g_oocq_m.oocq002
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN axri012_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE axri012_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            LET g_master_multi_table_t.oocql001 = g_oocq_m.oocq001
LET g_master_multi_table_t.oocql002 = g_oocq_m.oocq002
LET g_master_multi_table_t.oocql004 = g_oocq_m.oocql004
 
            IF l_cmd_t = 'r' THEN
               LET g_master_multi_table_t.oocql001 = ''
LET g_master_multi_table_t.oocql002 = ''
LET g_master_multi_table_t.oocql004 = ''
 
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL axri012_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL axri012_set_no_entry(p_cmd)
    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocq002
            #add-point:BEFORE FIELD oocq002 name="input.b.oocq002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocq002
            
            #add-point:AFTER FIELD oocq002 name="input.a.oocq002"
            #此段落由子樣板a05產生
            IF NOT axri012_oocq002_chk(g_oocq_m.oocq002,g_oocq_m_t.oocq001,p_cmd) THEN
               IF p_cmd = 'a' THEN 
                  LET g_oocq_m.oocq002 = ''
               ELSE
                  LET g_oocq_m.oocq002 = g_oocq_m_t.oocq002
               END IF 
               NEXT FIELD oocq002
            END IF 



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oocq002
            #add-point:ON CHANGE oocq002 name="input.g.oocq002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocql004
            #add-point:BEFORE FIELD oocql004 name="input.b.oocql004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocql004
            
            #add-point:AFTER FIELD oocql004 name="input.a.oocql004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oocql004
            #add-point:ON CHANGE oocql004 name="input.g.oocql004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocq004
            #add-point:BEFORE FIELD oocq004 name="input.b.oocq004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocq004
            
            #add-point:AFTER FIELD oocq004 name="input.a.oocq004"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oocq004
            #add-point:ON CHANGE oocq004 name="input.g.oocq004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocqstus
            #add-point:BEFORE FIELD oocqstus name="input.b.oocqstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocqstus
            
            #add-point:AFTER FIELD oocqstus name="input.a.oocqstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oocqstus
            #add-point:ON CHANGE oocqstus name="input.g.oocqstus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.oocq002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocq002
            #add-point:ON ACTION controlp INFIELD oocq002 name="input.c.oocq002"
            
            #END add-point
 
 
         #Ctrlp:input.c.oocql004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocql004
            #add-point:ON ACTION controlp INFIELD oocql004 name="input.c.oocql004"
            
            #END add-point
 
 
         #Ctrlp:input.c.oocq004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocq004
            #add-point:ON ACTION controlp INFIELD oocq004 name="input.c.oocq004"
            
            #END add-point
 
 
         #Ctrlp:input.c.oocqstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocqstus
            #add-point:ON ACTION controlp INFIELD oocqstus name="input.c.oocqstus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_oocq_m.oocq001,g_oocq_m.oocq002
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               
               #end add-point
               
               INSERT INTO oocq_t (oocqent,oocq002,oocq001,oocq003,oocq004,oocqstus,oocqownid,oocqowndp, 
                   oocqcrtid,oocqcrtdp,oocqcrtdt,oocqmodid,oocqmoddt)
               VALUES (g_enterprise,g_oocq_m.oocq002,g_oocq_m.oocq001,g_oocq_m.oocq003,g_oocq_m.oocq004, 
                   g_oocq_m.oocqstus,g_oocq_m.oocqownid,g_oocq_m.oocqowndp,g_oocq_m.oocqcrtid,g_oocq_m.oocqcrtdp, 
                   g_oocq_m.oocqcrtdt,g_oocq_m.oocqmodid,g_oocq_m.oocqmoddt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_oocq_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               
               #end add-point
               
               
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         IF g_oocq_m.oocq001 = g_master_multi_table_t.oocql001 AND
         g_oocq_m.oocq002 = g_master_multi_table_t.oocql002 AND
         g_oocq_m.oocql004 = g_master_multi_table_t.oocql004  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'oocqlent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_oocq_m.oocq001
            LET l_field_keys[02] = 'oocql001'
            LET l_var_keys_bak[02] = g_master_multi_table_t.oocql001
            LET l_var_keys[03] = g_oocq_m.oocq002
            LET l_field_keys[03] = 'oocql002'
            LET l_var_keys_bak[03] = g_master_multi_table_t.oocql002
            LET l_var_keys[04] = g_dlang
            LET l_field_keys[04] = 'oocql003'
            LET l_var_keys_bak[04] = g_dlang
            LET l_vars[01] = g_oocq_m.oocql004
            LET l_fields[01] = 'oocql004'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'oocql_t')
         END IF 
 
               
               #add-point:單頭新增後 name="input.head.a_insert"
                  CALL axri012_open_axri012_1(1)
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL axri012_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL axri012_b_fill()
                  CALL axri012_b_fill2('0')
               END IF
               
               #add-point:單頭新增後 name="input.head.a_insert2"
               
               #end add-point
               
               LET g_master_insert = TRUE
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL axri012_oocq_t_mask_restore('restore_mask_o')
               
               UPDATE oocq_t SET (oocq002,oocq001,oocq003,oocq004,oocqstus,oocqownid,oocqowndp,oocqcrtid, 
                   oocqcrtdp,oocqcrtdt,oocqmodid,oocqmoddt) = (g_oocq_m.oocq002,g_oocq_m.oocq001,g_oocq_m.oocq003, 
                   g_oocq_m.oocq004,g_oocq_m.oocqstus,g_oocq_m.oocqownid,g_oocq_m.oocqowndp,g_oocq_m.oocqcrtid, 
                   g_oocq_m.oocqcrtdp,g_oocq_m.oocqcrtdt,g_oocq_m.oocqmodid,g_oocq_m.oocqmoddt)
                WHERE oocqent = g_enterprise AND oocq001 = g_oocq001_t
                  AND oocq002 = g_oocq002_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "oocq_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         IF g_oocq_m.oocq001 = g_master_multi_table_t.oocql001 AND
         g_oocq_m.oocq002 = g_master_multi_table_t.oocql002 AND
         g_oocq_m.oocql004 = g_master_multi_table_t.oocql004  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'oocqlent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_oocq_m.oocq001
            LET l_field_keys[02] = 'oocql001'
            LET l_var_keys_bak[02] = g_master_multi_table_t.oocql001
            LET l_var_keys[03] = g_oocq_m.oocq002
            LET l_field_keys[03] = 'oocql002'
            LET l_var_keys_bak[03] = g_master_multi_table_t.oocql002
            LET l_var_keys[04] = g_dlang
            LET l_field_keys[04] = 'oocql003'
            LET l_var_keys_bak[04] = g_dlang
            LET l_vars[01] = g_oocq_m.oocql004
            LET l_fields[01] = 'oocql004'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'oocql_t')
         END IF 
 
               
               #將遮罩欄位進行遮蔽
               CALL axri012_oocq_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_oocq_m_t)
               LET g_log2 = util.JSON.stringify(g_oocq_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               CALL axri012_open_axri012_1(1)
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_oocq001_t = g_oocq_m.oocq001
            LET g_oocq002_t = g_oocq_m.oocq002
 
            
      END INPUT
   
 
{</section>}
 
{<section id="axri012.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_xrac_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_axri012_1
            LET g_action_choice="open_axri012_1"
            IF cl_auth_chk_act("open_axri012_1") THEN
               
               #add-point:ON ACTION open_axri012_1 name="input.detail_input.page1.open_axri012_1"
               CALL axri012_open_axri012_1(0)
               LET l_return_b = TRUE
               EXIT DIALOG
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xrac_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axri012_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_xrac_d.getLength()
            #add-point:資料輸入前 name="input.d.before_input"
            
            #end add-point
         
         BEFORE ROW
            #add-point:modify段before row2 name="input.body.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_detail_idx_list[1] = l_ac
            LET g_current_page = 1
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN axri012_cl USING g_enterprise,g_oocq_m.oocq001,g_oocq_m.oocq002
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN axri012_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE axri012_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_xrac_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_xrac_d[l_ac].xrac003 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_xrac_d_t.* = g_xrac_d[l_ac].*  #BACKUP
               LET g_xrac_d_o.* = g_xrac_d[l_ac].*  #BACKUP
               CALL axri012_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL axri012_set_no_entry_b(l_cmd)
               IF NOT axri012_lock_b("xrac_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axri012_bcl INTO g_xrac_d[l_ac].xrac003,g_xrac_d[l_ac].xrac004,g_xrac_d[l_ac].xrac005, 
                      g_xrac_d[l_ac].xrac006,g_xrac_d[l_ac].xrac007,g_xrac_d[l_ac].xrac008
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_xrac_d_t.xrac003,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xrac_d_mask_o[l_ac].* =  g_xrac_d[l_ac].*
                  CALL axri012_xrac_t_mask()
                  LET g_xrac_d_mask_n[l_ac].* =  g_xrac_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL axri012_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
        
         BEFORE INSERT  
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xrac_d[l_ac].* TO NULL 
            INITIALIZE g_xrac_d_t.* TO NULL 
            INITIALIZE g_xrac_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_xrac_d[l_ac].xrac004 = "0"
      LET g_xrac_d[l_ac].xrac005 = "0"
      LET g_xrac_d[l_ac].xrac006 = "0"
      LET g_xrac_d[l_ac].xrac007 = "10"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_xrac_d_t.* = g_xrac_d[l_ac].*     #新輸入資料
            LET g_xrac_d_o.* = g_xrac_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axri012_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL axri012_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xrac_d[li_reproduce_target].* = g_xrac_d[li_reproduce].*
 
               LET g_xrac_d[li_reproduce_target].xrac003 = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            LET g_xrac_d[l_ac].xrac007 = '10'
            IF cl_null(g_xrac_d[l_ac].xrac003) THEN 
               CALL axri012_xrac003_def(g_oocq_m.oocq002,g_xrac_d[l_ac].xrac003,l_cmd) 
                  RETURNING g_xrac_d[l_ac].xrac003 
            END IF 
            CALL axri012_xrac008_title(g_oocq_m.oocq001,g_oocq_m.oocq002) 
            LET g_xrac_d[l_ac].xrac008 = 0
            #end add-point  
  
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身新增 name="input.body.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM xrac_t 
             WHERE xracent = g_enterprise AND xrac001 = g_oocq_m.oocq001
               AND xrac002 = g_oocq_m.oocq002
 
               AND xrac003 = g_xrac_d[l_ac].xrac003
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_oocq_m.oocq001
               LET gs_keys[2] = g_oocq_m.oocq002
               LET gs_keys[3] = g_xrac_d[g_detail_idx].xrac003
               CALL axri012_insert_b('xrac_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_xrac_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xrac_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL axri012_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身刪除後(=d) name="input.body.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body.b_delete_ask"
               
               #end add-point 
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code = -263 
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身刪除前 name="input.body.b_delete"
               
               #end add-point 
               
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_oocq_m.oocq001
               LET gs_keys[gs_keys.getLength()+1] = g_oocq_m.oocq002
 
               LET gs_keys[gs_keys.getLength()+1] = g_xrac_d_t.xrac003
 
            
               #刪除同層單身
               IF NOT axri012_delete_b('xrac_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axri012_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT axri012_key_delete_b(gs_keys,'xrac_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axri012_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE axri012_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_xrac_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_xrac_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrac003
            #add-point:BEFORE FIELD xrac003 name="input.b.page1.xrac003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrac003
            
            #add-point:AFTER FIELD xrac003 name="input.a.page1.xrac003"
            IF NOT axri012_xrac003_chk(g_oocq_m.oocq002,g_oocq_m_t.oocq002,
                                   g_xrac_d[l_ac].xrac003,g_xrac_d_t.xrac003,l_cmd) THEN
               IF l_cmd = 'a' THEN
                  CALL axri012_xrac003_def(g_oocq_m.oocq002,g_xrac_d[l_ac].xrac003,l_cmd) 
                       RETURNING g_xrac_d[l_ac].xrac003 
               ELSE
                  LET g_xrac_d[l_ac].xrac003 = g_xrac_d_t.xrac003 
               END IF 
               NEXT FIELD xrac003
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrac003
            #add-point:ON CHANGE xrac003 name="input.g.page1.xrac003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrac004
            #add-point:BEFORE FIELD xrac004 name="input.b.page1.xrac004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrac004
            
            #add-point:AFTER FIELD xrac004 name="input.a.page1.xrac004"
            IF NOT axri012_num_chk(g_xrac_d[l_ac].xrac004,0,99) THEN 
               IF p_cmd = 'a' THEN 
                  LET g_xrac_d[l_ac].xrac004 = 0
               ELSE
                  LET g_xrac_d[l_ac].xrac004 = g_xrac_d_t.xrac004
               END IF 
               NEXT FIELD xrac004
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrac004
            #add-point:ON CHANGE xrac004 name="input.g.page1.xrac004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrac005
            #add-point:BEFORE FIELD xrac005 name="input.b.page1.xrac005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrac005
            
            #add-point:AFTER FIELD xrac005 name="input.a.page1.xrac005"
            IF NOT axri012_num_chk(g_xrac_d[l_ac].xrac005,-12,12) THEN 
               IF p_cmd = 'a' THEN 
                  LET g_xrac_d[l_ac].xrac005 = 0
               ELSE
                  LET g_xrac_d[l_ac].xrac005 = g_xrac_d_t.xrac005 
               END IF 
               NEXT FIELD xrac005
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrac005
            #add-point:ON CHANGE xrac005 name="input.g.page1.xrac005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrac006
            #add-point:BEFORE FIELD xrac006 name="input.b.page1.xrac006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrac006
            
            #add-point:AFTER FIELD xrac006 name="input.a.page1.xrac006"
            IF NOT axri012_num_chk(g_xrac_d[l_ac].xrac006,-999,999) THEN 
               IF p_cmd = 'a' THEN 
                  LET g_xrac_d[l_ac].xrac006 = 0
               ELSE
                  LET g_xrac_d[l_ac].xrac006 = g_xrac_d_t.xrac006
               END IF 
               NEXT FIELD xrac006
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrac006
            #add-point:ON CHANGE xrac006 name="input.g.page1.xrac006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrac007
            #add-point:BEFORE FIELD xrac007 name="input.b.page1.xrac007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrac007
            
            #add-point:AFTER FIELD xrac007 name="input.a.page1.xrac007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrac007
            #add-point:ON CHANGE xrac007 name="input.g.page1.xrac007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrac008
            #add-point:BEFORE FIELD xrac008 name="input.b.page1.xrac008"
            CALL axri012_set_format('xrac008',"##########&.##")
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrac008
            
            #add-point:AFTER FIELD xrac008 name="input.a.page1.xrac008"
            CALL axri012_set_format('xrac008',"##########&.##%")
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrac008
            #add-point:ON CHANGE xrac008 name="input.g.page1.xrac008"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.xrac003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrac003
            #add-point:ON ACTION controlp INFIELD xrac003 name="input.c.page1.xrac003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrac004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrac004
            #add-point:ON ACTION controlp INFIELD xrac004 name="input.c.page1.xrac004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrac005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrac005
            #add-point:ON ACTION controlp INFIELD xrac005 name="input.c.page1.xrac005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrac006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrac006
            #add-point:ON ACTION controlp INFIELD xrac006 name="input.c.page1.xrac006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrac007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrac007
            #add-point:ON ACTION controlp INFIELD xrac007 name="input.c.page1.xrac007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrac008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrac008
            #add-point:ON ACTION controlp INFIELD xrac008 name="input.c.page1.xrac008"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_xrac_d[l_ac].* = g_xrac_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE axri012_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_xrac_d[l_ac].xrac003 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_xrac_d[l_ac].* = g_xrac_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL axri012_xrac_t_mask_restore('restore_mask_o')
      
               UPDATE xrac_t SET (xrac001,xrac002,xrac003,xrac004,xrac005,xrac006,xrac007,xrac008) = (g_oocq_m.oocq001, 
                   g_oocq_m.oocq002,g_xrac_d[l_ac].xrac003,g_xrac_d[l_ac].xrac004,g_xrac_d[l_ac].xrac005, 
                   g_xrac_d[l_ac].xrac006,g_xrac_d[l_ac].xrac007,g_xrac_d[l_ac].xrac008)
                WHERE xracent = g_enterprise AND xrac001 = g_oocq_m.oocq001 
                  AND xrac002 = g_oocq_m.oocq002 
 
                  AND xrac003 = g_xrac_d_t.xrac003 #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_xrac_d[l_ac].* = g_xrac_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xrac_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_xrac_d[l_ac].* = g_xrac_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xrac_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_oocq_m.oocq001
               LET gs_keys_bak[1] = g_oocq001_t
               LET gs_keys[2] = g_oocq_m.oocq002
               LET gs_keys_bak[2] = g_oocq002_t
               LET gs_keys[3] = g_xrac_d[g_detail_idx].xrac003
               LET gs_keys_bak[3] = g_xrac_d_t.xrac003
               CALL axri012_update_b('xrac_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL axri012_xrac_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_xrac_d[g_detail_idx].xrac003 = g_xrac_d_t.xrac003 
 
                  ) THEN
                  LET gs_keys[01] = g_oocq_m.oocq001
                  LET gs_keys[gs_keys.getLength()+1] = g_oocq_m.oocq002
 
                  LET gs_keys[gs_keys.getLength()+1] = g_xrac_d_t.xrac003
 
                  CALL axri012_key_update_b(gs_keys,'xrac_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_oocq_m),util.JSON.stringify(g_xrac_d_t)
               LET g_log2 = util.JSON.stringify(g_oocq_m),util.JSON.stringify(g_xrac_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               CALL axri012_xrac008_title(g_oocq_m.oocq001,g_oocq_m.oocq002)
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL axri012_unlock_b("xrac_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            #add-point:單身after_row2 name="input.body.after_row2"
            
            #end add-point
              
         AFTER INPUT
            #add-point:input段after input  name="input.body.after_input"
 
            #end add-point 
    
         ON ACTION controlo    
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_xrac_d[li_reproduce_target].* = g_xrac_d[li_reproduce].*
 
               LET g_xrac_d[li_reproduce_target].xrac003 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_xrac_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xrac_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="axri012.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         IF p_cmd = 'a' THEN
            NEXT FIELD oocq002
         END IF
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD oocq001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD xrac003
 
               #add-point:input段modify_detail  name="input.modify_detail.other"
               
               #end add-point  
            END CASE
         END IF
      
      AFTER DIALOG
         #add-point:input段after_dialog name="input.after_dialog"
         
         #end add-point    
         
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
         #add-point:input段accept  name="input.accept"
         
         #end add-point    
         ACCEPT DIALOG
        
      ON ACTION cancel      #在dialog button (放棄)
         #add-point:input段cancel name="input.cancel"
         
         #end add-point  
         LET INT_FLAG = TRUE 
         LET g_detail_idx  = 1
         LET g_detail_idx2 = 1
         #各個page指標
         LET g_detail_idx_list[1] = 1 
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
 
         EXIT DIALOG
 
      ON ACTION close       #在dialog 右上角 (X)
         #add-point:input段close name="input.close"
         
         #end add-point  
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
         #add-point:input段exit name="input.exit"
         
         #end add-point
         LET INT_FLAG = TRUE 
         LET g_detail_idx  = 1
         LET g_detail_idx2 = 1
         #各個page指標
         LET g_detail_idx_list[1] = 1 
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   CALL axri012_set_format('xrac008',"##########&.##%")
   IF l_return_b = TRUE THEN
      CALL axri012_input('u')
   ELSE
      CALL axri012_xrac008_chk(g_oocq_m.oocq002,g_oocq_m.oocq004)
   END IF 
   CALL axri012_b_fill()  #160819-00025#1 add
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="axri012.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION axri012_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL axri012_b_fill() #單身填充
      CALL axri012_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL axri012_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_oocq_m.oocq001
   LET g_ref_fields[2] = g_oocq_m.oocq002
   CALL ap_ref_array2(g_ref_fields," SELECT oocql004 FROM oocql_t WHERE oocqlent = '"||g_enterprise||"' AND oocql001 = ? AND oocql002 = ? AND oocql003 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET g_oocq_m.oocql004 = g_rtn_fields[1] 
   DISPLAY BY NAME g_oocq_m.oocql004
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_oocq_m.oocqmodid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_oocq_m.oocqmodid_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_oocq_m.oocqmodid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_oocq_m.oocqownid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_oocq_m.oocqownid_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_oocq_m.oocqownid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_oocq_m.oocqowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_oocq_m.oocqowndp_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_oocq_m.oocqowndp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_oocq_m.oocqcrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_oocq_m.oocqcrtid_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_oocq_m.oocqcrtid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_oocq_m.oocqcrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_oocq_m.oocqcrtdp_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_oocq_m.oocqcrtdp_desc

   #end add-point
   
   #遮罩相關處理
   LET g_oocq_m_mask_o.* =  g_oocq_m.*
   CALL axri012_oocq_t_mask()
   LET g_oocq_m_mask_n.* =  g_oocq_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_oocq_m.oocq002,g_oocq_m.oocq001,g_oocq_m.oocq003,g_oocq_m.oocql004,g_oocq_m.oocq004, 
       g_oocq_m.oocqstus,g_oocq_m.oocqownid,g_oocq_m.oocqownid_desc,g_oocq_m.oocqowndp,g_oocq_m.oocqowndp_desc, 
       g_oocq_m.oocqcrtid,g_oocq_m.oocqcrtid_desc,g_oocq_m.oocqcrtdp,g_oocq_m.oocqcrtdp_desc,g_oocq_m.oocqcrtdt, 
       g_oocq_m.oocqmodid,g_oocq_m.oocqmodid_desc,g_oocq_m.oocqmoddt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_oocq_m.oocqstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_xrac_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL axri012_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axri012.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION axri012_detail_show()
   #add-point:detail_show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point  
   #add-point:detail_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="detail_show.before"
   
   #end add-point
   
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axri012.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION axri012_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE oocq_t.oocq001 
   DEFINE l_oldno     LIKE oocq_t.oocq001 
   DEFINE l_newno02     LIKE oocq_t.oocq002 
   DEFINE l_oldno02     LIKE oocq_t.oocq002 
 
   DEFINE l_master    RECORD LIKE oocq_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE xrac_t.* #此變數樣板目前無使用
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   #161128-00061#3-----modify--begin----------
   #DEFINE l_oocql   RECORD LIKE oocql_t.*
   DEFINE l_oocql RECORD  #應用分類碼多語言檔
       oocqlent LIKE oocql_t.oocqlent, #企業編號
       oocql001 LIKE oocql_t.oocql001, #應用分類
       oocql002 LIKE oocql_t.oocql002, #應用分類碼
       oocql003 LIKE oocql_t.oocql003, #語言別
       oocql004 LIKE oocql_t.oocql004, #說明
       oocql005 LIKE oocql_t.oocql005  #助記碼
       END RECORD

   #161128-00061#3-----modify--end----------
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   
   LET g_master_insert = FALSE
   
   IF g_oocq_m.oocq001 IS NULL
   OR g_oocq_m.oocq002 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_oocq001_t = g_oocq_m.oocq001
   LET g_oocq002_t = g_oocq_m.oocq002
 
    
   LET g_oocq_m.oocq001 = ""
   LET g_oocq_m.oocq002 = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_oocq_m.oocqownid = g_user
      LET g_oocq_m.oocqowndp = g_dept
      LET g_oocq_m.oocqcrtid = g_user
      LET g_oocq_m.oocqcrtdp = g_dept 
      LET g_oocq_m.oocqcrtdt = cl_get_current()
      LET g_oocq_m.oocqmodid = g_user
      LET g_oocq_m.oocqmoddt = cl_get_current()
      LET g_oocq_m.oocqstus = 'Y'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_oocq_m.oocqstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
   
   
   CALL axri012_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_oocq_m.* TO NULL
      INITIALIZE g_xrac_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL axri012_show()
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code = 9001 
      LET g_errparam.popup = FALSE 
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL axri012_set_act_visible()   
   CALL axri012_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_oocq001_t = g_oocq_m.oocq001
   LET g_oocq002_t = g_oocq_m.oocq002
 
   
   #組合新增資料的條件
   LET g_add_browse = " oocqent = " ||g_enterprise|| " AND",
                      " oocq001 = '", g_oocq_m.oocq001, "' "
                      ," AND oocq002 = '", g_oocq_m.oocq002, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axri012_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL axri012_idx_chk()
   
   LET g_data_owner = g_oocq_m.oocqownid      
   LET g_data_dept  = g_oocq_m.oocqowndp
   
   #功能已完成,通報訊息中心
   CALL axri012_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="axri012.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION axri012_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE xrac_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE axri012_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xrac_t
    WHERE xracent = g_enterprise AND xrac001 = g_oocq001_t
     AND xrac002 = g_oocq002_t
 
    INTO TEMP axri012_detail
 
   #將key修正為調整後   
   UPDATE axri012_detail 
      #更新key欄位
      SET xrac001 = g_oocq_m.oocq001
          , xrac002 = g_oocq_m.oocq002
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO xrac_t SELECT * FROM axri012_detail
   
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單身複製中1 name="detail_reproduce.body.table1.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE axri012_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_oocq001_t = g_oocq_m.oocq001
   LET g_oocq002_t = g_oocq_m.oocq002
 
   
END FUNCTION
 
{</section>}
 
{<section id="axri012.delete" >}
#+ 資料刪除
PRIVATE FUNCTION axri012_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   #add--160809-00047#2 By shiun--(S)
   DEFINE  l_success       LIKE type_t.num5
   DEFINE  l_use           LIKE type_t.num5
   #add--160809-00047#2 By shiun--(E)
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_oocq_m.oocq001 IS NULL
   OR g_oocq_m.oocq002 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_master_multi_table_t.oocql001 = g_oocq_m.oocq001
LET g_master_multi_table_t.oocql002 = g_oocq_m.oocq002
LET g_master_multi_table_t.oocql004 = g_oocq_m.oocql004
 
   
   CALL s_transaction_begin()
 
   OPEN axri012_cl USING g_enterprise,g_oocq_m.oocq001,g_oocq_m.oocq002
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axri012_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE axri012_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axri012_master_referesh USING g_oocq_m.oocq001,g_oocq_m.oocq002 INTO g_oocq_m.oocq002,g_oocq_m.oocq001, 
       g_oocq_m.oocq003,g_oocq_m.oocq004,g_oocq_m.oocqstus,g_oocq_m.oocqownid,g_oocq_m.oocqowndp,g_oocq_m.oocqcrtid, 
       g_oocq_m.oocqcrtdp,g_oocq_m.oocqcrtdt,g_oocq_m.oocqmodid,g_oocq_m.oocqmoddt,g_oocq_m.oocqmodid_desc 
 
   
   
   #檢查是否允許此動作
   IF NOT axri012_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_oocq_m_mask_o.* =  g_oocq_m.*
   CALL axri012_oocq_t_mask()
   LET g_oocq_m_mask_n.* =  g_oocq_m.*
   
   CALL axri012_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   #add--160809-00047#2 By shiun--(S)
      CALL s_azzi610_check('4',g_oocq_m.oocq002,g_site) RETURNING l_success,l_use
      IF l_use THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'azz-01159'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      #add--160809-00047#2 By shiun--(E)
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
 
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL axri012_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_oocq001_t = g_oocq_m.oocq001
      LET g_oocq002_t = g_oocq_m.oocq002
 
 
      DELETE FROM oocq_t
       WHERE oocqent = g_enterprise AND oocq001 = g_oocq_m.oocq001
         AND oocq002 = g_oocq_m.oocq002
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_oocq_m.oocq001,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM xrac_t
       WHERE xracent = g_enterprise AND xrac001 = g_oocq_m.oocq001
         AND xrac002 = g_oocq_m.oocq002
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xrac_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_oocq_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE axri012_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_xrac_d.clear() 
 
     
      CALL axri012_ui_browser_refresh()  
      #CALL axri012_ui_headershow()  
      #CALL axri012_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      INITIALIZE l_var_keys_bak TO NULL 
   INITIALIZE l_field_keys   TO NULL 
   LET l_var_keys_bak[01] = g_enterprise
   LET l_field_keys[01] = 'oocqlent'
   LET l_var_keys_bak[02] = g_master_multi_table_t.oocql001
   LET l_field_keys[02] = 'oocql001'
   LET l_var_keys_bak[03] = g_master_multi_table_t.oocql002
   LET l_field_keys[03] = 'oocql002'
   CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'oocql_t')
 
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL axri012_browser_fill("")
         CALL axri012_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE axri012_cl
 
   #功能已完成,通報訊息中心
   CALL axri012_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="axri012.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axri012_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
 
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_xrac_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF axri012_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT xrac003,xrac004,xrac005,xrac006,xrac007,xrac008  FROM xrac_t", 
                
                     " INNER JOIN oocq_t ON oocqent = " ||g_enterprise|| " AND oocq001 = xrac001 ",
                     " AND oocq002 = xrac002 ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                     
                     " WHERE xracent=? AND xrac001=? AND xrac002=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY xrac_t.xrac003"
         
         #add-point:單身填充控制 name="b_fill.sql"
   CALL axri012_xrac008_title(g_oocq_m.oocq001,g_oocq_m.oocq002)
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axri012_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR axri012_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_oocq_m.oocq001,g_oocq_m.oocq002   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_oocq_m.oocq001,g_oocq_m.oocq002 INTO g_xrac_d[l_ac].xrac003, 
          g_xrac_d[l_ac].xrac004,g_xrac_d[l_ac].xrac005,g_xrac_d[l_ac].xrac006,g_xrac_d[l_ac].xrac007, 
          g_xrac_d[l_ac].xrac008   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         
         #end add-point
      
         IF l_ac > g_max_rec THEN
            IF g_error_show = 1 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = l_ac
               LET g_errparam.code = 9035 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
            END IF
            EXIT FOREACH
         END IF
         
         LET l_ac = l_ac + 1
      END FOREACH
      LET g_error_show = 0
   
   END IF
    
 
   
   #add-point:browser_fill段其他table處理 name="browser_fill.other_fill"
   
   #end add-point
   
   CALL g_xrac_d.deleteElement(g_xrac_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE axri012_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_xrac_d.getLength()
      LET g_xrac_d_mask_o[l_ac].* =  g_xrac_d[l_ac].*
      CALL axri012_xrac_t_mask()
      LET g_xrac_d_mask_n[l_ac].* =  g_xrac_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="axri012.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION axri012_delete_b(ps_table,ps_keys_bak,ps_page)
   #add-point:delete_b段define(客製用) name="delete_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:delete_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="delete_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete"
      
      #end add-point    
      DELETE FROM xrac_t
       WHERE xracent = g_enterprise AND
         xrac001 = ps_keys_bak[1] AND xrac002 = ps_keys_bak[2] AND xrac003 = ps_keys_bak[3]
      #add-point:delete_b段刪除中 name="delete_b.m_delete"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = ":",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_xrac_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="axri012.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION axri012_insert_b(ps_table,ps_keys,ps_page)
   #add-point:insert_b段define(客製用) name="insert_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:insert_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="insert_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert"
      
      #end add-point 
      INSERT INTO xrac_t
                  (xracent,
                   xrac001,xrac002,
                   xrac003
                   ,xrac004,xrac005,xrac006,xrac007,xrac008) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_xrac_d[g_detail_idx].xrac004,g_xrac_d[g_detail_idx].xrac005,g_xrac_d[g_detail_idx].xrac006, 
                       g_xrac_d[g_detail_idx].xrac007,g_xrac_d[g_detail_idx].xrac008)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xrac_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_xrac_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="axri012.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION axri012_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   #add-point:update_b段define(客製用) name="update_b.define_customerization"
   
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
   #add-point:update_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="update_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="update_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE   
   
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "xrac_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL axri012_xrac_t_mask_restore('restore_mask_o')
               
      UPDATE xrac_t 
         SET (xrac001,xrac002,
              xrac003
              ,xrac004,xrac005,xrac006,xrac007,xrac008) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_xrac_d[g_detail_idx].xrac004,g_xrac_d[g_detail_idx].xrac005,g_xrac_d[g_detail_idx].xrac006, 
                  g_xrac_d[g_detail_idx].xrac007,g_xrac_d[g_detail_idx].xrac008) 
         WHERE xracent = g_enterprise AND xrac001 = ps_keys_bak[1] AND xrac002 = ps_keys_bak[2] AND xrac003 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xrac_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xrac_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL axri012_xrac_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
 
   
 
   
   #add-point:update_b段other name="update_b.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axri012.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION axri012_key_update_b(ps_keys_bak,ps_table)
   #add-point:update_b段define(客製用) name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak       DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_table          STRING
   DEFINE l_field_key       DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak    DYNAMIC ARRAY OF STRING
   DEFINE l_new_key         DYNAMIC ARRAY OF STRING
   DEFINE l_old_key         DYNAMIC ARRAY OF STRING
   #add-point:update_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="axri012.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION axri012_key_delete_b(ps_keys_bak,ps_table)
   #add-point:delete_b段define(客製用) name="key_delete_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak       DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_table          STRING
   DEFINE l_field_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak    DYNAMIC ARRAY OF STRING
   DEFINE l_new_key         DYNAMIC ARRAY OF STRING
   DEFINE l_old_key         DYNAMIC ARRAY OF STRING
   #add-point:delete_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_delete_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_delete_b.pre_function"
   
   #end add-point
   
 
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="axri012.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION axri012_lock_b(ps_table,ps_page)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point   
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:lock_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
    
   #先刷新資料
   #CALL axri012_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "xrac_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN axri012_bcl USING g_enterprise,
                                       g_oocq_m.oocq001,g_oocq_m.oocq002,g_xrac_d[g_detail_idx].xrac003  
                                               
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "axri012_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
 
   
 
   
   #add-point:lock_b段other name="lock_b.other"
   
   #end add-point  
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axri012.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION axri012_unlock_b(ps_table,ps_page)
   #add-point:unlock_b段define(客製用) name="unlock_b.define_customerization"
   
   #end add-point  
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
    
   LET ls_group = "'1',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE axri012_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="axri012.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION axri012_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("oocq001,oocq002",TRUE)
      CALL cl_set_comp_entry("",TRUE)
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
 
{<section id="axri012.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION axri012_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("oocq001,oocq002",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   CALL cl_set_comp_entry("oocqstus",FALSE)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axri012.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION axri012_set_entry_b(p_cmd)
   #add-point:set_entry_b段define(客製用) name="set_entry_b.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_entry_b.pre_function"
   
   #end add-point
    
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("",TRUE)
      #add-point:set_entry段欄位控制 name="set_entry_b.field_control"
      
      #end add-point  
   END IF
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="axri012.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION axri012_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point    
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="set_no_entry_b.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #add-point:set_no_entry_b段欄位控制 name="set_no_entry_b.field_control"
      
      #end add-point 
   END IF 
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b"
   
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="axri012.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION axri012_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axri012.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION axri012_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axri012.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION axri012_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axri012.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION axri012_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axri012.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION axri012_default_search()
   #add-point:default_search段define(客製用) name="default_search.define_customerization"
   
   #end add-point  
   DEFINE li_idx     LIKE type_t.num10
   DEFINE li_cnt     LIKE type_t.num10
   DEFINE ls_wc      STRING
   DEFINE la_wc      DYNAMIC ARRAY OF RECORD
          tableid    STRING,
          wc         STRING
          END RECORD
   DEFINE ls_where   STRING
   #add-point:default_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="default_search.before"
   
   #end add-point  
   
   LET g_pagestart = 1
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " oocq001 = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " oocq002 = '", g_argv[02], "' AND "
   END IF
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   
   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_default = TRUE
   ELSE
      #若無外部參數則預設為1=2
      LET g_default = FALSE
      
      #預設查詢條件
      CALL cl_qbe_get_default_qryplan() RETURNING ls_where
      IF NOT cl_null(ls_where) THEN
         CALL util.JSON.parse(ls_where, la_wc)
         INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
         FOR li_idx = 1 TO la_wc.getLength()
            CASE
               WHEN la_wc[li_idx].tableid = "oocq_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "xrac_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "EXTENDWC"
                  LET g_wc2_extend = la_wc[li_idx].wc
            END CASE
         END FOR
         IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
 
            OR NOT cl_null(g_wc2_extend)
            THEN
            #組合g_wc2
            IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
               LET g_wc2 = g_wc2_table1
            END IF
 
            IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
            END IF
         
            IF g_wc2.subString(1,5) = " AND " THEN
               LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
            END IF
         END IF
      END IF
    
      IF cl_null(g_wc) AND cl_null(g_wc2) THEN
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
 
{<section id="axri012.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION axri012_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   IF NOT axri012_void_chk(g_oocq_m.oocq002) THEN 
      RETURN 
   END IF 
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_oocq_m.oocq001 IS NULL
      OR g_oocq_m.oocq002 IS NULL
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN axri012_cl USING g_enterprise,g_oocq_m.oocq001,g_oocq_m.oocq002
   IF STATUS THEN
      CLOSE axri012_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axri012_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE axri012_master_referesh USING g_oocq_m.oocq001,g_oocq_m.oocq002 INTO g_oocq_m.oocq002,g_oocq_m.oocq001, 
       g_oocq_m.oocq003,g_oocq_m.oocq004,g_oocq_m.oocqstus,g_oocq_m.oocqownid,g_oocq_m.oocqowndp,g_oocq_m.oocqcrtid, 
       g_oocq_m.oocqcrtdp,g_oocq_m.oocqcrtdt,g_oocq_m.oocqmodid,g_oocq_m.oocqmoddt,g_oocq_m.oocqmodid_desc 
 
   
 
   #檢查是否允許此動作
   IF NOT axri012_action_chk() THEN
      CLOSE axri012_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_oocq_m.oocq002,g_oocq_m.oocq001,g_oocq_m.oocq003,g_oocq_m.oocql004,g_oocq_m.oocq004, 
       g_oocq_m.oocqstus,g_oocq_m.oocqownid,g_oocq_m.oocqownid_desc,g_oocq_m.oocqowndp,g_oocq_m.oocqowndp_desc, 
       g_oocq_m.oocqcrtid,g_oocq_m.oocqcrtid_desc,g_oocq_m.oocqcrtdp,g_oocq_m.oocqcrtdp_desc,g_oocq_m.oocqcrtdt, 
       g_oocq_m.oocqmodid,g_oocq_m.oocqmodid_desc,g_oocq_m.oocqmoddt
 
   CASE g_oocq_m.oocqstus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_oocq_m.oocqstus
            
            WHEN "N"
               HIDE OPTION "inactive"
            WHEN "Y"
               HIDE OPTION "active"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      
      #end add-point
      
      
	  
      ON ACTION inactive
         IF cl_auth_chk_act("inactive") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.inactive"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION active
         IF cl_auth_chk_act("active") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.active"
            
            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"
      
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "N" 
      AND lc_state <> "Y"
      ) OR 
      g_oocq_m.oocqstus = lc_state OR cl_null(lc_state) THEN
      CLOSE axri012_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   
   #end add-point
   
   LET g_oocq_m.oocqmodid = g_user
   LET g_oocq_m.oocqmoddt = cl_get_current()
   LET g_oocq_m.oocqstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE oocq_t 
      SET (oocqstus,oocqmodid,oocqmoddt) 
        = (g_oocq_m.oocqstus,g_oocq_m.oocqmodid,g_oocq_m.oocqmoddt)     
    WHERE oocqent = g_enterprise AND oocq001 = g_oocq_m.oocq001
      AND oocq002 = g_oocq_m.oocq002
    
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
    
      #撈取異動後的資料
      EXECUTE axri012_master_referesh USING g_oocq_m.oocq001,g_oocq_m.oocq002 INTO g_oocq_m.oocq002, 
          g_oocq_m.oocq001,g_oocq_m.oocq003,g_oocq_m.oocq004,g_oocq_m.oocqstus,g_oocq_m.oocqownid,g_oocq_m.oocqowndp, 
          g_oocq_m.oocqcrtid,g_oocq_m.oocqcrtdp,g_oocq_m.oocqcrtdt,g_oocq_m.oocqmodid,g_oocq_m.oocqmoddt, 
          g_oocq_m.oocqmodid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_oocq_m.oocq002,g_oocq_m.oocq001,g_oocq_m.oocq003,g_oocq_m.oocql004,g_oocq_m.oocq004, 
          g_oocq_m.oocqstus,g_oocq_m.oocqownid,g_oocq_m.oocqownid_desc,g_oocq_m.oocqowndp,g_oocq_m.oocqowndp_desc, 
          g_oocq_m.oocqcrtid,g_oocq_m.oocqcrtid_desc,g_oocq_m.oocqcrtdp,g_oocq_m.oocqcrtdp_desc,g_oocq_m.oocqcrtdt, 
          g_oocq_m.oocqmodid,g_oocq_m.oocqmodid_desc,g_oocq_m.oocqmoddt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE axri012_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL axri012_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axri012.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION axri012_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_xrac_d.getLength() THEN
         LET g_detail_idx = g_xrac_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_xrac_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xrac_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axri012.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axri012_b_fill2(pi_idx)
   #add-point:b_fill2段define(客製用) name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx                 LIKE type_t.num10
   DEFINE li_ac                  LIKE type_t.num10
   DEFINE li_detail_idx_tmp      LIKE type_t.num10
   DEFINE ls_chk                 LIKE type_t.chr1
   #add-point:b_fill2段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_detail_idx <= 0 THEN
      RETURN
   END IF
   
   LET li_detail_idx_tmp = g_detail_idx
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
   CALL axri012_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="axri012.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION axri012_fill_chk(ps_idx)
   #add-point:fill_chk段define(客製用) name="fill_chk.define_customerization"
   
   #end add-point
   DEFINE ps_idx        LIKE type_t.chr10
   #add-point:fill_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fill_chk.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="fill_chk.before_chk"
   
   #end add-point
   
   #此funtion功能暫時停用(2015/1/12)
   #無論傳入值為何皆回傳true(代表要填充該單身)
 
   #全部為1=1 or null時回傳true
   IF (cl_null(g_wc2_table1) OR g_wc2_table1.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk name="fill_chk.other_chk"
      
      #end add-point
      RETURN TRUE
   END IF
   
   #add-point:fill_chk段after_chk name="fill_chk.after_chk"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axri012.status_show" >}
PRIVATE FUNCTION axri012_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axri012.mask_functions" >}
&include "erp/axr/axri012_mask.4gl"
 
{</section>}
 
{<section id="axri012.signature" >}
   
 
{</section>}
 
{<section id="axri012.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION axri012_set_pk_array()
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
   LET g_pk_array[1].values = g_oocq_m.oocq001
   LET g_pk_array[1].column = 'oocq001'
   LET g_pk_array[2].values = g_oocq_m.oocq002
   LET g_pk_array[2].column = 'oocq002'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axri012.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="axri012.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION axri012_msgcentre_notify(lc_state)
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
   CALL axri012_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_oocq_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axri012.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION axri012_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="axri012.other_function" readonly="Y" >}
# #用于xrac004，xrac005，xrac006欄位錄入有效性檢查
# #p_min：最小值(必須錄入)
# #p_max：最大值(必須錄入)
# #p_num：傳入值（必須錄入）
# #axr-00001:0-12
# #axr-00002:-999~999
PRIVATE FUNCTION axri012_num_chk(p_num,p_min,p_max)
DEFINE p_num LIKE xrac_t.xrac005
   DEFINE p_min LIKE xrac_t.xrac005
   DEFINE p_max LIKE xrac_t.xrac005
   DEFINE r_success LIKE type_t.num5
   DEFINE l_errno LIKE type_t.chr20
   
   LET r_success = TRUE
   LET l_errno = ''

   IF NOT cl_null(p_min) AND NOT cl_null(p_max) AND NOT cl_null(p_num) THEN 
      #根據傳入的最大值為12或者999來判斷使用axr-00001還是axr-00002
      IF p_max = 12 THEN LET l_errno = 'axr-00001' END IF 
      IF p_max = 999 THEN LET l_errno = 'axr-00002' END IF 
      IF p_max = 99 THEN LET l_errno = 'axr-00005' END IF 
      IF p_max = 20 THEN LET l_errno = 'axr-00007' END IF  #請錄入0到20之間的數！
      IF NOT ap_chk_Range(p_num,p_min,1,p_max,1,l_errno,0) THEN
         LET r_success = FALSE
      END IF 
   END IF 
   RETURN r_success
END FUNCTION
# #oocq002重複性檢查
PRIVATE FUNCTION axri012_oocq002_chk(p_oocq002,p_oocq002_t,p_cmd)
DEFINE p_oocq002 LIKE oocq_t.oocq002
   DEFINE p_oocq002_t LIKE oocq_t.oocq002
   DEFINE p_cmd LIKE type_t.chr1
   DEFINE r_success LIKE type_t.num5

   LET r_success = TRUE
   IF NOT cl_null(p_oocq002) THEN 
      IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (p_oocq002 != g_oocq002_t ))) THEN 
         IF NOT ap_chk_notDup(p_oocq002,"SELECT COUNT(*) FROM oocq_t WHERE "||"oocqent = '" ||g_enterprise|| "' AND "||"oocq001 = '3114' AND "|| "oocq002 = '"||p_oocq002 ||"'",'std-00004',0) THEN 
            LET r_success = FALSE
         END IF
      END IF
   END IF
   RETURN r_success
END FUNCTION

PRIVATE FUNCTION axri012_set_format(ps_fields,ps_format)
   DEFINE   ps_fields           STRING,
            ps_format           STRING
   DEFINE   lst_fields          base.StringTokenizer,
            ls_field_name       STRING
   DEFINE   lnode_root          om.DomNode,
            llst_items          om.NodeList,
            li_i                LIKE type_t.num5,
            lnode_item          om.DomNode,
            ls_item_name        STRING,
            lnode_item_child    om.DomNode,
            ls_item_child_tag   STRING
   DEFINE   lwin_curr           ui.Window

   IF (ps_fields IS NULL) THEN
      RETURN
   ELSE
      LET ps_fields = ps_fields.toLowerCase()
   END IF

   LET lwin_curr = ui.Window.getCurrent()
   LET lnode_root = lwin_curr.getNode()

   LET llst_items = lnode_root.selectByPath("//Form//*")
   LET lst_fields = base.StringTokenizer.create(ps_fields, ",")
   WHILE lst_fields.hasMoreTokens()
      LET ls_field_name = lst_fields.nextToken()
      LET ls_field_name = ls_field_name.trim()

      FOR li_i = 1 TO llst_items.getLength()
         LET lnode_item = llst_items.item(li_i)
         LET ls_item_name = lnode_item.getAttribute("colName")

         IF (ls_item_name IS NULL) THEN
            LET ls_item_name = lnode_item.getAttribute("name")

            IF (ls_item_name IS NULL) THEN
               CONTINUE FOR
            END IF
         END IF

         IF (ls_item_name.equals(ls_field_name)) THEN
            LET lnode_item_child = lnode_item.getFirstChild()
            LET ls_item_child_tag = lnode_item_child.getTagName()
            IF (ls_item_child_tag.equals("Edit") OR
                ls_item_child_tag.equals("ButtonEdit") OR
                ls_item_child_tag.equals("Label") OR
                ls_item_child_tag.equals("DateEdit")) THEN

               CALL lnode_item_child.setAttribute("format", "")
               CALL lnode_item_child.setAttribute("format", ps_format)
            END IF

            EXIT FOR
         END IF
      END FOR
   END WHILE
END FUNCTION
# 開啟子作業---產生多賬期
# 0代表是點了按鈕，1代表是自動彈出提示
PRIVATE FUNCTION axri012_open_axri012_1(p_type)
DEFINE l_cnt LIKE type_t.num10 
   DEFINE p_type LIKE type_t.num5
   LET l_cnt = 0 
   IF NOT cl_null(g_oocq_m.oocq002) THEN 
      SELECT COUNT(*) INTO l_cnt FROM xrac_t
       WHERE xrac001 = '3114' 
         AND xrac002 = g_oocq_m.oocq002
         AND xracent = g_enterprise #160905-00007#3 add
      IF l_cnt = 0 THEN
         #CALL axri012_01(g_oocq_m.oocq002,g_oocq_m.oocq004) #20131008 mark
         CALL axri012_open_s01(g_oocq_m.oocq002,g_oocq_m.oocq004) #20131008 add
      ELSE 
         IF p_type = 0 THEN 
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'axr-00006'
            LET g_errparam.extend = g_oocq_m.oocq002
            LET g_errparam.popup = FALSE
            CALL cl_err()
 
         END IF 
      END IF 
   ELSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = '-400'
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()

   END IF
   CALL axri012_b_fill()
END FUNCTION
# oocq004欄位屬性動態設定
PRIVATE FUNCTION axri012_oocq004_set()
DEFINE l_gzad004 LIKE gzad_t.gzad004
   
   LET l_gzad004 = 'Y'
   SELECT gzad004 INTO l_gzad004 FROM gzad_t WHERE gzad001 = '3114' AND gzad002 = '1'
   #如果oocq004打勾表示可以空白
   IF l_gzad004 = 'N' THEN
      CALL cl_set_comp_required('oocq004',TRUE)
   ELSE
      CALL cl_set_comp_required('oocq004',FALSE)
   END IF 
   CALL cl_set_combo_scc('oocq004','8314')
END FUNCTION
# #對axrc003給默認值
PRIVATE FUNCTION axri012_xrac003_def(p_oocq002,p_xrac003,p_cmd)
DEFINE p_cmd LIKE type_t.chr1
   DEFINE p_xrac003 LIKE xrac_t.xrac003
   DEFINE p_oocq002 LIKE oocq_t.oocq002
   DEFINE r_return LIKE xrac_t.xrac003
   #如果p_xrac003為空
   #取xrac001 = '3114' and xrac002 = p_oocq002 的xrac003的最大值+1
   LET r_return = p_xrac003
   IF p_cmd = 'a' THEN
      SELECT MAX(xrac003) INTO r_return FROM xrac_t
       WHERE xrac001 = '3114'
         AND xrac002 = p_oocq002
	     AND xracent = g_enterprise
      IF cl_null(r_return) THEN LET r_return = 0 END IF 
      LET r_return = r_return +1
   END IF 
   
   RETURN r_return
END FUNCTION
# #單身key值重複報錯
PRIVATE FUNCTION axri012_xrac003_chk(p_oocq002,p_oocq002_t,p_xrac003,p_xrac003_t,p_cmd)
DEFINE p_oocq002 LIKE oocq_t.oocq002
   DEFINE p_oocq002_t LIKE oocq_t.oocq002
   DEFINE p_xrac003 LIKE xrac_t.xrac003
   DEFINE p_xrac003_t LIKE xrac_t.xrac003
   DEFINE p_cmd LIKE type_t.chr1
   DEFINE l_cmd LIKE type_t.chr1
   DEFINE r_success LIKE type_t.num5

   LET l_cmd = p_cmd
   LET r_success = TRUE
   
   IF NOT cl_null(p_oocq002) AND NOT cl_null(p_xrac003) THEN 
      IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (p_oocq002 != p_oocq002_t  OR p_xrac003 != p_xrac003_t))) THEN 
         IF NOT ap_chk_notDup(p_xrac003,"SELECT COUNT(*) FROM xrac_t WHERE "||"xracent = '" ||g_enterprise|| "' AND "||"xrac001 = '3114' AND "|| "xrac002 = '"||p_oocq002 ||"' AND "|| "xrac003 = '"||p_xrac003 ||"'",'std-00004',0) THEN 
            LET r_success = FALSE
         END IF
      END IF
   END IF
   
   RETURN r_success
END FUNCTION
# #檢查是否在axri013中已經有使用,表是xrad_t
PRIVATE FUNCTION axri012_void_chk(p_oocq002)
DEFINE p_oocq002 LIKE oocq_t.oocq002
   DEFINE r_success LIKE type_t.num5
   DEFINE l_oocqstus LIKE oocq_t.oocqstus
   DEFINE l_count    LIKE type_t.num10
   #給予初始化
   LET r_success = TRUE
   LET l_oocqstus = ''
   #空值判斷
   IF NOT cl_null(p_oocq002) THEN 
      #獲取傳入參數的stus欄位值
      SELECT oocqstus INTO l_oocqstus FROM oocq_t
       WHERE oocqent = g_enterprise AND oocq001 = '3114' AND oocq002 = p_oocq002 
      IF l_oocqstus = 'Y' THEN 
         #axri013使用的xrai_t
         LET l_count = 0
         SELECT COUNT(*) INTO l_count FROM xrai_t
          WHERE xrai002 = p_oocq002
            AND xraient = g_enterprise #160905-00007#3 add
         IF l_count > 0 THEN
            IF NOT cl_ask_confirm('axr-00004') THEN
               LET r_success = FALSE
            END IF
         END IF 
      END IF
   END IF 
   RETURN r_success
END FUNCTION
# #xrac007欄位屬性動態設定
PRIVATE FUNCTION axri012_xrac007_set()
CALL cl_set_combo_scc('xrac007','8310')
END FUNCTION
#單身xrac008欄位標題修改
PRIVATE FUNCTION axri012_xrac008_title(p_oocq001,p_oocq002)
   DEFINE p_oocq001 LIKE oocq_t.oocq001
   DEFINE p_oocq002 LIKE oocq_t.oocq002
   DEFINE l_xrac008 LIKE xrac_t.xrac008
   DEFINE l_pos     LIKE type_t.num10
   DEFINE l_dzeb003 LIKE dzeb_t.dzeb003
   DEFINE l_str     LIKE type_t.chr50
   
   LET l_xrac008 = 0
   LET l_str = ''
   LET l_dzeb003 = ''
   SELECT SUM(xrac008) INTO l_xrac008 FROM xrac_t
    WHERE xrac001 = p_oocq001 AND xrac002 = p_oocq002
      AND xracent = g_enterprise
   IF cl_null(l_xrac008) THEN LET l_xrac008 = 0 END IF 
   LET l_str = l_xrac008
   IF l_str = "0" THEN 
   ELSE
      CALL s_chr_get_index_of(l_xrac008,'.',1) RETURNING l_pos
      IF l_pos > 1 THEN
         LET l_str = l_str[1,l_pos+2]
      END IF
      SELECT dzeb003 INTO l_dzeb003 FROM dzeb_t WHERE dzeb001 = 'xrac_t' AND dzeb002 = 'xrac008'
      CALL cl_set_comp_att_text('xrac008',l_dzeb003||": "||l_str||"%")
   END IF
END FUNCTION
# 單身xrac008如果oocq004 = ‘1’ 時候完成錄入后需要判斷是否SUM（xrac008） =100
PRIVATE FUNCTION axri012_xrac008_chk(p_oocq002,p_oocq004)
DEFINE p_oocq002 LIKE oocq_t.oocq002
   DEFINE p_oocq004 LIKE oocq_t.oocq004
   DEFINE l_sum LIKE type_t.num20_6

   LET l_sum = 0
   IF p_oocq004 != '1' THEN
      RETURN
   END IF 
   SELECT sum(xrac008) INTO l_sum FROM xrac_t
    WHERE xrac001 = '3114'
      AND xrac002 = p_oocq002
      AND xracent = g_enterprise  #160819-00025#1 add
   IF l_sum != 100 THEN 
      #160819-00025#1 mod--s
      #INITIALIZE g_errparam TO NULL
      #LET g_errparam.code = 'axr-00003'
      #LET g_errparam.extend = l_sum
      #LET g_errparam.popup = TRUE
      #CALL cl_err()
      IF cl_ask_confirm("axr-01042") THEN  #多账期各期分配比率合计有误，不为100%！是否重新计算多账期各期分配比率？
         CALL axri012_xrac008_get(p_oocq002,p_oocq004)
      END IF
      #160819-00025#1 mod--e
   END IF
END FUNCTION
#+
PRIVATE FUNCTION axri012_open_s01(p_oocq002,p_oocq004)
   DEFINE p_oocq002 LIKE oocq_t.oocq002
   DEFINE p_oocq004 LIKE oocq_t.oocq004
   
   OPEN WINDOW w_axri012_s01 WITH FORM cl_ap_formpath("axr","axri012_s01")
   CALL cl_set_combo_scc('oocq004','8314') 
   CALL cl_set_combo_scc('xrac007','8310')
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_xrac_s.xrac001,g_xrac_s.xrac002,g_xrac_s.xrac003,g_xrac_s.oocq004,g_xrac_s.xrac006,g_xrac_s.xrac005,g_xrac_s.xrac004,g_xrac_s.xrac007 ATTRIBUTE(WITHOUT DEFAULTS)
         
         BEFORE INPUT
            LET g_xrac_s.xrac001 = '3114'
            LET g_xrac_s.xrac002 = p_oocq002
            LET g_xrac_s.oocq004 = p_oocq004
            LET g_xrac_s.xrac003 = 0
            LET g_xrac_s.xrac004 = 0
            LET g_xrac_s.xrac005 = 0
            LET g_xrac_s.xrac006 = 0
            LET g_xrac_s.xrac007 = 10          

         AFTER FIELD xrac003
            IF NOT axri012_num_chk(g_xrac_s.xrac003,0,20) THEN
               LET g_xrac_s.xrac003 = 0 
               NEXT FIELD xrac003
            END IF         

         AFTER FIELD xrac006
            IF NOT axri012_num_chk(g_xrac_s.xrac006,-999,999) THEN
               LET g_xrac_s.xrac006 = 0 
               NEXT FIELD xrac006
            END IF         

         AFTER FIELD xrac005
            IF NOT axri012_num_chk(g_xrac_s.xrac005,-12,12) THEN
               LET g_xrac_s.xrac005 = 0 
               NEXT FIELD xrac005
            END IF         

         AFTER FIELD xrac004
            IF NOT axri012_num_chk(g_xrac_s.xrac004,0,99) THEN
               LET g_xrac_s.xrac004 = 0 
               NEXT FIELD xrac004
            END IF         
       
         AFTER INPUT
            CALL axri012_xrac('3114',p_oocq002,g_xrac_s.oocq004,g_xrac_s.xrac003,g_xrac_s.xrac004,
                                     g_xrac_s.xrac005,g_xrac_s.xrac006,g_xrac_s.xrac007)           
            
      END INPUT

      ON ACTION accept
         ACCEPT DIALOG
        
      ON ACTION cancel
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION close
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit
         LET INT_FLAG = TRUE 
         EXIT DIALOG

   END DIALOG
 
   #畫面關閉
   CLOSE WINDOW w_axri012_s01 
   LET INT_FLAG = FALSE   
   
END FUNCTION
#+
PRIVATE FUNCTION axri012_xrac_ins(p_xrac001,p_xrac002,p_xrac003,p_xrac004,p_xrac005,p_xrac006,p_xrac007,p_xrac008)
   DEFINE p_xrac001 LIKE xrac_t.xrac001
   DEFINE p_xrac002 LIKE xrac_t.xrac002
   DEFINE p_xrac003 LIKE xrac_t.xrac003
   DEFINE p_xrac004 LIKE xrac_t.xrac004
   DEFINE p_xrac005 LIKE xrac_t.xrac005
   DEFINE p_xrac006 LIKE xrac_t.xrac006
   DEFINE p_xrac007 LIKE xrac_t.xrac007
   DEFINE p_xrac008 LIKE xrac_t.xrac008
   
   DEFINE r_success LIKE type_t.chr1
   LET r_success = 'Y'
   INSERT INTO xrac_t(xracent,xrac001,xrac002,xrac003,xrac004,
                      xrac005,xrac006,xrac007,xrac008)
               VALUES(g_enterprise,p_xrac001,p_xrac002,p_xrac003,p_xrac004,
                      p_xrac005,p_xrac006,p_xrac007,p_xrac008)      
   IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "ins xrac_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = 'N'
   END IF
   RETURN r_success
END FUNCTION
#+
PRIVATE FUNCTION axri012_xrac(p_xrac001,p_xrac002,p_oocq004,p_xrac003,p_xrac004,p_xrac005,p_xrac006,p_xrac007)
   DEFINE p_xrac001 LIKE xrac_t.xrac001
   DEFINE p_xrac002 LIKE xrac_t.xrac002
   DEFINE p_oocq004 LIKE oocq_t.oocq001
   DEFINE p_xrac003 LIKE xrac_t.xrac003
   DEFINE p_xrac004 LIKE xrac_t.xrac004
   DEFINE p_xrac005 LIKE xrac_t.xrac005
   DEFINE p_xrac006 LIKE xrac_t.xrac006
   DEFINE p_xrac007 LIKE xrac_t.xrac007
   DEFINE l_success LIKE type_t.chr1
   #161128-00061#3-----modify--begin----------
   #DEFINE l_xrac    RECORD LIKE xrac_t.*
   DEFINE l_xrac RECORD  #多帳期設定檔
       xracent LIKE xrac_t.xracent, #企業編號
       xrac001 LIKE xrac_t.xrac001, #應用分類
       xrac002 LIKE xrac_t.xrac002, #多帳期編號
       xrac003 LIKE xrac_t.xrac003, #帳期
       xrac004 LIKE xrac_t.xrac004, #間隔（季）
       xrac005 LIKE xrac_t.xrac005, #間隔（月）
       xrac006 LIKE xrac_t.xrac006, #間隔（日）
       xrac007 LIKE xrac_t.xrac007, #款別類型
       xrac008 LIKE xrac_t.xrac008  #分期比率
       END RECORD
   #161128-00061#3-----modify--end----------
   DEFINE l_cnt     LIKE type_t.num10   #用於判斷是否存在與xrac_t中
   DEFINE l_xrac008 LIKE xrac_t.xrac008 #用於累加xrac008的值
#初始化
   LET l_success = 'Y'
   INITIALIZE l_xrac.* TO NULL 
   LET l_cnt = 0
   LET l_xrac008 = 0
   
#由於axri012是使用的SCC：3114，故此處對第一個傳入的參數進行判斷
   #不等於的時候直接退出
   IF p_xrac001 != 3114 THEN RETURN END IF 
#判斷傳入值并給預設值
  #如果xrac001（應用分類），xrac002（應用分類碼），oocq004（金額設定），xrac003（產生期數）
  #為空，則RETURN
   IF cl_null(p_xrac001) OR cl_null(p_xrac002) OR cl_null(p_oocq004) OR cl_null(p_xrac003) THEN
      RETURN 
   END IF 
   LET l_xrac.xrac001 = p_xrac001
   LET l_xrac.xrac002 = p_xrac002
  #xrac004，xrac005，xrac006傳入值為空時初始化0
   IF cl_null(p_xrac004) THEN LET p_xrac004 = 0 END IF 
   IF cl_null(p_xrac005) THEN LET p_xrac005 = 0 END IF 
   IF cl_null(p_xrac006) THEN LET p_xrac006 = 0 END IF 
   LET l_xrac.xrac004 = p_xrac004
   LET l_xrac.xrac005 = p_xrac005
   LET l_xrac.xrac006 = p_xrac006
  #xrac003錄入值處理
   IF p_xrac003 = 0 THEN RETURN END IF  
  #xrac007給默認值10.現金類型
   LET l_xrac.xrac007 = p_xrac007
  #xrac008給默認值0
   IF p_oocq004 = '1' THEN
      LET l_xrac.xrac008 = s_num_round('1',(100/p_xrac003),1)
   ELSE
      LET l_xrac.xrac008 = 0 
   END IF 
   
  #xrac003給默認值
   LET l_xrac.xrac003 = 1
#判斷是否已經存在xrac_t的資料
   SELECT COUNT(*) INTO l_cnt FROM xrac_t
    WHERE xrac001 = p_xrac001
      AND xrac002 = p_xrac002
      AND xracent = g_enterprise #160905-00007#3 add

#啟用事務
   CALL s_transaction_begin()
   
   #開始插入操作
   WHILE TRUE
     #判斷要插入的xrac003與p_xrac003相等，且p_oocq004 = 1.比率分攤
     #或者要插入的xrac003大於p_xrac003
     #使用while外部的插入，否則xrac008均給與預設值0
      IF (l_xrac.xrac003 = p_xrac003 AND p_oocq004 = 1) OR l_xrac.xrac003 > p_xrac003 THEN
         EXIT WHILE
      END IF 

     #插入數據庫操作
      CALL axri012_xrac_ins(l_xrac.xrac001,l_xrac.xrac002,l_xrac.xrac003,
                               l_xrac.xrac004,l_xrac.xrac005,l_xrac.xrac006,
                               l_xrac.xrac007,l_xrac.xrac008)
           RETURNING l_success
      IF l_success = 'N' THEN EXIT WHILE END IF 
     #xrac003自動加1
      LET l_xrac.xrac003 = l_xrac.xrac003 + 1
     #xrac008累加
      LET l_xrac008 = l_xrac008 + l_xrac.xrac008
   END WHILE 
   
  #當p_oocq004 = '1',最後一筆資料由於xrac008的特殊性，直接在while外面插入數據庫中
   IF l_success = 'Y' AND p_oocq004 = '1'  THEN 
     #給xrac003 ,xrac008賦值
      LET l_xrac.xrac003 = p_xrac003
      LET l_xrac.xrac008 = 100 - l_xrac008
      CALL axri012_xrac_ins(l_xrac.xrac001,l_xrac.xrac002,l_xrac.xrac003,
                              l_xrac.xrac004,l_xrac.xrac005,l_xrac.xrac006,
                              l_xrac.xrac007,l_xrac.xrac008)
          RETURNING l_success 
   END IF
   
#結束事務
   CALL s_transaction_end(l_success,1)
END FUNCTION

#自动分配xrac008
#160819-00025#1 add
PRIVATE FUNCTION axri012_xrac008_get(p_oocq002,p_oocq004)
   DEFINE p_oocq002     LIKE oocq_t.oocq002
   DEFINE p_oocq004     LIKE oocq_t.oocq004
   DEFINE l_xrac008_sum LIKE xrac_t.xrac008 #用於累加xrac008的值
   DEFINE l_count,l_ac  LIKE type_t.num10
   DEFINE l_sql         STRING
   DEFINE l_xrac003     LIKE xrac_t.xrac003
   DEFINE l_xrac008     LIKE xrac_t.xrac008

   IF p_oocq004 != '1' THEN
      RETURN
   END IF 
   
   SELECT COUNT(*) INTO l_count FROM xrac_t
    WHERE xracent = g_enterprise
      AND xrac001 = '3114'
      AND xrac002 = p_oocq002
   IF l_count = 0 THEN
      RETURN
   END IF
   
   CALL s_transaction_begin()
   LET l_ac          = 1
   LET l_xrac008_sum = 0
   
   LET l_sql = " SELECT xrac003 FROM xrac_t ",
               "  WHERE xracent = ",g_enterprise,
               "    AND xrac001 = '3114' ",
               "    AND xrac002 = '",p_oocq002,"' "
   PREPARE axri012_xrac008_get_p FROM l_sql
   DECLARE axri012_xrac008_get_c CURSOR FOR axri012_xrac008_get_p
   FOREACH axri012_xrac008_get_c INTO l_xrac003
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH: nmbx"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF 
      
      #最后一笔考虑小数误差
      IF l_count = l_ac THEN
         LET l_xrac008 = 100 - l_xrac008_sum
      ELSE
         LET l_xrac008 = s_num_round('1',(100/l_count),1)  #同axri012_xrac()的处理方法一致
      END IF
      LET l_xrac008_sum = l_xrac008_sum + l_xrac008  #xrac008累加
      
      UPDATE xrac_t SET xrac008 = l_xrac008
       WHERE xracent = g_enterprise
         AND xrac001 = '3114'
         AND xrac002 = p_oocq002
         AND xrac003 = l_xrac003
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "upd xrac_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         CALL s_transaction_end('N','0')
         EXIT FOREACH
      END IF
      
      LET l_ac = l_ac + 1
   END FOREACH
   
   CALL s_transaction_end('Y','0')
END FUNCTION

 
{</section>}
 
