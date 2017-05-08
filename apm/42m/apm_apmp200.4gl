#該程式未解開Section, 採用最新樣板產出!
{<section id="apmp200.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2014-08-29 14:46:27), PR版次:0005(2016-12-14 13:54:31)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000070
#+ Filename...: apmp200
#+ Description: 交易對象拋轉據點作業
#+ Creator....: 02295(2014-08-29 10:10:16)
#+ Modifier...: 02295 -SD/PR- 05423
 
{</section>}
 
{<section id="apmp200.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#160411-00002#1  16/04/14 By catmoon 不需預帶ALL的信用額度相關資料至SITE
#160913-00055#4  2016/09/18  By lixiang  交易对象栏位开窗调整为q_pmaa001_25
#161019-00017#3  2016/10/20  By lixh     组织类型调整 q_ooef001 => q_ooef001_1
#161124-00048#8  2016/12/13  By zhujing  .*整批调整
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
     sel LIKE type_t.chr1,
     ooef001 LIKE ooef_t.ooef001,
     ooef001_desc LIKE type_t.chr80
     END RECORD
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"
TYPE type_g_detail2_d RECORD
     sel LIKE type_t.chr1,
     pmaa002 LIKE pmaa_t.pmaa002,
     pmaa001 LIKE ooef_t.ooef001,
     pmaa001_desc LIKE type_t.chr80,
     pmaa080 LIKE pmaa_t.pmaa080,
     pmaa080_desc LIKE type_t.chr80,
     pmaa090 LIKE pmaa_t.pmaa090,
     pmaa090_desc LIKE type_t.chr80
     END RECORD

DEFINE g_detail2_cnt         LIKE type_t.num5              #單身 總筆數(所有資料)
DEFINE g_detail2_d  DYNAMIC ARRAY OF type_g_detail2_d
DEFINE g_wc3                STRING
DEFINE g_wc4                STRING
DEFINE g_master   RECORD
        ooef001 STRING,
        pmaa002 STRING,
        pmaa001 STRING,
        pmaa080 STRING,
        pmaa090 STRING
       END RECORD 
DEFINE l_ac2                 LIKE type_t.num5              
DEFINE l_ac2_d               LIKE type_t.num5              #單身idx  
DEFINE g_detail_idx          LIKE type_t.num5
DEFINE g_detail_idx2         LIKE type_t.num5
DEFINE g_count1              LIKE type_t.num5
DEFINE g_count2              LIKE type_t.num5
#end add-point
 
{</section>}
 
{<section id="apmp200.main" >}
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
   CALL cl_ap_init("apm","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apmp200 WITH FORM cl_ap_formpath("apm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apmp200_init()   
 
      #進入選單 Menu (="N")
      CALL apmp200_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_apmp200
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="apmp200.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION apmp200_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc("pmaa002",'2014')
   CALL cl_set_combo_scc("l_pmaa002",'2014')
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="apmp200.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmp200_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   
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
         CALL apmp200_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT BY NAME g_wc ON ooef001
            BEFORE CONSTRUCT
               DISPLAY BY NAME g_master.ooef001
   
            AFTER FIELD ooef001
               LET g_master.ooef001 = GET_FLDBUF(ooef001)
   
            ON ACTION controlp INFIELD ooef001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               #CALL q_ooef001()    #161019-00017#3  
               CALL q_ooef001_1()  #161019-00017#3        
               DISPLAY g_qryparam.return1 TO ooef001 
               NEXT FIELD ooef001                 
         END CONSTRUCT
         CONSTRUCT BY NAME g_wc2 ON pmaa002,pmaa001
            BEFORE CONSTRUCT
               DISPLAY BY NAME g_master.pmaa002,g_master.pmaa001
   
            AFTER FIELD pmaa002
               LET g_master.pmaa002 = GET_FLDBUF(pmaa002)

            AFTER FIELD pmaa001
               LET g_master.pmaa001 = GET_FLDBUF(pmaa001)
               
            ON ACTION controlp INFIELD pmaa001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               #CALL q_pmaa001()       #160913-00055#4
               CALL q_pmaa001_25()     #160913-00055#4               
               DISPLAY g_qryparam.return1 TO pmaa001 
               NEXT FIELD pmaa001                 
         END CONSTRUCT 
         CONSTRUCT BY NAME g_wc3 ON pmaa090
            BEFORE CONSTRUCT
               DISPLAY BY NAME g_master.pmaa090
   
            AFTER FIELD pmaa090
               LET g_master.pmaa090 = GET_FLDBUF(pmaa090)
               
            ON ACTION controlp INFIELD pmaa090
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '281'
               CALL q_oocq002()                     
               DISPLAY g_qryparam.return1 TO pmaa090 
               NEXT FIELD pmaa090                 
         END CONSTRUCT
         CONSTRUCT BY NAME g_wc4 ON pmaa080
            BEFORE CONSTRUCT
               DISPLAY BY NAME g_master.pmaa080
   
            AFTER FIELD pmaa080
               LET g_master.pmaa080 = GET_FLDBUF(pmaa080)
               
            ON ACTION controlp INFIELD pmaa080
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '251'
               CALL q_oocq002()                     
               DISPLAY g_qryparam.return1 TO pmaa080 
               NEXT FIELD pmaa080                 
         END CONSTRUCT           
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT ARRAY g_detail_d FROM s_detail1.* ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, 
                  INSERT ROW = FALSE, 
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
            BEFORE INPUT

            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_detail_d.getLength() TO FORMONLY.h_count
               LET g_master_idx = l_ac

            ON CHANGE b_sel
              IF g_detail_d[l_ac].sel = 'Y' THEN 
                 LET g_count1 = g_count1 + 1
              ELSE
                 LET g_count1 = g_count1 - 1
              END IF

         END INPUT 
         INPUT ARRAY g_detail2_d FROM s_detail2.* ATTRIBUTE(COUNT = g_detail2_cnt,WITHOUT DEFAULTS, 
                  INSERT ROW = FALSE, 
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
            BEFORE INPUT

            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac2 = g_detail_idx2
               DISPLAY g_detail_idx2 TO FORMONLY.h_index
               DISPLAY g_detail2_d.getLength() TO FORMONLY.h_count
              
            ON CHANGE l_sel
              IF g_detail2_d[l_ac2].sel = 'Y' THEN 
                 LET g_count2 = g_count2 + 1
              ELSE
                 LET g_count2 = g_count2 - 1
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
            LET g_count1 = g_detail_d.getLength()
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
            LET g_count1 = 0
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "Y"
               END IF
            END FOR
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            LET g_count1 = g_count1 + 1
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "N"
               END IF
            END FOR
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            LET g_count1 = g_count1 - 1
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL apmp200_filter()
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
            CALL apmp200_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL apmp200_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         #選擇全部
         ON ACTION b_selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
            END FOR
            LET g_count1 = g_detail_d.getLength()
 
         #取消全部
         ON ACTION b_selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "N"
            END FOR
            LET g_count1 = 0
            
         #選擇全部
         ON ACTION l_selall
            CALL DIALOG.setSelectionRange("s_detail2", 1, -1, 1)
            FOR li_idx = 1 TO g_detail2_d.getLength()
               LET g_detail2_d[li_idx].sel = "Y"
            END FOR
            LET g_count2 = g_detail2_d.getLength()
 
         #取消全部
         ON ACTION l_selnone
            CALL DIALOG.setSelectionRange("s_detail2", 1, -1, 0)
            FOR li_idx = 1 TO g_detail2_d.getLength()
               LET g_detail2_d[li_idx].sel = "N"
            END FOR
            LET g_count2 = 0   

         ON ACTION batch_execute
            CALL apmp200_execute()
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
 
{<section id="apmp200.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION apmp200_query()
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
   CALL apmp200_b_fill()
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
 
{<section id="apmp200.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION apmp200_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"

   IF g_wc IS NULL THEN 
      LET g_wc = " 1=1"
   END IF
   LET g_sql = " SELECT 'N',ooef001,ooefl003 ",
               "   FROM ooef_t ",
               "   LEFT OUTER JOIN ooefl_t ON ooefent = ooeflent AND ooef001 = ooefl001 AND ooefl002 = '",g_dlang,"'",
               "  WHERE ooefent = ? AND ooefstus = 'Y' AND ooef201 = 'Y' AND ",g_wc,
               "  ORDER BY ooef001 "
               
   #end add-point
 
   PREPARE apmp200_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR apmp200_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
         g_detail_d[l_ac].sel,g_detail_d[l_ac].ooef001,g_detail_d[l_ac].ooef001_desc
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
      
      CALL apmp200_detail_show()      
 
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
   CALL g_detail_d.deleteElement(g_detail_d.getLength())
   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE apmp200_sel
   
   LET l_ac = 1
   CALL apmp200_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   IF g_wc2 IS NULL THEN 
      LET g_wc2 = " 1=1"
   END IF
   IF g_wc3 IS NULL THEN 
      LET g_wc3 = " 1=1"
   END IF
   IF g_wc4 IS NULL THEN 
      LET g_wc4 = " 1=1"
   END IF   
   LET g_sql = " SELECT 'N',pmaa002,pmaa001,pmaal004,pmaa080,a.oocql004,pmaa090,b.oocql004  ",
               "   FROM pmaa_t ",
               "   LEFT OUTER JOIN pmaal_t ON pmaaent = pmaalent AND pmaa001 = pmaal001 AND pmaal002 = '",g_dlang,"'",
               "   LEFT OUTER JOIN oocql_t a ON pmaaent = a.oocqlent AND a.oocql001 = '251' AND pmaa080 = a.oocql002 AND a.oocql003 = '",g_dlang,"'",
               "   LEFT OUTER JOIN oocql_t b ON pmaaent = b.oocqlent AND b.oocql001 = '281' AND pmaa090 = b.oocql002 AND b.oocql003 = '",g_dlang,"'",
               "  WHERE pmaaent = ? AND pmaastus = 'Y' AND ",g_wc2," AND (",g_wc3," AND ",g_wc4,")",
               "  ORDER BY pmaa002,pmaa001"

   PREPARE apmp200_sel2 FROM g_sql
   DECLARE b_fill_curs2 CURSOR FOR apmp200_sel2
   
   CALL g_detail2_d.clear()   
   FOREACH b_fill_curs2 USING g_enterprise INTO 
           g_detail2_d[l_ac].sel,g_detail2_d[l_ac].pmaa002,
           g_detail2_d[l_ac].pmaa001,g_detail2_d[l_ac].pmaa001_desc,
           g_detail2_d[l_ac].pmaa080,g_detail2_d[l_ac].pmaa080_desc,
           g_detail2_d[l_ac].pmaa090,g_detail2_d[l_ac].pmaa090_desc

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #add-point:b_fill段資料填充

      #end add-point
      
      CALL apmp200_detail_show()      
 
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
   CLOSE b_fill_curs2
   FREE apmp200_sel2
   CALL g_detail2_d.deleteElement(g_detail2_d.getLength())
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apmp200.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION apmp200_fetch()
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
 
{<section id="apmp200.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION apmp200_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apmp200.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION apmp200_filter()
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
   
   CALL apmp200_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="apmp200.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION apmp200_filter_parser(ps_field)
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
 
{<section id="apmp200.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION apmp200_filter_show(ps_field,ps_object)
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
   LET ls_condition = apmp200_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="apmp200.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION apmp200_execute()
DEFINE l_i   LIKE type_t.num5
DEFINE l_j   LIKE type_t.num5
DEFINE l_idx LIKE type_t.num5
DEFINE l_chr STRING
DEFINE l_stagecomplete  LIKE type_t.num10

DEFINE l_n               LIKE type_t.num5
#161124-00048#8 mod-S
#DEFINE l_pmab            RECORD LIKE pmab_t.*
DEFINE l_pmab RECORD  #交易對象據點檔
       pmabent LIKE pmab_t.pmabent, #企业编号
       pmabsite LIKE pmab_t.pmabsite, #营运据点
       pmab001 LIKE pmab_t.pmab001, #交易对象编号
       pmab002 LIKE pmab_t.pmab002, #信用额度检查
       pmab003 LIKE pmab_t.pmab003, #额度交易对象
       pmab004 LIKE pmab_t.pmab004, #信用评核等级
       pmab005 LIKE pmab_t.pmab005, #额度计算币种
       pmab006 LIKE pmab_t.pmab006, #企业额度
       pmab007 LIKE pmab_t.pmab007, #可超出率
       pmab008 LIKE pmab_t.pmab008, #有效期限
       pmab009 LIKE pmab_t.pmab009, #逾期账款宽限天数
       pmab010 LIKE pmab_t.pmab010, #允许除外额度
       pmab011 LIKE pmab_t.pmab011, #额度警示水准一
       pmab012 LIKE pmab_t.pmab012, #水准一通知层
       pmab013 LIKE pmab_t.pmab013, #额度警示水准二
       pmab014 LIKE pmab_t.pmab014, #水准二通知层
       pmab015 LIKE pmab_t.pmab015, #额度警示水准三
       pmab016 LIKE pmab_t.pmab016, #水准三通知层
       pmab017 LIKE pmab_t.pmab017, #启动预期应收通知
       pmab018 LIKE pmab_t.pmab018, #预期应收通知层
       pmab030 LIKE pmab_t.pmab030, #供应商ABC分类
       pmab031 LIKE pmab_t.pmab031, #负责采购人员
       pmab032 LIKE pmab_t.pmab032, #供应商惯用报表语言
       pmab033 LIKE pmab_t.pmab033, #供应商惯用交易币种
       pmab034 LIKE pmab_t.pmab034, #供应商惯用交易税种
       pmab035 LIKE pmab_t.pmab035, #供应商惯用发票开立方式
       pmab036 LIKE pmab_t.pmab036, #供应商惯用立账方式
       pmab037 LIKE pmab_t.pmab037, #供应商惯用付款条件
       pmab038 LIKE pmab_t.pmab038, #供应商惯用采购渠道
       pmab039 LIKE pmab_t.pmab039, #供应商惯用采购分类
       pmab040 LIKE pmab_t.pmab040, #供应商惯用交运方式
       pmab041 LIKE pmab_t.pmab041, #供应商惯用交运起点
       pmab042 LIKE pmab_t.pmab042, #供应商惯用交运终点
       pmab043 LIKE pmab_t.pmab043, #供应商惯用卸货港
       pmab044 LIKE pmab_t.pmab044, #供应商惯用其它条件
       pmab045 LIKE pmab_t.pmab045, #供应商惯用佣金率
       pmab046 LIKE pmab_t.pmab046, #供应商折扣率
       pmab047 LIKE pmab_t.pmab047, #供应商惯用Forwarder
       pmab048 LIKE pmab_t.pmab048, #供应商惯用 Notify
       pmab049 LIKE pmab_t.pmab049, #默认允许分批收货
       pmab050 LIKE pmab_t.pmab050, #最多可拆解批次
       pmab051 LIKE pmab_t.pmab051, #默认允许提前收货
       pmab052 LIKE pmab_t.pmab052, #可提前收货天数
       pmab053 LIKE pmab_t.pmab053, #惯用交易条件
       pmab054 LIKE pmab_t.pmab054, #惯用取价方式
       pmab055 LIKE pmab_t.pmab055, #应付账款类别
       pmab056 LIKE pmab_t.pmab056, #供应商惯用发票类型
       pmab057 LIKE pmab_t.pmab057, #供应商惯用内外购
       pmab058 LIKE pmab_t.pmab058, #供应商惯用汇率计算基准
       pmab060 LIKE pmab_t.pmab060, #供应商评鉴计算分类
       pmab061 LIKE pmab_t.pmab061, #价格评分
       pmab062 LIKE pmab_t.pmab062, #达交率评分
       pmab063 LIKE pmab_t.pmab063, #质量评分
       pmab064 LIKE pmab_t.pmab064, #配合度评分
       pmab065 LIKE pmab_t.pmab065, #调整加减分
       pmab066 LIKE pmab_t.pmab066, #定性评分一
       pmab067 LIKE pmab_t.pmab067, #定性评分二
       pmab068 LIKE pmab_t.pmab068, #定性评分三
       pmab069 LIKE pmab_t.pmab069, #定性评分四
       pmab070 LIKE pmab_t.pmab070, #定性评分五
       pmab071 LIKE pmab_t.pmab071, #检验程度
       pmab072 LIKE pmab_t.pmab072, #检验水准
       pmab073 LIKE pmab_t.pmab073, #检验级数
       pmab080 LIKE pmab_t.pmab080, #客户ABC分类
       pmab081 LIKE pmab_t.pmab081, #负责业务人员
       pmab082 LIKE pmab_t.pmab082, #客户惯用报表语言
       pmab083 LIKE pmab_t.pmab083, #客户惯用交易币种
       pmab084 LIKE pmab_t.pmab084, #客户惯用交易税种
       pmab085 LIKE pmab_t.pmab085, #客户惯用发票开立方式
       pmab086 LIKE pmab_t.pmab086, #客户惯用立账方式
       pmab087 LIKE pmab_t.pmab087, #客户惯用收款条件
       pmab088 LIKE pmab_t.pmab088, #客户惯用销售渠道
       pmab089 LIKE pmab_t.pmab089, #客户惯用销售分类
       pmab090 LIKE pmab_t.pmab090, #客户惯用交运方式
       pmab091 LIKE pmab_t.pmab091, #客户惯用交运起点
       pmab092 LIKE pmab_t.pmab092, #客户惯用交运终点
       pmab093 LIKE pmab_t.pmab093, #客户惯用卸货港
       pmab094 LIKE pmab_t.pmab094, #客户惯用其它条件
       pmab095 LIKE pmab_t.pmab095, #客户惯用佣金率
       pmab096 LIKE pmab_t.pmab096, #客户折扣率
       pmab097 LIKE pmab_t.pmab097, #客户惯用Forwarder
       pmab098 LIKE pmab_t.pmab098, #客户惯用 Notify
       pmab099 LIKE pmab_t.pmab099, #默认允许分批交货
       pmab100 LIKE pmab_t.pmab100, #最多可拆解批次
       pmab101 LIKE pmab_t.pmab101, #默认允许提前交货
       pmab102 LIKE pmab_t.pmab102, #可提前交货天数
       pmab103 LIKE pmab_t.pmab103, #惯用交易条件
       pmab104 LIKE pmab_t.pmab104, #惯用取价方式
       pmab105 LIKE pmab_t.pmab105, #应收账款类别
       pmab106 LIKE pmab_t.pmab106, #客户惯用发票类型
       pmab107 LIKE pmab_t.pmab107, #客户惯用内外销
       pmab108 LIKE pmab_t.pmab108, #客户惯用汇率计算基准
       pmabownid LIKE pmab_t.pmabownid, #资料所有者
       pmabowndp LIKE pmab_t.pmabowndp, #资料所有部门
       pmabcrtid LIKE pmab_t.pmabcrtid, #资料录入者
       pmabcrtdp LIKE pmab_t.pmabcrtdp, #资料录入部门
       pmabcrtdt LIKE pmab_t.pmabcrtdt, #资料创建日
       pmabmodid LIKE pmab_t.pmabmodid, #资料更改者
       pmabmoddt LIKE pmab_t.pmabmoddt, #最近更改日
       pmabcnfid LIKE pmab_t.pmabcnfid, #资料审核者
       pmabcnfdt LIKE pmab_t.pmabcnfdt, #数据审核日
       pmabstus LIKE pmab_t.pmabstus, #状态码
       pmabud001 LIKE pmab_t.pmabud001, #自定义字段(文本)001
       pmabud002 LIKE pmab_t.pmabud002, #自定义字段(文本)002
       pmabud003 LIKE pmab_t.pmabud003, #自定义字段(文本)003
       pmabud004 LIKE pmab_t.pmabud004, #自定义字段(文本)004
       pmabud005 LIKE pmab_t.pmabud005, #自定义字段(文本)005
       pmabud006 LIKE pmab_t.pmabud006, #自定义字段(文本)006
       pmabud007 LIKE pmab_t.pmabud007, #自定义字段(文本)007
       pmabud008 LIKE pmab_t.pmabud008, #自定义字段(文本)008
       pmabud009 LIKE pmab_t.pmabud009, #自定义字段(文本)009
       pmabud010 LIKE pmab_t.pmabud010, #自定义字段(文本)010
       pmabud011 LIKE pmab_t.pmabud011, #自定义字段(数字)011
       pmabud012 LIKE pmab_t.pmabud012, #自定义字段(数字)012
       pmabud013 LIKE pmab_t.pmabud013, #自定义字段(数字)013
       pmabud014 LIKE pmab_t.pmabud014, #自定义字段(数字)014
       pmabud015 LIKE pmab_t.pmabud015, #自定义字段(数字)015
       pmabud016 LIKE pmab_t.pmabud016, #自定义字段(数字)016
       pmabud017 LIKE pmab_t.pmabud017, #自定义字段(数字)017
       pmabud018 LIKE pmab_t.pmabud018, #自定义字段(数字)018
       pmabud019 LIKE pmab_t.pmabud019, #自定义字段(数字)019
       pmabud020 LIKE pmab_t.pmabud020, #自定义字段(数字)020
       pmabud021 LIKE pmab_t.pmabud021, #自定义字段(日期时间)021
       pmabud022 LIKE pmab_t.pmabud022, #自定义字段(日期时间)022
       pmabud023 LIKE pmab_t.pmabud023, #自定义字段(日期时间)023
       pmabud024 LIKE pmab_t.pmabud024, #自定义字段(日期时间)024
       pmabud025 LIKE pmab_t.pmabud025, #自定义字段(日期时间)025
       pmabud026 LIKE pmab_t.pmabud026, #自定义字段(日期时间)026
       pmabud027 LIKE pmab_t.pmabud027, #自定义字段(日期时间)027
       pmabud028 LIKE pmab_t.pmabud028, #自定义字段(日期时间)028
       pmabud029 LIKE pmab_t.pmabud029, #自定义字段(日期时间)029
       pmabud030 LIKE pmab_t.pmabud030, #自定义字段(日期时间)030
       pmab059 LIKE pmab_t.pmab059, #负责采购部门
       pmab109 LIKE pmab_t.pmab109, #负责业务部门
       pmab110 LIKE pmab_t.pmab110, #供应商条码包装数量
       pmab111 LIKE pmab_t.pmab111, #客户条码包装数量
       pmab019 LIKE pmab_t.pmab019, #逾期账款宽限额度
       pmab020 LIKE pmab_t.pmab020, #除外额有效日期
       pmab112 LIKE pmab_t.pmab112  #是否使用EC
END RECORD
#161124-00048#8 mod-E
DEFINE l_success         LIKE type_t.num5 
DEFINE r_success         LIKE type_t.num5 
DEFINE l_pmaacnfdt       DATETIME YEAR TO SECOND
DEFINE l_ooef001         LIKE ooef_t.ooef001
DEFINE l_sql             STRING
DEFINE l_count           LIKE type_t.num10

   LET l_count = g_count1 * g_count2
   LET l_success = TRUE
   LET l_idx = 1
   FOR l_i = 1 TO g_detail2_d.getLength()
      IF g_detail2_d[l_i].sel = 'Y' THEN 
         FOR l_j = 1 TO g_detail_d.getLength()
            IF g_detail_d[l_j].sel = 'Y' THEN 
               LET l_chr = g_detail2_d[l_i].pmaa001," INTO ",g_detail_d[l_j].ooef001   
               DISPLAY l_chr TO stagenow
               LET l_stagecomplete = l_idx* 100/l_count
               DISPLAY l_stagecomplete TO stagecomplete
               
               LET l_n = 0
               SELECT COUNT(*) INTO l_n FROM pmab_t 
                WHERE pmab001 = g_detail2_d[l_i].pmaa001 
                  AND pmabent = g_enterprise 
                  AND pmabsite = g_detail_d[l_j].ooef001
               IF l_n = 0 THEN
                  #161124-00048#8 mod-S
#                  SELECT * INTO l_pmab.* FROM pmab_t 
#                   WHERE pmab001 = g_detail2_d[l_i].pmaa001 
#                     AND pmabent = g_enterprise 
#                     AND pmabsite = 'ALL'
                  SELECT pmabent,pmabsite,pmab001,pmab002,pmab003,
                         pmab004,pmab005,pmab006,pmab007,pmab008,
                         pmab009,pmab010,pmab011,pmab012,pmab013,
                         pmab014,pmab015,pmab016,pmab017,pmab018,
                         pmab030,pmab031,pmab032,pmab033,pmab034,
                         pmab035,pmab036,pmab037,pmab038,pmab039,
                         pmab040,pmab041,pmab042,pmab043,pmab044,
                         pmab045,pmab046,pmab047,pmab048,pmab049,
                         pmab050,pmab051,pmab052,pmab053,pmab054,
                         pmab055,pmab056,pmab057,pmab058,pmab060,
                         pmab061,pmab062,pmab063,pmab064,pmab065,
                         pmab066,pmab067,pmab068,pmab069,pmab070,
                         pmab071,pmab072,pmab073,pmab080,pmab081,
                         pmab082,pmab083,pmab084,pmab085,pmab086,
                         pmab087,pmab088,pmab089,pmab090,pmab091,
                         pmab092,pmab093,pmab094,pmab095,pmab096,
                         pmab097,pmab098,pmab099,pmab100,pmab101,
                         pmab102,pmab103,pmab104,pmab105,pmab106,
                         pmab107,pmab108,pmabownid,pmabowndp,pmabcrtid,
                         pmabcrtdp,pmabcrtdt,pmabmodid,pmabmoddt,pmabcnfid,
                         pmabcnfdt,pmabstus,pmabud001,pmabud002,pmabud003,
                         pmabud004,pmabud005,pmabud006,pmabud007,pmabud008,
                         pmabud009,pmabud010,pmabud011,pmabud012,pmabud013,
                         pmabud014,pmabud015,pmabud016,pmabud017,pmabud018,
                         pmabud019,pmabud020,pmabud021,pmabud022,pmabud023,
                         pmabud024,pmabud025,pmabud026,pmabud027,pmabud028,
                         pmabud029,pmabud030,pmab059,pmab109,pmab110,
                         pmab111,pmab019,pmab020,pmab112 
                    INTO l_pmab.* 
                    FROM pmab_t 
                   WHERE pmab001 = g_detail2_d[l_i].pmaa001 
                     AND pmabent = g_enterprise 
                     AND pmabsite = 'ALL'
                  #161124-00048#8 mod-E
                  LET l_pmab.pmabownid = g_user
                  LET l_pmab.pmabowndp = g_dept
                  LET l_pmab.pmabcrtid = g_user
                  LET l_pmab.pmabcrtdp = g_dept 
                  LET l_pmaacnfdt = cl_get_current()
                  LET l_pmab.pmabmodid = NULL
                  LET l_pmab.pmabmoddt = NULL
                  LET l_pmab.pmabsite = g_detail_d[l_j].ooef001
                  LET l_pmab.pmabud011 = 0
                  LET l_pmab.pmabud012 = 0
                  LET l_pmab.pmabud013 = 0
                  LET l_pmab.pmabud014 = 0
                  LET l_pmab.pmabud015 = 0
                  LET l_pmab.pmabud016 = 0
                  LET l_pmab.pmabud017 = 0
                  LET l_pmab.pmabud018 = 0
                  LET l_pmab.pmabud019 = 0
                  LET l_pmab.pmabud020 = 0
                  #160411-00002#1--add--start--
                  #不需預帶ALL的信用額度相關資料至SITE
                  LET l_pmab.pmab002 = NULL
                  LET l_pmab.pmab003 = g_detail2_d[l_i].pmaa001 #預設交易對象編號
                  LET l_pmab.pmab004 = NULL
                  LET l_pmab.pmab005 = NULL
                  LET l_pmab.pmab006 = ''
                  LET l_pmab.pmab007 = ''
                  LET l_pmab.pmab008 = NULL
                  LET l_pmab.pmab009 = ''
                  LET l_pmab.pmab019 = ''
                  LET l_pmab.pmab010 = ''
                  LET l_pmab.pmab020 = ''
                  #160411-00002#1--add--end----
                  INSERT INTO pmab_t (pmabent,pmabsite,pmab001,pmab080,pmab081,pmab082,pmab083,pmab084,
                                      pmab103,pmab104,pmab085,pmab087,pmab105,pmab088,pmab089,pmab090,
                                      pmab091,pmab092,pmab093,pmab094,pmab095,pmab096,pmab097,pmab098,
                                      pmab099,pmab100,pmab101,pmab102,pmab030,pmab031,pmab032,pmab033,
                                      pmab034,pmab053,pmab054,pmab035,pmab037,pmab055,pmab038,pmab039,
                                      pmab040,pmab041,pmab042,pmab043,pmab044,pmab045,pmab046,pmab047,
                                      pmab048,pmab049,pmab050,pmab051,pmab052,pmab071,pmab072,pmab073,
                                      pmab060,pmab061,pmab066,pmab062,pmab067,pmab063,pmab068,pmab064,
                                      pmab069,pmab065,pmab070,pmab002,pmab003,pmab004,pmab005,pmab006,
                                      pmab007,pmab008,pmab009,pmab010,pmab011,pmab012,pmab013,pmab014,
                                      pmab015,pmab016,pmab017,pmab018,pmab056,pmab057,pmab058,pmab106,
                                      pmab107,pmab108,pmabownid,pmabowndp,pmabcrtid,pmabcrtdt,pmabcrtdp,
                                      pmabmodid,pmabmoddt,
                                      pmabud011,pmabud012,pmabud013,pmabud014,pmabud015,pmabud016,
                                      pmabud017,pmabud018,pmabud019,pmabud020)
                    VALUES (g_enterprise,l_pmab.pmabsite,l_pmab.pmab001,l_pmab.pmab080,l_pmab.pmab081,
                            l_pmab.pmab082,l_pmab.pmab083,l_pmab.pmab084,l_pmab.pmab103,l_pmab.pmab104,
                            l_pmab.pmab085,l_pmab.pmab087,l_pmab.pmab105,l_pmab.pmab088,l_pmab.pmab089,
                            l_pmab.pmab090,l_pmab.pmab091,l_pmab.pmab092,l_pmab.pmab093,l_pmab.pmab094,
                            l_pmab.pmab095,l_pmab.pmab096,l_pmab.pmab097,l_pmab.pmab098,l_pmab.pmab099,
                            l_pmab.pmab100,l_pmab.pmab101,l_pmab.pmab102,l_pmab.pmab030,l_pmab.pmab031,
                            l_pmab.pmab032,l_pmab.pmab033,l_pmab.pmab034,l_pmab.pmab053,l_pmab.pmab054,
                            l_pmab.pmab035,l_pmab.pmab037,l_pmab.pmab055,l_pmab.pmab038,l_pmab.pmab039,
                            l_pmab.pmab040,l_pmab.pmab041,l_pmab.pmab042,l_pmab.pmab043,l_pmab.pmab044,
                            l_pmab.pmab045,l_pmab.pmab046,l_pmab.pmab047,l_pmab.pmab048,l_pmab.pmab049,
                            l_pmab.pmab050,l_pmab.pmab051,l_pmab.pmab052,l_pmab.pmab071,l_pmab.pmab072,
                            l_pmab.pmab073,l_pmab.pmab060,l_pmab.pmab061,l_pmab.pmab066,l_pmab.pmab062,
                            l_pmab.pmab067,l_pmab.pmab063,l_pmab.pmab068,l_pmab.pmab064,l_pmab.pmab069,
                            l_pmab.pmab065,l_pmab.pmab070,l_pmab.pmab002,l_pmab.pmab003,l_pmab.pmab004,
                            l_pmab.pmab005,l_pmab.pmab006,l_pmab.pmab007,l_pmab.pmab008,l_pmab.pmab009,
                            l_pmab.pmab010,l_pmab.pmab011,l_pmab.pmab012,l_pmab.pmab013,l_pmab.pmab014,
                            l_pmab.pmab015,l_pmab.pmab016,l_pmab.pmab017,l_pmab.pmab018,l_pmab.pmab056,
                            l_pmab.pmab057,l_pmab.pmab058,l_pmab.pmab106,l_pmab.pmab107,l_pmab.pmab108,
                            l_pmab.pmabownid,l_pmab.pmabowndp,l_pmab.pmabcrtid,l_pmaacnfdt,l_pmab.pmabcrtdp,
                            l_pmab.pmabmodid,l_pmab.pmabmoddt,
                            l_pmab.pmabud011,l_pmab.pmabud012,l_pmab.pmabud013,l_pmab.pmabud014,l_pmab.pmabud015,
                            l_pmab.pmabud016,l_pmab.pmabud017,l_pmab.pmabud018,l_pmab.pmabud019,l_pmab.pmabud020) 
                  IF SQLCA.sqlcode THEN
                     LET l_success = FALSE
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "pmab_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     EXIT FOR
                  END IF               
               END IF
               LET l_idx = l_idx + 1
            END IF   
         END FOR
      END IF
      IF l_success = FALSE THEN 
         EXIT FOR
      END IF
   END FOR
   DISPLAY l_chr TO stagenow
   LET l_stagecomplete = 100
   DISPLAY l_stagecomplete TO stagecomplete   
   CALL cl_ask_confirm3("std-00012","")
END FUNCTION

#end add-point
 
{</section>}
 
