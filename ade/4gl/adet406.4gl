#該程式未解開Section, 採用最新樣板產出!
{<section id="adet406.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2016-10-19 10:04:08), PR版次:0006(2016-11-24 16:17:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000026
#+ Filename...: adet406
#+ Description: 門店收銀交款出納結帳作業
#+ Creator....: 02114(2016-06-20 10:14:34)
#+ Modifier...: 02749 -SD/PR- 06137
 
{</section>}
 
{<section id="adet406.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160509-00004#99    2016/07/01  By 02114       收银员开窗过率职能为1，收银员
#160818-00017#7     2016/08/24  by 08172       修改删除时重新检查状态
#161006-00008#10    2016/10/19  By lori        補齊aooi500管控要點
#161104-00002#3     2016/11/07  By 06137       調整系統*寫法
#161123-00042#3  161124 By 06137  161104-00002 星號寫法, 應補上自定義欄位
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
PRIVATE type type_g_dead_m        RECORD
       deadsite LIKE dead_t.deadsite, 
   deadsite_desc LIKE type_t.chr80, 
   deaddocdt LIKE dead_t.deaddocdt, 
   deadstamp DATETIME YEAR TO FRACTION(5), 
   deaddocno LIKE dead_t.deaddocno, 
   dead001 LIKE dead_t.dead001, 
   dead001_desc LIKE type_t.chr80, 
   deadstus LIKE dead_t.deadstus, 
   deadownid LIKE dead_t.deadownid, 
   deadownid_desc LIKE type_t.chr80, 
   deadowndp LIKE dead_t.deadowndp, 
   deadowndp_desc LIKE type_t.chr80, 
   deadcrtid LIKE dead_t.deadcrtid, 
   deadcrtid_desc LIKE type_t.chr80, 
   deadcrtdp LIKE dead_t.deadcrtdp, 
   deadcrtdp_desc LIKE type_t.chr80, 
   deadcrtdt LIKE dead_t.deadcrtdt, 
   deadmodid LIKE dead_t.deadmodid, 
   deadmodid_desc LIKE type_t.chr80, 
   deadmoddt LIKE dead_t.deadmoddt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_deae_d        RECORD
       deae002 LIKE deae_t.deae002, 
   deae001 LIKE deae_t.deae001, 
   deae001_desc LIKE type_t.chr500, 
   deae003 LIKE deae_t.deae003, 
   deae004 LIKE deae_t.deae004, 
   deae005 LIKE deae_t.deae005, 
   deae006 LIKE deae_t.deae006, 
   deae007 LIKE deae_t.deae007, 
   deaesite LIKE deae_t.deaesite
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_deaddocno LIKE dead_t.deaddocno
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_ooaa002         LIKE type_t.chr1   #160816-00007#1 add lujh
DEFINE g_ins_site_flag   LIKE type_t.chr1   #161006-00008#10 161102 by lori add
#end add-point
       
#模組變數(Module Variables)
DEFINE g_dead_m          type_g_dead_m
DEFINE g_dead_m_t        type_g_dead_m
DEFINE g_dead_m_o        type_g_dead_m
DEFINE g_dead_m_mask_o   type_g_dead_m #轉換遮罩前資料
DEFINE g_dead_m_mask_n   type_g_dead_m #轉換遮罩後資料
 
   DEFINE g_deaddocno_t LIKE dead_t.deaddocno
 
 
DEFINE g_deae_d          DYNAMIC ARRAY OF type_g_deae_d
DEFINE g_deae_d_t        type_g_deae_d
DEFINE g_deae_d_o        type_g_deae_d
DEFINE g_deae_d_mask_o   DYNAMIC ARRAY OF type_g_deae_d #轉換遮罩前資料
DEFINE g_deae_d_mask_n   DYNAMIC ARRAY OF type_g_deae_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
 
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
 
{<section id="adet406.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5   #161006-00008#10 161019 by lori add 
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ade","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT deadsite,'',deaddocdt,deadstamp,deaddocno,dead001,'',deadstus,deadownid, 
       '',deadowndp,'',deadcrtid,'',deadcrtdp,'',deadcrtdt,deadmodid,'',deadmoddt", 
                      " FROM dead_t",
                      " WHERE deadent= ? AND deaddocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE adet406_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.deadsite,t0.deaddocdt,t0.deadstamp,t0.deaddocno,t0.dead001,t0.deadstus, 
       t0.deadownid,t0.deadowndp,t0.deadcrtid,t0.deadcrtdp,t0.deadcrtdt,t0.deadmodid,t0.deadmoddt,t1.ooefl003 , 
       t2.pcab003 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011 ,t6.ooefl003 ,t7.ooag011",
               " FROM dead_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.deadsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN pcab_t t2 ON t2.pcabent="||g_enterprise||" AND t2.pcab001=t0.dead001  ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.deadownid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.deadowndp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.deadcrtid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.deadcrtdp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.deadmodid  ",
 
               " WHERE t0.deadent = " ||g_enterprise|| " AND t0.deaddocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE adet406_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_adet406 WITH FORM cl_ap_formpath("ade",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL adet406_init()   
 
      #進入選單 Menu (="N")
      CALL adet406_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_adet406
      
   END IF 
   
   CLOSE adet406_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success   #161006-00008#10 161019 by lori add 
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="adet406.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION adet406_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5   #161006-00008#10 161019 by lori add 
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
      CALL cl_set_combo_scc_part('deadstus','13','N,Y,X')
 
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success   #161006-00008#10 161019 by lori add 
   
   CALL cl_set_combo_scc('deae002','8310') 
   
   #160816-00007#1--add--str--lujh
   CALL cl_get_para(g_enterprise,'','E-CIR-0072') RETURNING g_ooaa002      
   CALL adet406_visible()   
   #160816-00007#1--add--end--lujh  
   
   #end add-point
   
   #初始化搜尋條件
   CALL adet406_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="adet406.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION adet406_ui_dialog()
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
   DEFINE  l_success             LIKE type_t.num5     #160816-00007#1 add lujh
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
            CALL adet406_insert()
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
         INITIALIZE g_dead_m.* TO NULL
         CALL g_deae_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL adet406_init()
      END IF
   
            
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
    
         DISPLAY ARRAY g_deae_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL adet406_idx_chk()
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
               CALL adet406_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
      
         BEFORE DIALOG
            #先填充browser資料
            CALL adet406_browser_fill("")
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
               CALL adet406_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL adet406_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL adet406_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL adet406_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL adet406_set_act_visible()   
            CALL adet406_set_act_no_visible()
            IF NOT (g_dead_m.deaddocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " deadent = " ||g_enterprise|| " AND",
                                  " deaddocno = '", g_dead_m.deaddocno, "' "
 
               #填到對應位置
               CALL adet406_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "dead_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "deae_t" 
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
               CALL adet406_browser_fill("F")   #browser_fill()會將notice區塊清空
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "dead_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "deae_t" 
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
                  CALL adet406_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL adet406_fetch("F")
                  END IF
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
          
         
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL adet406_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adet406_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL adet406_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adet406_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL adet406_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adet406_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL adet406_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adet406_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL adet406_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adet406_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_deae_d)
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
         ON ACTION adet406_s01
            LET g_action_choice="adet406_s01"
            IF cl_auth_chk_act("adet406_s01") THEN
               
               #add-point:ON ACTION adet406_s01 name="menu.adet406_s01"
               #160816-00007#1--add--str--lujh
               CALL s_transaction_begin()
               CALL cl_err_collect_init() 
               CALL adet406_open_adet406_s01() RETURNING l_success
               CALL cl_err_collect_show()
               IF l_success THEN
                  CALL s_transaction_end('Y','1')
               ELSE
                  CALL s_transaction_end('N','0')
               END IF
               CALL adet406_browser_fill("")
               IF g_browser_cnt > 0 THEN
                  IF NOT cl_null(g_current_idx) THEN
                     LET g_current_idx = 1
                  END IF
               ELSE 
                  LET g_current_idx = 0
               END IF
               
               IF g_current_idx <> 0 THEN
                  CALL adet406_fetch('') 
               END IF
               #160816-00007#1--add--end--lujh
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL adet406_delete()
               #add-point:ON ACTION delete name="menu.delete"
               #160818-00017#7 -s by 08172
               CALL adet406_set_act_visible()   
               CALL adet406_set_act_no_visible()
               #160818-00017#7 -e by 08172 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL adet406_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/ade/adet406_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/ade/adet406_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL adet406_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL adet406_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL adet406_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL adet406_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL adet406_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_dead_m.deaddocdt)
 
 
 
         
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
 
{<section id="adet406.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION adet406_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   DEFINE l_where           STRING   #161006-00008#10 161102 by lori add
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
   #161006-00008#10 161102 by lori add---(S)
   LET l_where = ''
   CALL s_aooi500_sql_where(g_prog,'deadsite') RETURNING l_where
   LET l_wc = l_wc," AND ",l_where
   #161006-00008#10 161102 by lori add---(E)
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT deaddocno ",
                      " FROM dead_t ",
                      " ",
                      " LEFT JOIN deae_t ON deaeent = deadent AND deaddocno = deaedocno ", "  ",
                      #add-point:browser_fill段sql(deae_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE deadent = " ||g_enterprise|| " AND deaeent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("dead_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT deaddocno ",
                      " FROM dead_t ", 
                      "  ",
                      "  ",
                      " WHERE deadent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("dead_t")
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
      INITIALIZE g_dead_m.* TO NULL
      CALL g_deae_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.deaddocno Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.deadstus,t0.deaddocno ",
                  " FROM dead_t t0",
                  "  ",
                  "  LEFT JOIN deae_t ON deaeent = deadent AND deaddocno = deaedocno ", "  ", 
                  #add-point:browser_fill段sql(deae_t1) name="browser_fill.join.deae_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                  
                  " WHERE t0.deadent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("dead_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.deadstus,t0.deaddocno ",
                  " FROM dead_t t0",
                  "  ",
                  
                  " WHERE t0.deadent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("dead_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY deaddocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"dead_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_deaddocno
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
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
         WHEN "X"
            LET g_browser[g_cnt].b_statepic = "stus/16/invalid.png"
         
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
   
   IF cl_null(g_browser[g_cnt].b_deaddocno) THEN
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
 
{<section id="adet406.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION adet406_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_dead_m.deaddocno = g_browser[g_current_idx].b_deaddocno   
 
   EXECUTE adet406_master_referesh USING g_dead_m.deaddocno INTO g_dead_m.deadsite,g_dead_m.deaddocdt, 
       g_dead_m.deadstamp,g_dead_m.deaddocno,g_dead_m.dead001,g_dead_m.deadstus,g_dead_m.deadownid,g_dead_m.deadowndp, 
       g_dead_m.deadcrtid,g_dead_m.deadcrtdp,g_dead_m.deadcrtdt,g_dead_m.deadmodid,g_dead_m.deadmoddt, 
       g_dead_m.deadsite_desc,g_dead_m.dead001_desc,g_dead_m.deadownid_desc,g_dead_m.deadowndp_desc, 
       g_dead_m.deadcrtid_desc,g_dead_m.deadcrtdp_desc,g_dead_m.deadmodid_desc
   
   CALL adet406_dead_t_mask()
   CALL adet406_show()
      
END FUNCTION
 
{</section>}
 
{<section id="adet406.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION adet406_ui_detailshow()
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
 
{<section id="adet406.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION adet406_ui_browser_refresh()
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
      IF g_browser[l_i].b_deaddocno = g_dead_m.deaddocno 
 
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
 
{<section id="adet406.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION adet406_construct()
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
   INITIALIZE g_dead_m.* TO NULL
   CALL g_deae_d.clear()        
 
   
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
      CONSTRUCT BY NAME g_wc ON deadsite,deaddocdt,deadstamp,deaddocno,dead001,deadstus,deadownid,deadowndp, 
          deadcrtid,deadcrtdp,deadcrtdt,deadmodid,deadmoddt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<deadcrtdt>>----
         AFTER FIELD deadcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<deadmoddt>>----
         AFTER FIELD deadmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<deadcnfdt>>----
         
         #----<<deadpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deadsite
            #add-point:BEFORE FIELD deadsite name="construct.b.deadsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deadsite
            
            #add-point:AFTER FIELD deadsite name="construct.a.deadsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.deadsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deadsite
            #add-point:ON ACTION controlp INFIELD deadsite name="construct.c.deadsite"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'deadsite',g_site,'c')
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO deadsite  #顯示到畫面上
            NEXT FIELD deadsite                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaddocdt
            #add-point:BEFORE FIELD deaddocdt name="construct.b.deaddocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaddocdt
            
            #add-point:AFTER FIELD deaddocdt name="construct.a.deaddocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.deaddocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaddocdt
            #add-point:ON ACTION controlp INFIELD deaddocdt name="construct.c.deaddocdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deadstamp
            #add-point:BEFORE FIELD deadstamp name="construct.b.deadstamp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deadstamp
            
            #add-point:AFTER FIELD deadstamp name="construct.a.deadstamp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.deadstamp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deadstamp
            #add-point:ON ACTION controlp INFIELD deadstamp name="construct.c.deadstamp"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaddocno
            #add-point:BEFORE FIELD deaddocno name="construct.b.deaddocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaddocno
            
            #add-point:AFTER FIELD deaddocno name="construct.a.deaddocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.deaddocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaddocno
            #add-point:ON ACTION controlp INFIELD deaddocno name="construct.c.deaddocno"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dead001
            #add-point:BEFORE FIELD dead001 name="construct.b.dead001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dead001
            
            #add-point:AFTER FIELD dead001 name="construct.a.dead001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.dead001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dead001
            #add-point:ON ACTION controlp INFIELD dead001 name="construct.c.dead001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = " pcab006 = '1' AND pcac002 = '",g_site,"'"   #160509-00004#99 add lujh
            CALL q_pcab001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dead001  #顯示到畫面上

            NEXT FIELD dead001                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deadstus
            #add-point:BEFORE FIELD deadstus name="construct.b.deadstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deadstus
            
            #add-point:AFTER FIELD deadstus name="construct.a.deadstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.deadstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deadstus
            #add-point:ON ACTION controlp INFIELD deadstus name="construct.c.deadstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.deadownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deadownid
            #add-point:ON ACTION controlp INFIELD deadownid name="construct.c.deadownid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO deadownid  #顯示到畫面上
            NEXT FIELD deadownid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deadownid
            #add-point:BEFORE FIELD deadownid name="construct.b.deadownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deadownid
            
            #add-point:AFTER FIELD deadownid name="construct.a.deadownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.deadowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deadowndp
            #add-point:ON ACTION controlp INFIELD deadowndp name="construct.c.deadowndp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO deadowndp  #顯示到畫面上
            NEXT FIELD deadowndp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deadowndp
            #add-point:BEFORE FIELD deadowndp name="construct.b.deadowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deadowndp
            
            #add-point:AFTER FIELD deadowndp name="construct.a.deadowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.deadcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deadcrtid
            #add-point:ON ACTION controlp INFIELD deadcrtid name="construct.c.deadcrtid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO deadcrtid  #顯示到畫面上
            NEXT FIELD deadcrtid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deadcrtid
            #add-point:BEFORE FIELD deadcrtid name="construct.b.deadcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deadcrtid
            
            #add-point:AFTER FIELD deadcrtid name="construct.a.deadcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.deadcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deadcrtdp
            #add-point:ON ACTION controlp INFIELD deadcrtdp name="construct.c.deadcrtdp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO deadcrtdp  #顯示到畫面上
            NEXT FIELD deadcrtdp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deadcrtdp
            #add-point:BEFORE FIELD deadcrtdp name="construct.b.deadcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deadcrtdp
            
            #add-point:AFTER FIELD deadcrtdp name="construct.a.deadcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deadcrtdt
            #add-point:BEFORE FIELD deadcrtdt name="construct.b.deadcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.deadmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deadmodid
            #add-point:ON ACTION controlp INFIELD deadmodid name="construct.c.deadmodid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO deadmodid  #顯示到畫面上
            NEXT FIELD deadmodid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deadmodid
            #add-point:BEFORE FIELD deadmodid name="construct.b.deadmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deadmodid
            
            #add-point:AFTER FIELD deadmodid name="construct.a.deadmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deadmoddt
            #add-point:BEFORE FIELD deadmoddt name="construct.b.deadmoddt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON deae002,deae001,deae003,deae004,deae005,deae006,deae007,deaesite
           FROM s_detail1[1].deae002,s_detail1[1].deae001,s_detail1[1].deae003,s_detail1[1].deae004, 
               s_detail1[1].deae005,s_detail1[1].deae006,s_detail1[1].deae007,s_detail1[1].deaesite
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deae002
            #add-point:BEFORE FIELD deae002 name="construct.b.page1.deae002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deae002
            
            #add-point:AFTER FIELD deae002 name="construct.a.page1.deae002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.deae002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deae002
            #add-point:ON ACTION controlp INFIELD deae002 name="construct.c.page1.deae002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deae001
            #add-point:BEFORE FIELD deae001 name="construct.b.page1.deae001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deae001
            
            #add-point:AFTER FIELD deae001 name="construct.a.page1.deae001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.deae001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deae001
            #add-point:ON ACTION controlp INFIELD deae001 name="construct.c.page1.deae001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooia001_5()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO deae001  #顯示到畫面上
            NEXT FIELD deae001                     #返回原欄位  
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deae003
            #add-point:BEFORE FIELD deae003 name="construct.b.page1.deae003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deae003
            
            #add-point:AFTER FIELD deae003 name="construct.a.page1.deae003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.deae003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deae003
            #add-point:ON ACTION controlp INFIELD deae003 name="construct.c.page1.deae003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deae004
            #add-point:BEFORE FIELD deae004 name="construct.b.page1.deae004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deae004
            
            #add-point:AFTER FIELD deae004 name="construct.a.page1.deae004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.deae004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deae004
            #add-point:ON ACTION controlp INFIELD deae004 name="construct.c.page1.deae004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deae005
            #add-point:BEFORE FIELD deae005 name="construct.b.page1.deae005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deae005
            
            #add-point:AFTER FIELD deae005 name="construct.a.page1.deae005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.deae005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deae005
            #add-point:ON ACTION controlp INFIELD deae005 name="construct.c.page1.deae005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deae006
            #add-point:BEFORE FIELD deae006 name="construct.b.page1.deae006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deae006
            
            #add-point:AFTER FIELD deae006 name="construct.a.page1.deae006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.deae006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deae006
            #add-point:ON ACTION controlp INFIELD deae006 name="construct.c.page1.deae006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deae007
            #add-point:BEFORE FIELD deae007 name="construct.b.page1.deae007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deae007
            
            #add-point:AFTER FIELD deae007 name="construct.a.page1.deae007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.deae007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deae007
            #add-point:ON ACTION controlp INFIELD deae007 name="construct.c.page1.deae007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaesite
            #add-point:BEFORE FIELD deaesite name="construct.b.page1.deaesite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaesite
            
            #add-point:AFTER FIELD deaesite name="construct.a.page1.deaesite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.deaesite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaesite
            #add-point:ON ACTION controlp INFIELD deaesite name="construct.c.page1.deaesite"
            
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
                  WHEN la_wc[li_idx].tableid = "dead_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "deae_t" 
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
 
{<section id="adet406.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION adet406_query()
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
   CALL g_deae_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL adet406_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL adet406_browser_fill("")
      CALL adet406_fetch("")
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
   CALL adet406_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL adet406_fetch("F") 
      #顯示單身筆數
      CALL adet406_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="adet406.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION adet406_fetch(p_flag)
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
   
   LET g_dead_m.deaddocno = g_browser[g_current_idx].b_deaddocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE adet406_master_referesh USING g_dead_m.deaddocno INTO g_dead_m.deadsite,g_dead_m.deaddocdt, 
       g_dead_m.deadstamp,g_dead_m.deaddocno,g_dead_m.dead001,g_dead_m.deadstus,g_dead_m.deadownid,g_dead_m.deadowndp, 
       g_dead_m.deadcrtid,g_dead_m.deadcrtdp,g_dead_m.deadcrtdt,g_dead_m.deadmodid,g_dead_m.deadmoddt, 
       g_dead_m.deadsite_desc,g_dead_m.dead001_desc,g_dead_m.deadownid_desc,g_dead_m.deadowndp_desc, 
       g_dead_m.deadcrtid_desc,g_dead_m.deadcrtdp_desc,g_dead_m.deadmodid_desc
   
   #遮罩相關處理
   LET g_dead_m_mask_o.* =  g_dead_m.*
   CALL adet406_dead_t_mask()
   LET g_dead_m_mask_n.* =  g_dead_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL adet406_set_act_visible()   
   CALL adet406_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_dead_m_t.* = g_dead_m.*
   LET g_dead_m_o.* = g_dead_m.*
   
   LET g_data_owner = g_dead_m.deadownid      
   LET g_data_dept  = g_dead_m.deadowndp
   
   #重新顯示   
   CALL adet406_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="adet406.insert" >}
#+ 資料新增
PRIVATE FUNCTION adet406_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE l_insert      LIKE type_t.num5
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_deae_d.clear()   
 
 
   INITIALIZE g_dead_m.* TO NULL             #DEFAULT 設定
   
   LET g_deaddocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_dead_m.deadownid = g_user
      LET g_dead_m.deadowndp = g_dept
      LET g_dead_m.deadcrtid = g_user
      LET g_dead_m.deadcrtdp = g_dept 
      LET g_dead_m.deadcrtdt = cl_get_current()
      LET g_dead_m.deadmodid = g_user
      LET g_dead_m.deadmoddt = cl_get_current()
      LET g_dead_m.deadstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
      
  
      #add-point:單頭預設值 name="insert.default"
      LET g_ins_site_flag = ''   #161006-00008#10 161102 by lori add
      
      CALL s_aooi500_default(g_prog,'deadsite',g_dead_m.deadsite)
         RETURNING l_insert,g_dead_m.deadsite
      IF NOT l_insert THEN
         RETURN
      END IF
      CALL s_desc_get_department_desc(g_dead_m.deadsite) RETURNING g_dead_m.deadsite_desc
      DISPLAY BY NAME g_dead_m.deadsite_desc 
      LET g_dead_m.deaddocdt = g_today
      LET g_dead_m.deadstamp = cl_get_time()
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_dead_m_t.* = g_dead_m.*
      LET g_dead_m_o.* = g_dead_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_dead_m.deadstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
    
      CALL adet406_input("a")
      
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
         INITIALIZE g_dead_m.* TO NULL
         INITIALIZE g_deae_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL adet406_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_deae_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL adet406_set_act_visible()   
   CALL adet406_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_deaddocno_t = g_dead_m.deaddocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " deadent = " ||g_enterprise|| " AND",
                      " deaddocno = '", g_dead_m.deaddocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL adet406_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE adet406_cl
   
   CALL adet406_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE adet406_master_referesh USING g_dead_m.deaddocno INTO g_dead_m.deadsite,g_dead_m.deaddocdt, 
       g_dead_m.deadstamp,g_dead_m.deaddocno,g_dead_m.dead001,g_dead_m.deadstus,g_dead_m.deadownid,g_dead_m.deadowndp, 
       g_dead_m.deadcrtid,g_dead_m.deadcrtdp,g_dead_m.deadcrtdt,g_dead_m.deadmodid,g_dead_m.deadmoddt, 
       g_dead_m.deadsite_desc,g_dead_m.dead001_desc,g_dead_m.deadownid_desc,g_dead_m.deadowndp_desc, 
       g_dead_m.deadcrtid_desc,g_dead_m.deadcrtdp_desc,g_dead_m.deadmodid_desc
   
   
   #遮罩相關處理
   LET g_dead_m_mask_o.* =  g_dead_m.*
   CALL adet406_dead_t_mask()
   LET g_dead_m_mask_n.* =  g_dead_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_dead_m.deadsite,g_dead_m.deadsite_desc,g_dead_m.deaddocdt,g_dead_m.deadstamp,g_dead_m.deaddocno, 
       g_dead_m.dead001,g_dead_m.dead001_desc,g_dead_m.deadstus,g_dead_m.deadownid,g_dead_m.deadownid_desc, 
       g_dead_m.deadowndp,g_dead_m.deadowndp_desc,g_dead_m.deadcrtid,g_dead_m.deadcrtid_desc,g_dead_m.deadcrtdp, 
       g_dead_m.deadcrtdp_desc,g_dead_m.deadcrtdt,g_dead_m.deadmodid,g_dead_m.deadmodid_desc,g_dead_m.deadmoddt 
 
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_dead_m.deadownid      
   LET g_data_dept  = g_dead_m.deadowndp
   
   #功能已完成,通報訊息中心
   CALL adet406_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="adet406.modify" >}
#+ 資料修改
PRIVATE FUNCTION adet406_modify()
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
   LET g_dead_m_t.* = g_dead_m.*
   LET g_dead_m_o.* = g_dead_m.*
   
   IF g_dead_m.deaddocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_deaddocno_t = g_dead_m.deaddocno
 
   CALL s_transaction_begin()
   
   OPEN adet406_cl USING g_enterprise,g_dead_m.deaddocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN adet406_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE adet406_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE adet406_master_referesh USING g_dead_m.deaddocno INTO g_dead_m.deadsite,g_dead_m.deaddocdt, 
       g_dead_m.deadstamp,g_dead_m.deaddocno,g_dead_m.dead001,g_dead_m.deadstus,g_dead_m.deadownid,g_dead_m.deadowndp, 
       g_dead_m.deadcrtid,g_dead_m.deadcrtdp,g_dead_m.deadcrtdt,g_dead_m.deadmodid,g_dead_m.deadmoddt, 
       g_dead_m.deadsite_desc,g_dead_m.dead001_desc,g_dead_m.deadownid_desc,g_dead_m.deadowndp_desc, 
       g_dead_m.deadcrtid_desc,g_dead_m.deadcrtdp_desc,g_dead_m.deadmodid_desc
   
   #檢查是否允許此動作
   IF NOT adet406_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_dead_m_mask_o.* =  g_dead_m.*
   CALL adet406_dead_t_mask()
   LET g_dead_m_mask_n.* =  g_dead_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL adet406_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_deaddocno_t = g_dead_m.deaddocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_dead_m.deadmodid = g_user 
LET g_dead_m.deadmoddt = cl_get_current()
LET g_dead_m.deadmodid_desc = cl_get_username(g_dead_m.deadmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL adet406_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE dead_t SET (deadmodid,deadmoddt) = (g_dead_m.deadmodid,g_dead_m.deadmoddt)
          WHERE deadent = g_enterprise AND deaddocno = g_deaddocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_dead_m.* = g_dead_m_t.*
            CALL adet406_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_dead_m.deaddocno != g_dead_m_t.deaddocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE deae_t SET deaedocno = g_dead_m.deaddocno
 
          WHERE deaeent = g_enterprise AND deaedocno = g_dead_m_t.deaddocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "deae_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "deae_t:",SQLERRMESSAGE 
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
   CALL adet406_set_act_visible()   
   CALL adet406_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " deadent = " ||g_enterprise|| " AND",
                      " deaddocno = '", g_dead_m.deaddocno, "' "
 
   #填到對應位置
   CALL adet406_browser_fill("")
 
   CLOSE adet406_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL adet406_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="adet406.input" >}
#+ 資料輸入
PRIVATE FUNCTION adet406_input(p_cmd)
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
   DEFINE  l_ooef004             LIKE ooef_t.ooef004 
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_str                 STRING
   DEFINE  l_no                  LIKE type_t.chr10
   DEFINE  l_ooia002             LIKE ooia_t.ooia002   
   DEFINE  l_errno               STRING                #161006-00008#10 161102 by lori add
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
   DISPLAY BY NAME g_dead_m.deadsite,g_dead_m.deadsite_desc,g_dead_m.deaddocdt,g_dead_m.deadstamp,g_dead_m.deaddocno, 
       g_dead_m.dead001,g_dead_m.dead001_desc,g_dead_m.deadstus,g_dead_m.deadownid,g_dead_m.deadownid_desc, 
       g_dead_m.deadowndp,g_dead_m.deadowndp_desc,g_dead_m.deadcrtid,g_dead_m.deadcrtid_desc,g_dead_m.deadcrtdp, 
       g_dead_m.deadcrtdp_desc,g_dead_m.deadcrtdt,g_dead_m.deadmodid,g_dead_m.deadmodid_desc,g_dead_m.deadmoddt 
 
   
   #切換畫面
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql name="input.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT deae002,deae001,deae003,deae004,deae005,deae006,deae007,deaesite FROM  
       deae_t WHERE deaeent=? AND deaedocno=? AND deae001=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE adet406_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL adet406_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL adet406_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_dead_m.deadsite,g_dead_m.deaddocdt,g_dead_m.deadstamp,g_dead_m.deaddocno,g_dead_m.dead001, 
       g_dead_m.deadstus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="adet406.input.head" >}
      #單頭段
      INPUT BY NAME g_dead_m.deadsite,g_dead_m.deaddocdt,g_dead_m.deadstamp,g_dead_m.deaddocno,g_dead_m.dead001, 
          g_dead_m.deadstus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN adet406_cl USING g_enterprise,g_dead_m.deaddocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN adet406_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE adet406_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL adet406_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL adet406_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deadsite
            
            #add-point:AFTER FIELD deadsite name="input.a.deadsite"
            #161006-00008#10 161102 by lori mark---(S)
            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_dead_m.deadsite
            #CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            #LET g_dead_m.deadsite_desc = '', g_rtn_fields[1] , ''
            #DISPLAY BY NAME g_dead_m.deadsite_desc            
            #161006-00008#10 161102 by lori mark---(E)
            
            #161006-00008#10 161102 by lori add---(S)
            LET g_dead_m.deadsite_desc = ' '
            DISPLAY BY NAME g_dead_m.deadsite_desc
            IF NOT cl_null(g_dead_m.deadsite) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_dead_m.deadsite != g_dead_m_t.deadsite OR g_dead_m_t.deadsite IS NULL )) THEN
                  LET l_success = NULL
                  LET l_errno = NULL
                  CALL s_aooi500_chk(g_prog,'deadsite',g_dead_m.deadsite,g_dead_m.deadsite)
                     RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     LET g_dead_m.deadsite = g_dead_m_t.deadsite 
                     DISPLAY BY NAME g_dead_m.deadsite
                     
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = l_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                  
                     NEXT FIELD CURRENT
                  ELSE
                     LET g_ins_site_flag = 'Y'
                  END IF
               END IF
            END IF
            
            LET g_dead_m.deadsite_desc = s_desc_get_department_desc(g_dead_m.deadsite)
            DISPLAY BY NAME g_dead_m.deadsite_desc
            
            CALL adet406_set_entry(p_cmd)
            CALL adet406_set_no_entry(p_cmd)            
            #161006-00008#10 161102 by lori add---(E)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deadsite
            #add-point:BEFORE FIELD deadsite name="input.b.deadsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deadsite
            #add-point:ON CHANGE deadsite name="input.g.deadsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaddocdt
            #add-point:BEFORE FIELD deaddocdt name="input.b.deaddocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaddocdt
            
            #add-point:AFTER FIELD deaddocdt name="input.a.deaddocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deaddocdt
            #add-point:ON CHANGE deaddocdt name="input.g.deaddocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deadstamp
            #add-point:BEFORE FIELD deadstamp name="input.b.deadstamp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deadstamp
            
            #add-point:AFTER FIELD deadstamp name="input.a.deadstamp"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deadstamp
            #add-point:ON CHANGE deadstamp name="input.g.deadstamp"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaddocno
            #add-point:BEFORE FIELD deaddocno name="input.b.deaddocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaddocno
            
            #add-point:AFTER FIELD deaddocno name="input.a.deaddocno"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_dead_m.deaddocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_dead_m.deaddocno != g_deaddocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM dead_t WHERE "||"deadent = '" ||g_enterprise|| "' AND "||"deaddocno = '"||g_dead_m.deaddocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_dead_m.deaddocno) THEN
               IF NOT s_aooi200_chk_slip(g_dead_m.deadsite,'',g_dead_m.deaddocno,g_prog) THEN
                  LET g_dead_m.deaddocno = g_dead_m_t.deaddocno
                  NEXT FIELD CURRENT
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deaddocno
            #add-point:ON CHANGE deaddocno name="input.g.deaddocno"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dead001
            
            #add-point:AFTER FIELD dead001 name="input.a.dead001"
            LET g_dead_m.dead001_desc = ""
            DISPLAY BY NAME g_dead_m.dead001_desc   
            IF NOT cl_null(g_dead_m.dead001) AND 
               (g_dead_m.dead001 != g_dead_m_t.dead001 OR cl_null(g_dead_m_t.dead001)) THEN              
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_dead_m.dead001
               LET g_chkparam.arg2 = g_dead_m.deadsite
               #呼叫檢查存在的library
               IF NOT cl_chk_exist("v_pcab001_1") THEN
                  LET g_dead_m.dead001 = g_dead_m_t.dead001
                  DISPLAY BY NAME g_dead_m.dead001 
                  CALL adet406_dead001_desc()
                  NEXT FIELD CURRENT
               END IF
               
               IF NOT adet406_chk_pcab() THEN
                  LET g_dead_m.dead001 = g_dead_m_t.dead001
                  DISPLAY BY NAME g_dead_m.dead001 
                  CALL adet406_dead001_desc()
                  NEXT FIELD CURRENT 
               END IF  

            END IF
            CALL adet406_dead001_desc()  
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dead001
            #add-point:BEFORE FIELD dead001 name="input.b.dead001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dead001
            #add-point:ON CHANGE dead001 name="input.g.dead001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deadstus
            #add-point:BEFORE FIELD deadstus name="input.b.deadstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deadstus
            
            #add-point:AFTER FIELD deadstus name="input.a.deadstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deadstus
            #add-point:ON CHANGE deadstus name="input.g.deadstus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.deadsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deadsite
            #add-point:ON ACTION controlp INFIELD deadsite name="input.c.deadsite"
            #161006-00008#10 161102 by lori add---(S)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_dead_m.deadsite
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'deadsite',g_dead_m.deadsite,'i')
            
            CALL q_ooef001_24()
            
            LET g_dead_m.deadsite = g_qryparam.return1            
            LET g_dead_m.deadsite_desc = s_desc_get_department_desc(g_dead_m.deadsite)
            DISPLAY g_dead_m.deadsite TO deadsite
            DISPLAY g_dead_m.deadsite_desc TO deadsite_desc
            
            NEXT FIELD deadsite                     
            #161006-00008#10 161102 by lori add---(E)
            #END add-point
 
 
         #Ctrlp:input.c.deaddocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaddocdt
            #add-point:ON ACTION controlp INFIELD deaddocdt name="input.c.deaddocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.deadstamp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deadstamp
            #add-point:ON ACTION controlp INFIELD deadstamp name="input.c.deadstamp"
            
            #END add-point
 
 
         #Ctrlp:input.c.deaddocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaddocno
            #add-point:ON ACTION controlp INFIELD deaddocno name="input.c.deaddocno"
                                    #此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_dead_m.deaddocno             #給予default值

            #給予arg
            CALL s_aooi100_sel_ooef004(g_dead_m.deadsite)
                 RETURNING l_success,l_ooef004
            LET g_qryparam.arg1 = l_ooef004 
            LET g_qryparam.arg2 = "adet406"   #160705-00042#1 160711 by sakura mark
            LET g_qryparam.arg2 = g_prog      #160705-00042#1 160711 by sakura add

            CALL q_ooba002_1()                                #呼叫開窗

            LET g_dead_m.deaddocno = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_dead_m.deaddocno TO deaddocno              #顯示到畫面上

            NEXT FIELD deaddocno                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.dead001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dead001
            #add-point:ON ACTION controlp INFIELD dead001 name="input.c.dead001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_dead_m.dead001        #給予default值
            LET g_qryparam.arg1 = g_dead_m.deadsite 
            LET g_qryparam.arg2 = ''
            LET g_qryparam.where = " pcab006 = '1'"           #160509-00004#99 add lujh
            CALL q_pcab001_1()                                #呼叫開窗
            LET g_dead_m.dead001 = g_qryparam.return1         #將開窗取得的值回傳到變數
            LET g_dead_m.dead001_desc = g_qryparam.return2
            DISPLAY g_dead_m.dead001 TO dead001               #顯示到畫面上
            DISPLAY g_dead_m.dead001_desc TO dead001_desc
            NEXT FIELD dead001                                #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.deadstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deadstus
            #add-point:ON ACTION controlp INFIELD deadstus name="input.c.deadstus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_dead_m.deaddocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               CALL s_aooi200_gen_docno(g_dead_m.deadsite,g_dead_m.deaddocno,g_dead_m.deaddocdt,g_prog) RETURNING l_success,g_dead_m.deaddocno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_dead_m.deaddocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD deaddocno
               END IF   

               DISPLAY BY NAME g_dead_m.deaddocno
               #end add-point
               
               INSERT INTO dead_t (deadent,deadsite,deaddocdt,deadstamp,deaddocno,dead001,deadstus,deadownid, 
                   deadowndp,deadcrtid,deadcrtdp,deadcrtdt,deadmodid,deadmoddt)
               VALUES (g_enterprise,g_dead_m.deadsite,g_dead_m.deaddocdt,g_dead_m.deadstamp,g_dead_m.deaddocno, 
                   g_dead_m.dead001,g_dead_m.deadstus,g_dead_m.deadownid,g_dead_m.deadowndp,g_dead_m.deadcrtid, 
                   g_dead_m.deadcrtdp,g_dead_m.deadcrtdt,g_dead_m.deadmodid,g_dead_m.deadmoddt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_dead_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
               CALL adet406_ins_deae() RETURNING l_success
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  NEXT FIELD CURRENT
               END IF
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL adet406_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL adet406_b_fill()
                  CALL adet406_b_fill2('0')
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
               CALL adet406_dead_t_mask_restore('restore_mask_o')
               
               UPDATE dead_t SET (deadsite,deaddocdt,deadstamp,deaddocno,dead001,deadstus,deadownid, 
                   deadowndp,deadcrtid,deadcrtdp,deadcrtdt,deadmodid,deadmoddt) = (g_dead_m.deadsite, 
                   g_dead_m.deaddocdt,g_dead_m.deadstamp,g_dead_m.deaddocno,g_dead_m.dead001,g_dead_m.deadstus, 
                   g_dead_m.deadownid,g_dead_m.deadowndp,g_dead_m.deadcrtid,g_dead_m.deadcrtdp,g_dead_m.deadcrtdt, 
                   g_dead_m.deadmodid,g_dead_m.deadmoddt)
                WHERE deadent = g_enterprise AND deaddocno = g_deaddocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "dead_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL adet406_dead_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_dead_m_t)
               LET g_log2 = util.JSON.stringify(g_dead_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_deaddocno_t = g_dead_m.deaddocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="adet406.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_deae_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = FALSE, 
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            #160816-00007#1--add--str--lujh
            CALL adet406_b_fill()
            EXIT DIALOG
            #160816-00007#1--add--end--lujh
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_deae_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL adet406_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_deae_d.getLength()
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
            OPEN adet406_cl USING g_enterprise,g_dead_m.deaddocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN adet406_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE adet406_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_deae_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_deae_d[l_ac].deae001 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_deae_d_t.* = g_deae_d[l_ac].*  #BACKUP
               LET g_deae_d_o.* = g_deae_d[l_ac].*  #BACKUP
               CALL adet406_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL adet406_set_no_entry_b(l_cmd)
               IF NOT adet406_lock_b("deae_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH adet406_bcl INTO g_deae_d[l_ac].deae002,g_deae_d[l_ac].deae001,g_deae_d[l_ac].deae003, 
                      g_deae_d[l_ac].deae004,g_deae_d[l_ac].deae005,g_deae_d[l_ac].deae006,g_deae_d[l_ac].deae007, 
                      g_deae_d[l_ac].deaesite
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_deae_d_t.deae001,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_deae_d_mask_o[l_ac].* =  g_deae_d[l_ac].*
                  CALL adet406_deae_t_mask()
                  LET g_deae_d_mask_n[l_ac].* =  g_deae_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL adet406_show()
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
            INITIALIZE g_deae_d[l_ac].* TO NULL 
            INITIALIZE g_deae_d_t.* TO NULL 
            INITIALIZE g_deae_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_deae_d[l_ac].deae003 = "0"
      LET g_deae_d[l_ac].deae004 = "0"
      LET g_deae_d[l_ac].deae005 = "0"
      LET g_deae_d[l_ac].deae006 = "0"
      LET g_deae_d[l_ac].deae007 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_deae_d_t.* = g_deae_d[l_ac].*     #新輸入資料
            LET g_deae_d_o.* = g_deae_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL adet406_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL adet406_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_deae_d[li_reproduce_target].* = g_deae_d[li_reproduce].*
 
               LET g_deae_d[li_reproduce_target].deae001 = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            
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
            SELECT COUNT(1) INTO l_count FROM deae_t 
             WHERE deaeent = g_enterprise AND deaedocno = g_dead_m.deaddocno
 
               AND deae001 = g_deae_d[l_ac].deae001
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_dead_m.deaddocno
               LET gs_keys[2] = g_deae_d[g_detail_idx].deae001
               CALL adet406_insert_b('deae_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_deae_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "deae_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL adet406_b_fill()
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
               LET gs_keys[01] = g_dead_m.deaddocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_deae_d_t.deae001
 
            
               #刪除同層單身
               IF NOT adet406_delete_b('deae_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE adet406_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT adet406_key_delete_b(gs_keys,'deae_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE adet406_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE adet406_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_deae_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_deae_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deae002
            #add-point:BEFORE FIELD deae002 name="input.b.page1.deae002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deae002
            
            #add-point:AFTER FIELD deae002 name="input.a.page1.deae002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deae002
            #add-point:ON CHANGE deae002 name="input.g.page1.deae002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deae001
            
            #add-point:AFTER FIELD deae001 name="input.a.page1.deae001"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_dead_m.deaddocno IS NOT NULL AND g_deae_d[l_ac].deae001 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_dead_m.deaddocno != g_deaddocno_t OR g_deae_d[l_ac].deae001 != g_deae_d_t.deae001)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM deae_t WHERE "||"deaeent = '" ||g_enterprise|| "' AND "||"deaedocno = '"||g_dead_m.deaddocno ||"' AND "|| "deae001 = '"||g_deae_d[g_detail_idx].deae001 ||"'",'std-00004',0) THEN 
                     LET g_deae_d[l_ac].deae001 = g_deae_d_t.deae001
                     CALL s_desc_get_ooial_desc(g_deae_d[l_ac].deae001) RETURNING g_deae_d[l_ac].deae001_desc
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_money_chk('1',g_dead_m.deadsite,g_deae_d[l_ac].deae001)
                   RETURNING l_success,g_errno,l_no,l_ooia002
                  IF NOT l_success THEN
                     #檢查失敗時後續處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = g_errno
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()                  
                     LET g_deae_d[l_ac].deae001 = g_deae_d_t.deae001
                     CALL s_desc_get_ooial_desc(g_deae_d[l_ac].deae001) RETURNING g_deae_d[l_ac].deae001_desc
                     NEXT FIELD CURRENT
                  END IF 
                  IF NOT cl_null(g_deae_d[l_ac].deae002) THEN
                     IF g_deae_d[l_ac].deae002 <> l_ooia002 THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = ""
                        LET g_errparam.code   = 'ade-00068'
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()                  
                        LET g_deae_d[l_ac].deae001 = g_deae_d_t.deae001
                        CALL s_desc_get_ooial_desc(g_deae_d[l_ac].deae001) RETURNING g_deae_d[l_ac].deae001_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF                
               END IF
            END IF                   
            CALL s_desc_get_ooial_desc(g_deae_d[l_ac].deae001) RETURNING g_deae_d[l_ac].deae001_desc   
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deae001
            #add-point:BEFORE FIELD deae001 name="input.b.page1.deae001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deae001
            #add-point:ON CHANGE deae001 name="input.g.page1.deae001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deae003
            #add-point:BEFORE FIELD deae003 name="input.b.page1.deae003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deae003
            
            #add-point:AFTER FIELD deae003 name="input.a.page1.deae003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deae003
            #add-point:ON CHANGE deae003 name="input.g.page1.deae003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deae004
            #add-point:BEFORE FIELD deae004 name="input.b.page1.deae004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deae004
            
            #add-point:AFTER FIELD deae004 name="input.a.page1.deae004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deae004
            #add-point:ON CHANGE deae004 name="input.g.page1.deae004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deae005
            #add-point:BEFORE FIELD deae005 name="input.b.page1.deae005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deae005
            
            #add-point:AFTER FIELD deae005 name="input.a.page1.deae005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deae005
            #add-point:ON CHANGE deae005 name="input.g.page1.deae005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deae006
            #add-point:BEFORE FIELD deae006 name="input.b.page1.deae006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deae006
            
            #add-point:AFTER FIELD deae006 name="input.a.page1.deae006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deae006
            #add-point:ON CHANGE deae006 name="input.g.page1.deae006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deae007
            #add-point:BEFORE FIELD deae007 name="input.b.page1.deae007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deae007
            
            #add-point:AFTER FIELD deae007 name="input.a.page1.deae007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deae007
            #add-point:ON CHANGE deae007 name="input.g.page1.deae007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaesite
            #add-point:BEFORE FIELD deaesite name="input.b.page1.deaesite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaesite
            
            #add-point:AFTER FIELD deaesite name="input.a.page1.deaesite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deaesite
            #add-point:ON CHANGE deaesite name="input.g.page1.deaesite"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.deae002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deae002
            #add-point:ON ACTION controlp INFIELD deae002 name="input.c.page1.deae002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.deae001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deae001
            #add-point:ON ACTION controlp INFIELD deae001 name="input.c.page1.deae001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_deae_d[l_ac].deae001 
            CALL s_money_where(g_dead_m.deadsite) RETURNING l_str
            IF NOT cl_null(g_deae_d[l_ac].deae002) THEN
               LET g_qryparam.where = l_str," AND ooia002 = '",g_deae_d[l_ac].deae002,"' "
            ELSE
               LET g_qryparam.where = l_str
            END IF
            IF g_deae_d[l_ac].deae002 = '40' THEN
               CALL q_ooia001_1()                            
            ELSE
               IF g_deae_d[l_ac].deae001 = '60' THEN
                  CALL q_ooia001_2()                          
               ELSE
                  CALL q_ooia001_5()                           
               END IF
            END IF
            LET g_deae_d[l_ac].deae001 = g_qryparam.return1
            CALL s_desc_get_ooial_desc(g_deae_d[l_ac].deae001) RETURNING g_deae_d[l_ac].deae001_desc
            NEXT FIELD deae001                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.deae003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deae003
            #add-point:ON ACTION controlp INFIELD deae003 name="input.c.page1.deae003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.deae004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deae004
            #add-point:ON ACTION controlp INFIELD deae004 name="input.c.page1.deae004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.deae005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deae005
            #add-point:ON ACTION controlp INFIELD deae005 name="input.c.page1.deae005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.deae006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deae006
            #add-point:ON ACTION controlp INFIELD deae006 name="input.c.page1.deae006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.deae007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deae007
            #add-point:ON ACTION controlp INFIELD deae007 name="input.c.page1.deae007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.deaesite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaesite
            #add-point:ON ACTION controlp INFIELD deaesite name="input.c.page1.deaesite"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_deae_d[l_ac].* = g_deae_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE adet406_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_deae_d[l_ac].deae001 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_deae_d[l_ac].* = g_deae_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL adet406_deae_t_mask_restore('restore_mask_o')
      
               UPDATE deae_t SET (deaedocno,deae002,deae001,deae003,deae004,deae005,deae006,deae007, 
                   deaesite) = (g_dead_m.deaddocno,g_deae_d[l_ac].deae002,g_deae_d[l_ac].deae001,g_deae_d[l_ac].deae003, 
                   g_deae_d[l_ac].deae004,g_deae_d[l_ac].deae005,g_deae_d[l_ac].deae006,g_deae_d[l_ac].deae007, 
                   g_deae_d[l_ac].deaesite)
                WHERE deaeent = g_enterprise AND deaedocno = g_dead_m.deaddocno 
 
                  AND deae001 = g_deae_d_t.deae001 #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_deae_d[l_ac].* = g_deae_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "deae_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_deae_d[l_ac].* = g_deae_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "deae_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_dead_m.deaddocno
               LET gs_keys_bak[1] = g_deaddocno_t
               LET gs_keys[2] = g_deae_d[g_detail_idx].deae001
               LET gs_keys_bak[2] = g_deae_d_t.deae001
               CALL adet406_update_b('deae_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL adet406_deae_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_deae_d[g_detail_idx].deae001 = g_deae_d_t.deae001 
 
                  ) THEN
                  LET gs_keys[01] = g_dead_m.deaddocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_deae_d_t.deae001
 
                  CALL adet406_key_update_b(gs_keys,'deae_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_dead_m),util.JSON.stringify(g_deae_d_t)
               LET g_log2 = util.JSON.stringify(g_dead_m),util.JSON.stringify(g_deae_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL adet406_unlock_b("deae_t","'1'")
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
               LET g_deae_d[li_reproduce_target].* = g_deae_d[li_reproduce].*
 
               LET g_deae_d[li_reproduce_target].deae001 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_deae_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_deae_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="adet406.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            NEXT FIELD deadsite   #161006-00008#10 161102 by lori add 
            #end add-point  
            NEXT FIELD deaddocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD deae002
 
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
   CALL adet406_show()
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="adet406.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION adet406_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   CALL adet406_visible()      #160816-00007#1 add lujh
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL adet406_b_fill() #單身填充
      CALL adet406_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL adet406_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   
   #end add-point
   
   #遮罩相關處理
   LET g_dead_m_mask_o.* =  g_dead_m.*
   CALL adet406_dead_t_mask()
   LET g_dead_m_mask_n.* =  g_dead_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_dead_m.deadsite,g_dead_m.deadsite_desc,g_dead_m.deaddocdt,g_dead_m.deadstamp,g_dead_m.deaddocno, 
       g_dead_m.dead001,g_dead_m.dead001_desc,g_dead_m.deadstus,g_dead_m.deadownid,g_dead_m.deadownid_desc, 
       g_dead_m.deadowndp,g_dead_m.deadowndp_desc,g_dead_m.deadcrtid,g_dead_m.deadcrtid_desc,g_dead_m.deadcrtdp, 
       g_dead_m.deadcrtdp_desc,g_dead_m.deadcrtdt,g_dead_m.deadmodid,g_dead_m.deadmodid_desc,g_dead_m.deadmoddt 
 
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_dead_m.deadstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_deae_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL adet406_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="adet406.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION adet406_detail_show()
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
 
{<section id="adet406.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION adet406_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE dead_t.deaddocno 
   DEFINE l_oldno     LIKE dead_t.deaddocno 
 
   DEFINE l_master    RECORD LIKE dead_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE deae_t.* #此變數樣板目前無使用
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   DEFINE l_insert        LIKE type_t.num5   #161006-00008#10 161102 by lori add 
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   
   LET g_master_insert = FALSE
   
   IF g_dead_m.deaddocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_deaddocno_t = g_dead_m.deaddocno
 
    
   LET g_dead_m.deaddocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_dead_m.deadownid = g_user
      LET g_dead_m.deadowndp = g_dept
      LET g_dead_m.deadcrtid = g_user
      LET g_dead_m.deadcrtdp = g_dept 
      LET g_dead_m.deadcrtdt = cl_get_current()
      LET g_dead_m.deadmodid = g_user
      LET g_dead_m.deadmoddt = cl_get_current()
      LET g_dead_m.deadstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   #161006-00008#10 161102 by lori add---(S)   
   LET g_ins_site_flag = ''
   
   CALL s_aooi500_default(g_prog,'deadsite',g_dead_m.deadsite)
      RETURNING l_insert,g_dead_m.deadsite
   IF NOT l_insert THEN
      RETURN
   END IF
   CALL s_desc_get_department_desc(g_dead_m.deadsite) RETURNING g_dead_m.deadsite_desc
   DISPLAY BY NAME g_dead_m.deadsite_desc 
   #161006-00008#10 161102 by lori add---(E)
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_dead_m.deadstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
   
   
   CALL adet406_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_dead_m.* TO NULL
      INITIALIZE g_deae_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL adet406_show()
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
   CALL adet406_set_act_visible()   
   CALL adet406_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_deaddocno_t = g_dead_m.deaddocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " deadent = " ||g_enterprise|| " AND",
                      " deaddocno = '", g_dead_m.deaddocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL adet406_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL adet406_idx_chk()
   
   LET g_data_owner = g_dead_m.deadownid      
   LET g_data_dept  = g_dead_m.deadowndp
   
   #功能已完成,通報訊息中心
   CALL adet406_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="adet406.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION adet406_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE deae_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE adet406_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM deae_t
    WHERE deaeent = g_enterprise AND deaedocno = g_deaddocno_t
 
    INTO TEMP adet406_detail
 
   #將key修正為調整後   
   UPDATE adet406_detail 
      #更新key欄位
      SET deaedocno = g_dead_m.deaddocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO deae_t SELECT * FROM adet406_detail
   
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
   DROP TABLE adet406_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_deaddocno_t = g_dead_m.deaddocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="adet406.delete" >}
#+ 資料刪除
PRIVATE FUNCTION adet406_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_dead_m.deaddocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN adet406_cl USING g_enterprise,g_dead_m.deaddocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN adet406_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE adet406_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE adet406_master_referesh USING g_dead_m.deaddocno INTO g_dead_m.deadsite,g_dead_m.deaddocdt, 
       g_dead_m.deadstamp,g_dead_m.deaddocno,g_dead_m.dead001,g_dead_m.deadstus,g_dead_m.deadownid,g_dead_m.deadowndp, 
       g_dead_m.deadcrtid,g_dead_m.deadcrtdp,g_dead_m.deadcrtdt,g_dead_m.deadmodid,g_dead_m.deadmoddt, 
       g_dead_m.deadsite_desc,g_dead_m.dead001_desc,g_dead_m.deadownid_desc,g_dead_m.deadowndp_desc, 
       g_dead_m.deadcrtid_desc,g_dead_m.deadcrtdp_desc,g_dead_m.deadmodid_desc
   
   
   #檢查是否允許此動作
   IF NOT adet406_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_dead_m_mask_o.* =  g_dead_m.*
   CALL adet406_dead_t_mask()
   LET g_dead_m_mask_n.* =  g_dead_m.*
   
   CALL adet406_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   IF NOT s_aooi200_del_docno(g_dead_m.deaddocno,g_dead_m.deaddocdt) THEN
      CALL s_transaction_end('N','0')
      CLOSE adet406_cl
      RETURN
   END IF
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL adet406_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_deaddocno_t = g_dead_m.deaddocno
 
 
      DELETE FROM dead_t
       WHERE deadent = g_enterprise AND deaddocno = g_dead_m.deaddocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_dead_m.deaddocno,":",SQLERRMESSAGE  
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
      
      DELETE FROM deae_t
       WHERE deaeent = g_enterprise AND deaedocno = g_dead_m.deaddocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "deae_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_dead_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE adet406_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_deae_d.clear() 
 
     
      CALL adet406_ui_browser_refresh()  
      #CALL adet406_ui_headershow()  
      #CALL adet406_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL adet406_browser_fill("")
         CALL adet406_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE adet406_cl
 
   #功能已完成,通報訊息中心
   CALL adet406_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="adet406.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION adet406_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_deae_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF adet406_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT deae002,deae001,deae003,deae004,deae005,deae006,deae007,deaesite , 
             t1.ooial003 FROM deae_t",   
                     " INNER JOIN dead_t ON deadent = " ||g_enterprise|| " AND deaddocno = deaedocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN ooial_t t1 ON t1.ooialent="||g_enterprise||" AND t1.ooial001=deae001 AND t1.ooial002='"||g_dlang||"' ",
 
                     " WHERE deaeent=? AND deaedocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY deae_t.deae001"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE adet406_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR adet406_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_dead_m.deaddocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_dead_m.deaddocno INTO g_deae_d[l_ac].deae002,g_deae_d[l_ac].deae001, 
          g_deae_d[l_ac].deae003,g_deae_d[l_ac].deae004,g_deae_d[l_ac].deae005,g_deae_d[l_ac].deae006, 
          g_deae_d[l_ac].deae007,g_deae_d[l_ac].deaesite,g_deae_d[l_ac].deae001_desc   #(ver:78)
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
   
   CALL g_deae_d.deleteElement(g_deae_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE adet406_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_deae_d.getLength()
      LET g_deae_d_mask_o[l_ac].* =  g_deae_d[l_ac].*
      CALL adet406_deae_t_mask()
      LET g_deae_d_mask_n[l_ac].* =  g_deae_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="adet406.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION adet406_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM deae_t
       WHERE deaeent = g_enterprise AND
         deaedocno = ps_keys_bak[1] AND deae001 = ps_keys_bak[2]
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
         CALL g_deae_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="adet406.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION adet406_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO deae_t
                  (deaeent,
                   deaedocno,
                   deae001
                   ,deae002,deae003,deae004,deae005,deae006,deae007,deaesite) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_deae_d[g_detail_idx].deae002,g_deae_d[g_detail_idx].deae003,g_deae_d[g_detail_idx].deae004, 
                       g_deae_d[g_detail_idx].deae005,g_deae_d[g_detail_idx].deae006,g_deae_d[g_detail_idx].deae007, 
                       g_deae_d[g_detail_idx].deaesite)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "deae_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_deae_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="adet406.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION adet406_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "deae_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL adet406_deae_t_mask_restore('restore_mask_o')
               
      UPDATE deae_t 
         SET (deaedocno,
              deae001
              ,deae002,deae003,deae004,deae005,deae006,deae007,deaesite) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_deae_d[g_detail_idx].deae002,g_deae_d[g_detail_idx].deae003,g_deae_d[g_detail_idx].deae004, 
                  g_deae_d[g_detail_idx].deae005,g_deae_d[g_detail_idx].deae006,g_deae_d[g_detail_idx].deae007, 
                  g_deae_d[g_detail_idx].deaesite) 
         WHERE deaeent = g_enterprise AND deaedocno = ps_keys_bak[1] AND deae001 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "deae_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "deae_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL adet406_deae_t_mask_restore('restore_mask_n')
               
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
 
{<section id="adet406.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION adet406_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="adet406.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION adet406_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="adet406.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION adet406_lock_b(ps_table,ps_page)
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
   #CALL adet406_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "deae_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN adet406_bcl USING g_enterprise,
                                       g_dead_m.deaddocno,g_deae_d[g_detail_idx].deae001     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "adet406_bcl:",SQLERRMESSAGE 
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
 
{<section id="adet406.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION adet406_unlock_b(ps_table,ps_page)
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
      CLOSE adet406_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="adet406.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION adet406_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("deaddocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("deaddocno",TRUE)
      CALL cl_set_comp_entry("deaddocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("deadsite",TRUE)   #161006-00008#10 161102 by lori add
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="adet406.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION adet406_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("deaddocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("deaddocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("deaddocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   #161006-00008#10 161102 by lori add---(S)
   IF (NOT s_aooi500_comp_entry(g_prog,'deadsite') OR g_ins_site_flag = 'Y') THEN
      CALL cl_set_comp_entry("deadsite",FALSE)
   END IF
   #161006-00008#10 161102 by lori add---(E)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="adet406.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION adet406_set_entry_b(p_cmd)
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
 
{<section id="adet406.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION adet406_set_no_entry_b(p_cmd)
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
   IF p_cmd = 'u' THEN
      CALL cl_set_comp_entry("deae001,deae002",FALSE)  
   END IF
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="adet406.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION adet406_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="adet406.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION adet406_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:2)
   IF g_dead_m.deadstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF



   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="adet406.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION adet406_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="adet406.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION adet406_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="adet406.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION adet406_default_search()
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
      LET ls_wc = ls_wc, " deaddocno = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "dead_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "deae_t" 
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
 
{<section id="adet406.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION adet406_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_n      LIKE type_t.num5
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_dead_m.deaddocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN adet406_cl USING g_enterprise,g_dead_m.deaddocno
   IF STATUS THEN
      CLOSE adet406_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN adet406_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE adet406_master_referesh USING g_dead_m.deaddocno INTO g_dead_m.deadsite,g_dead_m.deaddocdt, 
       g_dead_m.deadstamp,g_dead_m.deaddocno,g_dead_m.dead001,g_dead_m.deadstus,g_dead_m.deadownid,g_dead_m.deadowndp, 
       g_dead_m.deadcrtid,g_dead_m.deadcrtdp,g_dead_m.deadcrtdt,g_dead_m.deadmodid,g_dead_m.deadmoddt, 
       g_dead_m.deadsite_desc,g_dead_m.dead001_desc,g_dead_m.deadownid_desc,g_dead_m.deadowndp_desc, 
       g_dead_m.deadcrtid_desc,g_dead_m.deadcrtdp_desc,g_dead_m.deadmodid_desc
   
 
   #檢查是否允許此動作
   IF NOT adet406_action_chk() THEN
      CLOSE adet406_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_dead_m.deadsite,g_dead_m.deadsite_desc,g_dead_m.deaddocdt,g_dead_m.deadstamp,g_dead_m.deaddocno, 
       g_dead_m.dead001,g_dead_m.dead001_desc,g_dead_m.deadstus,g_dead_m.deadownid,g_dead_m.deadownid_desc, 
       g_dead_m.deadowndp,g_dead_m.deadowndp_desc,g_dead_m.deadcrtid,g_dead_m.deadcrtid_desc,g_dead_m.deadcrtdp, 
       g_dead_m.deadcrtdp_desc,g_dead_m.deadcrtdt,g_dead_m.deadmodid,g_dead_m.deadmodid_desc,g_dead_m.deadmoddt 
 
 
   CASE g_dead_m.deadstus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
  
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_dead_m.deadstus
            
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "X"
               HIDE OPTION "invalid"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
      CASE g_dead_m.deadstus
         WHEN "X"
            CALL cl_set_act_visible("unconfirmed,confirmed,invalid",FALSE)
            CLOSE adet406_cl
            CALL s_transaction_end('N','0')
            RETURN
         WHEN "Y"
            IF g_ooaa002 = 'Y' THEN   #160816-00007#1 add lujh
               CALL cl_set_act_visible("unconfirmed,confirmed,invalid",FALSE)
               CLOSE adet406_cl
               CALL s_transaction_end('N','0')
               RETURN
            #160816-00007#1--add--str--lujh
            ELSE
               CALL cl_set_act_visible("confirmed,invalid",FALSE)
            END IF
            #160816-00007#1--add--end--lujh
         WHEN "N"
            CALL cl_set_act_visible("unconfirmed",FALSE)
      END CASE
      #end add-point
      
      
	  
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
            UPDATE deat_t SET deat010 = 'N'
             WHERE deatent = g_enterprise
               AND deatsite = g_dead_m.deadsite
               AND deat001 = g_dead_m.deaddocdt
               AND deat002 = g_dead_m.dead001
             
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'upd deat'
               LET g_errparam.popup = TRUE
               CLOSE adet406_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            #end add-point
         END IF
         EXIT MENU
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.confirmed"
            SELECT COUNT(*) INTO l_n
              FROM deae_t
             WHERE deaeent = g_enterprise
               AND deaedocno = g_dead_m.deaddocno
               
            IF l_n = 0 THEN 
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "" 
               LET g_errparam.code   = "ade-00007" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CLOSE adet406_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            
            IF g_ooaa002 = 'Y' THEN 
               UPDATE rtjf_t SET rtjf108 = 'Y'
                WHERE rtjfent = g_enterprise
                  AND rtjf030 = g_dead_m.dead001
                  AND rtjf025 = g_dead_m.deaddocdt
                  AND rtjfsite = g_dead_m.deadsite
                  
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = 'upd rtjf'
                  LET g_errparam.popup = TRUE
                  CLOSE adet406_cl
                  CALL s_transaction_end('N','0')
                  RETURN
               END IF
            ELSE
               UPDATE deat_t SET deat010 = 'Y'
                WHERE deatent = g_enterprise
                  AND deatsite = g_dead_m.deadsite
                  AND deat001 = g_dead_m.deaddocdt
                  AND deat002 = g_dead_m.dead001

               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = 'upd deat'
                  LET g_errparam.popup = TRUE
                  CLOSE adet406_cl
                  CALL s_transaction_end('N','0')
                  RETURN
               END IF
            END IF
            #end add-point
         END IF
         EXIT MENU
      ON ACTION invalid
         IF cl_auth_chk_act("invalid") THEN
            LET lc_state = "X"
            #add-point:action控制 name="statechange.invalid"
            
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
      g_dead_m.deadstus = lc_state OR cl_null(lc_state) THEN
      CLOSE adet406_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   
   #end add-point
   
   LET g_dead_m.deadmodid = g_user
   LET g_dead_m.deadmoddt = cl_get_current()
   LET g_dead_m.deadstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE dead_t 
      SET (deadstus,deadmodid,deadmoddt) 
        = (g_dead_m.deadstus,g_dead_m.deadmodid,g_dead_m.deadmoddt)     
    WHERE deadent = g_enterprise AND deaddocno = g_dead_m.deaddocno
 
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE adet406_master_referesh USING g_dead_m.deaddocno INTO g_dead_m.deadsite,g_dead_m.deaddocdt, 
          g_dead_m.deadstamp,g_dead_m.deaddocno,g_dead_m.dead001,g_dead_m.deadstus,g_dead_m.deadownid, 
          g_dead_m.deadowndp,g_dead_m.deadcrtid,g_dead_m.deadcrtdp,g_dead_m.deadcrtdt,g_dead_m.deadmodid, 
          g_dead_m.deadmoddt,g_dead_m.deadsite_desc,g_dead_m.dead001_desc,g_dead_m.deadownid_desc,g_dead_m.deadowndp_desc, 
          g_dead_m.deadcrtid_desc,g_dead_m.deadcrtdp_desc,g_dead_m.deadmodid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_dead_m.deadsite,g_dead_m.deadsite_desc,g_dead_m.deaddocdt,g_dead_m.deadstamp, 
          g_dead_m.deaddocno,g_dead_m.dead001,g_dead_m.dead001_desc,g_dead_m.deadstus,g_dead_m.deadownid, 
          g_dead_m.deadownid_desc,g_dead_m.deadowndp,g_dead_m.deadowndp_desc,g_dead_m.deadcrtid,g_dead_m.deadcrtid_desc, 
          g_dead_m.deadcrtdp,g_dead_m.deadcrtdp_desc,g_dead_m.deadcrtdt,g_dead_m.deadmodid,g_dead_m.deadmodid_desc, 
          g_dead_m.deadmoddt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE adet406_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL adet406_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="adet406.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION adet406_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_deae_d.getLength() THEN
         LET g_detail_idx = g_deae_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_deae_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_deae_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="adet406.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION adet406_b_fill2(pi_idx)
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
   
   CALL adet406_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="adet406.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION adet406_fill_chk(ps_idx)
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
 
{<section id="adet406.status_show" >}
PRIVATE FUNCTION adet406_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="adet406.mask_functions" >}
&include "erp/ade/adet406_mask.4gl"
 
{</section>}
 
{<section id="adet406.signature" >}
   
 
{</section>}
 
{<section id="adet406.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION adet406_set_pk_array()
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
   LET g_pk_array[1].values = g_dead_m.deaddocno
   LET g_pk_array[1].column = 'deaddocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="adet406.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="adet406.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION adet406_msgcentre_notify(lc_state)
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
   CALL adet406_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_dead_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="adet406.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION adet406_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#7 -s by 08172
   SELECT deadstus  INTO g_dead_m.deadstus
     FROM dead_t
    WHERE deadent = g_enterprise
      AND deaddocno = g_dead_m.deaddocno
   LET g_errno = NULL
   IF (g_action_choice="modify" OR g_action_choice="modify_detail" OR g_action_choice="delete")  THEN
     CASE g_dead_m.deadstus
        WHEN 'W'
           LET g_errno = 'sub-00180'
        WHEN 'X'
           LET g_errno = 'sub-00229'
        WHEN 'Y'
           LET g_errno = 'sub-00178'
        WHEN 'S'
           LET g_errno = 'sub-00230'
     END CASE

     IF NOT cl_null(g_errno) THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = g_errno
        LET g_errparam.extend = g_dead_m.deaddocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL adet406_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#7 -e by 08172
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="adet406.other_function" readonly="Y" >}
# 收银员名称
PRIVATE FUNCTION adet406_dead001_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_dead_m.dead001
   CALL ap_ref_array2(g_ref_fields,"SELECT pcab003 FROM pcab_t WHERE pcabent='"||g_enterprise||"' AND pcab001=? ","") RETURNING g_rtn_fields
   LET g_dead_m.dead001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_dead_m.dead001_desc  
END FUNCTION
# 收银员检查
PRIVATE FUNCTION adet406_chk_pcab()
   DEFINE l_cnt       LIKE type_t.num5
   DEFINE r_success   LIKE type_t.num5
   
   LET r_success = TRUE
   
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM pcab_t,pcac_t
    WHERE pcabent = pcacent AND pcab001 = pcac001
      AND pcabent = g_enterprise
      AND pcab001 = g_dead_m.dead001
      AND pcac002 = g_dead_m.deadsite
      AND pcacstus = 'Y'
   IF l_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ade-00026'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE      
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION
# 整批产生单身
PRIVATE FUNCTION adet406_ins_deae()
   DEFINE l_sql            STRING
   DEFINE l_rtjf001        LIKE rtjf_t.rtjf001
   DEFINE l_rtjf002        LIKE rtjf_t.rtjf002
   DEFINE l_rtjf003        LIKE rtjf_t.rtjf003
   #160816-00007#1--add--str--lujh
   DEFINE l_deae002        LIKE deae_t.deae002
   DEFINE l_tmp            RECORD 
                           deat003        LIKE deat_t.deat003,
                           deat006        LIKE deat_t.deat006,
                           deat007        LIKE deat_t.deat007,
                           deat008        LIKE deat_t.deat008,
                           deat009        LIKE deat_t.deat009
                           END RECORD
   #160816-00007#1--add--end--lujh
   DEFINE l_n              LIKE type_t.num5
   DEFINE l_count_sql      STRING
   DEFINE r_success        LIKE type_t.num5
   
   LET r_success = TRUE
   
   IF g_ooaa002 = 'Y' THEN   #160816-00007#1 add lujh
      LET l_n = 0
      SELECT COUNT(*) INTO l_n
        FROM dead_t
       WHERE deadent = g_enterprise
         AND dead001 = g_dead_m.dead001
         AND deaddocno <> g_dead_m.deaddocno
         AND deadstus = 'N'
      
      IF l_n > 0 THEN 
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = "ade-00174" 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      LET l_sql = "SELECT rtjf001,rtjf002,SUM(rtjf031) ",
                  "  FROM rtjf_t ",
                  " WHERE rtjfent = ",g_enterprise,
                  "   AND rtjf030 = '",g_dead_m.dead001,"'",
                  "   AND rtjfsite = '",g_dead_m.deadsite,"'",
                  "   AND rtjf025 = '",g_dead_m.deaddocdt,"'",
                  "   AND (rtjf108 IS NULL OR rtjf108 = 'N')",
                  " GROUP BY rtjf001,rtjf002 "
      PREPARE adet406_rtjf_pre FROM l_sql
      DECLARE adet406_rtjf_cs CURSOR FOR adet406_rtjf_pre
      
      LET l_count_sql = "SELECT COUNT(*) FROM (",l_sql,")"
      
      LET l_n = 0
      PREPARE b_fill_cnt_pre FROM l_count_sql
      EXECUTE b_fill_cnt_pre INTO l_n
      FREE b_fill_cnt_pre
      
      IF l_n = 0 THEN 
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = "axc-00530" 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      FOREACH adet406_rtjf_cs INTO l_rtjf001,l_rtjf002,l_rtjf003
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         INSERT INTO deae_t(deaeent,deaesite,deaedocno,deae001,deae002,deae003) 
         VALUES(g_enterprise,g_dead_m.deadsite,g_dead_m.deaddocno,l_rtjf002,l_rtjf001,l_rtjf003)
         
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'ins'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            LET r_success = FALSE
         END IF   
      END FOREACH 
   #160816-00007#1--add--str--lujh
   ELSE
      LET l_n = 0
      SELECT COUNT(*) INTO l_n
        FROM dead_t
       WHERE deadent = g_enterprise
         AND dead001 = g_dead_m.dead001
         AND deaddocno <> g_dead_m.deaddocno
         AND deadstus <> 'X'
      
      IF l_n > 0 THEN 
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = "ade-00176" 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      LET l_sql = "SELECT deat003,SUM(deat006),SUM(deat007),SUM(deat008),SUM(deat009)",
                  "  FROM deat_t ",
                  " WHERE deatent = ",g_enterprise,
                  "   AND deat010 = 'N' ",
                  "   AND deatsite = '",g_dead_m.deadsite,"'",
                  "   AND deat001 = '",g_dead_m.deaddocdt,"'",
                  "   AND deat002 = '",g_dead_m.dead001,"'",               
                  " GROUP BY deat003 "
      PREPARE adet406_deat_pre FROM l_sql
      DECLARE adet406_deat_cs CURSOR FOR adet406_deat_pre
      
      LET l_count_sql = "SELECT COUNT(*) FROM (",l_sql,")"
      
      LET l_n = 0
      PREPARE b_fill_cnt_pre1 FROM l_count_sql
      EXECUTE b_fill_cnt_pre1 INTO l_n
      FREE b_fill_cnt_pre1
      
      IF l_n = 0 THEN 
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = "axc-00530" 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      FOREACH adet406_deat_cs INTO l_tmp.deat003,l_tmp.deat006,l_tmp.deat007,l_tmp.deat008,l_tmp.deat009
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         SELECT ooia002 INTO l_deae002
           FROM ooia_t
          WHERE ooiaent = g_enterprise
            AND ooia001 = l_tmp.deat003
         
         INSERT INTO deae_t(deaeent,deaesite,deaedocno,deae001,deae002,deae003,deae004,deae005,deae006,deae007) 
         VALUES(g_enterprise,g_dead_m.deadsite,g_dead_m.deaddocno,
                l_tmp.deat003,l_deae002,0,l_tmp.deat006,l_tmp.deat007,l_tmp.deat008,l_tmp.deat009)
         
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'ins'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            LET r_success = FALSE
         END IF   
      END FOREACH 
   END IF
   #160816-00007#1--add--end--lujh
   
   RETURN r_success
END FUNCTION
# 單身金額顯示
#160816-00007#1 add lujh
PRIVATE FUNCTION adet406_visible()
   
   IF g_ooaa002 = 'Y' THEN 
      CALL cl_set_comp_visible('deae004,deae005,deae006,deae007',FALSE)
      CALL cl_set_comp_visible('deae003',TRUE) 
      CALL cl_set_toolbaritem_visible("adet406_s01",FALSE)      
   ELSE
      CALL cl_set_comp_visible('deae004,deae005,deae006,deae007',TRUE)
      CALL cl_set_comp_visible('deae003',FALSE)  
      CALL cl_set_toolbaritem_visible("adet406_s01",TRUE) 
   END IF
END FUNCTION
# 批次產生所有收銀員的收銀數據
#160816-00007#1 add lujh
PRIVATE FUNCTION adet406_open_adet406_s01()
   DEFINE r_success       LIKE type_t.num5
   DEFINE tm      RECORD                   
          l_deadsite      LIKE dead_t.deadsite,    
          l_deaddocdt     LIKE dead_t.deaddocdt
                  END RECORD     
   DEFINE l_errno         LIKE type_t.chr10
   DEFINE l_ooef004       LIKE ooef_t.ooef004    
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_doctype       LIKE rtai_t.rtai004 
   DEFINE l_wc            STRING
   
   LET r_success = TRUE
   
   INITIALIZE tm.* TO NULL  
   
   OPEN WINDOW w_adet406_s01 WITH FORM cl_ap_formpath("ade","adet406_s01")
   #畫面初始化
   CALL cl_ui_init()
   WHILE TRUE
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)     
      
         CONSTRUCT l_wc ON deadsite FROM l_deadsite      
         
            BEFORE CONSTRUCT
            
            ON ACTION controlp INFIELD l_deadsite
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'deadsite',g_site,'c')
               CALL q_ooef001_24()
               DISPLAY g_qryparam.return1 TO l_deadsite  #顯示到畫面上
               NEXT FIELD l_deadsite                     #返回原欄位
               
         END CONSTRUCT    
         
         INPUT tm.l_deaddocdt FROM l_deaddocdt ATTRIBUTE(WITHOUT DEFAULTS)
            BEFORE INPUT 
         END INPUT
         
         BEFORE DIALOG
            DISPLAY g_site TO l_deadsite  
            LET tm.l_deaddocdt = g_today
            DISPLAY BY NAME tm.l_deaddocdt
               
         ON ACTION confirm
            ACCEPT DIALOG
      
         ON ACTION cancel1     
            LET INT_FLAG = TRUE
            EXIT DIALOG
      
         ON ACTION exit
            LET INT_FLAG = TRUE
            EXIT DIALOG
      
         ON ACTION close
            LET INT_FLAG = TRUE
            EXIT DIALOG  
            
      END DIALOG 
      
      IF NOT INT_FLAG THEN      
         #是否以目前輸入的條件批次產生收銀繳款單？
         IF cl_ask_confirm('ade-00134') THEN 
            IF NOT adet406_ins_deae_p(l_wc,tm.l_deaddocdt) THEN
               LET r_success = FALSE
               LET g_wc = l_wc CLIPPED," AND deaddocdt = TO_DATE('",tm.l_deaddocdt,"','yy/mm/dd')"
            ELSE 
               LET g_wc = l_wc CLIPPED," AND deaddocdt = TO_DATE('",tm.l_deaddocdt,"','yy/mm/dd')"
            END IF
            EXIT WHILE            
         ELSE
            CONTINUE WHILE         
         END IF
      ELSE
         LET r_success = FALSE
         LET INT_FLAG = FALSE
         EXIT WHILE
      END IF
      
   END WHILE
   
   CLOSE WINDOW w_adet406_s01

   RETURN r_success
END FUNCTION
# 整批產生單身
#160816-00007#1 add lujh
PRIVATE FUNCTION adet406_ins_deae_p(p_wc,p_docdt)
   DEFINE p_wc               STRING
   DEFINE p_docdt            LIKE dead_t.deadsite
   DEFINE l_sql              STRING
   DEFINE l_deatsite         LIKE deat_t.deatsite
   DEFINE l_deat001          LIKE deat_t.deat001
   DEFINE l_deat002          LIKE deat_t.deat002
   DEFINE l_tmp              RECORD 
                             deat003        LIKE deat_t.deat003,
                             deat006        LIKE deat_t.deat006,
                             deat007        LIKE deat_t.deat007,
                             deat008        LIKE deat_t.deat008,
                             deat009        LIKE deat_t.deat009
                             END RECORD
   DEFINE l_docno            LIKE dead_t.deaddocno
   #161104-00002#3 Mark By Ken 161107(S)
   #DEFINE l_dead             RECORD LIKE dead_t.*
   #DEFINE l_deae             RECORD LIKE deae_t.*
   #161104-00002#3 Mark By Ken 161107(E)
#161104-00002#3 Add By Ken 161107(S)   
DEFINE l_dead RECORD  #门店收银缴款出纳结账单头档
       deadent LIKE dead_t.deadent,     #企業代碼
       deadsite LIKE dead_t.deadsite,   #營運據點
       deaddocno LIKE dead_t.deaddocno, #單號
       deaddocdt LIKE dead_t.deaddocdt, #單據日期
       deadstamp LIKE dead_t.deadstamp, #時間戳記
       dead001 LIKE dead_t.dead001,     #收銀員編號
       deadownid LIKE dead_t.deadownid, #資料所有者
       deadowndp LIKE dead_t.deadowndp, #資料所屬部門
       deadcrtid LIKE dead_t.deadcrtid, #資料建立者
       deadcrtdp LIKE dead_t.deadcrtdp, #資料建立部門
       deadcrtdt LIKE dead_t.deadcrtdt, #資料創建日
       deadmodid LIKE dead_t.deadmodid, #資料修改者
       deadmoddt LIKE dead_t.deadmoddt, #最近修改日
       deadstus LIKE dead_t.deadstus,    #狀態碼
       #161123-00042#3 Add By Ken 161124(S)
       deadud001 LIKE dead_t.deadud001, #自定義欄位(文字)001
       deadud002 LIKE dead_t.deadud002, #自定義欄位(文字)002
       deadud003 LIKE dead_t.deadud003, #自定義欄位(文字)003
       deadud004 LIKE dead_t.deadud004, #自定義欄位(文字)004
       deadud005 LIKE dead_t.deadud005, #自定義欄位(文字)005
       deadud006 LIKE dead_t.deadud006, #自定義欄位(文字)006
       deadud007 LIKE dead_t.deadud007, #自定義欄位(文字)007
       deadud008 LIKE dead_t.deadud008, #自定義欄位(文字)008
       deadud009 LIKE dead_t.deadud009, #自定義欄位(文字)009
       deadud010 LIKE dead_t.deadud010, #自定義欄位(文字)010
       deadud011 LIKE dead_t.deadud011, #自定義欄位(數字)011
       deadud012 LIKE dead_t.deadud012, #自定義欄位(數字)012
       deadud013 LIKE dead_t.deadud013, #自定義欄位(數字)013
       deadud014 LIKE dead_t.deadud014, #自定義欄位(數字)014
       deadud015 LIKE dead_t.deadud015, #自定義欄位(數字)015
       deadud016 LIKE dead_t.deadud016, #自定義欄位(數字)016
       deadud017 LIKE dead_t.deadud017, #自定義欄位(數字)017
       deadud018 LIKE dead_t.deadud018, #自定義欄位(數字)018
       deadud019 LIKE dead_t.deadud019, #自定義欄位(數字)019
       deadud020 LIKE dead_t.deadud020, #自定義欄位(數字)020
       deadud021 LIKE dead_t.deadud021, #自定義欄位(日期時間)021
       deadud022 LIKE dead_t.deadud022, #自定義欄位(日期時間)022
       deadud023 LIKE dead_t.deadud023, #自定義欄位(日期時間)023
       deadud024 LIKE dead_t.deadud024, #自定義欄位(日期時間)024
       deadud025 LIKE dead_t.deadud025, #自定義欄位(日期時間)025
       deadud026 LIKE dead_t.deadud026, #自定義欄位(日期時間)026
       deadud027 LIKE dead_t.deadud027, #自定義欄位(日期時間)027
       deadud028 LIKE dead_t.deadud028, #自定義欄位(日期時間)028
       deadud029 LIKE dead_t.deadud029, #自定義欄位(日期時間)029
       deadud030 LIKE dead_t.deadud030  #自定義欄位(日期時間)030
       #161123-00042#3 Add By Ken 161124(E)
END RECORD   
DEFINE l_deae RECORD  #门店收银缴款出纳结账单身档
       deaeent LIKE deae_t.deaeent, #企業編號
       deaesite LIKE deae_t.deaesite, #營運據點
       deaedocno LIKE deae_t.deaedocno, #單號
       deae001 LIKE deae_t.deae001, #款別編號
       deae002 LIKE deae_t.deae002, #款別分類
       deae003 LIKE deae_t.deae003, #總繳金額
       deae004 LIKE deae_t.deae004, #實收金額
       deae005 LIKE deae_t.deae005, #POS讀帳條(本地延遲上傳)
       deae006 LIKE deae_t.deae006, #POS伺服器金額彙總
       deae007 LIKE deae_t.deae007,  #差異金額
       #161123-00042#3 Add By Ken 161124(S)
       deaeud001 LIKE deae_t.deaeud001, #自定義欄位(文字)001
       deaeud002 LIKE deae_t.deaeud002, #自定義欄位(文字)002
       deaeud003 LIKE deae_t.deaeud003, #自定義欄位(文字)003
       deaeud004 LIKE deae_t.deaeud004, #自定義欄位(文字)004
       deaeud005 LIKE deae_t.deaeud005, #自定義欄位(文字)005
       deaeud006 LIKE deae_t.deaeud006, #自定義欄位(文字)006
       deaeud007 LIKE deae_t.deaeud007, #自定義欄位(文字)007
       deaeud008 LIKE deae_t.deaeud008, #自定義欄位(文字)008
       deaeud009 LIKE deae_t.deaeud009, #自定義欄位(文字)009
       deaeud010 LIKE deae_t.deaeud010, #自定義欄位(文字)010
       deaeud011 LIKE deae_t.deaeud011, #自定義欄位(數字)011
       deaeud012 LIKE deae_t.deaeud012, #自定義欄位(數字)012
       deaeud013 LIKE deae_t.deaeud013, #自定義欄位(數字)013
       deaeud014 LIKE deae_t.deaeud014, #自定義欄位(數字)014
       deaeud015 LIKE deae_t.deaeud015, #自定義欄位(數字)015
       deaeud016 LIKE deae_t.deaeud016, #自定義欄位(數字)016
       deaeud017 LIKE deae_t.deaeud017, #自定義欄位(數字)017
       deaeud018 LIKE deae_t.deaeud018, #自定義欄位(數字)018
       deaeud019 LIKE deae_t.deaeud019, #自定義欄位(數字)019
       deaeud020 LIKE deae_t.deaeud020, #自定義欄位(數字)020
       deaeud021 LIKE deae_t.deaeud021, #自定義欄位(日期時間)021
       deaeud022 LIKE deae_t.deaeud022, #自定義欄位(日期時間)022
       deaeud023 LIKE deae_t.deaeud023, #自定義欄位(日期時間)023
       deaeud024 LIKE deae_t.deaeud024, #自定義欄位(日期時間)024
       deaeud025 LIKE deae_t.deaeud025, #自定義欄位(日期時間)025
       deaeud026 LIKE deae_t.deaeud026, #自定義欄位(日期時間)026
       deaeud027 LIKE deae_t.deaeud027, #自定義欄位(日期時間)027
       deaeud028 LIKE deae_t.deaeud028, #自定義欄位(日期時間)028
       deaeud029 LIKE deae_t.deaeud029, #自定義欄位(日期時間)029
       deaeud030 LIKE deae_t.deaeud030  #自定義欄位(日期時間)030       
       #161123-00042#3 Add By Ken 161124(E)
END RECORD
#161104-00002#3 Add By Ken 161107(E)   
   
   DEFINE l_n                LIKE type_t.num5
   DEFINE l_deaddocno        LIKE dead_t.deaddocno
   DEFINE l_deaddocdt        LIKE dead_t.deaddocdt
   DEFINE l_flag             LIKE type_t.chr1
   DEFINE l_flag1            LIKE type_t.chr1
   DEFINE l_success          LIKE type_t.num5
   DEFINE r_success          LIKE type_t.num5
   
   LET r_success = TRUE
   
   LET p_wc = cl_replace_str(p_wc,"deadsite","deatsite")       
   
   LET l_flag1 = 'N'
   LET l_n = 0
   LET l_sql = "SELECT COUNT(*) ",
               "  FROM dead_t ",
               " WHERE deadent = ",g_enterprise,
               "   AND deadsite||deaddocdt||dead001 IN (SELECT DISTINCT deatsite||deat001||deat002 ",
               "                                          FROM deat_t ",
               "                                         WHERE deatent = ",g_enterprise,
               "                                           AND deat001 = '",p_docdt,"'",
               "                                           AND ",p_wc,
               "                                           AND deat010 = 'N' ",
               "                                       )",
               "   AND deadstus = 'N' "
               
   PREPARE adet406_dead001_count_pre FROM l_sql
   EXECUTE adet406_dead001_count_pre INTO l_n
   
   IF l_n > 0 THEN 
      IF cl_ask_confirm('ade-00175') THEN 
         LET l_flag = 'Y'
      ELSE
         LET l_flag = 'N'
      END IF
   END IF
   
   LET l_sql = "SELECT DISTINCT deatsite,deat001,deat002",
               "  FROM deat_t ",
               " WHERE deatent = ",g_enterprise,
               "   AND deat001 = '",p_docdt,"'",
               "   AND ",p_wc,
               "   AND deat010 = 'N' "
   PREPARE adet406_ins_deae_1_pre FROM l_sql
   DECLARE adet406_ins_deae_1_cs CURSOR FOR adet406_ins_deae_1_pre
   
   FOREACH adet406_ins_deae_1_cs INTO l_deatsite,l_deat001,l_deat002
                                     
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      LET l_n = 0
      SELECT COUNT(*) INTO l_n
        FROM dead_t
       WHERE deadent = g_enterprise
         AND deadsite = l_deatsite
         AND deaddocdt = l_deat001
         AND dead001 = l_deat002
         AND deadstus = 'N'
         
      IF l_n > 0 THEN
         IF l_flag = 'Y' THEN       
            SELECT deaddocno,deaddocdt INTO l_deaddocno,l_deaddocdt
              FROM dead_t
             WHERE deadent = g_enterprise
               AND deadsite = l_deatsite
               AND deaddocdt = l_deat001
               AND dead001 = l_deat002
            
            IF NOT s_aooi200_del_docno(l_deaddocno,l_deaddocdt) THEN
               LET r_success = FALSE
            END IF
            
            DELETE FROM dead_t 
             WHERE deadent = g_enterprise 
               AND deaddocno = l_deaddocno
               
            DELETE FROM deae_t
             WHERE deaeent = g_enterprise
               AND deaedocno = l_deaddocno
  
         ELSE
            CONTINUE FOREACH
         END IF
      END IF
      
      INITIALIZE l_dead.* TO NULL
      INITIALIZE l_deae.* TO NULL
      
      #取預設批次拋轉單別
      CALL s_arti200_get_def_doc_type(l_deatsite,g_prog,'2')    
      RETURNING r_success,l_docno
      
      #插入單頭
      CALL s_aooi200_gen_docno(l_deatsite,l_docno,l_deat001,g_prog) RETURNING l_success,l_dead.deaddocno
      IF NOT l_success THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'apm-00003'
         LET g_errparam.extend = l_dead.deaddocno
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
      END IF  
      
      LET l_dead.deadent   = g_enterprise
      LET l_dead.deadsite  = l_deatsite
      LET l_dead.deaddocdt = l_deat001
      LET l_dead.deadstamp = cl_get_time()
      LET l_dead.dead001   = l_deat002   
      LET l_dead.deadownid = g_user
      LET l_dead.deadowndp = g_dept
      LET l_dead.deadcrtid = g_user
      LET l_dead.deadcrtdp = g_dept 
      LET l_dead.deadcrtdt = cl_get_current()
      LET l_dead.deadmodid = g_user
      LET l_dead.deadmoddt = cl_get_current()
      LET l_dead.deadstus  = 'N'
      
      #INSERT INTO dead_t VALUES(l_dead.*)   #161104-00002#3 Mark By Ken 161107
      #161104-00002#3 Add By Ken 161107(S)
      INSERT INTO dead_t (deadent,  deadsite, deaddocno,deaddocdt,deadstamp,
                          dead001,  deadownid,deadowndp,deadcrtid,deadcrtdp,
                          deadcrtdt,deadmodid,deadmoddt,deadstus,
                          #161123-00042#3 Add By Ken 161124(S)
                          deadud001,deadud002,deadud003,deadud004,deadud005,
                          deadud006,deadud007,deadud008,deadud009,deadud010,
                          deadud011,deadud012,deadud013,deadud014,deadud015,
                          deadud016,deadud017,deadud018,deadud019,deadud020,
                          deadud021,deadud022,deadud023,deadud024,deadud025,
                          deadud026,deadud027,deadud028,deadud029,deadud030)
                          #161123-00042#3 Add By Ken 161124(E)
        VALUES(l_dead.deadent,  l_dead.deadsite, l_dead.deaddocno, l_dead.deaddocdt, l_dead.deadstamp, 
               l_dead.dead001,  l_dead.deadownid,l_dead.deadowndp, l_dead.deadcrtid, l_dead.deadcrtdp,
               l_dead.deadcrtdt,l_dead.deadmodid,l_dead.deadmoddt, l_dead.deadstus,
               #161123-00042#3 Add By Ken 161124(S)
               l_dead.deadud001,l_dead.deadud002,l_dead.deadud003,l_dead.deadud004,l_dead.deadud005,
               l_dead.deadud006,l_dead.deadud007,l_dead.deadud008,l_dead.deadud009,l_dead.deadud010,
               l_dead.deadud011,l_dead.deadud012,l_dead.deadud013,l_dead.deadud014,l_dead.deadud015,
               l_dead.deadud016,l_dead.deadud017,l_dead.deadud018,l_dead.deadud019,l_dead.deadud020,
               l_dead.deadud021,l_dead.deadud022,l_dead.deadud023,l_dead.deadud024,l_dead.deadud025,
               l_dead.deadud026,l_dead.deadud027,l_dead.deadud028,l_dead.deadud029,l_dead.deadud030)
               #161123-00042#3 Add By Ken 161124(E)               
      #161104-00002#3 Add By Ken 161107(E)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'INSERT INTO dead_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      
         LET r_success = FALSE             
      END IF
      
      LET l_flag1 = 'Y'
      
      #插入單身
      LET l_sql = "SELECT deat003,SUM(deat006),SUM(deat007),SUM(deat008),SUM(deat009)",
               "  FROM deat_t ",
               " WHERE deatent = ",g_enterprise,
               "   AND deat010 = 'N' ",
               "   AND deatsite = '",l_deatsite,"'",
               "   AND deat001 = '",l_deat001,"'",
               "   AND deat002 = '",l_deat002,"'",               
               " GROUP BY deat003 "
      PREPARE s_deat_group_pre FROM l_sql
      DECLARE s_deat_group_cs CURSOR FOR s_deat_group_pre
      
      FOREACH s_deat_group_cs INTO l_tmp.deat003,l_tmp.deat006,l_tmp.deat007,l_tmp.deat008,l_tmp.deat009
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
      
         LET l_deae.deaeent   = g_enterprise
         LET l_deae.deaesite  = l_deatsite
         LET l_deae.deaedocno = l_dead.deaddocno
         LET l_deae.deae001   = l_tmp.deat003
         SELECT ooia002 INTO l_deae.deae002
           FROM ooia_t
          WHERE ooiaent = g_enterprise
            AND ooia001 = l_tmp.deat003
            
         LET l_deae.deae003   = 0
         LET l_deae.deae004   = l_tmp.deat006
         LET l_deae.deae005   = l_tmp.deat007
         LET l_deae.deae006   = l_tmp.deat008
         LET l_deae.deae007   = l_tmp.deat009
         
         #INSERT INTO deae_t VALUES(l_deae.*)   #161104-00002#3 Mark By Ken 161107
         #161104-00002#3 Add By Ken 161107(S)
         INSERT INTO deae_t (deaeent,deaesite,deaedocno,deae001,deae002,
                             deae003,deae004, deae005,  deae006,deae007,
                             #161123-00042#3 Add By Ken 161124(S)
                             deaeud001,deaeud002,deaeud003,deaeud004,deaeud005,
                             deaeud006,deaeud007,deaeud008,deaeud009,deaeud010,
                             deaeud011,deaeud012,deaeud013,deaeud014,deaeud015,
                             deaeud016,deaeud017,deaeud018,deaeud019,deaeud020,
                             deaeud021,deaeud022,deaeud023,deaeud024,deaeud025,
                             deaeud026,deaeud027,deaeud028,deaeud029,deaeud030) 
                             #161123-00042#3 Add By Ken 161124(E)
         VALUES(l_deae.deaeent,  l_deae.deaesite,  l_deae.deaedocno,  l_deae.deae001,  l_deae.deae002,  
                l_deae.deae003,  l_deae.deae004,   l_deae.deae005,    l_deae.deae006,  l_deae.deae007,
                #161123-00042#3 Add By Ken 161124(S)
                l_deae.deaeud001,l_deae.deaeud002,l_deae.deaeud003,l_deae.deaeud004,l_deae.deaeud005,
                l_deae.deaeud006,l_deae.deaeud007,l_deae.deaeud008,l_deae.deaeud009,l_deae.deaeud010,
                l_deae.deaeud011,l_deae.deaeud012,l_deae.deaeud013,l_deae.deaeud014,l_deae.deaeud015,
                l_deae.deaeud016,l_deae.deaeud017,l_deae.deaeud018,l_deae.deaeud019,l_deae.deaeud020,
                l_deae.deaeud021,l_deae.deaeud022,l_deae.deaeud023,l_deae.deaeud024,l_deae.deaeud025,
                l_deae.deaeud026,l_deae.deaeud027,l_deae.deaeud028,l_deae.deaeud029,l_deae.deaeud030) 
                #161123-00042#3 Add By Ken 161124(E)                
         #161104-00002#3 Add By Ken 161107(E)
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'INSERT INTO dead_t'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            LET r_success = FALSE             
         END IF
      END FOREACH
   END FOREACH
   
   IF l_flag1 = 'N' THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00491'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
   END IF
   
   RETURN r_success
END FUNCTION

 
{</section>}
 
