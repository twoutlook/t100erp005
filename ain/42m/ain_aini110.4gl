#該程式未解開Section, 採用最新樣板產出!
{<section id="aini110.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2016-01-04 16:57:43), PR版次:0004(2016-11-16 10:08:04)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000108
#+ Filename...: aini110
#+ Description: 庫存需求等候調整作業
#+ Creator....: 01996(2014-06-06 14:23:53)
#+ Modifier...: 01996 -SD/PR- 08734
 
{</section>}
 
{<section id="aini110.global" >}
#應用 i00 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#Memos
#161108-00012#1  2016/11/09 By 08734  g_browser_cnt 由num5改為num10
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:free_style模組變數(Module Variable) name="free_style.variable"

#end add-point
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
 type type_g_inas_m        RECORD
       inas009 LIKE inas_t.inas009, 
   imaal003 LIKE type_t.chr80, 
   imaal004 LIKE type_t.chr80, 
   inas010 LIKE inas_t.inas010, 
   sum1 LIKE inag_t.inag033, 
   sum2 LIKE inag_t.inag008, 
   sum3 LIKE inas_t.inas012, 
   imaa006 LIKE type_t.chr80
       END RECORD
 
#單身 type 宣告
 TYPE type_g_inas_d        RECORD
       seq LIKE inas_t.inas002, 
   inas006 LIKE inas_t.inas006, 
   inas005 LIKE inas_t.inas005, 
   expect  LIKE type_t.dat,
   inas007 LIKE inas_t.inas007, 
   inas001 LIKE inas_t.inas001, 
   inas002 LIKE inas_t.inas002, 
   inas003 LIKE inas_t.inas003, 
   inas004 LIKE inas_t.inas004, 
   inas012 LIKE inas_t.inas012, 
   inas011 LIKE inas_t.inas011, 
   inas013 LIKE inas_t.inas013, 
   inas015 LIKE inas_t.inas015, 
   inas016 LIKE inas_t.inas016, 
   inas016_desc LIKE type_t.chr500, 
   inas017 LIKE inas_t.inas017, 
   inas017_desc LIKE type_t.chr500
       END RECORD
       
 TYPE type_g_inas2_d RECORD
    inag004   LIKE inag_t.inag004,
    inag004_desc LIKE type_t.chr500,
    inag005   LIKE inag_t.inag005,
    inag005_desc LIKE type_t.chr500,
    inag006   LIKE inag_t.inag006,
    inag003   LIKE inag_t.inag003,
    inag033   LIKE inag_t.inag033,
    inag008   LIKE inag_t.inag008,
    inag007   LIKE inag_t.inag007
                 END RECORD
 
 TYPE type_g_inas3_d RECORD
       type LIKE type_t.chr80, 
   date LIKE type_t.chr80, 
   num1 LIKE type_t.chr80, 
   num2 LIKE type_t.chr80, 
   unit LIKE type_t.chr80, 
   docno LIKE type_t.chr80, 
   seq1 LIKE type_t.chr80, 
   seq2 LIKE type_t.chr80, 
   seq3 LIKE type_t.chr80, 
   user LIKE type_t.chr80,
   user_desc LIKE type_t.chr500,   
   dept LIKE type_t.chr80,
   dept_desc LIKE type_t.chr500
       END RECORD
 
 
#無單頭append欄位定義
#無單身append欄位定義
 
#模組變數(Module Variables)
DEFINE g_inas_m          type_g_inas_m
DEFINE g_inas_m_t        type_g_inas_m
 
   
 
DEFINE g_inas_d          DYNAMIC ARRAY OF type_g_inas_d
DEFINE g_inas_d_t        type_g_inas_d
DEFINE g_inas3_d   DYNAMIC ARRAY OF type_g_inas3_d
DEFINE g_inas3_d_t type_g_inas3_d
DEFINE g_inas2_d   DYNAMIC ARRAY OF type_g_inas2_d
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING

 
 
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
 
DEFINE g_sql                 STRING
DEFINE g_forupd_sql          STRING
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_current_idx         LIKE type_t.num10     
DEFINE g_jump                LIKE type_t.num10        
DEFINE g_no_ask              LIKE type_t.num5        
DEFINE g_rec_b               LIKE type_t.num10  #161108-00012#1 num5==》num10         
DEFINE l_ac                  LIKE type_t.num10   #161108-00012#1 num5==》num10  
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog
 
DEFINE g_pagestart           LIKE type_t.num10  #161108-00012#1 num5==》num10         
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁
DEFINE g_bfill               LIKE type_t.chr5              #是否刷新單身
 
DEFINE g_detail_cnt          LIKE type_t.num10              #單身總筆數   #161108-00012#1 num5==》num10
DEFINE g_detail_idx          LIKE type_t.num10              #單身目前所在筆數  #161108-00012#1 num5==》num10
DEFINE g_detail_idx2         LIKE type_t.num10              #單身2目前所在筆數  #161108-00012#1 num5==》num10
#DEFINE g_browser_cnt         LIKE type_t.num5              #Browser總筆數     #161108-00012#1  2016/11/09 By 08734 mark
DEFINE g_browser_cnt         LIKE type_t.num10              #Browser總筆數     #161108-00012#1  2016/11/09 By 08734 add
DEFINE g_browser_idx         LIKE type_t.num10              #Browser目前所在筆數  #161108-00012#1 num5==》num10
DEFINE g_temp_idx            LIKE type_t.num10              #Browser目前所在筆數(暫存用)  #161108-00012#1 num5==》num10
 
DEFINE g_searchcol           STRING                        #查詢欄位代碼
DEFINE g_searchstr           STRING                        #查詢欄位字串
DEFINE g_order               STRING                        #查詢排序欄位
DEFINE g_state               STRING                        
DEFINE g_insert              LIKE type_t.chr5              #是否導到其他page                    
DEFINE g_current_row         LIKE type_t.num10              #Browser所在筆數  #161108-00012#1 num5==》num10
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_error_show          LIKE type_t.num5
DEFINE gs_keys               DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak           DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_aw                  STRING                        #確定當下點擊的單身
DEFINE g_default             BOOLEAN 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_inas009      LIKE inas_t.inas009,
       b_inas010      LIKE inas_t.inas010
      END RECORD 
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
{</section>}
 
{<section id="aini110.main" >}
#+ 作業開始
MAIN
   #add-point:main段define name="main.define"
   
   #end add-point    
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point
 
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ain","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
 
   #add-point:SQL_define name="main.define_sql"
   LET g_sql = " SELECT UNIQUE inas009,imaal003,imaal004,inas010",
               " FROM inas_t",
               " LEFT JOIN imaal_t ON imaalent = inasent AND imaal001 = inas009 AND imaal002 = '",g_dlang,"'",
               " WHERE inasent = '" ||g_enterprise|| "' AND inassite = '" ||g_site|| "' AND inas009 = ? AND inas010 = ? "
   #add-point:SQL_define
   
   #end add-point
   PREPARE aini110_master_referesh FROM g_sql

   LET g_forupd_sql = "SELECT inas009,'','',inas010,'','','','' FROM inas_t WHERE inasent= ? AND inassite="
   
   CALL aini110_create_temp_table()

   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)    #轉換不同資料庫語法
   DECLARE aini110_cl CURSOR FROM g_forupd_sql 
   
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aini110 WITH FORM cl_ap_formpath("ain",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL aini110_init()
 
      #進入選單 Menu (='N')
      CALL aini110_ui_dialog()
   
      #畫面關閉
      CLOSE WINDOW w_aini110
   END IF
 
   #add-point:作業離開前 name="main.exit"
   CALL aini110_drop()
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
 
END MAIN
 
{</section>}
 
{<section id="aini110.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"
#建立临时表
PRIVATE FUNCTION aini110_create_temp_table()

   CREATE TEMP TABLE inas3_temp( 
                     seq_temp   SMALLINT,
                     date_temp   DATE,
                     num_temp    DECIMAL(20,6),
                     num2_temp   DECIMAL(20,6));
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create inas3_temp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

#      RETURN FALSE
   END IF
#   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION aini110_ui_dialog()
   DEFINE la_param  RECORD
             prog   STRING,
             param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   DEFINE li_idx    LIKE type_t.num10  #161108-00012#1 num5==》num10
   DEFINE ls_wc     STRING
   DEFINE lb_first  BOOLEAN
   #add-point:ui_dialog段define
   DEFINE l_dnd       ui.DragDrop
   DEFINE arr_inas   DYNAMIC ARRAY OF type_g_inas_d
   DEFINE l_ac1     LIKE type_t.num10  #161108-00012#1 num5==》num10
   DEFINE l_date_before LIKE type_t.dat
   DEFINE l_date_after  LIKE type_t.dat
   DEFINE l_i       LIKE type_t.num5
   DEFINE l_days    LIKE type_t.num5
   DEFINE l_before_second  LIKE type_t.num20
   DEFINE l_after_second  LIKE type_t.num20
   DEFINE l_before_time STRING
   DEFINE l_after_time  STRING
   DEFINE ld_standard_time DATETIME YEAR TO FRACTION(5)
   DEFINE l_date_result DATETIME YEAR TO FRACTION(5)
   DEFINE l_diff_hour       INTERVAL HOUR TO FRACTION(5)
   DEFINE l_diff_minute     INTERVAL MINUTE TO FRACTION(5)
   DEFINE l_diff_second     LIKE type_t.num20
   DEFINE l_diff_second2     INTERVAL SECOND TO FRACTION(5) 
   DEFINE l_day_str  STRING
   DEFINE l_hour_str STRING
   DEFINE l_minute_str STRING
   DEFINE l_second_str STRING   
   DEFINE l_day_num  LIKE type_t.num5
   DEFINE l_hour_num LIKE type_t.num5
   DEFINE l_minute_num LIKE type_t.num5
   DEFINE l_second_num LIKE type_t.num5
   
   CALL cl_set_act_visible("accept,cancel", FALSE)

   LET lb_first = TRUE


   #add-point:ui_dialog段before dialog
   CALL aini110_query()
   #end add-point

   WHILE TRUE

      CALL aini110_browser_fill("")


      #判斷前一個動作是否為新增, 若是的話切換到新增的筆數
#      IF g_state = "Y" THEN
#         FOR li_idx = 1 TO g_browser.getLength()
#            IF g_browser[li_idx].b_inas009 = g_inas009_t
#               AND g_browser[li_idx].b_inas010 = g_inas010_t
#               THEN
#               LET g_current_row = li_idx
#               EXIT FOR
#            END IF
#         END FOR
#         LET g_state = ""
#      END IF

      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)


         DISPLAY ARRAY g_inas_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1

            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL aini110_ui_detailshow()

               #add-point:page1自定義行為

               #end add-point

            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail1")

               #控制stus哪個按鈕可以按
             ON DRAG_START(l_dnd)
                  LET l_ac = ARR_CURR()
                  LET l_i = 1
                  CALL arr_inas.clear()
#                  LET l_date_before = g_inas_d[l_ac].inas006
#                  FOR li_idx = 1 TO g_inas_d.getLength()
#                     IF DIALOG.isRowSelected("s_detail1",li_idx) THEN
#                        LET arr_inas[l_i].* = g_inas_d[li_idx].*
#                        LET l_i = l_i + 1
#                     END IF
#                  END FOR
             ON DRAG_FINISHED(l_dnd)
                  
             ON DRAG_ENTER(l_dnd)

             ON DROP(l_dnd)
                
                LET l_ac1 = l_dnd.getLocationRow()
#                CALL DIALOG.insertRow("s_detail1",l_ac1)
#                CALL DIALOG.setCurrentRow("s_detail1",l_ac1)
#                IF cl_null(l_ac1) THEN
#                   LET l_ac1 = l_dnd.getLocationRow()
#                END IF
                IF g_inas_d.getLength() = 2 THEN
                   IF l_ac = 1 THEN
                      UPDATE inas_t SET inas006 = g_inas_d[l_ac1].inas006 + 1
                               WHERE inasent = g_enterprise AND inassite = g_site
                                 AND inas001 = g_inas_d[l_ac].inas001
                                 AND inas002 = g_inas_d[l_ac].inas002
                                 AND inas003 = g_inas_d[l_ac].inas003
                                 AND inas004 = g_inas_d[l_ac].inas004
                   ELSE
                      UPDATE inas_t SET inas006 = g_inas_d[l_ac1].inas006 - 1
                               WHERE inasent = g_enterprise AND inassite = g_site
                                 AND inas001 = g_inas_d[l_ac].inas001
                                 AND inas002 = g_inas_d[l_ac].inas002
                                 AND inas003 = g_inas_d[l_ac].inas003
                                 AND inas004 = g_inas_d[l_ac].inas004
                   END IF
                ELSE
                   LET l_date_before = g_inas_d[l_ac1].inas006
                   LET l_date_after = g_inas_d[l_ac].inas006
                   
                   LET l_days = l_date_after - l_date_before  #计算出相差天数
                   
                   IF l_days >= 2 THEN
                      UPDATE inas_t SET inas006 = g_inas_d[l_ac1].inas006 + 1
                               WHERE inasent = g_enterprise AND inassite = g_site
                                 AND inas001 = g_inas_d[l_ac].inas001
                                 AND inas002 = g_inas_d[l_ac].inas002
                                 AND inas003 = g_inas_d[l_ac].inas003
                                 AND inas004 = g_inas_d[l_ac].inas004
                   ELSE
                      LET l_before_time = g_inas_d[l_ac1].inas006     
                      LET l_after_time = g_inas_d[l_ac].inas006
                      LET l_day_str = l_before_time.subString(9,10)
                      LET l_hour_str = l_before_time.subString(12,13)
                      LET l_minute_str  = l_before_time.subString(15,16)
                      LET l_second_str  = l_before_time.subString(18,19)
                      LET l_day_num = l_day_str
                      LET l_hour_num = l_hour_str
                      LET l_minute_num = l_minute_str
                      LET l_second_num = l_second_str
                      LET l_before_second = (l_day_num * 24 * 60 * 60) + (l_hour_num * 60 * 60) + (l_minute_num * 60) + l_second_num
                      
                      LET l_day_str = l_after_time.subString(9,10)
                      LET l_hour_str = l_after_time.subString(12,13)
                      LET l_minute_str  = l_after_time.subString(15,16)
                      LET l_second_str  = l_after_time.subString(18,19)
                      LET l_day_num = l_day_str
                      LET l_hour_num = l_hour_str
                      LET l_minute_num = l_minute_str
                      LET l_second_num = l_second_str
                      LET l_after_second = (l_day_num * 24 * 60 * 60) + (l_hour_num * 60 * 60) + (l_minute_num * 60) + l_second_num
                      
                      LET l_diff_second = l_after_second - l_before_second
                      LET ld_standard_time = g_inas_d[l_ac1].inas006
                      IF (l_days = 1) OR (l_days = 0 AND l_diff_second > 7200) THEN   #如果 天数 相差一天 或者 是同一天但是相差两个小时以上
                         LET l_diff_hour = 1 UNITS HOUR 
                         LET l_date_result = ld_standard_time + l_diff_hour 
                      ELSE  #如果同一天 相差两个小时以内,但是在两分钟以上                
                         IF l_diff_second > 120  THEN
                            LET l_diff_minute = 1 UNITS MINUTE
                            LET l_date_result = ld_standard_time + l_diff_minute 
                         ELSE #如果是两分钟以内
                            LET l_diff_second2 = 1 UNITS SECOND
                            LET l_date_result = ld_standard_time + l_diff_second2
                         END IF
                      END IF
                      UPDATE inas_t SET inas006 = l_date_result
                               WHERE inasent = g_enterprise AND inassite = g_site
                                 AND inas001 = g_inas_d[l_ac].inas001
                                 AND inas002 = g_inas_d[l_ac].inas002
                                 AND inas003 = g_inas_d[l_ac].inas003
                                 AND inas004 = g_inas_d[l_ac].inas004   
                   END IF
                END IF
                
                
                
#                IF l_days >= 2 OR l_days <= -2 THEN
#                   UPDATE inas_t SET inas006 = g_inas_d[l_ac1].inas006 + 1
#                               WHERE inasent = g_enterprise AND inassite = g_site
#                                 AND inas001 = g_inas_d[l_ac].inas001
#                                 AND inas002 = g_inas_d[l_ac].inas002
#                                 AND inas003 = g_inas_d[l_ac].inas003
#                                 AND inas004 = g_inas_d[l_ac].inas004
#                ELSE
#                   LET l_diff_time = (1 * 60) UNITS MINUTE 
#                   LET ld_standard_time = g_inas_d[l_ac1].inas006
#                   LET ld_standard_time = ld_standard_time + l_diff_time
#                   UPDATE inas_t SET inas006 = ld_standard_time
#                               WHERE inasent = g_enterprise AND inassite = g_site
#                                 AND inas001 = g_inas_d[l_ac].inas001
#                                 AND inas002 = g_inas_d[l_ac].inas002
#                                 AND inas003 = g_inas_d[l_ac].inas003
#                                 AND inas004 = g_inas_d[l_ac].inas004
#                END IF
                CALL aini110_b_fill()
            #add-point:page1自定義行為

            #end add-point

         END DISPLAY

         DISPLAY ARRAY g_inas2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)

            BEFORE ROW
