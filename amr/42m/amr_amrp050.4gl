#該程式未解開Section, 採用最新樣板產出!
{<section id="amrp050.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0008(2014-10-28 13:38:59), PR版次:0008(2016-09-08 13:41:42)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000101
#+ Filename...: amrp050
#+ Description: 資源行事曆產生作業
#+ Creator....: 04441(2014-07-21 13:39:25)
#+ Modifier...: 04441 -SD/PR- 00593
 
{</section>}
 
{<section id="amrp050.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#160318-00005#25  2016/03/30  by 07675   將重複內容的錯誤訊息置換為公用錯誤訊息
#160826-00015#1   2016/09/08  By Sarah   畫面勾選"產生後進行資源行事曆維護"後要串amri050
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
   
   #end add-point
        wc               STRING
                     END RECORD
 
TYPE type_g_detail_d RECORD
#add-point:自定義模組變數(Module Variable)  #注意要在add-point內寫入END RECORD name="global.variable"
       sel               LIKE type_t.chr1,      #選擇
       mrba021           LIKE mrba_t.mrba021,   #作業編號
       mrba021_desc      LIKE type_t.chr80,     #說明
       mrba022           LIKE mrba_t.mrba022,   #工作站
       mrba022_desc      LIKE type_t.chr80,     #說明
       mrba010           LIKE mrba_t.mrba010,   #資源分類
       mrba010_desc      LIKE type_t.chr80,     #說明
       mrba001           LIKE mrba_t.mrba001,   #資源編號
       mrba004           LIKE mrba_t.mrba004,   #APS虛擬單號
       mrba103           LIKE mrba_t.mrba103    #嫁動班別
                     END RECORD

DEFINE tm            RECORD
       date1             LIKE type_t.dat,       #行事曆日期區間
       date2             LIKE type_t.dat,       #行事曆日期區間
       chk1              LIKE type_t.chr1,      #已存在資料是否重新產生
       chk2              LIKE type_t.chr1       #產生後進入資源行事曆維護
                     END RECORD

DEFINE g_rec_b       LIKE type_t.num5


#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="amrp050.main" >}
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
   CALL cl_ap_init("amr","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   LET g_forupd_sql = " SELECT mrbhent,mrbhsite,mrbh001,mrbh002,mrbh003, ",
                      "        mrbh004,mrbh005,mrbh006,mrbh007,mrbh008, ",
                      "        mrbhownid,mrbhowndp,mrbhcrtid,mrbhcrtdp,mrbhcrtdt, ",
                      "        mrbhmodid,mrbhmoddt,mrbhcnfid,mrbhcnfdt,mrbhstus ",
                      "   FROM mrbh_t",
                      "  WHERE mrbhent= ? AND mrbhsite=? FOR UPDATE "
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)              #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)            #遮蔽特定資料
   DECLARE amrp050_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_amrp050 WITH FORM cl_ap_formpath("amr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL amrp050_init()   
 
      #進入選單 Menu (="N")
      CALL amrp050_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_amrp050
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   DROP TABLE amrp050_tmp;
   CALL s_ins_able_time_drop_tmp()
   CALL s_amri007_drop_temp_table()
   CLOSE amrp050_cl
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="amrp050.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION amrp050_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   IF cl_null(g_bgjob) THEN
      LET g_bgjob = 'N'
   END IF
   
   LET tm.date1  = g_today
   LET tm.date2  = g_today
   LET tm.chk1  = 'Y'
   LET tm.chk2  = 'Y'

   DROP TABLE amrp050_tmp;
   CREATE TEMP TABLE amrp050_tmp( 
       mraa091         VARCHAR(1),
       mraa092         VARCHAR(8)
       );
   CALL s_ins_able_time_create_tmp()
   CALL s_amri007_crt_temp_table()
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="amrp050.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION amrp050_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_cnt    LIKE type_t.num5
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   LET g_wc = "1=1"
   
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL amrp050_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT BY NAME g_wc ON mrba021,mrba022,mrba010,mrba001

            BEFORE CONSTRUCT
            
            ON ACTION controlp INFIELD mrba021
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '221'
               CALL q_oocq002()
               DISPLAY g_qryparam.return1 TO mrba021
               NEXT FIELD mrba021
               
            ON ACTION controlp INFIELD mrba022
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ecaa001()
               DISPLAY g_qryparam.return1 TO mrba022
               NEXT FIELD mrba022
   
            ON ACTION controlp INFIELD mrba010
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '1101'
               CALL q_oocq002()
               DISPLAY g_qryparam.return1 TO mrba010
               NEXT FIELD mrba010
   
            ON ACTION controlp INFIELD mrba001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_mrba001_1()
               DISPLAY g_qryparam.return1 TO mrba001
               NEXT FIELD mrba001
               
         END CONSTRUCT
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT BY NAME tm.date1,tm.date2,tm.chk1,tm.chk2
            ATTRIBUTE(WITHOUT DEFAULTS)
         
            BEFORE INPUT

            AFTER INPUT

         END INPUT
         
         INPUT ARRAY g_detail_d FROM s_detail1.* 
              ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                        INSERT ROW = FALSE,
                        DELETE ROW = FALSE,
                        APPEND ROW = FALSE)
            BEFORE INPUT
               IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
                 CALL FGL_SET_ARR_CURR(g_detail_d.getLength()+1) 
                 LET g_insert = 'N' 
               END IF 
             
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_master_idx = l_ac
               DISPLAY l_ac TO FORMONLY.h_index
               
            ON CHANGE b_sel
                  
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
            CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
            CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
            #end add-point
 
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            #add-point:ui_dialog段on action selall name="ui_dialog.selall.befroe"
            
            #end add-point            
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
               #add-point:ui_dialog段on action selall name="ui_dialog.for.onaction_selall"
               
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
            CALL amrp050_filter()
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
            CALL amrp050_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL amrp050_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            LET l_cnt = 0
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF g_detail_d[li_idx].sel = 'Y' THEN
                  LET l_cnt = l_cnt + 1
               END IF
            END FOR
            IF l_cnt = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = '-400'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
            ELSE
               CALL amrp050_process()
            END IF
            ACCEPT DIALOG
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
 
{<section id="amrp050.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION amrp050_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   LET g_wc_filter = " 1=1"
   #end add-point
        
   LET g_error_show = 1
   CALL amrp050_b_fill()
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
 
{<section id="amrp050.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION amrp050_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
 
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   #取出符合條件且資源狀態為已確認之資源編號
   LET g_sql = "SELECT DISTINCT 'N',mrba021,a.oocql004,mrba022,ecaa002,mrba010,b.oocql004,mrba001,mrba004,mrba103 ",
               "  FROM mrba_t ",
               "       LEFT OUTER JOIN oocql_t a ON a.oocqlent = '",g_enterprise,"' AND a.oocql001 = '221' AND a.oocql002 = mrba021 AND a.oocql003 = '",g_dlang,"' ",
               "       LEFT OUTER JOIN ecaa_t ON ecaaent = '",g_enterprise,"' AND ecaasite = mrbasite AND ecaa001 = mrba022 ",
               "       LEFT OUTER JOIN oocql_t b ON b.oocqlent = '",g_enterprise,"' AND b.oocql001 = '1101' AND b.oocql002 = mrba010 AND b.oocql003 = '",g_dlang,"' ",
               " WHERE mrbaent = ? AND mrbasite = '",g_site,"' AND mrbastus = 'Y' AND ",g_wc_filter," AND ",g_wc,
               " ORDER BY mrba021,mrba022,mrba010,mrba001 "

   CALL cl_err_collect_init()
   LET g_coll_title[1] = cl_getmsg('amr-00080',g_lang)

   #end add-point
 
   PREPARE amrp050_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR amrp050_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   LET g_master_idx = 1
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
       g_detail_d[l_ac].sel,g_detail_d[l_ac].mrba021,g_detail_d[l_ac].mrba021_desc,
       g_detail_d[l_ac].mrba022,g_detail_d[l_ac].mrba022_desc,g_detail_d[l_ac].mrba010,
       g_detail_d[l_ac].mrba010_desc,g_detail_d[l_ac].mrba001,g_detail_d[l_ac].mrba004,g_detail_d[l_ac].mrba103
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
      IF cl_null(g_detail_d[l_ac].mrba022) THEN
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code = 'amr-00083'
         LET g_errparam.coll_vals[1] = g_detail_d[l_ac].mrba001
         CALL cl_err()
         CONTINUE FOREACH
      END IF
      IF cl_null(g_detail_d[l_ac].mrba103) THEN
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code = 'amr-00084'
         LET g_errparam.coll_vals[1] = g_detail_d[l_ac].mrba001
         CALL cl_err()
         CONTINUE FOREACH
      END IF
      
      #end add-point
      
      CALL amrp050_detail_show()      
 
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
   
   CALL cl_err_collect_show()

   CALL g_detail_d.deleteElement(g_detail_d.getLength())
   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE amrp050_sel
   
   LET l_ac = 1
   CALL amrp050_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="amrp050.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION amrp050_fetch()
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
 
{<section id="amrp050.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION amrp050_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="amrp050.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION amrp050_filter()
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
   
   CLEAR FORM 
   CALL g_detail_d.clear()
   
   CONSTRUCT g_wc_filter ON mrba021,mrba022,mrba010,mrba001
        FROM s_detail1[1].b_mrba021,s_detail1[1].b_mrba022,s_detail1[1].b_mrba010,s_detail1[1].b_mrba001
           
      BEFORE CONSTRUCT
      
      ON ACTION controlp INFIELD mrba021
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         LET g_qryparam.arg1 = '221'
         CALL q_oocq002()
         DISPLAY g_qryparam.return1 TO mrba021
         NEXT FIELD mrba021
         
      ON ACTION controlp INFIELD mrba022
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_ecaa001()
         DISPLAY g_qryparam.return1 TO mrba022
         NEXT FIELD mrba022
   
      ON ACTION controlp INFIELD mrba010
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         LET g_qryparam.arg1 = '1101'
         CALL q_oocq002()
         DISPLAY g_qryparam.return1 TO mrba010
         NEXT FIELD mrba010
   
      ON ACTION controlp INFIELD mrba001
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_mrba001_1()
         DISPLAY g_qryparam.return1 TO mrba001
         NEXT FIELD mrba001
               
   END CONSTRUCT
   #end add-point    
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   
   CALL amrp050_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="amrp050.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION amrp050_filter_parser(ps_field)
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
 
{<section id="amrp050.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION amrp050_filter_show(ps_field,ps_object)
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
   LET ls_condition = amrp050_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="amrp050.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 依照資源主檔設定的保養校正週期,並配合保養週期的時間設定,產生指定期間內各資源的行事曆
# Memo...........:
# Usage..........: CALL amrp050_process()
# Input parameter: no
# Return code....: no
# Date & Author..: 140725 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION amrp050_process()
DEFINE l_sql          STRING
DEFINE l_success      LIKE type_t.num5
DEFINE l_tot_success  LIKE type_t.num5
DEFINE l_count        LIKE type_t.num5
DEFINE l_cnt          LIKE type_t.num5
DEFINE l_oogd003      LIKE oogd_t.oogd003
DEFINE l_oogd004      LIKE oogd_t.oogd004
DEFINE l_date         LIKE type_t.dat
DEFINE l_errno        STRING
DEFINE l_mrbb         RECORD
    mrbb002      LIKE mrbb_t.mrbb002,     #項次
    mrbb003      LIKE mrbb_t.mrbb003,     #保修類型
    mrbb004      LIKE mrbb_t.mrbb004,     #保修週期
    mrbb009      LIKE mrbb_t.mrbb009,     #預計時間
    mrbb010      LIKE mrbb_t.mrbb010,     #時間單位
    mrbb013      LIKE mrbb_t.mrbb013      #停機保養
                      END RECORD
DEFINE l_mrbh003      LIKE mrbh_t.mrbh003
DEFINE l_mrbh005      LIKE mrbh_t.mrbh005
#160826-00015#1-s add
DEFINE l_mrbh006      STRING
DEFINE l_where        STRING
DEFINE la_param       RECORD
    prog         STRING,
    param        DYNAMIC ARRAY OF STRING
                      END RECORD
DEFINE ls_js          STRING
#160826-00015#1-e add

   CALL s_transaction_begin()
   
   OPEN amrp050_cl USING g_enterprise,g_site
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN amrp050_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CLOSE amrp050_cl
      RETURN
   END IF
   
   LET l_success = TRUE
   LET l_tot_success = TRUE
   LET l_count = 0
   CALL cl_err_collect_init()
   LET g_coll_title[1] = cl_getmsg('amr-00080',g_lang)
   LET g_coll_title[2] = cl_getmsg('anm-00225',g_lang)#160318-00005#25 mod#cl_getmsg('axm-00008',g_lang)
   LET l_mrbh006 = ""  #160826-00015#1 add
   
   #資源保養校正週期設定檔
   LET l_sql = " SELECT DISTINCT mrbb002,mrbb003,mrbb004,mrbb009,mrbb010,mrbb013 ",
               "   FROM mrbb_t ",
               "  WHERE mrbbent  = ",g_enterprise,
               "    AND mrbbsite = '",g_site,"' ",
               "    AND mrbb001  = ? "
   PREPARE amrp050_process_pre1 FROM l_sql
   DECLARE amrp050_process_cur1 CURSOR WITH HOLD FOR amrp050_process_pre1
   
   #資源保養校正週期設定檔
   LET l_sql = " SELECT mraa092 FROM amrp050_tmp WHERE mraa091 = 'Y' "
   PREPARE amrp050_process_pre2 FROM l_sql
   DECLARE amrp050_process_cur2 CURSOR WITH HOLD FOR amrp050_process_pre2
   
   FOR l_ac = 1 TO g_detail_d.getLength()
      IF g_detail_d[l_ac].sel = 'Y' THEN
      
         #此資源編號沒有設定稼動班別！
         IF cl_null(g_detail_d[l_ac].mrba103) THEN
            INITIALIZE g_errparam.* TO NULL
            LET g_errparam.code = 'amr-00084'
            LET g_errparam.extend = 'mrba103'
            LET g_errparam.coll_vals[1] = g_detail_d[l_ac].mrba001
            CALL cl_err()
            CONTINUE FOR
         END IF
         
         LET l_cnt = 0
         SELECT COUNT(*) INTO l_cnt
           FROM mrbb_t
          WHERE mrbbent = g_enterprise 
            AND mrbbsite = g_site
            AND mrbb001 = g_detail_d[l_ac].mrba001
         #該資源編號沒有維護對應的資源保養校正週期設定檔！
         IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
         IF l_cnt > 0 THEN
         
            #上班時間、下班時間
            LET l_oogd003 = ''
            LET l_oogd004 = ''
            SELECT oogd003,oogd004 INTO l_oogd003,l_oogd004
              FROM oogd_t
             WHERE oogdent = g_enterprise
               AND oogdsite = g_site
               AND oogd001 = g_detail_d[l_ac].mrba103
            
            INITIALIZE l_mrbb.* TO NULL
            OPEN amrp050_process_cur1 USING g_detail_d[l_ac].mrba001
            FOREACH amrp050_process_cur1 INTO l_mrbb.mrbb002,l_mrbb.mrbb003,l_mrbb.mrbb004,
                                              l_mrbb.mrbb009,l_mrbb.mrbb010,l_mrbb.mrbb013
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam.* TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = 'sel mrbb_t'
                  LET g_errparam.coll_vals[1] = g_detail_d[l_ac].mrba001
                  CALL cl_err()
                  LET l_success = FALSE
                  EXIT FOREACH
               END IF
               
               IF NOT l_success THEN
                  LET l_tot_success = FALSE
                  LET l_success = TRUE
               END IF
               
               #150609 by whitney add start
               #非停機保養=正常運作
               IF l_mrbb.mrbb013 = 'N' THEN
                  LET l_mrbh005 = 'Y'
               ELSE
                  LET l_mrbh005 = 'N'
               END IF
               #150609 by whitney add end
               
               #傳入的保修週期編號不可為空!
               IF cl_null(l_mrbb.mrbb004) THEN
                  INITIALIZE g_errparam.* TO NULL
                  LET g_errparam.code = 'sub-00375'
                  LET g_errparam.extend = 'mrbb004'
                  LET g_errparam.coll_vals[1] = g_detail_d[l_ac].mrba001
                  LET g_errparam.coll_vals[2] = l_mrbb.mrbb002
                  CALL cl_err()
                  LET l_success = FALSE
                  CONTINUE FOREACH
               END IF
               
               #若下班時間為空值,則提示錯誤訊息
               IF cl_null(l_mrbb.mrbb009) OR cl_null(l_mrbb.mrbb010) THEN
                  IF cl_null(l_oogd004) THEN
                     INITIALIZE g_errparam.* TO NULL
                     LET g_errparam.code = 'amr-00079'
                     LET g_errparam.extend = g_detail_d[l_ac].mrba103
                     LET g_errparam.coll_vals[1] = g_detail_d[l_ac].mrba001
                     LET g_errparam.coll_vals[2] = l_mrbb.mrbb002
                     CALL cl_err()
                     LET l_success = FALSE
                     CONTINUE FOREACH
                  END IF
               END IF
               
               #資源編號+保養項目有已存在行事曆區間起迄之資源行事曆資料
               LET l_cnt = 0
               SELECT COUNT(*) INTO l_cnt
                 FROM mrbh_t
                WHERE mrbhent = g_enterprise
                  AND mrbhsite = g_site
                  AND mrbh001 = g_detail_d[l_ac].mrba001
                  AND mrbh002 BETWEEN tm.date1 AND tm.date2
                  AND mrbh007 = l_mrbb.mrbb003
               IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
               IF l_cnt <> 0 THEN 
                  IF tm.chk1 = 'N' THEN
                     #不重新產生,則此筆不執行
                     CONTINUE FOREACH
                  ELSE
                     #已存在資料重新產生,先將資源刪除
                     DELETE FROM mrbh_t
                      WHERE mrbhent = g_enterprise
                        AND mrbhsite = g_site
                        AND mrbh001 = g_detail_d[l_ac].mrba001
                        AND mrbh002 BETWEEN tm.date1 AND tm.date2
                        AND mrbh007 = l_mrbb.mrbb003
                     IF l_oogd003 > l_oogd004 THEN  #大夜班
                        CALL s_date_get_date(tm.date2,'0','1') RETURNING l_date
                        DELETE FROM mrbh_t
                         WHERE mrbhent = g_enterprise
                           AND mrbhsite = g_site
                           AND mrbh001 = g_detail_d[l_ac].mrba001
                           AND mrbh002 = l_date
                           AND mrbh004 <= l_oogd004
                           AND mrbh007 = l_mrbb.mrbb003
                     END IF
                  END IF
               END IF
               
               #amri070"時段"之欄位值,若有多個時段,則須新增多筆mrbe_t
               DELETE FROM amrp050_tmp
               INSERT INTO amrp050_tmp SELECT mraa091,mraa092 FROM mraa_t WHERE mraaent = g_enterprise AND mraa001 = l_mrbb.mrbb004
               INSERT INTO amrp050_tmp SELECT mraa093,mraa094 FROM mraa_t WHERE mraaent = g_enterprise AND mraa001 = l_mrbb.mrbb004
               INSERT INTO amrp050_tmp SELECT mraa095,mraa096 FROM mraa_t WHERE mraaent = g_enterprise AND mraa001 = l_mrbb.mrbb004
               INSERT INTO amrp050_tmp SELECT mraa097,mraa098 FROM mraa_t WHERE mraaent = g_enterprise AND mraa001 = l_mrbb.mrbb004
               INSERT INTO amrp050_tmp SELECT mraa099,mraa100 FROM mraa_t WHERE mraaent = g_enterprise AND mraa001 = l_mrbb.mrbb004
               INSERT INTO amrp050_tmp SELECT mraa101,mraa102 FROM mraa_t WHERE mraaent = g_enterprise AND mraa001 = l_mrbb.mrbb004
               
               CALL s_date_get_date(tm.date1,0,'-1') RETURNING l_date
               WHILE l_date <= tm.date2
                  #從行事曆基準日開始,依amri007之週期設定,計算在行事曆日期區間,該保修項目之保修日期
                  CALL s_amri007_get_next_date(g_site,l_mrbb.mrbb004,l_date)
                       RETURNING l_success,l_errno,l_date
                  IF NOT l_success THEN
#                     INITIALIZE g_errparam.* TO NULL
#                     LET g_errparam.code = l_errno
#                     LET g_errparam.extend = l_mrbb.mrbb004
#                     LET g_errparam.coll_vals[1] = g_detail_d[l_ac].mrba001
#                     LET g_errparam.coll_vals[2] = l_mrbb.mrbb002
#                     CALL cl_err()
                     EXIT WHILE
                  END IF
                  
                  IF l_date > tm.date2 THEN
                     EXIT WHILE
                  END IF
                  
#160826-00015#1-s add
                  IF tm.chk2 = 'Y' THEN
                     IF cl_null(l_mrbh006) THEN
                        LET l_mrbh006 = "'",g_detail_d[l_ac].mrba022,"'"
                     ELSE
                        LET l_mrbh006 = l_mrbh006 ,",'",g_detail_d[l_ac].mrba022,"'"
                     END IF
                  END IF
#160826-00015#1-e add

                  LET l_cnt = 0
                  SELECT COUNT(*) INTO l_cnt FROM amrp050_tmp WHERE mraa091 = 'Y'
                  #若amri070 "時段"之欄位值均為空值,則依amrm200稼動班別取出aooi426上班時間
                  IF cl_null(l_cnt) OR l_cnt = 0 THEN
                     #若上班時間為空值,則提示錯誤訊息
                     IF cl_null(l_oogd003) THEN
                        INITIALIZE g_errparam.* TO NULL
                        LET g_errparam.code = 'amr-00078'
                        LET g_errparam.extend = g_detail_d[l_ac].mrba103
                        LET g_errparam.coll_vals[1] = g_detail_d[l_ac].mrba001
                        LET g_errparam.coll_vals[2] = l_mrbb.mrbb002
                        CALL cl_err()
                        LET l_success = FALSE
                        EXIT WHILE
                     END IF
                     
                     IF NOT cl_null(l_mrbb.mrbb009) AND NOT cl_null(l_mrbb.mrbb010) THEN
                        CALL amrp050_time_count(l_oogd003,l_mrbb.mrbb009,l_mrbb.mrbb010)
                             RETURNING l_oogd004
                     END IF
                     
                     IF NOT s_ins_able_time_ins_mrbh(g_detail_d[l_ac].mrba001,l_date,l_oogd003,l_oogd004,l_mrbh005,g_detail_d[l_ac].mrba022,l_mrbb.mrbb003,'') THEN
                        INITIALIZE g_errparam.* TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = 'ins mrbh_t'
                        LET g_errparam.coll_vals[1] = g_detail_d[l_ac].mrba001
                        LET g_errparam.coll_vals[2] = l_mrbb.mrbb002
                        CALL cl_err()
                        LET l_success = FALSE
                        EXIT WHILE
                     ELSE
                        LET l_count = l_count + 1
                     END IF
                  ELSE
                     LET l_mrbh003 = ''
                     FOREACH amrp050_process_cur2 INTO l_mrbh003
                     
                        IF NOT cl_null(l_mrbb.mrbb009) AND NOT cl_null(l_mrbb.mrbb010) THEN
                           CALL amrp050_time_count(l_mrbh003,l_mrbb.mrbb009,l_mrbb.mrbb010)
                                RETURNING l_oogd004
                        END IF
                        
                        IF NOT s_ins_able_time_ins_mrbh(g_detail_d[l_ac].mrba001,l_date,l_mrbh003,l_oogd004,l_mrbh005,g_detail_d[l_ac].mrba022,l_mrbb.mrbb003,'') THEN
                           INITIALIZE g_errparam.* TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = 'ins mrbh_t'
                           LET g_errparam.coll_vals[1] = g_detail_d[l_ac].mrba001
                           LET g_errparam.coll_vals[2] = l_mrbb.mrbb002
                           CALL cl_err()
                           LET l_success = FALSE
                           EXIT FOREACH
                        ELSE
                           LET l_count = l_count + 1
                        END IF
                        LET l_mrbh003 = ''
                     END FOREACH
                  END IF
               END WHILE
            
               INITIALIZE l_mrbb.* TO NULL
            END FOREACH
         ELSE
#            INITIALIZE g_errparam.* TO NULL
#            LET g_errparam.code = 'amr-00085'
#            LET g_errparam.coll_vals[1] = g_detail_d[l_ac].mrba001
#            CALL cl_err()
         END IF
         #呼叫s_ins_able_time(計算資源可用時間元件)將正常運作日期時間新增至資源行事曆檔
         LET l_date = tm.date1
         WHILE l_date <= tm.date2
            CALL s_ins_able_time(g_detail_d[l_ac].mrba001,l_date,g_detail_d[l_ac].mrba103) RETURNING l_success
            IF NOT l_success THEN EXIT WHILE END IF
            LET l_count = l_count + 1
            CALL s_date_get_date(l_date,0,1) RETURNING l_date
         END WHILE
      END IF
   END FOR
   
   CALL cl_err_collect_show()
   
   IF l_tot_success THEN
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
   
   IF l_count = 0 THEN
      #無符合條件的資料產生！
      INITIALIZE g_errparam.* TO NULL
      LET g_errparam.code = 'agl-00167'
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
#160826-00015#1-s add
   ELSE
      #畫面勾選"產生後進行資源行事曆維護"後要串amri050
      IF tm.chk2 = 'Y' THEN
         IF cl_null(l_mrbh006) THEN
            LET l_where = " mrbh002 BETWEEN '",tm.date1,"' AND '",tm.date2,"'"
         ELSE
            LET l_where = " mrbh002 BETWEEN '",tm.date1,"' AND '",tm.date2,"' AND mrbh006 IN (",l_mrbh006,")"
         END IF
         INITIALIZE la_param.* TO NULL
         LET la_param.prog = 'amri050'
         LET la_param.param[4] = l_where
         LET ls_js = util.JSON.stringify(la_param )
         CALL cl_cmdrun(ls_js)
      END IF
#160826-00015#1-e add
   END IF
   
   IF g_bgjob = 'N' THEN
      CALL cl_ask_pressanykey("std-00012")
   END IF
   
   CLOSE amrp050_cl

END FUNCTION

################################################################################
# Descriptions...: 依amrm200 保養校正週期頁籤[C:預計時間](mrbb009)設定,將開始時間+預計時間作為結束時間
#                  (預計時間須配合[C:時間單位]作轉換)
# Memo...........:
# Usage..........: CALL amrp050_time_count(p_time,p_mrbb009,p_mrbb010)
#                  RETURNING r_time
# Input parameter: 
# Return code....: 
# Date & Author..: 140725 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION amrp050_time_count(p_time,p_mrbb009,p_mrbb010)
DEFINE p_time       LIKE oogd_t.oogd004
DEFINE p_mrbb009    LIKE mrbb_t.mrbb009
DEFINE p_mrbb010    LIKE mrbb_t.mrbb010
DEFINE r_time       LIKE oogd_t.oogd004
DEFINE l_hour       LIKE type_t.num5
DEFINE l_min        LIKE type_t.num5
DEFINE l_sec        LIKE type_t.num5
DEFINE l_cnt        LIKE type_t.num5
DEFINE l_time       STRING
DEFINE ps_hour      STRING
DEFINE ps_min       STRING
DEFINE ps_sec       STRING

   LET l_time = p_time
   LET l_hour = l_time.subString(1,l_time.getIndexOf(":",1)-1)
   LET l_min  = l_time.subString(l_time.getIndexOf(":",1)+1,l_time.getIndexOf(":",1)+2)
   
   CALL s_chr_get_index_of(l_time,':',4) RETURNING l_cnt
   IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
   IF l_cnt > 1 THEN
      LET l_sec  = l_time.subString(l_time.getIndexOf(":",2)+1,l_time.getIndexOf(":",2)+2)
   ELSE
      LET l_sec = 0
   END IF
   IF cl_null(l_hour) THEN LET l_hour = 0 END IF
   IF cl_null(l_min) THEN LET l_min = 0 END IF
   IF cl_null(l_sec) THEN LET l_sec = 0 END IF
   
   CASE p_mrbb010
      WHEN '1'  #秒
         LET l_sec = l_sec + p_mrbb009
      WHEN '2'  #分
         LET l_min = l_min + p_mrbb009
      WHEN '3'  #時
         LET l_hour = l_hour + p_mrbb009
      WHEN '4'  #天
         LET l_hour = 24
         LET l_min = 0
         LET l_sec = 0
      OTHERWISE EXIT CASE
   END CASE
   
   IF l_sec >= 60 THEN
      LET l_min = l_min + s_num_round('3',l_sec/60,0)
      LET l_sec = l_sec MOD 60
   END IF
   IF l_min >= 60 THEN
      LET l_hour = l_hour + s_num_round('3',l_min/60,0)
      LET l_min = l_min MOD 60
   END IF
   IF l_hour > 24 THEN
      LET l_hour = l_hour - 24
   END IF
   
   LET r_time = ''
   LET ps_hour = l_hour
   LET ps_min = l_min
   LET ps_sec = l_sec
   LET ps_hour = ps_hour.trim()
   IF l_hour < 10 THEN
      LET r_time = '0',ps_hour
   ELSE
      LET r_time = ps_hour
   END IF
   
   LET ps_min = ps_min.trim()
   IF l_min < 10 THEN
      LET r_time = r_time CLIPPED,':','0',ps_min
   ELSE
      LET r_time = r_time CLIPPED,':',ps_min
   END IF
   
   LET ps_sec = ps_sec.trim()
   IF l_sec < 10 THEN
      LET r_time = r_time CLIPPED,':','0',ps_sec
   ELSE
      LET r_time = r_time CLIPPED,':',ps_sec
   END IF
   
   RETURN r_time
END FUNCTION

#end add-point
 
{</section>}
 
