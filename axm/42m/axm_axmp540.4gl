#該程式已解開Section, 不再透過樣板產出!
{<section id="axmp540.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0013(2016-10-26 10:31:03), PR版次:0013(2017-01-05 14:43:51)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000222
#+ Filename...: axmp540
#+ Description: 引導式出貨處理作業
#+ Creator....: 02040(2014-06-09 11:15:19)
#+ Modifier...: 05384 -SD/PR- 06021
 
{</section>}
 
{<section id="axmp540.global" >}
#+ Modifier...: No.160318-00005#48  2016/3/31   pengxin  修正azzi902重复定义之错误讯息
#160727-00019#23   2016/08/11 By 08742     系统中定义的临时表名称超过15码在执行时会出错,所以需要将系统中定义的临时表长度超过15码的全部改掉	
#                                          Mod   p540_01_lock_b_t --> p540_tmp01
#                                          Mod   p540_02_xmdk_temp --> p540_tmp02
#                                          Mod   p540_02_xmdl_temp --> p540_tmp03
#160706-00037#5    2016/10/21 By shiun     引導式作業調整的作法:進行到第二步時，針對勾選的資料中若有被別人處理中的單據提示"單據編號OOO+項次XX被其他使用者處理中"
#160706-00037#13   2016/11/14 By shiun     整批加上
#                                          1.檢查第一步勾選的資料有沒有被別人處理中，測試資料有沒有被別人LOCK的EXECUTE前要先把變數清空
#                                          2.若排除掉被別人處理中的資料後，本次沒有需要處理的資料，l_where應補上1=2條件而非1=1
#161227-00068#1    2016/12/30 By ouhz      单击出货单维护按钮后再点回到待出货数据后再去审核过账出货单卡住问题，调整g_action_choice="back_first"时drop p540_01_xmdh/p540_01_xmdh2/p540_01_tmp数据
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目
#嵌入作業需把其他程式的程式碼import進來 
IMPORT FGL axm_axmp540_01
IMPORT FGL axm_axmp540_02
#IMPORT FGL apm_apmp490_02
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
#add-point:增加匯入變數檔
GLOBALS "../../axm/4gl/axmp540_01.inc"
GLOBALS "../../axm/4gl/axmp540_02.inc"
#end add-point
 
#add-point:free_style模組變數(Module Variable)
  
DEFINE li_step              LIKE type_t.num5              #步驟
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
#end add-point
 
#add-point:自定義模組變數(Module Variable)

#end add-point
 
{</section>}
 
{<section id="axmp540.main" >}
#+ 作業開始
MAIN
   #add-point:main段define
   DEFINE l_success     LIKE type_t.num5
   #end add-point    
 
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log
 
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("axm","")
 
   #add-point:作業初始化

   #end add-point
 
   #add-point:SQL_define

   #end add-point
 
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call

      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axmp540 WITH FORM cl_ap_formpath("axm",g_code)
   
      #程式初始化
      CALL axmp540_init()
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      LET li_step = 1
      #使用while讓程式不斷的在步驟內運作  
      #每一次執行完都會回傳之後要做哪個動作   
      WHILE TRUE
         CASE li_step
            WHEN 1
               CALL axmp540_ui_dialog_step1()  RETURNING li_step
              
            WHEN 2
               CALL axmp540_ui_dialog_step2() RETURNING li_step
              
            WHEN 3
              CALL axmp540_ui_dialog_step3() RETURNING li_step
             
            WHEN 0
              EXIT WHILE 
          
            OTHERWISE
               EXIT WHILE
         END CASE
      END WHILE      
   
      #畫面關閉
      CLOSE WINDOW w_axmp540
   END IF
 
   #add-point:作業離開前
   #程式運作完了要記得把temp table刪掉
   CALL axmp540_01_drop_temp_table()  RETURNING l_success
   CALL axmp540_02_drop_temp_table()  RETURNING l_success
   CALL axmp540_03_drop_temp_table()  RETURNING l_success
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
 
END MAIN
 
{</section>}
 
{<section id="axmp540.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION axmp540_init()
  
  DEFINE l_success     LIKE type_t.num5

  LET gwin_curr = ui.Window.getCurrent()
  LET gfrm_curr = gwin_curr.getForm()
  #畫面嵌入
  CALL cl_ui_replace_sub_window(cl_ap_formpath("axm", "axmp540_01"), "main_grid01", "Group", "master")
  CALL axmp540_01_init()    #axmp540_01的畫面預設 
  CALL cl_ui_replace_sub_window(cl_ap_formpath("axm", "axmp540_02"), "main_grid02", "Group", "master")
  CALL axmp540_02_init()    #axmp540_02的畫面預設    

  #先將嵌入的畫面都隱藏  
   CALL cl_set_comp_visible("main_vbox01",FALSE)
   CALL cl_set_comp_visible("main_vbox02",FALSE)    
   
   #建立各程式的temp table
   CALL axmp540_01_create_temp_table() RETURNING l_success
   CALL axmp540_02_create_temp_table() RETURNING l_success
   CALL axmp540_03_create_temp_table() RETURNING l_success

END FUNCTION

PRIVATE FUNCTION axmp540_process(ls_js)
    DEFINE ls_js       STRING
#   DEFINE lc_param    type_parameter
#   DEFINE li_stus     LIKE type_t.num5
#   DEFINE li_count    LIKE type_t.num10  #progressbar計量
#   DEFINE ls_sql      STRING             #主SQL
#   #add-point:process段define
#
#   #end add-point
#
#   CALL util.JSON.parse(ls_js,lc_param)
#
#   #add-point:process段前處理
#
#   #end add-point
#
#   #預先計算progressbar迴圈次數
#   IF g_bgjob <> "Y" THEN
#      #add-point:process段count_progress
#
#      #end add-point
#   END IF
#
#   #主SQL及相關FOREACH前置處理
##  DECLARE axmp540_process_cs CURSOR FROM ls_sql
##  FOREACH axmp540_process_cs INTO
#   #add-point:process段process
#
#   #end add-point
##  END FOREACH
#
#   IF g_bgjob = "N" THEN
#      #前景作業完成處理
#      #add-point:process段foreground完成處理
#
#      #end add-point
#      CALL cl_ask_confirm("std-00012") RETURNING li_stus
#   ELSE
#      #背景作業完成處理
#      #add-point:process段background完成處理
#
#      #end add-point
#   END IF
END FUNCTION

PRIVATE FUNCTION axmp540_transfer_argv(ls_js)
    DEFINE ls_js       STRING
#   DEFINE la_cmdrun   RECORD
#             prog     STRING,
#             param    DYNAMIC ARRAY OF STRING
#                  END RECORD
#   DEFINE la_param    type_parameter
#
#   CALL util.JSON.parse(ls_js,la_param)
#
#   LET la_cmdrun.prog = g_prog
#   #add-point:transfer.argv段define
#
#   #end add-point
#
#   RETURN util.JSON.stringify( la_cmdrun )
END FUNCTION

PRIVATE FUNCTION axmp540_ui_dialog_step1()

   #設定左方的流程圖  
   CALL axmp540_set_step_img('1')

   #設定嵌入畫面的 顯示 與 隱藏 
   CALL axmp540_set_vbox_visible('1')
   
   #設定button隱藏
   CALL axmp540_set_act_visible('1')
   
   #mark--160706-00037#5 By shiun--(S)
#   #160120-00002#4 20160216 by s983961--add(s)   
#   #開啟transaction 
#   CALL s_transaction_begin()
#   #160120-00002#4 20160216 by s983961--add(e) 
   #mark--160706-00037#5 By shiun--(E)
   
   #每次進入第一頁時 就是資料輸入模式 
   LET g_mode = "i"
   
   #設定右方的button開關 
   CALL axmp540_01_set_act_visible()   
   CALL axmp540_01_b_fill()
   
   WHILE TRUE
     DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
        SUBDIALOG axm_axmp540_01.axmp540_01_input
        SUBDIALOG axm_axmp540_01.axmp540_01_construct
        SUBDIALOG axm_axmp540_01.axmp540_01_input01
        SUBDIALOG axm_axmp540_01.axmp540_01_input02

        BEFORE DIALOG
           IF g_action_choice = "back_step" THEN
              LET g_detail_idx = 1
              LET g_current_page = 1
              NEXT FIELD sel_01
           ELSE 
           #161227-00068#1--add---begin----
             IF g_action_choice = "back_first" THEN            
               DELETE FROM p540_01_xmdh
               DELETE FROM p540_01_xmdh2
               DELETE FROM p540_01_tmp
             END IF
          #161227-00068#1--add---end----
              NEXT FIELD xmdkdocno           
           END IF              

       
        ON ACTION Search                                  #搜尋  
           IF cl_null(g_xmdk_m.xmdkdocno) THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'apm-00603'
              LET g_errparam.extend = ""
              LET g_errparam.popup = TRUE
              CALL cl_err()
              NEXT FIELD xmdkdocno
           END IF        
           LET g_action_choice = "Search"
           IF cl_null(g_wc) THEN
              LET g_wc = ' 1=1'
           END IF
           CALL axmp540_01(g_wc)
           CALL s_transaction_begin()        #add--160706-00037#5 By shiun            
           CALL axmp540_01_b_fill()
           CALL s_transaction_end('Y','0')   #add--160706-00037#5 By shiun
           
           IF g_detail_cnt=0 AND g_detail2_cnt = 0 THEN              
              INITIALIZE g_errparam TO NULL
#              LET g_errparam.code = 'axm-00276'      #160318-00005#48  mark
              LET g_errparam.code = 'sub-01321'       #160318-00005#48  add
              LET g_errparam.extend = ""
              LET g_errparam.popup = TRUE
              CALL cl_err()
              NEXT FIELD xmdkdocno
           ELSE
              LET g_detail_idx = 1
              LET g_current_page = 1
              NEXT FIELD sel_01           
           END IF

         ON ACTION close
            LET INT_FLAG = TRUE
            LET g_action_choice = "close"
            EXIT DIALOG

         ON ACTION exit
            LET INT_FLAG = TRUE
            LET g_action_choice = "exit"
            EXIT DIALOG

         ON ACTION save                             #出貨資料寫入(寫入底稿)
            IF g_mode = 'i' THEN                    #需要是出貨資料模式才可使用此功能
               LET g_action_choice = "save"
               CALL axmp540_01_save()
               CALL s_transaction_begin()        #add--160706-00037#5 By shiun            
               CALL axmp540_01_b_fill()
               CALL s_transaction_end('Y','0')   #add--160706-00037#5 By shiun
            END IF
            
         ON ACTION next_step                          #下一步，出貨資料調整
            IF axmp540_01_tmp_chk() THEN              #檢查底稿資料正確性       
               LET g_action_choice = "next_step"
               LET INT_FLAG = TRUE
               EXIT DIALOG
            END IF
         #CS：客戶全選 OS：訂單全選 AS：全選 S：單選 US：取消單選 UA：取消全選 
         
         #選擇全部
         ON ACTION selall                       
            LET g_action_choice = "selall"
            CALL axmp540_01_sel('AS')         
         
         #取消全部
         ON ACTION selnone                           
            LET g_action_choice = "selnone"
            CALL axmp540_01_sel('UA')         

         #勾選所選資料
         ON ACTION sel
            LET g_action_choice = "sel"
            CALL axmp540_01_sel('S')

         #取消所選資料
         ON ACTION unsel
            LET g_action_choice = "unsel"
            CALL axmp540_01_sel('US')
         #客戶全選 
         ON ACTION all_c_sel                    
            LET g_action_choice = "all_c_sel"
            CALL axmp540_01_sel('CS')
            
         #訂單全選
         ON ACTION all_o_sel                   
            LET g_action_choice = "all_o_sel"
            CALL axmp540_01_sel('OS')
         
         #取消全選
         ON ACTION all_un_sel                       
            LET g_action_choice = "all_un_sel"
            CALL axmp540_01_sel('UA')
            
         #檢示底稿
         ON ACTION see_tmp                         
            LET g_mode = 'd'
            CALL axmp540_01_set_act_visible()             
            CALL axmp540_01_b_fill_tmp()
        
        #刪資底稿 
        ON ACTION del_tmp                          
           CALL axmp540_01_del_tmp()
           CALL axmp540_01_b_fill_tmp()
        
        #出貨資料
        ON ACTION sel_mode                                   
           LET g_mode = 'i'
           CALL axmp540_01_set_act_visible() 
           CALL s_transaction_begin()        #add--160706-00037#5 By shiun            
           CALL axmp540_01_b_fill()
           CALL s_transaction_end('Y','0')   #add--160706-00037#5 By shiun          

        ON ACTION main_img_step01
           #此action是為了讓button的圖片有顏色 
           LET g_action_choice = "img_step01"
           EXIT DIALOG
           
        #主選單用ACTION
        &include "main_menu.4gl"
        &include "relating_action.4gl"
        #交談指令共用ACTION
        &include "common_action.4gl"
            CONTINUE DIALOG

       END DIALOG

       IF INT_FLAG THEN
          LET INT_FLAG = FALSE
          EXIT WHILE
      END IF
    END WHILE

   #mark--160706-00037#3 By shiun--(S)
#   #160120-00002#4 s983961--add(s)   
#   CALL s_transaction_end('Y','0')
#   #160120-00002#4 s983961--add(e) 
   #mark--160706-00037#3 By shiun--(E)
   
   CASE g_action_choice
      WHEN "next_step"
         RETURN 2
      WHEN "Search"
         RETURN 1         
      WHEN "menu"
         RETURN 0
      OTHERWISE
         RETURN 0
   END CASE
   
END FUNCTION

PRIVATE FUNCTION axmp540_ui_dialog_step2()
DEFINE l_success         LIKE type_t.num5
#160120-00002#4 s983961--add(s)
DEFINE l_sql       STRING
DEFINE l_where     STRING
DEFINE l_sql_cho   LIKE type_t.num5
DEFINE l_xmdhdocno LIKE xmdh_t.xmdhdocno #出通單號
DEFINE l_xmdhseq   LIKE xmdh_t.xmdhseq
DEFINE l_xmdh001   LIKE xmdh_t.xmdh001   #訂單單號
DEFINE l_xmdhseq1  LIKE xmdh_t.xmdh002
DEFINE l_xmdhseq2  LIKE xmdh_t.xmdh003
DEFINE l_xmdhseq3  LIKE xmdh_t.xmdh004
#160120-00002#4 s983961--add(e)
#add--160706-00037#5 By shiun--(S) 
DEFINE l_docno     LIKE xmdd_t.xmdddocno
DEFINE l_seq       LIKE xmdd_t.xmddseq
DEFINE l_seq1      LIKE xmdd_t.xmddseq1
DEFINE l_seq2      LIKE xmdd_t.xmddseq2
DEFINE l_xmdh001_2 LIKE xmdh_t.xmdh001
DEFINE l_xmdh002_2 LIKE xmdh_t.xmdh002
DEFINE l_xmdh003_2 LIKE xmdh_t.xmdh003
DEFINE l_xmdh004_2 LIKE xmdh_t.xmdh004
#add--160706-00037#5 By shiun--(E)


   #設定左方的流程圖  
   CALL axmp540_set_step_img('2')

   #設定嵌入畫面的 顯示 與 隱藏 
   CALL axmp540_set_vbox_visible('2')
   
   #設定button隱藏
   CALL axmp540_set_act_visible('2')
   
   #畫面欄位顯示 與 隱藏      
   CALL cl_set_comp_visible("source",TRUE)              #來源單據 
   CALL cl_set_comp_visible("docno",FALSE)              #出貨單號
   CALL cl_set_comp_visible("result",FALSE)             #執行結果
   
   #add--160706-00037#5 By shiun--(S)
   CALL s_transaction_begin()

   CALL cl_err_collect_init()

   #抓訂單
   LET l_sql = "SELECT xmdh001,xmdhseq1,xmdhseq2,xmdhseq3 ",
               "  FROM p540_tmp01 ",
               " WHERE xmdhdocno IS NULL ",
               " ORDER BY xmdh001,xmdhseq1,xmdhseq2,xmdhseq3 "
   PREPARE p540_chk_lock_prep FROM l_sql
   DECLARE p540_chk_lock_curs CURSOR WITH HOLD FOR p540_chk_lock_prep

   LET l_sql = "SELECT xmdddocno,xmddseq,xmddseq1,xmddseq2 ",
               "  FROM xmdd_t ",
               " WHERE xmddent = ",g_enterprise,
               "   AND xmdddocno = ? ",
               "   AND xmddseq   = ? ",
               "   AND xmddseq1  = ? ",
               "   AND xmddseq2  = ? ",
               "   FOR UPDATE SKIP LOCKED "
   PREPARE p540_test_lock_prep FROM l_sql

   LET l_xmdh001  = ''
   LET l_xmdhseq1 = ''
   LET l_xmdhseq2 = ''
   LET l_xmdhseq3 = ''
   FOREACH p540_chk_lock_curs INTO l_xmdh001,l_xmdhseq1,l_xmdhseq2,l_xmdhseq3
      #add--160706-00037#13 By shiun--(S)
      LET l_docno = ''   
      LET l_seq   = ''
      LET l_seq1  = ''
      LET l_seq2  = ''
      #add--160706-00037#13 By shiun--(E)
      EXECUTE p540_test_lock_prep USING l_xmdh001,l_xmdhseq1,l_xmdhseq2,l_xmdhseq3
                                   INTO l_docno,l_seq,l_seq1,l_seq2
      IF cl_null(l_docno) OR cl_null(l_seq) OR cl_null(l_seq1) OR cl_null(l_seq2) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ''
         LET g_errparam.code   = 'apm-01120'
         LET g_errparam.popup  = TRUE
         LET g_errparam.replace[1] = l_xmdh001
         LET g_errparam.replace[2] = l_xmdhseq1
         LET g_errparam.replace[3] = l_xmdhseq2
         LET g_errparam.replace[4] = l_xmdhseq3
         CALL cl_err()

         DELETE FROM p540_01_xmdh
          WHERE xmdh001  = l_xmdh001
            AND xmdh002 = l_xmdhseq1
            AND xmdh003 = l_xmdhseq2
            AND xmdh004 = l_xmdhseq3

         DELETE FROM p540_01_xmdh2
          WHERE xmdh001  = l_xmdh001
            AND xmdh002 = l_xmdhseq1
            AND xmdh003 = l_xmdhseq2
            AND xmdh004 = l_xmdhseq3
            
         DELETE FROM p540_tmp01
          WHERE xmdh001  = l_xmdh001
            AND xmdhseq1 = l_xmdhseq1
            AND xmdhseq2 = l_xmdhseq2
            AND xmdhseq3 = l_xmdhseq3
      
         DELETE FROM p540_01_tmp
          WHERE docno = l_xmdh001
            AND seq = l_xmdhseq1
            AND xmdl005 = l_xmdhseq2
            AND xmdl006 = l_xmdhseq3
      END IF
      LET l_xmdh001  = ''
      LET l_xmdhseq1 = ''
      LET l_xmdhseq2 = ''
      LET l_xmdhseq3 = ''
   END FOREACH
   
   #抓出通單
   LET l_sql = "SELECT xmdhdocno,xmdhseq ",
               "  FROM p540_tmp01 ",
               " WHERE xmdhdocno IS NOT NULL ",
               " ORDER BY xmdhdocno,xmdhseq "
   PREPARE p540_chk_lock2_prep FROM l_sql
   DECLARE p540_chk_lock2_curs CURSOR WITH HOLD FOR p540_chk_lock2_prep

   LET l_sql = "SELECT xmdhdocno,xmdhseq,xmdh001,xmdh002,xmdh003,xmdh004 ",
               "  FROM xmdh_t ",
               " WHERE xmdhent = ",g_enterprise,
               "   AND xmdhdocno = ? ",
               "   AND xmdhseq   = ? ",
#               "   AND xmdh001  = ? ",   #160706-00037#5 mark
#               "   AND xmdh002  = ? ",   #160706-00037#5 mark
#               "   AND xmdh003  = ? ",   #160706-00037#5 mark
#               "   AND xmdh004  = ? ",   #160706-00037#5 mark
               "   FOR UPDATE SKIP LOCKED "
   PREPARE p540_test_lock2_prep FROM l_sql

   LET l_xmdhdocno = ''
   LET l_xmdhseq   = ''
   LET l_xmdh001  = ''
   LET l_xmdhseq1 = ''
   LET l_xmdhseq2 = ''
   LET l_xmdhseq3 = ''
   FOREACH p540_chk_lock2_curs INTO l_xmdhdocno,l_xmdhseq
      #add--160706-00037#13 By shiun--(S)
      LET l_docno = ''   
      LET l_seq   = ''
      LET l_xmdh001_2 = ''
      LET l_xmdh002_2 = ''
      LET l_xmdh003_2 = ''
      LET l_xmdh004_2 = ''
      #add--160706-00037#13 By shiun--(E)
#     EXECUTE p540_test_lock_prep USING l_xmdhdocno,l_xmdhseq,l_xmdh001,l_xmdhseq1,l_xmdhseq2,l_xmdhseq3
      EXECUTE p540_test_lock2_prep USING l_xmdhdocno,l_xmdhseq
                                   INTO l_docno,l_seq,l_xmdh001_2,l_xmdh002_2,l_xmdh003_2,l_xmdh004_2
      IF cl_null(l_docno) OR cl_null(l_seq) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ''
         LET g_errparam.code   = 'apm-01117'
         LET g_errparam.popup  = TRUE
         LET g_errparam.replace[1] = l_xmdhdocno
         LET g_errparam.replace[2] = l_xmdhseq
         CALL cl_err()

         DELETE FROM p540_01_xmdh
          WHERE xmdhdocno = l_xmdhdocno
            AND xmdhseq = l_xmdhseq
#            AND xmdh001 = l_xmdh001
#            AND xmdh002 = l_xmdhseq1
#            AND xmdh003 = l_xmdhseq2
#            AND xmdh004 = l_xmdhseq3

         DELETE FROM p540_01_xmdh2
          WHERE xmdhdocno = l_xmdhdocno
            AND xmdhseq = l_xmdhseq
#            AND xmdh001 = l_xmdh001
#            AND xmdh002 = l_xmdhseq1
#            AND xmdh003 = l_xmdhseq2
#            AND xmdh004 = l_xmdhseq3
            
         DELETE FROM p540_tmp01
          WHERE xmdhdocno = l_xmdhdocno
            AND xmdhseq = l_xmdhseq
#            AND xmdh001 = l_xmdh001
#            AND xmdh002 = l_xmdhseq1
#            AND xmdh003 = l_xmdhseq2
#            AND xmdh004 = l_xmdhseq3
      
         DELETE FROM p540_01_tmp
          WHERE docno = l_xmdhdocno
            AND seq = l_xmdhseq
         
      END IF
      LET l_xmdhdocno = ''
      LET l_xmdhseq = ''
      LET l_xmdh001  = ''
      LET l_xmdhseq1 = ''
      LET l_xmdhseq2 = ''
      LET l_xmdhseq3 = ''
   END FOREACH

   CALL cl_err_collect_show()

   CALL s_transaction_end('Y','0')
   #add--160706-00037#5 By shiun--(E)
    
   #160120-00002#4 20160217 by s983961--add(s)   
   #開啟transaction 
   CALL s_transaction_begin()
   
   #LET l_sql = "SELECT xmdhdocno,xmdhseq,xmdh001,xmdhseq1,xmdhseq2,xmdhseq3 ",
   #            "  FROM p540_01_lock_b_t ",
   #            " ORDER BY xmdhdocno,xmdhseq,xmdh001,xmdhseq1,xmdhseq2,xmdhseq3 "
   #PREPARE axmp540_02_lock_prep FROM l_sql
   #DECLARE axmp540_02_lock_curs CURSOR FOR axmp540_02_lock_prep
   #
   #LET l_where = ''
   #LET l_sql_cho = ''
   #FOREACH axmp540_02_lock_curs INTO l_xmdhdocno,l_xmdhseq,l_xmdh001,l_xmdhseq1,l_xmdhseq2,l_xmdhseq3
   #   IF cl_null(l_xmdhdocno) THEN
   #     #訂單        
   #     IF cl_null(l_where) THEN
   #        LET l_where = "(xmdddocno = '",l_xmdh001,"' AND xmddseq = '",l_xmdhseq1,"' AND xmddseq1 = '",l_xmdhseq2,"' AND xmddseq2 = '",l_xmdhseq3,"'  AND xmddent = '",g_enterprise,"')"
   #     ELSE
   #        LET l_where = l_where," OR ","(xmdddocno = '",l_xmdh001,"' AND xmddseq = '",l_xmdhseq1,"' AND xmddseq1 = '",l_xmdhseq2,"' AND xmddseq2 = '",l_xmdhseq3,"' AND xmddent = '",g_enterprise,"')"
   #     END IF
   #   ELSE 
   #     #出通單
   #     LET l_sql_cho = TRUE
   #     IF cl_null(l_where) THEN
   #        LET l_where = "(xmdhdocno = '",l_xmdhdocno,"' AND xmdhseq = '",l_xmdhseq,"' AND xmdh001 = '",l_xmdh001,"' AND xmdh002 = '",l_xmdhseq1,"' AND xmdh003 = '",l_xmdhseq2,"' AND xmdh004 = '",l_xmdhseq3,"'  AND xmdhent = '",g_enterprise,"')"
   #     ELSE
   #        LET l_where = l_where," OR ","(xmdhdocno = '",l_xmdhdocno,"' AND xmdhseq = '",l_xmdhseq,"' AND xmdh001 = '",l_xmdh001,"' AND xmdh002 = '",l_xmdhseq1,"' AND xmdh003 = '",l_xmdhseq2,"' AND xmdh004 = '",l_xmdhseq3,"'  AND xmdhent = '",g_enterprise,"')"
   #     END IF
   #   END IF  
   #END FOREACH
   #
   #IF l_sql_cho THEN 
   #  #出通單
   #  LET l_sql = "SELECT xmdhdocno,xmdhseq,xmdh001,xmdh002,xmdh003,xmdh004 ",
   #              "  FROM xmdh_t ",
   #              " WHERE "         
   #ELSE
   #  #訂單
   #  LET l_sql = "SELECT xmdddocno,xmddseq,xmddseq1,xmddseq2 ",
   #              "  FROM xmdd_t ",
   #              " WHERE "   
   #END IF
   #
   #LET l_sql = l_sql,l_where," FOR UPDATE " 
   #PREPARE axmp540_02_lock_body_prep FROM l_sql
   #DECLARE axmp540_02_lock_body_curs CURSOR FOR axmp540_02_lock_body_prep
   #OPEN axmp540_02_lock_body_curs

   #訂單
   LET l_sql = "SELECT xmdh001,xmdhseq1,xmdhseq2,xmdhseq3 ",
               "  FROM p540_tmp01 ",                 #160727-00019#23 Mod   p540_01_lock_b_t --> p540_tmp01
               " WHERE xmdhdocno IS NULL ",
               " ORDER BY xmdh001,xmdhseq1,xmdhseq2,xmdhseq3 "
   PREPARE axmp540_02_lock_prep FROM l_sql
   DECLARE axmp540_02_lock_curs CURSOR FOR axmp540_02_lock_prep

   LET l_where = ''
   FOREACH axmp540_02_lock_curs INTO l_xmdh001,l_xmdhseq1,l_xmdhseq2,l_xmdhseq3     
      IF cl_null(l_where) THEN
         LET l_where = "(xmdddocno = '",l_xmdh001,"' AND xmddseq = '",l_xmdhseq1,"' AND xmddseq1 = '",l_xmdhseq2,"' AND xmddseq2 = '",l_xmdhseq3,"')"
      ELSE
         LET l_where = l_where," OR ","(xmdddocno = '",l_xmdh001,"' AND xmddseq = '",l_xmdhseq1,"' AND xmddseq1 = '",l_xmdhseq2,"' AND xmddseq2 = '",l_xmdhseq3,"')"
      END IF         
   END FOREACH   
   #add--160706-00037#13 By shiun--(S)
   IF cl_null(l_where) THEN
      LET l_where  = " 1=2 "
   END IF
   LET l_where = l_where," )"
   #add--160706-00037#13 By shiun--(E)   

   LET l_sql = "SELECT xmdddocno,xmddseq,xmddseq1,xmddseq2 ",
               "  FROM xmdd_t ",
#              " WHERE "                                  #160706-00037#13 mark
               " WHERE xmddent = ",g_enterprise," AND ("  #160706-00037#13 mod

   LET l_sql = l_sql,l_where," FOR UPDATE "
   PREPARE axmp540_02_lock_body_prep FROM l_sql 
   DECLARE axmp540_02_lock_body_curs CURSOR FOR axmp540_02_lock_body_prep
   OPEN axmp540_02_lock_body_curs
   
   #出通單
   LET l_sql = ''
   LET l_sql = "SELECT xmdhdocno,xmdhseq,xmdh001,xmdhseq1,xmdhseq2,xmdhseq3 ",
               "  FROM p540_tmp01 ",          #160727-00019#23 Mod   p540_01_lock_b_t --> p540_tmp01
               " WHERE xmdhdocno IS NOT NULL ",
               " ORDER BY xmdhdocno,xmdhseq,xmdh001,xmdhseq1,xmdhseq2,xmdhseq3 "
   PREPARE axmp540_02_lock2_prep FROM l_sql
   DECLARE axmp540_02_lock2_curs CURSOR FOR axmp540_02_lock2_prep
   
   LET l_sql = "SELECT xmdhdocno,xmdhseq,xmdh001,xmdh002,xmdh003,xmdh004 ",
               "  FROM xmdh_t ",
#              " WHERE "                                  #160706-00037#13 mark
               " WHERE xmdhent = ",g_enterprise," AND ("  #160706-00037#13 mod      
                 
   LET l_where = ''
   LET l_xmdh001 = ''
   LET l_xmdhseq1 = ''
   LET l_xmdhseq2 = ''
   LET l_xmdhseq3 = ''
   FOREACH axmp540_02_lock2_curs INTO l_xmdhdocno,l_xmdhseq,l_xmdh001,l_xmdhseq1,l_xmdhseq2,l_xmdhseq3     
      IF cl_null(l_where) THEN
         LET l_where = "(xmdhdocno = '",l_xmdhdocno,"' AND xmdhseq = '",l_xmdhseq,"' AND xmdh001 = '",l_xmdh001,"' AND xmdh002 = '",l_xmdhseq1,"' AND xmdh003 = '",l_xmdhseq2,"' AND xmdh004 = '",l_xmdhseq3,"')"
      ELSE
         LET l_where = l_where," OR ","(xmdhdocno = '",l_xmdhdocno,"' AND xmdhseq = '",l_xmdhseq,"' AND xmdh001 = '",l_xmdh001,"' AND xmdh002 = '",l_xmdhseq1,"' AND xmdh003 = '",l_xmdhseq2,"' AND xmdh004 = '",l_xmdhseq3,"')"
      END IF 
   END FOREACH   
   #add--160706-00037#13 By shiun--(S)
   IF cl_null(l_where) THEN
      LET l_where  = " 1=2 "
   END IF
   LET l_where = l_where," )"
   #add--160706-00037#13 By shiun--(E)
   LET l_sql = l_sql,l_where," FOR UPDATE "
   PREPARE axmp540_02_lock2_body_prep FROM l_sql 
   DECLARE axmp540_02_lock2_body_curs CURSOR FOR axmp540_02_lock2_body_prep
   OPEN axmp540_02_lock2_body_curs     
   #160120-00002#4 20160217 by s983961--add(e)
   
   LET g_action_choice = NULL

   #141020 stellar add ----------------------(S)
      
   #匯總資料時，錯誤訊息先匯總後再顯示
   CALL cl_err_collect_init()
   #141020 stellar add ----------------------(E)
   
   CALL axmp540_02()
   CALL axmp540_02_b_fill()
   CALL axmp540_02_fetch()
   
   #141020 stellar add ----------------------(S)
   #匯總資料時，錯誤訊息先匯總後再顯示
   CALL cl_err_collect_show()
   #141020 stellar add ----------------------(E)
   
   WHILE TRUE
     DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
        SUBDIALOG axm_axmp540_02.axmp540_02_input05
        SUBDIALOG axm_axmp540_02.axmp540_02_display01
        #SUBDIALOG axm_axmp540_02.axmp540_02_input    #151118-00029#5 20160226 s983961--mark
        SUBDIALOG axm_axmp540_02.axmp540_02_display02 #151118-00029#5 20160226 s983961--add
        SUBDIALOG axm_axmp540_02.axmp540_02_display03
        SUBDIALOG axm_axmp540_02.axmp540_02_display04
        
        BEFORE DIALOG
            NEXT FIELD xmdlseq_02
                  
        ON ACTION axmp540_02_modify_detail                         #點擊待出貨明細頁籤，進入INPUT段
           LET g_action_choice = "axmp540_02_modify_detail"
           #CALL axmp540_01_data01_check()
           CALL axmp540_02_b()  #151118-00029#5 20160226 s983961--add


        ON ACTION CLOSE
           LET INT_FLAG = TRUE
           LET g_action_choice = "CLOSE"
           EXIT DIALOG

        ON ACTION EXIT
           LET INT_FLAG = TRUE
           LET g_action_choice = "EXIT"
           EXIT DIALOG

        ON ACTION back_step                    #抓取出貨資料(回到上一步)
           LET g_action_choice = "back_step"
           LET INT_FLAG = TRUE
           EXIT DIALOG
            
        ON ACTION over                         #完成
           #2014/10/24 by stellar add ------------------- (S)
           #檢查資料是否都有輸入
           CALL axmp540_02_check_field() RETURNING l_success
           IF NOT l_success THEN
              NEXT FIELD CURRENT
           END IF
           #2014/10/24 by stellar add ------------------- (E)
           LET g_action_choice = "over"
           EXIT DIALOG

        ON ACTION main_img_step02
           #此action是為了讓button的圖片有顏色 
           LET g_action_choice = "img_step02"
           EXIT DIALOG
           
        #主選單用ACTION
        &include "main_menu.4gl"
        &include "relating_action.4gl"
        #交談指令共用ACTION
        &include "common_action.4gl"
            CONTINUE DIALOG
     END DIALOG

     IF INT_FLAG THEN
        LET INT_FLAG = FALSE
        EXIT WHILE
     END IF
     
     IF g_action_choice = 'over' THEN
        EXIT WHILE
     END IF
   END WHILE
   
   #160120-00002#4 20160217 by s983961--add(S)
   CALL s_transaction_end('Y','0')
   #160120-00002#4 20160217 by s983961--add(e)
   
   CASE g_action_choice
      WHEN "back_step"
         RETURN 1
      WHEN "over"
         RETURN 3
      WHEN "menu"
         RETURN 0
      OTHERWISE
         RETURN 0
   END CASE   
END FUNCTION

PRIVATE FUNCTION axmp540_ui_dialog_step3()

   #設定左方的流程圖  
   CALL axmp540_set_step_img('3')

   #設定嵌入畫面的 顯示 與 隱藏 
   CALL axmp540_set_vbox_visible('3')
   
   #設定button隱藏
   CALL axmp540_set_act_visible('3')
   
   #畫面欄位顯示 與 隱藏 
   CALL cl_set_comp_visible("docno",TRUE)              #出貨單號
   CALL cl_set_comp_visible("result",TRUE)             #執行結果    
   CALL cl_set_comp_visible("source",FALSE)            #來源單據 
  
   #160120-00002#4 20160216 by s983961--add(s)   
   #開啟transaction 
   CALL s_transaction_begin()
   #160120-00002#4 20160216 by s983961--add(e)

   LET g_action_choice = NULL
   #CALL axmp540_02_ins_xmdk(g_xmdk_m.xmdkdocno,g_xmdk_m.xmdk003)
   CALL axmp540_02_ins_xmdk()
   CALL axmp540_02_b_fill()
   CALL axmp540_02_fetch()

   WHILE TRUE
     DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
        SUBDIALOG axm_axmp540_02.axmp540_02_display01
        SUBDIALOG axm_axmp540_02.axmp540_02_display02
        SUBDIALOG axm_axmp540_02.axmp540_02_display03
        SUBDIALOG axm_axmp540_02.axmp540_02_display04        

         ON ACTION CLOSE
            LET INT_FLAG = TRUE
            LET g_action_choice = "CLOSE"
            EXIT DIALOG

         ON ACTION EXIT
            LET INT_FLAG = TRUE
            LET g_action_choice = "EXIT"
            EXIT DIALOG

         ON ACTION back_first                    #回待出貨資料(回到主畫面重新開始操作)
            #清空tmptable
            DELETE FROM p540_01_tmp              #出貨底稿
            DELETE FROM p540_tmp02               #出貨單頭      #160727-00019#23 Mod   p540_02_xmdk_temp --> p540_tmp02
            DELETE FROM p540_tmp03               #出貨單身      #160727-00019#23 Mod   p540_02_xmdl_temp --> p540_tmp03
            CALL axmp540_01(g_wc)
            LET g_action_choice = "back_first"
            LET INT_FLAG = TRUE
            EXIT DIALOG
            
         ON ACTION open_axmt540                    #出貨單維護
            CALL axmp540_02_open_axmt540()
            EXIT DIALOG            
            
         ON ACTION main_img_step03
            #此action是為了讓button的圖片有顏色 
            LET g_action_choice = "img_step03"
            EXIT DIALOG
           
         #主選單用ACTION
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG

       END DIALOG

       IF INT_FLAG THEN
          LET INT_FLAG = FALSE
          EXIT WHILE
      END IF
    END WHILE

   #160120-00002#4 s983961--add(s)   
   CALL s_transaction_end('Y','0')
   #160120-00002#4 s983961--add(e) 

   CASE g_action_choice
      WHEN "back_first"         
         RETURN 1
      WHEN "menu"
         RETURN 0
      OTHERWISE
         RETURN 0
   END CASE   

END FUNCTION
################################################################################
# Descriptions...: 設定左方流程圖片
# Memo...........:
# Usage..........: CALL axmp540_set_step_img(p_step)
# Input parameter: p_step：第幾步驟的圖
# Date & Author..: 2014/06/20 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp540_set_step_img(p_step)
   DEFINE p_step     LIKE type_t.num5

   CALL gfrm_curr.setElementImage("step01","32/step01.png")
   CALL gfrm_curr.setElementImage("step02","32/step02.png")
   CALL gfrm_curr.setElementImage("step03","32/step03.png")
   
   #文字顏色設定 
   CALL gfrm_curr.setElementStyle("step01","menuitem")
   CALL gfrm_curr.setElementStyle("step02","menuitem")
   CALL gfrm_curr.setElementStyle("step03","menuitem")
   CALL gfrm_curr.setElementStyle("step04","menuitem")

   CASE p_step
      WHEN 1
         CALL gfrm_curr.setElementImage("step01","32/step01on.png")   #有on的是顏色不同的圖
         CALL gfrm_curr.setElementStyle("step01","menuitemfocus")
      WHEN 2
         CALL gfrm_curr.setElementImage("step02","32/step02on.png")   #有on的是顏色不同的圖
         CALL gfrm_curr.setElementStyle("step02","menuitemfocus")
      WHEN 3
         CALL gfrm_curr.setElementImage("step03","32/step03on.png")   #有on的是顏色不同的圖
         CALL gfrm_curr.setElementStyle("step03","menuitemfocus")
   END CASE
END FUNCTION
################################################################################
# Descriptions...: 設定每一步的畫面顯示與隱藏
# Memo...........:
# Usage..........: CALL axmp540_set_vbox_visible(p_step)
# Input parameter: p_step：步驟
# Date & Author..: 2014/06/20 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp540_set_vbox_visible(p_step)
   DEFINE p_step     LIKE type_t.num5

   #設定嵌入畫面的 顯示 與 隱藏 
   CALL cl_set_comp_visible("main_vbox01",FALSE)
   CALL cl_set_comp_visible("main_vbox02",FALSE)

   
      CASE p_step
      WHEN 1
         CALL cl_set_comp_visible("main_vbox01",TRUE)
      WHEN 2
         CALL cl_set_comp_visible("main_vbox02",TRUE)
      WHEN 3
         CALL cl_set_comp_visible("main_vbox02",TRUE)
          
   END CASE
   
END FUNCTION
################################################################################
# Descriptions...: 設定各步驟的action顯示
# Memo...........:
# Usage..........: CALL axmp540_set_act_visible(p_step)
# Input parameter: p_step：步驟
# Date & Author..: 2014/06/20 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp540_set_act_visible(p_step)
   DEFINE p_step     LIKE type_t.num5

   CALL cl_set_comp_visible("all_c_sel",FALSE)           #客戶全選
   CALL cl_set_comp_visible("all_o_sel",FALSE)           #訂單全選
   CALL cl_set_comp_visible("all_un_sel",FALSE)          #取消全選
   CALL cl_set_comp_visible("see_tmp",FALSE)             #檢示底稿
   CALL cl_set_comp_visible("sel_mode",FALSE)            #出貨資料 
   CALL cl_set_comp_visible("del_tmp",FALSE)             #刪除底稿
   
   CALL cl_set_comp_visible("next_step",FALSE)           #出貨調整 
   CALL cl_set_comp_visible("save",FALSE)                #出貨資料寫入 
     
   CALL cl_set_comp_visible("back_step",FALSE)           #抓取出貨資料   
   CALL cl_set_comp_visible("over",FALSE)                #完成  
   
   CALL cl_set_comp_visible("back_first",FALSE)          #回待出貨資料
   CALL cl_set_comp_visible("open_axmt540",FALSE)        #出貨單維護
   
   CASE p_step
      WHEN 1
         CALL cl_set_comp_visible("next_step",TRUE)           #出貨調整          
      WHEN 2
         CALL cl_set_comp_visible("back_step",TRUE)           #抓取出貨資料、完成 
         CALL cl_set_comp_visible("over",TRUE)                #完成
      WHEN 3
         CALL cl_set_comp_visible("back_first",TRUE)          #回待出貨資料 
         CALL cl_set_comp_visible("open_axmt540",TRUE)        #出貨單維護

   END CASE   


END FUNCTION

#end add-point
 
{</section>}
 