#               LET l_ac = DIALOG.getCurrentRow("s_detail2")
#               LET g_detail_idx = l_ac
#               DISPLAY g_detail_idx TO FORMONLY.idx
#               CALL aini110_ui_detailshow()

               #add-point:page1自定義行為

               #end add-point

            BEFORE DISPLAY
#               CALL FGL_SET_ARR_CURR(g_detail_idx)



            #add-point:page2自定義行為

            #end add-point

         END DISPLAY

         DISPLAY ARRAY g_inas3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)

            BEFORE ROW
#               LET l_ac = DIALOG.getCurrentRow("s_detail3")
#               LET g_detail_idx = l_ac
#               DISPLAY g_detail_idx TO FORMONLY.idx
#               CALL aini110_ui_detailshow()

               #add-point:page1自定義行為

               #end add-point

            BEFORE DISPLAY
#               CALL FGL_SET_ARR_CURR(g_detail_idx)
#


            #add-point:page2自定義行為

            #end add-point

         END DISPLAY


         #add-point:ui_dialog段自定義display array

         #end add-point


         BEFORE DIALOG
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
               CALL aini110_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aini110_ui_detailshow() #Setting the current row

            #add-point:ui_dialog段before dialog2

            #end add-point




         ON ACTION first
            CALL aini110_fetch('F')
            LET g_current_row = g_current_idx

         ON ACTION previous
            CALL aini110_fetch('P')
            LET g_current_row = g_current_idx

         ON ACTION jump
            CALL aini110_fetch('/')
            LET g_current_row = g_current_idx

         ON ACTION next
            CALL aini110_fetch('N')
            LET g_current_row = g_current_idx

         ON ACTION last
            CALL aini110_fetch('L')
            LET g_current_row = g_current_idx

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
               NEXT FIELD inas001
            END IF

         ON ACTION controls      #單頭摺疊，可利用hot key "Ctrl-s"開啟/關閉單頭
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
               CALL aini110_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF

         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL aini110_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "-100"
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CLEAR FORM
               ELSE
                  CALL aini110_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()


         #+ 此段落由子樣板a43產生
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aini110_query()
               #add-point:ON ACTION query

               #END add-point

            END IF


         #+ 此段落由子樣板a43產生
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN

               #add-point:ON ACTION output

               #END add-point
               EXIT DIALOG
            END IF


         #+ 此段落由子樣板a43產生
         ON ACTION rest
            LET g_action_choice="rest"
            IF cl_auth_chk_act("rest") THEN

               #add-point:ON ACTION rest
               CALL aini110_show()
               #END add-point
               EXIT DIALOG
            END IF


         #+ 此段落由子樣板a43產生
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL aini110_modify()
               #add-point:ON ACTION modify_detail

               #END add-point
               EXIT DIALOG
            END IF
         #+ 此段落由子樣板a43產生
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL aini110_modify()
               #add-point:ON ACTION modify_detail

               #END add-point
               EXIT DIALOG
            END IF





         #+ 此段落由子樣板a46產生
         #新增相關文件
         ON ACTION related_document
            CALL aini110_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document

               #END add-point
               CALL cl_doc()
            END IF

         ON ACTION agendum
            CALL aini110_set_pk_array()
            #add-point:ON ACTION agendum

            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()

         ON ACTION followup
            CALL aini110_set_pk_array()
            #add-point:ON ACTION followup

            #END add-point
            CALL cl_user_overview_follow('')

          ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               #browser
               CALL g_export_node.clear()

               LET g_main_hidden = 0  #xj add
               LET g_export_node[1] = base.typeInfo.create(g_inas_d)
               LET g_export_id[1]   = "s_detail1"
            
               #add-point:ON ACTION exporttoexcel
               LET g_export_node[2] = base.typeInfo.create(g_inas3_d)
               LET g_export_id[2]   = "s_detail3"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()

            END IF

         #主選單用ACTION
         &include "main_menu.4gl"
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

