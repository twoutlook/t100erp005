#該程式未解開Section, 採用最新樣板產出!
{<section id="aicp810.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2015-03-24 11:01:48), PR版次:0006(2017-02-15 18:00:58)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000151
#+ Filename...: aicp810
#+ Description: 多角貿易倉退單拋轉還原作業
#+ Creator....: 04441(2014-06-09 15:26:01)
#+ Modifier...: 04441 -SD/PR- 08171
 
{</section>}
 
{<section id="aicp810.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#Memos
#161231-00013#1  2016/01/11 By 08992   增加azzi850 部門權限控管
#170213-00043#1  2017/02/15 By 08171   若拋轉成功後已無符合的資料則不提示[指定的資料無法查詢到，....] 
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
       sel            LIKE type_t.chr1,
       pmdsdocno      LIKE pmds_t.pmdsdocno, 
       pmdsdocdt      LIKE pmds_t.pmdsdocdt,
       pmds007        LIKE pmds_t.pmds007,
       pmds007_desc   LIKE type_t.chr80,
       pmds002        LIKE pmds_t.pmds002,
       pmds002_desc   LIKE type_t.chr80,
       pmds003        LIKE pmds_t.pmds003,
       pmds003_desc   LIKE type_t.chr80,
       pmdsownid      LIKE pmds_t.pmdsownid,
       pmdsownid_desc LIKE type_t.chr80,
       pmdscrtid      LIKE pmds_t.pmdscrtid,
       pmdscrtid_desc LIKE type_t.chr80,
       pmds041        LIKE pmds_t.pmds041
       END RECORD
       
TYPE type_g_detail2_d RECORD
       pmdtseq           LIKE pmdt_t.pmdtseq, 
       pmdt001           LIKE pmdt_t.pmdt001,
       pmdt002           LIKE pmdt_t.pmdt002,
       pmdt003           LIKE pmdt_t.pmdt003,
       pmdt004           LIKE pmdt_t.pmdt004,
       pmdt005           LIKE pmdt_t.pmdt005,
       pmdt006           LIKE pmdt_t.pmdt006,
       pmdt006_desc      LIKE type_t.chr80,
       pmdt006_desc_desc LIKE type_t.chr80,
       pmdt007           LIKE pmdt_t.pmdt007,
       pmdt019           LIKE pmdt_t.pmdt019,
       pmdt019_desc      LIKE type_t.chr80,
       pmdt020           LIKE pmdt_t.pmdt020,
       pmdt021           LIKE pmdt_t.pmdt021,
       pmdt021_desc      LIKE type_t.chr80,
       pmdt022           LIKE pmdt_t.pmdt022,
       pmdt008           LIKE pmdt_t.pmdt008,
       pmdt023           LIKE pmdt_t.pmdt023,
       pmdt023_desc      LIKE type_t.chr80,
       pmdt024           LIKE pmdt_t.pmdt024,
       pmdt059           LIKE pmdt_t.pmdt059
                      END RECORD

TYPE type_g_detail3_d RECORD
       pmdsdocno1        LIKE pmds_t.pmdsdocno, 
       pmdsdocdt1        LIKE pmds_t.pmdsdocdt,
       pmds0071          LIKE pmds_t.pmds007,
       pmds0071_desc     LIKE type_t.chr80,
       pmds0021          LIKE pmds_t.pmds002,
       pmds0021_desc     LIKE type_t.chr80,
       pmds0031          LIKE pmds_t.pmds003,
       pmds0031_desc     LIKE type_t.chr80
                      END RECORD

TYPE type_g_detail4_d RECORD
       pmdsdocno2        LIKE pmds_t.pmdsdocno, 
       pmdsdocdt2        LIKE pmds_t.pmdsdocdt,
       pmds0072          LIKE pmds_t.pmds007,
       pmds0072_desc     LIKE type_t.chr80,
       pmds0022          LIKE pmds_t.pmds002,
       pmds0022_desc     LIKE type_t.chr80,
       pmds0032          LIKE pmds_t.pmds003,
       pmds0032_desc     LIKE type_t.chr80,
       pmds0412          LIKE pmds_t.pmds041,
       reason            LIKE type_t.chr500
                      END RECORD

DEFINE g_detail2_d  DYNAMIC ARRAY OF type_g_detail2_d
DEFINE g_detail3_d  DYNAMIC ARRAY OF type_g_detail3_d
DEFINE g_detail4_d  DYNAMIC ARRAY OF type_g_detail4_d
DEFINE g_detail2_idx         LIKE type_t.num5
DEFINE g_detail3_idx         LIKE type_t.num5
DEFINE g_detail4_idx         LIKE type_t.num5
DEFINE g_detail2_cnt         LIKE type_t.num5
DEFINE g_detail3_cnt         LIKE type_t.num5
DEFINE g_detail4_cnt         LIKE type_t.num5

DEFINE g_success_cnt     LIKE type_t.num5
DEFINE g_fail_cnt        LIKE type_t.num5

DEFINE g_aicp810_sel     STRING

#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aicp810.main" >}
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
   CALL cl_ap_init("aic","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   CALL aicp810_create_temp_table()
   
   CALL aicp810_sel()
   
   IF NOT cl_null(g_argv[1]) THEN
      LET g_bgjob = 'Y'
   END IF
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      IF NOT cl_null(g_argv[1]) THEN
         LET g_wc = " pmdsdocno = '",g_argv[1],"' "
         CALL aicp810_query()

         UPDATE aicp810_tmp SET sel = 'Y'

         CALL aicp810_process()
      END IF
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aicp810 WITH FORM cl_ap_formpath("aic",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aicp810_init()   
 
      #進入選單 Menu (="N")
      CALL aicp810_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      DROP TABLE aicp810_tmp

      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aicp810
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aicp810.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aicp810_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('b_pmdt005','2055')
   
   IF cl_null(g_bgjob) THEN
      LET g_bgjob = 'N'
   END IF
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aicp810.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aicp810_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_cnt       LIKE type_t.num5

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
         CALL aicp810_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT BY NAME g_wc ON pmdsdocno,pmdsdocdt,pmds007,pmds002,pmds003,pmdsownid,pmdscrtid,pmds041

            BEFORE CONSTRUCT
            
            ON ACTION controlp INFIELD pmdsdocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '7'                #倉退
               LET g_qryparam.where = g_aicp810_sel
               CALL q_pmdsdocno()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmdsdocno  #顯示到畫面上
               NEXT FIELD pmdsdocno                     #返回原欄位    
               
            ON ACTION controlp INFIELD pmds007
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_pmaa001_3()                     #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmds007  #顯示到畫面上
               NEXT FIELD pmds007                     #返回原欄位
   
            ON ACTION controlp INFIELD pmds002
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmds002  #顯示到畫面上
               NEXT FIELD pmds002                     #返回原欄位
               
            ON ACTION controlp INFIELD pmds003
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooeg001()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmds003  #顯示到畫面上
               NEXT FIELD pmds003                     #返回原欄位
               
            ON ACTION controlp INFIELD pmdsownid
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmdsownid  #顯示到畫面上
               NEXT FIELD pmdsownid                     #返回原欄位
   
            ON ACTION controlp INFIELD pmdscrtid
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmdscrtid  #顯示到畫面上
               NEXT FIELD pmdscrtid                     #返回原欄位
   
            ON ACTION controlp INFIELD pmds041
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '7'                #倉退
               CALL q_pmds041()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmds041    #顯示到畫面上
               NEXT FIELD pmds041                       #返回原欄位    
               
         END CONSTRUCT
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT ARRAY g_detail_d FROM s_detail1.*
            ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                      INSERT ROW = FALSE,
                      DELETE ROW = FALSE,
                      APPEND ROW = FALSE)

            BEFORE INPUT
               LET g_detail_cnt = g_detail_d.getLength()

            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_master_idx = l_ac
               DISPLAY l_ac TO FORMONLY.h_index
               CALL aicp810_fetch()               
               
            ON CHANGE b_sel
               UPDATE aicp810_tmp 
                  SET sel = g_detail_d[l_ac].sel 
                WHERE pmdsdocno = g_detail_d[l_ac].pmdsdocno 
                  
         END INPUT
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_detail2_d TO s_detail2.* ATTRIBUTE(COUNT=g_detail2_cnt)
            BEFORE DISPLAY
              
            BEFORE ROW
               CALL FGL_SET_ARR_CURR(g_detail2_idx)
               LET g_detail2_idx = DIALOG.getCurrentRow("s_detail2")
               DISPLAY g_detail2_idx TO FORMONLY.idx
              
         END DISPLAY

         DISPLAY ARRAY g_detail3_d TO s_detail3.* ATTRIBUTE(COUNT=g_detail3_cnt)
            BEFORE DISPLAY
              
            BEFORE ROW
               CALL FGL_SET_ARR_CURR(g_detail3_idx)
               LET g_detail3_idx = DIALOG.getCurrentRow("s_detail3")
               DISPLAY g_detail3_idx TO FORMONLY.idx
              
         END DISPLAY

         DISPLAY ARRAY g_detail4_d TO s_detail4.* ATTRIBUTE(COUNT=g_detail4_cnt)
            BEFORE DISPLAY
              
            BEFORE ROW
               CALL FGL_SET_ARR_CURR(g_detail4_idx)
               LET g_detail4_idx = DIALOG.getCurrentRow("s_detail4")
               DISPLAY g_detail4_idx TO FORMONLY.idx
              
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
            CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
            CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
            
            CALL aicp810_sel()
            
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
            UPDATE aicp810_tmp 
               SET sel = 'Y'
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
            UPDATE aicp810_tmp 
               SET sel = 'N'
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "Y"
               END IF
            END FOR
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  UPDATE aicp810_tmp 
                     SET sel = 'Y' 
                   WHERE pmdsdocno = g_detail_d[li_idx].pmdsdocno
               END IF
            END FOR
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "N"
               END IF
            END FOR
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  UPDATE aicp810_tmp 
                     SET sel = 'N' 
                   WHERE pmdsdocno = g_detail_d[li_idx].pmdsdocno
               END IF
            END FOR
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL aicp810_filter()
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
            CALL aicp810_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL aicp810_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            #變更此筆資料後，直接按執行
            IF l_ac > 0 THEN
               UPDATE aicp810_tmp
                  SET sel = g_detail_d[l_ac].sel
                WHERE pmdsdocno = g_detail_d[l_ac].pmdsdocno
            END IF
            
            LET l_cnt = ''
            SELECT COUNT(*) INTO l_cnt
              FROM aicp810_tmp
             WHERE sel = 'Y'
            IF cl_null(l_cnt) OR l_cnt = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = '-400'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               CONTINUE DIALOG
            ELSE
               CALL aicp810_process()
               LET INT_FLAG = TRUE     #170213-00043#1 17/02/15 By 08171 add
               CALL aicp810_query()
               LET INT_FLAG = FALSE    #170213-00043#1 17/02/15 By 08171 add
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
 
{<section id="aicp810.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aicp810_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   DELETE FROM aicp810_tmp;
   LET g_sql = "SELECT DISTINCT 'N',pmdsent,pmdsdocno,pmdsdocdt,pmds007,pmds002,pmds003,pmdsownid,pmdscrtid,pmds041,pmdt085 ",
               "  FROM pmds_t,pmdt_t ",
               " WHERE ",g_aicp810_sel,
               " AND ",g_wc
               
   LET g_sql = "INSERT INTO aicp810_tmp ",g_sql
   PREPARE tmp_ins_pre FROM g_sql
   EXECUTE tmp_ins_pre

   LET g_wc_filter = " 1=1"
   #end add-point
        
   LET g_error_show = 1
   CALL aicp810_b_fill()
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
 
{<section id="aicp810.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aicp810_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   LET g_sql = "SELECT DISTINCT sel,pmdsdocno,pmdsdocdt,pmds007,pmaal004,pmds002,a.oofa011, ",
               "                pmds003,ooefl003,pmdsownid,b.oofa011,pmdscrtid,c.oofa011,pmds041 ",
               "  FROM aicp810_tmp ",
               "       LEFT OUTER JOIN pmaal_t ON pmaalent = '",g_enterprise,"' AND pmds007 = pmaal001 AND pmaal002 = '",g_dlang,"' ",
               "       LEFT OUTER JOIN oofa_t a ON a.oofaent = '",g_enterprise,"' AND a.oofa002 = '2' AND a.oofa003 = pmds002 ",
               "       LEFT OUTER JOIN ooefl_t ON ooeflent = '",g_enterprise,"' AND ooefl001 = pmds003 AND ooefl002 = '",g_dlang,"' ",
               "       LEFT OUTER JOIN oofa_t b ON b.oofaent = '",g_enterprise,"' AND b.oofa002 = '2' AND b.oofa003 = pmdsownid ",
               "       LEFT OUTER JOIN oofa_t c ON c.oofaent = '",g_enterprise,"' AND c.oofa002 = '2' AND c.oofa003 = pmdscrtid ",
               " WHERE pmdsent = ? AND ",g_wc_filter,
               " ORDER BY pmdsdocno,pmdsdocdt "

   #end add-point
 
   PREPARE aicp810_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aicp810_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   CALL g_detail2_d.clear()  
   LET g_master_idx = 1  
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
   g_detail_d[l_ac].sel,g_detail_d[l_ac].pmdsdocno,g_detail_d[l_ac].pmdsdocdt,
   g_detail_d[l_ac].pmds007,g_detail_d[l_ac].pmds007_desc,
   g_detail_d[l_ac].pmds002,g_detail_d[l_ac].pmds002_desc,
   g_detail_d[l_ac].pmds003,g_detail_d[l_ac].pmds003_desc,
   g_detail_d[l_ac].pmdsownid,g_detail_d[l_ac].pmdsownid_desc,
   g_detail_d[l_ac].pmdscrtid,g_detail_d[l_ac].pmdscrtid_desc,
   g_detail_d[l_ac].pmds041
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
      
      CALL aicp810_detail_show()      
 
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
   FREE aicp810_sel
   
   LET l_ac = 1
   CALL aicp810_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aicp810.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aicp810_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define name="fetch.define"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後 name="fetch.after_fill"
   IF g_detail_d.getLength() = 0 THEN
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_sql = "SELECT pmdtseq,pmdt001,pmdt002,pmdt003,pmdt004,pmdt005,pmdt006,imaal003,imaal004,pmdt007,pmdt019,a.oocal003, ",
               "       pmdt020,pmdt021,b.oocal003,pmdt022,pmdt008,pmdt023,c.oocal003,pmdt024,pmdt059 ",
               "  FROM pmdt_t ",
               "       LEFT OUTER JOIN imaal_t ON pmdtent = imaalent AND pmdt006 = imaal001 AND imaal002 = '",g_dlang,"' ",
               "       LEFT OUTER JOIN oocal_t a ON pmdtent = a.oocalent AND pmdt019 = a.oocal001 AND a.oocal002 = '",g_dlang,"' ",
               "       LEFT OUTER JOIN oocal_t b ON pmdtent = b.oocalent AND pmdt021 = b.oocal001 AND b.oocal002 = '",g_dlang,"' ",
               "       LEFT OUTER JOIN oocal_t c ON pmdtent = c.oocalent AND pmdt023 = c.oocal001 AND c.oocal002 = '",g_dlang,"' ",
               " WHERE pmdtent = '",g_enterprise,"'",
               "   AND pmdtdocno = '",g_detail_d[g_master_idx].pmdsdocno,"'"
   PREPARE pmdt_fill_pre FROM g_sql
   DECLARE pmdt_fill_cur CURSOR FOR pmdt_fill_pre
   FOREACH pmdt_fill_cur INTO 
      g_detail2_d[l_ac].pmdtseq,g_detail2_d[l_ac].pmdt001,g_detail2_d[l_ac].pmdt002,g_detail2_d[l_ac].pmdt003,g_detail2_d[l_ac].pmdt004,
      g_detail2_d[l_ac].pmdt005,g_detail2_d[l_ac].pmdt006,g_detail2_d[l_ac].pmdt006_desc,g_detail2_d[l_ac].pmdt006_desc_desc,
      g_detail2_d[l_ac].pmdt007,g_detail2_d[l_ac].pmdt019,g_detail2_d[l_ac].pmdt019_desc,g_detail2_d[l_ac].pmdt020,
      g_detail2_d[l_ac].pmdt021,g_detail2_d[l_ac].pmdt021_desc,g_detail2_d[l_ac].pmdt022,g_detail2_d[l_ac].pmdt008,
      g_detail2_d[l_ac].pmdt023,g_detail2_d[l_ac].pmdt023_desc,g_detail2_d[l_ac].pmdt024,g_detail2_d[l_ac].pmdt059
   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

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
   CALL g_detail2_d.deleteElement(g_detail2_d.getLength())
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.cnt   
   #end add-point 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="aicp810.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aicp810_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aicp810.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aicp810_filter()
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
   CALL g_detail2_d.clear()
   
   CONSTRUCT g_wc_filter ON pmdsdocno,pmdsdocdt,pmds007,pmds002,pmds003,pmdsownid,pmdscrtid,pmds041
        FROM s_detail1[1].b_pmdsdocno,s_detail1[1].b_pmdsdocdt,s_detail1[1].b_pmds007,
             s_detail1[1].b_pmds002,s_detail1[1].b_pmds003,
             s_detail1[1].b_pmdsownid,s_detail1[1].b_pmdscrtid,s_detail1[1].b_pmds041
           
      BEFORE CONSTRUCT
      
            ON ACTION controlp INFIELD pmdsdocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '7'                #倉退
               LET g_qryparam.where = g_aicp810_sel
               CALL q_pmdsdocno()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmdsdocno  #顯示到畫面上
               NEXT FIELD pmdsdocno                     #返回原欄位    
               
            ON ACTION controlp INFIELD pmds007
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_pmaa001_3()                     #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmds007  #顯示到畫面上
               NEXT FIELD pmds007                     #返回原欄位
   
            ON ACTION controlp INFIELD pmds002
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmds002  #顯示到畫面上
               NEXT FIELD pmds002                     #返回原欄位
               
            ON ACTION controlp INFIELD pmds003
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooeg001()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmds003  #顯示到畫面上
               NEXT FIELD pmds003                     #返回原欄位
               
            ON ACTION controlp INFIELD pmdsownid
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmdsownid  #顯示到畫面上
               NEXT FIELD pmdsownid                     #返回原欄位
   
            ON ACTION controlp INFIELD pmdscrtid
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                          #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmdscrtid  #顯示到畫面上
               NEXT FIELD pmdscrtid                     #返回原欄位

            ON ACTION controlp INFIELD pmds041
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '7'                #倉退
               CALL q_pmds041()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmds041    #顯示到畫面上
               NEXT FIELD pmds041                       #返回原欄位    
               
   END CONSTRUCT
   #end add-point    
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   
   CALL aicp810_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="aicp810.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aicp810_filter_parser(ps_field)
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
 
{<section id="aicp810.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aicp810_filter_show(ps_field,ps_object)
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
   LET ls_condition = aicp810_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aicp810.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aicp810_process()
# Input parameter: no
# Return code....: no
# Date & Author..: 140610 By whiteny
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp810_process()
DEFINE ls_js          STRING
DEFINE lc_param       type_parameter
DEFINE l_success      LIKE type_t.num5
DEFINE l_tot_success  LIKE type_t.num5
DEFINE l_pmds      RECORD
   pmdsdocno       LIKE pmds_t.pmdsdocno, 
   pmdsdocdt       LIKE pmds_t.pmdsdocdt,
   pmds007         LIKE pmds_t.pmds007,
   pmds002         LIKE pmds_t.pmds002,
   pmds003         LIKE pmds_t.pmds003,
   pmds041         LIKE pmds_t.pmds041,
   pmdt085         LIKE pmdt_t.pmdt085
               END RECORD
DEFINE l_xmdk  RECORD
    xmdksite     LIKE xmdk_t.xmdksite,
    xmdkdocno    LIKE xmdk_t.xmdkdocno,
    xmdkdocdt    LIKE xmdk_t.xmdkdocdt
               END RECORD
DEFINE l_pmds1  RECORD
    pmdssite     LIKE pmds_t.pmdssite,
    pmdsdocno    LIKE pmds_t.pmdsdocno,
    pmdsdocdt    LIKE pmds_t.pmdsdocdt
               END RECORD
DEFINE l_g_prog       LIKE type_t.chr20
DEFINE l_g_site       LIKE type_t.chr10
DEFINE l_g_argv       LIKE type_t.chr10

   CALL util.JSON.parse(ls_js,lc_param)

   #預先計算progressbar迴圈次數

   CALL cl_err_collect_init()
   CALL s_azzi902_get_gzzd('aicp810',"lbl_xmdk035") RETURNING g_coll_title[1],g_coll_title[1]    #多角流程序號
   CALL s_azzi902_get_gzzd('aicp810',"lbl_xmdkdocno") RETURNING g_coll_title[2],g_coll_title[2]  #銷退單號
   CALL s_azzi902_get_gzzd('aicp810',"lbl_pmdsdocno") RETURNING g_coll_title[3],g_coll_title[3]  #倉退單號
   CALL g_detail3_d.clear()
   CALL g_detail4_d.clear()

   LET g_success_cnt = 1
   LET g_fail_cnt = 0
   LET l_tot_success = TRUE
   LET l_success = TRUE
   LET l_g_prog = g_prog
   LET l_g_site = g_site
   LET l_g_argv = g_argv[1]

   #有選擇的倉退"交易序號"
   LET g_sql = "SELECT DISTINCT pmdsdocno,pmdsdocdt,pmds007,pmds002,pmds003,pmds041,pmdt085 ",
               "  FROM aicp810_tmp WHERE sel = 'Y' ORDER BY pmdsdocno "
   PREPARE aicp810_process_pre FROM g_sql
   DECLARE aicp810_process_cur CURSOR WITH HOLD FOR aicp810_process_pre

   #各站之銷退符合上述之"交易序號"者
   LET g_sql = " SELECT xmdksite,xmdkdocno,xmdkdocdt ",
               "   FROM xmdk_t ",
               "  WHERE xmdkent = '",g_enterprise,"' ",
               "    AND xmdk000 = '6' ",
               "    AND xmdk035 = ? "
   PREPARE aicp810_process_xmdk_pre FROM g_sql
   DECLARE aicp810_process_xmdk_cur CURSOR WITH HOLD FOR aicp810_process_xmdk_pre

   #各站之倉退符合上述之"交易序號"者
   LET g_sql = " SELECT pmdssite,pmdsdocno,pmdsdocdt ",
               "   FROM pmds_t ",
               "  WHERE pmdsent = '",g_enterprise,"' ",
               "    AND pmds000 = '7' ",
               "    AND pmds041 = ? ",
               "    AND pmdsdocno <> ?"
   PREPARE aicp810_process_pmds_pre FROM g_sql
   DECLARE aicp810_process_pmds_cur CURSOR WITH HOLD FOR aicp810_process_pmds_pre

   #將該流程所有營運據點之符合"多角流程序號"之倉退/銷退單過帳還原,取消確認並刪除,但保留"多角貿易已拋轉"='Y'之原始倉退單據
   INITIALIZE l_pmds.* TO NULL
   FOREACH aicp810_process_cur INTO l_pmds.pmdsdocno,l_pmds.pmdsdocdt,l_pmds.pmds007,
                                    l_pmds.pmds002,l_pmds.pmds003,l_pmds.pmds041,l_pmds.pmdt085
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'process_cur'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      IF NOT l_success THEN
         LET l_tot_success = FALSE
         LET l_success = TRUE
      END IF
      
      #先取得錯誤訊息的長度，大於此長度的表示是這張單子的錯誤訊息
      LET g_fail_cnt = g_errcollect.getLength()
      CALL s_transaction_begin()
      LET g_site = l_g_site
      LET g_prog = 'apmt580'

      UPDATE pmds_t
         SET pmds041 = '',
             pmds050 = 'N'
       WHERE pmdsent = g_enterprise
         AND pmdsdocno = l_pmds.pmdsdocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "update pmds_t"
         LET g_errparam.coll_vals[1] = l_pmds.pmds041
         LET g_errparam.coll_vals[3] = l_pmds.pmdsdocno
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET l_success = FALSE
         CONTINUE FOREACH
      END IF

      INITIALIZE l_pmds1.* TO NULL
      FOREACH aicp810_process_pmds_cur USING l_pmds.pmds041,l_pmds.pmdsdocno INTO l_pmds1.pmdssite,l_pmds1.pmdsdocno,l_pmds1.pmdsdocdt
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'pmds_cur'
            LET g_errparam.popup = TRUE
            LET g_errparam.coll_vals[1] = l_pmds.pmds041
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         LET g_site = l_pmds1.pmdssite
         LET g_argv[1] = '7'
         LET g_prog = 'apmt580'
         
         UPDATE pmds_t
            SET pmds041 = '',
                pmds050 = 'N'
          WHERE pmdsent = g_enterprise
            AND pmdsdocno = l_pmds1.pmdsdocno
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'UPDATE pmds_t'
            LET g_errparam.popup = TRUE
            LET g_errparam.coll_vals[1] = l_pmds.pmds041
            LET g_errparam.coll_vals[3] = l_pmds1.pmdsdocno
            CALL cl_err()
            LET l_success = FALSE
            CONTINUE FOREACH
         END IF
         
         IF NOT s_apmt520_unposted_chk(l_pmds1.pmdsdocno) THEN
            LET l_success = FALSE
            CONTINUE FOREACH
         END IF
         IF NOT s_apmt520_unposted_upd(l_pmds1.pmdsdocno) THEN
            LET l_success = FALSE
            CONTINUE FOREACH
         END IF
         IF NOT s_apmt520_unconf_chk(l_pmds1.pmdsdocno) THEN
            LET l_success = FALSE
            CONTINUE FOREACH
         END IF
         IF NOT s_apmt520_unconf_upd(l_pmds1.pmdsdocno) THEN
            LET l_success = FALSE
            CONTINUE FOREACH
         END IF
         IF cl_get_para(g_enterprise,g_site,'E-BAS-0018') = 'N' THEN
            #多角單據流水號保持一致='N'時，做作廢處理
            IF NOT s_apmt520_invalid_chk(l_pmds1.pmdsdocno) THEN
               LET l_success = FALSE
               CONTINUE FOREACH
            END IF
            IF NOT s_apmt520_invalid_upd(l_pmds1.pmdsdocno) THEN
               LET l_success = FALSE
               CONTINUE FOREACH
            END IF
         ELSE
            IF NOT aicp810_del_pmds(l_pmds1.pmdsdocno,l_pmds1.pmdsdocdt) THEN
               LET l_success = FALSE
               CONTINUE FOREACH
            END IF
         END IF
         
         INITIALIZE l_pmds1.* TO NULL
      END FOREACH

      INITIALIZE l_xmdk.* TO NULL
      FOREACH aicp810_process_xmdk_cur USING l_pmds.pmds041 INTO l_xmdk.xmdksite,l_xmdk.xmdkdocno,l_xmdk.xmdkdocdt
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'xmdk_cur'
            LET g_errparam.popup = TRUE
            LET g_errparam.coll_vals[1] = l_pmds.pmds041
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         LET g_site = l_xmdk.xmdksite
         LET g_prog = 'axmt600'
         
         UPDATE xmdk_t
            SET xmdk035 = '',
                xmdk083 = 'N'
          WHERE xmdkent = g_enterprise
            AND xmdkdocno = l_xmdk.xmdkdocno
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'UPDATE xmdk_t'
            LET g_errparam.popup = TRUE
            LET g_errparam.coll_vals[1] = l_pmds.pmds041
            LET g_errparam.coll_vals[2] = l_xmdk.xmdkdocno
            CALL cl_err()
            LET l_success = FALSE
            CONTINUE FOREACH
         END IF
         
         IF NOT s_axmt600_unpost_chk(l_xmdk.xmdkdocno) THEN
            LET l_success = FALSE
            CONTINUE FOREACH
         END IF
         IF NOT s_axmt600_unpost_upd(l_xmdk.xmdkdocno) THEN
            LET l_success = FALSE
            CONTINUE FOREACH
         END IF
         IF NOT s_axmt600_unconf_chk(l_xmdk.xmdkdocno) THEN
            LET l_success = FALSE
            CONTINUE FOREACH
         END IF
         IF NOT s_axmt600_unconf_upd(l_xmdk.xmdkdocno) THEN
            LET l_success = FALSE
            CONTINUE FOREACH
         END IF
         IF cl_get_para(g_enterprise,g_site,'E-BAS-0018') = 'N' THEN
            #多角單據流水號保持一致='N'時，做作廢處理
            IF NOT s_axmt600_invalid_chk(l_xmdk.xmdkdocno) THEN
               LET l_success = FALSE
               CONTINUE FOREACH
            END IF
            IF NOT s_axmt600_invalid_upd(l_xmdk.xmdkdocno) THEN
               LET l_success = FALSE
               CONTINUE FOREACH
            END IF
         ELSE
            IF NOT aicp810_del_xmdk(l_xmdk.xmdkdocno,l_xmdk.xmdkdocdt) THEN
               LET l_success = FALSE
               CONTINUE FOREACH
            END IF
         END IF
                  
         INITIALIZE l_xmdk.* TO NULL
      END FOREACH
      
      IF l_success THEN
         CALL s_aic_carry_deletetrino(l_pmds.pmds041,'6') RETURNING l_success
      END IF
      
      IF g_bgjob = 'N' THEN
         IF l_success THEN
            CALL s_transaction_end('Y',0)
            CALL aicp810_success(l_pmds.pmdsdocno,l_pmds.pmdsdocdt,l_pmds.pmds007,l_pmds.pmds002,l_pmds.pmds003)
         ELSE
            CALL s_transaction_end('N',0)
            CALL aicp810_fail(l_pmds.pmdsdocno,l_pmds.pmdsdocdt,l_pmds.pmds007,l_pmds.pmds002,l_pmds.pmds003,l_pmds.pmds041)
         END IF
      ELSE
         IF l_success THEN
            CALL s_transaction_end('Y',0)
            CALL cl_ask_pressanykey("aic-00178")    #多角流程拋轉還原成功！
         ELSE
            CALL s_transaction_end('N',0)
            CALL cl_ask_pressanykey("aic-00179")    #多角流程拋轉還原失敗！
         END IF
      END IF

      INITIALIZE l_pmds.* TO NULL
   END FOREACH
   
   LET g_prog = l_g_prog
   LET g_site = l_g_site
   LET g_argv[1] = l_g_argv
   
   CALL cl_err_collect_init()
   CALL cl_err_collect_show()

   IF g_bgjob = 'N' THEN
      CALL cl_ask_pressanykey("std-00012")
   END IF

END FUNCTION

################################################################################
# Descriptions...: 將產生失敗之單據及原因顯示於執行失敗頁籤
# Memo...........:
# Usage..........: CALL aicp810_fail(p_pmdsdocno,p_pmdsdocdt,p_pmds007,p_pmds002,p_pmds003,p_pmds041)
# Input parameter: no
# Return code....: no
# Date & Author..: 140610 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp810_fail(p_pmdsdocno,p_pmdsdocdt,p_pmds007,p_pmds002,p_pmds003,p_pmds041)
DEFINE p_pmdsdocno  LIKE pmds_t.pmdsdocno 
DEFINE p_pmdsdocdt  LIKE pmds_t.pmdsdocdt
DEFINE p_pmds007    LIKE pmds_t.pmds007
DEFINE p_pmds002    LIKE pmds_t.pmds002
DEFINE p_pmds003    LIKE pmds_t.pmds003
DEFINE p_pmds041    LIKE pmds_t.pmds041
DEFINE l_errcode    LIKE gzze_t.gzze001
DEFINE l_i          LIKE type_t.num5
   
   IF g_bgjob = 'N' THEN
      IF cl_null(g_fail_cnt) THEN
         LET g_fail_cnt = 0
      END IF
      
      FOR l_i = g_fail_cnt+1 TO g_errcollect.getLength()
         LET g_detail4_d[l_i].pmdsdocno2 = p_pmdsdocno
         LET g_detail4_d[l_i].pmdsdocdt2 = p_pmdsdocdt
         LET g_detail4_d[l_i].pmds0072   = p_pmds007
         LET g_detail4_d[l_i].pmds0022   = p_pmds002  
         LET g_detail4_d[l_i].pmds0032   = p_pmds003  
         LET g_detail4_d[l_i].pmds0412   = p_pmds041  
      
         #錯誤訊息
#         LET l_errcode = g_errcollect[l_i].code
#         LET g_detail4_d[l_i].reason = cl_getmsg(l_errcode,g_dlang)
         LET g_detail4_d[l_i].reason = g_errcollect[l_i].message
         
         #說明
         CALL s_desc_get_trading_partner_abbr_desc(g_detail4_d[l_i].pmds0072)
              RETURNING g_detail4_d[l_i].pmds0072_desc
         CALL s_desc_get_person_desc(g_detail4_d[l_i].pmds0022)
              RETURNING g_detail4_d[l_i].pmds0022_desc
         CALL s_desc_get_department_desc(g_detail4_d[l_i].pmds0032)
              RETURNING g_detail4_d[l_i].pmds0032_desc
      END FOR
   END IF

END FUNCTION

################################################################################
# Descriptions...: 將順利產生成功之單據資料顯示於執行成功頁籤
# Memo...........:
# Usage..........: CALL aicp810_success(p_pmdsdocno,p_pmdsdocdt,p_pmds007,p_pmds002,p_pmds003)
# Input parameter: 
# Return code....: 
# Date & Author..: 140610 By whiteny
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp810_success(p_pmdsdocno,p_pmdsdocdt,p_pmds007,p_pmds002,p_pmds003)
DEFINE p_pmdsdocno LIKE pmds_t.pmdsdocno 
DEFINE p_pmdsdocdt LIKE pmds_t.pmdsdocdt
DEFINE p_pmds007   LIKE pmds_t.pmds007
DEFINE p_pmds002   LIKE pmds_t.pmds002
DEFINE p_pmds003   LIKE pmds_t.pmds003

   IF cl_null(g_success_cnt) THEN
      LET g_success_cnt = 1
   END IF

   LET g_detail3_d[g_success_cnt].pmdsdocno1 = p_pmdsdocno
   LET g_detail3_d[g_success_cnt].pmdsdocdt1 = p_pmdsdocdt
   LET g_detail3_d[g_success_cnt].pmds0071   = p_pmds007
   LET g_detail3_d[g_success_cnt].pmds0021   = p_pmds002  
   LET g_detail3_d[g_success_cnt].pmds0031   = p_pmds003  
   
   #說明
   CALL s_desc_get_trading_partner_abbr_desc(g_detail3_d[g_success_cnt].pmds0071)
        RETURNING g_detail3_d[g_success_cnt].pmds0071_desc
   CALL s_desc_get_person_desc(g_detail3_d[g_success_cnt].pmds0021)
        RETURNING g_detail3_d[g_success_cnt].pmds0021_desc
   CALL s_desc_get_department_desc(g_detail3_d[g_success_cnt].pmds0031)
        RETURNING g_detail3_d[g_success_cnt].pmds0031_desc
   
   LET g_success_cnt = g_success_cnt +  1

END FUNCTION

################################################################################
# Descriptions...: 刪除銷退單據
# Memo...........:
# Usage..........: CALL aicp810_del_xmdk(p_xmdkdocno,p_xmdkdocdt)
#                  RETURNING r_success
# Input parameter: p_xmdkdocno,p_xmdkdocdt
# Return code....: r_success
# Date & Author..: 141110 By whitney
# Modify.........: 150917-00001#4 151123 earl 加入製造批序號拋轉還原
################################################################################
PRIVATE FUNCTION aicp810_del_xmdk(p_xmdkdocno,p_xmdkdocdt)
DEFINE p_xmdkdocno  LIKE xmdk_t.xmdkdocno
DEFINE p_xmdkdocdt  LIKE xmdk_t.xmdkdocdt
DEFINE r_success    LIKE type_t.num5

   LET r_success = TRUE

   DELETE FROM xmdk_t WHERE xmdkent = g_enterprise AND xmdkdocno = p_xmdkdocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "delete xmdk_t"
      LET g_errparam.coll_vals[2] = p_xmdkdocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   DELETE FROM xmdl_t WHERE xmdlent = g_enterprise AND xmdldocno = p_xmdkdocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "delete xmdl_t"
      LET g_errparam.coll_vals[2] = p_xmdkdocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   DELETE FROM xmdm_t WHERE xmdment = g_enterprise AND xmdmdocno = p_xmdkdocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "delete xmdm_t"
      LET g_errparam.coll_vals[2] = p_xmdkdocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   #150917-00001#4 151123 earl s
   #製造批序號
   DELETE FROM inao_t
    WHERE inaoent = g_enterprise
      AND inaodocno = p_xmdkdocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "delete inao_t"
      LET g_errparam.coll_vals[2] = p_xmdkdocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #150917-00001#4 151123 earl e

   #單號處理 
   IF NOT s_aooi200_del_docno(p_xmdkdocno,p_xmdkdocdt) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   #刪除備註 
   IF NOT s_aooi360_del('6','axmt600',p_xmdkdocno,'','','','','','','','','4') THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   #相關文件 
   CALL g_pk_array.clear()
   LET g_pk_array[1].values = p_xmdkdocno
   LET g_pk_array[1].column = 'xmdkdocno'
   CALL cl_doc_remove()

   RETURN r_success

END FUNCTION

################################################################################
# Descriptions...: 刪除倉退單據
# Memo...........:
# Usage..........: CALL aicp810_del_pmds(p_pmdsdocno,p_pmdsdocdt)
#                  RETURNING r_success
# Input parameter: p_pmdsodcno,p_pmdsdocdt
# Return code....: r_success
# Date & Author..: 141110 By whitney
# Modify.........: 150917-00001#4 151123 earl 加入製造批序號拋轉還原
################################################################################
PRIVATE FUNCTION aicp810_del_pmds(p_pmdsdocno,p_pmdsdocdt)
DEFINE p_pmdsdocno  LIKE pmds_t.pmdsdocno
DEFINE p_pmdsdocdt  LIKE pmds_t.pmdsdocdt
DEFINE r_success    LIKE type_t.num5

   LET r_success = TRUE

   DELETE FROM pmds_t WHERE pmdsent = g_enterprise AND pmdsdocno = p_pmdsdocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "delete pmds_t"
      LET g_errparam.coll_vals[3] = p_pmdsdocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   DELETE FROM pmdt_t WHERE pmdtent = g_enterprise AND pmdtdocno = p_pmdsdocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "delete pmdt_t"
      LET g_errparam.coll_vals[3] = p_pmdsdocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   DELETE FROM pmdu_t WHERE pmduent = g_enterprise AND pmdudocno = p_pmdsdocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "delete pmdu_t"
      LET g_errparam.coll_vals[3] = p_pmdsdocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #150917-00001#4 151123 earl s
   #製造批序號
   DELETE FROM inao_t
    WHERE inaoent = g_enterprise
      AND inaodocno = p_pmdsdocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "delete inao_t"
      LET g_errparam.coll_vals[3] = p_pmdsdocno
      LET g_errparam.popup = TRUE
      
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #150917-00001#4 151123 earl e
   
   DELETE FROM pmdv_t WHERE pmdvent = g_enterprise AND pmdvdocno = p_pmdsdocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "delete pmdv_t"
      LET g_errparam.coll_vals[3] = p_pmdsdocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   #單號處理 
   IF NOT s_aooi200_del_docno(p_pmdsdocno,p_pmdsdocdt) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   #刪除備註 
   IF NOT s_aooi360_del('6','apmt580',p_pmdsdocno,'','','','','','','','','4') THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   #相關文件 
   CALL g_pk_array.clear()
   LET g_pk_array[1].values = p_pmdsdocno
   LET g_pk_array[1].column = 'pmdsdocno'
   CALL cl_doc_remove()

   RETURN r_success

END FUNCTION

#Create Temp Table
PRIVATE FUNCTION aicp810_create_temp_table()
   
   DROP TABLE aicp810_tmp;
   CREATE TEMP TABLE aicp810_tmp( 
       sel            LIKE type_t.chr1,
       pmdsent        LIKE pmds_t.pmdsent, 
       pmdsdocno      LIKE pmds_t.pmdsdocno, 
       pmdsdocdt      LIKE pmds_t.pmdsdocdt,
       pmds007        LIKE pmds_t.pmds007,
       pmds002        LIKE pmds_t.pmds002,
       pmds003        LIKE pmds_t.pmds003,
       pmdsownid      LIKE pmds_t.pmdsownid,
       pmdscrtid      LIKE pmds_t.pmdscrtid,
       pmds041        LIKE pmds_t.pmds041,
       pmdt085        LIKE pmdt_t.pmdt085
       );
END FUNCTION

#單號過濾條件
PRIVATE FUNCTION aicp810_sel()
  #LET g_aicp810_sel = " pmdsent = pmdtent AND pmdssite = pmdtsite AND pmdsdocno = pmdtdocno ",                              #161231-00013#1 mark
   LET g_aicp810_sel = " pmdsent = pmdtent AND pmdssite = pmdtsite AND pmdsdocno = pmdtdocno ",cl_sql_add_filter("pmds_t"),  #161231-00013#1 add 
                       " AND pmdsent = '",g_enterprise,"' AND pmdssite = '",g_site,"'",
                       " AND pmds050 = 'Y' AND pmds000 = '7' AND pmds041 IS NOT NULL ",
                       " AND pmds014 IN ('2','3') "
                       
                       
END FUNCTION

#end add-point
 
{</section>}
 
