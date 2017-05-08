#該程式已解開Section, 不再透過樣板產出!
{<section id="aicp700.description" >}
#+ Version..: T100-ERP-1.00.00(SD版次:1,PD版次:1) Build-000055
#+ 
#+ Filename...: aicp700
#+ Description: 多角貿易出貨通知單拋轉作業
#+ Creator....: 02295(2014/05/08)
#+ Modifier...: 02295(2014/05/08)
#+ Buildtype..: 應用 p02 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="aicp700.global" >}
#150917-00001#4 151111 earl 修改s_aic_carry_gen_tri_bs與s_aic_carry_gen_tri_mr傳入參數邏輯
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
       xmdk002           LIKE xmdk_t.xmdk002,
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
       xmdk044           LIKE xmdk_t.xmdk044,
       xmdk044_desc      LIKE type_t.chr80
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
       xmdk0041_desc     LIKE type_t.chr80,
       xmdk035           LIKE xmdk_t.xmdk035
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
       xmdk0442          LIKE xmdk_t.xmdk044,
       xmdk0442_desc     LIKE type_t.chr80,
       reason            LIKE type_t.chr500
                      END RECORD

DEFINE g_detail2_d  DYNAMIC ARRAY OF type_g_detail2_d
DEFINE g_detail3_d  DYNAMIC ARRAY OF type_g_detail3_d
DEFINE g_detail4_d  DYNAMIC ARRAY OF type_g_detail4_d
DEFINE g_detail2_idx     LIKE type_t.num5
DEFINE g_detail3_idx     LIKE type_t.num5
DEFINE g_detail4_idx     LIKE type_t.num5
DEFINE g_detail2_cnt     LIKE type_t.num5
DEFINE g_detail3_cnt     LIKE type_t.num5
DEFINE g_detail4_cnt     LIKE type_t.num5

DEFINE g_success_cnt     LIKE type_t.num5
DEFINE g_fail_cnt        LIKE type_t.num5

DEFINE g_aicp700_sel     STRING

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num5              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明

#end add-point
 
{</section>}
 