PRIVATE FUNCTION aini110_browser_fill(ps_page_action)
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   DEFINE l_searchcol       STRING
   #add-point:browser_fill段define

   #end add-point

   #add-point:browser_fill段動作開始前

   #end add-point

   CALL g_browser.clear()

   #搜尋用
   IF cl_null(g_searchcol) OR g_searchcol = '0' THEN
      LET l_searchcol = ""
   ELSE
      LET l_searchcol = g_searchcol
   END IF

   LET l_wc  = g_wc.trim()
   IF cl_null(l_wc) THEN  #p_wc 查詢條件
      RETURN
   END IF

   
   #單身未輸入搜尋條件
   LET l_sub_sql = " SELECT UNIQUE inas009,inas010 ",

                   " FROM inas_t ",
                   " ",
                   " ",
                   " WHERE inasent = '" ||g_enterprise|| "' AND inassite = '" ||g_site|| "' AND ",l_wc CLIPPED, cl_sql_add_filter("inas_t")
   

   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"

   #add-point:browser_fill,count前

   #end add-point

   PREPARE header_cnt_pre FROM g_sql
   EXECUTE header_cnt_pre INTO g_browser_cnt   #總筆數
   FREE header_cnt_pre

   #若超過最大顯示筆數
   LET g_error_show = 0

   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示

   #LET g_page_action = ps_page_action          # Keep Action
   IF ps_page_action = "first" OR
      ps_page_action = "prev"  OR
      ps_page_action = "next"  OR
      ps_page_action = "last"  THEN
      LET g_page_action = ps_page_action        #g_page_action 這個會影響 browser 下面四個button 的判斷
   END IF

   CASE ps_page_action
      WHEN "F"
         LET g_pagestart = 1

      WHEN "P"
         LET g_pagestart = g_pagestart - g_max_browse
         IF g_pagestart < 1 THEN
             LET g_pagestart = 1
         END IF

      WHEN "N"
         LET g_pagestart = g_pagestart + g_max_browse
         IF g_pagestart > g_browser_cnt THEN
            LET g_pagestart = g_browser_cnt - (g_browser_cnt mod g_max_browse) + 1
            WHILE g_pagestart > g_browser_cnt
               LET g_pagestart = g_pagestart - g_max_browse
            END WHILE
         END IF

      WHEN "L"
         LET g_pagestart = g_browser_cnt - (g_browser_cnt mod g_max_browse) + 1
         WHILE g_pagestart > g_browser_cnt
            LET g_pagestart = g_pagestart - g_max_browse
         END WHILE

      OTHERWISE
         LET g_pagestart = 1

   END CASE

   #單身有輸入查詢條件且非null
   
   #單身無輸入資料
   LET l_sub_sql  = "SELECT DISTINCT inas009,inas010 ",
                    " FROM inas_t ",
                    " WHERE inasent = '" ||g_enterprise|| "' AND inassite = '" ||g_site|| "' AND ", g_wc, cl_sql_add_filter("inas_t")
   
   

   #add-point:browser_fill,sql_rank前

   #end add-point

   LET l_sql_rank = "SELECT inas009,inas010,DENSE_RANK() OVER(ORDER BY inas009,inas010) AS RANK ",
                    " FROM (",l_sub_sql,") "

   #定義翻頁CURSOR
   LET g_sql= " SELECT inas009,inas010 FROM (",l_sql_rank,") WHERE RANK>=",g_pagestart,
              " AND RANK < ", g_pagestart + g_max_browse,
 #             " ORDER BY ",l_searchcol, " ", g_order
               " ORDER BY inas009,inas010"

   #add-point:browser_fill,pre前

   #end add-point

   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre

   CALL g_browser.clear()
   LET g_cnt = 1
   FOREACH browse_cur INTO g_browser[g_cnt].b_inas009,g_browser[g_cnt].b_inas010
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF



      #add-point:browser_fill段reference

      #end add-point

      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH

   CALL g_browser.deleteElement(g_cnt)
   IF g_browser.getLength() = 0 AND g_wc THEN
      INITIALIZE g_inas_m.* TO NULL
      CALL g_inas_d.clear()
      CALL g_inas2_d.clear()
      CALL g_inas3_d.clear()

      #add-point:browser_fill段after_clear

      #end add-point
      CLEAR FORM
   END IF

   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0

