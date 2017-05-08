#該程式已解開Section, 不再透過樣板產出!
{<section id="aicp950.description" >}
#+ Version..: T100-ERP-1.00.00(SD版次:1,PD版次:1) Build-000055
#+ 
#+ Filename...: aicp950
#+ Description: 多角貿易出貨通知單拋轉作業
#+ Creator....: 02295(2014/05/08)
#+ Modifier...: 02295(2014/05/08)
#+ Buildtype..: 應用 p02 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="aicp950.global" >}
#150917-00001#4  2015/11/11 earl            修改s_aic_carry_gen_tri_bs與s_aic_carry_gen_tri_mr傳入參數邏輯
#151123-00007#1  2015/12/02 earl            修改單價計算
#150917-00001#2  2016/01/18 earl            新增"整批設定流程"Action
#160318-00025#15 2016/04/07 BY 07900        重复错误讯息的修改
#160428-00006#4  2016/06/26 By 02040        統購統付調整採購單為最終站，收貨單為起始站；多角流程為3:採購指定最終供應商
#161013-00051#1  2016/10/18 By shiun        整批調整據點組織開窗
#161231-00013#1  2016/01/11 By 08992        增加azzi850 部門權限控管
#170213-00043#1  2017/02/15 By 08171        若拋轉成功後已無符合的資料則不提示[指定的資料無法查詢到，....] 
 
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
        pmds053_desc     LIKE type_t.chr80
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
        pmdsdocdt1       LIKE pmds_t.pmdsdocdt,
        pmds041          LIKE pmds_t.pmds041
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
        err_site         LIKE pmds_t.pmdssite,
        err_site_desc    LIKE type_t.chr80,
        reason           LIKE type_t.chr1000
                     END RECORD
DEFINE g_detail4_d          DYNAMIC ARRAY OF type_g_detail4_d
DEFINE g_detail4_cnt        LIKE type_t.num5

DEFINE g_success_cnt        LIKE type_t.num5
DEFINE g_fail_cnt           LIKE type_t.num5

DEFINE g_aicp950_sel        STRING

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num5              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明

#end add-point
 
{</section>}
 
