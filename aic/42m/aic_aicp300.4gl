#該程式已解開Section, 不再透過樣板產出!
{<section id="aicp300.description" >}
#+ Version..: T100-ERP-1.00.00(SD版次:1,PD版次:1) Build-000055
#+ 
#+ Filename...: aicp300
#+ Description: 多角貿易出貨通知單拋轉作業
#+ Creator....: 02295(2014/05/08)
#+ Modifier...: 02295(2014/05/08)
#+ Buildtype..: 應用 p02 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="aicp300.global" >}
#160810-00010#2  20160810  By 02040  多角流程為代採購和指定最終供應商，因起始站無訂單，故不需拋轉出通單
#161231-00013#1  2016/01/11 By 08992   增加azzi850 部門權限控管
#170213-00043#1  2017/02/15 By 08171   若拋轉成功後已無符合的資料則不提示[指定的資料無法查詢到，....] 
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc" 
 
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
DEFINE l_ac                 LIKE type_t.num5              
DEFINE l_ac_d               LIKE type_t.num5              #單身idx 
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_current_page       LIKE type_t.num5              #目前所在頁數
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_master_idx         LIKE type_t.num5
 
TYPE type_parameter RECORD
   #add-point:自定背景執行須傳遞的參數(Module Variable)
   
   #end add-point
        wc               STRING
                     END RECORD
 
TYPE type_g_detail_d RECORD
#add-point:自定義模組變數(Module Variable)
       sel            LIKE type_t.chr1,
       xmdgdocno      LIKE xmdg_t.xmdgdocno, 
       xmdgdocdt      LIKE xmdg_t.xmdgdocdt,
       xmdg028        LIKE xmdg_t.xmdg028,
       xmdg001        LIKE xmdg_t.xmdg001,
       xmdg005        LIKE xmdg_t.xmdg005,
       xmdg005_desc   LIKE type_t.chr80,
       xmdg002        LIKE xmdg_t.xmdg002,
       xmdg002_desc   LIKE type_t.chr80,
       xmdg003        LIKE xmdg_t.xmdg003,
       xmdg003_desc   LIKE type_t.chr80,
       xmdgownid      LIKE xmdg_t.xmdgownid,
       xmdgownid_desc LIKE type_t.chr80,
       xmdgcrtid      LIKE xmdg_t.xmdgcrtid,
       xmdgcrtid_desc LIKE type_t.chr80,
       xmdg034        LIKE xmdg_t.xmdg034,
       xmdg056        LIKE xmdg_t.xmdg056
       END RECORD

TYPE type_g_detail2_d RECORD
       xmdhseq        LIKE xmdh_t.xmdhseq, 
       xmdh001        LIKE xmdh_t.xmdh001,
       xmdh002        LIKE xmdh_t.xmdh002,
       xmdh003        LIKE xmdh_t.xmdh003,
       xmdh004        LIKE xmdh_t.xmdh004,
       xmdh005        LIKE xmdh_t.xmdh005,
       xmdh006        LIKE xmdh_t.xmdh006,
       xmdh006_desc   LIKE type_t.chr80,
       xmdh006_desc_1 LIKE type_t.chr80,
       xmdh007        LIKE xmdh_t.xmdh007,
       xmdh034        LIKE xmdh_t.xmdh034,
       xmdh015        LIKE xmdh_t.xmdh015,
       xmdh015_desc   LIKE type_t.chr80,
       xmdh016        LIKE xmdh_t.xmdh016,
       xmdh018        LIKE xmdh_t.xmdh018,
       xmdh018_desc   LIKE type_t.chr80,
       xmdh019        LIKE xmdh_t.xmdh019,
       xmdh008        LIKE xmdh_t.xmdh008,
       xmdh051        LIKE xmdh_t.xmdh051
       END RECORD
DEFINE g_detail2_d      DYNAMIC ARRAY OF type_g_detail2_d
DEFINE g_detail2_cnt    LIKE type_t.num5
DEFINE g_rec_b          LIKE type_t.num5

TYPE type_g_detail3_d RECORD
       xmdgdocno LIKE xmdg_t.xmdgdocno, 
       xmdgdocdt LIKE xmdg_t.xmdgdocdt,
       xmdg005 LIKE xmdh_t.xmdh005,
       xmdg005_desc LIKE type_t.chr80,
       xmdg002 LIKE xmdg_t.xmdg002,
       xmdg002_desc LIKE type_t.chr80,   #2015/03/20 by stellar add
       xmdg003 LIKE xmdg_t.xmdg003,
       xmdg003_desc LIKE type_t.chr80,   #2015/03/20 by stellar add
       xmdg055 LIKE xmdg_t.xmdg055
       END RECORD
DEFINE g_detail3_d      DYNAMIC ARRAY OF type_g_detail3_d
DEFINE g_detail3_cnt    LIKE type_t.num5   #2015/03/20 by stellar add