#   CALL aini110_fetch('')
   FREE browse_pre
   
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("modify,modify_detail,delete,reproduce",FALSE)
      CALL cl_navigator_setting(0,0)
#   ELSE
#      CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   END IF

END FUNCTION

PRIVATE FUNCTION aini110_ui_headershow()
   #add-point:ui_headershow段define

   #end add-point

   LET  g_inas_m.inas009 = g_browser[g_current_idx].b_inas009
   LET  g_inas_m.inas010 = g_browser[g_current_idx].b_inas010

   EXECUTE aini110_master_referesh USING g_browser[g_current_idx].b_inas009,g_browser[g_current_idx].b_inas010 
     INTO g_inas_m.inas009,g_inas_m.imaal003,g_inas_m.imaal004,g_inas_m.inas010
   CALL aini110_show()

END FUNCTION

PRIVATE FUNCTION aini110_ui_detailshow()
   #add-point:ui_detailshow段define

   #end add-point

   #add-point:ui_detailshow段before

   #end add-point

   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)

      #add-point:ui_detailshow段more

      #end add-point
   END IF

   #add-point:ui_detailshow段after

   #end add-point

END FUNCTION

PRIVATE FUNCTION aini110_construct()
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING
   DEFINE ls_wc       STRING
   #add-point:cs段define

   #end add-point

   #清除畫面上相關資料
   CLEAR FORM
   INITIALIZE g_inas_m.* TO NULL
   CALL g_inas_d.clear()
   CALL g_inas3_d.clear()

   INITIALIZE g_wc TO NULL
   
   LET g_action_choice = ""

   LET g_qryparam.state = 'c'

   #add-point:cs段construct外

   #end add-point

   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #單頭
      CONSTRUCT BY NAME g_wc ON inas009,inas010

         BEFORE CONSTRUCT
            #add-point:cs段more_construct

            #end add-point

        #---------------------------<  Master  >---------------------------
         #----<<inas009>>----
         #此段落由子樣板a01產生
         BEFORE FIELD inas009
            #add-point:BEFORE FIELD inas009

            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD inas009

            #add-point:AFTER FIELD inas009

            #END add-point


         #Ctrlp:construct.c.inas009
          ON ACTION controlp INFIELD inas009
            #add-point:ON ACTION controlp INFIELD inas009
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inas009()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inas009  #顯示到畫面上
            NEXT FIELD inas009
            #END add-point

         #----<<imaal003>>----
         #----<<imaal004>>----
         #----<<inas010>>----
         #此段落由子樣板a01產生
         BEFORE FIELD inas010
            #add-point:BEFORE FIELD inas010

            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD inas010

            #add-point:AFTER FIELD inas010

            #END add-point


         #Ctrlp:construct.c.inas010
          ON ACTION controlp INFIELD inas010
            #add-point:ON ACTION controlp INFIELD inas010
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inas010()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inas010  #顯示到畫面上
            NEXT FIELD inas010
            #END add-point

         #----<<sum1>>----
         #----<<sum2>>----
         #----<<sum3>>----
         #----<<imaa006>>----


      END CONSTRUCT

     
      #add-point:cs段more_construct

      #end add-point

      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:ui_dialog段b_dialog

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

   #add-point:cs段after_construct

   #end add-point

   #組合g_wc2
   
   LET g_current_row = 1

   IF INT_FLAG THEN
      RETURN
   END IF

   LET g_wc_filter = ""

END FUNCTION

PRIVATE FUNCTION aini110_query()
   DEFINE ls_wc STRING
   #add-point:query段define

   #end add-point

   #add-point:query開始前

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
   CALL g_inas_d.clear()
   CALL g_inas_d.clear()
   CALL g_inas3_d.clear()

   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count

   CALL aini110_construct()

   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      CALL aini110_browser_fill("")
      CALL aini110_fetch("")
      RETURN
   END IF

   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 0
   LET g_detail_idx2 = 0

   LET g_error_show = 1
   CALL aini110_browser_fill("F")

   #儲存WC資訊
   CALL cl_dlg_save_user_latestqry("("||g_wc||")")

   #備份搜尋條件
   LET ls_wc = g_wc

   IF g_browser.getLength() = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "-100"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()

   ELSE
      CALL aini110_fetch("F")
   END IF

   LET g_wc_filter = ""

