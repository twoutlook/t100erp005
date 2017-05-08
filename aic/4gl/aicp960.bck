#該程式已解開Section, 不再透過樣板產出!
{<section id="aicp960.description" >}
#+ Version..: T100-ERP-1.00.00(SD版次:1,PD版次:1) Build-000055
#+ 
#+ Filename...: aicp960
#+ Description: 多角貿易出貨通知單拋轉作業
#+ Creator....: 02295(2014/05/08)
#+ Modifier...: 02295(2014/05/08)
#+ Buildtype..: 應用 p02 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="aicp960.global" >}
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
        pmdssite         LIKE pmds_t.pmdssite, 
        pmdssite_desc    LIKE type_t.chr80,
        pmdlsite         LIKE pmdl_t.pmdlsite,
        pmdlsite_desc    LIKE type_t.chr80,
        pmds007          LIKE pmds_t.pmds007,
        pmds007_desc     LIKE type_t.chr80,
        pmdsdocno        LIKE pmds_t.pmdsdocno,
        pmdsdocdt        LIKE pmds_t.pmdsdocdt,
        pmds053          LIKE pmds_t.pmds053,
        pmds053_desc     LIKE type_t.chr80,
        pmds041          LIKE pmds_t.pmds041
                     END RECORD
DEFINE g_detail_d_t         type_g_detail_d

TYPE type_g_detail2_d RECORD
        pmdtseq          LIKE pmdt_t.pmdtseq, 
        pmdt001          LIKE pmdt_t.pmdt001,
        pmdt002          LIKE pmdt_t.pmdt002,
        pmdt005          LIKE pmdt_t.pmdt005,
        pmdt006          LIKE pmdt_t.pmdt006,
        pmdt006_desc     LIKE type_t.chr80,
        pmdt006_desc_1   LIKE type_t.chr80,
        pmdt007          LIKE pmdt_t.pmdt007,
        pmdt007_desc     LIKE type_t.chr80,
        pmdt019          LIKE pmdt_t.pmdt019,
        pmdt020          LIKE pmdt_t.pmdt020,
        pmdt021          LIKE pmdt_t.pmdt021,
        pmdt022          LIKE pmdt_t.pmdt022,
        pmdt008          LIKE pmdt_t.pmdt008,
        pmdt023          LIKE pmdt_t.pmdt023,
        pmdt024          LIKE pmdt_t.pmdt024,
        pmdt072          LIKE pmdt_t.pmdt072,
        pmdt073          LIKE pmdt_t.pmdt073,
        pmdt074          LIKE pmdt_t.pmdt074,
        pmdt059          LIKE pmdt_t.pmdt059
                     END RECORD
DEFINE g_detail2_d          DYNAMIC ARRAY OF type_g_detail2_d
DEFINE g_detail2_cnt        LIKE type_t.num5
DEFINE g_rec_b              LIKE type_t.num5

TYPE type_g_detail3_d RECORD
        pmdssite1        LIKE pmds_t.pmdssite, 
        pmdssite1_desc   LIKE type_t.chr80,
        pmdlsite1        LIKE pmdl_t.pmdlsite,
        pmdlsite1_desc   LIKE type_t.chr80,
        pmds0071         LIKE pmds_t.pmds007,
        pmds0071_desc    LIKE type_t.chr80,
        pmdsdocno1       LIKE pmds_t.pmdsdocno,
        pmdsdocdt1       LIKE pmds_t.pmdsdocdt
                     END RECORD
DEFINE g_detail3_d          DYNAMIC ARRAY OF type_g_detail3_d
DEFINE g_detail3_cnt        LIKE type_t.num5

TYPE type_g_detail4_d RECORD
        pmdssite2        LIKE pmds_t.pmdssite, 
        pmdssite2_desc   LIKE type_t.chr80,
        pmdlsite2        LIKE pmdl_t.pmdlsite,
        pmdlsite2_desc   LIKE type_t.chr80,
        pmds0072         LIKE pmds_t.pmds007,
        pmds0072_desc    LIKE type_t.chr80,
        pmdsdocno2       LIKE pmds_t.pmdsdocno,
        pmdsdocdt2       LIKE pmds_t.pmdsdocdt,
        pmds0412         LIKE pmds_t.pmds041,
        err_site         LIKE pmds_t.pmdssite,
        err_site_desc    LIKE type_t.chr80,
        reason           LIKE type_t.chr1000
                     END RECORD