TYPE type_g_detail4_d RECORD
       xmdgdocno      LIKE xmdg_t.xmdgdocno,   #出通單號
       xmdgdocdt      LIKE xmdg_t.xmdgdocdt,   #出通日期
       xmdg005        LIKE xmdg_t.xmdg005,     #客戶編號
       xmdg005_desc   LIKE type_t.chr80,       #客戶名稱
       xmdg002        LIKE xmdg_t.xmdg002,     #業務人員
       xmdg002_desc   LIKE type_t.chr80,       #全名
       xmdg003        LIKE xmdg_t.xmdg003,     #業務部門
       xmdg003_desc   LIKE type_t.chr80,       #說明
       xmdg056        LIKE xmdg_t.xmdg056,     #多角流程代碼
       xmdgsite       LIKE xmdg_t.xmdgsite,    #營運據點
       xmdgsite_desc  LIKE type_t.chr80,       #營運據點
       reason         LIKE type_t.chr1000      #失敗原因
       END RECORD
DEFINE g_detail4_d      DYNAMIC ARRAY OF type_g_detail4_d
DEFINE g_detail4_cnt    LIKE type_t.num5   #2015/03/20 by stellar add

DEFINE g_success_cnt     LIKE type_t.num5
DEFINE g_fail_cnt        LIKE type_t.num5

DEFINE g_aicp300_sel    STRING

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num5              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明
 
#end add-point
 
{</section>}
 
