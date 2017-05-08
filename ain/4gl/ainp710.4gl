#該程式未解開Section, 採用最新樣板產出!
{<section id="ainp710.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2015-02-11 01:48:15), PR版次:0002(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000047
#+ Filename...: ainp710
#+ Description: 隨貨同行單批次拋轉作業
#+ Creator....: 04226(2015-02-06 17:38:20)
#+ Modifier...: 04226 -SD/PR- 00000
 
{</section>}
 
{<section id="ainp710.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#Memos
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
     l_sdate        LIKE indc_t.indc022,       #起始日期
     l_edate        LIKE indc_t.indc022,       #截止日期
     l_type1        LIKE type_t.chr1,          #越庫調撥單
     l_type2        LIKE type_t.chr1,          #配送調撥單
     l_type3        LIKE type_t.chr1,          #其他兩階段調撥單
   #end add-point
        wc               STRING
                     END RECORD
 
TYPE type_g_detail_d RECORD
#add-point:自定義模組變數(Module Variable)  #注意要在add-point內寫入END RECORD name="global.variable"
     sel               LIKE type_t.chr1,        #選擇
     indc002           LIKE indc_t.indc002,     #來源類型
     indcdocno         LIKE indc_t.indcdocno,   #調撥單號
     indc006           LIKE indc_t.indc006,     #撥入營運組織
     indc006_desc      LIKE ooefl_t.ooefl003,   #撥入營運組織名稱
     indc021           LIKE indc_t.indc021,     #撥出確認人員
     indc021_desc      LIKE ooag_t.ooag011,     #撥出確認人員全名
     indc022           LIKE indc_t.indc022,     #撥出確認日期
     indc008           LIKE indc_t.indc008      #備註
                       END RECORD
TYPE type_g_detail2_d  RECORD
     inddseq           LIKE indd_t.inddseq,     #項次
     indd003           LIKE indd_t.indd003,     #商品條碼
     indd002           LIKE indd_t.indd002,     #商品編號
     indd002_desc      LIKE imaal_t.imaal003,   #商品品名
     indd002_desc_desc LIKE imaal_t.imaal004,   #商品規格
     indd004           LIKE indd_t.indd004,     #產品特徵
     indd006           LIKE indd_t.indd006,     #庫存單位
     indd006_desc      LIKE oocal_t.oocal003,   #庫存單位名稱
     indd007           LIKE indd_t.indd007,     #包裝單位
     indd007_desc      LIKE oocal_t.oocal003,   #包裝單位名稱
     indd020           LIKE indd_t.indd020,     #撥出包裝數量
     indd021           LIKE indd_t.indd021      #撥出庫存數量
                       END RECORD
DEFINE g_detail2_d     DYNAMIC ARRAY OF type_g_detail2_d
DEFINE g_parameter     type_parameter
DEFINE g_detail2_cnt   LIKE type_t.num5
DEFINE g_detail_idx    LIKE type_t.num5
DEFINE g_detail_idx2   LIKE type_t.num5
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="ainp710.main" >}
#+ 作業開始 
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   DEFINE ls_js  STRING
   #add-point:main段define name="main.define"
   DEFINE l_success LIKE type_t.num5   #150308-00001#3 150309 pomelo add
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ain","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_ainp710 WITH FORM cl_ap_formpath("ain",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL ainp710_init()   
 
      #進入選單 Menu (="N")
      CALL ainp710_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_ainp710
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   CALL ainp710_drop_temp_table()
   CALL s_aooi500_drop_temp() RETURNING l_success   #150308-00001#3 150309 pomelo add
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="ainp710.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION ainp710_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   DEFINE l_success LIKE type_t.num5   #150308-00001#3 150309 pomelo add
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('b_indc002','6016')
   #建立temp table
   CALL ainp710_create_temp_table()
   CALL s_aooi500_create_temp() RETURNING l_success   #150308-00001#3 150309 pomelo add
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="ainp710.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION ainp710_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_success        LIKE type_t.num5
   DEFINE l_docno_str      STRING
   DEFINE l_cnt            LIKE type_t.num5
   DEFINE la_param         RECORD
          prog             STRING,
          param            DYNAMIC ARRAY OF STRING
                           END RECORD
   DEFINE ls_js            STRING
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL ainp710_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT BY NAME g_wc ON indc006
         
            ON ACTION controlp INFIELD indc006
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               IF s_aooi500_setpoint(g_prog,'indc006') THEN
                  LET g_qryparam.where = s_aooi500_q_where(g_prog,'indc006',g_site,'c') #150308-00001#3 150309 pomelo add 'c'
                  CALL q_ooef001_24()
               ELSE
                  LET g_qryparam.where = " ooef211 = 'Y' AND ooefstus = 'Y'"
                  CALL q_ooef001()
               END IF
               DISPLAY g_qryparam.return1 TO indc006
               NEXT FIELD indc006
               
         END CONSTRUCT
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT BY NAME g_parameter.l_sdate, g_parameter.l_edate,
                       g_parameter.l_type1, g_parameter.l_type2,
                       g_parameter.l_type3
         
            ON CHANGE l_sdate
               IF NOT cl_null(g_parameter.l_sdate) AND NOT cl_null(g_parameter.l_edate) THEN
                  IF g_parameter.l_sdate > g_parameter.l_edate THEN
                     #起始日期不能大於截止日期！
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "acr-00068"
                     LET g_errparam.extend = ""
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD sdate
                  END IF
               END IF
            
            ON CHANGE l_edate
               IF NOT cl_null(g_parameter.l_sdate) AND NOT cl_null(g_parameter.l_edate) THEN
                  IF g_parameter.l_sdate > g_parameter.l_edate THEN
                     #起始日期不能大於截止日期！
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "acr-00068"
                     LET g_errparam.extend = ""
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD l_edate
                  END IF
               END IF
            
            ON CHANGE l_type1
               IF g_parameter.l_type1 = 'N' AND g_parameter.l_type2 = 'N' AND 
                  g_parameter.l_type3 = 'N' THEN
                  
                  #越庫採購訂單 或 配送單 或 兩段調撥單 必須有一個有勾選！
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "ain-00441"
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_parameter.l_type1 = 'Y'
                  NEXT FIELD l_type1
               END IF
            
            ON CHANGE l_type2
               IF g_parameter.l_type1 = 'N' AND g_parameter.l_type2 = 'N' AND 
                  g_parameter.l_type3 = 'N' THEN
                  
                  #越庫採購訂單 或 配送單 或 兩段調撥單 必須有一個有勾選！
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "ain-00441"
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_parameter.l_type2 = 'Y'
                  NEXT FIELD l_type2
               END IF
            
            ON CHANGE l_type3
               IF g_parameter.l_type1 = 'N' AND g_parameter.l_type2 = 'N' AND 
                  g_parameter.l_type3 = 'N' THEN
                  
                  #越庫採購訂單 或 配送單 或 兩段調撥單 必須有一個有勾選！
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "ain-00441"
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_parameter.l_type3 = 'Y'
                  NEXT FIELD l_type3
               END IF
            
         END INPUT
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         INPUT ARRAY g_detail_d FROM s_detail1.*
             ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                     INSERT ROW = FALSE,DELETE ROW = FALSE, APPEND ROW = FALSE)
            BEFORE INPUT
               LET g_current_page = 1
               CALL cl_set_act_visible("filter",FALSE)

            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_detail_d.getLength() TO FORMONLY.h_count
               LET g_master_idx = l_ac
               CALL ainp710_fetch()
               
            ON CHANGE sel
               CALL ainp710_ins_sel(l_ac)
         END INPUT
         
         DISPLAY ARRAY g_detail2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)

            BEFORE DISPLAY
               LET g_current_page = 2
               CALL cl_set_act_visible("filter",FALSE)

            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               DISPLAY g_detail2_d.getLength() TO FORMONLY.cnt
         END DISPLAY
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
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_parameter.l_type1 = 'Y'
            LET g_parameter.l_type2 = 'Y'
            LET g_parameter.l_type3 = 'Y'
            DISPLAY BY NAME g_parameter.l_type1,g_parameter.l_type2,g_parameter.l_type3
            #end add-point
 
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            #add-point:ui_dialog段on action selall name="ui_dialog.selall.befroe"
            
            #end add-point            
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
               #add-point:ui_dialog段on action selall name="ui_dialog.for.onaction_selall"
               CALL ainp710_ins_sel(li_idx)
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "N"
               #add-point:ui_dialog段on action selnone name="ui_dialog.for.onaction_selnone"
               CALL ainp710_ins_sel(li_idx)
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
            LET l_ac = DIALOG.getCurrentRow("s_detail1")
            IF l_ac > 0 THEN
               CALL ainp710_ins_sel(l_ac)
            END IF
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "N"
               END IF
            END FOR
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            LET l_ac = DIALOG.getCurrentRow("s_detail1")
            IF l_ac > 0 THEN
               CALL ainp710_ins_sel(l_ac)
            END IF
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL ainp710_filter()
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
            CALL g_curr_diag.setCurrentRow("s_detail1",1)
            #end add-point
            CALL ainp710_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL ainp710_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            LET l_cnt = 0
            SELECT COUNT(*) INTO l_cnt
              FROM ainp710_tmp
            IF l_cnt = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "abm-00098"
               LET g_errparam.extend = ""
               LET g_errparam.popup = TRUE
               CALL cl_err()
               CONTINUE DIALOG
            END IF
            CALL s_transaction_begin()
            CALL cl_err_collect_init()
            LET l_success = ''
            LET l_docno_str = ''
            CALL ainp710_process() RETURNING l_success,l_docno_str
            IF l_success THEN
               LET l_success = ''
               CALL ainp710_del_tmp()
               CALL s_transaction_end('Y','1')
               IF NOT cl_null(l_docno_str) THEN
                  LET la_param.prog = 'aint710'
                  LET la_param.param[1] = ''
                  LET la_param.param[2] = l_docno_str
                  LET ls_js = util.JSON.stringify(la_param)
                  CALL cl_cmdrun(ls_js)
               END IF
               CALL ainp710_b_fill()
            ELSE
               CALL s_transaction_end('N','1')
            END IF
            CALL cl_err_collect_show()
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
 
