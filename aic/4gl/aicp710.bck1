#該程式已解開Section, 不再透過樣板產出!
{<section id="aicp710.description" >}
#+ Version..: T100-ERP-1.00.00(SD版次:1,PD版次:1) Build-000055
#+ 
#+ Filename...: aicp710
#+ Description: 多角貿易出貨通知單拋轉作業
#+ Creator....: 02295(2014/05/08)
#+ Modifier...: 02295(2014/05/08)
#+ Buildtype..: 應用 p02 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="aicp710.global" >}
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
       xmdkdocno         LIKE xmdk_t.xmdkdocno, 
       xmdkdocdt         LIKE xmdk_t.xmdkdocdt,
       xmdk007           LIKE xmdk_t.xmdk007,
       xmdk007_desc      LIKE type_t.chr80,
       xmdk009           LIKE xmdk_t.xmdk009,
       xmdk009_desc      LIKE type_t.chr80,
       xmdk008           LIKE xmdk_t.xmdk008,
       xmdk008_desc      LIKE type_t.chr80,
       xmdk003           LIKE xmdk_t.xmdk003,
       xmdk003_desc      LIKE type_t.chr80,
       xmdk004           LIKE xmdk_t.xmdk004,
       xmdk004_desc      LIKE type_t.chr80,
       xmdkownid         LIKE xmdk_t.xmdkownid,
       xmdkownid_desc    LIKE type_t.chr80,
       xmdkcrtid         LIKE xmdk_t.xmdkcrtid,
       xmdkcrtid_desc    LIKE type_t.chr80,
       xmdk035           LIKE xmdk_t.xmdk035
                     END RECORD

TYPE type_g_detail2_d RECORD
       xmdlseq           LIKE xmdl_t.xmdlseq, 
       xmdl001           LIKE xmdl_t.xmdl001,
       xmdl002           LIKE xmdl_t.xmdl002,
       xmdl003           LIKE xmdl_t.xmdl003,
       xmdl004           LIKE xmdl_t.xmdl004,
       xmdl005           LIKE xmdl_t.xmdl005,
       xmdl006           LIKE xmdl_t.xmdl006,
       xmdl007           LIKE xmdl_t.xmdl007,
       xmdl008           LIKE xmdl_t.xmdl008,
       xmdl008_desc      LIKE type_t.chr80,
       xmdl008_desc_desc LIKE type_t.chr80,
       xmdl009           LIKE xmdl_t.xmdl009,
       xmdl033           LIKE xmdl_t.xmdl033,
       xmdl017           LIKE xmdl_t.xmdl017,
       xmdl017_desc      LIKE type_t.chr80,
       xmdl018           LIKE xmdl_t.xmdl018,
       xmdl019           LIKE xmdl_t.xmdl019,
       xmdl019_desc      LIKE type_t.chr80,
       xmdl020           LIKE xmdl_t.xmdl020,
       xmdl010           LIKE xmdl_t.xmdl010,
       xmdl021           LIKE xmdl_t.xmdl021,
       xmdl021_desc      LIKE type_t.chr80,
       xmdl022           LIKE xmdl_t.xmdl022,
       xmdl030           LIKE xmdl_t.xmdl030,
       xmdl031           LIKE xmdl_t.xmdl031,
       xmdl032           LIKE xmdl_t.xmdl032,
       xmdl051           LIKE xmdl_t.xmdl051
                      END RECORD

TYPE type_g_detail3_d RECORD
       xmdkdocno1        LIKE xmdk_t.xmdkdocno, 
       xmdkdocdt1        LIKE xmdk_t.xmdkdocdt,
       xmdk0071          LIKE xmdk_t.xmdk007,
       xmdk0071_desc     LIKE type_t.chr80,
       xmdk0091          LIKE xmdk_t.xmdk009,
       xmdk0091_desc     LIKE type_t.chr80,
       xmdk0081          LIKE xmdk_t.xmdk008,
       xmdk0081_desc     LIKE type_t.chr80,
       xmdk0031          LIKE xmdk_t.xmdk003,
       xmdk0031_desc     LIKE type_t.chr80,
       xmdk0041          LIKE xmdk_t.xmdk004,
       xmdk0041_desc     LIKE type_t.chr80
                      END RECORD

TYPE type_g_detail4_d RECORD
       xmdkdocno2        LIKE xmdk_t.xmdkdocno, 
       xmdkdocdt2        LIKE xmdk_t.xmdkdocdt,
       xmdk0072          LIKE xmdk_t.xmdk007,
       xmdk0072_desc     LIKE type_t.chr80,
       xmdk0092          LIKE xmdk_t.xmdk009,
       xmdk0092_desc     LIKE type_t.chr80,
       xmdk0082          LIKE xmdk_t.xmdk008,
       xmdk0082_desc     LIKE type_t.chr80,
       xmdk0032          LIKE xmdk_t.xmdk003,
       xmdk0032_desc     LIKE type_t.chr80,
       xmdk0042          LIKE xmdk_t.xmdk004,
       xmdk0042_desc     LIKE type_t.chr80,
       xmdk0352          LIKE xmdk_t.xmdk035,
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

DEFINE g_aicp710_sel     STRING

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num5              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明

#end add-point
 
{</section>}
 