DEFINE g_detail4_d          DYNAMIC ARRAY OF type_g_detail4_d
DEFINE g_detail4_cnt        LIKE type_t.num5

DEFINE g_success_cnt        LIKE type_t.num5
DEFINE g_fail_cnt           LIKE type_t.num5

DEFINE g_aicp960_sel        STRING
DEFINE g_aic_doc            LIKE type_t.num5

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num5              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明

#end add-point
 
{</section>}
 
{<section id="aicp960.main" >}
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
   CREATE TEMP TABLE aicp960_tmp( 
       sel               LIKE type_t.chr1,
       pmdssite          LIKE pmds_t.pmdssite, 
       pmdlsite          LIKE pmdl_t.pmdlsite,
       pmds007           LIKE pmds_t.pmds007,
       pmdsdocno         LIKE pmds_t.pmdsdocno,
       pmdsdocdt         LIKE pmds_t.pmdsdocdt,
       pmds053           LIKE pmds_t.pmds053,
       pmds041           LIKE pmds_t.pmds041
       )
       
   CALL aicp960_sel()
   
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
      OPEN WINDOW w_aicp960 WITH FORM cl_ap_formpath("aic",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aicp960_init()   
 
      #進入選單 Menu (="N")
      CALL aicp960_ui_dialog() 
 
      #add-point:畫面關閉前
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aicp960
   END IF 
   
   #add-point:作業離開前
   DROP TABLE aicp960_tmp
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aicp960.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aicp960_init()
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
 
{<section id="aicp960.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aicp960_ui_dialog()
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
   CALL aicp960_query()
   #end add-point
   
   WHILE TRUE
 
      CALL cl_dlg_query_bef_disp()  #相關查詢
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct
         CONSTRUCT BY NAME g_wc ON pmdsdocno,pmdsdocdt,pmdssite,pmdlsite,pmds007,pmds053,pmds041

            BEFORE CONSTRUCT

            ON ACTION controlp INFIELD pmdsdocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
			      LET g_qryparam.where = g_aicp960_sel
			      LET g_qryparam.arg1 = "('3','6')"
			      CALL q_pmdsdocno()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmdsdocno    #顯示到畫面上
               NEXT FIELD pmdsdocno                       #返回原欄位
               
            ON ACTION controlp INFIELD pmdssite
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
               #mod--161013-00051#1 By shiun--(S)
#               CALL q_ooef001()                           #呼叫開窗
               CALL q_ooef001_1()
               #mod--161013-00051#1 By shiun--(E)
               DISPLAY g_qryparam.return1 TO pmdssite     #顯示到畫面上
               NEXT FIELD pmdssite                        #返回原欄位 
               
            ON ACTION controlp INFIELD pmdlsite
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
               #mod--161013-00051#1 By shiun--(S)
#               CALL q_ooef001()                           #呼叫開窗
               CALL q_ooef001_1()
               #mod--161013-00051#1 By shiun--(E)
               DISPLAY g_qryparam.return1 TO pmdlsite     #顯示到畫面上
               NEXT FIELD pmdlsite                        #返回原欄位 
   
            ON ACTION controlp INFIELD pmds007
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
		         CALL q_pmaa001_3()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmds007      #顯示到畫面上
               NEXT FIELD pmds007                         #返回原欄位
               
            ON ACTION controlp INFIELD pmds053
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
			      LET g_qryparam.arg1 = '2'
			      LET g_qryparam.arg2 = '2'
			      LET g_qryparam.arg3 = 'N'
			      CALL q_icaa001_2()                        #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmds053     #顯示到畫面上
               NEXT FIELD pmds053                        #返回原欄位
            
            ON ACTION controlp INFIELD pmds041
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
			      LET g_qryparam.where = " pmdssite = '",g_site,"'",
			                             " AND pmds000 IN ('3','6')",
			                             " AND pmds014 = '4' ",
			                             #160902-00048#1-s-mod
			                             #" AND pmds041 NOT IN (SELECT pmdsdocno FROM pmds_t WHERE pmds000 IN ('3','6') AND pmds014 = '4') "
			                             " AND pmds041 NOT IN (SELECT pmdsdocno FROM pmds_t WHERE pmdsent'"||g_enterprise||"' AND pmds000 IN ('3','6') AND pmds014 = '4') "
			                             #160902-00048#1-e-mod
			      
			      CALL q_pmds041_2()                          #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmds041     #顯示到畫面上
               NEXT FIELD pmds041                        #返回原欄位
            
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
               CALL aicp960_fetch() 
               #單身1可編輯，需備份舊值
               LET g_detail_d_t.* = g_detail_d[l_ac].*
            
            ON CHANGE b_sel
                           
            ON ROW CHANGE
               UPDATE aicp960_tmp 
                  SET sel = g_detail_d[l_ac].sel, 
                      pmds053 = g_detail_d[l_ac].pmds053 
                WHERE pmdsdocno = g_detail_d[l_ac].pmdsdocno
               
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
            
            CALL aicp960_sel()
            
            #end add-point
 
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
            END FOR
            #add-point:ui_dialog段on action selall
            UPDATE aicp960_tmp 
               SET sel = 'Y'
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "N"
            END FOR
            #add-point:ui_dialog段on action selnone
            UPDATE aicp960_tmp 
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
                  UPDATE aicp960_tmp 
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
            #add-point:ui_dialog段on action unsel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  UPDATE aicp960_tmp 
                     SET sel = 'N' 
                   WHERE pmdsdocno = g_detail_d[li_idx].pmdsdocno 
               END IF
            END FOR            
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL aicp960_filter()
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
            CALL aicp960_query()
 
         # 條件清除
         ON ACTION qbeclear
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            CALL aicp960_b_fill()
            CALL aicp960_fetch()
 
         #add-point:ui_dialog段action
         ON ACTION batch_execute
            #變更此筆資料後，直接按執行
            IF l_ac > 0 THEN               
               UPDATE aicp960_tmp 
                  SET sel = g_detail_d[l_ac].sel
                WHERE pmdsdocno = g_detail_d[l_ac].pmdsdocno 
            END IF
            
            LET l_cnt = ''
            SELECT COUNT(*) INTO l_cnt
              FROM aicp960_tmp
             WHERE sel = 'Y'
            IF cl_null(l_cnt) OR l_cnt = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = '-400'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               
            ELSE
               CALL aicp960_process()
               LET INT_FLAG = TRUE     #170213-00043#1 17/02/15 By 08171 add
               CALL aicp960_query()
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
 
{<section id="aicp960.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aicp960_query()
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define
 
   #end add-point 
   
   #add-point:cs段after_construct
   DELETE FROM aicp960_tmp
   
   LET g_sql = " SELECT DISTINCT 'N',pmdssite,pmdlsite,pmds007,pmdsdocno,pmdsdocdt,pmds053,pmds041 ",
               "   FROM pmds_t",
               "        LEFT OUTER JOIN pmdl_t ON pmdlent = pmdsent ",
               "                               AND pmdldocno IN (SELECT DISTINCT pmdt001 ",
               "                                                   FROM pmdt_t WHERE pmdtent = pmdsent AND pmdtdocno = pmdsdocno)",
               "  WHERE ",g_aicp960_sel,
               "    AND ",g_wc
   LET g_sql = " INSERT INTO aicp960_tmp ",g_sql
   PREPARE tmp_ins_pre FROM g_sql
   EXECUTE tmp_ins_pre
   
   LET g_wc_filter = " 1=1"
   #end add-point
        
   LET g_error_show = 1
   CALL aicp960_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="aicp960.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aicp960_b_fill()
 
   DEFINE ls_wc           STRING
   #add-point:b_fill段define

   #end add-point
 
   #add-point:b_fill段sql_before
   LET g_sql = "SELECT DISTINCT sel,",
               "                pmdssite,'',",
               "                pmdlsite,'',",
               "                pmds007,'',",
               "                pmdsdocno,pmdsdocdt,",
               "                pmds053,'',",
               "                pmds041",
               "  FROM aicp960_tmp ",
               " WHERE ",g_wc_filter,
               " ORDER BY pmdsdocno "
   #end add-point
 
   PREPARE aicp960_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aicp960_sel
   
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
      g_detail_d[l_ac].pmdssite,g_detail_d[l_ac].pmdssite_desc,
      g_detail_d[l_ac].pmdlsite,g_detail_d[l_ac].pmdlsite_desc,
      g_detail_d[l_ac].pmds007,g_detail_d[l_ac].pmds007_desc,
      g_detail_d[l_ac].pmdsdocno,g_detail_d[l_ac].pmdsdocdt,
      g_detail_d[l_ac].pmds053,g_detail_d[l_ac].pmds053_desc,
      g_detail_d[l_ac].pmds041
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
      CALL s_desc_get_department_desc(g_detail_d[l_ac].pmdssite)
           RETURNING g_detail_d[l_ac].pmdssite_desc
      CALL s_desc_get_department_desc(g_detail_d[l_ac].pmdlsite)
           RETURNING g_detail_d[l_ac].pmdlsite_desc
      CALL s_desc_get_trading_partner_abbr_desc(g_detail_d[l_ac].pmds007)
           RETURNING g_detail_d[l_ac].pmds007_desc
      CALL s_desc_get_icaa001_desc(g_detail_d[l_ac].pmds053)
           RETURNING g_detail_d[l_ac].pmds053_desc
      #end add-point
      
      CALL aicp960_detail_show()      
 
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
   FREE aicp960_sel
   
   LET l_ac = 1
   CALL aicp960_fetch()
   #add-point:b_fill段資料填充(其他單身)
 
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aicp960.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aicp960_fetch()
 
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
   LET g_sql = " SELECT pmdtseq,",
               "        pmdt001,pmdt002,pmdt005,",
               "        pmdt006,imaal003,imaal004,",
               "        pmdt007,'',pmdt019, ",
               "        pmdt020,pmdt021,pmdt022,",
               "        pmdt008,pmdt023,pmdt024,",
               "        pmdt072,pmdt073,pmdt074,",
               "        pmdt059 ",
               "   FROM pmdt_t ",
               "        LEFT OUTER JOIN imaal_t ON pmdtent = imaalent AND pmdt006 = imaal001 AND imaal002 = '",g_dlang,"' ",
               "  WHERE pmdtent = ",g_enterprise,
               "    AND pmdtdocno = '",g_detail_d[g_master_idx].pmdsdocno,"'"
   PREPARE aicp960_fetch_pre FROM g_sql
   DECLARE aicp960_fetch_cur CURSOR FOR aicp960_fetch_pre

   FOREACH aicp960_fetch_cur INTO 
      g_detail2_d[l_ac].pmdtseq,
      g_detail2_d[l_ac].pmdt001,g_detail2_d[l_ac].pmdt002,g_detail2_d[l_ac].pmdt005,
      g_detail2_d[l_ac].pmdt006,g_detail2_d[l_ac].pmdt006_desc,g_detail2_d[l_ac].pmdt006_desc_1,
      g_detail2_d[l_ac].pmdt007,g_detail2_d[l_ac].pmdt007_desc,g_detail2_d[l_ac].pmdt019,
      g_detail2_d[l_ac].pmdt020,g_detail2_d[l_ac].pmdt021,g_detail2_d[l_ac].pmdt022,
      g_detail2_d[l_ac].pmdt008,g_detail2_d[l_ac].pmdt023,g_detail2_d[l_ac].pmdt024,
      g_detail2_d[l_ac].pmdt072,g_detail2_d[l_ac].pmdt073,g_detail2_d[l_ac].pmdt074,
      g_detail2_d[l_ac].pmdt059
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         
         EXIT FOREACH
      END IF
      
      #產品特徵
      CALL s_feature_description(g_detail2_d[l_ac].pmdt006,g_detail2_d[l_ac].pmdt007)
           RETURNING l_success,g_detail2_d[l_ac].pmdt007_desc

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
 
{<section id="aicp960.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aicp960_detail_show()
   #add-point:show段define
   
   #end add-point
 
   #add-point:detail_show段
 
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aicp960.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aicp960_filter()
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
   
   CONSTRUCT g_wc_filter ON pmdssite,pmdlsite,pmds007,
                            pmdsdocno,pmdsdocdt,pmds053,pmds041
        FROM s_detail1[1].b_pmdssite,s_detail1[1].b_pmdlsite,s_detail1[1].b_pmds007,
             s_detail1[1].b_pmdsdocno,s_detail1[1].b_pmdsdocdt,s_detail1[1].b_pmds053,s_detail1[1].b_pmds041
           
      BEFORE CONSTRUCT
      
      ON ACTION controlp INFIELD pmdsdocno
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
		   LET g_qryparam.reqry = FALSE
		   LET g_qryparam.where = g_aicp960_sel
		   LET g_qryparam.arg1 = "('3','6')"
		   CALL q_pmdsdocno()                         #呼叫開窗
         DISPLAY g_qryparam.return1 TO pmdsdocno    #顯示到畫面上
         NEXT FIELD pmdsdocno                       #返回原欄位
         
      ON ACTION controlp INFIELD pmdssite
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
		   LET g_qryparam.reqry = FALSE
         #mod--161013-00051#1 By shiun--(S)
#         CALL q_ooef001()                           #呼叫開窗
         CALL q_ooef001_1()
         #mod--161013-00051#1 By shiun--(E)
         DISPLAY g_qryparam.return1 TO pmdssite     #顯示到畫面上
         NEXT FIELD pmdssite                        #返回原欄位 
         
      ON ACTION controlp INFIELD pmdlsite
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
		   LET g_qryparam.reqry = FALSE
         #mod--161013-00051#1 By shiun--(S)
#         CALL q_ooef001()                           #呼叫開窗
         CALL q_ooef001_1()
         #mod--161013-00051#1 By shiun--(E)
         DISPLAY g_qryparam.return1 TO pmdlsite     #顯示到畫面上
         NEXT FIELD pmdlsite                        #返回原欄位 
       
      ON ACTION controlp INFIELD pmds007
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
		   LET g_qryparam.reqry = FALSE
		   CALL q_pmaa001_3()                         #呼叫開窗
         DISPLAY g_qryparam.return1 TO pmds007      #顯示到畫面上
         NEXT FIELD pmds007                         #返回原欄位
         
      ON ACTION controlp INFIELD pmds053
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
		   LET g_qryparam.reqry = FALSE
		   LET g_qryparam.arg1 = '2'
		   LET g_qryparam.arg2 = '2'
		   LET g_qryparam.arg3 = 'N'
		   CALL q_icaa001_2()                        #呼叫開窗
         DISPLAY g_qryparam.return1 TO pmds053     #顯示到畫面上
         NEXT FIELD pmds053                        #返回原欄位

     ON ACTION controlp INFIELD pmds041
        INITIALIZE g_qryparam.* TO NULL
        LET g_qryparam.state = 'c'
		  LET g_qryparam.reqry = FALSE
		  LET g_qryparam.where = " pmdssite = '",g_site,"'",
		                          " AND pmds000 IN ('3','6')",
		                          " AND pmds014 = '4' ",
		                          #160902-00048#1-s-mod
		                          #" AND pmds041 NOT IN (SELECT pmdsdocno FROM pmds_t WHERE pmds000 IN ('3','6') AND pmds014 = '4') "
		                          " AND pmds041 NOT IN (SELECT pmdsdocno FROM pmds_t WHERE pmdsent='"||g_enterprise||"' AND pmds000 IN ('3','6') AND pmds014 = '4') "
		                          #160902-00048#1-e-mod
		   
		  CALL q_pmds041_2()                          #呼叫開窗
        DISPLAY g_qryparam.return1 TO pmds041     #顯示到畫面上
        NEXT FIELD pmds041                        #返回原欄位

   END CONSTRUCT
   #end add-point    
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   
   CALL aicp960_b_fill()
   CALL aicp960_fetch()
   
END FUNCTION
 
{</section>}
 
{<section id="aicp960.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aicp960_filter_parser(ps_field)
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
 
{<section id="aicp960.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aicp960_filter_show(ps_field,ps_object)
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
   LET ls_condition = aicp960_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aicp960.other_function" >}
#add-point:自定義元件(Function)

################################################################################
# Descriptions...: 執行本作業,可將來源據點之多角入庫／出貨單還原
# Memo...........:
# Usage..........: CALL aicp960_process()
#                  RETURNING 回传参数
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 16/01/15 By earl
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp960_process()
DEFINE l_pmds             type_g_detail_d
DEFINE l_success          LIKE type_t.num5

DEFINE l_icab_now     RECORD
    icab002               LIKE icab_t.icab002,           #當站站別
    icab003               LIKE icab_t.icab003            #當站營運據點
                      END RECORD

   #有選擇的入庫單
   LET g_sql = "SELECT pmdssite,pmdlsite,",
               "       pmds007,",
               "       pmdsdocno,pmdsdocdt,pmds053,pmds041 ",
               "  FROM aicp960_tmp ",
               " WHERE sel = 'Y' ",
               " ORDER BY pmdsdocno "
   PREPARE aicp960_process_pre FROM g_sql
   DECLARE aicp960_process_cur CURSOR WITH HOLD FOR aicp960_process_pre
      
   #當站多角貿易營運據點
   LET g_sql = "SELECT icab002,icab003",
               "  FROM icab_t",
               " WHERE icabent = ",g_enterprise,
               "   AND icab001 = ?",
               " ORDER BY icab002"
   PREPARE aicp960_process_icab_pre FROM g_sql
   DECLARE aicp960_process_icab_cur CURSOR FOR aicp960_process_icab_pre
   

   LET g_success_cnt = 1
   LET g_fail_cnt = 0
   CALL g_detail3_d.clear()
   CALL g_detail4_d.clear()
   CALL cl_err_collect_init()   #匯總訊息-初始化
   
   INITIALIZE l_pmds.* TO NULL
   FOREACH aicp960_process_cur INTO l_pmds.pmdssite,l_pmds.pmdlsite,
                                    l_pmds.pmds007,
                                    l_pmds.pmdsdocno,l_pmds.pmdsdocdt,l_pmds.pmds053,l_pmds.pmds041
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'process_cur'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         
         #失敗記錄
         CALL aicp960_fail(l_pmds.*,'')
         EXIT FOREACH
      END IF
      
      CALL s_transaction_begin()
      LET g_fail_cnt = g_errcollect.getLength()  #先取得錯誤訊息的長度，大於此長度的表示是這張單子的錯誤訊息
      LET l_success = TRUE

      #多角流程序號為空白時，錯誤
      IF cl_null(l_pmds.pmds041) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'aic-00099'   #該筆資料之多角序號為空！
         LET g_errparam.popup = TRUE
         CALL cl_err()
         
         CALL s_transaction_end('N',0)
         #失敗記錄
         CALL aicp960_fail(l_pmds.*,'')
         CONTINUE FOREACH
      END IF

      #多角流程代碼為空白時，錯誤
      IF cl_null(l_pmds.pmds053) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'aic-00026'   #多角流程代碼不可為空
         LET g_errparam.popup = TRUE
         CALL cl_err()
         
         CALL s_transaction_end('N',0)
         #失敗記錄
         CALL aicp960_fail(l_pmds.*,'')
         CONTINUE FOREACH
      END IF
            
      #跑站(當站)
      INITIALIZE l_icab_now.* TO NULL
      OPEN aicp960_process_icab_cur USING l_pmds.pmds053
      FOREACH aicp960_process_icab_cur INTO l_icab_now.icab002,l_icab_now.icab003
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'FOREACH:aicp960_process_icab_cur'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            
            LET l_success = FALSE
            EXIT FOREACH
         END IF

         #用多角序號抓取該站的入庫單，並做處理
         CALL aicp960_pmds(l_icab_now.icab003,l_pmds.pmds041,l_pmds.pmds053)
              RETURNING l_success
         IF NOT l_success THEN
            EXIT FOREACH
         END IF

         #用多角序號抓取該站的出貨單，並做處理
         CALL aicp960_xmdk(l_icab_now.icab003,l_pmds.pmds041)
              RETURNING l_success
         IF NOT l_success THEN
            EXIT FOREACH
         END IF

      END FOREACH
      
      #更新"多角貿易拋轉否"='N'及清空"多角流程序號"、"多角流程代碼"
      IF l_success THEN
         UPDATE pmds_t SET pmds041 = NULL,
                           pmds053 = NULL,
                           pmds050 = 'N'
          WHERE pmdsent = g_enterprise
            AND pmdsdocno = l_pmds.pmdsdocno
           
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            
            CALL cl_err()
            LET l_success = FALSE
            #失敗記錄
            CALL aicp960_fail(l_pmds.*,'')
         END IF
      END IF

      IF l_success THEN
         CALL s_aic_carry_deletetrino(l_pmds.pmds041,'4')
              RETURNING l_success
      END IF

      IF l_success THEN
         CALL s_transaction_end('Y',0)
         #成功記錄
         CALL aicp960_success(l_pmds.*)
      ELSE
         CALL s_transaction_end('N',0)
         #失敗記錄
         CALL aicp960_fail(l_pmds.*,l_icab_now.icab003)
      END IF
   END FOREACH
   
   #清空錯誤訊息的array，並且之後的訊息不以array記錄
   CALL cl_err_collect_init()
   CALL cl_err_collect_show()
   
   CALL cl_ask_pressanykey("std-00012")
   
END FUNCTION

####################################################################################################
# Descriptions...: 失敗紀錄
# Memo...........:
# Usage..........: CALL aicp960_fail(p_pmds,p_pmdssite)
# Input parameter: 
# Return code....: 
# Date & Author..: 16/01/15 By earl
# Modify.........:
####################################################################################################
PRIVATE FUNCTION aicp960_fail(p_pmds,p_pmdssite)
   DEFINE p_pmds       type_g_detail_d
   DEFINE p_pmdssite   LIKE pmds_t.pmdssite
   DEFINE l_i          LIKE type_t.num5

   IF cl_null(g_fail_cnt) THEN
      LET g_fail_cnt = 0
   END IF
      
    FOR l_i = g_fail_cnt + 1 TO g_errcollect.getLength()
      LET g_detail4_d[l_i].pmdssite2  = p_pmds.pmdssite
      LET g_detail4_d[l_i].pmdlsite2  = p_pmds.pmdlsite
      LET g_detail4_d[l_i].pmds0072   = p_pmds.pmds007
      LET g_detail4_d[l_i].pmdsdocno2 = p_pmds.pmdsdocno
      LET g_detail4_d[l_i].pmdsdocdt2 = p_pmds.pmdsdocdt
      LET g_detail4_d[l_i].pmds0412   = p_pmds.pmds041
      LET g_detail4_d[l_i].err_site   = p_pmdssite
      
      #錯誤訊息
      LET g_detail4_d[l_i].reason = g_errcollect[l_i].message
      
      #說明
      CALL s_desc_get_department_desc(g_detail4_d[l_i].pmdssite2)
           RETURNING g_detail4_d[l_i].pmdssite2_desc
      CALL s_desc_get_department_desc(g_detail4_d[l_i].pmdlsite2)
           RETURNING g_detail4_d[l_i].pmdlsite2_desc
      CALL s_desc_get_trading_partner_abbr_desc(g_detail4_d[l_i].pmds0072)
           RETURNING g_detail4_d[l_i].pmds0072_desc
      CALL s_desc_get_department_desc(g_detail4_d[l_i].err_site)
           RETURNING g_detail4_d[l_i].err_site_desc
   END FOR
   
   LET g_fail_cnt = g_errcollect.getLength()

END FUNCTION

################################################################################
# Descriptions...: 成功紀錄
# Memo...........:
# Usage..........: CALL aicp960_success(p_pmds)
# Input parameter: 
# Return code....: 
# Date & Author..: 16/01/15 By earl
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp960_success(p_pmds)
   DEFINE p_pmds       type_g_detail_d

   IF cl_null(g_success_cnt) THEN
      LET g_success_cnt = 1
   END IF
      
   LET g_detail3_d[g_success_cnt].pmdssite1  = p_pmds.pmdssite
   LET g_detail3_d[g_success_cnt].pmdlsite1  = p_pmds.pmdlsite
   LET g_detail3_d[g_success_cnt].pmds0071   = p_pmds.pmds007
   LET g_detail3_d[g_success_cnt].pmdsdocno1 = p_pmds.pmdsdocno
   LET g_detail3_d[g_success_cnt].pmdsdocdt1 = p_pmds.pmdsdocdt
   
   #說明
   CALL s_desc_get_department_desc(g_detail3_d[g_success_cnt].pmdssite1)
        RETURNING g_detail3_d[g_success_cnt].pmdssite1_desc
   CALL s_desc_get_department_desc(g_detail3_d[g_success_cnt].pmdlsite1)
        RETURNING g_detail3_d[g_success_cnt].pmdlsite1_desc
   CALL s_desc_get_trading_partner_abbr_desc(g_detail3_d[g_success_cnt].pmds0071)
        RETURNING g_detail3_d[g_success_cnt].pmds0071_desc
   
   LET g_success_cnt = g_success_cnt +  1

END FUNCTION

#單號過濾條件
PRIVATE FUNCTION aicp960_sel()
  #LET g_aicp960_sel = " pmdsent = ",g_enterprise,                                 #161231-00013#1 mark
   LET g_aicp960_sel = " pmdsent = ",g_enterprise,cl_sql_add_filter("pmds_t"),     #161231-00013#1 add
                       " AND pmdssite = '",g_site,"' ",
                       " AND pmds014 = '4' ",
                       " AND pmds041 IS NOT NULL ",
                       " AND pmds050 = 'Y' ",
                       " AND pmdsstus = 'S' ",
                       " AND pmds000 IN ('3','6') ",
                       #160902-00048#1-s-mod
                       #" AND pmds041 NOT IN (SELECT pmdsdocno FROM pmds_t WHERE pmds000 IN ('3','6') AND pmds014 = '4') "
                       " AND pmds041 NOT IN (SELECT pmdsdocno FROM pmds_t WHERE pmdsent='"||g_enterprise||"' AND pmds000 IN ('3','6') AND pmds014 = '4') "
                       #160902-00048#1-e-mod
END FUNCTION

################################################################################
# Descriptions...: 抓取該站的入庫單，過帳還原、取消確認並刪除所有資料
# Memo...........:
# Usage..........: CALL aicp960_pmds(p_site,p_pmds041,p_pmds053)
#                  RETURNING r_success
# Input parameter: p_site     營運據點
#                : p_pmds041  多角序號
#                : p_pmds053  多角代碼
# Return code....: r_success  執行結果
#                : 
# Date & Author..: 160115 By earl
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp960_pmds(p_site,p_pmds041,p_pmds053)
DEFINE p_site            LIKE pmds_t.pmdssite
DEFINE p_pmds041         LIKE pmds_t.pmds041
DEFINE p_pmds053         LIKE pmds_t.pmds053
DEFINE r_success         LIKE type_t.num5
DEFINE l_pmdsdocno       LIKE pmds_t.pmdsdocno
DEFINE l_pmdsdocdt       LIKE pmds_t.pmdsdocdt
DEFINE l_prog            LIKE gzzz_t.gzzz001
DEFINE l_site            LIKE ooef_t.ooef001
DEFINE l_argv1           LIKE type_t.chr10
DEFINE l_icab003_last    LIKE icab_t.icab003
DEFINE l_sql             STRING

   LET r_success = TRUE
   
   LET l_sql = "SELECT icab003",
               "  FROM icab_t",
               " WHERE icabent = ",g_enterprise,
               "   AND icab001 = '",p_pmds053,"'",
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

################################################################################
# Descriptions...: 抓取該站的出貨單，過帳還原、取消確認並刪除所有資料
# Memo...........:
# Usage..........: CALL aicp960_xmdk(p_site,p_xmdk035)
#                  RETURNING r_success
# Input parameter: p_site     營運據點
#                : p_xmdk035  多角序號
# Return code....: r_success  執行結果
#                : 
# Date & Author..: 160115 By earl
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp960_xmdk(p_site,p_xmdk035)
DEFINE p_site            LIKE xmdk_t.xmdksite
DEFINE p_xmdk035         LIKE xmdk_t.xmdk035
DEFINE r_success         LIKE type_t.num5
DEFINE l_xmdkdocno       LIKE xmdk_t.xmdkdocno
DEFINE l_xmdkdocdt       LIKE xmdk_t.xmdkdocdt
DEFINE l_prog            LIKE gzzz_t.gzzz001
DEFINE l_site            LIKE ooef_t.ooef001

   
   LET r_success = TRUE

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

#end add-point
 
{</section>}
 