END FUNCTION

PRIVATE FUNCTION aini110_fetch(p_flag)
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define

   #end add-point

   #add-point:fetch段動作開始前

   #end add-point

   CASE p_flag
      WHEN 'F' LET g_current_idx = 1
      WHEN 'L' LET g_current_idx = g_header_cnt
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

#   CALL aini110_browser_fill(p_flag)

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
   LET g_browser_idx = g_pagestart+g_current_idx-1
   DISPLAY g_browser_idx TO FORMONLY.b_index   #當下筆數
   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數
   DISPLAY g_browser_idx TO FORMONLY.h_index   #當下筆數
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數

   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )

   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF

   #超出範圍
   IF g_current_idx > g_browser.getLength() THEN
      LET g_current_idx = g_browser.getLength()
   END IF

   LET  g_inas_m.inas009 = g_browser[g_current_idx].b_inas009
   LET  g_inas_m.inas010 = g_browser[g_current_idx].b_inas010

   #重讀DB,因TEMP有不被更新特性
   EXECUTE aini110_master_referesh USING g_browser[g_current_idx].b_inas009,g_browser[g_current_idx].b_inas010 
      INTO g_inas_m.inas009,g_inas_m.imaal003,g_inas_m.imaal004,g_inas_m.inas010
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "inas_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      INITIALIZE g_inas_m.* TO NULL
      RETURN
   END IF

   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)

   #重新顯示
   CALL aini110_show()

   #檢查此單據是否需顯示BPM簽核狀況按鈕


END FUNCTION

PRIVATE FUNCTION aini110_init()
   #add-point:init段define

   #end add-point

   LET g_bfill = "Y"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1


   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件

   #add-point:畫面資料初始化
   CALL cl_set_combo_scc('type','3019')
   CALL cl_set_combo_scc('inas007','24')

   #end add-point

   

END FUNCTION

PRIVATE FUNCTION aini110_modify()
  #add-point:modify段define
   
   #end add-point    
   

   
   EXECUTE aini110_master_referesh USING g_inas_m.inas009,g_inas_m.inas010 INTO g_inas_m.inas009,g_inas_m.imaal003,g_inas_m.imaal004,g_inas_m.inas010
 
   ERROR ""
  
 
   CALL s_transaction_begin()
   
   
   CALL s_transaction_end('Y','0')
 
   CALL aini110_show()
   WHILE TRUE
 
 
      #add-point:modify段修改前
      
      #end add-point
      
      CALL aini110_input("u")     #欄位更改
      
      #add-point:modify段修改後
      
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_inas_m.* = g_inas_m_t.*
         CALL aini110_show()
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9001
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()

         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更
      
      EXIT WHILE
      
   END WHILE
 
   #修改歷程記錄
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL aini110_browser_fill("")
   CALL s_transaction_end('Y','0')
   
   #流程通知預埋點-U
 
   CALL aini110_b_fill()
END FUNCTION

