#該程式已解開Section, 不再透過樣板產出!
{<section id="aicp910.description" >}
#+ Version..: T100-ERP-1.00.00(SD版次:1,PD版次:1) Build-000055
#+ 
#+ Filename...: aicp910
#+ Description: 統銷統收整批流程處理作業
#+ Creator....: 02295(2014/05/08)
#+ Modifier...: 02295(2014/05/08)
#+ Buildtype..: 應用 p02 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="aicp910.global" >}
#160902-00048#1   2016/09/05 By dorislai     修正SQL少ent的問題
#161013-00051#1   2016/10/18 By shiun        整批調整據點組織開窗
#161231-00013#1   2016/01/11 By 08992        增加azzi850 部門權限控管
#170213-00043#1   2017/02/15 By 08171        若拋轉成功後已無符合的資料則不提示[指定的資料無法查詢到，....] 
 
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
        sel              LIKE type_t.chr1,
        xmdksite         LIKE xmdk_t.xmdksite, 
        xmdksite_desc    LIKE type_t.chr80,
        xmdasite         LIKE xmda_t.xmdasite,
        xmdasite_desc    LIKE type_t.chr80,
        xmdk007          LIKE xmdk_t.xmdk007,
        xmdk007_desc     LIKE type_t.chr80,
        xmdkdocno        LIKE xmdk_t.xmdkdocno,
        xmdkdocdt        LIKE xmdk_t.xmdkdocdt,
        xmdk044          LIKE xmdk_t.xmdk044,
        xmdk044_desc     LIKE type_t.chr100,
        xmdk035          LIKE xmdk_t.xmdk035
                     END RECORD
DEFINE g_detail_d_t         type_g_detail_d

TYPE type_g_detail2_d RECORD
        xmdlseq          LIKE xmdl_t.xmdlseq, 
        xmdl001          LIKE xmdl_t.xmdl001,
        xmdl002          LIKE xmdl_t.xmdl002,
        xmdl003          LIKE xmdl_t.xmdl003,
        xmdl004          LIKE xmdl_t.xmdl004,
        xmdl005          LIKE xmdl_t.xmdl005,
        xmdl006          LIKE xmdl_t.xmdl006,
        xmdl007          LIKE xmdl_t.xmdl007,
        xmdl008          LIKE xmdl_t.xmdl008,
        xmdl008_desc     LIKE type_t.chr80,
        xmdl008_desc_1   LIKE type_t.chr80,
        xmdl009          LIKE xmdl_t.xmdl009,
        xmdl009_desc     LIKE type_t.chr80,
        xmdl033          LIKE xmdl_t.xmdl033,
        xmdl017          LIKE xmdl_t.xmdl017, 
        xmdl018          LIKE xmdl_t.xmdl018,
        xmdl019          LIKE xmdl_t.xmdl019,
        xmdl020          LIKE xmdl_t.xmdl020,
        xmdl010          LIKE xmdl_t.xmdl010,
        xmdl021          LIKE xmdl_t.xmdl021,
        xmdl022          LIKE xmdl_t.xmdl022,
        xmdl030          LIKE xmdl_t.xmdl030,
        xmdl031          LIKE xmdl_t.xmdl031,
        xmdl032          LIKE xmdl_t.xmdl032,
        xmdl051          LIKE xmdl_t.xmdl051
                     END RECORD
DEFINE g_detail2_d          DYNAMIC ARRAY OF type_g_detail2_d
DEFINE g_detail2_cnt        LIKE type_t.num5
DEFINE g_rec_b              LIKE type_t.num5

TYPE type_g_detail3_d RECORD
        xmdksite1        LIKE xmdk_t.xmdksite, 
        xmdksite1_desc   LIKE type_t.chr80,
        xmdasite1        LIKE xmda_t.xmdasite,
        xmdasite1_desc   LIKE type_t.chr80,
        xmdk0071         LIKE xmdk_t.xmdk007,
        xmdk0071_desc    LIKE type_t.chr80,
        xmdkdocno1       LIKE xmdk_t.xmdkdocno,
        xmdkdocdt1         LIKE xmdk_t.xmdkdocdt
                     END RECORD
DEFINE g_detail3_d          DYNAMIC ARRAY OF type_g_detail3_d
DEFINE g_detail3_cnt        LIKE type_t.num5

TYPE type_g_detail4_d RECORD
        xmdksite2        LIKE xmdk_t.xmdksite, 
        xmdksite2_desc   LIKE type_t.chr80,
        xmdasite2        LIKE xmda_t.xmdasite,
        xmdasite2_desc   LIKE type_t.chr80,
        xmdk0072         LIKE xmdk_t.xmdk007,
        xmdk0072_desc    LIKE type_t.chr80,
        xmdkdocno2       LIKE xmdk_t.xmdkdocno,
        xmdkdocdt2       LIKE xmdk_t.xmdkdocdt,
        xmdk0352         LIKE xmdk_t.xmdk035,
        err_site         LIKE xmdk_t.xmdksite,
        err_site_desc    LIKE type_t.chr80,
        reason           LIKE type_t.chr1000
                     END RECORD
DEFINE g_detail4_d          DYNAMIC ARRAY OF type_g_detail4_d
DEFINE g_detail4_cnt        LIKE type_t.num5

DEFINE g_success_cnt        LIKE type_t.num5
DEFINE g_fail_cnt           LIKE type_t.num5

DEFINE g_aicp910_sel        STRING
DEFINE g_aic_doc            LIKE type_t.num5

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num5              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明

#end add-point
 
{</section>}
 
