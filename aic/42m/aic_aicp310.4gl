#該程式已解開Section, 不再透過樣板產出!
{<section id="aicp310.description" >}
#+ Version..: T100-ERP-1.00.00(SD版次:1,PD版次:1) Build-000055
#+ 
#+ Filename...: aicp310
#+ Description: 多角貿易出貨通知單拋轉作業
#+ Creator....: 02295(2014/05/08)
#+ Modifier...: 02295(2014/05/08)
#+ Buildtype..: 應用 p02 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="aicp310.global" >}
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
       sel               LIKE type_t.chr1,
       xmdgdocno         LIKE xmdg_t.xmdgdocno, 
       xmdgdocdt         LIKE xmdg_t.xmdgdocdt,
       xmdg028           LIKE xmdg_t.xmdg028,
       xmdg001           LIKE xmdg_t.xmdg001,
       xmdg005           LIKE xmdg_t.xmdg005,
       xmdg005_desc      LIKE type_t.chr80,
       xmdg002           LIKE xmdg_t.xmdg002,
       xmdg002_desc      LIKE type_t.chr80,
       xmdg003           LIKE xmdg_t.xmdg003,
       xmdg003_desc      LIKE type_t.chr80,
       xmdgownid         LIKE xmdg_t.xmdgownid,
       xmdgownid_desc    LIKE type_t.chr80,
       xmdgcrtid         LIKE xmdg_t.xmdgcrtid,
       xmdgcrtid_desc    LIKE type_t.chr80,
       xmdg034           LIKE xmdg_t.xmdg034,
       xmdg056           LIKE xmdg_t.xmdg056,
       xmdg055           LIKE xmdg_t.xmdg055
       END RECORD

TYPE type_g_detail2_d    RECORD
       xmdhseq           LIKE xmdh_t.xmdhseq, 
       xmdh001           LIKE xmdh_t.xmdh001,
       xmdh002           LIKE xmdh_t.xmdh002,
       xmdh003           LIKE xmdh_t.xmdh003,
       xmdh004           LIKE xmdh_t.xmdh004,
       xmdh005           LIKE xmdh_t.xmdh005,
       xmdh006           LIKE xmdh_t.xmdh006,
       xmdh006_desc      LIKE type_t.chr80,
       xmdh006_desc_1    LIKE type_t.chr80,
       xmdh007           LIKE xmdh_t.xmdh007,
       xmdh034           LIKE xmdh_t.xmdh034,
       xmdh015           LIKE xmdh_t.xmdh015,
       xmdh015_desc      LIKE type_t.chr80,
       xmdh016           LIKE xmdh_t.xmdh016,
       xmdh018           LIKE xmdh_t.xmdh018,
       xmdh018_desc      LIKE type_t.chr80,
       xmdh019           LIKE xmdh_t.xmdh019,
       xmdh008           LIKE xmdh_t.xmdh008,
       xmdh051           LIKE xmdh_t.xmdh051
                         END RECORD
DEFINE g_detail2_cnt     LIKE type_t.num5
DEFINE g_detail2_d       DYNAMIC ARRAY OF type_g_detail2_d

#2015/03/20 by stellar add ----- (S)
#執行成功
TYPE type_g_detail3_d    RECORD
        xmdgdocno        LIKE xmdg_t.xmdgdocno,   #出通單號
        xmdgdocdt        LIKE xmdg_t.xmdgdocdt,   #出通日期
        xmdg005          LIKE xmdg_t.xmdg005,     #客戶編號
        xmdg005_desc     LIKE type_t.chr80,       #客戶名稱
        xmdg002          LIKE xmdg_t.xmdg002,     #業務人員
        xmdg002_desc     LIKE type_t.chr80,       #全名
        xmdg003          LIKE xmdg_t.xmdg003,     #業務部門
        xmdg003_desc     LIKE type_t.chr80        #說明
                         END RECORD
DEFINE g_detail3_cnt     LIKE type_t.num5
DEFINE g_detail3_d       DYNAMIC ARRAY OF type_g_detail3_d

#執行失敗
TYPE type_g_detail4_d    RECORD
        xmdgdocno        LIKE xmdg_t.xmdgdocno,   #出通單號
        xmdgdocdt        LIKE xmdg_t.xmdgdocdt,   #出通日期
        xmdg005          LIKE xmdg_t.xmdg005,     #客戶編號
        xmdg005_desc     LIKE type_t.chr80,       #客戶名稱
        xmdg002          LIKE xmdg_t.xmdg002,     #業務人員
        xmdg002_desc     LIKE type_t.chr80,       #全名
        xmdg003          LIKE xmdg_t.xmdg003,     #業務部門
        xmdg003_desc     LIKE type_t.chr80,       #說明
        xmdg055          LIKE xmdg_t.xmdg055,     #多角序號
        xmdgsite         LIKE xmdg_t.xmdgsite,    #營運據點
        xmdgsite_desc    LIKE type_t.chr80,       #名稱
        reason           LIKE type_t.chr500       #失敗原因
                         END RECORD
