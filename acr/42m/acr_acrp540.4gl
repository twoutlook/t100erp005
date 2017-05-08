#該程式未解開Section, 採用最新樣板產出!
{<section id="acrp540.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2016-08-19 20:31:17), PR版次:0005(2017-01-17 16:47:50)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000051
#+ Filename...: acrp540
#+ Description: 精選會員作業
#+ Creator....: 02003(2015-06-24 10:39:22)
#+ Modifier...: 02749 -SD/PR- 06137
 
{</section>}
 
{<section id="acrp540.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#41  2016/04/25  By pengxin  將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160729-00077#4   2016/08/19  By lori     1.累計消費次數/累計消費額/累計積點改為CONSTRUCT
#                                         2.INPUT條件另用變數 g_input_where 紀錄,便於存入crdf_t
#                                         3.變更屬性時紀錄變更條件於crdf_t
#160905-00007#1   2016-09-05  By 08734    ent调整
#170109-00037#17  2017/01/16  By 06137    批次LOCK處理1.UI勾選LOCK檢查2.資料處理LOCK
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
        mmag002_1        LIKE mmag_t.mmag002,
        mmag004_1        LIKE mmag_t.mmag004,
        mmag002_2        LIKE mmag_t.mmag002,
        mmag004_2        LIKE mmag_t.mmag004,
        mmag002_3        LIKE mmag_t.mmag002,
        mmag004_3        LIKE mmag_t.mmag004,
        mmag002_4        LIKE mmag_t.mmag002,
        mmag004_4        LIKE mmag_t.mmag004,
        bdate            LIKE decc_t.decc002,
        edate            LIKE decc_t.decc002,   
       #mmaq014          LIKE mmaq_t.mmaq014,   #160729-00077#4 160819 by lori mark
       #mmaq015          LIKE mmaq_t.mmaq015,   #160729-00077#4 160819 by lori mark
       #mmaq016          LIKE mmaq_t.mmaq016,   #160729-00077#4 160819 by lori mark
   #end add-point
        wc               STRING
                     END RECORD
 
TYPE type_g_detail_d RECORD
#add-point:自定義模組變數(Module Variable)  #注意要在add-point內寫入END RECORD name="global.variable"
        sel              LIKE type_t.chr1,
        mmaf001          LIKE mmaf_t.mmaf001,
        mmaf008          LIKE mmaf_t.mmaf008,
        mmaf001_desc     LIKE oocql_t.oocql004,
        mmaf015          LIKE mmaf_t.mmaf015,
        age              LIKE type_t.num10,
        mmaf014          LIKE mmaf_t.mmaf014,
        mmaq014          LIKE mmaq_t.mmaq014,
        mmaq015          LIKE mmaq_t.mmaq015,
        mmaq016          LIKE mmaq_t.mmaq016,
        mmag004          LIKE mmag_t.mmag004
                     END RECORD 
DEFINE g_master         type_parameter
DEFINE g_flag           LIKE type_t.chr1
DEFINE g_flag2          LIKE type_t.chr1
DEFINE g_mmag002        LIKE mmag_t.mmag002
DEFINE g_mmag003        LIKE mmag_t.mmag003
DEFINE g_mmag004        LIKE mmag_t.mmag004
DEFINE g_mmag004_desc   LIKE oocql_t.oocql004
DEFINE g_input_where    STRING   #160729-00077#4 160819 by lori add
DEFINE g_detail_idx     LIKE type_t.num5    #170109-00037#17 Add By Ken 170116
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="acrp540.main" >}
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
   CALL cl_ap_init("acr","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
 
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      CALL acrp540_process(ls_js)
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_acrp540 WITH FORM cl_ap_formpath("acr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL acrp540_init()   
 
      #進入選單 Menu (="N")
      CALL acrp540_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_acrp540
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="acrp540.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION acrp540_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc_part('mmag002_1','6831','01,02,03,04,05,06,07,08,09,10')
   CALL cl_set_combo_scc_part('mmag002_2','6831','01,02,03,04,05,06,07,08,09,10')
   CALL cl_set_combo_scc_part('mmag002_3','6831','01,02,03,04,05,06,07,08,09,10')
   CALL cl_set_combo_scc_part('mmag002_4','6831','01,02,03,04,05,06,07,08,09,10')
   CALL cl_set_comp_visible("b_mmag004",FALSE)
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="acrp540.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION acrp540_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_date      LIKE type_t.dat
   DEFINE l_mmag003   LIKE mmag_t.mmag003
   DEFINE lc_param    type_parameter
   DEFINE ls_js       STRING
   DEFINE l_msg       STRING
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   #170109-00037#17 Add By Ken 170116(S)
   #Lock檢查
   LET g_sql = " SELECT mmaf001 ",
               "   FROM mmaf_t ",
               "  WHERE mmafent = ",g_enterprise,
               "    AND mmaf001 = ? ",
               "    FOR UPDATE SKIP LOCKED "
   PREPARE acrp540_chk_lock_data FROM g_sql
   #170109-00037#17 Add By Ken 170116(E)
   
   INITIALIZE g_master.* TO NULL
   #计算当前月的上一月
   SELECT add_months(g_today,-1) INTO l_date FROM dual
   #獲取上月第一天
   CALL s_date_get_first_date(l_date) RETURNING g_master.bdate
   #獲取上月最後一天
   CALL s_date_get_last_date(l_date) RETURNING g_master.edate
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL acrp540_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT BY NAME g_master.wc ON mmaf001,mmaf008,mmaf014,mmaf015,mmaq014,mmaq015,mmaq016   #160729-00077#4 160819 by lori add:mmaq014~16
         
            BEFORE CONSTRUCT
            
            ON ACTION controlp INFIELD mmaf001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_mmaf001_1()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO mmaf001  #顯示到畫面上
               NEXT FIELD mmaf001                     #返回原欄位
               
         END CONSTRUCT
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT BY NAME g_master.mmag002_1,g_master.mmag004_1,g_master.mmag002_2,g_master.mmag004_2,
                       g_master.mmag002_3,g_master.mmag004_3,g_master.mmag002_4,g_master.mmag004_4,
                       g_master.bdate    ,g_master.edate   #,g_master.mmaq014  ,g_master.mmaq015  ,   #160729-00077#4 160819 by lori mark
                       #g_master.mmaq016   #160729-00077#4 160819 by lori mark
                       
            ATTRIBUTE(WITHOUT DEFAULTS)
         
            BEFORE INPUT
               CALL acrp540_set_entry()
               
            ON CHANGE mmag002_1
               CALL acrp540_set_entry()
               LET g_master.mmag004_1 = ''
               DISPLAY BY NAME g_master.mmag004_1
            
            AFTER FIELD mmag004_1
               IF NOT cl_null(g_master.mmag004_1) THEN 
                  SELECT oocq004 INTO l_mmag003 from oocq_t where oocq001='2049' and oocq002 = g_master.mmag002_1 AND oocqent=g_enterprise #160905-00007#1 add
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = l_mmag003
                  LET g_chkparam.arg2 = g_master.mmag004_1
                  #160318-00025#41  2016/04/25  by pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "aqc-00032:sub-01302|aqci030|",cl_get_progname("aqci030",g_lang,"2"),"|:EXEPROGaqci030"
                  #160318-00025#41  2016/04/25  by pengxin  add(E)
                  IF NOT cl_chk_exist("v_oocq002_01") THEN
                     NEXT FIELD CURRENT
                  END IF
               END IF 
            
            ON CHANGE mmag002_2
               CALL acrp540_set_entry()
               LET g_master.mmag004_2 = ''
               DISPLAY BY NAME g_master.mmag004_2
               
            AFTER FIELD mmag004_2
               IF NOT cl_null(g_master.mmag004_2) THEN 
                  SELECT oocq004 INTO l_mmag003 from oocq_t where oocq001='2049' and oocq002 = g_master.mmag002_2 AND oocqent=g_enterprise #160905-00007#1 add
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = l_mmag003
                  LET g_chkparam.arg2 = g_master.mmag004_2
                  #160318-00025#41  2016/04/25  by pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "aqc-00032:sub-01302|aqci030|",cl_get_progname("aqci030",g_lang,"2"),"|:EXEPROGaqci030"
                  #160318-00025#41  2016/04/25  by pengxin  add(E)
                  IF NOT cl_chk_exist("v_oocq002_01") THEN
                     NEXT FIELD CURRENT
                  END IF
               END IF 
            
            ON CHANGE mmag002_3
               CALL acrp540_set_entry()
               LET g_master.mmag004_3 = ''
               DISPLAY BY NAME g_master.mmag004_3
            
            AFTER FIELD mmag004_3
               IF NOT cl_null(g_master.mmag004_3) THEN 
                  SELECT oocq004 INTO l_mmag003 from oocq_t where oocq001='2049' and oocq002 = g_master.mmag002_3 AND oocqent=g_enterprise #160905-00007#1 add
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = l_mmag003
                  LET g_chkparam.arg2 = g_master.mmag004_3
                  #160318-00025#41  2016/04/25  by pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "aqc-00032:sub-01302|aqci030|",cl_get_progname("aqci030",g_lang,"2"),"|:EXEPROGaqci030"
                  #160318-00025#41  2016/04/25  by pengxin  add(E)
                  IF NOT cl_chk_exist("v_oocq002_01") THEN
                     NEXT FIELD CURRENT
                  END IF
               END IF 

            ON CHANGE mmag002_4
               CALL acrp540_set_entry()
               LET g_master.mmag004_4 = ''
               DISPLAY BY NAME g_master.mmag004_4
               
            AFTER FIELD mmag002_4
               IF NOT cl_null(g_master.mmag004_4) THEN 
                  SELECT oocq004 INTO l_mmag003 from oocq_t where oocq001='2049' and oocq002 = g_master.mmag002_4 AND oocqent=g_enterprise #160905-00007#1 add
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = l_mmag003
                  LET g_chkparam.arg2 = g_master.mmag004_4
                  #160318-00025#41  2016/04/25  by pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "aqc-00032:sub-01302|aqci030|",cl_get_progname("aqci030",g_lang,"2"),"|:EXEPROGaqci030"
                  #160318-00025#41  2016/04/25  by pengxin  add(E)
                  IF NOT cl_chk_exist("v_oocq002_01") THEN
                     NEXT FIELD CURRENT
                  END IF
               END IF 
               
            AFTER FIELD bdate
               IF NOT cl_null(g_master.bdate) THEN 
                  IF NOT cl_null(g_master.edate) AND g_master.bdate > g_master.edate THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = g_master.bdate
                     LET g_errparam.code   = 'ain-00128'
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     NEXT FIELD bdate
                  END IF 
                  CALL cl_set_comp_required('edate',TRUE)
               ELSE
                  CALL cl_set_comp_required('edate',FALSE)
               END IF 
            
            AFTER FIELD edate
               IF NOT cl_null(g_master.edate) THEN 
                  IF NOT cl_null(g_master.edate) AND g_master.bdate > g_master.edate THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = g_master.edate
                     LET g_errparam.code   = 'ain-00128'
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     NEXT FIELD edate
                  END IF 
                  CALL cl_set_comp_required('bdate',TRUE)
               ELSE
                  CALL cl_set_comp_required('bdate',FALSE)
               END IF 
           #160729-00077#4 160819 by lori mark---(S)
           #AFTER FIELD mmaq014
           #   IF NOT cl_null(g_master.mmaq014) THEN 
           #      IF NOT cl_ap_chk_range(g_master.mmaq014,"0","1","","","azz-00079",1) THEN
           #         NEXT FIELD mmaq014
           #      END IF 
           #   END IF 
           #   
           #AFTER FIELD mmaq015
           #   IF NOT cl_null(g_master.mmaq015) THEN 
           #      IF NOT cl_ap_chk_range(g_master.mmaq015,"0.00","1","","","azz-00079",1) THEN
           #         NEXT FIELD mmaq015
           #      END IF 
           #   END IF 
           #   
           #AFTER FIELD mmaq016
           #   IF NOT cl_null(g_master.mmaq016) THEN 
           #      IF NOT cl_ap_chk_range(g_master.mmaq016,"0.000","1","","","azz-00079",1) THEN
           #         NEXT FIELD mmaq016
           #      END IF 
           #   END IF 
           #160729-00077#4 160819 by lori mark---(E)
           
            ON ACTION controlp INFIELD mmag004_1
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET l_mmag003 = null
               SELECT oocq004 INTO l_mmag003 from oocq_t where oocq001='2049' and oocq002 = g_master.mmag002_1 AND oocqent=g_enterprise #160905-00007#1 add
               IF NOT cl_null(l_mmag003) THEN
                  LET g_qryparam.where = "oocq001='",l_mmag003,"'"
               END IF 
               CALL q_oocq002_16()                      #呼叫開窗
               LET g_master.mmag004_1 = g_qryparam.return1
               DISPLAY BY NAME g_master.mmag004_1
               NEXT FIELD mmag004_1                     #返回原欄位
               
            ON ACTION controlp INFIELD mmag004_2
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET l_mmag003 = null
               SELECT oocq004 INTO l_mmag003 from oocq_t where oocq001='2049' and oocq002 = g_master.mmag002_2 AND oocqent=g_enterprise #160905-00007#1 add
               IF NOT cl_null(l_mmag003) THEN
                  LET g_qryparam.where = "oocq001='",l_mmag003,"'"
               END IF 
               CALL q_oocq002_16()                      #呼叫開窗
               LET g_master.mmag004_2 = g_qryparam.return1
               DISPLAY BY NAME g_master.mmag004_2
               NEXT FIELD mmag004_2                     #返回原欄位
               
            ON ACTION controlp INFIELD mmag004_3
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET l_mmag003 = null
               SELECT oocq004 INTO l_mmag003 from oocq_t where oocq001='2049' and oocq002 = g_master.mmag002_3  AND oocqent=g_enterprise #160905-00007#1 add
               IF NOT cl_null(l_mmag003) THEN
                  LET g_qryparam.where = "oocq001='",l_mmag003,"'"
               END IF 
               CALL q_oocq002_16()                      #呼叫開窗
               LET g_master.mmag004_3 = g_qryparam.return1
               DISPLAY BY NAME g_master.mmag004_3
               NEXT FIELD mmag004_3                     #返回原欄位
               
            ON ACTION controlp INFIELD mmag004_4
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET l_mmag003 = null
               SELECT oocq004 INTO l_mmag003 from oocq_t where oocq001='2049' and oocq002 = g_master.mmag002_4 AND oocqent=g_enterprise #160905-00007#1 add
               IF NOT cl_null(l_mmag003) THEN
                  LET g_qryparam.where = "oocq001='",l_mmag003,"'"
               END IF 
               CALL q_oocq002_16()                      #呼叫開窗
               LET g_master.mmag004_4 = g_qryparam.return1
               DISPLAY BY NAME g_master.mmag004_4
               NEXT FIELD mmag004_4                     #返回原欄位
               
            AFTER INPUT 
               IF NOT cl_null(g_master.bdate) AND cl_null(g_master.edate) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'acr-00071'
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  NEXT FIELD edate
               END IF 
               IF cl_null(g_master.bdate) AND NOT cl_null(g_master.edate) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'acr-00071'
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  NEXT FIELD bdate
               END IF 
         END INPUT
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"

         INPUT ARRAY g_detail_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, 
                  INSERT ROW = FALSE, 
                  DELETE ROW = FALSE,
                  APPEND ROW = TRUE)
             BEFORE INSERT
                CANCEL INSERT
                
             BEFORE DELETE
                CANCEL DELETE
                                             
            #170109-00037#17 Add By Ken 170116(S)
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_detail_d.getLength() TO FORMONLY.h_count
               LET g_master_idx = l_ac
               #CALL adbp460_fetch()
               #IF g_detail_d[l_ac].sel = 'N' THEN
               #   NEXT FIELD sel
               #END IF            
            
            ON CHANGE sel
               IF l_ac > 0 THEN 
                  #UI勾選LOCK檢查
                  IF g_detail_d[l_ac].sel = "Y" THEN
                     CALL cl_err_collect_init() 
                     CALL s_transaction_begin()
                     IF NOT acrp540_lock_chk(l_ac) THEN
                        LET g_detail_d[l_ac].sel = 'N' 
                     END IF
                     CALL s_transaction_end('Y',0)
                     CALL cl_err_collect_show()
                  END IF
               END IF
            #170109-00037#17 Add By Ken 170116(E)             
         END INPUT 
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
            CALL acrp540_set_entry()
            #end add-point
 
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            #add-point:ui_dialog段on action selall name="ui_dialog.selall.befroe"
            CALL cl_err_collect_init()   #170109-00037#17 Add By Ken 170116
            #end add-point            
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
               #add-point:ui_dialog段on action selall name="ui_dialog.for.onaction_selall"
               #170109-00037#17 Add By Ken 170116(S)
               CALL s_transaction_begin()
               IF NOT acrp540_lock_chk(li_idx) THEN
                  LET g_detail_d[li_idx].sel = 'N' 
               END IF
               CALL s_transaction_end('Y',0)               
               #170109-00037#17 Add By Ken 170116(E)
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            CALL cl_err_collect_show()     #170109-00037#17 Add By Ken 170116
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
            #170109-00037#17 Add By Ken 170116(S)
            CALL cl_err_collect_init() 
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  CALL s_transaction_begin()
                  IF NOT acrp540_lock_chk(li_idx) THEN
                     LET g_detail_d[li_idx].sel = 'N'    
                  END IF
                  CALL s_transaction_end('Y',0)    
               END IF
            END FOR
            CALL cl_err_collect_show()
            #170109-00037#17 Add By Ken 170116(E)          


           
               
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
            CALL acrp540_filter()
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
            IF NOT cl_null(g_master.bdate) AND cl_null(g_master.edate) THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ''
               LET g_errparam.code   = 'acr-00071'
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               NEXT FIELD edate
            END IF 
            IF cl_null(g_master.bdate) AND NOT cl_null(g_master.edate) THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ''
               LET g_errparam.code   = 'acr-00071'
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               NEXT FIELD bdate
            END IF 
            #end add-point
            CALL acrp540_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL acrp540_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            #160225-00040#18 2016/05/05 s983961--add(s) 
            IF g_bgjob <> "Y" THEN
               CALL cl_progress_bar_no_window(3)    
            END IF                           
            #160225-00040#18 2016/05/05 s983961--add(e)
            CALL cl_err_collect_init()   #170109-00037#17 Add By Ken 170116
            LET ls_js = util.JSON.stringify(lc_param)
            CALL acrp540_process(ls_js) 
            IF g_flag2 = 'Y' THEN 
               CALL cl_set_comp_visible("b_mmag004",TRUE)
               CALL cl_getmsg('acr-00073',g_lang) RETURNING l_msg
               CALL cl_set_comp_att_text("b_mmag004",l_msg)
            END IF  
            CALL cl_err_collect_show()   #170109-00037#17 Add By Ken 170116           
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
 
{<section id="acrp540.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION acrp540_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   CALL cl_set_comp_visible("b_mmag004",FALSE)
   #end add-point
        
   LET g_error_show = 1
   CALL acrp540_b_fill()
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
 
{<section id="acrp540.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION acrp540_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE l_from          STRING
   DEFINE l_where         STRING 
   DEFINE l_mmag003       LIKE mmag_t.mmag003
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   LET g_input_where = ''   #160729-00077#4 160819 by lori add
   LET l_where = " WHERE mmafent = ? AND ",g_master.wc CLIPPED 
   
   IF NOT cl_null(g_master.mmag004_1) THEN 
      SELECT oocq004 INTO l_mmag003 from oocq_t where oocq001='2049' and oocq002 = g_master.mmag002_1 AND oocqent=g_enterprise #160905-00007#1 add
     #160729-00077#4 160819 by lori mark and add---(S)
     #LET l_where  = l_where," AND EXISTS (SELECT 1 FROM mmag_t WHERE mmag001 = mmaf001 AND mmagent = mmafent AND mmag002 = '",g_master.mmag002_1,"' AND mmag003 = '",l_mmag003,"' AND mmag004 = '",g_master.mmag004_1,"') "
      LET g_input_where = g_input_where,
                          " AND EXISTS (SELECT 1 FROM mmag_t ",
                          "              WHERE mmag001 = mmaf001 AND mmagent = mmafent AND mmag002 = '",g_master.mmag002_1,"' ",
                          "                AND mmag003 = '",l_mmag003,"' AND mmag004 = '",g_master.mmag004_1,"') "
     #160729-00077#4 160819 by lori mark and add---(E)                     
   END IF 
   
   IF NOT cl_null(g_master.mmag004_2) THEN 
      SELECT oocq004 INTO l_mmag003 from oocq_t where oocq001='2049' and oocq002 = g_master.mmag002_2 AND oocqent=g_enterprise #160905-00007#1 add
     #160729-00077#4 160819 by lori mark and add---(S)
     #LET l_where  = l_where," AND EXISTS (SELECT 1 FROM mmag_t WHERE mmag001 = mmaf001 AND mmagent = mmafent AND mmag002 = '",g_master.mmag002_2,"' AND mmag003 = '",l_mmag003,"' AND mmag004 = '",g_master.mmag004_2,"') "
      LET g_input_where = g_input_where,
                          " AND EXISTS (SELECT 1 FROM mmag_t ",
                          "              WHERE mmag001 = mmaf001 AND mmagent = mmafent AND mmag002 = '",g_master.mmag002_2,"' ",
                          "                AND mmag003 = '",l_mmag003,"' AND mmag004 = '",g_master.mmag004_2,"') "
     #160729-00077#4 160819 by lori mark and add---(E)
   END IF 
   
   IF NOT cl_null(g_master.mmag004_3) THEN 
      SELECT oocq004 INTO l_mmag003 from oocq_t where oocq001='2049' and oocq002 = g_master.mmag002_3 AND oocqent=g_enterprise
     #160729-00077#4 160819 by lori mark and add---(S)
     #LET l_where  = l_where," AND EXISTS (SELECT 1 FROM mmag_t WHERE mmag001 = mmaf001 AND mmagent = mmafent AND mmag002 = '",g_master.mmag002_3,"' AND mmag003 = '",l_mmag003,"' AND mmag004 = '",g_master.mmag004_3,"') "
      LET g_input_where = g_input_where,
                          " AND EXISTS (SELECT 1 FROM mmag_t ",
                          "              WHERE mmag001 = mmaf001 AND mmagent = mmafent AND mmag002 = '",g_master.mmag002_3,"' ",
                          "                AND mmag003 = '",l_mmag003,"' AND mmag004 = '",g_master.mmag004_3,"') "
     #160729-00077#4 160819 by lori mark and add---(E)
   END IF 
   
   IF NOT cl_null(g_master.mmag004_4) THEN 
      SELECT oocq004 INTO l_mmag003 from oocq_t where oocq001='2049' and oocq002 = g_master.mmag002_4 AND oocqent=g_enterprise #160905-00007#1 add
     #160729-00077#4 160819 by lori mark and add---(S)
     #LET l_where  = l_where," AND EXISTS (SELECT 1 FROM mmag_t WHERE mmag001 = mmaf001 AND mmagent = mmafent AND mmag002 = '",g_master.mmag002_4,"' AND mmag003 = '",l_mmag003,"' AND mmag004 = '",g_master.mmag004_4,"') "
      LET g_input_where = g_input_where,
                          " AND EXISTS (SELECT 1 FROM mmag_t ",
                          "              WHERE mmag001 = mmaf001 AND mmagent = mmafent AND mmag002 = '",g_master.mmag002_4,"' ",
                          "                AND mmag003 = '",l_mmag003,"' AND mmag004 = '",g_master.mmag004_4,"') "
     #160729-00077#4 160819 by lori mark and add---(E)
   END IF 
   
   IF NOT cl_null(g_master.bdate) THEN 
      #关联会员日结档decc_t抓取资料
      #                     选取/会员编号/姓名/性别/生日/年龄/手机号码/消费次数/消费金额/累计积分/精选会员标签
      #LET g_sql = " SELECT DISTINCT 'Y',mmaf001,mmaf008,oocql004,mmaf015,'',mmaf014,SUM(decc016) decc016,SUM(decc013) dscc013,SUM(decc021) decc021,'' "   #170109-00037#17 Mark By Ken 170116
      LET g_sql = " SELECT DISTINCT 'N',mmaf001,mmaf008,oocql004,mmaf015,'',mmaf014,SUM(decc016) decc016,SUM(decc013) dscc013,SUM(decc021) decc021,'' "    #170109-00037#17 Add By Ken 170116
      
      LET l_from = "  FROM decc_t,mmaf_t ",
                   "              LEFT JOIN mmag_t ON mmagent = mmafent AND mmag001 = mmaf001 AND mmag002 = '01' ",
                   "              LEFT JOIN oocql_t ON oocqlent = mmagent AND oocql001 = '2016' AND oocql002 = mmag004 AND oocql003 = '",g_dlang,"' ",
                   "              LEFT JOIN mmaq_t ON mmaqent = mmafent AND mmaq003 = mmaf001 "   #160729-00077#4 160819 by lori add
      
     #160729-00077#4 160819 by lori mark and add---(S)
     #LET l_where = l_where," AND decc002 >= '",g_master.bdate,"' AND decc002 <= '",g_master.edate,"'",
     #                      " AND deccent = mmafent AND decc001 = mmaf001 "
      LET l_where = l_where," AND deccent = mmafent AND decc001 = mmaf001 " 

      LET g_input_where = g_input_where," AND decc002 >= '",g_master.bdate,"' AND decc002 <= '",g_master.edate,"' "
     #160729-00077#4 160819 by lori mark and add---(E)
   ELSE
      #关联会员卡数据表mmaq_t抓取资料
      #                     选取/会员编号/姓名/性别/生日/年龄/手机号码/消费次数/消费金额/累计积分/精选会员标签
      #LET g_sql = " SELECT DISTINCT 'Y',mmaf001,mmaf008,oocql004,mmaf015,'',mmaf014,SUM(mmaq014) mmaq014,SUM(mmaq015) mmaq015,SUM(mmaq016) mmaq016,'' " #170109-00037#17 Mark By Ken 170116
      LET g_sql = " SELECT DISTINCT 'N',mmaf001,mmaf008,oocql004,mmaf015,'',mmaf014,SUM(mmaq014) mmaq014,SUM(mmaq015) mmaq015,SUM(mmaq016) mmaq016,'' "  #170109-00037#17 Add By Ken 170116
      
      LET l_from = "  FROM mmaq_t,mmaf_t ",
                   "       LEFT JOIN mmag_t ON mmagent = mmafent AND mmag001 = mmaf001 AND mmag002 = '01' ",
                   "       LEFT JOIN oocql_t ON oocqlent = mmagent AND oocql001 = '2016' AND oocql002 = mmag004 AND oocql003 = '",g_dlang,"' "
                   
      LET l_where = l_where," AND mmaqent = mmafent AND mmaq003 = mmaf001 "
   END IF 
   
   #160729-00077#4 160819 by lori mark and add---(S)
   #LET g_sql = g_sql,l_from,l_where," GROUP BY mmaf001,mmaf008,oocql004,mmaf015,mmaf014 ",
   #                                 " ORDER BY mmaf001"
   
   LET g_sql = g_sql,l_from,l_where,g_input_where,
               " GROUP BY mmaf001,mmaf008,oocql004,mmaf015,mmaf014 ",
               " ORDER BY mmaf001"   
   #160729-00077#4 160819 by lori mark and add---(E)
   #end add-point
 
   PREPARE acrp540_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR acrp540_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
   g_detail_d[l_ac].*
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
      #160729-00077#4 160819 by lori mark---(S)
      #IF NOT cl_null(g_master.mmaq014) THEN 
      #   IF g_detail_d[l_ac].mmaq014 != g_master.mmaq014 THEN 
      #      CONTINUE FOREACH 
      #   END IF 
      #END IF 
      #IF NOT cl_null(g_master.mmaq015) THEN 
      #   IF g_detail_d[l_ac].mmaq015 != g_master.mmaq015 THEN 
      #      CONTINUE FOREACH 
      #   END IF 
      #END IF 
      #IF NOT cl_null(g_master.mmaq016) THEN 
      #   IF g_detail_d[l_ac].mmaq016 != g_master.mmaq016 THEN 
      #      CONTINUE FOREACH 
      #   END IF 
      #END IF 
      #160729-00077#4 160819 by lori mark---(E)
      
      CALL acrp540_mmaf015_ref(g_detail_d[l_ac].mmaf015) RETURNING g_detail_d[l_ac].age
      #end add-point
      
      CALL acrp540_detail_show()      
 
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
   FREE acrp540_sel
   
   LET l_ac = 1
   CALL acrp540_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="acrp540.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION acrp540_fetch()
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
 
{<section id="acrp540.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION acrp540_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="acrp540.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION acrp540_filter()
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
   
   CALL acrp540_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="acrp540.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION acrp540_filter_parser(ps_field)
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
 
{<section id="acrp540.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION acrp540_filter_show(ps_field,ps_object)
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
   LET ls_condition = acrp540_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="acrp540.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 計算年齡
# Date & Author..: 2014/06/24 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION acrp540_mmaf015_ref(p_mmaf015)
DEFINE p_mmaf015      LIKE mmaf_t.mmaf015
DEFINE l_age          LIKE type_t.num5

   LET l_age = YEAR(g_today) - YEAR(p_mmaf015) + 1
   
   RETURN l_age
END FUNCTION

################################################################################
# Descriptions...: 開啟關閉欄位
# Memo...........:
# Usage..........: CALL acrp540_set_entry()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/06/24 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION acrp540_set_entry()
   
   IF NOT cl_null(g_master.mmag002_1) THEN
      CALL cl_set_comp_entry('mmag004_1',TRUE)
   ELSE
      LET g_master.mmag004_1 = ''
      DISPLAY BY NAME g_master.mmag004_1
      CALL cl_set_comp_entry('mmag004_1',FALSE)
   END IF 
   IF NOT cl_null(g_master.mmag002_2) THEN
      CALL cl_set_comp_entry('mmag004_2',TRUE)
   ELSE
      LET g_master.mmag004_2 = ''
      DISPLAY BY NAME g_master.mmag004_2
      CALL cl_set_comp_entry('mmag004_2',FALSE)
   END IF 
   IF NOT cl_null(g_master.mmag002_3) THEN
      CALL cl_set_comp_entry('mmag004_3',TRUE)
   ELSE
      LET g_master.mmag004_3 = ''
      DISPLAY BY NAME g_master.mmag004_3
      CALL cl_set_comp_entry('mmag004_3',FALSE)
   END IF 
   IF NOT cl_null(g_master.mmag002_4) THEN
      CALL cl_set_comp_entry('mmag004_4',TRUE)
   ELSE
      LET g_master.mmag004_4 = ''
      DISPLAY BY NAME g_master.mmag004_4
      CALL cl_set_comp_entry('mmag004_4',FALSE)
   END IF 
END FUNCTION

################################################################################
# Descriptions...: 執行
# Memo...........:
# Usage..........: CALL acrp540_process(ls_js)
# Input parameter: ls_js
# Return code....: 無
# Date & Author..: 2015/06/24 By yangxf
# Modify.........: 2016/08/19 By lori     更新屬性的同時須寫入更新條件crdf_t
################################################################################
PRIVATE FUNCTION acrp540_process(ls_js)
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_p01_status LIKE type_t.num5
   DEFINE li_idx        LIKE type_t.num5
   DEFINE l_n           LIKE type_t.num5
   DEFINE l_mmag003     LIKE mmag_t.mmag003
   DEFINE l_msg         LIKE type_t.chr100         #160225-00040#18 2016/05/05 s983961--add
   DEFINE l_date        DATETIME YEAR TO SECOND    #160729-00077#4 160819 by lori add 
   DEFINE l_crdf006     LIKE crdf_t.crdf006        #160729-00077#4 160819 by lori add
   DEFINE l_crdf007     LIKE crdf_t.crdf007        #160729-00077#4 160819 by lori add   
   #170109-00037#17 Add By Ken 170116(S)
   DEFINE l_cnt         LIKE type_t.num10             
   DEFINE l_err_cnt     LIKE type_t.num10
   #170109-00037#17 Add By Ken 170116(E)
   
   #160225-00040#18 2016/05/05 s983961--add(s)
   LET l_msg = cl_getmsg('ade-00114',g_lang)
   CALL cl_progress_no_window_ing(l_msg)  
   #160225-00040#18 2016/05/05 s983961--add(e)   
   
   CALL util.JSON.parse(ls_js,lc_param)
   LET l_n = g_detail_d.getLength()
   
   IF l_n = 0 OR cl_null(l_n) THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = '-400'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL acrp540_msg_show(2)   #160225-00040#1 Add By s983961 160505
      CALL cl_err() 
      RETURN 
   END IF
   
   LET g_flag2 = 'N'
   
   #170109-00037#17 Add By Ken 170116(S)
   LET l_cnt = 0
   LET l_err_cnt = 0
   #170109-00037#17 Add By Ken 170116(E)
   FOR l_n = 1 TO g_detail_d.getLength()
      IF g_detail_d[l_n].sel = 'Y' AND NOT cl_null(g_detail_d[l_n].mmaf001) THEN
         #170109-00037#17 Add By Ken 170116(S)
         LET l_cnt = l_cnt + 1
         IF NOT acrp540_lock_chk(l_n) THEN 
            LET l_err_cnt = l_err_cnt + 1         
            LET g_detail_d[l_n].sel = 'N'         
            CONTINUE FOR
         END IF
         #170109-00037#17 Add By Ken 170116(E)         
         LET g_flag2 = 'Y'
      END IF 
   END FOR

   #170109-00037#17 Add By Ken 170116(S)
   IF l_cnt = l_err_cnt THEN #有選取的筆數 = 被lock的筆數
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "ast-00867" #目前選取的資料,均已被鎖定,請重新操作 
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err() 
      RETURN
   END IF
   #170109-00037#17 Add By Ken 170116(E)
   
   #170109-00037#17 Mark By Ken 170116(S)
   #IF g_flag2 = 'N' THEN 
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code = '-400'
   #   LET g_errparam.extend = ''
   #   LET g_errparam.popup = TRUE
   #   CALL acrp540_msg_show(2)   #160225-00040#1 Add By s983961 160505
   #   CALL cl_err() 
   #   RETURN 
   #END IF 
   #170109-00037#17 Mark By Ken 170116(E)
   
   LET l_crdf006 = g_input_where   #160729-00077#4 160819 by lori add
   LET l_crdf007 = g_master.wc     #160729-00077#4 160819 by lori add 
   
   IF g_bgjob = "N" THEN
      CALL acrp540_ui_dialog_1()
      CALL s_transaction_begin() 
      #160225-00040#1 s983961 160505--add(s)
      LET l_msg = cl_getmsg('ast-00330',g_lang)   
      CALL cl_progress_no_window_ing(l_msg)
      #160225-00040#1 s983961 160505--add(e)      
      IF g_flag ='Y' THEN 
         #CALL cl_showmsg_init()    #170109-00037#17 Mark By Ken 170116  改用新錯誤訊息匯總
         FOR li_idx = 1 TO g_detail_d.getLength()
             IF g_detail_d[li_idx].sel = 'Y' THEN
                LET l_n = 0
                #查询会员是否已存在该属性
                SELECT COUNT(*) INTO l_n
                  FROM mmag_t
                 WHERE mmagent = g_enterprise
                   AND mmag001 = g_detail_d[li_idx].mmaf001
                   AND mmag002 = g_mmag002
                   AND mmag003 = g_mmag003

                IF l_n > 0 THEN 
                   #直接更新
                   UPDATE mmag_t SET mmag004 = g_mmag004
                    WHERE mmagent = g_enterprise
                      AND mmag001 = g_detail_d[li_idx].mmaf001
                      AND mmag002 = g_mmag002
                      AND mmag003 = g_mmag003
                   IF SQLCA.sqlcode THEN
                      #CALL cl_errmsg('',g_detail_d[li_idx].mmaf001,'',SQLCA.sqlcode,1)   #170109-00037#17 Mark By Ken 170116
                      #170109-00037#17 Add By Ken 170116(S)
                      INITIALIZE g_errparam TO NULL
	                   LET g_errparam.code =  SQLCA.sqlcode
	                   LET g_errparam.extend = g_detail_d[li_idx].mmaf001
	                   LET g_errparam.popup = TRUE
	                   CALL cl_err()                      
	                   #170109-00037#17 Add By Ken 170116(E)
                      LET g_flag2 = 'N'
                   ELSE
                      LET g_detail_d[li_idx].mmag004 = g_mmag004
                   END IF
                ELSE
                   #新增mmag_t
                   INSERT INTO mmag_t(mmagent,mmag001,mmag002,mmag003,mmag004,mmagstus)
                     VALUES(g_enterprise,g_detail_d[li_idx].mmaf001,g_mmag002,g_mmag003,g_mmag004,'Y')
                   IF SQLCA.sqlcode THEN
                      #CALL cl_errmsg('',g_detail_d[li_idx].mmaf001,'',SQLCA.sqlcode,1)  #170109-00037#17 Mark By Ken 170116
                      #170109-00037#17 Add By Ken 170116(S)
                      INITIALIZE g_errparam TO NULL
	                   LET g_errparam.code =  SQLCA.sqlcode
	                   LET g_errparam.extend = g_detail_d[li_idx].mmaf001
	                   LET g_errparam.popup = TRUE
	                   CALL cl_err()                      
	                   #170109-00037#17 Add By Ken 170116(E)                      
                      LET g_flag2 = 'N'
                   ELSE
                      LET g_detail_d[li_idx].mmag004 = g_mmag004
                   END IF
                END IF 
                
                #160729-00077#4 160819 by lori add---(S)   
                LET l_date = cl_get_current()                
                
                INSERT INTO crdf_t(crdfent, crdf001, crdf002, crdf003, crdf004,    #企業編號,會員編號/會員卡號,日期時間,人員編號,異動屬性
                                   crdf005, crdf006, crdf007)                      #異動屬性值,INPUT條件, QBE條件
                VALUES(g_enterprise, g_detail_d[li_idx].mmaf001, l_date, g_user, g_mmag002,
                       g_mmag004, l_crdf006, l_crdf007) 
                IF SQLCA.sqlcode THEN
                   #CALL cl_errmsg('',g_detail_d[li_idx].mmaf001,'',SQLCA.sqlcode,1)   #170109-00037#17 Mark By Ken 170116
                   #170109-00037#17 Add By Ken 170116(S)
                   INITIALIZE g_errparam TO NULL
	                LET g_errparam.code =  SQLCA.sqlcode
	                LET g_errparam.extend = g_detail_d[li_idx].mmaf001
	                LET g_errparam.popup = TRUE
	                CALL cl_err()                      
	                #170109-00037#17 Add By Ken 170116(E)                    
                   LET g_flag2 = 'N'
                ELSE
                   LET g_detail_d[li_idx].mmag004 = g_mmag004
                END IF                
                #160729-00077#4 160819 by lori add---(E)                
             END IF 
         END FOR 
         #CALL cl_err_showmsg()    #170109-00037#17 Add By Ken 170116  改用新錯誤訊息匯總
         IF g_flag2 = 'N' THEN
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'adz-00218'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
         ELSE
            CALL s_transaction_end('Y','0')  
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'adz-00217'
            LET g_errparam.extend = ''
            LET g_errparam.popup = FALSE
            CALL cl_err()
         END IF      
         LET INT_FLAG = TRUE         
         #CALL cl_ask_confirm3("std-00012","")   #160225-00040#1 s983961 160505--mark
      END IF 
   ELSE
      #背景作業完成處理
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
  
   #160225-00040#1 s983961 160505--add(s)
   LET l_msg = cl_getmsg('std-00012',g_lang)   
   CALL cl_progress_no_window_ing(l_msg)
   CALL cl_ask_confirm3("std-00012","")
   #160225-00040#1 s983961 160505--add(e)   
   
   #呼叫訊息中心傳遞本關完成訊息
   CALL acrp540_msgcentre_notify()
   
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: acrp540_msgcentre_notify()
# Date & Author..: 2015/06/24 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION acrp540_msgcentre_notify()
   DEFINE lc_state LIKE type_t.chr5
 
   INITIALIZE g_msgparam TO NULL
 
   LET g_msgparam.state = "process"
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
END FUNCTION

################################################################################
# Descriptions...: 标签操作
# Memo...........:
# Usage..........: CALL acrp540_ui_dialog_1()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2016/06/24 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION acrp540_ui_dialog_1()
   DEFINE li_idx    LIKE type_t.num5
   DEFINE ls_wc     STRING
   DEFINE lb_first  BOOLEAN
   DEFINE la_param  RECORD
             prog   STRING,
             param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   DEFINE lwin_curr       ui.Window
   DEFINE lfrm_curr       ui.Form
   DEFINE ls_path   STRING
   DEFINE l_mmag003 LIKE mmag_t.mmag003
   DEFINE l_date    DATETIME YEAR TO SECOND
   DEFINE l_n       LIKE type_t.num5
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_acrp540_s01 WITH FORM cl_ap_formpath("acr","acrp540_s01")
   LET g_flag = 'Y'
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   LET lwin_curr = ui.Window.getCurrent()
   LET lfrm_curr = lwin_curr.getForm()
   LET ls_path = os.Path.join(os.Path.join(FGL_GETENV("ERP"),"cfg"),"4tb")
   LET ls_path = os.Path.join(ls_path,"toolbar_lib.4tb")
   CALL lfrm_curr.loadToolBar(ls_path)
   CALL cl_set_combo_scc_part('mmag002','6831','11,12,13,14,15')  
   CALL cl_set_act_visible("accept,cancel", FALSE)
   LET g_mmag002 = ''
   LET g_mmag004 = ''
   LET g_mmag004_desc = ''
   DISPLAY g_mmag002 TO mmag002
   DISPLAY g_mmag004 TO mmag004
   DISPLAY g_mmag004_desc TO mmag004_desc
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      #輸入開始
      INPUT g_mmag002,g_mmag004 FROM mmag002,mmag004 ATTRIBUTE(WITHOUT DEFAULTS)
         
         ON CHANGE mmag002
            LET g_mmag004 = ''
            LET g_mmag004_desc = ''
            
         AFTER FIELD mmag004
            IF NOT cl_null(g_mmag004) AND NOT cl_null(g_mmag002) THEN 
               SELECT oocq004 INTO l_mmag003 from oocq_t where oocq001='2049' and oocq002 = g_mmag002 AND oocqent=g_enterprise #160905-00007#1 add
               SELECT oocql004 INTO g_mmag004_desc
                 FROM oocql_t
                WHERE oocqlent = g_enterprise
                  AND oocql001 = l_mmag003
                  AND oocql002 = g_mmag004
               DISPLAY g_mmag004_desc TO mmag004_desc
            END IF 
         
         ON ACTION controlp INFIELD mmag004
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            
            LET l_mmag003 = null
            SELECT oocq004 INTO l_mmag003 FROM oocq_t WHERE oocq001='2049' AND oocq002 = g_mmag002 AND oocqent=g_enterprise #160905-00007#1 add
            
            IF NOT cl_null(l_mmag003) THEN
               LET g_qryparam.where = "oocq001='",l_mmag003,"'"
            END IF 
            
            CALL q_oocq002_16()                      #呼叫開窗
            
            LET g_mmag004 = g_qryparam.return1
            DISPLAY BY NAME g_mmag004
            
            LET g_mmag004_desc = s_desc_get_acc_desc(l_mmag003,g_mmag004)   #160729-00077#4 160817 by lori add
            DISPLAY g_mmag004_desc TO mmag004_desc                          #160729-00077#4 160817 by lori add
            
            NEXT FIELD mmag004                     #返回原欄位
      END INPUT
      
      ON ACTION accept
         LET g_flag = 'Y' 
         ACCEPT DIALOG
        
      ON ACTION cancel
         LET INT_FLAG = TRUE 
         LET g_flag = 'N' 
         EXIT DIALOG
   
      ON ACTION close
         LET INT_FLAG = TRUE 
         LET g_flag = 'N' 
         EXIT DIALOG
   
      ON ACTION exit
         LET INT_FLAG = TRUE 
         LET g_flag = 'N' 
         EXIT DIALOG
         
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
   CALL cl_set_act_visible("accept,cancel", TRUE)
   #畫面關閉
   CLOSE WINDOW w_acrp540_s01
   IF g_flag = 'Y' THEN 
      #获取分类码
      SELECT oocq004 INTO g_mmag003 from oocq_t where oocq001='2049' and oocq002 = g_mmag002 AND oocqent=g_enterprise #160905-00007#1 add
      IF cl_null(g_mmag003) THEN 
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_mmag002
         LET g_errparam.code   = 'acr-00072'
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET g_flag = 'N'
      END IF 
      LET l_n = 0
      #检查分类码中是否存在分类码值
      SELECT COUNT(*) INTO l_n
        FROM oocq_t
       WHERE oocqent = g_enterprise
         AND oocq001 = g_mmag003
         AND oocq002 = g_mmag004
      IF l_n = 0 THEN
         LET l_date = cl_get_current()
         #新增此分类码值
         INSERT INTO oocq_t(oocqent,oocq001,oocq002,oocqstus,oocqownid,oocqowndp,oocqcrtid,oocqcrtdp,oocqcrtdt)
                     VALUES(g_enterprise,g_mmag003,g_mmag004,'Y',g_user,g_dept,g_user,g_dept,l_date)
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "oocq_t" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET g_flag = 'N'
         END IF 
      END IF 
   END IF 
END FUNCTION

################################################################################
# Descriptions...: 批次產生資料的進度條顯示次數
# Memo...........:
# Usage..........: CALL acrp540_msg_show(p_cnt)
# Input parameter: p_cnt
# Date & Author..: 20160505 By s983961
# Modify.........:
################################################################################
PRIVATE FUNCTION acrp540_msg_show(p_cnt)
DEFINE p_cnt            LIKE type_t.num5
DEFINE l_min_cnt        LIKE type_t.num5
DEFINE l_i              LIKE type_t.num5
DEFINE l_msg            STRING           

   LET l_min_cnt = 1
   IF p_cnt >1 THEN
     FOR l_i = l_min_cnt TO p_cnt
        LET l_msg = cl_getmsg('ast-00330',g_lang)
        CALL cl_progress_no_window_ing(l_msg)     
     END FOR
   END IF
   
   LET l_msg = cl_getmsg('std-00012',g_lang)
   CALL cl_progress_no_window_ing(l_msg)  
END FUNCTION

################################################################################
# Descriptions...: 檢查勾選資料是否有被lock
# Memo...........:
# Usage..........: CALL acrp540_lock_chk(p_ac)
#                  RETURNING r_success
# Input parameter: p_ac           第幾筆
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2017/01/16 By Ken    #170109-00037#17
# Modify.........:
################################################################################
PRIVATE FUNCTION acrp540_lock_chk(p_ac)
DEFINE p_ac             LIKE type_t.num10
DEFINE l_mmaf001        LIKE mmaf_t.mmaf001
DEFINE r_success        LIKE type_t.num10

   LET l_mmaf001 = ''
   LET r_success = TRUE
     
   EXECUTE acrp540_chk_lock_data USING g_detail_d[p_ac].mmaf001 
                                  INTO l_mmaf001
   IF cl_null(l_mmaf001) THEN
      #LET g_detail_d[p_ac].sel = 'N'
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'acr-00074'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = g_detail_d[p_ac].mmaf001 
      CALL cl_err()
      LET r_success = FALSE
   END IF   
   RETURN r_success
END FUNCTION

#end add-point
 
{</section>}
 