{<section id="aicp700.main" >}
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
   
   CALL aicp700_create_temp_table()
   
   CALL aicp700_sel()
   
   IF NOT cl_null(g_argv[1]) THEN
      LET g_bgjob = 'Y'
   END IF
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call
      IF NOT cl_null(g_argv[1]) THEN
         LET g_wc = " xmdkdocno = '",g_argv[1],"' "
         CALL aicp700_query()
         UPDATE aicp700_tmp
            SET sel = 'Y'
         CALL aicp700_process()
      END IF
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aicp700 WITH FORM cl_ap_formpath("aic",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aicp700_init()   
 
      #進入選單 Menu (="N")
      CALL aicp700_ui_dialog() 
 
      #add-point:畫面關閉前
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aicp700
   END IF 
   
   #add-point:作業離開前
   DROP TABLE aicp700_tmp
   CALL s_aic_carry_drop_temp_table_ship()   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aicp700.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aicp700_init()
   #add-point:init段define
   DEFINE l_success  LIKE type_t.num5
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
 
{<section id="aicp700.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aicp700_ui_dialog()
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

         CONSTRUCT BY NAME g_wc ON xmdkdocno,xmdkdocdt,xmdk007,xmdk009,xmdk008,xmdk003,xmdk004,xmdkownid,xmdkcrtid,xmdk044

            BEFORE CONSTRUCT
            
            ON ACTION controlp INFIELD xmdkdocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '6'                #銷退單
               LET g_qryparam.arg2 = 'Y'
               LET g_qryparam.where = g_aicp700_sel
               CALL q_xmdkdocno_2()                     #呼叫開窗
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
               CALL q_ooag001()                          #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdkcrtid  #顯示到畫面上
               NEXT FIELD xmdkcrtid                     #返回原欄位
            
            ON ACTION controlp INFIELD xmdk044
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '1'
               LET g_qryparam.arg2 = '0'
               CALL q_icaa001_1()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdk044    #顯示到畫面上
               NEXT FIELD xmdk044                       #返回原欄位
   
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
               CALL aicp700_fetch()               

            ON CHANGE b_sel
               UPDATE aicp700_tmp 
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
            
            CALL aicp700_sel()
            
            #end add-point
 
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
            END FOR
            #add-point:ui_dialog段on action selall
            UPDATE aicp700_tmp 
               SET sel = 'Y'
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "N"
            END FOR
            #add-point:ui_dialog段on action selnone
            UPDATE aicp700_tmp 
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
                  UPDATE aicp700_tmp 
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
                  UPDATE aicp700_tmp 
                     SET sel = 'N' 
                   WHERE xmdkdocno = g_detail_d[li_idx].xmdkdocno
               END IF
            END FOR
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL aicp700_filter()
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
            CALL aicp700_query()
 
         # 條件清除
         ON ACTION qbeclear
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            CALL aicp700_b_fill()
            CALL aicp700_fetch()
 
         #add-point:ui_dialog段action
         ON ACTION batch_execute
            #變更此筆資料後，直接按執行
            IF l_ac > 0 THEN
               UPDATE aicp700_tmp
                  SET sel = g_detail_d[l_ac].sel
                WHERE xmdkdocno = g_detail_d[l_ac].xmdkdocno
            END IF
           
            LET l_cnt = ''
            SELECT COUNT(*) INTO l_cnt
              FROM aicp700_tmp
             WHERE sel = 'Y'
            IF cl_null(l_cnt) OR l_cnt = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = '-400'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               CONTINUE DIALOG
            ELSE
               CALL aicp700_process()
               LET INT_FLAG = TRUE     #170213-00043#1 17/02/15 By 08171 add
               CALL aicp700_query()
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
 
{<section id="aicp700.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aicp700_query()
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define

   #end add-point 
   
   #add-point:cs段after_construct
   DELETE FROM aicp700_tmp;
   LET g_sql = "SELECT DISTINCT 'N',xmdkdocno,xmdkdocdt,xmdk002,xmdk007,xmdk009,xmdk008,xmdk003,xmdk004,xmdkownid,xmdkcrtid,xmdk044 ",
               "  FROM xmdk_t ",
               " WHERE ",g_aicp700_sel,
               "   AND ",g_wc
   
   LET g_sql = "INSERT INTO aicp700_tmp ",g_sql
   PREPARE tmp_ins_pre FROM g_sql
   EXECUTE tmp_ins_pre

   LET g_wc_filter = " 1=1"
   #end add-point
        
   LET g_error_show = 1
   CALL aicp700_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="aicp700.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aicp700_b_fill()
 
   DEFINE ls_wc           STRING
   #add-point:b_fill段define

   #end add-point
 
   #add-point:b_fill段sql_before
   LET g_sql = "SELECT DISTINCT sel,xmdkdocno,xmdkdocdt,xmdk002,xmdk007,a.pmaal004,xmdk009,b.pmaal004,xmdk008,c.pmaal004, ",
               "                xmdk003,d.oofa011,xmdk004,ooefl003,xmdkownid,e.oofa011,xmdkcrtid,f.oofa011,xmdk044,icaal003 ",
               "  FROM aicp700_tmp ",
               "       LEFT OUTER JOIN pmaal_t a ON a.pmaalent = '",g_enterprise,"' AND xmdk007 = a.pmaal001 AND a.pmaal002 = '",g_dlang,"' ",
               "       LEFT OUTER JOIN pmaal_t b ON b.pmaalent = '",g_enterprise,"' AND xmdk009 = b.pmaal001 AND b.pmaal002 = '",g_dlang,"' ",
               "       LEFT OUTER JOIN pmaal_t c ON c.pmaalent = '",g_enterprise,"' AND xmdk008 = c.pmaal001 AND c.pmaal002 = '",g_dlang,"' ",
               "       LEFT OUTER JOIN oofa_t d ON d.oofaent = '",g_enterprise,"' AND d.oofa002 = '2' AND d.oofa003 = xmdk003 ",
               "       LEFT OUTER JOIN ooefl_t ON ooeflent = '",g_enterprise,"' AND ooefl001 = xmdk004 AND ooefl002 = '",g_dlang,"' ",
               "       LEFT OUTER JOIN oofa_t e ON e.oofaent = '",g_enterprise,"' AND e.oofa002 = '2' AND e.oofa003 = xmdkownid ",
               "       LEFT OUTER JOIN oofa_t f ON f.oofaent = '",g_enterprise,"' AND f.oofa002 = '2' AND f.oofa003 = xmdkcrtid ",
               "       LEFT OUTER JOIN icaal_t ON icaalent = '",g_enterprise,"' AND icaal001 = xmdk044 AND icaal002 = '",g_dlang,"' ",
               " WHERE ",g_wc_filter,
               " ORDER BY xmdkdocno,xmdkdocdt "
               
   #end add-point
 
   PREPARE aicp700_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aicp700_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空
   LET g_master_idx = 1   
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO 
   #add-point:b_fill段foreach_into
   g_detail_d[l_ac].sel,g_detail_d[l_ac].xmdkdocno,g_detail_d[l_ac].xmdkdocdt,
   g_detail_d[l_ac].xmdk002,g_detail_d[l_ac].xmdk007,g_detail_d[l_ac].xmdk007_desc,
   g_detail_d[l_ac].xmdk009,g_detail_d[l_ac].xmdk009_desc,
   g_detail_d[l_ac].xmdk008,g_detail_d[l_ac].xmdk008_desc,
   g_detail_d[l_ac].xmdk003,g_detail_d[l_ac].xmdk003_desc,
   g_detail_d[l_ac].xmdk004,g_detail_d[l_ac].xmdk004_desc,
   g_detail_d[l_ac].xmdkownid,g_detail_d[l_ac].xmdkownid_desc,
   g_detail_d[l_ac].xmdkcrtid,g_detail_d[l_ac].xmdkcrtid_desc,
   g_detail_d[l_ac].xmdk044,g_detail_d[l_ac].xmdk044_desc  
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

      #end add-point
      
      CALL aicp700_detail_show()      
 
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
   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aicp700_sel
   
   LET l_ac = 1
   CALL aicp700_fetch()
   #add-point:b_fill段資料填充(其他單身)

   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aicp700.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aicp700_fetch()
 
   DEFINE li_ac           LIKE type_t.num5
   #add-point:fetch段define
 
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後
   IF g_detail_d.getLength() = 0 THEN
      RETURN
   END IF
   
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
   
   CALL g_detail2_d.clear()
   LET l_ac = 1
   
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
 
{<section id="aicp700.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aicp700_detail_show()
   #add-point:show段define
   
   #end add-point
 
   #add-point:detail_show段
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aicp700.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aicp700_filter()
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
   
   CONSTRUCT g_wc_filter ON xmdkdocno,xmdkdocdt,xmdk007,xmdk009,xmdk008,xmdk003,xmdk004,xmdkownid,xmdkcrtid,xmdk044
        FROM s_detail1[1].b_xmdkdocno,s_detail1[1].b_xmdkdocdt,s_detail1[1].b_xmdk007,
             s_detail1[1].b_xmdk009,s_detail1[1].b_xmdk008,s_detail1[1].b_xmdk003,
             s_detail1[1].b_xmdk004,s_detail1[1].b_xmdkownid,s_detail1[1].b_xmdkcrtid,s_detail1[1].b_xmdk044
           
      BEFORE CONSTRUCT
      
         ON ACTION controlp INFIELD b_xmdkdocno
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = g_aicp700_sel
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
         
         ON ACTION controlp INFIELD b_xmdk044
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '1'
            LET g_qryparam.arg2 = '0'
            CALL q_icaa001_1()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmdk044    #顯示到畫面上
            NEXT FIELD b_xmdk044                       #返回原欄位

   END CONSTRUCT
   #end add-point    
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   
   CALL aicp700_b_fill()
   CALL aicp700_fetch()
   
END FUNCTION
 
{</section>}
 
{<section id="aicp700.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aicp700_filter_parser(ps_field)
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
 
{<section id="aicp700.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aicp700_filter_show(ps_field,ps_object)
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
   LET ls_condition = aicp700_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aicp700.other_function" >}
#add-point:自定義元件(Function)

################################################################################
# Descriptions...: 將來源據點之多角銷退單拋轉至各站據點
# Memo...........:
# Usage..........: CALL aicp700_process()
# Input parameter: no
# Return code....: no
# Date & Author..: 141106 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp700_process()
DEFINE ls_js          STRING
DEFINE lc_param       type_parameter
DEFINE l_success      LIKE type_t.num5      #回傳執行結果
DEFINE l_success1     LIKE type_t.num5
DEFINE l_xmdk  RECORD
    xmdkdocno LIKE xmdk_t.xmdkdocno, 
    xmdkdocdt LIKE xmdk_t.xmdkdocdt,
    xmdk002   LIKE xmdk_t.xmdk002,
    xmdk007   LIKE xmdk_t.xmdk007,
    xmdk009   LIKE xmdk_t.xmdk009,
    xmdk008   LIKE xmdk_t.xmdk008,
    xmdk003   LIKE xmdk_t.xmdk003,
    xmdk004   LIKE xmdk_t.xmdk004,
    xmdk044   LIKE xmdk_t.xmdk044
             END RECORD
DEFINE l_trino        LIKE pmdl_t.pmdl031   #多角流程序號
DEFINE l_pmdsdocno    LIKE pmds_t.pmdsdocno
DEFINE l_xmdkdocno    LIKE xmdk_t.xmdkdocno
DEFINE l_icab002_max  LIKE icab_t.icab002   #最終站別
DEFINE l_icab002_now  LIKE icab_t.icab002   #當站站別
DEFINE l_icab003_now  LIKE icab_t.icab003   #當站營運據點
DEFINE l_icab002_next LIKE icab_t.icab002   #下站站別
DEFINE l_icab003_next LIKE icab_t.icab003   #下站營運據點

   CALL util.JSON.parse(ls_js,lc_param)

   #預先計算progressbar迴圈次數

   CALL s_tax_recount_tmp()
   CALL s_aic_carry_create_temp_table_ship() RETURNING l_success
   IF NOT l_success THEN
      RETURN
   END IF

   CALL cl_err_collect_init()
   CALL s_azzi902_get_gzzd('aicp700',"lbl_xmdkdocno") RETURNING g_coll_title[1],g_coll_title[1]  #銷退單號
   CALL g_detail3_d.clear()
   CALL g_detail4_d.clear()

   LET g_success_cnt = 1
   LET g_fail_cnt = 0

   #有選擇的銷退單
   LET g_sql = " SELECT xmdkdocno,xmdkdocdt,xmdk002,xmdk007,xmdk009,xmdk008,xmdk003,xmdk004,xmdk044 ",
               "   FROM aicp700_tmp ",
               "  WHERE sel = 'Y' ",
               "  ORDER BY xmdkdocno,xmdkdocdt "
   PREPARE aicp700_process_pre FROM g_sql
   DECLARE aicp700_process_cur CURSOR WITH HOLD FOR aicp700_process_pre

   #最終站
   LET g_sql = " SELECT MAX(icab002) ",
               "   FROM icab_t ",
               "  WHERE icabent = '",g_enterprise,"' ",
               "    AND icab001 = ? "
   PREPARE aicp700_process_icab002 FROM g_sql
   
   #多角貿易營運據點
   LET g_sql = " SELECT icab003 ",
               "   FROM icab_t ",
               "  WHERE icabent = '",g_enterprise,"' ",
               "    AND icab001 = ? ",
               "    AND icab002 = ? "
   PREPARE aicp700_process_icab003 FROM g_sql

   INITIALIZE l_xmdk.* TO NULL
   FOREACH aicp700_process_cur INTO l_xmdk.xmdkdocno,l_xmdk.xmdkdocdt,l_xmdk.xmdk002,l_xmdk.xmdk007,
                                    l_xmdk.xmdk009,l_xmdk.xmdk008,l_xmdk.xmdk003,l_xmdk.xmdk004,l_xmdk.xmdk044
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'process_cur'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      CALL s_transaction_begin()
      LET g_fail_cnt = g_errcollect.getLength()  #先取得錯誤訊息的長度，大於此長度的表示是這張單子的錯誤訊息
      LET l_success = TRUE
      LET l_trino = ''
      LET l_pmdsdocno = ''
      LET l_xmdkdocno = l_xmdk.xmdkdocno
      
      #呼叫產生多角序號元件取得多角流程序號
      CALL s_aic_carry_gettrino(l_xmdk.xmdk044,'6',g_today,g_site)
           RETURNING l_success1,l_trino
      IF NOT l_success1 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'amm-00001'
         LET g_errparam.coll_vals[1] = l_xmdk.xmdkdocno
         CALL cl_err()
         LET l_success = FALSE
         CALL s_transaction_end('N',0)
         CALL aicp700_fail(l_xmdk.xmdkdocno,l_xmdk.xmdkdocdt,l_xmdk.xmdk007,l_xmdk.xmdk009,l_xmdk.xmdk008,l_xmdk.xmdk003,l_xmdk.xmdk004,l_xmdk.xmdk044)
         CONTINUE FOREACH
      END IF
      
      #並回寫倉退單單頭"多角流程序"欄位,並更新g_site倉退單單頭"多角貿易拋轉"='Y'
      UPDATE xmdk_t SET xmdk083 = 'Y',
                        xmdk035 = l_trino
       WHERE xmdkent = g_enterprise
         AND xmdkdocno = l_xmdk.xmdkdocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'update pmds_t'
         LET g_errparam.coll_vals[1] = l_xmdk.xmdkdocno
         CALL cl_err()
         LET l_success = FALSE
         CALL s_transaction_end('N',0)
         CALL aicp700_fail(l_xmdk.xmdkdocno,l_xmdk.xmdkdocdt,l_xmdk.xmdk007,l_xmdk.xmdk009,l_xmdk.xmdk008,l_xmdk.xmdk003,l_xmdk.xmdk004,l_xmdk.xmdk044)
         CONTINUE FOREACH
      END IF
      
      #最終站別
      LET l_icab002_max = ''
      EXECUTE aicp700_process_icab002 USING l_xmdk.xmdk044 INTO l_icab002_max
      
      LET l_icab002_now = 0
      LET l_icab003_now = ''
      EXECUTE aicp700_process_icab003 USING l_xmdk.xmdk044,l_icab002_now INTO l_icab003_now
      
      #若g_site=來源站(第0站,SiteA),則依站別由小至大
      IF l_icab003_now = g_site THEN #正拋
         #呼叫 s_gen_tri_mr 產生第0站多角倉退單
         CALL s_aic_carry_gen_tri_mr(l_xmdk.xmdkdocno,l_xmdkdocno,'',l_xmdk.xmdkdocdt,l_xmdk.xmdk044,l_icab002_now,'','')
              RETURNING l_success,l_pmdsdocno
         IF l_success THEN
            FOR l_icab002_now = 1 TO l_icab002_max   #151103 earl mod
               LET l_icab002_next = l_icab002_now    #151103 earl mod
               LET l_icab003_next = ''
               EXECUTE aicp700_process_icab003 USING l_xmdk.xmdk044,l_icab002_next INTO l_icab003_next
               
               #呼叫s_gen_tri_bs產生多角銷退單
               CALL s_aic_carry_gen_tri_bs(l_xmdk.xmdkdocno,l_pmdsdocno,'',l_xmdk.xmdk002,l_xmdk.xmdkdocdt,l_xmdk.xmdk044,l_icab002_next,'','')
                    RETURNING l_success,l_xmdkdocno
               IF l_success AND l_icab002_next <> l_icab002_max THEN
                  #呼叫s_gen_tri_mr產生多角倉退單
                  CALL s_aic_carry_gen_tri_mr(l_xmdk.xmdkdocno,l_xmdkdocno,'',l_xmdk.xmdkdocdt,l_xmdk.xmdk044,l_icab002_next,'','')
                       RETURNING l_success,l_pmdsdocno
               END IF
               
               IF NOT l_success THEN
                  EXIT FOR
               END IF
               LET l_icab003_now = l_icab003_next
            END FOR
         END IF
         
      ELSE #逆拋
         LET l_icab002_now = l_icab002_max
         LET l_icab003_now = ''
         EXECUTE aicp700_process_icab003 USING l_xmdk.xmdk044,l_icab002_now INTO l_icab003_now
         #g_site=最終站(第3站,SiteD)
         IF l_icab003_now = g_site THEN
            FOR l_icab002_now = l_icab002_max - 1 TO 0 STEP -1 #151103 earl mod
               LET l_icab002_next = l_icab002_now  #151103 earl mod
               LET l_icab003_next = ''
               EXECUTE aicp700_process_icab003 USING l_xmdk.xmdk044,l_icab002_next INTO l_icab003_next
               
               #呼叫 s_gen_tri_bs 產生多角銷退單
               IF l_icab002_now = l_icab002_max - 1 THEN   #151102 earl add
                  CALL s_aic_carry_gen_tri_bs(l_xmdk.xmdkdocno,'',l_xmdkdocno,l_xmdk.xmdk002,l_xmdk.xmdkdocdt,l_xmdk.xmdk044,l_icab002_next,'','')
                       RETURNING l_success,l_xmdkdocno
               ELSE
                  CALL s_aic_carry_gen_tri_bs(l_xmdk.xmdkdocno,l_pmdsdocno,'',l_xmdk.xmdk002,l_xmdk.xmdkdocdt,l_xmdk.xmdk044,l_icab002_next,'','')
                       RETURNING l_success,l_xmdkdocno
               END IF
               IF l_success THEN
                  #呼叫 s_gen_tri_mr 產生多角倉退單
                  CALL s_aic_carry_gen_tri_mr(l_xmdk.xmdkdocno,l_xmdkdocno,'',l_xmdk.xmdkdocdt,l_xmdk.xmdk044,l_icab002_next,'','')
                       RETURNING l_success,l_pmdsdocno
               END IF
               
               IF NOT l_success THEN
                  EXIT FOR
               END IF
               LET l_icab003_now = l_icab003_next
            END FOR
         END IF
      END IF
      
      IF g_bgjob = 'N' THEN
         IF l_success THEN
            CALL s_transaction_end('Y',0)
            CALL aicp700_success(l_xmdk.xmdkdocno,l_xmdk.xmdkdocdt,l_xmdk.xmdk007,l_xmdk.xmdk009,l_xmdk.xmdk008,l_xmdk.xmdk003,l_xmdk.xmdk004,l_trino)
         ELSE
            CALL s_transaction_end('N',0)
            CALL aicp700_fail(l_xmdk.xmdkdocno,l_xmdk.xmdkdocdt,l_xmdk.xmdk007,l_xmdk.xmdk009,l_xmdk.xmdk008,l_xmdk.xmdk003,l_xmdk.xmdk004,l_xmdk.xmdk044)
         END IF
      ELSE
         IF l_success THEN
            #成功
            CALL s_transaction_end('Y',0)
            CALL cl_ask_pressanykey("aic-00176")    #多角流程拋轉成功！
         ELSE
            #失敗
            CALL s_transaction_end('N',0)
            CALL cl_ask_pressanykey("aic-00177")    #多角流程拋轉失敗！
         END IF
      END IF
      
      INITIALIZE l_xmdk.* TO NULL
   END FOREACH
   
   CALL cl_err_collect_init()
   CALL cl_err_collect_show()

   IF g_bgjob = 'N' THEN
      CALL cl_ask_pressanykey("std-00012")
   END IF

END FUNCTION

################################################################################
# Descriptions...: 失敗記錄
# Memo...........:
# Usage..........: CALL aicp700_fail(p_xmdkdocno,p_xmdkdocdt,p_xmdk007,p_xmdk009,p_xmdk008,p_xmdk003,p_xmdk004,p_xmdk044)
# Input parameter: 
# Return code....: 
# Date & Author..: 141106 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp700_fail(p_xmdkdocno,p_xmdkdocdt,p_xmdk007,p_xmdk009,p_xmdk008,p_xmdk003,p_xmdk004,p_xmdk044)
DEFINE p_xmdkdocno       LIKE xmdk_t.xmdkdocno
DEFINE p_xmdkdocdt       LIKE xmdk_t.xmdkdocdt
DEFINE p_xmdk007         LIKE xmdk_t.xmdk007
DEFINE p_xmdk009         LIKE xmdk_t.xmdk009
DEFINE p_xmdk008         LIKE xmdk_t.xmdk008
DEFINE p_xmdk003         LIKE xmdk_t.xmdk003
DEFINE p_xmdk004         LIKE xmdk_t.xmdk004
DEFINE p_xmdk044         LIKE xmdk_t.xmdk044
DEFINE l_errcode         LIKE gzze_t.gzze001
DEFINE l_i               LIKE type_t.num5

   IF g_bgjob = 'N' THEN
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
         LET g_detail4_d[l_i].xmdk0442   = p_xmdk044  
      
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
         CALL aicp700_get_icaal003(g_detail4_d[l_i].xmdk0442)
              RETURNING g_detail4_d[l_i].xmdk0442_desc
      END FOR
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 多角流程代碼說明
# Memo...........:
# Usage..........: CALL aicp700_get_icaal003(p_icaal001)
#                  RETURNING r_icaal003
# Input parameter: p_icaal001   多角流程代碼
# Return code....: r_icaal003   多角流程代碼說明
# Date & Author..: 141106 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp700_get_icaal003(p_icaal001)
DEFINE p_icaal001  LIKE icaal_t.icaal001

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_icaal001
   CALL ap_ref_array2(g_ref_fields," SELECT icaal003 FROM icaal_t WHERE icaalent = '"||g_enterprise||"' AND icaal001 = ? AND icaal002 = '"||g_dlang||"'","")
        RETURNING g_rtn_fields
   RETURN g_rtn_fields[1]

END FUNCTION

################################################################################
# Descriptions...: 成功記錄
# Memo...........:
# Usage..........: CALL aicp700_success(p_xmdkdocno,p_xmdkdocdt,p_xmdk007,p_xmdk009,p_xmdk008,p_xmdk003,p_xmdk004,p_xmdk035)
# Input parameter: 
# Return code....: 
# Date & Author..: 141106 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp700_success(p_xmdkdocno,p_xmdkdocdt,p_xmdk007,p_xmdk009,p_xmdk008,p_xmdk003,p_xmdk004,p_xmdk035)
DEFINE p_xmdkdocno        LIKE xmdk_t.xmdkdocno
DEFINE p_xmdkdocdt        LIKE xmdk_t.xmdkdocdt
DEFINE p_xmdk007          LIKE xmdk_t.xmdk007
DEFINE p_xmdk009          LIKE xmdk_t.xmdk009
DEFINE p_xmdk008          LIKE xmdk_t.xmdk008
DEFINE p_xmdk003          LIKE xmdk_t.xmdk003
DEFINE p_xmdk004          LIKE xmdk_t.xmdk004
DEFINE p_xmdk035          LIKE xmdk_t.xmdk035

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
   LET g_detail3_d[g_success_cnt].xmdk035    = p_xmdk035  
   
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

#Temp table
PRIVATE FUNCTION aicp700_create_temp_table()
   
   DROP TABLE aicp700_tmp;
   CREATE TEMP TABLE aicp700_tmp( 
       sel        VARCHAR(1),
       xmdkdocno  VARCHAR(20), 
       xmdkdocdt  DATE,
       xmdk002    VARCHAR(10),
       xmdk007    VARCHAR(10),
       xmdk009    VARCHAR(10),
       xmdk008    VARCHAR(10),
       xmdk003    VARCHAR(20),
       xmdk004    VARCHAR(10),
       xmdkownid  VARCHAR(20),
       xmdkcrtid  VARCHAR(20),
       xmdk044    VARCHAR(10)
       );
END FUNCTION

#單號過濾條件
PRIVATE FUNCTION aicp700_sel()
  #LET g_aicp700_sel = " xmdkent = ",g_enterprise,                                 #161231-00013#1 mark
   LET g_aicp700_sel = " xmdkent = ",g_enterprise,cl_sql_add_filter("xmdk_t"),     #161231-00013#1 add 
                       " AND xmdksite = '",g_site,"'",
                       " AND xmdk044 IS NOT NULL",      #多角序號
                       " AND xmdk083 = 'N'",            #多角貿易已拋轉
                       " AND xmdk045 IN ('2','7') ",
                       " AND xmdk000 = '6'",
                       " AND xmdkstus = 'S' ",
                       " AND xmdk082 IN ('1','2')",
                       " AND EXISTS (SELECT 1 ",
                       "               FROM icaa_t,icab_t a",
                       "              WHERE icaaent = a.icabent AND a.icabent = ",g_enterprise,
                       "                AND icaa001 = a.icab001 AND a.icab001 = xmdk044",
                       "                AND a.icab003 = '",g_site,"'",
                       "                AND (icaa003 = '1' OR (icaa003 = '2' AND icaa004 = '2'))",
                       #正拋初始站、逆拋最終站
                       "                AND ((icaa004 = '1' AND a.icab002 = '0') ",
                       "                     OR (icaa004 = '2' AND a.icab002 = (SELECT MAX(b.icab002) ",
                       "                                                          FROM icab_t b",
                       "                                                         WHERE b.icabent = ",g_enterprise,
                       "                                                           AND b.icab001 = icaa001))))"
END FUNCTION

#end add-point
 
{</section>}
 
