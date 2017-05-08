#該程式已解開Section, 不再透過樣板產出!
{<section id="aicp210.description" >}
#+ Version..: T100-ERP-1.00.00(SD版次:1,PD版次:1) Build-000055
#+ 
#+ Filename...: aicp210
#+ Description: 多角貿易出貨通知單拋轉作業
#+ Creator....: 02295(2014/05/08)
#+ Modifier...: 02295(2014/05/08)
#+ Buildtype..: 應用 p02 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="aicp210.global" >}
#161024-00057#14 2016/10/26 By Whitney  刪除sfad_t和sfae_t相關程式
#161229-00033#1  2016/12/29 By ouhz     调整多角订单过滤不存在收货入库单（不包括作废）问题
#170105-00013#1  2017/01/05 BY 08993    採購單號開窗邏輯需調整為排除掉已有收貨、入庫且未作廢的採購單號
#170106-00005#1  2017/01/12 BY charles4m 1. 採購逆拋 判斷最終站有沒有出通單、出貨單
#                                        2. 採購正拋 判斷來源佔有沒有出通單、出貨單
#                                        3. 採購逆拋有最終供應商 判斷最終站有沒有採購單、收貨單、入庫單
#161231-00013#1  2016/01/23 By 08992   增加azzi850 部門權限控管
#170206-00010#1  2017/02/08 By charles4m 不同 ent 有相同的訂單單號，程式少判斷到 ent 當SQL 條件，沒撈到資料
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
       pmdl006           LIKE pmdl_t.pmdl006,          #多角性質 
       pmdl005           LIKE pmdl_t.pmdl005,          #採購性質 
       pmdldocno         LIKE pmdl_t.pmdldocno,        #採購單號  
       pmdldocdt         LIKE pmdl_t.pmdldocdt,        #採購日期 
       pmdl004           LIKE pmdl_t.pmdl004,          #供應商編號 
       pmdl004_desc      LIKE type_t.chr80,
       pmdl002           LIKE pmdl_t.pmdl002,          #採購人員 
       pmdl002_desc      LIKE type_t.chr80,
       pmdl003           LIKE pmdl_t.pmdl003,          #採購部門 
       pmdl003_desc      LIKE type_t.chr80,
       pmdlownid         LIKE pmdl_t.pmdlownid,        #資料所有者 
       pmdlownid_desc    LIKE type_t.chr80,
       pmdlcrtid         LIKE pmdl_t.pmdlcrtid,        #資料建立者 
       pmdlcrtid_desc    LIKE type_t.chr80,
       pmdl051           LIKE pmdl_t.pmdl051,          #多角流程代碼 
       pmdl051_desc      LIKE type_t.chr80,
       pmdl052           LIKE pmdl_t.pmdl052,          #最終供應商 
       pmdl052_desc      LIKE type_t.chr80,
       pmdl031           LIKE pmdl_t.pmdl031           #多角流程序號 
                     END RECORD
DEFINE g_detail_d_t      type_g_detail_d

TYPE type_g_detail2_d RECORD
       pmdnseq           LIKE pmdn_t.pmdnseq,          #採購項次  
       pmdn027           LIKE pmdn_t.pmdn027,          #供應商料號 
       pmdn001           LIKE pmdn_t.pmdn001,          #料件編號 
       pmdn001_desc      LIKE type_t.chr80,
       pmdn001_desc_desc LIKE type_t.chr80,
       pmdn007           LIKE pmdn_t.pmdn007,          #採購數量 
       pmdn015           LIKE pmdn_t.pmdn015,          #單價 
       pmdn046           LIKE pmdn_t.pmdn046,          #未稅金額 
       pmdn047           LIKE pmdn_t.pmdn047,          #含稅金額 
       pmdn014           LIKE pmdn_t.pmdn014           #到庫日期 
                      END RECORD
DEFINE g_detail2_d       DYNAMIC ARRAY OF type_g_detail2_d
DEFINE g_detail2_cnt     LIKE type_t.num5
DEFINE g_rec_b           LIKE type_t.num5

TYPE type_g_detail3_d RECORD
       pmdldocno1        LIKE pmdl_t.pmdldocno, 
       pmdldocdt1        LIKE pmdl_t.pmdldocdt,
       pmdl0041          LIKE pmdl_t.pmdl004,
       pmdl0041_desc     LIKE type_t.chr80,
       pmdl0021          LIKE pmdl_t.pmdl002,
       pmdl0021_desc     LIKE type_t.chr80,
       pmdl0031          LIKE pmdl_t.pmdl003,
       pmdl0031_desc     LIKE type_t.chr80,
       pmdl0511          LIKE pmdl_t.pmdl051
                      END RECORD
DEFINE g_detail3_d       DYNAMIC ARRAY OF type_g_detail3_d
DEFINE g_detail3_cnt     LIKE type_t.num5

TYPE type_g_detail4_d RECORD
       pmdldocno2        LIKE pmdl_t.pmdldocno, 
       pmdldocdt2        LIKE pmdl_t.pmdldocdt,
       pmdl0042          LIKE pmdl_t.pmdl004,
       pmdl0042_desc     LIKE type_t.chr80,
       pmdl0022          LIKE pmdl_t.pmdl002,
       pmdl0022_desc     LIKE type_t.chr80,
       pmdl0032          LIKE pmdl_t.pmdl003,
       pmdl0032_desc     LIKE type_t.chr80,
       pmdl0312          LIKE pmdl_t.pmdl031,
       pmdl0522          LIKE pmdl_t.pmdl052,
       pmdl0522_desc     LIKE type_t.chr80,
       b_pmdlsite2       LIKE pmdl_t.pmdlsite,
       b_pmdlsite2_desc  LIKE type_t.chr80,
       reason            LIKE type_t.chr1000
                      END RECORD
DEFINE g_detail4_d       DYNAMIC ARRAY OF type_g_detail4_d
DEFINE g_detail4_cnt     LIKE type_t.num5
DEFINE g_icab003         LIKE icab_t.icab003   #多角流程代碼最終站的營運據點 
DEFINE g_success_cnt     LIKE type_t.num5
DEFINE g_fail_cnt        LIKE type_t.num5

DEFINE g_aicp210_sel     STRING

#170106-00005#1 ---add (s)---
TYPE type_g_pmdl_d  RECORD
                         icaa003      LIKE icaa_t.icaa003,
                         icaa004      LIKE icaa_t.icaa004,
                         icaa011      LIKE icaa_t.icaa011,
                         icab002      LIKE icab_t.icab002,
                         pmdldocno    LIKE pmdl_t.pmdldocno,
                         pmdldocdt    LIKE pmdl_t.pmdldocdt,
                         pmdl004      LIKE pmdl_t.pmdl004,
                         pmdl002      LIKE pmdl_t.pmdl002,
                         pmdl003      LIKE pmdl_t.pmdl003,
                         pmdl008      LIKE pmdl_t.pmdl008,
                         pmdl033      LIKE pmdl_t.pmdl033,
                         pmdlownid    LIKE pmdl_t.pmdlownid,
                         pmdlcrtid    LIKE pmdl_t.pmdlcrtid,
                         pmdl051      LIKE pmdl_t.pmdl051,
                         pmdl031      LIKE pmdl_t.pmdl031,
                         pmdlent      LIKE pmdl_t.pmdlent
                      END RECORD
DEFINE g_pmdl_d   DYNAMIC ARRAY OF type_g_pmdl_d
DEFINE g_pmdl_d_t type_g_pmdl_d
#170106-00005#1 ---add (e)---
#end add-point
DEFINE g_detail_cnt         LIKE type_t.num5              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明

#end add-point
 
{</section>}
 