PRIVATE FUNCTION aini110_input(p_cmd)
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd_t               LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_ac_t                LIKE type_t.num10                #未取消的ARRAY CNT  #161108-00012#1 num5==》num10
   DEFINE  l_n                   LIKE type_t.num5                #檢查重複用
   DEFINE  l_cnt                 LIKE type_t.num5                #檢查重複用
   DEFINE  l_lock_sw             LIKE type_t.chr1                #單身鎖住否
   DEFINE  l_allow_insert        LIKE type_t.num5                #可新增否
   DEFINE  l_allow_delete        LIKE type_t.num5                #可刪除否
   DEFINE  l_count               LIKE type_t.num5
   DEFINE  l_i                   LIKE type_t.num5
   DEFINE  l_insert              BOOLEAN
   DEFINE  ls_return             STRING
   DEFINE  l_var_keys            DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys          DYNAMIC ARRAY OF STRING
   DEFINE  l_vars                DYNAMIC ARRAY OF STRING
   DEFINE  l_fields              DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak        DYNAMIC ARRAY OF STRING
   DEFINE  lb_reproduce          BOOLEAN
   DEFINE  li_reproduce          LIKE type_t.num5
   DEFINE  li_reproduce_target   LIKE type_t.num5
   #add-point:input段define

   #end add-point

   #先做狀態判定
   IF p_cmd = 'r' THEN
      LET l_cmd_t = 'r'
      LET p_cmd   = 'a'
   ELSE
      LET l_cmd_t = p_cmd
   END IF

   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF

   CALL cl_set_head_visible("","YES")

   LET l_insert = FALSE
   LET g_action_choice = ""

   #add-point:input段define_sql

   #end add-point
   LET g_forupd_sql = "SELECT inas006,inas005,'',inas007,inas001,inas002,inas003,inas004,inas012,
       inas011,inas013,inas015,inas016,'',inas017,'','','','','','','','','','','','' FROM inas_t WHERE
       inasent=? AND inassite=? AND inas001=? AND inas002=? AND inas003=? AND inas004=? FOR UPDATE"
   #add-point:input段define_sql

   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE aini110_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR

   LET g_qryparam.state = 'i'

   LET lb_reproduce = FALSE

   #add-point:進入修改段前

   #end add-point

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #Page1 預設值產生於此處
      INPUT ARRAY g_inas_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)

         #自訂單身ACTION


         #+ 此段落由子樣板a43產生
         ON ACTION rest
            LET g_action_choice="rest"
            IF cl_auth_chk_act("rest") THEN

               #add-point:ON ACTION rest
               CALL aini110_b_fill()
               #END add-point
            END IF



         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN
              CALL FGL_SET_ARR_CURR(g_inas_d.getLength()+1)
              LET g_insert = 'N'
           END IF

            CALL aini110_b_fill()
            IF g_rec_b != 0 THEN
               CALL fgl_set_arr_curr(l_ac)
            END IF
            #add-point:資料輸入前

            #end add-point

         BEFORE ROW
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx


            CALL s_transaction_begin()

            #判定新增或修改
            

            LET l_cmd = ''

            IF g_rec_b >= l_ac
               AND g_inas_d[l_ac].inas001 IS NOT NULL
               AND g_inas_d[l_ac].inas002 IS NOT NULL
               AND g_inas_d[l_ac].inas003 IS NOT NULL
               AND g_inas_d[l_ac].inas004 IS NOT NULL

            THEN
               LET l_cmd='u'
               LET g_inas_d_t.* = g_inas_d[l_ac].*  #BACKUP
               
               #add-point:set_entry_b後

               #end add-point
              
               OPEN aini110_bcl USING g_enterprise, g_site,

                                                g_inas_d_t.inas001
                                                ,g_inas_d_t.inas002
                                                ,g_inas_d_t.inas003
                                                ,g_inas_d_t.inas004

               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  STATUS
                  LET g_errparam.extend = "OPEN aini110_bcl:"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET l_lock_sw='Y'
               ELSE
                  FETCH aini110_bcl INTO g_inas_d[l_ac].inas006,g_inas_d[l_ac].inas005,
                      g_inas_d[l_ac].expect,g_inas_d[l_ac].inas007,g_inas_d[l_ac].inas001,g_inas_d[l_ac].inas002,
                      g_inas_d[l_ac].inas003,g_inas_d[l_ac].inas004,g_inas_d[l_ac].inas012,g_inas_d[l_ac].inas011,
                      g_inas_d[l_ac].inas013,g_inas_d[l_ac].inas015,g_inas_d[l_ac].inas016,g_inas_d[l_ac].inas016_desc,
                      g_inas_d[l_ac].inas017,g_inas_d[l_ac].inas017_desc,g_inas3_d[l_ac].type,g_inas3_d[l_ac].date,
                      g_inas3_d[l_ac].num1,g_inas3_d[l_ac].num2,g_inas3_d[l_ac].unit,g_inas3_d[l_ac].docno,
                      g_inas3_d[l_ac].seq1,g_inas3_d[l_ac].seq2,g_inas3_d[l_ac].seq3,g_inas3_d[l_ac].user,
                      g_inas3_d[l_ac].dept
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = SQLCA.sqlcode
                      LET g_errparam.extend = g_inas_d_t.inas001
                      LET g_errparam.popup = TRUE
                      CALL cl_err()

                      LET l_lock_sw = "Y"
                  END IF

                  CALL aini110_ref_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row

         #----<<seq>>----
         #此段落由子樣板a01產生
         BEFORE FIELD seq
            #add-point:BEFORE FIELD seq

            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD seq

            #add-point:AFTER FIELD seq

            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE seq
            #add-point:ON CHANGE seq

            #END add-point

         #----<<inas006>>----
         #此段落由子樣板a01產生
         BEFORE FIELD inas006
            #add-point:BEFORE FIELD inas006

            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD inas006

            #add-point:AFTER FIELD inas006

            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE inas006
            #add-point:ON CHANGE inas006

            #END add-point

         #----<<inas005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD inas005
            #add-point:BEFORE FIELD inas005

            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD inas005

            #add-point:AFTER FIELD inas005

            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE inas005
            #add-point:ON CHANGE inas005

            #END add-point





         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_inas_d[l_ac].* = g_inas_d_t.*
               CLOSE aini110_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG
            END IF

            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_inas_d[l_ac].inas001
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_inas_d[l_ac].* = g_inas_d_t.*
            ELSE
               #寫入修改者/修改日期資訊


               #add-point:單身修改前

               #end add-point

               UPDATE inas_t SET (inas006,inas005,inas007,inas001,inas002,inas003,inas004,inas012,inas011,
                   inas013,inas015,inas016,inas017) = (g_inas_d[l_ac].inas006,g_inas_d[l_ac].inas005,
                   g_inas_d[l_ac].inas007,g_inas_d[l_ac].inas001,g_inas_d[l_ac].inas002,g_inas_d[l_ac].inas003,
                   g_inas_d[l_ac].inas004,g_inas_d[l_ac].inas012,g_inas_d[l_ac].inas011,g_inas_d[l_ac].inas013,
                   g_inas_d[l_ac].inas015,g_inas_d[l_ac].inas016,g_inas_d[l_ac].inas017)
                WHERE inasent = g_enterprise AND inassite = g_site 

                 AND inas001 = g_inas_d_t.inas001 #項次
                 AND inas002 = g_inas_d_t.inas002
                 AND inas003 = g_inas_d_t.inas003
                 AND inas004 = g_inas_d_t.inas004


               #add-point:單身修改中

               #end add-point

               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "inas_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   CALL cl_err("inas_t",SQLCA.sqlcode,1)
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL
               LET gs_keys[1] = g_inas_d[g_detail_idx].inas001
               LET gs_keys_bak[1] = g_inas_d_t.inas001
               LET gs_keys[2] = g_inas_d[g_detail_idx].inas002
               LET gs_keys_bak[2] = g_inas_d_t.inas002
               LET gs_keys[3] = g_inas_d[g_detail_idx].inas003
               LET gs_keys_bak[3] = g_inas_d_t.inas003
               LET gs_keys[4] = g_inas_d[g_detail_idx].inas004
               LET gs_keys_bak[4] = g_inas_d_t.inas004
               CALL aini110_update_b('inas_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改

               END CASE

               #add-point:單身修改後

               #end add-point
            END IF

         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF cl_null(g_inas_d[1].inas001) THEN
               CALL g_inas_d.deleteElement(1)
               NEXT FIELD inas001
            END IF
            #add-point:input段after input

            #end add-point

         ON ACTION controlo
            CALL FGL_SET_ARR_CURR(g_inas_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_inas_d.getLength()+1

      END INPUT

     
      #add-point:input段more_input

      #end add-point

      BEFORE DIALOG
         #add-point:input段before_dialog

         #end add-point
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD
        ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD seq
               WHEN "s_detail3"
                  NEXT FIELD type

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

   #add-point:input段after_input

   #end add-point

END FUNCTION

PRIVATE FUNCTION aini110_show()
   #add-point:show段define
DEFINE l_inag033_sum  LIKE inag_t.inag033
   #end add-point

   #add-point:show段之前

   #end add-point

#   IF g_bfill = "Y" THEN
#      CALL aini110_b_fill() #單身填充
#      CALL aini110_b_fill2() #單身填充
#   END IF



   #顯示followup圖示
   #+ 此段落由子樣板a48產生
   CALL aini110_set_pk_array()
   #add-point:ON ACTION agendum

   #END add-point
   CALL cl_user_overview_set_follow_pic()



   LET g_inas_m_t.* = g_inas_m.*      #保存單頭舊值
#   SELECT SUM(inag033) INTO g_inas_m.sum1 FROM inag_t WHERE inagent = g_enterprise AND inagsite = g_site 
#      AND inag001 = g_inas_m.inas009 AND inag002 = g_inas_m.inas010 AND inag010 != 'N'
#   SELECT SUM(inag033) INTO l_inag033_sum FROM inag_t WHERE inagent = g_enterprise AND inagsite = g_site 
#      AND inag001 = g_inas_m.inas009 AND inag002 = g_inas_m.inas010 
#   LET g_inas_m.sum1 = g_inas_m.sum1 + g_inas_m.sum2
   SELECT SUM(inas012) INTO g_inas_m.sum3 FROM inas_t WHERE inasent = g_enterprise
      AND inassite = g_site AND inas009 = g_inas_m.inas009 AND inas010 = g_inas_m.inas010
   SELECT imaa006 INTO g_inas_m.imaa006 FROM imaa_t WHERE imaaent = g_enterprise AND imaa001 = g_inas_m.inas009
   DISPLAY BY NAME g_inas_m.inas009,g_inas_m.imaal003,g_inas_m.imaal004,g_inas_m.inas010,g_inas_m.sum1,
       g_inas_m.sum2,g_inas_m.sum3,g_inas_m.imaa006
   CALL aini110_b_fill()                 #單身
   #單身填充

   CALL aini110_ref_show()

   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()

   #add-point:show段之後

   #end add-point

END FUNCTION

PRIVATE FUNCTION aini110_ref_show()
   DEFINE l_ac_t LIKE type_t.num10 #l_ac暫存用
   #add-point:ref_show段define

   #end add-point

   LET l_ac_t = l_ac

   #讀入ref值(單頭)
   #add-point:ref_show段m_reference

   #end add-point

   #讀入ref值(單身)
   FOR l_ac = 1 TO g_inas_d.getLength()
      #add-point:ref_show段d_reference

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_inas_d[l_ac].inas016
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_inas_d[l_ac].inas016_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_inas_d[l_ac].inas016_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_inas_d[l_ac].inas017
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_inas_d[l_ac].inas017_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_inas_d[l_ac].inas017_desc

      #end add-point
   END FOR

   FOR l_ac = 1 TO g_inas3_d.getLength()
      #add-point:ref_show段d2_reference

      #end add-point
   END FOR


   #add-point:ref_show段自訂

   #end add-point

   LET l_ac = l_ac_t

END FUNCTION

PRIVATE FUNCTION aini110_b_fill()
  
   #add-point:b_fill段define
DEFINE l_date1 LIKE type_t.dat
DEFINE l_date2 LIKE type_t.dat
DEFINE l_num   LIKE type_t.num5
DEFINE l_num2  LIKE type_t.num5
DEFINE l_num3  LIKE type_t.num5
DEFINE l_seq   LIKE type_t.num5
DEFINE l_date  LIKE type_t.dat
DEFINE l_sql   STRING
   #end add-point

   #先清空單身變數內容
   CALL aini110_b_fill2() 
   CALL g_inas_d.clear()
  #CALL g_inas2_d.clear()
#   CALL g_inas3_d.clear()


   #add-point:b_fill段sql_before

   #end add-point

      LET g_sql = "SELECT  UNIQUE '',to_char(inas006,'YYYY-MM-DD hh24:mi:ss') a,to_char(inas005,'YYYY-MM-DD hh24:mi:ss'),'',inas007,inas001,inas002,inas003,inas004,inas012,
          inas011,inas013,inas015,inas016,'',inas017,'' FROM inas_t",

                  "",

                  " WHERE inasent= ? AND inassite= ? AND inas009 = '",g_inas_m.inas009,"' AND inas010 = '",g_inas_m.inas010,"'"



   #add-point:b_fill段sql_after

   #end add-point

   #子單身的WC


   #判斷是否填充
   
   LET g_sql = g_sql, " ORDER BY a"
   
   #add-point:b_fill段fill_before
   
   #end add-point
   
   PREPARE aini110_pb FROM g_sql
   DECLARE b_fill_cs CURSOR FOR aini110_pb
   
   LET l_sql = "SELECT seq_temp,date_temp,num_temp FROM inas3_temp ORDER BY date_temp"
   PREPARE sel_temp FROM l_sql
   DECLARE cur_temp CURSOR FOR sel_temp 
   LET g_cnt = l_ac
   LET l_ac = 1
   
   OPEN b_fill_cs USING g_enterprise, g_site
   
   LET l_num2 = g_inas_m.sum1
   LET l_num = 0
   LET l_num3 = 0
   FOREACH b_fill_cs INTO g_inas_d[l_ac].seq,g_inas_d[l_ac].inas006,g_inas_d[l_ac].inas005,g_inas_d[l_ac].expect,
       g_inas_d[l_ac].inas007,g_inas_d[l_ac].inas001,g_inas_d[l_ac].inas002,g_inas_d[l_ac].inas003,
       g_inas_d[l_ac].inas004,g_inas_d[l_ac].inas012,g_inas_d[l_ac].inas011,g_inas_d[l_ac].inas013,
       g_inas_d[l_ac].inas015,g_inas_d[l_ac].inas016,g_inas_d[l_ac].inas016_desc,g_inas_d[l_ac].inas017,
       g_inas_d[l_ac].inas017_desc
   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
   
      #add-point:b_fill段資料填充
      LET g_inas_d[l_ac].seq = l_ac
      #end add-point
   
      #帶出公用欄位reference值
   
      
      IF g_inas_d[l_ac].inas011 <= l_num2  THEN
         LET g_inas_d[l_ac].expect = g_today
         LET l_num2 = l_num2 - g_inas_d[l_ac].inas011
      ELSE
         IF l_num2 > 0 then
            LET l_num3 = l_num2 
            LET l_num2 = 0            
         END IF
         FOREACH cur_temp INTO l_seq,l_date,l_num 
            
            LET l_num3 = l_num3 + l_num 
            IF g_inas_d[l_ac].inas011 <= l_num3  THEN
               LET g_inas_d[l_ac].expect = l_date
               LET l_num3 = l_num3 - g_inas_d[l_ac].inas011
               DELETE FROM inas3_temp WHERE seq_temp = l_seq
               EXIT FOREACH
            END IF
         END FOREACH
      END IF
      
   
      #add-point:單身資料抓取
   
      #end add-point
   
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
   
   END FOREACH
   
         CALL g_inas_d.deleteElement(g_inas_d.getLength())
   
   
   

   #add-point:b_fill段more

   #end add-point

   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt
   LET l_ac = g_cnt
   LET g_cnt = 0

   FREE aini110_pb

END FUNCTION

PRIVATE FUNCTION aini110_b_fill2()
   DEFINE pi_idx          LIKE type_t.num10   #161108-00012#1 num5==》num10
   DEFINE li_ac           LIKE type_t.num10  #161108-00012#1 num5==》num10
   #add-point:b_fill2段define
   DEFINE l_cnt           LIKE type_t.num5
   #end add-point

   LET li_ac = l_ac


   CALL g_inas2_d.clear()
   CALL g_inas3_d.clear()
   #add-point:單身填充後
   LET  g_sql = "SELECT inag004,inayl003,inag005,inab003,inag006,inag003,inag033,inag008,inag007 FROM inag_t",
                " LEFT JOIN inayl_t ON inaylent = inagent AND inayl001 = inag004 AND inayl002 = '",g_dlang,"'",
                " LEFT JOIN inab_t ON inabent = inagent AND inabsite = inagsite AND inab001 = inag004 AND inab002 = inag005",
                " WHERE inagent = ",g_enterprise," AND inagsite = '",g_site,"' AND inag001 = '",g_inas_m.inas009,"' AND inag002 = '",g_inas_m.inas010,"'",
                "   AND inag010 != 'N' "
   PREPARE aini110_pb2 FROM g_sql
   DECLARE b_fill_cs2 CURSOR FOR aini110_pb2
  
   LET l_cnt = 1
   LET g_inas_m.sum1 = 0
   FOREACH b_fill_cs2 INTO g_inas2_d[l_cnt].*
       IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      IF NOT cl_null(g_inas2_d[l_cnt].inag007) AND NOT cl_null(g_inas_m.imaa006) THEN
         CALl s_aooi250_convert_qty(g_inas_m.inas009,g_inas2_d[l_cnt].inag007,g_inas_m.imaa006,g_inas2_d[l_cnt].inag008)
                       RETURNING g_success,g_inas2_d[l_cnt].inag033
         LET g_inas_m.sum1 = g_inas_m.sum1 + g_inas2_d[l_cnt].inag033
      END IF   
      LET l_cnt = l_cnt + 1
      IF l_cnt > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   DISPLAY BY NAME g_inas_m.sum1
   
   CALL g_inas2_d.deleteElement(g_inas2_d.getLength())
   #end add-point

   DELETE FROM inas3_temp;
  #请购量
   LET l_ac = li_ac
   
   LET g_sql = "SELECT '1',to_char(pmdb030,'YYYY/MM/DD'),'',pmdb006,pmdb007,pmdbdocno,pmdbseq,1,1,pmda002,ooag011,pmda003,ooefl003 ",
               "  FROM pmdb_t,pmda_t LEFT OUTER JOIN ooag_t ON ooagent = pmdaent AND ooag001 = pmda002",
               "                     LEFT OUTER JOIN ooefl_t ON ooeflent = pmdaent AND ooefl001 = pmda003 AND ooefl002 = '",g_dlang,"'",
               " WHERE pmdaent = ",g_enterprise," AND pmdaent = pmdbent AND pmdadocno = pmdbdocno ",
               "   AND pmdastus = 'Y' AND pmdb004 = '",g_inas_m.inas009,"' AND pmdb005 = '",g_inas_m.inas010,"' AND (pmdb006-pmdb049) > 0"
   PREPARE aini110_pb3 FROM g_sql
   DECLARE b_fill_cs3 CURSOR FOR aini110_pb3
  
   LET l_cnt = 1
   FOREACH b_fill_cs3 INTO g_inas3_d[l_cnt].*  
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      CALL s_aooi250_convert_qty(g_inas_m.inas009,g_inas3_d[l_cnt].unit,g_inas_m.imaa006,g_inas3_d[l_cnt].num2) 
         RETURNING g_success,g_inas3_d[l_cnt].num1
      INSERT INTO inas3_temp VALUES(l_cnt,g_inas3_d[l_cnt].date,g_inas3_d[l_cnt].num2,g_inas3_d[l_cnt].num1)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "INSERT "
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      LET l_cnt = l_cnt + 1
      IF l_cnt > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH

   #采购量
   LET g_sql = "SELECT '2',to_char(pmdo011,'YYYY/MM/DD'),'',pmdo006,pmdo004,pmdodocno,pmdoseq,pmdoseq1,pmdoseq2,pmdl002,ooag011,pmdl003,ooefl003 ",
               "  FROM pmdo_t,pmdl_t LEFT OUTER JOIN ooag_t ON ooagent = pmdlent AND ooag001 = pmdl002",
               "                     LEFT OUTER JOIN ooefl_t ON ooeflent = pmdlent AND ooefl001 = pmdl003 AND ooefl002 = '",g_dlang,"'",
               " WHERE pmdlent = ",g_enterprise," AND pmdlent = pmdoent AND pmdldocno = pmdodocno ",
               "   AND pmdlstus = 'Y' AND pmdo001 = '",g_inas_m.inas009,"' AND pmdo002 = '",g_inas_m.inas010,"' AND (pmdo006 - pmdo015) > 0"
   PREPARE aini110_pb4 FROM g_sql
   DECLARE b_fill_cs4 CURSOR FOR aini110_pb4
  
   FOREACH b_fill_cs4 INTO g_inas3_d[l_cnt].*  
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      CALL s_aooi250_convert_qty(g_inas_m.inas009,g_inas3_d[l_cnt].unit,g_inas_m.imaa006,g_inas3_d[l_cnt].num2) 
         RETURNING g_success,g_inas3_d[l_cnt].num1
      INSERT INTO inas3_temp VALUES(l_cnt,g_inas3_d[l_cnt].date,g_inas3_d[l_cnt].num2,g_inas3_d[l_cnt].num1)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "INSERT "
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      LET l_cnt = l_cnt + 1
      IF l_cnt > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   
   #在验量
   LET g_sql = "SELECT '3',to_char(pmdt089,'YYYY/MM/DD'),'',pmdt053,pmdt019,pmdtdocno,pmdtseq,1,1,pmds002,ooag011,pmds003,ooefl003 ",
               "  FROM pmdt_t,pmds_t LEFT OUTER JOIN ooag_t ON ooagent = pmdsent AND ooag001 = pmds002",
               "                     LEFT OUTER JOIN ooefl_t ON ooeflent = pmdsent AND ooefl001 = pmds003 AND ooefl002 = '",g_dlang,"'",
               " WHERE pmdsent = ",g_enterprise," AND pmdsent = pmdtent AND pmdsdocno = pmdtdocno ",
               "   AND pmdsstus = 'Y' AND pmdt006 = '",g_inas_m.inas009,"' AND pmdt007 = '",g_inas_m.inas010,"' AND pmds000 IN ('1','2','8','9')",
               "   AND (pmdt053 - pmdt054) > 0"
   PREPARE aini110_pb5 FROM g_sql
   DECLARE b_fill_cs5 CURSOR FOR aini110_pb5
  
   FOREACH b_fill_cs5 INTO g_inas3_d[l_cnt].*  
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      CALL s_aooi250_convert_qty(g_inas_m.inas009,g_inas3_d[l_cnt].unit,g_inas_m.imaa006,g_inas3_d[l_cnt].num2) 
         RETURNING g_success,g_inas3_d[l_cnt].num1
      INSERT INTO inas3_temp VALUES(l_cnt,g_inas3_d[l_cnt].date,g_inas3_d[l_cnt].num2,g_inas3_d[l_cnt].num1)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "INSERT "
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      LET l_cnt = l_cnt + 1
      IF l_cnt > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   
   #在制量
   LET g_sql = "SELECT '4',to_char(sfaa019,'YYYY/MM/DD'),'',sfac003,sfac004,sfacdocno,sfacseq,1,1,sfaa002,ooag011,'','' ",
               "  FROM sfac_t,sfaa_t LEFT OUTER JOIN ooag_t ON ooagent = sfaaent AND ooag001 = sfaa002",
               " WHERE sfaaent = ",g_enterprise," AND sfaaent = sfacent AND sfaadocno = sfacdocno ",
               "   AND sfaastus = 'Y' AND sfac001 = '",g_inas_m.inas009,"' AND sfac006 = '",g_inas_m.inas010,"'",
               "   AND (sfac005 - sfac003) > 0"
   PREPARE aini110_pb6 FROM g_sql
   DECLARE b_fill_cs6 CURSOR FOR aini110_pb6
  
   FOREACH b_fill_cs6 INTO g_inas3_d[l_cnt].*  
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      CALL s_aooi250_convert_qty(g_inas_m.inas009,g_inas3_d[l_cnt].unit,g_inas_m.imaa006,g_inas3_d[l_cnt].num2) 
         RETURNING g_success,g_inas3_d[l_cnt].num1
      INSERT INTO inas3_temp VALUES(l_cnt,g_inas3_d[l_cnt].date,g_inas3_d[l_cnt].num2,g_inas3_d[l_cnt].num1)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "INSERT "
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      LET l_cnt = l_cnt + 1
      IF l_cnt > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_inas3_d.deleteElement(g_inas3_d.getLength())
   SELECT SUM(num2_temp) INTO g_inas_m.sum2 FROM inas3_temp
   DISPLAY BY NAME g_inas_m.sum2
   
   
END FUNCTION

PRIVATE FUNCTION aini110_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   DEFINE ps_table         STRING
   DEFINE ps_page          STRING
   DEFINE ps_keys          DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group         STRING
   DEFINE li_idx           LIKE type_t.num10  #161108-00012#1 num5==》num10
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   #add-point:update_b段define

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

PRIVATE FUNCTION aini110_set_pk_array()
   #add-point:set_pk_array段define

   #end add-point

   #add-point:set_pk_array段之前

   #end add-point

   CALL g_pk_array.clear()
   LET g_pk_array[1].values = ''
   LET g_pk_array[1].column = ''


   #add-point:set_pk_array段之後

   #end add-point

END FUNCTION

PRIVATE FUNCTION aini110_drop()
   DROP TABLE inas3_temp;
END FUNCTION

#end add-point
 
{</section>}
 