{<section id="aicp710.main" >}
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
   
   CALL aicp710_create_temp_table()
   
   CALL aicp710_sel()
   
   IF NOT cl_null(g_argv[1]) THEN
      LET g_bgjob = 'Y'
   END IF
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call
      IF NOT cl_null(g_argv[1]) THEN
         LET g_wc = " xmdkdocno = '",g_argv[1],"' "
         CALL aicp710_query()

         UPDATE aicp710_tmp SET sel = 'Y'

         CALL aicp710_process()
      END IF
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aicp710 WITH FORM cl_ap_formpath("aic",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aicp710_init()   
 
      #進入選單 Menu (="N")
      CALL aicp710_ui_dialog() 
 
      #add-point:畫面關閉前
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aicp710
   END IF 
   
   #add-point:作業離開前
   DROP TABLE aicp710_tmp
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aicp710.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aicp710_init()
   #add-point:init段define
   
   #end add-point   
 
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化
   CALL cl_set_combo_scc('b_xmdl007','2055')
   
   IF cl_null(g_bgjob) THEN
      LET g_bgjob = 'N'
   END IF
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aicp710.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aicp710_ui_dialog()
   DEFINE li_idx   LIKE type_t.num5
   #add-point:ui_dialog段define
   DEFINE l_cnt       LIKE type_t.num5

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

         CONSTRUCT BY NAME g_wc ON xmdkdocno,xmdkdocdt,xmdk007,xmdk009,xmdk008,xmdk003,xmdk004,xmdkownid,xmdkcrtid,xmdk035

            BEFORE CONSTRUCT
            
            ON ACTION controlp INFIELD xmdkdocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '6'                #銷退單
               LET g_qryparam.where = g_aicp710_sel
               CALL q_xmdkdocno_8()                     #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdkdocno  #顯示到畫面上
               NEXT FIELD xmdkdocno                     #返回原欄位    
               
            ON ACTION controlp INFIELD xmdk007
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = g_site
               CALL q_pmaa001_6()                     #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdk007  #顯示到畫面上
               NEXT FIELD xmdk007                     #返回原欄位
               
            ON ACTION controlp INFIELD xmdk009
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg2 = g_site
               CALL q_pmac002_6()                     #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdk009  #顯示到畫面上
               NEXT FIELD xmdk009                     #返回原欄位
   
            ON ACTION controlp INFIELD xmdk008
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg2 = g_site
               CALL q_pmac002_5()                     #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdk008  #顯示到畫面上
               NEXT FIELD xmdk008                     #返回原欄位
   
            ON ACTION controlp INFIELD xmdk003
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdk003  #顯示到畫面上
               NEXT FIELD xmdk003                     #返回原欄位
               
            ON ACTION controlp INFIELD xmdk004
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooeg001()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdk004  #顯示到畫面上
               NEXT FIELD xmdk004                     #返回原欄位
               
            ON ACTION controlp INFIELD xmdkownid
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdkownid  #顯示到畫面上
               NEXT FIELD xmdkownid                     #返回原欄位
   
            ON ACTION controlp INFIELD xmdkcrtid
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdkcrtid  #顯示到畫面上
               NEXT FIELD xmdkcrtid                     #返回原欄位
            
            ON ACTION controlp INFIELD xmdk035
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '6'
               CALL q_xmdk035()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdk035    #顯示到畫面上
               NEXT FIELD xmdk035                       #返回原欄位
   
         END CONSTRUCT         
         #end add-point
         #add-point:ui_dialog段input
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
               CALL aicp710_fetch()               
               
            ON CHANGE b_sel
               UPDATE aicp710_tmp 
                  SET sel = g_detail_d[l_ac].sel 
                WHERE xmdkdocno = g_detail_d[l_ac].xmdkdocno 
                  
         END INPUT               
         #end add-point
         #add-point:ui_dialog段自定義display array
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
            
            CALL aicp710_sel()
            
            #end add-point
 
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
            END FOR
            #add-point:ui_dialog段on action selall
            UPDATE aicp710_tmp 
               SET sel = 'Y'
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "N"
            END FOR
            #add-point:ui_dialog段on action selnone
            UPDATE aicp710_tmp 
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
                  UPDATE aicp710_tmp 
                     SET sel = 'Y' 
                   WHERE xmdkdocno = g_detail_d[li_idx].xmdkdocno 
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
                  UPDATE aicp710_tmp 
                     SET sel = 'N' 
                   WHERE xmdkdocno = g_detail_d[li_idx].xmdkdocno
               END IF
            END FOR             
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL aicp710_filter()
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
            CALL aicp710_query()
 
         # 條件清除
         ON ACTION qbeclear
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            CALL aicp710_b_fill()
            CALL aicp710_fetch()
 
         #add-point:ui_dialog段action
         ON ACTION batch_execute
            #變更此筆資料後，直接按執行
            IF l_ac > 0 THEN
               UPDATE aicp710_tmp
                  SET sel = g_detail_d[l_ac].sel
                WHERE xmdkdocno = g_detail_d[l_ac].xmdkdocno
            END IF
            
            LET l_cnt = ''
            SELECT COUNT(*) INTO l_cnt
              FROM aicp710_tmp
             WHERE sel = 'Y'
            IF cl_null(l_cnt) OR l_cnt = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = '-400'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               CONTINUE DIALOG
            ELSE
               CALL aicp710_process()
               LET INT_FLAG = TRUE     #170213-00043#1 17/02/15 By 08171 add
               CALL aicp710_query()
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
 
{<section id="aicp710.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aicp710_query()
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define

   #end add-point 
   
   #add-point:cs段after_construct
   DELETE FROM aicp710_tmp
   
   LET g_sql = "SELECT DISTINCT 'N',xmdkdocno,xmdkdocdt,xmdk007,xmdk009,xmdk008,xmdk003,xmdk004,xmdkownid,xmdkcrtid,xmdk035,xmdk044 ",
               "  FROM xmdk_t ",
               " WHERE ",g_aicp710_sel,
               " AND ",g_wc
               
   LET g_sql = "INSERT INTO aicp710_tmp ",g_sql
   PREPARE tmp_ins_pre FROM g_sql
   EXECUTE tmp_ins_pre

   LET g_wc_filter = " 1=1"
   #end add-point
        
   LET g_error_show = 1
   CALL aicp710_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="aicp710.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aicp710_b_fill()
 
   DEFINE ls_wc           STRING
   #add-point:b_fill段define
   DEFINE l_cnt           LIKE type_t.num5
   #end add-point
 
   #add-point:b_fill段sql_before
   LET g_sql = " SELECT COUNT(*) ",
               "   FROM xrcb_t ",
               "  WHERE xrcbent = '",g_enterprise,"' AND xrcbsite = '",g_site,"' ",
               "    AND xrcb002 = ? "
   DECLARE xrcb_bc CURSOR FROM g_sql
   
   LET g_sql = "SELECT DISTINCT sel,xmdkdocno,xmdkdocdt,xmdk007,a.pmaal004,xmdk009,b.pmaal004,xmdk008,c.pmaal004, ",
               "                xmdk003,d.oofa011,xmdk004,ooefl003,xmdkownid,e.oofa011,xmdkcrtid,f.oofa011,xmdk035 ",
               "  FROM aicp710_tmp ",
               "       LEFT OUTER JOIN pmaal_t a ON a.pmaalent = '",g_enterprise,"' AND xmdk007 = a.pmaal001 AND a.pmaal002 = '",g_dlang,"' ",
               "       LEFT OUTER JOIN pmaal_t b ON b.pmaalent = '",g_enterprise,"' AND xmdk009 = b.pmaal001 AND b.pmaal002 = '",g_dlang,"' ",
               "       LEFT OUTER JOIN pmaal_t c ON c.pmaalent = '",g_enterprise,"' AND xmdk008 = c.pmaal001 AND c.pmaal002 = '",g_dlang,"' ",
               "       LEFT OUTER JOIN oofa_t d ON d.oofaent = '",g_enterprise,"' AND d.oofa002 = '2' AND d.oofa003 = xmdk003 ",
               "       LEFT OUTER JOIN ooefl_t ON ooeflent = '",g_enterprise,"' AND ooefl001 = xmdk004 AND ooefl002 = '",g_dlang,"' ",
               "       LEFT OUTER JOIN oofa_t e ON e.oofaent = '",g_enterprise,"' AND e.oofa002 = '2' AND e.oofa003 = xmdkownid ",
               "       LEFT OUTER JOIN oofa_t f ON f.oofaent = '",g_enterprise,"' AND f.oofa002 = '2' AND f.oofa003 = xmdkcrtid ",
               " WHERE ",g_wc_filter,
               " ORDER BY xmdkdocno,xmdkdocdt "
               
   #end add-point
 
   PREPARE aicp710_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aicp710_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空
   CALL g_detail2_d.clear()  
   LET g_master_idx = 1   
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO 
   #add-point:b_fill段foreach_into
   g_detail_d[l_ac].sel,g_detail_d[l_ac].xmdkdocno,g_detail_d[l_ac].xmdkdocdt,
   g_detail_d[l_ac].xmdk007,g_detail_d[l_ac].xmdk007_desc,
   g_detail_d[l_ac].xmdk009,g_detail_d[l_ac].xmdk009_desc,
   g_detail_d[l_ac].xmdk008,g_detail_d[l_ac].xmdk008_desc,
   g_detail_d[l_ac].xmdk003,g_detail_d[l_ac].xmdk003_desc,
   g_detail_d[l_ac].xmdk004,g_detail_d[l_ac].xmdk004_desc,
   g_detail_d[l_ac].xmdkownid,g_detail_d[l_ac].xmdkownid_desc,
   g_detail_d[l_ac].xmdkcrtid,g_detail_d[l_ac].xmdkcrtid_desc,
   g_detail_d[l_ac].xmdk035  
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
      #不能存在於AR
      LET l_cnt = ''
      OPEN xrcb_bc USING g_detail_d[l_ac].xmdkdocno
      FETCH xrcb_bc INTO l_cnt
      if cl_null(l_cnt) then let l_cnt = 0 end if
      IF l_cnt <> 0 THEN
         CONTINUE FOREACH
      END IF
      #end add-point
      
      CALL aicp710_detail_show()      
 
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
   CLOSE xrcb_bc
   CALL g_detail_d.deleteElement(g_detail_d.getLength())
   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aicp710_sel
   
   LET l_ac = 1
   CALL aicp710_fetch()
   #add-point:b_fill段資料填充(其他單身)

   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aicp710.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aicp710_fetch()
 
   DEFINE li_ac           LIKE type_t.num5
   #add-point:fetch段define
   
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後
   IF g_detail_d.getLength() = 0 THEN
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_sql = "SELECT xmdlseq,xmdl001,xmdl002,xmdl003,xmdl004,xmdl005,xmdl006,xmdl007, ",
               "       xmdl008,imaal003,imaal004,xmdl009,xmdl033,xmdl017,a.oocal003,xmdl018, ",
               "       xmdl019,b.oocal003,xmdl020,xmdl010,xmdl021,c.oocal003,xmdl022,xmdl030,xmdl031,xmdl032,xmdl051 ",
               "  FROM xmdl_t ",
               "       LEFT OUTER JOIN imaal_t ON xmdlent = imaalent AND xmdl008 = imaal001 AND imaal002 = '",g_dlang,"' ",
               "       LEFT OUTER JOIN oocal_t a ON xmdlent = a.oocalent AND xmdl017 = a.oocal001 AND a.oocal002 = '",g_dlang,"' ",
               "       LEFT OUTER JOIN oocal_t b ON xmdlent = b.oocalent AND xmdl019 = b.oocal001 AND b.oocal002 = '",g_dlang,"' ",
               "       LEFT OUTER JOIN oocal_t c ON xmdlent = c.oocalent AND xmdl021 = c.oocal001 AND c.oocal002 = '",g_dlang,"' ",
               " WHERE xmdlent = '",g_enterprise,"'",
               "   AND xmdldocno = '",g_detail_d[g_master_idx].xmdkdocno,"'"
   PREPARE xmdl_fill_pre FROM g_sql
   DECLARE xmdl_fill_cur CURSOR FOR xmdl_fill_pre
   FOREACH xmdl_fill_cur INTO 
      g_detail2_d[l_ac].xmdlseq,g_detail2_d[l_ac].xmdl001,g_detail2_d[l_ac].xmdl002,g_detail2_d[l_ac].xmdl003,
      g_detail2_d[l_ac].xmdl004,g_detail2_d[l_ac].xmdl005,g_detail2_d[l_ac].xmdl006,g_detail2_d[l_ac].xmdl007,
      g_detail2_d[l_ac].xmdl008,g_detail2_d[l_ac].xmdl008_desc,g_detail2_d[l_ac].xmdl008_desc_desc,
      g_detail2_d[l_ac].xmdl009,g_detail2_d[l_ac].xmdl033,g_detail2_d[l_ac].xmdl017,g_detail2_d[l_ac].xmdl017_desc,
      g_detail2_d[l_ac].xmdl018,g_detail2_d[l_ac].xmdl019,g_detail2_d[l_ac].xmdl019_desc,g_detail2_d[l_ac].xmdl020,
      g_detail2_d[l_ac].xmdl010,g_detail2_d[l_ac].xmdl021,g_detail2_d[l_ac].xmdl021_desc,g_detail2_d[l_ac].xmdl022,
      g_detail2_d[l_ac].xmdl030,g_detail2_d[l_ac].xmdl031,g_detail2_d[l_ac].xmdl032,g_detail2_d[l_ac].xmdl051
   
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
 
{<section id="aicp710.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aicp710_detail_show()
   #add-point:show段define
   
   #end add-point
 
   #add-point:detail_show段
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aicp710.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aicp710_filter()
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
   
   CONSTRUCT g_wc_filter ON xmdkdocno,xmdkdocdt,xmdk007,xmdk009,xmdk008,xmdk003,xmdk004,xmdkownid,xmdkcrtid,xmdk035
        FROM s_detail1[1].b_xmdkdocno,s_detail1[1].b_xmdkdocdt,s_detail1[1].b_xmdk007  ,s_detail1[1].b_xmdk009  ,s_detail1[1].b_xmdk008,
             s_detail1[1].b_xmdk003  ,s_detail1[1].b_xmdk004  ,s_detail1[1].b_xmdkownid,s_detail1[1].b_xmdkcrtid,s_detail1[1].b_xmdk035
           
      BEFORE CONSTRUCT
      
         ON ACTION controlp INFIELD b_xmdkdocno
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = g_aicp710_sel
            CALL q_xmdkdocno_4()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmdkdocno  #顯示到畫面上
            NEXT FIELD b_xmdkdocno                     #返回原欄位    
            
         ON ACTION controlp INFIELD b_xmdk007
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_site
            CALL q_pmaa001_6()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmdk007  #顯示到畫面上
            NEXT FIELD b_xmdk007                     #返回原欄位
            
         ON ACTION controlp INFIELD b_xmdk009
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg2 = g_site
            CALL q_pmac002_6()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmdk009  #顯示到畫面上
            NEXT FIELD b_xmdk009                     #返回原欄位
   
         ON ACTION controlp INFIELD b_xmdk008
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg2 = g_site
            CALL q_pmac002_5()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmdk008  #顯示到畫面上
            NEXT FIELD b_xmdk008                     #返回原欄位
   
         ON ACTION controlp INFIELD b_xmdk003
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmdk003  #顯示到畫面上
            NEXT FIELD b_xmdk003                     #返回原欄位
            
         ON ACTION controlp INFIELD b_xmdk004
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmdk004  #顯示到畫面上
            NEXT FIELD b_xmdk004                     #返回原欄位
            
         ON ACTION controlp INFIELD b_xmdkownid
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmdkownid  #顯示到畫面上
            NEXT FIELD b_xmdkownid                     #返回原欄位
   
         ON ACTION controlp INFIELD b_xmdkcrtid
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                            #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmdkcrtid  #顯示到畫面上
            NEXT FIELD b_xmdkcrtid                     #返回原欄位
         
         ON ACTION controlp INFIELD b_xmdk035
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '6'
            CALL q_xmdk035()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmdk035    #顯示到畫面上
            NEXT FIELD b_xmdk035                       #返回原欄位

   END CONSTRUCT
   #end add-point    
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   
   CALL aicp710_b_fill()
   CALL aicp710_fetch()
   
END FUNCTION
 
{</section>}
 
{<section id="aicp710.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aicp710_filter_parser(ps_field)
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
 
{<section id="aicp710.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aicp710_filter_show(ps_field,ps_object)
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
   LET ls_condition = aicp710_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aicp710.other_function" >}
#add-point:自定義元件(Function)

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aicp710_process()
# Input parameter: no
# Return code....: no
# Date & Author..: 140610 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp710_process()
DEFINE ls_js          STRING
DEFINE lc_param       type_parameter
DEFINE l_success      LIKE type_t.num5
DEFINE l_tot_success  LIKE type_t.num5
DEFINE l_xmdk  RECORD
   xmdkdocno  LIKE xmdk_t.xmdkdocno, 
   xmdkdocdt  LIKE xmdk_t.xmdkdocdt,
   xmdk007    LIKE xmdk_t.xmdk007,
   xmdk009    LIKE xmdk_t.xmdk009,
   xmdk008    LIKE xmdk_t.xmdk008,
   xmdk003    LIKE xmdk_t.xmdk003,
   xmdk004    LIKE xmdk_t.xmdk004,
   xmdk035    LIKE xmdk_t.xmdk035,
   xmdl088    LIKE xmdl_t.xmdl088
               END RECORD
DEFINE l_xmdk1  RECORD
    xmdksite     LIKE xmdk_t.xmdksite,
    xmdkdocno    LIKE xmdk_t.xmdkdocno,
    xmdkdocdt    LIKE xmdk_t.xmdkdocdt
               END RECORD
DEFINE l_pmds  RECORD
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
   CALL s_azzi902_get_gzzd('aicp710',"lbl_xmdk035") RETURNING g_coll_title[1],g_coll_title[1]    #多角流程序號
   CALL s_azzi902_get_gzzd('aicp710',"lbl_xmdkdocno") RETURNING g_coll_title[2],g_coll_title[2]  #銷退單號
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

   #有選擇的銷退"交易序號"
   LET g_sql = " SELECT DISTINCT xmdkdocno,xmdkdocdt,xmdk007,xmdk009,xmdk008,xmdk003,xmdk004,xmdk035,xmdl088 ",
               "  FROM aicp710_tmp WHERE sel = 'Y' ORDER BY xmdkdocno "
   PREPARE aicp710_process_pre FROM g_sql
   DECLARE aicp710_process_cur CURSOR WITH HOLD FOR aicp710_process_pre

   #各站之銷退符合上述之"交易序號"者
   LET g_sql = " SELECT xmdksite,xmdkdocno,xmdkdocdt ",
               "   FROM xmdk_t ",
               "  WHERE xmdkent = '",g_enterprise,"' ",
               "    AND xmdk000 = '6' ",
               "    AND xmdk035 = ? ",
               "    AND xmdkdocno <> ?"
   PREPARE aicp710_process_xmdk_pre FROM g_sql
   DECLARE aicp710_process_xmdk_cur CURSOR WITH HOLD FOR aicp710_process_xmdk_pre

   #各站之倉退符合上述之"交易序號"者
   LET g_sql = " SELECT pmdssite,pmdsdocno,pmdsdocdt ",
               "   FROM pmds_t ",
               "  WHERE pmdsent = '",g_enterprise,"' ",
               "    AND pmds000 = '7' ",
               "    AND pmds041 = ? "
   PREPARE aicp710_process_pmds_pre FROM g_sql
   DECLARE aicp710_process_pmds_cur CURSOR WITH HOLD FOR aicp710_process_pmds_pre

   #將該流程所有營運據點之符合"多角流程序號"之倉退/銷退單過帳還原,取消確認並刪除,只保留"多角貿易已拋轉"='Y'之該張原始銷退單據
   INITIALIZE l_xmdk.* TO NULL
   FOREACH aicp710_process_cur INTO l_xmdk.xmdkdocno,l_xmdk.xmdkdocdt,l_xmdk.xmdk007,l_xmdk.xmdk009,
                                    l_xmdk.xmdk008,l_xmdk.xmdk003,l_xmdk.xmdk004,l_xmdk.xmdk035,l_xmdk.xmdl088
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
      LET l_success = TRUE
      CALL s_transaction_begin()
      LET g_site = l_g_site
      LET g_prog = 'axmt600'

      UPDATE xmdk_t
         SET xmdk035 = '',
             xmdk083 = 'N'
       WHERE xmdkent = g_enterprise
         AND xmdkdocno = l_xmdk.xmdkdocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "update xmdk_t"
         LET g_errparam.coll_vals[1] = l_xmdk.xmdk035
         LET g_errparam.coll_vals[2] = l_xmdk.xmdkdocno
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET l_success = FALSE
         CONTINUE FOREACH
      END IF

      INITIALIZE l_pmds.* TO NULL
      FOREACH aicp710_process_pmds_cur USING l_xmdk.xmdk035 INTO l_pmds.pmdssite,l_pmds.pmdsdocno,l_pmds.pmdsdocdt
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'pmds_cur'
            LET g_errparam.popup = TRUE
            LET g_errparam.coll_vals[1] = l_xmdk.xmdk035
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         LET g_site = l_pmds.pmdssite
         LET g_argv[1] = '7'
         LET g_prog = 'apmt580'
         
         UPDATE pmds_t
            SET pmds041 = '',
                pmds050 = 'N'
          WHERE pmdsent = g_enterprise
            AND pmdsdocno = l_pmds.pmdsdocno
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'UPDATE pmds_t'
            LET g_errparam.popup = TRUE
            LET g_errparam.coll_vals[1] = l_xmdk.xmdk035
            LET g_errparam.coll_vals[3] = l_pmds.pmdsdocno
            CALL cl_err()
            LET l_success = FALSE
            CONTINUE FOREACH
         END IF
         
         IF NOT s_apmt520_unposted_chk(l_pmds.pmdsdocno) THEN
            LET l_success = FALSE
            CONTINUE FOREACH
         END IF
         IF NOT s_apmt520_unposted_upd(l_pmds.pmdsdocno) THEN
            LET l_success = FALSE
            CONTINUE FOREACH
         END IF
         IF NOT s_apmt520_unconf_chk(l_pmds.pmdsdocno) THEN
            LET l_success = FALSE
            CONTINUE FOREACH
         END IF
         IF NOT s_apmt520_unconf_upd(l_pmds.pmdsdocno) THEN
            LET l_success = FALSE
            CONTINUE FOREACH
         END IF
         IF cl_get_para(g_enterprise,g_site,'E-BAS-0018') = 'N' THEN
            #多角單據流水號保持一致='N'時，做作廢處理
            IF NOT s_apmt520_invalid_chk(l_pmds.pmdsdocno) THEN
               LET l_success = FALSE
               CONTINUE FOREACH
            END IF
            IF NOT s_apmt520_invalid_upd(l_pmds.pmdsdocno) THEN
               LET l_success = FALSE
               CONTINUE FOREACH
            END IF
         ELSE
            IF NOT aicp710_del_pmds(l_pmds.pmdsdocno,l_pmds.pmdsdocdt) THEN
               LET l_success = FALSE
               CONTINUE FOREACH
            END IF
         END IF
         
         INITIALIZE l_pmds.* TO NULL
      END FOREACH

      INITIALIZE l_xmdk1.* TO NULL
      FOREACH aicp710_process_xmdk_cur USING l_xmdk.xmdk035,l_xmdk.xmdkdocno INTO l_xmdk1.xmdksite,l_xmdk1.xmdkdocno,l_xmdk1.xmdkdocdt
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'xmdk_cur'
            LET g_errparam.popup = TRUE
            LET g_errparam.coll_vals[1] = l_xmdk.xmdk035
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         LET g_site = l_xmdk1.xmdksite
         LET g_prog = 'axmt600'
         
         UPDATE xmdk_t
            SET xmdk035 = '',
                xmdk083 = 'N'
          WHERE xmdkent = g_enterprise
            AND xmdkdocno = l_xmdk1.xmdkdocno
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'UPDATE xmdk_t'
            LET g_errparam.popup = TRUE
            LET g_errparam.coll_vals[1] = l_xmdk.xmdk035
            LET g_errparam.coll_vals[2] = l_xmdk1.xmdkdocno
            CALL cl_err()
            LET l_success = FALSE
            CONTINUE FOREACH
         END IF
         
         IF NOT s_axmt600_unpost_chk(l_xmdk1.xmdkdocno) THEN
            LET l_success = FALSE
            CONTINUE FOREACH
         END IF
         IF NOT s_axmt600_unpost_upd(l_xmdk1.xmdkdocno) THEN
            LET l_success = FALSE
            CONTINUE FOREACH
         END IF
         IF NOT s_axmt600_unconf_chk(l_xmdk1.xmdkdocno) THEN
            LET l_success = FALSE
            CONTINUE FOREACH
         END IF
         IF NOT s_axmt600_unconf_upd(l_xmdk1.xmdkdocno) THEN
            LET l_success = FALSE
            CONTINUE FOREACH
         END IF
         IF cl_get_para(g_enterprise,g_site,'E-BAS-0018') = 'N' THEN
            #多角單據流水號保持一致='N'時，做作廢處理
            IF NOT s_axmt600_invalid_chk(l_xmdk1.xmdkdocno) THEN
               LET l_success = FALSE
               CONTINUE FOREACH
            END IF
            IF NOT s_axmt600_invalid_upd(l_xmdk1.xmdkdocno) THEN
               LET l_success = FALSE
               CONTINUE FOREACH
            END IF
         ELSE
            IF NOT aicp710_del_xmdk(l_xmdk1.xmdkdocno,l_xmdk1.xmdkdocdt) THEN
               LET l_success = FALSE
               CONTINUE FOREACH
            END IF
         END IF
                  
         INITIALIZE l_xmdk1.* TO NULL
      END FOREACH
               
      IF l_success THEN
         CALL s_aic_carry_deletetrino(l_xmdk.xmdk035,'6') RETURNING l_success
      END IF
      
      IF g_bgjob = "N" THEN
         IF l_success THEN
            CALL s_transaction_end('Y',0)
            CALL aicp710_success(l_xmdk.xmdkdocno,l_xmdk.xmdkdocdt,l_xmdk.xmdk007,l_xmdk.xmdk009,l_xmdk.xmdk008,l_xmdk.xmdk003,l_xmdk.xmdk004)
         ELSE
            CALL s_transaction_end('N',0)
            CALL aicp710_fail(l_xmdk.xmdkdocno,l_xmdk.xmdkdocdt,l_xmdk.xmdk007,l_xmdk.xmdk009,l_xmdk.xmdk008,l_xmdk.xmdk003,l_xmdk.xmdk004,l_xmdk.xmdk035)
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

      INITIALIZE l_xmdk.* TO NULL
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
# Descriptions...: 將順利產生成功之單據資料顯示於執行成功頁籤
# Memo...........:
# Usage..........: CALL aicp710_success(p_xmdkdocno,p_xmdkdocdt,p_xmdk007,p_xmdk009,p_xmdk008,p_xmdk003,p_xmdk004)
# Input parameter: 
# Return code....: 
# Date & Author..: 140610 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp710_success(p_xmdkdocno,p_xmdkdocdt,p_xmdk007,p_xmdk009,p_xmdk008,p_xmdk003,p_xmdk004)
DEFINE p_xmdkdocno LIKE xmdk_t.xmdkdocno 
DEFINE p_xmdkdocdt LIKE xmdk_t.xmdkdocdt
DEFINE p_xmdk007   LIKE xmdk_t.xmdk007
DEFINE p_xmdk009   LIKE xmdk_t.xmdk009
DEFINE p_xmdk008   LIKE xmdk_t.xmdk008
DEFINE p_xmdk003   LIKE xmdk_t.xmdk003
DEFINE p_xmdk004   LIKE xmdk_t.xmdk004

   IF cl_null(g_success_cnt) THEN
      LET g_success_cnt = 1
   END IF

   LET g_detail3_d[g_success_cnt].xmdkdocno1 = p_xmdkdocno
   LET g_detail3_d[g_success_cnt].xmdkdocdt1 = p_xmdkdocdt
   LET g_detail3_d[g_success_cnt].xmdk0071   = p_xmdk007
   LET g_detail3_d[g_success_cnt].xmdk0091   = p_xmdk009  
   LET g_detail3_d[g_success_cnt].xmdk0081   = p_xmdk008  
   LET g_detail3_d[g_success_cnt].xmdk0031   = p_xmdk003  
   LET g_detail3_d[g_success_cnt].xmdk0041   = p_xmdk004  
   
   #說明
   CALL s_desc_get_trading_partner_abbr_desc(g_detail3_d[g_success_cnt].xmdk0071)
        RETURNING g_detail3_d[g_success_cnt].xmdk0071_desc
   CALL s_desc_get_trading_partner_abbr_desc(g_detail3_d[g_success_cnt].xmdk0091)
        RETURNING g_detail3_d[g_success_cnt].xmdk0091_desc
   CALL s_desc_get_trading_partner_abbr_desc(g_detail3_d[g_success_cnt].xmdk0081)
        RETURNING g_detail3_d[g_success_cnt].xmdk0081_desc
   CALL s_desc_get_person_desc(g_detail3_d[g_success_cnt].xmdk0031)
        RETURNING g_detail3_d[g_success_cnt].xmdk0031_desc
   CALL s_desc_get_department_desc(g_detail3_d[g_success_cnt].xmdk0041)
        RETURNING g_detail3_d[g_success_cnt].xmdk0041_desc
   
   LET g_success_cnt = g_success_cnt +  1

END FUNCTION

################################################################################
# Descriptions...: 將產生失敗之單據及原因顯示於執行失敗頁籤
# Memo...........:
# Usage..........: CALL aicp710_fail(p_xmdkdocno,p_xmdkdocdt,p_xmdk007,p_xmdk009,p_xmdk008,p_xmdk003,p_xmdk004,p_xmdk035)
#                  RETURNING r_ac
# Input parameter: 
# Return code....: 
# Date & Author..: 140610 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp710_fail(p_xmdkdocno,p_xmdkdocdt,p_xmdk007,p_xmdk009,p_xmdk008,p_xmdk003,p_xmdk004,p_xmdk035)
DEFINE p_xmdkdocno  LIKE xmdk_t.xmdkdocno 
DEFINE p_xmdkdocdt  LIKE xmdk_t.xmdkdocdt
DEFINE p_xmdk007    LIKE xmdk_t.xmdk007
DEFINE p_xmdk009    LIKE xmdk_t.xmdk009
DEFINE p_xmdk008    LIKE xmdk_t.xmdk008
DEFINE p_xmdk003    LIKE xmdk_t.xmdk003
DEFINE p_xmdk004    LIKE xmdk_t.xmdk004
DEFINE p_xmdk035    LIKE xmdk_t.xmdk035
DEFINE l_errcode    LIKE gzze_t.gzze001
DEFINE l_i          LIKE type_t.num5

   IF g_bgjob = "N" THEN
      IF cl_null(g_fail_cnt) THEN
         LET g_fail_cnt = 0
      END IF
      
      FOR l_i = g_fail_cnt+1 TO g_errcollect.getLength()
         LET g_detail4_d[l_i].xmdkdocno2 = p_xmdkdocno
         LET g_detail4_d[l_i].xmdkdocdt2 = p_xmdkdocdt
         LET g_detail4_d[l_i].xmdk0072   = p_xmdk007
         LET g_detail4_d[l_i].xmdk0092   = p_xmdk009  
         LET g_detail4_d[l_i].xmdk0082   = p_xmdk008  
         LET g_detail4_d[l_i].xmdk0032   = p_xmdk003  
         LET g_detail4_d[l_i].xmdk0042   = p_xmdk004  
         LET g_detail4_d[l_i].xmdk0352   = p_xmdk035  
      
         #錯誤訊息
#         LET l_errcode = g_errcollect[l_i].code
#         LET g_detail4_d[l_i].reason = cl_getmsg(l_errcode,g_dlang)
         LET g_detail4_d[l_i].reason = g_errcollect[l_i].message
      
         #說明
         CALL s_desc_get_trading_partner_abbr_desc(g_detail4_d[l_i].xmdk0072)
              RETURNING g_detail4_d[l_i].xmdk0072_desc
         CALL s_desc_get_trading_partner_abbr_desc(g_detail4_d[l_i].xmdk0092)
              RETURNING g_detail4_d[l_i].xmdk0092_desc
         CALL s_desc_get_trading_partner_abbr_desc(g_detail4_d[l_i].xmdk0082)
              RETURNING g_detail4_d[l_i].xmdk0082_desc
         CALL s_desc_get_person_desc(g_detail4_d[l_i].xmdk0032)
              RETURNING g_detail4_d[l_i].xmdk0032_desc
         CALL s_desc_get_department_desc(g_detail4_d[l_i].xmdk0042)
              RETURNING g_detail4_d[l_i].xmdk0042_desc
      END FOR
   END IF

END FUNCTION

################################################################################
# Descriptions...: 刪除銷退單據
# Memo...........:
# Usage..........: CALL aicp710_del_xmdk(p_xmdkdocno,p_xmdkdocdt)
#                  RETURNING r_success
# Input parameter: p_xmdkdocno,p_xmdkdocdt
# Return code....: r_success
# Date & Author..: 141110 By whitney
# Modify.........: 150917-00001#4 151123 earl 加入製造批序號拋轉還原
################################################################################
PRIVATE FUNCTION aicp710_del_xmdk(p_xmdkdocno,p_xmdkdocdt)
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
# Usage..........: CALL aicp710_del_pmds(p_pmdsdocno,p_pmdsdocdt)
#                  RETURNING r_success
# Input parameter: p_pmdsodcno,p_pmdsdocdt
# Return code....: r_success
# Date & Author..: 141110 By whitney
# Modify.........: 150917-00001#4 151123 earl 加入製造批序號拋轉還原
################################################################################
PRIVATE FUNCTION aicp710_del_pmds(p_pmdsdocno,p_pmdsdocdt)
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
PRIVATE FUNCTION aicp710_create_temp_table()
   
   DROP TABLE aicp710_tmp
   CREATE TEMP TABLE aicp710_tmp( 
       sel       LIKE type_t.chr1,
       xmdkdocno LIKE xmdk_t.xmdkdocno, 
       xmdkdocdt LIKE xmdk_t.xmdkdocdt,
       xmdk007   LIKE xmdk_t.xmdk007,
       xmdk009   LIKE xmdk_t.xmdk009,
       xmdk008   LIKE xmdk_t.xmdk008,
       xmdk003   LIKE xmdk_t.xmdk003,
       xmdk004   LIKE xmdk_t.xmdk004,
       xmdkownid LIKE xmdk_t.xmdkownid,
       xmdkcrtid LIKE xmdk_t.xmdkcrtid,
       xmdk035   LIKE xmdk_t.xmdk035,
       xmdl088   LIKE xmdl_t.xmdl088
       );
END FUNCTION

#單號過濾條件
PRIVATE FUNCTION aicp710_sel()
  #LET g_aicp710_sel = " xmdkent = ",g_enterprise,"' AND xmdksite = '",g_site,"'",                                #161231-00013#1 mark
   LET g_aicp710_sel = " xmdkent = ",g_enterprise," AND xmdksite = '",g_site,"'",cl_sql_add_filter("xmdk_t"),     #161231-00013#1 add 
                       " AND xmdk083 = 'Y' AND xmdk000 = '6' AND xmdk035 IS NOT NULL ",
                       " AND xmdk045 IN ('2','7') "
END FUNCTION

#end add-point
 
{</section>}
 