{<section id="ainp710.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION ainp710_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   #end add-point
        
   LET g_error_show = 1
   CALL ainp710_b_fill()
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
 
{<section id="ainp710.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION ainp710_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE l_type_sql      STRING
   DEFINE l_ooef_sql      STRING
   DEFINE l_date_sql      STRING
   DEFINE l_where         STRING
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   #1.調撥單類型
   LET l_type_sql = ''
   # 1-1.越庫調撥單
   IF g_parameter.l_type1 = 'Y' THEN
      LET l_type_sql = " indc002 = '5'"
   END IF
   # 1-2.配送調撥單
   IF g_parameter.l_type2 = 'Y' THEN
      IF cl_null(l_type_sql) THEN
         LET l_type_sql = l_type_sql," indc002 = '4'"
      ELSE
         LET l_type_sql = l_type_sql," OR indc002 = '4'"
      END IF
   END IF
   # 1-3.其它兩階段調撥單
   IF g_parameter.l_type3 = 'Y' THEN
      IF cl_null(l_type_sql) THEN
         LET l_type_sql = l_type_sql," indc002 = '1' OR indc002 = '2'"
      ELSE
         LET l_type_sql = l_type_sql," OR indc002 = '1' OR indc002 = '2'"
      END IF
   END IF
   # 1-4.組SQL
   LET l_type_sql = "(",l_type_sql,")"
   
   #2.組織SQL
   IF s_aooi500_setpoint(g_prog,'indc006') THEN
      LET l_ooef_sql = s_aooi500_q_where(g_prog,'indc006',g_site,'c') #150308-00001#3 150309 pomelo add 'c'
   ELSE
      LET l_ooef_sql = " ooef211 = 'Y' AND ooefstus = 'Y'"
   END IF
   
   #3.確認日期
   LET l_date_sql = " 1=1"
   IF NOT cl_null(g_parameter.l_sdate) AND NOT cl_null(g_parameter.l_edate) THEN
      LET l_date_sql = l_date_sql," AND indc022 BETWEEN '",g_parameter.l_sdate,"'",
                                  "                 AND '",g_parameter.l_edate,"'"
   ELSE
      IF NOT cl_null(g_parameter.l_sdate) THEN
         LET l_date_sql = l_date_sql," AND indc022 >= '",g_parameter.l_sdate,"'"
      END IF
      
      IF NOT cl_null(g_parameter.l_edate) THEN
         LET l_date_sql = l_date_sql," AND indc022 <= '",g_parameter.l_edate,"'"
      END IF
   END IF
   LET l_where = g_wc," AND ",l_type_sql,
                      " AND ",l_ooef_sql,
                      " AND ",l_date_sql
   
   #4.撈取單身SQL
   LET g_sql = "SELECT 'N',     indc002,    indcdocno, indc006, t1.ooefl003,",
               "       indc021, t2.ooag011, indc022,   indc008",
               "  FROM indc_t",
               "  LEFT OUTER JOIN ooefl_t t1 ON t1.ooeflent = indcent",
               "                            AND t1.ooefl001 = indc006",
               "                            AND t1.ooefl002 = '",g_dlang,"'",
               "  LEFT OUTER JOIN ooag_t  t2 ON t2.ooagent = indcent",
               "                            AND t2.ooag001 = indc021",
               "  LEFT OUTER JOIN ooef_t ON ooefent = indcent",
               "                        AND ooef001 = indc006",
               " WHERE indcent = ?",
               "   AND indcstus = 'O'",
               "   AND indc005 = '",g_site,"'",
               "   AND indcsite = indc006",
               "   AND ",l_where CLIPPED,
               "   AND NOT EXISTS(SELECT 1",
               "                    FROM infm_t,infp_t",
               "                   WHERE infment = infpent",
               "                     AND infmdocno = infpdocno",
               "                     AND infpent = indcent",
               "                     AND infp002 = indcdocno",
               "                     AND infmstus != 'X')",
               " ORDER BY indc002"
   #end add-point
 
   PREPARE ainp710_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR ainp710_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   CALL ainp710_del_tmp()
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
      g_detail_d[l_ac].sel,          g_detail_d[l_ac].indc002,      g_detail_d[l_ac].indcdocno,
      g_detail_d[l_ac].indc006,      g_detail_d[l_ac].indc006_desc, g_detail_d[l_ac].indc021,
      g_detail_d[l_ac].indc021_desc, g_detail_d[l_ac].indc022,      g_detail_d[l_ac].indc008
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
      
      CALL ainp710_detail_show()      
 
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
   FREE ainp710_sel
   
   LET l_ac = 1
   CALL ainp710_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="ainp710.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION ainp710_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define name="fetch.define"
 
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後 name="fetch.after_fill"
   CALL g_detail2_d.clear()
   IF g_detail_idx = 0 THEN
      LET g_detail_idx = 1
   END IF
   
   LET g_sql = "SELECT inddseq, indd003, indd002,     t1.imaal003, t1.imaal004,",
               "       indd004, indd006, t2.oocal003, indd007,     t3.oocal003,",
               "       indd020, indd021",
               "  FROM indd_t",
               "  LEFT OUTER JOIN imaal_t t1 ON t1.imaalent = inddent",
               "                            AND t1.imaal001 = indd002",
               "                            AND t1.imaal002 = '",g_dlang,"'",
               "  LEFT OUTER JOIN oocal_t t2 ON t2.oocalent = inddent",
               "                            AND t2.oocal001 = indd006",
               "                            AND t2.oocal002 = '",g_dlang,"'",
               "  LEFT OUTER JOIN oocal_t t3 ON t3.oocalent = inddent",
               "                            AND t3.oocal001 = indd007",
               "                            AND t3.oocal002 = '",g_dlang,"'",
               " WHERE inddent = ",g_enterprise,
               "   AND indddocno = '",g_detail_d[g_detail_idx].indcdocno,"'",
               " ORDER BY inddseq"
   PREPARE ainp710_b_fill_pre FROM g_sql
   DECLARE ainp710_b_fill_cs CURSOR FOR ainp710_b_fill_pre
   
   LET l_ac = 1
   FOREACH ainp710_b_fill_cs
      INTO g_detail2_d[l_ac].inddseq,           g_detail2_d[l_ac].indd003,
           g_detail2_d[l_ac].indd002,           g_detail2_d[l_ac].indd002_desc,
           g_detail2_d[l_ac].indd002_desc_desc, g_detail2_d[l_ac].indd004,
           g_detail2_d[l_ac].indd006,           g_detail2_d[l_ac].indd006_desc,
           g_detail2_d[l_ac].indd007,           g_detail2_d[l_ac].indd007_desc,
           g_detail2_d[l_ac].indd020,           g_detail2_d[l_ac].indd021
      
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ""
            LET g_errparam.popup = TRUE
            CALL cl_err()

         END IF
         EXIT FOREACH
      END IF
   END FOREACH
   
   CALL g_detail2_d.deleteElement(l_ac)
   LET g_detail2_cnt = l_ac - 1
   DISPLAY g_detail2_cnt TO FORMONLY.cnt
   #end add-point 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="ainp710.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION ainp710_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="ainp710.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION ainp710_filter()
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
   
   #end add-point    
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   
   CALL ainp710_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="ainp710.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION ainp710_filter_parser(ps_field)
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
 
{<section id="ainp710.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION ainp710_filter_show(ps_field,ps_object)
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
   LET ls_condition = ainp710_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="ainp710.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 建立temp table
# Memo...........:
# Usage..........: CALL ainp710_create_temp_table()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/02/09 By pomelo
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp710_create_temp_table()

   CALL ainp710_drop_temp_table()
   
   CREATE TEMP TABLE ainp710_tmp(
      indcdocno      LIKE indc_t.indcdocno
   )
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "Create Table ainp710_tmp"
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   
   
   CREATE TEMP TABLE ainp710_infp(
      infp004        LIKE infp_t.infp004,   #商品編號
      infp005        LIKE infp_t.infp005,   #商品條碼
      infp006        LIKE infp_t.infp006,   #產品特徵
      infp007        LIKE infp_t.infp007,   #經營方式
      infp008        LIKE infp_t.infp008,   #庫存單位
      infp009        LIKE infp_t.infp009,   #包裝單位
      infp010        LIKE infp_t.infp010,   #撥出包裝數量
      infp011        LIKE infp_t.infp011,   #撥出庫存數量
      infp012        LIKE infp_t.infp012,   #撥出庫位
      infp013        LIKE infp_t.infp013,   #撥出儲位
      infp014        LIKE infp_t.infp014)   #撥出批號
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "Create Table ainp710_infp"
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 刪除temp table
# Memo...........:
# Usage..........: CALL ainp710_drop_temp_table()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/02/09 By pomelo
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp710_drop_temp_table()

   DROP TABLE ainp710_tmp
   
   DROP TABLE ainp710_infp
END FUNCTION

################################################################################
# Descriptions...: 新增選擇的單號
# Memo...........:
# Usage..........: CALL ainp710_ins_sel(p_ac)
# Input parameter: p_ac       陣列位置
# Return code....: 無
# Date & Author..: 2015/02/09 By pomelo
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp710_ins_sel(p_ac)
DEFINE p_type        LIKE type_t.chr1
DEFINE p_ac          LIKE type_t.num5
DEFINE l_sql         STRING

   #當選擇 = 'Y'  ---> Ins
   IF g_detail_d[l_ac].sel = 'Y' THEN
      INSERT INTO ainp710_tmp(indcdocno)
         VALUES (g_detail_d[l_ac].indcdocno)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "Ins ainp710_tmp"
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF
   ELSE
      DELETE FROM ainp710_tmp
       WHERE indcdocno = g_detail_d[l_ac].indcdocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "Del ainp710_tmp"
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF
   END IF
END FUNCTION

################################################################################
# Descriptions...: 刪除temp table資料
# Memo...........:
# Usage..........: CALL ainp710_del_tmp()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/02/09 By pomelo
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp710_del_tmp()

   DELETE FROM ainp710_tmp
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "Del ainp710_tmp"
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
END FUNCTION

################################################################################
# Descriptions...: 準備產生單據需要SQL
# Memo...........:
# Usage..........: CALL ainp710_pre()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/02/10 By pomelo
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp710_pre()
DEFINE l_sql            STRING

   #1. 庫存單位
   LET l_sql = "SELECT imaa104 FROM imaa_t",
               " WHERE imaaent = ",g_enterprise,
               "   AND imaa001 = ?"
   PREPARE ainp710_imaa104 FROM l_sql
   
   #2. 包裝單位
   LET l_sql = "SELECT rtdx004 FROM rtdx_t",
               " WHERE rtdxent = ",g_enterprise,
               "   AND rtdxsite = ?",
               "   AND rtdx001 = ?"
   PREPARE ainp710_rtdx004 FROM l_sql
   
   #3. 單位數量的轉換
   LET l_sql = "SELECT infp008,infp009,infp010,infp011",
               "  FROM ainp710_infp",
               " WHERE infp004 = ?",
               "   AND infp005 = ?",
               "   AND COALESCE(infp006,' ') = COALESCE(?,' ')",
               "   AND COALESCE(infp007,' ') = COALESCE(?,' ')",
               "   AND COALESCE(infp012,' ') = COALESCE(?,' ')",
               "   AND COALESCE(infp013,' ') = COALESCE(?,' ')",
               "   AND COALESCE(infp014,' ') = COALESCE(?,' ')"
   PREPARE ainp710_infp_pre FROM l_sql
   DECLARE ainp710_infp_cs CURSOR FOR ainp710_infp_pre
END FUNCTION

################################################################################
# Descriptions...: 產生隨貨同行單
# Memo...........:
# Usage..........: CALL ainp710_process()
#                     RETURNING r_success,r_docno_str
# Input parameter: 無
# Return code....: r_success      True/False
#                : r_docno_str    成功產生單號
# Date & Author..: 2015/02/09 By pomelo
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp710_process()
DEFINE r_success        LIKE type_t.num5
DEFINE r_docno_str      STRING
DEFINE l_sql            STRING
DEFINE l_success        LIKE type_t.num5
DEFINE l_docno          LIKE rtai_t.rtai004       #批次拋轉預設單別
#160225-00040#7 160310 By pomelo add(S)
DEFINE l_cnt            LIKE type_t.num10
DEFINE l_msg            STRING
#160225-00040#7 160310 By pomelo add(E)
DEFINE l_infm           RECORD
       infment          LIKE infm_t.infment,        #企業編號
       infmsite         LIKE infm_t.infmsite,       #營運據點
       infmunit         LIKE infm_t.infmunit,       #應用組織
       infmdocno        LIKE infm_t.infmdocno,      #隨貨同行單號
       infmdocdt        LIKE infm_t.infmdocdt,      #單據日期
       infm001          LIKE infm_t.infm001,        #製單人員
       infm002          LIKE infm_t.infm002,        #製單部門
       infm003          LIKE infm_t.infm003,        #撥出營運組織
       infm004          LIKE infm_t.infm004,        #撥入營運據點
       infm005          LIKE infm_t.infm005,        #撥出確認人員
       infm006          LIKE infm_t.infm006,        #撥出確認日期
       infm007          LIKE infm_t.infm007,        #備註
       infmstus         LIKE infm_t.infmstus,       #狀態碼
       infmownid        LIKE infm_t.infmownid,      #資料所有者
       infmowndp        LIKE infm_t.infmowndp,      #資料所屬部門
       infmcrtid        LIKE infm_t.infmcrtid,      #資料建立者
       infmcrtdp        LIKE infm_t.infmcrtdp,      #資料建立部門
       infmcrtdt        DATETIME YEAR TO SECOND     #資料建立日
                        END RECORD

   LET r_success = TRUE
   LET r_docno_str = ''
   
   CALL ainp710_pre()
   
   LET l_sql = "SELECT DISTINCT t1.indcent, t1.indcsite, t1.indc005, t1.indc006",
               "  FROM indc_t t1,ainp710_tmp t2",
               " WHERE t1.indcent = ",g_enterprise,
               "   AND t1.indcdocno = t2.indcdocno",
               " ORDER BY t1.indcsite"
   PREPARE ainp710_gen_head_pre FROM l_sql
   DECLARE ainp710_gen_head_cs CURSOR FOR ainp710_gen_head_pre
   
   #160225-00040#7 160310 By pomelo add(S)
   IF g_bgjob <> "Y" THEN
      LET l_cnt = 0
      LET l_sql = "SELECT COUNT(*) FROM (",l_sql,")"
      PREPARE ainp710_cnt FROM l_sql
      EXECUTE ainp710_cnt INTO l_cnt
      CALL cl_progress_bar_no_window(l_cnt)
      LET l_msg = cl_getmsg('ain-00746',g_lang)
   END IF
   #160225-00040#7 160310 By pomelo add(E)
   
   FOREACH ainp710_gen_head_cs
      INTO l_infm.infment, l_infm.infmsite, l_infm.infm003, l_infm.infm004
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "Foreach ainp710_gen_head_cs"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
      END IF
      
      CALL cl_progress_no_window_ing(l_msg)   #160225-00040#7 160310 By pomelo add
      
      LET l_infm.infmunit  = l_infm.infmsite     #應用組織
      LET l_infm.infmdocdt = g_today             #單據日期
      LET l_infm.infm001   = g_user              #製單人員
      LET l_infm.infm002   = g_dept              #製單部門
      LET l_infm.infm005   = ''                  #撥出確認人員
      LET l_infm.infm006   = ''                  #撥出確認日期
      LET l_infm.infm007   = ''                  #備註
      LET l_infm.infmstus  = 'N'                 #狀態碼
      LET l_infm.infmownid = g_user              #資料所有者
      LET l_infm.infmowndp = g_dept              #資料所屬部門
      LET l_infm.infmcrtid = g_user              #資料建立者
      LET l_infm.infmcrtdp = g_dept              #資料建立部門
      LET l_infm.infmcrtdt = cl_get_current()    #資料建立日
      
      #取單別
      LET l_success = ''
      CALL s_arti200_get_def_doc_type(l_infm.infmsite,'aint710','2')
         RETURNING l_success,l_docno
      IF l_success = FALSE THEN
         LET r_success = FALSE
         RETURN r_success,r_docno_str
      END IF
      
      #產生單號
      LET l_success = ''
      CALL s_aooi200_gen_docno(l_infm.infmsite,l_docno,l_infm.infmdocdt,'aint710')
         RETURNING l_success,l_infm.infmdocno
      IF l_success = FALSE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'apm-00003'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success,r_docno_str
      END IF
      
      #Ins infm_t
      INSERT INTO infm_t(infment,   infmsite,  infmunit,  infmdocno,
                         infmdocdt, infm001,   infm002,   infm003,
                         infm004,   infm005,   infm006,   infm007,
                         infmstus,  infmownid, infmowndp, infmcrtid,
                         infmcrtdp, infmcrtdt)
         VALUES(l_infm.infment,   l_infm.infmsite,  l_infm.infmunit,  l_infm.infmdocno,
                l_infm.infmdocdt, l_infm.infm001,   l_infm.infm002,   l_infm.infm003,
                l_infm.infm004,   l_infm.infm005,   l_infm.infm006,   l_infm.infm007,
                l_infm.infmstus,  l_infm.infmownid, l_infm.infmowndp, l_infm.infmcrtid,
                l_infm.infmcrtdp, l_infm.infmcrtdt)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "Ins infm_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success,r_docno_str
      END IF
      
      IF NOT ainp710_gen_detail(l_infm.infmsite, l_infm.infmdocno,
                                l_infm.infm003,  l_infm.infm004) THEN
         LET r_success = FALSe
         RETURN r_success,r_docno_str
      END IF
      
      IF cl_null(r_docno_str) THEN
         LET r_docno_str = "'",l_infm.infmdocno,"'"
      ELSE
         LET r_docno_str = r_docno_str,",'",l_infm.infmdocno,"'"
      END IF
   END FOREACH
   
   IF NOT cl_null(r_docno_str) THEN
      LET r_docno_str = "infmdocno IN (",r_docno_str,")"
   END IF
   
   RETURN r_success,r_docno_str
END FUNCTION

################################################################################
# Descriptions...: 產生隨貨同行單單身
# Memo...........:
# Usage..........: CALL ainp710_gen_detail(p_infmsite,p_infmdocno,p_infm003,p_infm004)
#                  RETURNING r_success
# Input parameter: p_infmsite     營運組織
#                : p_infmdocno    隨貨同行單號
#                : p_infm003      撥出營運組織
#                : p_infm004      撥入營運組織
# Return code....: r_success      True/False
# Date & Author..: 2015/02/09 By pomelo
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp710_gen_detail(p_infmsite,p_infmdocno,p_infm003,p_infm004)
DEFINE p_infmsite        LIKE infm_t.infmsite
DEFINE p_infmdocno       LIKE infm_t.infmdocno
DEFINE p_infm003         LIKE infm_t.infm003
DEFINE p_infm004         LIKE infm_t.infm004
DEFINE r_success         LIKE type_t.num5
DEFINE l_sql             STRING
DEFINE l_success         LIKE type_t.num5
DEFINE l_infoseq         LIKE info_t.infoseq
DEFINE l_sum_info007     LIKE info_t.info007     #撥出包裝數量
DEFINE l_sum_info008     LIKE info_t.info008     #撥出庫存數量
DEFINE l_change          LIKE info_t.info007
DEFINE l_sum             RECORD
       info005           LIKE info_t.info005,    #庫存單位
       info006           LIKE info_t.info006,    #包裝單位
       info007           LIKE info_t.info007,    #撥出包裝數量
       info008           LIKE info_t.info008     #撥出庫存數量
                         END RECORD
DEFINE l_infp            RECORD
       infpent           LIKE infp_t.infpent,    #企業編號
       infpsite          LIKE infp_t.infpsite,   #營運據點
       infpunit          LIKE infp_t.infpunit,   #應用組織
       infpdocno         LIKE infp_t.infpdocno,  #隨貨同行單號
       infp004           LIKE infp_t.infp004,    #商品編號
       infp005           LIKE infp_t.infp005,    #商品條碼
       infp006           LIKE infp_t.infp006,    #產品特徵
       infp007           LIKE infp_t.infp007,    #經營方式
       infp008           LIKE infp_t.infp008,    #庫存單位
       infp009           LIKE infp_t.infp009,    #包裝單位
       infp012           LIKE infp_t.infp012,    #撥出庫位
       infp013           LIKE infp_t.infp013,    #撥出儲位
       infp014           LIKE infp_t.infp014     #撥出批號
                         END RECORD
DEFINE l_info            RECORD
       infoent           LIKE info_t.infoent,    #企業編號
       infosite          LIKE info_t.infosite,   #營運據點
       infounit          LIKE info_t.infounit,   #應用組織
       infodocno         LIKE info_t.infodocno,  #隨貨同行單號
       infoseq           LIKE info_t.infoseq,    #項次
       info001           LIKE info_t.info001,    #商品編號
       info002           LIKE info_t.info002,    #商品條碼
       info003           LIKE info_t.info003,    #產品特徵
       info004           LIKE info_t.info004,    #經營方式
       info005           LIKE info_t.info005,    #庫存單位
       info006           LIKE info_t.info006,    #包裝單位
       info007           LIKE info_t.info007,    #撥出包裝數量
       info008           LIKE info_t.info008,    #撥出庫存數量
       info009           LIKE info_t.info009,    #撥出庫位
       info010           LIKE info_t.info010,    #撥出儲位
       info011           LIKE info_t.info011,    #撥出批號
       info012           LIKE info_t.info012,    #撥入包裝數量
       info013           LIKE info_t.info013,    #撥入庫存數量
       info014           LIKE info_t.info014,    #撥入庫位
       info015           LIKE info_t.info015,    #撥入儲位
       info016           LIKE info_t.info016     #撥入批號
                         END RECORD
                         
   LET r_success = TRUE
   
   #1.Ins infp_t(隨貨同行單單身擋-明細)
   LET l_sql = "INSERT INTO infp_t(infpent, infpsite, infpunit, infpdocno,",
               "                   infpseq, infp001,  infp002,  infp003,",
               "                   infp004, infp005,  infp006,  infp007,",
               "                   infp008, infp009,  infp010,  infp011,",
               "                   infp012, infp013,  infp014,  infp015,",
               "                   infp016, infp017,  infp018,  infp019)",
               "SELECT t1.indcent, '",p_infmsite,"' ,'",p_infmsite,"' ,'",p_infmdocno,"',",
               "       ROW_NUMBER() OVER (ORDER BY 1), t1.indc002, t1.indcdocno, inddseq,",
               "       indd002,               indd003,               COALESCE(indd004,' '), indd005,",
               "       indd006,               indd007,               indd020,               indd021,",
               "       COALESCE(indd022,' '), COALESCE(indd023,' '), '',                    '',",
               "       '',                    '',                    '',                    ''",
               "  FROM indc_t t1,indd_t",
               " WHERE t1.indcent = inddent",
               "   AND t1.indcdocno = indddocno",
               "   AND t1.indcent = ",g_enterprise,
               "   AND t1.indc005 = '",p_infm003,"'",
               "   AND t1.indc006 = '",p_infm004,"'",
               "   AND EXISTS(SELECT 1",
               "                FROM ainp710_tmp t2",
               "               WHERE t1.indcdocno = t2.indcdocno)",
               " ORDER BY indddocno"
   PREPARE ainp710_gen_infp FROM l_sql
   EXECUTE ainp710_gen_infp
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "Ins infp_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #2.Ins infn_t(隨貨同行單單身檔-單據編號匯總)
   LET l_sql = "INSERT INTO infn_t(infnent, infnsite, infnunit, infndocno,",
               "                   infnseq, infn001,  infn002)",
               "SELECT t1.indcent, '",p_infmsite,"' ,'",p_infmsite,"' ,'",p_infmdocno,"',",
               "       ROW_NUMBER() OVER (ORDER BY 1), t1.indc002, indddocno",
               "  FROM indc_t t1,indd_t",
               " WHERE t1.indcent = inddent",
               "   AND t1.indcdocno = indddocno",
               "   AND t1.indcent = ",g_enterprise,
               "   AND t1.indc005 = '",p_infm003,"'",
               "   AND t1.indc006 = '",p_infm004,"'",
               "   AND EXISTS(SELECT 1",
               "                FROM ainp710_tmp t2",
               "               WHERE t1.indcdocno = t2.indcdocno)",
               " ORDER BY indddocno"
   PREPARE ainp710_gen_infn FROM l_sql
   EXECUTE ainp710_gen_infn
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "Ins infn_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #3.Ins info_t(隨貨同行單單身檔-單據編號匯總)
   # 3-1.Del ainp710_infp
   DELETE FROM ainp710_infp
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "Del ainp710_infp"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   # 3-2.Ins ainp710_infp
   LET l_sql = "INSERT INTO ainp710_infp(infp004, infp005, infp006, infp007,",
               "                         infp008, infp009, infp010, infp011,",
               "                         infp012, infp013, infp014)",
               "SELECT infp004, infp005, infp006,      infp007,",
               "       infp008, infp009, SUM(infp010), SUM(infp011),",
               "       infp012, infp013, infp014",
               "  FROM infp_t",
               " WHERE infpent = ",g_enterprise,
               "   AND infpdocno = '",p_infmdocno,"'",
               " GROUP BY infp004, infp005, infp006,",
               "          infp007, infp008, infp009,",
               "          infp012, infp013, infp014"
   PREPARE ainp710_ins_ainp710_infp FROM l_sql
   EXECUTE ainp710_ins_ainp710_infp
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "Ins ainp710_infp"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   # 3-3.Sel infp_t
   LET l_sql = "SELECT DISTINCT infpent, infpsite, infpunit, infpdocno,",
               "                infp004, infp005,  infp006,  infp007,",
               "                infp008, infp009,  infp012,  infp013,",
               "                infp014",
               "  FROM infp_t",
               " WHERE infpent = ",g_enterprise,
               "   AND infpdocno = '",p_infmdocno,"'"
   PREPARE ainp710_sel_infp_pre FROM l_sql
   DECLARE ainp710_sel_infp_cs CURSOR FOR ainp710_sel_infp_pre
   
   LET l_infoseq = 1
   INITIALIZE l_infp.* TO NUll
   FOREACH ainp710_sel_infp_cs
      INTO l_infp.infpent, l_infp.infpsite, l_infp.infpunit, l_infp.infpdocno,
           l_infp.infp004, l_infp.infp005,  l_infp.infp006,  l_infp.infp007,
           l_infp.infp008, l_infp.infp009,  l_infp.infp012,  l_infp.infp013,
           l_infp.infp014
       
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "Foreach ainp710_sel_infp_cs"
          LET g_errparam.popup = TRUE
          CALL cl_err()
          LET r_success = FALSE
          RETURN r_success
       END IF
       LET l_info.infoent   = l_infp.infpent     #企業編號
       LET l_info.infosite  = l_infp.infpsite    #營運據點
       LET l_info.infounit  = l_infp.infpunit    #應用組織
       LET l_info.infodocno = l_infp.infpdocno   #隨貨同行單號
       LET l_info.infoseq   = l_infoseq          #項次
       LET l_info.info001   = l_infp.infp004     #商品編號
       LET l_info.info002   = l_infp.infp005     #商品條碼
       LET l_info.info003   = l_infp.infp006     #產品特徵
       LET l_info.info004   = l_infp.infp007     #經營方式
       LET l_info.info009   = l_infp.infp012     #撥出庫位
       LET l_info.info010   = l_infp.infp013     #撥出儲位
       LET l_info.info011   = l_infp.infp014     #撥出批號
       LET l_info.info012   = ''                 #撥入包裝數量
       LET l_info.info013   = ''                 #撥入庫存數量
       LET l_info.info014   = ''                 #撥入庫位
       LET l_info.info015   = ''                 #撥入儲位
       LET l_info.info016   = ''                 #撥入批號
       
       #庫存單位
       EXECUTE ainp710_imaa104 USING l_info.info001
          INTO l_info.info005
       
       #包裝單位
       EXECUTE ainp710_rtdx004 USING l_info.infosite, l_info.info001
          INTO l_info.info006
       
       LET l_sum_info007 = 0
       LET l_sum_info008 = 0
       INITIALIZE l_sum.* TO NULL
       FOREACH ainp710_infp_cs
         USING l_info.info001, l_info.info002, l_info.info003,
               l_info.info004, l_info.info009, l_info.info010,
               l_info.info011
          INTO l_sum.info005, l_sum.info006, l_sum.info007, l_sum.info008
          
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = "Foreach ainp710_infp_cs"
             LET g_errparam.popup = TRUE
             CALL cl_err()
             LET r_success = FALSE
             RETURN r_success
          END IF
          
          #調撥單庫存單位轉換成商品編號庫存單位
          LET l_success = ''
          LET l_change = 0
          CALL s_aooi250_convert_qty(l_info.info001, l_sum.info005, l_info.info005, l_sum.info008)
             RETURNING l_success,l_change
          LET l_sum_info008 = l_sum_info008 + l_change
          
          #調撥單包裝單位轉換成門店商品包裝單位
          LET l_success = ''
          LET l_change = 0
          CALL s_aooi250_convert_qty(l_info.info001, l_sum.info006, l_info.info006, l_sum.info007)
             RETURNING l_success, l_change
          LET l_sum_info007 = l_sum_info007 + l_change
          INITIALIZE l_sum.* TO NULL
       END FOREACH
       
       LET l_info.info007   = l_sum_info007      #撥出包裝數量
       LET l_info.info008   = l_sum_info008      #撥出庫存數量
       
       INSERT INTO info_t(infoent, infosite, infounit, infodocno,
                          infoseq, info001,  info002,  info003,
                          info004, info005,  info006,  info007,
                          info008, info009,  info010,  info011,
                          info012, info013,  info014,  info015,
                          info016)
          VALUES(l_info.infoent, l_info.infosite, l_info.infounit, l_info.infodocno,
                 l_info.infoseq, l_info.info001,  l_info.info002,  l_info.info003,
                 l_info.info004, l_info.info005,  l_info.info006,  l_info.info007,
                 l_info.info008, l_info.info009,  l_info.info010,  l_info.info011,
                 l_info.info012, l_info.info013,  l_info.info014,  l_info.info015,
                 l_info.info016)
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "Ins info_t"
          LET g_errparam.popup = TRUE
          CALL cl_err()
          LET r_success = FALSE
          RETURN r_success
       END IF
       
       LET l_infoseq = l_infoseq + 1
       INITIALIZE l_infp.* TO NULL
   END FOREACH
   
   RETURN r_success

END FUNCTION

#end add-point
 
{</section>}
 