{<section id="aicp300.main" >}
#+ 作業開始 
MAIN
   DEFINE ls_js  STRING
   #add-point:main段define
   
   #end add-point   
 
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("aic","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js
   CALL aicp300_create_temp_table()
   
   CALL aicp300_sel()

   IF NOT cl_null(g_argv[1]) THEN
      LET g_bgjob = 'Y'
   END IF
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call
      IF NOT cl_null(g_argv[1]) THEN
         LET g_wc = " xmdgdocno = '",g_argv[1],"' "
         CALL aicp300_query()
         UPDATE aicp300_tmp
            SET sel = 'Y'
         CALL aicp300_process()
      END IF
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aicp300 WITH FORM cl_ap_formpath("aic",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aicp300_init()   
 
      #進入選單 Menu (="N")
      CALL aicp300_ui_dialog() 
 
      #add-point:畫面關閉前
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aicp300
   END IF 
   
   #add-point:作業離開前
   DROP TABLE aicp300_tmp;
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aicp300.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aicp300_init()
   #add-point:init段define
   
   #end add-point   
 
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化
   CALL cl_set_combo_scc('xmdg001','2063')
   CALL cl_set_combo_scc('b_xmdg034','2064')
   CALL cl_set_combo_scc('b_xmdg001','2063')
   CALL cl_set_combo_scc('b_xmdh005','2055')
   
   LET g_errshow = 1
   IF cl_null(g_bgjob) THEN
      LET g_bgjob = 'N'
   END IF
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aicp300.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aicp300_ui_dialog()
   DEFINE li_idx   LIKE type_t.num5
   #add-point:ui_dialog段define
   DEFINE l_cnt    LIKE type_t.num5
   #end add-point 
 
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog 
   LET g_wc = "1=1"
   #end add-point
   
   WHILE TRUE
 
      CALL cl_dlg_query_bef_disp()  #相關查詢
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct

         CONSTRUCT BY NAME g_wc ON xmdgdocno,xmdgdocdt,xmdg028,xmdg001,xmdg005,xmdg002,xmdg003,xmdgownid,xmdgcrtid

            BEFORE CONSTRUCT
            
            ON ACTION controlp INFIELD xmdgdocno
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = g_aicp300_sel
               
               CALL q_xmdgdocno()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdgdocno  #顯示到畫面上
               NEXT FIELD xmdgdocno                     #返回原欄位            

            ON ACTION controlp INFIELD xmdg002
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdg002  #顯示到畫面上
               NEXT FIELD xmdg002                     #返回原欄位
               
            ON ACTION controlp INFIELD xmdg003
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooeg001()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdg003  #顯示到畫面上
               NEXT FIELD xmdg003                     #返回原欄位
   
            ON ACTION controlp INFIELD xmdg005
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = g_site
               CALL q_pmaa001_6()                     #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdg005  #顯示到畫面上
               NEXT FIELD xmdg005                     #返回原欄位
               
            ON ACTION controlp INFIELD xmdgownid
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdgownid  #顯示到畫面上
               NEXT FIELD xmdgownid                     #返回原欄位
   
            ON ACTION controlp INFIELD xmdgcrtid
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                          #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdgcrtid  #顯示到畫面上
               NEXT FIELD xmdgcrtid                     #返回原欄位
            
         END CONSTRUCT         
         #end add-point
         #add-point:ui_dialog段input
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
               CALL aicp300_fetch()
               
            ON CHANGE sel
               UPDATE aicp300_tmp 
                  SET sel = g_detail_d[l_ac].sel 
                WHERE xmdgdocno = g_detail_d[l_ac].xmdgdocno 
                  
         END INPUT               
         #end add-point
         #add-point:ui_dialog段自定義display array
         DISPLAY ARRAY g_detail2_d TO s_detail2.* ATTRIBUTE(COUNT=g_detail2_cnt)
            BEFORE DISPLAY
              
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               DISPLAY l_ac TO FORMONLY.idx
              
         END DISPLAY

         DISPLAY ARRAY g_detail3_d TO s_detail3.* ATTRIBUTE(COUNT=g_detail3_cnt)
            BEFORE DISPLAY
              
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               DISPLAY l_ac TO FORMONLY.idx
              
         END DISPLAY 
         
         DISPLAY ARRAY g_detail4_d TO s_detail4.* ATTRIBUTE(COUNT=g_detail4_cnt)
            BEFORE DISPLAY
              
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               DISPLAY l_ac TO FORMONLY.idx
              
         END DISPLAY          
         #end add-point
 
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
 
         BEFORE DIALOG
            IF g_detail_d.getLength() > 0 THEN
               CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
               CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
            ELSE
               CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
               CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
            END IF
            #add-point:ui_dialog段before_dialog2
            CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
            CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
            
            CALL aicp300_sel()
            
            #end add-point
 
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
            END FOR
            #add-point:ui_dialog段on action selall
            UPDATE aicp300_tmp 
               SET sel = 'Y'
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "N"
            END FOR
            #add-point:ui_dialog段on action selnone
            UPDATE aicp300_tmp 
               SET sel = 'N'
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "Y"
               END IF
            END FOR
            #add-point:ui_dialog段on action sel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  UPDATE aicp300_tmp 
                     SET sel = 'Y' 
                   WHERE xmdgdocno = g_detail_d[li_idx].xmdgdocno
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
            #add-point:ui_dialog段on action unsel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  UPDATE aicp300_tmp 
                     SET sel = 'N' 
                   WHERE xmdgdocno = g_detail_d[li_idx].xmdgdocno
               END IF
            END FOR
            
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL aicp300_filter()
            #add-point:ON ACTION filter

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
            CALL aicp300_query()
 
         # 條件清除
         ON ACTION qbeclear
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            CALL aicp300_b_fill()
            CALL aicp300_fetch()
 
         #add-point:ui_dialog段action
         ON ACTION batch_execute
            #變更此筆資料後，直接按執行
            IF l_ac > 0 THEN
               UPDATE aicp300_tmp
                  SET sel = g_detail_d[l_ac].sel
                WHERE xmdgdocno = g_detail_d[l_ac].xmdgdocno
            END IF
            
            LET l_cnt = ''
            SELECT COUNT(*) INTO l_cnt
              FROM aicp300_tmp
             WHERE sel = 'Y'
            IF cl_null(l_cnt) OR l_cnt = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = '-400'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

            ELSE
               CALL aicp300_process()
               LET INT_FLAG = TRUE     #170213-00043#1 17/02/15 By 08171 add
               CALL aicp300_query()
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
      
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="aicp300.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aicp300_query()
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define

   #end add-point 
   
   #add-point:cs段after_construct
   DELETE FROM aicp300_tmp;
   
   LET g_sql = "SELECT 'N',xmdgdocno,xmdgdocdt,",
               "       xmdg028,xmdg001,xmdg005,xmdg002,xmdg003,",
               "       xmdgownid,xmdgcrtid,",
               "       xmdg034,xmdg056 ",
               "  FROM xmdg_t ",
               " WHERE ",g_aicp300_sel,
               "   AND ",g_wc CLIPPED   
   
   LET g_sql = "INSERT INTO aicp300_tmp ",g_sql
   PREPARE tmp_ins_pre FROM g_sql
   EXECUTE tmp_ins_pre  

   LET g_wc_filter = " 1=1"
   #end add-point
        
   LET g_error_show = 1
   CALL aicp300_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="aicp300.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aicp300_b_fill()
 
   DEFINE ls_wc           STRING
   #add-point:b_fill段define

   #end add-point
 
   #add-point:b_fill段sql_before
   LET g_sql = "SELECT DISTINCT sel,xmdgdocno,xmdgdocdt,",
               "                xmdg028,xmdg001,",
               "                xmdg005,'',",
               "                xmdg002,'',",
               "                xmdg003,'',",
               "                xmdgownid,'',",
               "                xmdgcrtid,'',",
               "                xmdg034,xmdg056 ",
               "  FROM aicp300_tmp ",
               " WHERE ",g_wc_filter,
               " ORDER BY xmdgdocno,xmdgdocdt "
   #end add-point
 
   PREPARE aicp300_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aicp300_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空
   CALL g_detail2_d.clear() 
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO 
   #add-point:b_fill段foreach_into
   g_detail_d[l_ac].sel,g_detail_d[l_ac].xmdgdocno,g_detail_d[l_ac].xmdgdocdt,
   g_detail_d[l_ac].xmdg028,g_detail_d[l_ac].xmdg001,
   g_detail_d[l_ac].xmdg005,g_detail_d[l_ac].xmdg005_desc,
   g_detail_d[l_ac].xmdg002,g_detail_d[l_ac].xmdg002_desc,
   g_detail_d[l_ac].xmdg003,g_detail_d[l_ac].xmdg003_desc,
   g_detail_d[l_ac].xmdgownid,g_detail_d[l_ac].xmdgownid_desc,
   g_detail_d[l_ac].xmdgcrtid,g_detail_d[l_ac].xmdgcrtid_desc,
   g_detail_d[l_ac].xmdg034,g_detail_d[l_ac].xmdg056
   
   #end add-point
   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #add-point:b_fill段資料填充

      CALL s_desc_get_trading_partner_abbr_desc(g_detail_d[l_ac].xmdg005) RETURNING g_detail_d[l_ac].xmdg005_desc
      CALL s_desc_get_person_desc(g_detail_d[l_ac].xmdg002) RETURNING g_detail_d[l_ac].xmdg002_desc
      CALL s_desc_get_person_desc(g_detail_d[l_ac].xmdgownid) RETURNING g_detail_d[l_ac].xmdgownid_desc
      CALL s_desc_get_person_desc(g_detail_d[l_ac].xmdgcrtid) RETURNING g_detail_d[l_ac].xmdgcrtid_desc
      CALL s_desc_get_department_desc(g_detail_d[l_ac].xmdg003) RETURNING g_detail_d[l_ac].xmdg003_desc
      
      #end add-point
      
      CALL aicp300_detail_show()      
 
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
   LET g_error_show = 0
   
   #add-point:b_fill段資料填充(其他單身)
   CALL g_detail_d.deleteElement(g_detail_d.getLength())
   IF g_detail_d.getLength() > 0 THEN
      LET g_master_idx = 1
   ELSE
      LET g_master_idx = 0
   END IF
   
   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aicp300_sel
   
   LET l_ac = 1
   CALL aicp300_fetch()
   #add-point:b_fill段資料填充(其他單身)

   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aicp300.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aicp300_fetch()
 
   DEFINE li_ac           LIKE type_t.num5
   #add-point:fetch段define
   
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後
   CALL g_detail2_d.clear()
   
   IF cl_null(g_master_idx) OR g_master_idx <=0 THEN
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_sql = "SELECT xmdhseq,xmdh001,xmdh002,",
               "       xmdh003,xmdh004,xmdh005,",
               "       xmdh006,imaal003,imaal004,",
               "       xmdh007,xmdh034,",
               "       xmdh015,a.oocal003,",
               "       xmdh016,",
               "       xmdh018,b.oocal003,",
               "       xmdh019,xmdh008,xmdh051",
               "  FROM xmdh_t ",
               "       LEFT OUTER JOIN imaal_t ON xmdhent = imaalent AND xmdh006 = imaal001 AND imaal002 = '",g_dlang,"'",
               "       LEFT OUTER JOIN oocal_t a ON xmdhent = a.oocalent AND xmdh015 = a.oocal001 AND a.oocal002 = '",g_dlang,"'",
               "       LEFT OUTER JOIN oocal_t b ON xmdhent = b.oocalent AND xmdh018 = b.oocal001 AND b.oocal002 = '",g_dlang,"'",
               " WHERE xmdhent = '",g_enterprise,"'",
               "   AND xmdhdocno = '",g_detail_d[g_master_idx].xmdgdocno,"'"
   PREPARE xmdh_fill_pre FROM g_sql
   DECLARE xmdh_fill_cur CURSOR FOR xmdh_fill_pre
     
   FOREACH xmdh_fill_cur INTO g_detail2_d[l_ac].xmdhseq,g_detail2_d[l_ac].xmdh001,g_detail2_d[l_ac].xmdh002,
                              g_detail2_d[l_ac].xmdh003,g_detail2_d[l_ac].xmdh004,g_detail2_d[l_ac].xmdh005,
                              g_detail2_d[l_ac].xmdh006,g_detail2_d[l_ac].xmdh006_desc,g_detail2_d[l_ac].xmdh006_desc_1,
                              g_detail2_d[l_ac].xmdh007,g_detail2_d[l_ac].xmdh034,
                              g_detail2_d[l_ac].xmdh015,g_detail2_d[l_ac].xmdh015_desc,
                              g_detail2_d[l_ac].xmdh016,
                              g_detail2_d[l_ac].xmdh018,g_detail2_d[l_ac].xmdh018_desc,
                              g_detail2_d[l_ac].xmdh019,g_detail2_d[l_ac].xmdh008,g_detail2_d[l_ac].xmdh051
   
   
   
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
 
{<section id="aicp300.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aicp300_detail_show()
   #add-point:show段define
   
   #end add-point
 
   #add-point:detail_show段
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aicp300.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aicp300_filter()
   #add-point:filter段define

   #end add-point    
   
   DISPLAY ARRAY g_detail_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
      ON UPDATE
 
   END DISPLAY
   
   LET l_ac = 1
   LET g_detail_cnt = 1
   #add-point:filter段define
   
   CLEAR FORM 
   CALL g_detail_d.clear()
   CALL g_detail2_d.clear()
   
   CONSTRUCT g_wc_filter ON xmdgdocno,xmdgdocdt,
                            xmdg028,xmdg001,xmdg005,xmdg002,xmdg003,
                            xmdgownid,xmdgcrtid,
                            xmdg034,xmdg056
        FROM s_detail1[1].b_xmdgdocno,s_detail1[1].b_xmdgdocdt,
             s_detail1[1].b_xmdg028,s_detail1[1].b_xmdg001,s_detail1[1].b_xmdg005,s_detail1[1].b_xmdg002,s_detail1[1].b_xmdg003,
             s_detail1[1].b_xmdgownid,s_detail1[1].b_xmdgcrtid,
             s_detail1[1].b_xmdg034,s_detail1[1].b_xmdg056
           
      BEFORE CONSTRUCT
      
      ON ACTION controlp INFIELD b_xmdgdocno
         #開窗c段
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         LET g_qryparam.where = g_aicp300_sel
         
         CALL q_xmdgdocno()                       #呼叫開窗
         DISPLAY g_qryparam.return1 TO b_xmdgdocno  #顯示到畫面上
         NEXT FIELD b_xmdgdocno                     #返回原欄位            

      ON ACTION controlp INFIELD b_xmdg002
         #開窗c段
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_ooag001()                       #呼叫開窗
         DISPLAY g_qryparam.return1 TO b_xmdg002  #顯示到畫面上
         NEXT FIELD b_xmdg002                     #返回原欄位
         
      ON ACTION controlp INFIELD b_xmdg003
         #開窗c段
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_ooeg001()                       #呼叫開窗
         DISPLAY g_qryparam.return1 TO b_xmdg003  #顯示到畫面上
         NEXT FIELD b_xmdg003                     #返回原欄位
  
      ON ACTION controlp INFIELD b_xmdg005
         #開窗c段
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         LET g_qryparam.arg1 = g_site
         CALL q_pmaa001_6()                     #呼叫開窗
         DISPLAY g_qryparam.return1 TO b_xmdg005  #顯示到畫面上
         NEXT FIELD b_xmdg005                     #返回原欄位
         
      ON ACTION controlp INFIELD b_xmdgownid
         #開窗c段
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_ooag001()                         #呼叫開窗
         DISPLAY g_qryparam.return1 TO b_xmdgownid  #顯示到畫面上
         NEXT FIELD b_xmdgownid                     #返回原欄位
  
      ON ACTION controlp INFIELD b_xmdgcrtid
         #開窗c段
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_ooag001()                          #呼叫開窗
         DISPLAY g_qryparam.return1 TO b_xmdgcrtid  #顯示到畫面上
         NEXT FIELD b_xmdgcrtid                     #返回原欄位     
  
   END CONSTRUCT
   #end add-point    
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   
   CALL aicp300_b_fill()
   CALL aicp300_fetch()
   
END FUNCTION
 
{</section>}
 
{<section id="aicp300.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aicp300_filter_parser(ps_field)
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
   #add-point:filter段define
   
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
 
{<section id="aicp300.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aicp300_filter_show(ps_field,ps_object)
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
   LET ls_condition = aicp300_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aicp300.other_function" >}
#add-point:自定義元件(Function)

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aicp300_process()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp300_process()
DEFINE l_xmdg         type_g_detail_d
DEFINE l_xmdg055      LIKE xmdg_t.xmdg055
DEFINE l_xmdadocno    LIKE xmda_t.xmdadocno
DEFINE l_xmdcunit     LIKE xmdc_t.xmdcunit
DEFINE l_icab002      LIKE icab_t.icab002
DEFINE l_icab003      LIKE icab_t.icab003
DEFINE l_icac004      LIKE icac_t.icac004
DEFINE l_success      LIKE type_t.num5 
DEFINE l_icaa011      LIKE icaa_t.icaa011
DEFINE l_icaa003      LIKE icaa_t.icaa003          #160810-00010#2 add

   LET g_sql = "SELECT xmdgdocno,xmdgdocdt,",
               "       xmdg005,xmdg002,xmdg003,",
               "       xmdg034,xmdg056 ",
               "  FROM aicp300_tmp ",
               " WHERE sel = 'Y' ",
               " ORDER BY xmdgdocno "
   PREPARE process_pre FROM g_sql
   DECLARE process_cur CURSOR WITH HOLD FOR process_pre

   LET g_sql = "SELECT xmdh001",
               "  FROM xmdh_t",
               " WHERE xmdhent = ",g_enterprise,
               "   AND xmdhdocno = ?",
               "   AND xmdh001 IS NOT NULL",
               " ORDER BY xmdhseq"
   PREPARE xmdh001_pre FROM g_sql
   DECLARE xmdh001_cs SCROLL CURSOR FOR xmdh001_pre

   CALL s_tax_recount_tmp()

   LET g_success_cnt = 1
   LET g_fail_cnt = 0
   CALL g_detail3_d.clear()
   CALL g_detail4_d.clear()
   CALL cl_err_collect_init()   #匯總訊息-初始化

   INITIALIZE l_xmdg.* TO NULL
   FOREACH process_cur INTO l_xmdg.xmdgdocno,l_xmdg.xmdgdocdt,
                            l_xmdg.xmdg005,l_xmdg.xmdg002,l_xmdg.xmdg003,
                            l_xmdg.xmdg034,l_xmdg.xmdg056
   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:process_cur"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         #失敗記錄
         CALL aicp300_fail(l_xmdg.*,'')
         EXIT FOREACH
      END IF
      
      CALL s_transaction_begin()
      LET g_fail_cnt = g_errcollect.getLength()  #先取得錯誤訊息的長度，大於此長度的表示是這張單子的錯誤訊息
      LET l_success = TRUE
      LET l_xmdg055 = ''
      
      #多角流程代碼為空白時，錯誤
      IF cl_null(l_xmdg.xmdg056) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'aic-00026'   #多角流程代碼不可為空
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE

         CALL cl_err()
         CALL s_transaction_end('N',0)
         #失敗記錄
         CALL aicp300_fail(l_xmdg.*,'')
         CONTINUE FOREACH
      END IF
      
      IF l_xmdg.xmdg034 <> '3' THEN
      
         #呼叫產生多角序號的元件
         CALL s_aic_carry_gettrino(l_xmdg.xmdg056,'2',g_today,g_site)
              RETURNING l_success,l_xmdg055
         
         IF NOT l_success OR cl_null(l_xmdg055) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'amm-00001'   #自動生成單號失敗！
            LET g_errparam.extend = 'l_xmdg.xmdgdocno'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            CALL s_transaction_end('N',0)
            #失敗記錄
            CALL aicp300_fail(l_xmdg.*,'')
            CONTINUE FOREACH
         END IF
         
      ELSE  #3:統銷統收
         LET l_xmdg055 = l_xmdg.xmdgdocno
      END IF

      #更新g_site的出通單單頭抛轉否與多角流程序號
      UPDATE xmdg_t
         SET xmdg055 = l_xmdg055,
             xmdg054 = 'Y'
       WHERE xmdgent = g_enterprise
         AND xmdgdocno = l_xmdg.xmdgdocno

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'UPDATE xmdg_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         
         CALL s_transaction_end('N',0)
         #失敗記錄
         CALL aicp300_fail(l_xmdg.*,'')
         CONTINUE FOREACH
      END IF

      #根據訂單多角性質不同，而產生的其他站的出通單方式不同
      LET l_icaa003 = ''    #160810-00010#2  add
      LET l_icaa011 = ''
      SELECT icaa003,icaa011      #160810-00010#2 add icaa003
        INTO l_icaa003,l_icaa011  #160810-00010#2 add icaa003
        FROM icaa_t
       WHERE icaaent = g_enterprise
         AND icaa001 = l_xmdg.xmdg056

      IF l_xmdg.xmdg034 = '3' THEN   #多角性質=3.統銷統收
#150703 earl mark 邏輯待確認
#         #撈取出貨通知單的訂單單號（如有多筆訂單則取第一筆訂單單號）
#         OPEN xmdh001_cs USING l_xmdg.xmdgdocno
#         FETCH FIRST xmdh001_cs INTO l_xmdadocno
#         CLOSE xmdh001_cs
#
#         SELECT DISTINCT xmdcunit INTO l_xmdcunit
#           FROM xmdc_t
#          WHERE xmecent = g_enterprise AND xmdcdocno = l_xmdadocno
#          
#         IF l_xmdcunit = g_site THEN
#            CALL s_aic_carry_get_doctype(g_site,l_xmdcunit,'axmt520') RETURNING l_success,l_icac004
#            IF l_success THEN
#               CALL s_aicp300_carry(l_xmdg.xmdgdocno,l_xmdg.xmdgdocdt,l_xmdg.xmdg005,l_icac004,l_xmdg.xmdg056,l_icab002)
#               RETURNING l_success
#            END IF
#            
#            IF NOT l_success THEN 
#               CALL s_transaction_end('N',0)
#               #失敗記錄
#               CALL aicp300_fail(l_xmdg.*,'')
#               CONTINUE FOREACH
#            END IF
#         ELSE
#            CALL s_aic_carry_get_doctype(l_xmdcunit,g_site,'axmt520') RETURNING l_success,l_icac004
#            IF l_success THEN 
#               CALL s_aicp300_carry(l_xmdg.xmdgdocno,l_xmdg.xmdgdocdt,'',l_icac004,l_xmdg.xmdg056,l_icab002)
#               RETURNING l_success
#            END IF
#            
#            IF NOT l_success THEN 
#               CALL s_transaction_end('N',0)
#               #失敗記錄
#               CALL aicp300_fail(l_xmdg.*,'')
#               CONTINUE FOREACH
#            END IF
#         END IF

      ELSE  #多角性質=2.多角銷售 或 7.代採購出貨
      
         IF l_icaa011 = '1' THEN  #正拋     
            LET g_sql = "SELECT icab002,icab003 FROM icab_t ",
                        " WHERE icabent = ",g_enterprise,
                        "   AND icab001 = '",l_xmdg.xmdg056,"'",
                        " ORDER BY icab002"
         ELSE   #逆拋
            LET g_sql = "SELECT icab002,icab003 FROM icab_t ",
                        " WHERE icabent = ",g_enterprise,
                        "   AND icab001 = '",l_xmdg.xmdg056,"'",
                        " ORDER BY icab002 DESC"
         END IF

         PREPARE icab_pre1 FROM g_sql
         DECLARE icab_cur1 CURSOR FOR icab_pre1
         
         FOREACH icab_cur1 INTO l_icab002,l_icab003
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "FOREACH:icab_cur1"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               
               LET l_success = FALSE
               EXIT FOREACH
            END IF
            
            IF l_icab003 = g_site THEN
               CONTINUE FOREACH
            END IF
            #160810-00010#2-s-add
            IF l_icaa003 MATCHES '[23]' AND l_icab002 = 0 THEN
               CONTINUE FOREACH
            END IF
            #160810-00010#2-e-add
            
            CALL aicp300_get_icac004(l_xmdg.xmdg056,l_icab002) RETURNING l_success,l_icac004
            IF NOT l_success THEN
               EXIT FOREACH
            END IF
               
            CALL s_aicp300_carry(l_xmdg.xmdgdocno,l_xmdg.xmdgdocdt,'',l_icac004,l_xmdg.xmdg056,l_icab002)
            RETURNING l_success
            IF NOT l_success THEN
               EXIT FOREACH
            END IF
         
         END FOREACH
      END IF
      
      IF g_bgjob = "N" THEN
         IF l_success THEN 
            CALL s_transaction_end('Y','0') 
            #成功紀錄
            CALL aicp300_success(l_xmdg.*,l_xmdg055)
         ELSE
            CALL s_transaction_end('N','0')
            #失敗記錄
            CALL aicp300_fail(l_xmdg.*,l_icab003)
         END IF
      ELSE
         IF l_success THEN 
            CALL s_transaction_end('Y','0')
            CALL cl_ask_pressanykey("aic-00176")    #多角流程拋轉成功！            
         ELSE
            CALL s_transaction_end('N','0')
            CALL cl_ask_pressanykey("aic-00177")    #多角流程拋轉失敗！
         END IF         
      END IF
      
   END FOREACH
   
   #清空錯誤訊息的array，並且之後的訊息不以array記錄
   CALL cl_err_collect_init()
   CALL cl_err_collect_show()
   
   IF g_bgjob = 'N' THEN
      CALL cl_ask_pressanykey("std-00012")
   END IF
   
END FUNCTION

#單號過濾條件
PRIVATE FUNCTION aicp300_sel()
                       
   #設定出通單限制條件
   #LET g_aicp300_sel = " xmdgent = ",g_enterprise,                                 #161231-00013#1 mark
    LET g_aicp300_sel = " xmdgent = ",g_enterprise,cl_sql_add_filter("xmdg_t"),     #161231-00013#1 add
                       " AND xmdgsite = '",g_site,"'",
                       " AND xmdg056 IS NOT NULL",      #多角序號
                       " AND xmdg054 = 'N'",            #多角貿易已拋轉
                       " AND xmdg034 IN ('2','7')",
                       " AND xmdgstus = 'Y'",
                       " AND EXISTS (SELECT 1 ",
                       "               FROM icaa_t",
                       "              WHERE icaaent = ",g_enterprise,
                       "                AND icaa001 = xmdg056",
                       "                AND (icaa003 = '1' OR (icaa003 = '2' AND icaa011 = '2')))"
END FUNCTION

################################################################################
# Descriptions...: Create Temp Table
# Memo...........:
# Usage..........: CALL aicp300_create_temp_table()
#                  
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 150626 By earl
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp300_create_temp_table()
   DROP TABLE aicp300_tmp;
   CREATE TEMP TABLE aicp300_tmp( 
       sel        VARCHAR(1),   
       xmdgdocno  VARCHAR(20), 
       xmdgdocdt  DATE,
       xmdg028    DATE,
       xmdg001    VARCHAR(10),
       xmdg005    VARCHAR(10),
       xmdg002    VARCHAR(20),
       xmdg003    VARCHAR(10),
       xmdgownid  VARCHAR(20),
       xmdgcrtid  VARCHAR(20),
       xmdg034    VARCHAR(10),
       xmdg056    VARCHAR(10)
       );
END FUNCTION

################################################################################
# Descriptions...: 失敗紀錄
# Memo...........:
# Usage..........: CALL aicp300_fail(p_xmdg,p_xmdgsite)
#                 
# Input parameter: 
#                : 
# Return code....: p_xmdg
#                : p_xmdgsite   營運據點
# Date & Author..: 150701 By earl
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp300_fail(p_xmdg,p_xmdgsite)
   DEFINE p_xmdg         type_g_detail_d
   DEFINE p_xmdgsite     LIKE xmdg_t.xmdgsite
   DEFINE l_i            LIKE type_t.num5
   
   IF g_bgjob = "N" THEN
      IF cl_null(g_fail_cnt) THEN
         LET g_fail_cnt = 0
      END IF

      FOR l_i = g_fail_cnt + 1 TO g_errcollect.getLength()
         LET g_detail4_d[l_i].xmdgdocno = p_xmdg.xmdgdocno
         LET g_detail4_d[l_i].xmdgdocdt = p_xmdg.xmdgdocdt
         LET g_detail4_d[l_i].xmdg005 = p_xmdg.xmdg005
         LET g_detail4_d[l_i].xmdg002 = p_xmdg.xmdg002
         LET g_detail4_d[l_i].xmdg003 = p_xmdg.xmdg003
         LET g_detail4_d[l_i].xmdg056 = p_xmdg.xmdg056
         LET g_detail4_d[l_i].xmdgsite = p_xmdgsite
         
         #錯誤訊息
         LET g_detail4_d[l_i].reason = g_errcollect[l_i].message
      
         CALL s_desc_get_trading_partner_full_desc(g_detail4_d[l_i].xmdg005)
              RETURNING g_detail4_d[l_i].xmdg005_desc
         CALL s_desc_get_person_desc(g_detail4_d[l_i].xmdg002)
              RETURNING g_detail4_d[l_i].xmdg002_desc
         CALL s_desc_get_department_desc(g_detail4_d[l_i].xmdg003)
              RETURNING g_detail4_d[l_i].xmdg003_desc
         CALL s_desc_get_department_desc(g_detail4_d[l_i].xmdgsite)
              RETURNING g_detail4_d[l_i].xmdgsite_desc
      END FOR

      LET g_fail_cnt = g_errcollect.getLength()
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 成功紀錄
# Memo...........:
# Usage..........: CALL aicp300_success(p_xmdg,p_xmdg055)
#                  
# Input parameter: p_xmdg       RECORD
#                : p_xmdg055    多角流程序號
# Return code....: 
#                : 
# Date & Author..: 150701 By earl
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp300_success(p_xmdg,p_xmdg055)
   DEFINE p_xmdg           type_g_detail_d
   DEFINE p_xmdg055        LIKE xmdg_t.xmdg055

   IF cl_null(g_success_cnt) THEN
      LET g_success_cnt = 1
   END IF
   
   LET g_detail3_d[g_success_cnt].xmdgdocno = p_xmdg.xmdgdocno
   LET g_detail3_d[g_success_cnt].xmdgdocdt = p_xmdg.xmdgdocdt
   LET g_detail3_d[g_success_cnt].xmdg005 = p_xmdg.xmdg005
   LET g_detail3_d[g_success_cnt].xmdg002 = p_xmdg.xmdg002
   LET g_detail3_d[g_success_cnt].xmdg003 = p_xmdg.xmdg003
   LET g_detail3_d[g_success_cnt].xmdg055 = p_xmdg055
   
   CALL s_desc_get_trading_partner_full_desc(g_detail3_d[g_success_cnt].xmdg005)
        RETURNING g_detail3_d[g_success_cnt].xmdg005_desc
   CALL s_desc_get_person_desc(g_detail3_d[g_success_cnt].xmdg002)
        RETURNING g_detail3_d[g_success_cnt].xmdg002_desc
   CALL s_desc_get_department_desc(g_detail3_d[g_success_cnt].xmdg003)
        RETURNING g_detail3_d[g_success_cnt].xmdg003_desc
   
   LET g_success_cnt = g_success_cnt +  1
   
END FUNCTION

################################################################################
# Descriptions...: 取得出通單別
# Memo...........:
# Usage..........: CALL aicp300_get_icac004(p_icac001,p_icac002)
#                  RETURNING r_success,r_icac004
# Input parameter: p_icac001  #流程代碼
#                : p_icac002  #站別
# Return code....: r_success  #執行結果
#                : r_icac004  #出通單別
# Date & Author..: 150702 By earl
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp300_get_icac004(p_icac001,p_icac002)
   DEFINE p_icac001   LIKE icac_t.icac001
   DEFINE p_icac002   LIKE icac_t.icac002
   DEFINE r_success   LIKE type_t.num5
   DEFINE r_icac004   LIKE icac_t.icac004
   
   LET r_success = TRUE
   LET r_icac004 = ''

   SELECT icac004 INTO r_icac004
     FROM icac_t WHERE icacent = g_enterprise
      AND icac001 = p_icac001
      AND icac002 = p_icac002
      
   IF cl_null(r_icac004) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aic-00182'    #流程代碼%1站別%2之出貨通知單單別為空！
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = p_icac001
      LET g_errparam.replace[2] = p_icac002

      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success,r_icac004
   END IF
   
   RETURN r_success,r_icac004
END FUNCTION

#end add-point
 
{</section>}
 
