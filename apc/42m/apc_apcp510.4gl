#該程式未解開Section, 採用最新樣板產出!
{<section id="apcp510.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2016-10-04 16:42:19), PR版次:0002(2017-01-18 10:46:35)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: apcp510
#+ Description: 卡儲值差異處理作業
#+ Creator....: 02749(2016-09-09 10:58:33)
#+ Modifier...: 02749 -SD/PR- 06814
 
{</section>}
 
{<section id="apcp510.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#Memos
# Modify..........: #160819-00054#21   2016/10/04 by lori      取消原本直接呼叫s_card_value_del 的方式, 改產生apct500 的方式進行
# Modify..........: #160819-00054#37   2016/10/26 by lori      執行前 先將曾被"撤銷" 的錯誤紀錄的pcanstus 更新為'D'
# Modify..........: #170109-00037#7    2017/01/11 by 06814     批次LOCK處理:1.UI勾選LOCK檢查
#                                                                          2.資料處理LOCK
#                                                                          3.單號LOCK
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc" 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#模組變數(Module Variables)
DEFINE g_wc                 STRING
DEFINE g_wc_t               STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                STRING
DEFINE g_wc_filter          STRING
DEFINE g_wc_filter_t        STRING
DEFINE g_sql                STRING
DEFINE g_forupd_sql         STRING                        #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_t.num5
DEFINE g_cnt                LIKE type_t.num10    
DEFINE l_ac                 LIKE type_t.num10              
DEFINE l_ac_d               LIKE type_t.num10             #單身idx 
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_current_page       LIKE type_t.num10             #目前所在頁數
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_master_idx         LIKE type_t.num10
 
TYPE type_parameter RECORD
   #add-point:自定背景執行須傳遞的參數(Module Variable) name="global.parameter"
        mmau018          LIKE mmau_t.mmau018,
        mmau001          LIKE mmau_t.mmau001,
        l_date_s         LIKE type_t.dat,
        l_date_e         LIKE type_t.dat,
        l_mmau004_1      LIKE type_t.chr1,
        l_mmau004_2      LIKE type_t.chr2,
        l_mmau004_3      LIKE type_t.chr3,
        l_diff           LIKE type_t.chr1,
   #end add-point
        wc               STRING
                     END RECORD
 
TYPE type_g_detail_d RECORD
#add-point:自定義模組變數(Module Variable)  #注意要在add-point內寫入END RECORD name="global.variable"
        sel              LIKE type_t.chr1,
        mmau018          LIKE mmau_t.mmau018,
        mmau018_desc     LIKE ooefl_t.ooefl003,
        mmau006          LIKE type_t.dat,
        mmau001          LIKE mmau_t.mmau001,
        mmau004          LIKE mmau_t.mmau004,
        mmau009          LIKE mmau_t.mmau009,
        l_rtjf003        LIKE rtja_t.rtja003,
        l_diff_amount    LIKE type_t.num20_6        
                     END RECORD
DEFINE g_master      RECORD 
          mmau018        LIKE mmau_t.mmau018,  
          mmau001        LIKE mmau_t.mmau001,
          l_date_s       LIKE type_t.dat,
          l_date_e       LIKE type_t.dat,
          l_mmau004_1    LIKE type_t.chr1,
          l_mmau004_2    LIKE type_t.chr2,
          l_mmau004_3    LIKE type_t.chr3,
          l_diff         LIKE type_t.chr1,
          wc             STRING          
                     END RECORD          
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="apcp510.main" >}
#+ 作業開始 
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   DEFINE ls_js  STRING
   #add-point:main段define name="main.define"
   
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("apc","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      LET ls_js = g_argv[01]
      IF NOT apcp510_process(ls_js) THEN
         CALL cl_ap_exitprogram("1")
      END IF
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apcp510 WITH FORM cl_ap_formpath("apc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apcp510_init()   
 
      #進入選單 Menu (="N")
      CALL apcp510_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_apcp510
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="apcp510.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION apcp510_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('b_mmau004','6514')
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="apcp510.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apcp510_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_pcam013   LIKE pcam_t.pcam013
   DEFINE l_pcam006   LIKE pcam_t.pcam006
   DEFINE ls_js       STRING
   DEFINE l_success   LIKE type_t.num5
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   #170109-00037#7 20170110 add by beckxie---S
   #LOCK檢查
   LET g_sql = "SELECT pcam001 ",
               "  FROM pcam_t ",   
               " WHERE pcament = ",g_enterprise,
               "   AND pcam001 = ? ",
               "   AND pcam015 = ? ",
               "   FOR UPDATE SKIP LOCKED "
   PREPARE apcp510_chk_lock_pcam FROM g_sql
   
   
   LET g_sql = "SELECT DISTINCT pcam001,pcam015 ",           #請求ID,處理ID
               "  FROM pcan_t,pcam_t ",
               " WHERE pcanent = pcament AND pcan001 = pcam001 ",
               "   AND pcanent = ",g_enterprise,
               "   AND pcanstus = 'Y' AND pcam014 = 'Y' ",
               "   AND pcam004 = ? ",   #異動日期
               "   AND pcam006 = ? ",   #異動類型
               "   AND pcam008 = ? "   #卡號
   PREPARE apcp510_sel_pcam_pre1 FROM g_sql   
   DECLARE apcp510_sel_pcam_cur1 CURSOR FOR apcp510_sel_pcam_pre1
   #170109-00037#7 20170110 add by beckxie---E
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL apcp510_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT BY NAME g_master.wc ON mmau018,mmau001
            
            BEFORE CONSTRUCT
               CALL cl_set_act_visible("filter",FALSE)
            
            ON ACTION controlp INFIELD mmau018
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooef001_24()
               DISPLAY g_qryparam.return1 TO mmau018
               NEXT FIELD CURRENT  

            ON ACTION controlp INFIELD mmau001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooef001_24()
               DISPLAY g_qryparam.return1 TO mmau018
               NEXT FIELD CURRENT
         END CONSTRUCT
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT BY NAME g_master.l_date_s,g_master.l_date_e,g_master.l_mmau004_1,g_master.l_mmau004_2,g_master.l_mmau004_3,
                       g_master.l_diff ATTRIBUTE(WITHOUT DEFAULTS)
            
            BEFORE INPUT
               CALL cl_set_act_visible("filter",FALSE)                
         END INPUT
         
         INPUT ARRAY g_detail_d FROM s_detail1.*
             ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                       INSERT ROW = FALSE,DELETE ROW = FALSE, APPEND ROW = FALSE)
            
            BEFORE INPUT
               LET g_current_page = 1
               CALL cl_set_act_visible("filter",FALSE)
               LET g_detail_cnt = g_detail_d.getLength()
               
            BEFORE ROW
                LET l_ac = ARR_CURR()
                LET g_detail_cnt = g_detail_d.getLength()
                
                DISPLAY l_ac TO FORMONLY.h_index
                DISPLAY g_detail_d.getLength() TO FORMONLY.h_count
                
                IF g_detail_d[l_ac].sel = 'N' THEN
                   NEXT FIELD sel
                END IF
                
            ON CHANGE sel
               IF g_detail_d[l_ac].l_diff_amount = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apc-00097'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               
                  LET g_detail_d[l_ac].sel = 'N'
                  NEXT FIELD sel 
               END IF
               #170109-00037#7 20170113 add by beckxie---S
               CALL cl_err_collect_init() 
               CALL s_transaction_begin()
               IF NOT apcp510_lock_chk(l_ac) THEN
                  #FALSE=被lock
                  LET g_detail_d[l_ac].sel = 'N'
               END IF
               CALL s_transaction_end('Y',0)
               CALL cl_err_collect_show()
               #170109-00037#7 20170113 add by beckxie---E
         
            ON ROW CHANGE
               IF INT_FLAG THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 9001
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
         
                  LET INT_FLAG = 0
                  NEXT FIELD sel 
               END IF
               
         END INPUT      
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
 
         BEFORE DIALOG
            IF g_detail_d.getLength() > 0 THEN
               CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
               CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
            ELSE
               CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
               CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
            END IF
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            LET g_master.mmau018     = g_site  
            LET g_master.l_date_s    = g_today 
            LET g_master.l_date_e    = g_today 
            LET g_master.l_mmau004_1 = 'N'     
            LET g_master.l_mmau004_2 = 'N'     
            LET g_master.l_mmau004_3 = 'Y'     
            LET g_master.l_diff      = 'Y'     
            
            DISPLAY BY NAME g_master.mmau018     
            DISPLAY BY NAME g_master.l_date_s    
            DISPLAY BY NAME g_master.l_date_e    
            DISPLAY BY NAME g_master.l_mmau004_1 
            DISPLAY BY NAME g_master.l_mmau004_2 
            DISPLAY BY NAME g_master.l_mmau004_3 
            DISPLAY BY NAME g_master.l_diff  
            #end add-point
 
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            #add-point:ui_dialog段on action selall name="ui_dialog.selall.befroe"
            CALL cl_err_collect_init()   #170109-00037#7 20170113 add by beckxie
            #end add-point            
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
               #add-point:ui_dialog段on action selall name="ui_dialog.for.onaction_selall"
               IF g_detail_d[li_idx].l_diff_amount = 0 THEN
                  LET g_detail_d[li_idx].sel = "N"
               END IF               
               #170109-00037#7 20170113 add by beckxie---S
               CALL s_transaction_begin()
               IF NOT apcp510_lock_chk(li_idx) THEN
                  #FALSE=被lock
                  LET g_detail_d[li_idx].sel = 'N'
               END IF
               CALL s_transaction_end('Y',0)
               #170109-00037#7 20170113 add by beckxie---E
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            CALL cl_err_collect_show()   #170109-00037#7 20170113 add by beckxie
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "N"
               #add-point:ui_dialog段on action selnone name="ui_dialog.for.onaction_selnone"
               
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "Y"
               END IF
            END FOR
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            CALL cl_err_collect_init()   #170109-00037#7 20170113 add by beckxie
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "Y"
                  IF g_detail_d[li_idx].l_diff_amount = 0 THEN
                     LET g_detail_d[li_idx].sel = "N"
                  END IF                   
                  #170109-00037#7 20170113 add by beckxie---S
                  CALL s_transaction_begin()
                  IF NOT apcp510_lock_chk(li_idx) THEN
                     #FALSE=被lock
                     LET g_detail_d[li_idx].sel = 'N'
                  END IF
                  CALL s_transaction_end('Y',0)
                  #170109-00037#7 20170113 add by beckxie---E
               END IF
            END FOR
            CALL cl_err_collect_show()   #170109-00037#7 20170113 add by beckxie
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "N"
               END IF
            END FOR
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL apcp510_filter()
            #add-point:ON ACTION filter name="menu.filter"
            
            #END add-point
            EXIT DIALOG
      
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice = "exit"
            EXIT DIALOG
      
         ON ACTION exit
            LET g_action_choice="exit"
            EXIT DIALOG
 
         ON ACTION accept
            #add-point:ui_dialog段accept之前 name="menu.filter"
            
            #end add-point
            CALL apcp510_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL apcp510_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            LET l_success = ''
            LET ls_js = util.JSON.stringify(g_master)
            CALL apcp510_process(ls_js) RETURNING l_success
            CALL apcp510_b_fill()
         #end add-point
 
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG
 
      #(ver:22) ---start---
      #add-point:ui_dialog段 after dialog name="ui_dialog.exit_dialog"
      
      #end add-point
      #(ver:22) --- end ---
 
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         #(ver:22) ---start---
         #add-point:ui_dialog段離開dialog前 name="ui_dialog.b_exit"
         
         #end add-point
         #(ver:22) --- end ---
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="apcp510.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION apcp510_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   
   #end add-point
        
   LET g_error_show = 1
   CALL apcp510_b_fill()
   LET l_ac = g_master_idx
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = -100 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
   END IF
   
   #add-point:cs段after_query name="query.cs_after_query"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="apcp510.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION apcp510_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
 
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL apcp510_get_data("")    #取得資料來源SQL
   #end add-point
 
   PREPARE apcp510_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR apcp510_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
        g_detail_d[l_ac].sel     ,g_detail_d[l_ac].mmau018   ,g_detail_d[l_ac].mmau018_desc ,
        g_detail_d[l_ac].mmau006 ,g_detail_d[l_ac].mmau001   ,g_detail_d[l_ac].mmau004      ,
        g_detail_d[l_ac].mmau009 ,g_detail_d[l_ac].l_rtjf003 ,g_detail_d[l_ac].l_diff_amount 
   #end add-point
   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #add-point:b_fill段資料填充 name="b_fill.foreach_iside"
 
      #end add-point
      
      CALL apcp510_detail_show()      
 
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend =  "" 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
         END IF
         EXIT FOREACH
      END IF
      
   END FOREACH
   LET g_error_show = 0
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.other_table"
   CALL g_detail_d.deleteElement(l_ac)
   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE apcp510_sel
   
   LET l_ac = 1
   CALL apcp510_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apcp510.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION apcp510_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define name="fetch.define"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後 name="fetch.after_fill"
   
   #end add-point 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="apcp510.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION apcp510_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apcp510.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION apcp510_filter()
   #add-point:filter段define(客製用) name="filter.define_customerization"
   
   #end add-point    
   #add-point:filter段define name="filter.define"
   
   #end add-point
   
   DISPLAY ARRAY g_detail_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
      ON UPDATE
 
   END DISPLAY
 
   LET l_ac = 1
   LET g_detail_cnt = 1
   #add-point:filter段define name="filter.detail_cnt"
   LET g_wc = g_master.wc
   #end add-point    
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   
   CALL apcp510_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="apcp510.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION apcp510_filter_parser(ps_field)
   #add-point:filter段define(客製用) name="filter_parser.define_customerization"
   
   #end add-point    
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num10
   DEFINE li_tmp2    LIKE type_t.num10
   DEFINE ls_var     STRING
   #add-point:filter段define name="filter_parser.define"
   
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
 
{<section id="apcp510.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION apcp510_filter_show(ps_field,ps_object)
   DEFINE ps_field         STRING
   DEFINE ps_object        STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING
 
   LET ls_name = "formonly.", ps_object
 
   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = apcp510_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="apcp510.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 執行批次處理
# Memo...........:
# Usage..........: CALL apcp510_process(p_js)
#                  RETURNING r_success
# Input parameter: p_js           傳入參數條件
# Return code....: r_success      處理結果
# Date & Author..: 2016/09/19 By Lori
# Modify.........: 2016/10/04 By Lori     呼叫s_card_value_del 的方式, 改產生apct500 的方式進行
#                  2016/10/26 By Lori     執行前,先將曾被"撤銷" 的錯誤紀錄的pcanstus 更新為'D'
################################################################################
PRIVATE FUNCTION apcp510_process(p_js)
   DEFINE p_js              STRING
   DEFINE r_success         LIKE type_t.num5
   DEFINE l_para            type_parameter
   DEFINE li_idx            LIKE type_t.num5
   DEFINE l_err_cnt         LIKE type_t.num5
   DEFINE l_cnt1            LIKE type_t.num5
   DEFINE l_cnt2            LIKE type_t.num5 
   DEFINE l_ac              LIKE type_t.num5   
   DEFINE l_pcam006         LIKE pcam_t.pcam006
   DEFINE l_pcam013         LIKE pcam_t.pcam013
   #160819-00054#21 161004 by lori add---(S)
   DEFINE l_pcam002         LIKE pcam_t.pcam002
   DEFINE l_pcam003         LIKE pcam_t.pcam003
   DEFINE l_pcam004         LIKE pcam_t.pcam004
   DEFINE l_pcam005         LIKE pcam_t.pcam005
   DEFINE l_pcam008         LIKE pcam_t.pcam008
   DEFINE l_pcam009         LIKE pcam_t.pcam009
   DEFINE l_pcam010         LIKE pcam_t.pcam010
   DEFINE l_pcam011         LIKE pcam_t.pcam011
   DEFINE l_pcam012         LIKE pcam_t.pcam012 
   DEFINE l_pcam014         LIKE pcam_t.pcam014   
   #160819-00054#21 161004 by lori add---(E)
   DEFINE l_cardid          LIKE mmaq_t.mmaq001   #會員卡號
   DEFINE l_txn_type        LIKE mmau_t.mmau004   #異動類別(系統分類碼:6514)
   DEFINE l_docno           LIKE mmau_t.mmau005   #異動單據編號
   DEFINE l_value           LIKE mmau_t.mmau009   #本次儲值金額
   DEFINE l_discount_amount LIKE mmau_t.mmau011   #本次儲值折扣金額
   DEFINE l_added_val       LIKE mmau_t.mmau012   #本次加值金額
   DEFINE l_delivered       LIKE mmau_t.mmau013   #本次送抵現值金額
   DEFINE l_prepaid_costs   LIKE mmau_t.mmau014   #本次儲值成本
   DEFINE l_guid1           LIKE mmau_t.mmau100   #請求ID 
   DEFINE l_guid2           LIKE mmau_t.mmau101   #處理ID
   #160819-00054#21 161004 by lori add---(S)
   DEFINE l_success         LIKE type_t.num5
   DEFINE l_slip            LIKE type_t.chr30
   DEFINE l_pcapdocno       LIKE pcap_t.pcapdocno
   DEFINE l_seq             LIKE type_t.num5
   DEFINE l_pcap            RECORD
            pcapent	       LIKE pcap_t.pcapent	 ,   #企業編號		
            pcapunit	       LIKE pcap_t.pcapunit ,   #應用組織		
            pcapsite	       LIKE pcap_t.pcapsite ,   #營運組織		
            pcapdocno       LIKE pcap_t.pcapdocno,   #單據編號		
            pcapdocdt       LIKE pcap_t.pcapdocdt,   #單據日期		
            pcap001	       LIKE pcap_t.pcap001	 ,   #調整人員		
            pcap002	       LIKE pcap_t.pcap002	 ,   #調整部門		
            pcapstus	       LIKE pcap_t.pcapstus ,   #狀態碼			
            pcapownid       LIKE pcap_t.pcapownid,   #資料所有者	
            pcapowndp       LIKE pcap_t.pcapowndp,   #資料所屬部門	
            pcapcrtid       LIKE pcap_t.pcapcrtid,   #資料建立者	
            pcapcrtdp       LIKE pcap_t.pcapcrtdp,   #資料建立部門	
            pcapcrtdt       DATETIME YEAR TO SECOND  #資料創建日
                            END RECORD
                            
   DEFINE l_pcaq            RECORD
            pcaqent	          LIKE pcaq_t.pcaqent	 ,    #企業編號		
            pcaqsite	          LIKE pcaq_t.pcaqsite ,    #營運組織		
            pcaqunit	          LIKE pcaq_t.pcaqunit ,    #應用組織		
            pcaqdocno	       LIKE pcaq_t.pcaqdocno,    #單據編號		
            pcaqseq	          LIKE pcaq_t.pcaqseq	 ,    #項次			
            pcaq001	          LIKE pcaq_t.pcaq001	 ,    #請求ID			
            pcaq002	          LIKE pcaq_t.pcaq002	 ,    #單據類型		
            pcaq003	          LIKE pcaq_t.pcaq003	 ,    #服務名			
            pcaq004	          LIKE pcaq_t.pcaq004	 ,    #請求日期		
            pcaq005	          LIKE pcaq_t.pcaq005	 ,    #請求時間		
            pcaq006	          LIKE pcaq_t.pcaq006	 ,    #請求類型		
            pcaq007	          LIKE pcaq_t.pcaq007	 ,    #請求單號		
            pcaq008	          LIKE pcaq_t.pcaq008	 ,    #使用者名,卡號,券號		
            pcaq009	          LIKE pcaq_t.pcaq009	 ,    #更新前資料	
            pcaq010	          LIKE pcaq_t.pcaq010	 ,    #更新後資料	
            pcaq011	          LIKE pcaq_t.pcaq011	 ,    #本次異動		
            pcaq012	          LIKE pcaq_t.pcaq012	 ,    #收銀機號		
            pcaq013	          LIKE pcaq_t.pcaq013	 ,    #本次消費金額	
            pcaq014	          LIKE pcaq_t.pcaq014	 ,    #狀態			
            pcaq015	          LIKE pcaq_t.pcaq015	 ,    #處理ID			
            pcaq016	          LIKE pcaq_t.pcaq016	      #異動類型		
                            END RECORD
   #160819-00054#21 161004 by lori add---(E)
   #170109-00037#7 20170113 add by beckxie---S
   #DEFINE l_pcapdocno         LIKE pcap_t.pcapdocno
   DEFINE l_session_id        LIKE type_t.num20   
   DEFINE l_session_id_str    STRING
   DEFINE l_i                 LIKE type_t.num10
   DEFINE l_sql               STRING
   DEFINE l_sql_cnt           STRING
   DEFINE l_docno_str         STRING
   DEFINE l_docno_str1        STRING
   #170109-00037#7 20170113 add by beckxie---E

   LET r_success = TRUE
   LET l_err_cnt = 0 
   CALL util.JSON.parse(p_js,l_para)   
   
   
   IF g_bgjob = 'Y' THEN
      CALL apcp510_get_data(p_js)   #取得資料來源SQL
      PREPARE apcp510_sel1 FROM g_sql
      DECLARE apcp510_sel1_cur1 CURSOR FOR apcp510_sel1
      
      CALL g_detail_d.clear()   
      LET l_ac = 1  
      FOREACH apcp510_sel1_cur1 USING g_enterprise 
                                INTO  g_detail_d[l_ac].sel     ,g_detail_d[l_ac].mmau018   ,g_detail_d[l_ac].mmau018_desc ,
                                      g_detail_d[l_ac].mmau006 ,g_detail_d[l_ac].mmau001   ,g_detail_d[l_ac].mmau004      ,
                                      g_detail_d[l_ac].mmau009 ,g_detail_d[l_ac].l_rtjf003 ,g_detail_d[l_ac].l_diff_amount 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
         
            EXIT FOREACH
         END IF
         
         LET l_ac = l_ac + 1
      END FOREACH   
      CALL g_detail_d.deleteElement(l_ac)       
   END IF  
   
   LET g_sql = "SELECT SUM(pcam013) FROM pcan_t,pcam_t ",
               " WHERE pcanent = pcament AND pcan001 = pcam001 ",
               "   AND pcanent = ",g_enterprise,
               "   AND pcanstus = 'Y' AND pcam014 = 'Y' ",
               "   AND pcam004 = ? ",   #異動日期
               "   AND pcam006 = ? ",   #異動類型
               "   AND pcam008 = ? "    #卡號
   PREPARE apcp510_sel_pcam FROM g_sql
   
   LET g_sql = "SELECT pcam001,pcam007,pcam013,pcam015, ",           #請求ID,請求單號,本次消費金額,處理ID   #160819-00054#21 161004 by lori mod
               "       pcam002,pcam003,pcam004,pcam005,pcam008, ",   #160819-00054#21 161004 by lor add
               "       pcam009,pcam010,pcam011,pcam012,pcam014 ",    #160819-00054#21 161004 by lor add
               "  FROM pcan_t,pcam_t ",   
               " WHERE pcanent = pcament AND pcan001 = pcam001 ",
               "   AND pcanent = ",g_enterprise,
               "   AND pcanstus = 'Y' AND pcam014 = 'Y' ",
               "   AND pcam004 = ? ",   #異動日期
               "   AND pcam006 = ? ",   #異動類型
               "   AND pcam008 = ? "    #卡號
   PREPARE apcp510_sel_pcam_pre FROM g_sql   
   DECLARE apcp510_sel_pcam_cur CURSOR FOR apcp510_sel_pcam_pre
   
   LET g_sql = "SELECT COUNT(*) FROM (",g_sql,") "
   PREPARE apcp510_cnt_pcam FROM g_sql
   
   LET l_cardid          = ''   #會員卡號
   LET l_txn_type        = ''   #異動類別
   LET l_docno           = ''   #異動單據編號
   LET l_value           = 0    #本次儲值金額
   LET l_discount_amount = 0    #本次儲值折扣金額
   LET l_added_val       = 0    #本次加值金額
   LET l_delivered       = 0    #本次送抵現值金額
   LET l_prepaid_costs   = 0    #本次儲值成本
   LET l_guid1           = ''   #請求ID 
   LET l_guid2           = ''   #處理ID
   
   #170109-00037#7 20170113 add by beckxie---S
   SELECT USERENV('SESSIONID') INTO l_session_id FROM DUAL
   DISPLAY "------------------------------"
   DISPLAY "SessionId: ",l_session_id
   DISPLAY "------------------------------"
   LET l_session_id_str = l_session_id
   LET l_sql = " SELECT MAX(pcapdocno)  ",
               "   FROM pcap_t  ",
               "  WHERE pcapent = ",g_enterprise,
               "    AND pcapdocno LIKE ","'%",l_session_id_str,"%'"
    
   PREPARE apcp510_pcapdocno_max_sel FROM l_sql
   #170109-00037#7 20170113 add by beckxie---E
   
   CALL cl_err_collect_init()
   CALL s_transaction_begin()

   #160819-00054#37 161026 by lori add---(S)
   IF NOT s_apcq500_upd_pcan() THEN
      CALL s_transaction_end('N','0')
      LET r_success = FALSE
      RETURN r_success   
   END IF
   #160819-00054#37 161026 by lori add---(E)
   
   #160819-00054#21 161004 by lori add---(S)
   INITIALIZE l_pcap.* TO NULL
   
   #抓取默認單別
   LET l_success = ''
   LET l_slip = ''
   CALL s_arti200_get_def_doc_type(g_site,'apct500','1') RETURNING l_success,l_slip
   IF NOT l_success THEN
      CALL s_transaction_end('N','0')
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #170109-00037#7 20170113 mark by beckxie---S
   ##自動編號
   #LET l_success = ''
   #LET l_pcapdocno = ''
   #CALL s_aooi200_gen_docno(g_site,l_slip,g_today,'apct500') RETURNING l_success,l_pcapdocno
   #IF NOT l_success THEN
   #   CALL s_transaction_end('N','0')
   #   LET r_success = FALSE
   #   RETURN r_success
   #END IF
   #170109-00037#7 20170113 mark by beckxie---E
   #170109-00037#7 20170113 add by beckxie---S
   LET l_pcapdocno = ''
   EXECUTE apcp510_pcapdocno_max_sel INTO l_pcapdocno
   #轉成字串解析
   LET l_docno_str = l_pcapdocno
   
   IF cl_null(l_docno_str) THEN
      LET l_pcap.pcapdocno= l_session_id_str.trim() CLIPPED,"_0001" 
   ELSE
      FOR l_i =1 TO l_docno_str.getlength()
         IF l_docno_str.subString(l_i,l_i) = '_' THEN
            LET l_docno_str1 = l_docno_str.subString(l_i+1,l_docno_str.getlength())+1 USING "&&&&"
            EXIT FOR
         END IF
      END FOR
      LET l_pcap.pcapdocno = l_session_id_str.trim() CLIPPED,'_',l_docno_str1.trim() USING "&&&&"
   END IF
   #170109-00037#7 20170113 add by beckxie---E
   LET l_pcap.pcapent	= g_enterprise        #企業編號		
   LET l_pcap.pcapunit	= g_site              #應用組織		
   LET l_pcap.pcapsite	= g_site              #營運組織		
   #LET l_pcap.pcapdocno = l_pcapdocno         #單據編號   #移至前面給虛擬單號,後面再gen正確的單號update  #170109-00037#7 20170113 mark by beckxie
   LET l_pcap.pcapdocdt = g_today             #單據日期		
   LET l_pcap.pcap001	= g_user              #調整人員		
   LET l_pcap.pcap002	= g_dept              #調整部門
   LET l_pcap.pcapstus	= 'N'                 #狀態碼			
   LET l_pcap.pcapownid = g_user              #資料所有者	
   LET l_pcap.pcapowndp = g_dept              #資料所屬部門	
   LET l_pcap.pcapcrtid = g_user              #資料建立者	
   LET l_pcap.pcapcrtdp = g_dept              #資料建立部門	
   LET l_pcap.pcapcrtdt = cl_get_current()    #資料創建日
   
   INSERT INTO pcap_t(pcapent, pcapunit, pcapsite, pcapdocno,pcapdocdt,
                      pcap001, pcap002	,
                      pcapstus,pcapownid,pcapowndp,pcapcrtid,pcapcrtdp,
                      pcapcrtdt)
   VALUES(l_pcap.pcapent, l_pcap.pcapunit, l_pcap.pcapsite,l_pcap.pcapdocno, l_pcap.pcapdocdt,
          l_pcap.pcap001, l_pcap.pcap002,
          l_pcap.pcapstus,l_pcap.pcapownid,l_pcap.pcapowndp,l_pcap.pcapcrtid,l_pcap.pcapcrtdp,
          l_pcap.pcapcrtdt)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "INSERT pcap_t"
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      
      CALL s_transaction_end('N','0')
      LET r_success = FALSE
      RETURN r_success
   END IF          
   
   LET l_seq = 0
   #160819-00054#21 161004 by lori add---(E)
   
   FOR li_idx = 1 TO g_detail_d.getLength()
      IF g_detail_d[li_idx].sel = 'Y' THEN
         INITIALIZE l_pcaq.* TO NULL   #160819-00054#21 161004 by lori add
         
         #1.單身差異金額不可等於零
         IF g_detail_d[li_idx].l_diff_amount = 0 THEN
            CONTINUE FOR
         END IF
         
         LET l_pcam006 = ''
         LET l_pcam013 = 0
         #2.會員卡號+異動類別+差異金額 比對apcq500中的資料,必需找到相符的資料 才能進行處理
         CASE g_detail_d[li_idx].mmau004
            WHEN '5'
               LET l_pcam006 = '4'
            WHEN '8'
               LET l_pcam006 = '3'
            WHEN 'D'
               LET l_pcam006 = '13'
         END CASE
         #170109-00037#7 20170113 add by beckxie---S
         IF NOT apcp510_lock_chk(li_idx) THEN
            LET g_detail_d[li_idx].sel = 'N'
            CONTINUE FOR
         END IF
         #170109-00037#7 20170113 add by beckxie---E
         EXECUTE apcp510_sel_pcam USING g_detail_d[li_idx].mmau006,l_pcam006,g_detail_d[li_idx].mmau001
                                  INTO l_pcam013
         IF SQLCA.sqlcode THEN
            LET l_err_cnt = l_err_cnt + 1
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.extend = "EXECUTE:apcp510_sel_pcam"
            CALL cl_err()   
            
            CONTINUE FOR
         END IF 
         
         LET l_cardid   = g_detail_d[li_idx].mmau001   #會員卡號
         LET l_txn_type = ''   #異動類別
         LET l_docno    = ''   #異動單據編號
         LET l_value    = 0    #本次儲值金額
         LET l_guid1    = ''   #請求ID 
         LET l_guid2    = ''   #處理ID
         #160819-00054#21 161004 by lori add---(S)
         LET l_pcam002  = ''
         LET l_pcam003  = ''
         LET l_pcam004  = ''
         LET l_pcam005  = ''
         LET l_pcam008  = ''
         LET l_pcam009  = ''
         LET l_pcam010  = ''
         LET l_pcam011  = ''
         LET l_pcam012  = ''
         LET l_pcam014  = ''       
         #160819-00054#21 161004 by lori add---(E)
         
         IF g_detail_d[li_idx].l_diff_amount = l_pcam013 THEN
            #1.當異動類別 = 8.銷售儲值付款時
            #     差異金額小於零,進行取消"卡付款"的異動
            #  ELSE
            #     差異金額大於零,進行取消"儲值"的異動
            #     差異金額小於零,進行取消"反儲值"的異動
            
            #異動類別
            IF g_detail_d[li_idx].mmau004 = '8' THEN
               IF g_detail_d[li_idx].l_diff_amount < 0 THEN
                  LET l_txn_type = g_detail_d[li_idx].mmau004
               END IF 
            ELSE
               IF g_detail_d[li_idx].l_diff_amount > 0 THEN
                  LET l_txn_type = '5'
               ELSE
                  LET l_txn_type = 'C'
               END IF
            END IF     
             
            LET l_cnt1 = 0   
            LET l_cnt2 = 0
            EXECUTE apcp510_cnt_pcam USING g_detail_d[li_idx].mmau006,l_pcam006,g_detail_d[li_idx].mmau001
                                     INTO l_cnt1
            IF SQLCA.sqlcode THEN
               LET l_err_cnt = l_err_cnt + 1
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.extend = "EXECUTE:apcp510_cnt_pcam"
               CALL cl_err()   
               
               CONTINUE FOR
            END IF                                       
                                     
            FOREACH apcp510_sel_pcam_cur USING g_detail_d[li_idx].mmau006,l_pcam006,g_detail_d[li_idx].mmau001
                                         INTO l_guid1,  l_docno,  l_value,  l_guid2,               #160819-00054#21 161004 by lori mod
                                              l_pcam002,l_pcam003,l_pcam004,l_pcam005,l_pcam008,   #160819-00054#21 161004 by lori 
                                              l_pcam009,l_pcam010,l_pcam011,l_pcam012,l_pcam014    #160819-00054#21 161004 by lori 
               IF SQLCA.sqlcode THEN
                  LET l_err_cnt = l_err_cnt + 1
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.extend = "FOREACH:apcp510_sel_pcam_cur"
                  CALL cl_err()   
                  
                  EXIT FOREACH
               END IF         
               
               #160819-00054#21 161004 by lori mark---(S)
               #IF NOT s_card_value_del(l_cardid,   l_txn_type, l_docno,        l_value,l_discount_amount,         #會員卡號,異動類別,異動單據編號,本次儲值金額,本次儲值折扣金額
               #                        l_added_val,l_delivered,l_prepaid_costs,l_guid1,l_guid2) THEN              #本次加值金額,本次送抵現值金額),本次儲值成本,请求ID,处理ID
               #   
               #   LET l_err_cnt = l_err_cnt + 1
               #ELSE 
               #   LET l_cnt2 = l_cnt2 + 1
               #END IF
               #160819-00054#21 161004 by lori mark---(E)
               
               #160819-00054#21 161004 by lori add---(S)
               LET l_pcaq.pcaqent   = l_pcap.pcapent      #企業編號		
               LET l_pcaq.pcaqsite  = l_pcap.pcapunit     #營運組織		
               LET l_pcaq.pcaqunit  = l_pcap.pcapsite     #應用組織		
               LET l_pcaq.pcaqdocno = l_pcap.pcapdocno    #單據編號		
               LET l_pcaq.pcaqseq	= l_seq + 1           #項次			
               LET l_pcaq.pcaq001	= l_guid1             #請求ID			
               LET l_pcaq.pcaq002	= l_pcam002           #單據類型		
               LET l_pcaq.pcaq003	= l_pcam003           #服務名			
               LET l_pcaq.pcaq004	= l_pcam004           #請求日期		
               LET l_pcaq.pcaq005	= l_pcam005           #請求時間		
               LET l_pcaq.pcaq006	= l_pcam006           #請求類型		
               LET l_pcaq.pcaq007	= l_docno            #請求單號		
               LET l_pcaq.pcaq008	= l_pcam008          #使用者名,卡號,券號		
               LET l_pcaq.pcaq009	= l_pcam009          #更新前資料	
               LET l_pcaq.pcaq010	= l_pcam010          #更新後資料	
               LET l_pcaq.pcaq011	= l_pcam011          #本次異動		
               LET l_pcaq.pcaq012	= l_pcam012          #收銀機號		
               LET l_pcaq.pcaq013	= l_pcam013          #本次消費金額	
               LET l_pcaq.pcaq014	= l_pcam014          #狀態			
               LET l_pcaq.pcaq015	= l_guid2            #處理ID			
               LET l_pcaq.pcaq016	= '2'                #異動類型(1.補錄 2.還原)
               
               INSERT INTO pcaq_t (pcaqent,pcaqsite,pcaqunit,pcaqdocno,pcaqseq,
                                   pcaq001,pcaq002, pcaq003, pcaq004,  pcaq005,
                                   pcaq006,pcaq007, pcaq008, pcaq009,  pcaq010,
                                   pcaq011,pcaq012, pcaq013, pcaq014,  pcaq015,
                                   pcaq016)
               VALUES(l_pcaq.pcaqent,l_pcaq.pcaqsite,l_pcaq.pcaqunit,l_pcaq.pcaqdocno,l_pcaq.pcaqseq,
                      l_pcaq.pcaq001,l_pcaq.pcaq002, l_pcaq.pcaq003, l_pcaq.pcaq004,  l_pcaq.pcaq005,
                      l_pcaq.pcaq006,l_pcaq.pcaq007, l_pcaq.pcaq008, l_pcaq.pcaq009,  l_pcaq.pcaq010,
                      l_pcaq.pcaq011,l_pcaq.pcaq012, l_pcaq.pcaq013, l_pcaq.pcaq014,  l_pcaq.pcaq015,
                      l_pcaq.pcaq016)        
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = "INSERT pcaq_t"
                  LET g_errparam.code   = SQLCA.sqlcode
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  
                  LET l_err_cnt = l_err_cnt + 1                  
                  LET l_seq = l_seq - 1
               ELSE
                  LET l_cnt2 = l_cnt2 + 1               
               END IF                      
               #160819-00054#21 161004 by lori add---(E)
            END FOREACH
            
            #2.異動成功時,將對應的pcan_t的pcanstus的狀態碼 更新為'X',代表調整完畢 
            IF l_cnt1 = l_cnt2 THEN
               UPDATE pcan_t
                  SET pcanstus = 'X'
                WHERE EXISTS(SELECT 1 FROM pcam_t 
                              WHERE pcament = pcanent   AND pcam001 = pcan001
                                AND pcam014 = 'Y'       AND pcam004 = g_detail_d[li_idx].mmau006
                                AND pcam006 = l_pcam006 AND pcam008 = g_detail_d[li_idx].mmau001)   
                  AND pcanstus = 'Y'
               
               IF SQLCA.sqlcode THEN
                  LET l_err_cnt = l_err_cnt + 1
               END IF  
            END IF               
         ELSE
            LET l_err_cnt = l_err_cnt + 1
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "apc-00098"
            CALL cl_err()   
            
            CONTINUE FOR         
         END IF               
      END IF
   END FOR
   
   #170109-00037#7 20170113 add by beckxie---S
   #必須將虛擬單號update為gen出來的單號
   #更新docno
   IF NOT cl_null(l_session_id_str) THEN
      LET l_sql = " SELECT DISTINCT pcapdocno ",
                 "   FROM pcap_t  ",
                 "  WHERE pcapent = ",g_enterprise,
                 "    AND pcapdocno LIKE ","'%",l_session_id_str,"%'"
      PREPARE apcp510_docno_sel_pre FROM l_sql
      DECLARE apcp510_docno_sel_cur CURSOR FOR apcp510_docno_sel_pre
      
      LET l_pcapdocno = ''
      FOREACH apcp510_docno_sel_cur INTO l_pcapdocno
      
         #自動編號
         LET l_success = ''
         LET l_pcap.pcapdocno = ''
         CALL s_aooi200_gen_docno(g_site,l_slip,g_today,'apct500') RETURNING l_success,l_pcap.pcapdocno
         IF NOT l_success THEN
            LET l_err_cnt = l_err_cnt + 1
            CALL s_transaction_end('N','0')
            LET r_success = FALSE
            RETURN r_success
         END IF
         
         #update pcapdocno
         UPDATE pcap_t SET pcapdocno = l_pcap.pcapdocno
          WHERE pcapent = g_enterprise
            AND pcapdocno = l_pcapdocno
         IF SQLCA.sqlcode THEN
            LET l_err_cnt = l_err_cnt + 1
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'upd pcapdocno'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
            EXIT FOREACH         
         END IF
         #update pcaqdocno
         UPDATE pcaq_t SET pcaqdocno = l_pcap.pcapdocno
          WHERE pcaqent = g_enterprise
            AND pcaqdocno = l_pcapdocno
         IF SQLCA.sqlcode THEN
            LET l_err_cnt = l_err_cnt + 1
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'upd pcaqdocno'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
            EXIT FOREACH         
         END IF
         #DISPLAY "pcapdocno :",l_pcap.pcapdocno
      END FOREACH
   END IF
   #170109-00037#7 20170113 add by beckxie---E
   
   CALL cl_err_collect_show()       
   IF l_err_cnt > 0 THEN
      LET r_success = FALSE
      CALL s_transaction_end('N',0)   
   ELSE
      CALL s_transaction_end('Y',0)      
   END IF
   
   RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: 取得要處理的資料SQL
# Memo...........: g_bgjob = Y, 直接取出差異的內容進行處理
#                  g_bgjob = N, 依查詢方案條件過濾取出資料,由user勾選要處理的資料
#                  由g_sql組出SQL,不須額外的回傳值
# Usage..........: CALL apcp510_get_data(p_js)
# Input parameter: p_js     g_master條件
# Return code....: 無
# Date & Author..: 2016/09/19 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION apcp510_get_data(p_js)
   DEFINE p_js               STRING
   DEFINE l_para             type_parameter
   DEFINE l_sql_mmau         STRING
   DEFINE l_sql_rtif         STRING
   DEFINE l_sql_mmau004      STRING
   DEFINE l_sql_mmau004_1    STRING
   DEFINE l_wc               STRING
   DEFINE l_sel              LIKE type_t.chr1     

   IF g_bgjob = "Y" THEN
      CALL util.JSON.parse(p_js,l_para)
      LET l_para.l_diff = 'Y'   #只針對有差異的部分進行處理
       
      LET l_sel = 'Y'     
   ELSE
      LET l_para.mmau018     = g_master.mmau018     
      LET l_para.mmau001     = g_master.mmau001     
      LET l_para.l_date_s    = g_master.l_date_s    
      LET l_para.l_date_e    = g_master.l_date_e    
      LET l_para.l_mmau004_1 = g_master.l_mmau004_1 
      LET l_para.l_mmau004_2 = g_master.l_mmau004_2 
      LET l_para.l_mmau004_3 = g_master.l_mmau004_3 
      LET l_para.l_diff      = g_master.l_diff      
      LET l_para.wc          = g_master.wc          
        
      LET l_sel = 'N'   
   END IF 
   
   #異動類別條件
   LET l_sql_mmau004 = ""
   IF l_para.l_mmau004_1 = 'Y' THEN
      #銷售儲值付款
      LET l_sql_mmau004 = " mmau004 = '8' "
   END IF

   IF l_para.l_mmau004_2 = 'Y' THEN
      #卡充值
      IF cl_null(l_sql_mmau004) THEN
         LET l_sql_mmau004 = " mmau004 = '5' "
      ELSE   
         LET l_sql_mmau004 = l_sql_mmau004," OR mmau004 = '5' "
      END IF   
   END IF 

   IF l_para.l_mmau004_3 = 'Y' THEN
      #找零轉儲
      IF cl_null(l_sql_mmau004) THEN
         LET l_sql_mmau004 = " mmau004 = 'D' "
      ELSE   
         LET l_sql_mmau004 = l_sql_mmau004," OR mmau004 = 'D' "
      END IF   
   END IF
   
   IF cl_null(l_sql_mmau004) THEN
      LET l_sql_mmau004 = " 1=1 "
   END IF
   
   IF cl_null(l_para.wc) THEN
      LET l_para.wc = " 1=1 "
   END IF
   
   #會員卡儲值異動檔
   LET l_sql_mmau = "SELECT mmauent txn_ent,mmau018 txn_org,TO_DATE(TO_CHAR(mmau006, 'YYYY/MM/DD')) txn_date,mmau001 card_id,mmau004 txn_type, ",
                     "      SUM(mmau009) mem_amount ",
                    "  FROM mmau_t ",
                    "  WHERE mmauent = ",g_enterprise,
                    "  AND ", l_para.wc,
                    "  AND (",l_sql_mmau004,") "
                    
   IF NOT cl_null(l_para.l_date_s) THEN
      LET l_sql_mmau = l_sql_mmau,
                    "  AND TO_DATE(TO_CHAR(mmau006,'YYYY/MM/DD'),'YYYY/MM/DD') >= '",l_para.l_date_s,"' "
   END IF

   IF NOT cl_null(l_para.l_date_e) THEN
      LET l_sql_mmau = l_sql_mmau,
                    "  AND TO_DATE(TO_CHAR(mmau006,'YYYY/MM/DD'),'YYYY/MM/DD') <= '",l_para.l_date_e,"' "
   END IF

   LET l_sql_mmau = l_sql_mmau,      
                    "  GROUP BY mmauent,mmau018,mmau006,mmau001,mmau004 "
   
  #DISPLAY "Source mmau_t: ",l_sql_mmau
   
   #銷售交易收款明細檔
   LET l_wc = cl_replace_str(l_para.wc,"mmau018","rtjfsite")
   LET l_wc = cl_replace_str(l_wc,"mmau001","rtjf014")
   LET l_sql_mmau004_1 = cl_replace_str(l_sql_mmau004,"mmau004","txn_type")
   
   LET l_sql_rtif = "SELECT rtjfent txn_ent,rtjfsite txn_org,rtjadocdt txn_date,rtjf014 card_id,txn_type, ",
                    "       SUM(rtjf003) doc_amount ",
                    "  FROM (SELECT rtjfent,rtjfsite,rtjadocdt,rtjf014, ",
                    "              (CASE ",
                    "                    WHEN rtja000 = 'artt610' THEN '8' ",   #卡付款
                    "                    WHEN rtja000 = 'ammt425' AND rtja055 = 'N' THEN '5' ",   #儲值
                    "                    WHEN rtja000 = 'ammt425' AND rtja055 = 'Y' THEN 'D' ",   #找零轉儲  
                    "                 END) txn_type, ",
                    "              rtjf003 ",
                    "         FROM rtjf_t,rtja_t ",
                    "        WHERE rtjfent = rtjaent AND rtjfdocno = rtjadocno ", 
                    "          AND rtjfent = ",g_enterprise,
                    "          AND rtja000 IN ('artt610','ammt425') ",
                    "          AND rtjastus <> 'X' ",
                    "          AND ",l_wc                  
   IF NOT cl_null(l_para.l_date_s) THEN
      LET l_sql_rtif = l_sql_rtif,
                    "          AND TO_DATE(TO_CHAR(rtjadocdt,'YYYY/MM/DD'),'YYYY/MM/DD') >= '",l_para.l_date_s,"' "
   END IF
   
   IF NOT cl_null(l_para.l_date_e) THEN
      LET l_sql_rtif = l_sql_rtif,
                    "          AND TO_DATE(TO_CHAR(rtjadocdt,'YYYY/MM/DD'),'YYYY/MM/DD') <= '",g_master.l_date_e,"' "
   END IF         

   LET l_sql_rtif = l_sql_rtif,
                    "        ) ",
                    " WHERE (",l_sql_mmau004_1,") ",
                    "GROUP BY rtjfent,rtjfsite,rtjadocdt,rtjf014,txn_type "
                    
  #DISPLAY "Source rtif_t: ",l_sql_rtif 

   LET g_sql = "SELECT UNIQUE '",l_sel,"',txn_org,   ",
               "             (SELECT ooefl003 FROM ooefl_t WHERE ooeflent = txn_ent ",
               "                 AND ooefl001 = txn_org AND ooefl002 = '",g_dlang,"'), ",
               "              txn_date, card_id, txn_type, mem_amount, doc_amount,",
               "              mem_amount-doc_amount diff_amount ",
               "  FROM ( SELECT t1.txn_ent,t1.txn_org, t1.txn_date, t1.card_id, t1.txn_type, ",
               "                COALESCE(t1.mem_amount,0) mem_amount, COALESCE(t2.doc_amount,0) doc_amount ",
               "          FROM (",l_sql_mmau,") t1 ",
               "               LEFT JOIN (",l_sql_rtif,") t2 ",
               "                      ON t1.txn_ent  = t2.txn_ent   AND t1.txn_org = t2.txn_org ",
               "                     AND t1.txn_date = t2.txn_date AND t1.card_id = t2.card_id ",
               "                     AND t1.txn_type = t2.txn_type",
               "         UNION ALL ",
               "         SELECT t1.txn_ent,t1.txn_org, t1.txn_date, t1.card_id, t1.txn_type, ",
               "                COALESCE(t2.mem_amount,0) mem_amount, COALESCE(t1.doc_amount,0) doc_amount ",
               "          FROM (",l_sql_rtif,") t1 ",
               "               LEFT JOIN (",l_sql_mmau,") t2 ",
               "                      ON t1.txn_ent  = t2.txn_ent   AND t1.txn_org = t2.txn_org ",
               "                     AND t1.txn_date = t2.txn_date AND t1.card_id = t2.card_id ",
               "                     AND t1.txn_type = t2.txn_type",               
               "       ) ",
               " WHERE txn_ent = ? "
               
               
   IF l_para.l_diff = 'Y' THEN
      LET g_sql = g_sql,
               "   AND mem_amount <> doc_amount "   
   END IF  

   LET g_sql = g_sql,
               " ORDER BY txn_date,card_id,txn_type "    

   
   DISPLAY "Source SQL: ",g_sql
END FUNCTION
################################################################################
# Descriptions...: 檢查該筆(p_ac)的pcam_t是否被lock
# Memo...........:
# Usage..........: CALL apcp510_lock_chk(p_ac) RETURNING r_success
# Input parameter: p_ac           列(l_ac)
# Return code....: r_success      TRUE/FALSE (#TRUE=沒有被LOCK; #FALSE=被LOCK)
# Date & Author..: #170109-00037#7 20170113 add by beckxie
# Modify.........:
################################################################################
PRIVATE FUNCTION apcp510_lock_chk(p_ac)
   DEFINE p_ac        LIKE type_t.num10
   DEFINE l_pcam006   LIKE pcam_t.pcam006
   DEFINE l_pcam001   LIKE pcam_t.pcam001
   DEFINE l_pcam001_1 LIKE pcam_t.pcam001
   DEFINE l_pcam015   LIKE pcam_t.pcam015
   DEFINE l_colname   STRING
   DEFINE l_comment   STRING 
   DEFINE r_success   LIKE type_t.num5
   
   LET r_success = TRUE
   
   #取欄位名稱,title
   #單據編號
   LET l_colname = ''
   CALL s_azzi902_get_gzzd(g_prog,'lbl_mmau001')  RETURNING l_colname,l_comment
   LET g_coll_title[1] = l_colname
   LET l_colname = ''
   CALL s_azzi902_get_gzzd(g_prog,'lbl_mmau006')  RETURNING l_colname,l_comment
   LET g_coll_title[2] = l_colname
   
   #若單號為空,防呆
   LET l_pcam006 = ''
   #2.會員卡號+異動類別+差異金額 比對apcq500中的資料,必需找到相符的資料 才能進行處理
   CASE g_detail_d[p_ac].mmau004
      WHEN '5'
         LET l_pcam006 = '4'
      WHEN '8'
         LET l_pcam006 = '3'
      WHEN 'D'
         LET l_pcam006 = '13'                  
   END CASE
   IF cl_null(g_detail_d[p_ac].mmau006) OR cl_null(l_pcam006) OR cl_null(g_detail_d[p_ac].mmau001) THEN
      RETURN r_success
   END IF
   
   LET l_pcam001 = ''
   LET l_pcam015 = ''
   FOREACH apcp510_sel_pcam_cur1 USING g_detail_d[p_ac].mmau006,l_pcam006,g_detail_d[p_ac].mmau001 
                                 INTO l_pcam001,l_pcam015
      LET l_pcam001_1 = ''
      EXECUTE apcp510_chk_lock_pcam USING l_pcam001,l_pcam015 INTO l_pcam001_1
      CASE SQLCA.sqlcode 
         WHEN 100 
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'sub-00115'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            LET g_errparam.coll_vals[1] = g_detail_d[p_ac].mmau001
            LET g_errparam.coll_vals[2] = g_detail_d[p_ac].mmau006
            CALL cl_err()
         OTHERWISE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'excute apcp510_chk_lock_pcam'
            LET g_errparam.popup = TRUE
            CALL cl_err()
      END CASE
      
      IF cl_null(l_pcam001_1) THEN
         #FALSE=被LOCK
         LET r_success = FALSE
      END IF
      
      LET l_pcam001 = ''
      LET l_pcam015 = ''
   END FOREACH
      
   
   RETURN r_success
END FUNCTION

#end add-point
 
{</section>}
 