{<section id="aicp910.main" >}
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
   CREATE TEMP TABLE aicp910_tmp( 
       sel               LIKE type_t.chr1,
       xmdksite          LIKE xmdk_t.xmdksite,
       xmdasite          LIKE xmda_t.xmdasite,
       xmdk007           LIKE xmdk_t.xmdk007,
       xmdkdocno         LIKE xmdk_t.xmdkdocno,
       xmdkdocdt         LIKE xmdk_t.xmdkdocdt,
       xmdk044           LIKE xmdk_t.xmdk044,
       xmdk035           LIKE xmdk_t.xmdk035
       )
       
   CALL aicp910_sel()
   
   IF cl_get_para(g_enterprise,'','E-BAS-0018') = 'Y' THEN
      LET g_aic_doc = TRUE
   ELSE
      LET g_aic_doc = FALSE
   END IF
   
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aicp910 WITH FORM cl_ap_formpath("aic",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aicp910_init()   
 
      #進入選單 Menu (="N")
      CALL aicp910_ui_dialog() 
 
      #add-point:畫面關閉前
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aicp910
   END IF 
   
   #add-point:作業離開前
   DROP TABLE aicp910_tmp
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aicp910.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aicp910_init()
   #add-point:init段define
   
   #end add-point   
 
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化
   LET g_errshow = 1
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aicp910.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aicp910_ui_dialog()
   DEFINE li_idx   LIKE type_t.num5
   #add-point:ui_dialog段define
   DEFINE l_cnt       LIKE type_t.num5
   DEFINE l_success   LIKE type_t.num5
   #end add-point 
 
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog 
   LET g_wc = "1=1"
   CALL aicp910_query()   #先塞資料
   #end add-point
   
   WHILE TRUE
 
      CALL cl_dlg_query_bef_disp()  #相關查詢
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct
         CONSTRUCT BY NAME g_wc ON xmdkdocno,xmdkdocdt,xmdksite,xmdasite,xmdk007,xmdk044,xmdk035

            BEFORE CONSTRUCT
            
            ON ACTION controlp INFIELD xmdksite
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
               #mod--161013-00051#1 By shiun--(S)
#               CALL q_ooef001()                           #呼叫開窗
               CALL q_ooef001_1()
               #mod--161013-00051#1 By shiun--(E)
               DISPLAY g_qryparam.return1 TO xmdksite     #顯示到畫面上
               NEXT FIELD xmdksite                        #返回原欄位 
               
            ON ACTION controlp INFIELD xmdasite
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
               #mod--161013-00051#1 By shiun--(S)
#               CALL q_ooef001()                           #呼叫開窗
               CALL q_ooef001_1()
               #mod--161013-00051#1 By shiun--(E)
               DISPLAY g_qryparam.return1 TO xmdasite     #顯示到畫面上
               NEXT FIELD xmdasite                        #返回原欄位 
   
            ON ACTION controlp INFIELD xmdk007
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
			      LET g_qryparam.arg1 = g_site
		         CALL q_pmaa001_6()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdk007      #顯示到畫面上
               NEXT FIELD xmdk007                         #返回原欄位
               
            ON ACTION controlp INFIELD xmdkdocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
			      LET g_qryparam.where = g_aicp910_sel
			      LET g_qryparam.arg1 = '1'
			      CALL q_xmdkdocno_2()                        #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdkdocno     #顯示到畫面上
               NEXT FIELD xmdkdocno                        #返回原欄位
               
            ON ACTION controlp INFIELD xmdk044
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
			      LET g_qryparam.arg1 = '1'
			      LET g_qryparam.arg2 = '2'
			      LET g_qryparam.arg3 = 'N'
			      CALL q_icaa001_2()                        #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdk044     #顯示到畫面上
               NEXT FIELD xmdk044                        #返回原欄位

            ON ACTION controlp INFIELD xmdk035
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
			      LET g_qryparam.arg1 = '1'
			      LET g_qryparam.where = " xmdksite = '",g_site,"'",
			                             " AND xmdk045 = '3' ",
			                             #160902-00048#1-s-mod
			                             #" AND xmdk035 NOT IN (SELECT xmdkdocno FROM xmdk_t WHERE xmdk000 = '1' AND xmdk045 = '3') "
			                             " AND xmdk035 NOT IN (SELECT xmdkdocno FROM xmdk_t WHERE xmdkent='"||g_enterprise||"' AND xmdk000 = '1' AND xmdk045 = '3') "
			                             #160902-00048#1-e-mod
			      
			      CALL q_xmdk035()                          #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdk035     #顯示到畫面上
               NEXT FIELD xmdk035                        #返回原欄位

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
               CALL aicp910_fetch()
               #單身1可編輯，需備份舊值
               LET g_detail_d_t.* = g_detail_d[l_ac].*
               
            ON CHANGE b_sel
               
            ON ROW CHANGE
               UPDATE aicp910_tmp 
                   SET sel = g_detail_d[l_ac].sel, 
                       xmdk044 = g_detail_d[l_ac].xmdk044
                 WHERE xmdkdocno = g_detail_d[l_ac].xmdkdocno 
            
         END INPUT               
         #end add-point
         #add-point:ui_dialog段自定義display array
         DISPLAY ARRAY g_detail2_d TO s_detail2.* ATTRIBUTE(COUNT=g_detail2_cnt)
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               DISPLAY l_ac TO FORMONLY.idx
         END DISPLAY

         DISPLAY ARRAY g_detail3_d TO s_detail3.* ATTRIBUTE(COUNT=g_detail3_cnt)
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               DISPLAY l_ac TO FORMONLY.idx
         END DISPLAY

         DISPLAY ARRAY g_detail4_d TO s_detail4.* ATTRIBUTE(COUNT=g_detail4_cnt)
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
            
            CALL aicp910_sel()
            
            #end add-point
 
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
            END FOR
            #add-point:ui_dialog段on action selall
            UPDATE aicp910_tmp 
               SET sel = 'Y'
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "N"
            END FOR
            #add-point:ui_dialog段on action selnone
            UPDATE aicp910_tmp 
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
                  UPDATE aicp910_tmp 
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
                  UPDATE aicp910_tmp 
                     SET sel = 'N' 
                   WHERE xmdkdocno = g_detail_d[li_idx].xmdkdocno 
               END IF
            END FOR            
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL aicp910_filter()
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
            CALL aicp910_query()
 
         # 條件清除
         ON ACTION qbeclear
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            CALL aicp910_b_fill()
            CALL aicp910_fetch()
 
         #add-point:ui_dialog段action
         ON ACTION batch_execute
            #變更此筆資料後，直接按執行
            IF l_ac > 0 THEN
               UPDATE aicp910_tmp 
                  SET sel = g_detail_d[l_ac].sel
                WHERE xmdkdocno = g_detail_d[l_ac].xmdkdocno
            END IF
            
            LET l_cnt = ''
            SELECT COUNT(*) INTO l_cnt
              FROM aicp910_tmp
             WHERE sel = 'Y'
            IF cl_null(l_cnt) OR l_cnt = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = '-400'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               
            ELSE
               CALL aicp910_process()
               LET INT_FLAG = TRUE     #170213-00043#1 17/02/15 By 08171 add
               CALL aicp910_query()
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
 
{<section id="aicp910.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aicp910_query()
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define

   #end add-point 
   
   #add-point:cs段after_construct
   DELETE FROM aicp910_tmp
   
   LET g_sql = " SELECT DISTINCT 'N',xmdksite,xmdasite,xmdk007,xmdkdocno,xmdkdocdt,xmdk044,xmdk035 ",
               "   FROM xmdk_t",
               "        LEFT OUTER JOIN xmda_t ON xmdaent = xmdkent ",
               "                               AND xmdadocno IN (SELECT DISTINCT xmdl003 ",
               "                                                   FROM xmdl_t WHERE xmdlent = xmdkent AND xmdldocno = xmdkdocno)",
               "  WHERE ",g_aicp910_sel,
               "    AND ",g_wc
   LET g_sql = " INSERT INTO aicp910_tmp ",g_sql
   PREPARE tmp_ins_pre FROM g_sql
   EXECUTE tmp_ins_pre
   
   LET g_wc_filter = " 1=1"
   #end add-point
        
   LET g_error_show = 1
   CALL aicp910_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="aicp910.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aicp910_b_fill()
 
   DEFINE ls_wc           STRING
   #add-point:b_fill段define

   #end add-point
 
   #add-point:b_fill段sql_before
   LET g_sql = "SELECT DISTINCT sel,",
               "                xmdksite,'',",
               "                xmdasite,'',",
               "                xmdk007,'',",
               "                xmdkdocno,xmdkdocdt,",
               "                xmdk044,'',",
               "                xmdk035",
               "  FROM aicp910_tmp ",
               " WHERE ",g_wc_filter,
               " ORDER BY xmdkdocno "
   #end add-point
 
   PREPARE aicp910_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aicp910_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空
   CALL g_detail2_d.clear()
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO 
   #add-point:b_fill段foreach_into
      g_detail_d[l_ac].sel,
      g_detail_d[l_ac].xmdksite,g_detail_d[l_ac].xmdksite_desc,
      g_detail_d[l_ac].xmdasite,g_detail_d[l_ac].xmdasite_desc,
      g_detail_d[l_ac].xmdk007,g_detail_d[l_ac].xmdk007_desc,
      g_detail_d[l_ac].xmdkdocno,g_detail_d[l_ac].xmdkdocdt,
      g_detail_d[l_ac].xmdk044,g_detail_d[l_ac].xmdk044_desc,
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
      CALL s_desc_get_department_desc(g_detail_d[l_ac].xmdksite)
           RETURNING g_detail_d[l_ac].xmdksite_desc
      CALL s_desc_get_department_desc(g_detail_d[l_ac].xmdasite)
           RETURNING g_detail_d[l_ac].xmdasite_desc
      CALL s_desc_get_trading_partner_abbr_desc(g_detail_d[l_ac].xmdk007)
           RETURNING g_detail_d[l_ac].xmdk007_desc
      CALL s_desc_get_icaa001_desc(g_detail_d[l_ac].xmdk044)
           RETURNING g_detail_d[l_ac].xmdk044_desc

      #end add-point
      
      CALL aicp910_detail_show()      
 
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
   FREE aicp910_sel
   
   LET l_ac = 1
   CALL aicp910_fetch()
   #add-point:b_fill段資料填充(其他單身)
 
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aicp910.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aicp910_fetch()
 
   DEFINE li_ac           LIKE type_t.num5
   #add-point:fetch段define
   DEFINE l_success       LIKE type_t.num5
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後
   CALL g_detail2_d.clear()

   IF cl_null(g_master_idx) OR g_master_idx <=0 THEN
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_sql = "SELECT xmdlseq,",
               "       xmdl001,xmdl002,xmdl003,",
               "       xmdl004,xmdl005,xmdl006,",
               "       xmdl007,xmdl008,imaal003,imaal004,",
               "       xmdl009,'',xmdl033,",
               "       xmdl017,xmdl018,xmdl019,xmdl020,",
               "       xmdl010,xmdl021, ",
               "       xmdl022,xmdl030,xmdl031,",
               "       xmdl032,xmdl051 ",
               "  FROM xmdl_t ",
               "       LEFT OUTER JOIN imaal_t ON xmdlent = imaalent AND xmdl008 = imaal001 AND imaal002 = '",g_dlang,"' ",
               " WHERE xmdlent = ",g_enterprise,
               "   AND xmdldocno = '",g_detail_d[g_master_idx].xmdkdocno,"'"
   PREPARE aicp910_fetch_pre FROM g_sql
   DECLARE aicp910_fetch_cur CURSOR FOR aicp910_fetch_pre
   
   FOREACH aicp910_fetch_cur INTO g_detail2_d[l_ac].xmdlseq,
                                  g_detail2_d[l_ac].xmdl001,g_detail2_d[l_ac].xmdl002,g_detail2_d[l_ac].xmdl003,
                                  g_detail2_d[l_ac].xmdl004,g_detail2_d[l_ac].xmdl005,g_detail2_d[l_ac].xmdl006,
                                  g_detail2_d[l_ac].xmdl007,g_detail2_d[l_ac].xmdl008,g_detail2_d[l_ac].xmdl008_desc,g_detail2_d[l_ac].xmdl008_desc_1,
                                  g_detail2_d[l_ac].xmdl009,g_detail2_d[l_ac].xmdl009_desc,g_detail2_d[l_ac].xmdl033,
                                  g_detail2_d[l_ac].xmdl017,g_detail2_d[l_ac].xmdl018,g_detail2_d[l_ac].xmdl019,g_detail2_d[l_ac].xmdl020,
                                  g_detail2_d[l_ac].xmdl010,g_detail2_d[l_ac].xmdl021,
                                  g_detail2_d[l_ac].xmdl022,g_detail2_d[l_ac].xmdl030,g_detail2_d[l_ac].xmdl031,
                                  g_detail2_d[l_ac].xmdl032,g_detail2_d[l_ac].xmdl051
   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF

      CALL s_feature_description(g_detail2_d[l_ac].xmdl008,g_detail2_d[l_ac].xmdl009)
           RETURNING l_success,g_detail2_d[l_ac].xmdl009_desc
           
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.popup = TRUE
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF
   END FOREACH
   
   CALL g_detail2_d.deleteElement(g_detail2_d.getLength())
   LET g_detail2_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   #end add-point 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="aicp910.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aicp910_detail_show()
   #add-point:show段define
   
   #end add-point
 
   #add-point:detail_show段
 
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aicp910.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aicp910_filter()
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
   
   CONSTRUCT g_wc_filter ON xmdksite,xmdasite,xmdk007,
                            xmdkdocno,xmdkdocdt,xmdk044,xmdk035
        FROM s_detail1[1].b_xmdksite,s_detail1[1].b_xmdasite,s_detail1[1].b_xmdk007,
             s_detail1[1].b_xmdkdocno,s_detail1[1].b_xmdkdocdt,s_detail1[1].b_xmdk044,s_detail1[1].b_xmdk035
           
      BEFORE CONSTRUCT
      
      ON ACTION controlp INFIELD xmdksite
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
		   LET g_qryparam.reqry = FALSE
         #mod--161013-00051#1 By shiun--(S)
#         CALL q_ooef001()                           #呼叫開窗
         CALL q_ooef001_1()
         #mod--161013-00051#1 By shiun--(E)
         DISPLAY g_qryparam.return1 TO xmdksite     #顯示到畫面上
         NEXT FIELD xmdksite                        #返回原欄位 
         
      ON ACTION controlp INFIELD xmdasite
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
		   LET g_qryparam.reqry = FALSE
         #mod--161013-00051#1 By shiun--(S)
#         CALL q_ooef001()                           #呼叫開窗
         CALL q_ooef001_1()
         #mod--161013-00051#1 By shiun--(E)
         DISPLAY g_qryparam.return1 TO xmdasite     #顯示到畫面上
         NEXT FIELD xmdasite                        #返回原欄位 
       
      ON ACTION controlp INFIELD xmdk007
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
		   LET g_qryparam.reqry = FALSE	
		   LET g_qryparam.arg1 = g_site
		   CALL q_pmaa001_6()                         #呼叫開窗
         DISPLAY g_qryparam.return1 TO xmdk007      #顯示到畫面上
         NEXT FIELD xmdk007                         #返回原欄位
         
      ON ACTION controlp INFIELD xmdkdocno
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
		   LET g_qryparam.reqry = FALSE
		   LET g_qryparam.where = g_aicp910_sel
		   LET g_qryparam.arg1 = '1'
		   CALL q_xmdkdocno_2()                        #呼叫開窗
         DISPLAY g_qryparam.return1 TO xmdkdocno     #顯示到畫面上
         NEXT FIELD xmdkdocno                        #返回原欄位
         
      ON ACTION controlp INFIELD xmdk044
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
		   LET g_qryparam.reqry = FALSE
		   LET g_qryparam.arg1 = '1'
		   LET g_qryparam.arg2 = '2'
		   LET g_qryparam.arg3 = 'N'
		   CALL q_icaa001_2()                        #呼叫開窗
         DISPLAY g_qryparam.return1 TO xmdk044     #顯示到畫面上
         NEXT FIELD xmdk044                        #返回原欄位

      ON ACTION controlp INFIELD xmdk035
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
		   LET g_qryparam.reqry = FALSE
         LET g_qryparam.arg1 = '1'
         LET g_qryparam.where = " xmdksite = '",g_site,"'",
			                       " AND xmdk045 = '3' ",
			                       #160902-00048#1-s-mod
			                       #" AND xmdk035 NOT IN (SELECT xmdkdocno FROM xmdk_t WHERE xmdk000 = '1' AND xmdk045 = '3') "
			                       " AND xmdk035 NOT IN (SELECT xmdkdocno FROM xmdk_t WHERE xmdkent='"||g_enterprise||"' AND xmdk000 = '1' AND xmdk045 = '3') "
			                       #160902-00048#1-e-mod
		  
         CALL q_xmdk035()                          #呼叫開窗
         DISPLAY g_qryparam.return1 TO xmdk035     #顯示到畫面上
         NEXT FIELD xmdk035                        #返回原欄位

   END CONSTRUCT
   #end add-point    
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   
   CALL aicp910_b_fill()
   CALL aicp910_fetch()
   
END FUNCTION
 
{</section>}
 
{<section id="aicp910.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aicp910_filter_parser(ps_field)
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
 
{<section id="aicp910.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aicp910_filter_show(ps_field,ps_object)
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
   LET ls_condition = aicp910_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aicp910.other_function" >}
#add-point:自定義元件(Function)

################################################################################
# Descriptions...: 將來源據點之多角出貨單做還原拋轉
# Memo...........:
# Usage..........: CALL aicp910_process()
#                  RETURNING 回传参数
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 16/01/14 By earl
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp910_process()
DEFINE l_xmdk             type_g_detail_d
DEFINE l_success          LIKE type_t.num5

DEFINE l_icab_now   RECORD
    icab002               LIKE icab_t.icab002,   #站別
    icab003               LIKE icab_t.icab003    #營運據點
                END RECORD
   
   #有選擇的出貨單
   LET g_sql = "SELECT xmdksite,xmdasite,xmdk007,",
               "       xmdkdocno,xmdkdocdt,xmdk044,xmdk035",
               "  FROM aicp910_tmp",
               " WHERE sel = 'Y' ",
               " ORDER BY xmdkdocno"
   PREPARE aicp910_process_pre FROM g_sql
   DECLARE aicp910_process_cur CURSOR WITH HOLD FOR aicp910_process_pre

   #當站多角貿易營運據點
   LET g_sql = "SELECT icab002,icab003",
               "  FROM icab_t",
               " WHERE icabent = ",g_enterprise,
               "   AND icab001 = ?",
               " ORDER BY icab002"
   PREPARE aicp910_process_icab_pre FROM g_sql
   DECLARE aicp910_process_icab_cur CURSOR FOR aicp910_process_icab_pre
   
   LET g_success_cnt = 1
   LET g_fail_cnt = 0
   CALL g_detail3_d.clear()
   CALL g_detail4_d.clear()
   CALL cl_err_collect_init()   #匯總訊息-初始化

   INITIALIZE l_xmdk.* TO NULL
   FOREACH aicp910_process_cur INTO l_xmdk.xmdksite,l_xmdk.xmdasite,l_xmdk.xmdk007,
                                    l_xmdk.xmdkdocno,l_xmdk.xmdkdocdt,l_xmdk.xmdk044,l_xmdk.xmdk035
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'process_cur'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         
         #失敗記錄
         CALL aicp910_fail(l_xmdk.*,'')
         EXIT FOREACH
      END IF
      
      CALL s_transaction_begin()
      LET g_fail_cnt = g_errcollect.getLength()  #先取得錯誤訊息的長度，大於此長度的表示是這張單子的錯誤訊息
      LET l_success = TRUE
      
      #多角序號為空白時，錯誤
      IF cl_null(l_xmdk.xmdk035) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'aic-00099'   #該筆資料之多角序號為空！
         LET g_errparam.popup = TRUE
         CALL cl_err()
         
         CALL s_transaction_end('N',0)
         #失敗記錄
         CALL aicp910_fail(l_xmdk.*,'')
         CONTINUE FOREACH
      END IF
      
      #多角流程代碼為空白時，錯誤
      IF cl_null(l_xmdk.xmdk044) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'aic-00026'   #多角流程代碼不可為空
         LET g_errparam.popup = TRUE
         CALL cl_err()
         
         CALL s_transaction_end('N',0)
         #失敗記錄
         CALL aicp910_fail(l_xmdk.*,'')
         CONTINUE FOREACH
      END IF
       
      #跑站(當站)
      INITIALIZE l_icab_now.* TO NULL
      OPEN aicp910_process_icab_cur USING l_xmdk.xmdk044
      FOREACH aicp910_process_icab_cur INTO l_icab_now.icab002,l_icab_now.icab003
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'aicp910_process_icab_cur'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            
            LET l_success = FALSE
            EXIT FOREACH
         END IF
         
         #用多角序號抓取該站的出貨單，並做處理
         CALL aicp910_xmdk(l_icab_now.icab003,l_xmdk.xmdk035,l_xmdk.xmdk044)
              RETURNING l_success
         IF NOT l_success THEN
            EXIT FOREACH
         END IF
         
         #用多角序號抓取該站的入庫單，並做處理
         CALL aicp910_pmds(l_icab_now.icab003,l_xmdk.xmdk035)
              RETURNING l_success
         IF NOT l_success THEN
            EXIT FOREACH
         END IF
       
      END FOREACH
      
      #更新"多角貿易拋轉否"='N'及清空"多角流程序號"、"多角流程代碼"
      IF l_success THEN
         UPDATE xmdk_t SET xmdk035 = NULL,
                           xmdk044 = NULL,
                           xmdk083 = 'N'
          WHERE xmdkent = g_enterprise
            AND xmdkdocno = l_xmdk.xmdkdocno
         
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE

            CALL cl_err()
            LET l_success = FALSE
            #失敗記錄
            CALL aicp910_fail(l_xmdk.*,'')
         END IF
      END IF
      
      IF l_success THEN
         CALL s_aic_carry_deletetrino(l_xmdk.xmdk035,'4')
              RETURNING l_success
      END IF
      
      IF l_success THEN
         CALL s_transaction_end('Y',0)
         #成功記錄
         CALL aicp910_success(l_xmdk.*)                  
      ELSE
         CALL s_transaction_end('N',0)
         #失敗記錄
         CALL aicp910_fail(l_xmdk.*,l_icab_now.icab003)
      END IF
   END FOREACH

   #清空錯誤訊息的array，並且之後的訊息不以array記錄
   CALL cl_err_collect_init()
   CALL cl_err_collect_show()

   CALL cl_ask_pressanykey("std-00012")   #批次作業已執行完成。
   
END FUNCTION

################################################################################
# Descriptions...: 失敗紀錄
# Memo...........:
# Usage..........: CALL aicp910_fail(p_xmdk,p_xmdksite)
# Input parameter: 
# Return code....: 
# Date & Author..: 16/01/14 By earl
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp910_fail(p_xmdk,p_xmdksite)
   DEFINE p_xmdk       type_g_detail_d
   DEFINE p_xmdksite   LIKE xmdk_t.xmdksite
   
   DEFINE l_i          LIKE type_t.num5
   
   IF cl_null(g_fail_cnt) THEN
      LET g_fail_cnt = 0
   END IF
      
   FOR l_i = g_fail_cnt + 1 TO g_errcollect.getLength()
      LET g_detail4_d[l_i].xmdksite2  = p_xmdk.xmdksite
      LET g_detail4_d[l_i].xmdasite2  = p_xmdk.xmdasite
      LET g_detail4_d[l_i].xmdk0072   = p_xmdk.xmdk007
      LET g_detail4_d[l_i].xmdkdocno2 = p_xmdk.xmdkdocno
      LET g_detail4_d[l_i].xmdkdocdt2 = p_xmdk.xmdkdocdt
      LET g_detail4_d[l_i].xmdk0352   = p_xmdk.xmdk035
      LET g_detail4_d[l_i].err_site   = p_xmdksite
      
      #錯誤訊息
      LET g_detail4_d[l_i].reason = g_errcollect[l_i].message
      
      #說明
      CALL s_desc_get_department_desc(g_detail4_d[l_i].xmdksite2)
           RETURNING g_detail4_d[l_i].xmdksite2_desc
      CALL s_desc_get_department_desc(g_detail4_d[l_i].xmdasite2)
           RETURNING g_detail4_d[l_i].xmdasite2_desc
      CALL s_desc_get_trading_partner_abbr_desc(g_detail4_d[l_i].xmdk0072)
           RETURNING g_detail4_d[l_i].xmdk0072_desc
      CALL s_desc_get_department_desc(g_detail4_d[l_i].err_site)
              RETURNING g_detail4_d[l_i].err_site_desc
   END FOR
      
   LET g_fail_cnt = g_errcollect.getLength()

END FUNCTION

##########################################################################################################
# Descriptions...: 成功紀錄
# Memo...........:
# Usage..........: CALL  aicp910_success(p_xmdk)
# Input parameter: 
# Return code....: 
# Date & Author..: 16/01/14 By earl
# Modify.........:
##########################################################################################################
PRIVATE FUNCTION aicp910_success(p_xmdk)
   DEFINE p_xmdk       type_g_detail_d

   IF cl_null(g_success_cnt) THEN
      LET g_success_cnt = 1
   END IF
      
   LET g_detail3_d[g_success_cnt].xmdksite1  = p_xmdk.xmdksite
   LET g_detail3_d[g_success_cnt].xmdasite1  = p_xmdk.xmdasite
   LET g_detail3_d[g_success_cnt].xmdk0071   = p_xmdk.xmdk007
   LET g_detail3_d[g_success_cnt].xmdkdocno1 = p_xmdk.xmdkdocno
   LET g_detail3_d[g_success_cnt].xmdkdocdt1 = p_xmdk.xmdkdocdt
      
   #說明
   CALL s_desc_get_department_desc(g_detail3_d[g_success_cnt].xmdksite1)
        RETURNING g_detail3_d[g_success_cnt].xmdksite1_desc
   CALL s_desc_get_department_desc(g_detail3_d[g_success_cnt].xmdasite1)
        RETURNING g_detail3_d[g_success_cnt].xmdasite1_desc
   CALL s_desc_get_trading_partner_abbr_desc(g_detail3_d[g_success_cnt].xmdk0071)
        RETURNING g_detail3_d[g_success_cnt].xmdk0071_desc
      
   LET g_success_cnt = g_success_cnt +  1

END FUNCTION

#單號過濾條件
PRIVATE FUNCTION aicp910_sel()
  #LET g_aicp910_sel = " xmdkent = ",g_enterprise,                                 #161231-00013#1 mark
   LET g_aicp910_sel = " xmdkent = ",g_enterprise,cl_sql_add_filter("xmdk_t"),     #161231-00013#1 add
                       " AND xmdksite = '",g_site,"' ",
                       " AND xmdk045 = '3' ",
                       " AND xmdk035 IS NOT NULL ",
                       " AND xmdk083 = 'Y' ",
                       " AND xmdkstus = 'S' ",
                       " AND xmdk000 = '1' ",
                       #160902-00048#1-s-mod
                       #" AND xmdk035 NOT IN (SELECT xmdkdocno FROM xmdk_t WHERE xmdk000 = '1' AND xmdk045 = '3') "
                       " AND xmdk035 NOT IN (SELECT xmdkdocno FROM xmdk_t WHERE xmdkent='"||g_enterprise||"' AND xmdk000 = '1' AND xmdk045 = '3') "
                       #160902-00048#1-e-mod
END FUNCTION

################################################################################
# Descriptions...: 抓取該站的出貨單，過帳還原、取消確認並刪除所有資料
# Memo...........:
# Usage..........: CALL aicp910_xmdk(p_site,p_xmdk035,p_xmdk044)
#                  RETURNING r_success
# Input parameter: p_site         營運據點
#                : p_xmdk035      多角序號
#                : p_xmdk044      多角流程代碼
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2016/01/12 By earl
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp910_xmdk(p_site,p_xmdk035,p_xmdk044)
DEFINE p_site            LIKE xmdk_t.xmdksite
DEFINE p_xmdk035         LIKE xmdk_t.xmdk035
DEFINE p_xmdk044         LIKE xmdk_t.xmdk044
DEFINE r_success         LIKE type_t.num5
DEFINE l_xmdkdocno       LIKE xmdk_t.xmdkdocno
DEFINE l_xmdkdocdt       LIKE xmdk_t.xmdkdocdt
DEFINE l_prog            LIKE gzzz_t.gzzz001
DEFINE l_site            LIKE ooef_t.ooef001
DEFINE l_icab003_last    LIKE icab_t.icab003
DEFINE l_sql             STRING
   
   LET r_success = TRUE

   LET l_sql = "SELECT icab003",
               "  FROM icab_t",
               " WHERE icabent = ",g_enterprise,
               "   AND icab001 = '",p_xmdk044,"'",
               " ORDER BY icab002 DESC"
   PREPARE sel_icab003_last_pre FROM l_sql
   DECLARE sel_icab003_last_cs SCROLL CURSOR FOR sel_icab003_last_pre
   
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
   
   #最終站，不做處理
   IF l_icab003_last = p_site THEN
      RETURN r_success
   END IF

   LET l_xmdkdocno = ''
   LET l_xmdkdocdt = ''
   SELECT xmdkdocno,xmdkdocdt
     INTO l_xmdkdocno,l_xmdkdocdt
     FROM xmdk_t
    WHERE xmdkent = g_enterprise
      AND xmdksite = p_site
      AND xmdk000 = '2'   #無訂單出貨單
      AND xmdk035 = p_xmdk035
      AND xmdkstus <> 'X'
   IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE

      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   IF cl_null(l_xmdkdocno) THEN
      RETURN r_success
   END IF
   
   UPDATE xmdk_t SET xmdk035 = NULL,
                     xmdk083 = 'N'
    WHERE xmdkent = g_enterprise
      AND xmdkdocno = l_xmdkdocno

   LET l_prog = g_prog
   LET l_site = g_site
   LET g_prog = 'axmt541'
   LET g_site = p_site

   #過帳還原
   CALL s_axmt540_unpost_chk(l_xmdkdocno)
        RETURNING r_success
   IF NOT r_success THEN
      LET g_prog = l_prog
      LET g_site = l_site
      RETURN r_success
   END IF
   CALL s_axmt540_unpost_upd(l_xmdkdocno)
        RETURNING r_success
   IF NOT r_success THEN
      LET g_prog = l_prog
      LET g_site = l_site
      RETURN r_success
   END IF
   
   #取消確認
   CALL s_axmt540_unconf_chk(l_xmdkdocno)
        RETURNING r_success
   IF NOT r_success THEN
      LET g_prog = l_prog
      LET g_site = l_site
      RETURN r_success
   END IF
   CALL s_axmt540_unconf_upd(l_xmdkdocno)
        RETURNING r_success
   IF NOT r_success THEN
      LET g_prog = l_prog
      LET g_site = l_site
      RETURN r_success
   END IF
   
   IF NOT g_aic_doc THEN
      #多角單據流水號保持一致='N'時，做作廢處理
      CALL s_axmt540_invalid_chk(l_xmdkdocno)
           RETURNING r_success
      IF NOT r_success THEN
         LET g_prog = l_prog
         LET g_site = l_site
         RETURN r_success
      END IF

      CALL s_axmt540_invalid_upd(l_xmdkdocno)
           RETURNING r_success
      IF NOT r_success THEN
         LET g_prog = l_prog
         LET g_site = l_site
         RETURN r_success
      END IF
   ELSE
      #刪除所有資料
      #1.出貨單單頭
      DELETE FROM xmdk_t
       WHERE xmdkent = g_enterprise
         AND xmdkdocno = l_xmdkdocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = l_xmdkdocno
         LET g_errparam.popup = TRUE

         CALL cl_err()
         LET r_success = FALSE
         LET g_prog = l_prog
         LET g_site = l_site
         RETURN r_success
      END IF
      
      #2.出貨單明細
      DELETE FROM xmdl_t
       WHERE xmdlent = g_enterprise
         AND xmdldocno = l_xmdkdocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = l_xmdkdocno
         LET g_errparam.popup = TRUE

         CALL cl_err()
         LET r_success = FALSE
         LET g_prog = l_prog
         LET g_site = l_site
         RETURN r_success
      END IF
      
      #3.多庫儲批明細
      DELETE FROM xmdm_t
       WHERE xmdment = g_enterprise
         AND xmdmdocno = l_xmdkdocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = l_xmdkdocno
         LET g_errparam.popup = TRUE

         CALL cl_err()
         LET r_success = FALSE
         LET g_prog = l_prog
         LET g_site = l_site
         RETURN r_success
      END IF
      
      #製造批序號
      DELETE FROM inao_t
       WHERE inaoent = g_enterprise
         AND inaodocno = l_xmdkdocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = l_xmdkdocno
         LET g_errparam.popup = TRUE

         CALL cl_err()
         LET r_success = FALSE
         LET g_prog = l_prog
         LET g_site = l_site
         RETURN r_success
      END IF
      
      #4.單號處理
      IF NOT s_aooi200_del_docno(l_xmdkdocno,l_xmdkdocdt) THEN
         LET r_success = FALSE
         LET g_prog = l_prog
         LET g_site = l_site
         RETURN r_success
      END IF

      #稅額xrcd
      CALL s_axmt540_tax_delete(l_xmdkdocno,'','1') RETURNING r_success
      IF NOT r_success THEN
         LET g_prog = l_prog
         LET g_site = l_site
         RETURN r_success
      END IF

      #刪除備註
      CALL s_aooi360_del('6',g_prog,l_xmdkdocno,'','','','','','','','','4') RETURNING r_success
      IF NOT r_success THEN
         LET g_prog = l_prog
         LET g_site = l_site
         RETURN r_success
      END IF
      
      #相關文件
      CALL g_pk_array.clear()
      LET g_pk_array[1].values = l_xmdkdocno
      LET g_pk_array[1].column = 'xmdkdocno'
      CALL cl_doc_remove()
   END IF

   LET g_prog = l_prog
   LET g_site = l_site

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 抓取該站的入庫單，過帳還原、取消確認並刪除所有資料
# Memo...........:
# Usage..........: CALL aicp910_pmds(p_site,p_pmds041)
#                  RETURNING r_success
# Input parameter: p_site         營運據點
#                : p_pmds041      多角序號
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2016/01/12 By earl
# Modify.........: 
################################################################################
PRIVATE FUNCTION aicp910_pmds(p_site,p_pmds041)
DEFINE p_site            LIKE pmds_t.pmdssite
DEFINE p_pmds041         LIKE pmds_t.pmds041
DEFINE r_success         LIKE type_t.num5
DEFINE l_pmdsdocno       LIKE pmds_t.pmdsdocno
DEFINE l_pmdsdocdt       LIKE pmds_t.pmdsdocdt
DEFINE l_prog            LIKE gzzz_t.gzzz001
DEFINE l_site            LIKE ooef_t.ooef001
DEFINE l_argv1           LIKE type_t.chr10

   LET r_success = TRUE
   
   LET l_pmdsdocno = ''
   LET l_pmdsdocdt = ''
   SELECT pmdsdocno,pmdsdocdt
     INTO l_pmdsdocno,l_pmdsdocdt
     FROM pmds_t
    WHERE pmdsent = g_enterprise
      AND pmdssite = p_site
      AND pmds000 = '4'  #無採購收貨入庫
      AND pmds041 = p_pmds041
      AND pmdsstus <> 'X'
   IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
                  
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   IF cl_null(l_pmdsdocno) THEN
      RETURN r_success
   END IF
   
   UPDATE pmds_t SET pmds041 = NULL,
                     pmds050 = 'N'
    WHERE pmdsent = g_enterprise
      AND pmdsdocno = l_pmdsdocno
   
   LET l_prog = g_prog
   LET l_argv1 = g_argv[1]
   LET l_site = g_site
   LET g_site = p_site
   
   #無採購收貨入庫單維護作業
   LET g_prog = 'apmt532'
   LET g_argv[1] = '4'
   
   #過帳還原
   CALL s_apmt520_unposted_chk(l_pmdsdocno)
        RETURNING r_success
   IF NOT r_success THEN
      LET g_prog = l_prog
      LET g_argv[1] = l_argv1
      LET g_site = l_site
      RETURN r_success
   END IF
   CALL s_apmt520_unposted_upd(l_pmdsdocno)
        RETURNING r_success
   IF NOT r_success THEN
      LET g_prog = l_prog
      LET g_argv[1] = l_argv1
      LET g_site = l_site
      RETURN r_success
   END IF
   
   #取消確認
   CALL s_apmt520_unconf_chk(l_pmdsdocno)
        RETURNING r_success
   IF NOT r_success THEN
      LET g_prog = l_prog
      LET g_argv[1] = l_argv1
      LET g_site = l_site
      RETURN r_success
   END IF
   CALL s_apmt520_unconf_upd(l_pmdsdocno)
        RETURNING r_success
   IF NOT r_success THEN
      LET g_prog = l_prog
      LET g_argv[1] = l_argv1
      LET g_site = l_site
      RETURN r_success
   END IF
   
   IF NOT g_aic_doc THEN
      #多角單據流水號保持一致='N'時，做作廢處理
      CALL s_apmt520_invalid_chk(l_pmdsdocno)
           RETURNING r_success
      IF NOT r_success THEN
         LET g_prog = l_prog
         LET g_argv[1] = l_argv1
         LET g_site = l_site
         RETURN r_success
      END IF
      
      CALL s_apmt520_invalid_upd(l_pmdsdocno)
           RETURNING r_success
      IF NOT r_success THEN
         LET g_prog = l_prog
         LET g_argv[1] = l_argv1
         LET g_site = l_site
         RETURN r_success
      END IF
   ELSE
      #刪除所有資料
      #1.入庫單單頭
      DELETE FROM pmds_t
       WHERE pmdsent = g_enterprise
         AND pmdsdocno = l_pmdsdocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = l_pmdsdocno
         LET g_errparam.popup = TRUE
            
         CALL cl_err()
         LET r_success = FALSE
         LET g_prog = l_prog
         LET g_argv[1] = l_argv1
         LET g_site = l_site
         RETURN r_success
      END IF
         
      #2.入庫單明細
      DELETE FROM pmdt_t
       WHERE pmdtent = g_enterprise
         AND pmdtdocno = l_pmdsdocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = l_pmdsdocno
         LET g_errparam.popup = TRUE
            
         CALL cl_err()
         LET r_success = FALSE
         LET g_prog = l_prog
         LET g_argv[1] = l_argv1
         LET g_site = l_site
         RETURN r_success
      END IF
         
      #3.多庫儲批明細
      DELETE FROM pmdu_t
       WHERE pmduent = g_enterprise
         AND pmdudocno = l_pmdsdocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = l_pmdsdocno
         LET g_errparam.popup = TRUE
            
         CALL cl_err()
         LET r_success = FALSE
         LET g_prog = l_prog
         LET g_argv[1] = l_argv1
         LET g_site = l_site
         RETURN r_success
      END IF
      
      #製造批序號
      DELETE FROM inao_t
       WHERE inaoent = g_enterprise
         AND inaodocno = l_pmdsdocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = l_pmdsdocno
         LET g_errparam.popup = TRUE
         
         CALL cl_err()
         LET r_success = FALSE
         LET g_prog = l_prog
         LET g_argv[1] = l_argv1
         LET g_site = l_site
         RETURN r_success
      END IF
      
      #需求分配明細
      DELETE FROM pmdv_t
       WHERE pmdvent = g_enterprise
         AND pmdvdocno = l_pmdsdocno
      IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = l_pmdsdocno
         LET g_errparam.popup = TRUE
            
         CALL cl_err()
         LET r_success = FALSE
         LET g_prog = l_prog
         LET g_argv[1] = l_argv1
         LET g_site = l_site
         RETURN r_success
      END IF
      
      #4.單號處理
      IF NOT s_aooi200_del_docno(l_pmdsdocno,l_pmdsdocdt) THEN
         LET r_success = FALSE
         LET g_prog = l_prog
         LET g_argv[1] = l_argv1
         LET g_site = l_site
         RETURN r_success
      END IF

      #稅額xrcd
      DELETE FROM xrcd_t
       WHERE xrcdent = g_enterprise
         AND xrcddocno = l_pmdsdocno
      IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = l_pmdsdocno
         LET g_errparam.popup = TRUE
            
         CALL cl_err()
         LET r_success = FALSE
         LET g_prog = l_prog
         LET g_argv[1] = l_argv1
         LET g_site = l_site
         RETURN r_success
      END IF

      #刪除備註
      CALL s_aooi360_del('6',g_prog,l_pmdsdocno,'','','','','','','','','4') RETURNING r_success
      IF NOT r_success THEN
         LET g_prog = l_prog
         LET g_argv[1] = l_argv1
         LET g_site = l_site
         RETURN r_success
      END IF
      
      #相關文件
      CALL g_pk_array.clear()
      LET g_pk_array[1].values = l_pmdsdocno
      LET g_pk_array[1].column = 'pmdsdocno'
      CALL cl_doc_remove()
   END IF
   
   LET g_prog = l_prog
   LET g_argv[1] = l_argv1
   LET g_site = l_site
   
   RETURN r_success
END FUNCTION

#end add-point
 
{</section>}
 