DEFINE g_detail4_cnt     LIKE type_t.num5
DEFINE g_detail4_d       DYNAMIC ARRAY OF type_g_detail4_d

DEFINE g_success_cnt     LIKE type_t.num5
DEFINE g_fail_cnt        LIKE type_t.num5
#2015/03/20 by stellar add ----- (E)

DEFINE g_aicp310_sel     STRING           #符合之SQL條件

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num5              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明

#end add-point
 
{</section>}
 
{<section id="aicp310.main" >}
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
   CALL aicp310_create_temp_table()
   
   CALL aicp310_sel()
   
   IF NOT cl_null(g_argv[1]) THEN
      LET g_bgjob = 'Y'
   END IF
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call
      IF NOT cl_null(g_argv[1]) THEN
         LET g_wc = " xmdgdocno = '",g_argv[1],"' "
         CALL aicp310_query()
         UPDATE aicp310_tmp
            SET sel = 'Y'
         CALL aicp310_process()
      END IF
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aicp310 WITH FORM cl_ap_formpath("aic",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aicp310_init()   
 
      #進入選單 Menu (="N")
      CALL aicp310_ui_dialog() 
 
      #add-point:畫面關閉前
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aicp310
   END IF 
   
   #add-point:作業離開前
   DROP TABLE aicp310_tmp;
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aicp310.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aicp310_init()
   #add-point:init段define
   
   #end add-point   
 
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化
   
   LET g_errshow = 1
   IF cl_null(g_bgjob) THEN
      LET g_bgjob = 'N'
   END IF
   
   CALL cl_set_combo_scc('xmdg001','2063')
   CALL cl_set_combo_scc('b_xmdg001','2063')
   CALL cl_set_combo_scc('b_xmdh005','2055')
   CALL cl_set_combo_scc('b_xmdg034','2064')
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aicp310.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aicp310_ui_dialog()
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

         CONSTRUCT BY NAME g_wc ON xmdgdocno,xmdgdocdt,
                                   xmdg028,xmdg001,xmdg005,xmdg002,xmdg003,
                                   xmdgownid,xmdgcrtid

            BEFORE CONSTRUCT
            
            ON ACTION controlp INFIELD xmdgdocno
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = g_aicp310_sel
               
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
              ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
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
               CALL aicp310_fetch()               
               
            ON CHANGE sel
               UPDATE aicp310_tmp 
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
            
            CALL aicp310_sel()
            
            #end add-point
 
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
            END FOR
            #add-point:ui_dialog段on action selall
            UPDATE aicp310_tmp 
               SET sel = 'Y'
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "N"
            END FOR
            #add-point:ui_dialog段on action selnone
            UPDATE aicp310_tmp 
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
                  UPDATE aicp310_tmp
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
                  UPDATE aicp310_tmp 
                     SET sel = 'N' 
                   WHERE xmdgdocno = g_detail_d[li_idx].xmdgdocno
               END IF
            END FOR

            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL aicp310_filter()
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
            CALL aicp310_query()
 
         # 條件清除
         ON ACTION qbeclear
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            CALL aicp310_b_fill()
            CALL aicp310_fetch()
 
         #add-point:ui_dialog段action
         ON ACTION batch_execute
            #變更此筆資料後，直接按執行
            IF l_ac > 0 THEN
               UPDATE aicp310_tmp
                  SET sel = g_detail_d[l_ac].sel
                WHERE xmdgdocno = g_detail_d[l_ac].xmdgdocno
            END IF
            
            #判斷是否有至少選擇一筆資料做處理
            LET l_cnt = ''
            SELECT COUNT(*) INTO l_cnt
              FROM aicp310_tmp
             WHERE sel = 'Y'
            IF cl_null(l_cnt) OR l_cnt = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = '-400'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE

               CALL cl_err()
            ELSE
               CALL aicp310_process()
               LET INT_FLAG = TRUE     #170213-00043#1 17/02/15 By 08171 add
               CALL aicp310_query()
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
 
{<section id="aicp310.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aicp310_query()
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define

   #end add-point 
   
   #add-point:cs段after_construct
   DELETE FROM aicp310_tmp;
   
   LET g_sql = "SELECT DISTINCT 'N',xmdgdocno,xmdgdocdt,",
               "                xmdg028,xmdg001,xmdg005,xmdg002,xmdg003,",
               "                xmdgownid,xmdgcrtid,",
               "                xmdg034,xmdg056,xmdg055 ",
               "  FROM xmdg_t",
               " WHERE ",g_aicp310_sel,
               "   AND ",g_wc  CLIPPED
               
   LET g_sql = "INSERT INTO aicp310_tmp ",g_sql
   PREPARE tmp_ins_pre FROM g_sql
   EXECUTE tmp_ins_pre
   
   LET g_wc_filter = " 1=1"
   #end add-point
        
   LET g_error_show = 1
   CALL aicp310_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="aicp310.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aicp310_b_fill()
 
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
               "                xmdg034,xmdg056,xmdg055",
               "  FROM aicp310_tmp ",
               " ORDER BY xmdgdocno,xmdgdocdt "
   #end add-point
 
   PREPARE aicp310_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aicp310_sel
   
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
      g_detail_d[l_ac].xmdg034,g_detail_d[l_ac].xmdg056,g_detail_d[l_ac].xmdg055
   
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
      
      CALL s_desc_get_trading_partner_abbr_desc(g_detail_d[l_ac].xmdg005)
           RETURNING g_detail_d[l_ac].xmdg005_desc
      CALL s_desc_get_department_desc(g_detail_d[l_ac].xmdg003)
           RETURNING g_detail_d[l_ac].xmdg003_desc
      CALL s_desc_get_person_desc(g_detail_d[l_ac].xmdg002)
           RETURNING g_detail_d[l_ac].xmdg002_desc
      CALL s_desc_get_person_desc(g_detail_d[l_ac].xmdgownid)
           RETURNING g_detail_d[l_ac].xmdgownid_desc
      CALL s_desc_get_person_desc(g_detail_d[l_ac].xmdgcrtid)
           RETURNING g_detail_d[l_ac].xmdgcrtid_desc
      #end add-point
      
      CALL aicp310_detail_show()      
 
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
   FREE aicp310_sel
   
   LET l_ac = 1
   CALL aicp310_fetch()
   #add-point:b_fill段資料填充(其他單身)

   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aicp310.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aicp310_fetch()
 
   DEFINE li_ac           LIKE type_t.num5
   #add-point:fetch段define
   
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後
   #2015/03/25 by stellar add ----- (S)
   CALL g_detail2_d.clear()
   
   IF cl_null(g_master_idx) OR g_master_idx <=0 THEN
      RETURN
   END IF
   #2015/03/25 by stellar add ----- (E)
   
   LET l_ac = 1
   LET g_sql = "SELECT xmdhseq,xmdh001,xmdh002,xmdh003,xmdh004,xmdh005,xmdh006,imaal003,imaal004,",
               "       xmdh007,xmdh034,xmdh015,a.oocal003,xmdh016,xmdh018,b.oocal003,xmdh019,xmdh008,xmdh051",
               "  FROM xmdh_t ",
               "       LEFT OUTER JOIN imaal_t ON xmdhent = imaalent AND xmdh006 = imaal001 AND imaal002 = '",g_dlang,"'",
               "       LEFT OUTER JOIN oocal_t a ON xmdhent = a.oocalent AND xmdh015 = a.oocal001 AND a.oocal002 = '",g_dlang,"'",
               "       LEFT OUTER JOIN oocal_t b ON xmdhent = b.oocalent AND xmdh018 = b.oocal001 AND b.oocal002 = '",g_dlang,"'",
               " WHERE xmdhent = '",g_enterprise,"'",
               "   AND xmdhdocno = '",g_detail_d[g_master_idx].xmdgdocno,"'"
   PREPARE xmdh_fill_pre FROM g_sql
   DECLARE xmdh_fill_cur CURSOR FOR xmdh_fill_pre
   FOREACH xmdh_fill_cur INTO g_detail2_d[l_ac].*
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
   LET g_detail2_cnt = l_ac - 1 
   DISPLAY g_detail2_cnt TO FORMONLY.cnt   
   #end add-point 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="aicp310.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aicp310_detail_show()
   #add-point:show段define
   
   #end add-point
 
   #add-point:detail_show段
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aicp310.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aicp310_filter()
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
                            xmdg028,xmdg001,xmdg005,
                            xmdg002,xmdg003,
                            xmdgownid,xmdgcrtid,
                            xmdg034,xmdg056,xmdg055
        FROM s_detail1[1].b_xmdgdocno,s_detail1[1].b_xmdgdocdt,
             s_detail1[1].b_xmdg028,s_detail1[1].b_xmdg001,s_detail1[1].b_xmdg005,
             s_detail1[1].b_xmdg002,s_detail1[1].b_xmdg003,
             s_detail1[1].b_xmdgownid,s_detail1[1].b_xmdgcrtid,
             s_detail1[1].b_xmdg034,s_detail1[1].b_xmdg056,s_detail1[1].b_xmdg055

      BEFORE CONSTRUCT
         ON ACTION controlp INFIELD b_xmdgdocno
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = g_aicp310_sel
            
            CALL q_xmdgdocno()                        #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmdgdocno  #顯示到畫面上
            NEXT FIELD b_xmdgdocno                      #返回原欄位            
               
         ON ACTION controlp INFIELD b_xmdg005
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_site
            
            CALL q_pmaa001_6()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmdg005  #顯示到畫面上
            NEXT FIELD b_xmdg005                     #返回原欄位
         
         ON ACTION controlp INFIELD b_xmdg002
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            
            CALL q_ooag001()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmdg002  #顯示到畫面上
            NEXT FIELD b_xmdg002                     #返回原欄位
               
         ON ACTION controlp INFIELD b_xmdg003
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            
            CALL q_ooeg001()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmdg003  #顯示到畫面上
            NEXT FIELD b_xmdg003                     #返回原欄位
               
         ON ACTION controlp INFIELD b_xmdgownid
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmdgownid  #顯示到畫面上
            NEXT FIELD b_xmdgownid                     #返回原欄位
         
         ON ACTION controlp INFIELD b_xmdgcrtid
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmdgcrtid  #顯示到畫面上
            NEXT FIELD b_xmdgcrtid                     #返回原欄位
               
         ON ACTION controlp INFIELD b_xmdg056
         ON ACTION controlp INFIELD b_xmdg055
         
   END CONSTRUCT
   #end add-point    
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   
   CALL aicp310_b_fill()
   CALL aicp310_fetch()
   
END FUNCTION
 
{</section>}
 
{<section id="aicp310.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aicp310_filter_parser(ps_field)
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
 
{<section id="aicp310.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aicp310_filter_show(ps_field,ps_object)
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
   LET ls_condition = aicp310_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aicp310.other_function" >}
#add-point:自定義元件(Function)

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aicp310_process()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp310_process()
DEFINE l_xmdg         type_g_detail_d
DEFINE l_success      LIKE type_t.num5
DEFINE l_icab_now  RECORD
          icab002        LIKE icab_t.icab002,
          icab003        LIKE icab_t.icab003,
          icab004        LIKE icab_t.icab004
                   END RECORD

   #有選擇的出通單
   LET g_sql = "SELECT xmdgdocno,xmdgdocdt,",
               "       xmdg028,xmdg001,xmdg005, ",
               "       xmdg002,xmdg003,",
               "       xmdgownid,xmdgcrtid,",
               "       xmdg034,xmdg056,xmdg055",
               "  FROM aicp310_tmp ",
               " WHERE sel = 'Y' ",
               " ORDER BY xmdgdocno "
   PREPARE aicp310_process_pre FROM g_sql
   DECLARE aicp310_process_cur CURSOR WITH HOLD FOR aicp310_process_pre
   
   #該流程多角貿易營運據點
   LET g_sql = "SELECT icab002,icab003,icab004",
               "  FROM icab_t",
               " WHERE icabent = ",g_enterprise,
               "   AND icab001 = ?",
               " ORDER BY icab002"
   PREPARE aicp310_process_icab_pre FROM g_sql
   DECLARE aicp310_process_icab_cur CURSOR FOR aicp310_process_icab_pre
   
   LET g_success_cnt = 1
   LET g_fail_cnt = 0
   CALL g_detail3_d.clear()
   CALL g_detail4_d.clear()
   CALL cl_err_collect_init()   #匯總訊息-初始化
   
   FOREACH aicp310_process_cur INTO l_xmdg.xmdgdocno,l_xmdg.xmdgdocdt,
                                    l_xmdg.xmdg028,l_xmdg.xmdg001,l_xmdg.xmdg005,
                                    l_xmdg.xmdg002,l_xmdg.xmdg003,
                                    l_xmdg.xmdgownid,l_xmdg.xmdgcrtid,
                                    l_xmdg.xmdg034,l_xmdg.xmdg056,l_xmdg.xmdg055
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'process_cur'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         #失敗記錄
         CALL aicp310_fail(l_xmdg.*,'')
         EXIT FOREACH
      END IF
      
      CALL s_transaction_begin()
      LET g_fail_cnt = g_errcollect.getLength()  #先取得錯誤訊息的長度，大於此長度的表示是這張單子的錯誤訊息
      LET l_success = TRUE
      
      #多角序號為空白時，錯誤
      IF cl_null(l_xmdg.xmdg055) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'aic-00099'   #該筆資料之多角序號為空！
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE

         CALL cl_err()
         CALL s_transaction_end('N',0)
         #失敗記錄
         CALL aicp310_fail(l_xmdg.*,'')
         CONTINUE FOREACH
      END IF
      
      IF l_xmdg.xmdg034 <> '3' THEN
         #多角性質非"統銷統收"
         
         #多角流程代碼為空白時，錯誤
         IF cl_null(l_xmdg.xmdg056) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'aic-00026'  #多角流程代碼不可為空
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            
            CALL cl_err()
            CALL s_transaction_end('N',0)
            #失敗記錄
            CALL aicp310_fail(l_xmdg.*,'')
            CONTINUE FOREACH
         END IF

         #跑站(當站)
         OPEN aicp310_process_icab_cur USING l_xmdg.xmdg056
         FOREACH aicp310_process_icab_cur INTO l_icab_now.icab002,l_icab_now.icab003,l_icab_now.icab004
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
                  
               CALL cl_err()
               LET l_success = FALSE
               EXIT FOREACH
            END IF
            
            #用多角序號抓取該站的出通單，並做處理
            CALL aicp310_xmdg(l_icab_now.icab003,l_xmdg.xmdg055,l_xmdg.xmdg056)
                 RETURNING l_success
            IF NOT l_success THEN
               EXIT FOREACH
            END IF
         END FOREACH
      ELSE
         ##多角性質為"統銷統收"
      END IF
      
      #更新"多角貿易拋轉否"='N'及清空"多角流程序號"
      IF l_success THEN
         UPDATE xmdg_t SET xmdg054 = 'N',
                           xmdg055 = NULL
          WHERE xmdgent = g_enterprise
            AND xmdgdocno = l_xmdg.xmdgdocno
            
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
                        
            CALL cl_err()
            LET l_success = FALSE
         END IF
      END IF
      
      IF l_success THEN
         CALL s_aic_carry_deletetrino(l_xmdg.xmdg055,'2')
              RETURNING l_success
      END IF
      
      IF g_bgjob = 'N' THEN
         IF l_success THEN
            CALL s_transaction_end('Y',0)
            #成功記錄
            CALL aicp310_success(l_xmdg.*)
         ELSE
            CALL s_transaction_end('N',0)
            #失敗記錄
            CALL aicp310_fail(l_xmdg.*,l_icab_now.icab003)
         END IF
      ELSE
         IF l_success THEN
            #成功
            CALL s_transaction_end('Y',0)
            CALL cl_ask_pressanykey("aic-00178")    #多角流程拋轉還原成功！
         ELSE
            #失敗
            CALL s_transaction_end('N',0)
            CALL cl_ask_pressanykey("aic-00179")    #多角流程拋轉還原失敗！
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

################################################################################
# Descriptions...: 抓取該站的出通單，取消確認並刪除/作廢所有資料
# Memo...........:
# Usage..........: CALL aicp310_xmdg(p_site,p_xmdg055,p_xmdg056)
#                  RETURNING r_success
# Input parameter: p_site         營運據點
#                : p_xmdg055      多角序號
#                : p_xmdg056      多角代碼
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2015/03/19 By stellar
# Modify.........: 150917-00001#4 151123 earl 加入製造批序號拋轉還原
################################################################################
PRIVATE FUNCTION aicp310_xmdg(p_site,p_xmdg055,p_xmdg056)
DEFINE p_site            LIKE xmdg_t.xmdgsite
DEFINE p_xmdg055         LIKE xmdg_t.xmdg055
DEFINE p_xmdg056         LIKE xmdg_t.xmdg056
DEFINE r_success         LIKE type_t.num5
DEFINE l_xmdgdocno       LIKE xmdg_t.xmdgdocno
DEFINE l_xmdgdocdt       LIKE xmdg_t.xmdgdocdt
DEFINE l_site            LIKE xmdg_t.xmdgsite
DEFINE l_prog            LIKE ooef_t.ooef001
DEFINE l_icaa011         LIKE icaa_t.icaa011
DEFINE l_icab003_first   LIKE icab_t.icab003
DEFINE l_icab003_last    LIKE icab_t.icab003
DEFINE l_sql             STRING

   LET r_success = TRUE
   
   LET l_icaa011 = ''
   SELECT icaa011
     INTO l_icaa011
     FROM icaa_t
    WHERE icaaent = g_enterprise
      AND icaa001 = p_xmdg056
   
   LET l_sql = "SELECT icab003",
               "  FROM icab_t",
               " WHERE icabent = ",g_enterprise,
               "   AND icab001 = '",p_xmdg056,"'",
               " ORDER BY icab002"
   PREPARE sel_icab003_first_pre FROM l_sql
   DECLARE sel_icab003_first_cs SCROLL CURSOR FOR sel_icab003_first_pre

   LET l_sql = "SELECT icab003",
               "  FROM icab_t",
               " WHERE icabent = ",g_enterprise,
               "   AND icab001 = '",p_xmdg056,"'",
               " ORDER BY icab002 DESC"
   PREPARE sel_icab003_last_pre FROM l_sql
   DECLARE sel_icab003_last_cs SCROLL CURSOR FOR sel_icab003_last_pre
   
   LET l_icab003_first = ''
   OPEN sel_icab003_first_cs
   FETCH FIRST sel_icab003_first_cs INTO l_icab003_first
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'FETCH:sel_icab003_first_cs'
      LET g_errparam.popup = TRUE

      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   LET l_icab003_last = ''
   OPEN sel_icab003_last_cs
   FETCH FIRST sel_icab003_last_cs INTO l_icab003_last
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'FETCH:sel_icab003_last_cs'
      LET g_errparam.popup = TRUE

      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #正拋初始站，不做處理
   IF l_icaa011 = '1' AND l_icab003_first = p_site THEN
      RETURN r_success
   END IF

   #逆拋最終站，不做處理
   IF l_icaa011 = '2' AND l_icab003_last = p_site THEN
      RETURN r_success
   END IF
   
   LET l_xmdgdocno = ''
   LET l_xmdgdocdt = ''
   SELECT xmdgdocno,xmdgdocdt
     INTO l_xmdgdocno,l_xmdgdocdt
     FROM xmdg_t
    WHERE xmdgent = g_enterprise
      AND xmdgsite = p_site
      AND xmdg055 = p_xmdg055
      AND xmdgstus <> 'X'
   IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
                  
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   IF cl_null(l_xmdgdocno) THEN
      RETURN r_success
   END IF
   
   #先將多角序號清空
   UPDATE xmdg_t SET xmdg055 = NULL,
                     xmdg054 = 'N'
    WHERE xmdgent = g_enterprise
      AND xmdgdocno = l_xmdgdocno
   
   LET l_prog = g_prog
   LET l_site = g_site
   LET g_prog = 'axmt520'
   LET g_site = p_site
   
   #取消確認
   CALL s_axmt520_unconf_chk(l_xmdgdocno) 
        RETURNING r_success
   IF NOT r_success THEN
      LET g_prog = l_prog
      LET g_site = l_site
      RETURN r_success
   END IF
   CALL s_axmt520_unconf_upd(l_xmdgdocno)
        RETURNING r_success
   IF NOT r_success THEN
      LET g_prog = l_prog
      LET g_site = l_site
      RETURN r_success
   END IF
   
   IF cl_get_para(g_enterprise,g_site,'E-BAS-0018') = 'N' THEN
      #多角單據流水號保持一致='N'時，做作廢處理
      CALL s_axmt520_invalid_chk(l_xmdgdocno)
           RETURNING r_success
      IF NOT r_success THEN
         LET g_prog = l_prog
         LET g_site = l_site
         RETURN r_success
      END IF
      CALL s_axmt520_invalid_upd(l_xmdgdocno)
           RETURNING r_success
      IF NOT r_success THEN
         LET g_prog = l_prog
         LET g_site = l_site
         RETURN r_success
      END IF
   ELSE
      #刪除所有資料
      #1.出通單單頭
      DELETE FROM xmdg_t
       WHERE xmdgent = g_enterprise
         AND xmdgdocno = l_xmdgdocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = l_xmdgdocno
         LET g_errparam.popup = TRUE
         
         CALL cl_err()
         LET r_success = FALSE
         LET g_prog = l_prog
         LET g_site = l_site
         RETURN r_success
      END IF

      #2.依據出貨明細的的實際出貨數量更新對應的訂的交期名細中的已轉出貨量(xmdd031)
      IF NOT s_axmt520_upd_xmdd031(l_xmdgdocno,'') THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = l_xmdgdocno
         LET g_errparam.popup = TRUE
         
         CALL cl_err()
         LET r_success = FALSE
         LET g_prog = l_prog
         LET g_site = l_site
         RETURN r_success
      END IF
      
      #3.出通單明細
      DELETE FROM xmdh_t
       WHERE xmdhent = g_enterprise
         AND xmdhdocno = l_xmdgdocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = l_xmdgdocno
         LET g_errparam.popup = TRUE
         
         CALL cl_err()
         LET r_success = FALSE
         LET g_prog = l_prog
         LET g_site = l_site
         RETURN r_success
      END IF
      
      #3.多庫儲批明細
      DELETE FROM xmdi_t
       WHERE xmdient = g_enterprise
         AND xmdidocno = l_xmdgdocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = l_xmdgdocno
         LET g_errparam.popup = TRUE
         
         CALL cl_err()
         LET r_success = FALSE
         LET g_prog = l_prog
         LET g_site = l_site
         RETURN r_success
      END IF
      
      #150917-00001#4 151123 earl s
      #製造批序號
      DELETE FROM inao_t
       WHERE inaoent = g_enterprise
         AND inaodocno = l_xmdgdocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = l_xmdgdocno
         LET g_errparam.popup = TRUE
         
         CALL cl_err()
         LET r_success = FALSE
         LET g_prog = l_prog
         LET g_site = l_site
         RETURN r_success
      END IF
      #150917-00001#4 151123 earl e
      
      #4.單號處理
      IF NOT s_aooi200_del_docno(l_xmdgdocno,l_xmdgdocdt) THEN
         LET r_success = FALSE
         LET g_prog = l_prog
         LET g_site = l_site
         RETURN r_success
      END IF
   
      #稅額xrcd
      DELETE FROM xrcd_t
       WHERE xrcdent = g_enterprise
         AND xrcddocno = l_xmdgdocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = l_xmdgdocno
         LET g_errparam.popup = TRUE
         
         CALL cl_err()
         LET r_success = FALSE
         LET g_prog = l_prog
         LET g_site = l_site
         RETURN r_success
      END IF
   
      #刪除備註
      CALL s_aooi360_del('6',g_prog,l_xmdgdocno,'','','','','','','','','4') RETURNING r_success
      IF NOT r_success THEN
         LET g_prog = l_prog
         LET g_site = l_site
         RETURN r_success
      END IF
                  
      #相關文件
      CALL g_pk_array.clear()
      LET g_pk_array[1].values = l_xmdgdocno
      LET g_pk_array[1].column = 'xmdgdocno'
      CALL cl_doc_remove()
   END IF
   
   LET g_prog = l_prog
   LET g_site = l_site
   
   RETURN r_success
END FUNCTION

PRIVATE FUNCTION aicp310_success(p_xmdg)
DEFINE p_xmdg            type_g_detail_d

   IF cl_null(g_success_cnt) THEN
      LET g_success_cnt = 1
   END IF
   
   LET g_detail3_d[g_success_cnt].xmdgdocno = p_xmdg.xmdgdocno
   LET g_detail3_d[g_success_cnt].xmdgdocdt = p_xmdg.xmdgdocdt
   LET g_detail3_d[g_success_cnt].xmdg005 = p_xmdg.xmdg005
   LET g_detail3_d[g_success_cnt].xmdg002 = p_xmdg.xmdg002
   LET g_detail3_d[g_success_cnt].xmdg003 = p_xmdg.xmdg003
   
   #說明
   CALL s_desc_get_trading_partner_abbr_desc(g_detail3_d[g_success_cnt].xmdg005)
        RETURNING g_detail3_d[g_success_cnt].xmdg005_desc
   CALL s_desc_get_person_desc(g_detail3_d[g_success_cnt].xmdg002)
        RETURNING g_detail3_d[g_success_cnt].xmdg002_desc
   CALL s_desc_get_department_desc(g_detail3_d[g_success_cnt].xmdg003)
        RETURNING g_detail3_d[g_success_cnt].xmdg003_desc
   
   LET g_success_cnt = g_success_cnt +  1
   
END FUNCTION

PRIVATE FUNCTION aicp310_fail(p_xmdg,p_xmdgsite)
DEFINE p_xmdg            type_g_detail_d
DEFINE p_xmdgsite        LIKE xmdg_t.xmdgsite
DEFINE l_i               LIKE type_t.num5

   IF g_bgjob = 'N' THEN
      IF cl_null(g_fail_cnt) THEN
         LET g_fail_cnt = 0
      END IF
      
      FOR l_i = g_fail_cnt+1 TO g_errcollect.getLength()
          LET g_detail4_d[l_i].xmdgdocno = p_xmdg.xmdgdocno
          LET g_detail4_d[l_i].xmdgdocdt = p_xmdg.xmdgdocdt
          LET g_detail4_d[l_i].xmdg005 = p_xmdg.xmdg005
          LET g_detail4_d[l_i].xmdg002 = p_xmdg.xmdg002
          LET g_detail4_d[l_i].xmdg003 = p_xmdg.xmdg003
          LET g_detail4_d[l_i].xmdg055 = p_xmdg.xmdg055
          LET g_detail4_d[l_i].xmdgsite = p_xmdgsite
          
          #錯誤訊息
          LET g_detail4_d[l_i].reason = g_errcollect[l_i].message
          
          #說明
          CALL s_desc_get_trading_partner_abbr_desc(g_detail4_d[l_i].xmdg005)
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
# Descriptions...: Create Temp Table
# Memo...........:
# Usage..........: CALL aicp310_create_temp_table()
#                  
# Input parameter:
#                : 
# Return code....: 
#                : 
# Date & Author..: 150629 By earl
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp310_create_temp_table()
   DROP TABLE aicp310_tmp;
   CREATE TEMP TABLE aicp310_tmp( 
       sel          VARCHAR(1),   
       xmdgdocno    VARCHAR(20), 
       xmdgdocdt    DATE,
       xmdg028      DATE,
       xmdg001      VARCHAR(10),
       xmdg005      VARCHAR(10),
       xmdg002      VARCHAR(20),
       xmdg003      VARCHAR(10),
       xmdgownid    VARCHAR(20),
       xmdgcrtid    VARCHAR(20),
       xmdg034      VARCHAR(10),
       xmdg056      VARCHAR(10),
       xmdg055      VARCHAR(20)
       );
END FUNCTION

#單號過濾條件
PRIVATE FUNCTION aicp310_sel()
  #LET g_aicp310_sel = " xmdgent = ",g_enterprise,                                 #161231-00013#1 mark
   LET g_aicp310_sel = " xmdgent = ",g_enterprise,cl_sql_add_filter("xmdg_t"),     #161231-00013#1 add
                       " AND xmdgsite = '",g_site,"'",
                       " AND xmdgstus = 'Y'",
                       " AND xmdg056 IS NOT NULL",    #多角代碼
                       " AND xmdg055 IS NOT NULL ",   #多角序號
                       " AND xmdg054 = 'Y'  ",        #拋轉否
                       " AND xmdg034 IN ('2','7') ",
                       " AND EXISTS (SELECT 1 ",
                       "               FROM icaa_t",
                       "              WHERE icaaent = ",g_enterprise,
                       "                AND icaa001 = xmdg056",
                       "                AND (icaa003 = '1' OR (icaa003 = '2' AND icaa011 = '2')))",
                       
                       #排除已輸入出貨單之資料
                       " AND NOT EXISTS (SELECT * FROM xmdk_t,xmdl_t",
                       "                  WHERE xmdkent = xmdlent AND xmdlent = xmdgent",
                       "                    AND xmdkdocno = xmdldocno",
                       "                    AND xmdkstus <> 'X'",
                       "                    AND (xmdk005 = xmdgdocno OR xmdl001 = xmdgdocno))",
                       
                       #排除已輸入Invoice之資料
                       " AND NOT EXISTS (SELECT * FROM xmdo_t,xmdp_t",
                       "                  WHERE xmdoent = xmdpent AND xmdpent = xmdgent",
                       "                    AND xmdodocno = xmdpdocno",
                       "                    AND xmdostus <> 'X'",
                       "                    AND xmdo004 = '1'",  #出貨通知單
                       "                    AND (xmdo005 = xmdgdocno OR xmdp001 = xmdgdocno))",
                       
                       #排除已輸入包裝單之資料
                       " AND NOT EXISTS (SELECT * FROM xmel_t,xmem_t",
                       "                  WHERE xmelent = xmement AND xmement = xmdgent",
                       "                    AND xmeldocno = xmemdocno",
                       "                    AND xmelstus <> 'X'",
                       "                    AND xmel004 = '1'",  #出貨通知單
                       "                    AND (xmel005 = xmdgdocno OR xmem001 = xmdgdocno))"
                       
                       #統銷統收-暫不處理
                       
END FUNCTION

#end add-point
 
{</section>}
 