{<section id="aicp210.main" >}
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
   CALL aicp210_create_temp_table()
   
   CALL aicp210_sel()
   
   IF NOT cl_null(g_argv[1]) THEN
      LET g_bgjob = 'Y'
   END IF
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call
      IF NOT cl_null(g_argv[1]) THEN
         LET g_wc = " pmdldocno = '",g_argv[1],"' "
         CALL aicp210_query()
         
         UPDATE aicp210_tmp SET sel = 'Y'
         
         CALL aicp210_process()
      END IF
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aicp210 WITH FORM cl_ap_formpath("aic",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aicp210_init()   
 
      #進入選單 Menu (="N")
      CALL aicp210_ui_dialog() 
 
      #add-point:畫面關閉前
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aicp210
   END IF 
   
   #add-point:作業離開前
   DROP TABLE aicp210_tmp;
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aicp210.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aicp210_init()
   #add-point:init段define
   
   #end add-point   
 
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化
   CALL cl_set_combo_scc_part('b_pmdl006','2053','2,3')
   CALL cl_set_combo_scc_part('pmdl006','2053','2,3')
   CALL cl_set_combo_scc('b_pmdl005','2052')
   CALL cl_set_combo_scc('pmdl005','2052')
   
   LET g_errshow = 1
   IF cl_null(g_bgjob) THEN
      LET g_bgjob = 'N'
   END IF
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aicp210.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aicp210_ui_dialog()
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
   LET g_wc = " 1=1"
   #end add-point
   
   WHILE TRUE
 
      CALL cl_dlg_query_bef_disp()  #相關查詢
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct
         CONSTRUCT BY NAME g_wc ON pmdl006,pmdl005,pmdldocno,pmdldocdt,pmdl004,
                                   pmdl002,pmdl003,pmdlownid,pmdlcrtid,pmdl051,
                                   pmdl052 

            BEFORE CONSTRUCT
            
            ON ACTION controlp INFIELD pmdldocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = g_aicp210_sel
               CALL q_pmdldocno()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmdldocno  #顯示到畫面上
               NEXT FIELD pmdldocno                     #返回原欄位    
               
            ON ACTION controlp INFIELD pmdl004
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_pmaa001_3()                     #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmdl004  #顯示到畫面上
               NEXT FIELD pmdl004                     #返回原欄位
   
            ON ACTION controlp INFIELD pmdl002
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmdl002  #顯示到畫面上
               NEXT FIELD pmdl002                     #返回原欄位
               
            ON ACTION controlp INFIELD pmdl003
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooeg001()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmdl003  #顯示到畫面上
               NEXT FIELD pmdl003                     #返回原欄位
               
            ON ACTION controlp INFIELD pmdlownid
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmdlownid  #顯示到畫面上
               NEXT FIELD pmdlownid                     #返回原欄位
   
            ON ACTION controlp INFIELD pmdlcrtid
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                          #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmdlcrtid  #顯示到畫面上
               NEXT FIELD pmdlcrtid                     #返回原欄位
               
            ON ACTION controlp INFIELD pmdl051
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1  = '0' 
               CALL q_icaa001_5()
               DISPLAY g_qryparam.return1 TO pmdl051
               NEXT FIELD pmdl051
               
            ON ACTION controlp INFIELD pmdl052
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_pmaa001_3()
               DISPLAY g_qryparam.return1 TO pmdl052
               NEXT FIELD pmdl052
   
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
               CALL aicp210_fetch()       
               
            ON ROW CHANGE
               UPDATE aicp210_tmp SET sel = g_detail_d[l_ac].sel
                WHERE pmdldocno = g_detail_d[l_ac].pmdldocno 
                  
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
            
            CALL aicp210_sel()
            
            IF g_detail_d.getLength() <= 0 THEN 
               NEXT FIELD pmdl006 
            END IF 
            #end add-point
 
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
            END FOR
            #add-point:ui_dialog段on action selall
            UPDATE aicp210_tmp SET sel = 'Y'
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "N"
            END FOR
            #add-point:ui_dialog段on action selnone
            UPDATE aicp210_tmp SET sel = 'N'
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
                  UPDATE aicp210_tmp SET sel = 'Y' 
                   WHERE pmdldocno = g_detail_d[li_idx].pmdldocno
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
                  UPDATE aicp210_tmp SET sel = 'N' 
                   WHERE pmdldocno = g_detail_d[li_idx].pmdldocno
               END IF
            END FOR           
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL aicp210_filter()
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
            CALL aicp210_query()
 
         # 條件清除
         ON ACTION qbeclear
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            CALL aicp210_b_fill()
            CALL aicp210_fetch()
 
         #add-point:ui_dialog段action
         ON ACTION batch_execute
            #變更此筆資料後，直接按執行
            IF l_ac > 0 THEN
               UPDATE aicp210_tmp SET sel = g_detail_d[l_ac].sel
                WHERE pmdldocno = g_detail_d[l_ac].pmdldocno
            END IF
            #-----
            
            LET l_cnt = ''
            SELECT COUNT(*) INTO l_cnt
              FROM aicp210_tmp
             WHERE sel = 'Y'
            IF cl_null(l_cnt) OR l_cnt = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = '-400'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

            ELSE
               CALL aicp210_process() 
               LET INT_FLAG = TRUE     #170213-00043#1 17/02/15 By 08171 add
               CALL aicp210_query()
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
 
{<section id="aicp210.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aicp210_query()
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define

   #end add-point 
   
   #add-point:cs段after_construct
   DELETE FROM aicp210_tmp;
  #170106-00005#1 ---mark (s)---
  #LET g_sql = "SELECT DISTINCT 'N',pmdl006,pmdl005,pmdldocno,pmdldocdt,pmdl004, ",
  #            "       pmdl002,pmdl003,pmdlownid,pmdlcrtid,pmdl051,pmdl052,pmdl031 ",
  #            "  FROM pmdl_t ",
  #            " WHERE ",g_aicp210_sel,
  #            "   AND ",g_wc
  ##170106-00005#1 ---mark (e)---
  
  #170106-00005#1 ---add (s)---  
  LET l_ac = 1
  LET g_sql = " SELECT icaa003,icaa004,icaa011,icab002,pmdldocno,pmdldocdt,pmdl004, ",
               "       pmdl002,pmdl003,pmdl008,pmdl033,pmdlownid, ",
               "       pmdlcrtid,pmdl051,pmdl031,pmdlent ", 
               "  FROM pmdl_t,icab_t,icaa_t ",
               " WHERE ",g_aicp210_sel,
              #"   AND icabent=pmdlent AND icab003=pmdlsite AND icaaent=pmdlent AND icaasite=pmdlsite ", ##170206-00010#1 mark
               "   AND icabent=pmdlent AND icab003=pmdlsite AND icaaent=pmdlent ", #170206-00010#1 add
               "   AND icaa001=pmdl051 AND icab001=pmdl051 ",
               "   AND ",g_wc
               
  PREPARE aicp210_pmdl_1_pre FROM g_sql
  DECLARE aicp210_pmdl_1_cur CURSOR FOR aicp210_pmdl_1_pre
  FOREACH aicp210_pmdl_1_cur INTO g_pmdl_d[l_ac].*
      
     LET g_sql = "    SELECT DISTINCT 'N',pmdl006,pmdl005,pmdldocno,pmdldocdt,pmdl004, ",
                  "       pmdl002,pmdl003,pmdlownid,pmdlcrtid,pmdl051,pmdl052,pmdl031 ",
                 "      FROM pmdl_t a, icab_t c ",
                 "     WHERE c.icabent = a.pmdlent AND c.icab001 = '",g_pmdl_d[l_ac].pmdl051,"'",
                 "       AND a.pmdldocno = '",g_pmdl_d[l_ac].pmdldocno,"'",
                 "       AND c.icab002 = '0' "
              
     IF g_pmdl_d[l_ac].icaa003 = '1' THEN #銷售
        IF g_pmdl_d[l_ac].icaa004 = '1' THEN #出貨
           LET g_sql = g_sql , "   AND (c.icab002 = '0' ", #銷售正拋，來源站不可存在非作廢的出貨單  
                               "   AND NOT EXISTS(SELECT * FROM xmdk_t,xmdl_t",
                               "                   WHERE xmdkent = xmdlent ",
                               "                     AND xmdkdocno = xmdldocno",
                               "                     AND xmdkent = a.pmdlent", #170206-00010#1 add
                               "                     AND xmdl003 = '",g_pmdl_d[l_ac].pmdl008,"' ",
                               "                     AND xmdkstus <> 'X')"
        ELSE
           LET g_sql = g_sql , "   AND (NOT EXISTS (SELECT 1 FROM xmda_t b, icab_t d, xmdl_t, xmdk_t",  #銷售逆拋、最終站不可存在非作廢的出貨單
                               "                            WHERE b.xmda031 = a.pmdl031 AND d.icab001 = c.icab001 ",
                               "                              AND b.xmdaent = d.icabent AND b.xmda050 = d.icab001 ",
                               "                              AND b.xmdasite = d.icab003 ",
                               "                              AND xmdkent = a.pmdlent", #170206-00010#1 add
                               "                              AND xmdl003 = b.xmdadocno AND xmdkent = xmdlent ",
                               "                              AND xmdkdocno = xmdldocno AND xmdkstus <> 'X' ",
                               "                              AND d.icab002 = (SELECT MAX (e.icab002) ",
                               "                                                 FROM icab_t e ",
                               "                                                WHERE e.icabent = d.icabent AND e.icab001 = d.icab001)) "
        END IF 
        
        IF g_pmdl_d[l_ac].icaa011 = '1' THEN #出通
           LET g_sql = g_sql , "   AND c.icab002 = '0' ", #銷售正拋，來源站不可存在非作廢的出通單  
                               "   AND NOT EXISTS(SELECT * FROM xmdg_t,xmdh_t",
                               "                   WHERE xmdgent = xmdhent ",
                               "                     AND xmdgdocno = xmdhdocno",
                               "                     AND xmdgent = a.pmdlent", #170206-00010#1 add
                               "                     AND xmdh001 = '",g_pmdl_d[l_ac].pmdl008,"'",
                               "                     AND xmdgstus <> 'X'))"
        ELSE
           LET g_sql = g_sql , "   AND NOT EXISTS(SELECT 1 FROM xmda_t f, icab_t g, xmdg_t,xmdh_t ", #銷售逆拋、最終站不可存在非作廢的出通單
                               "                            WHERE f.xmda031 = a.pmdl031 AND g.icab001 = c.icab001 ",
                               "                              AND f.xmdaent = g.icabent AND f.xmda050 = g.icab001 ",
                               "                              AND f.xmdasite = g.icab003 ",
                               "                              AND xmdgent = a.pmdlent", #170206-00010#1 add
                               "                              AND xmdh001 = f.xmdadocno AND xmdgent = xmdhent ",
                               "                              AND xmdgdocno = xmdhdocno AND xmdgstus <> 'X' ",
                               "                              AND g.icab002 = (SELECT MAX (h.icab002) ",
                               "                                                 FROM icab_t h ",
                               "                                                WHERE h.icabent = g.icabent AND h.icab001 = g.icab001))) "
        END IF  
     END IF
     IF g_pmdl_d[l_ac].icaa003 = '2' THEN #代採
        IF g_pmdl_d[l_ac].icaa004 = '1' THEN #出貨
           LET g_sql = g_sql , "   AND (c.icab002 = '0' ", #代採正拋，來源站不可存在非作廢的收貨、入庫單  
                               "   AND NOT EXISTS(SELECT * FROM pmds_t,pmdt_t",
                               "                   WHERE pmdsent = pmdtent ",
                               "                     AND pmdsdocno = pmdtdocno",
                               "                     AND pmdsent = a.pmdlent", #170206-00010#1 add
                               "                     AND pmdt001 = '",g_pmdl_d[l_ac].pmdldocno,"'",
                               "                     AND pmdsstus <> 'X')"
        ELSE
           LET g_sql = g_sql , "   AND (NOT EXISTS (SELECT 1 FROM xmda_t b, icab_t d, xmdl_t, xmdk_t",  #代採逆拋、最終站不可存在非作廢的出貨單
                               "                            WHERE b.xmda031 = a.pmdl031 AND d.icab001 = c.icab001 ",
                               "                              AND b.xmdaent = d.icabent AND b.xmda050 = d.icab001 ",
                               "                              AND b.xmdasite = d.icab003 ",
                               "                              AND xmdkent = a.pmdlent", #170206-00010#1 add
                               "                              AND xmdl003 = b.xmdadocno AND xmdkent = xmdlent ",
                               "                              AND xmdkdocno = xmdldocno AND xmdkstus <> 'X' ",
                               "                              AND d.icab002 = (SELECT MAX (e.icab002) ",
                               "                                                 FROM icab_t e ",
                               "                                                WHERE e.icabent = d.icabent AND e.icab001 = d.icab001)) "
        END IF 
        
        IF g_pmdl_d[l_ac].icaa011 = '2' THEN #出通
           LET g_sql = g_sql , "   AND NOT EXISTS(SELECT 1 FROM xmda_t f, icab_t g, xmdg_t,xmdh_t ", #代採逆拋、最終站不可存在非作廢的出通單
                               "                            WHERE f.xmda031 = a.pmdl031 AND g.icab001 = c.icab001 ",
                               "                              AND f.xmdaent = g.icabent AND f.xmda050 = g.icab001 ",
                               "                              AND f.xmdasite = g.icab003 ",
                               "                              AND xmdgent = a.pmdlent", #170206-00010#1 add
                               "                              AND xmdh001 = f.xmdadocno AND xmdgent = xmdhent ",
                               "                              AND xmdgdocno = xmdhdocno AND xmdgstus <> 'X' ",
                               "                              AND g.icab002 = (SELECT MAX (h.icab002) ",
                               "                                                 FROM icab_t h ",
                               "                                                WHERE h.icabent = g.icabent AND h.icab001 = g.icab001))) "
        END IF  
     END IF
     IF g_pmdl_d[l_ac].icaa003 = '3' THEN #採購指定最終供應商
     
        IF g_pmdl_d[l_ac].icaa004 = '1' THEN #出貨
           LET g_sql = g_sql , "   AND (c.icab002 = '0' ", #採購正拋，來源站不可存在非作廢的收貨、入庫單  
                               "   AND NOT EXISTS(SELECT * FROM pmds_t,pmdt_t",
                               "                   WHERE pmdsent = pmdtent ",
                               "                     AND pmdsdocno = pmdtdocno",
                               "                     AND pmdsent = a.pmdlent", #170206-00010#1 add
                               "                     AND pmdt001 = '",g_pmdl_d[l_ac].pmdldocno,"'",
                               "                     AND pmdsstus <> 'X')"
        ELSE 
           LET g_sql = g_sql , "   AND (  NOT EXISTS(SELECT * FROM pmdl_t b , icab_t d , pmds_t, pmdt_t", #採購逆拋，最終站不可存在非作廢的採購、收貨、入庫單 
                               "                   WHERE b.pmdl031 = a.pmdl031 AND d.icab001 = c.icab001 ",
                               "                     AND b.pmdlent = d.icabent AND b.pmdl051 = d.icab001 ",
                               "                     AND b.pmdlsite = d.icab003 ",
                               "                     AND pmdsent = a.pmdlent", #170206-00010#1 add
                               "                     AND pmdt001 = b.pmdldocno AND pmdsent = pmdtent ",
                               "                     AND pmdsdocno = pmdtdocno AND pmdsstus <> 'X' ",
                               "                     AND d.icab002 = (SELECT MAX (e.icab002) ",
                               "                                        FROM icab_t e ",
                               "                                       WHERE e.icabent = d.icabent AND e.icab001 = d.icab001)) "
        END IF
        IF g_pmdl_d[l_ac].icaa011 = '2' THEN #出通
           LET g_sql = g_sql , "   AND NOT EXISTS(SELECT 1 FROM xmda_t f, icab_t g, xmdg_t,xmdh_t ", #採購逆拋、最終站不可存在非作廢的出通單
                               "                            WHERE f.xmda031 = a.pmdl031 AND g.icab001 = c.icab001 ",
                               "                              AND f.xmdaent = g.icabent AND f.xmda050 = g.icab001 ",
                               "                              AND f.xmdasite = g.icab003 ",
                               "                              AND xmdgent = a.pmdlent", #170206-00010#1 add
                               "                              AND xmdh001 = f.xmdadocno AND xmdgent = xmdhent ",
                               "                              AND xmdgdocno = xmdhdocno AND xmdgstus <> 'X' ",
                               "                              AND g.icab002 = (SELECT MAX (h.icab002) ",
                               "                                                 FROM icab_t h ",
                               "                                                WHERE h.icabent = g.icabent AND h.icab001 = g.icab001))) "
        END IF
     END IF
  #170106-00005#1 ---add (e)---
  
    
     LET g_sql = "INSERT INTO aicp210_tmp ",
                 "   (sel,pmdl006,pmdl005,pmdldocno,pmdldocdt,pmdl004, ",
                 "    pmdl002,pmdl003,pmdlownid,pmdlcrtid,pmdl051,pmdl052,pmdl031) ",g_sql
     PREPARE tmp_ins_pre FROM g_sql
     EXECUTE tmp_ins_pre
     
     
     LET l_ac = l_ac + 1 #170106-00005#1 add
        
   END FOREACH #170106-00005#1 add
   
   LET g_wc_filter = " 1=1"
   #end add-point
        
   LET g_error_show = 1
   CALL aicp210_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="aicp210.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aicp210_b_fill()
 
   DEFINE ls_wc           STRING
   #add-point:b_fill段define

   #end add-point
 
   #add-point:b_fill段sql_before
   LET g_sql = "SELECT DISTINCT 'N',pmdl006,pmdl005,",
               "                pmdldocno,pmdldocdt,",
               "                pmdl004,'',",
               "                pmdl002,'',",
               "                pmdl003,'',",
               "                pmdlownid,'',",
               "                pmdlcrtid,'', ",
               "                pmdl051,'',",
               "                pmdl052,'',",
               "                pmdl031",
               "  FROM aicp210_tmp ",
               " WHERE ",g_wc_filter,
               " ORDER BY pmdl006,pmdl005,pmdldocno "
   #end add-point
 
   PREPARE aicp210_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aicp210_sel
   
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
   g_detail_d[l_ac].sel,g_detail_d[l_ac].pmdl006,g_detail_d[l_ac].pmdl005,
   g_detail_d[l_ac].pmdldocno,g_detail_d[l_ac].pmdldocdt,
   g_detail_d[l_ac].pmdl004,g_detail_d[l_ac].pmdl004_desc,
   g_detail_d[l_ac].pmdl002,g_detail_d[l_ac].pmdl002_desc,
   g_detail_d[l_ac].pmdl003,g_detail_d[l_ac].pmdl003_desc,
   g_detail_d[l_ac].pmdlownid,g_detail_d[l_ac].pmdlownid_desc,
   g_detail_d[l_ac].pmdlcrtid,g_detail_d[l_ac].pmdlcrtid_desc,
   g_detail_d[l_ac].pmdl051,g_detail_d[l_ac].pmdl051_desc,
   g_detail_d[l_ac].pmdl052,g_detail_d[l_ac].pmdl052_desc,
   g_detail_d[l_ac].pmdl031
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
      
      CALL s_desc_get_person_desc(g_detail_d[l_ac].pmdl002) RETURNING g_detail_d[l_ac].pmdl002_desc
      CALL s_desc_get_person_desc(g_detail_d[l_ac].pmdlownid) RETURNING g_detail_d[l_ac].pmdlownid_desc
      CALL s_desc_get_person_desc(g_detail_d[l_ac].pmdlcrtid) RETURNING g_detail_d[l_ac].pmdlcrtid_desc
      
      CALL s_desc_get_department_desc(g_detail_d[l_ac].pmdl003) RETURNING g_detail_d[l_ac].pmdl003_desc
      
      CALL s_desc_get_trading_partner_abbr_desc(g_detail_d[l_ac].pmdl004) RETURNING g_detail_d[l_ac].pmdl004_desc
      CALL s_desc_get_trading_partner_abbr_desc(g_detail_d[l_ac].pmdl052) RETURNING g_detail_d[l_ac].pmdl052_desc
      
      CALL s_desc_get_icaa001_desc(g_detail_d[l_ac].pmdl051) RETURNING g_detail_d[l_ac].pmdl051_desc
      
      #end add-point
      
      CALL aicp210_detail_show()      
 
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
   FREE aicp210_sel
   
   LET l_ac = 1
   CALL aicp210_fetch()
   #add-point:b_fill段資料填充(其他單身)

   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aicp210.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aicp210_fetch()
 
   DEFINE li_ac           LIKE type_t.num5
   #add-point:fetch段define
   
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後
   IF cl_null(g_master_idx) OR g_master_idx <=0 THEN
      RETURN
   END IF 
   
   IF g_detail_d.getLength() <= 0 THEN 
      RETURN 
   END IF 
   
   LET l_ac = 1
   LET g_sql = "SELECT pmdnseq,pmdn027,pmdn001,imaal003,imaal004,pmdn007,pmdn015, ",
               "       pmdn046,pmdn047,pmdn014 ",
               "  FROM pmdn_t ",
               "       LEFT OUTER JOIN imaal_t ON imaalent = pmdnent AND imaal001 = pmdn001 AND imaal002 = '",g_dlang,"' ",
               " WHERE pmdnent = '",g_enterprise,"'",
               "   AND pmdndocno = '",g_detail_d[g_master_idx].pmdldocno,"' ",
               " ORDER BY pmdnseq "
   PREPARE pmdn_fill_pre FROM g_sql
   DECLARE pmdn_fill_cur CURSOR FOR pmdn_fill_pre
   FOREACH pmdn_fill_cur INTO 
      g_detail2_d[l_ac].pmdnseq,g_detail2_d[l_ac].pmdn027,g_detail2_d[l_ac].pmdn001,
      g_detail2_d[l_ac].pmdn001_desc,g_detail2_d[l_ac].pmdn001_desc_desc,
      g_detail2_d[l_ac].pmdn007,g_detail2_d[l_ac].pmdn015,g_detail2_d[l_ac].pmdn046,
      g_detail2_d[l_ac].pmdn047,g_detail2_d[l_ac].pmdn014
   
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
 
{<section id="aicp210.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aicp210_detail_show()
   #add-point:show段define
   
   #end add-point
 
   #add-point:detail_show段
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aicp210.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aicp210_filter()
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
   
   CONSTRUCT g_wc_filter ON pmdl006,pmdl005,pmdldocno,pmdldocdt,pmdl004,pmdl002,pmdl003,
                            pmdlownid,pmdlcrtid,pmdl051,pmdl052,pmdl031
        FROM s_detail1[1].b_pmdl006,s_detail1[1].b_pmdl005,s_detail1[1].b_pmdldocno,
             s_detail1[1].b_pmdldocdt,s_detail1[1].b_pmdl004,s_detail1[1].b_pmdl002,
             s_detail1[1].b_pmdl003,s_detail1[1].b_pmdlownid,s_detail1[1].b_pmdlcrtid,
             s_detail1[1].b_pmdl051,s_detail1[1].b_pmdl052,s_detail1[1].b_pmdl031
           
      BEFORE CONSTRUCT
      
      ON ACTION controlp INFIELD b_pmdldocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = "     pmdl006 IN ('2','3') ",
                                      " AND pmdl030 = 'Y' ",
                                      " AND pmdl031 IS NOT NULL ",
                                      " AND (SELECT COUNT(*) FROM pmdt_t,pmds_t ",    #不可存在收貨、入庫單  
                                      "       WHERE pmdtent   = pmdsent ",
                                      "         AND pmdtdocno = pmdsdocno ",
                                      "         AND pmdtent = pmdl_t.pmdlent ",   #170105-00013#1-s add
                                      "         AND pmdt001   = pmdl_t.pmdldocno ",
                                      "         AND pmdsstus <> 'X'  ",           #170105-00013#1-s add
                                      "         AND pmds000 IN (1,2,3,4,6,8,9,12,13) ) <= 0 "
               CALL q_pmdldocno()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmdldocno  #顯示到畫面上
               NEXT FIELD b_pmdldocno                   #返回原欄位    
               
            ON ACTION controlp INFIELD b_pmdl004
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_pmaa001_3()                     #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmdl004  #顯示到畫面上
               NEXT FIELD b_pmdl004                   #返回原欄位
   
            ON ACTION controlp INFIELD b_pmdl002
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmdl002  #顯示到畫面上
               NEXT FIELD b_pmdl002                   #返回原欄位
               
            ON ACTION controlp INFIELD b_pmdl003
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooeg001()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmdl003  #顯示到畫面上
               NEXT FIELD b_pmdl003                   #返回原欄位
               
            ON ACTION controlp INFIELD b_pmdlownid
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmdlownid  #顯示到畫面上
               NEXT FIELD b_pmdlownid                   #返回原欄位
   
            ON ACTION controlp INFIELD b_pmdlcrtid
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                          #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmdlcrtid   #顯示到畫面上
               NEXT FIELD b_pmdlcrtid                    #返回原欄位
   
            ON ACTION controlp INFIELD b_pmdl051
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1  = '0' 
               CALL q_icaa001_5()
               DISPLAY g_qryparam.return1 TO pmdl051
               NEXT FIELD b_pmdl051
               
            ON ACTION controlp INFIELD b_pmdl052
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_pmaa001_3()
               DISPLAY g_qryparam.return1 TO pmdl052
               NEXT FIELD b_pmdl052
   END CONSTRUCT
   #end add-point    
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   
   CALL aicp210_b_fill()
   CALL aicp210_fetch()
   
END FUNCTION
 
{</section>}
 
{<section id="aicp210.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aicp210_filter_parser(ps_field)
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
 
{<section id="aicp210.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aicp210_filter_show(ps_field,ps_object)
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
   LET ls_condition = aicp210_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aicp210.other_function" >}
#add-point:自定義元件(Function)

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aicp210_process()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2014/11/17 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp210_process()
   DEFINE l_pmdl006         LIKE pmdl_t.pmdl006
   DEFINE l_pmdl005         LIKE pmdl_t.pmdl005
   DEFINE l_pmdldocno       LIKE pmdl_t.pmdldocno
   DEFINE l_pmdldocdt       LIKE pmdl_t.pmdldocdt
   DEFINE l_pmdl004         LIKE pmdl_t.pmdl004
   DEFINE l_pmdl002         LIKE pmdl_t.pmdl002
   DEFINE l_pmdl003         LIKE pmdl_t.pmdl003
   DEFINE l_pmdl051         LIKE pmdl_t.pmdl051
   DEFINE l_pmdl052         LIKE pmdl_t.pmdl052 
   DEFINE l_pmdl031         LIKE pmdl_t.pmdl031
   DEFINE l_icab002_now     LIKE icab_t.icab002    #當站站別
   DEFINE l_icab003_now     LIKE icab_t.icab003    #當站營運據點
   DEFINE l_icab004_now     LIKE icab_t.icab004    #當站委外工單開立點否
   DEFINE l_success         LIKE type_t.num5       #回傳執行結果

   #有選擇的採購單
   LET g_sql = "SELECT pmdl006,pmdl005,pmdldocno,pmdldocdt,pmdl004,pmdl002,pmdl003,pmdl051,pmdl052,pmdl031 ",
               "  FROM aicp210_tmp ",
               " WHERE sel = 'Y' ",
               " ORDER BY pmdl006,pmdl005,pmdldocno "
   PREPARE aicp210_process_pre FROM g_sql
   DECLARE aicp210_process_cur CURSOR WITH HOLD FOR aicp210_process_pre
   
   #當站多角貿易營運據點
   LET g_sql = "SELECT icab002,icab003,icab004",
               "  FROM icab_t",
               " WHERE icabent = ",g_enterprise,
               "   AND icab001 = ?",
               " ORDER BY icab002 DESC "
   PREPARE aicp210_process_icab_pre FROM g_sql
   DECLARE aicp210_process_icab_cur CURSOR FOR aicp210_process_icab_pre
   
   LET l_success = TRUE
   LET g_success_cnt = 1
   LET g_fail_cnt = 0
   CALL g_detail3_d.clear()
   CALL g_detail4_d.clear()
   
   CALL cl_err_collect_init()        #匯總訊息 初始化 
   
   FOREACH aicp210_process_cur INTO l_pmdl006,l_pmdl005,l_pmdldocno,l_pmdldocdt,l_pmdl004,
                                    l_pmdl002,l_pmdl003,l_pmdl051,l_pmdl052,l_pmdl031
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
      
      #跑站(當站)
      OPEN aicp210_process_icab_cur USING l_pmdl051
      FOREACH aicp210_process_icab_cur INTO l_icab002_now,l_icab003_now,l_icab004_now
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = ''
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            
            LET l_success = FALSE
            EXIT FOREACH
         END IF 

         #如果是第0站的話，清空採購單的多角流程序號、多角貿易已拋轉改為N
         IF l_icab002_now = 0 THEN
            UPDATE pmdl_t SET pmdl030 = 'N',
                              pmdl031 = ''
             WHERE pmdlent = g_enterprise
               AND pmdldocno = l_pmdldocno
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ''
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE
               CALL cl_err()
          
               LET l_success = FALSE
               EXIT FOREACH
            END IF
            
            EXIT FOREACH
         END IF

         #採購單
         CALL aicp210_pmdl(l_icab003_now,l_pmdl031) RETURNING l_success
         IF NOT l_success THEN
            EXIT FOREACH
         END IF
         
         #委外工單開立點 
         IF l_icab004_now = 'Y' THEN
            #如果本站有為委外工單開立點的話 要多處理工單 
            CALL aicp210_sfaa(l_icab003_now,l_pmdl031) RETURNING l_success
            IF NOT l_success THEN
               EXIT FOREACH
            END IF
         END IF

         #訂單處理   
         CALL aicp210_xmda(l_icab003_now,l_pmdl031) RETURNING l_success
         IF NOT l_success THEN
            EXIT FOREACH
         END IF

         IF NOT l_success THEN
            EXIT FOREACH
         END IF
      END FOREACH 
            
      IF l_success THEN
         CALL s_aic_carry_deletetrino(l_pmdl031,'1')
              RETURNING l_success
      END IF
      
      IF g_bgjob = 'N' THEN      
         IF l_success THEN
            CALL s_transaction_end('Y',0)
            #成功記錄
            CALL aicp210_success(l_pmdldocno,l_pmdldocdt,l_pmdl004,l_pmdl002,l_pmdl003,l_pmdl051)
         ELSE
            CALL s_transaction_end('N',0)
            #失敗記錄
            CALL aicp210_fail(l_pmdldocno,l_pmdldocdt,l_pmdl004,l_pmdl002,l_pmdl003,l_pmdl051,l_pmdl052,'')
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
      
   END FOREACH 
   
   #清空錯誤訊息的array，並且之後的錯誤不再以array的方式記錄 
   CALL cl_err_collect_init()
   CALL cl_err_collect_show()
   
   IF g_bgjob = 'N' THEN
      CALL cl_ask_pressanykey("std-00012")
   END IF
END FUNCTION

################################################################################
# Descriptions...: 成功記錄
# Memo...........:
# Usage..........: CALL aicp210_success(p_pmdldocno,p_pmdldocdt,p_pmdl004,p_pmdl002,p_pmdl003,p_pmdl051)
#                  
# Input parameter: p_pmdldocno    採購單號
#                : p_pmdldocdt    採購日期
#                : p_pmdl004      供應商
#                : p_pmdl002      採購人員
#                : p_pmdl003      採購部門
#                : p_pmdl051      多角流程代碼
# Return code....: 
#                : 
# Date & Author..: 2014/11/17 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp210_success(p_pmdldocno,p_pmdldocdt,p_pmdl004,p_pmdl002,p_pmdl003,p_pmdl051)
   DEFINE p_pmdldocno       LIKE pmdl_t.pmdldocno
   DEFINE p_pmdldocdt       LIKE pmdl_t.pmdldocdt
   DEFINE p_pmdl004         LIKE pmdl_t.pmdl004
   DEFINE p_pmdl002         LIKE pmdl_t.pmdl002
   DEFINE p_pmdl003         LIKE pmdl_t.pmdl003
   DEFINE p_pmdl051         LIKE pmdl_t.pmdl051

   IF cl_null(g_success_cnt) THEN
      LET g_success_cnt = 1
   END IF
   
   LET g_detail3_d[g_success_cnt].pmdldocno1 = p_pmdldocno
   LET g_detail3_d[g_success_cnt].pmdldocdt1 = p_pmdldocdt
   LET g_detail3_d[g_success_cnt].pmdl0041 = p_pmdl004
   LET g_detail3_d[g_success_cnt].pmdl0021 = p_pmdl002
   LET g_detail3_d[g_success_cnt].pmdl0031 = p_pmdl003
   LET g_detail3_d[g_success_cnt].pmdl0511 = p_pmdl051
   
   #說明
   CALL s_desc_get_trading_partner_abbr_desc(g_detail3_d[g_success_cnt].pmdl0041)
        RETURNING g_detail3_d[g_success_cnt].pmdl0041_desc
   CALL s_desc_get_person_desc(g_detail3_d[g_success_cnt].pmdl0021)
        RETURNING g_detail3_d[g_success_cnt].pmdl0021_desc
   CALL s_desc_get_department_desc(g_detail3_d[g_success_cnt].pmdl0031)
        RETURNING g_detail3_d[g_success_cnt].pmdl0031_desc
   
   LET g_success_cnt = g_success_cnt +  1
   
END FUNCTION

################################################################################
# Descriptions...: 失敗記錄
# Memo...........:
# Usage..........: CALL aicp210_fail(p_pmdldocno,p_pmdldocdt,p_pmdl004,p_pmdl002,p_pmdl003,p_pmdl031,p_pmdl052,p_pmdlsite)
#                  
# Input parameter: p_pmdldocno    採購單號
#                : p_pmdldocdt    採購日期
#                : p_pmdl004      供應商
#                : p_pmdl002      採購人員
#                : p_pmdl003      採購部門
#                : p_pmdl031      多角流程序號
#                : p_pmdl052      最終供應商
#                : p_pmdlsite     營運據點
# Return code....: 
#                : 
# Date & Author..: 2014/11/17 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp210_fail(p_pmdldocno,p_pmdldocdt,p_pmdl004,p_pmdl002,p_pmdl003,p_pmdl031,p_pmdl052,p_pmdlsite)
   DEFINE p_pmdldocno       LIKE pmdl_t.pmdldocno
   DEFINE p_pmdldocdt       LIKE pmdl_t.pmdldocdt
   DEFINE p_pmdl004         LIKE pmdl_t.pmdl004
   DEFINE p_pmdl002         LIKE pmdl_t.pmdl002
   DEFINE p_pmdl003         LIKE pmdl_t.pmdl003
   DEFINE p_pmdl031         LIKE pmdl_t.pmdl031
   DEFINE p_pmdl052         LIKE pmdl_t.pmdl052
   DEFINE p_pmdlsite        LIKE pmdl_t.pmdlsite
   DEFINE l_i               LIKE type_t.num5

   IF g_bgjob = 'N' THEN
      IF cl_null(g_fail_cnt) THEN
         LET g_fail_cnt = 0
      END IF
      
      FOR l_i = g_fail_cnt+1 TO g_errcollect.getLength()
         LET g_detail4_d[l_i].pmdldocno2 = p_pmdldocno
         LET g_detail4_d[l_i].pmdldocdt2 = p_pmdldocdt
         LET g_detail4_d[l_i].pmdl0042 = p_pmdl004
         LET g_detail4_d[l_i].pmdl0022 = p_pmdl002
         LET g_detail4_d[l_i].pmdl0032 = p_pmdl003
         LET g_detail4_d[l_i].pmdl0312 = p_pmdl031
         LET g_detail4_d[l_i].pmdl0522 = p_pmdl052
         LET g_detail4_d[l_i].b_pmdlsite2 = p_pmdlsite
         
         #錯誤訊息
         LET g_detail4_d[l_i].reason = g_errcollect[l_i].message
         
         #說明
         CALL s_desc_get_trading_partner_abbr_desc(g_detail4_d[l_i].pmdl0042)
              RETURNING g_detail4_d[l_i].pmdl0042_desc
         CALL s_desc_get_person_desc(g_detail4_d[l_i].pmdl0022)
              RETURNING g_detail4_d[l_i].pmdl0022_desc
         CALL s_desc_get_department_desc(g_detail4_d[l_i].pmdl0032)
              RETURNING g_detail4_d[l_i].pmdl0032_desc
         CALL s_desc_get_trading_partner_abbr_desc(g_detail4_d[l_i].pmdl0522)
              RETURNING g_detail4_d[l_i].pmdl0522_desc
         CALL s_desc_get_department_desc(g_detail4_d[l_i].b_pmdlsite2)
              RETURNING g_detail4_d[l_i].b_pmdlsite2_desc
      END FOR
      
      LET g_fail_cnt = g_errcollect.getLength()
   END IF
END FUNCTION

################################################################################
# Descriptions...: Create Temp Table
# Memo...........:
# Usage..........: CALL aicp210_create_temp_table()
#                  
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 2014/06/25 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp210_create_temp_table()
   
   DROP TABLE aicp210_tmp;
   CREATE TEMP TABLE aicp210_tmp( 
       sel            LIKE type_t.chr1,
       pmdl006        LIKE pmdl_t.pmdl006,
       pmdl005        LIKE pmdl_t.pmdl005,
       pmdldocno      LIKE pmdl_t.pmdldocno, 
       pmdldocdt      LIKE pmdl_t.pmdldocdt,
       pmdl004        LIKE pmdl_t.pmdl004,
       pmdl002        LIKE pmdl_t.pmdl002,
       pmdl003        LIKE pmdl_t.pmdl003,
       pmdlownid      LIKE pmdl_t.pmdlownid,
       pmdlcrtid      LIKE pmdl_t.pmdlcrtid,
       pmdl051        LIKE pmdl_t.pmdl051,
       pmdl052        LIKE pmdl_t.pmdl052, 
       pmdl031        LIKE pmdl_t.pmdl031 
       );
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aicp210_pmdl(p_site,p_pmdl031)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2014/11/17 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp210_pmdl(p_site,p_pmdl031)
   DEFINE p_site          LIKE pmdl_t.pmdlsite     #營運據點  
   DEFINE p_pmdl031       LIKE pmdl_t.pmdl031      #多角流程序號  
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_pmdldocno     LIKE pmdl_t.pmdldocno    #採購單號  
   DEFINE l_pmdldocdt     LIKE pmdl_t.pmdldocdt    #採購日期  
   DEFINE l_prog          LIKE gzzz_t.gzzz001
   DEFINE l_pmdl005       LIKE pmdl_t.pmdl005

   LET r_success = TRUE

   #用多角流程序號找出採購單資料 
   LET l_pmdldocno = ''
   LET l_pmdldocdt = ''
   LET l_pmdl005 = ''
   SELECT pmdldocno,pmdldocdt,pmdl005
     INTO l_pmdldocno,l_pmdldocdt,l_pmdl005
     FROM pmdl_t
    WHERE pmdlent  = g_enterprise
      AND pmdlsite = p_site           #營運據點  
      AND pmdl031  = p_pmdl031        #多角流程序號   
      AND pmdlstus <> 'X'             #排除作廢  

   #因為終站非委外，非指定供應商不會產生採購單 所以有可能會有找不到的情況 
   IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ''
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF   
   
   #無採購單 故直接回傳true即可 
   IF cl_null(l_pmdldocno) THEN
      RETURN r_success
   END IF
   
   #先將多角序號刪除 才能取消確認 
   UPDATE pmdl_t
      SET pmdl030 = 'N',
          pmdl031 = ''
    WHERE pmdlent   = g_enterprise
      AND pmdldocno = l_pmdldocno
      
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = l_pmdldocno
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #取消確認  
   CALL s_apmt500_unconf_chk(l_pmdldocno) RETURNING r_success
   IF NOT r_success THEN
      RETURN r_success
   END IF
   CALL s_apmt500_unconf_upd(l_pmdldocno) RETURNING r_success
   IF NOT r_success THEN
      RETURN r_success
   END IF

   IF cl_get_para(g_enterprise,g_site,'E-BAS-0018') = 'N' THEN
      #多角單據流水號保持一致='N'時，做作廢處理 
      CALL s_apmt500_invalid_chk(l_pmdldocno) RETURNING r_success
      IF NOT r_success THEN
         RETURN r_success
      END IF

      CALL s_apmt500_invalid_upd(l_pmdldocno) RETURNING r_success
      IF NOT r_success THEN
         RETURN r_success
      END IF
      
   ELSE
      #準備刪除採購單資料 
      #採購單頭 
      DELETE FROM pmdl_t WHERE pmdlent   = g_enterprise
                           AND pmdldocno = l_pmdldocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = l_pmdldocno
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF

      #採購多帳期預付款檔
      DELETE FROM pmdm_t WHERE pmdment   = g_enterprise
                           AND pmdmdocno = l_pmdldocno
      IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = l_pmdldocno
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF

      #採購單身明細   
      DELETE FROM pmdn_t WHERE pmdnent   = g_enterprise
                           AND pmdndocno = l_pmdldocno
      IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = l_pmdldocno
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF

      #採購交期明細檔 
      DELETE FROM pmdo_t WHERE pmdoent   = g_enterprise
                           AND pmdodocno = l_pmdldocno
      IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = l_pmdldocno
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF

      #關聯單據明細檔  
      DELETE FROM pmdp_t WHERE pmdpent   = g_enterprise
                           AND pmdpdocno = l_pmdldocno
      IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = l_pmdldocno
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF

      #採購多交期匯總檔
      DELETE FROM pmdq_t WHERE pmdqent   = g_enterprise
                           AND pmdqdocno = l_pmdldocno
      IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = l_pmdldocno
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF

      #刪除交易稅明細檔
      DELETE FROM xrcd_t
       WHERE xrcdent = g_enterprise
         AND xrcddocno = l_pmdldocno
      IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = l_pmdldocno
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF

      #單號處理 
      LET l_prog = g_prog
      
      IF l_pmdl005 = '2' THEN  #委外採購
         LET g_prog = "apmt501"
      ELSE
         LET g_prog = "apmt500"
      END IF
      
      IF NOT s_aooi200_del_docno(l_pmdldocno,l_pmdldocdt) THEN
         LET g_prog = l_prog
         LET r_success = FALSE
         RETURN r_success
      END IF

      #刪除備註 
      CALL s_aooi360_del('6',g_prog,l_pmdldocno,'','','','','','','','','4') RETURNING r_success
      IF NOT r_success THEN
         LET g_prog = l_prog
         RETURN r_success
      END IF

      #相關文件  
      CALL g_pk_array.clear()
      LET g_pk_array[1].values = l_pmdldocno
      LET g_pk_ARRAY[1].column = 'pmdldocno' 
      CALL cl_doc_remove()

      LET g_prog = l_prog
   END IF

   RETURN r_success
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aicp210_xmda(p_site,p_xmda031)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2014/11/17 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp210_xmda(p_site,p_xmda031)
   #刪除訂單資料 
   DEFINE p_site        LIKE xmda_t.xmdasite
   DEFINE p_xmda031     LIKE xmda_t.xmda031
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_xmdadocno   LIKE xmda_t.xmdadocno
   DEFINE l_xmdadocdt   LIKE xmda_t.xmdadocdt
   DEFINE l_site        LIKE xmda_t.xmdasite
   DEFINE l_prog        LIKE gzzz_t.gzzz001

   LET r_success = TRUE

   #利用多角流程序號找出訂單資料 
   LET l_xmdadocno = ''
   LET l_xmdadocdt = ''
   SELECT xmdadocno,xmdadocdt INTO l_xmdadocno,l_xmdadocdt
     FROM xmda_t
    WHERE xmdaent  = g_enterprise
      AND xmdasite = p_site
      AND xmda031  = p_xmda031 
      AND xmdastus <> 'X'          #排除作廢 

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ''
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF 
   
   LET l_site = g_site      #備份g_site 
   LET g_site = p_site      #更換site  
   
   #清空多角序號 
   UPDATE xmda_t SET xmda030 = 'N',
                     xmda031 = ''
    WHERE xmdaent   = g_enterprise
      AND xmdadocno = l_xmdadocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = l_xmdadocno
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()

      LET g_site = l_site
      LET r_success = FALSE
      RETURN r_success
   END IF

   #取消確認  
   CALL s_axmt500_unconf_chk(l_xmdadocno) RETURNING r_success
   IF NOT r_success THEN
      LET g_site = l_site
      RETURN r_success
   END IF
   CALL s_axmt500_unconf_upd(l_xmdadocno) RETURNING r_success
   IF NOT r_success THEN
      LET g_site = l_site
      RETURN r_success
   END IF

   IF cl_get_para(g_enterprise,g_site,'E-BAS-0018') = 'N' THEN
      #多角單據流水號保持一致='N'時，做作廢處理  
      CALL s_axmt500_invalid_chk(l_xmdadocno) RETURNING r_success
      IF NOT r_success THEN
         LET g_site = l_site
         RETURN r_success
      END IF

      CALL s_axmt500_invalid_upd(l_xmdadocno) RETURNING r_success
      IF NOT r_success THEN
         LET g_site = l_site
         RETURN r_success
      END IF
   ELSE
      #刪除訂單單頭
      DELETE FROM xmda_t WHERE xmdaent   = g_enterprise
                           AND xmdadocno = l_xmdadocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = l_xmdadocno
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err() 
         
         LET g_site = l_site
         LET r_success = FALSE
         RETURN r_success
      END IF

      #訂單多帳期預收款檔
      DELETE FROM xmdb_t WHERE xmdbent = g_enterprise
                           AND xmdbdocno = l_xmdadocno
      IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ''
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         LET g_site = l_site
         LET r_success = FALSE
         RETURN r_success
      END IF

      #刪除訂單單身   
      DELETE FROM xmdc_t WHERE xmdcent   = g_enterprise
                           AND xmdcdocno = l_xmdadocno
      IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = l_xmdadocno
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         LET g_site = l_site
         LET r_success = FALSE
         RETURN r_success
      END IF

      #訂單交期明細檔 
      DELETE FROM xmdd_t WHERE xmddent   = g_enterprise
                           AND xmdddocno = l_xmdadocno
      IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = l_xmdadocno
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE 
         CALL cl_err()

         LET g_site = l_site
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      #訂單多交期匯總檔
      DELETE FROM xmdf_t WHERE xmdfent = g_enterprise
                           AND xmdfdocno = l_xmdadocno
      IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ''
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         LET g_site = l_site
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      #訂單附屬零件明細檔
      DELETE FROM xmdq_t WHERE xmdqent = g_enterprise
                           AND xmdqdocno = l_xmdadocno
      IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ''
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         LET g_site = l_site
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      #訂單備置明細檔
      DELETE FROM xmdr_t WHERE xmdrent = g_enterprise
                           AND xmdrdocno = l_xmdadocno
      IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ''
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         
         LET g_site = l_site
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      #訂單費用資料檔
      DELETE FROM xmds_t WHERE xmdsent = g_enterprise
                           AND xmdsdocno = l_xmdadocno
      IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ''
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         LET g_site = l_site
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      #刪除交易稅明細檔
      DELETE FROM xrcd_t
       WHERE xrcdent = g_enterprise
         AND xrcddocno = l_xmdadocno
      IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = l_xmdadocno
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         LET g_site = l_site
         LET r_success = FALSE
         RETURN r_success
      END IF

      #單號處理 
      LET l_prog = g_prog
      LET g_prog = 'axmt500'
      IF NOT s_aooi200_del_docno(l_xmdadocno,l_xmdadocdt) THEN
         LET g_prog = l_prog
         LET g_site = l_site
         LET r_success = FALSE
         RETURN r_success
      END IF

      #刪除備註 
      CALL s_aooi360_del('6',g_prog,l_xmdadocno,'','','','','','','','','4') RETURNING r_success
      IF NOT r_success THEN
         LET g_prog = l_prog
         LET g_site = l_site
         RETURN r_success
      END IF

      #相關文件 
      CALL g_pk_array.clear()
      LET g_pk_array[1].values = l_xmdadocno
      LET g_pk_array[1].column = 'xmdadocno' 
      CALL cl_doc_remove()

      LET g_prog = l_prog
      LET g_site = l_site
   END IF

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aicp210_sfaa(p_site,p_sfaa067)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2014/11/26 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION aicp210_sfaa(p_site,p_sfaa067)
   DEFINE p_site      LIKE sfaa_t.sfaasite
   DEFINE p_sfaa067   LIKE sfaa_t.sfaa067      #多角流程序號 
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_sfaadocno LIKE sfaa_t.sfaadocno    #工單單號  
   DEFINE l_sfaadocdt LIKE sfaa_t.sfaadocdt
   DEFINE l_sfaastus  LIKE sfaa_t.sfaastus
   
   DEFINE l_cnt       LIKE type_t.num5
   DEFINE l_prog      LIKE gzzz_t.gzzz001
   DEFINE l_sql       STRING

   LET r_success = TRUE

   #利用多角流程序號找出工單資料(可能有多筆)
   LET l_sql = "SELECT sfaadocno,sfaadocdt,sfaastus ",
               "  FROM sfaa_t",
               " WHERE sfaaent  = ",g_enterprise,
               "   AND sfaasite = '",p_site,"'",
               "   AND sfaa067  = '",p_sfaa067,"'",
               "   AND sfaastus <> 'X'"          #排除作廢  
   PREPARE aicp210_sfaa_pre FROM l_sql
   DECLARE aicp210_sfaa_cs CURSOR FOR aicp210_sfaa_pre
   
   FOREACH aicp210_sfaa_cs INTO l_sfaadocno,l_sfaadocdt,l_sfaastus
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'aicp210_sfaa_cs'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
      
         LET r_success = FALSE 
         EXIT FOREACH
      END IF
      
      IF l_sfaastus = 'F' THEN
         #檢查是否有 報工、發料、入庫 的資料 如果有的話就不能取消發放 
         #發料單 
         LET l_cnt = 0
         SELECT COUNT(*) INTO l_cnt
           FROM sfda_t,sfdc_t
          WHERE sfdaent   = sfdcent
            AND sfdadocno = sfdcdocno
            AND sfdc001   = l_sfaadocno
            AND sfdastus != 'X'
         IF cl_null(l_cnt) THEN
           LET l_cnt = 0
         END IF 
         IF l_cnt = 0 THEN
            SELECT COUNT(*) INTO l_cnt
              FROM sfda_t,sfdb_t
             WHERE sfdaent   = sfdbent
              AND sfdadocno = sfdbdocno
               AND sfdb001   = l_sfaadocno
               AND sfdastus != 'X'
            IF cl_null(l_cnt) THEN
               LET l_cnt = 0
            END IF
        END IF
         IF l_cnt > 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_sfaadocno
            LET g_errparam.code   = 'asf-00318'
            LET g_errparam.popup  = TRUE
            CALL cl_err()
      
           LET r_success = FALSE
            EXIT FOREACH
         END IF
      
         #入庫單 
         LET l_cnt = 0
         SELECT COUNT(*) INTO l_cnt
           FROM sfea_t,sfec_t
          WHERE sfeaent   = sfecent
            AND sfeadocno = sfecdocno
            AND sfec001   = l_sfaadocno 
            AND sfeastus != 'X'
         IF cl_null(l_cnt) THEN
            LET l_cnt = 0
         END IF
         IF l_cnt = 0 THEN
            SELECT COUNT(*) INTO l_cnt
              FROM sfea_t,sfeb_t
             WHERE sfeaent   = sfebent
               AND sfeadocno = sfebdocno
               AND sfeb001   = l_sfaadocno
               AND sfeastus != 'X'
            IF cl_null(l_cnt) THEN
               LET l_cnt = 0
            END IF
         END IF
         IF l_cnt > 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_sfaadocno
            LET g_errparam.code   = 'asf-00319'
            LET g_errparam.popup  = TRUE
            CALL cl_err()
      
            LET r_success = FALSE
            EXIT FOREACH
         END IF
       
         #報工單 
         LET l_cnt = 0 
         SELECT COUNT(*) INTO l_cnt
           FROM sffb_t
          WHERE sffbent   = g_enterprise
            AND sffb005   = l_sfaadocno
            AND sffbstus != 'X'
         IF cl_null(l_cnt) THEN
            LET l_cnt = 0
         END IF
         IF l_cnt > 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_sfaadocno
            LET g_errparam.code   = 'asf-00320'
            LET g_errparam.popup  = TRUE
            CALL cl_err()
       
            LET r_success = FALSE
            EXIT FOREACH
         END IF
       
         #委外採購單 
         LET l_cnt = 0
         SELECT COUNT(*) INTO l_cnt
           FROM pmdl_t
          WHERE pmdlent = g_enterprise
            AND pmdl008 = l_sfaadocno
            AND pmdlstus != 'X'
         IF cl_null(l_cnt) THEN
            LET l_cnt = 0
         END IF 
         IF l_cnt > 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_sfaadocno
            LET g_errparam.code   = 'asf-00454'
            LET g_errparam.popup  = TRUE
            CALL cl_err()
      
            LET r_success = FALSE
            EXIT FOREACH
         END IF

         #清除備置資料
         DELETE FROM sfbb_t
          WHERE sfbbent = g_enterprise
            AND sfbbdocno =  l_sfaadocno
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = ""
            LET g_errparam.popup = FALSE
            CALL cl_err()

            LET r_success = FALSE
            EXIT FOREACH
         END IF

         UPDATE sfba_t SET sfba031 = 0,sfba032 = ''
          WHERE sfbaent = g_enterprise
            AND sfbadocno = l_sfaadocno
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = ""
            LET g_errparam.popup = FALSE
            CALL cl_err()

            LET r_success = FALSE
            EXIT FOREACH
         END IF

         #更新狀態為Y 
         UPDATE sfaa_t SET sfaastus = 'Y'
          WHERE sfaaent   = g_enterprise
            AND sfaadocno = l_sfaadocno
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_sfaadocno
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
       
            LET r_success = FALSE
            EXIT FOREACH
         END IF
      END IF
       
      #看asft300的取消確認，似乎不用做任何的檢查  
      UPDATE sfaa_t SET sfaastus = 'N',
                        sfaacnfid = '',
                        sfaacnfdt = '',
                        sfaa067  = ''     
       WHERE sfaaent   = g_enterprise
         AND sfaadocno = l_sfaadocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = l_sfaadocno
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
       
         LET r_success = FALSE
         EXIT FOREACH
      END IF
       
      IF cl_get_para(g_enterprise,g_site,'E-BAS-0018') = 'N' THEN
         #多角單據流水號保持一致='N'時，做作廢處理 
         UPDATE sfaa_t SET sfaastus = 'X'
          WHERE sfaaent   = g_enterprise
            AND sfaadocno = l_sfaadocno
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.EXTEND = l_sfaadocno
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
      
            LET r_success = FALSE
            EXIT FOREACH
         END IF
      ELSE
         #刪除工單前檢查 
         #已存在子工單資料不可刪除 
         LET l_cnt = 0
         SELECT COUNT(*) INTO l_cnt
           FROM sfaa_t
          WHERE sfaaent  = g_enterprise
            AND sfaasits = p_site
            AND sfaa021  = l_sfaadocno
         IF cl_null(l_cnt) THEN
            LET l_cnt = 0
         END IF 
         IF l_cnt > 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_sfaadocno
            LET g_errparam.code   = 'asf-00439'
            LET g_errparam.popup  = TRUE
            CALL cl_err()
      
            LET r_success = FALSE
            EXIT FOREACH
         END IF
      
         CALL g_pk_array.clear()
         LET g_pk_array[1].values = l_sfaadocno
         LET g_pk_array[1].column = 'sfaadocno'
         INITIALIZE g_doc.* TO NULL
         LET g_doc.column1 = "sfaadocno"
         LET g_doc.value1  = l_sfaadocno
         CALL cl_doc_remove()
       
         #刪除工單單頭 
         DELETE FROM sfaa_t WHERE sfaaent   = g_enterprise
                              AND sfaasite  = p_site
                              AND sfaadocno = l_sfaadocno
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_sfaadocno
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
       
            LET r_success = FALSE
            EXIT FOREACH
         END IF
       
         #單號處理 
         LET l_prog = g_prog
         LET g_prog = 'asft300'
         IF NOT s_aooi200_del_docno(l_sfaadocno,l_sfaadocdt) THEN
            LET g_prog = l_prog
            LET r_success = FALSE
            EXIT FOREACH
         END IF
         LET g_prog = l_prog
      
         #刪除工單單身 
         DELETE FROM sfab_t WHERE sfabent   = g_enterprise
                              AND sfabsite  = p_site
                              AND sfabdocno = l_sfaadocno
         IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_sfaadocno
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
       
            LET r_success = FALSE
            EXIT FOREACH
         END IF 
          
         #刪除工單聯產品檔 
         DELETE FROM sfac_t WHERE sfacent   = g_enterprise
                              AND sfacsite  = p_site
                              AND sfacdocno = l_sfaadocno
         IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_sfaadocno
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
      
            LET r_success = FALSE
            EXIT FOREACH
         END IF
       
         #刪除工單產品序號檔 
         DELETE FROM sfaf_t WHERE sfafent   = g_enterprise
                              AND sfafsite  = p_site
                              AND sfafdocno = l_sfaadocno
         IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_sfaadocno
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
       
            LET r_success = FALSE
            EXIT FOREACH
         END IF 
          
         #刪除工單製程單頭檔 
         DELETE FROM sfca_t WHERE sfcaent   = g_enterprise
                              AND sfcasite  = p_site
                              AND sfcadocno = l_sfaadocno
         IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_sfaadocno
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
      
            LET r_success = FALSE
            EXIT FOREACH
         END IF
       
         #刪除工單製程單身檔 
         DELETE FROM sfcb_t WHERE sfcbent   = g_enterprise
                              AND sfcbsite  = p_site
                              AND sfcbdocno = l_sfaadocno
         IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_sfaadocno
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
      
            LET r_success = FALSE
            EXIT FOREACH
         END IF 
         
         #刪除工單製程上站作業資料 
         DELETE FROM sfcc_t WHERE sfccent   = g_enterprise
                              AND sfccsite  = p_site
                              AND sfccdocno = l_sfaadocno
         IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_sfaadocno
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
      
            LET r_success = FALSE
            EXIT FOREACH
         END IF
      
         #刪除工單製程check in/out項目資料 
         DELETE FROM sfcd_t WHERE sfcdent   = g_enterprise
                              AND sfcdsite  = p_site
                              AND sfcddocno = l_sfaadocno
         IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_sfaadocno
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
      
            LET r_success = FALSE
            EXIT FOREACH
         END IF 
         
         #刪除工單備料單身檔 
         DELETE FROM sfba_t WHERE sfbaent   = g_enterprise
                              AND sfbasite  = p_site
                              AND sfbadocno = l_sfaadocno
         IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_sfaadocno
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
      
            LET r_success = FALSE
            EXIT FOREACH
         END IF
      END IF
      
   END FOREACH

   RETURN r_success
END FUNCTION

#單號過濾條件
PRIVATE FUNCTION aicp210_sel()
   #LET g_aicp210_sel = " pmdlent = '",g_enterprise,"' ",                                #161231-00013#1 mark
   LET g_aicp210_sel = " pmdlent = '",g_enterprise,"' ",cl_sql_add_filter("pmdl_t"),     #161231-00013#1 add
                       " AND pmdlsite = '",g_site,"' ", 
                       " AND pmdlstus = 'Y'",
                       " AND pmdl006 IN ('2','3') ",
                       " AND pmdl030 = 'Y' ",
                       " AND pmdl031 IS NOT NULL " #170106-00005#1 reduce ,
                      #170106-00005#1 ---mark (s)--- 
                      #" AND (SELECT COUNT(*) FROM pmdt_t,pmds_t ",     #不可存在收貨、入庫單  
                      #"       WHERE pmdtent   = pmdsent ",
                      #"         AND pmdtdocno = pmdsdocno ",
                      #"         AND pmdtent = pmdl_t.pmdlent ",   #170105-00013#1-s add
                      #"         AND pmdt001   = pmdl_t.pmdldocno ",
#                     #"         AND pmdlstus <> 'X'  ",               #161229-00033#1 add   #170105-00013#1-s mark 
                      #"         AND pmdsstus <> 'X'  ",           #170105-00013#1-s add
                      #"         AND pmds000 IN (1,2,3,4,6,8,9,12,13) ) <= 0 "
                      #170106-00005#1 ---mark (e)--- 
END FUNCTION

#end add-point
 
{</section>}
 
