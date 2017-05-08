#該程式未解開Section, 採用最新樣板產出!
{<section id="aicp450.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2014-11-12 14:30:36), PR版次:0002(2017-01-11 18:02:49)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000055
#+ Filename...: aicp450
#+ Description: 代採買應收付拋轉作業
#+ Creator....: 04441(2014-11-10 16:18:55)
#+ Modifier...: 04441 -SD/PR- 08992
 
{</section>}
 
{<section id="aicp450.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#Memos
#161231-00013#1  2016/01/11 By 08992   增加azzi850 部門權限控管
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
    sel                LIKE type_t.chr1,
    pmds000            LIKE pmds_t.pmds000,
    pmdsdocno          LIKE pmds_t.pmdsdocno,
    pmdsdocdt          LIKE pmds_t.pmdsdocdt,
    pmds007            LIKE pmds_t.pmds007,
    pmds007_desc       LIKE type_t.chr80,
    pmds011            LIKE pmds_t.pmds011,
    pmds002            LIKE pmds_t.pmds002,
    pmds002_desc       LIKE type_t.chr80,
    pmds003            LIKE pmds_t.pmds003,
    pmds003_desc       LIKE type_t.chr80,
    pmds041            LIKE pmds_t.pmds041,
    pmdt085            LIKE pmdt_t.pmdt085,
    pmdsownid          LIKE pmds_t.pmdsownid,
    pmdsownid_desc     LIKE type_t.chr80,
    pmdscrtid          LIKE pmds_t.pmdscrtid,
    pmdscrtid_desc     LIKE type_t.chr80
                   END RECORD

TYPE type_g_detail2_d  RECORD
    pmdtseq            LIKE pmdt_t.pmdtseq,
    pmdndocno          LIKE pmdn_t.pmdndocno,
    pmdnseq            LIKE pmdn_t.pmdnseq,
    pmdn027            LIKE pmdn_t.pmdn027,
    pmdn001            LIKE pmdn_t.pmdn001,
    pmdn001_desc       LIKE type_t.chr80,
    pmdn001_desc_desc  LIKE type_t.chr80,
    pmdn007            LIKE pmdn_t.pmdn007,
    pmdn015            LIKE pmdn_t.pmdn015,
    pmdn046            LIKE pmdn_t.pmdn046,
    pmdn047            LIKE pmdn_t.pmdn047,
    pmdn014            LIKE pmdn_t.pmdn014
                   END RECORD

TYPE type_g_detail3_d  RECORD
    pmdsdocno1         LIKE pmds_t.pmdsdocno,
    pmdl0051           LIKE pmdl_t.pmdl005,
    pmdl0041           LIKE pmdl_t.pmdl004,
    pmdl0041_desc      LIKE type_t.chr80,
    pmdl0021           LIKE pmdl_t.pmdl002,
    pmdl0021_desc      LIKE type_t.chr80,
    pmdl0031           LIKE pmdl_t.pmdl003,
    pmdl0031_desc      LIKE type_t.chr80,
    pmdsownid1         LIKE pmds_t.pmdsownid,
    pmdsownid1_desc    LIKE type_t.chr80,
    pmdscrtid1         LIKE pmds_t.pmdscrtid,
    pmdscrtid1_desc    LIKE type_t.chr80,
    pmdl0521           LIKE pmdl_t.pmdl052,
    pmdl0521_desc      LIKE type_t.chr80,
    pmds0411           LIKE pmds_t.pmds041
                   END RECORD

TYPE type_g_detail4_d  RECORD
    pmdsdocno2         LIKE pmds_t.pmdsdocno,
    pmdl0052           LIKE pmdl_t.pmdl005,
    pmdl0042           LIKE pmdl_t.pmdl004,
    pmdl0042_desc      LIKE type_t.chr80,
    pmdl0022           LIKE pmdl_t.pmdl002,
    pmdl0022_desc      LIKE type_t.chr80,
    pmdl0032           LIKE pmdl_t.pmdl003,
    pmdl0032_desc      LIKE type_t.chr80,
    pmdsownid2         LIKE pmds_t.pmdsownid,
    pmdsownid2_desc    LIKE type_t.chr80,
    pmdscrtid2         LIKE pmds_t.pmdscrtid,
    pmdscrtid2_desc    LIKE type_t.chr80,
    pmdt0852           LIKE pmdt_t.pmdt085,
    pmdl0522           LIKE pmdl_t.pmdl052,
    pmdl0522_desc      LIKE type_t.chr80,
    reason             LIKE type_t.chr500
                      END RECORD

DEFINE g_detail2_d  DYNAMIC ARRAY OF type_g_detail2_d
DEFINE g_detail3_d  DYNAMIC ARRAY OF type_g_detail3_d
DEFINE g_detail4_d  DYNAMIC ARRAY OF type_g_detail4_d
DEFINE g_detail2_idx   LIKE type_t.num5
DEFINE g_detail3_idx   LIKE type_t.num5
DEFINE g_detail4_idx   LIKE type_t.num5
DEFINE g_detail2_cnt   LIKE type_t.num5
DEFINE g_detail3_cnt   LIKE type_t.num5
DEFINE g_detail4_cnt   LIKE type_t.num5

DEFINE tm  RECORD
    pmds000            LIKE pmds_t.pmds000,
    chk                LIKE type_t.chr1,
    date1              LIKE type_t.dat,
    date2              LIKE type_t.dat
                      END RECORD

DEFINE g_success_cnt     LIKE type_t.num5
DEFINE g_fail_cnt        LIKE type_t.num5

#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aicp450.main" >}
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
   IF NOT cl_null(g_argv[1]) THEN
      LET g_bgjob = 'Y'
   END IF
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aicp450 WITH FORM cl_ap_formpath("aic",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aicp450_init()   
 
      #進入選單 Menu (="N")
      CALL aicp450_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
 
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aicp450
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   DROP TABLE aicp450_tmp
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aicp450.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aicp450_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc_part('pmds000','2060','3,4,6,7')
   CALL cl_set_combo_scc('pmds011','2061')
   CALL cl_set_combo_scc('b_pmds000','2060')
   CALL cl_set_combo_scc('b_pmds011','2061')
   CALL cl_set_combo_scc('b_pmdl0051','2052')
   CALL cl_set_combo_scc('b_pmdl0052','2052')
   
   IF cl_null(g_bgjob) THEN
      LET g_bgjob = 'N'
   END IF
   
   CREATE TEMP TABLE aicp450_tmp( 
      sel        LIKE type_t.chr1,
      pmdsent    LIKE pmds_t.pmdsent,
      pmds000    LIKE pmds_t.pmds000,
      pmdsdocno  LIKE pmds_t.pmdsdocno,
      pmdsdocdt  LIKE pmds_t.pmdsdocdt,
      pmds007    LIKE pmds_t.pmds007,
      pmds011    LIKE pmds_t.pmds011,
      pmds002    LIKE pmds_t.pmds002,
      pmds003    LIKE pmds_t.pmds003,
      pmds041    LIKE pmds_t.pmds041,
      pmdt085    LIKE pmdt_t.pmdt085,
      pmdsownid  LIKE pmds_t.pmdsownid,
      pmdscrtid  LIKE pmds_t.pmdscrtid)
      
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aicp450.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aicp450_ui_dialog()
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
   LET g_wc = " 1=1"
   LET tm.pmds000 = ''
   LET tm.chk = 'Y'
   LET tm.date1 = ''
   LET tm.date2 = ''
   CALL cl_set_comp_required("date1",FALSE)
   
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aicp450_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT BY NAME g_wc ON pmdsdocno,pmdsdocdt,pmds007,pmds011,pmds002,pmds003,pmds041,pmdsownid,pmdscrtid

            BEFORE CONSTRUCT
            
            ON ACTION controlp INFIELD pmdsdocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = "('3','4','6','7')"
               CALL q_pmdsdocno()
               DISPLAY g_qryparam.return1 TO pmdsdocno
               NEXT FIELD pmdsdocno
               
            ON ACTION controlp INFIELD pmds007
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_pmaa001_3()
               DISPLAY g_qryparam.return1 TO pmds007
               NEXT FIELD pmds007
   
            ON ACTION controlp INFIELD pmds002
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()
               DISPLAY g_qryparam.return1 TO pmds002
               NEXT FIELD pmds002
               
            ON ACTION controlp INFIELD pmds003
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooeg001()
               DISPLAY g_qryparam.return1 TO pmds003
               NEXT FIELD pmds003
               
            ON ACTION controlp INFIELD pmdsownid
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()
               DISPLAY g_qryparam.return1 TO pmdsownid
               NEXT FIELD pmdsownid
   
            ON ACTION controlp INFIELD pmdscrtid
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()
               DISPLAY g_qryparam.return1 TO pmdscrtid
               NEXT FIELD pmdscrtid
               
         END CONSTRUCT
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT BY NAME tm.pmds000,tm.chk,tm.date1
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            AFTER FIELD chk
               #檢驗:若"入庫日期立帳"未勾選,則此欄不允許空白
               IF tm.chk = 'N' THEN
                  CALL cl_set_comp_required("date1",TRUE)
               ELSE
                  CALL cl_set_comp_required("date1",FALSE)
               END IF
            
         END INPUT
         
         INPUT BY NAME tm.date2
            ATTRIBUTE(WITHOUT DEFAULTS)
            
         END INPUT

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
               CALL aicp450_fetch()
               
            ON CHANGE b_sel
               UPDATE aicp450_tmp
                  SET sel = g_detail_d[l_ac].sel
                WHERE pmdsdocno = g_detail_d[l_ac].pmdsdocno
         END INPUT
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_detail2_d TO s_detail2.* ATTRIBUTE(COUNT=g_detail2_cnt)
            BEFORE DISPLAY
              
            BEFORE ROW
               LET g_detail2_idx = DIALOG.getCurrentRow("s_detail2")
              
         END DISPLAY

         DISPLAY ARRAY g_detail3_d TO s_detail3.* ATTRIBUTE(COUNT=g_detail3_cnt)
            BEFORE DISPLAY
              
            BEFORE ROW
               LET g_detail3_idx = DIALOG.getCurrentRow("s_detail3")
              
         END DISPLAY

         DISPLAY ARRAY g_detail4_d TO s_detail4.* ATTRIBUTE(COUNT=g_detail4_cnt)
            BEFORE DISPLAY
              
            BEFORE ROW
               LET g_detail4_idx = DIALOG.getCurrentRow("s_detail4")
              
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
            #end add-point
 
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            #add-point:ui_dialog段on action selall name="ui_dialog.selall.befroe"
            
            #end add-point            
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
               #add-point:ui_dialog段on action selall name="ui_dialog.for.onaction_selall"
            UPDATE aicp450_tmp 
               SET sel = 'Y'
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
            UPDATE aicp450_tmp 
               SET sel = 'N'
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
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  UPDATE aicp450_tmp 
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
                  UPDATE aicp450_tmp 
                     SET sel = 'N' 
                    WHERE pmdsdocno = g_detail_d[li_idx].pmdsdocno
               END IF
            END FOR
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL aicp450_filter()
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
            CALL aicp450_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL aicp450_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            IF tm.chk = 'N' AND cl_null(tm.date1) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code   = 'aic-00103'
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               NEXT FIELD date1
            END IF
            IF cl_null(tm.date2) THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.code   = 'aic-00104'
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               NEXT FIELD date2
            END IF
            LET l_cnt = ''
            SELECT COUNT(*) INTO l_cnt
              FROM aicp450_tmp
             WHERE sel = 'Y'
            IF cl_null(l_cnt) OR l_cnt = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = '-400'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               CONTINUE DIALOG
            ELSE
               CALL aicp450_process()
               CALL aicp450_query()
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
 
{<section id="aicp450.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aicp450_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   DELETE FROM aicp450_tmp
   
   IF cl_null(tm.pmds000) THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.code   = 'aic-00102'
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #1.apmt530/apmt532/apmt570/apmt571("單據性質"條件pmds000='3'收貨入庫單,'4'無採購收貨入庫單,'6'入庫單)或apmt580/apmt581("單據性質"條件pmds000='7'倉退單)
   #2.已過帳pmdsstus='S'
   #3."多角流程序號"不為空白pmds041 IS NOT NULL
   #4.單身"主帳套已請款數量"pmdt056=0(取單身第1筆即可)
   #5.入庫單單身"多角流程代碼"pmdt085於aici100 "流程類型"欄位(icaa003)='2' or '3' 
   #6.aici100 [流程定義]頁籤設定之第0站icab002='0'營運據點icab003=g_site 或 入庫單單身"採購多角性質"pmdt086='4'統購統付
   LET g_sql = "SELECT DISTINCT 'N',pmdsent,pmds000,pmdsdocno,pmdsdocdt,pmds007,pmds011,pmds002,pmds003,pmds041,pmdt085,pmdsownid,pmdscrtid ",
               "  FROM pmds_t,pmdt_t,icaa_t,icab_t ",
              #" WHERE pmdsent = '",g_enterprise,"' AND pmdssite = '",g_site,"' AND ",g_wc,                             #161231-00013#1 mark
               " WHERE pmdsent = '",g_enterprise,"' AND pmdssite = '",g_site,"' AND ",g_wc,cl_sql_add_filter("pmds_t"), #161231-00013#1 add   
               "   AND pmds000 IN ('3','4','6','7') AND pmdsstus = 'S' AND pmds041 IS NOT NULL ",
               "   AND pmdtent = pmdsent AND pmdtdocno = pmdsdocno AND pmdt056 = 0 ",
               "   AND icaaent = pmdtent AND icaa001 = pmdt085 AND icaa003 IN ('2','3') ",
               "   AND icabent = icaaent AND icab001 = icaa001 ",
               "   AND ((icab002 = '0' AND icab003 = '",g_site,"') OR pmdt086 = '4' ) "
   LET g_sql = "INSERT INTO aicp450_tmp(sel,pmdsent,pmds000,pmdsdocno,pmdsdocdt,pmds007,pmds011,pmds002,pmds003,pmds041,pmdt085,pmdsownid,pmdscrtid) ",g_sql
   PREPARE tmp_ins_pre FROM g_sql
   EXECUTE tmp_ins_pre

   LET g_wc_filter = " 1=1"
   #end add-point
        
   LET g_error_show = 1
   CALL aicp450_b_fill()
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
 
{<section id="aicp450.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aicp450_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   LET g_sql = "SELECT DISTINCT sel,pmds000,pmdsdocno,pmdsdocdt,pmds007,pmaal004,pmds011,pmds002,a.ooag011, ",
               "       pmds003,ooefl003,pmds041,pmdsownid,b.ooag011,pmdscrtid,c.ooag011 ",
               "  FROM aicp450_tmp ",
               "       LEFT OUTER JOIN pmaal_t ON pmaalent = pmdsent AND pmaal001 = pmds007 AND pmaal002 = '",g_dlang,"' ",
               "       LEFT OUTER JOIN ooag_t a ON a.ooagent  = pmdsent AND a.ooag001 = pmds002 ",
               "       LEFT OUTER JOIN ooefl_t ON ooeflent = pmdsent AND ooefl001 = pmds003 AND ooefl002 = '",g_dlang,"' ",
               "       LEFT OUTER JOIN ooag_t b ON b.ooagent  = pmdsent AND b.ooag001 = pmdsownid ",
               "       LEFT OUTER JOIN ooag_t c ON c.ooagent  = pmdsent AND c.ooag001 = pmdscrtid ",
               " WHERE pmdsent = ? AND ",g_wc_filter,
               " ORDER BY pmdsdocno,pmdsdocdt "

   #end add-point
 
   PREPARE aicp450_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aicp450_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   LET g_master_idx = 1
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
   g_detail_d[l_ac].sel,g_detail_d[l_ac].pmds000,g_detail_d[l_ac].pmdsdocno,
   g_detail_d[l_ac].pmdsdocdt,g_detail_d[l_ac].pmds007,g_detail_d[l_ac].pmds007_desc,
   g_detail_d[l_ac].pmds011,g_detail_d[l_ac].pmds002,g_detail_d[l_ac].pmds002_desc,
   g_detail_d[l_ac].pmds003,g_detail_d[l_ac].pmds003_desc,g_detail_d[l_ac].pmds041,
   g_detail_d[l_ac].pmdsownid,g_detail_d[l_ac].pmdsownid_desc,
   g_detail_d[l_ac].pmdscrtid,g_detail_d[l_ac].pmdscrtid_desc

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
      
      CALL aicp450_detail_show()      
 
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
   FREE aicp450_sel
   
   LET l_ac = 1
   CALL aicp450_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aicp450.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aicp450_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define name="fetch.define"
   DEFINE l_pmdt001  LIKE pmdt_t.pmdt001
   DEFINE l_pmdt002  LIKE pmdt_t.pmdt002
   
   
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後 name="fetch.after_fill"
   IF g_detail_d.getLength() = 0 THEN
      RETURN
   END IF

   CALL g_detail2_d.clear()
   LET l_ac = 1

   LET l_pmdt001 = ''
   LET l_pmdt002 = ''
   DECLARE pmdt_cur CURSOR FOR
      SELECT pmdtseq,pmdt001,pmdt002
        FROM pmdt_t
       WHERE pmdtent = g_enterprise
         AND pmdtdocno = g_detail_d[g_master_idx].pmdsdocno
   FOREACH pmdt_cur INTO g_detail2_d[l_ac].pmdtseq,l_pmdt001,l_pmdt002
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      CASE
         #'3'收貨入庫單,'4'無採購收貨入庫單
         WHEN g_detail_d[g_master_idx].pmds000='3' OR g_detail_d[g_master_idx].pmds000='4'
            LET g_detail2_d[l_ac].pmdndocno = l_pmdt001
            LET g_detail2_d[l_ac].pmdnseq   = l_pmdt002
         #'6'入庫單,'7'倉退單
         WHEN g_detail_d[g_master_idx].pmds000='6' OR g_detail_d[g_master_idx].pmds000='7'
            SELECT pmdt001,pmdt002
              INTO g_detail2_d[l_ac].pmdndocno,g_detail2_d[l_ac].pmdnseq
              FROM pmdt_t
             WHERE pmdtent = g_enterprise
               AND pmdtdocno = l_pmdt001
               AND pmdtseq = l_pmdt002
         OTHERWISE EXIT CASE
      END CASE
      
      SELECT pmdn027,pmdn001,imaal003,imaal004,pmdn007,pmdn015,pmdn046,pmdn047,pmdn014
        INTO g_detail2_d[l_ac].pmdn027,g_detail2_d[l_ac].pmdn001,g_detail2_d[l_ac].pmdn001_desc,
             g_detail2_d[l_ac].pmdn001_desc_desc,g_detail2_d[l_ac].pmdn007,g_detail2_d[l_ac].pmdn015,
             g_detail2_d[l_ac].pmdn046,g_detail2_d[l_ac].pmdn047,g_detail2_d[l_ac].pmdn014
        FROM pmdn_t LEFT OUTER JOIN imaal_t ON imaalent = pmdnent AND imaal001 = pmdn001 AND imaal002 = g_dlang
       WHERE pmdnent = g_enterprise
         AND pmdndocno = g_detail2_d[l_ac].pmdndocno
         AND pmdnseq = g_detail2_d[l_ac].pmdnseq

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
   
      LET l_pmdt001 = ''
      LET l_pmdt002 = ''
   END FOREACH
   
   CALL g_detail2_d.deleteElement(g_detail2_d.getLength())
   LET g_detail2_cnt = l_ac - 1 

   #end add-point 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="aicp450.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aicp450_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aicp450.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aicp450_filter()
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
   
   CONSTRUCT g_wc_filter ON pmdsdocno,pmdsdocdt,pmds007,pmds011,pmds002,pmds003,pmds041,pmdsownid,pmdscrtid
        FROM s_detail1[1].pmdsdocno,s_detail1[1].pmdsdocdt,s_detail1[1].pmds007,
             s_detail1[1].pmds011,s_detail1[1].pmds002,s_detail1[1].pmds003,
             s_detail1[1].pmds041,s_detail1[1].pmdsownid,s_detail1[1].pmdscrtid

      BEFORE CONSTRUCT
      
      ON ACTION controlp INFIELD pmdsdocno
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         LET g_qryparam.arg1 = "('3','4','6','7')"
         CALL q_pmdsdocno()
         DISPLAY g_qryparam.return1 TO pmdsdocno
         NEXT FIELD pmdsdocno
         
      ON ACTION controlp INFIELD pmds007
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_pmaa001_3()
         DISPLAY g_qryparam.return1 TO pmds007
         NEXT FIELD pmds007

      ON ACTION controlp INFIELD pmds002
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_ooag001()
         DISPLAY g_qryparam.return1 TO pmds002
         NEXT FIELD pmds002
         
      ON ACTION controlp INFIELD pmds003
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_ooeg001()
         DISPLAY g_qryparam.return1 TO pmds003
         NEXT FIELD pmds003
         
      ON ACTION controlp INFIELD pmdsownid
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_ooag001()
         DISPLAY g_qryparam.return1 TO pmdsownid
         NEXT FIELD pmdsownid

      ON ACTION controlp INFIELD pmdscrtid
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_ooag001()
         DISPLAY g_qryparam.return1 TO pmdscrtid
         NEXT FIELD pmdscrtid
         
   END CONSTRUCT
   #end add-point    
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   
   CALL aicp450_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="aicp450.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aicp450_filter_parser(ps_field)
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
 
{<section id="aicp450.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aicp450_filter_show(ps_field,ps_object)
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
   LET ls_condition = aicp450_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aicp450.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 可將來源據點之多角入庫單產生各站之應收付
# Memo...........:
# Usage..........: CALL aicp450_process()
# Input parameter: no
# Return code....: no
# Date & Author..: 141112 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp450_process()
DEFINE ls_js          STRING
DEFINE lc_param       type_parameter
DEFINE l_success      LIKE type_t.num5
DEFINE l_pmds  RECORD
    pmds000    LIKE pmds_t.pmds000,
    pmdsdocno  LIKE pmds_t.pmdsdocno,
    pmdsdocdt  LIKE pmds_t.pmdsdocdt,
    pmds007    LIKE pmds_t.pmds007,
    pmds011    LIKE pmds_t.pmds011,
    pmds002    LIKE pmds_t.pmds002,
    pmds003    LIKE pmds_t.pmds003,
    pmds041    LIKE pmds_t.pmds041,
    pmdt085    LIKE pmdt_t.pmdt085,
    pmdsownid  LIKE pmds_t.pmdsownid,
    pmdscrtid  LIKE pmds_t.pmdscrtid
           END RECORD
DEFINE l_success1     LIKE type_t.num5
DEFINE l_trino        LIKE pmdl_t.pmdl031
DEFINE l_date         LIKE type_t.dat        #應收付帳款日期
DEFINE l_pmdsdocno    LIKE pmds_t.pmdsdocno  #入庫單
DEFINE l_pmdsdocdt    LIKE pmds_t.pmdsdocdt  #入庫單據日期
DEFINE l_xmdkdocno    LIKE xmdk_t.xmdkdocno  #出貨單
DEFINE l_xmdkdocdt    LIKE xmdk_t.xmdkdocdt  #出貨單據日期
DEFINE l_icaa012      LIKE icaa_t.icaa012    #多角應收付開立方式
DEFINE l_icab002      LIKE icab_t.icab002    #站別
DEFINE l_icab003      LIKE icab_t.icab003    #營運據點
DEFINE l_icae  RECORD
    icae003    LIKE icae_t.icae003,          #應收單別
    icae004    LIKE icae_t.icae004,          #應付單別
    icae016    LIKE icae_t.icae016,          #帳務中心
    icae018    LIKE icae_t.icae018,          #帳款類別
    icae019    LIKE icae_t.icae019           #發票開立方式
           END RECORD

   CALL util.JSON.parse(ls_js,lc_param)

   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
   END IF

   CALL cl_err_collect_init()
   CALL s_azzi902_get_gzzd('aicp450',"lbl_pmds041") RETURNING g_coll_title[1],g_coll_title[1]  #多角序號
   CALL g_detail3_d.clear()
   CALL g_detail4_d.clear()

   LET g_success_cnt = 1
   LET g_fail_cnt = 0

   #有選擇的"交易序號"
   LET g_sql = " SELECT pmds000,pmdsdocno,pmdsdocdt,pmds007,pmds011, ",
               "        pmds002,pmds003,pmds041,pmdt085,pmdsownid,pmdscrtid  ",
               "   FROM aicp450_tmp ",
               "  WHERE sel = 'Y' "
   PREPARE aicp450_process_pre FROM g_sql
   DECLARE aicp450_process_cur CURSOR WITH HOLD FOR aicp450_process_pre

   #依入庫單單頭之"多角流程序號",取出各站符合"多角流程序號"之多角入庫單
   LET g_sql = " SELECT pmdsdocno,pmdsdocdt ",
               "   FROM pmds_t ",
               "  WHERE pmds041 = ? "
   PREPARE aicp450_process_pmds_pre FROM g_sql
   DECLARE aicp450_process_pmds_cur CURSOR WITH HOLD FOR aicp450_process_pmds_pre

   #依入庫單單頭之"多角流程序號",取出各站符合"多角流程序號"之多角出貨單
   LET g_sql = " SELECT xmdkdocno,xmdkdocdt ",
               "   FROM xmdk_t ",
               "  WHERE xmdk035 = ? "
   PREPARE aicp450_process_xmdk_pre FROM g_sql
   DECLARE aicp450_process_xmdk_cur CURSOR WITH HOLD FOR aicp450_process_xmdk_pre

   #"多角流程代碼"於aici100 "多角應收/應付開立方式"欄位
   LET g_sql = " SELECT icaa012 ",
               "   FROM icaa_t ",
               "  WHERE icaaent = '",g_enterprise,"' ",
               "    AND icaa001 = ? "
   PREPARE aicp450_process_icaa012 FROM g_sql

   #取出符合入庫單單身"多角流程代碼"之[T:多角貿易營運據點檔]及[T:多角流桯代碼設定檔]
   LET g_sql = " SELECT icab002,icab003 ",
               "   FROM icab_t ",
               "  WHERE icabent = '",g_enterprise,"' ",
               "    AND icab001 = ? "
   PREPARE aicp450_process_icab_pre FROM g_sql
   DECLARE aicp450_process_icab_cur CURSOR WITH HOLD FOR aicp450_process_icab_pre

#  2.5 應付帳款之"帳務中心"、"發票開立方式"、"帳款類別"
#      來源為aici100 [財務資訊]頁籤"帳務中心"、"發票開立方式"、"帳款類別"欄位且站別為下一站
#  2.6 應收帳款之"帳務中心"、"發票開立方式"、"帳款類別"
#      來源為aici100 [財務資訊]頁籤"帳務中心"、"發票開立方式"、"帳款類別"欄位且站別為當站
   LET g_sql = " SELECT icae003,icae004,icae016,icae018,icae019 ",
               "   FROM icae_t ",
               "  WHERE icaeent = '",g_enterprise,"' ",
               "    AND icae001 = ? ",
               "    AND icae002 = ? "
   PREPARE aicp450_process_icae FROM g_sql

   INITIALIZE l_pmds.* TO NULL
   FOREACH aicp450_process_cur INTO l_pmds.pmds000,l_pmds.pmdsdocno,l_pmds.pmdsdocdt,l_pmds.pmds007,l_pmds.pmds011,
                                    l_pmds.pmds002,l_pmds.pmds003,l_pmds.pmds041,l_pmds.pmdt085,l_pmds.pmdsownid,l_pmds.pmdscrtid
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'process_cur'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      #先取得錯誤訊息的長度，大於此長度的表示是這張單子的錯誤訊息
      LET g_fail_cnt = g_errcollect.getLength()
      LET l_success = TRUE
      CALL s_transaction_begin()

      #呼叫多角序號元件產生多角序號帶入至各站多角應付憑單"交易序號"(apca047)及應收憑單"交易序號"(xrca047)
      CALL s_aic_carry_gettrino(l_pmds.pmdt085,'5',g_today,g_site)
           RETURNING l_success1,l_trino
      IF NOT l_success1 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'amm-00001'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET l_success = FALSE
         CALL s_transaction_end('N',0)
         #失敗記錄
#         CALL aicp450_fail(p_pmdsdocno,p_pmdl005,p_pmdl004,p_pmdl002,p_pmdl003,p_pmdsownid,p_pmdscrtid,p_pmdt085,p_pmdl052)
         CONTINUE FOREACH
      END IF

      #若多角應收付開立方式=1.依多角流程序號,則依入庫單/出貨單號一對一產生應付/應收帳款;
      #=2.依多角流程代碼+客戶/廠商,則將此次選擇之多角入庫單,將相同多角流程代碼之多張入庫單/出貨單號彙總產生一張應付/應收帳款
      LET l_icaa012 = ''
      EXECUTE aicp450_process_icaa012 USING l_pmds.pmds041 INTO l_icaa012
      
      #將各站之多角入庫單依aapp130邏輯產生多角應付帳款
      LET l_pmdsdocno = ''
      LET l_pmdsdocdt = ''
      OPEN aicp450_process_pmds_cur USING l_pmds.pmds041
      FOREACH aicp450_process_pmds_cur INTO l_pmdsdocno,l_pmdsdocdt
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_success = FALSE
            EXIT FOREACH
         END IF
         
         CALL aicp450_get_date(l_icaa012,l_pmdsdocdt) RETURNING l_date
         
      END FOREACH

      #將各站之多角出貨單依axrp130邏輯產生多角應收帳款
      LET l_xmdkdocno = ''
      LET l_xmdkdocdt = ''
      OPEN aicp450_process_xmdk_cur USING l_pmds.pmds041
      FOREACH aicp450_process_xmdk_cur INTO l_xmdkdocno,l_xmdkdocdt
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_success = FALSE
            EXIT FOREACH
         END IF
         
         CALL aicp450_get_date(l_icaa012,l_xmdkdocdt) RETURNING l_date
         
      END FOREACH

      IF l_success THEN
         CALL s_transaction_end('Y',0)
#         CALL aicp450_success(p_pmdsdocno,p_pmdl005,p_pmdl004,p_pmdl002,p_pmdl003,p_pmdsownid,p_pmdscrtid,p_pmdl052,p_pmds041)
      ELSE
         CALL s_transaction_end('N',0)
#         CALL aicp450_fail(p_pmdsdocno,p_pmdl005,p_pmdl004,p_pmdl002,p_pmdl003,p_pmdsownid,p_pmdscrtid,p_pmdt085,p_pmdl052)
      END IF
      
      INITIALIZE l_pmds.* TO NULL
   END FOREACH
   
   CALL cl_err_collect_show()

   IF g_bgjob = 'N' THEN
      CALL cl_ask_pressanykey("std-00012")
   END IF

END FUNCTION

################################################################################
# Descriptions...: 將順利產生成功之單據資料顯示於執行成功頁籤
# Memo...........:
# Usage..........: CALL aicp450_success(p_pmdsdocno,p_pmdl005,p_pmdl004,p_pmdl002,p_pmdl003,p_pmdsownid,p_pmdscrtid,p_pmdl052,p_pmds041)
# Input parameter: 
# Return code....: 
# Date & Author..: 141112 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp450_success(p_pmdsdocno,p_pmdl005,p_pmdl004,p_pmdl002,p_pmdl003,p_pmdsownid,p_pmdscrtid,p_pmdl052,p_pmds041)
DEFINE p_pmdsdocno         LIKE pmds_t.pmdsdocno
DEFINE p_pmdl005           LIKE pmdl_t.pmdl005
DEFINE p_pmdl004           LIKE pmdl_t.pmdl004
DEFINE p_pmdl002           LIKE pmdl_t.pmdl002
DEFINE p_pmdl003           LIKE pmdl_t.pmdl003
DEFINE p_pmdsownid         LIKE pmds_t.pmdsownid
DEFINE p_pmdscrtid         LIKE pmds_t.pmdscrtid
DEFINE p_pmdl052           LIKE pmdl_t.pmdl052
DEFINE p_pmds041           LIKE pmds_t.pmds041

   IF cl_null(g_success_cnt) THEN
      LET g_success_cnt = 1
   END IF

   LET g_detail3_d[g_success_cnt].pmdsdocno1 = p_pmdsdocno
   LET g_detail3_d[g_success_cnt].pmdl0051   = p_pmdl005  
   LET g_detail3_d[g_success_cnt].pmdl0041   = p_pmdl004  
   LET g_detail3_d[g_success_cnt].pmdl0021   = p_pmdl002  
   LET g_detail3_d[g_success_cnt].pmdl0031   = p_pmdl003  
   LET g_detail3_d[g_success_cnt].pmdsownid1 = p_pmdsownid
   LET g_detail3_d[g_success_cnt].pmdscrtid1 = p_pmdscrtid
   LET g_detail3_d[g_success_cnt].pmdl0521   = p_pmdl052  
   LET g_detail3_d[g_success_cnt].pmds0411   = p_pmds041  
   
   #說明
   CALL s_desc_get_trading_partner_abbr_desc(g_detail3_d[g_success_cnt].pmdl0041)
        RETURNING g_detail3_d[g_success_cnt].pmdl0041_desc
   CALL s_desc_get_person_desc(g_detail3_d[g_success_cnt].pmdl0021)
        RETURNING g_detail3_d[g_success_cnt].pmdl0021_desc
   CALL s_desc_get_department_desc(g_detail3_d[g_success_cnt].pmdl0031)
        RETURNING g_detail3_d[g_success_cnt].pmdl0031_desc
   CALL s_desc_get_person_desc(g_detail3_d[g_success_cnt].pmdsownid1)
        RETURNING g_detail3_d[g_success_cnt].pmdsownid1_desc
   CALL s_desc_get_person_desc(g_detail3_d[g_success_cnt].pmdscrtid1)
        RETURNING g_detail3_d[g_success_cnt].pmdscrtid1_desc
   CALL s_desc_get_trading_partner_abbr_desc(g_detail3_d[g_success_cnt].pmdl0521)
        RETURNING g_detail3_d[g_success_cnt].pmdl0521_desc
   
   LET g_success_cnt = g_success_cnt +  1

END FUNCTION

################################################################################
# Descriptions...: 將產生失敗之單據及原因顯示於執行失敗頁籤
# Memo...........:
# Usage..........: CALL aicp450_fail(p_pmdsdocno,p_pmdl005,p_pmdl004,p_pmdl002,p_pmdl003,p_pmdsownid,p_pmdscrtid,p_pmdt085,p_pmdl052)
# Input parameter: 
# Return code....: 
# Date & Author..: 141112 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp450_fail(p_pmdsdocno,p_pmdl005,p_pmdl004,p_pmdl002,p_pmdl003,p_pmdsownid,p_pmdscrtid,p_pmdt085,p_pmdl052)
DEFINE p_pmdsdocno         LIKE pmds_t.pmdsdocno
DEFINE p_pmdl005           LIKE pmdl_t.pmdl005
DEFINE p_pmdl004           LIKE pmdl_t.pmdl004
DEFINE p_pmdl002           LIKE pmdl_t.pmdl002
DEFINE p_pmdl003           LIKE pmdl_t.pmdl003
DEFINE p_pmdsownid         LIKE pmds_t.pmdsownid
DEFINE p_pmdscrtid         LIKE pmds_t.pmdscrtid
DEFINE p_pmdt085           LIKE pmdt_t.pmdt085
DEFINE p_pmdl052           LIKE pmdl_t.pmdl052
DEFINE l_errcode         LIKE gzze_t.gzze001
DEFINE l_i               LIKE type_t.num5

   IF cl_null(g_fail_cnt) THEN
      LET g_fail_cnt = 0
   END IF

   FOR l_i = g_fail_cnt+1 TO g_errcollect.getLength()
       LET g_detail4_d[l_i].pmdsdocno2 = p_pmdsdocno
       LET g_detail4_d[l_i].pmdl0052   = p_pmdl005  
       LET g_detail4_d[l_i].pmdl0042   = p_pmdl004  
       LET g_detail4_d[l_i].pmdl0022   = p_pmdl002  
       LET g_detail4_d[l_i].pmdl0032   = p_pmdl003  
       LET g_detail4_d[l_i].pmdsownid2 = p_pmdsownid
       LET g_detail4_d[l_i].pmdscrtid2 = p_pmdscrtid
       LET g_detail4_d[l_i].pmdt0852   = p_pmdt085  
       LET g_detail4_d[l_i].pmdl0522   = p_pmdl052  
      
      #錯誤訊息
#      LET l_errcode = g_errcollect[l_i].code
#      LET g_detail4_d[l_i].reason = cl_getmsg(l_errcode,g_dlang)
      LET g_detail4_d[l_i].reason = g_errcollect[l_i].message
      
      #說明
      CALL s_desc_get_trading_partner_abbr_desc(g_detail4_d[l_i].pmdl0042)
           RETURNING g_detail4_d[l_i].pmdl0042_desc
      CALL s_desc_get_person_desc(g_detail4_d[l_i].pmdl0022)
           RETURNING g_detail4_d[l_i].pmdl0022_desc
      CALL s_desc_get_department_desc(g_detail4_d[l_i].pmdl0032)
           RETURNING g_detail4_d[l_i].pmdl0032_desc
      CALL s_desc_get_person_desc(g_detail4_d[l_i].pmdsownid2)
           RETURNING g_detail4_d[l_i].pmdsownid2_desc
      CALL s_desc_get_person_desc(g_detail4_d[l_i].pmdscrtid2)
           RETURNING g_detail4_d[l_i].pmdscrtid2_desc
      CALL s_desc_get_trading_partner_abbr_desc(g_detail4_d[l_i].pmdl0522)
           RETURNING g_detail4_d[l_i].pmdl0522_desc
   END FOR

END FUNCTION

################################################################################
# Descriptions...: 取得應收付帳款日期
# Memo...........:
# Usage..........: CALL aicp450_get_date(p_icaa012,p_docdt)
#                  RETURNING r_date
# Input parameter: p_icaa012 多角應收付開立方式
#                : p_docdt   單據日期
# Return code....: r_date    應收付帳款日期
# Date & Author..: 141112 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp450_get_date(p_icaa012,p_docdt)
DEFINE p_icaa012  LIKE icaa_t.icaa012
DEFINE p_docdt    LIKE type_t.dat
DEFINE r_date     LIKE type_t.dat

   LET r_date = ''

   #多角應收付開立方式
   CASE p_icaa012
      #依多角流程序號
      WHEN '1'
        #依入庫日期立帳
         IF tm.chk = 'Y' THEN
            #各站入庫/出貨單單據日期
            LET r_date = p_docdt
         ELSE
            #一對一產生帳款"帳款日期"
            LET r_date = tm.date1
         END IF
      #依多角流程代碼+客戶/廠商
      WHEN '2'
         #彙總產生帳款
         LET r_date = tm.date2
      OTHERWISE EXIT CASE
   END CASE

   RETURN r_date

END FUNCTION

#end add-point
 
{</section>}
 