{<section id="aicp950.main" >}
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
   CREATE TEMP TABLE aicp950_tmp( 
       sel               LIKE type_t.chr1,
       pmdssite          LIKE pmds_t.pmdssite, 
       pmdlsite          LIKE pmdl_t.pmdlsite,
       pmds007           LIKE pmds_t.pmds007,
       pmdsdocno         LIKE pmds_t.pmdsdocno,
       pmdsdocdt         LIKE pmds_t.pmdsdocdt,
       pmds053           LIKE pmds_t.pmds053
       )
       
   CALL aicp950_sel()
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aicp950 WITH FORM cl_ap_formpath("aic",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aicp950_init()   
 
      #進入選單 Menu (="N")
      CALL aicp950_ui_dialog() 
 
      #add-point:畫面關閉前
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aicp950
   END IF 
   
   #add-point:作業離開前
   DROP TABLE aicp950_tmp
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aicp950.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aicp950_init()
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
 
{<section id="aicp950.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aicp950_ui_dialog()
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
   CALL aicp950_query()
   #end add-point
   
   WHILE TRUE
 
      CALL cl_dlg_query_bef_disp()  #相關查詢
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct
         CONSTRUCT BY NAME g_wc ON pmdsdocno,pmdsdocdt,pmdssite,pmdlsite,pmds007,pmds053

            BEFORE CONSTRUCT

            ON ACTION controlp INFIELD pmdsdocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
			      LET g_qryparam.where = g_aicp950_sel
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
               CALL aicp950_set_no_required_b()
               CALL aicp950_set_required_b()
             
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_master_idx = l_ac
               DISPLAY l_ac TO FORMONLY.h_index
               CALL aicp950_fetch() 
               #單身1可編輯，需備份舊值
               LET g_detail_d_t.* = g_detail_d[l_ac].*
               CALL aicp950_set_no_required_b()
               CALL aicp950_set_required_b()
            
            ON CHANGE b_sel
               CALL aicp950_set_no_required_b()
               CALL aicp950_set_required_b()
               
            AFTER FIELD b_pmds053
               CALL s_desc_get_icaa001_desc(g_detail_d[l_ac].pmds053)
               RETURNING g_detail_d[l_ac].pmds053_desc
               DISPLAY BY NAME g_detail_d[l_ac].pmds053_desc
               
               IF NOT cl_null(g_detail_d[l_ac].pmds053) THEN
                  IF g_detail_d[l_ac].pmds053 <> g_detail_d_t.pmds053 OR cl_null(g_detail_d_t.pmds053) THEN
                  
                     IF NOT aicp950_pmds053_chk() THEN
                        LET g_detail_d[l_ac].pmds053 = g_detail_d_t.pmds053
                        CALL s_desc_get_icaa001_desc(g_detail_d[l_ac].pmds053)
                        RETURNING g_detail_d[l_ac].pmds053_desc
                        DISPLAY BY NAME g_detail_d[l_ac].pmds053_desc
               
                        NEXT FIELD CURRENT
                     END IF
                     
                  END IF
               END IF
            
            ON ROW CHANGE
               UPDATE aicp950_tmp 
                  SET sel = g_detail_d[l_ac].sel, 
                      pmds053 = g_detail_d[l_ac].pmds053 
                WHERE pmdsdocno = g_detail_d[l_ac].pmdsdocno

            ON ACTION controlp INFIELD b_pmds053
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_detail_d[l_ac].pmds053
			     #LET g_qryparam.arg1 = '2'     #160428-00006#4 mark
			     #LET g_qryparam.arg2 = '2'     #160428-00006#4 mark   
			      LET g_qryparam.arg1 = '3'     #160428-00006#4 add   #3:採購指定最終供應商
			      LET g_qryparam.arg2 = '1'     #160428-00006#4 add   #正拋 			      
			      LET g_qryparam.arg3 = 'N'
              #LET g_qryparam.arg4 = g_detail_d[l_ac].pmdlsite     #160428-00006#4 mark
              #LET g_qryparam.arg5 = g_detail_d[l_ac].pmdssite     #160428-00006#4 mark
               LET g_qryparam.arg4 = g_detail_d[l_ac].pmdssite     #160428-00006#4 add 
               LET g_qryparam.arg5 = g_detail_d[l_ac].pmdlsite     #160428-00006#4 add
               
			      CALL q_icaa001_2()                        #呼叫開窗
               LET g_detail_d[l_ac].pmds053 = g_qryparam.return1
               DISPLAY g_detail_d[l_ac].pmds053 TO b_pmds053
               CALL s_desc_get_icaa001_desc(g_detail_d[l_ac].pmds053)
               RETURNING g_detail_d[l_ac].pmds053_desc
               DISPLAY g_detail_d[l_ac].pmds053_desc TO b_pmds053_desc
               
               NEXT FIELD b_pmds053
               
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
            
            CALL aicp950_sel()
            
            #end add-point
 
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
            END FOR
            #add-point:ui_dialog段on action selall
            UPDATE aicp950_tmp 
               SET sel = 'Y'
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "N"
            END FOR
            #add-point:ui_dialog段on action selnone
            UPDATE aicp950_tmp 
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
                  UPDATE aicp950_tmp 
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
                  UPDATE aicp950_tmp 
                     SET sel = 'N' 
                   WHERE pmdsdocno = g_detail_d[li_idx].pmdsdocno 
               END IF
            END FOR            
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL aicp950_filter()
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
            CALL aicp950_query()
 
         # 條件清除
         ON ACTION qbeclear
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            CALL aicp950_b_fill()
            CALL aicp950_fetch()
 
         #add-point:ui_dialog段action
         ON ACTION batch_execute
            #變更此筆資料後，直接按執行
            IF l_ac > 0 THEN
               IF g_detail_d[l_ac].sel = 'Y' THEN
                  IF cl_null(g_detail_d[l_ac].pmds053) THEN
                     NEXT FIELD pmds053
                  ELSE
                     #檢查多角流程代碼
                     CALL cl_err_collect_init()   #不重複跳出錯誤訊息
                     CALL aicp950_pmds053_chk() RETURNING l_success
                     CALL cl_err_collect_init()   #不重複跳出錯誤訊息
                     CALL cl_err_collect_show()   #不重複跳出錯誤訊息

                     IF NOT l_success THEN
                        NEXT FIELD pmds053
                     END IF
                  END IF
               END IF
               
               UPDATE aicp950_tmp 
                     SET sel = g_detail_d[l_ac].sel, 
                         pmds053 = g_detail_d[l_ac].pmds053 
                   WHERE pmdsdocno = g_detail_d[l_ac].pmdsdocno 
            END IF
            #-----------------------
            
            LET l_cnt = ''
            SELECT COUNT(*) INTO l_cnt
              FROM aicp950_tmp
             WHERE sel = 'Y'
            IF cl_null(l_cnt) OR l_cnt = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = '-400'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               
            ELSE
               CALL aicp950_process()
               LET INT_FLAG = TRUE     #170213-00043#1 17/02/15 By 08171 add
               CALL aicp950_query()
               LET INT_FLAG = FALSE    #170213-00043#1 17/02/15 By 08171 add
            END IF
            ACCEPT DIALOG
            
         #150917-00001#2 160118 earl add s
         #整批設定流程
         ON ACTION call_aicp900_01
            LET l_cnt = ''
            SELECT COUNT(*) INTO l_cnt
              FROM aicp950_tmp
            IF cl_null(l_cnt) OR l_cnt = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'agl-00066'   #單身無資料不可進行此操作
               LET g_errparam.popup = TRUE
               CALL cl_err()
            ELSE
               CALL aicp900_01('2')
               CALL aicp950_b_fill()
               CALL aicp950_fetch()
            END IF
         #150917-00001#2 160118 earl add e
            
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
 
{<section id="aicp950.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aicp950_query()
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define
 
   #end add-point 
   
   #add-point:cs段after_construct
   DELETE FROM aicp950_tmp
   
   LET g_sql = " SELECT DISTINCT 'N',pmdssite,pmdlsite,pmds007,pmdsdocno,pmdsdocdt,pmds053 ",
               "   FROM pmds_t",
               "        LEFT OUTER JOIN pmdl_t ON pmdlent = pmdsent ",
               "                               AND pmdldocno IN (SELECT DISTINCT pmdt001 ",
               "                                                   FROM pmdt_t WHERE pmdtent = pmdsent AND pmdtdocno = pmdsdocno)",
               "  WHERE ",g_aicp950_sel,
               "    AND ",g_wc
   LET g_sql = " INSERT INTO aicp950_tmp ",g_sql
   PREPARE tmp_ins_pre FROM g_sql
   EXECUTE tmp_ins_pre
   
   LET g_wc_filter = " 1=1"
   #end add-point
        
   LET g_error_show = 1
   CALL aicp950_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="aicp950.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aicp950_b_fill()
 
   DEFINE ls_wc           STRING
   #add-point:b_fill段define

   #end add-point
 
   #add-point:b_fill段sql_before
   LET g_sql = "SELECT DISTINCT sel,",
               "                pmdssite,'',",
               "                pmdlsite,'',",
               "                pmds007,'',",
               "                pmdsdocno,pmdsdocdt,",
               "                pmds053,'' ",
               "  FROM aicp950_tmp ",
               " WHERE ",g_wc_filter,
               " ORDER BY pmdsdocno "
   #end add-point
 
   PREPARE aicp950_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aicp950_sel
   
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
      g_detail_d[l_ac].pmds053,g_detail_d[l_ac].pmds053_desc
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
      
      CALL aicp950_detail_show()      
 
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
   FREE aicp950_sel
   
   LET l_ac = 1
   CALL aicp950_fetch()
   #add-point:b_fill段資料填充(其他單身)
   CALL aicp950_set_no_required_b()
   CALL aicp950_set_required_b()
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aicp950.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aicp950_fetch()
 
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
   PREPARE aicp950_fetch_pre FROM g_sql
   DECLARE aicp950_fetch_cur CURSOR FOR aicp950_fetch_pre

   FOREACH aicp950_fetch_cur INTO 
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
 
{<section id="aicp950.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aicp950_detail_show()
   #add-point:show段define
   
   #end add-point
 
   #add-point:detail_show段
 
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aicp950.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aicp950_filter()
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
   
   CONSTRUCT g_wc_filter ON pmdssite,pmdlsite,pmds007,pmdsdocno,pmdsdocdt,pmds053
        FROM s_detail1[1].b_pmdssite,s_detail1[1].b_pmdlsite,s_detail1[1].b_pmds007,
             s_detail1[1].b_pmdsdocno,s_detail1[1].b_pmdsdocdt,s_detail1[1].b_pmds053
           
      BEFORE CONSTRUCT
      
      ON ACTION controlp INFIELD pmdsdocno
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
		   LET g_qryparam.reqry = FALSE
		   LET g_qryparam.where = g_aicp950_sel
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

   END CONSTRUCT
   #end add-point    
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   
   CALL aicp950_b_fill()
   CALL aicp950_fetch()
   
END FUNCTION
 
{</section>}
 
{<section id="aicp950.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aicp950_filter_parser(ps_field)
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
 
{<section id="aicp950.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aicp950_filter_show(ps_field,ps_object)
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
   LET ls_condition = aicp950_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aicp950.other_function" >}
#add-point:自定義元件(Function)

################################################################################
# Descriptions...: 執行本作業,可將來源據點之多角入庫／出貨單拋轉至各站據點
# Memo...........:
# Usage..........: CALL aicp950_process()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 14/07/01 By emma
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp950_process()
DEFINE l_pmds             type_g_detail_d
DEFINE l_trino            LIKE pmdl_t.pmdl031
DEFINE l_success          LIKE type_t.num5

DEFINE l_icab_now     RECORD
    icab002               LIKE icab_t.icab002,           #當站站別
    icab003               LIKE icab_t.icab003,           #當站營運據點
    icab004               LIKE icab_t.icab004            #當站委外工單開立點否
                      END RECORD
DEFINE l_icab_next    RECORD
    icab002               LIKE icab_t.icab002,           #下站站別
    icab003               LIKE icab_t.icab003            #下站營運據點
                     END RECORD
#160428-00006#4-s-add
DEFINE l_icab_pre    RECORD
    icab002               LIKE icab_t.icab002,           #上站站別
    icab003               LIKE icab_t.icab003            #上站營運據點
                      END RECORD                      
#160428-00006#4-s-add
DEFINE l_pmdsdocno        LIKE pmds_t.pmdsdocno  #回傳產生之入庫單號
DEFINE l_xmdkdocno        LIKE xmdk_t.xmdkdocno  #回傳產生之出貨單號
DEFINE l_first_pmdsdocno  LIKE pmds_t.pmdsdocno
DEFINE l_site             LIKE icab_t.icab003
DEFINE l_num              LIKE type_t.num5


   #有選擇的入庫單
   LET g_sql = "SELECT pmdssite,pmdlsite,",
               "       pmds007,",
               "       pmdsdocno,pmdsdocdt,pmds053 ",
               "  FROM aicp950_tmp ",
               " WHERE sel = 'Y' ",
               " ORDER BY pmdsdocno "
   PREPARE aicp950_process_pre FROM g_sql
   DECLARE aicp950_process_cur CURSOR WITH HOLD FOR aicp950_process_pre
   
   #下站多角貿易營運據點
   LET g_sql = "SELECT icab002,icab003",
               "  FROM icab_t",
               " WHERE icabent = ",g_enterprise,
               "   AND icab001 = ?",
               "   AND icab002 > ?",
               " ORDER BY icab002"
   PREPARE aicp950_process_icab_next_pre FROM g_sql
  #DECLARE aicp950_process_icab_next_cur CURSOR FOR aicp950_process_icab_next_pre         #160428-00006#4 mark
   DECLARE aicp950_process_icab_next_cur SCROLL CURSOR FOR aicp950_process_icab_next_pre  #160428-00006#4 add
   
   #當站多角貿易營運據點(正拋)  ##160428-00006#4改為正拋   
   LET g_sql = "SELECT icab002,icab003,icab004",
               "  FROM icab_t",
               " WHERE icabent = ",g_enterprise,
               "   AND icab001 = ?",
              #" ORDER BY icab002 DESC"                   #160428-00006#4 mark
               " ORDER BY icab002 "                       #160428-00006#4 add
   PREPARE aicp950_process_icab_desc_pre FROM g_sql
   DECLARE aicp950_process_icab_desc_cur CURSOR FOR aicp950_process_icab_desc_pre

   #上站多角貿易營運據點
   LET g_sql = "SELECT icab002,icab003",
               "  FROM icab_t",
               " WHERE icabent = ",g_enterprise,
               "   AND icab001 = ?",
               "   AND icab002 < ?",
               " ORDER BY icab002 DESC"
   PREPARE aicp950_process_icab_pre_pre FROM g_sql
  #DECLARE aicp950_process_icab_pre_cur CURSOR FOR aicp950_process_icab_pre_pre        #160428-00006#4 mark
   DECLARE aicp950_process_icab_pre_cur SCROLL CURSOR FOR aicp950_process_icab_pre_pre #160428-00006#4 add
   
   CALL s_tax_recount_tmp()

   LET g_success_cnt = 1
   LET g_fail_cnt = 0
   CALL g_detail3_d.clear()
   CALL g_detail4_d.clear()
   CALL cl_err_collect_init()   #匯總訊息-初始化
   
   INITIALIZE l_pmds.* TO NULL
   FOREACH aicp950_process_cur INTO l_pmds.pmdssite,l_pmds.pmdlsite,
                                    l_pmds.pmds007,
                                    l_pmds.pmdsdocno,l_pmds.pmdsdocdt,l_pmds.pmds053
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'process_cur'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         
         #失敗記錄
         CALL aicp950_fail(l_pmds.*,'')
         EXIT FOREACH
      END IF
      
      CALL s_transaction_begin()
      LET g_fail_cnt = g_errcollect.getLength()  #先取得錯誤訊息的長度，大於此長度的表示是這張單子的錯誤訊息
      LET l_success = TRUE
      LET l_trino = ''
      LET l_xmdkdocno = ''
      LET l_pmdsdocno = ''
      
      #多角流程代碼為空白時，錯誤
      IF cl_null(l_pmds.pmds053) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'aic-00026'   #多角流程代碼不可為空
         LET g_errparam.extend = l_pmds.pmdsdocno
         LET g_errparam.popup = TRUE
         CALL cl_err()
         
         CALL s_transaction_end('N',0)
         #失敗記錄
         CALL aicp950_fail(l_pmds.*,'')
         CONTINUE FOREACH
      END IF
      
      #呼叫產生多角序號元件取得多角流程序號，並回寫入庫單單頭pmds041
      CALL s_aic_carry_gettrino(l_pmds.pmds053,'4',g_today,g_site)
           RETURNING l_success,l_trino
      IF NOT l_success THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'amm-00001'   #自動生成單號失敗！
         LET g_errparam.extend = l_pmds.pmdsdocno
         LET g_errparam.popup = TRUE
         CALL cl_err()
         
         CALL s_transaction_end('N',0)
         #失敗記錄
         CALL aicp950_fail(l_pmds.*,'')
         CONTINUE FOREACH
      END IF
      
      #回寫入庫單頭多角序號、多角貿易已拋轉
      UPDATE pmds_t SET pmds041 = l_trino,
                        pmds053 = l_pmds.pmds053,
                        pmds050 = 'Y'
       WHERE pmdsent = g_enterprise
         AND pmdsdocno = l_pmds.pmdsdocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'UPDATE pmds_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         
         CALL s_transaction_end('N',0)
         #失敗記錄
         CALL aicp950_fail(l_pmds.*,'')
         CONTINUE FOREACH
      END IF
      
      #跑站(當站)
      LET l_num = 0
      INITIALIZE l_icab_now.* TO NULL
      OPEN aicp950_process_icab_desc_cur USING l_pmds.pmds053
      FOREACH aicp950_process_icab_desc_cur INTO l_icab_now.icab002,l_icab_now.icab003,l_icab_now.icab004
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'FOREACH:aicp950_process_icab_desc_cur'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            
            LET l_success = FALSE
            EXIT FOREACH
         END IF
                  
         INITIALIZE l_icab_pre.* TO NULL       #160428-00006#4 add
         INITIALIZE l_icab_next.* TO NULL
         
        #160428-00006#4-s-mark
        ##取上站
        #OPEN aicp950_process_icab_pre_cur USING l_pmds.pmds053,l_icab_now.icab002
        #FOREACH aicp950_process_icab_pre_cur INTO l_icab_next.icab002,l_icab_next.icab003
        #   IF SQLCA.sqlcode THEN
        #      INITIALIZE g_errparam TO NULL
        #      LET g_errparam.code = SQLCA.sqlcode
        #      LET g_errparam.extend = 'aicp950_process_icab_pre_cur'
        #      LET g_errparam.popup = TRUE
        #      CALL cl_err()
        #      
        #      LET l_success = FALSE
        #      EXIT FOREACH
        #   END IF
        #   EXIT FOREACH
        #END FOREACH         
        #160428-00006#4-e-mark 
        
        #160428-00006#4-s-add
         #出貨單的客戶：上一站
         #收貨入庫單的供應商：下一站         
         #取上站
         OPEN aicp950_process_icab_pre_cur USING l_pmds.pmds053,l_icab_now.icab002
         FETCH FIRST aicp950_process_icab_pre_cur INTO l_icab_pre.icab002,l_icab_pre.icab003
         #取下站        
         OPEN aicp950_process_icab_next_cur USING l_pmds.pmds053,l_icab_now.icab002
         FETCH FIRST aicp950_process_icab_next_cur INTO l_icab_next.icab002,l_icab_next.icab003         
        #160428-00006#4-e-add
         IF NOT l_success THEN
            EXIT FOREACH
         END IF
         
         #起始站
         IF l_num = 0 THEN
            #LET l_site = l_icab_now.icab003          #160428-00006#4 mark
            LET l_first_pmdsdocno = l_pmds.pmdsdocno  #初始入庫單號
            LET l_pmdsdocno = l_pmds.pmdsdocno
            
            LET l_num = l_num + 1
           #160428-00006#4-s-mark(起始站不需產生出貨單，改由最終站產生) 
           ##產生多角出貨單
           #CALL s_aic_carry_gen_tri_bs(l_pmds.pmdsdocno,l_pmdsdocno,'','1',l_pmds.pmdsdocdt,l_pmds.pmds053,l_icab_now.icab002,'aicp950',l_icab_next.icab003)
           #     RETURNING l_success,l_xmdkdocno
           #IF NOT l_success THEN
           #   EXIT FOREACH
           #END IF
           #160428-00006#4-e-mark 
            CONTINUE FOREACH
         END IF
         
         IF NOT cl_null(l_icab_next.icab002) THEN  #中間站
           #產生中間站之多角收貨入庫單
           #CALL s_aic_carry_gen_tri_mr(l_pmds.pmdsdocno,l_xmkdocno,'',l_pmds.pmdsdocdt,l_pmds.pmds053,l_icab_now.icab002,'aicp950',l_site)                          #160428-00006#4 mark      
            CALL s_aic_carry_gen_tri_mr(l_pmds.pmdsdocno,l_xmdkdocno,l_pmdsdocno,l_pmds.pmdsdocdt,l_pmds.pmds053,l_icab_now.icab002,'aicp950',l_icab_next.icab003)   #160428-00006#4 add
                 RETURNING l_success,l_pmdsdocno
            IF NOT l_success THEN
               EXIT FOREACH
            END IF
             
           #產生中間站之多角出貨單
           #CALL s_aic_carry_gen_tri_bs(l_pmds.pmdsdocno,l_pmdsdocno,'','1',l_pmds.pmdsdocdt,l_pmds.pmds053,l_icab_now.icab002,'aicp950',l_icab_next.icab003)        #160428-00006#4 mark        
            CALL s_aic_carry_gen_tri_bs(l_pmds.pmdsdocno,l_pmdsdocno,'','1',l_pmds.pmdsdocdt,l_pmds.pmds053,l_icab_now.icab002,'aicp950',l_icab_pre.icab003)         #160428-00006#4 add 
                 RETURNING l_success,l_xmdkdocno
            IF NOT l_success THEN
               EXIT FOREACH
            END IF
      
            #LET l_site = l_icab_now.icab003   #160428-00006#4 mark
         END IF
         #160428-00006#4-s-add
         #最終站產生出貨單
          IF cl_null(l_icab_next.icab002) THEN 
            #產生多角出貨單
             CALL s_aic_carry_gen_tri_bs(l_pmds.pmdsdocno,l_pmdsdocno,'','1',l_pmds.pmdsdocdt,l_pmds.pmds053,l_icab_now.icab002,'aicp950',l_icab_pre.icab003)
               RETURNING l_success,l_xmdkdocno
             IF NOT l_success THEN
                EXIT FOREACH
             END IF         
          END IF 
         #160428-00006#4-e-add         
      END FOREACH
      
      #151123-00007#1 151202 earl s
      IF l_success THEN
         CALL s_aic_carry_unite_price_upd('2',l_pmds.pmdsdocno) RETURNING l_success
      END IF
      #151123-00007#1 151202 earl e
      
      IF l_success THEN
         CALL s_transaction_end('Y',0)
         #成功記錄
         CALL aicp950_success(l_pmds.*,l_trino)
      ELSE
         CALL s_transaction_end('N',0)
         #失敗記錄
         CALL aicp950_fail(l_pmds.*,l_icab_now.icab003)
      END IF
      
   END FOREACH
  #160428-00006#4-e-add
   CLOSE aicp950_process_icab_next_cur
   CLOSE aicp950_process_icab_pre_cur
  #160428-00006#4-e-add
   #清空錯誤訊息的array，並且之後的訊息不以array記錄
   CALL cl_err_collect_init()
   CALL cl_err_collect_show()
   
   CALL cl_ask_pressanykey("std-00012")
   
END FUNCTION

################################################################################
# Descriptions...: 多角流程代碼校驗
# Memo...........:
# Usage..........: CALL aicp950_pmds053_chk()
#                  RETURNING r_success
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 14/07/01 By emma
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp950_pmds053_chk()
   DEFINE l_gzcbl004    LIKE gzcbl_t.gzcbl004
   DEFINE r_success     LIKE type_t.num5
   
   LET r_success = TRUE

   INITIALIZE g_chkparam.* TO NULL
  #160318-00025#15 by 07900 --add-str 
   LET g_errshow = TRUE #是否開窗
  #160318-00025#15 by 07900 --add-end
   LET g_chkparam.arg1 = g_detail_d[l_ac].pmds053
  #160428-00006#4-s-mark 
  #LET g_chkparam.arg2 = g_detail_d[l_ac].pmdlsite
  #LET g_chkparam.arg3 = g_detail_d[l_ac].pmdssite
  #LET g_chkparam.arg4 = '2'
  #160428-00006#4-e-mark 
  #160428-00006#4-s-add 
   LET g_chkparam.arg2 = g_detail_d[l_ac].pmdssite
   LET g_chkparam.arg3 = g_detail_d[l_ac].pmdlsite
   LET g_chkparam.arg4 = '3'
  #160428-00006#4-e-add
  
   LET l_gzcbl004 = ''
   SELECT gzcbl004 INTO l_gzcbl004
     FROM gzcbl_t
    WHERE gzcbl001 = '2501'
      AND gzcbl002 = '2'
      AND gzcbl003 = g_dlang
   LET l_gzcbl004 = g_chkparam.arg4,".",l_gzcbl004
   LET g_chkparam.err_str[1] = "aic-00084|",l_gzcbl004
  #160318-00025#15 by 07900 --add-str 
   LET g_chkparam.err_str[1] ="aic-00012:sub-01302|aici100|",cl_get_progname("aici100",g_lang,"2"),"|:EXEPROGaici100"
  #160318-00025#15 by 07900 --add-end 
  #IF NOT cl_chk_exist("v_icaa001_2") THEN   #160428-00006#4 mark
   IF NOT cl_chk_exist("v_icaa001_9") THEN   #160428-00006#4 add
      LET r_success = FALSE
   END IF
  #160428-00006#4-s-add
  #需檢查aici120計價基準：3:依最終供應商逆推4:依下游供應商單價逆推
   IF NOT s_aic_carry_get_tri_pm(g_detail_d[l_ac].pmds053,g_detail_d[l_ac].pmdssite,g_detail_d[l_ac].pmdsdocdt) THEN
      LET r_success = FALSE
   END IF      
  #160428-00006#4-e-add   
   
   
   
   RETURN r_success
END FUNCTION

####################################################################################################
# Descriptions...: 失敗紀錄
# Memo...........:
# Usage..........: CALL aicp950_fail(p_pmds,p_pmdssite)
# Input parameter: 
# Return code....: 
# Date & Author..: 14/07/02 By emma
# Modify.........:
####################################################################################################
PRIVATE FUNCTION aicp950_fail(p_pmds,p_pmdssite)
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
      LET g_detail4_d[l_i].err_site = p_pmdssite
      
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
# Usage..........: CALL aicp950_success(p_pmds,p_pmds041)
# Input parameter: 
# Return code....: 
# Date & Author..: 14/07/02 By emma
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp950_success(p_pmds,p_pmds041)
   DEFINE p_pmds       type_g_detail_d
   DEFINE p_pmds041    LIKE pmds_t.pmds041

   IF cl_null(g_success_cnt) THEN
      LET g_success_cnt = 1
   END IF
      
   LET g_detail3_d[g_success_cnt].pmdssite1  = p_pmds.pmdssite
   LET g_detail3_d[g_success_cnt].pmdlsite1  = p_pmds.pmdlsite
   LET g_detail3_d[g_success_cnt].pmds0071   = p_pmds.pmds007
   LET g_detail3_d[g_success_cnt].pmdsdocno1 = p_pmds.pmdsdocno
   LET g_detail3_d[g_success_cnt].pmdsdocdt1 = p_pmds.pmdsdocdt
   LET g_detail3_d[g_success_cnt].pmds041    = p_pmds041
   
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
PRIVATE FUNCTION aicp950_sel()
  #LET g_aicp950_sel = " pmdsent = ",g_enterprise,                                 #161231-00013#1 mark
   LET g_aicp950_sel = " pmdsent = ",g_enterprise,cl_sql_add_filter("pmds_t"),     #161231-00013#1 add
                       " AND pmdssite = '",g_site,"' ",
                       " AND pmds014 = '4' ",
                       " AND pmds041 IS NULL ",
                       " AND pmds050 = 'N' ",
                       " AND pmdsstus = 'S' ",
                       " AND pmds000 IN ('3','6') "
END FUNCTION

PRIVATE FUNCTION aicp950_set_no_required_b()
   CALL cl_set_comp_required("b_pmds053",FALSE)
END FUNCTION

PRIVATE FUNCTION aicp950_set_required_b()
   IF g_detail_d[l_ac].sel = 'Y' THEN
      CALL cl_set_comp_required("b_pmds053",TRUE)
   END IF
END FUNCTION

#end add-point
 
{</section>}
 
